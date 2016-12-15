package com.ht.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

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
import com.ht.entity.Quality;

/**
 * 质检管理Controller
 * @author 黄豪
 *
 */
@Controller
@RequestMapping("/quality")
public class QualityController {
	
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
	
	@RequestMapping(value="/godownEntryQueryAll", method=RequestMethod.POST)
	public String godownEntryQueryAll(@RequestParam(value="page", required=false) String page,@RequestParam(value="rows",required=false) String rows,Quality quality,HttpServletResponse resp) throws Exception{
		PageBean pageBean=null;
		if(page == null && rows == null){
			pageBean=new PageBean(1,10);
		}else{
			pageBean=new PageBean(Integer.parseInt(page),Integer.parseInt(rows));
		}
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("eid", StringUtil.formatLike(""));
		map.put("egid", StringUtil.formatLike(""));
		map.put("eeid", StringUtil.formatLike(""));
		map.put("eresult", StringUtil.formatLike(""));
		map.put("edate", StringUtil.formatLike(""));
		map.put("start", pageBean.getPage());
		map.put("size", pageBean.getPageSize());
		List<Quality> qualityList = qualityService.qualitySelectAll(map);
		Long total = qualityService.getTotal(map);
		JSONObject result = new JSONObject();
		JSONArray jsonArray = JSONArray.fromObject(qualityList);
		result.put("rows", jsonArray);
		result.put("total", total);
		ResponseUtil.write(resp, result);
		System.out.println("list:"+jsonArray);
		return null;
	}
}
