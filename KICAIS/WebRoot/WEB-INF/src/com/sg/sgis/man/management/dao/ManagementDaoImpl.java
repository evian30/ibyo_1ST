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
package com.sg.sgis.man.management.dao;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import com.signgate.core.config.SGConfigManager;
import com.signgate.core.exception.DaoException;

public interface ManagementDaoImpl {
	
	@SuppressWarnings("unchecked")
	public List selectManagement(HashMap paramMap) throws DaoException;
	
	@SuppressWarnings("unchecked") 
	public int selectManagementCount(Map map) throws DaoException;
	  
 
	@SuppressWarnings("unchecked")
	public List selectPjtManagement(HashMap paramMap) throws DaoException;
	
	@SuppressWarnings("unchecked") 
	public int selectPjtManagementCount(Map map) throws DaoException;
	 
	
	@SuppressWarnings("unchecked")
	public List selectManagementItem(HashMap paramMap) throws DaoException;
	
	@SuppressWarnings("unchecked") 
	public int selectManagementItemCount(Map map) throws DaoException;
	  
	@SuppressWarnings("unchecked")
	public void actionManagement(HashMap paramMap, HttpServletRequest request)throws DaoException;
	
	@SuppressWarnings("unchecked")
	public String selectManID(HashMap map) throws DaoException;
	
	@SuppressWarnings("unchecked")
	public String selectSalID(HashMap map) throws DaoException;

	@SuppressWarnings("unchecked")
	public List selectSalCheck(HashMap map)throws DaoException;
	
}
