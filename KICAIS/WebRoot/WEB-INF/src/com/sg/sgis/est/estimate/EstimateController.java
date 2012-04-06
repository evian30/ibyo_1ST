/**
 *  Class Name  : EstimateController.java
 *  Description : 견적정보관리 Controller
 *  Modification Information
 *
 *  수정일                   수정자               수정내용
 *  -------      --------   ---------------------------
 *  2011. 3. 21.    고기범              최초 생성
 *
 *  @author 고기범
 *  @since 2011. 3. 21.
 *  @version 1.0
 *  @see 
 * 
 *  Copyright (C) 2011 by SG All right reserved.
 */
package com.sg.sgis.est.estimate;

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
import com.sg.sgis.man.management.ManagementBiz;
import com.sg.sgis.pjt.pjtManage.PjtManageBiz;
import com.sg.sgis.util.CommonUtil;
import com.signgate.core.config.SGConfigManager;
import com.signgate.core.web.controller.SGUserController;
import com.signgate.core.web.util.WebUtil;

public class EstimateController extends SGUserController{

	protected final Log logger = LogFactory.getLog(getClass());
	
	CommonUtil comUtil = new CommonUtil();
	
	// 공통코드 BIZ경로 설정
	private SgisCodeBiz sgisCodeBiz;
	public void setSgisCodeBiz(SgisCodeBiz sgisCodeBiz) {
		this.sgisCodeBiz = sgisCodeBiz;
	}
	
	// 견적정보조회 BIZ경로 설정
	private EstimateInfoInquiryBiz estimateInfoInquiryBiz; 
	public void setEstimateInfoInquiryBiz(EstimateInfoInquiryBiz estimateInfoInquiryBiz){
		this.estimateInfoInquiryBiz = estimateInfoInquiryBiz;
	}
	
	// 견적진행상태조회 BIZ경로 설정
	private EstimateProcessStateManageBiz estimateProcessStateManageBiz; 
	public void setEstimateProcessStateManageBiz(EstimateProcessStateManageBiz estimateProcessStateManageBiz){
		this.estimateProcessStateManageBiz = estimateProcessStateManageBiz;
	}
	
	// 견적정보관리 BIZ경로 설정
	private EstimateInfoManageBiz estimateInfoManageBiz; 
	public void setEstimateInfoManageBiz(EstimateInfoManageBiz estimateInfoManageBiz){
		this.estimateInfoManageBiz = estimateInfoManageBiz;
	}
	
	// 로그인 사용자의 부서정보를 가져오기 위함
	private PjtManageBiz pjtManageBiz; 
	public void setPjtManageBiz(PjtManageBiz pjtManageBiz){
		this.pjtManageBiz = pjtManageBiz;
	}
	
	// 유지보수 관련 프로젝트 정보
	private ManagementBiz managementBiz; 
	public void setManagementBiz(ManagementBiz managementBiz){
		this.managementBiz = managementBiz;
	}
	 
	/** 견적정보관리 Start ****************************************************************************/
	
	/**
	 * 견적정보관리(초기화면)
	 * @param  request
	 * @param  response
	 * @return mav		(공통코드 목록)
	 * 2011. 3. 21.
	 */
	public ModelAndView estimateInfoManage(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = null;
		
		try {
			mav = new ModelAndView();
			HashMap paramMap = WebUtil.parseRequestMap(request); 
			
			List est_valid_type_code = sgisCodeBiz.selectComboCode("EST_VALID_TYPE_CODE");  // 견적유효기간구분코드
			List pay_condition = sgisCodeBiz.selectComboCode("PAY_CONDITION");   			// 지불조건
			List roll_type_code = sgisCodeBiz.selectComboCode("ROLL_TYPE_CODE");   			// 업무구분코드
			List yesno_code = sgisCodeBiz.selectComboCode("YESNO_CODE");   					// 견적확정여부
			List est_type_code = sgisCodeBiz.selectComboCode("EST_TYPE_CODE");   		    // 견적구분코드(품목유형코드)
			List flow_status_code = sgisCodeBiz.selectComboCode("FLOW_STATUS_CODE");   		// 진행상태
			List pay_free_code = sgisCodeBiz.selectComboCode("PAY_FREE_CODE");   			// 유무상구분코드
			List spec_type_code = sgisCodeBiz.selectComboCode("SPEC_TYPE_CODE"); 			// 제원타입코드
			List pjt_type_code = sgisCodeBiz.selectComboCode("PJT_TYPE_CODE"); 				// 사업구분
			
			mav.addObject("FLOW_STATUS_CODE", flow_status_code);				 			// 진행상태
			mav.addObject("EST_VALID_TYPE_CODE", est_valid_type_code);				 		// 견적유효기간구분코드
			mav.addObject("PAY_CONDITION", pay_condition);				 		 			// 지불조건
			mav.addObject("ROLL_TYPE_CODE", roll_type_code);				 		 		// 업무구분코드
			mav.addObject("YESNO_CODE", yesno_code);										// 견적확정여부
			mav.addObject("EST_TYPE_CODE", est_type_code);									// 견적구분코드(품목유형코드)
			mav.addObject("PAY_FREE_CODE", pay_free_code);				 					// 유무상구분코드
			mav.addObject("SPEC_TYPE_CODE", spec_type_code);								// 제원타입코드
			mav.addObject("PJT_TYPE_CODE", pjt_type_code);									// 사업구분
			
			HashMap adminMap = (HashMap)request.getSession().getAttribute(SGConfigManager.getString("common.session.admin.name"));
			
			mav.addObject("admin_id",(String)adminMap.get("ADMIN_ID"));
			mav.addObject("admin_nm",(String)adminMap.get("ADMIN_NM"));
			mav.addObject("sabun",(String)adminMap.get("SABUN"));
			
			
			mav.addObject("dept_code",pjtManageBiz.getDeptCode((String)adminMap.get("SABUN")));
		    mav.addObject("dept_nm", pjtManageBiz.getDeptNm(pjtManageBiz.getDeptCode((String)adminMap.get("SABUN"))));
		    
		    // 견적ID 생성
			String new_est_id = estimateInfoManageBiz.createEstId(paramMap);
			mav.addObject("new_est_id",new_est_id); 
			
			//프로젝트 관리(전체)를 위한 페이지 구분
			if(paramMap.get("totMng").equals("all")){
				mav.setViewName("/pjt/allESTManageList");
			}else{
				mav.setViewName("/est/estimate/estimateInfoManage");
			}
			
		} catch (Exception e) {
			logger.error(e, e);
		}
		return mav;
	}
	
