package forum.cute.bean;

import java.util.Date;

public class ReplyBean
{
	public int getId()
	{
		return id;
	}
	public void setId(int id)
	{
		this.id = id;
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
	public int getFloor()
	{
		return floor;
	}
	public void setFloor(int floor)
	{
		this.floor = floor;
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
	public Date getReplyTime()
	{
		return replyTime;
	}
	public void setReplyTime(Date replyTime)
	{
		this.replyTime = replyTime;
	}
	
	private int id;
	private int topicId;
	private String content;
	private int author;
	private int floor;
	private int replyFloor;
	private int replyUser;
	private Date replyTime;
	
	public String toString()
	{
		return "{ReplyBean}id="+id+" topicId="+topicId+" author="+author+" floor="+floor+" replyFloor="+replyFloor+" replyTime="+replyTime+" content="+content;
	}
	
	
}
