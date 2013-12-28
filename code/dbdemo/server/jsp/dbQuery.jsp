<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" contentType="application/uixml+xml; charset=UTF-8"%>
<%@ include file="/client/adapt.jsp"%>

<%
String title = aa.getReqParameterValue("title");
%>

<aa:sql-excute id="selectAll" dbId="postgresql" sql="select * from tbl_task where title like ?">
	<aa:sql-param type="String" value='<%="%"+title+"%"%>'/>
</aa:sql-excute>
<!DOCTYPE html SYSTEM "http://www.nj.fiberhome.com.cn/exmobi.dtd">
<html>
<head>
<meta charset="UTF-8"/>
<title>数据库-select</title>
</head>
<body id="content">
<aa:for-each var="list" dsId="selectAll" xpath="//datarow">
	<listitem type="twoline" href="http://sql/show.jsp?id=<%=aa.xpath("./datacol[@name='id']", "list")%>" caption="<%=aa.xpath("./datacol[@name='title']", "list")+"|"+aa.xpath("./datacol[@name='executor']", "list") %>" sndcaption="<%=aa.xpath("./datacol[@name='end_time']", "list") %>"/>
</aa:for-each>

</body>
<footer>
	<input type="button" onclick="res:page/add.xhtml" value="新增" style="width:50%"/>
	<input type="button" onclick="http://sql/query.jsp?title=<%=title%>" target="_self" value="刷新" style="width:50%"/>
</footer>
</html>
