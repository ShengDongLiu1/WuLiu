package com.ht.service.impl;

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

}
