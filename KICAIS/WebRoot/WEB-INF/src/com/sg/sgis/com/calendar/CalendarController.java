package com.sg.sgis.com.calendar;

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
import com.sg.sgis.util.CommonUtil;
import com.signgate.core.config.SGConfigManager;
import com.signgate.core.web.controller.SGUserController;
import com.signgate.core.web.util.WebUtil;
 
public class CalendarController extends SGUserController{
	protected final Log logger = LogFactory.getLog(getClass());
	
	private CalendarBiz calendarBiz;
	public void setCalendarBiz(CalendarBiz calendarBiz) {
		this.calendarBiz = calendarBiz;
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
	  
	CommonUtil comUtil = new CommonUtil();
	
	@SuppressWarnings("unchecked")
	public ModelAndView calendar(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = null;

		try {
			mav = new ModelAndView();
			HashMap map = WebUtil.parseRequestMap(request);
			HashMap adminMap = (HashMap)request.getSession().getAttribute(SGConfigManager.getString("common.session.admin.name"));
					map.put("admin_id", (String)adminMap.get("ADMIN_ID"));
					map.put("groups", (String)adminMap.get("GROUPS"));
	 
					if(map.get("src_scd_day_reg_emp_num")!=null){
						map.put("src_scd_day_reg_emp_num", map.get("src_scd_day_reg_emp_num"));
					}else{
						map.put("scd_day_reg_dept", pjtManageBiz.getDeptCode((String)adminMap.get("SABUN")));
						map.put("scd_day_reg_emp_num", (String)adminMap.get("ADMIN_ID"));
					}
			 
					
			mav.setViewName("/com/calendar/calendar");  
			
			mav.addObject("ScheduleList", calendarBiz.selectSchedule(map)); 
				
			mav.addObject("SCD_TYPE_CODE", calendarBiz.selectComboCode("SCD_TYPE_CODE")); 			//일정구분코드
			mav.addObject("PROC_TYPE_CODE", calendarBiz.selectComboCode("PROC_TYPE_CODE")); 		//계획/수행코드
			mav.addObject("TASK_GROUP_CODE", calendarBiz.selectComboCode("TASK_GROUP_CODE")); 		//타스크그룹코드
			mav.addObject("STATUS_VAL", calendarBiz.selectComboCode("STATUS_VAL"));					//업무구분코드
			mav.addObject("WORK_TYPE_CODE", calendarBiz.selectComboCode("WORK_TYPE_CODE"));			//내외근 구분코드
			mav.addObject("TASK_GROUP_CODE", calendarBiz.selectComboCode("TASK_GROUP_CODE"));		//타스크구분
			  
			mav.addObject("pMap",map);
			mav.addAllObjects(map);
			
		} catch (Exception e) { 
			logger.error("::"+this.getClass()+"\n<기념일관리 목록 에러>::::\n"+e.getMessage()); 
		}
		return mav;
	}
	
	public ModelAndView calendarIFR(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = null; 
		
		try {
			mav = new ModelAndView();
			HashMap map = WebUtil.parseRequestMap(request);
			HashMap adminMap = (HashMap)request.getSession().getAttribute(SGConfigManager.getString("common.session.admin.name")); 
			
			String getAuthority = pjtManageBiz.getAuthority((String)adminMap.get("ADMIN_ID"));				 	
			
			if(adminMap.get("ADMIN_ID").equals("30215")){
				mav.addObject("getAuthority", "관리자");
			}else{
				mav.addObject("getAuthority", getAuthority);
			}
			mav.addObject("admin_id", (String)adminMap.get("ADMIN_ID"));
			
			mav.addObject("pMap",map);
			mav.addAllObjects(map);
	
		} catch (Exception e) {
			logger.error(e, e);
		}
		return mav;
	} 
	
	
	public ModelAndView calendarList(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = null;
		
		try {
			mav = new ModelAndView();
	
		} catch (Exception e) {
			logger.error(e, e);
		}
		return mav;
	} 
	
	
	public ModelAndView result_1st(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = null;
		request.setCharacterEncoding("utf-8");
		
		try{
			mav = new ModelAndView();
			mav.setViewName("/result/result_1st");	
			HashMap map = WebUtil.parseRequestMap(request); 
			
			/***** 그리드의 페이지 클릭시 						 *****/
			/***** 검색조건에 한글조회값이 있다면 해당 필드만 decode	 *****/  
			if("grid_page".equals(request.getParameter("div"))){
				map.put("src_whatday",comUtil.getDecodingUTF(request.getParameter("src_whatday")));
				map.put("src_content",comUtil.getDecodingUTF(request.getParameter("src_content")));
			} 
			
			/***** paging *****/ 
			int limit = 0;
			if((String)map.get("limit") != null)
				limit = Integer.parseInt((String)map.get("limit"));
			
			int start = 0;
			if((String)map.get("start") != null)
				start = Integer.parseInt((String)map.get("start"));
		 
			map.put("limit", limit+start);  	
			
			List result = calendarBiz.selectCalDay(map);;					// DB에서 목록조회
			
			/***** 조회된 결과를 JSON형식으로 screen에 Return *****/
			JSONArray jsonArray = JSONArray.fromObject(result);
			HashMap<String,Object> mapResult = new HashMap<String, Object>();
			mapResult.put("success", "true");								// 성공여부
			mapResult.put("message", "Loaded data");						// message
			
			mapResult.put("data_1st", jsonArray);								// 조회된 결과값
			mapResult.put("total_1st", calendarBiz.selectCalDayCount(map));	// 목록의 총갯수 조회
			JSONObject jsonObject = JSONObject.fromObject(mapResult);		// JSON형식으로 설정
			mav.addObject("RESULT_1ST", jsonObject);							// 조회된 결과값을 담기 
	 
		}catch(Exception ex){
			logger.error(ex.getMessage());
		}
		
		return mav;
	}
	 
	
	
	
	public ModelAndView actionCalendar(HttpServletRequest request, HttpServletResponse response) {
		
		ModelAndView mav = new ModelAndView();
		HashMap<String,Object> mapResult = new HashMap<String, Object>();
		
		try {

			mav = new ModelAndView();
			mav.setViewName("/result/result_1st");	
			
			/***** 조회조건 및 parameter설정 *****/
			HashMap paramMap = WebUtil.parseRequestMap(request); 
			HashMap adminMap = (HashMap)request.getSession().getAttribute(SGConfigManager.getString("common.session.admin.name"));
					paramMap.put("admin_id", (String)adminMap.get("ADMIN_ID"));
					paramMap.put("groups", (String)adminMap.get("GROUPS"));
					paramMap.put("emp_num", (String)adminMap.get("SABUN")); 
			
			/***** paging *****/ 
			/*grid 페이징 처리시 사용 할 페이지 시작 종료 value*/
			int limit = 0;
			if((String)paramMap.get("limit") != null)
				limit = Integer.parseInt((String)paramMap.get("limit"));
			int start = 0;
			if((String)paramMap.get("start") != null)
				start = Integer.parseInt((String)paramMap.get("start"));
			
			paramMap.put("limit", limit+start);  
			
			/***** 저장 및 수정 *****/
			boolean calRegResult = calendarBiz.calDayAction(paramMap); 
			
			/***** DB에서 목록조회 *****/
			List result = calendarBiz.selectCalDay(paramMap);			
			
			/***** 조회된 결과를 JSON형식으로 screen에 Return *****/
			JSONArray jsonArray = JSONArray.fromObject(result);
			mapResult.put("success", "true");										
			mapResult.put("message", "Loaded data");
			
			mapResult.put("data_1st", jsonArray);
			mapResult.put("total_1st", calendarBiz.selectCalDayCount(paramMap));
			JSONObject jsonObject = JSONObject.fromObject(mapResult);
			mav.addObject("RESULT_1ST", jsonObject);
			
		} catch (Exception e) {
			logger.error("::"+this.getClass()+"\n<기념일관리 처리 에러>::::\n"+e.getMessage()); 
			e.printStackTrace();
		} finally{
			
		}
		
		return mav;
	}
	
	
	
	
	public ModelAndView actionSchedule(HttpServletRequest request, HttpServletResponse response) {
		
		ModelAndView mav = new ModelAndView();
		HashMap mapResult = new HashMap();
		
		try {

			mav = new ModelAndView();
			mav.setViewName("/com/calendar/calendar");	
			
			/***** 조회조건 및 parameter설정 *****/
			HashMap paramMap = WebUtil.parseRequestMap(request); 
			HashMap adminMap = (HashMap)request.getSession().getAttribute(SGConfigManager.getString("common.session.admin.name"));
					paramMap.put("admin_id", (String)adminMap.get("ADMIN_ID"));
					paramMap.put("groups", (String)adminMap.get("GROUPS")); 
					paramMap.put("scd_day_reg_dept", pjtManageBiz.getDeptCode((String)adminMap.get("SABUN")));
					paramMap.put("scd_day_reg_emp_num", (String)adminMap.get("SABUN"));  
					 
					paramMap.put("scd_sdate", (paramMap.get("scd_sdate").toString().substring(0,10).replaceAll("-", "")));  
					paramMap.put("scd_edate", (paramMap.get("scd_edate").toString().substring(0,10).replaceAll("-", ""))); 
							
			/***** 저장 및 수정 *****/
			boolean scdRegResult = calendarBiz.actionSchedule(paramMap);  
			  
			
			mav.addObject("ScheduleList", calendarBiz.selectSchedule(paramMap)); 
			
			mav.addObject("SCD_TYPE_CODE", calendarBiz.selectComboCode("SCD_TYPE_CODE")); 			//일정구분코드
			mav.addObject("PROC_TYPE_CODE", calendarBiz.selectComboCode("PROC_TYPE_CODE")); 		//계획/수행코드
			mav.addObject("TASK_GROUP_CODE", calendarBiz.selectComboCode("TASK_GROUP_CODE")); 		//타스크그룹코드
			mav.addObject("STATUS_VAL", calendarBiz.selectComboCode("STATUS_VAL"));					//업무구분코드
			mav.addObject("WORK_TYPE_CODE", calendarBiz.selectComboCode("WORK_TYPE_CODE"));			//내외근 구분코드
			mav.addObject("TASK_GROUP_CODE", calendarBiz.selectComboCode("TASK_GROUP_CODE"));		//타스크구분
			
		    
		} catch (Exception e) {
			logger.error("::"+this.getClass()+"\n<일정 처리 에러>::::\n"+e.getMessage()); 
			e.printStackTrace();
		} finally{
			
		}
		
		return mav;
	}	
	
	
	public ModelAndView deleteSchedule(HttpServletRequest request, HttpServletResponse response) {
		
		ModelAndView mav = new ModelAndView();
		HashMap mapResult = new HashMap();
		
		try {

			mav = new ModelAndView();
			mav.setViewName("/com/calendar/calendar");	
			
			/***** 조회조건 및 parameter설정 *****/
			HashMap paramMap = WebUtil.parseRequestMap(request); 
			HashMap adminMap = (HashMap)request.getSession().getAttribute(SGConfigManager.getString("common.session.admin.name"));
					paramMap.put("admin_id", (String)adminMap.get("ADMIN_ID"));
					paramMap.put("groups", (String)adminMap.get("GROUPS")); 
					paramMap.put("scd_day_reg_dept", pjtManageBiz.getDeptCode((String)adminMap.get("SABUN")));
					paramMap.put("scd_day_reg_emp_num", (String)adminMap.get("SABUN"));
			 
			boolean scdRegResult = calendarBiz.deleteSchedule(paramMap);  
			  
			
			mav.addObject("ScheduleList", calendarBiz.selectSchedule(paramMap)); 
			
			mav.addObject("SCD_TYPE_CODE", calendarBiz.selectComboCode("SCD_TYPE_CODE")); 			//일정구분코드
			mav.addObject("PROC_TYPE_CODE", calendarBiz.selectComboCode("PROC_TYPE_CODE")); 		//계획/수행코드
			mav.addObject("TASK_GROUP_CODE", calendarBiz.selectComboCode("TASK_GROUP_CODE")); 		//타스크그룹코드
			mav.addObject("STATUS_VAL", calendarBiz.selectComboCode("STATUS_VAL"));					//업무구분코드
			mav.addObject("WORK_TYPE_CODE", calendarBiz.selectComboCode("WORK_TYPE_CODE"));			//내외근 구분코드
			mav.addObject("TASK_GROUP_CODE", calendarBiz.selectComboCode("TASK_GROUP_CODE"));		//타스크구분
			
		    
		} catch (Exception e) {
			logger.error("::"+this.getClass()+"\n<일정 삭제 에러>::::\n"+e.getMessage()); 
			e.printStackTrace();
		} finally{
			
		}
		
		return mav;
	}
	
	
	public ModelAndView allSchedule(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = null;

		try {
			mav = new ModelAndView();
			HashMap paramMap = WebUtil.parseRequestMap(request);
			HashMap mapResult = new HashMap();
			
			HashMap adminMap = (HashMap)request.getSession().getAttribute(SGConfigManager.getString("common.session.admin.name"));
					mav.addObject("admin_id",(String)adminMap.get("ADMIN_ID"));
					mav.addObject("admin_nm",(String)adminMap.get("ADMIN_NM"));
					mav.addObject("sabun",(String)adminMap.get("SABUN"));
					mav.addObject("dept_code",pjtManageBiz.getDeptCode((String)adminMap.get("SABUN")));
					mav.addObject("dept_nm", pjtManageBiz.getDeptNm((String)adminMap.get("DEPT")));
					
				 
			mav.setViewName("/com/calendar/allSchedule");
			 	
			mav.addObject("SCD_TYPE_CODE", calendarBiz.selectComboCode("SCD_TYPE_CODE")); 			//일정구분코드
			mav.addObject("PROC_TYPE_CODE", calendarBiz.selectComboCode("PROC_TYPE_CODE")); 		//계획/수행코드
			mav.addObject("TASK_GROUP_CODE", calendarBiz.selectComboCode("TASK_GROUP_CODE")); 		//타스크그룹코드
			mav.addObject("STATUS_VAL", calendarBiz.selectComboCode("STATUS_VAL"));					//업무구분코드
			mav.addObject("WORK_TYPE_CODE", calendarBiz.selectComboCode("WORK_TYPE_CODE"));			//내외근 구분코드
			mav.addObject("TASK_GROUP_CODE", calendarBiz.selectComboCode("TASK_GROUP_CODE"));		//타스크구분
			mav.addObject("POSITION_CODE", sgisCodeBiz.selectComboCode("POSITION_CODE"));			//직위
			mav.addObject("PJT_STATUS", sgisCodeBiz.selectComboCode("PJT_STATUS"));
			
			mav.addObject("pMap",paramMap);
			mav.addAllObjects(paramMap); 
			
			
		} catch (Exception e) { 
			logger.error("::"+this.getClass()+"\n<전체 기념일관리 목록 에러>::::\n"+e.getMessage()); 
		}
		return mav;
	}
	
	
	public ModelAndView all_result_1st(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = null;

		try {
			mav = new ModelAndView();
			HashMap paramMap = WebUtil.parseRequestMap(request);
			HashMap mapResult = new HashMap(); 
	 
			mav.setViewName("/result/result_1st");
			
			/***** paging *****/ 
			int limit = 0;
			if((String)paramMap.get("limit") != null)
				limit = Integer.parseInt((String)paramMap.get("limit"));
			int start = 0;
			if((String)paramMap.get("start") != null)
				start = Integer.parseInt((String)paramMap.get("start"));
			paramMap.put("limit", limit+start); 
			
			//자신의 부서에서 등록한 목록만 가져오기//
			HashMap adminMap = (HashMap)request.getSession().getAttribute(SGConfigManager.getString("common.session.admin.name"));
			String emp_num   =(String)adminMap.get("ADMIN_ID");
			String dept_code = pjtManageBiz.getDeptCode((String)adminMap.get("SABUN"));
			String groups	 = (String)adminMap.get("GROUPS");
			
			if(    groups.indexOf("G001", 0) == -1 				//시스템관리자
				&& groups.indexOf("G002", 0) == -1				//임원
				&& groups.indexOf("G005", 0) == -1				//대표이사 
			  ){
				paramMap.put("session_dept_code", dept_code);
			}  
			
			List result = calendarBiz.selectAllSchedule(paramMap);		
			
			
			JSONArray jsonArray = JSONArray.fromObject(result);
			
			mapResult.put("success", "true");
			mapResult.put("message", "Loaded data");
			
			mapResult.put("data_1st", jsonArray);
			mapResult.put("total_1st", calendarBiz.selectAllScheduleCount(paramMap));
			JSONObject jsonObject = JSONObject.fromObject(mapResult);
			mav.addObject("RESULT_1ST", jsonObject);
			
			
		} catch (Exception e) { 
			logger.error("::"+this.getClass()+"\n<전체 기념일관리 목록 에러>::::\n"+e.getMessage()); 
		}
		return mav;
	}
	
	
	

	public ModelAndView actionAllSchedule(HttpServletRequest request, HttpServletResponse response) {
		
		ModelAndView mav = new ModelAndView();
		HashMap mapResult = new HashMap();
		
		try {

			mav = new ModelAndView(); 
			
			/***** 조회조건 및 parameter설정 *****/
			HashMap paramMap = WebUtil.parseRequestMap(request);
			HashMap adminMap = (HashMap)request.getSession().getAttribute(SGConfigManager.getString("common.session.admin.name"));
					paramMap.put("admin_id",(String)adminMap.get("ADMIN_ID"));		
					paramMap.put("scd_sdate", (paramMap.get("scd_sdate").toString().substring(0,10).replaceAll("-", "")));  
					paramMap.put("scd_edate", (paramMap.get("scd_edate").toString().substring(0,10).replaceAll("-", ""))); 
				 			
			/***** 저장 및 수정 *****/
			boolean scdRegResult = calendarBiz.actionSchedule(paramMap); 
			
			mav.setViewName("/result/result_1st");
			
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
			
			if(    groups.indexOf("G001", 0) == -1 				//시스템관리자
				&& groups.indexOf("G002", 0) == -1				//임원
				&& groups.indexOf("G005", 0) == -1				//대표이사 
			  ){
				paramMap.put("session_dept_code", dept_code);
			}  
			
			List result = calendarBiz.selectAllSchedule(paramMap);		
			
			
			JSONArray jsonArray = JSONArray.fromObject(result);
			
			mapResult.put("success", "true");
			mapResult.put("message", "Loaded data");
			
			mapResult.put("data_1st", jsonArray);
			mapResult.put("total_1st", calendarBiz.selectAllScheduleCount(paramMap));
			JSONObject jsonObject = JSONObject.fromObject(mapResult);
			mav.addObject("RESULT_1ST", jsonObject); 
		    
		} catch (Exception e) {
			logger.error("::"+this.getClass()+"\n<전체 일정 처리 에러>::::\n"+e.getMessage()); 
			e.printStackTrace();
		} finally{
			
		}
		
		return mav;
	}	
	 
	
}
