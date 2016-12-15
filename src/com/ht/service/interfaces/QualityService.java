package com.ht.service.interfaces;

import java.util.List;
import java.util.Map;

import com.ht.entity.Quality;

public interface QualityService {

	Quality qualitySelect(int id);
	
	List<Quality> qualitySelectAll(Map<String, Object> map);
	
	Long getTotal(Map<String, Object> map);
}
