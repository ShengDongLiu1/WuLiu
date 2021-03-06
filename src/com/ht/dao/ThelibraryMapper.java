package com.ht.dao;

import java.util.List;
import java.util.Map;

import com.ht.entity.Thelibrary;

public interface ThelibraryMapper {
    int deleteByPrimaryKey(Integer tid);

    int insert(Thelibrary record);

    int insertSelective(Thelibrary record);

    Thelibrary selectByPrimaryKey(Integer tid);

    int updateByPrimaryKeySelective(Thelibrary record);

    int updateByPrimaryKey(Thelibrary record);
    
    
    List<Thelibrary> queryAll(Map<String, Object> map);
    
    List<Thelibrary> queryAll2(Map<String, Object> map);
    
    /**
     * 出库单总条数
     * @param map
     * @return
     */
    Long queryAllCount(Map<String, Object> map);
    
    Long queryAllCount2(Map<String, Object> map);
    
    
    Thelibrary queryById(Integer tid);
    
    
    /*
     * 出库单追踪
     */
    List<Thelibrary> queryTrack(Map<String, Object> map);
    
    
    List<Thelibrary> queryTrack2(Map<String, Object> map);
    
    
    /*
     *货物配送总条数 
     */
    Long queryAllCount3(Map<String, Object> map);
    
    /*
     *完成配送总条数 
     */
    Long queryAllCount4(Map<String, Object> map);
    
    
}