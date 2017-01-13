package com.ht.controller;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ht.entity.Transportdetails;
import com.ht.service.interfaces.TransportdetailsService;
import com.ht.ssm.util.ResponseUtil;

import net.sf.json.JSONObject;

@Controller
@RequestMapping("/transportd")
public class TransportdetailsController {
	

	@Autowired
	private TransportdetailsService TransportdetailsService;
	
	
	
	@RequestMapping("/save")
	@ResponseBody
	public String save(Transportdetails transportdetails,HttpServletResponse response)throws Exception{
		int resultTotal=0; // 操作的记录条数
		JSONObject result=new JSONObject();
		resultTotal=TransportdetailsService.insertSelective(transportdetails);
		if(resultTotal>0){
			result.put("success", true);
		}else{
			result.put("success", false);
		}
		ResponseUtil.write(response, result);
		return null;
	}
}
