package com.weeklyreport.programmer.filter;
/**
 * @author Chiho
 * 拦截用户没有登录状态下的操作
 * 
 */
import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class LoginFilter implements Filter {

	@Override
	public void doFilter(ServletRequest req, ServletResponse rep, FilterChain chain)
			throws IOException, ServletException {
		// TODO Auto-generated method stub
		HttpServletRequest request = (HttpServletRequest) req;
		HttpServletResponse response =(HttpServletResponse) rep;
		Object user = request.getSession().getAttribute("user");
		if(user == null) {
			//未登录
			response.sendRedirect("index.jsp");
			return;
		}else {
			chain.doFilter(request, response);
		}
		
	}
	public void init(FilterConfig arg0) throws ServletException {
		// TODO Auto-generated method stub

	}

}






























