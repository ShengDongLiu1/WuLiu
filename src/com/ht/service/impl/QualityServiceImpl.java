package com.ht.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ht.dao.QualityMapper;
import com.ht.entity.Quality;
import com.ht.entity.Receipt;
import com.ht.entity.Thelibrary;
import com.ht.service.interfaces.QualityService;

/**
 * 质检管理Service实现类
 * @author 黄豪
 *
 */

@Service
public class QualityServiceImpl implements QualityService {

	@Autowired
	private QualityMapper qualityMapper;
	
	@Override
	public int qualityAdd(Quality quality) {
		// TODO Auto-generated method stub
		return qualityMapper.qualityAdd(quality);
	}

	@Override
	public Quality qualitySelect(Integer eid) {
		// TODO Auto-generated method stub
		return qualityMapper.qualitySelect(eid);
	}

	@Override
	public List<Quality> qualitySelectAll(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return qualityMapper.qualitySelectAll(map);
	}

	@Override
	public Integer qualityDelete(Integer eid) {
		// TODO Auto-generated method stub
		return qualityMapper.qualityDelete(eid);
	}

	@Override
	public Integer qualityUpdate(Quality quality) {
		// TODO Auto-generated method stub
		return qualityMapper.qualityUpdate(quality);
	}

	@Override
	public Long getTotal(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return qualityMapper.getTotal(map);
	}

	@Override
	public Integer receiptUpdate(Receipt receipt) {
		return qualityMapper.receiptUpdate(receipt);
	}

	@Override
	public int queryByTid() {
		return qualityMapper.queryByTid();
	}

	@Override
	public List<Quality> qualitySelectAll2(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return qualityMapper.qualitySelectAll2(map);
	}

	@Override
	public Long getTotal2(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return qualityMapper.getTotal2(map);
	}

	@Override
	public Quality qualitySelect2(int eid) {
		return qualityMapper.qualitySelect2(eid);
	}

	@Override
	public Integer thelibraryUpdate(Thelibrary thelibrary) {
		// TODO Auto-generated method stub
		return qualityMapper.thelibraryUpdate(thelibrary);
	}

	@Override
	public List<Quality> qualitySelectAll3(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return qualityMapper.qualitySelectAll3(map);
	}

	@Override
	public Long getTotal3(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return qualityMapper.getTotal3(map);
	}

}
