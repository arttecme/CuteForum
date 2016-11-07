package forum.cute.action.topic;

import java.util.Date;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionContext;

import forum.cute.bean.ReplyBean;
import forum.cute.service.DBService;

public class ReplyTopicAction
{
	private int topicId;
	private String content;
	private int author;
	private int replyFloor;
	private int replyUser;
	
	public String execute()
	{
		ReplyBean reply = new ReplyBean();
		reply.setTopicId(topicId);
		reply.setContent(content);
		reply.setAuthor(author);
		reply.setReplyFloor(replyFloor);
		reply.setReplyUser(replyUser);
		reply.setReplyTime(new Date());
		
		int curNum = DBService.getInstance().getReplyMap().queryMaxFloor(topicId);
		System.out.println("当前总回复数" + curNum);
		reply.setFloor(curNum+1);
		DBService.getInstance().getReplyMap().createReply(reply);
		
		ActionContext.getContext().put("topicId", topicId);
		ActionContext.getContext().put("page", -1);
		
		return "success";
	}
	
	public int getTopicId()
	{
		return topicId;
	}

	public void setTopicId(int topicId)
	{
		this.topicId = topicId;
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

	public int getReplyFloor()
	{
		return replyFloor;
	}

	public void setReplyFloor(int replyFloor)
	{
		this.replyFloor = replyFloor;
	}

	public int getReplyUser()
	{
		return replyUser;
	}

	public void setReplyUser(int replyUser)
	{
		this.replyUser = replyUser;
	}
	
}
