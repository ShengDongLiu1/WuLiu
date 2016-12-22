package com.ht.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
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
	

	@RequestMapping(value="/daochu",method=RequestMethod.GET)
	public String daochu(@RequestParam(value="page",required=false) String page,
			@RequestParam(value="rows",required=false) String rows,
			Test test,HttpServletResponse res) throws Exception{
		// 声明一个工作薄
	   HSSFWorkbook hwb = new HSSFWorkbook();
	   //声明一个单子并命名
	   HSSFSheet sheet = hwb.createSheet("测试表");
	   //给单子名称一个长度
	   sheet.setDefaultColumnWidth((int)15);
	   // 生成一个样式  
	   HSSFCellStyle style = hwb.createCellStyle();
	   //创建第一行（也可以称为表头）
	   HSSFRow row = sheet.createRow(0);
	   //样式字体居中
	   style.setAlignment(HSSFCellStyle.ALIGN_CENTER);
	   //给表头第一行一次创建单元格
	   HSSFCell cell = row.createCell((int) 0);
	   cell.setCellValue("编号");
	   cell.setCellStyle(style); 
	   cell = row.createCell((int) 1);
	   cell.setCellValue("姓名");
	   cell.setCellStyle(style);
	   cell = row.createCell((int) 2);
	   cell.setCellValue("性别");
	   cell.setCellStyle(style);
	   cell = row.createCell((int) 3);
	   cell.setCellValue("绰号");
	   cell.setCellStyle(style);
	   cell = row.createCell((int) 4);
	   cell.setCellValue("时间");
	   cell.setCellStyle(style);

		PageBean pageBean=new PageBean(Integer.parseInt(page),Integer.parseInt(rows));
		Map<String,Object> map=new HashMap<String,Object>();
		map.put("tname", null);
		map.put("tsex", null);
		map.put("tmes", null);
		map.put("tdate", null);
		map.put("tid", null);
		map.put("start", pageBean.getStart());
		map.put("size", pageBean.getPageSize());
		List<Test> list=testService.testSelectAll(map);
		//向单元格里填充数据
		for (short i = 0; i < list.size(); i++) {
			row = sheet.createRow(i + 1);
			row.createCell(0).setCellValue(list.get(i).getTid());
			row.createCell(1).setCellValue(list.get(i).getTname());
			row.createCell(2).setCellValue(list.get(i).getTsex());
			row.createCell(3).setCellValue(list.get(i).getTmes());
			row.createCell(4).setCellValue(list.get(i).getTdate());
		}
	     
	   File file = new File("E:/导出文件");
	   if(file.exists() == false){
		   file.mkdir();
	   }
	   FileOutputStream out = new FileOutputStream("E:/导出文件/Test.xls");
	   hwb.write(out);
	   out.flush();
	   out.close();
	   JSONObject jsonObject = new JSONObject();
       jsonObject.put("success", true);
       ResponseUtil.write(res, jsonObject);
       return null;
	}
	
}
