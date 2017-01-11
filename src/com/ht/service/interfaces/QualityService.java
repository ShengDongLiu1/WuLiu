package com.ht.service.interfaces;

import java.util.List;
import java.util.Map;

import com.ht.entity.Quality;
import com.ht.entity.Receipt;
import com.ht.entity.Thelibrary;

public interface QualityService {

	int qualityAdd(Quality quality);
	
	Quality qualitySelect(Integer eid);
	
	List<Quality> qualitySelectAll(Map<String, Object> map);
	
	Integer qualityDelete(Integer eid);
	
	Integer qualityUpdate(Quality quality);
	
	Long getTotal(Map<String, Object> map);
	
	//根据id修改收货单记录
	Integer receiptUpdate(Receipt receipt);
	
	int queryByTid();
	
	//查询所有质检记录
	List<Quality> qualitySelectAll2(Map<String, Object> map);
	
	//总质检记录条数
	Long getTotal2(Map<String, Object> map);
	
	//根据id查询质检记录
	Quality qualitySelect2(int eid);
	
	//根据id修改出库表记录
	Integer thelibraryUpdate(Thelibrary thelibrary);
	
	//查询所有质检记录
	List<Quality> qualitySelectAll3(Map<String, Object> map);
	
	//总质检记录条数
	Long getTotal3(Map<String, Object> map);
}
