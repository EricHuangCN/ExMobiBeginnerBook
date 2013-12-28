<%@ page language="java" import="java.util.*,com.fiberhome.bcs.appprocess.common.util.*"
 contentType="application/uixml+xml; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/client/adapt.jsp"%>

<%
//推送接口传递的键值对参数不管是在url中还是在请求正文中买都是通过getReqParameterValue获取
String username = aa.getReqParameterValue("username");//获取用户名
String title = aa.getReqParameterValue("title");//获取title参数

%>
<%-- 如果用户名不为空则执行sql查询相关信息，并对信息格式化 --%>
<aa:if test="<%=username.length()>0 %>">

	<%
	//组成sql语句
	String sql = "select * from tsbbm_user where username='"+username+"'";
	%>

	<%-- 执行sql查询 --%>
	<aa:sql-excute id="select" dbId="postgresql" sql="<%=sql %>"></aa:sql-excute>
	<%-- 使用直推方式格式化数据，是一种固定格式 --%>
	<%-- directPushType:app,本应用的直推消息，收到后打开page/task.html页面 --%>
	<%-- immediately：是否后续操作立刻执行，1标示该消息的后续操作立刻执行，0标示用户点击后执行page：用户点击后打开的本地页面。此参数PC、android有效 --%>
	<%-- page:directPushType=app时有效,用户点击后打开的本地页面task.xhtml，在该页面中可以获取<aa:push-param>设置的参数 --%>
	<aa:direct-push directPushType="app" title="<%=title %>" titleHead="ExMobi消息" page="page/task.xhtml">
		<%-- 设置接收人 --%>
		<%-- 根据查询到的信息组成格式化的消息，使用for循环是考虑用户可能在多个设备登陆，具体视实际场景而定，也可以给其中一个推 --%>
		<aa:for-each var="list" xpath="//datarow" dsId="select">
			<%
			//获取esn和clientid
			String esn = aa.xpath("./datacol[@name='esn']", "list");
			String clientid = aa.xpath("./datacol[@name='clientid']", "list");
			%>
			
			<aa:push-receiver esn="<%=esn %>" clientid="<%=clientid %>"></aa:push-receiver>
			
		</aa:for-each>
			
		<%-- 指定直推页面参数列表，task.xhtml页面需要的参数，这里传递username和title --%>
		<aa:push-params>
			<aa:push-param name="username" value="<%=username %>" />
			<aa:push-param name="title" value="<%=title %>" />
		</aa:push-params>
	</aa:direct-push>


</aa:if>

