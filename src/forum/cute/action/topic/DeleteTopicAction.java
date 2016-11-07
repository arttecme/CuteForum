package forum.cute.action.topic;

import com.opensymphony.xwork2.ActionContext;

import forum.cute.bean.BeanKey;
import forum.cute.bean.TopicBean;
import forum.cute.bean.UserBean;
import forum.cute.service.DBService;

public class DeleteTopicAction
{
	public int page;
	public int topicId;
	
	private String toError(String msg)
	{
		ActionContext.getContext().put("errMsg", msg);
		return "error";
	}
	
	public String execute()
	{
		System.out.println("删除之后回到第"+page+"页");
		
		UserBean user = (UserBean)ActionContext.getContext().getSession().get(BeanKey.USER);
		if(user == null)
		{
			return toError("必须登录才能进行操作");
		}
		
		TopicBean topic = DBService.getInstance().getTopicMap().selectTopicById(topicId);
		if(topic==null)
		{
			return toError("该话题不存在");
		}
		
		if(topic.getAuthor() != user.getId())
		{
			return toError("该话题的作者不是你，你不能对其进行删除");
		}
		
		int delTopicNum = DBService.getInstance().getTopicMap().deleteTopic(topicId);
		int delReplyNum = DBService.getInstance().getReplyMap().deleteReplyInTopic(topicId);
		
		ActionContext.getContext().put("page", page);
		ActionContext.getContext().put("delTopicNum", delTopicNum);
		ActionContext.getContext().put("delReplyNum", delReplyNum);
		return "success";
	}
}
