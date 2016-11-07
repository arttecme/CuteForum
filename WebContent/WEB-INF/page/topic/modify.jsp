<%@page import="forum.cute.bean.SectionBean"%>
<%@page import="forum.cute.bean.TopicBean"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>修改话题</title>

<%@ include file="../inc.jsp" %>

<link href="${rt}/static/umeditor/themes/default/css/umeditor.css" type="text/css" rel="stylesheet">
<script type="text/javascript" charset="utf-8" src="${rt}/static/umeditor/umeditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="${rt}/static/umeditor/umeditor.min.js"></script>
<script type="text/javascript" src="${rt}/static/umeditor/lang/zh-cn/zh-cn.js"></script>

</head>
<body>

<%@ include file="../top.jsp" %>
<%@ include file="../nav.jsp" %>

<div id="main_rect" class="container">

<br/>

<form id="topicForm" class="form-horizontal" role="form" action="${rt}/topic/update.action?topicId=${topic.id}" method="post">

<div class="form-group">
	<label for="titleInput" class="col-xs-1 control-label">主&nbsp;题&nbsp;：</label>
	<div class="col-xs-11">
		<input value="${topic.title}" class="form-control" id="titleInput" name="title" type="text" placeholder="account123" onblur="checkAccount();">
	</div>
</div>

<div class="form-group">
	<label for="sectionSelect"  class="col-xs-1 control-label">板&nbsp;块&nbsp;：</label>
	<div class="col-xs-6">
		<select id="sectionSelect" name="section" class="form-control">
		<c:forEach items="${sections}" var="section">
			<option value="${section.id}">${section.title}</option>
		</c:forEach>
		</select>
	</div>
</div>

<script type="text/javascript">
var opts = document.getElementById("sectionSelect").options;
for (var i=0; i<opts.length; i++)
{  
	if (opts[i].value == ${topic.section})
	{  
		opts[i].selected = true;  
		break;  
	}  
}
</script>

<!--style给定宽度可以影响编辑器的最终宽度-->
<script type="text/plain" id="myEditor" style="width:100%;height:100%;">
    ${topic.content}
</script>

<input type="hidden" id="content" name="content">
<input type="hidden" id="author" name="author" value="${user.id}">
<hr/>

<div class="form-group">
	<div class="col-xs-12">
		<button type="button" class="btn btn-lg btn-block btn-primary" onclick="updateTopic()">修&nbsp;&nbsp;改</button>
	</div>
</div>

</form>

<br/>
<br/>

<script type="text/javascript">
//修改话题
function updateTopic()
{
	document.getElementById("content").value = UM.getEditor('myEditor').getContent();
	document.getElementById("topicForm").submit();
}
</script>

<script type="text/javascript">
//创建富文本编辑器
	window.UMEDITOR_CONFIG.imagePath = "${rt}/";//重写配置项
    //实例化编辑器
    var um = UM.getEditor('myEditor');
</script>

</div>

<%@ include file="../bottom.jsp" %>

</body>
</html>