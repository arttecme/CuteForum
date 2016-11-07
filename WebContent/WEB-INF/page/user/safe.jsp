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
<title>用户中心--安全设置</title>


<%@ include file="../inc.jsp" %>

</head>
<body>

<%@ include file="../top.jsp" %>
<%@ include file="../nav.jsp" %>

<div id="main_rect" class="container">

<c:if test="${not empty param.errorMsg}">
	<br/>
	<div class="alert alert-danger alert-dismissable">
		<button type="button" class="close" data-dismiss="alert" aria-hidden="true">
      		&times;
		</button>
		 错误！${param.errorMsg}
	</div>
</c:if>

<div class="row">

<div class="col-xs-2">
<%@ include file="menu.jsp" %>
<script type="text/javascript">
$(menu_safe_tab).addClass("active");
</script>
</div>

<div class="col-xs-10">
<div class="text-center">
	<img src="${rt}/static/img/user/security.png" class="" alt="Security">
</div>
<hr/>

<form class="form-horizontal" role="form" action="${rt}/user/modifySafe.action" method="post">

<div id="passwordDiv" class="form-group">
	<label for="passwordInput" class="col-sm-2 control-label">密&nbsp;码&nbsp;：</label>
	<div class="col-sm-6">
		<input class="form-control" id="passwordInput" name="password" type="password" onblur="checkPassword();">
	</div>
	<label class="col-sm-3 control-label help-block" id="passwordTip">请输入16位以内的英文数字组合的密码</label>
</div>

<div id="repeatDiv" class="form-group">
	<label for="passwordRepeat" class="col-sm-2 control-label">密&nbsp;码&nbsp;：</label>
	<div class="col-sm-6">
		<input class="form-control" id="passwordRepeat" type="password" onblur="checkPassword();">
	</div>
	<label class="col-sm-3 control-label help-block" id="repeatTip">请重复输入密码</label>
</div>

<div class="form-group">
	<div class="col-xs-2"></div>
	<div class="col-xs-3 text-center">
		<button type="submit" class="btn btn-lg btn-block btn-primary">修&nbsp;&nbsp;改</button>
	</div>
	<div class="col-xs-3 text-center">
		<button type="reset" class="btn btn-lg btn-block btn-default">清&nbsp;&nbsp;空</button>
	</div>
</div>
	
</form>

</div>

</div>

<hr/>

</div>

<%@ include file="../bottom.jsp" %>

<script type="text/javascript">
function checkPassword()
{
	var ok = true;
	var passwordVal = document.getElementById("passwordInput").value;
	var repeatVal = document.getElementById("passwordRepeat").value;
	if(passwordVal=="")
	{
		document.getElementById("passwordTip").innerHTML = "密码不能为空";
		ok = false;
	}
	else
	{
		document.getElementById("passwordTip").innerHTML = "您已输入了密码";
	}
	if(repeatVal=="")
	{
		document.getElementById("repeatTip").innerHTML = "请重复输入密码";
		ok = false;
	}
	else
	{
		document.getElementById("repeatTip").innerHTML = "您已输入了密码";
	}
	if(passwordVal != "" && repeatVal != "" && passwordVal != repeatVal)
	{
		document.getElementById("repeatTip").innerHTML = "两次输入的密码不相同";
		ok = false;
	}
	if(ok)
	{
		$("#passwordDiv").removeClass("has-error");
		$("#passwordDiv").addClass("has-success");
		$("#repeatDiv").removeClass("has-error");
		$("#repeatDiv").addClass("has-success");
	}
	else
	{
		$("#passwordDiv").removeClass("has-success");
		$("#passwordDiv").addClass("has-error");
		$("#repeatDiv").removeClass("has-success");
		$("#repeatDiv").addClass("has-error");
	}
}
</script>

</body>
</html>