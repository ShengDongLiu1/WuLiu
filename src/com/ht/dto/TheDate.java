package com.ht.dto;

import java.text.SimpleDateFormat;
import java.util.Date;

public class TheDate {
	/**
	 * 把util时间格式转换成字符串
	 * @param date
	 * @return
	 */
	public static String datetoString(Date date){
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String dateTime=null;
		if(date != null){
			dateTime = sdf.format(date);
		}
		return dateTime;
	}
	
	/**
	 * 把String字符串转换成util格式
	 * @param date
	 * @return
	 */
	public static Date stringtoDate(String time) throws Exception{
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date date = null;
		if(time != null && !"".equals(time)){
			sdf.parse(time);
		}
		return date;
	}
}
