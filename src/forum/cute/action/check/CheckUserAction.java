package forum.cute.action.check;

import com.opensymphony.xwork2.ActionContext;

import forum.cute.bean.UserBean;
import forum.cute.service.DBService;
import forum.cute.utils.Macro;

public class CheckUserAction
{
	/** 空 */
	private static final String EC_EMPTY = "empty";
	/** 可用 */
	private static final String EC_AVAILABLE = "available";
	/** 已存在 */
	private static final String EC_EXIST = "exist";
	
	private String account;
	private String name;
	
	/** 检查账户名 */
	public String check_account()
	{
		if( Macro.isInvalid(account) )
		{
			ActionContext.getContext().put("errorCode", EC_EMPTY);
		}
		else
		{
			UserBean user = DBService.getInstance().getUserMap().selectUserByAccount(account);
			if(user == null)
			{
				ActionContext.getContext().put("errorCode", EC_AVAILABLE);
			}
			else
			{
				ActionContext.getContext().put("errorCode", EC_EXIST);
			}
		}
		return "success";
	}
	
	/** 检查昵称 */
	public String check_name()
	{
		if( Macro.isInvalid(name) )
		{
			ActionContext.getContext().put("errorCode", EC_EMPTY);
		}
		else
		{
			UserBean user = DBService.getInstance().getUserMap().selectUserByName(name);
			if(user == null)
			{
				ActionContext.getContext().put("errorCode", EC_AVAILABLE);
			}
			else
			{
				ActionContext.getContext().put("errorCode", EC_EXIST);
			}
		}
		return "success";
	}

	public String getAccount()
	{
		return account;
	}

	public void setAccount(String account)
	{
		this.account = account;
	}

	public String getName()
	{
		return name;
	}

	public void setName(String name)
	{
		this.name = name;
	}
}
