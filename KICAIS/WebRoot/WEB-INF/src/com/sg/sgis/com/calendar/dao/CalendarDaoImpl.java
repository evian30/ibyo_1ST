package com.sg.sgis.com.calendar.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.signgate.core.exception.DaoException;

public interface CalendarDaoImpl {	 
	
	@SuppressWarnings("unchecked") 
	public int selectCalDayCount(Map map) throws DaoException;
	 
	@SuppressWarnings("unchecked")
	public List selectCalDay(Map map) throws DaoException;
		 
	@SuppressWarnings("unchecked")
	public void insertCalDay(HashMap map) throws DaoException;
 
	@SuppressWarnings("unchecked")
	public void updateCalDay(HashMap map) throws DaoException;
	
	@SuppressWarnings("unchecked")
	public void deleteCalDay(Map map) throws DaoException;
	
	@SuppressWarnings("unchecked")
	public HashMap selectCalDayView(Map map) throws DaoException;

	@SuppressWarnings("unchecked")
	public List selectComboCode(String searchCode)throws DaoException;
	
	@SuppressWarnings("unchecked")
	public List selectSchedule(HashMap paramMap)throws DaoException;
	
	@SuppressWarnings("unchecked")
	public void insertSchedule(HashMap map) throws DaoException;
 
	@SuppressWarnings("unchecked")
	public void updateSchedule(HashMap map) throws DaoException;
	
	@SuppressWarnings("unchecked")
	public void deleteSchedule(Map map) throws DaoException;
	
	@SuppressWarnings("unchecked") 
	public int selectAllScheduleCount(Map map) throws DaoException;
	 
	@SuppressWarnings("unchecked")
	public List selectAllSchedule(Map map) throws DaoException;
	
}
 