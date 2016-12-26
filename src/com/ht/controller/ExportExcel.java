package com.ht.controller;

import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ht.dto.PathService;
import com.ht.dto.TheDate;
import com.ht.entity.Customer;
import com.ht.entity.Goods;
import com.ht.entity.Inventory;
import com.ht.entity.Quality;
import com.ht.entity.Receipt;
import com.ht.entity.Storage;
import com.ht.entity.Thelibrary;


@Controller
@RequestMapping("/export")
public class ExportExcel {
	
	/**
	 * 导出订单表
	 * @param session
	 * @param request
	 * @param response
	 */
	@RequestMapping(value="/goodsExcel")
	public void exportGoods(HttpSession session,HttpServletRequest request,HttpServletResponse response){
		 // 第一步，创建一个webbook，对应一个Excel文件  
        HSSFWorkbook wb = new HSSFWorkbook();  
        // 第二步，在webbook中添加一个sheet,对应Excel文件中的sheet  
        HSSFSheet sheet = wb.createSheet("客户订单表");  
        // 第三步，在sheet中添加表头第0行,注意老版本poi对Excel的行数列数有限制short  
        HSSFRow row = sheet.createRow(0);  
        // 第四步，创建单元格，并设置值表头 设置表头居中  
        HSSFCellStyle style = wb.createCellStyle();  
        style.setAlignment(HSSFCellStyle.ALIGN_CENTER); // 创建一个居中格式  
  
        HSSFCell cell = row.createCell(0);  
        cell.setCellValue("编号");  
        cell.setCellStyle(style);
        
        cell = row.createCell(1);  
        cell.setCellValue("客户");  
        cell.setCellStyle(style);  
        
        cell = row.createCell(2);  
        cell.setCellValue("货物名称");  
        cell.setCellStyle(style);  
        
        cell = row.createCell(3);  
        cell.setCellValue("订单号");  
        cell.setCellStyle(style);
        
        cell = row.createCell(4);  
        cell.setCellValue("货物数量");  
        cell.setCellStyle(style);
        
        cell = row.createCell(5);  
        cell.setCellValue("货物单位");  
        cell.setCellStyle(style);
        
        cell = row.createCell(6);  
        cell.setCellValue("货物等级");  
        cell.setCellStyle(style);
        
        cell = row.createCell(7);  
        cell.setCellValue("货物状态");  
        cell.setCellStyle(style);
        
        cell = row.createCell(8);  
        cell.setCellValue("下单时间");  
        cell.setCellStyle(style);
        
        @SuppressWarnings("unchecked")
		List<Goods> list=(List<Goods>)session.getAttribute("goodslist");
        
        for (int i = 0; i < list.size(); i++)  
        {  
            row = sheet.createRow((int) i + 1);  
            // 第四步，创建单元格，并设置值  
            row.createCell(0).setCellValue(i+1);  
            row.createCell(1).setCellValue(list.get(i).getCustomer().getCname());  
            row.createCell(2).setCellValue(list.get(i).getGname());
            row.createCell(3).setCellValue(list.get(i).getGordernumber()); 
            row.createCell(4).setCellValue(list.get(i).getGcount()); 
            row.createCell(5).setCellValue(list.get(i).getGunit()); 
            row.createCell(6).setCellValue(list.get(i).getGgrade());
            String state=list.get(i).getGstate();
            if("1".equals(state)){
            	state="待揽收";
            }else if("2".equals(state)){
            	state="已揽收";
            }else if("3".equals(state)){
            	state="已拒收";
            }
            row.createCell(7).setCellValue(state);
            row.createCell(8).setCellValue(TheDate.datetoString(list.get(i).getGorderstime()));
        }  
        // 第六步，将文件存到指定位置  
        try{  
        	FileOutputStream fout = new FileOutputStream(PathService.Path(request)+"/"+"goods.xls");  
            wb.write(fout);  
            fout.close();  
            ServletContext context = request.getSession().getServletContext();  
		    //通过context方式直接获取文件的路径  
		    String path = context.getRealPath("/客户订单表.xls");  
		    //获取文件名  
		    String filename = path.substring(path.lastIndexOf("\\")+1);  
		    //将文件名进行URL编码  
		    filename = URLEncoder.encode(filename,"utf-8");  
		    //告诉浏览器用下载的方式打开图片  
		    response.setHeader("content-disposition", "attachment;filename="+filename);  
		    //将图片使用字节流的形式写给客户机  
		    @SuppressWarnings("resource")
			InputStream is = new FileInputStream(PathService.Path(request)+"/"+"goods.xls"); //从这个路径下读取文件 
		    OutputStream out = response.getOutputStream();  
		    byte[] buffer = new byte[1024];  
		    int len = 0;  
		    while((len=is.read(buffer))!=-1){  
		        out.write(buffer, 0, len);  
		    } 
        }  
        catch (Exception e)  
        {  
            e.printStackTrace(); 
        }
	}
	
