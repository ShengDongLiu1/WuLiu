package com.ht.dao;

import java.util.List;
import java.util.Map;

import com.ht.entity.Quality;
import com.ht.entity.Receipt;
/**
 * 质检管理Dao
 * @author 黄豪
 *
 */
public interface QualityMapper {

	//新增质检记录
	Integer qualityAdd(Quality quality);
	
	//根据id查询质检记录
	Quality qualitySelect(int eid);
	
	//查询所有质检记录
	List<Quality> qualitySelectAll(Map<String, Object> map);
	
	//根据id删除质检记录
	Integer qualityDelete(Integer eid);
	
	//根据id修改质检记录
	Integer qualityUpdate(Quality quality);
	
	//总质检记录条数
	Long getTotal(Map<String, Object> map);
	
	//查询收货表的状态
	Receipt receiptStatus(Integer rid);
}
