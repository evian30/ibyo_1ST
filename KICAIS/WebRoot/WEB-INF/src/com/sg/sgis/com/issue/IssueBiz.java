/**
 *  Class Name  : IssueBiz.java
 *  Description : 이슈관리 Biz
 *  Modification Information
 *
 *  수정일                   수정자               수정내용
 *  -------      --------   ---------------------------
 *  2011. 3. 11. 고기범              최초 생성
 *
 *  @author 고기범
 *  @since 2011. 3. 11.
 *  @version 1.0
 *  @see 
 * 
 *  Copyright (C) 2011 by SG All right reserved.
 */
package com.sg.sgis.com.issue;

import java.util.HashMap;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.sg.sgis.com.issue.dao.IssueDaoImpl;

import sg.svc.portal.util.NewPageNavigator;

public class IssueBiz {

	NewPageNavigator pageNavi = new NewPageNavigator();
	
	protected final Log logger = LogFactory.getLog(getClass());
	
	// Dao경로 설정
	private IssueDaoImpl issueDao; 
	public void setIssueDao(IssueDaoImpl issueDao)
	{
		this.issueDao = issueDao;
	}
	
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
	public List selectIssue(HashMap paramMap)throws Exception{
		List list = null;
		
		try{
			
			list = issueDao.selectIssue(paramMap);
			
		}catch(Exception e){
			logger.error(e, e);
		}
		return list;
	}

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
	public int selectIssueCount(HashMap paramMap)throws Exception{
		int result = 0;

		try{
			
			result = issueDao.selectIssueCount(paramMap);
			
		}catch(Exception e){
			logger.error(e, e);
		}
		return result;
	}

	/**
	 * 이슈코드 중복체크
	 * @param  request (
	 *  			    ISSUE_TYPE_CODE : 이슈구분코드
	 *                 ,ISSUE_CODE 		: 이슈코드
	 *                 )
	 * @return String  (Y : 사용가능, N : 사용불가)
	 * 2011. 3. 14.
	 */
	public String checkIssueCode(HashMap paramMap)throws Exception{
		String result = "";
		
		try{

			result = issueDao.checkIssueCode(paramMap);
			
		}catch(Exception e){
			logger.error(e, e);
		}
		return result;
	}

	/**
	 * 이슈정보관리 등록, 수정
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
	 * @return response ( true	: 등록, 수정 성공
	 *                  , false : 등록, 수정 실패
	 *                  )
	 * 2011. 3. 14.
	 */
	public boolean updateIssue(HashMap paramMap)throws Exception{
		
		int regResult = 0;
		boolean result = true;
		
		try{
			// flag값이 없으면 신규, 그렇지 않으면 저장
			if(("").equals(paramMap.get("flag"))){
				// 저장
				regResult = issueDao.insertIssue(paramMap);
				
			}else{ 
				// 수정
				regResult = issueDao.updateIssue(paramMap);
			}
		}catch(Exception e){
			logger.error(e, e);
		}
		return result;
	}
	
	
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
	public List selectIssuePop(HashMap paramMap)throws Exception{
		List list = null;
		
		try{
			
			list = issueDao.selectIssuePop(paramMap);
			
		}catch(Exception e){
			logger.error(e, e);
		}
		return list;
	}

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
	public int selectIssuePopCount(HashMap paramMap)throws Exception{
		int result = 0;

		try{
			
			result = issueDao.selectIssuePopCount(paramMap);
			
		}catch(Exception e){
			logger.error(e, e);
		}
		return result;
	}	
	
}