	/**
	 * 收货单
	 * @param session
	 * @param request
	 * @param response
	 */
	@RequestMapping(value="/receiptExcel")
	public void exportReceipt(HttpSession session,HttpServletRequest request,HttpServletResponse response){
		 // 第一步，创建一个webbook，对应一个Excel文件  
        HSSFWorkbook wb = new HSSFWorkbook();  
        // 第二步，在webbook中添加一个sheet,对应Excel文件中的sheet  
        HSSFSheet sheet = wb.createSheet("收货单");  
        // 第三步，在sheet中添加表头第0行,注意老版本poi对Excel的行数列数有限制short  
        HSSFRow row = sheet.createRow(0);  
        // 第四步，创建单元格，并设置值表头 设置表头居中  
        HSSFCellStyle style = wb.createCellStyle();  
        style.setAlignment(HSSFCellStyle.ALIGN_CENTER); // 创建一个居中格式  
  
        HSSFCell cell = row.createCell(0);  
        cell.setCellValue("编号");  
        cell.setCellStyle(style);
        
        cell = row.createCell(1);  
        cell.setCellValue("客户");  
        cell.setCellStyle(style);  
        
        cell = row.createCell(2);  
        cell.setCellValue("货物名称");  
        cell.setCellStyle(style);  
        
        cell = row.createCell(3);  
        cell.setCellValue("订单号");  
        cell.setCellStyle(style);
        
        cell = row.createCell(4);  
        cell.setCellValue("货物总数量");  
        cell.setCellStyle(style);
        
        cell = row.createCell(5);  
        cell.setCellValue("剩余货物数量");  
        cell.setCellStyle(style);
        
        cell = row.createCell(6);  
        cell.setCellValue("破损数量");  
        cell.setCellStyle(style);
        
        cell = row.createCell(7);  
        cell.setCellValue("搁置数量");  
        cell.setCellStyle(style);
        
        cell = row.createCell(8);  
        cell.setCellValue("收货时间");  
        cell.setCellStyle(style);
        
        cell = row.createCell(9);  
        cell.setCellValue("收货员");  
        cell.setCellStyle(style);
        
        cell = row.createCell(10);  
        cell.setCellValue("货物状态");  
        cell.setCellStyle(style);
        
        @SuppressWarnings("unchecked")
		List<Receipt> list=(List<Receipt>)session.getAttribute("receiptList");
        
        for (int i = 0; i < list.size(); i++)  
        {  
            row = sheet.createRow((int) i + 1);  
            // 第四步，创建单元格，并设置值  
            row.createCell(0).setCellValue(i+1);  
            row.createCell(1).setCellValue(list.get(i).getCustomer().getCname());  
            row.createCell(2).setCellValue(list.get(i).getGoods().getGname());
            row.createCell(3).setCellValue(list.get(i).getGoods().getGordernumber()); 
            row.createCell(4).setCellValue(list.get(i).getGoods().getGcount()); 
            row.createCell(5).setCellValue(list.get(i).getRreceivecount()); 
            row.createCell(6).setCellValue(list.get(i).getRdamagedcount());
            row.createCell(7).setCellValue(list.get(i).getRshelvecount());
            row.createCell(8).setCellValue(TheDate.datetoString(list.get(i).getRtdgoodstime()));
            row.createCell(9).setCellValue(list.get(i).getUser().getUsertruename());
            Integer state=list.get(i).getRstart();
            String string="";
            if(state == 1){
            	string="待检验";
            }else if(state == 2){
            	string="未入库";
            }else if(state == 3){
            	string="质检失败";
            }else if(state == 4){
            	string="部分入库";
            }else if(state == 5){
            	string="已入库";
            }
            row.createCell(10).setCellValue(string);
        }  
        // 第六步，将文件存到指定位置  
        try{  
        	FileOutputStream fout = new FileOutputStream(PathService.Path(request)+"/"+"receipt.xls");  
            wb.write(fout);  
            fout.close();  
            ServletContext context = request.getSession().getServletContext();  
		    //通过context方式直接获取文件的路径  
		    String path = context.getRealPath("/收货单.xls");  
		    //获取文件名  
		    String filename = path.substring(path.lastIndexOf("\\")+1);  
		    //将文件名进行URL编码  
		    filename = URLEncoder.encode(filename,"utf-8");  
		    //告诉浏览器用下载的方式打开图片  
		    response.setHeader("content-disposition", "attachment;filename="+filename);  
		    //将图片使用字节流的形式写给客户机  
		    @SuppressWarnings("resource")
			InputStream is = new FileInputStream(PathService.Path(request)+"/"+"receipt.xls"); //从这个路径下读取文件 
		    OutputStream out = response.getOutputStream();  
		    byte[] buffer = new byte[1024];  
		    int len = 0;  
		    while((len=is.read(buffer))!=-1){  
		        out.write(buffer, 0, len);  
		    } 
        }  
        catch (Exception e)  
        {  
            e.printStackTrace(); 
        }
	}
	
