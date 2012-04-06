/**
 *  Class Name  : OrderController.java
 *  Description : 수주정보관리 Controller
 *  Modification Information
 *
 *  수정일                   수정자               수정내용
 *  -------      --------   ---------------------------
 *  2011. 4. 15.    고기범              최초 생성
 *
 *  @author 고기범
 *  @since 2011. 4. 15.
 *  @version 1.0
 *  @see 
 * 
 *  Copyright (C) 2011 by SG All right reserved.
 */
package com.sg.sgis.ord.order;

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
import com.sg.sgis.pjt.pjtManage.PjtManageBiz;
import com.sg.sgis.util.CommonUtil;
import com.signgate.core.config.SGConfigManager;
import com.signgate.core.web.controller.SGUserController;
import com.signgate.core.web.util.WebUtil;

public class OrderController extends SGUserController{

protected final Log logger = LogFactory.getLog(getClass());
	
	CommonUtil comUtil = new CommonUtil();
	
	// 공통코드 BIZ경로 설정
	private SgisCodeBiz sgisCodeBiz;
	public void setSgisCodeBiz(SgisCodeBiz sgisCodeBiz) {
		this.sgisCodeBiz = sgisCodeBiz;
	}
	
	// 수주정보관리
	private OrderInfoManageBiz orderInfoManageBiz;
	public void setOrderInfoManageBiz(OrderInfoManageBiz orderInfoManageBiz) {
		this.orderInfoManageBiz = orderInfoManageBiz;
	}
	
	// 수주정보 조회
	private OrderInfoInquiryBiz orderInfoInquiryBiz;
	public void setOrderInfoInquiryBiz(OrderInfoInquiryBiz orderInfoInquiryBiz) {
		this.orderInfoInquiryBiz = orderInfoInquiryBiz;
	}
	
	// 수주진행상태 관리
	private OrderProcessStateManageBiz orderProcessStateManageBiz;
	public void setOrderProcessStateManageBiz(OrderProcessStateManageBiz orderProcessStateManageBiz) {
		this.orderProcessStateManageBiz = orderProcessStateManageBiz;
	}
	
	// 로그인 사용자의 부서정보를 가져오기 위함
	private PjtManageBiz pjtManageBiz; 
	public void setPjtManageBiz(PjtManageBiz pjtManageBiz){
		this.pjtManageBiz = pjtManageBiz;
	}
	
	/** 수주정보관리 Start ********************************************************************/
	/**
	 * 수주정보관리(초기화면)
	 * @param  request
	 * @param  response
	 * @return mav		(공통코드 목록)
	 * 2011. 4. 15.
	 */
	public ModelAndView orderInfoManage(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = null;
		
		try {
			mav = new ModelAndView();
			HashMap paramMap = WebUtil.parseRequestMap(request);
			
			List item_pattern_code = sgisCodeBiz.selectComboCode("ITEM_PATTERN_CODE");   	// 수주구분코드(품목유형코드)
			List roll_type_code = sgisCodeBiz.selectComboCode("ROLL_TYPE_CODE");   			// 업무구분코드
			List flow_status_code = sgisCodeBiz.selectComboCode("FLOW_STATUS_CODE");   		// 진행상태
			List pay_free_code = sgisCodeBiz.selectComboCode("PAY_FREE_CODE");   			// 유무상구분코드
			List tax_issue_type_code = sgisCodeBiz.selectComboCode("TAX_ISSUE_TYPE_CODE"); 	// 세금계산서발행구분
			List spec_type_code = sgisCodeBiz.selectComboCode("SPEC_TYPE_CODE"); 			// 제원타입코드
			List est_type_code = sgisCodeBiz.selectComboCode("EST_TYPE_CODE");   		    // 견적구분코드
			
			mav.addObject("ITEM_PATTERN_CODE", item_pattern_code);							// 수주구분코드(품목유형코드)
			mav.addObject("ROLL_TYPE_CODE", roll_type_code);				 		 		// 업무구분코드
			mav.addObject("FLOW_STATUS_CODE", flow_status_code);				 			// 진행상태
			mav.addObject("PAY_FREE_CODE", pay_free_code);				 					// 유무상구분코드
			mav.addObject("TAX_ISSUE_TYPE_CODE", tax_issue_type_code);						// 세금계산서발행구분
			mav.addObject("SPEC_TYPE_CODE", spec_type_code);								// 제원타입코드
			mav.addObject("EST_TYPE_CODE", est_type_code);									// 견적구분코드(품목유형코드)
			
			HashMap adminMap = (HashMap)request.getSession().getAttribute(SGConfigManager.getString("common.session.admin.name"));
			
			mav.addObject("admin_id",(String)adminMap.get("ADMIN_ID"));
			mav.addObject("admin_nm",(String)adminMap.get("ADMIN_NM"));
			mav.addObject("sabun",(String)adminMap.get("SABUN"));
			
			mav.addObject("dept_code",pjtManageBiz.getDeptCode((String)adminMap.get("SABUN")));
		    mav.addObject("dept_nm", pjtManageBiz.getDeptNm(pjtManageBiz.getDeptCode((String)adminMap.get("SABUN"))));
			
		    // 수주ID 생성
			String new_ord_id = orderInfoManageBiz.createOrdId(paramMap);
			mav.addObject("new_ord_id",new_ord_id);
			
			//프로젝트 관리(전체)를 위한 페이지 구분
			if(paramMap.get("totMng").equals("all")){
				mav.setViewName("/pjt/allORDManageList");
			}else{
				mav.setViewName("/ord/order/orderInfoManage");
			}

		} catch (Exception e) {
			logger.error(e, e);
		}
		return mav;
	}
	
