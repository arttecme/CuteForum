package forum.cute.test;

import com.opensymphony.xwork2.ActionContext;

import forum.cute.bean.SectionBean;
import forum.cute.bean.UserBean;
import forum.cute.service.DBService;

public class Tests
{
	public static void testActionContext()
	{
		Object user = ActionContext.getContext().getSession().get("user");
		System.out.println("Test user="+user);
	}
	
	public static void testMyBatis()
	{
		SectionBean section = DBService.getInstance().getSectionMap().selectSectionById(5);
		System.out.println(section);
		UserBean user = DBService.getInstance().getUserMap().selectUserById(1001);
		System.out.println(user);
	}
}
