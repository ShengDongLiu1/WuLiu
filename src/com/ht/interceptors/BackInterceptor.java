package com.ht.interceptors;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;
import com.ht.entity.sysuser;

public class BackInterceptor implements HandlerInterceptor {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		HttpSession session = request.getSession();
		
		sysuser sysuser = (sysuser) session.getAttribute("user");
		if(sysuser==null){
			
			request.setAttribute("msg", "请登录");
			request.getRequestDispatcher("/user/login").forward(request, response);
			
			return false;
		}/*else{
			String lock=(String) session.getAttribute("lockUser");
			if(lock != null){
				request.getRequestDispatcher("/WEB-INF/views/index.jsp").forward(request, response);
				return false;
			}
		}*/
		return true;
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {

	}

	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {

	}

}