	/**
	 * 수주정보관리 목록조회(수주정보)
	 * @param  request
	 * @param  response
	 * @return mav		
	 * 2011. 4. 15.
	 */
	public ModelAndView orderInfoManageList(HttpServletRequest request, HttpServletResponse response) {
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
			if("" != paramMap.get("src_ord_date_start") || null != paramMap.get("src_ord_date_start")){
				String src_ord_date_start = paramMap.get("src_ord_date_start").toString();
				src_ord_date_start = src_ord_date_start.replace("-", "");
				paramMap.put("src_ord_date_start", src_ord_date_start);
			}
			// 검색 종료일
			if("" != paramMap.get("src_ord_date_end") || null != paramMap.get("src_ord_date_end") ){
				String src_ord_date_end = paramMap.get("src_ord_date_end").toString();
				src_ord_date_end = src_ord_date_end.replace("-", "");
				paramMap.put("src_ord_date_end", src_ord_date_end);
			}
			
			/***** DB에서 목록조회 *****/
			result = orderInfoManageBiz.selectOrderInfoManageList(paramMap);			
			resultCnt = orderInfoManageBiz.selectOrderInfoManageListCount(paramMap); 
			
			/***** 조회된 결과를 JSON형식으로 screen에 Return *****/
			mapResult.put("success", "true");								// 성공여부
			mapResult.put("message", "Loaded data");						// message
			
		} catch (Exception e) {
			logger.error(e, e);
			mapResult.put("success", "false");								// 성공여부
			mapResult.put("message", "False Loaded data");					// message
			e.printStackTrace();
		}
		
		JSONArray jsonArray = JSONArray.fromObject(result);					// 조회된 결과값
		mapResult.put("data_1st", jsonArray);								
		mapResult.put("total_1st", resultCnt); 								// 목록의 총갯수 조회
		JSONObject jsonObject = JSONObject.fromObject(mapResult);			// JSON형식으로 설정
		mav.addObject("RESULT_1ST", jsonObject);							// 조회된 결과값을 담기
		
