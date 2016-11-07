package forum.cute.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import forum.cute.bean.ReplyBean;

public interface ReplyMapper
{
	ReplyBean selectReplyById(int id);
	
	List<ReplyBean> selectPageReplies(@Param("topicId")int topicId, @Param("ind_from")int indFrom, @Param("page_size")int pageSize);
	
	int queryMaxFloor(int topicId);
	
	int createReply(ReplyBean reply);
	
	int deleteReplyInTopic(int topicId);
}
