package com.ht.dto;

import java.io.File;

import javax.servlet.http.HttpServletRequest;

public class PathService {
	/**
	 * 获取路径，用于临时保存excel表格
	 * @param request
	 * @return
	 */
	public static File Path(HttpServletRequest request){
		File pathServer=new File(request.getSession().getServletContext().getRealPath("/")+"excel");
    	if(!pathServer.exists()){
    		pathServer.mkdirs();
		}
    	return pathServer;
	}
}
