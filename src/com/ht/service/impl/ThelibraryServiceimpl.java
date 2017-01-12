package com.ht.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ht.dao.ThelibraryMapper;
import com.ht.entity.Thelibrary;
import com.ht.service.interfaces.ThelibraryService;

@Service
public class ThelibraryServiceimpl implements ThelibraryService{
		
	@Autowired
	private  ThelibraryMapper thelibraryMapper;


	@Override
	public int insert(Thelibrary record) {
		return thelibraryMapper.insert(record);
	}


	@Override
	public int deleteByPrimaryKey(Integer tid) {
		return 0;
	}


	@Override
	public int insertSelective(Thelibrary record) {
		// TODO Auto-generated method stub
		return 0;
	}


	@Override
	public Thelibrary selectByPrimaryKey(Integer tid) {
		return thelibraryMapper.selectByPrimaryKey(tid);
	}


	@Override
	public int updateByPrimaryKeySelective(Thelibrary record) {
		return thelibraryMapper.updateByPrimaryKeySelective(record);
	}


	@Override
	public int updateByPrimaryKey(Thelibrary record) {
		return thelibraryMapper.updateByPrimaryKey(record);
	}


	@Override
	public List<Thelibrary> queryAll(Map<String, Object> map) {
		return thelibraryMapper.queryAll(map);
	}


	@Override
	public Long queryAllCount(Map<String, Object> map) {
		return thelibraryMapper.queryAllCount(map);
	}


	@Override
	public List<Thelibrary> queryAll2(Map<String, Object> map) {
		return thelibraryMapper.queryAll2(map);
	}


	@Override
	public Long queryAllCount2(Map<String, Object> map) {
		return thelibraryMapper.queryAllCount2(map);
	}


	@Override
	public Thelibrary queryById(Integer tid) {
		return thelibraryMapper.queryById(tid);
	}


	@Override
	public List<Thelibrary> queryTrack(Map<String, Object> map) {
		return thelibraryMapper.queryTrack(map);
	}


	@Override
	public List<Thelibrary> queryTrack2(Map<String, Object> map) {
		return thelibraryMapper.queryTrack2(map);
	}


	@Override
	public Long queryAllCount3(Map<String, Object> map) {
		return thelibraryMapper.queryAllCount3(map);
	}

	@Override
	public Long queryAllCount4(Map<String, Object> map) {
		return thelibraryMapper.queryAllCount4(map);
	}

	
	
	
}
