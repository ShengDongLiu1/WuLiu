package com.ht.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ht.dto.DateUtil;
import com.ht.dto.PageBean;
import com.ht.dto.StringUtil;
import com.ht.entity.AES;
import com.ht.entity.Customer;
import com.ht.entity.sysuser;
import com.ht.service.interfaces.CustomerService;
import com.ht.service.interfaces.UserService;
import com.ht.ssm.util.ResponseUtil;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
@RequestMapping("/customer")
public class Customerller {

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
		return "public/login";
	}
	
	/**
	 * 跳转到主页
	 * @return
	 */
	@RequestMapping(value="/index",method=RequestMethod.GET)
	public String toindex(){
		return "public/index";
	}
	
	/**
	 * 跳转到企业介绍
	 * @return
	 */
	@RequestMapping(value="/info",method=RequestMethod.GET)
	public String toinfo(){
		return "public/info";
	}
	
	/**
	 * 跳转到经营范围
	 * @return
	 */
	@RequestMapping(value="/management",method=RequestMethod.GET)
	public String tomanagement(){
		return "public/management";
	}
	
	/**
	 * 跳转到服务网络
	 * @return
	 */
	@RequestMapping(value="/network",method=RequestMethod.GET)
	public String tonetwork(){
		return "public/network";
	}
	
	/**
	 * 跳转到业务流程
	 * @return
	 */
	@RequestMapping(value="/flow",method=RequestMethod.GET)
	public String toflow(){
		return "public/flow";
	}
	
	/**
	 * 客户留言
	 * @return
	 */
	@RequestMapping(value="/message",method=RequestMethod.GET)
	public String tomessage(){
		return "public/message";
	}
	
	/**
	 * 跳转到我的货物
	 * @return
	 */
	@RequestMapping(value="/warehouse",method=RequestMethod.GET)
	public String towarehouse(HttpSession session){
		Customer customer=(Customer) session.getAttribute("customer");
		if(customer == null){
			return "public/login";
		}else{
			return "public/warehouse";
		}
	}
	
	
	/**
	 * 跳转到我的资料
	 * @return
	 */
	@RequestMapping(value="/personal",method=RequestMethod.GET)
	public String personal(HttpSession session){
		Customer customer=(Customer) session.getAttribute("customer");
		if(customer == null){
			return "public/login";
		}else{
			return "public/personalData";
		}
	}
	
	/**
	 * 转到我的资料
	 */
	@RequestMapping(value="/personalDataupdate")
	public String personalDataupdate(){
		return "public/personalData";
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
	 * 用户注销
	 * @param session
	 * @return
	 */
	@RequestMapping(value="/klogout",method=RequestMethod.GET)
	public String logout(HttpSession session){
		session.removeAttribute("customer");
		return "public/index";
	}
	/**
	 * 转到子界面
	 */
	@RequestMapping(value="/allkh")
	public String topageStorage(){
		return "customer/customerManage";
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
	@RequestMapping("/customerLogin")
	@ResponseBody
	public Map<String, Object> login(Customer customer,String code, HttpServletRequest request,HttpSession session) throws Exception{
		Map<String, Object> map=new HashMap<>();
		if(code.equals(session.getAttribute("code").toString())){
			//密码加密
			customer.setCpassword(AES.getInstance().encrypt(customer.getCpassword()));
			map.put("cemail", customer.getCemail());
			map.put("cpassword", customer.getCpassword());
			
			Customer customer2=customerService.klogin1(map);//客户登录
			if(customer2 == null){
				sysuser existsysuser = userService.login(customer.getCemail(),customer.getCpassword());
				session.setAttribute("user", existsysuser);
				session.removeAttribute("lockUser");
				if(existsysuser == null){
					map.put("result", "账号或密码错误!");
				}else{
					map.put("success", "admin");
				}
			}else{
				customer2.setCpassword(AES.getInstance().decrypt(customer2.getCpassword()));
				session.setAttribute("customer", customer2);
				map.put("success", "customer");
			}
		}else{
				map.put("result", "验证码输入错误!");
		}
		return map;
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
			customer.setCpassword(AES.getInstance().encrypt("123456"));//默认密码
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
	
	
	@RequestMapping("/save2")
	@ResponseBody
	public String save2(Customer customer,HttpServletResponse response)throws Exception{
		int resultTotal=0; // 操作的记录条数
		JSONObject result=new JSONObject();
		if(customer.getCid()==null){
			customer.setCpassword(AES.getInstance().encrypt(customer.getCpassword()));
			customer.setCkhno("KH"+DateUtil.getCurrentDateStr()); // 动态生成客户编号
			try{
				resultTotal=customerService.add(customer);
			}catch(DuplicateKeyException d){
				result.put("result", "err");
			}
		}
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
	
	/**
	 * 修改客户
	 * @param ids
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/update")
	public String update(Customer customer,HttpServletResponse response,HttpSession session)throws Exception{
		int resultTotal = 0;
            resultTotal = customerService.update(customer);
            
        if(resultTotal > 0){   //说明修改或添加成功
        	int cid=customer.getCid();
        	Customer cus= customerService.select(cid);
        	session.setAttribute("customer", cus);
        	return "redirect:/customer/personalDataupdate";
        }else{
        	return "redirect:/customer/personalDataupdate";
        }
	}
	
	//转到修改密码界面
	@RequestMapping("/revise")
	public String revise() throws Exception{
		System.out.println("00000001");
		return "public/revise";
	}
	
	//修改密码
	@RequestMapping("/updatePwd")
	public String userRevise(Customer customer3, @RequestParam("cid")String cid, @RequestParam("newUserpwd")String newUserpwd){
		try {
			customer3.setCid(Integer.valueOf(cid));
			customer3.setCpassword(AES.getInstance().encrypt(newUserpwd));
			customerService.updateUserPwd(customer3);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "public/login";
	}
	
	//判断邮箱
	@RequestMapping("/checkEmail")
	public String checkEmail(@RequestParam("cemail")String cemail,HttpServletResponse response) throws Exception{
		int resultTotao = 0;
		resultTotao = customerService.checkEmail(cemail);
		JSONObject result1=new JSONObject();
		if(resultTotao > 0) {
			result1.put("success", false);
		}else{
			result1.put("success", true);
		}
		ResponseUtil.write(response, result1);
		return "public/login";
	}
		
	//判断邮箱2
	@RequestMapping("/checkEmail2")
	public String checkEmail2(Customer customer3,@RequestParam("cemail")String cemail,@RequestParam("cid")String cid,HttpServletResponse response) throws Exception{
		int resultTotao = 0;
		customer3.setCid(Integer.valueOf(cid));
		customer3.setCemail(cemail);
		resultTotao = customerService.checkEmail2(customer3);
		JSONObject result2=new JSONObject();
		if(resultTotao > 0) {
			result2.put("success", false);
		}else{
			result2.put("success", true);
		}
		ResponseUtil.write(response, result2);
		return "public/login";
	}
	//判断手机号码
	@RequestMapping("/checkCphone")
	public String checkCphone(@RequestParam("cphone")String cphone,HttpServletResponse response) throws Exception{
		int resultTotao = 0;
		resultTotao = customerService.checkCphone(cphone);
		JSONObject result2=new JSONObject();
		if(resultTotao > 0) {
			result2.put("success", false);
		}else{
			result2.put("success", true);
		}
		ResponseUtil.write(response, result2);
		return "public/login";
	}
	//判断手机2
	@RequestMapping("/checkCphone2")
	public String checkCphone2(Customer customer3,@RequestParam("cphone")String cphone,@RequestParam("cid")String cid,HttpServletResponse response) throws Exception{
		int resultTotao = 0;
		customer3.setCid(Integer.valueOf(cid));
		customer3.setCphone(cphone);
		resultTotao = customerService.checkCphone2(customer3);
		JSONObject result1=new JSONObject();
		if(resultTotao > 0) {
			result1.put("success", false);
		}else{
			result1.put("success", true);
		}
		ResponseUtil.write(response, result1);
		return "public/login";
	}
	//修改密码
	@RequestMapping(value="/updatePwd1", method=RequestMethod.GET)
	public String userRevise1(Customer customer3, @RequestParam("cid")String cid, @RequestParam("newUserpwd")String newUserpwd) throws Exception{
		customer3.setCid(Integer.valueOf(cid));
		customer3.setCpassword(AES.getInstance().encrypt(newUserpwd));
		customerService.updateUserPwd(customer3);
		return "public/login";
	}
	
	/**
	 * 根据id查看客户信息
	 * @param cid
	 * @return
	 */
	@RequestMapping(value="/cusByid",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> selectById(Integer cid){
		Map<String, Object> map=new HashMap<>();
		Customer customer=customerService.select(cid);
		map.put("customer", customer);
		return map;
	}
	
	/**
	 * 每个星级所占有的客户
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/cusView")
	public String cusView(HttpServletRequest request){
		Map<String,Object> map=new HashMap<String,Object>();
		map.put("ccredit", "★☆☆☆☆");
		float count1=customerService.getTotal(map);
		
		map.put("ccredit", "★★☆☆☆");
		float count2=customerService.getTotal(map);
		
		map.put("ccredit", "★★★☆☆");
		float count3=customerService.getTotal(map);
		
		map.put("ccredit", "★★★★☆");
		float count4=customerService.getTotal(map);
		
		map.put("ccredit", "★★★★★");
		float count5=customerService.getTotal(map);
		float count=count1+count2+count3+count4+count5;
		float sta1=StringUtil.keepNumtwo(count1/count)*100;
		float sta2=StringUtil.keepNumtwo(count2/count)*100;
		float sta3=StringUtil.keepNumtwo(count3/count)*100;
		float sta4=StringUtil.keepNumtwo(count4/count)*100;
		float sta5=StringUtil.keepNumtwo(count5/count)*100;
//		System.out.println("count:"+count+"sta1:"+sta1+"sta2:"+sta2+"sta3:"+sta3+"sta4:"+sta4+"sta5:"+sta5);
		request.setAttribute("sta1", sta1);
		request.setAttribute("sta2", sta2);
		request.setAttribute("sta3", sta3);
		request.setAttribute("sta4", sta4);
		request.setAttribute("sta5", sta5);
		return "customer/cusView";
	}
	
	
}