	/**
	 * 导出入库表
	 * @param session
	 * @param request
	 * @param response
	 */
	@RequestMapping(value="/storageExcel")
	public void exportStorage(HttpSession session,HttpServletRequest request,HttpServletResponse response){
		 // 第一步，创建一个webbook，对应一个Excel文件  
        HSSFWorkbook wb = new HSSFWorkbook();  
        // 第二步，在webbook中添加一个sheet,对应Excel文件中的sheet  
        HSSFSheet sheet = wb.createSheet("入库列表");  
        // 第三步，在sheet中添加表头第0行,注意老版本poi对Excel的行数列数有限制short  
        HSSFRow row = sheet.createRow(0);
        // 第四步，创建单元格，并设置值表头 设置表头居中  
        HSSFCellStyle style = wb.createCellStyle();  
        style.setAlignment(HSSFCellStyle.ALIGN_CENTER); // 创建一个居中格式  
  
        HSSFCell cell = row.createCell(0);  
        cell.setCellValue("编号");  
        cell.setCellStyle(style);
        
        cell = row.createCell(1);  
        cell.setCellValue("客户");  
        cell.setCellStyle(style);  
        
        cell = row.createCell(2);  
        cell.setCellValue("货物名称");  
        cell.setCellStyle(style);  
        
        cell = row.createCell(3);  
        cell.setCellValue("库位名称");  
        cell.setCellStyle(style);
        
        cell = row.createCell(4);  
        cell.setCellValue("入库类型");  
        cell.setCellStyle(style);
        
        cell = row.createCell(5);  
        cell.setCellValue("入库数量");  
        cell.setCellStyle(style);
        
        cell = row.createCell(6);  
        cell.setCellValue("剩余库存");  
        cell.setCellStyle(style);
        
        cell = row.createCell(7);  
        cell.setCellValue("条形码编号");  
        cell.setCellStyle(style);
        
        cell = row.createCell(8);  
        cell.setCellValue("入库时间");  
        cell.setCellStyle(style);
        
        cell = row.createCell(9);  
        cell.setCellValue("操作员");  
        cell.setCellStyle(style);
        
        @SuppressWarnings("unchecked")
		List<Storage> list=(List<Storage>)session.getAttribute("storageList");
        
        for (int i = 0; i < list.size(); i++)  
        {  
            row = sheet.createRow((int) i + 1);  
            // 第四步，创建单元格，并设置值  
            row.createCell(0).setCellValue(i+1);  
            row.createCell(1).setCellValue(list.get(i).getCustomer().getCname());  
            row.createCell(2).setCellValue(list.get(i).getGoods().getGname());
            row.createCell(3).setCellValue(list.get(i).getInventory().getLoname()); 
            row.createCell(4).setCellValue(list.get(i).getStoragemode()); 
            row.createCell(5).setCellValue(list.get(i).getStoragecount()); 
            row.createCell(6).setCellValue(list.get(i).getSstock());
            row.createCell(7).setCellValue(list.get(i).getSbarcadeid());
            row.createCell(8).setCellValue(TheDate.datetoString(list.get(i).getStoragetime()));
            row.createCell(9).setCellValue(list.get(i).getUser().getUsertruename());
        }  
        // 第六步，将文件存到指定位置  
        try{  
        	FileOutputStream fout = new FileOutputStream(PathService.Path(request)+"/"+"storage.xls");  
            wb.write(fout);  
            fout.close();  
            ServletContext context = request.getSession().getServletContext();  
		    //通过context方式直接获取文件的路径  
		    String path = context.getRealPath("/入库列表.xls");  
		    //获取文件名  
		    String filename = path.substring(path.lastIndexOf("\\")+1);  
		    //将文件名进行URL编码  
		    filename = URLEncoder.encode(filename,"utf-8");  
		    //告诉浏览器用下载的方式打开图片  
		    response.setHeader("content-disposition", "attachment;filename="+filename);  
		    //将图片使用字节流的形式写给客户机  
		    @SuppressWarnings("resource")
			InputStream is = new FileInputStream(PathService.Path(request)+"/"+"storage.xls"); //从这个路径下读取文件 
		    OutputStream out = response.getOutputStream();  
		    byte[] buffer = new byte[1024];  
		    int len = 0;  
		    while((len=is.read(buffer))!=-1){  
		        out.write(buffer, 0, len);  
		    } 
        }  
        catch (Exception e)  
        {  
            e.printStackTrace(); 
        }
	}
	
