package com.ht.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.ht.entity.AES;
import com.ht.entity.Customer;
import com.ht.entity.sysuser;
import com.ht.service.interfaces.CustomerService;
import com.ht.service.interfaces.SysfunctionService;
import com.ht.service.interfaces.UserService;


@Controller
@RequestMapping("/customer")
public class Customerller {
	@Autowired
	private SysfunctionService sysfunctionService;

	@Autowired
	private CustomerService customerService;
	
	@Autowired
	private UserService userService;
	
	/**
	 * 跳转到登录页面
	 * @return
	 */
	@RequestMapping(value="/login",method=RequestMethod.GET)
	public String tologin(){
		
		return "index2";
	}
	
	/*@RequestMapping(value="/khlogin",method=RequestMethod.POST)
	public String login(Customer customer,HttpSession session){
		Map<String,Object> map = new HashMap<>();
		map.put("cemail", customer.getCemail());
		map.put("cpassword", customer.getCpassword());
		Customer existsycustomer = customerService.klogin1(map);
		session.setAttribute("user2", existsycustomer);
		sysuser existsysuser = userService.login(customer.getCemail(),customer.getCpassword());
		
		session.setAttribute("user", existsysuser);
		
		if(existsysuser==null){
			
			return "index2";
		}
		
		return "redirect:/user/index";
		
	}*/
	/**
	 * frame中加载main的部分
	 * @return
	 */
	@RequestMapping(value="/welcome",method=RequestMethod.GET)
	public String welcome(){
		
		return "index2";
	}
	/**
	 * 用户注销
	 * @param session
	 * @return
	 */
	@RequestMapping(value="/klogout",method=RequestMethod.GET)
	public String logout(HttpSession session){
		
		session.removeAttribute("user");
		session.removeAttribute("initfun");
		
		return "index2";
	}
	@RequestMapping("/khlogin")
	public String login(Customer customer,String code, HttpServletRequest req,HttpSession session) throws Exception{
		if(code.equals(session.getAttribute("code"))){
			customer.setCpassword(AES.getInstance().encrypt(customer.getCpassword()));
			Map<String, Object> map = new HashMap<>();
			map.put("cemail", customer.getCemail());
			map.put("cpassword", customer.getCpassword());
			try{
					System.out.println("ssssss");
					sysuser existsysuser = userService.login(customer.getCemail(),customer.getCpassword());
					session.setAttribute("user", existsysuser);
					return "redirect:/user/index";
			}catch(Exception e){
				System.out.println("TRY");
				session.setAttribute("LoginError", "账号或密码有误~");
				return "index2";
			}
		}else{
			session.setAttribute("LoginError", "验证码有误~");
			return "index2";
		}
	}	
}
