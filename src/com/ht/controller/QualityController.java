package com.ht.controller;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
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

import com.ht.service.interfaces.QualityService;
import com.ht.ssm.util.ResponseUtil;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import com.ht.dto.StringUtil;
import com.ht.dto.PageBean;
import com.ht.entity.Goods;
import com.ht.entity.Quality;
import com.ht.entity.Receipt;
import com.ht.entity.sysuser;

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
	 * @param USERTRUENAME
	 * @param egid
	 * @param eresult
	 * @param edate
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/queryAll",method=RequestMethod.GET)
	public String queryAll(@RequestParam(value="page",required=false)String page,@RequestParam(value="rows",required=false)String rows,HttpServletResponse response,HttpSession session,String usertruename,String gname,String rstart,String edate) throws Exception{
		PageBean pageBean=null;
		if(page == null && rows == null){
			pageBean=new PageBean(1,10);
		}else{
			pageBean=new PageBean(Integer.parseInt(page),Integer.parseInt(rows));
		}
		Map<String, Object> map= new HashMap<>();
		System.out.println("******************="+usertruename);
		map.put("usertruename", StringUtil.formatLike(usertruename));
		map.put("gname", StringUtil.formatLike(gname));
		map.put("rstart", StringUtil.formatLike(rstart));
		map.put("edate", StringUtil.formatLike(edate));
		map.put("start", pageBean.getStart());
		map.put("size", pageBean.getPageSize());
		List<Quality> list=qualityService.qualitySelectAll(map);
		session.setAttribute("qualitylist", list);
		Long total=qualityService.getTotal(map);	//查询总条数
		JSONObject result = new JSONObject();
		JSONArray jsonArray = JSONArray.fromObject(list);
		result.put("rows", jsonArray);
		result.put("total", total);
		ResponseUtil.write(response, result);
		System.out.println("list:"+jsonArray);
		return null;
	}
	
	@RequestMapping(value="/qualityByid",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> selectByid(Integer eid,HttpServletResponse response){
		Map<String, Object> map=new HashMap<>();
		Quality quality=qualityService.qualitySelect(eid);
		map.put("quality", quality);
		return map;
	}
	
	@RequestMapping("/save")
	public String save(Quality quality, Receipt receipt, HttpServletResponse resp) throws Exception{
		Date date=new Date();
		DateFormat format=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		format.format(date);
		quality.setEdate(date);
		int resultObj = 0;
		if(quality.getEid() != null){
			resultObj = qualityService.qualityUpdate(quality);
			resultObj = qualityService.receiptUpdate(receipt);
		}
		JSONObject jsonObject = new JSONObject();
		if(resultObj > 0){
			jsonObject.put("success", true);
		}else{
			jsonObject.put("success", false);
		}
		ResponseUtil.write(resp, jsonObject);
		return null;
	}
	
	@RequestMapping("/delete")
	public String qualityDalete(@RequestParam(value="ids") String ids,HttpServletResponse res) throws Exception{
		String[] idStr = ids.split(",");
        JSONObject jsonObject = new JSONObject();
        for (String id : idStr) {
        	qualityService.qualityDelete(Integer.parseInt(id));
        }
        jsonObject.put("success", true);
        ResponseUtil.write(res, jsonObject);
		return null;
	}
	
}
