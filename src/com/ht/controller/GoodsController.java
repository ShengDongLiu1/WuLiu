package com.ht.controller;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

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
import com.ht.dto.PageBean;
import com.ht.dto.StringUtil;
import com.ht.entity.Customer;
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
	public String queryAll(@RequestParam(value="page",required=false)String page,@RequestParam(value="rows",required=false)String rows,HttpServletResponse response,HttpSession session,String cname,String gname,String gstate,String gordernumber) throws Exception{
		PageBean pageBean=null;
		if(page == null && rows == null){
			pageBean=new PageBean(1,10);
		}else{
			pageBean=new PageBean(Integer.parseInt(page),Integer.parseInt(rows));
		}
		Map<String, Object> map= new HashMap<>();
		map.put("cname", StringUtil.formatLike(cname));
		map.put("gname", StringUtil.formatLike(gname));
		map.put("gstate", StringUtil.formatLike(gstate));	//货物状态
		map.put("gordernumber", StringUtil.formatLike(gordernumber));//订单号
		map.put("start", pageBean.getStart());
		map.put("size", pageBean.getPageSize());
		List<Goods> list=goodsService.queryAll(map);
		session.setAttribute("goodslist", list);//导出excel时用到
		Long total=goodsService.queryAllCount(map);	//查询总条数
		
		JSONObject result = new JSONObject();
		JSONArray jsonArray = JSONArray.fromObject(list);
		result.put("rows", jsonArray);
		result.put("total", total);
		ResponseUtil.write(response, result);
		System.out.println("list:"+jsonArray);
		return null;
	}
	
	/**
	 * 根据货物id查询货物
	 * @param gid
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/goodByid",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> selectByid(Integer gid,HttpServletResponse response){
		Map<String, Object> map=new HashMap<>();
		Goods goods=goodsService.selectByPrimaryKey(gid);
		map.put("goods", goods);
		return map;
	}
	
	/**
	 * 拒收货物
	 * @param goods
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/goodCause",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> upGood(Goods goods,HttpServletResponse response){
		Map<String, Object> map=new HashMap<>();
		goods.setGstate("3");
		System.out.println("goods:"+goods);
		int resultcount=goodsService.updateByPrimaryKeySelective(goods);
		if(resultcount>0){
			map.put("result", "拒收成功！");
		}else{
			map.put("result", "拒收失败，请稍后再试！");
		}
		return map;
	}
	
	@RequestMapping(value="/add")
	public String addGoods(Goods goods,HttpServletRequest request,HttpSession session){
		DateFormat format=new SimpleDateFormat("MMddHHmm");
    	String time=format.format(new Date());
        Random ran=new Random();//实例化一个random的对象ne
        int four=ran.nextInt(9999-1000+1)+1000;//为变量赋随机值1000-9999
        Customer customer=(Customer) session.getAttribute("customer");
        goods.setGcid(customer.getCid());
		goods.setGordernumber(four+time);//4位随机数加8位时间
		goods.setGstate("1");
		goods.setGorderstime(new Date());
		int resultcount=goodsService.insertSelective(goods);
		if(resultcount>0){
			request.setAttribute("result", "✔订单添加成功！");
		}else{
			request.setAttribute("result", "✘订单添加失败！");
		}
		return "public/warehouse";
	}
	
	@RequestMapping(value="/myGoods",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> myGoods(HttpSession session,Integer page,Integer rows){
		Customer customer=(Customer) session.getAttribute("customer");
		if(customer == null){return null;}
		Map<String, Object> map= new HashMap<>();
		PageBean pageBean=null;
		if(page == null && rows == null){
			pageBean=new PageBean(1,4);
		}else{
			pageBean=new PageBean(page,rows);
		}
		map.put("cid", customer.getCid());
		map.put("start", pageBean.getStart());
		map.put("size", pageBean.getPageSize());
		List<Goods> list=goodsService.queryAll(map);
		Long total=goodsService.queryAllCount(map);	//查询总条数
		pageBean.setTotal(Integer.parseInt(String.valueOf(total)));
		map.put("total", total);		//订单记录总条数
		map.put("count",pageBean.getCount());//总页数
		map.put("page", pageBean.getPage());//当前页码
		map.put("pageSize", pageBean.getPageSize());//一页显示多少行
		map.put("listGoods", list);
		return map;
	}
	
}
