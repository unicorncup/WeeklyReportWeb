package com.weeklyreport.programmer.util;

public class SnGenerateUtil {
	public static String generateSn(int clazzId){
		String sn = "";
		sn = "S" + clazzId + System.currentTimeMillis();
		return sn;
	}
	public static String generateTeacherSn(int clazzId){
		String sn = "";
		sn = "T" + clazzId + System.currentTimeMillis();
		return sn;
	}
	public static String generateSn1(int teacherId){
		String sn = "";
		sn = "S" + teacherId + System.currentTimeMillis();
		return sn;
	}
}
