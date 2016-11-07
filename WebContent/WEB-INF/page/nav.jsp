<%@page import="forum.cute.bean.BeanKey"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style>
#nav_bar{
	background-color: #52adbd;
	background-color: rgba(82, 173, 189, 0.5);
}
.marginNone{
	margin: 0px 0px;
}
.paddingNone{
	padding: 0px 0px;
}
</style>

<!-- ===========导航栏============= -->
<div id="nav_bar" class="container paddingNone">
	<div class="navbar navbar-inverse marginNone">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target=".navbar-collapse">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="${rt}">泰迪大天团</a>
        </div>
        <div class="navbar-collapse collapse">
            <ul class="nav navbar-nav">
                <li id="navMainItem" class="active"><a href="${rt}">论坛板块</a></li>
                <li id="navCentreItem"><a href="#centre" onclick="gotoUserCentre()" >个人中心</a></li>
                <li id="navGameItem"><a href="${rt}/underConstruction.action">游戏圈</a></li>
                <li id="navHelpItem"><a href="${rt}/underConstruction.action">小助手</a></li>
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">常用操作<span class="caret"></span></a>
                    <ul class="dropdown-menu" role="menu">
                        <li><a href="${rt}/topic/edit.action">发表新帖子</a></li>
                        <li><a href="${rt}/topic/search.action">搜索帖子</a></li>
                        <li><a href="${rt}/user/myTopics.action">我的帖子</a></li>
                        <li class="divider"></li>
                        <li class="dropdown-header">充值业务</li>
                        <li><a href="${rt}/underConstruction.action">VIP通道</a></li>
                        <li><a href="${rt}/underConstruction.action">翻译服务</a></li>
                    </ul>
                </li>
            </ul>
        </div><!--/.nav-collapse -->
    </div>
</div>

<script type="text/javascript">
function setNavItem(tabId)
{
	$("#navMainItem").removeClass("active");
	$("#navCentreItem").removeClass("active");
	$("#navGameItem").removeClass("active");
	$("#navHelpItem").removeClass("active");
	$("#"+tabId).addClass("active");
}

function gotoUserCentre()
{
<%
if(null == session.getAttribute(BeanKey.USER)) {
%>
	//alert("尚未登录");
	$("#myModal").modal();
<%
}else{
%>
	location.href = "${rt}/user/centre.action";
<%
}
%>

}
</script>