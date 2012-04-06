/**
 *  Class Name  : EmployeeController.java
 *  Description : 사원정보관리 Controller
 *  Modification Information
 *
 *  수정일                   수정자               수정내용
 *  -------      --------   ---------------------------
 *  2011. 2. 7.    고기범        최초 생성
 *  2011. 4. 1.    고기범        Session 정보 설정
 *
 *  @author 고기범
 *  @since 2011. 2. 7.
 *  @version 1.0
 *  @see 
 * 
 *  Copyright (C) 2011 by SG All right reserved.
 */
package com.sg.sgis.com.employee;

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

public class EmployeeController extends SGUserController{

	protected final Log logger = LogFactory.getLog(getClass());
	
	CommonUtil comUtil = new CommonUtil();
	
	// BIZ경로 설정
	private EmployeeBiz EmployeeBiz; 
	public void setEmployeeBiz(EmployeeBiz employeeBiz){
		this.EmployeeBiz = employeeBiz;
	}
	
	// BIZ경로 설정
	private DeptBiz DeptBiz; 
	public void setDeptBiz(DeptBiz deptBiz){
		this.DeptBiz = deptBiz;
	}
	
	// 공통코드 BIZ경로 설정
	private SgisCodeBiz sgisCodeBiz;
	public void setSgisCodeBiz(SgisCodeBiz sgisCodeBiz) {
		this.sgisCodeBiz = sgisCodeBiz;
	}
	
	
	private PjtManageBiz pjtManageBiz; 
	public void setPjtManageBiz(PjtManageBiz pjtManageBiz){
		this.pjtManageBiz = pjtManageBiz;
	} 
	
	
	public ModelAndView employeeList(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = null;
		
		try {
			mav = new ModelAndView();
			
			// 공통코드 조회
			List use_yn = sgisCodeBiz.selectComboCode("YESNO_CODE");			// 사용여부
			List position_code = sgisCodeBiz.selectComboCode("POSITION_CODE");	// 직위코드
			List duty_code = sgisCodeBiz.selectComboCode("DUTY_CODE");			// 직책코드
			// 공통코드 조회(테이블명, value컬럼, name컬럼)
			List dept_code = DeptBiz.selectComboCode("COM_DEPT","DEPT_CODE","DEPT_NAME");	// 부서코드
			
			mav.addObject("RESULT", "");
			mav.addObject("USE_YN", use_yn);				// 사용여부
			mav.addObject("DEPT_CODE", dept_code);			// 부서코드
			mav.addObject("POSITION_CODE", position_code);	// 직위코드
			mav.addObject("DUTY_CODE", duty_code);			// 직책코드
			
		} catch (Exception e) {
			logger.error(e, e);
		}
		return mav;
	}
	
	public ModelAndView employeePop(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = null;
		
		try {
			mav = new ModelAndView();
			
			HashMap map = WebUtil.parseRequestMap(request);
			
			/********************일정관리의 사원 검색 임원이 아니면 본인의 팀원 것만 확인 가능 하도록*****************************/
			HashMap adminMap = (HashMap)request.getSession().getAttribute(SGConfigManager.getString("common.session.admin.name"));
			String emp_num   =(String)adminMap.get("ADMIN_ID");
			String dept_code = pjtManageBiz.getDeptCode((String)adminMap.get("SABUN"));		 
			String getAuthority = pjtManageBiz.getAuthority(emp_num);
			
			mav.addObject("getAuthority", getAuthority);
			mav.addObject("dept_nm", pjtManageBiz.getDeptNm(pjtManageBiz.getDeptCode((String)adminMap.get("SABUN"))));
			mav.addObject("dept_code", dept_code);
			mav.addObject("emp_num", emp_num);
			
			  
		} catch (Exception e) {
			logger.error(e, e);
		}
		return mav;
	}
	
