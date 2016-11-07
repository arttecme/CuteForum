package forum.cute.action;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import com.opensymphony.xwork2.ActionContext;

import forum.cute.bean.SectionBean;
import forum.cute.bean.TopicBean;
import forum.cute.bean.UserBean;
import forum.cute.service.DBService;

public class MainAction
{
	public String execute()
	{
		ActionContext.getContext().put("debugInfo", "来自MainAction的调试信息");
		
		List<SectionBean> sections = DBService.getInstance().getSectionMap().selectAllSections();
//		sections.add(new SectionBean().build(1001, "水果世界", "这是关于水果世界de详细优雅的介绍", 0));
//		sections.add(new SectionBean().build(1002, "萌漫画", "这是关于萌漫画de详细优雅的介绍", 0));
//		sections.add(new SectionBean().build(1003, "游戏宅", "这是关于游戏宅de详细优雅的介绍", 0));
//		sections.add(new SectionBean().build(1004, "逗B联盟", "这是关于逗B联盟de详细优雅的介绍", 0));
		ActionContext.getContext().put("sections", sections);
		
		Map<Integer, List<TopicBean>> recommends = new HashMap<Integer, List<TopicBean>>();
		Iterator<SectionBean> secIter = sections.iterator();
		Map<Integer, UserBean> userInfos = new HashMap<Integer, UserBean>();
		Map<Integer, Integer> replyNums = new HashMap<Integer, Integer>();
		while(secIter.hasNext())
		{
			SectionBean section = secIter.next();
			List<TopicBean> topics = DBService.getInstance().getTopicMap().selectRecommendTopics(section.getId());
			//System.out.println("section id=" + section.getId() + " topics=" + topics);
			recommends.put(section.getId(), topics);
			
			for(int i = 0; i < topics.size(); i++)
			{
				TopicBean topic = topics.get(i);
				UserBean author = DBService.getInstance().getUserMap().selectUserById(topic.getAuthor());
				userInfos.put(topic.getAuthor(), author);
				Integer rnum = DBService.getInstance().getReplyMap().queryMaxFloor(topic.getId());
				replyNums.put(topic.getId(), rnum);
			}
		}
		ActionContext.getContext().put("recommends", recommends);
		ActionContext.getContext().put("userInfos", userInfos);
		ActionContext.getContext().put("replyNums", replyNums);//每个话题的回帖数
		
		return "success";
	}
}
