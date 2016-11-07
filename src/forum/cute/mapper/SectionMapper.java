package forum.cute.mapper;

import java.util.List;

import forum.cute.bean.SectionBean;

public interface SectionMapper
{
	SectionBean selectSectionById(int id);
	
	List<SectionBean> selectAllSections();
}
