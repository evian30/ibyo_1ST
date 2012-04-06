/**
 *  Class Name  : DeptBiz.java
 *  Description : 부서정보관리 Biz
 *  Modification Information
 *
 *  수정일                   수정자               수정내용
 *  -------      --------   ---------------------------
 *  2011. 1. 26. 고기범              최초 생성
 *  2011. 3. 25    고기범	     디자인 변경 및 공통적용
 *  
 *  @author 고기범
 *  @since 2011. 1. 26.
 *  @version 1.0
 *  @see 
 * 
 *  Copyright (C) 2011 by SG All right reserved.
 */
package com.sg.sgis.com.dept;

import java.util.HashMap;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import sg.svc.portal.util.NewPageNavigator;

import com.sg.sgis.com.dept.dao.DeptDaoImpl;
import com.sg.sgis.com.sgisCode.dao.SgisCodeDaoImpl;
import com.signgate.core.exception.DaoException;

public class DeptBiz {

	NewPageNavigator pageNavi = new NewPageNavigator();
	
	protected final Log logger = LogFactory.getLog(getClass());
	
	// Dao경로 설정
	private DeptDaoImpl deptDao; 
	public void setDeptDao(DeptDaoImpl deptDao)
	{
		this.deptDao = deptDao;
	}
	
	//공통 코드 DAO 설정
	private SgisCodeDaoImpl sgisCodeDao;
	public void setSgisCodeDao(SgisCodeDaoImpl sgisCodeDao) {
		this.sgisCodeDao = sgisCodeDao;
	}
	
		 
	/**
	 * 부서정보관리 목록조회
	 * @param  map
	 * @return list
	 * @throws DaoException
	 * 2011. 1. 26.
	 */
	@SuppressWarnings("unchecked")
	public List selectDept(HashMap paramMap){
		List list = null;
		
		try{
			list = deptDao.selectDept(paramMap);
		}catch(Exception e){
			logger.error(e, e);
		}
		return list;
	}
	
	/**
	 * 공통코드 조회
	 * @param  String (공통코드의 group_code) 
	 * @return list	  
	 * @throws DaoException
	 * 2011. 1. 28.
	 */

	@SuppressWarnings("unchecked")
	public List selectComboCode(String searchCode){
		List list = null;
		
		try{
			list = deptDao.selectComboCode(searchCode);
		}catch(Exception e){
			e.printStackTrace();
			logger.error(e, e);
		}
		return list;
	}
	
	/**
	 * 공통코드 조회
	 * @param  String (테이블명, valueColum, nameColum) 
	 * @return list	  
	 * @throws DaoException
	 * 2011. 3. 2.
	 */
	@SuppressWarnings("unchecked")
	public List selectComboCodeEtc(String tableName,String valueColum ,String nameColum, String etcValue){
		
		List list = null;
		
		try{
			
			HashMap requestMap = new HashMap();
			requestMap.put("tableName",  tableName);	// 테이블명
			requestMap.put("valueColum", valueColum);	// value필드
			requestMap.put("nameColum",  nameColum);	// name필드		
			requestMap.put("etcValue",   etcValue);	    // 기타조회값
			list = deptDao.selectComboCodeEtc(requestMap);
		}catch(Exception e){
			e.printStackTrace();
			logger.error(e, e);
		}
		return list;
	}
	
	/**
	 * 공통코드 조회
	 * @param  String (테이블명, valueColum, nameColum) 
	 * @return list	  
	 * @throws DaoException
	 * 2011. 3. 2.
	 */
	@SuppressWarnings("unchecked")
	public List selectComboCode(String tableName,String valueColum ,String nameColum){
		
		List list = null;
		
		try{
			
			HashMap requestMap = new HashMap();
			
			requestMap.put("tableName",  tableName);	// 테이블명
			requestMap.put("valueColum", valueColum);	// value필드
			requestMap.put("nameColum",  nameColum);	// name필드		
			requestMap.put("etcValue",   null);	        // 기타조회값
			
			// list = deptDao.selectComboCode(requestMap);
			
		}catch(Exception e){
			e.printStackTrace();
			logger.error(e, e);
		}
		return list;
	}
	
	/**
	 * 공통코드 조회
	 * @param  String (공통코드의 group_code) 
	 * @return list	  ('','','')의 형식으로 값을 return
	 * @throws DaoException
	 * 2011. 1. 28.
	 */
	@SuppressWarnings("unchecked")
	public List selectComboCode(String group_code, String level){
		List list = null;
		HashMap paramMap = new HashMap();
		paramMap.put("group_code", group_code);
		paramMap.put("level", level);
		
		try{
			list = sgisCodeDao.selectComboCode2(paramMap);
		}catch(Exception e){
			e.printStackTrace();
			logger.error(e, e);
		}
		return list;
	}

	/**
	 * 부서정보관리 상세조회
	 * @param  map
	 * @return list
	 * @throws DaoException
	 * 2011. 2. 8.
	 */
	public List selectDeptbyPK(HashMap paramMap) {
		List list = null;
		
		try{
			list = deptDao.selectDeptbyPK(paramMap);
		}catch(Exception e){
			logger.error(e, e);
		}
		return list;
	}

	/**
	 * 부서정보관리 등록, 수정
	 * @param  map
	 * @return list
	 * @throws 
	 * 2011. 2. 8.
	 */
	public boolean regNewDept(HashMap paramMap) {
		
		int regResult = 0;
		boolean result = true;
		
		try{
			// flag값이 없으면 신규, 그렇지 않으면 저장
			if(("").equals(paramMap.get("flag"))){
				// 저장
				regResult = deptDao.insertNewDept(paramMap);
				
			}else{ 
				// 수정
				regResult = deptDao.updateNewDept(paramMap);
			}
		}catch(Exception e){
			logger.error(e, e);
		}
		return result;
	}

	/**
	 * 부서조회 팝업
	 * @param  map
	 * @return list
	 * @throws 
	 * 2011. 2. 8.
	 */
	public List selectDeptPopList(HashMap paramMap) {
		
		List result = null;
		
		try{
			
			result = deptDao.selectDeptPopList(paramMap);
			
		}catch(Exception e){
			logger.error(e, e);
		}
		
		return result;
	}

	/**
	 * 부서조회 총갯수
	 * @param  map (검색조건 : 부서명, 부서레벨, 사용유무)
	 * @return int (목록총갯수)
	 * @throws 
	 * 2011. 3. 10.
	 */
	public int selectDeptCount(HashMap paramMap) {
		int result = 0;
		
		try{

			result = deptDao.selectDeptCount(paramMap);
			logger.debug("selectEmployeeCount............");
			
		}catch(Exception e){
			logger.error(e, e);
		}
		return result;
	}


	/**
	 * 부서조회 팝업 총건수
	 * @param  paramMap
	 * @return int
	 * @throws 
	 * 2011. 2. 8.
	 */
	public int selectDeptPopListCnt(HashMap paramMap) {
		int result = 0;
		
		try{

			result = deptDao.selectDeptPopListCnt(paramMap);
			logger.debug("selectDeptPopListCnt............");
			
		}catch(Exception e){
			logger.error(e, e);
		}
		return result;
	}
}
