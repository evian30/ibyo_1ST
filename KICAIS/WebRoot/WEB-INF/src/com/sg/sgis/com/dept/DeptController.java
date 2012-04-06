/**
 *  Class Name  : DeptController.java
 *  Description : 부서정보관리 Controller
 *  Modification Information
 *
 *  수정일                   수정자               수정내용
 *  -------      --------   ---------------------------
 *  2011. 1. 26. 고기범              최초 생성
 *  2011. 3. 25  고기범              디자인 변경 및 공통 JS적용에 따른 수정
 *  2011. 4.  1. 고기범		 session 정보 추가
 *
 *  @author 고기범
 *  @since 2011. 1. 26.
 *  @version 1.0
 *  @see 
 * 
 *  Copyright (C) 2011 by SG All right reserved.
 */
package com.sg.sgis.com.dept;

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
import com.sg.sgis.util.CommonUtil;
import com.signgate.core.config.SGConfigManager;
import com.signgate.core.web.controller.SGUserController;
import com.signgate.core.web.util.WebUtil;

public class DeptController extends SGUserController{

	protected final Log logger = LogFactory.getLog(getClass());
	
	CommonUtil comUtil = new CommonUtil();
	
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
 
	/**
	 * 부서정보관리 조회
	 * @param  request
	 * @param  response
	 * @return mav		(공통코드 목록)
	 * 2011. 1. 26.
	 */
	public ModelAndView deptList(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = null;
		
		try {
			mav = new ModelAndView();
			
			// 공통코드 조회
			List yesno_code = sgisCodeBiz.selectComboCode("YESNO_CODE");			// 사용여부
			List dept_level_code = sgisCodeBiz.selectComboCode("DEPT_LEVEL_CODE");	// 부서레벨코드
		
			mav.addObject("YESNO_CODE", yesno_code);			// 사용여부
			mav.addObject("DEPT_LEVEL_CODE", dept_level_code);	// 부서레벨코드
			
		} catch (Exception e) {
			logger.error(e, e);
		}
		return mav;
	}
		
	/**
	 * 부서조회 팝업(초기화면)
	 * @param  request
	 * @param  response
	 * @return mav		(공통코드 목록)
	 * 2011. 3. 8.
	 */
	
	public ModelAndView deptPop(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = null;
		
		try {
			mav = new ModelAndView();

		} catch (Exception e) {
			logger.error(e, e);
		}
		return mav;
	}
	
	/**
	 * 부서조회 팝업
	 * @param  request
	 * @param  response
	 * @return mav		(공통코드 목록)
	 * 2011. 3. 8.
	 */
	
	public ModelAndView deptPopList(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = null;
		
		try {
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
			
			List result = DeptBiz.selectDeptPopList(paramMap);				// DB에서 목록조회
			JSONArray jsonArray = JSONArray.fromObject(result);
			
			// 조회된 결과를 JSON형식으로 screen에 Return
			HashMap<String,Object> mapResult = new HashMap<String, Object>();
			mapResult.put("success", "true");							// 성공여부
			mapResult.put("message", "Loaded data");					// message
			mapResult.put("data_1st_pop", jsonArray);						// 조회된 결과값
			mapResult.put("total_1st_pop",DeptBiz.selectDeptPopListCnt(paramMap));							// 목록의 총갯수 조회
			JSONObject jsonObject = JSONObject.fromObject(mapResult);	// JSON형식으로 설정
			mav.addObject("RESULT_1ST", jsonObject);					// 조회된 결과값을 담기
			
		} catch (Exception e) {
			logger.error(e, e);
		}
		return mav;
	}
	
	/**
	 * 부서정보상세 조회
	 * @param  request
	 * @param  response
	 * @return mav		
	 * 2011. 1. 31.
	 */
	public ModelAndView deptDetail(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = null;
		
		try {
			mav = new ModelAndView();
			mav.setViewName("/com/dept/deptDetail");	
			HashMap paramMap = WebUtil.parseRequestMap(request); 
			
			List result = DeptBiz.selectDeptbyPK(paramMap);			// DB에서 목록조회
			JSONArray jsonArray = JSONArray.fromObject(result);
			
			// 조회된 결과를 JSON형식으로 screen에 Return
			HashMap<String,Object> mapResult = new HashMap<String, Object>();
			mapResult.put("success", "true");								// 성공여부
			mapResult.put("message", "Loaded data");						// message
			mapResult.put("data", jsonArray);								// 조회된 결과값
			JSONObject jsonObject = JSONObject.fromObject(mapResult);		// JSON형식으로 설정
			mav.addObject("RESULT", jsonObject);							// 조회된 결과값을 담기
			
			// 공통코드 조회
//			List com_code = DeptBiz.selectComboCode("YESNO_CODE");	// 사용여부(group_code:YESNO_CODE)
//			
//			mav.addObject("RESULT", "");
//			mav.addObject("COM_CODE", com_code);	// 사용여부

		} catch (Exception e) {
			logger.error(e, e);
		}
		return mav;
	}
	
