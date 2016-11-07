package forum.cute.define;

import forum.cute.bean.UserBean;
import forum.cute.utils.Macro;

public class UserImg
{
	public static final String SAVE_PATH = "/upload/user/img/";
	
	public static final String TYPE_SOURCE = "src";
	public static final String TYPE_128 = "128";
	public static final String TYPE_64 = "64";
	public static final String TYPE_32 = "32";
	
	public static String toFileName(String imgName, String type)
	{
		if(TYPE_SOURCE.equals(type))
		{
			return imgName + "_" + TYPE_SOURCE + ".png";
		}
		else if(TYPE_128.equals(type))
		{
			return imgName + "_" + TYPE_128 + ".jpg";
		}
		else if(TYPE_64.equals(type))
		{
			return imgName + "_" + TYPE_64 + ".jpg";
		}
		else if(TYPE_32.equals(type))
		{
			return imgName + "_" + TYPE_32 + ".jpg";
		}
		return "ErrorFileName";
	}
	
	/** 获取用户头像（type不支持SOURCE） */
	public static String getUserImgFile(UserBean user, String type)
	{
		if(user==null || Macro.isInvalid(user.getIcon()))
		{
			return "/static/img/user/user_img_"+type+".jpg";
		}
		return SAVE_PATH + toFileName(user.getIcon(), type);
	}
	
}
