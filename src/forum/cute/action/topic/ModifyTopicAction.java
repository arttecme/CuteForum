package forum.cute.action.topic;

import java.util.List;

import com.opensymphony.xwork2.ActionContext;

import forum.cute.bean.BeanKey;
import forum.cute.bean.SectionBean;
import forum.cute.bean.TopicBean;
import forum.cute.bean.UserBean;
import forum.cute.service.DBService;

public class ModifyTopicAction
{
	/** 想要修改的话题 */
	public int topicId;
	
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
		
		ActionContext.getContext().put("topic", topic);
		
		List<SectionBean> sections = DBService.getInstance().getSectionMap().selectAllSections();
		ActionContext.getContext().put("sections", sections);
		
		return "success";
	}
}
