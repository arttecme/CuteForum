<%@page import="forum.cute.define.UserDefine"%>
<%@page import="forum.cute.define.UserImg"%>
<%@page import="forum.cute.bean.BeanKey"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="forum.cute.utils.PageLinks"%>
<%@page import="forum.cute.bean.ReplyBean"%>
<%@page import="forum.cute.bean.UserBean"%>
<%@page import="forum.cute.bean.SectionBean"%>
<%@page import="forum.cute.bean.TopicBean"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>查看话题</title>

<%@ include file="../inc.jsp" %>

<link href="${rt}/static/umeditor/themes/default/css/umeditor.css" type="text/css" rel="stylesheet">
<script type="text/javascript" charset="utf-8" src="${rt}/static/umeditor/umeditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="${rt}/static/umeditor/umeditor.min.js"></script>
<script type="text/javascript" src="${rt}/static/umeditor/lang/zh-cn/zh-cn.js"></script>

<style type="text/css">
.title-bg {
	background-color: rgba(36,105,155,0.8);
	border-bottom: 2px solid white;
}
.img-wrap {
	border:2px solid;
	border-radius:25px;
}
.article-bg {
	background-color: rgba(145,154,155,0.6);
	border-bottom: 2px solid white;
}
.content-status-bg {
	background-color: rgba(13,78,123,0.3);
}
.content-bg {
	background-color: rgba(255,255,255,0.7);
}
.content-oper-bg {
	background-color: rgba(255,255,255,0.7);
}
</style>

</head>
<body>

<%@ include file="../top.jsp" %>
<%@ include file="../nav.jsp" %>

<%
UserBean user = (UserBean)session.getAttribute(BeanKey.USER);
UserBean author = (UserBean)request.getAttribute("author");//pageContext.getAttribute("author");
%>

<div id="main_rect" class="container">

<div class="row title-bg">
<div class="col-xs-12">
	<h4><img src="${rt}/static/img/topic/title_mark.png" />
	<a class="txtColorWhite txtBold txtShaddowDefault" href="${rt}/section.action?id=${section.id}">${section.title}</a>
	<span class="txtColorWhite txtBold txtShaddowDefault">&nbsp;&nbsp;/&nbsp;</span>
	<a class="txtColorWhite txtBold txtShaddowDefault">【&nbsp;${topic.title}&nbsp;】<span class="badge">${floorNum}</span></a></h4>
</div>
</div>

<c:if test="${page==0}">
<div class="row article-bg">
	<div class="col-xs-2 text-center">
		<!-- 用户信息（左边） -->
		<br/>
		<img class="img-wrap" src="${rt}<%=UserImg.getUserImgFile(author, UserImg.TYPE_128) %>" />
		<br/>
		<a href="${rt}/user/space.action?userId=${author.id}"><b>${author.name}</b></a>
	</div>
	<div class="col-xs-10">
		<!-- 内容信息（右边） -->
		<div id="内容状态行" class="row content-status-bg">
			<div class="col-xs-10">
				<h5 class="txtColorWhite"><a class="txtColorOrange" href="${rt}/user/space.action?userId=${author.id}"><b>${author.name}</b></a>&nbsp;发表于&nbsp;
				<fmt:formatDate value="${topic.pubTime}" pattern="yyyy-MM-dd hh-mm-ss"/></h5>
			</div>
			<div class="col-xs-2">
				<img alt="楼猪" src="${rt}/static/img/topic/pig.png"/>
			</div>
		</div>
		<div id="主内容区" class="row content-bg">
			<div class="col-xs-12">
				<p class="text-justify">${topic.content}</p>
			</div>
		</div>
		<div id="内容操作行" class="row content-oper-bg">
			<div class="col-xs-12">
				<br/>
				<a href="#replyPos" class="btn btn-default" onclick="setReplyTarget('${author.name}', '${author.id}', 0)">
					<img src="${rt}/static/img/topic/reply_icon.png" />&nbsp;回复
				</a>
			</div>
			<div>&nbsp;</div>
		</div>
	</div>
</div>
</c:if>

<!-- =================================回复列表区域BEG==================================== -->
<%
List<ReplyBean> replies = (List<ReplyBean>) request.getAttribute("replies");
Map<Integer, UserBean> userInfos = (Map<Integer, UserBean>) request.getAttribute("userInfos");
%>
<%
for(int i = 0; i < replies.size(); i++) {
	ReplyBean reply = replies.get(i);
	UserBean reviewer = userInfos.get(reply.getAuthor());
	if(reviewer == null)
	{ 
		reviewer = new UserBean();
		reviewer.setName(UserDefine.DEAULT_NAME);
	}
	UserBean replyTar = userInfos.get(reply.getReplyUser());
	if(replyTar == null)
	{ 
		replyTar = new UserBean();
		replyTar.setName(UserDefine.DEAULT_NAME);
	}
	String RCID = "repCtt_" + i;
	pageContext.setAttribute("RCID", RCID);
	pageContext.setAttribute("reply", reply);
	pageContext.setAttribute("reviewer", reviewer);
	pageContext.setAttribute("replyTar", replyTar);
%>

<div class="row article-bg">
	<div class="col-xs-2 user-div text-center">
		<br/>
		<img class="img-wrap" src="${rt}<%=UserImg.getUserImgFile(reviewer, UserImg.TYPE_128) %>" />
		<br/>
		<a href="${rt}/user/space.action?userId=${reviewer.id}"><b>${reviewer.name}</b></a>
	</div>
	<div class="col-xs-10">
		<div class="row content-status-bg">
			<div class="col-xs-10">
				<h5 class="txtColorWhite">
				<a class="txtColorOrange" href="${rt}/user/space.action?userId=${reviewer.id}"><b>${reviewer.name}</b></a>
				在<%=new SimpleDateFormat("yyyy-MM-dd hh-mm-ss").format(reply.getReplyTime()) %>回复了&nbsp;
				<a class="txtColorOrange" href="${rt}/user/space.action?userId=${replyTar.id}"><b>${replyTar.name}</b></a>
				@${reply.replyFloor}楼
				</h5>
			</div>
			<div class="col-xs-2">
				<h5 class="txtColorWhite txtShaddowDefault"><%=reply.getFloor() %>楼</h5>
			</div>
		</div>
		<div class="row content-bg">
			<div id="${RCID}" class="col-xs-12">
				<%=reply.getContent() %>
			</div>
		</div>
		<div class="row content-oper-bg">
			<div>&nbsp;</div><div>&nbsp;</div>
			<div class="col-xs-12">
				<a href="#replyPos" class="btn btn-default" onclick="setReplyTarget('${reviewer.name}', '${reviewer.id}', ${reply.floor}, $('#${RCID}').text());">
					<img src="${rt}/static/img/topic/reply_icon.png" />&nbsp;回复
				</a>
			</div>
			<div>&nbsp;</div>
		</div>
	</div>
</div>

<%} %>
<!-- =================================回复列表区域END==================================== -->


