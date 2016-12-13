package com.ht.dao;

import com.ht.entity.Thelibrary;

public interface ThelibraryMapper {
    int deleteByPrimaryKey(Integer tid);

    int insert(Thelibrary record);

    int insertSelective(Thelibrary record);

    Thelibrary selectByPrimaryKey(Integer tid);

    int updateByPrimaryKeySelective(Thelibrary record);

    int updateByPrimaryKey(Thelibrary record);
}