<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" contentType="application/uixml+xml; charset=UTF-8"%>
<%@ include file="/client/adapt.jsp"%>
<%
String id = aa.getReqParameterValue("id");
//获取所有参数MAP映射
Map<String, Object> pmap = aa.getReqParameters();
//插入的列
String set = "id";
//插入的列对应的值,唯一标示id通过UUID自动生成
String values = "'"+UUID.randomUUID().toString()+"'";
if (null != pmap){
	//遍历所有参数，并拼接成SQL片段
	for (String s : pmap.keySet()){
		values += ",'"+pmap.get(s)+"' ";
		set += ","+s;
	}
}
String sql = "insert into tbl_task ("+set+") values ("+values+")";
%>
<aa:sql-excute id="update" dbId="postgresql" sql="<%=sql %>"/>
<html type="alert">
<body>
	<alert title="提示" icontype="alarm">
		<msg><%=aa.xpath("//result", "update").equals("1")?"新增成功！":"新增失败！"%></msg>
		<nextaction>script:close</nextaction>
	</alert>
</body>
</html>
