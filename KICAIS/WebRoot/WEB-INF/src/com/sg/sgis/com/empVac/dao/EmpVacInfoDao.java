package com.sg.sgis.com.empVac.dao;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.signgate.core.dao.BaseDao;
import com.signgate.core.exception.DaoException;

public class EmpVacInfoDao extends BaseDao implements EmpVacInfoDaoImpl{

	protected final Log logger = LogFactory.getLog(getClass());
	
	/**
	 * 개인별휴가정보 목록조회
	 * @param  paramMap
	 * @return List
	 * @throws DaoException
	 * 2011. 2. 8.
	 */
	@SuppressWarnings("unchecked")
	public List selectEmpVacList(HashMap paramMap) throws DaoException{
		
		System.out.println("Dao...Item.selectItem.....................");
		
		return  queryForList("EmpVac.selectEmpVacList",paramMap);
	}
	
	@SuppressWarnings("unchecked") 
	public int selectEmpVacCount(Map map) throws DaoException{
		return queryForInt("EmpVac.selectEmpVacCount",map); 
	} 
	
	@SuppressWarnings("unchecked") 
	public int selectEmpVacSavedCount(Map map) throws DaoException{
		return queryForInt("EmpVac.selectEmpVacSavedCount",map); 
	} 	
 
	@SuppressWarnings("unchecked")
	public void insertEmpVac(HashMap map) throws DaoException{
		insert("EmpVac.insertEmpVac", map);
	} 
 
	@SuppressWarnings("unchecked")
	public void updateEmpVac(HashMap map) throws DaoException{
		update("EmpVac.updateEmpVac", map);
	} 
	
	@SuppressWarnings("unchecked")
	public void deleteEmpVac(HashMap map) throws DaoException{
		update("EmpVac.deleteEmpVac", map);
	} 	
}
