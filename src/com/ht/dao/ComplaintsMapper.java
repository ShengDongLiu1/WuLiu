package com.ht.dao;

import java.util.List;
import java.util.Map;

import com.ht.entity.Complaints;

public interface ComplaintsMapper {
    int deleteByPrimaryKey(Integer comid);

    int insert(Complaints record);

    int insertSelective(Complaints record);

    Complaints selectByPrimaryKey(Integer comid);

    int updateByPrimaryKeySelective(Complaints record);

    int updateByPrimaryKey(Complaints record);

	List<Complaints> select(Map<String, Object> map);

	Long queryAllCount(Map<String, Object> map);
}