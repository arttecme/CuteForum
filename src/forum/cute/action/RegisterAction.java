package forum.cute.action;

import com.opensymphony.xwork2.ActionContext;

import forum.cute.bean.BeanKey;
import forum.cute.bean.UserBean;
import forum.cute.service.DBService;
import forum.cute.utils.Macro;

public class RegisterAction
{
	private String type;//动作类型 提交注册/打开注册页面
	
	private String account;
	private String password;
	private String name;
	private int gender;
	private String desc;
	
	private String fail(String errorMsg)
	{
		ActionContext.getContext().put("errorMsg", errorMsg);
		return "fail";
	}
	
	public String execute()
	{
		if( Macro.isInvalid(type) )
		{
			return "fill";
		}
		
		System.out.println("RegisterAction: account="+account+" password="+password+" name="+name+" gender="+gender+" desc="+desc);
		//account检查
		if( Macro.isInvalid(account) )
		{
			return fail("帐号不能为空哟！");
		}
		else
		{
			UserBean user = DBService.getInstance().getUserMap().selectUserByAccount(account);
			if(user != null)
			{
				return fail("该帐号已被别人抢先注册了哟！");
			}
		}
		//name检查
		if( Macro.isInvalid(name) )
		{
			return fail("昵称不能为空哟！");
		}
		else
		{
			UserBean user = DBService.getInstance().getUserMap().selectUserByName(name);
			if(user != null)
			{
				return fail("该昵称已被别人抢先注册了哟！");
			}
		}
		//
		DBService.getInstance().getUserMap().createUser(account, password, name, gender, desc);
		UserBean user = DBService.getInstance().getUserMap().selectUserByAccount(account);
		if(user == null)
		{
			return fail("数据库插入失败，请联系管理员！");
		}
		ActionContext.getContext().getSession().put(BeanKey.USER, user);
		
		return "success";
	}

	public String getType()
	{
		return type;
	}

	public void setType(String type)
	{
		this.type = type;
	}
	
	public String getAccount()
	{
		return account;
	}

	public void setAccount(String account)
	{
		this.account = account;
	}

	public String getPassword()
	{
		return password;
	}

	public void setPassword(String password)
	{
		this.password = password;
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
}
