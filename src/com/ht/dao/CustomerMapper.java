package com.ht.dao;

import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.ht.entity.Customer;
import com.ht.entity.sysuser;

public interface CustomerMapper {
    int deleteByPrimaryKey(Integer cid);
    
    int insert(Customer record);
    
    int insertSelective(Customer record);

    public Customer klogin1(String cemail, String cpassword);

    int updateByPrimaryKeySelective(Customer record);

    int updateByPrimaryKey(Customer record);
     
    /**客户登录
	 * @param cemail 用户名
	 * @param cpassword 用户密码
	 * @return sysuser
	 */
	sysuser klogin(@Param("cemail")String cemail,@Param("cpassword") String cpassword);

	Customer klogin1(Map<String, Object> map);
}