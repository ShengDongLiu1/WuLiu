package com.ht.dao;

import java.util.List;
import java.util.Map;

import com.ht.entity.Quality;
/**
 * 质检管理Dao
 * @author 黄豪
 *
 */
public interface QualityMapper {

	int qualityAdd(Quality quality);
	
	Quality qualitySelect(int id);
	
	List<Quality> qualitySelectAll(Map<String, Object> map);
	
	int qualityDelete(int id);
	
	int qualityUpdate(Quality quality);
	
	Long getTotal(Map<String, Object> map);
}
