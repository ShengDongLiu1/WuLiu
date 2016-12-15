package com.ht.service.interfaces;

import java.util.List;
import java.util.Map;

import com.ht.entity.Inventory;
public interface InventoryService {
	List<Inventory> select(Map<String, Object> map);

	Long queryAllCount(Map<String, Object> map);

	int inventoryAdd(Inventory inventory);

	int inventoryupdate(Inventory inventory);

	void inventorydelete(int parseInt);
	
}
