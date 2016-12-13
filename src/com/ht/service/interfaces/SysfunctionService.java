package com.ht.service.interfaces;

import java.util.List;

import com.ht.entity.Sysfunction;
import com.ht.entity.sysuser;

public interface SysfunctionService {

	
	/** 
	 * @param existsysuser 登录的用户
	 * @return
	 */
	List<Sysfunction> initfunction(sysuser existsysuser);
	

}
