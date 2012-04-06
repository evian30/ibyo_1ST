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
package com.sg.sgis.man.management;

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
import com.sg.sgis.sal.sale.SaleInfoManageBiz;
import com.sg.sgis.util.CommonUtil;
import com.signgate.core.config.SGConfigManager;
import com.signgate.core.web.controller.SGUserController; 
import com.signgate.core.web.util.WebUtil;

public class ManagementController extends SGUserController{

	protected final Log logger = LogFactory.getLog(getClass()); 
	
	private ManagementBiz managementBiz; 
	public void setManagementBiz(ManagementBiz managementBiz){
		this.managementBiz = managementBiz;
	}
	
	private PjtManageBiz pjtManageBiz; 
	public void setPjtManageBiz(PjtManageBiz pjtManageBiz){
		this.pjtManageBiz = pjtManageBiz;
	} 
	  
	private SgisCodeBiz sgisCodeBiz; 
	public void setSgisCodeBiz(SgisCodeBiz sgisCodeBiz){
		this.sgisCodeBiz = sgisCodeBiz;
	}
	
	// 매출정보관리 BIZ경로 설정
	private SaleInfoManageBiz saleInfoManageBiz; 
	public void setSaleInfoManageBiz(SaleInfoManageBiz saleInfoManageBiz){
		this.saleInfoManageBiz = saleInfoManageBiz;
	}
	  
	CommonUtil comUtil = new CommonUtil();
	public ModelAndView managementList(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = null;
		
		try {
			mav = new ModelAndView(); 
				  
				List PAY_FREE_CODE = sgisCodeBiz.selectComboCode("PAY_FREE_CODE");					//유상무상 구분
					 mav.addObject("PAY_FREE_CODE", PAY_FREE_CODE);	 
				List PJT_STATUS_CODE = sgisCodeBiz.selectComboCode("PJT_STATUS");					//진행상태코드
					 mav.addObject("PJT_STATUS_CODE", PJT_STATUS_CODE); 
				List COM_CUSTOM_PATTERN_NM = sgisCodeBiz.selectComboCode("CUSTOM_PATTERN_CODE");	//거래처 유형	
					 mav.addObject("COM_CUSTOM_PATTERN_NM", COM_CUSTOM_PATTERN_NM);
				List MAN_STATUS_CODE = sgisCodeBiz.selectComboCode("MAN_STATUS_CODE");						//유지보수 진행상태
					 mav.addObject("MAN_STATUS_CODE", MAN_STATUS_CODE);  	 
					 
				HashMap paramMap = WebUtil.parseRequestMap(request);  		
				HashMap adminMap = (HashMap)request.getSession().getAttribute(SGConfigManager.getString("common.session.admin.name"));
						mav.addObject("admin_id",(String)adminMap.get("ADMIN_ID"));
						mav.addObject("admin_nm",(String)adminMap.get("ADMIN_NM"));
						mav.addObject("sabun",(String)adminMap.get("SABUN"));
						mav.addObject("dept_code",pjtManageBiz.getDeptCode((String)adminMap.get("SABUN")));
						mav.addObject("dept_nm", pjtManageBiz.getDeptNm(pjtManageBiz.getDeptCode((String)adminMap.get("SABUN"))));
				 
				mav.addObject("new_man_id", managementBiz.selectManID(paramMap));
				
				
				if(paramMap.get("totMng").equals("all")){
					mav.setViewName("/pjt/allMANManageList");
				}else{
					mav.setViewName("/man/management/managementList");
				}
				
				
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
			
			List result = managementBiz.selectManagement(paramMap);		
			 
			JSONArray jsonArray = JSONArray.fromObject(result);
			
			mapResult.put("success", "true");
			mapResult.put("message", "Loaded data");
			
			mapResult.put("data_1st", jsonArray);
			mapResult.put("total_1st", managementBiz.selectManagementCount(paramMap));
			JSONObject jsonObject = JSONObject.fromObject(mapResult);
			mav.addObject("RESULT_1ST", jsonObject);
		
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
			 
			int limit = 0;
			if((String)map.get("limit") != null)
				limit = Integer.parseInt((String)map.get("limit"));
			
			int start = 0;
			if((String)map.get("start") != null)
				start = Integer.parseInt((String)map.get("start"));
			
			map.put("limit", limit+start);			
			 
			List result_edit_1st = managementBiz.selectPjtManagement(map);		
		
			JSONArray jsonArray = new JSONArray();
			jsonArray = JSONArray.fromObject(result_edit_1st);		
			
			mapResult.put("data_edit_1st", jsonArray);
			mapResult.put("total_edit_1st", managementBiz.selectPjtManagementCount(map));
			
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
			 
			int limit = 0;
			if((String)map.get("limit") != null)
				limit = Integer.parseInt((String)map.get("limit"));
			
			int start = 0;
			if((String)map.get("start") != null)
				start = Integer.parseInt((String)map.get("start"));
			
			map.put("limit", limit+start);			
			 
			List result_edit_2nd = managementBiz.selectManagementItem(map);		
		
			JSONArray jsonArray = new JSONArray();
			jsonArray = JSONArray.fromObject(result_edit_2nd);		
			
			mapResult.put("data_edit_2nd", jsonArray);
			mapResult.put("total_edit_2nd", managementBiz.selectManagementItemCount(map));
			
			JSONObject jsonObject = JSONObject.fromObject(mapResult);	 
			mav.addObject("RESULT_EDIT_2ND", jsonObject);	

		}catch(Exception ex){
			logger.error(ex.getMessage());
		}
		
		return mav;
	} 
	
