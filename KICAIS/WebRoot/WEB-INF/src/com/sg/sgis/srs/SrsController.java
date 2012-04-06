/**
 *  Class Name  : TechServiceController
 *  Description : 기술지원정보 Controller
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

package com.sg.sgis.srs;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.servlet.ModelAndView;

import com.sg.sgis.com.dept.DeptBiz;
import com.sg.sgis.com.employee.EmployeeBiz;
import com.sg.sgis.com.sgisCode.SgisCodeBiz;
import com.sg.sgis.pjt.pjtManage.PjtManageBiz;
import com.sg.sgis.util.CommonUtil;
import com.signgate.core.config.SGConfigManager;
import com.signgate.core.web.controller.SGUserController;
import com.signgate.core.web.util.WebUtil;

public class SrsController extends SGUserController{

	protected final Log logger = LogFactory.getLog(getClass());
	
	CommonUtil comUtil = new CommonUtil();
	
	// BIZ경로 설정
	private SrsMngBiz srsMngBiz;


	public SrsMngBiz getSrsMngBiz() {
		return srsMngBiz;
	}

	public void setSrsMngBiz(SrsMngBiz srsMngBiz) {
		this.srsMngBiz = srsMngBiz;
	}	
		
	
	
	private DeptBiz deptBiz;
	
	public DeptBiz getDeptBiz() {
		return deptBiz;
	}

	public void setDeptBiz(DeptBiz deptBiz) {
		this.deptBiz = deptBiz;
	}

	
	// 공통코드 BIZ경로 설정
	private SgisCodeBiz sgisCodeBiz;
	
	
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
	 
	// 로그인 사용자정보
	 private EmployeeBiz EmployeeBiz; 
		public void setEmployeeBiz(EmployeeBiz employeeBiz){
			this.EmployeeBiz = employeeBiz;
		}	 
	
	/**
	 * 기술지원요청 정보 조회
	 * @param  request
	 * @param  response
	 * @return mav		(공통코드 목록)
	 * 2011. 1. 26.
	 */
	public ModelAndView srsInfoMngList(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = null;
		
		try {
			mav = new ModelAndView();
			
			  HashMap adminMap = (HashMap)request.getSession().getAttribute(SGConfigManager.getString("common.session.admin.name"));
			   
			   mav.addObject("admin_id",(String)adminMap.get("ADMIN_ID"));
			   mav.addObject("admin_nm",(String)adminMap.get("ADMIN_NM"));
			   mav.addObject("sabun",(String)adminMap.get("SABUN"));
			   mav.addObject("dept_code",pjtManageBiz.getDeptCode((String)adminMap.get("SABUN")));
			   mav.addObject("dept_nm", pjtManageBiz.getDeptNm(pjtManageBiz.getDeptCode((String)adminMap.get("SABUN"))));

			   String emp_num   =(String)adminMap.get("ADMIN_ID");
				String dept_code = pjtManageBiz.getDeptCode((String)adminMap.get("SABUN"));
				String groups	 = (String)adminMap.get("GROUPS");
				
				/*보기권한 임원-전체, 팀장-팀의데이터, 팀원-본인데이터  by ibyo:2011.06.08*/
				String getAuthority = pjtManageBiz.getAuthority(emp_num);				   
			   
			   
			// 공통코드 조회
			List srs_type_code = sgisCodeBiz.selectComboCode("SRS_CLS_CODE");			// 기술지원범주
		   	List srs_status = sgisCodeBiz.selectComboCode("SRS_STATUS_CODE");			// 상태

			
			HashMap empMap = new HashMap();
			empMap.put("start", "0");  
			empMap.put("limit", "1");  
			empMap.put("Lsrc_emp_num", (String)adminMap.get("SABUN"));  
			List empResult = EmployeeBiz.selectEmployee(empMap);						// 세션의 사원상세정보			
			
			empMap.put("dept_code", "30001");
			List teamLeader_1 = srsMngBiz.selectTeamLeader(empMap);						//기술지원팀 팀장조회	
			
			List srsMgrDept2 = srsMngBiz.selectSrsMgrDept2();							// 2차 기술지원부서정보
			
			   
			HashMap empInfo = new HashMap();
			empInfo = (HashMap)empResult.get(0);
			
			HashMap mapData = null;
			int deptChkCnt =0;
			for(int i = 0; i < srsMgrDept2.size(); i++)
			{
				mapData = (HashMap)srsMgrDept2.get(i);

				if(((String)empInfo.get("DEPT_CODE")).equals((String)mapData.get("DEPT_CODE")))
				{
					deptChkCnt ++;
				}
			}	
			
			if(getAuthority.equals("사장") || getAuthority.equals("본부장") || getAuthority.equals("연구소장"))
			{
					mav.addObject("SRSEMPGUBUN", "ZZ");		
			}			
			else
			{
				if(deptChkCnt == 0 && !((String)empInfo.get("DEPT_CODE")).equals("30001"))
				{
					mav.addObject("SRSEMPGUBUN", "AA");		//의뢰자
				}else if(((String)empInfo.get("DEPT_CODE")).equals("30001"))		//기술지원팀
				{
					if(getAuthority.equals("팀장") || getAuthority.equals("팀장대행"))
					{
						mav.addObject("SRSEMPGUBUN", "BB");		//1차팀장
					}else
					{
						mav.addObject("SRSEMPGUBUN", "CC");		//1차팀원
					}
				}else
				{
					if(getAuthority.equals("팀장") || getAuthority.equals("팀장대행"))
					{
						mav.addObject("SRSEMPGUBUN", "DD");		//2차팀장
					}else
					{
						mav.addObject("SRSEMPGUBUN", "EE");		//2차팀원
					}
				}
			}
		
			mav.addObject("SRS_TYPE_CODE", srs_type_code);	
			mav.addObject("SRS_STATUS_CODE", srs_status);

			mav.addObject("EMPINFO", empResult);
			mav.addObject("TEAMLEADER_1", teamLeader_1);
			
			mav.addObject("SRSMGRDEPT2", srsMgrDept2);
			
		} catch (Exception e) {
			logger.error(e, e);
			e.printStackTrace();
		}
		return mav;
	}

	/**
	 * 기술지원요청 정보관리 : 조회된 목록을 화면으로 retuen
	 * @param  request 
	 * @param  response
	 * 2011. 1. 26.
	 */
	
	public ModelAndView result(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = null;
		
		try{
			mav = new ModelAndView();
			mav.setViewName("/result/result_1st");	
			HashMap paramMap = WebUtil.parseRequestMap(request); 
			
			/***** 그리드의 페이지 클릭시 						 *****/
			/***** 검색조건에 한글조회값이 있다면 해당 필드만 decode	 *****/  
			/*
			if("grid_page".equals(request.getParameter("div"))){
				paramMap.put("src_task_name",comUtil.getDecodingUTF(request.getParameter("src_task_name")));
			}
			*/
			
			/***** paging *****/ 
			int limit = 0;
			if((String)paramMap.get("limit") != null)
				limit = Integer.parseInt((String)paramMap.get("limit"));
			int start = 0;
			if((String)paramMap.get("start") != null)
				start = Integer.parseInt((String)paramMap.get("start"));
			
			paramMap.put("limit", limit+start);  
			
			
			/***** DB에서 목록조회 *****/
			HashMap adminMap = (HashMap)request.getSession().getAttribute(SGConfigManager.getString("common.session.admin.name"));
			String emp_num   =(String)adminMap.get("ADMIN_ID");
			String dept_code = pjtManageBiz.getDeptCode((String)adminMap.get("SABUN"));
			String groups	 = (String)adminMap.get("GROUPS");
			
			/*보기권한 임원-전체, 팀장-팀의데이터, 팀원-본인데이터  by ibyo:2011.06.08*/
			String getAuthority = pjtManageBiz.getAuthority(emp_num);				 	
	
			String src_srs_emp_gubun = nullToBlank((String)paramMap.get("src_srs_emp_gubun"));
			String src_srs_emp_duty_code = nullToBlank((String)paramMap.get("src_srs_emp_duty_code"));
			
			
			if(getAuthority.equals("사장") || getAuthority.equals("본부장") || getAuthority.equals("연구소장")){

			}else
			{	
				if(src_srs_emp_gubun.equals("AA") && (getAuthority.equals("팀장") || getAuthority.equals("팀장대행")) ) //의뢰인의 팀장,사업팀장일경우
				{
					
					paramMap.put("src_srs_emp_gubun", "AA_TEAM");
					paramMap.put("session_sabun_dept_code", pjtManageBiz.getDeptCode((String)adminMap.get("SABUN"))); //로그인 사번의 부서 팀원들만 조회	
				}else if(src_srs_emp_gubun.equals("AA")) //의뢰인 일경우
				{
	  
					paramMap.put("session_sabun_dept_code", (String)adminMap.get("SABUN")); 		
				}else if(src_srs_emp_gubun.equals("BB") ) //1차팀장
				{
					
					paramMap.put("session_sabun_dept_code", pjtManageBiz.getDeptCode((String)adminMap.get("SABUN"))); //로그인 사번의 부서 팀원들만 조회
				}else if(src_srs_emp_gubun.equals("CC") ) //1차팀원
				{
					
					paramMap.put("session_sabun_dept_code", (String)adminMap.get("SABUN"));
				}else if(src_srs_emp_gubun.equals("DD") ) //2차팀장
				{
					
					paramMap.put("session_sabun_dept_code", pjtManageBiz.getDeptCode((String)adminMap.get("SABUN"))); //로그인 사번의 부서 팀원들만 조회
				}else if(src_srs_emp_gubun.equals("EE") ) //2차팀원
				{
					
					paramMap.put("session_sabun_dept_code", (String)adminMap.get("SABUN"));
				}
			}
			 
			   
			List result = srsMngBiz.selectSrsInfo(paramMap);			
			
			/***** 조회된 결과를 JSON형식으로 screen에 Return *****/
			JSONArray jsonArray = JSONArray.fromObject(result);
			HashMap<String,Object> mapResult = new HashMap<String, Object>();
			mapResult.put("success", "true");								// 성공여부
			mapResult.put("message", "Loaded data");						// message
			
			mapResult.put("data_1st", jsonArray);							// 조회된 결과값
			mapResult.put("total_1st", srsMngBiz.selectSrsInfoCount(paramMap)); 	// 목록의 총갯수 조회
			JSONObject jsonObject = JSONObject.fromObject(mapResult);		// JSON형식으로 설정
			mav.addObject("RESULT_1ST", jsonObject);						// 조회된 결과값을 담기
			
		}catch(Exception ex){
			logger.error(ex.getMessage());
		}
		
		return mav;
	}
	
	
	
	/**
	 * 기술지원요청 저장,수정
	 */
	public ModelAndView actionSrsInfoMng(HttpServletRequest request, HttpServletResponse response)throws Exception{
		
		ModelAndView mav = null;
		
		try {
			mav = new ModelAndView();
			mav.setViewName("/result/result_1st");	
			HashMap paramMap = WebUtil.parseRequestMap(request); 			
		
			/***** session 정보 *****/
			HashMap adminMap = (HashMap)request.getSession().getAttribute(SGConfigManager.getString("common.session.admin.name"));
			paramMap.put("final_mod_id", (String)adminMap.get("SABUN"));	// 로그인 ID

			
			String[] req_item_str = (paramMap.get("req_item_str")).toString().split("^");
			
//System.out.println("--req_item_str--"+req_item_str);			
			/***** 저장 및 수정 *****/
			List srs_status = sgisCodeBiz.selectComboCode("SRS_STATUS_CODE");				// 상태
			
			boolean actSrInfoResult = srsMngBiz.actionSrsInfoMng(paramMap, request, srs_status);	
			
			
			/***** paging *****/ 
			int limit = 0;
			if((String)paramMap.get("limit") != null)
				limit = Integer.parseInt((String)paramMap.get("limit"));
			int start = 0;
			if((String)paramMap.get("start") != null)
				start = Integer.parseInt((String)paramMap.get("start"));
			
			paramMap.put("limit", limit+start); 					
			 
			/***** DB에서 목록조회 *****/
			String 	src_srs_emp_gubun = nullToBlank((String)paramMap.get("src_srs_emp_gubun"));
			String src_srs_emp_duty_code = nullToBlank((String)paramMap.get("src_srs_emp_duty_code"));
			
			
			if(src_srs_emp_gubun.equals("AA") && src_srs_emp_duty_code.equals("200")) //의뢰인의 팀장일경우
			{
				
				paramMap.put("src_srs_emp_gubun", "AA_TEAM");
				paramMap.put("session_sabun_dept_code", pjtManageBiz.getDeptCode((String)adminMap.get("SABUN"))); //로그인 사번의 부서 팀원들만 조회	
			}else if(src_srs_emp_gubun.equals("AA")) //의뢰인 일경우
			{
  
				paramMap.put("session_sabun_dept_code", (String)adminMap.get("SABUN")); 		
			}else if(src_srs_emp_gubun.equals("BB") ) //1차팀장
			{
				
				paramMap.put("session_sabun_dept_code", pjtManageBiz.getDeptCode((String)adminMap.get("SABUN"))); //로그인 사번의 부서 팀원들만 조회
			}else if(src_srs_emp_gubun.equals("CC") ) //1차팀원
			{
				
				paramMap.put("session_sabun_dept_code", (String)adminMap.get("SABUN"));
			}else if(src_srs_emp_gubun.equals("DD") ) //2차팀장
			{
				
				paramMap.put("session_sabun_dept_code", pjtManageBiz.getDeptCode((String)adminMap.get("SABUN"))); //로그인 사번의 부서 팀원들만 조회
			}else if(src_srs_emp_gubun.equals("EE") ) //2차팀원
			{
				
				paramMap.put("session_sabun_dept_code", (String)adminMap.get("SABUN"));
			}
			
 
			
			List result = srsMngBiz.selectSrsInfo(paramMap);			
			
			/***** 조회된 결과를 JSON형식으로 screen에 Return *****/
			JSONArray jsonArray = JSONArray.fromObject(result);
			HashMap<String,Object> mapResult = new HashMap<String, Object>();
			mapResult.put("success", "true");								// 성공여부
			mapResult.put("message", "Loaded data");						// message
			
			mapResult.put("data_1st", jsonArray);							// 조회된 결과값
			mapResult.put("total_1st", srsMngBiz.selectSrsInfoCount(paramMap)); 	// 목록의 총갯수 조회
			JSONObject jsonObject = JSONObject.fromObject(mapResult);		// JSON형식으로 설정
			mav.addObject("RESULT_1ST", jsonObject);		
			
			
		}catch (Exception e){
			logger.error(e, e);
		}finally{
			
		}
			return mav;
	}		
	
	


	
	
	/**
	 * 기술지원요청 검토관리 조회
	 * @param  request
	 * @param  response
	 * @return mav		
	 * 2011. 1. 26.
	 */
	public ModelAndView srsReviewMngList(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = null;
		
		try {
			mav = new ModelAndView();
			//mav.setViewName("/dev/csrInfo/csrInfoReviewMngList");
			
			  HashMap adminMap = (HashMap)request.getSession().getAttribute(SGConfigManager.getString("common.session.admin.name"));
			   
			   mav.addObject("admin_id",(String)adminMap.get("ADMIN_ID"));
			   mav.addObject("admin_nm",(String)adminMap.get("ADMIN_NM"));
			   mav.addObject("sabun",(String)adminMap.get("SABUN"));
			   mav.addObject("dept_code",pjtManageBiz.getDeptCode((String)adminMap.get("SABUN")));
			   mav.addObject("dept_nm", pjtManageBiz.getDeptNm(pjtManageBiz.getDeptCode((String)adminMap.get("SABUN"))));

			   
			// 공통코드 조회
			List sr_type_code = sgisCodeBiz.selectComboCode("SR_TYPE_CODE");	// 업무요청구분코드
			List request_status_code = sgisCodeBiz.selectComboCode("REQUEST_STATUS_CODE");	// 요청상태코드

			mav.addObject("SR_TYPE_CODE", sr_type_code);	
			mav.addObject("REQUEST_STATUS_CODE", request_status_code);

		} catch (Exception e) {
			logger.error(e, e);
			e.printStackTrace();
		}
		return mav;
	}	
	

	/**
	 * 기술지원요청 검토관리  : 조회된 목록을 화면으로 retuen
	 * @param  request 
	 * @param  response
	 * @return mav	   
	 * 2011. 1. 26.
	 */
	
	public ModelAndView resultReview(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = null;
		
		try{
			mav = new ModelAndView();
			mav.setViewName("/result/result_edit_1st");	
			
			// 공통코드 조회
			List request_status_code = sgisCodeBiz.selectComboCode("REQUEST_STATUS_CODE");	// 요청상태코드

			mav.addObject("REQUEST_STATUS_CODE", request_status_code);	// 요청상태코드			
			
			HashMap paramMap = WebUtil.parseRequestMap(request); 
			
			/***** 그리드의 페이지 클릭시 						 *****/
			/***** 검색조건에 한글조회값이 있다면 해당 필드만 decode	 *****/  
			/*
			if("grid_page".equals(request.getParameter("div"))){
				paramMap.put("src_task_name",comUtil.getDecodingUTF(request.getParameter("src_task_name")));
			}
			*/
			
			/***** paging *****/ 
			int limit = 0;
			if((String)paramMap.get("limit") != null)
				limit = Integer.parseInt((String)paramMap.get("limit"));
			int start = 0;
			if((String)paramMap.get("start") != null)
				start = Integer.parseInt((String)paramMap.get("start"));
			
			paramMap.put("limit", limit+start);  
			
			HashMap adminMap = (HashMap)request.getSession().getAttribute(SGConfigManager.getString("common.session.admin.name"));
			/***** DB에서 목록조회 *****/
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
			
			      
			   List result = srsMngBiz.selectSrsReview(paramMap);			
			
			/***** 조회된 결과를 JSON형식으로 screen에 Return *****/
			JSONArray jsonArray = JSONArray.fromObject(result);
			HashMap<String,Object> mapResult = new HashMap<String, Object>();
			mapResult.put("success", "true");								// 성공여부
			mapResult.put("message", "Loaded data");						// message
			
			mapResult.put("data_edit_1st", jsonArray);							// 조회된 결과값
			mapResult.put("total_edit_1st", srsMngBiz.selectSrsReviewCount(paramMap)); 	// 목록의 총갯수 조회
			JSONObject jsonObject = JSONObject.fromObject(mapResult);		// JSON형식으로 설정
			
			mav.addObject("RESULT_EDIT_1ST", jsonObject);						// 조회된 결과값을 담기
			
		}catch(Exception ex){
			logger.error(ex.getMessage());
		}
		
		return mav;
	}		
	
	

	/**
	 * 팀장조회
	 * @param  request 
	 * @param  response
	 * 2011. 1. 26.
	 */
	
	public ModelAndView selectTeamLeader(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = null;
		
		try{
			mav = new ModelAndView();
			mav.setViewName("/result/result_1st");	
			HashMap paramMap = WebUtil.parseRequestMap(request); 
			
			
			
			/***** DB에서 목록조회 *****/
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
			
			List result = srsMngBiz.selectTeamLeader(paramMap);			
			
			/***** 조회된 결과를 JSON형식으로 screen에 Return *****/
			JSONArray jsonArray = JSONArray.fromObject(result);
			HashMap<String,Object> mapResult = new HashMap<String, Object>();
			mapResult.put("success", "true");								// 성공여부
			mapResult.put("message", "Loaded data");						// message
			
			mapResult.put("data_1st", jsonArray);							// 조회된 결과값
			JSONObject jsonObject = JSONObject.fromObject(mapResult);		// JSON형식으로 설정
			mav.addObject("RESULT_1ST", jsonObject);						// 조회된 결과값을 담기
			
		}catch(Exception ex){
			logger.error(ex.getMessage());
		}
		
		return mav;
	}	
	
	
	public ModelAndView visitNaviPop(HttpServletRequest request, HttpServletResponse response) {
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

	
	public String nullToBlank(String str)	{
		if(str == null) {
			return "";
		}else{
			return str;
		}
	}	
}
