package com.ht.service.interfaces;

import com.ht.entity.Complaints;

public interface ComplaintsService {

	 /**
     * 新增投诉
     * @param map
     * @return
     */
	void insertSelective(Complaints complaints);
	
}
