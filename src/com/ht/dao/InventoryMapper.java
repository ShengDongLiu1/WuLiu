package com.ht.dao;

import java.util.List;

import org.springframework.stereotype.Service;

import com.ht.entity.Inventory;
public interface InventoryMapper {
    int deleteByPrimaryKey(Integer loid);

    int insert(Inventory record);

    int insertSelective(Inventory record);

    Inventory selectByPrimaryKey(Integer loid);

    int updateByPrimaryKeySelective(Inventory record);

    int updateByPrimaryKey(Inventory record);

	List<Inventory> select();
}