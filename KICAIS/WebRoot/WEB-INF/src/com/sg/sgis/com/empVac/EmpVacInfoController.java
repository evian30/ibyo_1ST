/**
 *  Class Name  : EmpVacController
 *  Description : 개인별휴가정보 Controller
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

package com.sg.sgis.com.empVac;


import java.util.Calendar;
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
import com.sg.sgis.pjt.pjtManage.PjtManageBiz;
import com.signgate.core.config.SGConfigManager;
import com.signgate.core.web.controller.SGUserController;
import com.signgate.core.web.util.WebUtil;

public class EmpVacInfoController extends SGUserController{

	protected final Log logger = LogFactory.getLog(getClass());
	
	// BIZ경로 설정
	private EmpVacInfoBiz empVacInfoBiz;
	private EmpVacUsedInfoBiz empVacUsedInfoBiz;
	private PjtManageBiz pjtManageBiz; 
	private DeptBiz deptBiz;

	public EmpVacInfoBiz getEmpVacInfoBiz() {
		return empVacInfoBiz;
	}

	public void setEmpVacInfoBiz(EmpVacInfoBiz empVacInfoBiz) {
		this.empVacInfoBiz = empVacInfoBiz;
	}

	public EmpVacUsedInfoBiz getEmpVacUsedInfoBiz() {
		return empVacUsedInfoBiz;
	}

	public void setEmpVacUsedInfoBiz(EmpVacUsedInfoBiz empVacUsedInfoBiz) {
		this.empVacUsedInfoBiz = empVacUsedInfoBiz;
	}	
	
	public void setPjtManageBiz(PjtManageBiz pjtManageBiz){
		this.pjtManageBiz = pjtManageBiz;
	}	
	
	public DeptBiz getDeptBiz() {
		return deptBiz;
	}

	public void setDeptBiz(DeptBiz deptBiz) {
		this.deptBiz = deptBiz;
	}		
	

	public ModelAndView empVacInfoList(HttpServletRequest request, HttpServletResponse response) {
		
		ModelAndView mav = new ModelAndView();
		
		try {
			
			mav.setViewName("/com/empVac/empVacList");
			// 공통코드 조회
/*			
			List item_pattern_code  = deptBiz.selectComboCode("ITEM_PATTERN_CODE"); // 품목유형코드
			List item_type_code  = deptBiz.selectComboCode("ITEM_TYPE_CODE");		// 품목구분코드
			
			mav.addObject("RESULT", "");
			mav.addObject("ITEM_PATTERN_CODE", item_pattern_code);	// 품목유형코드
			mav.addObject("ITEM_TYPE_CODE", item_type_code);		// 품목구분코드
*/
		} catch (Exception e) {
			logger.error(e, e);
		}
		return mav;
	}	
	
	/**
	 * 개인별휴가정보관리 : 조회된 목록을 화면으로 retuen
	 * @param  request 
	 * @param  response
	 * @return mav	   
	 * 2011. 3. 28.
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
			List result_edit_1st = empVacInfoBiz.selectEmpVacList(paramMap);		
		
			JSONArray jsonArray = new JSONArray();
			jsonArray = JSONArray.fromObject(result_edit_1st);		
			
			mapResult.put("data_edit_1st", jsonArray);
			mapResult.put("total_edit_1st", empVacInfoBiz.selectEmpVacCount(paramMap));
			
			JSONObject jsonObject = JSONObject.fromObject(mapResult);	 
			mav.addObject("RESULT_EDIT_1ST", jsonObject);	

		}catch(Exception ex){
			logger.error(ex.getMessage());
		}
		
		return mav;
	}

	
	// 신규 등록 또는 수정 처리
	public ModelAndView actionEmpVacInfo(HttpServletRequest request, HttpServletResponse response)throws Exception{
		
		ModelAndView mav = new ModelAndView(); 
		HashMap mapResult = new HashMap();
		JSONObject jsonObject = new JSONObject();
		
		try {
			mav = new ModelAndView();
			mav.setViewName("/result/result_edit_1st");	
			HashMap paramMap = WebUtil.parseRequestMap(request); 
			
			/***** session 정보 *****/
			HashMap adminMap = (HashMap)request.getSession().getAttribute(SGConfigManager.getString("common.session.admin.name"));
			paramMap.put("final_mod_id", (String)adminMap.get("SABUN"));	// 로그인 ID
			paramMap.put("reg_id", (String)adminMap.get("SABUN"));	// 로그인 ID
			
			/***** 저장 및 수정 *****/
			boolean actEmpVacInfoResult = empVacInfoBiz.actionEmpVacInfo(paramMap, request);
			
			/***** paging *****/ 
			int limit = 0;
			if((String)paramMap.get("limit") != null)
				limit = Integer.parseInt((String)paramMap.get("limit"));
			int start = 0;
			if((String)paramMap.get("start") != null)
				start = Integer.parseInt((String)paramMap.get("start"));
			
			paramMap.put("limit", limit+start);		
			 
			/***** 목록조회 *****/
			List result_edit_1st = empVacInfoBiz.selectEmpVacList(paramMap);		
		
			JSONArray jsonArray = new JSONArray();
			jsonArray = JSONArray.fromObject(result_edit_1st);		
			
			mapResult.put("data_edit_1st", jsonArray);
			mapResult.put("total_edit_1st", empVacInfoBiz.selectEmpVacCount(paramMap));
			
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

	
	public ModelAndView empVacUsedInfoList(HttpServletRequest request, HttpServletResponse response) {
		
		ModelAndView mav = new ModelAndView();
		
		try {
			HashMap adminMap = (HashMap)request.getSession().getAttribute(SGConfigManager.getString("common.session.admin.name"));

		    mav.addObject("admin_id",(String)adminMap.get("ADMIN_ID"));
			mav.addObject("admin_nm",(String)adminMap.get("ADMIN_NM"));
			mav.addObject("sabun",(String)adminMap.get("SABUN"));
			mav.addObject("dept_code",pjtManageBiz.getDeptCode((String)adminMap.get("SABUN")));
			mav.addObject("dept_nm", pjtManageBiz.getDeptNm(pjtManageBiz.getDeptCode((String)adminMap.get("SABUN"))));			
			
			mav.setViewName("/com/empVac/empVacUsedList");
			// 공통코드 조회
			List vac_type_code  = deptBiz.selectComboCode("VAC_TYPE_CODE"); // 휴가구분코드
			
			HashMap map = new HashMap();
			
			Calendar cal = Calendar.getInstance();
			int toDay = cal.get(Calendar.YEAR);
			map.put("basic_year", Integer.toString(toDay));
		    //테스트 
			//map.put("emp_num", "30192");
			map.put("emp_num", (String)adminMap.get("SABUN"));
			
			//총휴가일수
			mav.addObject("empVacTotCount", empVacUsedInfoBiz.selectEmpVacTotCount(map));			
			
			mav.addObject("VAC_TYPE_CODE", vac_type_code);	
		
		} catch (Exception e) {
			logger.error(e, e);
		}
		return mav;
	}	
	
	/**
	 * 개인별휴가사용정보관리 : 조회된 목록을 화면으로 retuen
	 * @param  request 
	 * @param  response
	 * @return mav	   
	 * 2011. 3. 28.
	 */
	public ModelAndView result_edit_1st_used(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView();
		
		try{
			HashMap adminMap = (HashMap)request.getSession().getAttribute(SGConfigManager.getString("common.session.admin.name"));

		    mav.addObject("admin_id",(String)adminMap.get("ADMIN_ID"));
			mav.addObject("admin_nm",(String)adminMap.get("ADMIN_NM"));
			mav.addObject("sabun",(String)adminMap.get("SABUN"));
			mav.addObject("dept_code",pjtManageBiz.getDeptCode((String)adminMap.get("SABUN")));
			mav.addObject("dept_nm", pjtManageBiz.getDeptNm(pjtManageBiz.getDeptCode((String)adminMap.get("SABUN"))));			
			
			
			mav.setViewName("/result/result_edit_1st");	
			
			HashMap paramMap = WebUtil.parseRequestMap(request); 
			
			Calendar cal = Calendar.getInstance();
			int toDay = cal.get(Calendar.YEAR);
		
			if((String)paramMap.get("basic_year")== null || ((String)paramMap.get("basic_year")).equals(""))  //기준년도가 없으면 올해년도 입력
			{
				paramMap.put("basic_year", Integer.toString(toDay));
			}
			
		    //테스트 
			//map.put("emp_num", "30192");
			paramMap.put("emp_num", (String)adminMap.get("SABUN"));
		
			HashMap mapResult = new HashMap();

			//총휴가일수
			mapResult.put("empVacTotCount", empVacUsedInfoBiz.selectEmpVacTotCount(paramMap));			
			
			/***** paging *****/ 
			int limit = 0;
			if((String)paramMap.get("limit") != null)
				limit = Integer.parseInt((String)paramMap.get("limit"));
			int start = 0;
			if((String)paramMap.get("start") != null)
				start = Integer.parseInt((String)paramMap.get("start"));
			
			paramMap.put("limit", limit+start);		
			 
			/***** 목록조회 *****/
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
			
			List result_edit_1st = empVacUsedInfoBiz.selectEmpVacUsedList(paramMap);		
		
			JSONArray jsonArray = new JSONArray();
			jsonArray = JSONArray.fromObject(result_edit_1st);
			
			mapResult.put("success", "true");	
			mapResult.put("data_edit_1st", jsonArray);
			mapResult.put("total_edit_1st", empVacUsedInfoBiz.selectEmpVacUsedCount(paramMap));

			mapResult.put("pMap",paramMap);			
			
			JSONObject jsonObject = JSONObject.fromObject(mapResult);	 
			mav.addObject("RESULT_EDIT_1ST", jsonObject);	
			
			

		}catch(Exception ex){
			logger.error(ex.getMessage());
		}
		
		return mav;
	}

	/**
	 *  신규 등록 또는 수정 처리
	 */
	public ModelAndView actionEmpVacUsedInfo(HttpServletRequest request, HttpServletResponse response)throws Exception{
		
		ModelAndView mav = new ModelAndView(); 
		HashMap mapResult = new HashMap();
		
		try {
			mav = new ModelAndView();
			mav.setViewName("/result/result_edit_1st");

			HashMap paramMap = WebUtil.parseRequestMap(request); 
			
			/***** session 정보 *****/
			HashMap adminMap = (HashMap)request.getSession().getAttribute(SGConfigManager.getString("common.session.admin.name"));
			//테스트
			//paramMap.put("emp_num","30192");
			paramMap.put("emp_num",(String)adminMap.get("SABUN"));

			
			paramMap.put("final_mod_id", (String)adminMap.get("SABUN"));	// 로그인 ID
			paramMap.put("reg_id", (String)adminMap.get("SABUN"));	// 로그인 ID
						

			/***** 저장 및 수정 *****/
			boolean actEmpVacUsedInfoResult = empVacUsedInfoBiz.actionEmpVacUsedInfo(paramMap, request);			
			
			/***** paging *****/ 
			int limit = 0;
			if((String)paramMap.get("limit") != null)
				limit = Integer.parseInt((String)paramMap.get("limit"));
			int start = 0;
			if((String)paramMap.get("start") != null)
				start = Integer.parseInt((String)paramMap.get("start"));
			
			paramMap.put("limit", limit+start);		
			 
			/***** 목록조회 *****/
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

			List result_edit_1st = empVacUsedInfoBiz.selectEmpVacUsedList(paramMap);		
		
			JSONArray jsonArray = new JSONArray();
			jsonArray = JSONArray.fromObject(result_edit_1st);		
			
			mapResult.put("data_edit_1st", jsonArray);
			mapResult.put("total_edit_1st", empVacUsedInfoBiz.selectEmpVacUsedCount(paramMap));
			
			JSONObject jsonObject = JSONObject.fromObject(mapResult);	 
			mav.addObject("pMap",paramMap);
			
			mav.addObject("RESULT_EDIT_1ST", jsonObject);	
			

			
			
		}catch (Exception e){
			mapResult.put("success", "false");								// 성공여부
			mapResult.put("message", e.toString());							// message
			logger.error(e, e);
		}finally{
			
		}
			return mav;
	}	
	
	/**
	 * 개인별휴가사용관리 삭제
	 */
	public ModelAndView deleteEmpVacUsed(HttpServletRequest request, HttpServletResponse response) {
		
		ModelAndView mav = new ModelAndView();
		HashMap<String,Object> mapResult = new HashMap<String, Object>();
		
		try {
			HashMap paramMap = WebUtil.parseRequestMap(request); 
			
			/***** session 정보 *****/
			HashMap adminMap = (HashMap)request.getSession().getAttribute(SGConfigManager.getString("common.session.admin.name"));
			paramMap.put("final_mod_id", (String)adminMap.get("SABUN"));	// 로그인 ID
			paramMap.put("reg_id", (String)adminMap.get("SABUN"));	// 로그인 ID
			
			mav = new ModelAndView();
			mav.setViewName("/result/result_1st");	
			
			/***** 삭제 *****/
			boolean delEmpVacUsedResult = empVacUsedInfoBiz.deleteEmpVacUsed(paramMap, request);	

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

			
			//재조회
			List result_edit_1st = empVacUsedInfoBiz.selectEmpVacUsedList(paramMap);		
		
			JSONArray jsonArray = new JSONArray();
			jsonArray = JSONArray.fromObject(result_edit_1st);		
			
			mapResult.put("data_edit_1st", jsonArray);
			mapResult.put("total_edit_1st", empVacUsedInfoBiz.selectEmpVacUsedCount(paramMap));
			
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
	 * 개인별휴가일수
	 */	
	public ModelAndView selectEmpVacDaysCount(HttpServletRequest request, HttpServletResponse response)throws Exception{
		
		ModelAndView mav = new ModelAndView(); 
		HashMap mapResult = new HashMap();
		
		try {
			mav = new ModelAndView();
			mav.setViewName("/result/result_edit_1st");

			HashMap paramMap = WebUtil.parseRequestMap(request); 
			
			/***** session 정보 *****/
			HashMap adminMap = (HashMap)request.getSession().getAttribute(SGConfigManager.getString("common.session.admin.name"));
			paramMap.put("final_mod_id", (String)adminMap.get("SABUN"));	// 로그인 ID
			paramMap.put("reg_id", (String)adminMap.get("SABUN"));	// 로그인 ID
						

			/*****조회 *****/
			mapResult.put("empVacDaysCount", empVacUsedInfoBiz.selectEmpVacDaysCount(paramMap));
			
			JSONObject jsonObject = JSONObject.fromObject(mapResult);	 
			mav.addObject("RESULT_EDIT_1ST", jsonObject);	
			
			
		}catch (Exception e){
			mapResult.put("success", "false");								// 성공여부
			mapResult.put("message", e.toString());							// message
			logger.error(e, e);
		}finally{
			
		}
			return mav;
	}	
		

}
