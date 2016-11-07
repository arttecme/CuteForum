package forum.cute.action.topic;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import com.opensymphony.xwork2.ActionContext;

import forum.cute.bean.ReplyBean;
import forum.cute.bean.SectionBean;
import forum.cute.bean.TopicBean;
import forum.cute.bean.UserBean;
import forum.cute.define.UserDefine;
import forum.cute.service.DBService;

public class ShowTopicAction
{
	private static final int PAGE_SIZE = 3;
	
	private int topicId;
	private int page;
	
	public String execute()
	{
		System.out.println("ShowTopicAction:topicId="+topicId);
		
		TopicBean topic =  DBService.getInstance().getTopicMap().selectTopicById(topicId);
		if(topic == null) { return "fail"; }
		ActionContext.getContext().put("topic", topic);
		
		UserBean author = DBService.getInstance().getUserMap().selectUserById(topic.getAuthor());
		if(author == null)
		{
			author = new UserBean();
			author.setId(topic.getAuthor());
			author.setName(UserDefine.DEAULT_NAME);
		}
		ActionContext.getContext().put("author", author);
		
		int floorNum = DBService.getInstance().getReplyMap().queryMaxFloor(topicId);
		int maxPageInd = (int)Math.floor(((double)(floorNum-1) / (double)PAGE_SIZE));
		if(maxPageInd < 0) { maxPageInd = 0; }
		if(page < 0) { page = maxPageInd; }
		if(page > maxPageInd) { page = maxPageInd; }
		List<ReplyBean> replies = DBService.getInstance().getReplyMap().selectPageReplies(topicId, page*PAGE_SIZE, PAGE_SIZE);
		ActionContext.getContext().put("replies", replies);
		
		Map<Integer, UserBean> userInfos = new HashMap<Integer, UserBean>();
		Iterator<ReplyBean> repIter = replies.iterator();
		while(repIter.hasNext())
		{
			ReplyBean reply = repIter.next();
			UserBean reviewer = DBService.getInstance().getUserMap().selectUserById(reply.getAuthor());
			userInfos.put(reply.getAuthor(), reviewer);
			UserBean replyUser = DBService.getInstance().getUserMap().selectUserById(reply.getReplyUser());
			userInfos.put(reply.getReplyUser(), replyUser);
		}
		
		SectionBean section = DBService.getInstance().getSectionMap().selectSectionById(topic.getSection());
		
		ActionContext.getContext().put("section", section);//所属板块信息
		ActionContext.getContext().put("userInfos", userInfos);//页面所涉及到的所有用户信息
		ActionContext.getContext().put("page", page);//当前页面序号 from 0
		ActionContext.getContext().put("maxPageInd", maxPageInd);//最大页面序号 from 0
		ActionContext.getContext().put("floorNum", floorNum);//楼层数（即回帖数）
		
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
	
	public int getPage()
	{
		return page;
	}

	public void setPage(int page)
	{
		this.page = page;
	}
	
}
