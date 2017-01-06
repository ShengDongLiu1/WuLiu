package com.ht.service.interfaces;

import java.util.List;

import com.ht.entity.sysuser;

public interface UserService {

	/**用户登录
	 * @param username 用户名
	 * @param userpwd 密码
	 * @return sysuser
	 */
	sysuser login(String username, String userpwd);

	/**列出所有的用户，除了超级管理员
	 * @return
	 */
	List<sysuser> selectAllUser();

	sysuser selectByPrimaryKey(Integer userid);

	/** 更新用户信息
	 * @param sysuser
	 * @return
	 */
	int updateUser(sysuser sysuser);

	/** 保存用户信息
	 * @param sysuser
	 * @return
	 */
	int saveuser(sysuser sysuser);

	/** 查看用户名是否存在
	 * @param username 用户名
	 * @return sysuser
	 */
	sysuser findbyusername(String username);

	/**根据用户id删除用户
	 * @param userid
	 * @return
	 */
	int delete(Integer userid);

	/** 根据用户名查看用户信息
	 * @param username 用户名
	 * @return
	 */
	List<sysuser> searchbyusername(String username);
	
	/** 根据用户员工编码查看是否存在这个用户
	 * @param ujobnumber 员工编码
	 * @return
	 */
	sysuser selectujobnumber(String ujobnumber);
}
