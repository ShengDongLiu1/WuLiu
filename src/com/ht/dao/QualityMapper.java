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

	//新增质检记录
	int qualityAdd(Quality quality);
	
	//根据id查询质检记录
	Quality qualitySelect(int eid);
	
	//查询所有质检记录
	List<Quality> qualitySelectAll(Map<String, Object> map);
	
	//根据id删除质检记录
	int qualityDelete(int eid);
	
	//根据id修改质检记录
	int qualityUpdate(Quality quality);
	
	//总质检记录条数
	Long getTotal(Map<String, Object> map);
}
