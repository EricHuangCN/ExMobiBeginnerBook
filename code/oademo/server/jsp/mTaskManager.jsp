<%@ page language="java" import="java.util.*,com.fiberhome.bcs.appprocess.common.util.*"
 contentType="application/uixml+xml; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/client/adapt.jsp"%>

<%-- 提交保存操作 --%>
<aa:http id="taskManagerAction"/>

<%-- 根据响应结果进行提示 --%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.nj.fiberhome.com.cn/exmobi.dtd">
<html type="alert">
<body>
	<alert title="提示" icontype="alarm">
		<%-- 为了简化说明，这里仅作一个提示，一般表单提交完可以做一些相应的处理 --%>
		<%-- 响应内容可以看下临时文件，也是一个json字符串，如果包含success则提交是正确，否则认为失败 --%>
		<msg><%=aa.regex(".*", "taskManagerAction").indexOf("success")>-1?"保存成功！":"保存失败！"%></msg>
	</alert>
</body>
</html>
