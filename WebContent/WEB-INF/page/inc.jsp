<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="rt" value="${pageContext.request.contextPath}" />

<!-- 新 Bootstrap 核心 CSS 文件 -->
<link rel="stylesheet" href="${rt}/static/bootstrap/css/bootstrap.min.css">
<!-- 可选的Bootstrap主题文件（一般不用引入） -->
<link rel="stylesheet" href="${rt}/static/bootstrap/css/bootstrap-theme.min.css">
<!-- jQuery文件。务必在bootstrap.min.js 之前引入 -->
<script src="${rt}/static/jQuery/jquery-1.11.3.min.js"></script>
<!-- 最新的 Bootstrap 核心 JavaScript 文件 -->
<script src="${rt}/static/bootstrap/js/bootstrap.min.js"></script>

<script type="text/javascript" src="${rt}/static/js/utils.js"></script>
<script type="text/javascript" src="${rt}/static/js/AjaxRequest.js"></script>

<style>
body {
	font-family: Microsoft YaHei;
	background-color: rgb(213,223,207);
	background-image: url("${rt}/static/img/bg/ferris_wheel.jpg");
	background-attachment: fixed;
	background-position: center;
	background-repeat: no-repeat;
}

#main_rect {
	background-color: aqua;
	background-color: rgba(213,223,207,0.6);
}


.tableHeader {
	background-color: #d555b3;
	background-color: rgba(13,78,123,0.2);
	border-top: thin solid #0d4e7b;
	border-bottom: thin solid #0d4e7b;
}
.tableLine {
	background-color: #d5d3fa;
	background-color: rgba(240,240,250,0.5);
	border-bottom: thin solid #6b6b6b;
}

.txtBold {
	font-weight: bold;
}

.txtShaddowDefault {
	text-shadow: #2b2b2b 0 1px 0;
}

.txtNeon {
	text-shadow: 0 0 10px #fff, 0 0 20px #fff, 0 0 30px #fff, 0 0 40px #ff00de, 0 0 70px #ff00de, 0 0 80px #ff00de, 0 0 100px #ff00de, 0 0 150px #ff00de;
}

.txtColorOrange {
	color: #fb8b4b;
}
.txtColorDark {
	color: #4b4b4b;
}
.txtColorGrey {
	color: #8b8b8b;
}
.txtColorWhite {
	color: #ebebeb;
}

.rplPreMark {
	color: #fe0000;
	font-weight: bold;
	text-shadow: 0 0 3px black;
}
.rplContent {
	color: #fefe00;
	text-shadow: 0 0 3px black;
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
