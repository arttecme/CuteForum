package forum.cute.action;

import com.opensymphony.xwork2.ActionContext;

import forum.cute.bean.BeanKey;
import forum.cute.bean.UserBean;
import forum.cute.service.DBService;
import forum.cute.utils.Macro;

public class LoginAction
{
	/** 登录成功 */
	private static final String EC_SUCCESS = "success";
	/** 帐号为空 */
	private static final String EC_ACCOUNT_EMPTY = "account_empty";
	/** 密码为空 */
	private static final String EC_PASSWORD_EMPTY = "password_empty";
	/** 帐号不存在 */
	private static final String EC_ACCOUNT_NULL = "account_null";
	/** 密码错误 */
	private static final String EC_PASSWORD_ERROR = "password_error";
	
	private String account;
	private String password;
	
	/** 执行登录 */
	public static void login(UserBean user)
	{
		ActionContext.getContext().getSession().put(BeanKey.USER, user);
	}
	
	private String result(String errorCode)
	{
		ActionContext.getContext().put("errorCode", errorCode);
		return "success";
	}
	
	public String execute()
	{
		if( Macro.isInvalid(account) )
		{
			return result(EC_ACCOUNT_EMPTY);
		}
		if( Macro.isInvalid(password) )
		{
			return result(EC_PASSWORD_EMPTY);
		}
		UserBean user = DBService.getInstance().getUserMap().selectUserByAccount(account);
		if(user != null)
		{
			if(password.equals(user.getPassword()))
			{
				login(user);
				return result(EC_SUCCESS);
			}
			else
			{
				return result(EC_PASSWORD_ERROR);
			}
		}
		else
		{
			return result(EC_ACCOUNT_NULL);
		}
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
	
}
