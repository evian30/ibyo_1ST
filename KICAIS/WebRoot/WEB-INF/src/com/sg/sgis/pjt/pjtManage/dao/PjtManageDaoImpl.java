/**
 *  Class Name  : PjtManageDaoImpl.java
 *  Description : 프로젝트관리 DaoImpl
 *  Modification Information
 *
 *  수정일                   수정자                 수정내용
 *  -------      --------    ---------------------------
 *  2011. 03. 09.    고기범                 최초 생성
 *
 *  @author 여인범
 *  @since 2011. 03. 09.
 *  @version 1.0
 *  @see 
 * 
 *  Copyright (C) 2011 by SG All right reserved.
 */
package com.sg.sgis.pjt.pjtManage.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.signgate.core.exception.DaoException;

public interface PjtManageDaoImpl {

	
	@SuppressWarnings("unchecked")
	public List selectPjtManage(HashMap paramMap) throws DaoException;
	

	@SuppressWarnings("unchecked") 
	public int selectPjtManageCount(Map map) throws DaoException;
 	
	@SuppressWarnings("unchecked") 
	public void deletePjtManage(HashMap map) throws DaoException;
	
	
	@SuppressWarnings("unchecked")
	public List selectPjtCustom(HashMap paramMap) throws DaoException;
	
	@SuppressWarnings("unchecked") 
	public int selectPjtCustomCount(Map map) throws DaoException; 

	
	
	@SuppressWarnings("unchecked")
	public List selectPjtItem(HashMap paramMap) throws DaoException;
	
	@SuppressWarnings("unchecked") 
	public int selectPjtItemCount(Map map) throws DaoException; 

	@SuppressWarnings("unchecked") 
	public void actionPjtManage(HashMap paramMap, HttpServletRequest request)throws DaoException;
	
	@SuppressWarnings("unchecked") 
	public void actionPjtStatusManage(HashMap paramMap, HttpServletRequest request)throws DaoException;
	
	@SuppressWarnings("unchecked")
	public String getDeptCode(String emp_num) throws DaoException;
	
	@SuppressWarnings("unchecked")
	public String getDegreeRCode(String emp_num) throws DaoException;
	
	@SuppressWarnings("unchecked")
	public String getDegreeBCode(String emp_num) throws DaoException;
	
	@SuppressWarnings("unchecked")
	public String getDeptNm(String dept_code) throws DaoException;
	
	@SuppressWarnings("unchecked")
	public String selectPjtID(HashMap map) throws DaoException;
	
	
	@SuppressWarnings("unchecked")
	public List selectPjtStatusHIS(HashMap paramMap) throws DaoException;
	
	@SuppressWarnings("unchecked") 
	public int selectPjtStatusHISCount(Map map) throws DaoException;
	
	@SuppressWarnings("unchecked")
	public List selectPjtStatus(HashMap paramMap) throws DaoException;
	
	@SuppressWarnings("unchecked") 
	public int selectPjtStatusCount(Map map) throws DaoException;

	@SuppressWarnings("unchecked")
	public String getAuthority(String emp_num) throws DaoException;
}
