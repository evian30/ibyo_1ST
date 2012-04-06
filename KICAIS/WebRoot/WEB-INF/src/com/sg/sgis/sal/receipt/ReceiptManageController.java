/**
 *  Class Name  : receiptManageController.java
 *  Description : 수금관리 Controller
 *  Modification Information
 *
 *  수정일                   수정자               수정내용
 *  -------      --------   ---------------------------
 *  2011. 4. 29. 고기범              최초 생성
 *
 *  @author 고기범
 *  @since 2011. 4. 29.
 *  @version 1.0
 *  @see 
 * 
 *  Copyright (C) 2011 by SG All right reserved.
 */
package com.sg.sgis.sal.receipt;

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
import com.sg.sgis.ord.order.OrderInfoManageBiz;
import com.sg.sgis.util.CommonUtil;
import com.signgate.core.config.SGConfigManager;
import com.signgate.core.web.controller.SGUserController;
import com.signgate.core.web.util.WebUtil;

public class ReceiptManageController extends SGUserController{

	protected final Log logger = LogFactory.getLog(getClass());
	
	CommonUtil comUtil = new CommonUtil();
	
	// 공통코드 BIZ경로 설정
	private SgisCodeBiz sgisCodeBiz;
	public void setSgisCodeBiz(SgisCodeBiz sgisCodeBiz) {
		this.sgisCodeBiz = sgisCodeBiz;
	}
	
	// 수금관리
	private ReceiptManageBiz receiptManageBiz;
	public void setReceiptManageBiz(ReceiptManageBiz receiptManageBiz) {
		this.receiptManageBiz = receiptManageBiz;
	}
	
	/**
	 * 수금관리(초기화면)
	 * @param  request
	 * @param  response
	 * @return mav		(공통코드 목록)
	 * 2011. 4. 29.
	 */
	public ModelAndView receiptManage(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = null;
		
		try {
			mav = new ModelAndView();
			List pay_condition = sgisCodeBiz.selectComboCode("PAY_CONDITION");   	// 수금분류
			
			mav.addObject("PAY_CONDITION", pay_condition);							// 수금분류
			
			HashMap adminMap = (HashMap)request.getSession().getAttribute(SGConfigManager.getString("common.session.admin.name"));
			
			mav.addObject("admin_id",(String)adminMap.get("ADMIN_ID"));
			mav.addObject("admin_nm",(String)adminMap.get("ADMIN_NM"));
			mav.addObject("sabun",(String)adminMap.get("SABUN"));

		} catch (Exception e) {
			logger.error(e, e);
		}
		return mav;
	}
	
	/**
	 * 수금관리_프로젝트별 수금정보
	 * @param  request
	 * @param  response
	 * @return mav		
	 * 2011. 4. 29.
	 */
	public ModelAndView receiptProjectList(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = null;
		
		mav = new ModelAndView();
		List result = null;				// 조회결과
		int resultCnt = 0;
		
		mav.setViewName("/result/result_edit_1st");	
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
			
			// 검색조건의 날짜 값에서 "-"를 제거
			// 검색 시작일
			if("" != paramMap.get("src_receipt_date_start") || null != paramMap.get("src_receipt_date_start")){
				String src_receipt_date_start = paramMap.get("src_receipt_date_start").toString();
				src_receipt_date_start = src_receipt_date_start.replace("-", "");
				paramMap.put("src_receipt_date_start", src_receipt_date_start);
			}
			// 검색 종료일
			if("" != paramMap.get("src_receipt_date_end") || null != paramMap.get("src_receipt_date_end") ){
				String src_receipt_date_end = paramMap.get("src_receipt_date_end").toString();
				src_receipt_date_end = src_receipt_date_end.replace("-", "");
				paramMap.put("src_receipt_date_end", src_receipt_date_end);
			}
			
			/***** DB에서 목록조회 *****/
			result = receiptManageBiz.selectReceiptProjectList(paramMap);			
			resultCnt = receiptManageBiz.selectReceiptProjectListCount(paramMap); 
			
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
		mapResult.put("data_edit_1st", jsonArray);								
		mapResult.put("total_edit_1st", resultCnt); 						// 목록의 총갯수 조회
		JSONObject jsonObject = JSONObject.fromObject(mapResult);			// JSON형식으로 설정
		mav.addObject("RESULT_EDIT_1ST", jsonObject);						// 조회된 결과값을 담기
		
		return mav;
	}
	
