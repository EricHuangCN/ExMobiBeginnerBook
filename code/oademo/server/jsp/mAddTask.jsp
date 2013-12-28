<%@ page language="java" import="java.util.*,com.fiberhome.bcs.appprocess.common.util.*"
 contentType="application/uixml+xml; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/client/adapt.jsp"%>

<%-- 请求新建任务页面 --%>
<aa:http id="addTask"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.nj.fiberhome.com.cn/exmobi.dtd">
<html>
<head>
<meta charset="UTF-8"/>
<title>新建——get请求</title>
<script>
<![CDATA[
	function doSubmit(){
		if(document.getElementById("title").value==""){
			alert("标题不能为空！");
			return;
		}else if(document.getElementById("days").value==""){
			alert("工期不能为空！");
			return;
		}else if(document.getElementById("begin_time").value==""){
			alert("开始时间不能为空！");
			return;
		}else if(document.getElementById("end_time").value==""){
			alert("结束时间不能为空");
			return;
		}else if(document.getElementById("uploadImg").value==""){
			alert("附件不能为空！");
			return;
		}
		document.getElementById("form").submit();
	}
]]>
</script>
</head>
<body>
<%-- action为http://oa/app/template/action/taskManagerAction.jsp?handler=save --%>
<form id="form" action="http://oa/app/template<%=aa.regexFilter("url:'..([^']+)'", aa.xpath("//script[not(@src)]", "addTask"))%>" method="post" target="_self" enctype="multipart/form-data">
<%-- 包含有input的table就是登陆需要信息，对该表格tr做循环读取 --%>
<aa:for-each dsId="addTask" var="node" xpath="//fieldset/table/tr//td/node()">
	<aa:choose>
		<%-- 获取文本标题 --%>
		<aa:when testxpath="name()=''" dsId="node">
			<font color="#ff0000" style="width:30%;"><aa:value-of xpath="." dsId="node"/></font>
		</aa:when>
		<%-- 将有选择时间的input转成ExMobi的object控件 --%>
		<aa:when test='<%=aa.xpath("contains(./@name, \'_time\')", "node") %>'>
			<object type="date" name="<%=aa.xpath("./@name", "node")%>" id="<%=aa.xpath("./@id", "node")%>" style="width:70%;"></object>
		</aa:when>
		<%-- 普通input照常输出 --%>
		<aa:when testxpath="name()='input'" dsId="node">
			<input type="<%=aa.xpath("./@type", "node")%>" name="<%=aa.xpath("./@name", "node")%>" id="<%=aa.xpath("./@id", "node")%>" style="width:70%;"/>
		</aa:when>
		<%-- 普通textarea照常输出 --%>
		<aa:when testxpath="name()='textarea'" dsId="node">
			<textarea name="<%=aa.xpath("./@name", "node")%>" id="<%=aa.xpath("./@id", "node")%>" style="width:70%;height:60;"></textarea>
		</aa:when>
		<%-- 普通select照常输出 --%>
		<aa:when testxpath="name()='select'" dsId="node">
			<select name="<%=aa.xpath("./@name", "node")%>" id="<%=aa.xpath("./@id", "node")%>" style="width:70%">
				<%-- 取select下的option --%>
				<aa:for-each var="option" xpath="option" dsId="node">
					<option value="<%=aa.xpath("./@value", "option")%>"><%=aa.xpath(".", "option")%></option>
				</aa:for-each>
			</select>
		</aa:when>
		<aa:otherwise>
			<%-- 特殊的控件走此分支 --%>
			
		</aa:otherwise>
	</aa:choose>
	
</aa:for-each>
</form>
</body>
<footer>
	<div href="doSubmit()" style="padding:10 0 10 0;text-align:center;background-color:#cccccc;">
		保存
	</div>
</footer>
</html>