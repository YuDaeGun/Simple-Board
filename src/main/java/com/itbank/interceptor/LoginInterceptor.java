package com.itbank.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class LoginInterceptor extends HandlerInterceptorAdapter {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		HttpSession session = request.getSession();
		String url = request.getRequestURL().toString();
		
		if(session.getAttribute("login") == null) {
			response.sendRedirect(request.getContextPath() + "/member/login?url=" + url);
			return false;
		}
		return true;
	}
}
