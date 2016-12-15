package com.ht.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.alibaba.fastjson.JSONObject;
import com.ht.dto.PageBean;
import com.ht.dto.StringUtil;
import com.ht.entity.Receipt;
import com.ht.service.interfaces.ReceiptService;
import com.ht.ssm.util.ResponseUtil;

import net.sf.json.JSONArray;

@Controller
@RequestMapping("/receipt")
public class ReceiptController {
	
	@Autowired
	private ReceiptService receiptService;
	
	@RequestMapping(value="/allRece")
	public String topagerReceipt(){
		return "receipt/receipt";
	}
	
	@RequestMapping(value="/all")
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
		List<Receipt> list=receiptService.queryAll(map);
		Long total=receiptService.queryAllCount(map);	//查询总条数
		
		JSONObject result = new JSONObject();
		JSONArray jsonArray = JSONArray.fromObject(list);
		result.put("rows", jsonArray);
		result.put("total", total);
		ResponseUtil.write(response, result);
		System.out.println("list:"+jsonArray);
		return null;
	}

}
