package com.sg.sgis.com.empVac.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.signgate.core.exception.DaoException;

public interface EmpVacInfoDaoImpl {

	/**
	 * 개인별휴가정보 목록조회
	 * @param  paramMap
	 * @return List
	 * @throws DaoException
	 * 2011. 2. 8.
	 */
	@SuppressWarnings("unchecked")
	public List selectEmpVacList(HashMap paramMap)throws DaoException;
	
	
	@SuppressWarnings("unchecked") 
	public int selectEmpVacCount(Map map) throws DaoException;
	
	@SuppressWarnings("unchecked") 
	public int selectEmpVacSavedCount(Map map) throws DaoException;
	
 	
	@SuppressWarnings("unchecked")
	public void insertEmpVac(HashMap map) throws DaoException;
 
	@SuppressWarnings("unchecked")
	public void updateEmpVac(HashMap map) throws DaoException;	
	
	@SuppressWarnings("unchecked")
	public void deleteEmpVac(HashMap map) throws DaoException;		
}
