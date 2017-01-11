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
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ht.dto.PageBean;
import com.ht.dto.StringUtil;
import com.ht.entity.Complaints;
import com.ht.entity.sysuser;
import com.ht.service.interfaces.ComplaintsService;
import com.ht.service.interfaces.UserService;
import com.ht.ssm.util.ResponseUtil;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;


@Controller
@RequestMapping("/complaints")
public class ComplaintsController {
	@Autowired
	private ComplaintsService complaintsService;
	
	@Autowired
	private UserService userService;
	
	@RequestMapping(value="/all")
	public String topageComplaints(){
		return "complaints/complaints";
	}
	/**
	 * 添加投诉
	 * @param ids
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/addcomplaints",method=RequestMethod.POST)
	@ResponseBody
	public String addmessage(Complaints complaints,HttpServletResponse response,HttpSession session)throws Exception{
		
		String sysusers=complaints.getComsysuser();
		JSONObject result = new JSONObject();
		sysuser resultTotal = userService.selectujobnumber(sysusers);
            //System.out.println(resultTotal);
		if(resultTotal!=null){
			 if(sysusers.equals(resultTotal.getUjobnumber())){   //说明员工编码正确
				complaints.setComtime(new Date());
				complaints.setComdisposetype("未启动");
				complaints.setComdisposesysuser("无");
				complaints.setComdisposemethod("无");
				 complaintsService.insertSelective(complaints);
		        	System.out.println("员工编码正确");
		    		result.put("success", "true1");
		        }
		}else{
    		result.put("success", "err1");
        	System.out.println("员工编码不正确");
        }
		ResponseUtil.write(response, result);
		return null;
       
	}
	
	@RequestMapping(value="/allComplaints",method=RequestMethod.GET)
	public String select(@RequestParam(value="comdisposetype",required=false)String comdisposetype,@RequestParam(value="comtime1",required=false)String comtime1,@RequestParam(value="comtime",required=false)String comtime,@RequestParam(value="comsysuser",required=false)String comsysuser,@RequestParam(value="comtype",required=false)String comtype,@RequestParam(value="comcusid",required=false)String comcusid,@RequestParam(value="comtitle",required=false)String comtitle,@RequestParam(value="comlevel",required=false)String comlevel,@RequestParam(value="page",required=false)String page,@RequestParam(value="rows",required=false)String rows,HttpServletResponse response,HttpSession session) throws Exception{
		PageBean pageBean=new PageBean(Integer.parseInt(page),Integer.parseInt(rows));
		Map<String, Object> map= new HashMap<>();
		System.out.println(comtype+"con");
		map.put("comsysuser", StringUtil.formatLike(comsysuser));
		map.put("comtype", StringUtil.formatLike(comtype));
		map.put("comcusid", StringUtil.formatLike(comcusid));
		map.put("comtitle", StringUtil.formatLike(comtitle));
		map.put("comlevel", StringUtil.formatLike(comlevel));
		map.put("comtime", comtime);
		map.put("comtime1", comtime1);
		map.put("comdisposetype", StringUtil.formatLike(comdisposetype));
		map.put("start", pageBean.getStart());
		map.put("size", pageBean.getPageSize());
		List<Complaints> list=complaintsService.select(map);//查询所有数据
		System.out.println(map.get("comtype")+"comtype");
		Long total=complaintsService.queryAllCount(map);	//查询总条数
		System.out.println("总条数:"+total);
		JSONObject result = new JSONObject();
		JSONArray jsonArray = JSONArray.fromObject(list);
		result.put("rows", jsonArray);
		result.put("total", total);
		ResponseUtil.write(response, result);
		System.out.println("list:"+jsonArray);
		return null;
	}
	@RequestMapping(value="/updatestate",method=RequestMethod.POST)
	public String updatestate(@RequestParam(value="sta",required=false)String sta,@RequestParam(value="tsid",required=false)int tsid,@RequestParam(value="comdisposesysuserss",required=false)String comdisposesysuserss,@RequestParam(value="comdisposemethods",required=false)String comdisposemethods,HttpServletResponse res) throws Exception{
		int resultTotal = 0;
		Complaints complaints=new Complaints();
		complaints.setComid(tsid);
		complaints.setComdisposetype(sta);
		complaints.setComdisposesysuser(comdisposesysuserss);
		complaints.setComdisposemethod(comdisposemethods);
		
            resultTotal = complaintsService.updateByPrimaryKeySelective(complaints);
        JSONObject jsonObject = new JSONObject();
        if(resultTotal > 0){   //说明修改成功
            jsonObject.put("success", true);
        }else{
            jsonObject.put("success", false);
        }
        ResponseUtil.write(res, jsonObject);
        return null;
	}
}
