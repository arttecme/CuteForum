package forum.cute.action.topic;

import java.util.Date;

import com.opensymphony.xwork2.ActionContext;

import forum.cute.bean.TopicBean;
import forum.cute.service.DBService;
import forum.cute.utils.Macro;

public class PublishTopicAction
{
	private String title;
	private int section;
	private String content;
	private int author;
	
	public String execute()
	{
		if(Macro.isInvalid(title)) { return "fail"; }
		if(Macro.isInvalid(content)) { return "fail"; }
		Date now = new Date();
		TopicBean topic = new TopicBean();
		topic.setTitle(title);
		topic.setSection(section);
		topic.setContent(content);
		topic.setAuthor(author);
		topic.setPubTime(now);
		topic.setModTime(now);
		topic.setRecommend(true);
		DBService.getInstance().getTopicMap().createTopic(topic);
		System.out.println("topic="+topic);
		ActionContext.getContext().put("topicId", topic.getId());
		return "success";
	}
	
	public String getTitle()
	{
		return title;
	}

	public void setTitle(String title)
	{
		this.title = title;
	}

	public int getSection()
	{
		return section;
	}

	public void setSection(int section)
	{
		this.section = section;
	}

	public String getContent()
	{
		return content;
	}

	public void setContent(String content)
	{
		this.content = content;
	}

	public int getAuthor()
	{
		return author;
	}

	public void setAuthor(int author)
	{
		this.author = author;
	}
	
}
