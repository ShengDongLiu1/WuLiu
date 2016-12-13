package com.ht.service.interfaces;

import java.util.List;

import com.ht.entity.Sysfunction;
import com.ht.entity.Sysrole;

public interface RoleService {

	/** 查询出所有的role，提供给用户选择
     * @return list
     */
	List<Sysrole> listAll();

	/** 根据id查找用户信息
	 * @param roleid 用户的id
	 * @return Sysrole
	 */
	Sysrole findbyid(Integer roleid);

	/** 更新角色信息
	 * @param sysrole 
	 * @return
	 */
	int updateRole(Sysrole sysrole);

	/**增加角色
	 * @param sysrole
	 * @return
	 */
	int saverole(Sysrole sysrole);

	/**搜索用户信息
	 * @param rolename
	 * @return
	 */
	List<Sysrole> listbyrolename(String rolename);

	/**权限页面的跳转
	 * @return
	 */
	List<Sysfunction> initfunlist(int roleid);

	/**保存用户的权限信息
	 * @param roleid
	 * @param funids
	 * @return
	 */
	Integer saveright(int roleid, Integer[] funids);

	
	
}
