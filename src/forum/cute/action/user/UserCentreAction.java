package forum.cute.action.user;

import com.opensymphony.xwork2.ActionContext;

public class UserCentreAction
{
	
	public String go()
	{
		return goInfo();
	}
	
	public String goInfo()
	{
		return "info";
	}
	
	public String goSafe()
	{
		return "safe";
	}
	
	public String goImage()
	{
		return "image";
	}
	
}
