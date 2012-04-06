package com.sg.sgis.dev.scdInfoMng;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.servlet.ModelAndView;

import com.sg.sgis.dev.pjdInfoMng.dao.PjdInfoMngImpl;
import com.sg.sgis.dev.scdInfoMng.dao.ScdDayInfoMngImpl;
import com.sg.sgis.dev.scdInfoMng.dao.ScdInfoMngImpl;
import com.signgate.core.exception.BizException;
import com.signgate.core.exception.DaoException;
import com.signgate.core.web.biz.BaseDownloadBiz;
import com.signgate.core.web.servlet.vo.DownloadFileBean;

public class ScdInfoMngBiz extends BaseDownloadBiz {
	
	protected final Log logger = LogFactory.getLog(getClass());
	
	private ScdInfoMngImpl scdInfoMngDao;

	public ScdInfoMngImpl getScdInfoMngDao() {
		return scdInfoMngDao;
	}

	public void setScdInfoMngDao(ScdInfoMngImpl scdInfoMngDao) {
		this.scdInfoMngDao = scdInfoMngDao;
	}		
	
	
	private ScdDayInfoMngImpl scdDayInfoMngDao;


	public ScdDayInfoMngImpl getScdDayInfoMngDao() {
		return scdDayInfoMngDao;
	}


	public void setScdDayInfoMngDao(ScdDayInfoMngImpl scdDayInfoMngDao) {
		this.scdDayInfoMngDao = scdDayInfoMngDao;
	}		
	
	private PjdInfoMngImpl pjdInfMngDao;

	public PjdInfoMngImpl getPjdInfMngDao() {
		return pjdInfMngDao;
	}

	public void setPjdInfMngDao(PjdInfoMngImpl pjdInfMngDao) {
		this.pjdInfMngDao = pjdInfMngDao;
	}		
	
	/**
	 * 개발프로젝트관리 조회
	 * @param  paramMap
	 * @return list
	 * @throws DaoException
	 * 2011. 2. 8.
	 */
	@SuppressWarnings("unchecked")
	public List selectScdPjdInfo(HashMap paramMap){
		List list = null;
		
		try{
			list = scdInfoMngDao.selectScdPjdInfo(paramMap);
			
		}catch(Exception e){
			logger.error(e, e);
		}
		return list;
	}
	
	
	@SuppressWarnings("unchecked")
	public int selectScdPjdInfoCount(HashMap map) throws Exception{
		int cnt = 0;
		try{ 
			cnt = scdInfoMngDao.selectScdPjdInfoCount(map);			 
		}catch(Exception e){
			logger.error("::"+this.getClass()+"[--selectScdPjdInfoCount-->]"+e.toString()); 
			throw new Exception();
		}
		return cnt;
	}	
	
	
	/**
	 * 타스크 정보  목록조회
	 * @param  paramMap
	 * @return list
	 * @throws DaoException
	 * 2011. 2. 8.
	 */
	@SuppressWarnings("unchecked")
	public List selectScdPlanInfo(HashMap paramMap){
		List list = null;
		
		try{
			list = scdInfoMngDao.selectScdPlanInfo(paramMap);
			
		}catch(Exception e){
			logger.error(e, e);
		}
		return list;
	}
	
	
	@SuppressWarnings("unchecked")
	public int selectScdPlanInfoCount(HashMap map) throws Exception{
		int cnt = 0;
		try{ 
			cnt = scdInfoMngDao.selectScdPlanInfoCount(map);			 
		}catch(Exception e){
			logger.error("::"+this.getClass()+"[--selectScdPlanInfoCount-->]"+e.toString()); 
			throw new Exception();
		}
		return cnt;
	}	
	
