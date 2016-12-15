package com.ht.service.impl;

import java.util.List;
import java.util.Map;

import com.ht.dao.QualityMapper;
import com.ht.entity.Quality;
import com.ht.service.interfaces.QualityService;

/**
 * 质检管理Service实现类
 * @author 黄豪
 *
 */
public class QualityServiceImpl implements QualityService {

	private QualityMapper qualityMapper;
	
	@Override
	public Quality qualitySelect(int id) {
		// TODO Auto-generated method stub
		return qualityMapper.qualitySelect(id);
	}

	@Override
	public List<Quality> qualitySelectAll(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return qualityMapper.qualitySelectAll(map);
	}

	@Override
	public Long getTotal(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return qualityMapper.getTotal(map);
	}

}