	public ModelAndView actionManagement(HttpServletRequest request, HttpServletResponse response)throws Exception{

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
			if(paramMap.get("ManType").equals("base")){ 
				 mav.setViewName("/result/result_1st");
				 
				 check = managementBiz.actionManagement(paramMap, request);
				
				 man_total="total_1st";
				 man_data="data_1st";
				 man_result="RESULT_1ST"; 
			}else{
				
			}
			
			String sal_id=managementBiz.selectSalID(paramMap);
			 
			List result = managementBiz.selectManagement(paramMap);

			JSONArray jsonArray = JSONArray.fromObject(result);

			if("".equals(check)){
				mapResult.put("success", "true");										// 성공 
			}else{
				mapResult.put("success", "false");										// 실패 
			}
			 
			if(sal_id!=null){
				mapResult.put("sal_id", sal_id);  
			}
			mapResult.put(man_total, managementBiz.selectManagementCount(paramMap));
			mapResult.put("new_man_id", managementBiz.selectManID(paramMap));
			
			mapResult.put(man_total, managementBiz.selectManagementCount(paramMap));		
			mapResult.put(man_data, jsonArray);											// 조회된 결과값
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
	 
	/**
	 * 유지보수 등록가능한 프로젝트인지 체크
	 * @param request
	 * @param response
	 * @return
	 * 2011. 5. 18.
	 */
	public ModelAndView selectSalCheck(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView();
		
		try{
			mav.setViewName("/result/result_edit_2nd");	
			HashMap map = WebUtil.parseRequestMap(request);   
			
			HashMap mapResult = new HashMap();
			 
			List result = managementBiz.selectSalCheck(map);		
		
			JSONArray jsonArray = new JSONArray();
			jsonArray = JSONArray.fromObject(result);		
			
			mapResult.put("success", "true");	
			mapResult.put("data", jsonArray);
			
			JSONObject jsonObject = JSONObject.fromObject(mapResult);	 
			mav.addObject("RESULT_EDIT_2ND", jsonObject);	

		}catch(Exception ex){
			logger.error(ex.getMessage());
		}
		
		return mav;
	}   
	
	/**
	 * 매출정보관리(수주 품목정보) 목록조회
	 * @param  request 
	 * @param  response
	 * @return 
	 * 2011. 4. 26.
	 */
	public ModelAndView selectSalItemInfo(HttpServletRequest request, HttpServletResponse response) {
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
			 
			List result_edit_1st = saleInfoManageBiz.selectSalItemInfo(map);		
		
			JSONArray jsonArray = new JSONArray();
			jsonArray = JSONArray.fromObject(result_edit_1st);		
			
			mapResult.put("data_edit_2nd", jsonArray);
			mapResult.put("total_edit_2nd", saleInfoManageBiz.selectSalItemInfoCount(map));
			
			JSONObject jsonObject = JSONObject.fromObject(mapResult);	 
			mav.addObject("RESULT_EDIT_2ND", jsonObject);	

		}catch(Exception ex){
			logger.error(ex.getMessage());
		}
		
		return mav;
	}
	
}
