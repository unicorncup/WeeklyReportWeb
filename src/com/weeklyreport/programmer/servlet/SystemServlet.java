package com.weeklyreport.programmer.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
/**
 * 
 * @author Chiho
 *系统登录后主页面
 */
public class SystemServlet extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = -5494249955973522822L;

	public void doGet(HttpServletRequest request,HttpServletResponse response) throws IOException{
		doPost(request, response);
	}
	public void doPost(HttpServletRequest request,HttpServletResponse response) throws IOException{
		HttpSession session = request.getSession();
		
		try {
			request.getRequestDispatcher("view/system.jsp").forward(request, response);
		} catch (ServletException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}



	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	












