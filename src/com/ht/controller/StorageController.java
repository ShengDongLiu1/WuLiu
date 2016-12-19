package com.ht.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.ht.dto.Barcode;
import com.ht.dto.PageBean;
import com.ht.dto.StringUtil;
import com.ht.entity.Goods;
import com.ht.entity.Inventory;
import com.ht.entity.Storage;
import com.ht.entity.sysuser;
import com.ht.service.interfaces.InventoryService;
import com.ht.service.interfaces.StorageService;
import com.ht.ssm.util.ResponseUtil;

import net.sf.json.JSONArray;

@Controller
@RequestMapping("/storage")
public class StorageController {
	
	@Autowired
	private StorageService storageService;
	
	@Autowired
	public InventoryService inventoryService;
	
	@RequestMapping(value="/allStor")
	public String topageStorage(){
		return "Storage/storage";
	}
	/**
	 * 入库列表
	 * @param page
	 * @param rows
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/all",method=RequestMethod.GET)
	public String queryAll(@RequestParam(value="page",required=false)String page,@RequestParam(value="rows",required=false)String rows,HttpServletResponse response,String cname,String gname,String loname,String sbarcadeid,String username) throws Exception{
		PageBean pageBean=null;
		if(page == null && rows == null){
			pageBean=new PageBean(1,10);
		}else{
			pageBean=new PageBean(Integer.parseInt(page),Integer.parseInt(rows));
		}
		Map<String, Object> map= new HashMap<>();
		map.put("cname", StringUtil.formatLike(cname));
		map.put("gname", StringUtil.formatLike(gname));
		map.put("loname", StringUtil.formatLike(loname));
		map.put("usertruename", StringUtil.formatLike(username));
		map.put("storagemode", StringUtil.formatLike(""));
		map.put("sbarcadeid", StringUtil.formatLike(sbarcadeid));
		map.put("start", pageBean.getStart());
		map.put("size", pageBean.getPageSize());
		List<Storage> list=storageService.queryAll(map);//查询所有数据
		Long total=storageService.queryAllCount(map);	//查询总条数
		JSONObject result = new JSONObject();
		JSONArray jsonArray = JSONArray.fromObject(list);
		result.put("rows", jsonArray);
		result.put("total", total);
		ResponseUtil.write(response, result);
		System.out.println("list:"+jsonArray);
		return null;
	}
	
	/**
	 * 添加入库单
	 * @param barcode
	 * @param storage
	 * @param request
	 * @param session
	 * @return
	 */
	@RequestMapping(value="/add",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> add(Barcode barcode,Storage storage,Inventory inventory,HttpServletRequest request,HttpSession session){
		Map<String, Object> map= new HashMap<>();
		String string=barcode.createCode(request);//条形码生成
		sysuser user=(sysuser) session.getAttribute("user");
		Goods goods=(Goods)session.getAttribute("queryGoods");
		storage.setScid(goods.getGcid());//客户id
		storage.setSgid(goods.getGid());//货物id
		storage.setSeid(user.getUserid());//员工id
		storage.setStoragebarcode(string+".png");//条形码
		storage.setSbarcadeid(string);
		storage.setStoragetime(new Date());
		inventory.setLoid(storage.getSsbid());//库位编号
		inventory.setLogid(goods.getGid());//货物编号
		int resultcount=storageService.insertSelective(storage);
		if(resultcount>0){
			inventoryService.inventoryupdate(inventory);//给库位添加一个货物id
			map.put("result", "入库成功！");
		}else{
			map.put("result", "入库失败，请稍后再试！");
		}
		return map;
	}
}
