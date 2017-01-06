package com.ht.controller;

import java.util.Date;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ht.entity.Complaints;
import com.ht.entity.sysuser;
import com.ht.service.interfaces.ComplaintsService;
import com.ht.service.interfaces.UserService;
import com.ht.ssm.util.ResponseUtil;

import net.sf.json.JSONObject;


@Controller
@RequestMapping("/complaints")
public class ComplaintsController {
	@Autowired
	private ComplaintsService complaintsService;
	
	@Autowired
	private UserService userService;
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
		System.out.println("222222222");
		String sysusers=complaints.getComsysuser();
		JSONObject result = new JSONObject();
		sysuser resultTotal = userService.selectujobnumber(sysusers);
            //System.out.println(resultTotal);
		if(resultTotal!=null){
			 if(sysusers.equals(resultTotal.getUjobnumber())){   //说明员工编码正确
				 complaints.setComtime(new Date());
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
}
