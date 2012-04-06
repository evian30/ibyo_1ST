/**
 *  Class Name  : SaleInfoManageDaoImpl.java
 *  Description : 매출정보관리 DaoImpl
 *  Modification Information
 *
 *  수정일                   수정자               수정내용
 *  -------      --------   ---------------------------
 *  2011. 4. 25.    고기범              최초 생성
 *
 *  @author 고기범
 *  @since 2011. 4. 25.
 *  @version 1.0
 *  @see 
 * 
 *  Copyright (C) 2011 by SG All right reserved.
 */
package com.sg.sgis.sal.sale.dao;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.signgate.core.exception.DaoException;

public interface SaleInfoManageDaoImpl {

	/**
	 * 매출정보관리 목록조회(매출정보)
	 * @param  paramMap
	 * @return List		
	 * 2011. 4. 26.
	 */
	@SuppressWarnings("unchecked")
	public List selectSaleInfoManageList(HashMap paramMap)throws DaoException;

	/**
	 * 매출정보관리 목록조회(매출정보)_총건수
	 * @param  paramMap
	 * @return int		
	 * 2011. 4. 26.
	 */
	@SuppressWarnings("unchecked")
	public int selectSaleInfoManageListCount(HashMap paramMap)throws DaoException;

	/**
	 * 매출정보관리 목록조회(품목정보)
	 * @param  paramMap
	 * @return List		
	 * 2011. 4. 26.
	 */
	@SuppressWarnings("unchecked")
	public List selectSalItemInfo(HashMap paramMap)throws DaoException;

	/**
	 * 매출정보관리 목록조회(품목정보)_총건수
	 * @param  paramMap
	 * @return int		
	 * 2011. 4. 26.
	 */
	@SuppressWarnings("unchecked")
	public int selectSalItemInfoCount(HashMap paramMap)throws DaoException;

	/**
	 * 매출정보관리 목록조회(시스템 사양 정보)
	 * @param  paramMap
	 * @return List		
	 * 2011. 4. 26.
	 */
	@SuppressWarnings("unchecked")
	public List selectSalSpecInfo(HashMap paramMap)throws DaoException;

	/**
	 * 매출정보관리 목록조회(시스템 사양정보)_총건수
	 * @param  paramMap
	 * @return int		
	 * 2011. 4. 26.
	 */
	@SuppressWarnings("unchecked")
	public int selectSalSpecInfoCount(HashMap paramMap)throws DaoException;

	/**
	 * 세금계산서관리 목록조회
	 * @param request	( 
	 *                   SAL_ID : 매출ID
	 * 					)
	 * @param response
	 * @return List
	 * @throws Exception
	 * 2011. 4. 20.
	 */
	@SuppressWarnings("unchecked")
	public List selectTaxInfo(HashMap paramMap)throws DaoException;

	/**
	 * 세금계산서관리 목록조회 총건수
	 * @param request	( 
	 *                   SAL_ID 		   : 매출ID
	 * 					)
	 * @param response
	 * @return 
	 * @throws Exception
	 * 2011. 4. 26.
	 */
	@SuppressWarnings("unchecked")
	public int selectTaxInfoCount(HashMap paramMap)throws DaoException;

	/**
	 * 매출정보 입력, 수정
	 * @param request	( SAL_INFO 		   : 매출정보관리
	 *                  , SAL_ITEM_INFO    : 매출품목관리
	 *                  , SAL_SPEC_INFO    : 매출설치시스템사양정보
	 * 					)
	 * @param response
	 * @return
	 * @throws Exception
	 * 2011. 4. 26.
	 */
	@SuppressWarnings("unchecked")
	public boolean saveSaleInfoManage(HashMap map, HttpServletRequest request)throws DaoException;

	/**
	 * 매출ID 생성
	 * @return
	 * @throws DaoException
	 * 2011. 4. 27.
	 */
	@SuppressWarnings("unchecked")
	public String createSalId(HashMap paramMap)throws DaoException;

	/**
	 * 매출정보관리 목록조회
	 * @param  paramMap
	 * @param  response
	 * @return mav		
	 * 2011. 6. 8.
	 */
	@SuppressWarnings("unchecked")
	public List saleInfoManageList(HashMap paramMap)throws DaoException;

	/**
	 * 매출정보관리 목록조회 총건수
	 * @param  paramMap
	 * @param  response
	 * @return mav		
	 * 2011. 6. 8.
	 */
	@SuppressWarnings("unchecked")
	public int saleInfoManageListCount(HashMap paramMap)throws DaoException;
}
