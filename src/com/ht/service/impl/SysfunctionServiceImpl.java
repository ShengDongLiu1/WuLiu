package com.ht.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ht.dao.SysfunctionMapper;
import com.ht.entity.Sysfunction;
import com.ht.entity.sysuser;
import com.ht.service.interfaces.SysfunctionService;

@Service
public class SysfunctionServiceImpl implements SysfunctionService {
	
	@Autowired
	private SysfunctionMapper sysfunctionMapper;

	@Override
	public List<Sysfunction> initfunction(sysuser existsysuser) {
		
		return sysfunctionMapper.initfunction(existsysuser);
	}

}
