package forum.cute.action;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.opensymphony.xwork2.ActionContext;

import forum.cute.bean.SectionBean;
import forum.cute.bean.TopicBean;
import forum.cute.bean.UserBean;
import forum.cute.service.DBService;

public class SectionAction
{
	/** 每页容纳主题数 */
	private static final int PAGE_SIZE = 12;
	
	private int id;
	private int page=0;
	
	
	public String execute()
	{
		ActionContext.getContext().put("debugInfo", "来自SectionAction的调试信息id="+id+" page="+page);
		
		int topicsNum = DBService.getInstance().getTopicMap().queryTopicsNum(id);
		int maxPageInd = (int)Math.floor( (double)(topicsNum-1)/(double)PAGE_SIZE );
		if(maxPageInd < 0) { maxPageInd = 0; }
		if(page < 0) { page = maxPageInd; }
		if(page > maxPageInd) { page = maxPageInd; }
		List<TopicBean> topics = DBService.getInstance().getTopicMap().selectPageTopics(id, page*PAGE_SIZE, PAGE_SIZE);
		
		Map<Integer, UserBean> userInfos = new HashMap<Integer, UserBean>();
		Map<Integer, Integer> replyNums = new HashMap<Integer, Integer>();
		for(int i = 0; i < topics.size(); i++)
		{
			TopicBean topic = topics.get(i);
			UserBean author = DBService.getInstance().getUserMap().selectUserById(topic.getAuthor());
			userInfos.put(topic.getAuthor(), author);
			Integer rnum = DBService.getInstance().getReplyMap().queryMaxFloor(topic.getId());
			replyNums.put(topic.getId(), rnum);
		}
		
		SectionBean section = DBService.getInstance().getSectionMap().selectSectionById(id);
		
		//System.out.println("检索出来的本页数据：" + topics);
		ActionContext.getContext().put("section", section);
		ActionContext.getContext().put("topics", topics);
		ActionContext.getContext().put("topicsNum", topicsNum);
		ActionContext.getContext().put("page", page);
		ActionContext.getContext().put("maxPageInd", maxPageInd);
		ActionContext.getContext().put("userInfos", userInfos);
		ActionContext.getContext().put("replyNums", replyNums);
		
		return "success";
	}

	public int getId()
	{
		return id;
	}

	public void setId(int id)
	{
		this.id = id;
	}

	public int getPage()
	{
		return page;
	}

	public void setPage(int page)
	{
		this.page = page;
	}
}
