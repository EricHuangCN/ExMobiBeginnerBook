<%@ page language="java" import="java.util.*,com.fiberhome.bcs.appprocess.common.util.*"
 contentType="application/uixml+xml; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/client/adapt.jsp"%>

<%-- 发起默认请求即可，因为基本信息已经在form中组好 --%>
<aa:http id="checkLogin"/>

<%-- 直接通过正则获取全部内容（请思考为什么不用xpath？）,.*代表全部内容 --%>
<%=aa.regex(".*", "checkLogin")%>