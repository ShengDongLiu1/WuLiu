package com.ht.dto;

import java.util.Calendar;
import java.util.Date;

/**
 * 今天星期几
 * @author Crazy
 *
 */
public class Lastweek {
	public static int weekDate(){
        Calendar c = Calendar.getInstance();
        Date date = new Date();
        c.setTime(date);
        int today=c.get(Calendar.DAY_OF_WEEK);
        System.out.println("今天星期："+(today-1));
        
		return today;
	}
}