	public ModelAndView employeeList2(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = null;
		
		try {
			mav = new ModelAndView();
			
			HashMap adminMap = (HashMap)request.getSession().getAttribute(SGConfigManager.getString("common.session.admin.name")); 
					mav.addObject("admin_id",(String)adminMap.get("ADMIN_ID"));
					mav.addObject("admin_nm",(String)adminMap.get("ADMIN_NM"));
					mav.addObject("sabun",(String)adminMap.get("SABUN"));  
					mav.addObject("groups", (String)adminMap.get("GROUPS"));
			
			// 공통코드 조회
			List use_yn = sgisCodeBiz.selectComboCode("YESNO_CODE");			// 사용여부
			List position_code = sgisCodeBiz.selectComboCode("POSITION_CODE");	// 직위코드
			List duty_code = sgisCodeBiz.selectComboCode("DUTY_CODE");			// 직책코드
			// 공통코드 조회(테이블명, value컬럼, name컬럼)
			List dept_code = DeptBiz.selectComboCodeEtc("COM_DEPT","DEPT_CODE","DEPT_NAME","3");	// 부서코드
			
			mav.addObject("RESULT", "");
			mav.addObject("USE_YN", use_yn);				// 사용여부
			mav.addObject("DEPT_CODE", dept_code);			// 부서코드
			mav.addObject("POSITION_CODE", position_code);	// 직위코드
			mav.addObject("DUTY_CODE", duty_code);			// 직책코드
			
		} catch (Exception e) {
			logger.error(e, e);
		}
		return mav;
	}
	
	/**
	 * 사원정보관리 : 조회된 목록을 화면으로 retuen
	 * @param  request (
	 *
	 *                 )
	 * @param  response
	 * @return mav	   (COM_DEPT : 부서관리)
	 * 2011. 1. 26.
	 * @throws Exception 
	 */
	public ModelAndView result_1st(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ModelAndView mav = null;
		
		try{
			mav = new ModelAndView();
			mav.setViewName("/result/result_1st");	
			HashMap map = WebUtil.parseRequestMap(request); 
			
			/***** 그리드의 페이지 클릭시 						 *****/
			/***** 검색조건에 한글조회값이 있다면 해당 필드만 decode	 *****/  
			if("grid_page".equals(request.getParameter("div"))){
//				map.put("src_kor_name",comUtil.getDecodingUTF(request.getParameter("src_kor_name")));
//				map.put("src_dept_name",comUtil.getDecodingUTF(request.getParameter("src_dept_name")));
			}
			
			/***** paging *****/ 
			int limit = 0;
			if((String)map.get("limit") != null)
				limit = Integer.parseInt((String)map.get("limit"));
			int start = 0;
			if((String)map.get("start") != null)
				start = Integer.parseInt((String)map.get("start"));
			
			map.put("limit", limit+start); 
			
			List result = EmployeeBiz.selectEmployee(map);					// DB에서 목록조회
			
			/***** 조회된 결과를 JSON형식으로 screen에 Return *****/
			JSONArray jsonArray = JSONArray.fromObject(result);
			HashMap<String,Object> mapResult = new HashMap<String, Object>();
			mapResult.put("success", "true");								// 성공여부
			mapResult.put("message", "Loaded data");						// message
			
			mapResult.put("data_1st", jsonArray);								// 조회된 결과값
			mapResult.put("total_1st", EmployeeBiz.selectEmployeeCount(map));	// 목록의 총갯수 조회
			JSONObject jsonObject = JSONObject.fromObject(mapResult);		// JSON형식으로 설정
			mav.addObject("RESULT_1ST", jsonObject);							// 조회된 결과값을 담기
			
		}catch(Exception ex){
			logger.error(ex.getMessage());
		}
		
		return mav;
	}
	
