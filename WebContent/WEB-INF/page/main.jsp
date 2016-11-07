<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="forum.cute.bean.UserBean"%>
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
<title>CuteForum</title>

<%@ include file="inc.jsp" %>

</head>
<body>

<%@ include file="top.jsp" %>
<%@ include file="nav.jsp" %>

<script type="text/javascript">
	setNavItem("navMainItem");//设置导航选中项
</script>

<div id="main_rect" class="container">

<br/>
<c:set var="i" value="0"/>
<c:forEach items="${sections}" var="section">
<c:set var="i" value="${i+1}"/>
<div class="panel panel-primary">
	<div class="panel-heading">
		<h3 class="panel-title">
			<img src="${rt}/static/img/section/section_mark.png"/>
			<a href="${rt}/section.action?id=${section.id}">${section.title}</a>
		</h3>
	</div>
	<div class="panel-body">
		<!-- 板块介绍 -->
		<div class="col-xs-2">
			<div class="panel panel-primary">
      			<div class="panel-heading">
         			<h4 class="panel-title">
            			<a data-toggle="collapse" data-parent="#accordion" href="#collapseIntro_${i}">【${i}】Intro</a>
					</h4>
				</div>
				<div id="collapseIntro_${i}" class="panel-collapse collapse">
					<div class="panel-body">
						${section.desc}
					</div>
				</div>
			</div>
			<script type="text/javascript">
				$(function () { $('#collapseIntro_${i}').collapse('show')});
			</script>  
		</div>
		<!-- 推荐帖子 -->
		<div class="col-xs-10">
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
			Map<Integer, List<TopicBean>> recommends = (Map<Integer, List<TopicBean>>) request.getAttribute("recommends");
			Map<Integer, UserBean> userInfos = (Map<Integer, UserBean>) request.getAttribute("userInfos");
			Map<Integer, Integer> replyNums = (Map<Integer, Integer>) request.getAttribute("replyNums");
			SectionBean section = (SectionBean) pageContext.getAttribute("section");
			List<TopicBean> topics = recommends.get(section.getId());
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
					<a href="${rt}/topic/show.action?topicId=<%=topic.getId() %>"><%=topic.getTitle() %></a>
				</div>
				<div class="col-xs-2">
					<a href="${rt}/user/space.action?userId=<%=author.getId() %>"><%=author.getName() %></a>
				</div>
				<div class="col-xs-3">
					<%=new SimpleDateFormat("yy-MM-dd hh:mm:ss").format(topic.getPubTime()) %>
				</div>
				<div class="col-xs-1">
					<%=rnum %>
				</div>
			</div>
			<%
			}
			%>
		</div>
	</div>
</div>
	
</c:forEach>

</div>

<%@ include file="bottom.jsp" %>

</body>
</html>