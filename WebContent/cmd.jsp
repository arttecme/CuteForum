<%@page import="forum.cute.bean.BeanKey"%>
<%@page import="forum.cute.bean.UserBean"%>
<%@page import="java.io.IOException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>命令测试工具</title>

<!-- 新 Bootstrap 核心 CSS 文件 -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/bootstrap/css/bootstrap.min.css">
<!-- jQuery文件。务必在bootstrap.min.js 之前引入 -->
<script src="${pageContext.request.contextPath}/static/jQuery/jquery-1.11.3.min.js"></script>
<!-- 最新的 Bootstrap 核心 JavaScript 文件 -->
<script src="${pageContext.request.contextPath}/static/bootstrap/js/bootstrap.min.js"></script>

<style>
.row{
    margin-bottom: 20px;
}
.row .row{
    margin-top:10px;
    margin-bottom: 0;
}

[class*="col-"]{
    padding-top:15px;
    padding-bottom:15px;
    background-color: #245580;
    background-color: rgba(86,61,124, .15);
    border: 1px solid #843534;
    border: 1px solid rgba(86,61,124, .2);
}
</style>

</head>
<body>

<%!
boolean hasCmd(HttpServletRequest request, String paramName)
{
	return request.getParameter(paramName) != null;
}

void trace(JspWriter out, String msg) throws IOException
{
	out.print("[trace]"+msg+"<br/>");
}
%>

<%

if( hasCmd(request, "loginBtnLogin") )
{
	trace(out, "登录操作");
	UserBean user = new UserBean();
	user.setAccount(request.getParameter("loginInputAccount"));
	user.setPassword(request.getParameter("loginInputPassword"));
	user.setName(request.getParameter("loginInputAccount"));
	session.setAttribute(BeanKey.USER, user);
}
else if( hasCmd(request, "loginBtnLogout") )
{
	trace(out, "注销操作");
	session.removeAttribute(BeanKey.USER);
}

%>

user.name=${user.name}

<div class="container">
<form action="cmd.jsp" method="post"><div class="row">

<div class="col-md-4">
<div class="form-group">
    <label for="loginInputAccount">Account</label>
    <input type="text" class="form-control" id="loginInputAccount" name="loginInputAccount" placeholder="Account">
</div>
<div class="form-group">
    <label for="loginInputPassword">Password</label>
    <input type="password" class="form-control" id="loginInputPassword" name="loginInputPassword" placeholder="Password">
</div>
<div class="form-group">
    <label for="loginInputFile">File input</label>
    <input type="file" id="loginInputFile">
    <p class="help-block">If one day need certification here.</p>
</div>
<div class="checkbox">
    <label>
      <input type="checkbox"> Check me out
    </label>
</div>
<button type="submit" class="btn btn-info" id="loginBtnLogin" name="loginBtnLogin">Login</button>
<button type="submit" class="btn btn-info" id="loginBtnLogout" name="loginBtnLogout">Logout</button>

</div>

<div class="col-md-4">2</div>
<div class="col-md-4">3</div>
<div class="col-md-4">4</div>
<div class="col-md-4">5</div>
    
</div></form>
</div>

</body>
</html>