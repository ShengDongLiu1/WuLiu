package com.ht.service.interfaces;

import java.util.List;

import com.ht.entity.Sysfunction;

public interface FunctionService {

	/**列出所有的功能
	 * @return list
	 */
	List<Sysfunction> listAll();

	/**列出所有的功能
	 * @param funname 功能名称
	 * @return
	 */
	List<Sysfunction> selectByFunName(String funname);

	/**按id查找功能信息
	 * @param id
	 * @return
	 */
	Sysfunction selectByid(int id);

	/**更新功能
	 * @param sysfunction
	 * @return
	 */
	int updateFun(Sysfunction sysfunction);

	/**添加顶层功能
	 * @param sysfunction
	 * @return
	 */
	int addFun(Sysfunction sysfunction);

	/**删除功能
	 * @param id
	 * @return
	 */
	int deletebyid(int id);

}
