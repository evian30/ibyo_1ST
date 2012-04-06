/**
 *  Class Name  : EmployeeDaoImpl.java
 *  Description : 사원정보관리 DaoImpl
 *  Modification Information
 *
 *  수정일                   수정자                 수정내용
 *  -------      --------    ---------------------------
 *  2011. 2. 8.    고기범                 최초 생성
 *
 *  @author 고기범
 *  @since 2011. 2. 8.
 *  @version 1.0
 *  @see 
 * 
 *  Copyright (C) 2011 by SG All right reserved.
 */
package com.sg.sgis.com.employee.dao;

import java.util.HashMap;
import java.util.List;

import com.signgate.core.exception.DaoException;

public interface EmployeeDaoImpl {

	/**
	 * 사원정보관리 목록조회
	 * @param  paramMap
	 * @return List
	 * @throws DaoException
	 * 2011. 2. 8.
	 */
	@SuppressWarnings("unchecked")
	public List selectEmployee(HashMap paramMap) throws DaoException;

	/**
	 * 사원정보관리 상세조회
	 * @param  paramMap
	 * @return List
	 * @throws DaoException
	 * 2011. 2. 9.
	 */
	@SuppressWarnings("unchecked")
	public HashMap selectEmployeebyPK(HashMap paramMap)throws DaoException;

	/**
	 * 사원정보관리 저장
	 * @param  paramMap
	 * @return 
	 * @throws DaoException
	 * 2011. 2. 11.
	 */
	public void saveEmployee(HashMap paramMap)throws DaoException;
	
	/**
	 * 사원정보관리 수정
	 * @param  paramMap
	 * @return 
	 * @throws DaoException
	 * 2011. 2. 11.
	 */
	public void updateEmployee(HashMap paramMap)throws DaoException;

	/**
	 * 사원정보목록 총갯수
	 * @param  map
	 * @return 
	 * @throws DaoException
	 * 2011. 3. 9.
	 */
	public int selectEmployeeCount(HashMap map)throws DaoException;

	
	public Object downPhotoFile(HashMap paramMap)throws DaoException;
	
	@SuppressWarnings("unchecked")
	public void insertLoginInfo(HashMap map) throws DaoException;
	
	

	@SuppressWarnings("unchecked")
	public void insertADMIN(HashMap map) throws DaoException;
	
	public void updateADMIN(HashMap paramMap)throws DaoException;

	/**
	 * 사원정보관리  팝업 목록조회
	 * @param  paramMap
	 * @return List
	 * 2011. 4. 11.
	 */
	@SuppressWarnings("unchecked")
	public List selectEmployeePop(HashMap paramMap)throws DaoException;

	/**
	 * 사원정보관리  팝업 목록 총건수
	 * @param  paramMap
	 * @return List
	 * 2011. 4. 11.
	 */
	@SuppressWarnings("unchecked")
	public int selectEmployeePopCount(HashMap paramMap)throws DaoException;
	
}
