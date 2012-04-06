package sg.svc.portal.bass.schedule;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
 

import net.sf.json.JSONArray;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import sg.svc.portal.bass.schedule.domain.Schedule;
import sg.svc.portal.bass.schedule.ifac.IScheduleDao;
import sg.svc.portal.bass.techsup.ifac.ITechsupDao;

import com.signgate.core.exception.BizException;
import com.signgate.core.util.DateUtil;
 

/**
 * 일정 Biz
 * @author badangel79
 *
 */
public class ScheduleBiz {
	protected final Log logger = LogFactory.getLog(getClass());
	
	//주간 일정 시간
	public final String[] SCHEDULETIME = {
		"0000",
		"0100",
		"0200",
		"0300",
		"0400",
		"0500",
		"0600",
		"0700",
		//"0730",
		"0800",
		//"0830",
		"0900",
		//"0930",
		"1000",
		//"1030",
		"1100",
		//"1130",
		"1200",
		//"1230",
		"1300",
		//"1330",
		"1400",
		//"1430",
		"1500",
		//"1530",
		"1600",
		//"1630",
		"1700",
		//"1730",
		"1800",
		//"1830",
		"1900",
		//"1930",
		"2000",
		//"2030",
		"2100",
		//"2130",
		"2200",
		//"2230",
		"2300",
		//"2330", 
		"2400"
	};
	
	private IScheduleDao scheduleDao;
	
	public void setScheduleDao(IScheduleDao scheduleDao)
	{
		this.scheduleDao = scheduleDao;
	}
	
	private ITechsupDao techsupDao; 
	public void setTechsupDao(ITechsupDao techsupDao)
	{
		this.techsupDao = techsupDao;
	}
	
	/**
	 * 일정등록
	 *
	 * @param map
	 * @throws BizException
	 * @see 
	 */
	@SuppressWarnings("unchecked")
	public boolean insScheduleInsert(Map map) throws BizException {
		boolean retBoolean = false;
		try{ 
			
			scheduleDao.setScheduleInsert(map);
			map.put("reject_yn", "N");
			map.put("contents", map.get("title"));
			techsupDao.insertTechStatus(map);
			 
			retBoolean = true;
		}catch(Exception e){
			
			retBoolean = false;
			logger.error(e, e);
			throw new BizException("");			
		}
		
		return retBoolean;
		
	}
	/**
	 * 월별 스케줄 리스트 
	 * @param map
	 * @param request
	 * @return
	 * @throws BizException
	 */
	@SuppressWarnings("unchecked")
	public List getSchedulList(HashMap map, HttpServletRequest request) throws BizException {
		List list = new ArrayList();
		//HashMap resultMap = new HashMap();
		try{	
			list = scheduleDao.getScheduleList(map);
		}catch(Exception e){
			logger.error(e, e);
		}
		return list;
	}
	
 
	/**
	 * 주간별 스케줄 리스트 
	 * @param map
	 * @param request
	 * @return
	 * @throws BizException
	 */
	@SuppressWarnings("unchecked")
	public List getWeekSchedulList(HashMap map, HttpServletRequest request) throws BizException {
		List list = new ArrayList();
		//HashMap resultMap = new HashMap();
		try{	
			list = scheduleDao.getWeekScheduleList(map);
		}catch(Exception e){
			logger.error(e, e);
		}
		return list;
	}
	
