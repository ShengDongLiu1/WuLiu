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
import com.ht.entity.Test;
import com.ht.service.interfaces.TestService;
import com.ht.ssm.util.ResponseUtil;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
@RequestMapping("/test")
public class TestController {

	@Autowired
	private TestService testService;

	@RequestMapping(value="/list",method=RequestMethod.GET)
	public String List(){
		return "test/test";
	}
	
	@RequestMapping("/save")
	public String save(Test test,HttpServletResponse res) throws Exception{
		int resultTotal = 0;
        if (test.getTid() == null) {
    		System.out.println("时间"+test.getTdate());
            resultTotal = testService.testAdd(test);
        }else{
            resultTotal = testService.testupdate(test);
        }
        JSONObject jsonObject = new JSONObject();
        if(resultTotal > 0){   //说明修改或添加成功
            jsonObject.put("success", true);
        }else{
            jsonObject.put("success", false);
        }
        ResponseUtil.write(res, jsonObject);
        return null;
	}
	
	@RequestMapping("/delete")
	public String delete(@RequestParam(value="ids") String ids,HttpServletResponse res) throws Exception{
		String[] idStr = ids.split(",");
        JSONObject jsonObject = new JSONObject();
        for (String id : idStr) {
            testService.testdelete(Integer.parseInt(id));
        }
        jsonObject.put("success", true);
        ResponseUtil.write(res, jsonObject);
        return null;
	}
	
	@RequestMapping(value="/queryAll",method=RequestMethod.GET)
	public String queryAll(@RequestParam(value="page",required=false) String page,
			@RequestParam(value="rows",required=false) String rows,
			Test test,HttpServletResponse res) throws Exception{
		PageBean pageBean=new PageBean(Integer.parseInt(page),Integer.parseInt(rows));
		Map<String,Object> map=new HashMap<String,Object>();
		map.put("tname", StringUtil.formatLike(test.getTname()));
		map.put("tsex", StringUtil.formatLike(test.getTsex()));
		map.put("tmes", StringUtil.formatLike(test.getTmes()));
		map.put("tdate", test.getTdate());
		map.put("tid", test.getTid());
		map.put("start", pageBean.getStart());
		map.put("size", pageBean.getPageSize());
		List<Test> testList=testService.testSelectAll(map);
		Long total=testService.getTotal(map);
		
		JSONObject result=new JSONObject();
		JSONArray jsonArray=JSONArray.fromObject(testList);
		result.put("rows", jsonArray);
		result.put("total", total);
		ResponseUtil.write(res, result);
		return null;
	}
}
