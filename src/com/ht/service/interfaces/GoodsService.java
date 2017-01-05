package com.ht.service.interfaces;

import java.util.List;
import java.util.Map;

import com.ht.entity.Goods;

public interface GoodsService {
	/**
	 * 根据id删除订单
	 * @param gid
	 * @return
	 */
    int deleteByPrimaryKey(Integer gid);

    /**
     * 添加订单
     * @param record
     * @return
     */
    int insertSelective(Goods record);

    /**
     * 根据id查询订单
     * @param gid
     * @return
     */
    Goods selectByPrimaryKey(Integer gid);

    /**
     * 根据id修改订单
     * @param record
     * @return
     */
    int updateByPrimaryKeySelective(Goods record);
    
    /**
     * 查询所有订单
     * @param map
     * @return
     */
    List<Goods> queryAll(Map<String, Object> map);
    
    /**
     * 订单总条数
     * @param map
     * @return
     */
    Long queryAllCount(Map<String, Object> map);
    
    /**
     * 每月的货物揽收量
     * @param map
     * @return
     */
    Long monthGoodCount(Map<String, Object> map);
}
