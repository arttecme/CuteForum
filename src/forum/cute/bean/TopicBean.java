package forum.cute.bean;

import java.util.Date;

public class TopicBean
{
	public int getId()
	{
		return id;
	}
	public void setId(int id)
	{
		this.id = id;
	}
	public int getSection()
	{
		return section;
	}
	public void setSection(int section)
	{
		this.section = section;
	}
	public String getTitle()
	{
		return title;
	}
	public void setTitle(String title)
	{
		this.title = title;
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
	public Date getPubTime()
	{
		return pubTime;
	}
	public void setPubTime(Date pubTime)
	{
		this.pubTime = pubTime;
	}
	public Date getModTime()
	{
		return modTime;
	}
	public void setModTime(Date modTime)
	{
		this.modTime = modTime;
	}
	public boolean isRecommend()
	{
		return recommend;
	}
	public void setRecommend(boolean recommend)
	{
		this.recommend = recommend;
	}
	
	private int id;
	private int section;
	private String title;
	private String content;
	private int author;
	private Date pubTime;
	private Date modTime;
	private boolean recommend;
	
	public String toString()
	{
		return "{topic}id="+id+" / section="+section+" / title="+title+" / recommend="+recommend;
	}
}
