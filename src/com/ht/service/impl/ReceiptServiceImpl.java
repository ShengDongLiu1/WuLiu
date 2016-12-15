package com.ht.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ht.dao.ReceiptMapper;
import com.ht.entity.Receipt;
import com.ht.service.interfaces.ReceiptService;

@Service
public class ReceiptServiceImpl implements ReceiptService{
	
	@Autowired
	private ReceiptMapper receipt;
	
	@Override
	public int deleteByPrimaryKey(Integer rid) {
		return receipt.deleteByPrimaryKey(rid);
	}

	@Override
	public int insertSelective(Receipt record) {
		return receipt.insertSelective(record);
	}

	@Override
	public Receipt selectByPrimaryKey(Integer rid) {
		return receipt.selectByPrimaryKey(rid);
	}

	@Override
	public int updateByPrimaryKeySelective(Receipt record) {
		return receipt.updateByPrimaryKeySelective(record);
	}

	@Override
	public List<Receipt> queryAll(Map<String, Object> map) {
		return receipt.queryAll(map);
	}

	@Override
	public Long queryAllCount(Map<String, Object> map) {
		return receipt.queryAllCount(map);
	}

}
