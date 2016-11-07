<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>错误！</title>
<%@ include file="inc.jsp" %>
</head>
<body>

<%@ include file="top.jsp" %>
<%@ include file="nav.jsp" %>

<div id="main_rect" class="container text-center">

<br/>
<div class="alert alert-danger">错误！${errMsg}</div>

<img alt="error" src="${rt}/static/img/error.jpg"/>

</div>

<%@ include file="bottom.jsp" %>

</body>
</html>