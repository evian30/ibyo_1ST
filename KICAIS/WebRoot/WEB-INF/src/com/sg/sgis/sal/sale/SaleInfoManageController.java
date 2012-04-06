/**
 *  Class Name  : SaleInfoManageController.java
 *  Description : 매출정보관리 Controller
 *  Modification Information
 *
 *  수정일                   수정자               수정내용
 *  -------      --------   ---------------------------
 *  2011. 4. 25.    고기범              최초 생성
 *
 *  @author 고기범
 *  @since 2011. 4. 25.
 *  @version 1.0
 *  @see 
 * 
 *  Copyright (C) 2011 by SG All right reserved.
 */
package com.sg.sgis.sal.sale;

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

public class SaleInfoManageController extends SGUserController{

	protected final Log logger = LogFactory.getLog(getClass());
	
	CommonUtil comUtil = new CommonUtil();

	// 공통코드 BIZ경로 설정
	private SgisCodeBiz sgisCodeBiz;
	public void setSgisCodeBiz(SgisCodeBiz sgisCodeBiz) {
		this.sgisCodeBiz = sgisCodeBiz;
	}
	
	// 매출정보관리 BIZ경로 설정
	private SaleInfoManageBiz saleInfoManageBiz; 
	public void setSaleInfoManageBiz(SaleInfoManageBiz saleInfoManageBiz){
		this.saleInfoManageBiz = saleInfoManageBiz;
	}
	
	private PjtManageBiz pjtManageBiz; 
	public void setPjtManageBiz(PjtManageBiz pjtManageBiz){
		this.pjtManageBiz = pjtManageBiz;
	} 
	 
	
	/**
	 * 매출정보관리(초기화면)
	 * @param  request
	 * @param  response
	 * @return mav		(공통코드 목록)
	 * 2011. 4. 25.
	 */               
	public ModelAndView saleInfoManage(HttpServletRequest request, HttpServletResponse response)throws Exception {
		ModelAndView mav = null;
		
		try {
			mav = new ModelAndView();
			HashMap paramMap = WebUtil.parseRequestMap(request); 
			
			List est_type_code = sgisCodeBiz.selectComboCode("EST_TYPE_CODE");   			// 매출구분코드(견적구분코드)
			List roll_type_code = sgisCodeBiz.selectComboCode("ROLL_TYPE_CODE");   			// 업무구분코드
			List flow_status_code = sgisCodeBiz.selectComboCode("FLOW_STATUS_CODE");   		// 진행상태
			List pay_free_code = sgisCodeBiz.selectComboCode("PAY_FREE_CODE");   			// 유무상구분코드
			List tax_issue_type_code = sgisCodeBiz.selectComboCode("TAX_ISSUE_TYPE_CODE"); 	// 세금계산서발행구분
			List spec_type_code = sgisCodeBiz.selectComboCode("SPEC_TYPE_CODE"); 			// 제원타입코드
			
			mav.addObject("EST_TYPE_CODE", est_type_code);									// 매출구분코드(견적구분코드)
			mav.addObject("ROLL_TYPE_CODE", roll_type_code);				 		 		// 업무구분코드
			mav.addObject("FLOW_STATUS_CODE", flow_status_code);				 			// 진행상태
			mav.addObject("PAY_FREE_CODE", pay_free_code);				 					// 유무상구분코드
			mav.addObject("TAX_ISSUE_TYPE_CODE", tax_issue_type_code);						// 세금계산서발행구분
			mav.addObject("SPEC_TYPE_CODE", spec_type_code);								// 제원타입코드
			
			HashMap adminMap = (HashMap)request.getSession().getAttribute(SGConfigManager.getString("common.session.admin.name"));
			
			mav.addObject("admin_id",(String)adminMap.get("ADMIN_ID"));
			mav.addObject("admin_nm",(String)adminMap.get("ADMIN_NM"));
			mav.addObject("sabun",(String)adminMap.get("SABUN"));
			
			mav.addObject("dept_code",pjtManageBiz.getDeptCode((String)adminMap.get("SABUN")));
		    mav.addObject("dept_nm", pjtManageBiz.getDeptNm(pjtManageBiz.getDeptCode((String)adminMap.get("SABUN"))));
			
			// 매출ID 생성
			// String new_sal_id = saleInfoManageBiz.createSalId(paramMap);
			// mav.addObject("new_sal_id",new_sal_id); 
			
			
			//프로젝트 관리(전체)를 위한 페이지 구분
			if(paramMap.get("totMng").equals("all")){
				mav.setViewName("/pjt/allSALManageList");
			}else{
				mav.setViewName("/sal/sale/saleInfoManage");
			}
			
								
		} catch (Exception e) {
			logger.error(e, e);
			e.printStackTrace();
		} finally{
			
		}
		return mav;
	}
	
