/**
 *  Class Name  : ReceiptManageBiz.java
 *  Description : 수금관리 Biz
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
package com.sg.sgis.sal.receipt;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.sg.sgis.sal.receipt.dao.ReceiptManageDaoImpl;

public class ReceiptManageBiz {

	protected final Log logger = LogFactory.getLog(getClass());
	
	// 수금관리 Dao경로 설정
	private ReceiptManageDaoImpl receiptManageDao; 
	public void setReceiptManageDao(ReceiptManageDaoImpl receiptManageDao)
	{
		this.receiptManageDao = receiptManageDao;
	}
	
	/**
	 * 수금관리_프로젝트별 수금정보
	 * @param  paramMap
	 * @return List		
	 * 2011. 4. 29.
	 */
	@SuppressWarnings("unchecked")
	public List selectReceiptProjectList(HashMap paramMap)throws Exception{
		List result = null;
		
		try{
			 result = receiptManageDao.selectReceiptProjectList(paramMap);
		}catch(Exception e){
			logger.error(e, e);
		}
		
		return result;
	}

	/**
	 * 수금관리_프로젝트별 수금정보 총건수
	 * @param  paramMap
	 * @return List		
	 * 2011. 4. 29.
	 */
	@SuppressWarnings("unchecked")
	public int selectReceiptProjectListCount(HashMap paramMap)throws Exception{
		int result = 0;
		
		try{
			 result = receiptManageDao.selectReceiptProjectListCount(paramMap);
		}catch(Exception e){
			logger.error(e, e);
		}
		
		return result;
	}

	/**
	 * 수금관리_수금상세정보
	 * @param  paramMap
	 * @return List		
	 * 2011. 4. 29.
	 */
	@SuppressWarnings("unchecked")
	public List selectReceiptManageList(HashMap paramMap)throws Exception{
		List result = null;
		
		try{
			 result = receiptManageDao.selectReceiptManageList(paramMap);
		}catch(Exception e){
			logger.error(e, e);
		}
		
		return result;
	}

	/**
	 * 수금관리_수금상세정보 총건수
	 * @param  paramMap
	 * @return List		
	 * 2011. 4. 29.
	 */
	@SuppressWarnings("unchecked")
	public int selectReceiptManageListCount(HashMap paramMap)throws Exception{
		int result = 0;
		
		try{
			 result = receiptManageDao.selectReceiptManageListCount(paramMap);
		}catch(Exception e){
			logger.error(e, e);
		}
		
		return result;
	}

	/**
	 * 수금관리_수금상세정보 저장, 수정
	 * @param  request
	 * @param  response
	 * @return mav		
	 * 2011. 5. 2.
	 */
	@SuppressWarnings("unchecked")
	public boolean saveReceiptManage(HashMap paramMap,
			HttpServletRequest request)throws Exception{
		boolean result = true;
		
		try{
			 result = receiptManageDao.saveReceiptManage(paramMap, request);
		}catch(Exception e){
			logger.error(e, e);
		}
		
		return result;
	}
	
	public List selectReceiptInfo(HashMap paramMap) {
		List list = null;
		try{
			list = receiptManageDao.selectReceiptInfo(paramMap);
		}catch(Exception e){
			logger.error(e, e);
		}
		return list;
	}
	
	
	public int selectReceiptInfoCount(HashMap paramMap) {
		int result = 0;

		try{
			result = receiptManageDao.selectReceiptInfoCount(paramMap);
		}catch(Exception e){
			logger.error(e, e);
		}

		return result;
	}


	public List selectReceiptItemInfo(HashMap paramMap) {
		List list = null;
		try{
			list = receiptManageDao.selectReceiptItemInfo(paramMap);
		}catch(Exception e){
			logger.error(e, e);
		}
		return list;
	}


	public Object selectReceiptItemInfoCount(HashMap paramMap) {
		int result = 0;

		try{
			result = receiptManageDao.selectReceiptItemInfoCount(paramMap);
		}catch(Exception e){
			logger.error(e, e);
		}

		return result;
	}
	
	
}
