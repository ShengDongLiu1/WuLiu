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

	List<Inventory> selectInveGoods(Integer loid);

	Inventory selectByPrimaryKey(Integer loid);

	void updataInveState1(Integer loid);

	void updataInveState2(Integer loid);
	
	/**
	 * 库位列表
	 * @param map
	 * @return
	 */
	List<Inventory> selectKwGoods(Map<String, Object> map);

	/**
	 * 库位个数
	 * @param map
	 * @return
	 */
	Long selectKwGoodsCount(Map<String, Object> map);
	
}
