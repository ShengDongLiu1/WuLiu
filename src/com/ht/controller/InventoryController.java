package com.ht.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

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
	public String select(@RequestParam(value="gname",required=false)String gname,@RequestParam(value="loname",required=false)String loname,@RequestParam(value="lolevel",required=false)String lolevel,@RequestParam(value="lostate",required=false)String lostate,@RequestParam(value="page",required=false)String page,@RequestParam(value="rows",required=false)String rows,HttpServletResponse response,HttpSession session) throws Exception{
		PageBean pageBean=new PageBean(Integer.parseInt(page),Integer.parseInt(rows));
		Map<String, Object> map= new HashMap<>();
		map.put("gname", StringUtil.formatLike(gname));
		map.put("loname", StringUtil.formatLike(loname));
		map.put("lolevel", StringUtil.formatLike(lolevel));
		map.put("lostate", StringUtil.formatLike(lostate));
		map.put("start", pageBean.getStart());
		map.put("size", pageBean.getPageSize());
		List<Inventory> list=inventoryService.select(map);//查询所有数据
		session.setAttribute("inventoryList", list);
		Long total=inventoryService.queryAllCount(map);	//查询总条数
		JSONObject result = new JSONObject();
		JSONArray jsonArray = JSONArray.fromObject(list);
		result.put("rows", jsonArray);
		result.put("total", total);
		ResponseUtil.write(response, result);
		System.out.println("list:"+jsonArray);
		return null;
	}
	
	//losizesy之前库位尺寸
	//losizess剩余库位尺寸
	@RequestMapping("/save")
	public String save(int losizess,int losizesy,int lovolumesy,int lovolumess,int loweightsy,int loweightss,Inventory inventory,HttpServletResponse res) throws Exception{
		int resultTotal = 0;
        if (inventory.getLoid() == null) {
        	
        	inventory.setLosizes(inventory.getLosize());
        	inventory.setLovolumes(inventory.getLovolume());
        	inventory.setLoweights(inventory.getLoweight());
            resultTotal = inventoryService.inventoryAdd(inventory);
        }else{
        	inventory.setLosizes(losizess+inventory.getLosize()-losizesy);
        	inventory.setLovolumes(lovolumess+inventory.getLovolume()-lovolumesy);
        	inventory.setLoweights(loweightss+inventory.getLoweight()-loweightsy);
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
	//打开详细页面
	@RequestMapping(value="/invenOpen",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> selectByd(Integer loid,HttpServletResponse response){
		System.out.println("loid:"+loid);
		Map<String, Object> map=new HashMap<>();
		List<Inventory> list=inventoryService.selectInveGoods(loid);
		map.put("inventory",list);
		for(Inventory i:list){
			System.out.println(i.getLogid()+i.getGoods().getGname());
		}
		return map;
	}
	@RequestMapping(value="/NOInveWin",method=RequestMethod.POST)
	@ResponseBody
	public String NOInveWin(Integer loid,HttpServletResponse response){
		Inventory l=inventoryService.selectByPrimaryKey(loid);
		System.out.println("状态"+l.getLostate());
		if(l.getLostate()==0 && l.getLogid()==-1){
			inventoryService.updataInveState1(loid);
			return "关闭成功";
		}else if(l.getLostate()==1){
			inventoryService.updataInveState2(loid);
			return "开启成功";
		}else{
			return "关闭失败，库位有货物";
		}
	}
	
	/**
	 * 查询库位是否充足
	 * @return
	 */
	@RequestMapping(value="/isInventory")
	@ResponseBody
	public Map<String, Object> oneMessage(){
		Map<String, Object> map=new HashMap<>();
		map.put("logid", -1);
		map.put("lostate", 0);
		Long resultcount=inventoryService.queryAllCount(map);	//查询总条数
		if(resultcount<2){
			map.put("isOrnull", true);
			map.put("countNum", "警告： "+resultcount+" 库位即将用尽，请尽快安排货物出库!");
		}else{
			map.put("isOrnull", false);
		}
		if(resultcount == 0){
			map.put("isOrnull", true);
			map.put("countNum", "警告： "+resultcount+" 已无空闲库位，请尽快安排货物出库!");
		}
		
		return map;
	}
}