	/**
	 * 타스크 담당자  목록조회
	 * @param  paramMap
	 * @return list
	 * @throws DaoException
	 * 2011. 2. 8.
	 */
	@SuppressWarnings("unchecked")
	public List selectScdDutyAssign(HashMap paramMap){
		List list = null;
		
		try{
			list = scdInfoMngDao.selectScdDutyAssign(paramMap);
			
		}catch(Exception e){
			logger.error(e, e);
		}
		return list;
	}
	
	
	@SuppressWarnings("unchecked")
	public int selectScdDutyAssignCount(HashMap map) throws Exception{
		int cnt = 0;
		try{ 
			cnt = scdInfoMngDao.selectScdDutyAssignCount(map);			 
		}catch(Exception e){
			logger.error("::"+this.getClass()+"[--selectScdDutyAssignCount-->]"+e.toString()); 
			throw new Exception();
		}
		return cnt;
	}		
	
	
	/**
	 * 타스크 정보  저장
	 * @param  paramMap
	 * @return list
	 * @throws DaoException
	 * 2011. 2. 8.
	 */	
	public boolean insertScdPlanInfo(HashMap map) throws BizException {
		boolean retBoolean = false;
		try{
			scdInfoMngDao.insertScdPlanInfo(map);
			retBoolean = true;
		}catch(Exception e){
			retBoolean = false;
			logger.error(e, e);
			throw new BizException("");
		}
		
		return retBoolean;
	}	

	/**
	 * 타스크 정보  수정
	 * @param  paramMap
	 * @return list
	 * @throws DaoException
	 * 2011. 2. 8.
	 */	
	public boolean updateScdPlanInfo(HashMap map) throws BizException {
		boolean retBoolean = false;
		try{
			scdInfoMngDao.updateScdPlanInfo(map);
			retBoolean = true;
		}catch(Exception e){
			retBoolean = false;
			logger.error(e, e);
			throw new BizException("");
		}
		
		return retBoolean;
	}	
	

	/**
	 * 타스크 정보  삭제
	 * @param  paramMap
	 * @return list
	 * @throws DaoException
	 * 2011. 2. 8.
	 */	
	public boolean deleteScdPlanInfo(HashMap paramMap,HttpServletRequest request) throws BizException {
		boolean retBoolean = false;
		try{
			
			String deleteData = (String)request.getParameter("deleteData");	
			
		
			JSONArray jsonArray1 = JSONArray.fromObject(deleteData);
			
			for (int i=0; i < jsonArray1.size(); i++) {
				JSONObject jsonData = jsonArray1.getJSONObject(i);
			
				HashMap<String,String> map = new HashMap<String,String>();
			    Iterator iter = jsonData.keys();
			    while(iter.hasNext()){
			        String key = (String)iter.next();
			        String value = jsonData.getString(key);
			        map.put(key.toLowerCase(),value);
			    }
			    
			    scdInfoMngDao.deleteScdPlanInfo(map);			// 삭제
			    
			    HashMap<String,String> deleteScdDutyAssignMap = new HashMap<String,String>();
			    
			    /***** 타스크에 배정된 타스크 담당자 삭제 *****/
			    deleteScdDutyAssignMap.put("scd_plan_seq", (String)map.get("scd_plan_seq"));
				deleteScdDutyAssignMap.put("scd_duty_seq", "");
								
				scdInfoMngDao.deleteScdDutyAssign(deleteScdDutyAssignMap);			// 타스크 담당자 삭제
				
				paramMap.put("pjt_id", (String)map.get("pjt_id"));
			}				
			
			
			int rowTotCnt = Integer.parseInt((String)paramMap.get("rowTotCnt"));

			if(rowTotCnt == jsonArray1.size() ) //선택된 모두가 삭제가 되면
			{
				
				//진행상태 history
				paramMap.put("pjt_proc_name", "타스크삭제" );
			    paramMap.put("his_comment", (String)paramMap.get("pjt_name"));
			    
				paramMap.put("pjt_status_code", "");
				pjdInfMngDao.insertPjtHistory(paramMap);
				
				
				//프로제트 진행상태 G10-프로젝트등록
				paramMap.put("proc_status_code", "G10");
				scdDayInfoMngDao.updatePjtInfoStatus(paramMap);
				
				//진행상태 history
				paramMap.put("pjt_proc_name", "프로젝트등록" );
			    paramMap.put("his_comment", (String)paramMap.get("pjt_name"));
			    
				paramMap.put("pjt_status_code", (String)paramMap.get("proc_status_code"));
				pjdInfMngDao.insertPjtHistory(paramMap);				
			}			
			
			retBoolean = true;
		}catch(Exception e){
			retBoolean = false;
			logger.error(e, e);
			throw new BizException("");
		}
		
		return retBoolean;
	}
	

