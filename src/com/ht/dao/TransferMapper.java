package com.ht.dao;

import java.util.List;
import java.util.Map;

import com.ht.entity.Transfer;

public interface TransferMapper {
    int deleteByPrimaryKey(Integer tid);

    int insert(Transfer record);

    int insertSelective(Transfer record);

    Transfer selectByPrimaryKey(Integer tid);

    int updateByPrimaryKeySelective(Transfer record);

    int updateByPrimaryKey(Transfer record);

	List<Transfer> select(Map<String, Object> map);

	Long queryAllCount(Map<String, Object> map);
}