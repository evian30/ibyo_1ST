package com.sg.sgis.com.empVac.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.signgate.core.exception.DaoException;

public interface EmpVacUsedInfoDaoImpl {
	/**
	 * 개인별휴가사용정보 목록조회
	 * @param  paramMap
	 * @return List
	 * @throws DaoException
	 * 2011. 2. 8.
	 */
	@SuppressWarnings("unchecked")
	public List selectEmpVacUsedList(HashMap paramMap)throws DaoException;
	
	
	@SuppressWarnings("unchecked") 
	public int selectEmpVacUsedCount(Map map) throws DaoException;
	
 	
	@SuppressWarnings("unchecked")
	public void insertEmpVacUsed(HashMap map) throws DaoException;
 
	@SuppressWarnings("unchecked")
	public void updateEmpVacUsed(HashMap map) throws DaoException;	
	
	@SuppressWarnings("unchecked")
	public void deleteEmpVacUsed(HashMap map) throws DaoException;	
	
	@SuppressWarnings("unchecked") 
	public int selectEmpVacDaysCount(Map map) throws DaoException;
	
	@SuppressWarnings("unchecked") 
	public int selectEmpVacTotCount(Map map) throws DaoException;	
		
}
