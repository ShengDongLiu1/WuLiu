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
import com.ht.entity.Transfer;
import com.ht.service.interfaces.TransferService;
import com.ht.ssm.util.ResponseUtil;

import net.sf.json.JSONArray;


@Controller
@RequestMapping("/transfer")
public class TransferController {
	@Autowired
	public TransferService transferService;
	
	@RequestMapping(value="/all")
	public String topageStorage(){
		return "Transfer/Transfer";
	}
	
	@RequestMapping(value="/allTransfer",method=RequestMethod.GET)
	public String select(@RequestParam(value="gname",required=false)String gname,@RequestParam(value="username",required=false)String username,@RequestParam(value="treason",required=false)String treason,@RequestParam(value="tdate",required=false)String tdate,@RequestParam(value="tdates",required=false)String tdates,@RequestParam(value="page",required=false)String page,@RequestParam(value="rows",required=false)String rows,HttpServletResponse response) throws Exception{
		PageBean pageBean=new PageBean(Integer.parseInt(page),Integer.parseInt(rows));
		Map<String, Object> map= new HashMap<>();
		map.put("gname", StringUtil.formatLike(gname));
		map.put("username", StringUtil.formatLike(username));
		map.put("treason", StringUtil.formatLike(treason));
		map.put("tdate", tdate);
		map.put("tdates", tdates);
		map.put("start", pageBean.getStart());
		map.put("size", pageBean.getPageSize());
		List<Transfer> list=transferService.select(map);//查询所有数据
		Long total=transferService.queryAllCount(map);	//查询总条数
		System.out.println("总条数:"+total);
		JSONObject result = new JSONObject();
		JSONArray jsonArray = JSONArray.fromObject(list);
		result.put("rows", jsonArray);
		result.put("total", total);
		ResponseUtil.write(response, result);
		System.out.println("list:"+jsonArray);
		return null;
	}
}
