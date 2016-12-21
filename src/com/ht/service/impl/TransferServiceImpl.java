package com.ht.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ht.dao.TransferMapper;
import com.ht.entity.Transfer;
import com.ht.service.interfaces.TransferService;
@Service
public class TransferServiceImpl implements TransferService{
	@Autowired
	private TransferMapper transferMapper;
	@Override
	public List<Transfer> select(Map<String, Object> map) {
		return transferMapper.select(map);
	}

	@Override
	public Long queryAllCount(Map<String, Object> map) {
		return transferMapper.queryAllCount(map);
	}

}
