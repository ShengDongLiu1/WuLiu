package com.ht.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.ht.entity.sysuser;

public interface sysuserMapper {
    int deleteByPrimaryKey(Integer userid);

    int insert(sysuser record);

    int insertSelective(sysuser record);

    sysuser selectByPrimaryKey(Integer userid);

    int updateByPrimaryKeySelective(sysuser record);

    int updateByPrimaryKey(sysuser record);

	/**用户登录
	 * @param username 用户名
	 * @param userpwd 用户密码
	 * @return sysuser
	 */
	sysuser login(@Param("username")String username,@Param("userpwd") String userpwd);

	
	/**列出所有的用户，除了超级管理员
	 * @param model
	 * @return
	 */
	List<sysuser> selectAllUser();

	/**查看用户名是否重复
	 * @param username 用户名
	 * @return
	 */
	sysuser findbyusername(String username);

	/** 根据用户名查看用户信息
	 * @param username 用户名
	 * @return
	 */
	List<sysuser> searchbyusername(String username);
	
    
}