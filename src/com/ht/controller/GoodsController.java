package com.ht.controller;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
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
	
	/**
	 * 添加订单
	 * @param goods
	 * @param request
	 * @param session
	 * @return
	 */
	@RequestMapping(value="/add")
	public String addGoods(Goods goods,HttpServletRequest request,HttpSession session,String location_p,String location_c,String location_a,String location_p1,String location_c1,String location_a1){
		DateFormat format=new SimpleDateFormat("MMddHHmm");
    	String time=format.format(new Date());
        Random ran=new Random();//实例化一个random的对象ne
        int four=ran.nextInt(9999-1000+1)+1000;//为变量赋随机值1000-9999
        Customer customer=(Customer) session.getAttribute("customer");
        goods.setGcid(customer.getCid());
		goods.setGordernumber(four+time);//4位随机数加8位时间
		goods.setGstate("1");
		goods.setGorigin(location_p+" "+location_c+" "+location_a);
		goods.setGendpoint(location_p1+" "+location_c1+" "+location_a1);
		goods.setGorderstime(new Date());
		int resultcount=goodsService.insertSelective(goods);
		if(resultcount>0){
			request.setAttribute("result", "✔订单添加成功！");
		}else{
			request.setAttribute("result", "✘订单添加失败！");
		}
		return "public/warehouse";
	}
	
	/**
	 * 某个客户的所有订单
	 * @param session
	 * @param page
	 * @param rows
	 * @return
	 */
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
	
	/**
	 * 修改货物信息
	 * @param goods
	 * @throws Exception 
	 */
	@RequestMapping(value="/updateGood")
	public String updateGood(Goods goods,HttpServletResponse response) throws Exception{
		JSONObject jsonObject = new JSONObject();
		if(goods.getGid() != null){
			int resultcount=goodsService.updateByPrimaryKeySelective(goods);
			if(resultcount>0){
				System.out.println("修改成功");
				jsonObject.put("success", true);
			}else{
				jsonObject.put("success", false);
			}
		}
		ResponseUtil.write(response, jsonObject);
        return null;
	}
	
	/**
	 * 查询订单视图
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/view")
	public String selectView(HttpServletRequest request){
		Calendar calendar=Calendar.getInstance();
		//获得当前时间的月份，月份从0开始所以结果要加1
		int month=calendar.get(Calendar.MONTH)+1;
		List<Long> list=new ArrayList<>();
		List<Long> list1=new ArrayList<>();
		Map<String, Object> map=new HashMap<>();
		for (int i = 1; i <= month; i++) {
			map.put("gstate", 2);
			map.put("month", i);
			list.add(goodsService.monthGoodCount(map));
			map.put("gstate", 3);
			list1.add(goodsService.monthGoodCount(map));
		}
		request.setAttribute("yi", list);
		request.setAttribute("ju", list1);
		return "goods/goodsView";
	}
	
	/**
	 * 查询是否有未揽收的货物
	 * @return
	 */
	@RequestMapping(value="/isGoods")
	@ResponseBody
	public Map<String, Object> oneMessage(){
		Map<String, Object> map=new HashMap<>();
		Calendar calendar=Calendar.getInstance();
		int month=calendar.get(Calendar.MONTH)+1;
		map.put("gstate", 1);
		map.put("month", month);
		Long resultcount=goodsService.monthGoodCount(map);
		if(resultcount>0){
			map.put("isOrnull", true);
			map.put("countNum", "系统还有 "+resultcount+" 笔订单未处理，请尽快安排揽收！");
		}else{
			map.put("isOrnull", false);
		}
		
		return map;
	}
	
}
