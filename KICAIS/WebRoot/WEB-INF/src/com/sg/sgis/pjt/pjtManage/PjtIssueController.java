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
import com.sg.sgis.com.issue.IssueBiz;
import com.sg.sgis.com.sgisCode.SgisCodeBiz;
import com.sg.sgis.util.CommonUtil;
import com.signgate.core.config.SGConfigManager;
import com.signgate.core.web.controller.SGUserController; 
import com.signgate.core.web.util.WebUtil;

public class PjtIssueController extends SGUserController{

	protected final Log logger = LogFactory.getLog(getClass()); 
	
	private PjtIssueBiz pjtIssueBiz; 
	public void setPjtIssueBiz(PjtIssueBiz pjtIssueBiz){
		this.pjtIssueBiz = pjtIssueBiz;
	}
	
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
	
	private IssueBiz IssueBiz; 
	public void setIssueBiz(IssueBiz issueBiz){
		this.IssueBiz = issueBiz;
	}
	
	CommonUtil comUtil = new CommonUtil();
	
	public ModelAndView pjtIssueList(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = null;
		
		try {
			mav = new ModelAndView();  				
				
				List PJT_STATUS_CODE = sgisCodeBiz.selectComboCode("PJT_STATUS");							//진행상태코드
					 mav.addObject("PJT_STATUS_CODE", PJT_STATUS_CODE); 	 
				List EFFECT_TYPE_CODE = sgisCodeBiz.selectComboCode("EFFECT_TYPE_CODE");					//영향도
					 mav.addObject("EFFECT_TYPE_CODE", EFFECT_TYPE_CODE);	 
				List EMERGNCY_TYPE_CODE = sgisCodeBiz.selectComboCode("EMERGNCY_TYPE_CODE");				//긴급성
					 mav.addObject("EMERGNCY_TYPE_CODE", EMERGNCY_TYPE_CODE);
			    List issue_type_code = sgisCodeBiz.selectComboCode("ISSUE_TYPE_CODE");						//이슈구분코드
					 mav.addObject("ISSUE_TYPE_CODE", issue_type_code);
				List PJT_TYPE_CODE = sgisCodeBiz.selectComboCode("PJT_TYPE_CODE");							//사업구분
					 mav.addObject("PJT_TYPE_CODE", PJT_TYPE_CODE);	 	 
					 
				
				HashMap paramMap = WebUtil.parseRequestMap(request);  		
				HashMap adminMap = (HashMap)request.getSession().getAttribute(SGConfigManager.getString("common.session.admin.name"));
				
				mav.addObject("admin_id",(String)adminMap.get("ADMIN_ID"));
				mav.addObject("admin_nm",(String)adminMap.get("ADMIN_NM"));
				mav.addObject("sabun",(String)adminMap.get("SABUN"));
				mav.addObject("dept_code",pjtManageBiz.getDeptCode((String)adminMap.get("SABUN")));
				mav.addObject("dept_nm", pjtManageBiz.getDeptNm(pjtManageBiz.getDeptCode((String)adminMap.get("SABUN"))));
				
				if("grid_page".equals(request.getParameter("div"))){
					 paramMap.put("src_pjt_name",comUtil.getDecodingUTF(request.getParameter("src_pjt_name")));
				}
				
				if(paramMap.get("popUp_YN").equals("Y")){
					mav.setViewName("/pjt/pjtIssue/pjtIssuePop");	
				}else{
					mav.setViewName("/pjt/pjtIssue/pjtIssueList");
				}
				
		} catch (Exception e) {
			logger.error(e, e);
			
		}
		return mav;
	} 
  
	
	public ModelAndView result_edit_1st(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView();
		
		try{
			
			mav.setViewName("/result/result_edit_1st");	
			HashMap mapResult = new HashMap();
			
			HashMap map = WebUtil.parseRequestMap(request);
			
			HashMap adminMap = (HashMap)request.getSession().getAttribute(SGConfigManager.getString("common.session.admin.name"));
					mav.addObject("admin_id",(String)adminMap.get("ADMIN_ID"));
					mav.addObject("admin_nm",(String)adminMap.get("ADMIN_NM"));
					mav.addObject("sabun",(String)adminMap.get("SABUN"));
					mav.addObject("dept_code",pjtManageBiz.getDeptCode((String)adminMap.get("SABUN")));
					mav.addObject("dept_nm", pjtManageBiz.getDeptNm(pjtManageBiz.getDeptCode((String)adminMap.get("SABUN")))); 
					
			  
			mapResult.put("success", "true");			 				
			
			/*grid 페이징 처리시 사용 할 페이지 시작 종료 value*/
			int limit = 0;
			if((String)map.get("limit") != null)
				limit = Integer.parseInt((String)map.get("limit"));
			
			int start = 0;
			if((String)map.get("start") != null)
				start = Integer.parseInt((String)map.get("start"));
			map.put("limit", limit+start);
			
			//자신의 부서에서 등록한 목록만 가져오기//
			String emp_num   =(String)adminMap.get("ADMIN_ID");
			String dept_code = pjtManageBiz.getDeptCode((String)adminMap.get("SABUN"));
			String groups	 = (String)adminMap.get("GROUPS");
			
			if(    groups.indexOf("G001", 0) != -1 				//시스템관리자
				&& groups.indexOf("G002", 0) != -1				//임원
				&& groups.indexOf("G005", 0) != -1				//대표이사 
			  ){
				map.put("session_dept_code", dept_code);
			}  
			
			 
			List result_edit_1st = pjtIssueBiz.selectPjtIssue(map);		
		
			JSONArray jsonArray = new JSONArray();
			jsonArray = JSONArray.fromObject(result_edit_1st);		
			
			mapResult.put("data_edit_1st", jsonArray);
			mapResult.put("total_edit_1st", pjtIssueBiz.selectPjtIssueCount(map));
			
			JSONObject jsonObject = JSONObject.fromObject(mapResult);	 
			mav.addObject("RESULT_EDIT_1ST", jsonObject);	

		}catch(Exception ex){
			logger.error(ex.getMessage());
		}
		return mav;
	}
	
	 
	
