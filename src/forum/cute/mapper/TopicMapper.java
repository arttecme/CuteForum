package forum.cute.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import forum.cute.bean.TopicBean;

public interface TopicMapper
{
	TopicBean selectTopicById(int id);
	
	List<TopicBean> selectRecommendTopics(int section);
	
	List<TopicBean> selectPageTopics(@Param("section")int section, @Param("ind_from")int indFrom, @Param("page_size")int pageSize);
	
	List<TopicBean> selectMyPageTopics(@Param("author")int author, @Param("ind_from")int indFrom, @Param("page_size")int pageSize);
	
	int queryTopicsNum(int section);
	
	int queryMyTopicsNum(int author);
	
	int createTopic(TopicBean topic);
	
	int updateTopic(TopicBean topic);
	
	int deleteTopic(int id);
	
	/** 搜索全部板块的话题数量 */
	int searchTopicsNum(@Param("keywords")String keywords);
	/** 搜索指定板块的话题数量 */
	int searchTopicsInSectionNum(@Param("section")int section, @Param("keywords")String keywords);
	/** 搜索全部板块的话题 */
	List<TopicBean> searchTopics(@Param("keywords")String keywords, @Param("ind_from")int indFrom, @Param("page_size")int pageSize);
	/** 搜索指定板块的话题 */
	List<TopicBean> searchTopicsInSection(@Param("section")int section, @Param("keywords")String keywords, @Param("ind_from")int indFrom, @Param("page_size")int pageSize);
}
