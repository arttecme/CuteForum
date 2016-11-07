package forum.cute.bean;

public class SectionBean
{
	
	public int getId()
	{
		return id;
	}
	public void setId(int id)
	{
		this.id = id;
	}
	public String getTitle()
	{
		return title;
	}
	public void setTitle(String title)
	{
		this.title = title;
	}
	public String getDesc()
	{
		return desc;
	}
	public void setDesc(String desc)
	{
		this.desc = desc;
	}
	public int getMaster()
	{
		return master;
	}
	public void setMaster(int master)
	{
		this.master = master;
	}
	
	private int id;
	private String title;
	private String desc;
	private int master;
	
	
	public SectionBean build(int id, String title, String desc, int master)
	{
		this.id = id;
		this.title = title;
		this.desc = desc;
		this.master = master;
		return this;
	}
	
	public String toString()
	{
		return "{SectionBean}id:"+id+" / title:"+title+" / desc:"+desc+" / master:"+master;
	}
}
