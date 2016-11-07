package forum.cute.mapper;

import org.apache.ibatis.annotations.Param;

import forum.cute.bean.UserBean;

public interface UserMapper
{
	UserBean selectUserById(int id);
	
	UserBean selectUserByAccount(String account);
	
	UserBean selectUserByName(String name);
	
	int createUser(@Param("p_account")String account, @Param("p_password")String password, 
			@Param("p_name")String name, @Param("p_gender")int gender, @Param("p_desc")String desc);
	
	int updateUser(UserBean user);
}
