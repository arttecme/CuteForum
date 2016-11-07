<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style>
#bottom_rect{
	background-color: #2b2b2b;
	background-color: rgba(33, 33, 33, 0.9);
	color: silver;
	font-size: 12px;
	padding: 30px 20px;
}
</style>
    
<div id="bottom_rect" class="container">

<div class="row">

<div class="col-xs-4">
	Powered by Cute Forum! 1.0.3 alpha<br/>
	© 2015-2032 AnStudio Inc.
</div>

<div class="col-xs-8 text-right">
	Jack Gu. | <a href="#" class="txtColorWhite" onclick="alert('mail:278884301@qq.com');">Contact Me</a> | Archiver<br/>
	<%=new Date().toString() %>.
</div>

<br/>

</div>