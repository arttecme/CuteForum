package forum.cute.action.user;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Random;

import org.apache.commons.io.FileUtils;
import org.apache.struts2.ServletActionContext;

import com.alibaba.fastjson.JSON;
import com.opensymphony.xwork2.ActionContext;

import forum.cute.bean.BeanKey;
import forum.cute.bean.UserBean;
import forum.cute.service.DBService;

import static forum.cute.define.UserImg.TYPE_SOURCE;
import static forum.cute.define.UserImg.TYPE_128;
import static forum.cute.define.UserImg.TYPE_64;
import static forum.cute.define.UserImg.TYPE_32;
import static forum.cute.define.UserImg.SAVE_PATH;
import static forum.cute.define.UserImg.toFileName;

public class UserImgUploadAction
{
	/** 客户端顺便传的get参数，测试着玩的 */
	public String sign;
	public String rndcode;//fullAvatarEditor会传的值，没有什么用处
	
	private static class Result
	{
		/**
		* 表示图片是否已上传成功。
		*/
		public Boolean success;
		/**
		* 自定义的附加消息。
		*/
		public String msg;
		/**
		* 表示原始图片的保存地址。
		*/
		public String sourceUrl;
		/**
		* 表示所有头像图片的保存地址，该变量为一个数组。
		*/
		public ArrayList<String> avatarUrls;
	}
	
	private File __source;
	private String __sourceContentType;
	private String __sourceFileName;
	
	private File __avatar1;
	private String __avatar1ContentType;
	private String __avatar1FileName;
	
	private File __avatar2;
	private String __avatar2ContentType;
	private String __avatar2FileName;
	
	private File __avatar3;
	private String __avatar3ContentType;
	private String __avatar3FileName;
	
	
	
	private void handleImg(File avatarFile, String imgName, String type, Result result)
	{
		if(avatarFile == null) { return; }
		String fileName = toFileName(imgName, type);
		String realpath = ServletActionContext.getServletContext().getRealPath(SAVE_PATH);
		String virtualPath = SAVE_PATH +  fileName;
		
		if(avatarFile != null)
		{
			File destFile = new File(new File(realpath), fileName);
			if(!destFile.getParentFile().exists())
			{
				destFile.getParentFile().mkdir();
			}
			try
			{
				FileUtils.copyFile(avatarFile, destFile);
			}
			catch (IOException e)
			{
				e.printStackTrace();
			}
			if(TYPE_SOURCE.equals(type))
			{
				result.sourceUrl = virtualPath;
			}
			else
			{
				result.avatarUrls.add(virtualPath);
			}
		}
	}
	
	public String execute()
	{
		System.out.println("UserImgUploadAction:sign="+sign + " rndcode=" + rndcode);
		
		Result result = new Result();
		result.avatarUrls = new ArrayList<String>();
		
		UserBean user = (UserBean) ActionContext.getContext().getSession().get(BeanKey.USER);
		if(user == null)
		{
			result.success = false;
			result.msg = "need login";//"此操作需要登录后才能操作!";
		}
		else
		{
			String imgName = "";
			//取服务器时间+8位随机码作为部分文件名，确保文件名无重复。
			SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyyMMddHHmmssS"); 
			imgName = simpleDateFormat.format(new Date());
			Random random = new Random();
			String randomCode = "";
			for ( int i = 0; i < 8; i++ )
			{
				randomCode += Integer.toString(random.nextInt(36), 36);
			}
			imgName += randomCode;
			
			handleImg(__source, imgName, TYPE_SOURCE, result);
			handleImg(__avatar1, imgName, TYPE_128, result);
			handleImg(__avatar2, imgName, TYPE_64, result);
			handleImg(__avatar3, imgName, TYPE_32, result);
			
			user.setIcon(imgName);
			int affectNum = DBService.getInstance().getUserMap().updateUser(user);
			if(affectNum > 0)
			{
				result.success = true;
				result.msg = "形象传输成功!";
			}
			else
			{
				result.msg = "更新数据库用户形象失败!";
			}
		}
		String jsonStr = JSON.toJSONString(result);
		ActionContext.getContext().put("result", jsonStr);
		
		return "success";
	}
	
	public File get__source()
	{
		return __source;
	}

	public void set__source(File __source)
	{
		this.__source = __source;
	}

	public String get__sourceContentType()
	{
		return __sourceContentType;
	}

	public void set__sourceContentType(String __sourceContentType)
	{
		this.__sourceContentType = __sourceContentType;
	}

	public String get__sourceFileName()
	{
		return __sourceFileName;
	}

	public void set__sourceFileName(String __sourceFileName)
	{
		this.__sourceFileName = __sourceFileName;
	}
	
	public File get__avatar1()
	{
		return __avatar1;
	}

	public void set__avatar1(File __avatar1)
	{
		this.__avatar1 = __avatar1;
	}

	public String get__avatar1ContentType()
	{
		return __avatar1ContentType;
	}

	public void set__avatar1ContentType(String __avatar1ContentType)
	{
		this.__avatar1ContentType = __avatar1ContentType;
	}

	public String get__avatar1FileName()
	{
		return __avatar1FileName;
	}

	public void set__avatar1FileName(String __avatar1FileName)
	{
		this.__avatar1FileName = __avatar1FileName;
	}
	
	public File get__avatar2()
	{
		return __avatar2;
	}

	public void set__avatar2(File __avatar2)
	{
		this.__avatar2 = __avatar2;
	}

	public String get__avatar2ContentType()
	{
		return __avatar2ContentType;
	}

	public void set__avatar2ContentType(String __avatar2ContentType)
	{
		this.__avatar2ContentType = __avatar2ContentType;
	}

	public String get__avatar2FileName()
	{
		return __avatar2FileName;
	}

	public void set__avatar2FileName(String __avatar2FileName)
	{
		this.__avatar2FileName = __avatar2FileName;
	}

	public File get__avatar3()
	{
		return __avatar3;
	}

	public void set__avatar3(File __avatar3)
	{
		this.__avatar3 = __avatar3;
	}

	public String get__avatar3ContentType()
	{
		return __avatar3ContentType;
	}

	public void set__avatar3ContentType(String __avatar3ContentType)
	{
		this.__avatar3ContentType = __avatar3ContentType;
	}

	public String get__avatar3FileName()
	{
		return __avatar3FileName;
	}

	public void set__avatar3FileName(String __avatar3FileName)
	{
		this.__avatar3FileName = __avatar3FileName;
	}
	
}
