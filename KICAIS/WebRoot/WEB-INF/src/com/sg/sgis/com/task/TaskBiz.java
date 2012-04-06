/**
 *  Class Name  : TaskBiz.java
 *  Description : 타스크관리 Biz
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

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.sg.sgis.com.task.dao.TaskDaoImpl;
import com.signgate.core.config.SGConfigManager;

public class TaskBiz {

	protected final Log logger = LogFactory.getLog(getClass());
	
	// Dao경로 설정
	private TaskDaoImpl taskDao; 
	public void setTaskDao(TaskDaoImpl taskDao)
	{
		this.taskDao = taskDao;
	}
	
	/**
	 * 타스크정보관리 목록조회
	 * @param  paramMap	( src_task_group_code : 타스크그룹코드
	 *                  , src_task_code 	  : 타스크코드
	 *                  , src_task_name       : 타스크명
	 *                  , start				  : 검색(시작페이지)
	 *                  , limit				  : 검색(종료페이지)
	 * @return list     ( COM_TASK_INFO : 타스크정보관리)
	 * @throws Exception
	 * 2011. 3. 15.
	 */
	public List selectTask(HashMap paramMap)throws Exception{
		List list = null;
		
		try{
			
			list = taskDao.selectTask(paramMap);
			
		}catch(Exception e){
			logger.error(e, e);
		}
		return list;
	}

	/**
	 * 타스크정보관리 목록총갯수
	 * @param  paramMap	( src_TASK_GROUP_CODE : 타스크그룹코드
	 *                  , src_TASK_CODE 	  : 타스크코드
	 *                  , src_TASK_NAME       : 타스크명
	 *                  )
	 * @return int      (목록 총갯수)
	 * @throws Exception
	 * 2011. 3. 15.
	 */
	public int selectTaskCount(HashMap paramMap)throws Exception{
		int result = 0;

		try{

			result = taskDao.selectTaskCount(paramMap);
			
		}catch(Exception e){
			logger.error(e, e);
		}
		return result;
	}

	/**
	 * 타스크정보관리 등록, 수정
	 * @param  request  ( TASK_CODE		      : 타스크코드 
					    , TASK_GROUP_CODE     : 타스크그룹코드
					    , TASK_GROUP_NAME     : 타스크그룹명
					    , TASK_NAME           : 타스크명
					    , TASK_DESC           : 타스크설명
					    , NOTE       		  : 비고
					    , USE_YN			  : 사용여부 
					    , SRC_TASK_CODE       : 검색_타스크코드
					    , SRC_TASK_GROUP_CODE : 검색_타스크그룹코드
					    , SRC_TASK_NAME       : 검색_타스크명
					    , START				  : 검색_시작페이지
					    , LIMIT	  			  : 검색_종료페이지
					    )
	 * @return response ( true	: 등록, 수정 성공
	 *                  , false : 등록, 수정 실패
	 *                  )
	 * 2011. 3. 15.
	 */
	public boolean updateTask(HashMap paramMap, HttpServletRequest request)throws Exception{
		boolean result = true;
		
			// 저장
			result = taskDao.updateTask(paramMap, request);
				
		return result;
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
	public String checkTaskCode(HashMap paramMap)throws Exception{
		String result = "";
		
		try{

			result = taskDao.checkTaskCode(paramMap);
			
		}catch(Exception e){
			logger.error(e, e);
		}
		return result;
	}

	/**
	 * 타스크산출물 목록조회
	 * @param  paramMap	( task_group_code : 타스크그룹코드
	 *                  , task_code 	  : 타스크코드
	 *                  , start			  : 검색(시작페이지)
	 *                  , limit			  : 검색(종료페이지)
	 * @return list     ( COM_TASK_REPORT_INFO : 타스크별 산출물관리)
	 * @throws Exception
	 * 2011. 3. 29.
	 */
	public List selectTaskReportInfo(HashMap paramMap)throws Exception{
		List list = null;
		
		try{
			
			list = taskDao.selectTaskReportInfo(paramMap);
			
		}catch(Exception e){
			logger.error(e, e);
		}
		return list;
	}

	/**
	 * 타스크산출물 목록조회 총건수
	 * @param  paramMap	( task_group_code : 타스크그룹코드
	 *                  , task_code 	  : 타스크코드
	 *                  , start			  : 검색(시작페이지)
	 *                  , limit			  : 검색(종료페이지)
	 * @return int 
	 * @throws Exception
	 * 2011. 3. 29.
	 */
	public int selectTaskReportInfoCnt(HashMap paramMap)throws Exception{
		int result = 0;

		try{

			result = taskDao.selectTaskReportInfoCnt(paramMap);
			
		}catch(Exception e){
			logger.error(e, e);
		}
		return result;
	}
	
	/**
	 * 타스크정보관리 목록팝업조회
	 * @param  paramMap	( src_task_group_code : 타스크그룹코드
	 *                  , src_task_code 	  : 타스크코드
	 *                  , src_task_name       : 타스크명
	 *                  , start				  : 검색(시작페이지)
	 *                  , limit				  : 검색(종료페이지)
	 * @return list     ( COM_TASK_INFO : 타스크정보관리)
	 * @throws Exception
	 * 2011. 3. 15.
	 */
	public List selectTaskPop(HashMap paramMap)throws Exception{
		List list = null;
		
		try{
			
			list = taskDao.selectTaskPop(paramMap);
			
		}catch(Exception e){
			logger.error(e, e);
		}
		return list;
	}

	/**
	 * 타스크정보관리 목록팝업총갯수
	 * @param  paramMap	( src_TASK_GROUP_CODE : 타스크그룹코드
	 *                  , src_TASK_CODE 	  : 타스크코드
	 *                  , src_TASK_NAME       : 타스크명
	 *                  )
	 * @return int      (목록 총갯수)
	 * @throws Exception
	 * 2011. 3. 15.
	 */
	public int selectTaskPopCount(HashMap paramMap)throws Exception{
		int result = 0;

		try{

			result = taskDao.selectTaskPopCount(paramMap);
			
		}catch(Exception e){
			logger.error(e, e);
		}
		return result;
	}
	
}
