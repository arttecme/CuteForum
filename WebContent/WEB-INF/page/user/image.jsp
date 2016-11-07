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
<title>用户中心--形象设置</title>

<%@ include file="../inc.jsp" %>

<script src="${rt}/static/fullAvatarEditor/scripts/swfobject.js"></script>
<script src="${rt}/static/fullAvatarEditor/scripts/fullAvatarEditor.js"></script>


</head>
<body>

<%@ include file="../top.jsp" %>
<%@ include file="../nav.jsp" %>

<div id="main_rect" class="container">

<div class="row">

<div class="col-xs-2">
<%@ include file="menu.jsp" %>
<script type="text/javascript">
$(menu_image_tab).addClass("active");
</script>
</div>

<div class="col-xs-10">

<hr/>
<c:if test="${not empty user.icon}">
<div class="panel panel-primary">
   <div class="panel-heading">
      <h3 class="panel-title">当前形象</h3>
   </div>
   <div class="panel-body">
   		128*128像素：
      	<img src="${rt}/upload/user/img/${user.icon}_128.jpg" />
      	64*64像素：
      	<img src="${rt}/upload/user/img/${user.icon}_64.jpg" />
      	32*32像素：
      	<img src="${rt}/upload/user/img/${user.icon}_32.jpg" />
   </div>
</div>
<hr/>
</c:if>

<div style="width:632px;margin: 0 auto;text-align:center">
			<h3 style="text-align:center">上传你的新头像~。~V</h3>
			<div>
				<p id="swfContainer">
                    本组件需要安装Flash Player后才可使用，请从<a href="http://www.adobe.com/go/getflashplayer">这里</a>下载安装。
				</p>
			</div>
			<!-- 
			<button type="button" id="upload" style="display:none;margin-top:8px;">swf外定义的上传按钮，点击可执行上传保存操作</button>
        	 -->
        </div>
		<script type="text/javascript">
            swfobject.addDomLoadEvent(function () {
				var swf = new fullAvatarEditor("${rt}/static/fullAvatarEditor/fullAvatarEditor.swf", "${rt}/static/fullAvatarEditor/expressInstall.swf", "swfContainer", {
					    id : 'swf',
						upload_url : '${rt}/user/upImg.action?sign=keepmoving911',	//上传接口
						method : 'post',	//传递到上传接口中的查询参数的提交方式。更改该值时，请注意更改上传接口中的查询参数的接收方式
						src_upload : 2,		//是否上传原图片的选项，有以下值：0-不上传；1-上传；2-显示复选框由用户选择
						avatar_box_border_width : 0,
						avatar_sizes : '128*128|64*64|32*32',
						avatar_sizes_desc : '128*128像素|64*64像素|32*32像素'
					}, function (msg) {
						switch(msg.code)
						{
							case 1 : 
								//alert("页面成功加载了组件！");
								break;
							case 2 : 
								//alert("已成功加载图片到编辑面板。");
								document.getElementById("upload").style.display = "inline";
								break;
							case 3 :
								if(msg.type == 0)
								{
									alert("摄像头已准备就绪且用户已允许使用。");
								}
								else if(msg.type == 1)
								{
									alert("摄像头已准备就绪但用户未允许使用！");
								}
								else
								{
									alert("摄像头被占用！");
								}
							break;
							case 5 : 
								if(msg.type == 0)
								{
									if(msg.content.sourceUrl)
									{
										//alert("原图已成功保存至服务器，url为：\n" +　msg.content.sourceUrl+"\n\n" + "头像已成功保存至服务器，url为：\n" + msg.content.avatarUrls.join("\n\n"));
									}
									else
									{
										//alert("头像已成功保存至服务器，url为：\n" + msg.content.avatarUrls.join("\n\n"));
									}
									window.location.reload();
								}
							break;
							default:
								alert("type="+msg.type+"==>"+msg.content.msg);
								break;
						}
					}
				);
				document.getElementById("upload").onclick=function(){
					swf.call("upload");
				};
            });
			//var _bdhmProtocol = (("https:" == document.location.protocol) ? " https://" : " http://");
			//document.write(unescape("%3Cscript src='" + _bdhmProtocol + "hm.baidu.com/h.js%3F5f036dd99455cb8adc9de73e2f052f72' type='text/javascript'%3E%3C/script%3E"));
        </script>

</div>

</div>

<%@ include file="../bottom.jsp" %>

<script type="text/javascript">

</script>

</body>
</html>