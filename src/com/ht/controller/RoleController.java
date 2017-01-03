package com.ht.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.ht.entity.Sysfunction;
import com.ht.entity.Sysrole;
import com.ht.service.interfaces.RoleService;

@Controller
@RequestMapping("/role")
public class RoleController {
	
	@Autowired
	private RoleService roleService;
	
	/**
	 * 查看所有角色信息,除了超级管理员
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/list",method=RequestMethod.GET)
	public String listrole(Model model){
		
		 List<Sysrole> listAll = roleService.listAll();
		 model.addAttribute("roleList", listAll);
		
		return "sysrole/list";
	}
	
	/**跳转到更新页面
	 * @param sysrole
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/update",method=RequestMethod.GET)
	public String toupdate(Sysrole sysrole,Model model){
		
		Sysrole findsysrole = roleService.findbyid(sysrole.getRoleid());
		model.addAttribute("item", findsysrole);
		
		return "sysrole/edit";
	}
	
	/**更新角色信息
	 * @param sysrole
	 * @return
	 */
	@RequestMapping(value="/update",method=RequestMethod.POST)
	public String update(Sysrole sysrole){
		
		int count = roleService.updateRole(sysrole);
		
		if(count<0){
			
			return "error";
		}
		
		return "redirect:/role/list";
	}
	/**跳转到增加角色的页面
	 * @return
	 */
	@RequestMapping(value="/add",method=RequestMethod.GET)
	public String toadd(){
		
		return "sysrole/add";
	}
	
	/**增加角色
	 * @param sysrole
	 * @return
	 */
	@RequestMapping(value="/add",method=RequestMethod.POST)
	public String add(Sysrole sysrole){
		
		int count = roleService.saverole(sysrole);
		
	    if(count<0){
			
			return "error";
		}
		
		return "redirect:/role/list";
	}
	/**
	 * 按角色名称查询
	 * @param request
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	@RequestMapping(value = "/search",method = RequestMethod.POST)
	public String search(String rolename,Model model){
		
		List<Sysrole> list = roleService.listbyrolename(rolename);
		
		model.addAttribute("roleList", list);
		
		return "sysrole/list";
	}
	/**
	 * 权限页面的跳转
	 * @param request
	 * @return
	 * @throws UnsupportedEncodingException 
	 */
	@RequestMapping(value="/auth")
	public String auth(Sysrole sysrole,Model model){
		
		Sysrole role = roleService.findbyid(sysrole.getRoleid());
		List<Sysfunction> funlist = roleService.initfunlist(sysrole.getRoleid());
		System.out.println(funlist);
		model.addAttribute("role", role);
		model.addAttribute("list", funlist);
		
		return "sysrole/right";
	}
	
	/**
	 * 通过id删除权限,并实现保存
	 * @param sysrole
	 * @param request
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	@RequestMapping(value="/saveright",method=RequestMethod.POST)
	public String saveright(@RequestParam("roleid")int roleid,
			@RequestParam(value="ckrr", required=false)Integer[] funids,Model model){
		
		Integer rtn = roleService.saveright(roleid,funids);
		if(rtn>0){
			return "redirect:/role/list";
		}else{
			model.addAttribute("msg", "保存角色权限失败");
			
			return "forward:/role/auth";
		}
		
		
		
	}
	
}


