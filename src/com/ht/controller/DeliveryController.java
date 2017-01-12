package com.ht.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ht.dto.PageBean;
import com.ht.dto.StringUtil;
import com.ht.entity.Thelibrary;
import com.ht.entity.sysuser;
import com.ht.service.interfaces.ThelibraryService;
import com.ht.ssm.util.ResponseUtil;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
@RequestMapping("/delivery")
public class DeliveryController {
	@Autowired
	private ThelibraryService thelibraryService;
	
	
	@RequestMapping("/chaxun")
	public String delivery(){
		return "delivery/deliverys";
	}
	
	
	@RequestMapping("/notshipped")
	public String notshipped(){
		return "rack/notsipped";  
	}
	
	@RequestMapping("/wancheng")
	public String wancheng(){
		return "delivery/complete";
	}
	
	@RequestMapping("/lists")
	public String list(@RequestParam(value="page",required=false)String page,@RequestParam(value="rows",required=false)String rows, HttpSession session,Thelibrary thelibaray,HttpServletResponse response,String gname, String  cname,String tnumber)throws Exception{
		PageBean pageBean=new PageBean(Integer.parseInt(page),Integer.parseInt(rows));
		Map<String,Object> map=new HashMap<String,Object>();
		map.put("cname", StringUtil.formatLike(cname));
		map.put("gname", StringUtil.formatLike(gname));
		map.put("tnumber",StringUtil.formatLike(tnumber));
		map.put("start", pageBean.getStart());
		map.put("size", pageBean.getPageSize());
		List<Thelibrary> thelibrarylist =thelibraryService.queryTrack(map);
		for(Thelibrary t : thelibrarylist){
			t.setGorderstime1(t.getGoods().getGorderstime());
		}
		Long total=thelibraryService.queryAllCount3(map);
		JSONObject result=new JSONObject();
		JSONArray jsonArray=JSONArray.fromObject(thelibrarylist);
		result.put("rows", jsonArray);
		result.put("total", total);
		ResponseUtil.write(response, result);
		return null;
	}
	
	
	@RequestMapping("/lists2")
	public String list2(@RequestParam(value="page",required=false)String page,@RequestParam(value="rows",required=false)String rows, HttpSession session,Thelibrary thelibaray,HttpServletResponse response,String gname, String  cname,String tnumber,HttpServletRequest request)throws Exception{
		PageBean pageBean=new PageBean(Integer.parseInt(page),Integer.parseInt(rows));
		sysuser existsysuser = (sysuser)session.getAttribute("user");
		System.out.println(existsysuser.getUsername()+"=======================");
		Map<String,Object> map=new HashMap<String,Object>();
		map.put("username",existsysuser.getUsername());
		map.put("cname", StringUtil.formatLike(cname));
		map.put("gname", StringUtil.formatLike(gname));
		map.put("tnumber",StringUtil.formatLike(tnumber));
		map.put("start", pageBean.getStart());
		map.put("size", pageBean.getPageSize());
		List<Thelibrary> thelibrarylist =thelibraryService.queryTrack2(map);
		for(Thelibrary t : thelibrarylist){
			t.setGorderstime1(t.getGoods().getGorderstime());
		}
		Long total=thelibraryService.queryAllCount4(map);
		JSONObject result=new JSONObject();
		JSONArray jsonArray=JSONArray.fromObject(thelibrarylist);
		result.put("rows", jsonArray);
		result.put("total", total);
		ResponseUtil.write(response, result);
		return null;
	}
	
	@RequestMapping("/peisong")
	@ResponseBody
	public String peisong(Thelibrary thelibrary,HttpServletResponse response) throws Exception{
		int resultTotal=0; // 操作的记录条数
		JSONObject result = new JSONObject();
		if(thelibrary.getTid()!=null){
			thelibrary.setTstate(4);
			resultTotal = thelibraryService.updateByPrimaryKeySelective(thelibrary);
		}
		if(resultTotal>0){
			result.put("success", true);
		}else{
			result.put("success", false);
		}
		ResponseUtil.write(response, result);
		
		return null;
	}
	
	
	
	@RequestMapping("/wanchengs")
	@ResponseBody
	public String wancheng(Thelibrary thelibrary,HttpServletResponse response) throws Exception{
		int resultTotal=0; // 操作的记录条数
		JSONObject result = new JSONObject();
		if(thelibrary.getTid()!=null){
			thelibrary.setTstate(5);
			resultTotal = thelibraryService.updateByPrimaryKeySelective(thelibrary);
		}
		if(resultTotal>0){
			result.put("success", true);
		}else{
			result.put("success", false);
		}
		ResponseUtil.write(response, result);
		
		return null;
	}

}
