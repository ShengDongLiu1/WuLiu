package com.ht.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ht.dao.TransportdetailsMapper;
import com.ht.entity.Transportdetails;
import com.ht.service.interfaces.TransportdetailsService;

@Service
public class TransportdetailsServiceImpl implements TransportdetailsService{

	
	@Autowired
	private  TransportdetailsMapper transportdetailsMapper;
	
	
	@Override
	public int deleteByPrimaryKey(Integer shid) {
		return transportdetailsMapper.deleteByPrimaryKey(shid);
	}

	@Override
	public int insert(Transportdetails transportd) {
		return transportdetailsMapper.insert(transportd);
	}

	@Override
	public int insertSelective(Transportdetails transportd) {
		return transportdetailsMapper.insertSelective(transportd);
	}

	@Override
	public Transportdetails selectByPrimaryKey(Integer tid) {
		return transportdetailsMapper.selectByPrimaryKey(tid);
	}

	@Override
	public int updateByPrimaryKeySelective(Transportdetails transportd) {
		return transportdetailsMapper.updateByPrimaryKeySelective(transportd);
	}

	@Override
	public int updateByPrimaryKey(Transportdetails transportd) {
		return transportdetailsMapper.updateByPrimaryKey(transportd);
	}

	@Override
	public List<Transportdetails> queryAll(Map<String, Object> map) {
		return transportdetailsMapper.queryAll(map);
	}

	@Override
	public Long queryAllCount(Map<String, Object> map) {
		return transportdetailsMapper.queryAllCount(map);
	}

	@Override
	public Transportdetails queryById(Integer shid) {
		return transportdetailsMapper.queryById(shid);
	}
	
}
