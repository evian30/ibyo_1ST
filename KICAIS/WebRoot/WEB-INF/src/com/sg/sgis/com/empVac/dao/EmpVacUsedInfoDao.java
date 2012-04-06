package com.sg.sgis.com.empVac.dao;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.signgate.core.dao.BaseDao;
import com.signgate.core.exception.DaoException;

public class EmpVacUsedInfoDao extends BaseDao implements EmpVacUsedInfoDaoImpl{

	protected final Log logger = LogFactory.getLog(getClass());
	
	/**
	 * 개인별휴가사용정보 목록조회
	 * @param  paramMap
	 * @return List
	 * @throws DaoException
	 * 2011. 2. 8.
	 */
	@SuppressWarnings("unchecked")
	public List selectEmpVacUsedList(HashMap paramMap) throws DaoException{
		return  queryForList("EmpVacUsed.selectEmpVacUsedList",paramMap);
	}
	
	@SuppressWarnings("unchecked") 
	public int selectEmpVacUsedCount(Map map) throws DaoException{
		return queryForInt("EmpVacUsed.selectEmpVacUsedCount",map); 
	} 
 
	@SuppressWarnings("unchecked")
	public void insertEmpVacUsed(HashMap map) throws DaoException{
		insert("EmpVacUsed.insertEmpVacUsed", map);
	} 
 
	@SuppressWarnings("unchecked")
	public void updateEmpVacUsed(HashMap map) throws DaoException{
		update("EmpVacUsed.updateEmpVacUsed", map);
	} 
	
	@SuppressWarnings("unchecked")
	public void deleteEmpVacUsed(HashMap map) throws DaoException{
		update("EmpVacUsed.deleteEmpVacUsed", map);
	} 	

	@SuppressWarnings("unchecked") 
	public int selectEmpVacDaysCount(Map map) throws DaoException{
		return queryForInt("EmpVacUsed.selectEmpVacDaysCount",map); 
	} 
 	
	
	@SuppressWarnings("unchecked") 
	public int selectEmpVacTotCount(Map map) throws DaoException{
		return queryForInt("EmpVacUsed.selectEmpVacTotCount",map); 
	} 	
}