	/**
	 * 타스크담당자 정보  저장
	 * @param  paramMap
	 * @return list
	 * @throws DaoException
	 * 2011. 2. 8.
	 */	
	public boolean insertScdDutyAssign(HashMap map) throws BizException {
		boolean retBoolean = false;
		try{
			scdInfoMngDao.insertScdDutyAssign(map);
			retBoolean = true;
		}catch(Exception e){
			retBoolean = false;
			logger.error(e, e);
			throw new BizException("");
		}
		
		return retBoolean;
	}	

	/**
	 * 타스크담당자 정보  수정
	 * @param  paramMap
	 * @return list
	 * @throws DaoException
	 * 2011. 2. 8.
	 */	
	public boolean updateScdDutyAssign(HashMap map) throws BizException {
		boolean retBoolean = false;
		try{
			scdInfoMngDao.updateScdDutyAssign(map);
			retBoolean = true;
		}catch(Exception e){
			retBoolean = false;
			logger.error(e, e);
			throw new BizException("");
		}
		
		return retBoolean;
	}	
	
	
	
	/**
	 * 타스크담당자 정보  삭제
	 * @param  paramMap
	 * @return list
	 * @throws DaoException
	 * 2011. 2. 8.
	 */	
	public boolean deleteScdDutyAssign(HashMap paramMap,HttpServletRequest request) throws BizException {
		boolean retBoolean = false;
		try{
			
			String deleteData = (String)request.getParameter("deleteData");	
			
		
			JSONArray jsonArray1 = JSONArray.fromObject(deleteData);

			for (int i=0; i < jsonArray1.size(); i++) {
				JSONObject jsonData = jsonArray1.getJSONObject(i);
			
				HashMap<String,String> map = new HashMap<String,String>();
			    Iterator iter = jsonData.keys();
			    while(iter.hasNext()){
			        String key = (String)iter.next();
			        String value = jsonData.getString(key);
			        map.put(key.toLowerCase(),value);
			    }
			    
			    map.put("scd_plan_seq", "");					// scd_duty_seq 만 삭제
			    scdInfoMngDao.deleteScdDutyAssign(map);			// 삭제
			}				

			retBoolean = true;
		}catch(Exception e){
			retBoolean = false;
			logger.error(e, e);
			throw new BizException("");
		}
		
		return retBoolean;
	}	
	
	
	/**
	 * 개발일정계획 정보 입력, 수정
	 * @param request	( : 프로젝트 기본정보
	 *                  , : 타스크정보
	 *                  , : 타스크 담당자정보
	 * 					)
	 * @param response
	 * @return
	 * @throws Exception
	 * 2011. 4. 7.
	 */
	@SuppressWarnings("unchecked")
	public ModelAndView actionScdInfoMng(HashMap paramMap,HttpServletRequest request)throws Exception{
		boolean result = true;
		ModelAndView mav = new ModelAndView(); 
		
		try{
			
			int new_scd_plan_seq = 0;

			String selTaskCode ="";
			String searchScdPlanSeq="";
			
			/********** 1. 타스크정보 저장, 수정 **********/
			String recvJsonScdPlanInfo = (String)request.getParameter("edit1stData");			
			JSONArray jsonArrayScdPlanInfo = JSONArray.fromObject(recvJsonScdPlanInfo);
			
			/********** 2. 타스크담당자  저장, 수정 **********/
			String recvJsonDataScdDutyAssign = (String)request.getParameter("edit2ndData");			
			JSONArray jsonArrayScdDutyAssign = JSONArray.fromObject(recvJsonDataScdDutyAssign);		
			
			
			selTaskCode = (String)paramMap.get("selTaskCode");
			
			// 타스크 정보
			for (int i=0; i < jsonArrayScdPlanInfo.size(); i++) {
				JSONObject jsonData = new JSONObject();
				jsonData = jsonArrayScdPlanInfo.getJSONObject(i);
			
				HashMap<String,String> map = new HashMap<String,String>();
			    Iterator iter = jsonData.keys();
			    while(iter.hasNext()){
			        String key = (String)iter.next();
			        String value = jsonData.getString(key);
			        map.put(key.toLowerCase(),value);
			    }
			    
			    // session정보 설정
			    map.put("final_mod_id", (String)paramMap.get("final_mod_id"));
			    
				/********** 1. 타스크정보 저장, 수정 **********/
				if(((String)map.get("flag")).equals("I"))		//신규
				{
					new_scd_plan_seq = scdInfoMngDao.selectScdPlanSeq();	//일정계획순번
					map.put("scd_plan_seq", Integer.toString(new_scd_plan_seq));
					insertScdPlanInfo(map);			// 저장	
					
					if(i==0)
					{
						int rowTotCnt = Integer.parseInt((String)paramMap.get("rowTotCnt"));

						if(rowTotCnt == jsonArrayScdPlanInfo.size() ) //선택된 모두가 삭제가 되면
						{
							
							
							paramMap.put("pjt_id", (String)map.get("pjt_id"));
							//프로제트 진행상태 G50-프로젝트 진행
							paramMap.put("proc_status_code", "G20");
							scdDayInfoMngDao.updatePjtInfoStatus(paramMap);
							
							//진행상태 history
							paramMap.put("pjt_proc_name", "프로젝트일정계획등록" );
						    paramMap.put("his_comment", (String)paramMap.get("pjt_name"));
						    
							paramMap.put("pjt_status_code", (String)paramMap.get("proc_status_code"));
							pjdInfMngDao.insertPjtHistory(paramMap);			
						}	
						

					}	
				}else
				{
					updateScdPlanInfo(map);			// 수정
					new_scd_plan_seq = Integer.parseInt((String)map.get("scd_plan_seq"));
				}
				
				if(selTaskCode.equals((String)map.get("task_code")))	//동일 타스크코드에 대한 일정계획순번(FK)
				{
					searchScdPlanSeq = Integer.toString(new_scd_plan_seq);
				}
 

			}// End for
			
			
			//타스크 담당자 정보 
			for (int i_2=0; i_2 < jsonArrayScdDutyAssign.size(); i_2++) {
				JSONObject jsonData_2 = new JSONObject();
				jsonData_2 = jsonArrayScdDutyAssign.getJSONObject(i_2);
			
				HashMap<String,String> map_2 = new HashMap<String,String>();
			    Iterator iter_2 = jsonData_2.keys();
			    while(iter_2.hasNext()){
			        String key = (String)iter_2.next();
			        String value = jsonData_2.getString(key);
			        map_2.put(key.toLowerCase(),value);
			    }
			    
			    // session정보 설정
			    map_2.put("final_mod_id", (String)paramMap.get("final_mod_id"));

			    if(searchScdPlanSeq.equals(""))
			    {
			    	searchScdPlanSeq = 	(String)map_2.get("scd_plan_seq");
			    }
			    
			    
				/********** 2. 타스크담당자  저장, 수정 **********/	
				if(((String)map_2.get("flag")).equals("I"))		//신규
				{
					map_2.put("scd_plan_seq", searchScdPlanSeq);	//일정계획순번					
					insertScdDutyAssign(map_2);			// 저장	
					
				}else
				{
					updateScdDutyAssign(map_2);			// 수정
				}
			}// End for				
			
			mav = actionAfterScdInfo(paramMap, searchScdPlanSeq);
			
		}catch(Exception e){
			logger.error(e,e);
			result = false;
		}
		return mav;
	}	

	
	/**
	 * 저장,수정후 재조회
	 * @param request	()
	 * @param response
	 * @return
	 * @throws Exception
	 * 2011. 4. 7.
	 */
	@SuppressWarnings("unchecked")
	public ModelAndView actionAfterScdInfo(HashMap map, String search_scd_plan_seq)throws Exception{
		ModelAndView mav = new ModelAndView(); 
		JSONArray jsonArray = new JSONArray();
		JSONObject jsonObject = new JSONObject();
		HashMap<String,Object> mapResult = new HashMap();
		
		try{
			mav = new ModelAndView();
			mav.setViewName("/result/result_1st");
			
			String search_scd_type_code ="";
			String search_pjt_id ="";
			
		
			
			/***** paging *****/ 
			int limit = 0;
			if((String)map.get("limit") != null)
				limit = Integer.parseInt((String)map.get("limit"));
			int start = 0;
			if((String)map.get("start") != null)
				start = Integer.parseInt((String)map.get("start"));
			
			map.put("limit", limit+start); 
			
			search_scd_type_code = (String)map.get("search_scd_type_code");
			search_pjt_id = (String)map.get("search_pjt_id");
			
			map.put("scd_type_code", search_scd_type_code); 
			map.put("pjt_id", search_pjt_id); 
			
			
			if(!search_pjt_id.equals(""))
			{
				map.put("src_pjt_date_from", ""); 
				map.put("src_pjt_date_to", ""); 
			}

			/***** 프로젝트 기본정보 목록조회 *****/
			List result = selectScdPjdInfo(map);						 
			jsonArray = JSONArray.fromObject(result); 			
			mapResult.put("success", "true");							// 성공여부
			mapResult.put("message", "Loaded data");					// message
			mapResult.put("data_1st", jsonArray);									// 프로젝트 기본정보 조회
			mapResult.put("total_1st", selectScdPjdInfoCount(map));	// 목록의 총갯수 조회

			mapResult.put("searchPjtId", search_pjt_id);			
			mapResult.put("searchScdPlanSeq", search_scd_plan_seq);					
			
			jsonObject = JSONObject.fromObject(mapResult);		

			mav.addObject("RESULT_1ST", jsonObject);						// 조회된 결과값을 담기
			
			
		}catch (Exception e){
			mapResult.put("success", "false");								// 성공여부
			mapResult.put("message", e.toString());							// message
			
			logger.error(e, e);
		}finally{
			
		}
			return mav;
	}	
	
	
	 
