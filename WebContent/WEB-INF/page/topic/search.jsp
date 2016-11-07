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
<title>搜索话题</title>

<%@ include file="../inc.jsp" %>

<style type="text/css">
.whiteBorder {
border: 2px solid white;
border-radius: 10px;
padding: 50px;
-moz-border-radius:10px; /* Old Firefox */
}
</style>

</head>
<body>

<%@ include file="../top.jsp" %>
<%@ include file="../nav.jsp" %>

<div id="main_rect" class="container">
<br/>
<div class="row">
<div class="col-xs-2"></div>
<div class="col-xs-8 whiteBorder">
<form id="topicForm" class="form-horizontal" role="form" action="${rt}/topic/doSearch.action" method="post">

<div class="form-group">
	<h4 class="txtColorGrey"><b>关&nbsp;键&nbsp;字&nbsp;：</b></h4>
	<div>
		<input class="form-control" id="keywordsInput" name="keywords" type="text" placeholder="在此输入关键字">
	</div>
</div>

<hr/>

<div class="form-group">
	<h4 class="txtColorGrey"><b>所&nbsp;属&nbsp;板&nbsp;块&nbsp;：</b></h4>
	<div>
		<select id="sectionSelect" name="section" class="form-control">
			<option value="-1" selected>所有板块</option>
			<c:forEach items="${sections}" var="section">
				<option value="${section.id}">${section.title}</option>
			</c:forEach>
		</select>
	</div>
</div>

<hr/>

<div class="form-group">
	<div class="col-xs-12">
		<button type="submit" class="btn btn-lg btn-block btn-primary">搜&nbsp;&nbsp;索</button>
	</div>
</div>

</form>
</div>
<div class="col-xs-2"></div>
</div>
<hr/>
</div>
<%@ include file="../bottom.jsp" %>

</body>
</html>