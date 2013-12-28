<%@ page language="java" import="java.util.*,com.fiberhome.bcs.appprocess.common.util.*"
 contentType="application/uixml+xml; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/client/adapt.jsp"%>

<%-- mimetype是强制转换aa:http请求的响应内容格式，由于在抓包的时候可以看到响应内容就是标准XML所以强制转换为XML格式 --%>
<%-- 可以尝试去掉看下是什么效果（可能会导致XML结构乱掉） --%>
<aa:http id="taskManagerListXML" mimetype="text/xml">
	<%-- 该头信息的设置是因为抓包的实际content-type为multipart/form-data；而一般form表单的提交，默认content-type为application/x-www-form-urlencoded，所以需要重置。当然，如果直接在form表单设置enctype属性值为multipart/form-data也是可以的 --%>
	<aa:header name="Content-Type" value="multipart/form-data"/>
	<%-- 非键值对的请求正文一律放在aa:content中，当存在该标签的时候aa:param键值对参数自动失效。如果不写该标签的话，就本次aa:http请求而言是通过键值对的方式page=1&rows=5的方式提交的，将与抓包看到的内容不符，所以需要重置请求正文 --%>
	<aa:content><request><page><%=aa.getReqParameterValue("page") %></page><rows><%=aa.getReqParameterValue("rows") %></rows></request></aa:content>
</aa:http>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.nj.fiberhome.com.cn/exmobi.dtd">
<html>
<head>
<meta charset="UTF-8"/>
<title>列表:post为XML</title>
</head>
<body>
<aa:for-each dsId="taskManagerListXML" var="item" xpath="//item">
	<listitem type="twoline" caption="<%=aa.xpath("./title", "item") %>" sndcaption="<%=aa.xpath("./executor", "item")+"|"+aa.xpath("./update_time", "item") %>"/>
</aa:for-each>
</body>
</html>
