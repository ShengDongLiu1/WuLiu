package com.ht.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ht.dao.CosttypeMapper;
import com.ht.entity.Costtype;
import com.ht.service.interfaces.CosttypeService;

@Service
public class CosttypeServiceImpl implements CosttypeService{

	@Autowired
	private CosttypeMapper costtype;
	
	@Override
	public int deleteByPrimaryKey(Integer cid) {
		return costtype.deleteByPrimaryKey(cid);
	}

	@Override
	public int insert(Costtype record) {
		return costtype.insert(record);
	}

	@Override
	public int insertSelective(Costtype record) {
		return costtype.insertSelective(record);
	}

	@Override
	public Costtype selectByPrimaryKey(Integer cid) {
		return costtype.selectByPrimaryKey(cid);
	}

	@Override
	public int updateByPrimaryKeySelective(Costtype record) {
		return costtype.updateByPrimaryKey(record);
	}

	@Override
	public int updateByPrimaryKey(Costtype record) {
		return costtype.updateByPrimaryKey(record);
	}

	@Override
	public List<Costtype> queryAll(Map<String, Object> map) {
		return costtype.queryAll(map);
	}

	@Override
	public Long queryAllCount(Map<String, Object> map) {
		return costtype.queryAllCount(map);
	}

}
