package com.ht.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.ht.dto.PageBean;
import com.ht.dto.StringUtil;
import com.ht.entity.Goods;
import com.ht.entity.Inventory;
import com.ht.entity.Receipt;
import com.ht.entity.sysuser;
import com.ht.service.interfaces.GoodsService;
import com.ht.service.interfaces.InventoryService;
import com.ht.service.interfaces.ReceiptService;
import com.ht.ssm.util.ResponseUtil;

import net.sf.json.JSONArray;

@Controller
@RequestMapping("/receipt")
public class ReceiptController {
	
	@Autowired
	private ReceiptService receiptService;
	
	@Autowired
	public InventoryService inventoryService;
	
	@Autowired
	private GoodsService goodsService;
	
	/**
	 * 跳转到收货单
	 * @return
	 */
	@RequestMapping(value="/allRece")
	public String topagerReceipt(){
		return "receipt/receipt";
	}
	
	/**
	 * 所有收货单
	 * @param page
	 * @param rows
	 * @param response
	 * @param cname
	 * @param gname
	 * @param gstate
	 * @param gordernumber
	 * @param username
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/all")
	public String queryAll(@RequestParam(value="page",required=false)String page,@RequestParam(value="rows",required=false)String rows,HttpServletResponse response,String cname,String gname,String rstart,String gordernumber,String username) throws Exception{
		PageBean pageBean=null;
		if(page == null && rows == null){
			pageBean=new PageBean(1,10);
		}else{
			pageBean=new PageBean(Integer.parseInt(page),Integer.parseInt(rows));
		}
		Map<String, Object> map= new HashMap<>();
		map.put("cname", StringUtil.formatLike(cname));
		map.put("gname", StringUtil.formatLike(gname));
		map.put("usertruename", StringUtil.formatLike(username));
		map.put("rstart", rstart);	//订单入库状态
		map.put("gordernumber", StringUtil.formatLike(gordernumber));//订单号
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
	
	/**
	 * 揽收货物添加收货单
	 * @param receipt
	 * @param session
	 * @return
	 */
	@RequestMapping("/addRece")
	@ResponseBody
	public Map<String, Object> addReceipt(Receipt receipt,HttpSession session){
		Map<String, Object> map=new HashMap<>();
		sysuser user=(sysuser) session.getAttribute("user");
		int poshun=receipt.getRdamagedcount();//破损数量
		int geshi=receipt.getRshelvecount();//搁置数量
		int allcount=receipt.getRreceivecount();//货物数量
		receipt.setRreceivecount(allcount-poshun-geshi);//实际揽收数量
		receipt.setReid(user.getUserid());//员工id
		receipt.setRtdgoodstime(new Date());
		receipt.setRstart(1);	//清单状态1表示未入库
		int resultcount=receiptService.insertSelective(receipt);
		if(resultcount>0){
			Goods goods=new Goods();
			goods.setGid(receipt.getRgid());
			goods.setGstate("2");//状态设为2已揽收
			resultcount=goodsService.updateByPrimaryKeySelective(goods);
			if(resultcount>0){
				map.put("result", "揽收成功！");
			}else{
				map.put("result", "揽收失败请稍后再试！");
			}
		}
		return map;
	}
	
	/**
	 * 根据货物条件查询库位
	 * @param gid
	 * @param rid
	 * @param session
	 */
	@RequestMapping(value="/byGood")
	public void selectGoods(Integer gid,Integer rid,HttpSession session){
		Goods goods=goodsService.selectByPrimaryKey(gid);
		session.setAttribute("queryGoods", goods);
		Receipt receipt=receiptService.selectByPrimaryKey(rid);
		session.setAttribute("receipt", receipt);
	}
	
	/**
	 * 库位列表
	 * @param gid
	 * @param page
	 * @param rows
	 * @param response
	 * @param session
	 * @throws Exception
	 */
	@RequestMapping(value="/kuweiList")
	public String kuweiList(Integer gid,@RequestParam(value="page",required=false)String page,@RequestParam(value="rows",required=false)String rows,HttpServletResponse response,HttpSession session) throws Exception{
		Map<String, Object> map= new HashMap<>();
		PageBean pageBean=new PageBean(Integer.parseInt(page),Integer.parseInt(rows));
		Goods goods=(Goods) session.getAttribute("queryGoods");
		if(goods == null){
			return null;
		}
		map.put("logid", -1);
		map.put("losize", goods.getGsize());
		map.put("lovolume", goods.getGvolume());
		map.put("loweight", goods.getGweight());
		map.put("lolevel", goods.getGgrade());
		map.put("lostate", 0);
		map.put("start", pageBean.getStart());
		map.put("size", pageBean.getPageSize());
		List<Inventory> invenList=inventoryService.selectKwGoods(map);
		Long total=inventoryService.selectKwGoodsCount(map);
		
		JSONObject result = new JSONObject();
		JSONArray jsonArray = JSONArray.fromObject(invenList);
		result.put("rows", jsonArray);
		result.put("total", total);
		ResponseUtil.write(response, result);
		return null;
	}

}