	/**
	 * 타스크정보 순번 가져오기
	 */	
	@SuppressWarnings("unchecked")
	public int selectScdPlanSeq() throws Exception{
		int cnt = 0;
		try{ 
			cnt = scdInfoMngDao.selectScdPlanSeq();			 
		}catch(Exception e){
			logger.error("::"+this.getClass()+"[--selectScdPlanSeq-->]"+e.toString()); 
			throw new Exception();
		}
		return cnt;
	}	
	
	
	/**
	 * 일정수행산출물관리  저장
	 * @param  paramMap
	 * @return list
	 * @throws DaoException
	 * 2011. 2. 8.
	 */	
	public boolean insertScdExecPrpdInfo(HashMap map) throws BizException {
		boolean retBoolean = false;
		try{
			scdInfoMngDao.insertScdExecPrpdInfo(map);
			retBoolean = true;
		}catch(Exception e){
			retBoolean = false;
			logger.error(e, e);
			throw new BizException("");
		}
		
		return retBoolean;
	}		
	
	/**
	 * 일정수행산출물관리  수정
	 * @param  paramMap
	 * @return list
	 * @throws DaoException
	 * 2011. 2. 8.
	 */	
	public boolean updateScdExecPrpdInfo(HashMap map) throws BizException {
		boolean retBoolean = false;
		try{
			scdInfoMngDao.updateScdExecPrpdInfo(map);
			retBoolean = true;
		}catch(Exception e){
			retBoolean = false;
			logger.error(e, e);
			throw new BizException("");
		}
		
		return retBoolean;
	}	
	
