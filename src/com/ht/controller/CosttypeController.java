package com.ht.controller;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.ht.dto.PageBean;
import com.ht.dto.StringUtil;
import com.ht.entity.Costtype;
import com.ht.service.interfaces.CosttypeService;
import com.ht.ssm.util.ResponseUtil;

import net.sf.json.JSONArray;

@Controller
@RequestMapping("/costtype")
public class CosttypeController {
	
	@Autowired
	private CosttypeService costtypeService;
	
	@RequestMapping("/toList")
	public String toPageAll(){
		return "costtype/costtype";
	}
	
	/**
	 * 所有费用类型
	 * @param page
	 * @param rows
	 * @param response
	 * @param cname
	 * @param cprice
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/all")
	public String allCosttype(@RequestParam(value="page",required=false)String page,@RequestParam(value="rows",required=false)String rows,HttpServletResponse response,String cname,BigDecimal cprice) throws Exception{
		PageBean pageBean=new PageBean(Integer.parseInt(page),Integer.parseInt(rows));
		Map<String, Object> map= new HashMap<>();
		map.put("cname", StringUtil.formatLike(cname));
		map.put("cprice", cprice);
		map.put("start", pageBean.getStart());
		map.put("size", pageBean.getPageSize());
		List<Costtype> list=costtypeService.queryAll(map);
		Long total=costtypeService.queryAllCount(map);	//查询总条数
		
		JSONObject result = new JSONObject();
		JSONArray jsonArray = JSONArray.fromObject(list);
		result.put("rows", jsonArray);
		result.put("total", total);
		ResponseUtil.write(response, result);
		return null;
	}
	
	/**
	 * 添加和修改费用类型
	 * @param costtype
	 * @return
	 */
	@RequestMapping(value="/addAndUpdate")
	@ResponseBody
	public Map<String, Object> addCosttype(Costtype costtype){
		Map<String, Object> map= new HashMap<>();
		if(costtype.getCid() == null || costtype.getCid().equals("")){
			if(costtype.getCcid() == null || costtype.getCcid() == 0){//ccid为空表示添加父节点
				costtype.setCcid(-1);
			}
			int resultcount=costtypeService.insert(costtype);
			if(resultcount>0){
				map.put("result", "类型添加成功！");
			}else{
				map.put("result", "类型添加失败，请重试！");
			}
		}else{
			int resultcount=costtypeService.updateByPrimaryKey(costtype);
			if(resultcount>0){
				map.put("result", "类型修改成功！");
			}else{
				map.put("result", "类型修改失败，请重试！");
			}
		}
		return map;
	}
	
	/**
	 * 删除费用类型
	 * @param cid
	 * @return
	 */
	@RequestMapping(value="/deleteCost",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> deleteCosttype(Integer cid){
		Map<String, Object> map= new HashMap<>();
		int resultcount=costtypeService.deleteByPrimaryKey(cid);
		if(resultcount>0){
			map.put("result", "类型删除成功！");
			System.out.println("类型删除成功！");
		}else{
			map.put("result", "类型删除失败，请重试！");
			System.out.println("类型删除失败，请重试！");
		}
		return map;
	}
}
