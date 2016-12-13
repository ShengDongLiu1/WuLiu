package com.ht.dao;

import com.ht.entity.Costtype;

public interface CosttypeMapper {
    int deleteByPrimaryKey(Integer cid);

    int insert(Costtype record);

    int insertSelective(Costtype record);

    Costtype selectByPrimaryKey(Integer cid);

    int updateByPrimaryKeySelective(Costtype record);

    int updateByPrimaryKey(Costtype record);
}