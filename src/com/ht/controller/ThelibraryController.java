package com.ht.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
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

import com.alibaba.fastjson.JSON;
import com.ht.dto.PageBean;
import com.ht.dto.StringUtil;
import com.ht.entity.Storage;
import com.ht.entity.Thelibrary;
import com.ht.entity.Transport;
import com.ht.service.interfaces.StorageService;
import com.ht.service.interfaces.ThelibraryService;
import com.ht.service.interfaces.TransportService;
import com.ht.ssm.util.Combox;
import com.ht.ssm.util.ResponseUtil;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
@RequestMapping("/thelibrary")
public class ThelibraryController {

	@Autowired
	private ThelibraryService thelibraryService;
	
	@Autowired
	private StorageService StorageService;
	
	@Autowired
	private TransportService transportService;

	
	@RequestMapping(value="/list",method=RequestMethod.GET)
	public String List(){
		return "thelibrary/thelibrary";
	}
	
	@RequestMapping(value="/yishenpi",method=RequestMethod.GET)
	public String yishenpi(){
		return "thelibrary/yishenpi";
	}


	@RequestMapping(value = "/add",method=RequestMethod.POST)
	public String add(Thelibrary thelibrary,HttpServletResponse resp,@RequestParam(value="goodscount2",required=false)String goodscount,Storage storage,
			@RequestParam(value="tid",required=false)Integer tid,@RequestParam(value="tstate",required=false)Integer tstate,@RequestParam(value="ttid",required=false)Integer ttid){
		int resultTotal = 0;
		if (thelibrary.getTid() == null) {
        	thelibrary.setTstate(1);
        	thelibrary.setTtid(-1);
        	storage.setSstock((storage.getSstock() - (thelibrary.getTcount())));
        	storage.setSid(storage.getSid());
        	StorageService.updateByPrimaryKeySelective(storage);
        	
            resultTotal = thelibraryService.insert(thelibrary);
        }else{
        	thelibrary.setTid(tid);
        	thelibrary.setTstate(tstate);
        	if(!"".equals(ttid) && ttid!=null){
        		thelibrary.setTtid(ttid);
        		thelibrary.setTstate(3);
        	}
            resultTotal = thelibraryService.updateByPrimaryKeySelective(thelibrary);
        }
        JSONObject jsonObject = new JSONObject();
        if(resultTotal > 0){   //说明修改或添加成功
            jsonObject.put("success", true);
        }else{
            jsonObject.put("success", false);
        }
        try {
			ResponseUtil.write(resp, jsonObject);
		} catch (Exception e) {
			e.printStackTrace();
		}
        return null;
	}
	
	
	@RequestMapping(value="/all",method=RequestMethod.GET)
	public String queryAll(@RequestParam(value="page",required=false)String page,@RequestParam(value="rows",required=false)String rows,HttpServletResponse response,HttpSession session,String gname,String tdrivername,String ttype,
			@RequestParam(value="query",required=false)String query) throws Exception{
		PageBean pageBean=null;
		if(page == null && rows == null){
			pageBean=new PageBean(0,10);
		}else{
			pageBean=new PageBean(Integer.parseInt(page),Integer.parseInt(rows));
		}
		Map<String, Object> map= new HashMap<>();
		map.put("tdrivername", StringUtil.formatLike(tdrivername));
		map.put("gname", StringUtil.formatLike(gname));
		map.put("ttype", StringUtil.formatLike(ttype));
		map.put("start", pageBean.getStart());
		map.put("size", pageBean.getPageSize());
		List<Thelibrary> list = null;
		Long total = null;
		if(!query.equals("") && "1".equals(query)){
			 list = thelibraryService.queryAll(map);//查询所有数据
			 total=thelibraryService.queryAllCount(map);
		}else{
			 list = thelibraryService.queryAll2(map);
			 session.setAttribute("thelibraryList", list);
			 total = thelibraryService.queryAllCount2(map);
		}
		JSONObject result = new JSONObject();
		JSONArray jsonArray = JSONArray.fromObject(list);
		result.put("rows", jsonArray);
		result.put("total", total);
		ResponseUtil.write(response, result);
		System.out.println("list:"+jsonArray);
		return null;
	}
	
	
	@RequestMapping(value="/tjls",method=RequestMethod.GET)
	@ResponseBody
	public String tjls(HttpServletRequest req,HttpServletResponse resp ) throws IOException{
		req.setCharacterEncoding("UTF-8");
		resp.setCharacterEncoding("UTF-8");
		resp.setContentType("text/json");
		PrintWriter out=resp.getWriter();
		Map<String, Object> map= new HashMap<>();
		List<Transport> transport = transportService.select(map);
		List<Combox> list  = new ArrayList<>();
		for (Transport tra : transport) {
			int sid = tra.getTrid();
			String sname = tra.getTdrivername();
			Combox combox = new Combox();
			combox.setId(String.valueOf(sid));
			combox.setName(sname);
			list.add(combox);
		}
		out.write(JSON.toJSONString(list));
		out.close();
		return null;
	}
	
	
	
	@RequestMapping(value="/thelibraryByid",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> selectByid(Integer tid,HttpServletResponse response){
		Map<String, Object> map=new HashMap<>();
		Thelibrary thelibrary = thelibraryService.queryById(tid);
		map.put("thelibrary", thelibrary);
		return map;
	}
	
}
