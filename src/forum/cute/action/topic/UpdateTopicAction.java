package forum.cute.action.topic;

import java.util.Date;

import com.opensymphony.xwork2.ActionContext;

import forum.cute.bean.BeanKey;
import forum.cute.bean.TopicBean;
import forum.cute.bean.UserBean;
import forum.cute.service.DBService;

public class UpdateTopicAction
{
	public int topicId;
	public String title;
	public int section;
	public String content;
	
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
			return toError("必须登录才能进行操作");
		}
		
		TopicBean topic = DBService.getInstance().getTopicMap().selectTopicById(topicId);
		if(topic==null)
		{
			return toError("该话题不存在");
		}
		
		if(topic.getAuthor() != user.getId())
		{
			return toError("该话题的作者不是你，你不能对其进行修改");
		}
		
		topic.setSection(section);
		topic.setTitle(title);
		topic.setContent(content);
		topic.setModTime(new Date());
		
		DBService.getInstance().getTopicMap().updateTopic(topic);
		
		return "success";
	}
}
