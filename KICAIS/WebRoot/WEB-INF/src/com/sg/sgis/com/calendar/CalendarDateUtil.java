package com.sg.sgis.com.calendar;

import java.text.ParsePosition;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
  
public class CalendarDateUtil {
    protected static final Log logger = LogFactory.getLog(CalendarDateUtil.class); 
    
       
	//날짜와 시간 가져오기
	public static String getYear(){
		Calendar calendar = Calendar.getInstance();
		return Integer.toString(calendar.get(Calendar.YEAR));
	}
	
	//현재 월 가져오기
	 public static String getMonth(){
		Calendar now = Calendar.getInstance();
		int monthN  = now.get(Calendar.MONTH)+1;
		String MON  = (monthN<10)? "0"+Integer.toString(monthN):Integer.toString(monthN) ;
		
		return MON;
	 }
	 
	//현재 일자 가져오기
	public static String getDay(){
		Calendar now = Calendar.getInstance();
		int dayN     = now.get(Calendar.DAY_OF_MONTH);
		if(dayN <10){
		  	 return '0' + Integer.toString(dayN);
		}
		return Integer.toString(dayN);
	}
	
	public static String getDate(){ //년-월-일
		java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd");
		return  formatter.format(new java.util.Date());
	}
	public static String getTime(){ //년-월-일 시:분:초
		java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		return  formatter.format(new java.util.Date());
	}
	public static String getTime2(){ //시:분:초
		java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("HHmmss");
		return  formatter.format(new java.util.Date());
	}
	
	public static String getHour(){ //시:분:초
		java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("HH");
		return  formatter.format(new java.util.Date());
	}
	
	public static int getDateNum(){
		java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyyMMdd");
		return  Integer.parseInt(formatter.format(new java.util.Date()));
	}
	public static int getNum(){
		java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyyMM");
		return  Integer.parseInt(formatter.format(new java.util.Date()));
	}
	
	//한달전 일자 가져오기, sDay:현재일자 sMM:개월수(1은 1개월)
	public String getLastMonth() {
		Calendar cal = new GregorianCalendar();
	
		String sDay = getTime().substring(0,10); 
		String sMM = "1";
	
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		Date d = df.parse(sDay, new ParsePosition(0)); 
	
		cal.setTime(d);
		cal.add(Calendar.MONTH, -Integer.parseInt(sMM));
	
		return df.format(cal.getTime());
	}
	
	//	한달후 일자 가져오기, sDay:현재일자 sMM:개월수(1은 1개월)
	public String getNextMonth() {
		Calendar cal = new GregorianCalendar();
	
		String sDay = getTime().substring(0,10);
		String sMM = "1";
	
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		Date d = df.parse(sDay, new ParsePosition(0));
	
		cal.setTime(d);
		cal.add(Calendar.MONTH, Integer.parseInt(sMM));
	
		return df.format(cal.getTime());
	}
	
	//두달전 일자 가져오기, sDay:현재일자 sMM:개월수(1은 1개월)
	public String getLast2Month() {
		Calendar cal = new GregorianCalendar();
	
		String sDay = getTime().substring(0,10); 
		String sMM = "2";
	
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		Date d = df.parse(sDay, new ParsePosition(0)); 
	
		cal.setTime(d);
		cal.add(Calendar.MONTH, -Integer.parseInt(sMM));
	
		return df.format(cal.getTime());
	}
	
	//두달후 일자 가져오기, sDay:현재일자 sMM:개월수(1은 1개월)
	public String getNext2Month() {
		Calendar cal = new GregorianCalendar();
	
		String sDay = getTime().substring(0,10);
		String sMM = "2";
	
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		Date d = df.parse(sDay, new ParsePosition(0));
	
		cal.setTime(d);
		cal.add(Calendar.MONTH, Integer.parseInt(sMM));
	
		return df.format(cal.getTime());
	}
	
	//	어제 일자 가져오기, sDay:현재일자 sMM:일수(1은 1일)
	public String getLastDate() {
		Calendar cal = new GregorianCalendar();
	
		String sDay = getTime().substring(0,10);
		String sMM = "1";
	
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		Date d = df.parse(sDay, new ParsePosition(0));
	
		cal.setTime(d);
		cal.add(Calendar.DATE, -Integer.parseInt(sMM));
	
		return df.format(cal.getTime());
	}
	
	//두 날짜 차이값 비교, sDay:일자1 pDay:일자2
	public long getDiffDate(String day1, String day2) {
	
		long retVal = 0;
		String sDay = day1;
		String pDay = day2;
		
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		
		Date d1 = df.parse(sDay, new ParsePosition(0));
		Date d2 = df.parse(pDay, new ParsePosition(0));
		
		retVal = (d1.getTime() - d2.getTime()) / (1000*60*60*24);
			
		return retVal;
	}	
}