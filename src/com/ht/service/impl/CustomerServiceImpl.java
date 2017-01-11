package com.ht.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ht.dao.CustomerMapper;
import com.ht.entity.Customer;
import com.ht.service.interfaces.CustomerService;

@Service("CustomerService")
public class CustomerServiceImpl implements CustomerService{
	
	@Autowired
	private CustomerMapper customerMapper;

	@Override
	public Customer klogin1(Map<String, Object> map) {
		return customerMapper.klogin1(map);
	}
	@Override
	public int insertSelective(Customer customer) {
		return customerMapper.insertSelective(customer);
	}
	
	@Override
	public List<Customer> find(Map<String, Object> map) {
		return customerMapper.find(map);
	}
	@Override
	public Long getTotal(Map<String, Object> map) {
		return customerMapper.getTotal(map);
	}
	@Override
	public int add(Customer customer) {
		return customerMapper.add(customer);
	}

	@Override
	public int delete(Integer id) {
		return customerMapper.delete(id);
	}
	@Override
	public int update(Customer customer) {
		return customerMapper.update(customer);
	}
	@Override
	public Customer select(int cid) {
		return customerMapper.select(cid);
	}
	@Override
	public int updateUserPwd(Customer customer) {
		return customerMapper.updateUserPwd(customer);
	}
	@Override
	public int checkEmail(String email) {
		return customerMapper.checkEmail(email);
	}
	@Override
	public int checkCphone(String cphone) {
		return customerMapper.checkCphone(cphone);
	}
}
