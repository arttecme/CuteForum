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
<title>新用户注册</title>


<%@ include file="inc.jsp" %>

</head>
<body>

<%@ include file="top.jsp" %>
<%@ include file="nav.jsp" %>

<div id="main_rect" class="container">

<br/>

<c:if test="${not empty errorMsg}">
	<script type="text/javascript">
		alert("注册失败！\r${errorMsg}");
	</script>
</c:if>

<br/>

<form class="form-horizontal" role="form" action="${rt}/register.action?type=commit" method="post">

   <div class="form-group">
      <label for="accountInput" class="col-sm-2 control-label">帐&nbsp;号&nbsp;：</label>
      <div class="col-sm-6">
         <input class="form-control" id="accountInput" name="account" type="text" placeholder="account123" onblur="checkAccount();">
      </div>
      <label class="col-sm-3 control-label help-block" id="accountTip">请输入16位以内的英文数字组合的帐号</label>
   </div>
   
   <br/>
   
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
   
   <br/>
   
   <div class="form-group">
      <label for="nameInput" class="col-sm-2 control-label">昵&nbsp;称&nbsp;：</label>
      <div class="col-sm-6">
         <input class="form-control" id="nameInput" name="name" type="text" placeholder="哆啦A梦911" onblur="checkName();">
      </div>
      <label class="col-sm-3 control-label help-block" id="nameTip">请输入8位以内的汉字英文数字组合的帐号</label>
   </div>
   
   <br/>
   
	<div class="form-group">
		<label for="genderSelect"  class="col-sm-2 control-label">性&nbsp;别&nbsp;：</label>
		<div class="col-sm-6">
			<select id="genderSelect" name="gender" class="form-control">
				<option value="0">未知&nbsp;(UNKNOWN)</option>
            	<option value="1">男&nbsp;(BOY)</option>
            	<option value="2">女&nbsp;(GIRL)</option>
			</select>
		</div>
		<label class="col-sm-3 control-label help-block" id="genderTip">不填就素人妖</label>
	</div>
	
	<br/>
	
	<div class="form-group has-warning">
		<label for="descText" class="col-sm-2 control-label">个&nbsp;人&nbsp;说&nbsp;明&nbsp;：</label>
		<div class="col-sm-6">
			<textarea id="descText" name="desc" class="form-control" rows="4">这个家伙很懒，什么都没留下~</textarea>
		</div>
		<label class="col-sm-3 control-label help-block" id="descTip">选填（80字以内哟）</label>
	</div>
	
	<br/>
	
	<div class="form-group">
		<div class="col-xs-2"></div>
		<div class="col-xs-3 text-center">
			<button type="submit" class="btn btn-lg btn-block btn-primary">注&nbsp;&nbsp;册</button>
		</div>
		<div class="col-xs-3 text-center">
			<button type="reset" class="btn btn-lg btn-block btn-default">重&nbsp;&nbsp;置</button>
		</div>
	</div>
   
</form>



</div>

<%@ include file="bottom.jsp" %>

<script type="text/javascript">

function checkAccount()
{
	var account = document.getElementById("accountInput").value;
	if(account == "")
	{
		document.getElementById("accountTip").innerHTML = "帐号不能为空";
		return;
	}
	var url = "${rt}/check/account.action";
	var params = "account=" + account;
	new net.AjaxRequest(url, onCheckAccountResult, null, "POST", params);
}

function onCheckAccountResult()
{
	var returnValue = this.req.responseText; //获取Ajax处理页的返回值
	var pure = returnValue.replace(/\s/g,""); //去除字符串中的Unicode空白符
	//alert("onCheckAccountResult="+returnValue);
	if( utils.contains(pure, "empty") ) { document.getElementById("accountTip").innerHTML = "帐号不能为空"; }
	else if( utils.contains(pure, "available") ) { document.getElementById("accountTip").innerHTML = "账户名可用"; }
	else if( utils.contains(pure, "exist") ) { document.getElementById("accountTip").innerHTML = "账户名已存在"; }
	else { document.getElementById("accountTip").innerHTML = "未知错误"; }
}

function checkName()
{
	var name = document.getElementById("nameInput").value;
	if(name == "")
	{
		document.getElementById("nameTip").innerHTML = "昵称不能为空";
		return;
	}
	var url = "${rt}/check/name.action";
	var params = "name=" + name;
	new net.AjaxRequest(url, onCheckNameResult, null, "POST", params);
}

function onCheckNameResult()
{
	var returnValue = this.req.responseText; //获取Ajax处理页的返回值
	var h = returnValue.replace(/\s/g,""); //去除字符串中的Unicode空白符
	//alert("onCheckAccountResult="+returnValue);
	if( utils.contains(h, "empty") ) { document.getElementById("nameTip").innerHTML = "昵称不能为空"; }
	else if( utils.contains(h, "available") ) { document.getElementById("nameTip").innerHTML = "昵称可用"; }
	else if( utils.contains(h, "exist") ) { document.getElementById("nameTip").innerHTML = "昵称已存在"; }
	else { document.getElementById("nameTip").innerHTML = "未知错误"; }
}

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