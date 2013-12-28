<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" contentType="application/uixml+xml; charset=UTF-8"%>
<%@ include file="/client/adapt.jsp"%>
<%
String id = aa.getReqParameterValueFromUrl("id");
String sql = "delete from tbl_task where id='"+id+"'";
%>
<aa:sql-excute id="update" dbId="postgresql" sql="<%=sql %>"/>
<html type="alert">
<body>
	<alert title="提示" icontype="alarm">
		<msg><%=aa.xpath("//result", "update").equals("1")?"删除成功！":"删除失败！"%></msg>
		<nextaction>script:close</nextaction>
	</alert>
</body>
</html>