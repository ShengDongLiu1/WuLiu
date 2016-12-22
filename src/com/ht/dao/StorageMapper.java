package com.ht.dao;

import java.util.List;
import java.util.Map;

import com.ht.entity.Storage;

public interface StorageMapper {
	/**
	 * 根据id删除
	 * @param sid
	 * @return
	 */
    int deleteByPrimaryKey(Integer sid);

    /**
     * 添加入库信息
     * @param record
     * @return
     */
    int insertSelective(Storage record);

    /**
     * 根据id查询入库信息
     * @param sid
     * @return
     */
    Storage selectByPrimaryKey(Integer sid);

    /**
     * 根据id修改信息
     * @param record
     * @return
     */
    int updateByPrimaryKeySelective(Storage record);
    
    /**
     * 分页查询入库记录
     * @param map
     * @return
     */
    List<Storage> queryAll(Map<String, Object> map);
    
    /**
     * 入库总条数
     * @param map
     * @return
     */
    Long queryAllCount(Map<String, Object> map);

	
}