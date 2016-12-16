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
import com.ht.entity.Receipt;
import com.ht.entity.sysuser;
import com.ht.service.interfaces.GoodsService;
import com.ht.service.interfaces.ReceiptService;
import com.ht.ssm.util.ResponseUtil;

import net.sf.json.JSONArray;

@Controller
@RequestMapping("/receipt")
public class ReceiptController {
	
	@Autowired
	private ReceiptService receiptService;
	
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
	public String queryAll(@RequestParam(value="page",required=false)String page,@RequestParam(value="rows",required=false)String rows,HttpServletResponse response,String cname,String gname,String gstate,String gordernumber,String username) throws Exception{
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
		map.put("gstate", StringUtil.formatLike(gstate));	//货物状态
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
		System.out.println("receipt:"+receipt);
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

}
