package com.ht.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ht.dao.sysuserMapper;
import com.ht.entity.sysuser;
import com.ht.service.interfaces.UserService;
@Service
public class UserServiceImpl implements UserService{

	@Autowired
	private sysuserMapper sysuserMapper;
	
	@Override
	public sysuser login(String username, String userpwd) {
		
		return sysuserMapper.login(username,userpwd);
	}

	@Override
	public List<sysuser> selectAllUser() {
		
		return sysuserMapper.selectAllUser();
	}

	@Override
	public sysuser selectByPrimaryKey(Integer userid) {
		
		return sysuserMapper.selectByPrimaryKey(userid);
	}

	@Override
	public int updateUser(sysuser sysuser) {
		
		return sysuserMapper.updateByPrimaryKey(sysuser);
	}

	@Override
	public int saveuser(sysuser sysuser) {
	
		return sysuserMapper.insert(sysuser);
	}

	@Override
	public sysuser findbyusername(String username) {
		
		return sysuserMapper.findbyusername(username);
	}

	@Override
	public int delete(Integer userid) {
		
		return sysuserMapper.deleteByPrimaryKey(userid);
	}

	@Override
	public List<sysuser> searchbyusername(String username) {
		
		return sysuserMapper.searchbyusername(username);
	}

	@Override
	public sysuser selectujobnumber(String ujobnumber) {
		return sysuserMapper.selectujobnumber(ujobnumber);
	}
}
