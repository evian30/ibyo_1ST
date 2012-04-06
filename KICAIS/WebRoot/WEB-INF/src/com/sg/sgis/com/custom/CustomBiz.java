/**
 *  Class Name  : CustomBiz.java
 *  Description : 거래처관리 Biz
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
package com.sg.sgis.com.custom;

import java.util.HashMap;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.sg.sgis.com.custom.dao.CustomDaoImpl;

public class CustomBiz {
	
	protected final Log logger = LogFactory.getLog(getClass());
	
	// Dao경로 설정
	private CustomDaoImpl customDao;
	public void setCustomDao(CustomDaoImpl customDao) 
	{
		this.customDao = customDao;
	}
	
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
	public List selectCustom(HashMap paramMap)throws Exception{
		
		List list = null;
		
		try{
			
			list = customDao.selectCustom(paramMap);
			
		}catch(Exception e){
			logger.error(e, e);
		}
		return list;
	}

	/**
	 * 거래처관리 목록총갯수
	 * @param  paramMap	( 
	 * 					  src_custom_type : 검색_거래처구분
	 *                  , src_custom_code : 검색_거래처코드
	 *                  , src_biz_num	  : 검색_사업자번호
	 * @return int      (목록 총갯수)
	 * @throws Exception
	 * 2011. 3. 15.
	 */
	public int selectCustomCount(HashMap paramMap)throws Exception{
		int result = 0;

		try{

			result = customDao.selectCustomCount(paramMap);
			
		}catch(Exception e){
			logger.error(e, e);
		}
		return result;
	}

	/**
	 * 고객정보관리 등록, 수정
	 * @param  paramMap ( COM_CUSTOM        : 거래처관리(Table정보)
					    , src_custom_type   : 검색_거래처구분
					    , src_custom_code   : 검색_거래처코드
					    , src_biz_num       : 검색_사업자번호
					    , start				: 검색_시작페이지
					    , limit	  			: 검색_종료페이지
					    )
	 * @return boolean  ( true	: 등록, 수정 성공
	 *                  , false : 등록, 수정 실패
	 *                  )
	 * 2011. 3. 16.
	 */
	public boolean updateCustom(HashMap paramMap)throws Exception{
		int regResult = 0;
		boolean result = true;
		
		try{
			// flag값이 없으면 신규, 그렇지 않으면 저장
			if(("").equals(paramMap.get("flag"))){
				// 저장
				regResult = customDao.insertCustom(paramMap);
				
			}else{ 
				// 수정
				regResult = customDao.updateCustom(paramMap);
			}
		}catch(Exception e){
			logger.error(e, e);
		}
		return result;
	}

	/**
	 * 거래처조회 팝업
	 * @param  paramMap
	 * @return List		(공통코드 목록)
	 * 2011. 3. 16.
	 */
	public List selectCustomPopList(HashMap paramMap)throws Exception{
		List result = null;
		
		try{
			
			result = customDao.selectCustomPopList(paramMap);
			
		}catch(Exception e){
			logger.error(e, e);
		}
		
		return result;
	}

	/**
	 * 거래처담당자관리 목록조회
	 * @param  paramMap(
	 *                  src_custom_code	  : 검색_거래처코드
	 *                 ,src_biz_num	      : 검색_사업자번호
	 *                 ,src_customer_name : 검색_담당자명
	 *                 )
	 * @return List	   (COM_CUSTOM_MEMBER : 거래처담당자관리
	 * 				   ,COM_CUSTOM        : 거래처관리)
	 * 2011. 3. 17.
	 */
	public List selectCustomMember(HashMap paramMap)throws Exception{
		List list = null;
		
		try{
			
			list = customDao.selectCustomMember(paramMap);
			
		}catch(Exception e){
			logger.error(e, e);
		}
		return list;
	}

	/**
	 * 거래처담당자관리 목록조회 총갯수
	 * @param  paramMap(
	 *                  src_custom_code	  : 검색_거래처코드
	 *                 ,src_biz_num	      : 검색_사업자번호
	 *                 ,src_customer_name : 검색_담당자명
	 *                 )
	 * @return int
	 * 2011. 3. 17.
	 */
	public int selectCustomMemberCount(HashMap paramMap)throws Exception{
		int result = 0;

		try{

			result = customDao.selectCustomMemberCount(paramMap);
			
		}catch(Exception e){
			logger.error(e, e);
		}
		return result;
	}

	/**
	 * 거래처담당자 등록, 수정
	 * @param  paramMap ( COM_CUSTOM_MEMBER : 거래처담당자관리(table정보)
					    , src_customer_name : 검색_담당자명
					    , src_custom_code   : 검색_거래처번호
					    , src_biz_num       : 검색_사업자번호
					    , start				: 검색_시작페이지
					    , limit	  			: 검색_종료페이지
					    )
	 * @return boolean  ( true	: 등록, 수정 성공
	 *                  , false : 등록, 수정 실패
	 *                  )
	 * 2011. 3. 16.
	 */
	public boolean updateCustomMember(HashMap paramMap)throws Exception{
		int regResult = 0;
		boolean result = true;
		
		try{
			// flag값이 없으면 신규, 그렇지 않으면 저장
			if(("").equals(paramMap.get("flag"))){
				// 저장
				regResult = customDao.insertCustomMember(paramMap);
				
			}else{ 
				// 수정
				regResult = customDao.updateCustomMember(paramMap);
			}
		}catch(Exception e){
			logger.error(e, e);
			e.printStackTrace();
		}
		return result;
	}

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
	public List customListView(HashMap paramMap)throws Exception{
		List list = null;
		
		try{
			
			list = customDao.customListView(paramMap);
			
		}catch(Exception e){
			logger.error(e, e);
		}
		return list;
	}

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
	public int customListViewCount(HashMap paramMap)throws Exception{
		int result = 0;

		try{

			result = customDao.customListViewCount(paramMap);
			
		}catch(Exception e){
			logger.error(e, e);
		}
		return result;
	}

	/**
	 * 거래처정보조회 (거래처담당자)
	 * @param  paramMap (
	 *                   src_custom_code	  : 검색_거래처코드
	 *                  )
	 * @return List	    (COM_CUSTOM_MEMBER : 거래처담당자관리)
	 * 2011. 3. 18.
	 */
	public List customMemberListView(HashMap paramMap)throws Exception{
		List list = null;
		
		try{
			
			list = customDao.customMemberListView(paramMap);
			
		}catch(Exception e){
			logger.error(e, e);
		}
		return list;
	}

	/**
	 * 거래처정보조회 (거래처담당자) 총갯수
	 * @param  paramMap (
	 *                   src_custom_code	  : 검색_거래처코드
	 *                  )
	 * @return int
	 * 2011. 3. 18.
	 */
	public int customMemberListViewCount(HashMap paramMap)throws Exception{
		int result = 0;

		try{

			result = customDao.customMemberListViewCount(paramMap);
			
		}catch(Exception e){
			logger.error(e, e);
		}
		return result;
	}
	
	
	/**
	 * 거래처정보조회 (거래처담당자) 팝업
	 * @param  paramMap (
	 *                   src_custom_code	  : 검색_거래처코드
	 *                  )
	 * @return List	    (COM_CUSTOM_MEMBER : 거래처담당자관리)
	 * 2011. 3. 18.
	 */
	public List selectCustomMemberPop(HashMap paramMap)throws Exception{
		List list = null;
		
		try{
			
			list = customDao.selectCustomMemberPop(paramMap);
			
		}catch(Exception e){
			logger.error(e, e);
		}
		return list;
	}

	/**
	 * 거래처정보조회 (거래처담당자) 팝업총갯수
	 * @param  paramMap (
	 *                   src_custom_code	  : 검색_거래처코드
	 *                  )
	 * @return int
	 * 2011. 3. 18.
	 */
	public int selectCustomMemberPopCount(HashMap paramMap)throws Exception{
		int result = 0;

		try{

			result = customDao.selectCustomMemberPopCount(paramMap);
			
		}catch(Exception e){
			logger.error(e, e);
		}
		return result;
	}	
	
}
