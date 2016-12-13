package com.ht.dao;

import com.ht.entity.Receipt;

public interface ReceiptMapper {
    int deleteByPrimaryKey(Integer rid);

    int insert(Receipt record);

    int insertSelective(Receipt record);

    Receipt selectByPrimaryKey(Integer rid);

    int updateByPrimaryKeySelective(Receipt record);

    int updateByPrimaryKey(Receipt record);
}