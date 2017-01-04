package com.ht.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.ht.dto.PageBean;
import com.ht.dto.StringUtil;
import com.ht.entity.Customer;
import com.ht.entity.Thelibrary;
import com.ht.service.interfaces.ThelibraryService;
import com.ht.ssm.util.ResponseUtil;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
@RequestMapping("/track")
public class TrackController {
	@Autowired
	private ThelibraryService thelibraryService;
	
	
	@RequestMapping("/delivery")
	public String delivery(){
		return "track/delivery";
	}
	
	
	@RequestMapping("/list")
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
		Long total=thelibraryService.queryAllCount2(map);
		JSONObject result=new JSONObject();
		JSONArray jsonArray=JSONArray.fromObject(thelibrarylist);
		result.put("rows", jsonArray);
		result.put("total", total);
		ResponseUtil.write(response, result);
		return null;
	}

}
