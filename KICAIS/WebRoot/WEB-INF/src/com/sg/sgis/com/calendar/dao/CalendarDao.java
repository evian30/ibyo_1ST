package com.sg.sgis.com.calendar.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.signgate.core.dao.BaseDao;
import com.signgate.core.exception.DaoException;

public class CalendarDao extends BaseDao implements CalendarDaoImpl {
	protected final Log logger = LogFactory.getLog(getClass());
	 
	@SuppressWarnings("unchecked") 
	public int selectCalDayCount(Map map) throws DaoException{
		return queryForInt("Calendar.selectCalDayCount",map); 
	}
	 
	@SuppressWarnings("unchecked")
	public List selectCalDay(Map map) throws DaoException{
		return queryForList("Calendar.selectCalDay", map);
	}	
		 
	@SuppressWarnings("unchecked")
	public void insertCalDay(HashMap map) throws DaoException{
		insert("Calendar.insertCalDay", map);
	} 
 
	@SuppressWarnings("unchecked")
	public void updateCalDay(HashMap map) throws DaoException{
		update("Calendar.updateCalDay", map);
	} 
	
	@SuppressWarnings("unchecked")
	public void deleteCalDay(Map map) throws DaoException{
		delete("Calendar.deleteCalDay", map);
	}
	
	@SuppressWarnings("unchecked")
	public HashMap selectCalDayView(Map map) throws DaoException{
		return (HashMap)queryForObject("Calendar.selectCalDayView", map);
	}
	 
	@SuppressWarnings("unchecked")
	public List selectComboCode(String searchCode)throws DaoException{ 
		return  queryForList("Calendar.selectComboCode",searchCode);
	}
	 

	public List selectSchedule(HashMap paramMap) throws DaoException {
		return  queryForList("Calendar.selectSchedule",paramMap);
	} 
	
	@SuppressWarnings("unchecked")
	public void insertSchedule(HashMap map) throws DaoException{
		insert("Calendar.insertSchedule", map);
	} 
 
	@SuppressWarnings("unchecked")
	public void updateSchedule(HashMap map) throws DaoException{
		update("Calendar.updateSchedule", map);
	} 
	
	@SuppressWarnings("unchecked")
	public void deleteSchedule(Map map) throws DaoException{
		delete("Calendar.deleteSchedule", map);
	}
	
	
	
	@SuppressWarnings("unchecked") 
	public int selectAllScheduleCount(Map map) throws DaoException{
		return queryForInt("Calendar.selectAllScheduleCount",map); 
	}
	 
	@SuppressWarnings("unchecked")
	public List selectAllSchedule(Map map) throws DaoException{
		return queryForList("Calendar.selectAllSchedule", map);
	}	
	
}
