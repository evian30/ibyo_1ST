/**
 *  Class Name  : PjtManageController.java
 *  Description :  프로젝트정보관리 Controller
 *  Modification Information
 *
 *  수정일                   수정자               수정내용
 *  -------      --------   ---------------------------
 *  2011. 03. 08.    여인범              최초 생성
 *
 *  @author 여인범
 *  @since 2011. 03. 08.
 *  @version 1.0
 *  @see 
 * 
 *  Copyright (C) 2011 by SG All right reserved.
 */
package com.sg.sgis.pjt.pjtManage;

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
import com.sg.sgis.pur.PurchaseBiz;
import com.sg.sgis.util.CommonUtil;
import com.signgate.core.config.SGConfigManager;
import com.signgate.core.web.controller.SGUserController; 
import com.signgate.core.web.util.WebUtil;

public class PjtManageController extends SGUserController{

	protected final Log logger = LogFactory.getLog(getClass()); 
	 
	private PjtManageBiz pjtManageBiz; 
	public void setPjtManageBiz(PjtManageBiz pjtManageBiz){
		this.pjtManageBiz = pjtManageBiz;
	} 
	 
	//공통코드 BIZ
	private SgisCodeBiz sgisCodeBiz; 
	public void setSgisCodeBiz(SgisCodeBiz sgisCodeBiz){
		this.sgisCodeBiz = sgisCodeBiz;
	}
	
	//부서관리 BIZ
	private DeptBiz deptBiz; 
	public void setDeptBiz(DeptBiz deptBiz){
		this.deptBiz = deptBiz;
	}
	
	
	private PurchaseBiz purBiz;
	public void setPurBiz(PurchaseBiz purBiz) {
		this.purBiz = purBiz;
	}
	
	CommonUtil comUtil = new CommonUtil();
	
	public ModelAndView pjtManageList(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = null;
		
		try {
			mav = new ModelAndView();  
			HashMap paramMap = WebUtil.parseRequestMap(request); 
			
				List PJT_TYPE_CODE = sgisCodeBiz.selectComboCode("PJT_TYPE_CODE");					//사업구분
					 mav.addObject("PJT_TYPE_CODE", PJT_TYPE_CODE);	 
				List PAY_FREE_CODE = sgisCodeBiz.selectComboCode("PAY_FREE_CODE");					//유상무상 구분
					 mav.addObject("PAY_FREE_CODE", PAY_FREE_CODE);	 
				List PJT_STATUS_CODE = sgisCodeBiz.selectComboCode("PJT_STATUS");					//진행상태코드
					 mav.addObject("PJT_STATUS_CODE", PJT_STATUS_CODE); 
				List COM_CUSTOM_PATTERN_NM = sgisCodeBiz.selectComboCode("CUSTOM_PATTERN_CODE");	//거래처 유형	
					 mav.addObject("COM_CUSTOM_PATTERN_NM", COM_CUSTOM_PATTERN_NM);  
					 
				HashMap adminMap = (HashMap)request.getSession().getAttribute(SGConfigManager.getString("common.session.admin.name"));
						mav.addObject("admin_id",(String)adminMap.get("ADMIN_ID"));
						mav.addObject("admin_nm",(String)adminMap.get("ADMIN_NM"));
						mav.addObject("sabun",(String)adminMap.get("SABUN"));
						mav.addObject("dept_code",pjtManageBiz.getDeptCode((String)adminMap.get("SABUN")));
						mav.addObject("dept_nm", pjtManageBiz.getDeptNm(pjtManageBiz.getDeptCode((String)adminMap.get("SABUN"))));
				
				String getPjtType = "";
				String src_pjt_type_code = "10";
				
				if(src_pjt_type_code.equals("10")){
					getPjtType = "PJT";
				}else if(src_pjt_type_code.equals("22")){
					getPjtType = "PJD";
				}else if(src_pjt_type_code.equals("30")){
					getPjtType = "PJM";
				}else if(src_pjt_type_code.equals("40")){
					getPjtType = "PJI";
				}
				
				paramMap.put("src_pjt_type_code", src_pjt_type_code);
				paramMap.put("getPjtType", getPjtType);  
				
				mav.addObject("new_pjt_id", pjtManageBiz.selectPjtID(paramMap));
				
				if(paramMap.get("totMng").equals("all")){
					mav.setViewName("/pjt/allPJTManageList");
				}else{
					mav.setViewName("/pjt/pjtManage/pjtManageList");
				}
				
		} catch (Exception e) {
			logger.error(e, e);
			
		}
		return mav;
	}
	
	
	public ModelAndView pjtStatusManage(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = null;
		
		try {
			mav = new ModelAndView(); 
				  
				mav.setViewName("/pjt/pjtManage/pjtStatusManage");
			
				List PJT_TYPE_CODE = sgisCodeBiz.selectComboCode("PJT_TYPE_CODE");				//사업구분
					 mav.addObject("PJT_TYPE_CODE", PJT_TYPE_CODE);	 
				List PAY_FREE_CODE = sgisCodeBiz.selectComboCode("PAY_FREE_CODE");					//유상무상 구분
					 mav.addObject("PAY_FREE_CODE", PAY_FREE_CODE);	 
				List PJT_STATUS_CODE = sgisCodeBiz.selectComboCode("PJT_STATUS");					//진행상태코드
					 mav.addObject("PJT_STATUS_CODE", PJT_STATUS_CODE); 
				List COM_CUSTOM_PATTERN_NM = sgisCodeBiz.selectComboCode("CUSTOM_PATTERN_CODE");	//거래처 유형	
					 mav.addObject("COM_CUSTOM_PATTERN_NM", COM_CUSTOM_PATTERN_NM); 
					 	 
					 
				HashMap paramMap = WebUtil.parseRequestMap(request);  		
				HashMap adminMap = (HashMap)request.getSession().getAttribute(SGConfigManager.getString("common.session.admin.name"));
				
				mav.addObject("admin_id",(String)adminMap.get("ADMIN_ID"));
				mav.addObject("admin_nm",(String)adminMap.get("ADMIN_NM"));
				mav.addObject("sabun",(String)adminMap.get("SABUN"));
				mav.addObject("dept_code",pjtManageBiz.getDeptCode((String)adminMap.get("SABUN")));
				mav.addObject("dept_nm", pjtManageBiz.getDeptNm(pjtManageBiz.getDeptCode((String)adminMap.get("SABUN"))));  
				
				
		} catch (Exception e) {
			logger.error(e, e);
			
		}
		return mav;
	} 
 
