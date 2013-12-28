<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" contentType="application/uixml+xml; charset=UTF-8"%>
<%@ include file="/client/adapt.jsp"%>
<%
String id = aa.getReqParameterValueFromUrl("id");
String sql = "select * from tbl_task where id='"+id+"'";
%>
<aa:sql-excute id="selectOne" dbId="postgresql" sql="<%=sql %>"/>
<!DOCTYPE html SYSTEM "http://www.nj.fiberhome.com.cn/exmobi.dtd">
<html>
<head>
<meta charset="UTF-8"/>
<title>数据库-select</title>
</head>
<body id="content">
	<form id="form" action="http://sql/update.jsp" method="post" target="_self">
		<input type="hidden" name="id" value="<%=id %>"/>
		标题：
		<br/>
		<input type="text" name="title" value="<%=aa.xpath("//datacol[@name='title']", "selectOne") %>"/>
		<br/>
		开始时间：<br/>
		<object type="date" name="begin_time" value="<%=aa.xpath("//datacol[@name='begin_time']", "selectOne") %>" style="width:100%"/>
		<br/>
		结束时间：<br/>
		<object type="date" name="end_time" value="<%=aa.xpath("//datacol[@name='end_time']", "selectOne") %>" style="width:100%"/>
		<br/>
		任务执行人：
		<br/>
		<input type="text" name="executor" value="<%=aa.xpath("//datacol[@name='executor']", "selectOne") %>"/>
		<br/>
		优先级：
		<br/>
		<input type="text" name="priority_level" value="<%=aa.xpath("//datacol[@name='priority_level']", "selectOne") %>"/>
		<br/>
		任务说明：
		<br/>
		<input type="text" name="remark" value="<%=aa.xpath("//datacol[@name='remark']", "selectOne") %>"/>
		<br/>
	</form>
</body>
<footer>
	<input type="button" onclick="document.getElementById('form').submit()" value="修改" style="width:50%"/>
	<input type="button" onclick="http://sql/delete.jsp?id=<%=id%>" target="_self" value="删除" style="width:50%"/>
</footer>
</html>
