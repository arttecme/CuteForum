package forum.cute.action.user;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.opensymphony.xwork2.ActionContext;

import forum.cute.bean.BeanKey;
import forum.cute.bean.TopicBean;
import forum.cute.bean.UserBean;
import forum.cute.service.DBService;

public class MyTopicsAction
{
	private static final int PAGE_SIZE = 12;
	
	public int page = 0;
	
	private String toError(String msg)
	{
		ActionContext.getContext().put("errMsg", msg);
		return "error";
	}
	
	public String execute()
	{
		UserBean user = (UserBean)ActionContext.getContext().getSession().get(BeanKey.USER);
		if(user == null)
		{
			return toError("你需要先登录!");
		}
		int author = user.getId();
		int topicsNum = DBService.getInstance().getTopicMap().queryMyTopicsNum(author);
		int maxPageInd = (int)Math.floor( (double)(topicsNum-1)/(double)PAGE_SIZE );
		if(maxPageInd < 0) { maxPageInd = 0; }
		if(page < 0) { page = maxPageInd; }
		if(page > maxPageInd) { page = maxPageInd; }
		List<TopicBean> topics = DBService.getInstance().getTopicMap().selectMyPageTopics(author, page*PAGE_SIZE, PAGE_SIZE);
		Map<Integer, Integer> replyNums = new HashMap<Integer, Integer>();
		for(int i = 0; i < topics.size(); i++)
		{
			TopicBean topic = topics.get(i);
			Integer rnum = DBService.getInstance().getReplyMap().queryMaxFloor(topic.getId());
			replyNums.put(topic.getId(), rnum);
		}
		ActionContext.getContext().put("topics", topics);
		ActionContext.getContext().put("topicsNum", topicsNum);
		ActionContext.getContext().put("page", page);
		ActionContext.getContext().put("maxPageInd", maxPageInd);
		ActionContext.getContext().put("replyNums", replyNums);
		return "success";
	}
}