	@SuppressWarnings("unchecked")
	public ModelAndView result_1st(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = null;
		
		try{
			HashMap paramMap = WebUtil.parseRequestMap(request); 
			HashMap mapResult = new HashMap();
			
			mav = new ModelAndView();
			mav.setViewName("/result/result_1st"); 
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
			
			/*보기권한 임원-전체, 팀장-팀의데이터, 팀원-본인데이터  by ibyo:2011.06.08*/
			String getAuthority = pjtManageBiz.getAuthority(emp_num);				 	
			if(getAuthority.equals("사장") || getAuthority.equals("본부장") || getAuthority.equals("연구소장")){
				paramMap.put("session_dept_code", "");
			}else if(getAuthority.equals("팀장") || getAuthority.equals("팀장대행")){
				paramMap.put("session_dept_code", dept_code);
			}else if(getAuthority.equals("팀원")){
				paramMap.put("reg_id", emp_num);
			}
			 
			
			List result = pjtManageBiz.selectPjtManage(paramMap);	 					//목록 조회		
			 
			JSONArray jsonArray = JSONArray.fromObject(result);
			
			mapResult.put("success", "true");											// 성공여부
			mapResult.put("message", "Loaded data");									// message
			
			mapResult.put("data_1st", jsonArray);										// 조회된 결과값
			mapResult.put("total_1st", pjtManageBiz.selectPjtManageCount(paramMap)); 	// 목록의 총갯수 조회
			JSONObject jsonObject = JSONObject.fromObject(mapResult);					// JSON형식으로 설정
			mav.addObject("RESULT_1ST", jsonObject);									// 조회된 결과값을 담기
			 
		
		}catch(Exception ex){
			logger.error(ex.getMessage());
		}
		
		return mav;
	}
	   
	
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
			 
			List result_edit_1st = pjtManageBiz.selectPjtCustom(map);		
		
			JSONArray jsonArray = new JSONArray();
			jsonArray = JSONArray.fromObject(result_edit_1st);		
			
