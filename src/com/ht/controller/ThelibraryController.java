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

import com.ht.dto.PageBean;
import com.ht.dto.StringUtil;
import com.ht.entity.Storage;
import com.ht.entity.Thelibrary;
import com.ht.service.interfaces.StorageService;
import com.ht.service.interfaces.ThelibraryService;
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
			@RequestParam(value="tid",required=false)Integer tid,@RequestParam(value="tstate",required=false)Integer tstate	){
		thelibrary.setTid(tid);
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
	public String queryAll(@RequestParam(value="page",required=false)String page,@RequestParam(value="rows",required=false)String rows,HttpServletResponse response,String gname,String sjname,String ttype,
			@RequestParam(value="query",required=false)String query) throws Exception{
		PageBean pageBean=null;
		if(page == null && rows == null){
			pageBean=new PageBean(0,10);
		}else{
			pageBean=new PageBean(Integer.parseInt(page),Integer.parseInt(rows));
		}
		Map<String, Object> map= new HashMap<>();
		map.put("gname", StringUtil.formatLike(gname));
		map.put("tdrivername", StringUtil.formatLike(sjname));
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
			 total = thelibraryService.queryAllCount2(map);
		}
			//查询总条数
		JSONObject result = new JSONObject();
		JSONArray jsonArray = JSONArray.fromObject(list);
		result.put("rows", jsonArray);
		result.put("total", total);
		ResponseUtil.write(response, result);
		System.out.println("list:"+jsonArray);
		return null;
	}
	
	
	@RequestMapping(value="/all2",method=RequestMethod.GET)
	public String queryAll2(@RequestParam(value="page",required=false)String page,@RequestParam(value="rows",required=false)String rows,HttpServletResponse response,String gname,String tdrivername,String ttype) throws Exception{
		PageBean pageBean=null;
		if(page == null && rows == null){
			pageBean=new PageBean(0,10);
		}else{
			pageBean=new PageBean(Integer.parseInt(page),Integer.parseInt(rows));
		}
		Map<String, Object> map= new HashMap<>();
		/*map.put("gname", StringUtil.formatLike(gname));
		map.put("tdrivername", StringUtil.formatLike(tdrivername));
		map.put("ttype", StringUtil.formatLike(ttype));*/
		map.put("start", pageBean.getStart());
		map.put("size", pageBean.getPageSize());
		List<Thelibrary> list=thelibraryService.queryAll2(map);//查询所有数据
		Long total=thelibraryService.queryAllCount(map);	//查询总条数
		JSONObject result = new JSONObject();
		JSONArray jsonArray = JSONArray.fromObject(list);
		result.put("rows", jsonArray);
		result.put("total", total);
		ResponseUtil.write(response, result);
		System.out.println("list:"+jsonArray);
		return null;
	}
	
	
}
