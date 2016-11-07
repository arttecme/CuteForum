package forum.cute.service;

import java.io.IOException;
import java.io.InputStream;
import java.util.Timer;
import java.util.TimerTask;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import forum.cute.mapper.ReplyMapper;
import forum.cute.mapper.SectionMapper;
import forum.cute.mapper.TopicMapper;
import forum.cute.mapper.UserMapper;

public class DBService
{	
	private SqlSessionFactory sessionFac;
	private SqlSession session;
	
	private SectionMapper sectionMap;
	public SectionMapper getSectionMap()
	{
		return sectionMap;
	}
	
	private UserMapper userMap;
	public UserMapper getUserMap()
	{
		return userMap;
	}
	
	private TopicMapper topicMap;
	public TopicMapper getTopicMap()
	{
		return topicMap;
	}
	
	private ReplyMapper replyMap;
	public ReplyMapper getReplyMap()
	{
		return replyMap;
	}
	
	private DBService()
	{
		String resource = "mybatis-config.xml";
		InputStream ips;
		try
		{
			ips = Resources.getResourceAsStream(resource);
			sessionFac = new SqlSessionFactoryBuilder().build(ips,"development");
			retrieveSessionAndMap();
			keepLiving();
		}
		catch (IOException e)
		{
			e.printStackTrace();
		}
	}
	
	/** 获取会话 */
	private void retrieveSessionAndMap()
	{
		if(session != null)
		{
			session.clearCache();
			session.close();
		}
		session = sessionFac.openSession();
		
		sectionMap = session.getMapper(SectionMapper.class);
		userMap = session.getMapper(UserMapper.class);
		topicMap = session.getMapper(TopicMapper.class);
		replyMap = session.getMapper(ReplyMapper.class);
	}
	
	/** MySQL连接超过8小时就是timeout
	 * 定时重新获取一下会话连接 */
	private void keepLiving()
	{
		Timer timer = new Timer();
		TimerTask task = new TimerTask()
		{
			@Override
			public void run()
			{
				//System.out.println("重新获取一下会话连接");
				retrieveSessionAndMap();
			}
		};
		timer.scheduleAtFixedRate(task, 3000, 3600000);//每小时激活一次
	}
	
	private static class DBServiceHolder
	{
		private static DBService instance = new DBService();
	}
	
	public static DBService getInstance()
	{
		return DBServiceHolder.instance;
	}

}
