<%@ page language="java" import="java.util.*,com.fiberhome.bcs.appprocess.common.util.*"
 contentType="application/uixml+xml; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/client/adapt.jsp"%>

<aa:http id="login"></aa:http>

<!DOCTYPE html SYSTEM "http://www.nj.fiberhome.com.cn/exmobi.dtd">
<html>
<head>
<meta charset="UTF-8"/>
<title>登陆——get请求</title>
</head>
<body>
<%-- action为http://domain/app/template/checkLogin.jsp --%>
<form action="http://domain/app/template/<%=aa.regexFilter("url:'([^']*)',", aa.xpath("//script[not(@src)]", "login"))%>" method="post" target="_self">
<%-- 包含有input的table就是登陆需要信息，对该表格td下的所有节点做循环读取 --%>
<aa:for-each dsId="login" var="node" xpath="//table[./tr/td/input]//td/node()[not(name()='br' or name()='a' or @type='button')]">
	<aa:if testxpath="name()=''" dsId="node">
		<font color="#ff0000" style="width:30%;"><aa:value-of xpath="." dsId="node"/></font>
	</aa:if>
	<aa:if testxpath="name()='input'" dsId="node">
		<input type="<%=aa.xpath("@type", "node")%>" id="<%=aa.xpath("@id", "node")%>" name="<%=aa.xpath("@name", "node")%>" style="width:70%;"></input>
	</aa:if>
</aa:for-each>
<input type="submit" value="登陆" style="width:100%"/>
</form>
</body>
</html>
