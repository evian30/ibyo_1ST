/**
 *  Class Name  : OrderInfoManageDaoImpl.java
 *  Description : 수주정보관리 Impl
 *  Modification Information
 *
 *  수정일                   수정자               수정내용
 *  -------      --------   ---------------------------
 *  2011. 4. 15. 고기범              최초 생성
 *
 *  @author 고기범
 *  @since 2011. 4. 15.
 *  @version 1.0
 *  @see 
 * 
 *  Copyright (C) 2011 by SG All right reserved.
 */
package com.sg.sgis.ord.order.dao;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.signgate.core.exception.DaoException;

public interface OrderInfoManageDaoImpl {

	/**
	 * 수주정보관리 목록조회(수주정보)_ 총건수
	 * @param  paramMap
	 * @return List		
	 * 2011. 4. 15.
	 */
	@SuppressWarnings("unchecked")
	public List selectOrderInfoManageList(HashMap paramMap)throws DaoException;

	/**
	 * 수주정보관리 목록조회(수주정보)_총건수
	 * @param  paramMap
	 * @return int		
	 * 2011. 4. 15.
	 */
	@SuppressWarnings("unchecked")
	public int selectOrderInfoManageListCount(HashMap paramMap)throws DaoException;

	/**
	 * 수주정보관리 목록조회(품목정보)
	 * @param  paramMap
	 * @return List		
	 * 2011. 4. 18.
	 */
	@SuppressWarnings("unchecked")
	public List selectOrdItemInfo(HashMap paramMap)throws DaoException;

	/**
	 * 수주정보관리 목록조회(품목정보)_총건수
	 * @param  paramMap
	 * @return int		
	 * 2011. 4. 18.
	 */
	@SuppressWarnings("unchecked")
	public int selectOrdItemInfoCount(HashMap paramMap)throws DaoException;

	/**
	 * 수주정보관리 목록조회(시스템 사양정보)
	 * @param  paramMap
	 * @return List		
	 * 2011. 4. 18.
	 */
	@SuppressWarnings("unchecked")
	public List selectOrdSpecInfo(HashMap paramMap)throws DaoException;

	/**
	 * 수주정보관리 목록조회(시스템 사양정보)_총건수
	 * @param  paramMap
	 * @return int		
	 * 2011. 4. 18.
	 */
	@SuppressWarnings("unchecked")
	public int selectOrdSpecInfoCount(HashMap paramMap)throws DaoException;

	/**
	 * 수주정보 입력, 수정
	 * @param request	( ORD_INFO 		   : 수주정보관리
	 *                  , ORD_ITEM_INFO    : 수주품목관리
	 *                  , ORD_SPEC_INFO    : 수주설치시스템사양정보
	 * 					)
	 * @param response
	 * @return
	 * @throws Exception
	 * 2011. 4. 18.
	 */
	@SuppressWarnings("unchecked")
	public void saveOrderInfoManage(HashMap map, HttpServletRequest request)throws DaoException;

	/**
	 * 세금계산서관리 목록조회
	 * @param  paramMap
	 * @return List
	 * @throws Exception
	 * 2011. 4. 20.
	 */
	@SuppressWarnings("unchecked")
	public List selectTaxInfo(HashMap paramMap)throws DaoException;

	/**
	 * 세금계산서관리 목록조회 총건수
	 * @param  paramMap
	 * @return 
	 * @throws Exception
	 * 2011. 4. 20.
	 */
	@SuppressWarnings("unchecked")
	public int selectTaxInfoCount(HashMap paramMap)throws DaoException;

	/**
	 * 수주팝업 목록조회 총건수
	 * @param  paramMap
	 * @return 
	 * @throws Exception
	 * 2011. 4. 28.
	 */
	@SuppressWarnings("unchecked")
	public int selectOrderPopListCount(HashMap paramMap)throws DaoException;

	/**
	 * 수주팝업 목록조회 
	 * @param  paramMap
	 * @return 
	 * @throws Exception
	 * 2011. 4. 28.
	 */
	@SuppressWarnings("unchecked")
	public List selectOrderPopList(HashMap paramMap)throws DaoException;

	/**
	 * 수주ID 생성
	 * @param paramMap
	 * @return String
	 * @throws Exception
	 * 2011. 5. 6.
	 */
	@SuppressWarnings("unchecked")
	public String createOrdId(HashMap paramMap)throws DaoException;

	/**
	 * 세금계산서 발행정보
	 * @param paramMap
	 * @return String
	 * @throws Exception
	 * 2011. 6. 3.
	 */
	@SuppressWarnings("unchecked")
	public List selectTaxPublishInfoManageList(HashMap paramMap)throws DaoException;

	/**
	 * 세금계산서 발행정보 총건수
	 * @param paramMap
	 * @return String
	 * @throws Exception
	 * 2011. 6. 3.
	 */
	@SuppressWarnings("unchecked")
	public int selectTaxPublishInfoManageListCount(HashMap paramMap)throws DaoException;

	/**
	 * 세금계산서 발행정보 저장, 수정
	 * @param map
	 * @param request
	 * @return
	 * 2011. 6. 3.
	 */
	@SuppressWarnings("unchecked")
	public void saveTaxPublishInfoManage(HashMap map, HttpServletRequest request)throws DaoException;

	/**
	 * 세금계산서 발행정보 저장, 수정(매출등록)
	 * @param map
	 * @param request
	 * @return
	 * 2011. 6. 4.
	 */
	@SuppressWarnings("unchecked")
	public void saveSaleRegister(HashMap map, HttpServletRequest request)throws DaoException;

	
}
