package com.ht.service.impl;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ht.dao.CustomerMapper;
import com.ht.entity.Customer;
import com.ht.service.interfaces.CustomerService;

@Service
public class CustomerServiceImpl implements CustomerService{
	
	@Autowired
	private CustomerMapper customerMapper;

	@Override
	public Customer klogin1(Map<String, Object> map) {
		return customerMapper.klogin1(map);
	}

}
