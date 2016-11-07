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
<title>用户中心</title>


<%@ include file="../inc.jsp" %>

</head>
<body>

<%@ include file="../top.jsp" %>
<%@ include file="../nav.jsp" %>

<script type="text/javascript">
	setNavItem("navCentreItem");//设置导航选中项
</script>

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
$(menu_info_tab).addClass("active");
</script>
</div>

<div class="col-xs-10">

<br/>

<div class="row">
      <div class="col-sm-2 text-right"><label>V&nbsp;I&nbsp;P：</label></div>
      <div class="col-sm-10"><span class="label label-warning">黄钻年费会员LEVEL8</span></div>
</div>
<br/>
<div class="row">
      <div class="col-sm-2 text-right"><label>信誉值：</label></div>
      <div class="col-sm-10"><span class="label label-success">★&nbsp;★&nbsp;★&nbsp;★&nbsp;★&nbsp;★&nbsp;☆&nbsp;☆&nbsp;☆&nbsp;☆</span></div>
</div>
<br/>
<div class="row">
      <div class="col-sm-2 text-right"><label>威望：</label></div>
      <div class="col-sm-10"><span class="label label-primary">◆&nbsp;◆&nbsp;◆&nbsp;◆&nbsp;◆&nbsp;◇&nbsp;◇&nbsp;◇&nbsp;◇&nbsp;◇</span></div>
</div>

<hr/>

<form class="form-horizontal" role="form" action="${rt}/user/modifyInfo.action" method="post">

<div class="form-group">
      <label for="nameInput" class="col-sm-2 control-label">昵&nbsp;称&nbsp;：</label>
      <div class="col-sm-6">
         <input class="form-control" id="nameInput" name="name" type="text" value="${user.name}" placeholder="哆啦A梦911" onblur="checkName();">
      </div>
      <label class="col-sm-3 control-label help-block" id="nameTip">请输入8位以内的汉字英文数字组合的帐号</label>
</div>

	<div class="form-group">
		<label for="genderSelect"  class="col-sm-2 control-label">性&nbsp;别&nbsp;：</label>
		<div class="col-sm-6">
			<select id="genderSelect" name="gender" class="form-control">
			<c:if test="${user.gender==0}">
				<option value="0" selected>未知&nbsp;(UNKNOWN)</option>
			</c:if>
			<c:if test="${user.gender!=0}">
				<option value="0">未知&nbsp;(UNKNOWN)</option>
			</c:if>
			<c:if test="${user.gender==1}">
				<option value="1" selected>男&nbsp;(BOY)</option>
			</c:if>
			<c:if test="${user.gender!=1}">
				<option value="1">男&nbsp;(BOY)</option>
			</c:if>
			<c:if test="${user.gender==2}">
				<option value="2" selected>女&nbsp;(GIRL)</option>
            </c:if>
            <c:if test="${user.gender!=2}">
           		<option value="2">女&nbsp;(GIRL)</option>
            </c:if>
			</select>
		</div>
		<label class="col-sm-3 control-label help-block" id="genderTip">不填就素人妖</label>
	</div>

<div class="form-group has-warning">
		<label for="descText" class="col-sm-2 control-label">个&nbsp;人&nbsp;说&nbsp;明&nbsp;：</label>
		<div class="col-sm-6">
			<textarea id="descText" name="desc" class="form-control" rows="4">${user.desc}</textarea>
		</div>
		<label class="col-sm-3 control-label help-block" id="descTip">选填（80字以内哟）</label>
	</div>
	
<div class="form-group">
		<div class="col-xs-2"></div>
		<div class="col-xs-3 text-center">
			<button type="submit" class="btn btn-lg btn-block btn-primary">修&nbsp;&nbsp;改</button>
		</div>
		<div class="col-xs-3 text-center">
			<button type="reset" class="btn btn-lg btn-block btn-default">重&nbsp;&nbsp;置</button>
		</div>
	</div>
	
</form>

</div>

</div>

</div>

<%@ include file="../bottom.jsp" %>

<script type="text/javascript">

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

</script>

</body>
</html>