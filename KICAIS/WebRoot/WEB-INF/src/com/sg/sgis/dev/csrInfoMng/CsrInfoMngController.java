/**
 *  Class Name  : CsrInfoController
 *  Description : 업무요청정보 Controller
 *  Modification Information
 *
 *  수정일                   수정자               수정내용
 *  -------      --------   ---------------------------
 *  2011. 3. 25. 이준영              최초 생성
 *
 *  @author 이준영
 *  @since 2011. 2. 8.
 *  @version 1.0
 *  @see 
 * 
 *  Copyright (C) 2011 by SG All right reserved.
 */


package com.sg.sgis.dev.csrInfoMng;


import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.servlet.ModelAndView;

import com.sg.sgis.com.dept.DeptBiz;
import com.sg.sgis.com.sgisCode.SgisCodeBiz;
import com.sg.sgis.pjt.pjtManage.PjtManageBiz;
import com.sg.sgis.util.CommonUtil;
import com.signgate.core.config.SGConfigManager;
import com.signgate.core.web.controller.SGUserController;
import com.signgate.core.web.util.WebUtil;



public class CsrInfoMngController extends SGUserController{
	
	protected final Log logger = LogFactory.getLog(getClass());
	
	CommonUtil comUtil = new CommonUtil();
	
	// BIZ경로 설정
	private CsrInfoMngBiz csrInfoMngBiz;
	
	private DeptBiz deptBiz;
	
	// 공통코드 BIZ경로 설정
	private SgisCodeBiz sgisCodeBiz;


	public CsrInfoMngBiz getCsrInfoMngBiz() {
		return csrInfoMngBiz;
	}

	public void setCsrInfoMngBiz(CsrInfoMngBiz csrInfoMngBiz) {
		this.csrInfoMngBiz = csrInfoMngBiz;
	}	
	
	
	public DeptBiz getDeptBiz() {
		return deptBiz;
	}

	public void setDeptBiz(DeptBiz deptBiz) {
		this.deptBiz = deptBiz;
	}

	public SgisCodeBiz getSgisCodeBiz() {
		return sgisCodeBiz;
	}

	public void setSgisCodeBiz(SgisCodeBiz sgisCodeBiz) {
		this.sgisCodeBiz = sgisCodeBiz;
	}

	// 로그인 사용자의 부서정보를 가져오기 위함
	 private PjtManageBiz pjtManageBiz; 
	 
	 public void setPjtManageBiz(PjtManageBiz pjtManageBiz){
	  this.pjtManageBiz = pjtManageBiz;
	 }
	 
	
	/**
	 * 업무요청정보 조회
	 * @param  request
	 * @param  response
	 * @return mav		(공통코드 목록)
	 * 2011. 1. 26.
	 */
	public ModelAndView csrInfoMngList(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = null;
		
		try {
			mav = new ModelAndView();
			
			  HashMap adminMap = (HashMap)request.getSession().getAttribute(SGConfigManager.getString("common.session.admin.name"));
			   
			   mav.addObject("admin_id",(String)adminMap.get("ADMIN_ID"));
			   mav.addObject("admin_nm",(String)adminMap.get("ADMIN_NM"));
			   mav.addObject("sabun",(String)adminMap.get("SABUN"));
			   mav.addObject("dept_code",pjtManageBiz.getDeptCode((String)adminMap.get("SABUN")));
			   mav.addObject("dept_nm", pjtManageBiz.getDeptNm(pjtManageBiz.getDeptCode((String)adminMap.get("SABUN"))));
			   
			// 공통코드 조회
			List sr_type_code = sgisCodeBiz.selectComboCode("SR_TYPE_CODE");	// 업무요청구분코드
			List request_status_code = sgisCodeBiz.selectComboCode("REQUEST_STATUS_CODE");	// 요청상태코드
			List deal_yn = sgisCodeBiz.selectComboCode("SR_FLOW_CODE");						// 처리완료여부
			
			mav.addObject("SR_TYPE_CODE", sr_type_code);	
			mav.addObject("REQUEST_STATUS_CODE", request_status_code);
			mav.addObject("SR_FLOW_CODE", deal_yn);
			
			
		} catch (Exception e) {
			logger.error(e, e);
			e.printStackTrace();
		}
		return mav;
	}