	/**
	 * 매출정보관리 목록조회(수주정보_상세_목록)
	 * @param  request
	 * @param  response
	 * @return mav		
	 * 2011. 4. 26.
	 */
	public ModelAndView selectSaleInfoManageList(HttpServletRequest request, HttpServletResponse response) {
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
				
			/***** DB에서 목록조회 *****/
			result = saleInfoManageBiz.selectSaleInfoManageList(paramMap);			
			resultCnt = saleInfoManageBiz.selectSaleInfoManageListCount(paramMap); 
			
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
	 * 매출정보관리 목록조회
	 * @param  request
	 * @param  response
	 * @return mav		
	 * 2011. 6. 8.
	 */
	public ModelAndView saleInfoManageList(HttpServletRequest request, HttpServletResponse response) {
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
			
			/***** DB에서 목록조회 *****/
			result = saleInfoManageBiz.saleInfoManageList(paramMap);			
			resultCnt = saleInfoManageBiz.saleInfoManageListCount(paramMap); 
			
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
		mapResult.put("data_2nd", jsonArray);								
		mapResult.put("total_2nd", resultCnt); 								// 목록의 총갯수 조회
		JSONObject jsonObject = JSONObject.fromObject(mapResult);			// JSON형식으로 설정
		mav.addObject("RESULT_2ND", jsonObject);							// 조회된 결과값을 담기
		
		return mav;
	}
	/**
	 * 매출정보관리(수주 품목정보) 목록조회
	 * @param  request 
	 * @param  response
	 * @return 
	 * 2011. 4. 26.
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
			 
			List result_edit_1st = saleInfoManageBiz.selectSalItemInfo(map);		
		
			JSONArray jsonArray = new JSONArray();
			jsonArray = JSONArray.fromObject(result_edit_1st);		
			
			mapResult.put("data_edit_1st", jsonArray);
			mapResult.put("total_edit_1st", saleInfoManageBiz.selectSalItemInfoCount(map));
			
			JSONObject jsonObject = JSONObject.fromObject(mapResult);	 
			mav.addObject("RESULT_EDIT_1ST", jsonObject);	

		}catch(Exception ex){
			logger.error(ex.getMessage());
		}
		
		return mav;
	}
	
	/**
	 * 매출정보관리(납품처 시스템사양 정보) 목록조회
	 * @param  request 
	 * @param  response
	 * @return 
	 * 2011. 4. 26.
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
			 
			List result_edit_2nd = saleInfoManageBiz.selectSalSpecInfo(map);		
		
			JSONArray jsonArray = new JSONArray();
			jsonArray = JSONArray.fromObject(result_edit_2nd);		
			
			mapResult.put("data_edit_2nd", jsonArray);
			mapResult.put("total_edit_2nd", saleInfoManageBiz.selectSalSpecInfoCount(map));
			
			JSONObject jsonObject = JSONObject.fromObject(mapResult);	 
			mav.addObject("RESULT_EDIT_2ND", jsonObject);	

		}catch(Exception ex){
			logger.error(ex.getMessage());
		}
		
		return mav;
	}
	
	/**
	 * 매출정보관리(세금계산서 분할 발행정보) 목록조회
	 * @param  request 
	 * @param  response
	 * @return 
	 * 2011. 4. 26.
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
			 
			List result_edit_3rd = saleInfoManageBiz.selectTaxInfo(map);		
		
			JSONArray jsonArray = new JSONArray();
			jsonArray = JSONArray.fromObject(result_edit_3rd);		
			
			mapResult.put("data_edit_3rd", jsonArray);
			mapResult.put("total_edit_3rd", saleInfoManageBiz.selectTaxInfoCount(map));
			
			JSONObject jsonObject = JSONObject.fromObject(mapResult);	 
			mav.addObject("RESULT_EDIT_3RD", jsonObject);	

		}catch(Exception ex){
			logger.error(ex.getMessage());
		}
		
		return mav;
	}
	
	/**
	 * 매출정보관리 저장, 수정
	 * @param request	( SAL_INFO 		   : 매출정보관리
	 *                  , SAL_ITEM_INFO    : 매출품목관리
	 *                  , SAL_SPEC_INFO    : 매출설치 시스템사양정보
	 * 					)
	 * @param  response
	 * @return 
	 * 2011. 4. 26.
	 */
	public ModelAndView saveSaleInfoManage(HttpServletRequest request, HttpServletResponse response) {
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
			boolean deptRegResult = saleInfoManageBiz.saveSaleInfoManage(map, request);
			
			// 검색조건의 날짜 값에서 "-"를 제거
			// 검색 시작일
			if("" != map.get("src_sal_date_start") || null != map.get("src_sal_date_start")){
				String src_sal_date_start = map.get("src_sal_date_start").toString();
				src_sal_date_start = src_sal_date_start.replace("-", "");
				map.put("src_sal_date_start", src_sal_date_start);
			}
			// 검색 종료일
			if("" != map.get("src_sal_date_end") || null != map.get("src_sal_date_end") ){
				String src_sal_date_end = map.get("src_sal_date_end").toString();
				src_sal_date_end = src_sal_date_end.replace("-", "");
				map.put("src_sal_date_end", src_sal_date_end);
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
			List result = saleInfoManageBiz.selectSaleInfoManageList(map);						 
			
			/***** 조회된 결과를 JSON형식으로 screen에 Return *****/
			
			jsonArray = JSONArray.fromObject(result); 			
			if(deptRegResult == true){
				mapResult.put("success", "true");							// 성공여부
				mapResult.put("message", "Loaded data");					// message
			}else{
				mapResult.put("success", "false");							// 성공여부
				mapResult.put("message", "Loaded data false");				// message
			}
			mapResult.put("data_1st", jsonArray);						// 조회된 결과값
			mapResult.put("total_1st", saleInfoManageBiz.selectSaleInfoManageListCount(map));	// 목록의 총갯수 조회

			// 신규 저장일 경우 새로운 sal_id를 채번해서 화면에 설정해준다.
			if("save".equals(saveDiv)){
				// 매출ID 생성
				String new_sal_id = saleInfoManageBiz.createSalId(map);
				mapResult.put("new_sal_id",new_sal_id);
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
}
