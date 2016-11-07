<%@page import="java.text.SimpleDateFormat"%>
<%@page import="forum.cute.bean.UserBean"%>
<%@page import="forum.cute.utils.PageLinks"%>
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
<title>搜索结果</title>

<%@ include file="../inc.jsp" %>

<style type="text/css">

</style>

</head>
<body>

<%@ include file="../top.jsp" %>
<%@ include file="../nav.jsp" %>

<div id="main_rect" class="container">

<br/>

<div class="row">
	<div class="col-xs-3">
		共搜索出相关话题${topicsNum}个
	</div>
	<div class="col-xs-9">
		<div class="progress progress-striped active">
			<div class="progress-bar progress-bar-primary" role="progressbar" 
				aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" 
				style="width: ${100*(page+1)/(maxPageInd+1)}%;">
			<span class="sr-only">阅读进度</span>
			</div>
		</div>
	</div>
</div>

<div class="row tableHeader">
	<div class="col-xs-6">
		<h5>话题</h5>
	</div>
	<div class="col-xs-2">
		<h5>作者</h5>
	</div>
	<div class="col-xs-3">
		<h5>发表时间</h5>
	</div>
	<div class="col-xs-1">
		<h5>回复数</h5>
	</div>
</div>


<% 
List<TopicBean> topics = (List<TopicBean>) request.getAttribute("topics");
Map<Integer, UserBean> userInfos = (Map<Integer, UserBean>) request.getAttribute("userInfos");
Map<Integer, Integer> replyNums = (Map<Integer, Integer>) request.getAttribute("replyNums");
%>
<%
for(int i = 0; i < topics.size(); i++)
{
	TopicBean topic = topics.get(i);
	UserBean author = userInfos.get(topic.getAuthor());
	if( author==null ) { author = new UserBean(); }
	int rnum = replyNums.get(topic.getId());
%>
<div class="row tableLine">
	<div class="col-xs-6">
		<h5><a class="txtColorDark" href="${rt}/topic/show.action?topicId=<%=topic.getId() %>"><%=topic.getTitle() %></a></h5>
	</div>
	<div class="col-xs-2">
		<h5><a href="${rt}/user/space.action?userId=<%=author.getId() %>"><%=author.getName() %></a></h5>
	</div>
	<div class="col-xs-3">
		<h5><%=new SimpleDateFormat("yyyy-MM-dd hh:mm:ss").format(topic.getPubTime()) %></h5>
	</div>
	<div class="col-xs-1">
		<h5><%=rnum %></h5>
	</div>
</div>
<%
}
%>

<!-- ${debugInfo} -->

<br/>

<br/>

<br/><br/>


<div class="text-center">
<%
PageLinks pl = new PageLinks(out);
pl.linkBody = pageContext.getAttribute("rt") + "/topic/doSearch.action?keywords=" + request.getAttribute("keywords") + "&section=" + request.getAttribute("section") + "&";
pl.pageInd = (Integer)request.getAttribute("page");
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
	var link = "${rt}/topic/doSearch.action?keywords=${requestScope.keywords}&section=${requestScope.section}&page="+input;
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

<br/>

</div>

<%@ include file="../bottom.jsp" %>

</body>
</html>