package com.ht.dao;

import java.util.List;
import java.util.Map;

import com.ht.entity.Inventory;
public interface InventoryMapper {
    int deleteByPrimaryKey(Integer loid);

    int insert(Inventory record);

    int insertSelective(Inventory record);

    Inventory selectByPrimaryKey(Integer loid);

    int updateByPrimaryKeySelective(Inventory record);

    int updateByPrimaryKey(Inventory record);

	List<Inventory> select(Map<String, Object> map);

	Long queryAllCount(Map<String, Object> map);

	int inventoryAdd(Inventory inventory);

	int inventoryupdate(Inventory inventory);

	void inventorydelete(int parseInt);

	List<Inventory> selectInveGoods(Integer loid);

	void updataInveState2(Integer loid);

	void updataInveState1(Integer loid);
}