	@RequestMapping(value="/thelibraryExcel")
	public void exportThelibrary(HttpSession session,HttpServletRequest request,HttpServletResponse response){
		 // 第一步，创建一个webbook，对应一个Excel文件  
        HSSFWorkbook wb = new HSSFWorkbook();  
        // 第二步，在webbook中添加一个sheet,对应Excel文件中的sheet  
        HSSFSheet sheet = wb.createSheet("出货单");  
        // 第三步，在sheet中添加表头第0行,注意老版本poi对Excel的行数列数有限制short  
        HSSFRow row = sheet.createRow(0);
        // 第四步，创建单元格，并设置值表头 设置表头居中  
        HSSFCellStyle style = wb.createCellStyle();  
        style.setAlignment(HSSFCellStyle.ALIGN_CENTER); // 创建一个居中格式  
  
        HSSFCell cell = row.createCell(0);  
        cell.setCellValue("编号");  
        cell.setCellStyle(style);
        
        cell = row.createCell(1);  
        cell.setCellValue("货物名称");  
        cell.setCellStyle(style);  
        
        cell = row.createCell(2);  
        cell.setCellValue("出库数量");  
        cell.setCellStyle(style);
        
        cell = row.createCell(3);  
        cell.setCellValue("出库类型");  
        cell.setCellStyle(style);
        
        cell = row.createCell(4);  
        cell.setCellValue("司机姓名");  
        cell.setCellStyle(style);
        
        cell = row.createCell(5);  
        cell.setCellValue("状态");  
        cell.setCellStyle(style);
        
        cell = row.createCell(6);  
        cell.setCellValue("备注");  
        cell.setCellStyle(style);
        
        cell = row.createCell(7);  
        cell.setCellValue("出库时间");  
        cell.setCellStyle(style);
        
        @SuppressWarnings("unchecked")
		List<Thelibrary> list=(List<Thelibrary>)session.getAttribute("thelibraryList");
        
        for (int i = 0; i < list.size(); i++)  
        {  
            row = sheet.createRow((int) i + 1);  
            // 第四步，创建单元格，并设置值  
            row.createCell(0).setCellValue(i+1);  
            row.createCell(1).setCellValue(list.get(i).getGoods().getGname());
            row.createCell(2).setCellValue(list.get(i).getTcount()); 
            row.createCell(3).setCellValue(list.get(i).getTtype()); 
            row.createCell(4).setCellValue(list.get(i).getTransport().getTdrivername()); 
            Integer state=list.get(i).getTstate();
            String string="";
            if(state ==1){
            	string="未审批";
            }else if(state ==2){
            	string="已审批";
            }else if(state ==3){
            	string="已出货";
            }
            row.createCell(5).setCellValue(string);
            row.createCell(6).setCellValue(list.get(i).getRemarks());
            row.createCell(7).setCellValue(TheDate.datetoString(list.get(i).getTtime()));
        }  
        // 第六步，将文件存到指定位置  
        try{  
        	FileOutputStream fout = new FileOutputStream(PathService.Path(request)+"/"+"thelibrary.xls");  
            wb.write(fout);  
            fout.close();  
            ServletContext context = request.getSession().getServletContext();  
		    //通过context方式直接获取文件的路径  
		    String path = context.getRealPath("/出库单.xls");  
		    //获取文件名  
		    String filename = path.substring(path.lastIndexOf("\\")+1);  
		    //将文件名进行URL编码  
		    filename = URLEncoder.encode(filename,"utf-8");  
		    //告诉浏览器用下载的方式打开图片  
		    response.setHeader("content-disposition", "attachment;filename="+filename);  
		    //将图片使用字节流的形式写给客户机  
		    @SuppressWarnings("resource")
			InputStream is = new FileInputStream(PathService.Path(request)+"/"+"thelibrary.xls"); //从这个路径下读取文件 
		    OutputStream out = response.getOutputStream();  
		    byte[] buffer = new byte[1024];  
		    int len = 0;  
		    while((len=is.read(buffer))!=-1){  
		        out.write(buffer, 0, len);  
		    } 
        }  
        catch (Exception e)  
        {  
            e.printStackTrace(); 
        }
	}
	
	
	/**
	 * 导出质检表
	 * @param session
	 * @param request
	 * @param response
	 */
	@RequestMapping(value="/qualityExcel")
	public void exportQuality(HttpSession session,HttpServletRequest request,HttpServletResponse response){
		 // 第一步，创建一个webbook，对应一个Excel文件  
        HSSFWorkbook wb = new HSSFWorkbook();  
        // 第二步，在webbook中添加一个sheet,对应Excel文件中的sheet  
        HSSFSheet sheet = wb.createSheet("质检表");  
        // 第三步，在sheet中添加表头第0行,注意老版本poi对Excel的行数列数有限制short  
        HSSFRow row = sheet.createRow(0);
        // 第四步，创建单元格，并设置值表头 设置表头居中  
        HSSFCellStyle style = wb.createCellStyle();  
        style.setAlignment(HSSFCellStyle.ALIGN_CENTER); // 创建一个居中格式  
  
        HSSFCell cell = row.createCell(0);  
        cell.setCellValue("编号");  
        cell.setCellStyle(style);
        
        cell = row.createCell(1);  
        cell.setCellValue("货物名称");  
        cell.setCellStyle(style);  
        
        cell = row.createCell(2);  
        cell.setCellValue("质检员工");  
        cell.setCellStyle(style);
        
        cell = row.createCell(3);  
        cell.setCellValue("检验结果");  
        cell.setCellStyle(style);
        
        cell = row.createCell(4);  
        cell.setCellValue("货物状态");  
        cell.setCellStyle(style);
        
        cell = row.createCell(5);  
        cell.setCellValue("检验时间");  
        cell.setCellStyle(style);
        
        @SuppressWarnings("unchecked")
		List<Quality> list=(List<Quality>)session.getAttribute("qualitylist");
        
        for (int i = 0; i < list.size(); i++)  
        {  
            row = sheet.createRow((int) i + 1);  
            // 第四步，创建单元格，并设置值  
            row.createCell(0).setCellValue(i+1);  
            row.createCell(1).setCellValue(list.get(i).getGoods().getGname());
            row.createCell(2).setCellValue(list.get(i).getSysusers().getUsertruename());
            row.createCell(3).setCellValue(list.get(i).getEresult()); 
            Integer state=list.get(i).getReceipt().getRstart();
            String string="";
            if(state ==1){
            	string="待检验";
            }else if(state ==2){
            	string="检验通过";
            }else if(state ==4){
            	string="检验失败";
            }
            row.createCell(4).setCellValue(string); 
            row.createCell(5).setCellValue(TheDate.datetoString(list.get(i).getEdate())); 
        }  
        // 第六步，将文件存到指定位置  
        try{  
        	FileOutputStream fout = new FileOutputStream(PathService.Path(request)+"/"+"quality.xls");  
            wb.write(fout);  
            fout.close();  
            ServletContext context = request.getSession().getServletContext();  
		    //通过context方式直接获取文件的路径  
		    String path = context.getRealPath("/质检表.xls");  
		    //获取文件名  
		    String filename = path.substring(path.lastIndexOf("\\")+1);  
		    //将文件名进行URL编码  
		    filename = URLEncoder.encode(filename,"utf-8");  
		    //告诉浏览器用下载的方式打开图片  
		    response.setHeader("content-disposition", "attachment;filename="+filename);  
		    //将图片使用字节流的形式写给客户机  
		    @SuppressWarnings("resource")
			InputStream is = new FileInputStream(PathService.Path(request)+"/"+"quality.xls"); //从这个路径下读取文件 
		    OutputStream out = response.getOutputStream();  
		    byte[] buffer = new byte[1024];  
		    int len = 0;  
		    while((len=is.read(buffer))!=-1){  
		        out.write(buffer, 0, len);  
		    } 
        }  
        catch (Exception e)  
        {  
            e.printStackTrace(); 
        }
	}
	
	
	/**
	 * 导出客户信息
	 * @param session
	 * @param request
	 * @param response
	 */
	@RequestMapping(value="/customerExcel")
	public void exportCustomer(HttpSession session,HttpServletRequest request,HttpServletResponse response){
		 // 第一步，创建一个webbook，对应一个Excel文件  
        HSSFWorkbook wb = new HSSFWorkbook();  
        // 第二步，在webbook中添加一个sheet,对应Excel文件中的sheet  
        HSSFSheet sheet = wb.createSheet("客户信息表");  
        // 第三步，在sheet中添加表头第0行,注意老版本poi对Excel的行数列数有限制short  
        HSSFRow row = sheet.createRow(0);
        // 第四步，创建单元格，并设置值表头 设置表头居中  
        HSSFCellStyle style = wb.createCellStyle();  
        style.setAlignment(HSSFCellStyle.ALIGN_CENTER); // 创建一个居中格式  
  
        HSSFCell cell = row.createCell(0);  
        cell.setCellValue("编号");  
        cell.setCellStyle(style);
        
        cell = row.createCell(1);  
        cell.setCellValue("客户编号");  
        cell.setCellStyle(style);  
        
        cell = row.createCell(2);  
        cell.setCellValue("客户联系人");  
        cell.setCellStyle(style);
        
        cell = row.createCell(3);  
        cell.setCellValue("客户公司");  
        cell.setCellStyle(style);
        
        cell = row.createCell(4);  
        cell.setCellValue("客户电话");  
        cell.setCellStyle(style);
        
        cell = row.createCell(5);  
        cell.setCellValue("客户邮箱");  
        cell.setCellStyle(style);
        
        cell = row.createCell(6);  
        cell.setCellValue("客户等级");  
        cell.setCellStyle(style);
        
        cell = row.createCell(7);  
        cell.setCellValue("客户地址");  
        cell.setCellStyle(style);
        
        @SuppressWarnings("unchecked")
		List<Customer> list=(List<Customer>)session.getAttribute("customerList");
        
        for (int i = 0; i < list.size(); i++)  
        {  
            row = sheet.createRow((int) i + 1);  
            // 第四步，创建单元格，并设置值  
            row.createCell(0).setCellValue(i+1);  
            row.createCell(1).setCellValue(list.get(i).getCkhno());
            row.createCell(2).setCellValue(list.get(i).getCname());
            row.createCell(3).setCellValue(list.get(i).getCcompany()); 
            row.createCell(4).setCellValue(list.get(i).getCphone()); 
            row.createCell(5).setCellValue(list.get(i).getCemail()); 
            row.createCell(6).setCellValue(list.get(i).getCcredit()); 
            row.createCell(7).setCellValue(list.get(i).getCaddress()); 
        }  
        // 第六步，将文件存到指定位置  
        try{  
        	FileOutputStream fout = new FileOutputStream(PathService.Path(request)+"/"+"customer.xls");  
            wb.write(fout);  
            fout.close();  
            ServletContext context = request.getSession().getServletContext();  
		    //通过context方式直接获取文件的路径  
		    String path = context.getRealPath("/客户信息表.xls");  
		    //获取文件名  
		    String filename = path.substring(path.lastIndexOf("\\")+1);  
		    //将文件名进行URL编码  
		    filename = URLEncoder.encode(filename,"utf-8");  
		    //告诉浏览器用下载的方式打开图片  
		    response.setHeader("content-disposition", "attachment;filename="+filename);  
		    //将图片使用字节流的形式写给客户机  
		    @SuppressWarnings("resource")
			InputStream is = new FileInputStream(PathService.Path(request)+"/"+"customer.xls"); //从这个路径下读取文件 
		    OutputStream out = response.getOutputStream();  
		    byte[] buffer = new byte[1024];  
		    int len = 0;  
		    while((len=is.read(buffer))!=-1){  
		        out.write(buffer, 0, len);  
		    } 
        }  
        catch (Exception e)  
        {  
            e.printStackTrace(); 
        }
	}
	
