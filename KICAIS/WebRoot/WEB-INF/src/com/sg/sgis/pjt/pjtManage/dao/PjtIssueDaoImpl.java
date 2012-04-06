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

public interface PjtIssueDaoImpl {

	
	@SuppressWarnings("unchecked")
	public List selectPjtIssue(HashMap paramMap) throws DaoException;
	

	@SuppressWarnings("unchecked") 
	public int selectPjtIssueCount(Map map) throws DaoException; 
 
	@SuppressWarnings("unchecked") 
	public void actionPjtIssue(HashMap paramMap, HttpServletRequest request)throws DaoException;
	
	 
}
