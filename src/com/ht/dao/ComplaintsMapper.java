package com.ht.dao;

import com.ht.entity.Complaints;

public interface ComplaintsMapper {
    int deleteByPrimaryKey(Integer comid);

    int insert(Complaints record);

    int insertSelective(Complaints record);

    Complaints selectByPrimaryKey(Integer comid);

    int updateByPrimaryKeySelective(Complaints record);

    int updateByPrimaryKey(Complaints record);
}