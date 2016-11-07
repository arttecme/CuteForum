package forum.cute.action.topic;

import java.util.List;

import com.opensymphony.xwork2.ActionContext;

import forum.cute.bean.SectionBean;
import forum.cute.service.DBService;

public class EditTopicAction
{
	public String execute()
	{
		List<SectionBean> sections = DBService.getInstance().getSectionMap().selectAllSections();
		ActionContext.getContext().put("sections", sections);
		return "success";
	}
}
