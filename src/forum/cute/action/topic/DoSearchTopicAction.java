package forum.cute.action.topic;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.opensymphony.xwork2.ActionContext;

import forum.cute.bean.TopicBean;
import forum.cute.bean.UserBean;
import forum.cute.service.DBService;

public class DoSearchTopicAction
{
	/** 每页容纳主题数 */
	private static final int PAGE_SIZE = 10;
	
	public String keywords;//关键词
	public int section;//所属板块
	public int page=0;
	
	public String execute()
	{
		List<TopicBean> topics;
		String searchPattern = "%"+keywords+"%";
		
		int topicsNum = 0;
		if(section < 0)
		{
			topicsNum = DBService.getInstance().getTopicMap().searchTopicsNum(searchPattern);
		}
		else
		{
			topicsNum = DBService.getInstance().getTopicMap().searchTopicsInSectionNum(section, searchPattern);
		}
		int maxPageInd = (int)Math.floor( (double)(topicsNum-1)/(double)PAGE_SIZE );
		if(maxPageInd < 0) { maxPageInd = 0; }
		if(page < 0) { page = maxPageInd; }
		if(page > maxPageInd) { page = maxPageInd; }
		if(section < 0)
		{
			topics = DBService.getInstance().getTopicMap().searchTopics(searchPattern, page*PAGE_SIZE, PAGE_SIZE);
		}
		else
		{
			topics = DBService.getInstance().getTopicMap().searchTopicsInSection(section, searchPattern, page*PAGE_SIZE, PAGE_SIZE);
		}
		
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
		
		ActionContext.getContext().put("section", section);
		ActionContext.getContext().put("topics", topics);
		ActionContext.getContext().put("topicsNum", topicsNum);
		ActionContext.getContext().put("page", page);
		ActionContext.getContext().put("maxPageInd", maxPageInd);
		ActionContext.getContext().put("userInfos", userInfos);
		ActionContext.getContext().put("replyNums", replyNums);
		
		return "success";
	}
}
