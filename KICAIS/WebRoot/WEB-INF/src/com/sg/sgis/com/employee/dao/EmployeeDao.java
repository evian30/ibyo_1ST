package com.sg.sgis.com.employee.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.signgate.core.dao.BaseDao;
import com.signgate.core.exception.DaoException;

public class EmployeeDao extends BaseDao implements EmployeeDaoImpl{

	protected final Log logger = LogFactory.getLog(getClass());
	
	/**
	 * 사원정보관리 목록조회
	 * @param  paramMap
	 * @return List
	 * @throws DaoException
	 * 2011. 2. 8.
	 */
	@SuppressWarnings("unchecked")
	public List selectEmployee(HashMap paramMap) throws DaoException{
		return  queryForList("Employee.selectEmployee",paramMap);
	}
	
	/**
	 * 사원정보관리 상세조회
	 * @param  paramMap
	 * @return List
	 * @throws DaoException
	 * 2011. 2. 9.
	 */
	@SuppressWarnings("unchecked")
	public HashMap selectEmployeebyPK(HashMap paramMap)throws DaoException{
		return  (HashMap)queryForObject("Employee.selectEmployeebyPK",paramMap);
	}
	
	/**
	 * 사원정보관리 저장
	 * @param  paramMap
	 * @return 
	 * @throws DaoException
	 * 2011. 2. 11.
	 */
	@SuppressWarnings("unchecked")
	public void saveEmployee(HashMap paramMap)throws DaoException{
		insert("Employee.saveEmployee",paramMap);
	}
	
	/**
	 * 사원정보관리 수정
	 * @param  paramMap
	 * @return 
	 * @throws DaoException
	 * 2011. 2. 11.
	 */
	@SuppressWarnings("unchecked")
	public void updateEmployee(HashMap paramMap)throws DaoException{
		update("Employee.updateEmployee",paramMap);
	}
	
	/**
	 * 사원정보목록 총갯수
	 * @param  map
	 * @return 
	 * @throws DaoException
	 * 2011. 3. 9.
	 */
	@SuppressWarnings("unchecked")
	public int selectEmployeeCount(HashMap map)throws DaoException{
		return queryForInt("Employee.selectEmployeeCount",map); 
	}
	
	
	@SuppressWarnings("unchecked")
	public Object downPhotoFile(HashMap map) throws DaoException{
		return queryForList("Employee.downPhotoFile", map);
	}
	
	
	@SuppressWarnings("unchecked")
	public void insertLoginInfo(HashMap map) throws DaoException {
		insert("Employee.insertLoginInfo", map); 
	}
	
	@SuppressWarnings("unchecked")
	public void insertADMIN(HashMap map) throws DaoException {
		insert("Employee.insertADMIN", map); 
	}
	
	@SuppressWarnings("unchecked")
	public void updateADMIN(HashMap paramMap)throws DaoException{
		update("Employee.updateADMIN",paramMap);
	}

	/**
	 * 사원정보관리  팝업 목록조회
	 * @param  paramMap
	 * @return List
	 * 2011. 4. 11.
	 */
	@SuppressWarnings("unchecked")
	public List selectEmployeePop(HashMap paramMap) throws DaoException {
		return queryForList("Employee.selectEmployeePop", paramMap);
	}

	/**
	 * 사원정보관리  팝업 목록 총건수
	 * @param  paramMap
	 * @return List
	 * 2011. 4. 11.
	 */
	@SuppressWarnings("unchecked")
	public int selectEmployeePopCount(HashMap paramMap) throws DaoException {
		return queryForInt("Employee.selectEmployeePopCount",paramMap);
	}
	 
}
