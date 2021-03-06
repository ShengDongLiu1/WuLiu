package com.ht.controller;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ht.entity.AES;
import com.ht.entity.Sysfunction;
import com.ht.entity.Sysrole;
import com.ht.entity.sysuser;
import com.ht.service.interfaces.RoleService;
import com.ht.service.interfaces.SysfunctionService;
import com.ht.service.interfaces.UserService;
import com.ht.ssm.util.Createstring;
import com.ht.vo.Reg;

/**
 * @author Administrator
 *
 */
/**
 * @author Administrator
 *
 */
@Controller
@RequestMapping("/user")
public class UserController {
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private SysfunctionService sysfunctionService;
	
	@Autowired
	private RoleService roleService;
	
	/**
	 * 跳转到登录页面
	 * @return
	 */
	@RequestMapping(value="/login",method=RequestMethod.GET)
	public String tologin(){
		
		return "public/login";
	}
	
	/**
	 * 后台管理欢迎页
	 * @return
	 */
	@RequestMapping(value="/welcome",method=RequestMethod.GET)
	public String toWelcome(){
		return "welcome";
	}
	
	/**
	 * 用户登录，并查处该用户拥有的权限功能
	 * @param sysuser
	 * @param session
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/login",method=RequestMethod.POST)
	public String login(sysuser sysuser,HttpSession session,Model model){
		
		sysuser existsysuser = userService.login(sysuser.getUsername(),sysuser.getUserpwd());
		
		session.setAttribute("user", existsysuser);
		
		/*if(existsysuser==null){
			
			model.addAttribute("msg", "用户名密码错误");
			
			return "login";
		}*/
		
		return "redirect:/user/index";
	}
	/**
	 * 用户注销
	 * @param session
	 * @return
	 */
	@RequestMapping(value="/logout",method=RequestMethod.GET)
	public String logout(HttpSession session){
		session.removeAttribute("lockUser");
		session.removeAttribute("user");
		session.removeAttribute("initfun");
		
		return "public/index";
	}
	
	/**
	 * 跳转到主页页面
	 * @return
	 */
	@RequestMapping(value="/index",method=RequestMethod.GET)
	public String index(Model model,HttpSession session){
		
		sysuser sysuser = (sysuser) session.getAttribute("user");
		
		if(sysuser.getRoleid() == -2){
			System.out.println("客户登入");
			return "redirect:/customer/index";
		}
		
		List<Sysfunction> funlist=sysfunctionService.initfunction(sysuser);
		
		System.out.println(funlist);
		
		 if ((sysuser != null) && (funlist.size() > 0))
		 {
		      model.addAttribute("initfun", funlist);
		      model.addAttribute("user", sysuser);
		 } else {
		      model.addAttribute("msg", "登录会话失效");
		      return "forward:/user/login";
		 }
		
		return "index";
	}
	
	
	/**列出所有的用户，除了超级管理员
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/listuser",method=RequestMethod.GET)
	public String listUser(Model model){
		
		List<sysuser> list = userService.selectAllUser();
		
		System.out.println(list);
		
		model.addAttribute("listuser", list);
		
		return "sysuser/list";
		
	}
	
	/**跳转到用户更新页面
	 * @param sysuser
	 * @param model
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="/update",method=RequestMethod.GET)
	public String toupdate(sysuser sysuser,Model model) throws Exception{
		
		sysuser existuser = userService.selectByPrimaryKey(sysuser.getUserid());
		existuser.setUserpwd(AES.getInstance().decrypt(existuser.getUserpwd()));
		model.addAttribute("item", existuser);
		
		return "sysuser/edit";
	}
	
	/**更新用户信息
	 * @param sysuser
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="/update",method=RequestMethod.POST)
	public String Update(sysuser sysuser) throws Exception{
		sysuser.setUserpwd(AES.getInstance().encrypt(sysuser.getUserpwd()));
		int count = userService.updateUser(sysuser);
		
		if(count<=0){
			
			return "error";
		}
		
		return "redirect:/user/listuser";
	}
	
	/** 显示用户可以更新角色
	 * @return
	 */
	@RequestMapping(value="/listrolejson",method=RequestMethod.POST,produces="application/json; charset=UTF-8"
			)
	public @ResponseBody List<Sysrole> areajson(){
		
		List<Sysrole> list = roleService.listAll();
		return list;
	}
	
	/**跳转到登录页面
	 * @return
	 */
	@RequestMapping(value="/add",method=RequestMethod.GET)
	public String toadd(){
		
		return "sysuser/add";
	}
	/**增加用户
	 * @param sysuser
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="/add",method=RequestMethod.POST)
	public String add(sysuser sysuser) throws Exception{
		sysuser.setUjobnumber("HTWL-"+Createstring.random());
		sysuser.setUserpwd(AES.getInstance().encrypt(sysuser.getUserpwd()));
		int count = userService.saveuser(sysuser);
		
		if(count<0){
			
			return "error";
		}
		
		return "redirect:/user/listuser";
	}
	
	@RequestMapping(value="/delete",method=RequestMethod.GET)
	public String Delete(sysuser sysuser){
		
		if(sysuser.getUserid()==null){
			
			return "error";
		}
		
		int count = userService.delete(sysuser.getUserid());
		
		if(count<0){
			
			return "error";
		}
		
		return "redirect:/user/listuser";
	}
	
	/** 查看用户信息是否存在
	 * @param username
	 * @return
	 */
	@RequestMapping(value="/checkusername",method=RequestMethod.POST,produces="application/json; charset=UTF-8"
			)
	public @ResponseBody Reg checkusername(String username){
		Reg reg = new Reg(200 , "可以注册");
		sysuser finduser = userService.findbyusername(username);
		
		if(finduser==null){
			
			return reg;
		}
		reg.setCode(500);
		reg.setMsg("账号已经存在");
		
		return reg;
		
	}
	
	/**根据用户名搜索用户信息
	 * @param username 用户名
	 * @return
	 */
	@RequestMapping(value="/search",method=RequestMethod.POST)
	public String search(String username,Model model){
		
		if(username==null){
			
			username="";
		}
		List<sysuser> searchlist = userService.searchbyusername(username);
		model.addAttribute("listuser", searchlist);
		
		return "sysuser/list";
	}
	
	/**
	 * 用户锁屏
	 * @param session
	 */
	@RequestMapping(value="/lock")
	public void lockUser(HttpSession session){
		session.setAttribute("lockUser", "lock");
	}
	
	/**
	 * 解锁
	 * @param session
	 * @param pwd
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="/unlock")
	@ResponseBody
	public Map<String, Object> unlockUser(HttpSession session,String pwd) throws Exception{
		Map<String, Object> map=new HashMap<>();
		sysuser sysuser = (sysuser) session.getAttribute("user");
		if(sysuser == null){
			map.put("result", "会话已失效，请重新登录！"); 
		}else if(pwd != null && AES.getInstance().encrypt(pwd).equals(sysuser.getUserpwd())){
			session.removeAttribute("lockUser");
			map.put("result", "success");
		}else{
			map.put("result", "密码输入错误，解锁失败！");
		}
		return map;
	}

}