			mapResult.put("data_edit_1st", jsonArray);
			mapResult.put("total_edit_1st", pjtManageBiz.selectPjtCustomCount(map));
			
			JSONObject jsonObject = JSONObject.fromObject(mapResult);	 
			mav.addObject("RESULT_EDIT_1ST", jsonObject);	

		}catch(Exception ex){
			logger.error(ex.getMessage());
		}
		
		return mav;
	}
	
	
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
			 
			List result_edit_2nd = pjtManageBiz.selectPjtItem(map);		
		
			JSONArray jsonArray = new JSONArray();
			jsonArray = JSONArray.fromObject(result_edit_2nd);		
			
			mapResult.put("data_edit_2nd", jsonArray);
			mapResult.put("total_edit_2nd", pjtManageBiz.selectPjtItemCount(map));
			
			JSONObject jsonObject = JSONObject.fromObject(mapResult);	 
			mav.addObject("RESULT_EDIT_2ND", jsonObject);	

		}catch(Exception ex){
			logger.error(ex.getMessage());
		}
		
		return mav;
	}
	
	@SuppressWarnings("unchecked")
	public ModelAndView result_edit_3rd(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = null;
		
		try{
			HashMap paramMap = WebUtil.parseRequestMap(request); 
			HashMap mapResult = new HashMap();
			
			mav = new ModelAndView();
			mav.setViewName("/result/result_edit_3rd"); 
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
			
			/*보기권한 임원-전체, 팀장-팀의데이터, 팀원-본인데이터  by ibyo:2011.06.08*/
			String getAuthority = pjtManageBiz.getAuthority(emp_num);				 	
			if(getAuthority.equals("사장") || getAuthority.equals("본부장") || getAuthority.equals("연구소장")){
				paramMap.put("session_dept_code", "");
			}else if(getAuthority.equals("팀장") || getAuthority.equals("팀장대행")){
				paramMap.put("session_dept_code", dept_code);
			}else if(getAuthority.equals("팀원")){
				paramMap.put("reg_id", emp_num);
			}
			
			
			 
			List result = pjtManageBiz.selectPjtManage(paramMap);	 						//목록 조회
			
			JSONArray jsonArray = JSONArray.fromObject(result);
			
			mapResult.put("success", "true");												// 성공여부
			mapResult.put("message", "Loaded data");										// message
			
			mapResult.put("data_edit_3rd", jsonArray);										// 조회된 결과값
			mapResult.put("total_edit_3rd", pjtManageBiz.selectPjtManageCount(paramMap)); 	// 목록의 총갯수 조회
			JSONObject jsonObject = JSONObject.fromObject(mapResult);						// JSON형식으로 설정
			mav.addObject("RESULT_EDIT_3RD", jsonObject);									// 조회된 결과값을 담기
			 
		}catch(Exception ex){
			logger.error(ex.getMessage());
		}
		
		return mav;
	}
 
	
	public ModelAndView actionPjtManage(HttpServletRequest request, HttpServletResponse response)throws Exception{

		ModelAndView mav = new ModelAndView();
		JSONObject jsonObject = new JSONObject();
		HashMap mapResult = new HashMap();
		String man_total="";
		String man_data="";
		String man_result="";
		
		try {
			mav = new ModelAndView();
			
			HashMap paramMap = WebUtil.parseRequestMap(request);  		
			HashMap adminMap = (HashMap)request.getSession().getAttribute(SGConfigManager.getString("common.session.admin.name"));
					paramMap.put("admin_id", (String)adminMap.get("ADMIN_ID"));
					paramMap.put("groups", (String)adminMap.get("GROUPS"));
					paramMap.put("emp_num", (String)adminMap.get("SABUN"));  
	 
			boolean check = false;
		 
			
			//기본정보를 입력 수정 할 것인지, 진행상태, 계약여부만 수정 할것인지 
			if("base".equals(paramMap.get("pjtManType"))){
				 
				 mav.setViewName("/result/result_1st");	
				 
				 check = pjtManageBiz.actionPjtManage(paramMap, request);
				
				 man_total="total_1st";
				 man_data="data_1st";
				 man_result="RESULT_1ST";
				 
			}else if("status".equals(paramMap.get("pjtManType"))){
				 mav.setViewName("/result/result_edit_3rd");	
				 
				 check = pjtManageBiz.actionPjtStatusManage(paramMap, request);
				
				 man_total="total_edit_3rd";
				 man_data="data_edit_3rd";
				 man_result="RESULT_EDIT_3RD";
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
			
			
			List result = pjtManageBiz.selectPjtManage(paramMap);						// DB에서 목록조회

			JSONArray jsonArray = JSONArray.fromObject(result);

			// 조회된 결과 및 message
			if("".equals(check)){
				mapResult.put("success", "true");										// 성공 
			}else{
				mapResult.put("success", "false");										// 실패 
			}
			
			
			String getPjtType = "";
			String src_pjt_type_code =  "10";
			
			if(src_pjt_type_code.equals("10")){
				getPjtType = "PJT";
			}else if(src_pjt_type_code.equals("22")){
				getPjtType = "PJD";
			}else if(src_pjt_type_code.equals("30")){
				getPjtType = "PJM";
			}else if(src_pjt_type_code.equals("40")){
				getPjtType = "PJI";
			}
			
			paramMap.put("src_pjt_type_code", src_pjt_type_code);
			paramMap.put("getPjtType", getPjtType);  
			
			mapResult.put("new_pjt_id", pjtManageBiz.selectPjtID(paramMap)); 
			
			   
			mapResult.put(man_total, pjtManageBiz.selectPjtManageCount(paramMap));		
			mapResult.put(man_data, jsonArray);										// 조회된 결과값
			jsonObject = JSONObject.fromObject(mapResult);								// JSON형식으로 설정

		}catch (Exception e){
			mapResult.put("success", "false");											// 성공여부
			mapResult.put("message", e.toString());										// message
			logger.error(e, e);
		}finally{

		}
		mav.addObject(man_result, jsonObject);										// 조회된 결과값을 담기
		return mav;
	}
	
	
	public ModelAndView pjtInfoPop(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = null;
		
		try {
			HashMap map = WebUtil.parseRequestMap(request);  	
			mav = new ModelAndView();

			// 공통코드 조회
			List PJT_TYPE_CODE = sgisCodeBiz.selectComboCode("PJT_TYPE_CODE");	 
			mav.addObject("PJT_TYPE_CODE", PJT_TYPE_CODE);
			
			mav.addObject("src_pjt_type_code", (String)map.get("src_pjt_type_code"));
			
		} catch (Exception e) {
			logger.error(e, e);
		}
		return mav;
	} 
	 	
	 
	public ModelAndView pjtInfoPopList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ModelAndView mav = null;
		
		try{
			mav = new ModelAndView();
			mav.setViewName("/result/result_1st");	
			HashMap map = WebUtil.parseRequestMap(request);  
			
			map.put("src_pjt_type_code", (String)map.get("src_pjt_type_code")); 
			
			/***** paging *****/ 
			int limit = 0;
			if((String)map.get("limit") != null)
				limit = Integer.parseInt((String)map.get("limit"));
			int start = 0;
			if((String)map.get("start") != null)
				start = Integer.parseInt((String)map.get("start"));
			map.put("limit", limit+start); 
			
			
			HashMap adminMap = (HashMap)request.getSession().getAttribute(SGConfigManager.getString("common.session.admin.name"));
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
				if(
					!"30000".equals(dept_code) &&     //기술연구소     
					!"30001".equals(dept_code) &&     //기술지원팀     
					!"30002".equals(dept_code) &&     //융합보안팀     
					!"30003".equals(dept_code) &&     //솔루션개발팀    
					!"30004".equals(dept_code) &&     //웹서비스팀     
					!"30005".equals(dept_code) &&     //데이터센터     
					!"30010".equals(dept_code) &&     //전략기술단     
					!"30011".equals(dept_code)        //R&D팀  
					){
					map.put("reg_id", emp_num);
				}else{
					map.put("session_dept_code", dept_code);
				}
				
			}
					
			/***** 목록조회 *****/
			List result = pjtManageBiz.selectPjtManage(map);						
			
			/***** 조회된 결과를 JSON형식으로 screen에 Return *****/
			JSONArray jsonArray = JSONArray.fromObject(result);
			HashMap mapResult = new HashMap();
			mapResult.put("success", "true");										
			mapResult.put("message", "Loaded data");								
			
			mapResult.put("data_1st_pop", jsonArray);								
			mapResult.put("total_1st_pop", pjtManageBiz.selectPjtManageCount(map));
			JSONObject jsonObject = JSONObject.fromObject(mapResult);				
			mav.addObject("RESULT_1ST", jsonObject);								
			 
			
		}catch(Exception ex){
			logger.error(ex.getMessage());
		}
		
		return mav;
	}		
	
	
	
	public ModelAndView pjtStatusHISPop(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = null;
		
		try {
			HashMap map = WebUtil.parseRequestMap(request);  	
			mav = new ModelAndView();
			 
		} catch (Exception e) {
			logger.error(e, e);
		}
		return mav;
	} 
	 	
	 
	public ModelAndView pjtStatusListHIS(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ModelAndView mav = null;
		
		try{
			mav = new ModelAndView();
			mav.setViewName("/result/result_1st");	
			HashMap map = WebUtil.parseRequestMap(request); 
    		
			int limit = 0;
			if((String)map.get("limit") != null)
				limit = Integer.parseInt((String)map.get("limit"));
			int start = 0;
			if((String)map.get("start") != null)
				start = Integer.parseInt((String)map.get("start"));
			
			map.put("limit", limit+start); 
			map.put("grd_pjt_id", map.get("grd_pjt_id")); 
			
			List result = pjtManageBiz.selectPjtStatusHIS(map);						
					
			JSONArray jsonArray = JSONArray.fromObject(result);
			HashMap mapResult = new HashMap();
			 
			mapResult.put("success", "true");									
			mapResult.put("message", "Loaded data");						

			mapResult.put("data_1st_pop", jsonArray);							
			mapResult.put("total_1st_pop", pjtManageBiz.selectPjtStatusHISCount(map));
			JSONObject jsonObject = JSONObject.fromObject(mapResult);
			mav.addObject("RESULT_1ST", jsonObject);
				 
			  
		}catch(Exception ex){
			logger.error(ex.getMessage());
		}
		
		return mav;
	}		
	
	
	
	
	
	
	
	

	public ModelAndView statusManageList(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = null;		
		try {
			mav = new ModelAndView(); 
				  
				mav.setViewName("/pjt/pjtManage/statusManageList");
				
				List PJT_STATUS_CODE = sgisCodeBiz.selectComboCode("PJT_STATUS");					//진행상태코드
					mav.addObject("PJT_STATUS_CODE", PJT_STATUS_CODE); 
				List PJT_TYPE_CODE = sgisCodeBiz.selectComboCode("PJT_TYPE_CODE");
					mav.addObject("PJT_TYPE_CODE", PJT_TYPE_CODE); 
				 
				
				HashMap paramMap = WebUtil.parseRequestMap(request);  		
				HashMap adminMap = (HashMap)request.getSession().getAttribute(SGConfigManager.getString("common.session.admin.name")); 
				mav.addObject("admin_id",(String)adminMap.get("ADMIN_ID"));
				mav.addObject("admin_nm",(String)adminMap.get("ADMIN_NM"));
				mav.addObject("sabun",(String)adminMap.get("SABUN"));
				mav.addObject("dept_code",pjtManageBiz.getDeptCode((String)adminMap.get("SABUN")));
				mav.addObject("dept_nm", pjtManageBiz.getDeptNm(pjtManageBiz.getDeptCode((String)adminMap.get("SABUN")))); 
				
		} catch (Exception e) {
			logger.error(e, e);
			
		}
		return mav;
	}
	  
	public ModelAndView statusManageListResult(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = null;		
		try{
			mav = new ModelAndView();
			mav.setViewName("/result/result_edit_1st");	
			HashMap map = WebUtil.parseRequestMap(request); 
    		
			int limit = 0;
			if((String)map.get("limit") != null)
				limit = Integer.parseInt((String)map.get("limit"));
			int start = 0;
			if((String)map.get("start") != null)
				start = Integer.parseInt((String)map.get("start"));
			map.put("limit", limit+start); 
			
			
			
			HashMap adminMap = (HashMap)request.getSession().getAttribute(SGConfigManager.getString("common.session.admin.name"));
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
			
			
			List result = pjtManageBiz.selectPjtStatus(map);						
					
			JSONArray jsonArray = JSONArray.fromObject(result);
			HashMap mapResult = new HashMap();
			 
			mapResult.put("success", "true");									
			mapResult.put("message", "Loaded data");
			mapResult.put("data_edit_1st", jsonArray);
			mapResult.put("total_edit_1st", pjtManageBiz.selectPjtStatusCount(map));
			JSONObject jsonObject = JSONObject.fromObject(mapResult);
			mav.addObject("RESULT_EDIT_1ST", jsonObject);
			  
		}catch(Exception ex){
			logger.error(ex.getMessage());
		}
		
		return mav;
	}
	
	
	public ModelAndView statusActionPjtManage(HttpServletRequest request, HttpServletResponse response)throws Exception{

		ModelAndView mav = new ModelAndView();
		JSONObject jsonObject = new JSONObject();
		HashMap mapResult = new HashMap(); 

		try {
			mav = new ModelAndView();
			mav.setViewName("/result/result_edit_1st");
			
			HashMap paramMap = WebUtil.parseRequestMap(request);  		
			HashMap adminMap = (HashMap)request.getSession().getAttribute(SGConfigManager.getString("common.session.admin.name"));
					paramMap.put("admin_id", (String)adminMap.get("ADMIN_ID"));
					paramMap.put("groups", (String)adminMap.get("GROUPS"));
					paramMap.put("emp_num", (String)adminMap.get("SABUN"));
			
			boolean check = false;
			check = pjtManageBiz.actionPjtStatusManage(paramMap, request);
			
			List result = pjtManageBiz.selectPjtStatus(paramMap);
			JSONArray jsonArray = JSONArray.fromObject(result);

			if("".equals(check)){
				mapResult.put("success", "true"); 
			}else{
				mapResult.put("success", "false"); 
			}
			
			mapResult.put("total_edit_1st", pjtManageBiz.selectPjtStatusCount(paramMap));		
			mapResult.put("data_edit_1st", jsonArray);
			jsonObject = JSONObject.fromObject(mapResult);

		}catch (Exception e){
			mapResult.put("success", "false");
			mapResult.put("message", e.toString());
			logger.error(e, e);
		}finally{

		}
		mav.addObject("RESULT_EDIT_1ST", jsonObject);
		return mav;
	}
	
	
	public ModelAndView allPJTManagement(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = null;		
  
		try{
			HashMap paramMap = WebUtil.parseRequestMap(request); 
			HashMap mapResult = new HashMap();
			
			mav = new ModelAndView();
			mav.setViewName("/pjt/allPJTManagement"); 
			
			List PJT_TYPE_CODE = sgisCodeBiz.selectComboCode("PJT_TYPE_CODE");				//사업구분
				 mav.addObject("PJT_TYPE_CODE", PJT_TYPE_CODE);	 
			List PAY_FREE_CODE = sgisCodeBiz.selectComboCode("PAY_FREE_CODE");					//유상무상 구분
				 mav.addObject("PAY_FREE_CODE", PAY_FREE_CODE);	 
			List PJT_STATUS_CODE = sgisCodeBiz.selectComboCode("PJT_STATUS");					//진행상태코드
				 mav.addObject("PJT_STATUS_CODE", PJT_STATUS_CODE); 
			List COM_CUSTOM_PATTERN_NM = sgisCodeBiz.selectComboCode("CUSTOM_PATTERN_CODE");	//거래처 유형	
				 mav.addObject("COM_CUSTOM_PATTERN_NM", COM_CUSTOM_PATTERN_NM);
			 
			int limit = 0;
			if((String)paramMap.get("limit") != null)
				limit = Integer.parseInt((String)paramMap.get("limit"));
			int start = 0;
			if((String)paramMap.get("start") != null)
				start = Integer.parseInt((String)paramMap.get("start"));
			
			paramMap.put("limit", limit+start); 
			 
			List result = pjtManageBiz.selectPjtManage(paramMap);
			
			JSONArray jsonArray = JSONArray.fromObject(result);
			
			mapResult.put("success", "true");
			mapResult.put("message", "Loaded data");
			
			mapResult.put("data_edit_3rd", jsonArray);
			mapResult.put("total_edit_3rd", pjtManageBiz.selectPjtManageCount(paramMap));
			JSONObject jsonObject = JSONObject.fromObject(mapResult);
			mav.addObject("RESULT_EDIT_3RD", jsonObject);
			  
			
		}catch(Exception ex){
			logger.error(ex.getMessage());
		}
		
		return mav;
	}

}
