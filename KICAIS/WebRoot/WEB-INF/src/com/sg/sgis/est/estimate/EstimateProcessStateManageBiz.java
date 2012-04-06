/**
 *  Class Name  : EstimateProcessStateManageBiz.java
 *  Description : 견적정보진행상태  Biz
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
package com.sg.sgis.est.estimate;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.sg.sgis.est.estimate.dao.EstimateProcessStateManageDaoImpl;

public class EstimateProcessStateManageBiz {

	protected final Log logger = LogFactory.getLog(getClass());
	
	// 견적진행상태관리 Dao경로 설정
	private EstimateProcessStateManageDaoImpl estimateProcessStateManageDao; 
	public void setEstimateProcessStateManageDao(EstimateProcessStateManageDaoImpl estimateProcessStateManageDao)
	{
		this.estimateProcessStateManageDao = estimateProcessStateManageDao;
	}
	
	/**
	 * 견적정보진행상태(견적정보)조회
	 * @param paramMap
	 * @return
	 * @throws Exception
	 * 2011. 4. 13.
	 */
	@SuppressWarnings("unchecked")
	public List selectEstimateProcessStateEstInfoList(HashMap paramMap)throws Exception {
		List result = null;
		
		try{
			result = estimateProcessStateManageDao.selectEstimateProcessStateEstInfoList(paramMap);
		}catch(Exception e){
			//logger.error(e, e);
		}
		
		return result;
	}

	/**
	 * 견적정보진행상태(견적정보)조회 총건수
	 * @param paramMap
	 * @return
	 * @throws Exception
	 * 2011. 4. 13.
	 */
	@SuppressWarnings("unchecked")
	public int selectEstimateProcessStateEstInfoListCount(HashMap paramMap)throws Exception {
		int result = 0;
		
		try{
			result = estimateProcessStateManageDao.selectEstimateProcessStateEstInfoListCount(paramMap);
		}catch(Exception e){
			logger.error(e, e);
		}
		
		return result;
	}
	
	/**
	 * 견적정보진행상태(견적 품목정보)조회 
	 * @param paramMap
	 * @return
	 * @throws Exception
	 * 2011. 4. 13.
	 */
	@SuppressWarnings("unchecked")
	public List selectEstimateProcessStateEstItemInfoList(HashMap paramMap)throws Exception {
		List result = null;
		
		try{
			result = estimateProcessStateManageDao.selectEstimateProcessStateEstItemInfoList(paramMap);
		}catch(Exception e){
			//logger.error(e, e);
		}
		
		return result;
	}
	
	/**
	 * 견적정보진행상태(견적 품목정보)조회 총건수
	 * @param paramMap
	 * @return
	 * @throws Exception
	 * 2011. 4. 13.
	 */
	@SuppressWarnings("unchecked")
	public int selectEstimateProcessStateEstItemInfoListCount(HashMap paramMap)throws Exception {
		int result = 0;
		
		try{
			result = estimateProcessStateManageDao.selectEstimateProcessStateEstItemInfoListCount(paramMap);
		}catch(Exception e){
			logger.error(e, e);
		}
		
		return result;
	}

	/**
	 * 견적정보진행상태 수정
	 * @param request	( EST_INFO : 견적정보관리 )
	 * @param response
	 * @return
	 * @throws Exception
	 * 2011. 4. 13.
	 */
	public boolean saveEstimateProcessStateEstInfo(HashMap map,
			HttpServletRequest request)throws Exception {
		boolean result = true;
		
		try{
			estimateProcessStateManageDao.saveEstimateProcessStateEstInfo(map, request);
		}catch(Exception e){
			logger.error(e,e);
			result = false;
		}
		return result;
	}
	
}
