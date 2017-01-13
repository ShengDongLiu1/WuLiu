package com.ht.dao;

import java.util.List;
import java.util.Map;

import com.ht.entity.Transportdetails;

public interface TransportdetailsMapper {
    int deleteByPrimaryKey(Integer shid);

    int insert(Transportdetails transportd);

    int insertSelective(Transportdetails transportd);

    Transportdetails selectByPrimaryKey(Integer tid);

    int updateByPrimaryKeySelective(Transportdetails transportd);

    int updateByPrimaryKey(Transportdetails transportd);
    
    
    List<Transportdetails> queryAll(Map<String, Object> map);
    
    
    Long queryAllCount(Map<String, Object> map);
    
    
    Transportdetails queryById(Integer shid);
    
}