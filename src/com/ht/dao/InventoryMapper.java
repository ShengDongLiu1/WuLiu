package com.ht.dao;

import com.ht.entity.Inventory;

public interface InventoryMapper {
    int deleteByPrimaryKey(Integer loid);

    int insert(Inventory record);

    int insertSelective(Inventory record);

    Inventory selectByPrimaryKey(Integer loid);

    int updateByPrimaryKeySelective(Inventory record);

    int updateByPrimaryKey(Inventory record);
}