	@RequestMapping("/inventoryExcel")
	public void exportInventory(HttpSession session,HttpServletRequest request,HttpServletResponse response){
		// 第一步，创建一个webbook，对应一个Excel文件  
        HSSFWorkbook wb = new HSSFWorkbook();  
        // 第二步，在webbook中添加一个sheet,对应Excel文件中的sheet  
        HSSFSheet sheet = wb.createSheet("库位表");  
        // 第三步，在sheet中添加表头第0行,注意老版本poi对Excel的行数列数有限制short  
        HSSFRow row = sheet.createRow(0);
        // 第四步，创建单元格，并设置值表头 设置表头居中  
        HSSFCellStyle style = wb.createCellStyle();  
        style.setAlignment(HSSFCellStyle.ALIGN_CENTER); // 创建一个居中格式  
  
        HSSFCell cell = row.createCell(0);  
        cell.setCellValue("编号");  
        cell.setCellStyle(style);
        
        cell = row.createCell(1);  
        cell.setCellValue("货物名称");  
        cell.setCellStyle(style);  
        
        cell = row.createCell(2);  
        cell.setCellValue("库位名称");  
        cell.setCellStyle(style);
        
        cell = row.createCell(3);  
        cell.setCellValue("库位尺寸（m）");  
        cell.setCellStyle(style);
        
        cell = row.createCell(4);  
        cell.setCellValue("库位体积（m³）");  
        cell.setCellStyle(style);
        
        cell = row.createCell(5);  
        cell.setCellValue("承受重量（t）");  
        cell.setCellStyle(style);
        
        cell = row.createCell(6);  
        cell.setCellValue("库位等级");  
        cell.setCellStyle(style);
        
        cell = row.createCell(7);  
        cell.setCellValue("库位状态");  
        cell.setCellStyle(style);
        
        @SuppressWarnings("unchecked")
		List<Inventory> list=(List<Inventory>)session.getAttribute("inventoryList");
        
        for (int i = 0; i < list.size(); i++)  
        {  
            row = sheet.createRow((int) i + 1);  
            // 第四步，创建单元格，并设置值  
            row.createCell(0).setCellValue(i+1);  
            row.createCell(1).setCellValue(list.get(i).getGoods().getGname());
            row.createCell(2).setCellValue(list.get(i).getLoname());
            row.createCell(3).setCellValue(list.get(i).getLosize()); 
            row.createCell(4).setCellValue(list.get(i).getLovolume()); 
            row.createCell(5).setCellValue(list.get(i).getLoweight()); 
            row.createCell(6).setCellValue(list.get(i).getLolevel());
            int start = list.get(i).getLostate();
            String string="";
            if(start == 0){
            	string="开启";
            }else if(start == 1){
            	string="关闭";
            }
            row.createCell(7).setCellValue(string); 
        }  
        // 第六步，将文件存到指定位置  
        try{  
        	FileOutputStream fout = new FileOutputStream(PathService.Path(request)+"/"+"inventory.xls");  
            wb.write(fout);  
            fout.close();  
            ServletContext context = request.getSession().getServletContext();  
		    //通过context方式直接获取文件的路径  
		    String path = context.getRealPath("/库位表.xls");  
		    //获取文件名  
		    String filename = path.substring(path.lastIndexOf("\\")+1);  
		    //将文件名进行URL编码  
		    filename = URLEncoder.encode(filename,"utf-8");  
		    //告诉浏览器用下载的方式打开图片  
		    response.setHeader("content-disposition", "attachment;filename="+filename);  
		    //将图片使用字节流的形式写给客户机  
		    @SuppressWarnings("resource")
			InputStream is = new FileInputStream(PathService.Path(request)+"/"+"inventory.xls"); //从这个路径下读取文件 
		    OutputStream out = response.getOutputStream();  
		    byte[] buffer = new byte[1024];  
		    int len = 0;  
		    while((len=is.read(buffer))!=-1){  
		        out.write(buffer, 0, len);  
		    } 
        }  
        catch (Exception e)  
        {  
            e.printStackTrace(); 
        }
	}
}
