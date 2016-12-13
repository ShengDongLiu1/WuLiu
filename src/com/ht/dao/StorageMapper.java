package com.ht.dao;

import com.ht.entity.Storage;

public interface StorageMapper {
    int deleteByPrimaryKey(Integer sid);

    int insert(Storage record);

    int insertSelective(Storage record);

    Storage selectByPrimaryKey(Integer sid);

    int updateByPrimaryKeySelective(Storage record);

    int updateByPrimaryKey(Storage record);
}