package com.ht.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ht.dao.StorageMapper;
import com.ht.entity.Storage;
import com.ht.service.interfaces.StorageService;

@Service
public class StorageServiceImpl implements StorageService{

	@Autowired
	private StorageMapper storage;
	
	@Override
	public int deleteByPrimaryKey(Integer sid) {
		return storage.deleteByPrimaryKey(sid);
	}

	@Override
	public int insertSelective(Storage record) {
		return storage.insertSelective(record);
	}

	@Override
	public Storage selectByPrimaryKey(Integer sid) {
		return storage.selectByPrimaryKey(sid);
	}

	@Override
	public List<Storage> queryAll(Map<String, Object> map) {
		return storage.queryAll(map);
	}

	@Override
	public Long queryAllCount(Map<String, Object> map) {
		return storage.queryAllCount(map);
	}

	@Override
	public int updateByPrimaryKeySelective(Storage sto) {
		return storage.updateByPrimaryKeySelective(sto);
	}


}
