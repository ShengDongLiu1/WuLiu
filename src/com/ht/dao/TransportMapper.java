package com.ht.dao;

import com.ht.entity.Transport;

public interface TransportMapper {
    int deleteByPrimaryKey(Integer tid);

    int insert(Transport record);

    int insertSelective(Transport record);

    Transport selectByPrimaryKey(Integer tid);

    int updateByPrimaryKeySelective(Transport record);

    int updateByPrimaryKey(Transport record);
}