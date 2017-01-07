package com.ht.service.interfaces;

import java.util.List;
import java.util.Map;

import com.ht.entity.Complaints;

public interface ComplaintsService {

	 /**
     * 新增投诉
     * @param map
     * @return
     */
	void insertSelective(Complaints complaints);

	 /**
     * 查询所有投诉
     * @param map
     * @return
     */
	List<Complaints> select(Map<String, Object> map);
	
	 /**
     * 查询投诉总条数
     * @param map
     * @return
     */
	Long queryAllCount(Map<String, Object> map);
	
}