<!-- ========================分页区域BEG============================ -->
<div class="text-center">
<%
PageLinks pl = new PageLinks(out);
pl.linkBody = pageContext.getAttribute("rt") + "/topic/show.action?topicId=" + request.getAttribute("topicId") + "&";
pl.pageInd = (Integer)request.getAttribute("page");;
pl.minPageInd = 0;
pl.maxPageInd = (Integer)request.getAttribute("maxPageInd");
pl.LINK_SIDE_SIZE = 3;
pl.output();
%>
</div>

<script type="text/javascript">
function jumpPage()
{
	var input = document.getElementById("jumpPageInput").value;
	input = input - 1;
	if(input < <%=pl.minPageInd%>) { input = <%=pl.minPageInd%>; }
	if(input > <%=pl.maxPageInd%>) { input = <%=pl.maxPageInd%>; }
	var link = "${rt}/topic/show.action?topicId=${requestScope.topicId}&page="+input;
	location.href = link;
	
}
</script>
<div class="input-group col-xs-4 col-xs-push-4 text-center">
	<span class="input-group-btn">
		<button class="btn btn-default" type="button">${page+1} / ${maxPageInd+1}</button>
	</span>
	<input type="text" class="form-control" id="jumpPageInput" placeholder="第几页(输入数字,最大${maxPageInd+1})">
	<span class="input-group-btn">
		<button class="btn btn-primary" type="button" onclick="jumpPage();">GO!</button>
	</span>
</div>
<!-- ========================分页区域END============================ -->

<hr/>

<div name="replyPos" id="replyPos" class="row">
<div class="col-xs-12">
	<div>
		回复：<span id="replyTarSpan" class="label label-default">楼主  @ 0楼</span>
		&nbsp;&nbsp;&nbsp;OR&nbsp;&nbsp;&nbsp;
		<button class="btn btn-sm btn-primary" onclick="setReplyTarget('${author.name}', '${author.id}', 0)">回复楼主</button>
	</div>
	<div>
		<!--style给定宽度可以影响编辑器的最终宽度-->
		<script type="text/plain" id="myEditor" style="width:100%;height:200px;">
   		 	( ⊙ o ⊙ ) 
		</script>
	</div>
	<div>
		<button class="btn btn-lg btn-primary btn-block" onclick="submitReply()">回复</button>
	</div>
	<hr/>
</div>
</div>

</div>

<%@ include file="../bottom.jsp" %>

<script type="text/javascript">
function setReplyTarget(userName, userId, floorIndex, replyContent)
{
	document.getElementById("form_replyFloor").value = floorIndex;
	document.getElementById("form_replyUser").value = userId;
	
	document.getElementById("replyTarSpan").innerHTML = userName+" @ "+floorIndex+"楼";
	if(replyContent != null && replyContent != "")
	{
		var cutStr = "";
		var strs = replyContent.trim().split("[-.-]");
		if(strs.length > 0)
		{
			cutStr = strs[strs.length-1];
		}
		else
		{
			cutStr = replyContent.trim().substr(0, 12);
		}
		cutStr = "<img src='${rt}/static/img/topic/qtL.png'/>『" + cutStr + "』 [-.-]<img src='${rt}/static/img/topic/qtR.png'/><br/>◆";
		UM.getEditor('myEditor').setContent(cutStr);
	}
}

function submitReply()
{
	if( document.getElementById("form_author").value == "" )
	{
		document.getElementById("form_author").value = "0";
	}
	document.getElementById("form_content").value = UM.getEditor('myEditor').getContent();
	document.getElementById("replyForm").submit();
}
</script>

<script type="text/javascript">
//创建富文本编辑器
	window.UMEDITOR_CONFIG.imagePath = "${rt}/";//重写配置项
    //实例化编辑器
    var um = UM.getEditor('myEditor');
</script>

<form id="replyForm" action="${rt}/topic/reply.action" method="post">
<input type="hidden" id="form_topicId" name="topicId" value="${topic.id}">
<input type="hidden" id="form_content" name="content">
<input type="hidden" id="form_author" name="author" value="${user.id}">
<input type="hidden" id="form_replyFloor" name="replyFloor" value="0">
<input type="hidden" id="form_replyUser" name="replyUser" value="0">
</form>

</body>
</html>