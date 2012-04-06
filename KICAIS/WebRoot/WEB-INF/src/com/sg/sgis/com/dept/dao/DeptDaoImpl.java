/**
 *  Class Name  : DeptDaoImpl.java
 *  Description : 부서정보관리 DaoImpl
 *  Modification Information
 *
 *  수정일                   수정자                 수정내용
 *  -------      --------    ---------------------------
 *  2011. 1. 26. 고기범                 최초 생성
 *  2011. 3. 25    고기범	     디자인 변경 및 공통적용
 *
 *  @author 고기범
 *  @since 2011. 1. 26.
 *  @version 1.0
 *  @see 
 * 
 *  Copyright (C) 2011 by SG All right reserved.
 */
package com.sg.sgis.com.dept.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.signgate.core.exception.DaoException;

public interface DeptDaoImpl {

	/**
	 * 부서정보관리 목록조회
	 * @param map
	 * @return
	 * @throws DaoException
	 * 2011. 1. 26.
	 */
	@SuppressWarnings("unchecked")
	public List selectDept(Map map) throws DaoException; 
	
	/**
	 * 공통코드 조회
	 * @param  String (공통코드의 group_code) 
	 * @return list
	 * @throws DaoException
	 * 2011. 1. 28.
	 */
	@SuppressWarnings("unchecked")
	public List selectComboCode(String searchCode) throws DaoException;

	/**
	 * 공통코드 조회
	 * @param  HashMap 
	 * @return list
	 * @throws DaoException
	 * 2011. 1. 28.
	 */
	@SuppressWarnings("unchecked")
	public List selectComboCodeEtc(HashMap requestMap) throws DaoException;
	
	/**
	 * 부서정보관리 목록조회
	 * @param  paramMap 
	 * @return list	  
	 * @throws DaoException
	 * 2011. 2. 8.
	 */
	@SuppressWarnings("unchecked")
	public List selectDeptbyPK(HashMap paramMap)throws DaoException;
	
	/**
	 * 부서정보관리 신규등록
	 * @param map
	 * @return
	 * @throws DaoException
	 * 2011. 3. 02.
	 */
	@SuppressWarnings("unchecked")
	public int insertNewDept(HashMap paramMap) throws DaoException;

	/**
	 * 부서정보관리 수정
	 * @param map
	 * @return
	 * @throws DaoException
	 * 2011. 3. 07.
	 */
	public int updateNewDept(HashMap paramMap) throws DaoException;

	/**
	 * 부서조회 팝업
	 * @param map
	 * @return
	 * @throws DaoException
	 * 2011. 3. 08.
	 */
	@SuppressWarnings("unchecked")
	public List selectDeptPopList(HashMap paramMap) throws DaoException;

	/**
	 * 부서조회 총갯수
	 * @param  map (검색조건 : 부서명, 부서레벨, 사용유무)
	 * @return int (목록총갯수)
	 * @throws DaoException
	 * 2011. 3. 10.
	 */
	@SuppressWarnings("unchecked")
	public int selectDeptCount(HashMap paramMap)throws DaoException;

	/**
	 * 부서조회 팝업 총건수
	 * @param  map
	 * @return int
	 * @throws DaoException
	 * 2011. 3. 25.
	 */
	@SuppressWarnings("unchecked")
	public int selectDeptPopListCnt(HashMap paramMap)throws DaoException;
 
}
