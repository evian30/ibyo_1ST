/**
 *  Class Name  : IssueController.java
 *  Description : 이슈관리 Controller
 *  Modification Information
 *
 *  수정일                   수정자               수정내용
 *  -------      --------   ---------------------------
 *  2011. 3. 11. 고기범              최초 생성
 *  2011. 4.  4. 고기범            session정보 설정
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

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.servlet.ModelAndView;

import com.sg.sgis.com.sgisCode.SgisCodeBiz;
import com.sg.sgis.util.CommonUtil;
import com.signgate.core.config.SGConfigManager;
import com.signgate.core.web.controller.SGUserController;
import com.signgate.core.web.util.WebUtil;

public class IssueController extends SGUserController{

	protected final Log logger = LogFactory.getLog(getClass());
	
	CommonUtil comUtil = new CommonUtil();
	
	// BIZ경로 설정
	private IssueBiz IssueBiz; 
	public void setIssueBiz(IssueBiz issueBiz){
		this.IssueBiz = issueBiz;
	}
	
	// 공통코드 BIZ경로 설정
	private SgisCodeBiz sgisCodeBiz;
	public void setSgisCodeBiz(SgisCodeBiz sgisCodeBiz) {
		this.sgisCodeBiz = sgisCodeBiz;
	} 
	
	/**
	 * 이슈관리 조회
	 * @param  request
	 * @param  response
	 * @return mav		(공통코드 목록)
	 * 2011. 1. 26.
	 */
	public ModelAndView issueList(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = null;
		
		try {
			mav = new ModelAndView();
			
			// 공통코드 조회
			List issue_type_code = sgisCodeBiz.selectComboCode("ISSUE_TYPE_CODE");	// 이슈구분코드
			mav.addObject("ISSUE_TYPE_CODE", issue_type_code);						// 이슈구분코드
			mav.addObject("RESULT", "");

		} catch (Exception e) {
			logger.error(e, e);
		}
		return mav;
	}
	
	/**
	 * 이슈정보관리 : 조회된 목록을 화면으로 retuen
	 * @param  request (
	 *  			    SRC_ISSUE_TYPE_CODE : 검색_이슈구분코드
	 *                 ,SRC_ISSUE_CODE 		: 검색_이슈코드
	 *                 ,SRC_ISSUE_COMMENT	: 검색_이슈내용
	 *                 ,START				: 검색_시작페이지
	 *                 ,LIMT				: 검색_종료페이지
	 *                 )
	 * @param  response
	 * @return mav	   (COM_ISSUE_INFO : 이슈관리)
	 * 2011. 1. 26.
	 */
	public ModelAndView result_1st(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = null;
		
		try{
			mav = new ModelAndView();
			mav.setViewName("/result/result_1st");	
			HashMap paramMap = WebUtil.parseRequestMap(request); 
			
			/***** 그리드의 페이지 클릭시 						 *****/
			/***** 검색조건에 한글조회값이 있다면 해당 필드만 decode	 *****/  
			if("grid_page".equals(request.getParameter("div"))){
				paramMap.put("src_issue_comment",comUtil.getDecodingUTF(request.getParameter("src_issue_comment")));
			}
			
			//System.out.println("test issue 조회값 -----------------------------------");
			//System.out.println(paramMap.toString());
			//System.out.println("test issue 조회값 -----------------------------------");
			
			/***** paging *****/ 
			int limit = Integer.parseInt(paramMap.get("limit").toString());
			int start = Integer.parseInt(paramMap.get("start").toString()); 
			paramMap.put("limit", limit+start);
			
			/***** DB에서 목록조회 *****/
			List result = IssueBiz.selectIssue(paramMap);			
			
			/***** 조회된 결과를 JSON형식으로 screen에 Return *****/
			JSONArray jsonArray = JSONArray.fromObject(result);
			HashMap<String,Object> mapResult = new HashMap<String, Object>();
			mapResult.put("success", "true");							// 성공여부
			mapResult.put("message", "Loaded data");					// message
			
			mapResult.put("data_1st", jsonArray);							// 조회된 결과값
			mapResult.put("total_1st", IssueBiz.selectIssueCount(paramMap)); // 목록의 총갯수 조회
			JSONObject jsonObject = JSONObject.fromObject(mapResult);	// JSON형식으로 설정
			mav.addObject("RESULT_1ST", jsonObject);						// 조회된 결과값을 담기
			
			logger.debug("test Edit_grid -----------------------------------");
			logger.debug(jsonObject);
			logger.debug("test Edit_grid -----------------------------------");

		}catch(Exception ex){
			logger.error(ex.getMessage());
		}
		
		return mav;
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
	public ModelAndView checkIssueCode(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = null;
		
		try {
			mav = new ModelAndView();
			mav.setViewName("/result");	
			HashMap paramMap = WebUtil.parseRequestMap(request); 
			
			//System.out.println("issue code check start.........");
			//System.out.println("구분코드........................ : "+request.getParameter("issue_type_code"));
			//System.out.println("코드............................ : "+request.getParameter("issue_code"));
			
			// 이슈코드 중복체크
			String checkIssueCode = IssueBiz.checkIssueCode(paramMap);
			
			// 이슈코드 중복체크 결과를 return 
			HashMap<String,Object> mapResult = new HashMap<String, Object>();
			mapResult.put("CHECK_ISSUE_CODE", checkIssueCode);				// 이슈구분코드
			JSONObject jsonObject = JSONObject.fromObject(mapResult);		// JSON형식으로 설정
			mav.addObject("RESULT", jsonObject);

			//System.out.println("issue code check end............................");
			
		} catch (Exception e) {
			logger.error(e, e);
		}
		return mav;
	}
	
	
	/**
	 * 이슈정보관리 등록, 수정
	 * @param  request  ( ISSUE_CODE		     : 이슈코드 
					    , ISSUE_TYPE_CODE     : 이슈구분코드
					    , ISSUE_COMMENT       : 이슈내용
					    , USE_YN			     : 사용여부 
					    , SRC_ISSUE_TYPE_CODE : 검색_이슈구분코드
					    , SRC_ISSUE_CODE		 : 검색_이슈코드
					    , SRC_ISSUE_COMMENT   : 검색_이슈내용
					    , START				 : 검색_시작페이지
					    , LIMIT	  			 : 검색_종료페이지
					    )
	 * @return response (COM_ISSUE_INFO : 이슈관리)
	 * 2011. 3. 14.
	 */
	public ModelAndView updateIssue(HttpServletRequest request, HttpServletResponse response) {
		
		ModelAndView mav = new ModelAndView();
		JSONObject jsonObject = new JSONObject();
		HashMap<String,Object> mapResult = new HashMap<String, Object>();
		
		try {

			mav = new ModelAndView();
			mav.setViewName("/result/result_1st");	
			
			/***** 조회조건 및 parameter설정 *****/
			HashMap paramMap = WebUtil.parseRequestMap(request); 
			
			/***** session 정보 *****/
			HashMap adminMap = (HashMap)request.getSession().getAttribute(SGConfigManager.getString("common.session.admin.name"));
			paramMap.put("final_mod_id", (String)adminMap.get("ADMIN_ID"));	// 로그인 ID
			
			/***** 저장 및 수정 *****/
			boolean deptRegResult = IssueBiz.updateIssue(paramMap);		 
			
			/***** 목록조회 *****/
			List result = IssueBiz.selectIssue(paramMap);					
			
			/***** 조회된 결과를 JSON형식으로 screen에 Return *****/
			JSONArray jsonArray = JSONArray.fromObject(result);
			mapResult.put("success", "true");							// 성공여부
			mapResult.put("message", "Loaded data");					// message
			mapResult.put("total_1st", IssueBiz.selectIssueCount(paramMap));// 목록의 총갯수 조회
			mapResult.put("data_1st", jsonArray);							// 조회된 결과값
			jsonObject = JSONObject.fromObject(mapResult);				// JSON형식으로 설정
			
		} catch (Exception e) {
			logger.error(e, e);
		} finally{
			
		}
		
		mav.addObject("RESULT_1ST", jsonObject);						// 조회된 결과값을 담기
		
		return mav;
	}
	
	
	public ModelAndView issueInfoPop(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = null;
		
		try {
			mav = new ModelAndView();

			// 공통코드 조회
			List issue_type_code = sgisCodeBiz.selectComboCode("ISSUE_TYPE_CODE");	// 이슈구분코드
			mav.addObject("ISSUE_TYPE_CODE", issue_type_code);						// 이슈구분코드
			
			
		} catch (Exception e) {
			logger.error(e, e);
		}
		return mav;
	}

	
	/**
	 * 이슈정보관리  팝업
	 * @param  request 
	 * @param  response
	 * @return mav	   (COM_EMP_INFO : 사원정보)
	 * 2011. 4. 11.
	 * @throws Exception 
	 */
	public ModelAndView issueInfoPopList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ModelAndView mav = null;
		
		try{
			mav = new ModelAndView();
			mav.setViewName("/result/result_1st");	
			HashMap map = WebUtil.parseRequestMap(request); 

			// 공통코드 조회
			List issue_type_code = sgisCodeBiz.selectComboCode("ISSUE_TYPE_CODE");	// 이슈구분코드
			mav.addObject("ISSUE_TYPE_CODE", issue_type_code);						// 이슈구분코드
			
			
			/***** 그리드의 페이지 클릭시 						 *****/
			/***** 검색조건에 한글조회값이 있다면 해당 필드만 decode	 *****/  
			if("grid_page".equals(request.getParameter("div"))){
//				map.put("src_kor_name",comUtil.getDecodingUTF(request.getParameter("src_kor_name")));
//				map.put("src_dept_name",comUtil.getDecodingUTF(request.getParameter("src_dept_name")));
			}
			
			/***** paging *****/ 
			int limit = 0;
			if((String)map.get("limit") != null)
				limit = Integer.parseInt((String)map.get("limit"));
			int start = 0;
			if((String)map.get("start") != null)
				start = Integer.parseInt((String)map.get("start"));
			
			map.put("limit", limit+start); 
			
			//System.out.println("이런 이런............야............."+map.toString());
			
			List result = IssueBiz.selectIssuePop(map);						// DB에서 목록조회
			
			/***** 조회된 결과를 JSON형식으로 screen에 Return *****/
			JSONArray jsonArray = JSONArray.fromObject(result);
			HashMap<String,Object> mapResult = new HashMap<String, Object>();
			mapResult.put("success", "true");										// 성공여부
			mapResult.put("message", "Loaded data");								// message
			
			mapResult.put("data_1st_pop", jsonArray);								// 조회된 결과값
			mapResult.put("total_1st_pop", IssueBiz.selectIssuePopCount(map));// 목록의 총갯수 조회
			JSONObject jsonObject = JSONObject.fromObject(mapResult);				// JSON형식으로 설정
			mav.addObject("RESULT_1ST", jsonObject);								// 조회된 결과값을 담기
			
			//System.out.println("===issueInfoPopList===...."+jsonObject.toString());
			
		}catch(Exception ex){
			logger.error(ex.getMessage());
		}
		
		return mav;
	}	
	
}
