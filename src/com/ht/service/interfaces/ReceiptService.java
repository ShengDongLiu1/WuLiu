package com.ht.service.interfaces;

import java.util.List;
import java.util.Map;

import com.ht.entity.Receipt;

public interface ReceiptService {
	
	/**
	 * 根据id删除收货单
	 * @param rid
	 * @return
	 */
    int deleteByPrimaryKey(Integer rid);
    
    /**
     * 添加收货单
     * @param record
     * @return
     */
    int insertSelective(Receipt record);
    
    /**
     * 根据id查询收货单
     * @param rid
     * @return
     */
    Receipt selectByPrimaryKey(Integer rid);

    /**
     * 根据id修改收货单
     * @param record
     * @return
     */
    int updateByPrimaryKeySelective(Receipt record);
    
    /**
     * 分页查询收货记录
     * @param map
     * @return
     */
    List<Receipt> queryAll(Map<String, Object> map);
    
    /**
     * 收货总条数
     * @param map
     * @return
     */
    Long queryAllCount(Map<String, Object> map);

}