	/**
	 * 수금관리_시스템사양정보
	 * @param  request 
	 * @param  response
	 * @return 
	 * 2011. 4. 29.
	 */
	public ModelAndView receiptManageList(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = null;
		
		mav = new ModelAndView();
		List result = null;				// 조회결과
		int resultCnt = 0;
		
		mav.setViewName("/result/result_edit_2nd");	
		HashMap paramMap = WebUtil.parseRequestMap(request); 
		HashMap<String,Object> mapResult = new HashMap<String, Object>();
		
		try{
			
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
			result = receiptManageBiz.selectReceiptManageList(paramMap);		
			resultCnt = receiptManageBiz.selectReceiptManageListCount(paramMap);
			
			/***** 조회된 결과를 JSON형식으로 screen에 Return *****/
			mapResult.put("success", "true");								// 성공여부
			mapResult.put("message", "Loaded data");						// message

		}catch(Exception e){
			logger.error(e, e);
			mapResult.put("success", "false");								// 성공여부
			mapResult.put("message", "False Loaded data");					// message
			e.printStackTrace();
		}
		
		JSONArray jsonArray = JSONArray.fromObject(result);					// 조회된 결과값
		mapResult.put("data_edit_2nd", jsonArray);								
		mapResult.put("total_edit_2nd", resultCnt); 						// 목록의 총갯수 조회
		JSONObject jsonObject = JSONObject.fromObject(mapResult);			// JSON형식으로 설정
		mav.addObject("RESULT_EDIT_2ND", jsonObject);	
		
		return mav;
	}
	
	/**
	 * 수금관리_수금상세정보 저장, 수정
	 * @param  request
	 * @param  response
	 * @return mav		
	 * 2011. 5. 2.
	 */
	public ModelAndView saveReceiptManage(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = null;
		
		mav = new ModelAndView();
		List result = null;				// 조회결과
		int resultCnt = 0;
		
		mav.setViewName("/result/result_edit_1st");	
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
			
			// 검색조건의 날짜 값에서 "-"를 제거
			// 검색 시작일
			if("" != paramMap.get("src_receipt_date_start") || null != paramMap.get("src_receipt_date_start")){
				String src_receipt_date_start = paramMap.get("src_receipt_date_start").toString();
				src_receipt_date_start = src_receipt_date_start.replace("-", "");
				paramMap.put("src_receipt_date_start", src_receipt_date_start);
			}
			// 검색 종료일
			if("" != paramMap.get("src_receipt_date_end") || null != paramMap.get("src_receipt_date_end") ){
				String src_receipt_date_end = paramMap.get("src_receipt_date_end").toString();
				src_receipt_date_end = src_receipt_date_end.replace("-", "");
				paramMap.put("src_receipt_date_end", src_receipt_date_end);
			}
			
			/***** session 정보 *****/
			HashMap adminMap = (HashMap)request.getSession().getAttribute(SGConfigManager.getString("common.session.admin.name"));
			paramMap.put("final_mod_id", (String)adminMap.get("ADMIN_ID"));	// 로그인 ID
			
			/***** 저장 및 수정 *****/
			boolean deptRegResult = receiptManageBiz.saveReceiptManage(paramMap, request);
			
			/***** DB에서 목록조회 *****/
			result = receiptManageBiz.selectReceiptProjectList(paramMap);			
			resultCnt = receiptManageBiz.selectReceiptProjectListCount(paramMap); 
			
			/***** 조회된 결과를 JSON형식으로 screen에 Return *****/
			if(deptRegResult == true){
				mapResult.put("success", "true");								// 성공여부
				mapResult.put("message", "Loaded data");						// message
			}else{
				mapResult.put("success", "false");								// 성공여부
				mapResult.put("message", "False Loaded data");					// message
			}
			
		} catch (Exception e) {
			logger.error(e, e);
			mapResult.put("success", "false");								// 성공여부
			mapResult.put("message", "False Loaded data");					// message
			e.printStackTrace();
		}
		
		JSONArray jsonArray = JSONArray.fromObject(result);					// 조회된 결과값
		mapResult.put("data_edit_1st", jsonArray);								
		mapResult.put("total_edit_1st", resultCnt); 						// 목록의 총갯수 조회
		JSONObject jsonObject = JSONObject.fromObject(mapResult);			// JSON형식으로 설정
		mav.addObject("RESULT_EDIT_1ST", jsonObject);						// 조회된 결과값을 담기
		
