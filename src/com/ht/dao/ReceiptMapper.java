package com.ht.dao;

import com.ht.entity.Receipt;

public interface ReceiptMapper {
	
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

}