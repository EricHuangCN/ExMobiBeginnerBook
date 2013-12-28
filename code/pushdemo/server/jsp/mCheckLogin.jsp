<%@ page language="java" import="java.util.*,com.fiberhome.bcs.appprocess.common.util.*"
 contentType="application/uixml+xml; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/client/adapt.jsp"%>

<%-- 发起默认请求即可，因为基本信息已经在form中组好 --%>
<aa:http id="checkLogin"/>

<%
//直接通过正则获取全部内容（请思考为什么不用xpath？）,.*代表全部内容
String result = aa.regex(".*", "checkLogin");
%>
<%-- 判断是否为登陆成功 --%>
<aa:if test='<%=result.indexOf("success")>-1 %>'>

<%
//username是在请求正文中以键值对方式存在，所以使用getReqParameterValue获取
String username = aa.getReqParameterValue("username");
//esn和clientid存在于头信息中，所以使用getReqHeaderValue获取
String esn = aa.getReqHeaderValue("esn");
String clientid = aa.getReqHeaderValue("clientid");

//组成sql语句
String sql = "insert into tsbbm_user (username, esn, clientid) values ('"+username+"', '"+esn+"', '"+clientid+"')";
%>
<%-- 执行sql --%>
<aa:sql-excute dbId="postgresql" sql="<%=sql %>"></aa:sql-excute>


</aa:if>


<%-- 把响应内容回给客户端 --%>
<%=result%>