<%@ page language="java" import="java.util.*,com.fiberhome.bcs.appprocess.common.util.*"
 contentType="application/uixml+xml; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/client/adapt.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.nj.fiberhome.com.cn/exmobi.dtd">
<%
String base = "http://oa/app/template/jsp/";
String uploadUrl = aa.getReqParameterValue("uploadUrl");
String formUrl = aa.getReqParameterValue("formUrl");

//先判断是否有附件，如果有附件则先进行附件提交，并将获取到的文件名和id保存到变量中
//如果没有上传附件，则文件名为空串，否则就会有文件名，长度大于0
if(aa.getReqAttachName("upload").length()>0){
%>
<aa:http id="uploadFile" url="<%=base+uploadUrl %>"/>
<%
}
/*
如果有附件提交，则会返回fileName和fileId，下面的赋值就相当于模拟抓包到的响应内容
<script>
parent.document.getElementById("fileName").value = "培训课程.txt";
parent.document.getElementById("fileId").value = "e1fe1a7f-d5c3-44e3-b4c3-35b0e8f245a9";
</script>
*/
String fileName = aa.regex("fileName\"\\).value = \"([^\"]*)\"", "uploadFile");
String fileId = aa.regex("fileId\"\\).value = \"([^\"]*)\"", "uploadFile");
%>
<%-- 一个JSP中多次使用aa:http如果不设置参数，则从客户端过来的请求体都会被提交，也就是说一个JSP中多个默认aa:http的请求都是一样的，url、method、参数等都完全一样
可以通过设置keepreqdata="false"相当于把aa:http请求清零，所以参数全部重新设置，组成一个全新的请求 ---%>
<aa:http id="sendInfo" keepreqdata="false" url="<%=base+formUrl %>" method="post">
<%
//获得原先提交的参数
Map<String, Object> map = aa.getReqParameters();
//原先在页面中提交的fileName和fileId是hidden的隐藏域，没有赋值，这里是将前面提交附件获取到的文件名和id赋值给输入框对应的参数
map.put("fileName", fileName);
map.put("fileId", fileId);
//去掉辅助/不必要的参数（有时候不去掉问题也不大）
map.remove("upload");
map.remove("formUrl");
map.remove("uploadUrl");
//重新拼接提交的参数
for(String s : map.keySet()){
%>
<aa:param name="<%=s %>" value='<%=map.get(s).toString() %>' />
<%		
}
%>
</aa:http>
<html type="alert">
<body>
	<alert title="提示" icontype="alarm">
		<msg>
		<aa:choose>
			<aa:when testxpath="//script[contains(. , '成功')]" dsId="sendInfo">
				发送成功！
			</aa:when>
			<aa:otherwise>
				发送失败！
			</aa:otherwise>
		</aa:choose>
		</msg>
	</alert>
</body>
</html>
