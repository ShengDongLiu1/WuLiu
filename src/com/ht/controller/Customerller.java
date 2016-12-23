package com.ht.controller;

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

import com.ht.dto.DateUtil;
import com.ht.dto.PageBean;
import com.ht.dto.StringUtil;
import com.ht.entity.AES;
import com.ht.entity.Customer;
import com.ht.entity.sysuser;
import com.ht.service.interfaces.CustomerService;
import com.ht.service.interfaces.SysfunctionService;
import com.ht.service.interfaces.UserService;
import com.ht.ssm.util.ResponseUtil;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

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
	/**
	 * 跳转到注册界面
	 * @return
	 */
	@RequestMapping(value="/zc",method=RequestMethod.GET)
	public String welcome2(){
		
		return "register";
	}
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
	/**
	 * 转到子界面
	 */
	@RequestMapping(value="/allkh")
	public String topageStorage(){
		return "customer/customerManage";
	}
	/**
	 * 注册
	 */
	@RequestMapping("/zhuce")
	public String save(@RequestParam(value="cpassword2",required=false)String cpassword2,@RequestParam(value="cemail",required=false)String cemail,HttpServletResponse res) throws Exception{
		
		return null;
		
	}
	/**
	 * 登录验证
	 * @param customer
	 * @param code
	 * @param req
	 * @param session
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/khlogin")
	public String login(Customer customer,String code, HttpServletRequest req,HttpSession session) throws Exception{
		if(code.equals(session.getAttribute("code"))){
			customer.setCpassword(AES.getInstance().encrypt(customer.getCpassword()));
			Map<String, Object> map = new HashMap<>();
			map.put("cemail", customer.getCemail());
			map.put("cpassword", customer.getCpassword());
			try{
				sysuser existsysuser = userService.login(customer.getCemail(),customer.getCpassword());
				session.setAttribute("user", existsysuser);
				return "redirect:/user/index";
			}catch(Exception e){
				session.setAttribute("LoginError", "账号或密码有误~");
				return "index2";
			}
		}else{
				session.setAttribute("LoginError", "验证码有误~");
			 	return "index2";
		}
	}
	/**
	 * 分页条件查询客户
	 * @param page
	 * @param rows
	 * @param s_customer
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/list")
	public String list(@RequestParam(value="page",required=false)String page,@RequestParam(value="rows",required=false)String rows, HttpSession session,Customer s_customer,HttpServletResponse response)throws Exception{
		PageBean pageBean=new PageBean(Integer.parseInt(page),Integer.parseInt(rows));
		Map<String,Object> map=new HashMap<String,Object>();
		map.put("ckhno", StringUtil.formatLike(s_customer.getCkhno()));
		map.put("cname", StringUtil.formatLike(s_customer.getCname()));
		map.put("start", pageBean.getStart());
		map.put("size", pageBean.getPageSize());
		
		List<Customer> customerList=customerService.find(map);
		session.setAttribute("customerList", customerList);
		Long total=customerService.getTotal(map);
		JSONObject result=new JSONObject();
		JSONArray jsonArray=JSONArray.fromObject(customerList);
		result.put("rows", jsonArray);
		result.put("total", total);
		ResponseUtil.write(response, result);
		return null;
	}
	/**
	 * 添加或者修改客户
	 * @param user
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/save")
	public String save(Customer customer,HttpServletResponse response)throws Exception{
		int resultTotal=0; // 操作的记录条数
		if(customer.getCid()==null){
			customer.setCkhno("KH"+DateUtil.getCurrentDateStr()); // 动态生成客户编号
			resultTotal=customerService.add(customer);
		}else{
			resultTotal=customerService.update(customer);
		}
		JSONObject result=new JSONObject();
		if(resultTotal>0){
			result.put("success", true);
		}else{
			result.put("success", false);
		}
		ResponseUtil.write(response, result);
		return null;
	}
	/**
	 * 删除客户
	 * @param ids
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/delete")
	public String delete(@RequestParam(value="ids")String ids,HttpServletResponse response)throws Exception{
		String []idsStr=ids.split(",");
		for(int i=0;i<idsStr.length;i++){
			customerService.delete(Integer.parseInt(idsStr[i]));
		}
		JSONObject result=new JSONObject();
		result.put("success", true);
		ResponseUtil.write(response, result);
		return null;
	}
}