		return mav;
	}
	
	public ModelAndView searchReceiptManage(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = null;

		try {
			mav = new ModelAndView();

			HashMap adminMap = (HashMap)request.getSession().getAttribute(SGConfigManager.getString("common.session.admin.name"));

			mav.addObject("admin_id",(String)adminMap.get("ADMIN_ID"));
			mav.addObject("admin_nm",(String)adminMap.get("ADMIN_NM"));
			mav.addObject("sabun",(String)adminMap.get("SABUN"));

		} catch (Exception e) {
			logger.error(e, e);
		}
		return mav;
	}
	
	/**
	 * 세금계산서 리스트
	 * @param  request
	 * @param  response
	 * @return mav		(공통코드 목록)
	 * 2011. 4. 29.
	 */
	public ModelAndView result_1st(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = null;

		try {
			mav = new ModelAndView();
			mav.setViewName("/result/result_1st");

			//			HashMap adminMap = (HashMap)request.getSession().getAttribute(SGConfigManager.getString("common.session.admin.name"));
			//			
			//			mav.addObject("admin_id",(String)adminMap.get("ADMIN_ID"));
			//			mav.addObject("admin_nm",(String)adminMap.get("ADMIN_NM"));
			//			mav.addObject("sabun",(String)adminMap.get("SABUN"));

			HashMap paramMap = WebUtil.parseRequestMap(request);

			/***** paging *****/ 
			int limit = 0;
			if((String)paramMap.get("limit") != null)
				limit = Integer.parseInt((String)paramMap.get("limit"));
			int start = 0;
			if((String)paramMap.get("start") != null)
				start = Integer.parseInt((String)paramMap.get("start"));

			paramMap.put("limit", limit+start);  
			//AND    PUR_DATE BETWEEN NVL(#src_pur_date_from#, '20000101') AND NVL(#src_pur_date_to#, '20000101')

			if((String)paramMap.get("src_prepare_date_from") == null || ((String)paramMap.get("src_prepare_date_from")).equals("")){
				paramMap.put("src_prepare_date_from","20100101");
			}
			if((String)paramMap.get("src_prepare_date_to") == null || ((String)paramMap.get("src_prepare_date_to")).equals("")){
				paramMap.put("src_prepare_date_to","20191230");
			}

			/***** DB에서 목록조회 *****/
			List result = receiptManageBiz.selectReceiptInfo(paramMap);
			if(result != null && result.size() > 0){

				/***** 조회된 결과를 JSON형식으로 screen에 Return *****/
				JSONArray jsonArray = JSONArray.fromObject(result);
				HashMap<String,Object> mapResult = new HashMap<String, Object>();
				mapResult.put("success", "true");								// 성공여부
				mapResult.put("message", "Loaded data");						// message

				mapResult.put("data_1st", jsonArray);							// 조회된 결과값
				mapResult.put("total_1st", receiptManageBiz.selectReceiptInfoCount(paramMap)); 	// 목록의 총갯수 조회
				JSONObject jsonObject = JSONObject.fromObject(mapResult);		// JSON형식으로 설정
				mav.addObject("RESULT_1ST", jsonObject);						// 조회된 결과값을 담기
			}else if(result == null || result.size() <= 0){
				/***** 조회된 결과를 JSON형식으로 screen에 Return *****/
				JSONArray jsonArray = JSONArray.fromObject(result);
				HashMap<String,Object> mapResult = new HashMap<String, Object>();
				mapResult.put("success", "true");								// 성공여부
				mapResult.put("message", "Loaded data");						// message

				mapResult.put("data_1st", "");							// 조회된 결과값
				mapResult.put("total_1st", "0"); 	// 목록의 총갯수 조회
				JSONObject jsonObject = JSONObject.fromObject(mapResult);		// JSON형식으로 설정
				mav.addObject("RESULT_1ST", jsonObject);						// 조회된 결과값을 담기
			}
		} catch (Exception e) {
			logger.error(e, e);
		}
		return mav;
	}

	public ModelAndView searchReceiptItemInfo(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = null;

		try {
			mav = new ModelAndView();
			mav.setViewName("/result/result_1st");
			
			HashMap paramMap = WebUtil.parseRequestMap(request);

			//HashMap adminMap = (HashMap)request.getSession().getAttribute(SGConfigManager.getString("common.session.admin.name"));
			//			
			//mav.addObject("admin_id",(String)adminMap.get("ADMIN_ID"));
			//mav.addObject("admin_nm",(String)adminMap.get("ADMIN_NM"));
			//mav.addObject("sabun",(String)adminMap.get("SABUN"));

			/***** DB에서 목록조회 *****/
			List result = receiptManageBiz.selectReceiptItemInfo(paramMap);
			
			if(result != null && result.size() > 0){
				/***** 조회된 결과를 JSON형식으로 screen에 Return *****/
				JSONArray jsonArray = JSONArray.fromObject(result);
				HashMap<String,Object> mapResult = new HashMap<String, Object>();
				mapResult.put("success", "true");								// 성공여부
				mapResult.put("message", "Loaded data");						// message

				mapResult.put("data_1st", jsonArray);							// 조회된 결과값
				mapResult.put("total_1st", receiptManageBiz.selectReceiptItemInfoCount(paramMap)); 	// 목록의 총갯수 조회
				JSONObject jsonObject = JSONObject.fromObject(mapResult);		// JSON형식으로 설정
				mav.addObject("RESULT_1ST", jsonObject);
			}
		} catch (Exception e) {
			logger.error(e, e);
		}
		return mav;
	}
	
}
