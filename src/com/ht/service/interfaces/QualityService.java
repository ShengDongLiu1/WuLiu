package com.ht.service.interfaces;

import java.util.List;
import java.util.Map;

import com.ht.entity.Quality;

public interface QualityService {

	int qualityAdd(Quality quality);
	
	Quality qualitySelect(int eid);
	
	List<Quality> qualitySelectAll(Map<String, Object> map);
	
	int qualityDelete(int eid);
	
	int qualityUpdate(Quality quality);
	
	Long getTotal(Map<String, Object> map);
}