	/**
	 * 업무요청정보관리 : 조회된 목록을 화면으로 retuen
	 * @param  request (
	 *  			    src_csr_date_from, src_csr_date_to : 요청일자
	 *                 ,src_csr_dept_code	: 요청부서
	 *                 ,src_csr_type_code	: 업무요청구분
	 *                 )
	 * @param  response
	 * @return mav	   (CSR_INFO : 업무요청정보관리)
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
			/*
			if("grid_page".equals(request.getParameter("div"))){
				paramMap.put("src_task_name",comUtil.getDecodingUTF(request.getParameter("src_task_name")));
			}
			*/
			/***** paging *****/ 
			int limit = 0;
			if((String)paramMap.get("limit") != null)
				limit = Integer.parseInt((String)paramMap.get("limit"));
			int start = 0;
			if((String)paramMap.get("start") != null)
				start = Integer.parseInt((String)paramMap.get("start"));
			
			paramMap.put("limit", limit+start);  
			
			
			/***** DB에서 목록조회 *****/
			HashMap adminMap = (HashMap)request.getSession().getAttribute(SGConfigManager.getString("common.session.admin.name"));
			
			String emp_num   =(String)adminMap.get("ADMIN_ID");
			String dept_code = pjtManageBiz.getDeptCode((String)adminMap.get("SABUN"));
			String groups	 = (String)adminMap.get("GROUPS");
			
		
			   
			   
			List result = csrInfoMngBiz.selectCsrInfo(paramMap);			
			
			/***** 조회된 결과를 JSON형식으로 screen에 Return *****/
			JSONArray jsonArray = JSONArray.fromObject(result);
			HashMap<String,Object> mapResult = new HashMap<String, Object>();
			mapResult.put("success", "true");								// 성공여부
			mapResult.put("message", "Loaded data");						// message
			