		return mav;
	}
	
	/**
	 * 수주정보관리(수주 품목정보) 목록조회
	 * @param  request 
	 * @param  response
	 * @return 
	 * 2011. 4. 18.
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
			 
			List result_edit_1st = orderInfoManageBiz.selectOrdItemInfo(map);		
		
			JSONArray jsonArray = new JSONArray();
			jsonArray = JSONArray.fromObject(result_edit_1st);		
			
			mapResult.put("data_edit_1st", jsonArray);
			mapResult.put("total_edit_1st", orderInfoManageBiz.selectOrdItemInfoCount(map));
			
			JSONObject jsonObject = JSONObject.fromObject(mapResult);	 
			mav.addObject("RESULT_EDIT_1ST", jsonObject);	

		}catch(Exception ex){
			logger.error(ex.getMessage());
		}
		
		return mav;
	}
	
	/**
	 * 수주정보관리(납품처 시스템사양 정보) 목록조회
	 * @param  request 
	 * @param  response
	 * @return 
	 * 2011. 4. 18.
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
			 
			List result_edit_2nd = orderInfoManageBiz.selectOrdSpecInfo(map);		
		
			JSONArray jsonArray = new JSONArray();
			jsonArray = JSONArray.fromObject(result_edit_2nd);		
			
			mapResult.put("data_edit_2nd", jsonArray);
			mapResult.put("total_edit_2nd", orderInfoManageBiz.selectOrdSpecInfoCount(map));
			
			JSONObject jsonObject = JSONObject.fromObject(mapResult);	 
			mav.addObject("RESULT_EDIT_2ND", jsonObject);	

		}catch(Exception ex){
			logger.error(ex.getMessage());
		}
		
		return mav;
	}
	
	/**
	 * 수주정보관리(세금계산서 분할 발행정보) 목록조회
	 * @param  request 
	 * @param  response
	 * @return 
	 * 2011. 4. 18.
	 */
	public ModelAndView result_edit_3rd(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView();
		
		try{
			mav.setViewName("/result/result_edit_3rd");	
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
			 
			List result_edit_3rd = orderInfoManageBiz.selectTaxInfo(map);		
		
			JSONArray jsonArray = new JSONArray();
			jsonArray = JSONArray.fromObject(result_edit_3rd);		
			
			mapResult.put("data_edit_3rd", jsonArray);
			mapResult.put("total_edit_3rd", orderInfoManageBiz.selectTaxInfoCount(map));
			
			JSONObject jsonObject = JSONObject.fromObject(mapResult);	 
			mav.addObject("RESULT_EDIT_3RD", jsonObject);	

		}catch(Exception ex){
			logger.error(ex.getMessage());
		}
		
		return mav;
	}
	
	/**
	 * 수주정보관리 저장, 수정
	 * @param request	( ORD_INFO 		   : 수주정보관리
	 *                  , ORD_ITEM_INFO    : 수주품목관리
	 *                  , ORD_SPEC_INFO    : 수주설치 시스템사양정보
	 * 					)
	 * @param  response
	 * @return 
	 * 2011. 4. 18.
	 */
	public ModelAndView saveOrderInfoManage(HttpServletRequest request, HttpServletResponse response) {
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
			
			/***** session 정보 *****/
			HashMap adminMap = (HashMap)request.getSession().getAttribute(SGConfigManager.getString("common.session.admin.name"));
			map.put("final_mod_id", (String)adminMap.get("ADMIN_ID"));	// 로그인 ID
			
			/***** 저장 및 수정 *****/
			boolean deptRegResult = orderInfoManageBiz.saveOrderInfoManage(map, request);
			
			// 검색조건의 날짜 값에서 "-"를 제거
			// 검색 시작일
			if("" != map.get("src_ord_date_start") || null != map.get("src_ord_date_start")){
				String src_ord_date_start = map.get("src_ord_date_start").toString();
				src_ord_date_start = src_ord_date_start.replace("-", "");
				map.put("src_ord_date_start", src_ord_date_start);
			}
			// 검색 종료일
			if("" != map.get("src_ord_date_end") || null != map.get("src_ord_date_end") ){
				String src_ord_date_end = map.get("src_ord_date_end").toString();
				src_ord_date_end = src_ord_date_end.replace("-", "");
				map.put("src_ord_date_end", src_ord_date_end);
			}
			
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
			List result = orderInfoManageBiz.selectOrderInfoManageList(map);						 
			
			/***** 조회된 결과를 JSON형식으로 screen에 Return *****/
			
			jsonArray = JSONArray.fromObject(result); 			
			mapResult.put("success", "true");							// 성공여부
			mapResult.put("message", "Loaded data");					// message
			mapResult.put("data_1st", jsonArray);						// 조회된 결과값
			mapResult.put("total_1st", orderInfoManageBiz.selectOrderInfoManageListCount(map));	// 목록의 총갯수 조회
			
			// 신규 저장일 경우 새로운 ord_id를 채번해서 화면에 설정해준다.
			if("save".equals(saveDiv)){
				// 견적ID 생성
				String new_est_id = orderInfoManageBiz.createOrdId(map);
				mapResult.put("new_est_id",new_est_id); 
			}
			
			jsonObject = JSONObject.fromObject(mapResult);	

		}catch (Exception e){
			logger.error(e, e);
			e.printStackTrace();
		}finally{
			
		}
		mav.addObject("RESULT_1ST", jsonObject); 	
		return mav;
	}
	
	/** 수주정보관리 End   ********************************************************************/
	
	
	/** 수주정보조회 Start ********************************************************************/
	/**
	 * 수주정보조회(초기화면)
	 * @param  request
	 * @param  response
	 * @return mav		(공통코드 목록)
	 * 2011. 4. 15.
	 */
	public ModelAndView orderInfoInquiry(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = null;
		
		try {
			mav = new ModelAndView();
			List item_pattern_code = sgisCodeBiz.selectComboCode("ITEM_PATTERN_CODE");   	// 수주구분코드(품목유형코드)
			List roll_type_code = sgisCodeBiz.selectComboCode("ROLL_TYPE_CODE");   			// 업무구분코드
			List flow_status_code = sgisCodeBiz.selectComboCode("FLOW_STATUS_CODE");   		// 진행상태
			List pay_free_code = sgisCodeBiz.selectComboCode("PAY_FREE_CODE");   			// 유무상구분코드
			List tax_issue_type_code = sgisCodeBiz.selectComboCode("TAX_ISSUE_TYPE_CODE"); 	// 세금계산서발행구분
			List spec_type_code = sgisCodeBiz.selectComboCode("SPEC_TYPE_CODE"); 			// 제원타입코드
			List est_type_code = sgisCodeBiz.selectComboCode("EST_TYPE_CODE"); 				// 수주구분코드
			
			mav.addObject("EST_TYPE_CODE", est_type_code);									// 수주구분코드
			mav.addObject("ITEM_PATTERN_CODE", item_pattern_code);							// 수주구분코드(품목유형코드)
			mav.addObject("ROLL_TYPE_CODE", roll_type_code);				 		 		// 업무구분코드
			mav.addObject("FLOW_STATUS_CODE", flow_status_code);				 			// 진행상태
			mav.addObject("PAY_FREE_CODE", pay_free_code);				 					// 유무상구분코드
			mav.addObject("TAX_ISSUE_TYPE_CODE", tax_issue_type_code);						// 세금계산서발행구분
			mav.addObject("SPEC_TYPE_CODE", spec_type_code);								// 제원타입코드
			

		} catch (Exception e) {
			logger.error(e, e);
		}
		return mav;
	}
	/** 수주정보조회 End   ********************************************************************/

	
	/** 수주진행상태 관리 Start ****************************************************************/
	/**
	 * 수주진행상태 관리(초기화면)
	 * @param  request
	 * @param  response
	 * @return mav		(공통코드 목록)
	 * 2011. 4. 15.
	 */
	public ModelAndView orderProcessStateManage(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = null;
		
		try {
			mav = new ModelAndView();
			List item_pattern_code = sgisCodeBiz.selectComboCode("ITEM_PATTERN_CODE");   	// 수주구분코드(품목유형코드)
			List flow_status_code = sgisCodeBiz.selectComboCode("FLOW_STATUS_CODE");   		// 진행상태
			List pay_free_code = sgisCodeBiz.selectComboCode("PAY_FREE_CODE");   			// 유무상구분코드
			List roll_type_code = sgisCodeBiz.selectComboCode("ROLL_TYPE_CODE");   			// 업무구분코드
			List est_type_code = sgisCodeBiz.selectComboCode("EST_TYPE_CODE");   		    // 견적구분코드
			
			mav.addObject("ITEM_PATTERN_CODE", item_pattern_code);							// 수주구분코드(품목유형코드)
			mav.addObject("FLOW_STATUS_CODE", flow_status_code);				 			// 진행상태
			mav.addObject("PAY_FREE_CODE", pay_free_code);				 					// 유무상구분코드
			mav.addObject("ROLL_TYPE_CODE", roll_type_code);				 		 		// 업무구분코드
			mav.addObject("EST_TYPE_CODE", est_type_code);				 		 			// 견적구분코드
		} catch (Exception e) {
			logger.error(e, e);
		}
		return mav;
	}
	
	/**
	 * 수주정보관리 목록조회(수주정보)
	 * @param  request
	 * @param  response
	 * @return mav		
	 * 2011. 4. 22.
	 */
	public ModelAndView orderProcessStateManageList(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = null;
		
		mav = new ModelAndView();
		List result = null;				// 조회결과
		int resultCnt = 0;
		
		mav.setViewName("/result/result_edit_3rd");	
		HashMap paramMap = WebUtil.parseRequestMap(request); 
		HashMap<String,Object> mapResult = new HashMap<String, Object>();
		
		try {
			
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
			
			// 검색조건의 날짜 값에서 "-"를 제거
			// 검색 시작일
			if("" != paramMap.get("src_ord_date_start") || null != paramMap.get("src_ord_date_start")){
				String src_ord_date_start = paramMap.get("src_ord_date_start").toString();
				src_ord_date_start = src_ord_date_start.replace("-", "");
				paramMap.put("src_ord_date_start", src_ord_date_start);
			}
			// 검색 종료일
			if("" != paramMap.get("src_ord_date_end") || null != paramMap.get("src_ord_date_end") ){
				String src_ord_date_end = paramMap.get("src_ord_date_end").toString();
				src_ord_date_end = src_ord_date_end.replace("-", "");
				paramMap.put("src_ord_date_end", src_ord_date_end);
			}
			
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
			result = orderInfoManageBiz.selectOrderInfoManageList(paramMap);			
			resultCnt = orderInfoManageBiz.selectOrderInfoManageListCount(paramMap); 
			
			/***** 조회된 결과를 JSON형식으로 screen에 Return *****/
			mapResult.put("success", "true");								// 성공여부
			mapResult.put("message", "Loaded data");						// message
			
		} catch (Exception e) {
			logger.error(e, e);
			mapResult.put("success", "false");								// 성공여부
			mapResult.put("message", "False Loaded data");					// message
			e.printStackTrace();
		}
		
		JSONArray jsonArray = JSONArray.fromObject(result);					// 조회된 결과값
		mapResult.put("data_edit_3rd", jsonArray);								
		mapResult.put("total_edit_3rd", resultCnt); 						// 목록의 총갯수 조회
		JSONObject jsonObject = JSONObject.fromObject(mapResult);			// JSON형식으로 설정
		mav.addObject("RESULT_EDIT_3RD", jsonObject);						// 조회된 결과값을 담기
		
		return mav;
	}
	
	/**
	 * 수주진행상태  수정
	 * @param request	( ORD_INFO 		   : 수주정보관리
	 * 					)
	 * @param  response
	 * @return 
	 * 2011. 4. 22.
	 */
	public ModelAndView saveOrderProcessStateManage(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView(); 
		HashMap mapResult = new HashMap();
		JSONArray jsonArray = new JSONArray();
		JSONObject jsonObject = new JSONObject();
		
		try {
			mav = new ModelAndView();
			mav.setViewName("/result/result_edit_3rd");
			
			/***** 조회조건 및 parameter설정 *****/
			HashMap map = WebUtil.parseRequestMap(request);  
			
			// 검색조건의 날짜 값에서 "-"를 제거
			// 검색 시작일
			if("" != map.get("src_ord_date_start") || null != map.get("src_ord_date_start")){
				String src_ord_date_start = map.get("src_ord_date_start").toString();
				src_ord_date_start = src_ord_date_start.replace("-", "");
				map.put("src_ord_date_start", src_ord_date_start);
			}
			// 검색 종료일
			if("" != map.get("src_ord_date_end") || null != map.get("src_ord_date_end") ){
				String src_ord_date_end = map.get("src_ord_date_end").toString();
				src_ord_date_end = src_ord_date_end.replace("-", "");
				map.put("src_ord_date_end", src_ord_date_end);
			}
			
			/***** session 정보 *****/
			HashMap adminMap = (HashMap)request.getSession().getAttribute(SGConfigManager.getString("common.session.admin.name"));
			map.put("final_mod_id", (String)adminMap.get("ADMIN_ID"));	// 로그인 ID
			
			/***** 저장 및 수정 *****/
			boolean deptRegResult = orderProcessStateManageBiz.saveOrderProcessStateManage(map, request);
			
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
			List result = orderInfoManageBiz.selectOrderInfoManageList(map);						 
			
			/***** 조회된 결과를 JSON형식으로 screen에 Return *****/
			
			jsonArray = JSONArray.fromObject(result); 			
			mapResult.put("success", "true");							// 성공여부
			mapResult.put("message", "Loaded data");					// message
			mapResult.put("data_edit_3rd", jsonArray);						// 조회된 결과값
			mapResult.put("total_edit_3rd", orderInfoManageBiz.selectOrderInfoManageListCount(map));	// 목록의 총갯수 조회
			jsonObject = JSONObject.fromObject(mapResult);	

		}catch (Exception e){
			logger.error(e, e);
			e.printStackTrace();
		}finally{
			
		}
		mav.addObject("RESULT_EDIT_3RD", jsonObject); 	
		return mav;
	}
	
	
	/** 수주진행상태 관리 End   ****************************************************************/
	
	/** 수주팝업 Start ****************************************************************/
	/**
	 * 수주팝업(초기화면)
	 * @param  request
	 * @param  response
	 * @return mav		(공통코드 목록)
	 * 2011. 4. 28.
	 */
	public ModelAndView orderPop(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = null;
		
		try {
			mav = new ModelAndView();

		} catch (Exception e) {
			logger.error(e, e);
		}
		return mav;
	}
	
	/**
	 * 수주팝업 목록조회
	 * @param  request
	 * @param  response
	 * @return mav		
	 * 2011. 4. 28.
	 */
	public ModelAndView orderPopList(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = null;
		
		mav = new ModelAndView();
		List result = null;				// 조회결과
		int resultCnt = 0;
		
		mav.setViewName("/result/result_1st");	
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
			result = orderInfoManageBiz.selectOrderPopList(paramMap);			
			resultCnt = orderInfoManageBiz.selectOrderPopListCount(paramMap); 
			
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
		mapResult.put("total_1st_pop", resultCnt); 							// 목록의 총갯수 조회
		JSONObject jsonObject = JSONObject.fromObject(mapResult);			// JSON형식으로 설정
		mav.addObject("RESULT_1ST", jsonObject);							// 조회된 결과값을 담기
		
		return mav;
	}
	
	/** 수주팝업 End   ****************************************************************/
	
	/** 세금계산서발행정보 Start *******************************************************/
	/**
	 * 세금계산서발행정보(초기화면)
	 * @param  request
	 * @param  response
	 * @return mav		(공통코드 목록)
	 * 2011. 6. 2.
	 */
	public ModelAndView taxPublishInfoManage(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = null;
		
		try {
			mav = new ModelAndView();
			HashMap paramMap = WebUtil.parseRequestMap(request);
			
			List item_pattern_code = sgisCodeBiz.selectComboCode("ITEM_PATTERN_CODE");   	// 수주구분코드(품목유형코드)
			List roll_type_code = sgisCodeBiz.selectComboCode("ROLL_TYPE_CODE");   			// 업무구분코드
			List flow_status_code = sgisCodeBiz.selectComboCode("FLOW_STATUS_CODE");   		// 진행상태
			List pay_free_code = sgisCodeBiz.selectComboCode("PAY_FREE_CODE");   			// 유무상구분코드
			List tax_issue_type_code = sgisCodeBiz.selectComboCode("TAX_ISSUE_TYPE_CODE"); 	// 세금계산서발행구분
			List spec_type_code = sgisCodeBiz.selectComboCode("SPEC_TYPE_CODE"); 			// 제원타입코드
			List est_type_code = sgisCodeBiz.selectComboCode("EST_TYPE_CODE");   		    // 견적구분코드
			List custom_type = sgisCodeBiz.selectComboCode("CUSTOM_TYPE");					// 거래처구분코드
			List per_biz_type_code = sgisCodeBiz.selectComboCode("PER_BIZ_TYPE_CODE");		// 개인/사업자구분코드

			mav.addObject("CUSTOM_TYPE", custom_type);										// 거래처구분코드
			mav.addObject("PER_BIZ_TYPE_CODE", per_biz_type_code);							// 개인/사업자구분코드
			mav.addObject("ITEM_PATTERN_CODE", item_pattern_code);							// 수주구분코드(품목유형코드)
			mav.addObject("ROLL_TYPE_CODE", roll_type_code);				 		 		// 업무구분코드
			mav.addObject("FLOW_STATUS_CODE", flow_status_code);				 			// 진행상태
			mav.addObject("PAY_FREE_CODE", pay_free_code);				 					// 유무상구분코드
			mav.addObject("TAX_ISSUE_TYPE_CODE", tax_issue_type_code);						// 세금계산서발행구분
			mav.addObject("SPEC_TYPE_CODE", spec_type_code);								// 제원타입코드
			mav.addObject("EST_TYPE_CODE", est_type_code);									// 견적구분코드(품목유형코드)
			
			HashMap adminMap = (HashMap)request.getSession().getAttribute(SGConfigManager.getString("common.session.admin.name"));
			
			mav.addObject("admin_id",(String)adminMap.get("ADMIN_ID"));
			mav.addObject("admin_nm",(String)adminMap.get("ADMIN_NM"));
			mav.addObject("sabun",(String)adminMap.get("SABUN"));
			
			mav.addObject("dept_code",pjtManageBiz.getDeptCode((String)adminMap.get("SABUN")));
		    mav.addObject("dept_nm", pjtManageBiz.getDeptNm(pjtManageBiz.getDeptCode((String)adminMap.get("SABUN"))));
			
		    // 수주ID 생성
			String new_ord_id = orderInfoManageBiz.createOrdId(paramMap);
			mav.addObject("new_ord_id",new_ord_id);
			
			//프로젝트 관리(전체)를 위한 페이지 구분
			if(paramMap.get("totMng").equals("all")){
				mav.setViewName("/pjt/allORDManageList");
			}else{
				mav.setViewName("/ord/order/orderInfoManage");
			}

		} catch (Exception e) {
			logger.error(e, e);
		}
		return mav;
	}
	
	/**
	 * 세금계산서발행정보
	 * @param  request
	 * @param  response
	 * @return mav		
	 * 2011. 6. 3.
	 */
	public ModelAndView taxPublishInfoManageList(HttpServletRequest request, HttpServletResponse response) {
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
			if("" != paramMap.get("src_ord_date_start") || null != paramMap.get("src_ord_date_start")){
				String src_ord_date_start = paramMap.get("src_ord_date_start").toString();
				src_ord_date_start = src_ord_date_start.replace("-", "");
				paramMap.put("src_ord_date_start", src_ord_date_start);
			}
			// 검색 종료일
			if("" != paramMap.get("src_ord_date_end") || null != paramMap.get("src_ord_date_end") ){
				String src_ord_date_end = paramMap.get("src_ord_date_end").toString();
				src_ord_date_end = src_ord_date_end.replace("-", "");
				paramMap.put("src_ord_date_end", src_ord_date_end);
			}
			
			System.out.println("파람..........."+paramMap.toString());
			
			
			
			/***** DB에서 목록조회 *****/
			result = orderInfoManageBiz.selectTaxPublishInfoManageList(paramMap);			
			resultCnt = orderInfoManageBiz.selectTaxPublishInfoManageListCount(paramMap); 
			
			/***** 조회된 결과를 JSON형식으로 screen에 Return *****/
			mapResult.put("success", "true");								// 성공여부
			mapResult.put("message", "Loaded data");						// message
			
		} catch (Exception e) {
			logger.error(e, e);
			mapResult.put("success", "false");								// 성공여부
			mapResult.put("message", "False Loaded data");					// message
			e.printStackTrace();
		}
		
		JSONArray jsonArray = JSONArray.fromObject(result);					// 조회된 결과값
		mapResult.put("data_1st", jsonArray);								
		mapResult.put("total_1st", resultCnt); 								// 목록의 총갯수 조회
		JSONObject jsonObject = JSONObject.fromObject(mapResult);			// JSON형식으로 설정
		mav.addObject("RESULT_1ST", jsonObject);							// 조회된 결과값을 담기
		
		return mav;
	}
	
	/**
	 * 세금계산서 발행정보 저장, 수정
	 * @param request	
	 * @param  response
	 * @return 
	 * 2011. 4. 18.
	 */
	public ModelAndView saveTaxPublishInfoManage(HttpServletRequest request, HttpServletResponse response) {
		
		ModelAndView mav = new ModelAndView(); 
		HashMap mapResult = new HashMap();
		JSONArray jsonArray = new JSONArray();
		JSONObject jsonObject = new JSONObject();
		
		List result = null;				// 조회결과
		int resultCnt = 0;
		
		try {
			mav = new ModelAndView();
			mav.setViewName("/result/result_1st");
			
			/***** 조회조건 및 parameter설정 *****/
			HashMap map = WebUtil.parseRequestMap(request);  
			String saveDiv = (String)map.get("saveDiv");		// 저장(save)인지 수정(update)인지 구분
			
			/***** session 정보 *****/
			HashMap adminMap = (HashMap)request.getSession().getAttribute(SGConfigManager.getString("common.session.admin.name"));
			map.put("final_mod_id", (String)adminMap.get("ADMIN_ID"));	// 로그인 ID
			
			/***** 저장 및 수정 *****/
			boolean deptRegResult = orderInfoManageBiz.saveTaxPublishInfoManage(map, request);
			
			// 검색조건의 날짜 값에서 "-"를 제거
			// 검색 시작일
			if("" != map.get("src_ord_date_start") || null != map.get("src_ord_date_start")){
				String src_ord_date_start = map.get("src_ord_date_start").toString();
				src_ord_date_start = src_ord_date_start.replace("-", "");
				map.put("src_ord_date_start", src_ord_date_start);
			}
			// 검색 종료일
			if("" != map.get("src_ord_date_end") || null != map.get("src_ord_date_end") ){
				String src_ord_date_end = map.get("src_ord_date_end").toString();
				src_ord_date_end = src_ord_date_end.replace("-", "");
				map.put("src_ord_date_end", src_ord_date_end);
			}
			
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
			/***** DB에서 목록조회 *****/
			result = orderInfoManageBiz.selectTaxPublishInfoManageList(map);			
			resultCnt = orderInfoManageBiz.selectTaxPublishInfoManageListCount(map); 					 
			
			/***** 조회된 결과를 JSON형식으로 screen에 Return *****/
			
			jsonArray = JSONArray.fromObject(result); 			
			mapResult.put("success", "true");							// 성공여부
			mapResult.put("message", "Loaded data");					// message
			mapResult.put("data_1st", jsonArray);						// 조회된 결과값
			mapResult.put("total_1st", resultCnt);	// 목록의 총갯수 조회
			
			jsonObject = JSONObject.fromObject(mapResult);	

		}catch (Exception e){
			logger.error(e, e);
			e.printStackTrace();
		}finally{
			
		}
		mav.addObject("RESULT_1ST", jsonObject); 	
		return mav;
	}
	
	/**
	 * 세금계산서 발행정보 저장, 수정(매출등록)
	 * @param request	
	 * @param  response
	 * @return 
	 * 2011. 6. 4.
	 */
	public ModelAndView saveSaleRegister(HttpServletRequest request, HttpServletResponse response) {
		
		ModelAndView mav = new ModelAndView(); 
		HashMap mapResult = new HashMap();
		JSONArray jsonArray = new JSONArray();
		JSONObject jsonObject = new JSONObject();
		
		List result = null;				// 조회결과
		int resultCnt = 0;
		
		try {
			mav = new ModelAndView();
			mav.setViewName("/result/result_1st");
			
			/***** 조회조건 및 parameter설정 *****/
			HashMap map = WebUtil.parseRequestMap(request);  
			String saveDiv = (String)map.get("saveDiv");		// 저장(save)인지 수정(update)인지 구분
			
			/***** session 정보 *****/
			HashMap adminMap = (HashMap)request.getSession().getAttribute(SGConfigManager.getString("common.session.admin.name"));
			map.put("final_mod_id", (String)adminMap.get("ADMIN_ID"));	// 로그인 ID
			
			/***** 저장 및 수정 *****/
			boolean deptRegResult = orderInfoManageBiz.saveSaleRegister(map, request);
			
			// 검색조건의 날짜 값에서 "-"를 제거
			// 검색 시작일
			if("" != map.get("src_ord_date_start") || null != map.get("src_ord_date_start")){
				String src_ord_date_start = map.get("src_ord_date_start").toString();
				src_ord_date_start = src_ord_date_start.replace("-", "");
				map.put("src_ord_date_start", src_ord_date_start);
			}
			// 검색 종료일
			if("" != map.get("src_ord_date_end") || null != map.get("src_ord_date_end") ){
				String src_ord_date_end = map.get("src_ord_date_end").toString();
				src_ord_date_end = src_ord_date_end.replace("-", "");
				map.put("src_ord_date_end", src_ord_date_end);
			}
			
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
			/***** DB에서 목록조회 *****/
			result = orderInfoManageBiz.selectTaxPublishInfoManageList(map);			
			resultCnt = orderInfoManageBiz.selectTaxPublishInfoManageListCount(map); 					 
			
			/***** 조회된 결과를 JSON형식으로 screen에 Return *****/
			
			jsonArray = JSONArray.fromObject(result); 			
			mapResult.put("success", "true");							// 성공여부
			mapResult.put("message", "Loaded data");					// message
			mapResult.put("data_1st", jsonArray);						// 조회된 결과값
			mapResult.put("total_1st", resultCnt);	// 목록의 총갯수 조회
			
			jsonObject = JSONObject.fromObject(mapResult);	

		}catch (Exception e){
			logger.error(e, e);
			e.printStackTrace();
		}finally{
			
		}
		mav.addObject("RESULT_1ST", jsonObject); 	
		return mav;
	}
	
	/** 세금계산서발행정보 End   *******************************************************/
}