	/**
	 * 부서정보관리 : 조회된 목록을 화면으로 retuen
	 * @param  request (
	 *  			    DEPT_NAME  : 부서명
	 *                 ,DEPT_LEVEL : 부서레벨 
	 *                 ,USE_YN	  : 사용여부
	 *                 )
	 * @param  response
	 * @return mav	   (COM_DEPT : 부서관리)
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
//			if("grid_page".equals(request.getParameter("div"))){
				//paramMap.put("src_dept_name",comUtil.getDecodingUTF(request.getParameter("src_dept_name")));
//				System.out.println("난. 나나.... -----------------------------------"+paramMap.toString());
//			}
			
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
			List result = DeptBiz.selectDept(paramMap);			
			
			/***** 조회된 결과를 JSON형식으로 screen에 Return *****/
			JSONArray jsonArray = JSONArray.fromObject(result);
			HashMap<String,Object> mapResult = new HashMap<String, Object>();
			mapResult.put("success", "true");								// 성공여부
			mapResult.put("message", "Loaded data");						// message
			
			mapResult.put("data_1st", jsonArray);							// 조회된 결과값
			mapResult.put("total_1st", DeptBiz.selectDeptCount(paramMap));  // 목록의 총갯수 조회
			JSONObject jsonObject = JSONObject.fromObject(mapResult);		// JSON형식으로 설정
			mav.addObject("RESULT_1ST", jsonObject);						// 조회된 결과값을 담기
			
		}catch(Exception ex){
			logger.error(ex.getMessage());
		}
		
		return mav;
	}
	
	/**
	 * 부서정보관리
	 * @param  request
	 * @param  response
	 * @return mav (공통코드 목록)
	 * 2011. 1. 26.
	 */
	public ModelAndView deptManager(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = null;
		
		try {
			mav = new ModelAndView();
			// 공통코드 조회
			List yesno_code = DeptBiz.selectComboCode("YESNO_CODE");			// 사용여부
			List dept_level_code = DeptBiz.selectComboCode("DEPT_LEVEL_CODE");	// 부서레벨코드
		
			mav.addObject("YESNO_CODE", yesno_code);			// 사용여부
			mav.addObject("DEPT_LEVEL_CODE", dept_level_code);	// 부서레벨코드
			
			logger.debug("test");
		} catch (Exception e) {
			logger.error(e, e);
		}
		return mav;
	}
	
	/**
	 * 신규 부서 정보 등록 처리
	 * @param  request
	 * @param  response
	 * @return 
	 * 2011. 1. 26.
	 */
	public ModelAndView deptRegProc(HttpServletRequest request, HttpServletResponse response) {
		
		ModelAndView mav = new ModelAndView();
		JSONObject jsonObject = new JSONObject();
		HashMap<String,Object> mapResult = new HashMap<String, Object>();
		
		try {

			mav = new ModelAndView();
			mav.setViewName("/result/result_1st");	
			
			/***** 조회조건 및 parameter설정 *****/
			HashMap paramMap = WebUtil.parseRequestMap(request); 
			
			/***** session 정보 *****/
			HashMap adminMap = (HashMap)request.getSession().getAttribute(SGConfigManager.getString("common.session.admin.name"));
						
			paramMap.put("final_mod_id", (String)adminMap.get("ADMIN_ID"));	// 로그인 ID
			
			/***** 저장 및 수정 *****/
			boolean deptRegResult = DeptBiz.regNewDept(paramMap);		 
			
			/***** 목록조회 *****/
			List result = DeptBiz.selectDept(paramMap);					
			
			/***** 조회된 결과를 JSON형식으로 screen에 Return *****/
			JSONArray jsonArray = JSONArray.fromObject(result);
			mapResult.put("success", "true");							// 성공여부
			mapResult.put("message", "Loaded data");					// message
			mapResult.put("total_1st", DeptBiz.selectDeptCount(paramMap)); 	// 목록의 총갯수 조회
			mapResult.put("data_1st", jsonArray);							// 조회된 결과값
			jsonObject = JSONObject.fromObject(mapResult);				// JSON형식으로 설정
			
		} catch (Exception e) {
			logger.error(e, e);
		} finally{
			
		}
		
		mav.addObject("RESULT_1ST", jsonObject);						// 조회된 결과값을 담기
		
		return mav;
	}
	
	public ModelAndView emptySearch(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = null;
		
		try {
			mav = new ModelAndView();
			
		} catch (Exception e) {
			logger.error(e, e);
		}
		return mav;
	}
	
}
