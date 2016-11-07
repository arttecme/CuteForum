package com.baidu.ueditor.um;

import javax.servlet.http.HttpServletRequest;

public class MyUploadPlugin
{
	/** 是否使用ueditor默认的文件上传地址  */
	public static final boolean USE_DEFAULT_PATH = false;
	
	public static String getPhysicalPath(HttpServletRequest request, String path)
	{
		String realPath = request.getSession().getServletContext().getRealPath("/");
		return realPath + path + "";
	}
}
