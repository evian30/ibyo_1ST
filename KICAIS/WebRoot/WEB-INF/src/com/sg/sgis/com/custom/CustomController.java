/**
 *  Class Name  : CustomController.java
 *  Description : 거래처관리 Controller
 *  Modification Information
 *
 *  수정일                   수정자               수정내용
 *  -------      --------   ---------------------------
 *  2011. 1. 28. 이재철              최초 생성
 *  2011. 3. 15. 고기범
 *  2011. 4.  1. 고기범 		 Session 정보 추가(입력, 수정)
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

public class CustomController  extends SGUserController{
	
	protected final Log logger = LogFactory.getLog(getClass());
	
	CommonUtil comUtil = new CommonUtil();
	
	// Biz경로 설정
	CustomBiz customBiz;
	public void setCustomBiz(CustomBiz customBiz) {
		this.customBiz = customBiz;
	}
	
	// 공통코드 BIZ경로 설정
	private SgisCodeBiz sgisCodeBiz;
	public void setSgisCodeBiz(SgisCodeBiz sgisCodeBiz) {
		this.sgisCodeBiz = sgisCodeBiz;
	}
	
	/**
	 * 거래처관리 조회
	 * @param  request
	 * @param  response
	 * @return mav		(공통코드 목록)
	 * 2011. 3. 15.
	 */
	public ModelAndView customList(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = null;
		
		try {
			mav = new ModelAndView();
			
			// 공통코드 조회
			List custom_type = sgisCodeBiz.selectComboCode("CUSTOM_TYPE");				// 거래처구분코드
			List custom_level_code = sgisCodeBiz.selectComboCode("CUSTOM_LEVEL_CODE");	// 거래처등급코드
			List per_biz_type_code = sgisCodeBiz.selectComboCode("PER_BIZ_TYPE_CODE");	// 개인/사업자구분코드

			mav.addObject("CUSTOM_TYPE", custom_type);				// 거래처구분코드
			mav.addObject("CUSTOM_LEVEL_CODE", custom_level_code);	// 거래처등급코드
			mav.addObject("PER_BIZ_TYPE_CODE", per_biz_type_code);	// 개인/사업자구분코드
			
			HashMap adminMap = (HashMap)request.getSession().getAttribute(SGConfigManager.getString("common.session.admin.name"));
			
			mav.addObject("admin_id",(String)adminMap.get("ADMIN_ID"));
			mav.addObject("admin_nm",(String)adminMap.get("ADMIN_NM"));
			mav.addObject("sabun",(String)adminMap.get("SABUN"));
			
			mav.addObject("RESULT", "");

		} catch (Exception e) {
			logger.error(e, e);
		}
		return mav;
	}
	
	/**
	 * 거래처정보 조회(팝업)
	 * @param  request
	 * @param  response
	 * @return mav		(공통코드 목록)
	 * 2011. 3. 15.
	 */
	public ModelAndView customPop(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = null;
		
		try {
			mav = new ModelAndView();
			mav.addObject("RESULT", "");

		} catch (Exception e) {
			logger.error(e, e);
		}
		return mav;
	}
	
	/**
	 * 거래처담당자 조회(팝업)
	 * @param  request
	 * @param  response
	 * @return mav		(공통코드 목록)
	 * 2011. 4. 11.
	 */
	public ModelAndView customMemberPop(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = null;
		
		try {
			mav = new ModelAndView();
			mav.addObject("RESULT", "");

		} catch (Exception e) {
			logger.error(e, e);
		}
		return mav;
	}
	
	/**
	 * 거래처정보조회 (view)
	 * @param  request
	 * @param  response
	 * @return mav		(공통코드 목록)
	 * 2011. 3. 15.
	 */
	public ModelAndView customView(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = null;
		
		try {
			mav = new ModelAndView();
			
			// 공통코드 조회
			List custom_type = sgisCodeBiz.selectComboCode("CUSTOM_TYPE");				// 거래처구분코드
			List custom_level_code = sgisCodeBiz.selectComboCode("CUSTOM_LEVEL_CODE");	// 거래처등급코드
			List yesno_code = sgisCodeBiz.selectComboCode("YESNO_CODE");				// 사용여부

			mav.addObject("CUSTOM_TYPE", custom_type);				// 거래처구분코드
			mav.addObject("CUSTOM_LEVEL_CODE", custom_level_code);	// 거래처등급코드
			mav.addObject("YESNO_CODE", yesno_code);				// 사용여부
			
			mav.addObject("RESULT", "");

		} catch (Exception e) {
			logger.error(e, e);
		}
		return mav;
	}
	/**
	 * 거래처담당자 조회
	 * @param  request
	 * @param  response
	 * @return mav		(공통코드 목록)
	 * 2011. 3. 15.
	 */
	public ModelAndView customMemberList(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = null;
		
		try {
			mav = new ModelAndView();
			
			// 공통코드 조회
			List custom_type = sgisCodeBiz.selectComboCode("CUSTOM_TYPE");				 // 거래처구분코드
			List customer_roll_code = sgisCodeBiz.selectComboCode("CUSTOMER_ROLL_CODE"); // 업무구분코드
			List custom_level_code = sgisCodeBiz.selectComboCode("CUSTOM_LEVEL_CODE");   // 담당자등급
			
			mav.addObject("CUSTOM_TYPE", custom_type);				 // 거래처구분코드
			mav.addObject("CUSTOMER_ROLL_CODE", customer_roll_code); // 업무구분코드
			mav.addObject("CUSTOM_LEVEL_CODE", custom_level_code);	 // 담당자등급
			
			HashMap adminMap = (HashMap)request.getSession().getAttribute(SGConfigManager.getString("common.session.admin.name"));
			
			mav.addObject("admin_id",(String)adminMap.get("ADMIN_ID"));
			mav.addObject("admin_nm",(String)adminMap.get("ADMIN_NM"));
			mav.addObject("sabun",(String)adminMap.get("SABUN"));
			
			mav.addObject("RESULT", "");

		} catch (Exception e) {
			logger.error(e, e);
		}
		return mav;
	}	
	
	/**
	 * 거래처관리 : 조회된 목록을 화면으로 retuen
	 * @param  request (
	 *  			    src_custom_type : 검색_거래처구분
	 *                 ,src_custom_code	: 검색_거래처코드
	 *                 ,src_biz_num	    : 검색_사업자번호
	 *                 )
	 * @param  response
	 * @return mav	   (COM_CUSTOM : 거래처관리)
	 * 2011. 1. 26.
	 */
	public ModelAndView result(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = null;
		
		try{
			mav = new ModelAndView();
			mav.setViewName("/result/result_1st");	
			HashMap paramMap = WebUtil.parseRequestMap(request); 
			
			/***** 그리드의 페이지 클릭시 						 *****/
			/***** 검색조건에 한글조회값이 있다면 해당 필드만 decode	 *****/  
			if("grid_page".equals(request.getParameter("div"))){
				// paramMap.put("src_custom_name",comUtil.getDecodingUTF(request.getParameter("src_custom_name")));
			}
			
			/***** paging *****/ 
			int limit = 0;
			if((String)paramMap.get("limit") != null)
				limit = Integer.parseInt((String)paramMap.get("limit"));
			int start = 0;
			if((String)paramMap.get("start") != null)
				start = Integer.parseInt((String)paramMap.get("start"));
			
			paramMap.put("limit", limit+start); 
			
			/***** DB에서 목록조회 *****/
			List result = customBiz.selectCustom(paramMap);			
			
			/***** 조회된 결과를 JSON형식으로 screen에 Return *****/
			JSONArray jsonArray = JSONArray.fromObject(result);
			HashMap<String,Object> mapResult = new HashMap<String, Object>();
			mapResult.put("success", "true");								// 성공여부
			mapResult.put("message", "Loaded data");						// message
			
			mapResult.put("data_1st", jsonArray);								// 조회된 결과값
			mapResult.put("total_1st", customBiz.selectCustomCount(paramMap)); 	// 목록의 총갯수 조회
			JSONObject jsonObject = JSONObject.fromObject(mapResult);			// JSON형식으로 설정
			mav.addObject("RESULT_1ST", jsonObject);							// 조회된 결과값을 담기
			
		}catch(Exception ex){
			logger.error(ex.getMessage());
		}
		
		return mav;
	}
	
	/**
	 * 거래처관리 등록, 수정
	 * @param  request  ( COM_CUSTOM          : 거래처관리
	 * 					, src_custom_type     : 검색_거래처구분
					    , src_custom_code     : 검색_거래처코드
					    , src_biz_num         : 검색_사업자번호
					    , start				  : 검색_시작페이지
					    , limit	  			  : 검색_종료페이지
					    )
	 * @return response (COM_CUSTOM : 거래처관리)
	 * 2011. 3. 14.
	 */
	public ModelAndView updateCustom(HttpServletRequest request, HttpServletResponse response) {
		
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
			boolean deptRegResult = customBiz.updateCustom(paramMap);		 
			
			/***** 목록조회 *****/
			List result = customBiz.selectCustom(paramMap);					
			
			/***** 조회된 결과를 JSON형식으로 screen에 Return *****/
			JSONArray jsonArray = JSONArray.fromObject(result);
			mapResult.put("success", "true");									// 성공여부
			mapResult.put("message", "Loaded data");							// message
			mapResult.put("total_1st", customBiz.selectCustomCount(paramMap));  // 목록의 총갯수 조회
			mapResult.put("data_1st", jsonArray);								// 조회된 결과값
			jsonObject = JSONObject.fromObject(mapResult);						// JSON형식으로 설정
			
		} catch (Exception e) {
			logger.error(e, e);
			e.printStackTrace();
		} finally{
			
		}
		
		mav.addObject("RESULT_1ST", jsonObject);						// 조회된 결과값을 담기
		
		return mav;
	}
	
	/**
	 * 거래처조회 팝업
	 * @param  request
	 * @param  response
	 * @return mav		(공통코드 목록)
	 * 2011. 3. 16.
	 */
	public ModelAndView customPopList(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = null;
		
		try {
			mav = new ModelAndView();
			mav.setViewName("result/result_2nd");	
			HashMap paramMap = WebUtil.parseRequestMap(request); 
			
			List result = customBiz.selectCustomPopList(paramMap);		// DB에서 목록조회
			JSONArray jsonArray = JSONArray.fromObject(result);
			
			// 조회된 결과를 JSON형식으로 screen에 Return
			HashMap<String,Object> mapResult = new HashMap<String, Object>();
			mapResult.put("success", "true");							// 성공여부
			mapResult.put("message", "Loaded data");					// message
			mapResult.put("data_2nd", jsonArray);						// 조회된 결과값
			JSONObject jsonObject = JSONObject.fromObject(mapResult);	// JSON형식으로 설정
			mav.addObject("RESULT_2ND", jsonObject);					// 조회된 결과값을 담기
			
		} catch (Exception e) {
			logger.error(e, e);
		}
		return mav;
	}
	
	/**
	 * 거래처담당자관리 목록조회 
	 * @param  request (
	 *                  src_custom_code	  : 검색_거래처코드
	 *                 ,src_biz_num	      : 검색_사업자번호
	 *                 ,src_customer_name : 검색_담당자명
	 *                 )
	 * @param  response
	 * @return mav	   (COM_CUSTOM_MEMBER : 거래처담당자관리
	 * 				   ,COM_CUSTOM        : 거래처관리)
	 * 2011. 3. 17.
	 */
	public ModelAndView customMemberResult(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = null;
		
		try{
			mav = new ModelAndView();
			mav.setViewName("/result/result_1st");	
			HashMap paramMap = WebUtil.parseRequestMap(request); 
			
			/***** 그리드의 페이지 클릭시 						 *****/
			/***** 검색조건에 한글조회값이 있다면 해당 필드만 decode	 *****/  
			if("grid_page".equals(request.getParameter("div"))){
				// 담당자명
				// paramMap.put("src_customer_name",comUtil.getDecodingUTF(request.getParameter("src_customer_name")));
			}
			
			/***** paging *****/ 
			/*grid 페이징 처리시 사용 할 페이지 시작 종료 value*/
			int limit = 0;
			if((String)paramMap.get("limit") != null)
				limit = Integer.parseInt((String)paramMap.get("limit"));
			int start = 0;
			if((String)paramMap.get("start") != null)
				start = Integer.parseInt((String)paramMap.get("start"));
			
			paramMap.put("limit", limit+start);  
			
			/***** DB에서 목록조회 *****/
			List result = customBiz.selectCustomMember(paramMap);			
			
			/***** 조회된 결과를 JSON형식으로 screen에 Return *****/
			JSONArray jsonArray = JSONArray.fromObject(result);
			HashMap<String,Object> mapResult = new HashMap<String, Object>();
			mapResult.put("success", "true");										// 성공여부
			mapResult.put("message", "Loaded data");								// message
			
			mapResult.put("data_1st", jsonArray);									// 조회된 결과값
			mapResult.put("total_1st", customBiz.selectCustomMemberCount(paramMap));// 목록의 총갯수 조회
			JSONObject jsonObject = JSONObject.fromObject(mapResult);				// JSON형식으로 설정
			mav.addObject("RESULT_1ST", jsonObject);									// 조회된 결과값을 담기
			
		}catch(Exception ex){

			ex.printStackTrace();
			logger.error(ex.getMessage());
		}
		
		return mav;
	}
	
	/**
	 * 거래처담당자등록
	 * @param  request  ( COM_CUSTOM_MEMBER : 거래처담당자관리)
	 * @return response 
	 * 2011. 3. 17.
	 */
	public ModelAndView updateCustomMember(HttpServletRequest request, HttpServletResponse response) {
		
		ModelAndView mav = new ModelAndView();
		HashMap<String,Object> mapResult = new HashMap<String, Object>();
		
		try {

			mav = new ModelAndView();
			mav.setViewName("result/result_1st");	
			
			/***** 조회조건 및 parameter설정 *****/
			HashMap paramMap = WebUtil.parseRequestMap(request); 
			
			/***** session 정보 *****/
			HashMap adminMap = (HashMap)request.getSession().getAttribute(SGConfigManager.getString("common.session.admin.name"));
						
			paramMap.put("final_mod_id", (String)adminMap.get("ADMIN_ID"));	// 로그인 ID
			
			/***** paging *****/ 
			/*grid 페이징 처리시 사용 할 페이지 시작 종료 value*/
			int limit = 0;
			if((String)paramMap.get("limit") != null)
				limit = Integer.parseInt((String)paramMap.get("limit"));
			int start = 0;
			if((String)paramMap.get("start") != null)
				start = Integer.parseInt((String)paramMap.get("start"));
			
			paramMap.put("limit", limit+start);  
			
			/***** 저장 및 수정 *****/
			boolean deptRegResult = customBiz.updateCustomMember(paramMap);		 
			
			/***** DB에서 목록조회 *****/
			List result = customBiz.selectCustomMember(paramMap);			
			
			/***** 조회된 결과를 JSON형식으로 screen에 Return *****/
			JSONArray jsonArray = JSONArray.fromObject(result);
			mapResult.put("success", "true");										// 성공여부
			mapResult.put("message", "Loaded data");								// message
			
			mapResult.put("data_1st", jsonArray);									// 조회된 결과값
			mapResult.put("total_1st", customBiz.selectCustomMemberCount(paramMap));// 목록의 총갯수 조회
			JSONObject jsonObject = JSONObject.fromObject(mapResult);				// JSON형식으로 설정
			mav.addObject("RESULT_1ST", jsonObject);									// 조회된 결과값을 담기
			
		} catch (Exception e) {
			logger.error(e, e);
			e.printStackTrace();
		} finally{
			
		}
		
		return mav;
	}
	
	/**
	 * 거래처정보조회 (거래처)
	 * @param  request (src_custom_type   : 검색_거래처구분
	 *                 ,src_custom_code	  : 검색_거래처코드
	 *                 ,src_biz_num	      : 검색_사업자번호
	 *                 ,src_customer_name : 검색_담당자명
	 *                 ,src_custom_level  : 검색_거래처등급
	 *                 ,src_use_yn        : 검색_사용여부
	 *                 )
	 * @param  response
	 * @return mav	   (COM_CUSTOM        : 거래처관리)
	 * 2011. 3. 18.
	 */
	public ModelAndView customListView(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = null;
		
		try{
			mav = new ModelAndView();
			mav.setViewName("/result/result_1st");	
			HashMap paramMap = WebUtil.parseRequestMap(request); 
			
			/***** 그리드의 페이지 클릭시 						 *****/
			/***** 검색조건에 한글조회값이 있다면 해당 필드만 decode	 *****/  
			if("grid_page".equals(request.getParameter("div"))){
				// 담당자명
				// paramMap.put("src_customer_name",comUtil.getDecodingUTF(request.getParameter("src_customer_name")));
			}
			
			/***** paging *****/ 
			/*grid 페이징 처리시 사용 할 페이지 시작 종료 value*/
			int limit = 0;
			if((String)paramMap.get("limit") != null)
				limit = Integer.parseInt((String)paramMap.get("limit"));
			int start = 0;
			if((String)paramMap.get("start") != null)
				start = Integer.parseInt((String)paramMap.get("start"));
			
			paramMap.put("limit", limit+start);  
			
			/***** DB에서 목록조회 *****/
			List result = customBiz.customListView(paramMap);			
			
			/***** 조회된 결과를 JSON형식으로 screen에 Return *****/
			JSONArray jsonArray = JSONArray.fromObject(result);
			HashMap<String,Object> mapResult = new HashMap<String, Object>();
			mapResult.put("success", "true");										// 성공여부
			mapResult.put("message", "Loaded data");								// message
			
			mapResult.put("data_1st", jsonArray);									// 조회된 결과값
			mapResult.put("total_1st", customBiz.customListViewCount(paramMap));    // 목록의 총갯수 조회
			JSONObject jsonObject = JSONObject.fromObject(mapResult);				// JSON형식으로 설정
			mav.addObject("RESULT_1ST", jsonObject);									// 조회된 결과값을 담기
			
		}catch(Exception ex){

			ex.printStackTrace();
			logger.error(ex.getMessage());
		}
		
		return mav;
	}
	
	/**
	 * 거래처정보조회 (거래처담당자)
	 * @param  request (
	 *                  src_custom_code	  : 검색_거래처코드
	 *                 )
	 * @param  response
	 * @return mav	   (COM_CUSTOM_MEMBER : 거래처담당자관리)
	 * 2011. 3. 18.
	 */
	public ModelAndView customMemberListView(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = null;
		
		try{
			mav = new ModelAndView();
			mav.setViewName("/result/result_2nd");	
			HashMap paramMap = WebUtil.parseRequestMap(request); 
			
			/***** 그리드의 페이지 클릭시 						 *****/
			/***** 검색조건에 한글조회값이 있다면 해당 필드만 decode	 *****/  
			if("grid_page".equals(request.getParameter("div"))){
				// 담당자명
				// paramMap.put("src_customer_name",comUtil.getDecodingUTF(request.getParameter("src_customer_name")));
			}
			
			/***** paging *****/ 
			/*grid 페이징 처리시 사용 할 페이지 시작 종료 value*/
			int limit = 0;
			if((String)paramMap.get("limit") != null)
				limit = Integer.parseInt((String)paramMap.get("limit"));
			int start = 0;
			if((String)paramMap.get("start") != null)
				start = Integer.parseInt((String)paramMap.get("start"));
			
			paramMap.put("limit", limit+start);  
			
			/***** DB에서 목록조회 *****/
			List result = customBiz.customMemberListView(paramMap);			
			
			/***** 조회된 결과를 JSON형식으로 screen에 Return *****/
			JSONArray jsonArray = JSONArray.fromObject(result);
			HashMap<String,Object> mapResult = new HashMap<String, Object>();
			mapResult.put("success", "true");										  // 성공여부
			mapResult.put("message", "Loaded data");								  // message
			
			mapResult.put("data_2nd", jsonArray);									  // 조회된 결과값
			mapResult.put("total_2nd", customBiz.customMemberListViewCount(paramMap));// 목록의 총갯수 조회
			JSONObject jsonObject = JSONObject.fromObject(mapResult);				  // JSON형식으로 설정
			mav.addObject("RESULT_2ND", jsonObject);									  // 조회된 결과값을 담기
			
		}catch(Exception ex){

			ex.printStackTrace();
			logger.error(ex.getMessage());
		}
		
		return mav;
	}
	
	/**
	 * 거래처담당자  팝업
	 * @param  request 
	 * @param  response
	 * @return mav	   (COM_EMP_INFO : 사원정보)
	 * 2011. 4. 11.
	 * @throws Exception 
	 */
	public ModelAndView customMemberPopList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ModelAndView mav = null;
		
		try{
			mav = new ModelAndView();
			mav.setViewName("/result/result_1st");	
			HashMap map = WebUtil.parseRequestMap(request); 
			
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
			
			List result = customBiz.selectCustomMemberPop(map);						// DB에서 목록조회
			
			/***** 조회된 결과를 JSON형식으로 screen에 Return *****/
			JSONArray jsonArray = JSONArray.fromObject(result);
			HashMap<String,Object> mapResult = new HashMap<String, Object>();
			mapResult.put("success", "true");										// 성공여부
			mapResult.put("message", "Loaded data");								// message
			
			mapResult.put("data_1st_pop", jsonArray);								// 조회된 결과값
			mapResult.put("total_1st_pop", customBiz.selectCustomMemberPopCount(map));// 목록의 총갯수 조회
			JSONObject jsonObject = JSONObject.fromObject(mapResult);				// JSON형식으로 설정
			mav.addObject("RESULT_1ST", jsonObject);								// 조회된 결과값을 담기
			
		}catch(Exception ex){
			logger.error(ex.getMessage());
		}
		
		return mav;
	}
}
