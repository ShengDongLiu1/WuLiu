package com.ht.service.interfaces;

import java.util.List;
import java.util.Map;

import com.ht.entity.Transfer;

public interface TransferService {

	List<Transfer> select(Map<String, Object> map);

	Long queryAllCount(Map<String, Object> map);
	
}
