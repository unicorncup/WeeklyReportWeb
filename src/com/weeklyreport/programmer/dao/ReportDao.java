package com.weeklyreport.programmer.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.weeklyreport.programmer.model.Report;
import com.weeklyreport.programmer.model.Page;
import com.weeklyreport.programmer.util.StringUtil;

/**
 * 
 * @author Chiho
 *周报告信息数据库操作
 */
public class ReportDao extends BaseDao {
	public List<Report> getReportList(Report report,Page page){
		List<Report> ret = new ArrayList<Report>();
		String sql = "select * from s_report ";
		if(!StringUtil.isEmpty(report.getName())){
			sql += "where name like '%" + report.getName() + "%'";
		}
		sql += " limit " + page.getStart() + "," + page.getPageSize();
		ResultSet resultSet = query(sql);
		try {
			while(resultSet.next()){
				Report re = new Report();
				re.setId(resultSet.getInt("id"));
				re.setName(resultSet.getString("name"));
				re.setReportname(resultSet.getString("reportname"));
				re.setInfo1(resultSet.getString("info1"));
				re.setInfo2(resultSet.getString("info2"));
				re.setInfo3(resultSet.getString("info3"));
				re.setScore(resultSet.getString("score"));
				re.setInfo(resultSet.getString("info"));
				ret.add(re);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return ret;
	}
	public int getReportListTotal(Report report){
		int total = 0;
		String sql = "select count(*)as total from s_report ";
		if(!StringUtil.isEmpty(report.getName())){
			sql += "where name like '%" + report.getName() + "%'";
		}
		ResultSet resultSet = query(sql);
		try {
			while(resultSet.next()){
				total = resultSet.getInt("total");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return total;
	}
	public boolean addReport(Report report){
		String sql = "insert into s_report values(null,'"+report.getName()+"','"+report.getReportname()+"','"+report.getInfo1()+"','"+report.getInfo2()+"','"+report.getInfo3()+"','"+report.getScore()+"','"+report.getInfo()+"') ";
		return update(sql);
	}
	public boolean deleteReport(int id){
		String sql = "delete from s_report where id = "+id;
		return update(sql);
	}
	public boolean editReport(Report report) {
		// TODO Auto-generated method stub
		String sql = "update s_report set name = '"+report.getName()+"',reportname= '"+report.getReportname()+"',info1= '"+report.getInfo1()+"',info2= '"+report.getInfo2()+"',info3= '"+report.getInfo3()+"',score= '"+report.getScore()+"',info = '"+report.getInfo()+"' where id = " + report.getId();
		return update(sql);
	}
	
}
