﻿/**
 *  Class Name  : ScdInfoMngController
 *  Description : 공정관리 Controller
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


package com.sg.sgis.dev.scdInfoMng;

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

public class ScdInfoMngController extends SGUserController{
	
	protected final Log logger = LogFactory.getLog(getClass());
	
	CommonUtil comUtil = new CommonUtil();
	
	// BIZ경로 설정
	private ScdInfoMngBiz scdInfoMngBiz;
	

	// 공통코드 BIZ경로 설정
	private SgisCodeBiz sgisCodeBiz;


	public ScdInfoMngBiz getScdInfoMngBiz() {
		return scdInfoMngBiz;
	}


	public void setScdInfoMngBiz(ScdInfoMngBiz scdInfoMngBiz) {
		this.scdInfoMngBiz = scdInfoMngBiz;
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
	public ModelAndView scdInfoMngList(HttpServletRequest request, HttpServletResponse response) {
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
	 * 개발프로젝트관리: 조회된 목록을 화면으로 retuen
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
			
			HashMap adminMap = (HashMap)request.getSession().getAttribute(SGConfigManager.getString("common.session.admin.name"));
			
			String emp_num   =(String)adminMap.get("ADMIN_ID");
			String dept_code = pjtManageBiz.getDeptCode((String)adminMap.get("SABUN"));
			String groups	 = (String)adminMap.get("GROUPS");
			 
			
			/***** DB에서 목록조회 *****/
			List result = scdInfoMngBiz.selectScdPjdInfo(paramMap);			
			
			/***** 조회된 결과를 JSON형식으로 screen에 Return *****/
			JSONArray jsonArray = JSONArray.fromObject(result);
			HashMap<String,Object> mapResult = new HashMap<String, Object>();
			mapResult.put("success", "true");								// 성공여부
			mapResult.put("message", "Loaded data");						// message
			
			mapResult.put("data_1st", jsonArray);							// 조회된 결과값
			mapResult.put("total_1st", scdInfoMngBiz.selectScdPjdInfoCount(paramMap)); 	// 목록의 총갯수 조회
			JSONObject jsonObject = JSONObject.fromObject(mapResult);		// JSON형식으로 설정
			mav.addObject("RESULT_1ST", jsonObject);						// 조회된 결과값을 담기
			
		}catch(Exception ex){
			logger.error(ex.getMessage());
		}
		
		return mav;
	}	
	
	/**
	 * 타스크 정보  목록조회
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
			
			/***** paging *****/ 
			int limit = 0;
			if((String)map.get("limit") != null)
				limit = Integer.parseInt((String)map.get("limit"));
			int start = 0;
			if((String)map.get("start") != null)
				start = Integer.parseInt((String)map.get("start"));
			
			map.put("limit", limit+start); 	
			
			
			/***** 목록조회 *****/ 
			List result_edit_1st = scdInfoMngBiz.selectScdPlanInfo(map);		
		
			JSONArray jsonArray = new JSONArray();
			jsonArray = JSONArray.fromObject(result_edit_1st);		
			
			mapResult.put("data_edit_1st", jsonArray);
			mapResult.put("total_edit_1st", scdInfoMngBiz.selectScdPlanInfoCount(map));
			
			JSONObject jsonObject = JSONObject.fromObject(mapResult);	 
			mav.addObject("RESULT_EDIT_1ST", jsonObject);	

		}catch(Exception ex){
			logger.error(ex.getMessage());
		}
		
		return mav;
	}
	
	
	/**
	 * 타스크 담당자  목록조회
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

			/***** paging *****/ 
			int limit = 0;
			if((String)map.get("limit") != null)
				limit = Integer.parseInt((String)map.get("limit"));
			int start = 0;
			if((String)map.get("start") != null)
				start = Integer.parseInt((String)map.get("start"));
			
			map.put("limit", limit+start); 			
			
			/***** 목록조회 *****/
			List result_edit_2nd = scdInfoMngBiz.selectScdDutyAssign(map);		
		
			JSONArray jsonArray = new JSONArray();
			jsonArray = JSONArray.fromObject(result_edit_2nd);		
			
			mapResult.put("data_edit_2nd", jsonArray);
			mapResult.put("total_edit_2nd", scdInfoMngBiz.selectScdDutyAssignCount(map));
			
			JSONObject jsonObject = JSONObject.fromObject(mapResult);	 
			mav.addObject("RESULT_EDIT_2ND", jsonObject);	

		}catch(Exception ex){
			logger.error(ex.getMessage());
		}
		
		return mav;
	}		


	/**
	 * 타스크 삭제
	 * @param  request 
	 * @param  response
	 * @return 
	 * 2011. 4. 7.
	 */
	public ModelAndView deleteScdPlanInfo(HttpServletRequest request, HttpServletResponse response) {
		
		ModelAndView mav = new ModelAndView();
		HashMap<String,Object> mapResult = new HashMap<String, Object>();
		JSONArray jsonArray = new JSONArray();
		JSONObject jsonObject = new JSONObject();
		
		try {
			mav = new ModelAndView();
			mav.setViewName("/result/result_edit_1st");	

			/***** 조회조건 및 parameter설정 *****/
			HashMap map = WebUtil.parseRequestMap(request);  
			
			/***** session 정보 *****/
			HashMap adminMap = (HashMap)request.getSession().getAttribute(SGConfigManager.getString("common.session.admin.name"));
			map.put("final_mod_id", (String)adminMap.get("SABUN"));	// 로그인 ID
			map.put("reg_id", (String)adminMap.get("SABUN"));	// 로그인 ID
			
			
			/***** 일정관리에 등록된 타스크수 *****/
			int scdDayInfoTaskCnt = 0;
			scdDayInfoTaskCnt = scdInfoMngBiz.selectScdDayInfoTaskCnt(map);
			
			if(scdDayInfoTaskCnt > 0)
			{
				mapResult.put("success", "false");	
				mapResult.put("message", "이미 담당자가 일정을 등록했습니다.");	
				
			}else
			{				/***** 삭제 *****/
					boolean deleteScdPlanInfoResult = scdInfoMngBiz.deleteScdPlanInfo(map, request);	
					mapResult.put("success", "true");							// 성공여부
					mapResult.put("message", "Loaded data");					// message
			}

			
			/***** paging *****/ 
			int limit = 0;
			if((String)map.get("limit") != null)
				limit = Integer.parseInt((String)map.get("limit"));
			int start = 0;
			if((String)map.get("start") != null)
				start = Integer.parseInt((String)map.get("start"));
			
			map.put("limit", limit+start); 			
			
			/***** 목록조회 *****/
			List result = scdInfoMngBiz.selectScdPlanInfo(map);						 
			
			
			/***** 조회된 결과를 JSON형식으로 screen에 Return *****/			
			jsonArray = JSONArray.fromObject(result); 			
			mapResult.put("data_edit_1st", jsonArray);						// 조회된 결과값
			mapResult.put("total_edit_1st", scdInfoMngBiz.selectScdPlanInfoCount(map));	// 목록의 총갯수 조회
			
			mapResult.put("searchScdPlanSeq", (String)map.get("scd_plan_seq"));	// 타스크담당자 정보를 위한 정보
			
			jsonObject = JSONObject.fromObject(mapResult);					
			mav.addObject("RESULT_EDIT_1ST", jsonObject);						// 조회된 결과값을 담기

		} catch (Exception e) {
			logger.error(e, e);
			e.printStackTrace();
		} finally{
			
		}
		
		return mav;
	}		
	
	
	/**
	 * 타스크담당자정보 [일정별담당자배정]   삭제
	 */	
	public ModelAndView deleteScdDutyAssign(HttpServletRequest request, HttpServletResponse response) {
		
		ModelAndView mav = new ModelAndView();
		HashMap<String,Object> mapResult = new HashMap<String, Object>();
		JSONArray jsonArray = new JSONArray();
		JSONObject jsonObject = new JSONObject();
		
		try {
			mav = new ModelAndView();
			mav.setViewName("/result/result_edit_2nd");	

			/***** 조회조건 및 parameter설정 *****/
			HashMap map = WebUtil.parseRequestMap(request);  
			
			/***** session 정보 *****/
			HashMap adminMap = (HashMap)request.getSession().getAttribute(SGConfigManager.getString("common.session.admin.name"));
			map.put("final_mod_id", (String)adminMap.get("SABUN"));	// 로그인 ID
			map.put("reg_id", (String)adminMap.get("SABUN"));	// 로그인 ID
			
			/***** 삭제 *****/
			map.put("scd_plan_seq", "");	//개별삭제를 위해
			
			
			/***** 일정관리에 등록된 담당자수 *****/
			int scdDayInfoRegEmpCnt = 0;
			scdDayInfoRegEmpCnt = scdInfoMngBiz.selectScdDayInfoRegEmpCnt(map);
			
			if(scdDayInfoRegEmpCnt > 0)
			{
				mapResult.put("success", "false");	
				mapResult.put("message", "이미 담당자가 일정을 등록했습니다.");	
				
			}else
			{				
				boolean deletePjdEquipInfoResult = scdInfoMngBiz.deleteScdDutyAssign(map, request);			

				mapResult.put("success", "true");							// 성공여부
				mapResult.put("message", "Loaded data");					// message
			}			
			
			
			/***** paging *****/ 
			int limit = 0;
			if((String)map.get("limit") != null)
				limit = Integer.parseInt((String)map.get("limit"));
			int start = 0;
			if((String)map.get("start") != null)
				start = Integer.parseInt((String)map.get("start"));
			
			map.put("limit", limit+start); 
			
			/***** 목록조회 *****/
			map.put("scd_plan_seq", (String)map.get("searchScdPlanSeq"));	
			
			List result = scdInfoMngBiz.selectScdDutyAssign(map);						 
			
			
			/***** 조회된 결과를 JSON형식으로 screen에 Return *****/			
			jsonArray = JSONArray.fromObject(result); 			
			mapResult.put("data_edit_2nd", jsonArray);						// 조회된 결과값
			mapResult.put("total_edit_2nd", scdInfoMngBiz.selectScdDutyAssignCount(map));	// 목록의 총갯수 조회
			
			mapResult.put("searchPjtId", (String)map.get("searchPjtId"));	// 삭제후 타스크정보 조회를 위한 프로젝트아이디
			
			jsonObject = JSONObject.fromObject(mapResult);			
			mav.addObject("RESULT_EDIT_2ND", jsonObject);						// 조회된 결과값을 담기

		} catch (Exception e) {
			logger.error(e, e);
			e.printStackTrace();
		} finally{
			
		}
		
		return mav;
	}		
	
	
	 
	/**
	 * 신규 등록 또는 수정 처리
	 */	
	public ModelAndView actionScdInfoMng(HttpServletRequest request, HttpServletResponse response)throws Exception{
		
		ModelAndView mav = new ModelAndView(); 
		try {

			
			/***** 조회조건 및 parameter설정 *****/
			HashMap map = WebUtil.parseRequestMap(request);  
			
			
			/***** session 정보 *****/
			HashMap adminMap = (HashMap)request.getSession().getAttribute(SGConfigManager.getString("common.session.admin.name"));
			map.put("final_mod_id", (String)adminMap.get("SABUN"));	// 로그인 ID
			map.put("reg_id", (String)adminMap.get("SABUN"));	// 로그인 ID
			
			/***** 저장 및 수정 *****/			
			
			mav = scdInfoMngBiz.actionScdInfoMng(map, request);

			
		}catch (Exception e){			
			logger.error(e, e);
		}finally{
			
		}
			return mav;
	}		
	
	
	
}
