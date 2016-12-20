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
import com.ht.entity.Transport;
import com.ht.service.interfaces.TransportService;
import com.ht.ssm.util.ResponseUtil;

import net.sf.json.JSONArray;
@Controller
@RequestMapping("/transport")
public class TransportController {

	@Autowired
	public TransportService transportService;
		
	@RequestMapping(value="/allTran")
	public String topageStorage(){
		return "transport/transport";
	}
	@RequestMapping(value="/all",method=RequestMethod.GET)
	public String select(@RequestParam(value="idcard",required=false)String idcard,@RequestParam(value="tdrivername",required=false)String tdrivername,@RequestParam(value="tdriverphone",required=false)String tdriverphone,@RequestParam(value="tvehicleid",required=false)String tvehicleid,@RequestParam(value="tvehicletype",required=false)String tvehicletype,@RequestParam(value="tvehiclecapacity",required=false)String tvehiclecapacity,@RequestParam(value="page",required=false)String page,@RequestParam(value="rows",required=false)String rows,HttpServletResponse response) throws Exception{
		PageBean pageBean=new PageBean(Integer.parseInt(page),Integer.parseInt(rows));
		Map<String, Object> map= new HashMap<>();
		map.put("idcard", StringUtil.formatLike(idcard));
		map.put("tdrivername", StringUtil.formatLike(tdrivername));
		map.put("tdriverphone", StringUtil.formatLike(tdriverphone));
		map.put("tvehicleid", StringUtil.formatLike(tvehicleid));
		map.put("tvehicletype", StringUtil.formatLike(tvehicletype));
		map.put("tvehiclecapacity", StringUtil.formatLike(tvehiclecapacity));
		map.put("start", pageBean.getStart());
		map.put("size", pageBean.getPageSize());
		List<Transport> list=transportService.select(map);//查询所有数据
		Long total=transportService.queryAllCount(map);	//查询总条数
		JSONObject result = new JSONObject();
		JSONArray jsonArray = JSONArray.fromObject(list);
		result.put("rows", jsonArray);
		result.put("total", total);
		ResponseUtil.write(response, result);
		return null;
	}
	
	@RequestMapping("/save")
	public String save(Transport transport,HttpServletResponse res) throws Exception{
		int resultTotal = 0;
        if (transport.getTid() == null) {
            resultTotal = transportService.treansportAdd(transport);
        }else{
            resultTotal = transportService.treansportupdate(transport);
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
        	transportService.transportdelete(Integer.parseInt(id));
        }
        jsonObject.put("success", true);
        ResponseUtil.write(res, jsonObject);
        return null;
	}
}
