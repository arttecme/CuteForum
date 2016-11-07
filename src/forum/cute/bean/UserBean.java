package forum.cute.bean;

import forum.cute.define.UserDefine;

public class UserBean
{
	
	public int getId()
	{
		return id;
	}
	public void setId(int id)
	{
		this.id = id;
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
	public String getIcon()
	{
		return icon;
	}
	public void setIcon(String icon)
	{
		this.icon = icon;
	}
	public String getDesc()
	{
		return desc;
	}
	public void setDesc(String desc)
	{
		this.desc = desc;
	}
	
	private int id;
	private String account;
	private String password;
	private String name = UserDefine.DEAULT_NAME;
	private int gender;
	private String icon;
	private String desc;
	
	public String toString()
	{
		return "[UserBean]id="+id+" account="+account+" password="+password+" name="+name+" gender="+gender+" icon="+icon+" desc="+desc;
	}
}
