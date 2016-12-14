package com.ht.service.impl;

import java.util.List;

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
	public List<Inventory> select() {
		return inventoryMapper.select();
	}
	
}
