package com.ht.ssm.util;

public class Createstring {
	
	 public static String random(){//传入的字符串的长度
	        StringBuilder builder = new StringBuilder(7);
	        for(int i = 0; i < 7; i++){
	            int r = (int) (Math.random()*3);
	            int rn1=(int)(48+Math.random()*10);
	            int rn2=(int)(65+Math.random()*26);
	           // int rn3=(int)(97+Math.random()*26);
	            switch(r){
	            case 0:   
	                builder.append((char)rn1);
	                break;
	            case 1:
	                builder.append((char)rn2);
	                break;
	            }
	        }
	        return builder.toString();
	    }    
	    public static void main(String[] args){
	        String s = Createstring.random();
	        System.out.println(s);
	    }
}
