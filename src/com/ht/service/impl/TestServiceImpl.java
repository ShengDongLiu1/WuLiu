package com.ht.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ht.dao.TestMapper;
import com.ht.entity.Test;
import com.ht.service.interfaces.TestService;

@Service
public class TestServiceImpl implements TestService {
	
	@Autowired
	private TestMapper testMapper;
	
	@Override
	public int testAdd(Test test) {
		return testMapper.testAdd(test);
	}

	@Override
	public Test testSelect(int id) {
		return testMapper.testSelect(id);
	}

	@Override
	public List<Test> testSelectAll(Map<String, Object> map) {
		return testMapper.testSelectAll(map);
	}

	@Override
	public int testdelete(int id) {
		return testMapper.testdelete(id);
	}

	@Override
	public int testupdate(Test test) {
		return testMapper.testupdate(test);
	}

	@Override
	public Long getTotal(Map<String, Object> map) {
		return testMapper.getTotal(map);
	}

}
