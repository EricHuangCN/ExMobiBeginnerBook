<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" contentType="application/uixml+xml; charset=UTF-8"%>
<%@ include file="/client/adapt.jsp"%>
<%
String id = aa.getReqParameterValue("id");
//获取所有参数MAP映射
Map<String, Object> pmap = aa.getReqParameters();
//修改的键值对
String set = "";
if (null != pmap){
	for (String s : pmap.keySet()){
		//将不为id的参数拼接起来
		if(!id.equals(pmap.get(s)))
		set += ","+s+"='"+pmap.get(s)+"' ";
	}
}
String sql = "update tbl_task set "+set.replaceFirst(",", "")+" where id='"+id+"'";
%>
<aa:sql-excute id="update" dbId="postgresql" sql="<%=sql %>"/>
<html type="alert">
<body>
	<alert title="提示" icontype="alarm">
		<msg><%=aa.xpath("//result", "update").equals("1")?"修改成功！":"修改失败！"%></msg>
		<nextaction>script:close</nextaction>
	</alert>
</body>
</html>
