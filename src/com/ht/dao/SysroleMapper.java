package com.ht.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.ht.entity.Sysfunction;
import com.ht.entity.Sysrole;

public interface SysroleMapper {
    int deleteByPrimaryKey(Integer roleid);

    int insert(Sysrole record);

    int insertSelective(Sysrole record);

    Sysrole selectByPrimaryKey(Integer roleid);

    int updateByPrimaryKeySelective(Sysrole record);

    int updateByPrimaryKey(Sysrole record);
    
    /** 查询出所有的role，提供给用户选择
     * @return list
     */
    List<Sysrole> listAll();

	/**搜索角色信息
	 * @param rolename
	 * @return
	 */
	List<Sysrole> searchbyrolename(String rolename);

	/**权限页面的跳转
	 * @return
	 */
	List<Sysfunction> initfunlist(int roleid);
	
	/**根据该角色的roleid，删除对应的 role - function关系
	 * @param roleid
	 * @return
	 */
	int deleteright(Integer roleid);
	
	/**储存权限信息
	 * @param roleid 要存储角色的id
	 * @param funids 功能角色id
	 * @return
	 */
	int saveright(@Param("roleid")Integer roleid,@Param("funids") Integer[] funids);
    
}