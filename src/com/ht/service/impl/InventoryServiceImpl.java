package com.ht.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ht.dao.InventoryMapper;
import com.ht.entity.Inventory;
import com.ht.service.interfaces.InventoryService;

@Service
public class InventoryServiceImpl implements InventoryService{
	@Autowired
	private InventoryMapper inventoryMapper;
	
	
	@Override
	public List<Inventory> select(Map<String, Object> map) {
		return inventoryMapper.select(map);
	}

	@Override
	public Long queryAllCount(Map<String, Object> map) {
		
		return inventoryMapper.queryAllCount(map);
	}

	@Override
	public int inventoryAdd(Inventory inventory) {
		return inventoryMapper.inventoryAdd(inventory);
	}

	@Override
	public int inventoryupdate(Inventory inventory) {
		return inventoryMapper.inventoryupdate(inventory);
	}

	@Override
	public void inventorydelete(int parseInt) {
		inventoryMapper.inventorydelete(parseInt);
	}

	@Override
	public List<Inventory> selectInveGoods(Integer loid) {
		return inventoryMapper.selectInveGoods(loid);
	}

	@Override
	public Inventory selectByPrimaryKey(Integer loid) {
		return inventoryMapper.selectByPrimaryKey(loid);
	}

	@Override
	public void updataInveState1(Integer loid) {
		inventoryMapper.updataInveState1(loid);
		
	}

	@Override
	public void updataInveState2(Integer loid) {
		inventoryMapper.updataInveState2(loid);
		
	}

	
}
