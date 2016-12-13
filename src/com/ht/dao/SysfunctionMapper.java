package com.ht.dao;

import java.util.List;

import com.ht.entity.Sysfunction;
import com.ht.entity.sysuser;

public interface SysfunctionMapper {
    int deleteByPrimaryKey(Integer funid);

    int insert(Sysfunction record);

    int insertSelective(Sysfunction record);

    Sysfunction selectByPrimaryKey(Integer funid);

    int updateByPrimaryKeySelective(Sysfunction record);

    int updateByPrimaryKey(Sysfunction record);

	/**根据登录的用户初始化功能列表
	 * @param existsysuser 登录的用户
	 * @return 页面显示的功能
	 */
	List<Sysfunction> initfunction(sysuser existsysuser);

	/**列出所有的功能
	 * @return list
	 */
	List<Sysfunction> selectAll();

	/**列出所有的功能
	 * @param funname 功能名称
	 * @return list
	 */
	List<Sysfunction> selectByFunName(String funname);

	/**根据父id删除功能
	 * @param funid 父Id
	 * @return
	 */
	int deleteByfunpid(Integer funid);


}