	/**
	 * 사원정보관리 상세조회 : 조회된 목록을 화면으로 retuen
	 * @param  request ( emp_num : 사번 )
	 * @param  response
	 * @return mav	   (COM_EMP_INFO 사원정보)
	 * 2011. 2. 9.
	 */
	public ModelAndView employeeDetail(HttpServletRequest request, HttpServletResponse response) {
		
		ModelAndView mav = new ModelAndView();
		
		try {
			mav.setViewName("/result/result_1st");	
			
			// 조회조건 설정
			HashMap paramMap = WebUtil.parseRequestMap(request); 

			// 상세조회			
			HashMap result = EmployeeBiz.selectEmployeebyPK(paramMap);		// DB에서 목록조회
			JSONArray jsonArray = JSONArray.fromObject(result);
			
			// 조회된 결과를 JSON형식으로 screen에 Return
			HashMap<String,Object> mapResult = new HashMap<String, Object>();
			mapResult.put("success", "true");							// 성공여부
			mapResult.put("message", "Loaded data");					// message
			mapResult.put("data", jsonArray);							// 조회된 결과값
			JSONObject jsonObject = JSONObject.fromObject(mapResult);	// JSON형식으로 설정
	
			// 조회결과를 mav에 담기
			mav.addObject("RESULT", jsonObject);	// 사원정보관리 상세조회 결과
			
		} catch (Exception e) {
			logger.error(e, e);
		}
		return mav;
	}
	
	
	/**
	 * 사원정보관리 입력,수정 
	 * @param  request (COM_EMP_INFO 사원정보)
	 * @param  response
	 * @return mav	   (COM_EMP_INFO 사원정보)
	 * 2011. 2. 11.
	 */
	public ModelAndView updateEmployee(HttpServletRequest request, HttpServletResponse response)throws Exception{
		
		ModelAndView mav = new ModelAndView();
		JSONObject jsonObject = new JSONObject();
		HashMap<String,Object> mapResult = new HashMap<String, Object>();
		
		try {
			
			mav = new ModelAndView();
			mav.setViewName("/result/result_1st");	
			HashMap paramMap = WebUtil.parseRequestMap(request); 
			
			/***** session 정보 *****/
			HashMap adminMap = (HashMap)request.getSession().getAttribute(SGConfigManager.getString("common.session.admin.name"));
			paramMap.put("final_mod_id", (String)adminMap.get("ADMIN_ID"));	// 로그인 ID
			
			//첨부파일
			//SGFileBean sgfb = new SGFileBean("");			
			//WebUtil.processMultipart(request, sgfb, paramMap); 
			
			String check = EmployeeBiz.updateEmployee(paramMap);			// 저장 및 수정

			List result = EmployeeBiz.selectEmployee(paramMap);				// DB에서 목록조회
			JSONArray jsonArray = JSONArray.fromObject(result);
			
			// 조회된 결과 및 message
			mapResult.put("success", "true");									// 성공여부
			mapResult.put("message", "Loaded data");							// message
			mapResult.put("total_1st", EmployeeBiz.selectEmployeeCount(paramMap));	// 목록의 총갯수 조회
			mapResult.put("data_1st", jsonArray);									// 조회된 결과값
			jsonObject = JSONObject.fromObject(mapResult);						// JSON형식으로 설정
			
		} catch (Exception e) {
			mapResult.put("success", "false");						// 성공여부
			mapResult.put("message", e.toString());					// message
			logger.error(e, e);
			e.printStackTrace();
		} finally{
			
		}
		
		mav.addObject("RESULT_1ST", jsonObject);						// 조회된 결과값을 담기
		
		return mav;
	}
	
	/**
	 * 사원정보관리  팝업
	 * @param  request 
	 * @param  response
	 * @return mav	   (COM_EMP_INFO : 사원정보)
	 * 2011. 4. 11.
	 * @throws Exception 
	 */
	public ModelAndView employeePopList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ModelAndView mav = null;
		
		try{
			mav = new ModelAndView();
			mav.setViewName("/result/result_1st");	
			HashMap map = WebUtil.parseRequestMap(request); 
			
			/***** 그리드의 페이지 클릭시 						 *****/
			/***** 검색조건에 한글조회값이 있다면 해당 필드만 decode	 *****/  
			if("grid_page".equals(request.getParameter("div"))){
//				map.put("src_kor_name",comUtil.getDecodingUTF(request.getParameter("src_kor_name")));
//				map.put("src_dept_name",comUtil.getDecodingUTF(request.getParameter("src_dept_name")));
			}
			
			/***** paging *****/ 
			int limit = 0;
			if((String)map.get("limit") != null)
				limit = Integer.parseInt((String)map.get("limit"));
			int start = 0;
			if((String)map.get("start") != null)
				start = Integer.parseInt((String)map.get("start"));
			
			
			 
			
			map.put("limit", limit+start); 
			
			List result = EmployeeBiz.selectEmployeePop(map);						// DB에서 목록조회
			
			/***** 조회된 결과를 JSON형식으로 screen에 Return *****/
			JSONArray jsonArray = JSONArray.fromObject(result);
			HashMap<String,Object> mapResult = new HashMap<String, Object>();
			mapResult.put("success", "true");										// 성공여부
			mapResult.put("message", "Loaded data");								// message
			
			
			mapResult.put("data_1st_pop", jsonArray);								// 조회된 결과값
			mapResult.put("total_1st_pop", EmployeeBiz.selectEmployeePopCount(map));// 목록의 총갯수 조회
			JSONObject jsonObject = JSONObject.fromObject(mapResult);				// JSON형식으로 설정
			mav.addObject("RESULT_1ST", jsonObject);								// 조회된 결과값을 담기
			
 
		}catch(Exception ex){
			logger.error(ex.getMessage());
		}
		
		return mav;
	}
	
}