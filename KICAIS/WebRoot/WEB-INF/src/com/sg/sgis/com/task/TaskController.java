/**
 *  Class Name  : TaskController.java
 *  Description : 타스크관리 Controller
 *  Modification Information
 *
 *  수정일                   수정자               수정내용
 *  -------      --------   ---------------------------
 *  2011. 3. 11. 고기범              최초 생성
 *
 *  @author 고기범
 *  @since 2011. 3. 11.
 *  @version 1.0
 *  @see 
 * 
 *  Copyright (C) 2011 by SG All right reserved.
 */
package com.sg.sgis.com.task;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.servlet.ModelAndView;

import com.sg.sgis.com.sgisCode.SgisCodeBiz;
import com.sg.sgis.util.CommonUtil;
import com.signgate.core.web.controller.SGUserController;
import com.signgate.core.web.util.WebUtil;

public class TaskController extends SGUserController{

protected final Log logger = LogFactory.getLog(getClass());
	
	CommonUtil comUtil = new CommonUtil();
	
	// BIZ경로 설정
	private TaskBiz TaskBiz; 
	public void setTaskBiz(TaskBiz taskBiz){
		this.TaskBiz = taskBiz;
	}
	
	// 공통코드 BIZ경로 설정
	private SgisCodeBiz sgisCodeBiz;
	public void setSgisCodeBiz(SgisCodeBiz sgisCodeBiz) {
		this.sgisCodeBiz = sgisCodeBiz;
	} 
	
	/**
	 * 타스크관리 조회
	 * @param  request
	 * @param  response
	 * @return mav		(공통코드 목록)
	 * 2011. 1. 26.
	 */
	public ModelAndView taskList(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = null;
		
		try {
			mav = new ModelAndView();
			
			// 공통코드 조회
			List task_group_code = sgisCodeBiz.selectComboCode("TASK_GROUP_CODE");	// 타스크코드
			List yesno_code = sgisCodeBiz.selectComboCode("YESNO_CODE");			// 사용여부

			mav.addObject("TASK_GROUP_CODE", task_group_code);	// 타스크그룹코드
			mav.addObject("YESNO_CODE", yesno_code);			// 사용여부
			
		} catch (Exception e) {
			logger.error(e, e);
			e.printStackTrace();
		}
		return mav;
	}
	
	/**
	 * 타스크관리 : 조회된 목록을 화면으로 retuen
	 * @param  request (
	 *  			    SRC_TASK_GROUP_CODE : 검색_타스크그룹코드
	 *                 ,SRC_TASK_GROUP_NAME	: 검색_타스크그룹명
	 *                 ,SRC_TASK_NAME	    : 검색_타스크이름
	 *                 )
	 * @param  response
	 * @return mav	   (COM_TASK_INFO : 타스크정보관리)
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
			if("grid_page".equals(request.getParameter("div"))){
				paramMap.put("src_task_name",comUtil.getDecodingUTF(request.getParameter("src_task_name")));
			}
			
			/***** paging *****/ 
			int limit = 0;
			if((String)paramMap.get("limit") != null)
				limit = Integer.parseInt((String)paramMap.get("limit"));
			int start = 0;
			if((String)paramMap.get("start") != null)
				start = Integer.parseInt((String)paramMap.get("start"));
			
			paramMap.put("limit", limit+start);  
			
			
			/***** DB에서 목록조회 *****/
			List result = TaskBiz.selectTask(paramMap);			
			
			/***** 조회된 결과를 JSON형식으로 screen에 Return *****/
			JSONArray jsonArray = JSONArray.fromObject(result);
			HashMap<String,Object> mapResult = new HashMap<String, Object>();
			mapResult.put("success", "true");								// 성공여부
			mapResult.put("message", "Loaded data");						// message
			
