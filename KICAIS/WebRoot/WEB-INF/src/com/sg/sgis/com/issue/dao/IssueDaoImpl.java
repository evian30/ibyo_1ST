/**
 *  Class Name  : IssueDaoImpl.java
 *  Description : 이슈관리 DaoImpl
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
package com.sg.sgis.com.issue.dao;

import java.util.HashMap;
import java.util.List;

import com.signgate.core.exception.DaoException;

public interface IssueDaoImpl {

	/**
	 * 이슈정보관리 목록조회
	 * @param  paramMap	( src_issue_type_code : 이슈구분코드
	 *                  , src_issue_code 	  : 이슈코드
	 *                  , src_issue_comment   : 이슈내용
	 *                  , start				  : 검색(시작페이지)
	 *                  , limit				  : 검색(종료페이지)
	 * @return list     ( COM_ISSUE_INFO : 이슈정보관리)
	 * @throws Exception
	 * 2011. 3. 14.
	 */
	public List selectIssue(HashMap paramMap)throws DaoException;

	/**
	 * 이슈정보관리 목록총갯수
	 * @param  paramMap	( src_issue_type_code : 이슈구분코드
	 *                  , src_issue_code 	  : 이슈코드
	 *                  , src_issue_comment   : 이슈내용
	 *                  )
	 * @return int      (목록 총갯수)
	 * @throws Exception
	 * 2011. 3. 14.
	 */
	public int selectIssueCount(HashMap paramMap)throws DaoException;

	/**
	 * 이슈코드 중복체크
	 * @param  request (
	 *  			    ISSUE_TYPE_CODE : 이슈구분코드
	 *                 ,ISSUE_CODE 		: 이슈코드
	 *                 )
	 * @return String  (Y : 사용가능, N : 사용불가)
	 * 2011. 3. 14.
	 */
	public String checkIssueCode(HashMap paramMap)throws DaoException;

	/**
	 * 이슈정보관리 등록
	 * @param  request  ( ISSUE_CODE		  : 이슈코드 
					    , ISSUE_TYPE_CODE     : 이슈구분코드
					    , ISSUE_COMMENT       : 이슈내용
					    , USE_YN			  : 사용여부 
					    , SRC_ISSUE_TYPE_CODE : 검색_이슈구분코드
					    , SRC_ISSUE_CODE	  : 검색_이슈코드
					    , SRC_ISSUE_COMMENT   : 검색_이슈내용
					    , START				  : 검색_시작페이지
					    , LIMIT	  			  : 검색_종료페이지
					    )
	 * @return int 
	 * 2011. 3. 14.
	 */
	public int insertIssue(HashMap paramMap)throws DaoException;

	/**
	 * 이슈정보관리 수정
	 * @param  request  ( ISSUE_CODE		  : 이슈코드 
					    , ISSUE_TYPE_CODE     : 이슈구분코드
					    , ISSUE_COMMENT       : 이슈내용
					    , USE_YN			  : 사용여부 
					    , SRC_ISSUE_TYPE_CODE : 검색_이슈구분코드
					    , SRC_ISSUE_CODE	  : 검색_이슈코드
					    , SRC_ISSUE_COMMENT   : 검색_이슈내용
					    , START				  : 검색_시작페이지
					    , LIMIT	  			  : 검색_종료페이지
					    )
	 * @return int 
	 * 2011. 3. 14.
	 */
	public int updateIssue(HashMap paramMap)throws DaoException;

	
	/**
	 * 이슈정보관리 목록팝업조회
	 * @param  paramMap	( src_issue_type_code : 이슈구분코드
	 *                  , src_issue_code 	  : 이슈코드
	 *                  , src_issue_comment   : 이슈내용
	 *                  , start				  : 검색(시작페이지)
	 *                  , limit				  : 검색(종료페이지)
	 * @return list     ( COM_ISSUE_INFO : 이슈정보관리)
	 * @throws Exception
	 * 2011. 3. 14.
	 */
	public List selectIssuePop(HashMap paramMap)throws DaoException;

	/**
	 * 이슈정보관리 목록팝업총갯수
	 * @param  paramMap	( src_issue_type_code : 이슈구분코드
	 *                  , src_issue_code 	  : 이슈코드
	 *                  , src_issue_comment   : 이슈내용
	 *                  )
	 * @return int      (목록 총갯수)
	 * @throws Exception
	 * 2011. 3. 14.
	 */
	public int selectIssuePopCount(HashMap paramMap)throws DaoException;	
}
