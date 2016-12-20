package com.ht.service.interfaces;

import java.util.List;
import java.util.Map;

import com.ht.entity.Transport;

public interface TransportService {

	List<Transport> select(Map<String, Object> map);

	Long queryAllCount(Map<String, Object> map);

	int treansportAdd(Transport transport);

	int treansportupdate(Transport transport);

	void transportdelete(int parseInt);
	
}