			mapResult.put("data_1st", jsonArray);							// 조회된 결과값
			mapResult.put("total_1st", csrInfoMngBiz.selectCsrInfoCount(paramMap)); 	// 목록의 총갯수 조회
			JSONObject jsonObject = JSONObject.fromObject(mapResult);		// JSON형식으로 설정
			mav.addObject("RESULT_1ST", jsonObject);						// 조회된 결과값을 담기
			
		}catch(Exception ex){
			logger.error(ex.getMessage());
		}
		
		return mav;
	}
	
	
	
	/**
	 * 업무요청 저장,수정
	 */
	public ModelAndView actionCsrInfoMng(HttpServletRequest request, HttpServletResponse response)throws Exception{
		
		ModelAndView mav = null;
		
		try {
			mav = new ModelAndView();
			mav.setViewName("/result/result_1st");	
			HashMap paramMap = WebUtil.parseRequestMap(request); 			
		
			/***** session 정보 *****/
			HashMap adminMap = (HashMap)request.getSession().getAttribute(SGConfigManager.getString("common.session.admin.name"));
			paramMap.put("final_mod_id", (String)adminMap.get("SABUN"));	// 로그인 ID

			
			/***** 저장 및 수정 *****/
			boolean actCsrInfoResult = csrInfoMngBiz.actionCsrInfoMng(paramMap, request);	
			
			
			/***** paging *****/ 
			int limit = 0;
			if((String)paramMap.get("limit") != null)
				limit = Integer.parseInt((String)paramMap.get("limit"));
			int start = 0;
			if((String)paramMap.get("start") != null)
				start = Integer.parseInt((String)paramMap.get("start"));
			
			paramMap.put("limit", limit+start); 					
			 
			/***** DB에서 목록조회 *****/
			String emp_num   =(String)adminMap.get("ADMIN_ID");
			String dept_code = pjtManageBiz.getDeptCode((String)adminMap.get("SABUN"));
			String groups	 = (String)adminMap.get("GROUPS");
			
			/*보기권한 임원-전체, 팀장-팀의데이터, 팀원-본인데이터  by ibyo:2011.06.08*/
			String getAuthority = pjtManageBiz.getAuthority(emp_num);				 	
			if(getAuthority.equals("사장") || getAuthority.equals("본부장") || getAuthority.equals("연구소장")){
				paramMap.put("session_dept_code", "");
			}else if(getAuthority.equals("팀장") || getAuthority.equals("팀장대행")){
				paramMap.put("session_dept_code", dept_code);
			}else if(getAuthority.equals("팀원")){
				paramMap.put("reg_id", emp_num);
			}
			
			List result = csrInfoMngBiz.selectCsrInfo(paramMap);			
			
			/***** 조회된 결과를 JSON형식으로 screen에 Return *****/
			JSONArray jsonArray = JSONArray.fromObject(result);
			HashMap<String,Object> mapResult = new HashMap<String, Object>();
			mapResult.put("success", "true");								// 성공여부
			mapResult.put("message", "Loaded data");						// message
			
			mapResult.put("data_1st", jsonArray);							// 조회된 결과값
			mapResult.put("total_1st", csrInfoMngBiz.selectCsrInfoCount(paramMap)); 	// 목록의 총갯수 조회
			JSONObject jsonObject = JSONObject.fromObject(mapResult);		// JSON형식으로 설정
			mav.addObject("RESULT_1ST", jsonObject);		
			
			
		}catch (Exception e){
			logger.error(e, e);
		}finally{
			
		}
			return mav;
	}		
	
	

	
	/**
	 * 업무요청 상세정보  : 조회된 목록을 화면으로 retuen
	 * @param  request 
	 * @param  response
	 * @return mav	   
	 * 2011. 1. 26.
	 */
	
	public ModelAndView csrPatternItem(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = null;
		
		try{
			mav = new ModelAndView();
			mav.setViewName("/result/result_edit_1st");	
			HashMap paramMap = WebUtil.parseRequestMap(request); 
			
			/***** 그리드의 페이지 클릭시 						 *****/
			/***** 검색조건에 한글조회값이 있다면 해당 필드만 decode	 *****/  
			/*
			if("grid_page".equals(request.getParameter("div"))){
				paramMap.put("src_task_name",comUtil.getDecodingUTF(request.getParameter("src_task_name")));
			}
			*/
			/***** paging *****/ 
			int limit = 0;
			if((String)paramMap.get("limit") != null)
				limit = Integer.parseInt((String)paramMap.get("limit"));
			int start = 0;
			if((String)paramMap.get("start") != null)
				start = Integer.parseInt((String)paramMap.get("start"));
			
			paramMap.put("limit", limit+start);  
			
			
			/***** DB에서 목록조회 *****/
			List result = csrInfoMngBiz.selectCsrPatternItem(paramMap);			
			
			/***** 조회된 결과를 JSON형식으로 screen에 Return *****/
			JSONArray jsonArray = JSONArray.fromObject(result);
			HashMap<String,Object> mapResult = new HashMap<String, Object>();
			mapResult.put("success", "true");								// 성공여부
			mapResult.put("message", "Loaded data");						// message
			
			mapResult.put("data_edit_1st", jsonArray);							// 조회된 결과값
			mapResult.put("total_edit_1st", csrInfoMngBiz.selectCsrPatternItemCount(paramMap)); 	// 목록의 총갯수 조회
			JSONObject jsonObject = JSONObject.fromObject(mapResult);		// JSON형식으로 설정
			
			mav.addObject("RESULT_EDIT_1ST", jsonObject);						// 조회된 결과값을 담기
			
		}catch(Exception ex){
			logger.error(ex.getMessage());
		}
		
		return mav;
	}	
	
	
	/**
	 * 업무요청유형_제품삭제
	 */
	public ModelAndView deleteCsrPatternItem(HttpServletRequest request, HttpServletResponse response) {
		
		ModelAndView mav = new ModelAndView();
		HashMap<String,Object> mapResult = new HashMap<String, Object>();
		
		try {
			HashMap paramMap = WebUtil.parseRequestMap(request); 
			
			mav = new ModelAndView();
			mav.setViewName("/result/result_edit_1st");	
			
			/***** 삭제 *****/
			boolean deleteCsrPatternItemResult = csrInfoMngBiz.deleteCsrPatternItem(paramMap, request);	
			
			
			/***** paging *****/ 
			int limit = 0;
			if((String)paramMap.get("limit") != null)
				limit = Integer.parseInt((String)paramMap.get("limit"));
			int start = 0;
			if((String)paramMap.get("start") != null)
				start = Integer.parseInt((String)paramMap.get("start"));
			
			paramMap.put("limit", limit+start); 			
			
			/***** 목록조회 *****/
			List result_edit_1st = csrInfoMngBiz.selectCsrPatternItem(paramMap);		
		
			JSONArray jsonArray = new JSONArray();
			jsonArray = JSONArray.fromObject(result_edit_1st);		
			
			mapResult.put("data_edit_1st", jsonArray);
			mapResult.put("total_edit_1st", csrInfoMngBiz.selectCsrPatternItemCount(paramMap));
			
			JSONObject jsonObject_2 = JSONObject.fromObject(mapResult);	 
			mav.addObject("RESULT_EDIT_1ST", jsonObject_2);				

		} catch (Exception e) {
			logger.error(e, e);
			e.printStackTrace();
		} finally{
			
		}
		
		return mav;
	}		
	
	
	
	/**
	 * 업무요청검토관리 조회
	 * @param  request
	 * @param  response
	 * @return mav		
	 * 2011. 1. 26.
	 */
	public ModelAndView csrInfoReviewMngList(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = null;
		
		try {
			mav = new ModelAndView();
			//mav.setViewName("/dev/csrInfo/csrInfoReviewMngList");
			
			  HashMap adminMap = (HashMap)request.getSession().getAttribute(SGConfigManager.getString("common.session.admin.name"));
			   
			   mav.addObject("admin_id",(String)adminMap.get("ADMIN_ID"));
			   mav.addObject("admin_nm",(String)adminMap.get("ADMIN_NM"));
			   mav.addObject("sabun",(String)adminMap.get("SABUN"));
			   mav.addObject("dept_code",pjtManageBiz.getDeptCode((String)adminMap.get("SABUN")));
			   mav.addObject("dept_nm", pjtManageBiz.getDeptNm(pjtManageBiz.getDeptCode((String)adminMap.get("SABUN"))));

			   
			// 공통코드 조회
			List sr_type_code = sgisCodeBiz.selectComboCode("SR_TYPE_CODE");	// 업무요청구분코드
			List request_status_code = sgisCodeBiz.selectComboCode("REQUEST_STATUS_CODE");	// 요청상태코드

			mav.addObject("SR_TYPE_CODE", sr_type_code);	
			mav.addObject("REQUEST_STATUS_CODE", request_status_code);

		} catch (Exception e) {
			logger.error(e, e);
			e.printStackTrace();
		}
		return mav;
	}	
	

	/**
	 * 업무요청 검토관리  : 조회된 목록을 화면으로 retuen
	 * @param  request 
	 * @param  response
	 * @return mav	   
	 * 2011. 1. 26.
	 */
	
	public ModelAndView resultReview(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = null;
		
		try{
			mav = new ModelAndView();
			mav.setViewName("/result/result_edit_1st");	
			
			// 공통코드 조회
			List request_status_code = sgisCodeBiz.selectComboCode("REQUEST_STATUS_CODE");	// 요청상태코드

			mav.addObject("REQUEST_STATUS_CODE", request_status_code);	// 요청상태코드			
			
			HashMap paramMap = WebUtil.parseRequestMap(request); 
			
			/***** 그리드의 페이지 클릭시 						 *****/
			/***** 검색조건에 한글조회값이 있다면 해당 필드만 decode	 *****/  
			/*
			if("grid_page".equals(request.getParameter("div"))){
				paramMap.put("src_task_name",comUtil.getDecodingUTF(request.getParameter("src_task_name")));
			}
			*/
			
			/***** paging *****/ 
			int limit = 0;
			if((String)paramMap.get("limit") != null)
				limit = Integer.parseInt((String)paramMap.get("limit"));
			int start = 0;
			if((String)paramMap.get("start") != null)
				start = Integer.parseInt((String)paramMap.get("start"));
			
			paramMap.put("limit", limit+start);  
			
			HashMap adminMap = (HashMap)request.getSession().getAttribute(SGConfigManager.getString("common.session.admin.name"));
			
			/***** DB에서 목록조회 *****/
			String emp_num   =(String)adminMap.get("ADMIN_ID");
			String dept_code = pjtManageBiz.getDeptCode((String)adminMap.get("SABUN"));
			String groups	 = (String)adminMap.get("GROUPS");
			
			/*보기권한 임원-전체, 팀장-팀의데이터, 팀원-본인데이터  by ibyo:2011.06.08*/
			String getAuthority = pjtManageBiz.getAuthority(emp_num);				 	
			if(getAuthority.equals("사장") || getAuthority.equals("본부장") || getAuthority.equals("연구소장")){
				paramMap.put("session_dept_code", "");
			}else if(getAuthority.equals("팀장") || getAuthority.equals("팀장대행")){
				paramMap.put("session_dept_code", dept_code);
			}else if(getAuthority.equals("팀원")){
				paramMap.put("reg_id", emp_num);
			}
			
			   List result = csrInfoMngBiz.selectCsrReview(paramMap);			
			
			/***** 조회된 결과를 JSON형식으로 screen에 Return *****/
			JSONArray jsonArray = JSONArray.fromObject(result);
			HashMap<String,Object> mapResult = new HashMap<String, Object>();
			mapResult.put("success", "true");								// 성공여부
			mapResult.put("message", "Loaded data");						// message
			
			mapResult.put("data_edit_1st", jsonArray);							// 조회된 결과값
			mapResult.put("total_edit_1st", csrInfoMngBiz.selectCsrReviewCount(paramMap)); 	// 목록의 총갯수 조회
			JSONObject jsonObject = JSONObject.fromObject(mapResult);		// JSON형식으로 설정
			
			mav.addObject("RESULT_EDIT_1ST", jsonObject);						// 조회된 결과값을 담기
			
		}catch(Exception ex){
			logger.error(ex.getMessage());
		}
		
		return mav;
	}		
	
	
	/**
	 * 업무요청 검토관리  신규 등록 또는 수정 처리
	 */
	public ModelAndView actionCsrInfoReviewMng(HttpServletRequest request, HttpServletResponse response)throws Exception{
		
		ModelAndView mav = new ModelAndView(); 
		HashMap mapResult = new HashMap();
		JSONObject jsonObject = new JSONObject();
		
		try {
			mav = new ModelAndView();
			mav.setViewName("/result/result_edit_1st");	
			HashMap paramMap = WebUtil.parseRequestMap(request); 
			
			/***** session 정보 *****/
			  HashMap adminMap = (HashMap)request.getSession().getAttribute(SGConfigManager.getString("common.session.admin.name"));
			   
			   mav.addObject("admin_id",(String)adminMap.get("ADMIN_ID"));
			   mav.addObject("admin_nm",(String)adminMap.get("ADMIN_NM"));
			   mav.addObject("sabun",(String)adminMap.get("SABUN"));
			   mav.addObject("dept_code",pjtManageBiz.getDeptCode((String)adminMap.get("SABUN")));
			   mav.addObject("dept_nm", pjtManageBiz.getDeptNm(pjtManageBiz.getDeptCode((String)adminMap.get("SABUN"))));
			
		    paramMap.put("deal_dept_code", pjtManageBiz.getDeptCode((String)adminMap.get("SABUN")));	// 처리부서코드
		    paramMap.put("deal_emp_num", (String)adminMap.get("SABUN"));	// 처리자사번
		    
			paramMap.put("final_mod_id", (String)adminMap.get("SABUN"));	// 로그인 ID

			
			/***** 수정 *****/
			boolean updateCsrReviewResult = csrInfoMngBiz.updateCsrReview(paramMap, request);		
			
			
			/***** paging *****/ 
			int limit = 0;
			if((String)paramMap.get("limit") != null)
				limit = Integer.parseInt((String)paramMap.get("limit"));
			int start = 0;
			if((String)paramMap.get("start") != null)
				start = Integer.parseInt((String)paramMap.get("start"));
			
			paramMap.put("limit", limit+start);  
			
			String emp_num   =(String)adminMap.get("ADMIN_ID");
			String dept_code = pjtManageBiz.getDeptCode((String)adminMap.get("SABUN"));
			String groups	 = (String)adminMap.get("GROUPS");
			
			/*보기권한 임원-전체, 팀장-팀의데이터, 팀원-본인데이터  by ibyo:2011.06.08*/
			String getAuthority = pjtManageBiz.getAuthority(emp_num);				 	
			if(getAuthority.equals("사장") || getAuthority.equals("본부장") || getAuthority.equals("연구소장")){
				paramMap.put("session_dept_code", "");
			}else if(getAuthority.equals("팀장") || getAuthority.equals("팀장대행")){
				paramMap.put("session_dept_code", dept_code);
			}else if(getAuthority.equals("팀원")){
				paramMap.put("reg_id", emp_num);
			}

			
			/***** DB에서 목록조회 *****/
			List result_edit_1st = csrInfoMngBiz.selectCsrReview(paramMap);		
		
			JSONArray jsonArray = new JSONArray();
			jsonArray = JSONArray.fromObject(result_edit_1st);		
			
			mapResult.put("data_edit_1st", jsonArray);
			mapResult.put("total_edit_1st", csrInfoMngBiz.selectCsrReviewCount(paramMap));
			
			JSONObject jsonObject_2 = JSONObject.fromObject(mapResult);	 
			mav.addObject("RESULT_EDIT_1ST", jsonObject_2);				
			
			
		}catch (Exception e){
			mapResult.put("success", "false");								// 성공여부
			mapResult.put("message", e.toString());							// message
			logger.error(e, e);
		}finally{
			
		}
			return mav;
	}	
	
	
	/**
	 * 개발업무요청정보 조회
	 * @param  request
	 * @param  response
	 * @return mav		
	 * 2011. 1. 26.
	 */
	public ModelAndView devCsrInfoMngList(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = null;
		
		try {
			mav = new ModelAndView();

			HashMap adminMap = (HashMap)request.getSession().getAttribute(SGConfigManager.getString("common.session.admin.name"));
			   
			   mav.addObject("admin_id",(String)adminMap.get("ADMIN_ID"));
			   mav.addObject("admin_nm",(String)adminMap.get("ADMIN_NM"));
			   mav.addObject("sabun",(String)adminMap.get("SABUN"));
			   mav.addObject("dept_code",pjtManageBiz.getDeptCode((String)adminMap.get("SABUN")));
			   mav.addObject("dept_nm", pjtManageBiz.getDeptNm(pjtManageBiz.getDeptCode((String)adminMap.get("SABUN"))));
			   
				// 공통코드 조회
				List sr_type_code = sgisCodeBiz.selectComboCode("SR_TYPE_CODE");	// 업무요청구분코드
				List request_status_code = sgisCodeBiz.selectComboCode("REQUEST_STATUS_CODE");	// 요청상태코드
				List deal_yn = sgisCodeBiz.selectComboCode("SR_FLOW_CODE");						// 처리완료여부
				
				mav.addObject("SR_TYPE_CODE", sr_type_code);	
				mav.addObject("REQUEST_STATUS_CODE", request_status_code);
				mav.addObject("SR_FLOW_CODE", deal_yn);	

		} catch (Exception e) {
			logger.error(e, e);
			e.printStackTrace();
		}
		return mav;
	}
	
	/**
	 * 업무요청 상세정보  : 프로젝트 제품 목록조회
	 * @param  request 
	 * @param  response
	 * @return mav	   
	 * 2011. 1. 26.
	 */
	
	public ModelAndView selectPjtItem(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = null;
		
		try{
			mav = new ModelAndView();
			mav.setViewName("/result/result_edit_1st");	
			HashMap paramMap = WebUtil.parseRequestMap(request); 
			
		
			
			/***** DB에서 목록조회 *****/
			List result = csrInfoMngBiz.selectPjtItem(paramMap);			
			
			/***** 조회된 결과를 JSON형식으로 screen에 Return *****/
			JSONArray jsonArray = JSONArray.fromObject(result);
			HashMap<String,Object> mapResult = new HashMap<String, Object>();
			mapResult.put("success", "true");								// 성공여부
			mapResult.put("message", "Loaded data");						// message
			
			mapResult.put("pjtItem", jsonArray);							// 조회된 결과값
			JSONObject jsonObject = JSONObject.fromObject(mapResult);		// JSON형식으로 설정
			
			mav.addObject("RESULT_EDIT_1ST", jsonObject);						// 조회된 결과값을 담기
			
		}catch(Exception ex){
			logger.error(ex.getMessage());
		}
		
		return mav;
	}	
	
}
