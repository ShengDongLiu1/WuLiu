package com.ht.dao;

import com.ht.entity.Unitprice;

public interface UnitpriceMapper {
    int deleteByPrimaryKey(Integer uid);

    int insert(Unitprice record);

    int insertSelective(Unitprice record);

    Unitprice selectByPrimaryKey(Integer uid);

    int updateByPrimaryKeySelective(Unitprice record);

    int updateByPrimaryKey(Unitprice record);
}