	/**
	 * 견적 Rev (초기화면)
	 * @param  request
	 * @param  response
	 * @return mav		(공통코드 목록)
	 * 2011. 4. 12.
	 */
	public ModelAndView estimateInfoManageRevPop(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = null;
		
		try {
			mav = new ModelAndView();
			mav.addObject("RESULT", "");

		} catch (Exception e) {
			logger.error(e, e);
		}
		return mav;
	}

	public ModelAndView ozReport(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = null;
		
		try {
			mav = new ModelAndView();
			mav.setViewName("/ozr/ozReport");	
			mav.addObject("RESULT", "");

		} catch (Exception e) {
			logger.error(e, e);
		}
		return mav;
	}
	
	
	
	/**
	 * 견적정보관리 목록조회(견적정보)
	 * @param  request
	 * @param  response
	 * @return mav		
	 * 2011. 3. 21.
	 */
	public ModelAndView estimateInfoManageList(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = null;
		
		mav = new ModelAndView();
		List result = null;				// 조회결과
		int resultCnt = 0;
		
		mav.setViewName("/result/result_1st");	
		HashMap paramMap = WebUtil.parseRequestMap(request); 
		HashMap<String,Object> mapResult = new HashMap<String, Object>();
		
		try {
			
			HashMap adminMap = (HashMap)request.getSession().getAttribute(SGConfigManager.getString("common.session.admin.name"));
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
			
			/***** 그리드의 페이지 클릭시 						 *****/
			/***** 검색조건에 한글조회값이 있다면 해당 필드만 decode	 *****/  
			if("grid_page".equals(request.getParameter("div"))){
				// paramMap.put("src_custom_name",comUtil.getDecodingUTF(request.getParameter("src_custom_name")));
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
			
			// 검색조건의 날짜 값에서 "-"를 제거
			// 검색 시작일
			if("" != paramMap.get("src_est_date_start")){
				String src_est_date_start = paramMap.get("src_est_date_start").toString();
				src_est_date_start = src_est_date_start.replace("-", "");
				paramMap.put("src_est_date_start", src_est_date_start);
			}
			// 검색 종료일
			if("" != paramMap.get("src_est_date_end")){
				String src_est_date_end = paramMap.get("src_est_date_end").toString();
				src_est_date_end = src_est_date_end.replace("-", "");
				paramMap.put("src_est_date_end", src_est_date_end);
			}

			/***** DB에서 목록조회 *****/
			result = estimateInfoManageBiz.selectEstimateInfoManageList(paramMap);			
			resultCnt = estimateInfoManageBiz.selectEstimateInfoManageListCount(paramMap); 
			
			/***** 조회된 결과를 JSON형식으로 screen에 Return *****/
			mapResult.put("success", "true");								// 성공여부
			mapResult.put("message", "Loaded data");						// message
			
		} catch (Exception e) {
			logger.error(e, e);
			mapResult.put("success", "false");								// 성공여부
			mapResult.put("message", "False Loaded data");					// message
		}
		
		JSONArray jsonArray = JSONArray.fromObject(result);					// 조회된 결과값
		mapResult.put("data_1st", jsonArray);								
		mapResult.put("total_1st", resultCnt); 								// 목록의 총갯수 조회
		JSONObject jsonObject = JSONObject.fromObject(mapResult);			// JSON형식으로 설정
		mav.addObject("RESULT_1ST", jsonObject);							// 조회된 결과값을 담기
		
		return mav;
	}
	
	/**
	 * 견적정보관리(견적 품목정보) 목록조회
	 * @param  request 
	 * @param  response
	 * @return 
	 * 2011. 4. 7.
	 */
	public ModelAndView result_edit_1st(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView();
		
		try{
			mav.setViewName("/result/result_edit_1st");	
			HashMap map = WebUtil.parseRequestMap(request);   
			
			HashMap mapResult = new HashMap();
			mapResult.put("success", "true");			 				
			
			/*grid 페이징 처리시 사용 할 페이지 시작 종료 value*/
			int limit = 0;
			if((String)map.get("limit") != null)
				limit = Integer.parseInt((String)map.get("limit"));
			
			int start = 0;
			if((String)map.get("start") != null)
				start = Integer.parseInt((String)map.get("start"));
			
			map.put("limit", limit+start);			
			 
			List result_edit_1st = estimateInfoManageBiz.selectEstItemInfo(map);		
		
			JSONArray jsonArray = new JSONArray();
			jsonArray = JSONArray.fromObject(result_edit_1st);		
			
			mapResult.put("data_edit_1st", jsonArray);
			mapResult.put("total_edit_1st", estimateInfoManageBiz.selectEstItemInfoCount(map));
			
			JSONObject jsonObject = JSONObject.fromObject(mapResult);	 
			mav.addObject("RESULT_EDIT_1ST", jsonObject);	

		}catch(Exception ex){
			logger.error(ex.getMessage());
		}
		
		return mav;
	}
	
	/**
	 * 견적정보관리(납품처 시스템사양 정보) 목록조회
	 * @param  request 
	 * @param  response
	 * @return 
	 * 2011. 4. 7.
	 */
	public ModelAndView result_edit_2nd(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView();
		
		try{
			mav.setViewName("/result/result_edit_2nd");	
			HashMap map = WebUtil.parseRequestMap(request);   
			
			HashMap mapResult = new HashMap();
			mapResult.put("success", "true");			 				
			
			/*grid 페이징 처리시 사용 할 페이지 시작 종료 value*/
			int limit = 0;
			if((String)map.get("limit") != null)
				limit = Integer.parseInt((String)map.get("limit"));
			
			int start = 0;
			if((String)map.get("start") != null)
				start = Integer.parseInt((String)map.get("start"));
			
			map.put("limit", limit+start);			
			 
			List result_edit_2nd = estimateInfoManageBiz.selectEstSpecInfo(map);		
		
			JSONArray jsonArray = new JSONArray();
			jsonArray = JSONArray.fromObject(result_edit_2nd);		
			
			mapResult.put("data_edit_2nd", jsonArray);
			mapResult.put("total_edit_2nd", estimateInfoManageBiz.selectEstSpecInfoCount(map));
			
			JSONObject jsonObject = JSONObject.fromObject(mapResult);	 
			mav.addObject("RESULT_EDIT_2ND", jsonObject);	

		}catch(Exception ex){
			logger.error(ex.getMessage());
		}
		
		return mav;
	}
	
	/**
	 * 견적정보 입력, 수정
	 * @param request	( EST_INFO 		   : 견적정보관리
	 *                  , EST_ITEM_INFO    : 견적품목관리
	 *                  , EST_SPEC_INFO    : 설치시스템사양정보
	 * 					)
	 * @param response
	 * @return
	 * @throws Exception
	 * 2011. 4. 7.
	 */
	public ModelAndView saveEstimateInfoManage(HttpServletRequest request, HttpServletResponse response)throws Exception{
		
		ModelAndView mav = new ModelAndView(); 
		HashMap mapResult = new HashMap();
		JSONArray jsonArray = new JSONArray();
		JSONObject jsonObject = new JSONObject();
		
		try {
			mav = new ModelAndView();
			mav.setViewName("/result/result_1st");
			
			/***** 조회조건 및 parameter설정 *****/
			HashMap map = WebUtil.parseRequestMap(request);  
			String saveDiv = (String)map.get("saveDiv");		// 저장(save)인지 수정(update)인지 구분
			
			/***** paging *****/ 
			/*grid 페이징 처리시 사용 할 페이지 시작 종료 value*/
			int limit = 0;
			if((String)map.get("limit") != null)
				limit = Integer.parseInt((String)map.get("limit"));
			int start = 0;
			if((String)map.get("start") != null)
				start = Integer.parseInt((String)map.get("start"));
			
			map.put("limit", limit+start); 
			
			// 검색조건의 날짜 값에서 "-"를 제거
			// 검색 시작일
			if("" != map.get("src_est_date_start")){
				String src_est_date_start = map.get("src_est_date_start").toString();
				src_est_date_start = src_est_date_start.replace("-", "");
				map.put("src_est_date_start", src_est_date_start);
			}
			// 검색 종료일
			if("" != map.get("src_est_date_end")){
				String src_est_date_end = map.get("src_est_date_end").toString();
				src_est_date_end = src_est_date_end.replace("-", "");
				map.put("src_est_date_end", src_est_date_end);
			}
			
			/***** session 정보 *****/
			HashMap adminMap = (HashMap)request.getSession().getAttribute(SGConfigManager.getString("common.session.admin.name"));
			map.put("final_mod_id", (String)adminMap.get("ADMIN_ID"));	// 로그인 ID
			
			/***** 저장 및 수정 *****/
			boolean deptRegResult = estimateInfoManageBiz.saveEstimateInfoManage(map, request);
			
			String emp_num   =(String)adminMap.get("ADMIN_ID");
			String dept_code = pjtManageBiz.getDeptCode((String)adminMap.get("SABUN"));
			String groups	 = (String)adminMap.get("GROUPS");
			
			/*보기권한 임원-전체, 팀장-팀의데이터, 팀원-본인데이터  by ibyo:2011.06.08*/
			String getAuthority = pjtManageBiz.getAuthority(emp_num);				 	
			if(getAuthority.equals("사장") || getAuthority.equals("본부장") || getAuthority.equals("연구소장")){
				map.put("session_dept_code", "");
			}else if(getAuthority.equals("팀장") || getAuthority.equals("팀장대행")){
				map.put("session_dept_code", dept_code);
			}else if(getAuthority.equals("팀원")){
				map.put("reg_id", emp_num);
			} 
			
			/***** 목록조회 *****/
			List result = estimateInfoManageBiz.selectEstimateInfoManageList(map);						 
			
			/***** 조회된 결과를 JSON형식으로 screen에 Return *****/
			
			jsonArray = JSONArray.fromObject(result); 			
			mapResult.put("success", "true");							// 성공여부
			mapResult.put("message", "Loaded data");					// message
			mapResult.put("data_1st", jsonArray);						// 조회된 결과값
			mapResult.put("total_1st", estimateInfoManageBiz.selectEstimateInfoManageListCount(map));	// 목록의 총갯수 조회
			
			// 신규 저장일 경우 새로운 sal_id를 채번해서 화면에 설정해준다.
			if("save".equals(saveDiv)){
				// 견적ID 생성
				String new_est_id = estimateInfoManageBiz.createEstId(map);
				mapResult.put("new_est_id",new_est_id); 
			}
			
			jsonObject = JSONObject.fromObject(mapResult);	
			
		}catch (Exception e){
			logger.error(e, e);
		}finally{
			
		}
		mav.addObject("RESULT_1ST", jsonObject); 	
			return mav;
	}
	
	/**
	 * 견적Rev 팝업 목록조회
	 * @param  request
	 * @param  response
	 * @return mav		
	 * 2011. 4. 12.
	 */
	public ModelAndView estimateInfoManageRevPopList(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = null;
		
		mav = new ModelAndView();
		List result = null;				// 조회결과
		int resultCnt = 0;
		
		mav.setViewName("/result/result_1st");	
		HashMap paramMap = WebUtil.parseRequestMap(request); 
		HashMap<String,Object> mapResult = new HashMap<String, Object>();
		
		try {
			
			/***** 그리드의 페이지 클릭시 						 *****/
			/***** 검색조건에 한글조회값이 있다면 해당 필드만 decode	 *****/  
			if("grid_page".equals(request.getParameter("div"))){
				// paramMap.put("src_custom_name",comUtil.getDecodingUTF(request.getParameter("src_custom_name")));
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
			result = estimateInfoManageBiz.selectEstimateInfoManageRevPopList(paramMap);			
			resultCnt = estimateInfoManageBiz.selectEstimateInfoManageRevPopListCount(paramMap); 
			
			/***** 조회된 결과를 JSON형식으로 screen에 Return *****/
			mapResult.put("success", "true");								// 성공여부
			mapResult.put("message", "Loaded data");						// message
			
		} catch (Exception e) {
			logger.error(e, e);
			mapResult.put("success", "false");								// 성공여부
			mapResult.put("message", "False Loaded data");					// message
		}
		
		JSONArray jsonArray = JSONArray.fromObject(result);					// 조회된 결과값
		mapResult.put("data_1st_pop", jsonArray);								
		mapResult.put("total_1st_pop", resultCnt); 								// 목록의 총갯수 조회
		JSONObject jsonObject = JSONObject.fromObject(mapResult);			// JSON형식으로 설정
		mav.addObject("RESULT_1ST", jsonObject);							// 조회된 결과값을 담기
		
		return mav;
	}
	
	/** 견적정보관리 End ****************************************************************************/
	
	/** 견적정보진행상태 Start **********************************************************************/
	
	/**
	 * 견적진행상태관리(초기화면)
	 * @param  request
	 * @param  response
	 * @return mav		(공통코드 목록)
	 * 2011. 3. 21.
	 */
	public ModelAndView estimateProcessStateManage(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = null;
		
		try {
			mav = new ModelAndView();
			// 공통코드 조회
			List item_pattern_code = sgisCodeBiz.selectComboCode("ITEM_PATTERN_CODE"); 	// 견적구분코드
			List flow_status_code  = sgisCodeBiz.selectComboCode("FLOW_STATUS_CODE"); 	// 진행상태코드
			List pay_free_code     = sgisCodeBiz.selectComboCode("PAY_FREE_CODE");   	// 유무상구분코드
			List est_type_code 	   = sgisCodeBiz.selectComboCode("EST_TYPE_CODE"); 	    // 견적구분코드(품목유형코드)
			
			mav.addObject("FLOW_STATUS_CODE", flow_status_code);		// 진행상태코드
			mav.addObject("ITEM_PATTERN_CODE", item_pattern_code);		// 품목유형코드
			mav.addObject("PAY_FREE_CODE", pay_free_code);	         	// 유무상구분코드
			mav.addObject("EST_TYPE_CODE", est_type_code);	         	// 견적구분코드(품목유형코드)
			mav.addObject("RESULT", "");

		} catch (Exception e) {
			logger.error(e, e);
		}
		return mav;
	}
	
	/**
	 * 견적정보진행상태(견적정보) 목록조회
	 * @param  request
	 * @param  response
	 * @return mav		
	 * 2011. 4. 13.
	 */
	public ModelAndView estimateProcessStateEstInfoList(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = null;
		
		mav = new ModelAndView();
		List result = null;				// 조회결과
		int resultCnt = 0;
		
		mav.setViewName("/result/result_edit_1st");	
		HashMap paramMap = WebUtil.parseRequestMap(request); 
		HashMap<String,Object> mapResult = new HashMap<String, Object>();
		
		try {
			
			HashMap adminMap = (HashMap)request.getSession().getAttribute(SGConfigManager.getString("common.session.admin.name"));
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
			
			/***** paging *****/ 
			/*grid 페이징 처리시 사용 할 페이지 시작 종료 value*/
			int limit = 0;
			if((String)paramMap.get("limit") != null)
				limit = Integer.parseInt((String)paramMap.get("limit"));
			int start = 0;
			if((String)paramMap.get("start") != null)
				start = Integer.parseInt((String)paramMap.get("start"));
			
			paramMap.put("limit", limit+start); 
			
			// 검색조건의 날짜 값에서 "-"를 제거
			// 검색 시작일
			if("" != paramMap.get("src_est_date_start") && null != paramMap.get("src_est_date_start")){
				String src_est_date_start = paramMap.get("src_est_date_start").toString();
				src_est_date_start = src_est_date_start.replace("-", "");
				paramMap.put("src_est_date_start", src_est_date_start);
			}
			// 검색 종료일
			if("" != paramMap.get("src_est_date_end") && null != paramMap.get("src_est_date_end")){
				String src_est_date_end = paramMap.get("src_est_date_end").toString();
				src_est_date_end = src_est_date_end.replace("-", "");
				paramMap.put("src_est_date_end", src_est_date_end);
			}
			
			/***** DB에서 목록조회 *****/
			result = estimateProcessStateManageBiz.selectEstimateProcessStateEstInfoList(paramMap);			
			resultCnt = estimateProcessStateManageBiz.selectEstimateProcessStateEstInfoListCount(paramMap); 
			
			/***** 조회된 결과를 JSON형식으로 screen에 Return *****/
			mapResult.put("success", "true");								// 성공여부
			mapResult.put("message", "Loaded data");						// message
			
		} catch (Exception e) {
			logger.error(e, e);
			e.printStackTrace();
			mapResult.put("success", "false");								// 성공여부
			mapResult.put("message", "False Loaded data");					// message
		}
		
		JSONArray jsonArray = JSONArray.fromObject(result);					// 조회된 결과값
		mapResult.put("data_edit_1st", jsonArray);								
		mapResult.put("total_edit_1st", resultCnt); 								// 목록의 총갯수 조회
		JSONObject jsonObject = JSONObject.fromObject(mapResult);			// JSON형식으로 설정
		mav.addObject("RESULT_EDIT_1ST", jsonObject);							// 조회된 결과값을 담기
		
		return mav;
	}
	
	/**
	 * 견적정보진행상태(견적품목정보)조회
	 * @param  request
	 * @param  response
	 * @return mav		
	 * 2011. 4. 13.
	 */
	public ModelAndView estimateProcessStateEstItemInfoList(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = null;
		
		mav = new ModelAndView();
		List result = null;				// 조회결과
		int resultCnt = 0;
		
		mav.setViewName("/result/result_2nd");	
		HashMap paramMap = WebUtil.parseRequestMap(request); 
		HashMap<String,Object> mapResult = new HashMap<String, Object>();
		
		try {
			
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
			result = estimateProcessStateManageBiz.selectEstimateProcessStateEstItemInfoList(paramMap);			
			resultCnt = estimateProcessStateManageBiz.selectEstimateProcessStateEstItemInfoListCount(paramMap); 
			
			/***** 조회된 결과를 JSON형식으로 screen에 Return *****/
			mapResult.put("success", "true");								// 성공여부
			mapResult.put("message", "Loaded data");						// message
			
		} catch (Exception e) {
			logger.error(e, e);
			mapResult.put("success", "false");								// 성공여부
			mapResult.put("message", "False Loaded data");					// message
		}
		
		JSONArray jsonArray = JSONArray.fromObject(result);					// 조회된 결과값
		mapResult.put("data_2nd", jsonArray);								
		mapResult.put("total_2nd", resultCnt); 								// 목록의 총갯수 조회
		JSONObject jsonObject = JSONObject.fromObject(mapResult);			// JSON형식으로 설정
		mav.addObject("RESULT_2ND", jsonObject);							// 조회된 결과값을 담기
		
		return mav;
	}
	
	/**
	 * 견적정보진행상태 수정
	 * @param request	( EST_INFO : 견적정보관리 )
	 * @param response
	 * @return
	 * @throws Exception
	 * 2011. 4. 13.
	 */
	public ModelAndView saveEstimateProcessStateEstInfo(HttpServletRequest request, HttpServletResponse response)throws Exception{
		
		ModelAndView mav = new ModelAndView(); 
		HashMap mapResult = new HashMap();
		JSONArray jsonArray = new JSONArray();
		JSONObject jsonObject = new JSONObject();
		
		try {
			
			mav = new ModelAndView();
			mav.setViewName("/result/result_edit_1st");
			
			/***** 조회조건 및 parameter설정 *****/
			HashMap map = WebUtil.parseRequestMap(request);  
			
			/***** session 정보 *****/
			HashMap adminMap = (HashMap)request.getSession().getAttribute(SGConfigManager.getString("common.session.admin.name"));
			map.put("final_mod_id", (String)adminMap.get("ADMIN_ID"));	// 로그인 ID
			
			// 검색조건의 날짜 값에서 "-"를 제거
			// 검색 시작일
			if("" != map.get("src_est_date_start")){
				String src_est_date_start = map.get("src_est_date_start").toString();
				src_est_date_start = src_est_date_start.replace("-", "");
				map.put("src_est_date_start", src_est_date_start);
			}
			// 검색 종료일
			if("" != map.get("src_est_date_end")){
				String src_est_date_end = map.get("src_est_date_end").toString();
				src_est_date_end = src_est_date_end.replace("-", "");
				map.put("src_est_date_end", src_est_date_end);
			}
			
			/***** paging *****/ 
			/*grid 페이징 처리시 사용 할 페이지 시작 종료 value*/
			int limit = 0;
			if((String)map.get("limit") != null)
				limit = Integer.parseInt((String)map.get("limit"));
			int start = 0;
			if((String)map.get("start") != null)
				start = Integer.parseInt((String)map.get("start"));
			
			map.put("limit", limit+start); 
			
			/***** 저장 및 수정 *****/
			boolean deptRegResult = estimateProcessStateManageBiz.saveEstimateProcessStateEstInfo(map, request);
			
			String emp_num   =(String)adminMap.get("ADMIN_ID");
			String dept_code = pjtManageBiz.getDeptCode((String)adminMap.get("SABUN"));
			String groups	 = (String)adminMap.get("GROUPS");
			
			/*보기권한 임원-전체, 팀장-팀의데이터, 팀원-본인데이터  by ibyo:2011.06.08*/
			String getAuthority = pjtManageBiz.getAuthority(emp_num);				 	
			if(getAuthority.equals("사장") || getAuthority.equals("본부장") || getAuthority.equals("연구소장")){
				map.put("session_dept_code", "");
			}else if(getAuthority.equals("팀장") || getAuthority.equals("팀장대행")){
				map.put("session_dept_code", dept_code);
			}else if(getAuthority.equals("팀원")){
				map.put("reg_id", emp_num);
			}
			
			/***** 목록조회 *****/
			List result = estimateProcessStateManageBiz.selectEstimateProcessStateEstInfoList(map);		
			
			/***** 조회된 결과를 JSON형식으로 screen에 Return *****/
			
			jsonArray = JSONArray.fromObject(result); 			
			mapResult.put("success", "true");							// 성공여부
			mapResult.put("message", "Loaded data");					// message
			mapResult.put("data_edit_1st", jsonArray);						// 조회된 결과값
			mapResult.put("total_edit_1st", estimateProcessStateManageBiz.selectEstimateProcessStateEstInfoListCount(map));	// 목록의 총갯수 조회
			jsonObject = JSONObject.fromObject(mapResult);	
						
		}catch (Exception e){
			logger.error(e, e);
		}finally{
			
		}
		mav.addObject("RESULT_EDIT_1ST", jsonObject); 	
			return mav;
	}
	
	/** 견적정보진행상태 End ************************************************************************/
	
	/** 견적정보조회 Start **************************************************************************/
	
	/**
	 * 견적정보 조회(초기화면)
	 * @param  request
	 * @param  response
	 * @return mav		(공통코드 목록)
	 * 2011. 3. 21.
	 */
	public ModelAndView estimateInfoInquiry(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = null;
		
		try {
			mav = new ModelAndView();
			// 공통코드 조회
			List item_pattern_code    = sgisCodeBiz.selectComboCode("ITEM_PATTERN_CODE"); 	// 견적구분코드
			List roll_type_code 	  = sgisCodeBiz.selectComboCode("ROLL_TYPE_CODE"); 		// 업무구분코드
			List est_valid_type_code  = sgisCodeBiz.selectComboCode("EST_VALID_TYPE_CODE"); // 견적유효기간구분코드
			List pay_condition  	  = sgisCodeBiz.selectComboCode("PAY_CONDITION"); 		// 지불조건
			List flow_status_code  	  = sgisCodeBiz.selectComboCode("FLOW_STATUS_CODE"); 	// 진행상태코드
			List pay_free_code        = sgisCodeBiz.selectComboCode("PAY_FREE_CODE");   	// 유무상구분코드
			List spec_type_code       = sgisCodeBiz.selectComboCode("SPEC_TYPE_CODE"); 		// 제원타입코드
			List est_type_code 	      = sgisCodeBiz.selectComboCode("EST_TYPE_CODE"); 	    // 견적구분코드(품목유형코드)
			
			mav.addObject("FLOW_STATUS_CODE", flow_status_code);		// 진행상태코드
			mav.addObject("PAY_CONDITION", pay_condition);				// 지불조건
			mav.addObject("ROLL_TYPE_CODE", roll_type_code);			// 업무구분코드
			mav.addObject("EST_VALID_TYPE_CODE", est_valid_type_code);	// 견적유효기간구분코드
			mav.addObject("ITEM_PATTERN_CODE", item_pattern_code);		// 품목유형코드
			mav.addObject("PAY_FREE_CODE", pay_free_code);		        // 유무상구분코드
			mav.addObject("SPEC_TYPE_CODE", spec_type_code);		    // 제원타입코드
			mav.addObject("EST_TYPE_CODE", est_type_code);		    	// 견적구분코드(품목유형코드)
			mav.addObject("RESULT", "");

		} catch (Exception e) {
			logger.error(e, e);
		}
		return mav;
	}
	
	
	/** 견적정보조회 End ****************************************************************************/
	
	/** 견적정보조회 PopUp Start ********************************************************************/
	/**
	 * 견적정보 조회 팝업(초기화면)
	 * @param  request
	 * @param  response
	 * @return mav		(공통코드 목록)
	 * 2011. 4. 18.
	 */
	public ModelAndView estimatePop(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = null;
		
		try {
			mav = new ModelAndView();

		} catch (Exception e) {
			logger.error(e, e);
		}
		return mav;
	}
	
	/**
	 * 견적정보 조회 팝업
	 * @param  request
	 * @param  response
	 * @return mav		
	 * 2011. 4. 18.
	 */
	public ModelAndView estimatePopList(HttpServletRequest request, HttpServletResponse response) {
		
		ModelAndView mav = null;
		
		mav = new ModelAndView();
		List result = null;				// 조회결과
		int resultCnt = 0;
		
		mav.setViewName("/result/result_1st");	
		HashMap paramMap = WebUtil.parseRequestMap(request); 
		HashMap<String,Object> mapResult = new HashMap<String, Object>();
		
		try {
			
			/***** 그리드의 페이지 클릭시 						 *****/
			/***** 검색조건에 한글조회값이 있다면 해당 필드만 decode	 *****/  
			if("grid_page".equals(request.getParameter("div"))){
				// paramMap.put("src_custom_name",comUtil.getDecodingUTF(request.getParameter("src_custom_name")));
			}
			
			/***** session 정보 *****/
			HashMap adminMap = (HashMap)request.getSession().getAttribute(SGConfigManager.getString("common.session.admin.name"));
			
			/***** paging *****/ 
			/*grid 페이징 처리시 사용 할 페이지 시작 종료 value*/
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
			result = estimateInfoManageBiz.estimatePopList(paramMap);			
			resultCnt = estimateInfoManageBiz.estimatePopListCount(paramMap); 
			
			/***** 조회된 결과를 JSON형식으로 screen에 Return *****/
			mapResult.put("success", "true");								// 성공여부
			mapResult.put("message", "Loaded data");						// message
			
		} catch (Exception e) {
			logger.error(e, e);
			mapResult.put("success", "false");								// 성공여부
			mapResult.put("message", "False Loaded data");					// message
		}
		
		JSONArray jsonArray = JSONArray.fromObject(result);					// 조회된 결과값
		mapResult.put("data_1st_pop", jsonArray);								
		mapResult.put("total_1st_pop", resultCnt); 								// 목록의 총갯수 조회
		JSONObject jsonObject = JSONObject.fromObject(mapResult);			// JSON형식으로 설정
		mav.addObject("RESULT_1ST", jsonObject);							// 조회된 결과값을 담기
		
		return mav;
	}
	/** 견적정보조회 PopUp End ********************************************************************/

	/**
	 * 프로젝트조회시 프로젝트의 거래처 정보 및 품목조회
	 * @param  request
	 * @param  response
	 * @return mav		
	 * 2011. 5. 4.
	 */
	public ModelAndView selectPjtCustom(HttpServletRequest request, HttpServletResponse response) {
		
		ModelAndView mav = null;
		
		mav = new ModelAndView();
		mav.setViewName("/result/result_edit_1st");
		List result = null;
		List resultItem = null;
		int resultItemCnt = 0;
		HashMap paramMap = WebUtil.parseRequestMap(request); 
		HashMap<String,Object> mapResult = new HashMap<String, Object>();
		
		try {
			
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
			result = estimateInfoManageBiz.selectPjtCustom(paramMap);			
			resultItem = estimateInfoManageBiz.selectPjtItemList(paramMap);	
			resultItemCnt = estimateInfoManageBiz.selectPjtItemListCount(paramMap); 
			
			/***** 조회된 결과를 JSON형식으로 screen에 Return *****/
			mapResult.put("success", "true");								// 성공여부
			mapResult.put("message", "Loaded data");						// message
			
		} catch (Exception e) {
			logger.error(e, e);
			mapResult.put("success", "false");								// 성공여부
			mapResult.put("message", "False Loaded data");					// message
		}
		
		JSONArray jsonArray = JSONArray.fromObject(result);					// 조회된 결과값
		JSONArray jsonArrayItem  = JSONArray.fromObject(resultItem);		// 조회된 결과값
		
		mapResult.put("data", jsonArray);						
		mapResult.put("data_edit_1st", jsonArrayItem);						// 조회된 결과값
		mapResult.put("total_edit_1st", resultItemCnt);						// 목록의 총갯수 조회
		JSONObject jsonObject = JSONObject.fromObject(mapResult);			// JSON형식으로 설정
		mav.addObject("RESULT_EDIT_1ST", jsonObject);						// 조회된 결과값을 담기
		
		return mav;
	}
	
	/**
	 * 견적정보관리_견적등록 가능여부 확인
	 * @param  request
	 * @param  response
	 * @return mav		
	 * 2011. 5. 11.
	 */
	public ModelAndView projectUseCheck(HttpServletRequest request, HttpServletResponse response) {
		
		ModelAndView mav = null;
		
		mav = new ModelAndView();
		mav.setViewName("/result/result_edit_1st");
		List result = null;
		HashMap paramMap = WebUtil.parseRequestMap(request); 
		HashMap<String,Object> mapResult = new HashMap<String, Object>();
		
		try {
			
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
			result = estimateInfoManageBiz.projectUseCheck(paramMap);			
			
			JSONArray jsonArray = new JSONArray();
			jsonArray = JSONArray.fromObject(result);	
			
			/***** 조회된 결과를 JSON형식으로 screen에 Return *****/
			mapResult.put("success", "true");								// 성공여부
			mapResult.put("message", "Loaded data");						// message
			mapResult.put("data", jsonArray);								// 사용가능여부
			
		} catch (Exception e) {
			logger.error(e, e);
			mapResult.put("success", "false");								// 성공여부
			mapResult.put("message", "False Loaded data");					// message
			
		}
		
		JSONObject jsonObject = JSONObject.fromObject(mapResult);			// JSON형식으로 설정
		mav.addObject("RESULT_EDIT_1ST", jsonObject);						// 조회된 결과값을 담기
		
		return mav;
	}
	
	public ModelAndView result_edit_4th(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView();
		
		
		
		try{
			mav.setViewName("/result/result_edit_4th");	
			HashMap map = WebUtil.parseRequestMap(request);   
			
			HashMap mapResult = new HashMap();
			mapResult.put("success", "true");			 				
			 
			int limit = 0;
			if((String)map.get("limit") != null)
				limit = Integer.parseInt((String)map.get("limit"));
			
			int start = 0;
			if((String)map.get("start") != null)
				start = Integer.parseInt((String)map.get("start"));
			
			map.put("limit", limit+start);			
			 
			List result_edit_4th = managementBiz.selectPjtManagement(map);			
			
			JSONArray jsonArray = new JSONArray();
			jsonArray = JSONArray.fromObject(result_edit_4th);		
			
			mapResult.put("data_edit_4th", jsonArray);
			mapResult.put("total_edit_4th", managementBiz.selectPjtManagementCount(map));
			
			JSONObject jsonObject = JSONObject.fromObject(mapResult);	 
			mav.addObject("RESULT_EDIT_4TH", jsonObject);	

		}catch(Exception ex){
			logger.error(ex.getMessage());
			ex.printStackTrace();
		}
		
		return mav;
	} 
	
}
