<%@page import="forum.cute.utils.PageLinks"%>
<%@page import="java.text.SimpleDateFormat"%>
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
<title>用户中心--我的话题</title>


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

<c:if test="${not empty param.delTopicNum}">
	<div class="alert alert-info">
	成功删除了${param.delTopicNum}个话题,
	并且删除了${param.delReplyNum}个回复
	</div>
</c:if>

<div class="row">

<div class="col-xs-2">
<%@ include file="menu.jsp" %>
<script type="text/javascript">
$(menu_topic_tab).addClass("active");
</script>
</div>

<div class="col-xs-10">

<div class="row tableHeader">
	<div class="col-xs-6">
		<h5>话题</h5>
	</div>
	<div class="col-xs-2">
		<h5>操作</h5>
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
Map<Integer, Integer> replyNums = (Map<Integer, Integer>) request.getAttribute("replyNums");
%>
<%
for(int i = 0; i < topics.size(); i++)
{
	TopicBean topic = topics.get(i);
	int rnum = replyNums.get(topic.getId());
%>
<div class="row tableLine">
	<div class="col-xs-6">
		<h5><a class="txtColorDark" href="${rt}/topic/show.action?topicId=<%=topic.getId() %>"><%=topic.getTitle() %></a></h5>
	</div>
	<div class="col-xs-2">
		<h5>
		<a href="${rt}/topic/modify.action?topicId=<%=topic.getId() %>">修改</a>
		/
		<a href="#" onclick="deleteSure(<%=topic.getId() %>,'<%=topic.getTitle() %>')">删除</a>
		</h5>
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

<!-- 模态框（Modal） -->
<div class="modal fade" id="deleteSurePane" tabindex="-1" role="dialog" 
   aria-labelledby="myModalLabel" aria-hidden="true">
   <div class="modal-dialog">
      <div class="modal-content">
         <div class="modal-header">
            <button type="button" class="close" 
               data-dismiss="modal" aria-hidden="true">
                  &times;
            </button>
            <h4 class="modal-title" id="deleteModalLabel">
             	删除确认
            </h4>
         </div>
         <div class="modal-body">
            <span id="deleteSureWords"></span>	
         </div>
         <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal">
				取消
            </button>
            <button type="button" class="btn btn-primary" onclick="sendDeleteReq()">
               	删除
            </button>
         </div>
      </div><!-- /.modal-content -->
	</div>
</div>

<div class="text-center">
<%
PageLinks pl = new PageLinks(out);
pl.linkBody = pageContext.getAttribute("rt") + "/user/myTopics.action?";
pl.pageInd = (Integer)request.getAttribute("page");;
pl.minPageInd = 0;
pl.maxPageInd = (Integer)request.getAttribute("maxPageInd");
pl.LINK_SIDE_SIZE = 3;
pl.output();
%>
</div>

</div>

</div>

<hr/>

</div>

<%@ include file="../bottom.jsp" %>

<script type="text/javascript">
var deleteId = -1;
var deleteTitle = "null";
function deleteSure(id, title)
{
	deleteId = id;
	deleteTitle = title;
	document.getElementById("deleteSureWords").innerHTML = "你真的要删除《"+deleteTitle+"》这个帖子吗？";
	$("#deleteSurePane").modal();
}

function sendDeleteReq()
{
	location.href = "${rt}/topic/delete.action?topicId="+deleteId+"&page="+${page};
}
</script>

</body>
</html>