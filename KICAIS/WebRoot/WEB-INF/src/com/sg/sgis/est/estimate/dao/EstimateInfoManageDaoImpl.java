/**
 *  Class Name  : EstimateInfoManageDaoImpl.java
 *  Description : 견적정보관리 Impl
 *  Modification Information
 *
 *  수정일                   수정자               수정내용
 *  -------      --------   ---------------------------
 *  2011. 3. 21.    고기범              최초 생성
 *
 *  @author 고기범
 *  @since 2011. 3. 21.
 *  @version 1.0
 *  @see 
 * 
 *  Copyright (C) 2011 by SG All right reserved.
 */
package com.sg.sgis.est.estimate.dao;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.signgate.core.exception.DaoException;

public interface EstimateInfoManageDaoImpl {

	/**
	 * 견적정보관리 목록조회(견적정보)
	 * @param  paramMap
	 * @return List		
	 * 2011. 3. 21.
	 */
	@SuppressWarnings("unchecked")
	public List selectEstimateInfoManageList(HashMap paramMap)throws DaoException;

	/**
	 * 견적정보관리 목록조회(견적정보)_ 총건수
	 * @param  paramMap
	 * @return List		
	 * 2011. 3. 21.
	 */
	@SuppressWarnings("unchecked")
	public int selectEstimateInfoManageListCount(HashMap paramMap)throws DaoException;

	/**
	 * 견적정보 입력, 수정
	 * @param request	( EST_INFO 		   : 견적정보관리
	 *                  , EST_ITEM_INFO    : 견적품목관리
	 *                  , EST_SPEC_INFO    : 설치시스템사양정보
	 * 					)
	 * @param response
	 * @return
	 * @throws Exception
	 * 2011. 4. 7.
	 */
	@SuppressWarnings("unchecked")
	public void saveEstimateInfoManage(HashMap map, 
			HttpServletRequest request)throws DaoException;

	/**
	 * 견적정보관리(견적 품목정보) 목록
	 * @param  request 
	 * @param  response
	 * @return 
	 * 2011. 4. 8.
	 */
	@SuppressWarnings("unchecked")
	public List selectEstItemInfo(HashMap map)throws DaoException;

	/**
	 * 견적정보관리(견적 품목정보) 목록 총건수
	 * @param  request 
	 * @param  response
	 * @return 
	 * 2011. 4. 8.
	 */
	@SuppressWarnings("unchecked")
	public int selectEstItemInfoCount(HashMap map)throws DaoException;

	/**
	 * 견적정보관리(납품처 시스템사양 정보) 목록 
	 * @param  request 
	 * @param  response
	 * @return 
	 * 2011. 4. 8.
	 */
	@SuppressWarnings("unchecked")
	public List selectEstSpecInfo(HashMap map)throws DaoException;
	
	/**
	 * 견적정보관리(납품처 시스템사양 정보) 목록 총건수
	 * @param  request 
	 * @param  response
	 * @return 
	 * 2011. 4. 8.
	 */
	@SuppressWarnings("unchecked")
	public int selectEstSpecInfoCount(HashMap map)throws DaoException;

	/**
	 * 견적정보 rev 팝업 목록 조회
	 * @param paramMap
	 * @return
	 * 2011. 4. 12.
	 */
	@SuppressWarnings("unchecked")
	public List selectEstimateInfoManageRevPopList(HashMap paramMap)throws DaoException;

	/**
	 * 견적정보 rev 팝업 목록 총건수
	 * @param paramMap
	 * @return
	 * 2011. 4. 12.
	 */
	@SuppressWarnings("unchecked")
	public int selectEstimateInfoManageRevPopListCount(HashMap paramMap)throws DaoException;

	/**
	 * 견적정보 팝업 목록
	 * @param paramMap
	 * @return
	 * 2011. 4. 18.
	 */
	@SuppressWarnings("unchecked")
	public List estimatePopList(HashMap paramMap)throws DaoException;

	/**
	 * 견적정보 팝업 목록 총건수
	 * @param paramMap
	 * @return
	 * 2011. 4. 18.
	 */
	@SuppressWarnings("unchecked")
	public int estimatePopListCount(HashMap paramMap)throws DaoException;

	/**
	 * 프로젝트조회시 프로젝트의 거래처 정보 조회
	 * @param paramMap
	 * @return
	 * @throws Exception
	 * 2011. 5. 4.
	 */
	@SuppressWarnings("unchecked")
	public List selectPjtCustom(HashMap paramMap)throws DaoException;

	/**
	 * 프로젝트조회시 프로젝트의 매출품목 조회 
	 * @param paramMap
	 * @return
	 * @throws Exception
	 * 2011. 5. 4.
	 */
	@SuppressWarnings("unchecked")
	public List selectPjtItemList(HashMap paramMap)throws DaoException;

	/**
	 * 프로젝트조회시 프로젝트의 매출품목 조회 총건수
	 * @param paramMap
	 * @return
	 * @throws Exception
	 * 2011. 5. 4.
	 */
	@SuppressWarnings("unchecked")
	public int selectPjtItemListCount(HashMap paramMap)throws DaoException;

	/**
	 * 견적ID 생성
	 * @param paramMap
	 * @return
	 * @throws Exception
	 * 2011. 5. 4.
	 */
	@SuppressWarnings("unchecked")
	public String createEstId(HashMap paramMap)throws DaoException;

	/**
	 * 견적정보관리_견적등록 가능여부 확인
	 * @param paramMap
	 * @return
	 * @throws DaoException
	 * 2011. 5. 11.
	 */
	@SuppressWarnings("unchecked")
	public List projectUseCheck(HashMap paramMap)throws DaoException;
	
}
