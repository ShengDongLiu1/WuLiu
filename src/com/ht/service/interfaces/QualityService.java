package com.ht.service.interfaces;

import java.util.List;
import java.util.Map;

import com.ht.entity.Quality;
import com.ht.entity.Receipt;

public interface QualityService {

	int qualityAdd(Quality quality);
	
	Quality qualitySelect(Integer eid);
	
	List<Quality> qualitySelectAll(Map<String, Object> map);
	
	Integer qualityDelete(Integer eid);
	
	Integer qualityUpdate(Quality quality);
	
	Long getTotal(Map<String, Object> map);
	
	//查询收货表的状态
	Receipt receiptStatus(Integer rid);
}
