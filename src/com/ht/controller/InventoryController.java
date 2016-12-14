package com.ht.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.ht.entity.Inventory;
import com.ht.service.interfaces.InventoryService;

@Controller
@RequestMapping("/inventory")
public class InventoryController {
	@Autowired
	public InventoryService inventoryService;
	
	@RequestMapping(value="/select",method=RequestMethod.GET)
	public String select(){
		List<Inventory> list=inventoryService.select();
		for(Inventory s:list){
			System.out.println(s.getLogid()+s.toString());
		}
		return null;
	}
}
