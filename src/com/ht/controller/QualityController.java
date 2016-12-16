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

import com.ht.service.interfaces.QualityService;
import com.ht.ssm.util.ResponseUtil;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import com.ht.dto.StringUtil;
import com.ht.dto.PageBean;
import com.ht.entity.Goods;
import com.ht.entity.Quality;

/**
 * 质检管理Controller
 * @author 黄豪
 *
 */
@Controller
@RequestMapping("/quality")
public class QualityController {
	
	@Autowired
	private QualityService qualityService;
	
	/**
	 * 转到入库质检
	 * @return
	 */
	@RequestMapping("/godownEntry")
	public String godownEntry(){
		return "Quality/godownEntry";
	}
	
	/**
	 * 转到出库质检
	 * @return
	 */
	@RequestMapping("/stockRemoval")
	public String stockRemoval(){
		return "Quality/stockRemoval";
	}
	
	/**
	 * 分页
	 * @param page
	 * @param rows
	 * @param response
	 * @param ename
	 * @param egid
	 * @param eresult
	 * @param edate
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/queryAll",method=RequestMethod.GET)
	public String queryAll(@RequestParam(value="page",required=false)String page,@RequestParam(value="rows",required=false)String rows,HttpServletResponse response,String ename,String gordernumber,String eresult,String edate) throws Exception{
		PageBean pageBean=null;
		if(page == null && rows == null){
			pageBean=new PageBean(1,10);
		}else{
			pageBean=new PageBean(Integer.parseInt(page),Integer.parseInt(rows));
		}
		Map<String, Object> map= new HashMap<>();
		map.put("ename", StringUtil.formatLike(ename));
		map.put("gordernumber", StringUtil.formatLike(gordernumber));
		map.put("eresult", StringUtil.formatLike(eresult));
		map.put("edate", StringUtil.formatLike(edate));
		map.put("start", pageBean.getStart());
		map.put("size", pageBean.getPageSize());
		List<Quality> list=qualityService.qualitySelectAll(map);
		Long total=qualityService.getTotal(map);	//查询总条数
		System.out.println("************="+total);
		JSONObject result = new JSONObject();
		JSONArray jsonArray = JSONArray.fromObject(list);
		result.put("rows", jsonArray);
		result.put("total", total);
		ResponseUtil.write(response, result);
		System.out.println("list:"+jsonArray);
		return null;
	}
}
