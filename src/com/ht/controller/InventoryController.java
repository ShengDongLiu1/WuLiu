package com.ht.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.alibaba.fastjson.JSONObject;
import com.ht.dto.PageBean;
import com.ht.dto.StringUtil;
import com.ht.entity.Inventory;
import com.ht.service.interfaces.InventoryService;
import com.ht.ssm.util.ResponseUtil;

import net.sf.json.JSONArray;

@Controller
@RequestMapping("/inventory")
public class InventoryController {
	@Autowired
	public InventoryService inventoryService;
	
	@RequestMapping(value="/all")
	public String topageStorage(){
		return "Inventory/Inventory";
	}
	
	@RequestMapping(value="/allInve",method=RequestMethod.GET)
	public String select(@RequestParam(value="page",required=false)String page,@RequestParam(value="rows",required=false)String rows,HttpServletResponse response) throws Exception{
		PageBean pageBean=null;
		if(page == null && rows == null){
			pageBean=new PageBean(1,10);
		}else{
			pageBean=new PageBean(Integer.parseInt(page),Integer.parseInt(rows));
		}
		Map<String, Object> map= new HashMap<>();
		map.put("logid", StringUtil.formatLike(""));
		map.put("loname", StringUtil.formatLike(""));
		map.put("losize", StringUtil.formatLike(""));
		map.put("lovolume", StringUtil.formatLike(""));
		map.put("loweight", StringUtil.formatLike(""));
		map.put("lolevel", StringUtil.formatLike(""));
		map.put("lostate", StringUtil.formatLike(""));
		map.put("start", pageBean.getStart());
		map.put("size", pageBean.getPageSize());
		List<Inventory> list=inventoryService.select(map);//查询所有数据
		Long total=inventoryService.queryAllCount(map);	//查询总条数
		JSONObject result = new JSONObject();
		JSONArray jsonArray = JSONArray.fromObject(list);
		result.put("rows", jsonArray);
		result.put("total", total);
		ResponseUtil.write(response, result);
		System.out.println("list:"+jsonArray);
		return null;
	}
}
