/**
 *  Class Name  : EstimateProcessStateManageDaoImpl.java
 *  Description : 견적정보진행상태 Impl
 *  Modification Information
 *
 *  수정일                   수정자               수정내용
 *  -------      --------   ---------------------------
 *  2011. 3. 21.    고기범              최초 생성
 *
 *  @author 고기범
 *  @since 2011. 4. 13.
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

public interface EstimateProcessStateManageDaoImpl {

	/**
	 * 견적정보진행상태(견적정보)조회
	 * @param paramMap
	 * @return
	 * @throws Exception
	 * 2011. 4. 13.
	 */
	@SuppressWarnings("unchecked")
	public List selectEstimateProcessStateEstInfoList(HashMap paramMap)throws DaoException;

	/**
	 * 견적정보진행상태(견적 정보)조회 총건수
	 * @param paramMap
	 * @return
	 * @throws Exception
	 * 2011. 4. 13.
	 */
	@SuppressWarnings("unchecked")
	public int selectEstimateProcessStateEstInfoListCount(HashMap paramMap)throws DaoException;

	/**
	 * 견적정보진행상태(견적 품목정보)조회 
	 * @param paramMap
	 * @return
	 * @throws Exception
	 * 2011. 4. 13.
	 */
	@SuppressWarnings("unchecked")
	public List selectEstimateProcessStateEstItemInfoList(HashMap paramMap)throws DaoException;

	/**
	 * 견적정보진행상태(견적 품목정보)조회 총건수
	 * @param paramMap
	 * @return
	 * @throws Exception
	 * 2011. 4. 13.
	 */
	@SuppressWarnings("unchecked")
	public int selectEstimateProcessStateEstItemInfoListCount(HashMap paramMap)throws DaoException;

	/**
	 * 견적정보진행상태 수정
	 * @param map		( EST_INFO : 견적정보관리 )
	 * @param request
	 * @return
	 * @throws Exception
	 * 2011. 4. 13.
	 */
	public void saveEstimateProcessStateEstInfo(HashMap map,
			HttpServletRequest request)throws DaoException;

}
