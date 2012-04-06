/**
 *  Class Name  : OrderInfoManageBiz.java
 *  Description : 수주정보관리 Biz
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
package com.sg.sgis.ord.order;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.sg.sgis.ord.order.dao.OrderInfoManageDaoImpl;

public class OrderInfoManageBiz {

	protected final Log logger = LogFactory.getLog(getClass());
	
	// 수주정보관리 Dao경로 설정
	private OrderInfoManageDaoImpl orderInfoManageDao; 
	public void setOrderInfoManageDao(OrderInfoManageDaoImpl orderInfoManageDao)
	{
		this.orderInfoManageDao = orderInfoManageDao;
	}
	
	/**
	 * 수주정보관리 목록조회(수주정보)
	 * @param  paramMap
	 * @return List		
	 * 2011. 4. 15.
	 */
	@SuppressWarnings("unchecked")
	public List selectOrderInfoManageList(HashMap paramMap)throws Exception{
		List result = null;
		
		try{
			 result = orderInfoManageDao.selectOrderInfoManageList(paramMap);
		}catch(Exception e){
			logger.error(e, e);
		}
		
		return result;
	}
	
	/**
	 * 수주정보관리 목록조회(수주정보)_총건수
	 * @param  paramMap
	 * @return int		
	 * 2011. 4. 15.
	 */
	@SuppressWarnings("unchecked")
	public int selectOrderInfoManageListCount(HashMap paramMap)throws Exception {
		int result = 0;
		
		try{
			 result = orderInfoManageDao.selectOrderInfoManageListCount(paramMap);
		}catch(Exception e){
			logger.error(e, e);
		}
		
		return result;
	}

	/**
	 * 수주정보관리 목록조회(품목정보)
	 * @param  paramMap
	 * @return List		
	 * 2011. 4. 18.
	 */
	@SuppressWarnings("unchecked")
	public List selectOrdItemInfo(HashMap paramMap)throws Exception {
		List result = null;
		
		try{
			 result = orderInfoManageDao.selectOrdItemInfo(paramMap);
		}catch(Exception e){
			logger.error(e, e);
		}
		
		return result;
	}

	/**
	 * 수주정보관리 목록조회(품목정보)_총건수
	 * @param  paramMap
	 * @return int		
	 * 2011. 4. 18.
	 */
	@SuppressWarnings("unchecked")
	public Object selectOrdItemInfoCount(HashMap paramMap)throws Exception {
		int result = 0;
		
		try{
			 result = orderInfoManageDao.selectOrdItemInfoCount(paramMap);
		}catch(Exception e){
			logger.error(e, e);
		}
		
		return result;
	}

	/**
	 * 수주정보관리 목록조회(시스템 사양 정보)
	 * @param  paramMap
	 * @return List		
	 * 2011. 4. 18.
	 */
	@SuppressWarnings("unchecked")
	public List selectOrdSpecInfo(HashMap paramMap)throws Exception {
		List result = null;
		
		try{
			 result = orderInfoManageDao.selectOrdSpecInfo(paramMap);
		}catch(Exception e){
			logger.error(e, e);
		}
		
		return result;
	}

	/**
	 * 수주정보관리 목록조회(시스템 사양정보)_총건수
	 * @param  paramMap
	 * @return int		
	 * 2011. 4. 18.
	 */
	@SuppressWarnings("unchecked")
	public Object selectOrdSpecInfoCount(HashMap paramMap)throws Exception {
		int result = 0;
		
		try{
			 result = orderInfoManageDao.selectOrdSpecInfoCount(paramMap);
		}catch(Exception e){
			logger.error(e, e);
		}
		
		return result;
	}

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
	public boolean saveOrderInfoManage(HashMap map, 
			HttpServletRequest request) throws Exception {
		boolean result = true;
		
		try{
			orderInfoManageDao.saveOrderInfoManage(map, request);
		}catch(Exception e){
			logger.error(e,e);
			result = false;
		}
		return result;
	}

	/**
	 * 세금계산서관리 목록조회
	 * @param request	( 
	 *                   ORD_ID 		   : 수주ID
	 * 					)
	 * @param response
	 * @return List
	 * @throws Exception
	 * 2011. 4. 20.
	 */
	@SuppressWarnings("unchecked")
	public List selectTaxInfo(HashMap paramMap)throws Exception {
		List result = null;
		
		try{
			 result = orderInfoManageDao.selectTaxInfo(paramMap);
		}catch(Exception e){
			logger.error(e, e);
		}
		
		return result;
	}

	/**
	 * 세금계산서관리 목록조회 총건수
	 * @param request	( 
	 *                   ORD_ID 		   : 수주ID
	 * 					)
	 * @param response
	 * @return 
	 * @throws Exception
	 * 2011. 4. 20.
	 */
	@SuppressWarnings("unchecked")
	public Object selectTaxInfoCount(HashMap paramMap)throws Exception {
		int result = 0;
		
		try{
			 result = orderInfoManageDao.selectTaxInfoCount(paramMap);
		}catch(Exception e){
			logger.error(e, e);
		}
		
		return result;
	}

	/**
	 * 수주팝업목록조회 총건수
	 * @param paramMap
	 * @return List
	 * @throws Exception
	 * 2011. 4. 28.
	 */
	@SuppressWarnings("unchecked")
	public int selectOrderPopListCount(HashMap paramMap)throws Exception {
		int result = 0;
		
		try{
			 result = orderInfoManageDao.selectOrderPopListCount(paramMap);
		}catch(Exception e){
			logger.error(e, e);
		}
		
		return result;
	}

	/**
	 * 수주팝업목록조회 총건수
	 * @param paramMap
	 * @return List
	 * @throws Exception
	 * 2011. 4. 28.
	 */
	@SuppressWarnings("unchecked")
	public List selectOrderPopList(HashMap paramMap)throws Exception {
		List result = null;
		
		try{
			 result = orderInfoManageDao.selectOrderPopList(paramMap);
		}catch(Exception e){
			logger.error(e, e);
		}
		
		return result;
	}

	/**
	 * 수주ID 생성
	 * @param paramMap
	 * @return String
	 * @throws Exception
	 * 2011. 5. 6.
	 */
	@SuppressWarnings("unchecked")
	public String createOrdId(HashMap paramMap)throws Exception {
		String result = null;
		
		try{
			 result = orderInfoManageDao.createOrdId(paramMap);
		}catch(Exception e){
			logger.error(e, e);
		}
		
		return result;
	}

	/**
	 * 세금계산서 발행정보
	 * @param paramMap
	 * @return String
	 * @throws Exception
	 * 2011. 6. 3.
	 */
	@SuppressWarnings("unchecked")
	public List selectTaxPublishInfoManageList(HashMap paramMap)throws Exception {
		List result = null;
		
		try{
			 result = orderInfoManageDao.selectTaxPublishInfoManageList(paramMap);
		}catch(Exception e){
			logger.error(e, e);
		}
		
		return result;
	}

	/**
	 * 세금계산서 발행정보 총건수
	 * @param paramMap
	 * @return String
	 * @throws Exception
	 * 2011. 6. 3.
	 */
	@SuppressWarnings("unchecked")
	public int selectTaxPublishInfoManageListCount(HashMap paramMap)throws Exception {
		int result = 0;
		
		try{
			 result = orderInfoManageDao.selectTaxPublishInfoManageListCount(paramMap);
		}catch(Exception e){
			logger.error(e, e);
		}
		
		return result;
	}

	/**
	 * 세금계산서 발행정보 저장, 수정
	 * @param map
	 * @param request
	 * @return
	 * 2011. 6. 3.
	 */
	@SuppressWarnings("unchecked")
	public boolean saveTaxPublishInfoManage(HashMap map,
			HttpServletRequest request) {
		// TODO Auto-generated method stub
		boolean result = true;
		
		try{
			orderInfoManageDao.saveTaxPublishInfoManage(map, request);
		}catch(Exception e){
			logger.error(e,e);
			result = false;
		}
		return result;
	}

	/**
	 * 세금계산서 발행정보(매출등록)
	 * @param map
	 * @param request
	 * @return
	 * 2011. 6. 4.
	 */
	@SuppressWarnings("unchecked")
	public boolean saveSaleRegister(HashMap map, HttpServletRequest request) {
		// TODO Auto-generated method stub
		boolean result = true;
		
		try{
			orderInfoManageDao.saveSaleRegister(map, request);
		}catch(Exception e){
			logger.error(e,e);
			result = false;
		}
		return result;
	}

}
