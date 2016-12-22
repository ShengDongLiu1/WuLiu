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
	
	//根据id修改收货单记录
	Integer receiptUpdate(Receipt receipt);
}
