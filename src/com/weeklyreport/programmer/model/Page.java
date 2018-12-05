package com.weeklyreport.programmer.model;
/**
 * 
 * @author Chiho
 *分页类页码封装
 */
public class Page {
	private int start;//起始页
	private int currentPage;//当前页面
	private int pageSize;//每一页面显示数量
	public Page(int currentPage,int pageSize){
		this.start = (currentPage-1)*pageSize;
		this.currentPage = currentPage;
		this.pageSize = pageSize;
	}
	public int getStart() {
		return start;
	}
	public void setStart(int start) {
		this.start = start;
	}
	public int getCurrentPage() {
		return currentPage;
	}
	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}
	public int getPageSize() {
		return pageSize;
	}
	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}
	
}
