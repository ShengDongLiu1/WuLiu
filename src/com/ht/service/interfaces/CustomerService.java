package com.ht.service.interfaces;

import java.util.List;
import java.util.Map;

import com.ht.entity.Customer;

public interface CustomerService {
	
	/**客户登录
	 * @param cemail 用户名
	 * @param cpassword 用户密码
	 * @return sysuser
	 */

	public Customer klogin1(Map<String, Object> map);
	
	/**
	 * 注册
	 * @param record
	 * @return
	 */

	public int insertSelective(Customer customer);
	
	/**
	 * 查询客户集合
	 * @param map
	 * @return
	 */
	public List<Customer> find(Map<String,Object> map);
	
	/**
	 * 获取总记录数
	 * @param map
	 * @return
	 */
	public Long getTotal(Map<String,Object> map);
	
	/**
	 * 添加客户
	 * @param customer
	 * @return
	 */
	public int add(Customer customer);
	
	/**
	 * 修改客户
	 * @param customer
	 * @return
	 */
	public int update(Customer customer);
	
	/**
	 * 删除客户
	 * @param id
	 * @return
	 */
	public int delete(Integer id);

	public Customer select(int cid);

}
