package com.ht.service.interfaces;

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
}
