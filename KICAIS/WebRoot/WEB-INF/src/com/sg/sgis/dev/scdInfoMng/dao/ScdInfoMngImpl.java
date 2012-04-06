package com.sg.sgis.dev.scdInfoMng.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.signgate.core.exception.DaoException;

/**
 * 개발일정계획관리
 * @param  paramMap
 * @return List
 * @throws DaoException
 * 2011. 2. 8.
 */

public interface ScdInfoMngImpl {

	@SuppressWarnings("unchecked")
	public List selectScdPjdInfo(HashMap paramMap)throws DaoException;	
	
	@SuppressWarnings("unchecked") 
	public int selectScdPjdInfoCount(Map map) throws DaoException;
	
	@SuppressWarnings("unchecked")
	public List selectScdPlanInfo(HashMap map) throws DaoException;
 
	@SuppressWarnings("unchecked")
	public int selectScdPlanInfoCount(Map map) throws DaoException;	
	
	@SuppressWarnings("unchecked")
	public int selectScdPlanSeq() throws DaoException;		
	
	@SuppressWarnings("unchecked")
	public void insertScdPlanInfo(HashMap map) throws DaoException;		
	
	@SuppressWarnings("unchecked")
	public void updateScdPlanInfo(HashMap map) throws DaoException;		
	
	@SuppressWarnings("unchecked")
	public void deleteScdPlanInfo(HashMap map) throws DaoException;		

	@SuppressWarnings("unchecked")
	public List selectScdDutyAssign(HashMap paramMap)throws DaoException;	
	
	@SuppressWarnings("unchecked") 
	public int selectScdDutyAssignCount(Map map) throws DaoException;
	
	@SuppressWarnings("unchecked")
	public void insertScdDutyAssign(HashMap map) throws DaoException;		
	
	@SuppressWarnings("unchecked")
	public void updateScdDutyAssign(HashMap map) throws DaoException;		

	@SuppressWarnings("unchecked")
	public void deleteScdDutyAssign(HashMap map) throws DaoException;		

	
	@SuppressWarnings("unchecked")
	public List selectScdDayTaskInfo(HashMap paramMap)throws DaoException;	
	
	@SuppressWarnings("unchecked") 
	public int selectScdDayTaskInfoCount(Map map) throws DaoException;
	
	@SuppressWarnings("unchecked")
	public List selectScdDayInfo(HashMap paramMap)throws DaoException;	
	
	@SuppressWarnings("unchecked") 
	public int selectScdDayInfoCount(Map map) throws DaoException;	

	@SuppressWarnings("unchecked")
	public void insertScdDayInfo(HashMap map) throws DaoException;		
	
	@SuppressWarnings("unchecked")
	public void updateScdDayInfo(HashMap map) throws DaoException;		

	@SuppressWarnings("unchecked")
	public void deleteScdDayInfo(HashMap map) throws DaoException;		

	@SuppressWarnings("unchecked")
	public List selectScdExecPrpdInfo(HashMap paramMap)throws DaoException;	
	
	@SuppressWarnings("unchecked") 
	public int selectScdExecPrpdInfoCount(Map map) throws DaoException;	
	
	@SuppressWarnings("unchecked")
	public void insertScdExecPrpdInfo(HashMap map) throws DaoException;		
	
	@SuppressWarnings("unchecked")
	public void updateScdExecPrpdInfo(HashMap map) throws DaoException;		

	@SuppressWarnings("unchecked")
	public void deleteScdExecPrpdInfo(HashMap map) throws DaoException;		
	
	@SuppressWarnings("unchecked")
	public int selectScdDaySeqCount(Map map) throws DaoException;		
	
	@SuppressWarnings("unchecked")
	public List selectScdExecPrpdInfoPop(HashMap paramMap)throws DaoException;	
	
	@SuppressWarnings("unchecked") 
	public int selectScdExecPrpdInfoPopCount(Map map) throws DaoException;		
	
	@SuppressWarnings("unchecked")
	public int selectScdDayInfoTaskCnt(HashMap paramMap) throws DaoException;
	
	@SuppressWarnings("unchecked")
	public int selectScdDayInfoRegEmpCnt(HashMap paramMap) throws DaoException;	
	
	
	@SuppressWarnings("unchecked")
	public Object getDownloadFile(HashMap map) throws DaoException;	
}
