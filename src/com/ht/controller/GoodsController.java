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
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.ht.dto.PageBean;
import com.ht.dto.StringUtil;
import com.ht.entity.Goods;
import com.ht.service.interfaces.GoodsService;
import com.ht.ssm.util.ResponseUtil;

import net.sf.json.JSONArray;

@Controller
@RequestMapping("/goods")
public class GoodsController {
	
	@Autowired
	private GoodsService goodsService;
	
	@RequestMapping(value="/allGood")
	public String topagerReceipt(){
		return "goods/goods";
	}
	
	/**
	 * 查询所有订单
	 * @param page
	 * @param rows
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/all",method=RequestMethod.GET)
	public String queryAll(@RequestParam(value="page",required=false)String page,@RequestParam(value="rows",required=false)String rows,HttpServletResponse response) throws Exception{
		PageBean pageBean=null;
		if(page == null && rows == null){
			pageBean=new PageBean(1,10);
		}else{
			pageBean=new PageBean(Integer.parseInt(page),Integer.parseInt(rows));
		}
		Map<String, Object> map= new HashMap<>();
		map.put("cname", StringUtil.formatLike(""));
		map.put("gname", StringUtil.formatLike(""));
		map.put("gstate", StringUtil.formatLike(""));	//货物状态
		map.put("gordernumber", StringUtil.formatLike(""));//订单号
		map.put("start", pageBean.getStart());
		map.put("size", pageBean.getPageSize());
		List<Goods> list=goodsService.queryAll(map);
		Long total=goodsService.queryAllCount(map);	//查询总条数
		
		JSONObject result = new JSONObject();
		JSONArray jsonArray = JSONArray.fromObject(list);
		result.put("rows", jsonArray);
		result.put("total", total);
		ResponseUtil.write(response, result);
		System.out.println("list:"+jsonArray);
		return null;
	}
	
	@RequestMapping(value="/goodByid",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> selectByd(Integer gid,HttpServletResponse response){
		System.out.println("gid:"+gid);
		Map<String, Object> map=new HashMap<>();
		Goods goods=goodsService.selectByPrimaryKey(gid);
		map.put("goods", goods);
		return map;
	}
}
