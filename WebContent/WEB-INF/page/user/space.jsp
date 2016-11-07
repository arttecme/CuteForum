<%@page import="forum.cute.utils.PageLinks"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="forum.cute.bean.UserBean"%>
<%@page import="forum.cute.define.UserImg"%>
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
<title>用户空间</title>


<%@ include file="../inc.jsp" %>

</head>
<body>

<%@ include file="../top.jsp" %>
<%@ include file="../nav.jsp" %>

<%
UserBean host = (UserBean)session.getAttribute("host");
if(host == null){
	host = (UserBean)request.getAttribute("host");
}
%>

<div id="main_rect" class="container">

<div class="row">
<!-- 左侧 -->
<div class="col-xs-4 text-center">
	<h3>${host.name}</h3>
	<img class="img-wrap" src="${rt}<%=UserImg.getUserImgFile(host, UserImg.TYPE_128) %>" />
	<div>江湖小虾</div>
	<hr/>
	<h4>个人说明：</h4>
	<div>${host.desc}</div>
	<br/>
</div>
<!-- 右侧 -->
<div class="col-xs-8">
<div class="row tableHeader">
	<div class="col-xs-6">
		<h5>话题</h5>
	</div>
	<div class="col-xs-3">
		<h5>修改时间</h5>
	</div>
	<div class="col-xs-3">
		<h5>发表时间</h5>
	</div>
</div>

<% 
List<TopicBean> topics = (List<TopicBean>) request.getAttribute("topics");
%>
<%
for(int i = 0; i < topics.size(); i++)
{
	TopicBean topic = topics.get(i);
%>
<div class="row tableLine">
	<div class="col-xs-6">
		<h5><a class="txtColorDark" href="${rt}/topic/show.action?topicId=<%=topic.getId() %>"><%=topic.getTitle() %></a></h5>
	</div>
	<div class="col-xs-3">
		<h5><%=new SimpleDateFormat("yyyy-MM-dd hh:mm:ss").format(topic.getModTime()) %></h5>
	</div>
	<div class="col-xs-3">
		<h5><%=new SimpleDateFormat("yyyy-MM-dd hh:mm:ss").format(topic.getPubTime()) %></h5>
	</div>
</div>
<%
}
%>
<div class="text-center">
<%
PageLinks pl = new PageLinks(out);
pl.linkBody = pageContext.getAttribute("rt") + "/user/space.action?userId="+host.getId()+"&";
pl.pageInd = (Integer)request.getAttribute("page");;
pl.minPageInd = 0;
pl.maxPageInd = (Integer)request.getAttribute("maxPageInd");
pl.LINK_SIDE_SIZE = 3;
pl.output();
%>
</div>
</div>
</div>

</div>

<%@ include file="../bottom.jsp" %>

</body>
</html>