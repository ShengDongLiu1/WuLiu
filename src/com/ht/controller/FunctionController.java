package com.ht.controller;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.ht.entity.Sysfunction;
import com.ht.service.interfaces.FunctionService;

@Controller
@RequestMapping("/function")
public class FunctionController {

	@Autowired
	private FunctionService functionService;
	
	/**列出所有的功能
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/list",method=RequestMethod.GET)
	public String list(Model model){
		
		List<Sysfunction> list = functionService.listAll();
		
		model.addAttribute("funList", list);
		
		return "sysfunction/list";
	}
	/**
	 * 按功能名称查询
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/search",method=RequestMethod.POST)
	public String search(String funname,Model model){
		
		List<Sysfunction> list = functionService.selectByFunName(funname);
		
		model.addAttribute("funList", list);
		
		return "sysfunction/list";
	}
	
	/**按id查找功能信息
	 * @param id
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/update",method = RequestMethod.GET)
	public String toupdate(@Param("id")int id,Model model){
		
		Sysfunction list = functionService.selectByid(id);
		
		model.addAttribute("item", list);
		
		return "sysfunction/edit";
	}
	
	/**更新功能信息
	 * @param sysfunction
	 * @return
	 */
	@RequestMapping(value = "/update",method = RequestMethod.POST)
	public String update(Sysfunction sysfunction){
		
		int count = functionService.updateFun(sysfunction);
		if(count < 0){
			
			return "error";
		}
		
		return "redirect:/function/list";
	}
	
	/**跳转到增加功能的页面
	 * @return
	 */
	@RequestMapping(value = "/add",method = RequestMethod.GET)
	public String toadd(){
		
		return "sysfunction/add";
	}
	
	/**添加顶层功能
	 * @return
	 */
	@RequestMapping(value="/add",method=RequestMethod.POST)
	public String add(Sysfunction sysfunction){
		
		int count = functionService.addFun(sysfunction);
		if(count < 0){
			
			return "error";
		}
		return "redirect:/function/list";
	}
	
	/**跳转到增加子功能的页面
	 * @return
	 */
	@RequestMapping(value="/addsub",method=RequestMethod.GET)
	public String toaddsub(){
		
		return "sysfunction/addsub";
	}
	
	/**增加子功能
	 * @param sysfunction
	 * @return
	 */
	@RequestMapping(value="/addsub",method=RequestMethod.POST)
	public String addsub(Sysfunction sysfunction){
		
		int count = functionService.addFun(sysfunction);
		if(count < 0){
			
			return "error";
		}
		return "redirect:/function/list";
	}
	
	/**删除功能
	 * @param sysfunction
	 * @return
	 */
	@RequestMapping(value="/delete",method=RequestMethod.GET)
	public String delete(@RequestParam("id")int id){
		
		int count = functionService.deletebyid(id);
		if(count < 0){
			
			return "error";
		}
		return "redirect:/function/list";
	}
	
	
	
}
