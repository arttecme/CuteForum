package forum.cute.action.user;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

import com.opensymphony.xwork2.ActionContext;

import forum.cute.bean.BeanKey;
import forum.cute.bean.UserBean;
import forum.cute.service.DBService;
import forum.cute.utils.Macro;

public class UserModifyAction
{
	private String name;
	private int gender;
	private String desc;
	private String password;
	private String icon;
	
	private String toFail(String errorMsg)
	{
		try
		{
			ActionContext.getContext().put("errorMsg", URLEncoder.encode(errorMsg, "UTF-8"));
		}
		catch (UnsupportedEncodingException e)
		{
			e.printStackTrace();
		}
		return "fail";
	}
	
	private String toError(String msg)
	{
		ActionContext.getContext().put("errMsg", msg);
		return "error";
	}
	
	/** 更新个人信息 */
	public String updateInfo()
	{
		UserBean user = (UserBean)ActionContext.getContext().getSession().get(BeanKey.USER);
		if(user==null)
		{
			return toError("必须登录之后再进行操作");
		}
		System.out.println("新值name"+name+" gender="+gender+" desc="+desc);
		
		if(user.getName().equals(name))
		{
			//并不修改名字
		}
		else
		{
			UserBean tmp = DBService.getInstance().getUserMap().selectUserByName(name);
			if(tmp != null && tmp.getId() != user.getId())
			{
				return toFail("该昵称已存在");
			}
			user.setName(name);
		}
		
		user.setGender(gender);
		user.setDesc(desc);
		
		int affectNum = DBService.getInstance().getUserMap().updateUser(user);
		
		System.out.println("updateInfo更新影响数："+affectNum+" ==="+user);
		return "info";
	}
	
	/** 更新安全信息 */
	public String updateSafe()
	{
		UserBean user = (UserBean)ActionContext.getContext().getSession().get(BeanKey.USER);
		if(user==null)
		{
			return toError("必须登录之后再进行操作");
		}
		if(Macro.isInvalid(password))
		{
			return toFail("密码不能为空!");
		}
		if(password.length() < 6)
		{
			return toFail("密码不能少于6位!");
		}
		if(password.length() > 16)
		{
			return toFail("密码不能多于16位!");
		}
		
		user.setPassword(password);
		
		int affectNum = DBService.getInstance().getUserMap().updateUser(user);
		System.out.println("updateSafe更新影响数："+affectNum+" ==="+user);
		
		return "safe";
	}
	
	/** 更新形象信息 */
	public String updateImage()
	{
		return "image";
	}
	
	
	public String getName()
	{
		return name;
	}

	public void setName(String name)
	{
		this.name = name;
	}

	public int getGender()
	{
		return gender;
	}

	public void setGender(int gender)
	{
		this.gender = gender;
	}

	public String getDesc()
	{
		return desc;
	}

	public void setDesc(String desc)
	{
		this.desc = desc;
	}

	public String getPassword()
	{
		return password;
	}

	public void setPassword(String password)
	{
		this.password = password;
	}

	public String getIcon()
	{
		return icon;
	}

	public void setIcon(String icon)
	{
		this.icon = icon;
	}
	
}
