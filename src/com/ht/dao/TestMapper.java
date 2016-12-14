package com.ht.dao;

import java.util.List;
import java.util.Map;

import com.ht.entity.Test;

public interface TestMapper {
	
	int testAdd(Test test);
	
	Test testSelect(int id);
	
	List<Test> testSelectAll(Map<String, Object> map);
	
	int testdelete(int id);
	
	int testupdate(Test test);
	
	Long getTotal(Map<String, Object> map);
}
