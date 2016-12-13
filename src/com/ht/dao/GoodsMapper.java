package com.ht.dao;

import com.ht.entity.Goods;

public interface GoodsMapper {
    int deleteByPrimaryKey(Integer sid);

    int insert(Goods record);

    int insertSelective(Goods record);

    Goods selectByPrimaryKey(Integer sid);

    int updateByPrimaryKeySelective(Goods record);

    int updateByPrimaryKey(Goods record);
}