	/**
	 * 일정수행산출물관리  삭제
	 * @param  paramMap
	 * @return list
	 * @throws DaoException
	 * 2011. 2. 8.
	 */	
	public boolean deleteScdExecPrpdInfo(HashMap map) throws BizException {
		boolean retBoolean = false;
		try{
			scdInfoMngDao.deleteScdExecPrpdInfo(map);
			retBoolean = true;
		}catch(Exception e){
			retBoolean = false;
			logger.error(e, e);
			throw new BizException("");
		}
		
		return retBoolean;
	}
	

	/**
	 * 일정수행산출물관리 조회
	 * @param  paramMap
	 * @return list
	 * @throws DaoException
	 * 2011. 2. 8.
	 */
	@SuppressWarnings("unchecked")
	public List selectScdExecPrpdInfo(HashMap paramMap){
		List list = null;
		
		try{
			list = scdInfoMngDao.selectScdExecPrpdInfo(paramMap);
			
		}catch(Exception e){
			logger.error(e, e);
		}
		return list;
	}	
	
	
	@SuppressWarnings("unchecked")
	public int selectScdExecPrpdInfoCount(HashMap map) throws Exception{
		int cnt = 0;
		try{ 
			cnt = scdInfoMngDao.selectScdExecPrpdInfoCount(map);			 
		}catch(Exception e){
			logger.error("::"+this.getClass()+"[--selectScdExecPrpdInfoCount-->]"+e.toString()); 
			throw new Exception();
		}
		return cnt;
	}		
	
	
	/**
	 * 일정수행산출물관리 팝업조회
	 * @param  paramMap
	 * @return list
	 * @throws DaoException
	 * 2011. 2. 8.
	 */
	@SuppressWarnings("unchecked")
	public List selectScdExecPrpdInfoPop(HashMap paramMap){
		List list = null;
		
		try{
			list = scdInfoMngDao.selectScdExecPrpdInfoPop(paramMap);
			
		}catch(Exception e){
			logger.error(e, e);
		}
		return list;
	}	
	
	
	@SuppressWarnings("unchecked")
	public int selectScdExecPrpdInfoPopCount(HashMap map) throws Exception{
		int cnt = 0;
		try{ 
			cnt = scdInfoMngDao.selectScdExecPrpdInfoPopCount(map);			 
		}catch(Exception e){
			logger.error("::"+this.getClass()+"[--selectScdExecPrpdInfoPopCount-->]"+e.toString()); 
			throw new Exception();
		}
		return cnt;
	}		
	
	
	/**
	 * 일정관리에 등록된 타스크수
	 * @param  paramMap
	 * @return list
	 * @throws DaoException
	 * 2011. 2. 8.
	 */	
	@SuppressWarnings("unchecked")
	public int selectScdDayInfoTaskCnt(HashMap map) throws Exception{
		int cnt = 0;
		try{ 
			cnt = scdInfoMngDao.selectScdDayInfoTaskCnt(map);			 
		}catch(Exception e){
			logger.error("::"+this.getClass()+"[--selectScdDayInfoTaskCnt-->]"+e.toString()); 
			throw new Exception();
		}
		return cnt;
	}	
	
	
	/**
	 * 일정관리에 등록된 담당자수
	 * @param  paramMap
	 * @return list
	 * @throws DaoException
	 * 2011. 2. 8.
	 */	
	@SuppressWarnings("unchecked")
	public int selectScdDayInfoRegEmpCnt(HashMap map) throws Exception{
		int cnt = 0;
		try{ 
			cnt = scdInfoMngDao.selectScdDayInfoRegEmpCnt(map);			 
		}catch(Exception e){
			logger.error("::"+this.getClass()+"[--selectScdDayInfoRegEmpCnt-->]"+e.toString()); 
			throw new Exception();
		}
		return cnt;
	}	
	
	/**
	 * 산출물다운로드
	 * @param  paramMap
	 * @return list
	 * @throws DaoException
	 * 2011. 2. 8.
	 */	
	@SuppressWarnings("unchecked")
	public DownloadFileBean selFileInfo(Map parameterMap) {
		DownloadFileBean dfb = null;
		try{ 
			dfb = (DownloadFileBean)scdInfoMngDao.getDownloadFile((HashMap)parameterMap);
			
		}catch(Exception e){
			logger.error(e, e);
		}
		return dfb;
	}
		
}
