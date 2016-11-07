package forum.cute.action.user;

import java.util.List;

import com.opensymphony.xwork2.ActionContext;

import forum.cute.bean.TopicBean;
import forum.cute.bean.UserBean;
import forum.cute.service.DBService;

public class UserSpaceAction
{
	private static final int PAGE_SIZE = 8;
	
	public int page = 0;
	public int userId;
	
	private String toError(String msg)
	{
		ActionContext.getContext().put("errMsg", msg);
		return "error";
	}
	
	public String execute()
	{
		System.out.println("UserSpaceAction:userId="+userId);
		
		UserBean host = DBService.getInstance().getUserMap().selectUserById(userId);
		if(host == null)
		{
			return toError("空间请求无效,这个用户并不存在");
		}
		
		int topicsNum = DBService.getInstance().getTopicMap().queryMyTopicsNum(userId);
		int maxPageInd = (int)Math.floor( (double)(topicsNum-1)/(double)PAGE_SIZE );
		if(maxPageInd < 0) { maxPageInd = 0; }
		if(page < 0) { page = maxPageInd; }
		if(page > maxPageInd) { page = maxPageInd; }
		List<TopicBean> topics = DBService.getInstance().getTopicMap().selectMyPageTopics(userId, page*PAGE_SIZE, PAGE_SIZE);
		
		ActionContext.getContext().put("host", host);
		ActionContext.getContext().put("topics", topics);
		ActionContext.getContext().put("topicsNum", topicsNum);
		ActionContext.getContext().put("page", page);
		ActionContext.getContext().put("maxPageInd", maxPageInd);
		
		return "success";
	}

}