	public ModelAndView actionPjtIssue(HttpServletRequest request, HttpServletResponse response){

		ModelAndView mav = new ModelAndView();
		HashMap mapResult = new HashMap();

		try {
			mav = new ModelAndView();
			mav.setViewName("/result/result_edit_1st");
			
			List TECH_SUP_RESULT_CODE = sgisCodeBiz.selectComboCode("TECH_SUP_RESULT_CODE");			//진행현황코드
				 mav.addObject("TECH_SUP_RESULT_CODE", TECH_SUP_RESULT_CODE);	 
			List EFFECT_TYPE_CODE = sgisCodeBiz.selectComboCode("EFFECT_TYPE_CODE");					//영향도
				 mav.addObject("EFFECT_TYPE_CODE", EFFECT_TYPE_CODE);	 
			List EMERGNCY_TYPE_CODE = sgisCodeBiz.selectComboCode("EMERGNCY_TYPE_CODE");				//긴급성
				 mav.addObject("EMERGNCY_TYPE_CODE", EMERGNCY_TYPE_CODE);
		    List issue_type_code = sgisCodeBiz.selectComboCode("ISSUE_TYPE_CODE");						//이슈구분코드
				 mav.addObject("ISSUE_TYPE_CODE", issue_type_code);
				 
			HashMap paramMap = WebUtil.parseRequestMap(request);  		
			HashMap adminMap = (HashMap)request.getSession().getAttribute(SGConfigManager.getString("common.session.admin.name"));
					mav.addObject("admin_id",(String)adminMap.get("ADMIN_ID"));
					mav.addObject("admin_nm",(String)adminMap.get("ADMIN_NM"));
					mav.addObject("sabun",(String)adminMap.get("SABUN"));
					mav.addObject("dept_code",pjtManageBiz.getDeptCode((String)adminMap.get("SABUN")));
					mav.addObject("dept_nm", pjtManageBiz.getDeptNm(pjtManageBiz.getDeptCode((String)adminMap.get("SABUN")))); 

			paramMap.put("pjt_type_code", "10");
					
			boolean check = pjtIssueBiz.actionPjtIssue(paramMap, request);			// 저장 및 수정 			

			/*grid 페이징 처리시 사용 할 페이지 시작 종료 value*/
			int limit = 0;
			if((String)paramMap.get("limit") != null)
				limit = Integer.parseInt((String)paramMap.get("limit"));
			
			int start = 0;
			if((String)paramMap.get("start") != null)
				start = Integer.parseInt((String)paramMap.get("start"));
			
			paramMap.put("limit", limit+start);	
			
			
			if("".equals(check)){
				mapResult.put("success", "true");										// 성공 
			}else{
				mapResult.put("success", "false");										// 실패 
			}
			 
			 
			List result_edit_1st = pjtIssueBiz.selectPjtIssue(paramMap);		
		
			JSONArray jsonArray = new JSONArray();
			jsonArray = JSONArray.fromObject(result_edit_1st);		
			
			mapResult.put("data_edit_1st", jsonArray);
			mapResult.put("total_edit_1st", pjtIssueBiz.selectPjtIssueCount(paramMap));
			
			JSONObject jsonObject = JSONObject.fromObject(mapResult);	 
			mav.addObject("RESULT_EDIT_1ST", jsonObject);	
			 
		 
		}catch (Exception e){
		 	mapResult.put("message", e.toString());										// message
			logger.error(e, e);
		}
		return mav;
		 
	}
	 
	

}
