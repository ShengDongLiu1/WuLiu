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
	
	/**
	 * 算出每个货物需要的空间再乘以入库数量
	 * @param bing
	 * @param in
	 * @param count
	 * @return
	 */
	public static float jiSuan(float bing,Integer in,Integer count){
		float f1=(bing/in)*count;
		BigDecimal b = new BigDecimal(f1);
		float result = b.setScale(2, BigDecimal.ROUND_HALF_UP).floatValue();
		return result;
	}
	
	/**
	 * 保留两位小数
	 * @param num
	 * @return
	 */
	public static double keepNum(double num){
		BigDecimal b = new BigDecimal(num);
		float result = b.setScale(2, BigDecimal.ROUND_HALF_UP).floatValue();
		return result;
	}
	
	/**
	 * 保留两位小数float
	 * @param num
	 * @return
	 */
	public static float keepNumtwo(float num){
		BigDecimal b = new BigDecimal(num);
		float result = b.setScale(2, BigDecimal.ROUND_HALF_UP).floatValue();
		return result;
	}
}
