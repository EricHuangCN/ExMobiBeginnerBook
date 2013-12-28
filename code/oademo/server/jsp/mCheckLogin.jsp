<%@ page language="java" import="java.util.*,com.fiberhome.bcs.appprocess.common.util.*"
 contentType="application/uixml+xml; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/client/adapt.jsp"%>


<aa:http id="checkLogin"/>

<%/*
登陆成功的响应结果为：
{"status":"success"} 
登陆失败的响应结果不含success
所以可以根据响应结果是否包含succes来判断是否登陆成功
*/%>

<%
//登陆成功分支——登陆成功则显示菜单页面
if(aa.regex(".*", "checkLogin").indexOf("success")>-1){
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.nj.fiberhome.com.cn/exmobi.dtd">
<html>
<head>
<meta charset="UTF-8"/>
<title>校验:post带键值对</title>
</head>
<body>
<listitem type="twoline" href="http://oa/app/template/jsp/addTask.jsp" caption="创建任务 " sndcaption="post带附件的请求实例"/>
<listitem type="twoline" href="document.getElementById('form').submit()" caption="任务信息查看[xml格式]" sndcaption="post请求体为XML实例，通过form提交"/>
<listitem type="twoline" href="http://oa/app/template/jsp/newInfo.jsp" caption="发送信息" sndcaption="合并请求实例，一个JSP发起两次aa:http请求"/>
<form id="form" action="http://oa/app/template/action/taskManagerAction.jsp?handler=list&amp;dataType=xml&amp;timeStamp=1340797760522" method="post">
	<input type="hidden" name="page" value="1"/>
	<input type="hidden" name="rows" value="5"/>
</form>
</body>
</html>
<%
}else{//登陆失败分支，登陆失败则进行提示
%>
<html type="alert">
<body>
	<alert title="提示" icontype="alarm">
		<msg>登陆信息错误，请重新输入！</msg>
	</alert>
</body>
</html>
<%
}
%>