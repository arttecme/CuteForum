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
<title>编辑新的话题</title>

<%@ include file="../inc.jsp" %>

<link href="${rt}/static/umeditor/themes/default/css/umeditor.css" type="text/css" rel="stylesheet">
<script type="text/javascript" charset="utf-8" src="${rt}/static/umeditor/umeditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="${rt}/static/umeditor/umeditor.min.js"></script>
<script type="text/javascript" src="${rt}/static/umeditor/lang/zh-cn/zh-cn.js"></script>

</head>
<body>

<%@ include file="../top.jsp" %>
<%@ include file="../nav.jsp" %>

<div id="main_rect" class="container">

<br/>

<form id="topicForm" class="form-horizontal" role="form" action="${rt}/topic/publish.action" method="post">

<div class="form-group">
	<label for="titleInput" class="col-xs-1 control-label">主&nbsp;题&nbsp;：</label>
	<div class="col-xs-11">
		<input class="form-control" id="titleInput" name="title" type="text" placeholder="此处写文章标题" onblur="checkAccount();">
	</div>
</div>

<div class="form-group">
	<label for="sectionSelect"  class="col-xs-1 control-label">板&nbsp;块&nbsp;：</label>
	<div class="col-xs-6">
		<select id="sectionSelect" name="section" class="form-control">
		<c:forEach items="${sections}" var="section">
			<option value="${section.id}">${section.title}</option>
		</c:forEach>
		</select>
	</div>
</div>

<!--style给定宽度可以影响编辑器的最终宽度-->
<script type="text/plain" id="myEditor" style="width:100%;height:100%;">
    <p>这里我可以写一些输入提示</p>
</script>

<input type="hidden" id="content" name="content">
<input type="hidden" id="author" name="author" value="${user.id}">
<hr/>

<div class="form-group">
	<div class="col-xs-12">
		<button type="button" class="btn btn-lg btn-block btn-primary" onclick="publishTopic()">发&nbsp;&nbsp;表</button>
	</div>
</div>

</form>

<br/>
<br/>

<script type="text/javascript">
//发表话题
function publishTopic()
{
	document.getElementById("content").value = UM.getEditor('myEditor').getContent();
	document.getElementById("topicForm").submit();
}
</script>

<script type="text/javascript">
//创建富文本编辑器
	window.UMEDITOR_CONFIG.imagePath = "${rt}/";//重写配置项
    //实例化编辑器
    var um = UM.getEditor('myEditor');
    um.addListener('blur',function(){
        $('#focush2').html('编辑器失去焦点了')
    });
    um.addListener('focus',function(){
        $('#focush2').html('')
    });
    //按钮的操作
    function insertHtml() {
        var value = prompt('插入html代码', '');
        um.execCommand('insertHtml', value)
    }
    function isFocus(){
        alert(um.isFocus())
    }
    function doBlur(){
        um.blur()
    }
    function createEditor() {
        enableBtn();
        um = UM.getEditor('myEditor');
    }
    function getAllHtml() {
        alert(UM.getEditor('myEditor').getAllHtml())
    }
    function getContent() {
        var arr = [];
        arr.push("使用editor.getContent()方法可以获得编辑器的内容");
        arr.push("内容为：");
        arr.push(UM.getEditor('myEditor').getContent());
        alert(arr.join("\n"));
    }
    function getPlainTxt() {
        var arr = [];
        arr.push("使用editor.getPlainTxt()方法可以获得编辑器的带格式的纯文本内容");
        arr.push("内容为：");
        arr.push(UM.getEditor('myEditor').getPlainTxt());
        alert(arr.join('\n'))
    }
    function setContent(isAppendTo) {
        var arr = [];
        arr.push("使用editor.setContent('欢迎使用umeditor')方法可以设置编辑器的内容");
        UM.getEditor('myEditor').setContent('欢迎使用umeditor', isAppendTo);
        alert(arr.join("\n"));
    }
    function setDisabled() {
        UM.getEditor('myEditor').setDisabled('fullscreen');
        disableBtn("enable");
    }

    function setEnabled() {
        UM.getEditor('myEditor').setEnabled();
        enableBtn();
    }

    function getText() {
        //当你点击按钮时编辑区域已经失去了焦点，如果直接用getText将不会得到内容，所以要在选回来，然后取得内容
        var range = UM.getEditor('myEditor').selection.getRange();
        range.select();
        var txt = UM.getEditor('myEditor').selection.getText();
        alert(txt)
    }

    function getContentTxt() {
        var arr = [];
        arr.push("使用editor.getContentTxt()方法可以获得编辑器的纯文本内容");
        arr.push("编辑器的纯文本内容为：");
        arr.push(UM.getEditor('myEditor').getContentTxt());
        alert(arr.join("\n"));
    }
    function hasContent() {
        var arr = [];
        arr.push("使用editor.hasContents()方法判断编辑器里是否有内容");
        arr.push("判断结果为：");
        arr.push(UM.getEditor('myEditor').hasContents());
        alert(arr.join("\n"));
    }
    function setFocus() {
        UM.getEditor('myEditor').focus();
    }
    function deleteEditor() {
        disableBtn();
        UM.getEditor('myEditor').destroy();
    }
    function disableBtn(str) {
        var div = document.getElementById('btns');
        var btns = domUtils.getElementsByTagName(div, "button");
        for (var i = 0, btn; btn = btns[i++];) {
            if (btn.id == str) {
                domUtils.removeAttributes(btn, ["disabled"]);
            } else {
                btn.setAttribute("disabled", "true");
            }
        }
    }
    function enableBtn() {
        var div = document.getElementById('btns');
        var btns = domUtils.getElementsByTagName(div, "button");
        for (var i = 0, btn; btn = btns[i++];) {
            domUtils.removeAttributes(btn, ["disabled"]);
        }
    }
</script>

</div>

<%@ include file="../bottom.jsp" %>

</body>
</html>