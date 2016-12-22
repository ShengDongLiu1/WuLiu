package com.ht.service.interfaces;

import java.util.List;
import java.util.Map;

import com.ht.entity.Storage;

public interface StorageService {
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

    /**
     * 修改库位
     * @param map
     * @return
     */
	int updateByPrimaryKeySelective(Storage storage);


}
