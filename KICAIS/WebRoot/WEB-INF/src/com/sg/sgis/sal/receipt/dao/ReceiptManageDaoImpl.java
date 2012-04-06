/**
 *  Class Name  : ReceiptManageDaoImpl.java
 *  Description : 수금관리 Impl
 *  Modification Information
 *
 *  수정일                   수정자               수정내용
 *  -------      --------   ---------------------------
 *  2011. 4. 29. 고기범              최초 생성
 *
 *  @author 고기범
 *  @since 2011. 4. 29.
 *  @version 1.0
 *  @see 
 * 
 *  Copyright (C) 2011 by SG All right reserved.
 */
package com.sg.sgis.sal.receipt.dao;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.signgate.core.exception.DaoException;

public interface ReceiptManageDaoImpl {

	/**
	 * 수금관리_프로젝트별 수금정보
	 * @param  paramMap
	 * @return List		
	 * 2011. 4. 29.
	 */
	@SuppressWarnings("unchecked")
	public List selectReceiptProjectList(HashMap paramMap)throws DaoException;

	/**
	 * 수금관리_프로젝트별 수금정보 총건수
	 * @param  paramMap
	 * @return List		
	 * 2011. 4. 29.
	 */
	@SuppressWarnings("unchecked")
	public int selectReceiptProjectListCount(HashMap paramMap)throws DaoException;

	/**
	 * 수금관리_수금상세정보
	 * @param  paramMap
	 * @return List		
	 * 2011. 4. 29.
	 */
	@SuppressWarnings("unchecked")
	public List selectReceiptManageList(HashMap paramMap)throws DaoException;

	/**
	 * 수금관리_수금상세정보 총건수
	 * @param  paramMap
	 * @return List		
	 * 2011. 4. 29.
	 */
	@SuppressWarnings("unchecked")
	public int selectReceiptManageListCount(HashMap paramMap)throws DaoException;

	/**
	 * 수금관리_수금상세정보 저장, 수정
	 * @param  request
	 * @param  response
	 * @return mav		
	 * 2011. 5. 2.
	 */
	@SuppressWarnings("unchecked")
	public boolean saveReceiptManage(HashMap paramMap,
			HttpServletRequest request)throws DaoException;
	
	
	List selectReceiptInfo(HashMap paramMap) throws DaoException;

	int selectReceiptInfoCount(HashMap paramMap) throws DaoException;

	List selectReceiptItemInfo(HashMap paramMap) throws DaoException;

	int selectReceiptItemInfoCount(HashMap paramMap) throws DaoException;

}
