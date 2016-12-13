package com.ht.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ht.dao.SysfunctionMapper;
import com.ht.entity.Sysfunction;
import com.ht.service.interfaces.FunctionService;
@Service
public class FunctionServiceImpl implements FunctionService {

	
	@Autowired
	private SysfunctionMapper sysfunctionMapper;
	
	
	
	@Override
	public List<Sysfunction> listAll() {
		
		return sysfunctionMapper.selectAll();
	}



	@Override
	public List<Sysfunction> selectByFunName(String funname) {
		
		return sysfunctionMapper.selectByFunName(funname);
	}



	@Override
	public Sysfunction selectByid(int id) {
		
		return sysfunctionMapper.selectByPrimaryKey(id);
	}



	@Override
	public int updateFun(Sysfunction sysfunction) {
		
		return sysfunctionMapper.updateByPrimaryKey(sysfunction);
	}



	@Override
	public int addFun(Sysfunction sysfunction) {
		
		return sysfunctionMapper.insert(sysfunction);
	}



	@Override
	public int deletebyid(int id) {
		int count=0;
		
		Sysfunction findsysfunction = sysfunctionMapper.selectByPrimaryKey(id);
		
		if(findsysfunction.getFunpid()==-1){
			
			 count = sysfunctionMapper.deleteByPrimaryKey(findsysfunction.getFunid());
			
			if(count<0){
				
				throw new RuntimeException("删除失败");
			}
			
			count = sysfunctionMapper.deleteByfunpid(findsysfunction.getFunid());
		}else{
			
			 count = sysfunctionMapper.deleteByPrimaryKey(findsysfunction.getFunid());
			
		}
		
		return count;
	}

}
