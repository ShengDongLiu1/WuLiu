package com.ht.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ht.dao.TransportMapper;
import com.ht.entity.Transport;
import com.ht.service.interfaces.TransportService;
@Service
public class TransportServiceImpl implements TransportService{
	@Autowired
	private TransportMapper transportMapper;
	
	@Override
	public List<Transport> select(Map<String, Object> map) {
		return transportMapper.select(map);
	}

	@Override
	public Long queryAllCount(Map<String, Object> map) {
		return transportMapper.queryAllCount(map);
	}

	@Override
	public int treansportAdd(Transport transport) {
		return transportMapper.treansportAdd(transport);
	}

	@Override
	public int treansportupdate(Transport transport) {
		return transportMapper.treansportupdate(transport);
	}

	@Override
	public void transportdelete(int parseInt) {
		transportMapper.transportdelete(parseInt);
	}
	
}
