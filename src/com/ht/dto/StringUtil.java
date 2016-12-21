package com.ht.dto;

import java.math.BigDecimal;

/**
 * @author 
 *
 */
public class StringUtil {

	/**
	 * 是否为空
	 * @param str
	 * @return
	 */
	public static boolean isEmpty(String str){
		if(str==null||"".equals(str.trim())){
			return true;
		}else{
			return false;
		}
	}
	
	/**
	 * 是否不为空
	 * @param str
	 * @return
	 */
	public static boolean isNotEmpty(String str){
		if((str!=null)&&!"".equals(str.trim())){
			return true;
		}else{
			return false;
		}
	}
	
	/**
	 * 模糊查询
	 * @param str
	 * @return
	 */
	public static String formatLike(String str){
		if(isNotEmpty(str)){
			return "%"+str+"%";
		}else{
			return null;
		}
	}
	
	public static float jiSuan(float bing,Integer in,Integer count){
		float f1=(bing/in)*count;
		BigDecimal b = new BigDecimal(f1);
		float result = b.setScale(2, BigDecimal.ROUND_HALF_UP).floatValue();
		return result;
	}
}
