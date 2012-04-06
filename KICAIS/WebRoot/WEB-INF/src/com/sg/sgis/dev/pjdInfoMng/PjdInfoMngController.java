/**
 *  Class Name  : PjdInfoMngController
 *  Description : 개발프로젝트관리 Controller
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


package com.sg.sgis.dev.pjdInfoMng;

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


public class PjdInfoMngController extends SGUserController{
	
	protected final Log logger = LogFactory.getLog(getClass());
	
	CommonUtil comUtil = new CommonUtil();
	
	// BIZ경로 설정
	private PjdInfoMngBiz pjdInfoMngBiz;
	
	private DeptBiz deptBiz;
	
	// 공통코드 BIZ경로 설정
	private SgisCodeBiz sgisCodeBiz;



	public PjdInfoMngBiz getPjdInfoMngBiz() {
		return pjdInfoMngBiz;
	}

	public void setPjdInfoMngBiz(PjdInfoMngBiz pjdInfoMngBiz) {
		this.pjdInfoMngBiz = pjdInfoMngBiz;
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
	 * 개발프로젝트 조회
	 * @param  request
	 * @param  response
	 * @return mav		
	 * 2011. 1. 26.
	 */
	public ModelAndView pjdInfoMngList(HttpServletRequest request, HttpServletResponse response) {
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
			List roll_type_code = sgisCodeBiz.selectComboCode("ROLL_TYPE_CODE");	// 사업구분
			mav.addObject("ROLL_TYPE_CODE", roll_type_code);						
						
			// 공통코드 조회
			List pay_free_code = sgisCodeBiz.selectComboCode("PAY_FREE_CODE");	// 유무상구분
			mav.addObject("PAY_FREE_CODE", pay_free_code);						
					
			// 공통코드 조회
			List proc_status_code = sgisCodeBiz.selectComboCode("FLOW_STATUS_CODE");	// 진행상태
			mav.addObject("FLOW_STATUS_CODE", proc_status_code);						
			
			// 공통코드 조회
			List equip_type_code = sgisCodeBiz.selectComboCode("EQUIP_TYPE_CODE");	// 장비구분
			mav.addObject("EQUIP_TYPE_CODE", equip_type_code);												

		} catch (Exception e) {
			logger.error(e, e);
			e.printStackTrace();
		}
		return mav;
	}


	
	/**
	 * 개발프로젝트정보 관리 : 조회된 목록을 화면으로 retuen
	 * @param  request 
	 * @param  response
	 * @return mav	   
	 * 2011. 1. 26.
	 */
	
	public ModelAndView result(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = null;
		
		try{
			mav = new ModelAndView();
			mav.setViewName("/result/result_1st");	
			HashMap paramMap = WebUtil.parseRequestMap(request); 
			

			/***** paging *****/ 
			int limit = 0;
			if((String)paramMap.get("limit") != null)
				limit = Integer.parseInt((String)paramMap.get("limit"));
			int start = 0;
			if((String)paramMap.get("start") != null)
				start = Integer.parseInt((String)paramMap.get("start"));
			
			paramMap.put("limit", limit+start);  
			paramMap.put("src_pjt_name",((String)paramMap.get("src_pjt_name")).toUpperCase());
			
			HashMap adminMap = (HashMap)request.getSession().getAttribute(SGConfigManager.getString("common.session.admin.name"));
			
			String emp_num   =(String)adminMap.get("ADMIN_ID");
			String dept_code = pjtManageBiz.getDeptCode((String)adminMap.get("SABUN"));
			String groups	 = (String)adminMap.get("GROUPS");
			
			  
			/***** DB에서 목록조회 *****/
			List result = pjdInfoMngBiz.selectPjdInfo(paramMap);			
			
			/***** 조회된 결과를 JSON형식으로 screen에 Return *****/
			JSONArray jsonArray = JSONArray.fromObject(result);
			HashMap<String,Object> mapResult = new HashMap<String, Object>();
			mapResult.put("success", "true");								// 성공여부
			mapResult.put("message", "Loaded data");						// message
			
			mapResult.put("data_1st", jsonArray);							// 조회된 결과값
			mapResult.put("total_1st", pjdInfoMngBiz.selectPjdInfoCount(paramMap)); 	// 목록의 총갯수 조회
			JSONObject jsonObject = JSONObject.fromObject(mapResult);		// JSON형식으로 설정
			mav.addObject("RESULT_1ST", jsonObject);						// 조회된 결과값을 담기
			
		}catch(Exception ex){
			logger.error(ex.getMessage());
		}
		
		return mav;
	}	
	
	
	/**
	 * 프로젝트 상세정보 목록조회
	 * @param  request 
	 * @param  response
	 * @return 
	 * 2011. 4. 7.
	 */
	public ModelAndView result_edit_1st(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView();
		
		try{
			mav.setViewName("/result/result_edit_1st");	
			HashMap paramMap = WebUtil.parseRequestMap(request);   
			
			HashMap mapResult = new HashMap();
			mapResult.put("success", "true");			 				
			
			/***** paging *****/ 
			int limit = 0;
			if((String)paramMap.get("limit") != null)
				limit = Integer.parseInt((String)paramMap.get("limit"));
			int start = 0;
			if((String)paramMap.get("start") != null)
				start = Integer.parseInt((String)paramMap.get("start"));
			
			paramMap.put("limit", limit+start); 	
			
			
			/***** 목록조회 *****/ 
			List result_edit_1st = pjdInfoMngBiz.selectPjdDevInfoNitem(paramMap);		
		
			JSONArray jsonArray = new JSONArray();
			jsonArray = JSONArray.fromObject(result_edit_1st);		
			
			mapResult.put("data_edit_1st", jsonArray);
			mapResult.put("total_edit_1st", pjdInfoMngBiz.selectPjdDevInfoNitemCount(paramMap));
			
			JSONObject jsonObject = JSONObject.fromObject(mapResult);	 
			mav.addObject("RESULT_EDIT_1ST", jsonObject);	

		}catch(Exception ex){
			logger.error(ex.getMessage());
		}
		
		return mav;
	}
	
	/**
	 * 개발장비  목록조회
	 * @param  request 
	 * @param  response
	 * @return 
	 * 2011. 4. 7.
	 */
	public ModelAndView result_edit_2nd(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView();
		
		try{
			mav.setViewName("/result/result_edit_2nd");	
			HashMap paramMap = WebUtil.parseRequestMap(request);   
			
			// 공통코드 조회
			List equip_type_code = sgisCodeBiz.selectComboCode("EQUIP_TYPE_CODE");	// 장비구분코드
			mav.addObject("EQUIP_TYPE_CODE", equip_type_code);
			
			HashMap mapResult = new HashMap();
			mapResult.put("success", "true");			 				

			/***** paging *****/ 
			int limit = 0;
			if((String)paramMap.get("limit") != null)
				limit = Integer.parseInt((String)paramMap.get("limit"));
			int start = 0;
			if((String)paramMap.get("start") != null)
				start = Integer.parseInt((String)paramMap.get("start"));
			
			paramMap.put("limit", limit+start); 			
			
			/***** 목록조회 *****/
			List result_edit_2nd = pjdInfoMngBiz.selectPjdEquipInfo(paramMap);		
		
			JSONArray jsonArray = new JSONArray();
			jsonArray = JSONArray.fromObject(result_edit_2nd);		
			
			mapResult.put("data_edit_2nd", jsonArray);
			mapResult.put("total_edit_2nd", pjdInfoMngBiz.selectPjdEquipInfoCount(paramMap));
			
			JSONObject jsonObject = JSONObject.fromObject(mapResult);	 
			mav.addObject("RESULT_EDIT_2ND", jsonObject);	

		}catch(Exception ex){
			logger.error(ex.getMessage());
		}
		
		return mav;
	}	
	


	/**
	 * 신규 등록 또는 수정 처리
	 */	
	public ModelAndView actionPjtInfoMng(HttpServletRequest request, HttpServletResponse response)throws Exception{
		
		ModelAndView mav = new ModelAndView(); 
		HashMap<String,Object> mapResult = new HashMap();
		JSONArray jsonArray = new JSONArray();
		JSONObject jsonObject = new JSONObject();
		
		try {
			mav = new ModelAndView();
			mav.setViewName("/result/result_1st");
			
			/***** 조회조건 및 parameter설정 *****/
			HashMap paramMap = WebUtil.parseRequestMap(request);  
			
			
			/***** session 정보 *****/
			HashMap adminMap = (HashMap)request.getSession().getAttribute(SGConfigManager.getString("common.session.admin.name"));

			mav.addObject("admin_id",(String)adminMap.get("ADMIN_ID"));
		    mav.addObject("admin_nm",(String)adminMap.get("ADMIN_NM"));
		    mav.addObject("sabun",(String)adminMap.get("SABUN"));
		    mav.addObject("dept_code",pjtManageBiz.getDeptCode((String)adminMap.get("SABUN")));
		    mav.addObject("dept_nm", pjtManageBiz.getDeptNm(pjtManageBiz.getDeptCode((String)adminMap.get("SABUN"))));
		    
			paramMap.put("final_mod_id", (String)adminMap.get("SABUN"));	// 로그인 ID
			
			/***** 저장 및 수정 *****/			
			boolean actionPjtInfoResult = pjdInfoMngBiz.actionPjtInfoMng(paramMap, request);

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

			/***** 목록조회 *****/
			List result = pjdInfoMngBiz.selectPjdInfo(paramMap);						 
			
			/***** 조회된 결과를 JSON형식으로 screen에 Return *****/
			
			jsonArray = JSONArray.fromObject(result); 			
			mapResult.put("success", "true");							// 성공여부
			mapResult.put("message", "Loaded data");					// message
			mapResult.put("data_1st", jsonArray);						// 조회된 결과값
			mapResult.put("total_1st", pjdInfoMngBiz.selectPjdInfoCount(paramMap));	// 목록의 총갯수 조회
			jsonObject = JSONObject.fromObject(mapResult);		
			mav.addObject("RESULT_1ST", jsonObject);						// 조회된 결과값을 담기
			
		}catch (Exception e){
			mapResult.put("success", "false");								// 성공여부
			mapResult.put("message", e.toString());							// message
			logger.error(e, e);
		}finally{
			
		}
			return mav;
	}			
	
	
	
	/**
	 * 프로젝트 팝업
	 */	
	public ModelAndView pjtInfoPop(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = null;
		
		try {
			mav = new ModelAndView();

			// 공통코드 조회
			List issue_type_code = sgisCodeBiz.selectComboCode("PJT_TYPE_CODE");	// 프로젝트구분코드
			mav.addObject("PJT_TYPE_CODE", issue_type_code);						// 프로젝트구분코드
			
			
		} catch (Exception e) {
			logger.error(e, e);
		}
		return mav;
	}

	
	/**
	 * 프로젝트정보관리  팝업
	 * @param  request 
	 * @param  response
	 * @return mav	   
	 * 2011. 4. 11.
	 * @throws Exception 
	 */
	public ModelAndView pjtInfoPopList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ModelAndView mav = null;
		
		try{
			mav = new ModelAndView();
			mav.setViewName("/result/result_1st");	
			HashMap paramMap = WebUtil.parseRequestMap(request); 

			// 공통코드 조회
			List issue_type_code = sgisCodeBiz.selectComboCode("PJT_TYPE_CODE");	// 프로젝트구분코드
			mav.addObject("PJT_TYPE_CODE", issue_type_code);						// 프로젝트구분코드
			
			/***** paging *****/ 
			int limit = 0;
			if((String)paramMap.get("limit") != null)
				limit = Integer.parseInt((String)paramMap.get("limit"));
			int start = 0;
			if((String)paramMap.get("start") != null)
				start = Integer.parseInt((String)paramMap.get("start"));
			
			paramMap.put("limit", limit+start); 
			
			
			
			/***** 목록조회 *****/
			List result = pjdInfoMngBiz.selectPjdInfoPop(paramMap);						// DB에서 목록조회
			
			/***** 조회된 결과를 JSON형식으로 screen에 Return *****/
			JSONArray jsonArray = JSONArray.fromObject(result);
			HashMap<String,Object> mapResult = new HashMap<String, Object>();
			mapResult.put("success", "true");										// 성공여부
			mapResult.put("message", "Loaded data");								// message
			
			mapResult.put("data_1st_pop", jsonArray);								// 조회된 결과값
			mapResult.put("total_1st_pop", pjdInfoMngBiz.selectPjdInfoPopCount(paramMap));// 목록의 총갯수 조회
			JSONObject jsonObject = JSONObject.fromObject(mapResult);				// JSON형식으로 설정
			mav.addObject("RESULT_1ST", jsonObject);								// 조회된 결과값을 담기
			
			
		}catch(Exception ex){
			logger.error(ex.getMessage());
		}
		
		return mav;
	}		

	
	/**
	 * 프로젝트 팝업,제품
	 */
	public ModelAndView pjtInfoNitemPop(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = null;
		
		try {
			mav = new ModelAndView();

			// 공통코드 조회
			List issue_type_code = sgisCodeBiz.selectComboCode("PJT_TYPE_CODE");	// 프로젝트구분코드
			mav.addObject("PJT_TYPE_CODE", issue_type_code);						// 프로젝트구분코드
			
			
		} catch (Exception e) {
			logger.error(e, e);
		}
		return mav;
	}	
	
	/**
	 * 개발프로젝트정보별 제품 팝업
	 * @param  request 
	 * @param  response
	 * @return mav	   
	 * 2011. 4. 11.
	 * @throws Exception 
	 */
	public ModelAndView pjtInfoNitemPopList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ModelAndView mav = null;
		
		try{
			mav = new ModelAndView();
			mav.setViewName("/result/result_1st");	
			HashMap paramMap = WebUtil.parseRequestMap(request); 

			// 공통코드 조회
			List issue_type_code = sgisCodeBiz.selectComboCode("PJT_TYPE_CODE");	// 프로젝트구분코드
			mav.addObject("PJT_TYPE_CODE", issue_type_code);						// 프로젝트구분코드
			
			/***** paging *****/ 
			int limit = 0;
			if((String)paramMap.get("limit") != null)
				limit = Integer.parseInt((String)paramMap.get("limit"));
			int start = 0;
			if((String)paramMap.get("start") != null)
				start = Integer.parseInt((String)paramMap.get("start"));
			
			paramMap.put("limit", limit+start); 
			
			
			/***** 목록조회 *****/
			HashMap adminMap = (HashMap)request.getSession().getAttribute(SGConfigManager.getString("common.session.admin.name"));
			
			String emp_num   =(String)adminMap.get("ADMIN_ID");
			String dept_code = pjtManageBiz.getDeptCode((String)adminMap.get("SABUN"));
			String groups	 = (String)adminMap.get("GROUPS");
			
			String getAuthority = pjtManageBiz.getAuthority(emp_num);				 	

			   
			List result = pjdInfoMngBiz.selectPjdInfoNitemPop(paramMap);						// DB에서 목록조회
			
			/***** 조회된 결과를 JSON형식으로 screen에 Return *****/
			JSONArray jsonArray = JSONArray.fromObject(result);
			HashMap<String,Object> mapResult = new HashMap<String, Object>();
			mapResult.put("success", "true");										// 성공여부
			mapResult.put("message", "Loaded data");								// message
			
			mapResult.put("data_1st_pop", jsonArray);								// 조회된 결과값
			mapResult.put("total_1st_pop", pjdInfoMngBiz.selectPjdInfoNitemPopCount(paramMap));// 목록의 총갯수 조회
			JSONObject jsonObject = JSONObject.fromObject(mapResult);				// JSON형식으로 설정
			mav.addObject("RESULT_1ST", jsonObject);								// 조회된 결과값을 담기
			
			
		}catch(Exception ex){
			logger.error(ex.getMessage());
		}
		
		return mav;
	}	
	
	
	/**
	 * 개발프로젝트관리 삭제
	 */
	public ModelAndView deletePjdDevInfo(HttpServletRequest request, HttpServletResponse response) {
		
		ModelAndView mav = new ModelAndView();
		HashMap<String,Object> mapResult = new HashMap<String, Object>();
		
		try {
			mav = new ModelAndView();
			mav.setViewName("/result/result_edit_1st");	

			/***** 조회조건 및 parameter설정 *****/
			HashMap paramMap = WebUtil.parseRequestMap(request);  
			
			
			/***** session 정보 *****/
			HashMap adminMap = (HashMap)request.getSession().getAttribute(SGConfigManager.getString("common.session.admin.name"));
			paramMap.put("final_mod_id", (String)adminMap.get("SABUN"));	// 로그인 ID
			
			/***** 삭제 *****/
			
			boolean deletePjdDevInfoResult = pjdInfoMngBiz.deletePjdDevInfo(paramMap, request);			
			

			/***** paging *****/ 
			int limit = 0;
			if((String)paramMap.get("limit") != null)
				limit = Integer.parseInt((String)paramMap.get("limit"));
			int start = 0;
			if((String)paramMap.get("start") != null)
				start = Integer.parseInt((String)paramMap.get("start"));
			
			paramMap.put("limit", limit+start); 			
			
			/***** 목록조회 *****/ 
			List result_edit_1st = pjdInfoMngBiz.selectPjdDevInfoNitem(paramMap);		
		
			JSONArray jsonArray = new JSONArray();
			jsonArray = JSONArray.fromObject(result_edit_1st);		
			
			mapResult.put("data_edit_1st", jsonArray);
			mapResult.put("total_edit_1st", pjdInfoMngBiz.selectPjdDevInfoNitemCount(paramMap));
			
			JSONObject jsonObject = JSONObject.fromObject(mapResult);	 
			mav.addObject("RESULT_EDIT_1ST", jsonObject);	
			
		} catch (Exception e) {
			logger.error(e, e);
			e.printStackTrace();
		} finally{
			
		}
		
		return mav;
	}		
	
	
	/**
	 * 개발프로젝트장비관리  삭제
	 */
	public ModelAndView deletePjdEquipInfo(HttpServletRequest request, HttpServletResponse response) {
		
		ModelAndView mav = new ModelAndView();
		HashMap<String,Object> mapResult = new HashMap<String, Object>();
		
		try {
			mav = new ModelAndView();
			mav.setViewName("/result/result_edit_2nd");	

			/***** 조회조건 및 parameter설정 *****/
			HashMap paramMap = WebUtil.parseRequestMap(request);  
			
			/***** session 정보 *****/
			HashMap adminMap = (HashMap)request.getSession().getAttribute(SGConfigManager.getString("common.session.admin.name"));
			paramMap.put("final_mod_id", (String)adminMap.get("SABUN"));	// 로그인 ID
			
			/***** 삭제 *****/			
			boolean deletePjdEquipInfoResult = pjdInfoMngBiz.deletePjdEquipInfo(paramMap, request);			
			
			
			/***** paging *****/ 
			int limit = 0;
			if((String)paramMap.get("limit") != null)
				limit = Integer.parseInt((String)paramMap.get("limit"));
			int start = 0;
			if((String)paramMap.get("start") != null)
				start = Integer.parseInt((String)paramMap.get("start"));
			
			paramMap.put("limit", limit+start); 
			
			/***** 목록조회 *****/
			List result_edit_2nd = pjdInfoMngBiz.selectPjdEquipInfo(paramMap);		
		
			JSONArray jsonArray = new JSONArray();
			jsonArray = JSONArray.fromObject(result_edit_2nd);		
			
			mapResult.put("data_edit_2nd", jsonArray);
			mapResult.put("total_edit_2nd", pjdInfoMngBiz.selectPjdEquipInfoCount(paramMap));
			
			JSONObject jsonObject = JSONObject.fromObject(mapResult);	 
			mav.addObject("RESULT_EDIT_2ND", jsonObject);	
			
		} catch (Exception e) {
			logger.error(e, e);
			e.printStackTrace();
		} finally{
			
		}
		
		return mav;
	}		
	
	
}
