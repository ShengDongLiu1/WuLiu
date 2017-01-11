package com.ht.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.ht.entity.Customer;
import com.ht.entity.sysuser;
/**
 * 客户Dao接口
 * @author LJP
 *
 */
public interface CustomerMapper {
	
    int insertSelective(Customer record);

    public Customer klogin1(String cemail, String cpassword);
     
    /**客户登录
	 * @param cemail 用户名
	 * @param cpassword 用户密码
	 * @return sysuser
	 */
	sysuser klogin(@Param("cemail")String cemail,@Param("cpassword") String cpassword);

	Customer klogin1(Map<String, Object> map);
	
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
	 * 邮箱匹配
	 * @param email
	 * @return
	 */
	public int checkEmail(String cemail);
	
	/**
	 * 邮箱匹配2
	 * @param email
	 * @return
	 */
	public int checkEmail2(Customer customer);
	
	/**
	 * 手机号码匹配
	 * @param cphone
	 * @return
	 */
	public int checkCphone(String cphone);
	
	/**
	 * 手机号码匹配2
	 * @param customer
	 * @return
	 */
	public int checkCphone2(Customer customer);
	
	/**
	 * 删除客户
	 * @param id
	 * @return
	 */
	public int delete(Integer id);

	/**
	 * 修改客户更新客户资料
	 * @param cid
	 * @return
	 */
	Customer select(int cid);
	
	int updateUserPwd(Customer customer);
	
	
}