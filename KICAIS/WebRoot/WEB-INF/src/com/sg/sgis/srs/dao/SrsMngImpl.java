package com.sg.sgis.srs.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.signgate.core.exception.DaoException;


public interface SrsMngImpl {
	
	/**
	 * 기술지원요청정보 목록조회
	 * @param  paramMap
	 * @return List
	 * @throws DaoException
	 * 2011. 2. 8.
	 */
	@SuppressWarnings("unchecked")
	public List selectSrsInfo(HashMap paramMap)throws DaoException;	
	
	@SuppressWarnings("unchecked") 
	public int selectSrsInfoCount(Map map) throws DaoException;
	
	@SuppressWarnings("unchecked")
	public void insertSrsInfo(HashMap map) throws DaoException;
 
	@SuppressWarnings("unchecked")
	public void updateSrsReqEmp(HashMap map) throws DaoException;	
	
	@SuppressWarnings("unchecked")
	public void updateSrsMgr1(HashMap map) throws DaoException;	
	
	@SuppressWarnings("unchecked")
	public void updateSrsMgr2(HashMap map) throws DaoException;	
	
	@SuppressWarnings("unchecked")
	public void updateSupEmp1(HashMap map) throws DaoException;	
	
	@SuppressWarnings("unchecked")
	public void updateSupEmp2(HashMap map) throws DaoException;		
	
	@SuppressWarnings("unchecked")
	public void deleteSrsInfo(HashMap map) throws DaoException;		
	

	
	
	/**
	 * 기술지원요청검토 관리조회
	 * @param  paramMap
	 * @return List
	 * @throws DaoException
	 * 2011. 2. 8.
	 */
	@SuppressWarnings("unchecked")
	public List selectSrsReview(HashMap paramMap)throws DaoException;	
	
	@SuppressWarnings("unchecked") 
	public int selectSrsReviewCount(Map map) throws DaoException;	
	
	/**
	 * 2차 기술지원부서
	 * @param  paramMap
	 * @return List
	 * @throws DaoException
	 * 2011. 2. 8.
	 */
	@SuppressWarnings("unchecked")
	public List selectSrsMgrDept2()throws DaoException;		
	

	/**
	 * 팀장조회
	 * @param  paramMap
	 * @return List
	 * @throws DaoException
	 * 2011. 2. 8.
	 */
	@SuppressWarnings("unchecked")
	public List selectTeamLeader(HashMap paramMap)throws DaoException;	
	

}
