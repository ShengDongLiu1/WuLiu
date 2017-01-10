package com.ht.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ht.dao.ComplaintsMapper;
import com.ht.entity.Complaints;
import com.ht.service.interfaces.ComplaintsService;

@Service
public class ComplaintsServiceImpl implements ComplaintsService{

	@Autowired
	private ComplaintsMapper complaintsMapper;
	@Override
	public void insertSelective(Complaints complaints) {
		complaintsMapper.insertSelective(complaints);
		
	}
	@Override
	public List<Complaints> select(Map<String, Object> map) {
		return complaintsMapper.select(map);
	}
	@Override
	public Long queryAllCount(Map<String, Object> map) {
		return complaintsMapper.queryAllCount(map);
	}
	@Override
	public int updateByPrimaryKeySelective(Complaints complaints) {
		return complaintsMapper.updateByPrimaryKeySelective(complaints);
	}

}
