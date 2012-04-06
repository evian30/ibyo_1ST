/**
 *  Class Name  : CustomDaoImpl.java
 *  Description : 거래처관리 DaoImpl
 *  Modification Information
 *
 *  수정일                   수정자               수정내용
 *  -------      --------   ---------------------------
 *  2011. 1. 28. 이재철              최초 생성
 *  2011. 3. 15. 고기범
 *
 *  @author 이재철
 *  @since 2011. 1. 28.
 *  @version 1.0
 *  @see 
 * 
 *  Copyright (C) 2011 by SG All right reserved.
 */
package com.sg.sgis.com.custom.dao;

import java.util.HashMap;
import java.util.List;

import com.signgate.core.exception.DaoException;

public interface CustomDaoImpl {

	/**
	 * 거래처관리 목록조회
	 * @param  paramMap	( 
	 * 					  src_custom_type : 검색_거래처구분
	 *                  , src_custom_code : 검색_거래처코드
	 *                  , src_biz_num	  : 검색_사업자번호
	 *                  , start			  : 검색(시작페이지)
	 *                  , limit			  : 검색(종료페이지)
	 * @return list     ( COM_CUSTOM : 거래처관리)
	 * @throws Exception
	 * 2011. 3. 15.
	 */
	public List selectCustom(HashMap paramMap)throws DaoException;

	/**
	 * 거래처관리 목록총갯수
	 * @param  paramMap	( 
	 * 					  src_custom_type : 검색_거래처구분
	 *                  , src_custom_code : 검색_거래처코드
	 *                  , src_biz_num	  : 검색_사업자번호
	 * @return int      (목록 총갯수)
	 * @throws DaoException 
	 * 2011. 3. 15.
	 */
	public int selectCustomCount(HashMap paramMap)throws DaoException;

	/**
	 * 고객정보관리 등록
	 * @param  request  ( COM_CUSTOM        : 거래처관리(Table정보)
					    , SRC_CUSTOM_TYPE   : 검색_거래처구분
					    , SRC_CUSTOM_CODE   : 검색_거래처코드
					    , SRC_BIZ_NUM       : 검색_사업자번호
					    , START				: 검색_시작페이지
					    , LIMIT	  			: 검색_종료페이지
					    )
	 * @return int
	 * 2011. 3. 16.
	 */
	public int insertCustom(HashMap paramMap)throws DaoException;

	/**
	 * 고객정보관리 수정
	 * @param  request  ( COM_CUSTOM        : 거래처관리(Table정보)
					    , SRC_CUSTOM_TYPE   : 검색_거래처구분
					    , SRC_CUSTOM_CODE   : 검색_거래처코드
					    , SRC_BIZ_NUM       : 검색_사업자번호
					    , START				: 검색_시작페이지
					    , LIMIT	  			: 검색_종료페이지
					    )
	 * @return int
	 * 2011. 3. 16.
	 */
	public int updateCustom(HashMap paramMap)throws DaoException;

	/**
	 * 거래처조회 팝업
	 * @param  request
	 * @param  response
	 * @return mav		(공통코드 목록)
	 * 2011. 3. 16.
	 */
	public List selectCustomPopList(HashMap paramMap)throws DaoException;

	/**
	 * 거래처담당자관리 목록조회
	 * @param  request (
	 *                  src_custom_code	  : 검색_거래처코드
	 *                 ,src_biz_num	      : 검색_사업자번호
	 *                 ,src_customer_name : 검색_담당자명
	 *                 )
	 * @param  response
	 * @return List	   (COM_CUSTOM_MEMBER : 거래처담당자관리
	 * 				   ,COM_CUSTOM        : 거래처관리)
	 * 2011. 3. 17.
	 */
	public List selectCustomMember(HashMap paramMap)throws DaoException;

	/**
	 * 거래처담당자관리 목록조회 총갯수
	 * @param  request (
	 *                  src_custom_code	  : 검색_거래처코드
	 *                 ,src_biz_num	      : 검색_사업자번호
	 *                 ,src_customer_name : 검색_담당자명
	 *                 )
	 * @param  response
	 * @return int
	 * 2011. 3. 17.
	 */
	public int selectCustomMemberCount(HashMap paramMap)throws DaoException;

