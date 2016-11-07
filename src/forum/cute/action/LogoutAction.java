package forum.cute.action;

import com.opensymphony.xwork2.ActionContext;

import forum.cute.bean.BeanKey;

public class LogoutAction
{
	/** 执行登出 */
	public static void logout()
	{
		ActionContext.getContext().getSession().remove(BeanKey.USER);
	}
	
	public String execute()
	{
		logout();
		return "success";
	}
}