	/**
	 * 월간 일정 날자 테이블 생성
	 * @param list
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public HashMap getSchedule(List list)
	{
		HashMap hm2 = new HashMap();   	   
	   	  
	   	   String str = "";
	   	   int n = 0;
	   	   int pren = -1;
	   	   
	   	   List list2 = null;
	   	   for(int i=0;i<list.size();i++){ 
	   		 HashMap schedule = (HashMap)list.get(i);
	 		   str = schedule.get("ST_DATE").toString().substring(0, 8);   		   
	 		   str = str.substring(6);   		   
	 		   n = Integer.parseInt(str);
	 		   
	   		   if(n != pren){   			   
	   			   list2 = new ArrayList();
	   			   
	   		   }
	   		   
	   		   list2.add(schedule);	
	   		   
	   		   if(n != pren){
	   			   hm2.put("a"+n, list2);
			   }
	   		   pren = n;  		   
	   		   
	   	   }
	   	   
	   	
	   	   return hm2;
	}
	
	/**
	 * 일정 주간 테이블 작성
	 * @param list
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public HashMap getWeekSchedule(List list)
	{
		HashMap hm2 = new HashMap();   	   
	   	  
	   	   String sDate = "";
	   	   String sTime = "";
	   	   
	   	   for(int i=0;i<list.size();i++){ 
	   		   HashMap schedule = (HashMap)list.get(i);
	   		   sDate = schedule.get("SCH_DATE").toString();   		   
	   		   sTime = schedule.get("SCH_TIME").toString();	   		   
	   		   hm2.put("a"+sDate+sTime, schedule);   		   
	   	   }
	   	   
	   	   return hm2;
	}
	
	/**
	 * 요청 날짜 테이블
	 * @param year
	 * @param month
	 * @return
	 */
	public static Object[][]getDateTable(int year, int month)
    {
	   Calendar cal = Calendar.getInstance();      
       
       cal.set(year,month-1,1);
       
       int lastDay = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
       int firstDay = cal.get(Calendar.DAY_OF_WEEK);
       Object temp[][] = new Object[6][7];
       int daycount = 1;
       
       for(int i=0;i<6;i++)
       {
            for(int j=0; j<7;j++)
            {
                if(firstDay-1 > 0 || daycount > lastDay)
                {
                    temp[i][j] = "";
                    firstDay--;
                    continue;
                }
                else
                {
                    temp[i][j] = String.valueOf(daycount);
                    daycount++;
                }
            }
       }
       
       return temp;
    }
	
	/**
	 * 주간 날짜 생성
	 * @param year
	 * @param month
	 * @param day
	 * @return
	 */
	public static String[] getWeekTable(int year, int month, int day)
    {
		String temp[] = new String[7];
		try {
		   Calendar cal = Calendar.getInstance();      
	       
	       cal.set(year,month-1,day);	       
	       
	       int firstDay = cal.get(Calendar.DAY_OF_WEEK);	       
       
	       String sSchDate = year+getNaza(month)+getNaza(day);	       
       
	       String sDate = DateUtil.getIncrementDay(sSchDate, -(firstDay-1), "yyyyMMdd");
	       String sDate2 = "";
	       for(int i=0; i<7;i++)
	       {
	    	   sDate2 = DateUtil.getIncrementDay(sDate, i, "yyyyMMdd");
	    	   temp[i] = sDate2;
	       }     
	       
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return temp;
       
    }
	
	/**
	 * 날짜 생성
	 * @param n
	 * @return
	 */
	public static String getNaza(int n)
	{
		if(n < 10) return "0"+n;
		
		return Integer.toString(n);
	}
	
	/**
	 * 스케줄 일정을 가지고 온다.
	 * @param map
	 * @return
	 * @throws BizException
	 */
	@SuppressWarnings("unchecked")
	public HashMap selScheduleView(HashMap map) throws BizException {
		HashMap schedule = new HashMap(); 
		try{
					
			schedule = scheduleDao.getScheduleView(map);
			
		}catch(Exception e){
			logger.error(e, e);
		}
		return schedule;
	}
	
	/**
	 * 일정 수정
	 *
	 * @param map
	 * @throws BizException
	 * @see 
	 */
	@SuppressWarnings("unchecked")
	public boolean updScheduleUpdate(HashMap map) throws BizException {
		boolean retBoolean = false;
		try{ 
			scheduleDao.setScheduleUpdate(map);
			
			retBoolean = true;;
		}catch(Exception e){
			retBoolean = false;
			logger.error(e, e);
			throw new BizException("");		
		}
		
		return retBoolean;
	}
	
	/**
	 * 일정 삭제
	 * @param map
	 * @return
	 * @throws BizException
	 */
	@SuppressWarnings("unchecked")
	public boolean delScheduleDelete(HashMap map) throws BizException {
		boolean retBoolean = false;
		try{
			scheduleDao.setScheduleDelete(map);
			retBoolean = true;
		}catch(Exception e){
			retBoolean = false;
			logger.error(e, e);
			throw new BizException("");
		}
		
		return retBoolean;
	}
	
	/**
	 * 일정 존재여부
	 * @param map
	 * @return
	 * @throws BizException
	 */
	@SuppressWarnings("unchecked")
	public int getScheduleCount(HashMap map) throws BizException {
		int retCnt = 0;
		try{
			String sSch_Date = map.get("sch_date").toString();			
			sSch_Date = sSch_Date.replaceAll("-","");			
			map.put("sch_date", sSch_Date);		
			
			retCnt = scheduleDao.getScheduleCount(map);
		}catch(Exception e){			
			logger.error(e, e);
			throw new BizException("");
		}
		
		return retCnt;
	}
	
	
}