	/**
	 * 거래처담당자 등록
	 * @param  request  ( COM_CUSTOM_MEMBER : 거래처담당자관리(Table정보)
					    , SRC_CUSTOMER_NAME : 검색_담당자명
					    , SRC_CUSTOM_CODE   : 검색_거래처번호
					    , SRC_BIZ_NUM       : 검색_사업자번호
					    , START				: 검색_시작페이지
					    , LIMIT	  			: 검색_종료페이지
					    )
	 * @return response ( true	: 등록, 수정 성공
	 *                  , false : 등록, 수정 실패
	 *                  )
	 * 2011. 3. 16.
	 */
	public int insertCustomMember(HashMap paramMap)throws DaoException;

	/**
	 * 거래처담당자 수정
	 * @param  request  ( COM_CUSTOM_MEMBER : 거래처담당자관리(Table정보)
					    , SRC_CUSTOMER_NAME : 검색_담당자명
					    , SRC_CUSTOM_CODE   : 검색_거래처번호
					    , SRC_BIZ_NUM       : 검색_사업자번호
					    , START				: 검색_시작페이지
					    , LIMIT	  			: 검색_종료페이지
					    )
	 * @return response ( true	: 등록, 수정 성공
	 *                  , false : 등록, 수정 실패
	 *                  )
	 * 2011. 3. 16.
	 */
	public int updateCustomMember(HashMap paramMap)throws DaoException;

	/**
	 * 거래처정보조회 (거래처)
	 * @param  paramMap(src_custom_type   : 검색_거래처구분
	 *                 ,src_custom_code	  : 검색_거래처코드
	 *                 ,src_biz_num	      : 검색_사업자번호
	 *                 ,src_customer_name : 검색_담당자명
	 *                 ,src_custom_level  : 검색_거래처등급
	 *                 ,src_use_yn        : 검색_사용여부
	 *                 )
	 * @return List	   (COM_CUSTOM        : 거래처관리)
	 * 2011. 3. 18.
	 */
	public List customListView(HashMap paramMap)throws DaoException;

	/**
	 * 거래처정보조회 (거래처) 총갯수
	 * @param  paramMap (src_custom_type   : 검색_거래처구분
	 *                  ,src_custom_code   : 검색_거래처코드
	 *                  ,src_biz_num	   : 검색_사업자번호
	 *                  ,src_customer_name : 검색_담당자명
	 *                  ,src_custom_level  : 검색_거래처등급
	 *                  ,src_use_yn        : 검색_사용여부
	 *                  )
	 * @return int
	 * 2011. 3. 18.
	 */
	public int customListViewCount(HashMap paramMap)throws DaoException;

	/**
	 * 거래처정보조회 (거래처담당자)
	 * @param  paramMap (
	 *                   src_custom_code	  : 검색_거래처코드
	 *                  )
	 * @return List	    (COM_CUSTOM_MEMBER : 거래처담당자관리)
	 * 2011. 3. 18.
	 */
	public List customMemberListView(HashMap paramMap)throws DaoException;

	/**
	 * 거래처정보조회 (거래처담당자) 총갯수
	 * @param  paramMap (
	 *                   src_custom_code	  : 검색_거래처코드
	 *                  )
	 * @return int
	 * 2011. 3. 18.
	 */
	public int customMemberListViewCount(HashMap paramMap)throws DaoException;
	
	/**
	 * 거래처정보조회 (거래처담당자)팝업
	 * @param  paramMap (
	 *                   src_custom_code	  : 검색_거래처코드
	 *                  )
	 * @return List	    (COM_CUSTOM_MEMBER : 거래처담당자관리)
	 * 2011. 3. 18.
	 */
	public List selectCustomMemberPop(HashMap paramMap)throws DaoException;

	/**
	 * 거래처정보조회 (거래처담당자) 팝업총갯수
	 * @param  paramMap (
	 *                   src_custom_code	  : 검색_거래처코드
	 *                  )
	 * @return int
	 * 2011. 3. 18.
	 */
	public int selectCustomMemberPopCount(HashMap paramMap)throws DaoException;	

}
