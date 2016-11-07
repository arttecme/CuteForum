<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<style>
#top_rect{
	background-color: #52adbd;
	background-color: rgba(209,214,218, 0.9);/*rgba(160, 194, 200, 0.9);*/
}
.put_right_bottom{
	padding-left: 10px;
	padding-top: 50px;
}
/*
[class*="col-"]{
            background-color: #245580;
            background-color: rgba(86,61,124, .15);
            border: 1px solid #843534;
            border: 1px solid rgba(86,61,124, .2);
        }
        */
</style>

<script type="text/javascript">
//发送登录请求（提交登录表单）
function sendTopLogin()
{
	var userAccount = document.getElementById("topAccountInput").value;
	var userPassword = document.getElementById("topPasswordInput").value;
	if(userAccount == "") { document.getElementById("topAccountTip").innerHTML = "账户不能为空"; return false; }
	else { document.getElementById("topAccountTip").innerHTML = ""; }
	if(userPassword == "") { document.getElementById("topPasswordTip").innerHTML = "密码不能为空"; return false; }
	else { document.getElementById("topPasswordTip").innerHTML = ""; }
	//document.getElementById("loginForm").submit();
	var url = "${rt}/login.action";
	var params = "account=" + userAccount + "&password=" + userPassword;
	new net.AjaxRequest(url, onTopLoginResult, null, "POST", params);
}

function onTopLoginResult()
{
	var returnValue = this.req.responseText; //获取Ajax处理页的返回值
	var pure = returnValue.replace(/\s/g,""); //去除字符串中的Unicode空白符
	//alert(pure);
	if(utils.contains(pure, "success"))
	{
		location.reload();
	}
	else if(utils.contains(pure, "account_null"))
	{
		document.getElementById("topAccountTip").innerHTML = "帐号不存在";
	}
	else if(utils.contains(pure, "password_error"))
	{
		document.getElementById("topPasswordTip").innerHTML = "密码错误";
	}
}

$(function () { $('.popover-show').popover('show');});
$(function () { $('.popover-hide').popover('hide');});
$(function () { $('.popover-destroy').popover('destroy');});
$(function () { $('.popover-toggle').popover('toggle');});
$(function () { $(".popover-options button").popover({html : true });});
	      
</script>

<!-- debugInfo=${debugInfo} -->
<!-- ===========顶部栏============= -->
<div id="top_rect" class="container">

<c:set var="userOperList">
<br/>
<a href='${rt}/user/centre.action' type='button' class='btn btn-block btn-warning' style='font-size: 14px'>个人中心</a>
<a href='${rt}/logout.action' type='button' class='btn btn-block btn-default' style='font-size: 14px'>注销</a>
</c:set>

<div id="loginInfoCtn" class="row">
	<div class="col-xs-4">
		<img src="${rt}/static/img/top_logo.png"/>
	</div>
	
	<div class="col-xs-2 col-xs-push-6 put_right_bottom">
		<c:choose>
			<c:when test="${not empty user }">
				<!-- 已登录 -->
				<p class="popover-options">
				<button type="button" class="btn btn-default" style="font-size: 14px"
				title="<h3>您好，黄钻会员</h3>"  
			    data-container="body" data-toggle="popover" data-placement="bottom" 
			    data-content="你的会员快到期了，<br/>我知道你也很想充值呢！${userOperList}">
				  <span class="glyphicon glyphicon-user"></span> ${user.name}
				</button>
				</p>
			</c:when>
			<c:otherwise>
				<!-- 未登录 -->
				<button class="btn btn-primary" data-toggle="modal" data-target="#myModal">登录</button>
				<a class="btn btn-default" href="${rt}/register.action" target="_parent">注册</a>
			</c:otherwise>
		</c:choose>
	</div>

</div>

<!-- 登录模态框 -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" 
   aria-labelledby="myModalLabel" aria-hidden="true">
   <div class="modal-dialog">
      <div class="modal-content">
         <div class="modal-header">
            <button type="button" class="close" 
               data-dismiss="modal" aria-hidden="true">
                  &times;
            </button>
            <h4 class="modal-title" id="myModalLabel">
              	登录您的账户
            </h4>
         </div>
         <div class="modal-body">
         	<form id="loginForm" method="post">
				<div class="form-group">
				    <label for="topAccountInput">账户</label>
				    <input type="text" class="form-control" id="topAccountInput" name="userAccount" placeholder="Account">
				    <label id="topAccountTip" class="help-block"></label>
				</div>
				<div class="form-group">
				    <label for="topPasswordInput">密码</label>
				    <input type="password" class="form-control" id="topPasswordInput" name="userPassword" placeholder="Password">
					<label id="topPasswordTip" class="help-block"></label>
				</div>
				<div class="checkbox">
				    <label>
				      <input type="checkbox"> 记住我的帐号
				    </label>
				</div>
         	</form>
         </div>
         <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
            <button type="button" class="btn btn-primary" onclick="sendTopLogin()">登录</button>
         </div>
      </div><!-- /.modal-content -->
</div><!-- /.modal -->
</div>

</div>