			mapResult.put("data_1st", jsonArray);							// 조회된 결과값
			mapResult.put("total_1st", TaskBiz.selectTaskCount(paramMap)); 	// 목록의 총갯수 조회
			JSONObject jsonObject = JSONObject.fromObject(mapResult);		// JSON형식으로 설정
			mav.addObject("RESULT_1ST", jsonObject);						// 조회된 결과값을 담기
			
		}catch(Exception ex){
			logger.error(ex.getMessage());
		}
		
		return mav;
	}
	
	/**
	 * 타스크코드 중복체크
	 * @param  request (
	 *  			    TASK_GROUP_CODE : 타스크그룹코드
	 *                 ,TASK_CODE 		: 타스크코드
	 *                 )
	 * @return String  (Y : 사용가능, N : 사용불가)
	 * 2011. 3. 15.
	 */
	public ModelAndView checkTaskCode(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = null;
		
		try {
			mav = new ModelAndView();
			mav.setViewName("/result/result_1st");	
			HashMap paramMap = WebUtil.parseRequestMap(request); 
			
			// 타스크코드 중복체크
			String checkTaskCode = TaskBiz.checkTaskCode(paramMap);
			
			// 타스크코드 중복체크 결과를 return 
			HashMap<String,Object> mapResult = new HashMap<String, Object>();
			mapResult.put("CHECK_TASK_CODE", checkTaskCode);				// 타스크코드 사용가능여부
			JSONObject jsonObject = JSONObject.fromObject(mapResult);		// JSON형식으로 설정
			mav.addObject("RESULT_1ST", jsonObject);
			
		} catch (Exception e) {
			logger.error(e, e);
		}
		return mav;
	}
	
	
	/**
	 * 타스크정보관리 등록, 수정
	 * @param  request  ( TASK_CODE			  : 타스크코드
						, TASK_GROUP_CODE	  : 타스크그룹코드
						, TASK_GROUP_NAME	  : 타스크그룹고트
						, TASK_NAME			  : 타스크명
						, TASK_DESC			  : 타스크설명
						, NOTE				  : 비고
						, TASK_INFO_SEQ		  : 순번
						, USE_YN			  : 사용여부
					    , SRC_TASK_CODE       : 검색_타스크코드
					    , SRC_TASK_GROUP_CODE : 검색_타스크그룹코드
					    , SRC_TASK_NAME       : 검색_타스크명
					    , START				  : 검색_시작페이지
					    , LIMIT	  			  : 검색_종료페이지
					    )
	 * @return response (COM_TASK_INFO : 타스크정보)
	 * 2011. 3. 14.
	 */
	public ModelAndView updateTask(HttpServletRequest request, HttpServletResponse response) {
		
		ModelAndView mav = new ModelAndView();
		JSONObject jsonObject = new JSONObject();
		HashMap<String,Object> mapResult = new HashMap<String, Object>();
		
		try {

			mav = new ModelAndView();
			mav.setViewName("/result/result_1st");	
			
			/***** 조회조건 및 parameter설정 *****/
			HashMap paramMap = WebUtil.parseRequestMap(request); 
			
			/***** 저장 및 수정 *****/
			boolean deptRegResult = TaskBiz.updateTask(paramMap, request);		 
			
			/***** 목록조회 *****/
			List result = TaskBiz.selectTask(paramMap);					
			
			/***** 조회된 결과를 JSON형식으로 screen에 Return *****/
			JSONArray jsonArray = JSONArray.fromObject(result);
			mapResult.put("success", "true");								// 성공여부
			mapResult.put("message", "Loaded data");						// message
			mapResult.put("total_1st", TaskBiz.selectTaskCount(paramMap));  // 목록의 총갯수 조회
			mapResult.put("data_1st", jsonArray);							// 조회된 결과값
			jsonObject = JSONObject.fromObject(mapResult);					// JSON형식으로 설정
			
		} catch (Exception e) {
			logger.error(e, e);
			e.printStackTrace();
		} finally{
			
		}
		
		mav.addObject("RESULT_1ST", jsonObject);						// 조회된 결과값을 담기
		
		return mav;
	}
	
	/**
	 * 타스크 산출물
	 * @param  request  ( TASK_CODE			  : 타스크코드
						, TASK_GROUP_CODE	  : 타스크그룹코드
					    , START				  : 검색_시작페이지
					    , LIMIT	  			  : 검색_종료페이지
					    )
	 * @return response (COM_TASK_REPORT_INFO : 타스크별 산출물관리)
	 * 2011. 3. 14.
	 */
	public ModelAndView taskReportInfoResult(HttpServletRequest request, HttpServletResponse response) {
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
			 
			List result_edit_1st = TaskBiz.selectTaskReportInfo(map);		
		
			JSONArray jsonArray = new JSONArray();
			jsonArray = JSONArray.fromObject(result_edit_1st);		
			
			mapResult.put("data_edit_1st", jsonArray);
			mapResult.put("total_edit_1st", TaskBiz.selectTaskReportInfoCnt(map));
			
			JSONObject jsonObject = JSONObject.fromObject(mapResult);	 
			mav.addObject("RESULT_EDIT_1ST", jsonObject);	

		}catch(Exception ex){
			logger.error(ex.getMessage());
		}
		
		return mav;
	}
	
	/**
	 * 타스크정보관리 등록, 수정
	 * @param  request  ( TASK_CODE			  : 타스크코드
						, TASK_GROUP_CODE	  : 타스크그룹코드
						, TASK_GROUP_NAME	  : 타스크그룹고트
						, TASK_NAME			  : 타스크명
						, TASK_DESC			  : 타스크설명
						, NOTE				  : 비고
						, TASK_INFO_SEQ		  : 순번
						, USE_YN			  : 사용여부
					    , SRC_TASK_CODE       : 검색_타스크코드
					    , SRC_TASK_GROUP_CODE : 검색_타스크그룹코드
					    , SRC_TASK_NAME       : 검색_타스크명
					    , START				  : 검색_시작페이지
					    , LIMIT	  			  : 검색_종료페이지
					    )
	 * @return response (COM_TASK_INFO : 타스크정보)
	 * 2011. 3. 14.
	 */
	public ModelAndView updateTaskReportInfo(HttpServletRequest request, HttpServletResponse response) {
		
		ModelAndView mav = new ModelAndView();
		JSONObject jsonObject = new JSONObject();
		HashMap<String,Object> mapResult = new HashMap<String, Object>();
		
		try {

			mav = new ModelAndView();
			mav.setViewName("/result/result_edit_1st");	
			
			/***** 조회조건 및 parameter설정 *****/
			HashMap paramMap = WebUtil.parseRequestMap(request); 
			
			/***** 저장 및 수정 *****/
			boolean deptRegResult = TaskBiz.updateTask(paramMap, request);		 
			
			/***** 목록조회 *****/
//			List result = TaskBiz.selectTask(paramMap);		
			List result = null;
			
			/***** 조회된 결과를 JSON형식으로 screen에 Return *****/
			JSONArray jsonArray = JSONArray.fromObject(result);
			mapResult.put("success", "true");								// 성공여부
			mapResult.put("message", "Loaded data");						// message
			mapResult.put("total_edit_1st", 10);  // 목록의 총갯수 조회
			mapResult.put("data_edit_1st", jsonArray);							// 조회된 결과값
			jsonObject = JSONObject.fromObject(mapResult);					// JSON형식으로 설정
			
		} catch (Exception e) {
			logger.error(e, e);
			e.printStackTrace();
		} finally{
			
		}
		
		mav.addObject("RESULT_EDIT_1ST", jsonObject);						// 조회된 결과값을 담기
		
		return mav;
	}
	
	public ModelAndView taskInfoPop(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = null;
		
		try {
			mav = new ModelAndView();

			// 공통코드 조회
			List task_group_code = sgisCodeBiz.selectComboCode("TASK_GROUP_CODE");	// 타스크코드

			mav.addObject("TASK_GROUP_CODE", task_group_code);	// 타스크그룹코드
			
			
		} catch (Exception e) {
			logger.error(e, e);
		}
		return mav;
	}

	
	/**
	 * 이슈정보관리  팝업
	 * @param  request 
	 * @param  response
	 * @return mav	   (COM_EMP_INFO : 사원정보)
	 * 2011. 4. 11.
	 * @throws Exception 
	 */
	public ModelAndView taskInfoPopList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ModelAndView mav = null;
		
		try{
			mav = new ModelAndView();
			mav.setViewName("/result/result_1st");	
			HashMap map = WebUtil.parseRequestMap(request); 

			// 공통코드 조회
			List task_group_code = sgisCodeBiz.selectComboCode("TASK_GROUP_CODE");	// 타스크코드

			mav.addObject("TASK_GROUP_CODE", task_group_code);	// 타스크그룹코드
			
			
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
			
			List result = TaskBiz.selectTaskPop(map);						// DB에서 목록조회
			
			/***** 조회된 결과를 JSON형식으로 screen에 Return *****/
			JSONArray jsonArray = JSONArray.fromObject(result);
			HashMap<String,Object> mapResult = new HashMap<String, Object>();
			mapResult.put("success", "true");										// 성공여부
			mapResult.put("message", "Loaded data");								// message
			
			mapResult.put("data_1st_pop", jsonArray);								// 조회된 결과값
			mapResult.put("total_1st_pop", TaskBiz.selectTaskPopCount(map));// 목록의 총갯수 조회
			JSONObject jsonObject = JSONObject.fromObject(mapResult);				// JSON형식으로 설정
			mav.addObject("RESULT_1ST", jsonObject);								// 조회된 결과값을 담기
			
		}catch(Exception ex){
			logger.error(ex.getMessage());
		}
		
		return mav;
	}		
}
