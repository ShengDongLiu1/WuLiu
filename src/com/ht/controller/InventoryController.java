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
import com.ht.entity.Test;
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
	public String select(@RequestParam(value="gname",required=false)String gname,@RequestParam(value="loname",required=false)String loname,@RequestParam(value="lolevel",required=false)String lolevel,@RequestParam(value="lostate",required=false)String lostate,@RequestParam(value="page",required=false)String page,@RequestParam(value="rows",required=false)String rows,HttpServletResponse response) throws Exception{
		PageBean pageBean=new PageBean(Integer.parseInt(page),Integer.parseInt(rows));
		Map<String, Object> map= new HashMap<>();
		map.put("gname", StringUtil.formatLike(gname));
		map.put("loname", StringUtil.formatLike(loname));
		map.put("lolevel", StringUtil.formatLike(lolevel));
		map.put("lostate", StringUtil.formatLike(lostate));
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
	
	
	@RequestMapping("/save")
	public String save(Inventory inventory,HttpServletResponse res) throws Exception{
		int resultTotal = 0;
        if (inventory.getLoid() == null) {
            resultTotal = inventoryService.inventoryAdd(inventory);
        }else{
            resultTotal = inventoryService.inventoryupdate(inventory);
        }
        JSONObject jsonObject = new JSONObject();
        if(resultTotal > 0){   //说明修改或添加成功
            jsonObject.put("success", true);
        }else{
            jsonObject.put("success", false);
        }
        ResponseUtil.write(res, jsonObject);
        return null;
	}
	
	@RequestMapping("/delete")
	public String delete(@RequestParam(value="ids") String ids,HttpServletResponse res) throws Exception{
		String[] idStr = ids.split(",");
        JSONObject jsonObject = new JSONObject();
        for (String id : idStr) {
        	inventoryService.inventorydelete(Integer.parseInt(id));
        }
        jsonObject.put("success", true);
        ResponseUtil.write(res, jsonObject);
        return null;
	}
}
