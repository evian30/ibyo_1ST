/**
 *  Class Name  : ScdInfoMngController
 *  Description : 개발일정계획관리 Controller
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
import java.util.Iterator;
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
import com.signgate.core.exception.SGFileUploadException;
import com.signgate.core.util.FileUtil;
import com.signgate.core.web.controller.SGUserController;
import com.signgate.core.web.util.SGFileBean;
import com.signgate.core.web.util.WebUtil;
 
public class ScdDayInfoMngController extends SGUserController{
	protected final Log logger = LogFactory.getLog(getClass());
	
	private ScdDayInfoMngBiz scdDayInfoMngBiz;

	public ScdDayInfoMngBiz getScdDayInfoMngBiz() {
		return scdDayInfoMngBiz;
	}

	public void setScdDayInfoMngBiz(ScdDayInfoMngBiz scdDayInfoMngBiz) {
		this.scdDayInfoMngBiz = scdDayInfoMngBiz;
	}	

	private ScdInfoMngBiz scdInfoMngBiz; 

	
	public ScdInfoMngBiz getScdInfoMngBiz() {
		return scdInfoMngBiz;
	}

	public void setScdInfoMngBiz(ScdInfoMngBiz scdInfoMngBiz) {
		this.scdInfoMngBiz = scdInfoMngBiz;
	}	
	
	// 공통코드 BIZ경로 설정
	private SgisCodeBiz sgisCodeBiz;
	public void setSgisCodeBiz(SgisCodeBiz sgisCodeBiz) {
		this.sgisCodeBiz = sgisCodeBiz;
	}
	
	public SgisCodeBiz getSgisCodeBiz() {
		return sgisCodeBiz;
	}		
	
	// 로그인 사용자의 부서정보를 가져오기 위함
	 private PjtManageBiz pjtManageBiz; 
	 
	 public void setPjtManageBiz(PjtManageBiz pjtManageBiz){
	  this.pjtManageBiz = pjtManageBiz;
	 }
	 	

	CommonUtil comUtil = new CommonUtil();
	
	/**
	 * 프로젝트 일정관리 조회
	 */	
	@SuppressWarnings("unchecked")
	public ModelAndView result(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = null;

		try {
			mav = new ModelAndView();
			HashMap map = WebUtil.parseRequestMap(request);
			
			/***** paging *****/ 
			int limit = 0;
			if((String)map.get("limit") != null)
				limit = Integer.parseInt((String)map.get("limit"));
			int start = 0;
			if((String)map.get("start") != null)
				start = Integer.parseInt((String)map.get("start"));
			
			map.put("limit", limit+start);  			
			
			HashMap adminMap = (HashMap)request.getSession().getAttribute(SGConfigManager.getString("common.session.admin.name"));
			
			map.put("admin_id", (String)adminMap.get("ADMIN_ID"));
			map.put("groups", (String)adminMap.get("GROUPS"));
					
			map.put("scd_day_reg_dept", pjtManageBiz.getDeptCode((String)adminMap.get("SABUN")));
			map.put("scd_day_reg_emp_num", (String)adminMap.get("SABUN"));
	 
			mav.setViewName("/result/result_1st");

			if(((String)map.get("src_csr_date_from")).equals("") && ((String)map.get("src_csr_date_to")).equals(""))
			{
				map.put("initSearch", "Y");
			}
			
			 	//자신의 부서에서 등록한 목록만 가져오기//
			   	String emp_num   =(String)adminMap.get("ADMIN_ID");
				String dept_code = pjtManageBiz.getDeptCode((String)adminMap.get("SABUN"));
				String groups	 = (String)adminMap.get("GROUPS");
				
				/*보기권한 임원-전체, 팀장-팀의데이터, 팀원-본인데이터  by ibyo:2011.06.08
				String getAuthority = pjtManageBiz.getAuthority(emp_num);				 	
				if(getAuthority.equals("사장") || getAuthority.equals("본부장") || getAuthority.equals("연구소장")){
					map.put("session_dept_code", "");
				}else if(getAuthority.equals("팀장") || getAuthority.equals("팀장대행")){
					map.put("session_dept_code", dept_code);
				}else if(getAuthority.equals("팀원")){
					map.put("reg_id", emp_num);
				}
			   */
			
				map.put("scd_day_reg_dept", dept_code);
			
			
			/***** DB에서 목록조회 *****/
			List result = scdDayInfoMngBiz.selectSchedule(map);			
			
			/***** 조회된 결과를 JSON형식으로 screen에 Return *****/
			JSONArray jsonArray = JSONArray.fromObject(result);
			HashMap<String,Object> mapResult = new HashMap<String, Object>();
			mapResult.put("success", "true");								// 성공여부
			mapResult.put("message", "Loaded data");						// message
			
			mapResult.put("data_1st", jsonArray);							// 조회된 결과값
			mapResult.put("total_1st", scdDayInfoMngBiz.selectScheduleCount(map)); 	// 목록의 총갯수 조회

			JSONObject jsonObject = JSONObject.fromObject(mapResult);		// JSON형식으로 설정
			mav.addObject("RESULT_1ST", jsonObject);						// 조회된 결과값을 담기

			mav.addObject("pMap",map);
			
		} catch (Exception e) { 
			logger.error("::"+this.getClass()+"[--result-->]"+e.getMessage()); 
		}
		return mav;
	}
	
	
	/**
	 * 프로젝트 일정관리 조회
	 */	
	public ModelAndView scdDayInfoMngList(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = null;
		
		try {
			mav = new ModelAndView();
			
			mav.addObject("STATUS_VAL", scdDayInfoMngBiz.selectComboCode("STATUS_VAL"));				//일정상태값
			mav.addObject("WORK_TYPE_CODE", scdDayInfoMngBiz.selectComboCode("WORK_TYPE_CODE"));		//내외근 구분코드
			mav.addObject("PJT_STATUS", sgisCodeBiz.selectComboCode("PJT_STATUS"));						//현재프로젝트상태코드
			mav.addObject("TASK_CHK_RES_CODE", sgisCodeBiz.selectComboCode("TASK_CHK_RES_CODE"));		//타스크완료여부
	
		} catch (Exception e) {
			logger.error(e, e);
		}
		return mav;
	} 
	
	
	/**
	 * 프로젝트 일정관리 저장,수정
	 */	
	public ModelAndView actionSchedule(HttpServletRequest request, HttpServletResponse response) {
		
		ModelAndView mav = new ModelAndView();
		HashMap mapResult = new HashMap();
		JSONArray jsonArray = new JSONArray();
		JSONObject jsonObject = new JSONObject();
		
		try {

			mav = new ModelAndView();
			mav.setViewName("/result/result_1st");	
			
			/***** 조회조건 및 parameter설정 *****/
//			HashMap paramMap = WebUtil.parseRequestMap(request);
			
			//HashMap paramMap = new HashMap();
			HashMap paramMap = WebUtil.parseRequestMap(request); 
logger.debug("--processMultipart-trace-start->>"+paramMap);		

			HashMap adminMap = (HashMap)request.getSession().getAttribute(SGConfigManager.getString("common.session.admin.name"));
			   
			   mav.addObject("admin_id",(String)adminMap.get("ADMIN_ID"));
			   mav.addObject("admin_nm",(String)adminMap.get("ADMIN_NM"));
			   mav.addObject("sabun",(String)adminMap.get("SABUN"));
			   mav.addObject("dept_code",pjtManageBiz.getDeptCode((String)adminMap.get("SABUN")));
			   mav.addObject("dept_nm", pjtManageBiz.getDeptNm(pjtManageBiz.getDeptCode((String)adminMap.get("SABUN"))));
			

			//첨부파일
			String savepath= "/kacaisDoc";   			//sg-common-config  <repositoryPath>D:\\</repositoryPath>
			SGFileBean sgfb = new SGFileBean(savepath);	
				
logger.debug("--processMultipart-trace-1->>"+paramMap);	
			
			WebUtil.processMultipart(request, sgfb, paramMap);
			
logger.debug("--processMultipart-trace-2->>"+paramMap);

			      
			//일정관리순번 	   
			int selScdDayInfoSeq = scdDayInfoMngBiz.selectScdDayInfoSeq();	
			
			paramMap.put("final_mod_id", (String)adminMap.get("SABUN"));
			
			if((paramMap.get("scd_day_seq").toString()).equals(""))//신규
			{  
				paramMap.put("insert", "Y");
				paramMap.put("scd_day_seq", selScdDayInfoSeq);
			    
				paramMap.put("scd_day_reg_dept", pjtManageBiz.getDeptCode((String)adminMap.get("SABUN")));
				paramMap.put("scd_day_reg_emp_num", (String)adminMap.get("SABUN"));
				   				
			}else
			{	paramMap.put("insert", "N");
				selScdDayInfoSeq = Integer.parseInt(paramMap.get("scd_day_seq").toString());
			}
				   
				// 해당 프로젝트의  타스크 완료건수		
			   int task_end_yn_cnt = scdDayInfoMngBiz.selectTaskEndYnCount(paramMap);
logger.debug("--processMultipart-trace-3->>-"+paramMap);	

			   if(task_end_yn_cnt >0 )
			   {
				   mapResult.put("task_end_yn_cnt", task_end_yn_cnt);
			   }else
			   {
				   mapResult.put("task_end_yn_cnt", "0");
				   
logger.debug("--processMultipart-trace-4->>-"+paramMap);			   
					/***** 저장 및 수정 *****/
					boolean scdRegResult = scdDayInfoMngBiz.actionSchedule(paramMap);
					
					List fileList = (List)paramMap.get("uploadList");
					
					Iterator iteratorDelFile = fileList.iterator(); 
					
					if(scdRegResult)
					{
						Iterator iterator = fileList.iterator(); 
						
						while(iterator.hasNext())
						{
							HashMap fMap = (HashMap)iterator.next();
logger.debug("--processMultipart-trace-5->>-"+fMap);							

							/***** 일정수행산출물관리 저장*****/
							
							//타스크산출물순번
							paramMap.put("task_info_seq", "");
							//산출물등록자사번
							paramMap.put("prod_reg_emp_num", (String)adminMap.get("SABUN"));
							
							//산출물파일명
							paramMap.put("prod_file_name", (String)fMap.get("sourceFileName"));
							
							//*산출물저장파일경로
							paramMap.put("prod_fil_path", (String)fMap.get("filePath"));   //filePath
							
							//*서버등록파일명
							paramMap.put("saved_file_name", (String)fMap.get("saveFileName"));
							
							scdInfoMngBiz.insertScdExecPrpdInfo(paramMap);
							
						}		
					}else
					{
						while(iteratorDelFile.hasNext())
						{
							HashMap fMap = (HashMap)iteratorDelFile.next();
logger.debug("--processMultipart-trace-6->>-"+fMap);
							//파일삭제
							FileUtil.delete((String)fMap.get("fileRealPath")+(String)fMap.get("saveFileName"));
						}		
					}
			   }			      
			      
				/***** paging *****/ 
				int limit = 0;
				if((String)paramMap.get("limit") != null)
					limit = Integer.parseInt((String)paramMap.get("limit"));
				int start = 0;
				if((String)paramMap.get("start") != null)
					start = Integer.parseInt((String)paramMap.get("start"));
				
				paramMap.put("limit", limit+start); 			
				
				paramMap.put("initSearch", "Y");
				paramMap.put("src_csr_date_from", "");
				paramMap.put("src_csr_date_to", "");
				
logger.debug("--processMultipart-trace-7->>-"+paramMap);				
				/***** 목록조회 *****/
			//자신의 부서에서 등록한 목록만 가져오기//
			String emp_num   =(String)adminMap.get("ADMIN_ID");
				String dept_code = pjtManageBiz.getDeptCode((String)adminMap.get("SABUN"));
				String groups	 = (String)adminMap.get("GROUPS");
				
				

				List result = scdDayInfoMngBiz.selectSchedule(paramMap);						 
				
				/***** 조회된 결과를 JSON형식으로 screen에 Return *****/
				
				jsonArray = JSONArray.fromObject(result); 			
				mapResult.put("success", "true");							// 성공여부
				mapResult.put("message", "Loaded data");					// message
				mapResult.put("data_1st", jsonArray);						// 조회된 결과값
				mapResult.put("total_1st", scdDayInfoMngBiz.selectScheduleCount(paramMap));	// 목록의 총갯수 조회
				//jsonObject = JSONObject.fromObject(mapResult);		
				//mav.addObject("RESULT_1ST", jsonObject);						// 조회된 결과값을 담기			

		}catch(SGFileUploadException se){
			mapResult.put("success", "false");							// 성공여부
			mapResult.put("message", se.getMessage());					// message	
			logger.error("::"+this.getClass()+"\n<isMultipart-8-SGFileUploadException>::::\n"+se.getMessage()); 
		
		} catch (Exception e) {
			logger.error("::"+this.getClass()+"[--isMultipart-9-Exception-->]"+e.getMessage()); 
			e.printStackTrace();
		} finally{
logger.debug("--processMultipart-trace-end->>");
			jsonObject = JSONObject.fromObject(mapResult);
			mav.addObject("RESULT_1ST", jsonObject);			
			
		}
		
		return mav;
	}	
	
	
	/**
	 * 프로젝트 일정관리 삭제
	 */
	public ModelAndView deleteSchedule(HttpServletRequest request, HttpServletResponse response) {
		
		ModelAndView mav = new ModelAndView();
		HashMap mapResult = new HashMap();
		JSONArray jsonArray = new JSONArray();
		JSONObject jsonObject = new JSONObject();
		try {

			mav = new ModelAndView();
			mav.setViewName("/result/result_1st");	
			
			/***** 조회조건 및 parameter설정 *****/
			HashMap paramMap = WebUtil.parseRequestMap(request); 
			HashMap adminMap = (HashMap)request.getSession().getAttribute(SGConfigManager.getString("common.session.admin.name"));
			   
			   mav.addObject("admin_id",(String)adminMap.get("ADMIN_ID"));
			   mav.addObject("admin_nm",(String)adminMap.get("ADMIN_NM"));
			   mav.addObject("sabun",(String)adminMap.get("SABUN"));
			   mav.addObject("dept_code",pjtManageBiz.getDeptCode((String)adminMap.get("SABUN")));
			   mav.addObject("dept_nm", pjtManageBiz.getDeptNm(pjtManageBiz.getDeptCode((String)adminMap.get("SABUN"))));
			

			boolean scdRegResult = scdDayInfoMngBiz.deleteSchedule(paramMap);  
			  
			
			/***** paging *****/ 
			int limit = 0;
			if((String)paramMap.get("limit") != null)
				limit = Integer.parseInt((String)paramMap.get("limit"));
			int start = 0;
			if((String)paramMap.get("start") != null)
				start = Integer.parseInt((String)paramMap.get("start"));
			
			paramMap.put("limit", limit+start); 			

			//자신의 부서에서 등록한 목록만 가져오기//
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
			
			
			/***** 목록조회 *****/
			List result = scdDayInfoMngBiz.selectSchedule(paramMap);						 
			
			/***** 조회된 결과를 JSON형식으로 screen에 Return *****/
			
			jsonArray = JSONArray.fromObject(result); 			
			mapResult.put("success", "true");							// 성공여부
			mapResult.put("message", "Loaded data");					// message
			mapResult.put("data_1st", jsonArray);						// 조회된 결과값
			mapResult.put("total_1st", scdDayInfoMngBiz.selectScheduleCount(paramMap));	// 목록의 총갯수 조회
			jsonObject = JSONObject.fromObject(mapResult);		
			mav.addObject("RESULT_1ST", jsonObject);						// 조회된 결과값을 담기	
			
		    
		} catch (Exception e) {
			logger.error("::"+this.getClass()+"[--deleteSchedule-->]"+e.getMessage()); 
			e.printStackTrace();
		} finally{
			
		}
		
		return mav;
	}
	
	
	/**
	 * 프로젝트 일정관리 상세검색
	 */
	public ModelAndView all_result_1st(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = null;

		try {
			mav = new ModelAndView();
			HashMap paramMap = WebUtil.parseRequestMap(request);
			HashMap mapResult = new HashMap(); 
	 
			mav.setViewName("/result/result_edit_1st");
			
			/***** paging *****/ 
			int limit = 0;
			if((String)paramMap.get("limit") != null)
				limit = Integer.parseInt((String)paramMap.get("limit"));
			int start = 0;
			if((String)paramMap.get("start") != null)
				start = Integer.parseInt((String)paramMap.get("start"));
			
			paramMap.put("limit", limit+start); 
			
			List result = scdDayInfoMngBiz.selectAllSchedule(paramMap);		
			
			JSONArray jsonArray = JSONArray.fromObject(result);
			
			mapResult.put("success", "true");
			mapResult.put("message", "Loaded data");
			
			mapResult.put("data_edit_1st", jsonArray);
			mapResult.put("total_edit_1st", scdDayInfoMngBiz.selectAllScheduleCount(paramMap));
			JSONObject jsonObject = JSONObject.fromObject(mapResult);
			mav.addObject("RESULT_EDIT_1ST", jsonObject);
			
			
		} catch (Exception e) { 
			logger.error("::"+this.getClass()+"[--all_result_1st-->]"+e.getMessage()); 
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
				   
			   mav.addObject("admin_id",(String)adminMap.get("ADMIN_ID"));
			   mav.addObject("admin_nm",(String)adminMap.get("ADMIN_NM"));
			   mav.addObject("sabun",(String)adminMap.get("SABUN"));
			   mav.addObject("dept_code",pjtManageBiz.getDeptCode((String)adminMap.get("SABUN")));
			   mav.addObject("dept_nm", pjtManageBiz.getDeptNm(pjtManageBiz.getDeptCode((String)adminMap.get("SABUN"))));
			
			   paramMap.put("scd_day_reg_dept", pjtManageBiz.getDeptCode((String)adminMap.get("SABUN")));
			   paramMap.put("scd_day_reg_emp_num", (String)adminMap.get("SABUN"));

					
					
			/***** 저장 및 수정 *****/
			boolean scdRegResult = scdDayInfoMngBiz.actionSchedule(paramMap); 
			
			mav.setViewName("/result/result_1st");
			
			/***** paging *****/ 
			int limit = 0;
			if((String)paramMap.get("limit") != null)
				limit = Integer.parseInt((String)paramMap.get("limit"));
			int start = 0;
			if((String)paramMap.get("start") != null)
				start = Integer.parseInt((String)paramMap.get("start"));
			
			paramMap.put("limit", limit+start); 
			
			List result = scdDayInfoMngBiz.selectAllSchedule(paramMap);		
			
			
			JSONArray jsonArray = JSONArray.fromObject(result);
			
			mapResult.put("success", "true");
			mapResult.put("message", "Loaded data");
			
			mapResult.put("data_1st", jsonArray);
			mapResult.put("total_1st", scdDayInfoMngBiz.selectAllScheduleCount(paramMap));
			JSONObject jsonObject = JSONObject.fromObject(mapResult);
			mav.addObject("RESULT_1ST", jsonObject); 
		    
		} catch (Exception e) {
			logger.error("::"+this.getClass()+"[--actionAllSchedule-->]"+e.getMessage()); 
			e.printStackTrace();
		} finally{
			
		}
		
		return mav;
	}

	
	/**
	 * 개발프로젝트 검토 조회	
	 */
	public ModelAndView scdDayInfoReviewMngList(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = null;
		
		try {
			mav = new ModelAndView();
			
			mav.addObject("STATUS_VAL", scdDayInfoMngBiz.selectComboCode("STATUS_VAL"));				//일정상태값
			mav.addObject("WORK_TYPE_CODE", scdDayInfoMngBiz.selectComboCode("WORK_TYPE_CODE"));		//내외근 구분코드
			mav.addObject("PJT_STATUS", sgisCodeBiz.selectComboCode("PJT_STATUS"));						//현재프로젝트상태코드
			mav.addObject("TASK_CHK_RES_CODE", sgisCodeBiz.selectComboCode("TASK_CHK_RES_CODE"));		//타스크완료여부
	
		} catch (Exception e) {
			logger.error(e, e);
		}
		return mav;
	} 
		
	
	/**
	 * 개발프로젝트 검토 조회	
	 */
	@SuppressWarnings("unchecked")
	public ModelAndView scdDayInfoReviewResult(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = null;

		try {
			mav = new ModelAndView();
			
			// 공통코드 조회
			List task_chk_res_code = sgisCodeBiz.selectComboCode("TASK_CHK_RES_CODE");	
			mav.addObject("TASK_CHK_RES_CODE", task_chk_res_code);						// 타스크검토결과코드	
			
			HashMap map = WebUtil.parseRequestMap(request);
			HashMap adminMap = (HashMap)request.getSession().getAttribute(SGConfigManager.getString("common.session.admin.name"));
			
			map.put("admin_id", (String)adminMap.get("ADMIN_ID"));
			map.put("groups", (String)adminMap.get("GROUPS"));
					
			map.put("scd_day_reg_emp_num", (String)adminMap.get("SABUN")); 
	 
			mav.setViewName("/result/result_edit_1st");

			map.put("src_pjt_id", ((String)map.get("src_pjt_id")).toUpperCase()); //대문자로 변경
			
			/***** paging *****/ 
			int limit = 0;
			if((String)map.get("limit") != null)
				limit = Integer.parseInt((String)map.get("limit"));
			int start = 0;
			if((String)map.get("start") != null)
				start = Integer.parseInt((String)map.get("start"));
			
			map.put("limit", limit+start); 			
			
			String emp_num   =(String)adminMap.get("ADMIN_ID");
			String dept_code = pjtManageBiz.getDeptCode((String)adminMap.get("SABUN"));
			String groups	 = (String)adminMap.get("GROUPS");
			
			   
			/***** DB에서 목록조회 *****/
			List result = scdDayInfoMngBiz.selectScheduleReview(map);			
			
			/***** 조회된 결과를 JSON형식으로 screen에 Return *****/
			JSONArray jsonArray = JSONArray.fromObject(result);
			HashMap<String,Object> mapResult = new HashMap<String, Object>();
			mapResult.put("success", "true");								// 성공여부
			mapResult.put("message", "Loaded data");						// message
			
			mapResult.put("data_edit_1st", jsonArray);							// 조회된 결과값
			mapResult.put("total_edit_1st", scdDayInfoMngBiz.selectScheduleReviewCount(map)); 	// 목록의 총갯수 조회

			JSONObject jsonObject = JSONObject.fromObject(mapResult);		// JSON형식으로 설정
			mav.addObject("RESULT_EDIT_1ST", jsonObject);						// 조회된 결과값을 담기

			mav.addObject("pMap",map);
			
		} catch (Exception e) { 
			logger.error("::"+this.getClass()+"[--scdDayInfoReviewResult-->]"+e.getMessage()); 
		}
		return mav;
	}	
 
	
	/**
	 * 개발프로젝트 검토 저장,수정
	 */
	 @SuppressWarnings("unchecked")
	public ModelAndView actionScdDayInfoReview(HttpServletRequest request, HttpServletResponse response) {
		
		ModelAndView mav = new ModelAndView();
		HashMap mapResult = new HashMap();
		
		try {

			mav = new ModelAndView(); 
			
			/***** 조회조건 및 parameter설정 *****/
			HashMap paramMap = WebUtil.parseRequestMap(request);
			HashMap adminMap = (HashMap)request.getSession().getAttribute(SGConfigManager.getString("common.session.admin.name"));
					paramMap.put("final_mod_id",(String)adminMap.get("SABUN"));		
				 			
			/***** 저장 및 수정 *****/
			int scdRegResult = scdDayInfoMngBiz.actionScdDayInfoReview(paramMap, request); 
			
			if(scdRegResult == 88)  // 이미완료처리됨
			{
				mapResult.put("success", "false");
				mapResult.put("message", "이미 완료처리 되었습니다.");
			}else
			{
				mapResult.put("success", "true");
				mapResult.put("message", "Loaded data");
			}
			
			mav.setViewName("/result/result_edit_1st");
			
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
			
			
			List result = scdDayInfoMngBiz.selectScheduleReview(paramMap);		
			
			JSONArray jsonArray = JSONArray.fromObject(result);

			
			mapResult.put("data_edit_1st", jsonArray);
			mapResult.put("total_edit_1st", scdDayInfoMngBiz.selectScheduleReviewCount(paramMap));
			JSONObject jsonObject = JSONObject.fromObject(mapResult);
			mav.addObject("RESULT_EDIT_1ST", jsonObject); 
		    
		} catch (Exception e) {
			logger.error("::"+this.getClass()+"[--actionScdDayInfoReview-->]"+e.getMessage()); 
			e.printStackTrace();
		} finally{
			
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


	 
	 /**
	 * 산출물 삭제
	 */	
	 @SuppressWarnings("unchecked")
	 public ModelAndView fileDel(HttpServletRequest request,HttpServletResponse response) 
	 {
		 ModelAndView mav = new ModelAndView();
			
		try {
		 
		 //mav.setViewName("/dev/scdInfo/dayInfo/scdDayInfoMngList");
     	 mav.setViewName("/result/result_1st");	
		 HashMap paramMap = WebUtil.parseRequestMap(request);

		 HashMap adminMap = (HashMap)request.getSession().getAttribute(SGConfigManager.getString("common.session.admin.name"));

		 /***** paging *****/ 
			int limit = 0;
			if((String)paramMap.get("limit") != null)
				limit = Integer.parseInt((String)paramMap.get("limit"));
			int start = 0;
			if((String)paramMap.get("start") != null)
				start = Integer.parseInt((String)paramMap.get("start"));
			
			paramMap.put("limit", limit+start); 		 
		 
		  
			if(((String)paramMap.get("delYn")).equals("Y"))  //삭제 버튼 선택시
			{
				//테이블 조회
		    	List resultList = scdInfoMngBiz.selectScdExecPrpdInfo(paramMap);
		    	
		    	HashMap getData = new HashMap();
		
		        String prod_fil_path = "";		//산출물저장파일경로
		        String saved_file_name = "";	//서버등록파일명
		        String prod_file_name = "";		//산출물파일명
		        
		    	getData = (HashMap)resultList.get(0);
		            
		    	prod_fil_path = (String)getData.get("PROD_FIL_PATH");
		    	saved_file_name = (String)getData.get("SAVED_FILE_NAME");
		    	
		    	prod_file_name = (String)getData.get("PROD_FILE_NAME");
	logger.debug("fileDel--경로 ::"+prod_fil_path+", 파일명 : "+saved_file_name+"<br>" );		 
			 
			  String path = prod_fil_path + saved_file_name;
	logger.debug("--path--"+path);
	
	
				boolean delResult = scdInfoMngBiz.deleteScdExecPrpdInfo(paramMap);
				
				if(delResult)
				{
					FileUtil.delete(path);
				}
		}

			//테이블 조회
			paramMap.put("scd_exec_prpd_seq", "");
	    	List resultList2 = scdInfoMngBiz.selectScdExecPrpdInfo(paramMap);
			
	    	JSONArray jsonArray = JSONArray.fromObject(resultList2);
	    	HashMap<String,Object> mapResult = new HashMap<String, Object>();
	    	mapResult.put("afterFileList",jsonArray);       // 목록의 총갯수 조회
	    	
    	    JSONObject jsonObject = JSONObject.fromObject(mapResult); // JSON형식으로 설정
    	    mav.addObject("RESULT_1ST", jsonObject);     // 조회된 결과값을 담기
	    	   
    	
			} catch (Exception e) {
				logger.error(e, e);
			}
			return mav;
	 }	 
	
	 
		
		/**
	 	*  산출물 팝업
	 	*/	
	 	@SuppressWarnings("unchecked")
		public ModelAndView scdExecPrpdInfoPop(HttpServletRequest request, HttpServletResponse response) {
			ModelAndView mav = null;
			
			try {
				mav = new ModelAndView();
				
				
			} catch (Exception e) {
				logger.error(e, e);
			}
			return mav;
		} 	 


		@SuppressWarnings("unchecked")
		public ModelAndView resultScdExecPrpdInfoPop(HttpServletRequest request, HttpServletResponse response) {
			ModelAndView mav = null;

			try {
				
				mav = new ModelAndView();
				mav.setViewName("/result/result_1st");				
				
				HashMap map = WebUtil.parseRequestMap(request);
				
				/***** paging *****/ 
				int limit = 0;
				if((String)map.get("limit") != null)
					limit = Integer.parseInt((String)map.get("limit"));
				int start = 0;
				if((String)map.get("start") != null)
					start = Integer.parseInt((String)map.get("start"));
				
				map.put("limit", limit+start);  			
				
				HashMap adminMap = (HashMap)request.getSession().getAttribute(SGConfigManager.getString("common.session.admin.name"));
				
				map.put("admin_id", (String)adminMap.get("ADMIN_ID"));
				map.put("groups", (String)adminMap.get("GROUPS"));
						
				map.put("scd_day_reg_dept", pjtManageBiz.getDeptCode((String)adminMap.get("SABUN")));
				map.put("scd_day_reg_emp_num", (String)adminMap.get("SABUN")); 
				
				if( (String)map.get("prod_file_name") != null )  //이름으로만 검색
				{
					if(!((String)map.get("prod_file_name")).equals(""))
					{
						map.put("src_scd_day_seq", "");
					}
				}
				
				/***** DB에서 목록조회 *****/
				List result = scdInfoMngBiz.selectScdExecPrpdInfoPop(map);			
				
				/***** 조회된 결과를 JSON형식으로 screen에 Return *****/
				JSONArray jsonArray = JSONArray.fromObject(result);
				HashMap<String,Object> mapResult = new HashMap<String, Object>();
				mapResult.put("success", "true");								// 성공여부
				mapResult.put("message", "Loaded data");						// message
				
				mapResult.put("data_1st_pop", jsonArray);							// 조회된 결과값
				mapResult.put("total_1st_pop", scdInfoMngBiz.selectScdExecPrpdInfoPopCount(map)); 	// 목록의 총갯수 조회

				JSONObject jsonObject = JSONObject.fromObject(mapResult);		// JSON형식으로 설정
				mav.addObject("RESULT_1ST", jsonObject);						// 조회된 결과값을 담기

				mav.addObject("pMap",map);
				
			} catch (Exception e) { 
				logger.error("::"+this.getClass()+"[--resultScdExecPrpdInfoPop-->]"+e.getMessage()); 
			}
			return mav;
		}
		
		
}
