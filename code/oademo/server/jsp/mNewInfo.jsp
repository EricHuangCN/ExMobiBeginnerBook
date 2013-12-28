<%@ page language="java" import="java.util.*,com.fiberhome.bcs.appprocess.common.util.*"
 contentType="application/uixml+xml; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/client/adapt.jsp"%>

<aa:http id="newInfo"/>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.nj.fiberhome.com.cn/exmobi.dtd">
<html>
<head>
<meta charset="UTF-8"/>
<title show="false">合并请求</title>
<script>
<![CDATA[
	function doSubmit(){
		if(document.getElementById("title").value==""){
			alert("标题不能为空！");
			return;
		}else if(document.getElementById("to").value==""){
			alert("接收人不能为空！");
			return;
		}

		document.getElementById("form").submit();
	}
]]>
</script>
</head>
<header>
<titlebar caption="返回" title="信息发送" rcaption="发送" riconhref="doSubmit()" iconhref="script:close"/>
</header>
<body>
<%-- form的action属性写了一个虚拟地址，这个地址是不存在的，只是为了给mapp路由做一个唯一URL进到指定的JSP中处理 --%>
<form id="form" action="http://oa/app/allInOne.jsp" method="post" target="_blank" enctype="multipart/form-data">
<%-- 包含有input的table就是登陆需要信息，对该表格tr做循环读取 --%>
<aa:for-each dsId="newInfo" var="node" xpath="//fieldset//td/node()[name()!='span' and not(@onclick)]">
	<aa:choose>
		<%-- 普通文字照常输出，但是如果全部是空格则不输出 --%>
		<aa:when testxpath="name()='' and string-length(normalize-space(.))>0" dsId="node">
			<font color="#ff0000" style="width:30%;"><aa:value-of xpath="." dsId="node"/><aa:value-of xpath="" dsId="node"/></font>
		</aa:when>
		<%-- 普通textarea照常输出 --%>
		<aa:when testxpath="name()='textarea'" dsId="node">
			<textarea name="<%=aa.xpath("./@name", "node")%>" id="<%=aa.xpath("./@id", "node")%>" style="width:70%;"></textarea>
		</aa:when>
		<%-- 普通hidden照常输出，但是不设置宽度 --%>
		<aa:when testxpath="@type='hidden'" dsId="node">
			<input type="<%=aa.xpath("@type", "node")%>" id="<%=aa.xpath("@id", "node")%>" name="<%=aa.xpath("@name", "node")%>"></input>
		</aa:when>
		<%-- 普通input照常输出 --%>
		<aa:when testxpath="name()='input'" dsId="node">
			<input type="<%=aa.xpath("@type", "node")%>" id="<%=aa.xpath("@id", "node")%>" name="<%=aa.xpath("@name", "node")%>" style="width:70%;"></input>
		</aa:when>
	</aa:choose>
</aa:for-each>
<%-- 把两个表单的提交地址作为隐藏域提交，可以在JSP中获取分别进行请求 --%>
<input type="hidden" name="formUrl" value="<%=aa.xpath("//form[@id='form']/@action", "newInfo")%>"/>
<input type="hidden" name="uploadUrl" value="<%=aa.xpath("//form[@id='uploadFile']/@action", "newInfo")%>"/>
</form>
</body>
</html>