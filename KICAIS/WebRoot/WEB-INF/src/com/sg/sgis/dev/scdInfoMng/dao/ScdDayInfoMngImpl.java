package com.sg.sgis.dev.scdInfoMng.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.signgate.core.exception.DaoException;

public interface ScdDayInfoMngImpl {	 
	
	@SuppressWarnings("unchecked")
	public List selectComboCode(String searchCode)throws DaoException;
	
	@SuppressWarnings("unchecked")
	public List selectSchedule(HashMap paramMap)throws DaoException;

	@SuppressWarnings("unchecked") 
	public int selectScheduleCount(Map map) throws DaoException;	
	
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
	
	@SuppressWarnings("unchecked")
	public String getDeptCode(String emp_num) throws DaoException;
	
	@SuppressWarnings("unchecked")
	public String getDeptNm(String dept_code) throws DaoException;	
	
	@SuppressWarnings("unchecked")
	public void updateScheduleTaskChkResCode(HashMap map) throws DaoException;	
	
	@SuppressWarnings("unchecked")
	public List selectScheduleReview(HashMap paramMap)throws DaoException;

	@SuppressWarnings("unchecked") 
	public int selectScheduleReviewCount(Map map) throws DaoException;	

	@SuppressWarnings("unchecked") 
	public int selectScdTotTaskCount(Map map) throws DaoException;	
	
	@SuppressWarnings("unchecked") 
	public int selectScdDaySeqCount(Map map) throws DaoException;	
	
	@SuppressWarnings("unchecked")
	public void updatePjtInfoStatus(HashMap map) throws DaoException;	
	
	@SuppressWarnings("unchecked") 
	public int selectTaskEndYnCount(Map map) throws DaoException;	
	
	@SuppressWarnings("unchecked")
	public void updateCsrPatternItemDealYn(HashMap map) throws DaoException;	
	
	@SuppressWarnings("unchecked") 
	public int selectScdDayInfoSeq() throws DaoException;	

}
 