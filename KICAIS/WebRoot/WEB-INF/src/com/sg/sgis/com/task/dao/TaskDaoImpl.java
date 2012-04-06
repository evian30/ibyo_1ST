/**
 *  Class Name  : TaskDaoImpl.java
 *  Description : 타스크관리 DaoImpl
 *  Modification Information
 *
 *  수정일                   수정자                 수정내용
 *  -------      --------    ---------------------------
 *  2011. 3. 11. 고기범                 최초 생성
 *
 *  @author 고기범
 *  @since 2011. 3. 11.
 *  @version 1.0
 *  @see 
 * 
 *  Copyright (C) 2011 by SG All right reserved.
 */
package com.sg.sgis.com.task.dao;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.signgate.core.exception.DaoException;

public interface TaskDaoImpl {

	/**
	 * 타스크정보관리 목록조회
	 * @param  paramMap	( src_task_group_code : 타스크그룹코드
	 *                  , src_task_code 	  : 타스크코드
	 *                  , src_task_name       : 타스크명
	 *                  , start				  : 검색(시작페이지)
	 *                  , limit				  : 검색(종료페이지)
	 * @return list     ( COM_TASK_INFO : 타스크정보관리)
	 * @throws Exception
	 * 2011. 3. 15.
	 */
	public List selectTask(HashMap paramMap)throws DaoException;

	/**
	 * 타스크정보관리 목록총갯수
	 * @param  paramMap	( src_TASK_GROUP_CODE : 타스크그룹코드
	 *                  , src_TASK_CODE 	  : 타스크코드
	 *                  , src_TASK_NAME       : 타스크명
	 *                  )
	 * @return int      (목록 총갯수)
	 * @throws Exception
	 * 2011. 3. 15.
	 */
	public int selectTaskCount(HashMap paramMap)throws DaoException;

	/**
	 * 타스크정보관리 등록
	 * @param  request  ( TASK_CODE		      : 타스크코드 
					    , TASK_GROUP_CODE     : 타스크그룹코드
					    , TASK_GROUP_NAME     : 타스크그룹명
					    , TASK_NAME           : 타스크명
					    , TASK_DESC           : 타스크설명
					    , NOTE       		  : 비고
					    , USE_YN			  : 사용여부 
					    , SRC_TASK_CODE       : 검색_타스크코드
					    , SRC_TASK_GROUP_CODE : 검색_타스크그룹코드
					    , SRC_TASK_NAME       : 검색_타스크명
					    , START				  : 검색_시작페이지
					    , LIMIT	  			  : 검색_종료페이지
					    )
	 * @return int
	 * 2011. 3. 15.
	 */
	public int insertTask(HashMap paramMap)throws DaoException;

	/**
	 * 타스크정보관리 수정
	 * @param  request  ( TASK_CODE		      : 타스크코드 
					    , TASK_GROUP_CODE     : 타스크그룹코드
					    , TASK_GROUP_NAME     : 타스크그룹명
					    , TASK_NAME           : 타스크명
					    , TASK_DESC           : 타스크설명
					    , NOTE       		  : 비고
					    , USE_YN			  : 사용여부 
					    , SRC_TASK_CODE       : 검색_타스크코드
					    , SRC_TASK_GROUP_CODE : 검색_타스크그룹코드
					    , SRC_TASK_NAME       : 검색_타스크명
					    , START				  : 검색_시작페이지
					    , LIMIT	  			  : 검색_종료페이지
					    )
	 * @return int
	 * 2011. 3. 15.
	 * @throws SQLException 
	 */
	public boolean updateTask(HashMap paramMap, HttpServletRequest request)throws DaoException, SQLException;

	/**
	 * 타스크코드 중복체크
	 * @param  request (
	 *  			    TASK_GROUP_CODE : 타스크그룹코드
	 *                 ,TASK_CODE 		: 타스크코드
	 *                 )
	 * @return String  (Y : 사용가능, N : 사용불가)
	 * 2011. 3. 15.
	 */
	public String checkTaskCode(HashMap paramMap)throws DaoException;

	/**
	 * 타스크산출물 목록조회
	 * @param  paramMap	( task_group_code : 타스크그룹코드
	 *                  , task_code 	  : 타스크코드
	 *                  , start			  : 검색(시작페이지)
	 *                  , limit			  : 검색(종료페이지)
	 * @return list     ( COM_TASK_REPORT_INFO : 타스크별 산출물관리)
	 * @throws Exception
	 * 2011. 3. 29.
	 */
	public List selectTaskReportInfo(HashMap paramMap)throws DaoException;

	/**
	 * 타스크산출물 목록조회 총건수
	 * @param  paramMap	( task_group_code : 타스크그룹코드
	 *                  , task_code 	  : 타스크코드
	 *                  , start			  : 검색(시작페이지)
	 *                  , limit			  : 검색(종료페이지)
	 * @return int 
	 * @throws Exception
	 * 2011. 3. 29.
	 */
	public int selectTaskReportInfoCnt(HashMap paramMap)throws DaoException;

	public int insertTaskReportInfo(HashMap map)throws DaoException;

	public int updateTaskReportInfo(HashMap map)throws DaoException;

	
	/**
	 * 타스크정보관리 목록팝업조회
	 * @param  paramMap	( src_task_group_code : 타스크그룹코드
	 *                  , src_task_code 	  : 타스크코드
	 *                  , src_task_name       : 타스크명
	 *                  , start				  : 검색(시작페이지)
	 *                  , limit				  : 검색(종료페이지)
	 * @return list     ( COM_TASK_INFO : 타스크정보관리)
	 * @throws Exception
	 * 2011. 3. 15.
	 */
	public List selectTaskPop(HashMap paramMap)throws DaoException;

	/**
	 * 타스크정보관리 목록팝업총갯수
	 * @param  paramMap	( src_TASK_GROUP_CODE : 타스크그룹코드
	 *                  , src_TASK_CODE 	  : 타스크코드
	 *                  , src_TASK_NAME       : 타스크명
	 *                  )
	 * @return int      (목록 총갯수)
	 * @throws Exception
	 * 2011. 3. 15.
	 */
	public int selectTaskPopCount(HashMap paramMap)throws DaoException;	
	
}
