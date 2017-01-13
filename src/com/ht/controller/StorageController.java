package com.ht.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
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
import com.ht.dto.Lastweek;
import com.ht.dto.PageBean;
import com.ht.dto.StringUtil;
import com.ht.entity.Goods;
import com.ht.entity.Inventory;
import com.ht.entity.Receipt;
import com.ht.entity.Storage;
import com.ht.service.interfaces.InventoryService;
import com.ht.service.interfaces.ReceiptService;
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
	
	@Autowired
	private ReceiptService receiptService;
	
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
	public String queryAll(@RequestParam(value="page",required=false)String page,@RequestParam(value="rows",required=false)String rows,HttpServletResponse response,HttpSession session,String cname,String gname,String loname,String sbarcadeid,String username) throws Exception{
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
		session.setAttribute("storageList", list);
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
	public Map<String, Object> add(Barcode barcode,Integer ssbid,Inventory inventory,HttpServletRequest request,HttpSession session){
		Map<String, Object> map= new HashMap<>();
		String string=barcode.createCode(request);//条形码生成
		Receipt receipt=(Receipt) session.getAttribute("queryReceipt");
		Storage storage=(Storage) session.getAttribute("queryStorage");
		Goods goods=(Goods) session.getAttribute("queryGoods");
		storage.setSstock(storage.getStoragecount());
		storage.setSsbid(ssbid);//库位编号
		storage.setStoragebarcode(string+".png");//条形码
		storage.setSbarcadeid(string);
		storage.setStoragetime(new Date());
		int resultcount=storageService.insertSelective(storage);
		if(resultcount>0){
			Inventory inventory2=inventoryService.selectByPrimaryKey(storage.getSsbid());
			inventory.setLoid(storage.getSsbid());//库位编号
			inventory.setLogid(storage.getSgid());//货物编号
			inventory.setLosizes(StringUtil.keepNum(inventory2.getLosizes()-goods.getGsize()));//剩余尺寸
			inventory.setLovolumes(StringUtil.keepNum(inventory2.getLovolumes()-goods.getGvolume()));//剩余体积
			inventory.setLoweights(StringUtil.keepNum(inventory2.getLoweights()-goods.getGweight()));//剩余承受重量
			inventoryService.inventoryupdate(inventory);//给库位添加一个货物id
			//一次性入库修改状态
			if(receipt.getRreceivecount().equals(storage.getStoragecount())){
				receipt.setRstart(5);
				receipt.setRreceivecount(receipt.getRreceivecount()-storage.getStoragecount());
				receiptService.updateByPrimaryKeySelective(receipt);
			}else{//分批入库减去已入库数量
				receipt.setRstart(3);
				receipt.setRreceivecount(receipt.getRreceivecount()-storage.getStoragecount());
				receiptService.updateByPrimaryKeySelective(receipt);
			}
			map.put("result", "入库成功！");
		}else{
			map.put("result", "入库失败，请稍后再试！");
		}
		return map;
	}
	
	@RequestMapping("/updatekw")
	public String updatekw(Storage storage,@RequestParam(value="sgid",required=false)int sgid,@RequestParam(value="zqkwid",required=false)int zqkwid,@RequestParam(value="sid",required=false)int sid,@RequestParam(value="loid",required=false)int ssbid,HttpServletResponse res,HttpSession session) throws Exception{
		int resultTotal = 0;
		storage.setSid(sid);
		storage.setSsbid(ssbid);
		Goods goods=(Goods) session.getAttribute("queryGoods");
		
		Inventory zqinv=inventoryService.selectByPrimaryKey(zqkwid);//之前库位
		zqinv.setLosizes(zqinv.getLosizes()+goods.getGsize());
		zqinv.setLovolumes(zqinv.getLovolumes()+goods.getGvolume());
		zqinv.setLoweights(zqinv.getLoweights()+goods.getGweight());
		inventoryService.inventoryupdate(zqinv);
		
		Inventory zhinv=inventoryService.selectByPrimaryKey(ssbid);//之后库位
		zhinv.setLosizes(zhinv.getLosizes()-goods.getGsize());
		zhinv.setLovolumes(zhinv.getLovolumes()-goods.getGvolume());
		zhinv.setLoweights(zhinv.getLoweights()-goods.getGweight());
		inventoryService.inventoryupdate(zhinv);
            resultTotal = storageService.updateByPrimaryKeySelective(storage);
            Inventory inventory=new Inventory();//移库位之后，更改库位货物
            System.out.println(sgid);
            inventory.setLoid(ssbid);
            inventory.setLogid(sgid);
            inventoryService.inventoryupdate(inventory);
            Inventory inventorys=new Inventory();//移库位之前，更改库位货物

            inventorys.setLoid(zqkwid);
            inventorys.setLogid(-1);
            inventoryService.inventoryupdate(inventorys);
        JSONObject jsonObject = new JSONObject();
        if(resultTotal > 0){   //说明修改成功
            jsonObject.put("success", true);
        }else{
            jsonObject.put("success", false);
        }
        ResponseUtil.write(res, jsonObject);
        return null;
	}
	
	/**
	 * 上一周货物揽收情况
	 * @return
	 */
	@RequestMapping(value="/storView")
	public String lastStorage(HttpServletRequest request){
		List<Long> list=new ArrayList<>();
		List<String> weekDate=new ArrayList<>();
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        Calendar c = Calendar.getInstance();
        int day=Lastweek.weekDate();
        String[] num = {"","周一","周二","周三","周四","周五","周六","周日"}; 
        //过去七天
        for(int i=1;i<=7;i++){
        	c.setTime(new Date());
	        c.add(Calendar.DATE, -6-day+i);
	        Date date = c.getTime();
	        String str = format.format(date);
	        Map<String, Object> map= new HashMap<>();
	        map.put("storagetime", str);
	        Long total=storageService.queryAllCount(map);	//查询总条数
	        list.add(total);
	        weekDate.add(str+" "+num[i]);
//	        System.out.println("过去"+(7-i)+"天："+str+"\t揽收："+total+"批货物");
        }
        request.setAttribute("list", list);
        request.setAttribute("weekDate", weekDate);
		return "Storage/storView";
	}
}
