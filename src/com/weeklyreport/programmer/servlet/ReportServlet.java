package com.weeklyreport.programmer.servlet;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.weeklyreport.programmer.dao.ReportDao;
import com.weeklyreport.programmer.model.Page;
import com.weeklyreport.programmer.model.Report;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
/**
 * 
 * @author Chiho
 *周报告信息管理servlet
 */

public class ReportServlet extends HttpServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = -8493863714134726229L;
	public void doGet(HttpServletRequest request,HttpServletResponse response) throws IOException{
		doPost(request, response);
	}
	public void doPost(HttpServletRequest request,HttpServletResponse response) throws IOException{
		String method = request.getParameter("method");
		if("toReportListView".equals(method)){
			reportList(request,response);
		}else if("getReportList".equals(method)){
			getReportList(request, response);
		}else if("AddReport".equals(method)){
			addReport(request, response);
		}else if("DeleteReport".equals(method)){
			deleteReport(request, response);
		}else if("EditReport".equals(method)){
			editReport(request, response);
		}
	}
	private void editReport(HttpServletRequest request,
			HttpServletResponse response) {
		// TODO Auto-generated method stub
		Integer id = Integer.parseInt(request.getParameter("id"));
		String name = request.getParameter("name"); 
		String reportname = request.getParameter("reportname"); 
		String info1 = request.getParameter("info1");
		String info2 = request.getParameter("info2");
		String info3 = request.getParameter("info3");
		String score = request.getParameter("score"); 
		String info = request.getParameter("info");
		Report report = new Report();
		report.setName(name);
		report.setReportname(reportname);
		report.setInfo1(info1);
		report.setInfo2(info2);
		report.setInfo3(info3);
		report.setScore(score);
		report.setInfo(info);
		report.setId(id);
		ReportDao reportDao = new ReportDao();
		if(reportDao.editReport(report)){
			try {
				response.getWriter().write("success");
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}finally{
				reportDao.closeCon();
			}
		}
	}
	private void deleteReport(HttpServletRequest request,
			HttpServletResponse response) {
		// TODO Auto-generated method stub
		Integer id = Integer.parseInt(request.getParameter("reportid"));
		ReportDao reportDao = new ReportDao();
		if(reportDao.deleteReport(id)){
			try {
				response.getWriter().write("success");
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}finally{
				reportDao.closeCon();
			}
		}
	}
	private void addReport(HttpServletRequest request,
			HttpServletResponse response) {
		// TODO Auto-generated method stub
		String name = request.getParameter("name"); 
		String reportname = request.getParameter("reportname");
		String info1 = request.getParameter("info1");
		String info2 = request.getParameter("info2");
		String info3 = request.getParameter("info3");
		String score = request.getParameter("score");
		String info = request.getParameter("info");
		Report report = new Report();
		report.setName(name);
		report.setReportname(reportname);
		report.setInfo1(info1);
		report.setInfo2(info2);
		report.setInfo3(info3);
		report.setScore(score);
		report.setInfo(info);
		ReportDao reportDao = new ReportDao();
		if(reportDao.addReport(report)){
			try {
				response.getWriter().write("success");
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}finally{
				reportDao.closeCon();
			}
		}
		
	}
	private void reportList(HttpServletRequest request,
			HttpServletResponse response) {
		// TODO Auto-generated method stub
		try {
			request.getRequestDispatcher("view/reportList.jsp").forward(request, response);
		} catch (ServletException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	private void getReportList(HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub
		String name = request.getParameter("reportName");
		Integer currentPage = request.getParameter("page") == null ? 1 : Integer.parseInt(request.getParameter("page"));
		Integer pageSize = request.getParameter("rows") == null ? 999 : Integer.parseInt(request.getParameter("rows"));
//		Integer clazz = request.getParameter("clazzid") == null ? 0 : Integer.parseInt(request.getParameter("clazzid"));
		int userType = Integer.parseInt(request.getSession().getAttribute("userType").toString());
		Report report = new Report();
		report.setName(name);
		
		ReportDao reportDao = new ReportDao();
		List<Report> reportList = reportDao.getReportList(report, new Page(currentPage, pageSize));
		int total = reportDao.getReportListTotal(report);
		reportDao.closeCon();
		response.setCharacterEncoding("UTF-8");
		Map<String, Object> ret = new HashMap<String, Object>();
		ret.put("total", total);
		ret.put("rows", reportList);
		try {
			String from = request.getParameter("from");
			if("combox".equals(from)){
				response.getWriter().write(JSONArray.fromObject(reportList).toString());
			}else{
				response.getWriter().write(JSONObject.fromObject(ret).toString());
			}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
