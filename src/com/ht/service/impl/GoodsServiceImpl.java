package com.ht.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ht.dao.GoodsMapper;
import com.ht.entity.Goods;
import com.ht.service.interfaces.GoodsService;

@Service
public class GoodsServiceImpl implements GoodsService{

	@Autowired
	private GoodsMapper goods;
	
	@Override
	public int deleteByPrimaryKey(Integer gid) {
		return goods.deleteByPrimaryKey(gid);
	}

	@Override
	public int insertSelective(Goods record) {
		return goods.insertSelective(record);
	}

	@Override
	public Goods selectByPrimaryKey(Integer gid) {
		return goods.selectByPrimaryKey(gid);
	}

	@Override
	public int updateByPrimaryKeySelective(Goods record) {
		return goods.updateByPrimaryKeySelective(record);
	}

	@Override
	public List<Goods> queryAll(Map<String, Object> map) {
		return goods.queryAll(map);
	}

	@Override
	public Long queryAllCount(Map<String, Object> map) {
		return goods.queryAllCount(map);
	}

}
