package com.ht.dao;

import java.util.List;
import java.util.Map;

import com.ht.entity.Transport;

public interface TransportMapper {
    int deleteByPrimaryKey(Integer tid);

    int insert(Transport record);

    int insertSelective(Transport record);

    Transport selectByPrimaryKey(Integer tid);

    int updateByPrimaryKeySelective(Transport record);

    int updateByPrimaryKey(Transport record);

	List<Transport> select(Map<String, Object> map);

	Long queryAllCount(Map<String, Object> map);

	int treansportAdd(Transport transport);

	int treansportupdate(Transport transport);

	void transportdelete(int parseInt);
}