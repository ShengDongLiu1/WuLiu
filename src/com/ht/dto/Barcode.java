package com.ht.dto;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileOutputStream;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import org.jbarcode.JBarcode;
import org.jbarcode.encode.Code128Encoder;
import org.jbarcode.encode.Code39Encoder;
import org.jbarcode.encode.InvalidAtributeException;
import org.jbarcode.paint.BaseLineTextPainter;
import org.jbarcode.paint.EAN13TextPainter;
import org.jbarcode.paint.WideRatioCodedPainter;
import org.jbarcode.paint.WidthCodedPainter;
import org.jbarcode.util.ImageUtil;

/**
 * 条形码生成
 * @author Crazy
 *
 */
public class Barcode {
	
	public String createCode(HttpServletRequest request){
		
		DateFormat format=new SimpleDateFormat("yyMMddHHmm");
    	String time=format.format(new Date());
    	int in=(int)((Math.random()*9+1)*100000);
		JBarcode localJBarcode = new JBarcode(Code128Encoder.getInstance(), WidthCodedPainter.getInstance(), EAN13TextPainter.getInstance());  
		localJBarcode.setEncoder(Code39Encoder.getInstance());  
		localJBarcode.setPainter(WideRatioCodedPainter.getInstance());  
		localJBarcode.setTextPainter(BaseLineTextPainter.getInstance());  
		localJBarcode.setShowCheckDigit(false);  
		//xx  
		String str = "WP"+in+time;  
		System.out.println("str:"+str);
		BufferedImage localBufferedImage;
		try {
			localBufferedImage = localJBarcode.createBarcode(str);
			saveToFile(localBufferedImage, "WP"+in+time+".png","png",request);
		} catch (InvalidAtributeException e) {
			e.printStackTrace();
		} 
		return str;
	}
	
	public void saveToFile(BufferedImage paramBufferedImage, String paramString1, String paramString2,HttpServletRequest request){  
	try {  
			File headPath=new File(request.getSession().getServletContext().getRealPath("/")+"storagebarcode");
			if(!headPath.exists()){
				headPath.mkdirs();
			}
			System.out.println("headPath:"+headPath);
			FileOutputStream localFileOutputStream = new FileOutputStream(headPath +"/"+ paramString1);  
			ImageUtil.encodeAndWrite(paramBufferedImage, paramString2, localFileOutputStream, 96, 96);  
			localFileOutputStream.close();  
		} catch (Exception localException){  
			localException.printStackTrace();  
		}  
	}  
}
