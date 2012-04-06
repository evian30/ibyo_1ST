/**
 *  Class Name  : TaskDao.java
 *  Description : 타스크관리 Dao
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
package com.sg.sgis.com.task.dao;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.ibatis.sqlmap.engine.mapping.sql.Sql;
import com.signgate.core.dao.BaseDao;
import com.signgate.core.exception.DaoException;

public class TaskDao extends BaseDao implements TaskDaoImpl{

	protected final Log logger = LogFactory.getLog(getClass());

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
	public List selectTask(HashMap paramMap) throws DaoException {
		return queryForList("Task.selectTask", paramMap);
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
	public int selectTaskCount(HashMap paramMap) throws DaoException {
		return queryForInt("Task.selectTaskCount",paramMap); 
	}

	/**
	 * 타스크정보관리 등록
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
	 * @return int
	 * 2011. 3. 15.
	 */
	public int insertTask(HashMap paramMap) throws DaoException {
		// TODO Auto-generated method stub
		return update("Task.insertTask",paramMap);
	}

	/**
	 * 타스크정보관리 수정
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
	 * @return int
	 * 2011. 3. 15.
	 * @throws SQLException 
	 */
	public boolean updateTask(HashMap paramMap, HttpServletRequest request) throws DaoException, SQLException {

		boolean result = true;
		
		// session정보 설정
		// HashMap adminMap = (HashMap)request.getSession().getAttribute(SGConfigManager.getString("common.session.admin.name"));
			
		//paramMap.put("final_mod_id", (String)adminMap.get("ADMIN_ID"));
		
		try{
			
			getSqlMapClient().startTransaction();
			
			// flag값이 없으면 신규, 그렇지 않으면 저장
			if(("").equals(paramMap.get("flag"))){
				// 저장
				update("Task.insertTask",paramMap);
				
			}else{ 
				// 수정
				update("Task.updateTask",paramMap);
			}
			
			// 편집그리드의 내용을 받아서 처리하는부분
			String recvJsonData = (String)request.getParameter("data");			
			JSONArray jsonArray1 = JSONArray.fromObject(recvJsonData);
			
			for (int i=0; i < jsonArray1.size(); i++) {
				JSONObject jsonData = jsonArray1.getJSONObject(i);
			
				HashMap<String,String> map = new HashMap<String,String>();
			    Iterator iter = jsonData.keys();
			    while(iter.hasNext()){
			        String key = (String)iter.next();
			        String value = jsonData.getString(key);
			        
			        map.put(key.toLowerCase(),value);
			    }
			    
			    // session정보 설정
			   // map.put("final_mod_id", (String)adminMap.get("ADMIN_ID"));
			    
			    if("I".equals(map.get("flag"))){
			    	update("Task.insertTaskReportInfo",map);
			    }else{
			    	update("Task.updateTaskReportInfo",map);
			    }

			}
			
			getSqlMapClient().commitTransaction();
			
		}catch(Exception e){
			logger.error(e, e);
			e.printStackTrace();
			result = false;
		}finally{
			getSqlMapClient().endTransaction();
		}
		
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
	public String checkTaskCode(HashMap paramMap) throws DaoException {
		// TODO Auto-generated method stub
		return queryForString("Task.checkTaskCode",paramMap);
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
	public List selectTaskReportInfo(HashMap paramMap) throws DaoException {
		return queryForList("Task.selectTaskReportInfo", paramMap);
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
	public int selectTaskReportInfoCnt(HashMap paramMap) throws DaoException {
		return queryForInt("Task.selectTaskReportInfoCnt",paramMap); 
	}

	public int insertTaskReportInfo(HashMap map) throws DaoException {
		return update("Task.insertTaskReportInfo",map);
	}

	public int updateTaskReportInfo(HashMap map) throws DaoException {
		return update("Task.updateTaskReportInfo",map);
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
	public List selectTaskPop(HashMap paramMap) throws DaoException {
		return queryForList("Task.selectTaskPop", paramMap);
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
	public int selectTaskPopCount(HashMap paramMap) throws DaoException {
		return queryForInt("Task.selectTaskPopCount",paramMap); 
	}
	
}
