package com.sg.sgis.com.calendar;

import java.util.HashMap;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import sg.svc.portal.util.NewPageNavigator;

import com.sg.sgis.com.calendar.dao.CalendarDaoImpl;
import com.signgate.core.exception.BizException;
import com.signgate.core.exception.DaoException;
import com.signgate.core.web.util.WebUtil;

public class CalendarBiz {
	protected final Log logger = LogFactory.getLog(getClass());
	
	CalendarDaoImpl calendarDao;
	public void setCalendarDao(CalendarDaoImpl calendarDao) {
		this.calendarDao = calendarDao;
	} 
	
	
	@SuppressWarnings("unchecked")
	public List selectCalDay(HashMap paramMap){
		List list = null;
		
		try{ 
		
			list = calendarDao.selectCalDay(paramMap);
			
		}catch(Exception e){
			logger.error("::"+this.getClass()+"\n<기념일관리 목록 BIZ 에러>::::\n"+e.toString()); 
		}
		return list;
	}
	
	
	@SuppressWarnings("unchecked")
	public int selectCalDayCount(HashMap map) throws Exception{
		int cnt = 0;
		try{ 
			cnt = calendarDao.selectCalDayCount(map);			 
		}catch(Exception e){
			logger.error("::"+this.getClass()+"\n<기념일관리 카운트 BIZ 에러>::::\n"+e.toString()); 
			throw new Exception();
		}
		return cnt;
	}
	
	
	@SuppressWarnings("unchecked")
	public boolean calDayAction(HashMap map) throws BizException{
		boolean retTrue = false;
		try{ 
			
			if(map.get("isNew").equals("") ) 					 
				calendarDao.updateCalDay(map);
			else if(map.get("isNew").equals("yes"))					
				calendarDao.insertCalDay(map);
			
			retTrue = true;
			
		}catch(Exception e){
			retTrue = false;
			logger.error("::::::::::"+this.getClass()+e.toString());
			throw new  BizException("\n에러가 발생 하였습니다." + "\n<기념일관리 처리 BIZ 에러>::::\n"+this.getClass()+e.toString());
		}
		return retTrue;
		
	} 
	
	 
	@SuppressWarnings("unchecked")
	public List selectComboCode(String searchCode){
		List list = null; 
		
		try{
			list = calendarDao.selectComboCode(searchCode); 
			
		}catch(Exception e){
			e.printStackTrace();
			logger.error(e, e);
		}
		return list;
	}
	
	

	@SuppressWarnings("unchecked")
	public List selectSchedule(HashMap paramMap){
		List list = null;
		
		try{ 
		
			list = calendarDao.selectSchedule(paramMap);
			
		}catch(Exception e){
			logger.error("::"+this.getClass()+"\n<일정 목록 BIZ 에러>::::\n"+e.toString()); 
		}
		return list;
	}
	 
	
	public boolean actionSchedule(HashMap paramMap)throws BizException {
		
		boolean result = true;
		try{

			if((paramMap.get("scd_day_seq").toString()).equals("")){
				calendarDao.insertSchedule(paramMap);
			}else if(Integer.parseInt(paramMap.get("scd_day_seq").toString()) > 0){  
				calendarDao.updateSchedule(paramMap);
			}
			 
		}catch(Exception e){
			result = false;
			logger.error("::::::::::"+this.getClass()+e.toString());
		}finally{

		} 
			return result;
	}
	
	
	
public boolean deleteSchedule(HashMap paramMap)throws BizException {
		
		boolean result = true;
		try{ 
			
			if(("del").equals(paramMap.get("flag"))){ 
				calendarDao.deleteSchedule(paramMap);
			}
			
		}catch(Exception e){
			result = false;
			logger.error("::::::::::"+this.getClass()+e.toString());
		}finally{

		} 
			return result;
	}
	


	@SuppressWarnings("unchecked")
	public List selectAllSchedule(HashMap paramMap){
		List list = null;
		
		try{ 
		
			list = calendarDao.selectAllSchedule(paramMap);
			
		}catch(Exception e){
			logger.error("::"+this.getClass()+"\n<목록 BIZ 에러>::::\n"+e.toString()); 
		}
		return list;
	}
	
	
	@SuppressWarnings("unchecked")
	public int selectAllScheduleCount(HashMap map) throws Exception{
		int cnt = 0;
		try{ 
			cnt = calendarDao.selectAllScheduleCount(map);			 
		}catch(Exception e){
			logger.error("::"+this.getClass()+"\n<카운트 BIZ 에러>::::\n"+e.toString()); 
			throw new Exception();
		}
		return cnt;
	}

	
}
