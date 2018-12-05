package com.weeklyreport.programmer.util;
/**
 * 
 * @author Chiho
 *string类公用操作方法
 */
public class StringUtil {
	public static boolean isEmpty(String str) {
		if(str == null || "".equals(str))return true;
		return false;
	}
}
