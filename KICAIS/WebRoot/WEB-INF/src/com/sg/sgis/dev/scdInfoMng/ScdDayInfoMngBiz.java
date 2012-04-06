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

import com.sg.sgis.dev.pjdInfoMng.dao.PjdInfoMngImpl;
import com.sg.sgis.dev.scdInfoMng.dao.ScdDayInfoMngImpl;
import com.signgate.core.exception.BizException;
import com.signgate.core.exception.DaoException;
import com.signgate.core.web.servlet.vo.DownloadFileBean;

public class ScdDayInfoMngBiz {
	protected final Log logger = LogFactory.getLog(getClass());
	
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
	 * 공통코드 조회 
	 */	 
	@SuppressWarnings("unchecked")
	public List selectComboCode(String searchCode){
		List list = null; 
		
		try{
			list = scdDayInfoMngDao.selectComboCode(searchCode); 
			
		}catch(Exception e){
			e.printStackTrace();
			logger.error(e, e);
		}
		return list;
	}
	

	/**
	 * 오늘의 일정 
	 */	 
	 
	@SuppressWarnings("unchecked")
	public List selectSchedule(HashMap paramMap){
		List list = null;
		
		try{ 
		
			list = scdDayInfoMngDao.selectSchedule(paramMap);
			
		}catch(Exception e){
			logger.error("::"+this.getClass()+"[--selectSchedule-->]"+e.toString()); 
		}
		return list;
	}
	 

	@SuppressWarnings("unchecked")
	public int selectScheduleCount(HashMap map) throws Exception{
		int cnt = 0;
		try{ 
			cnt = scdDayInfoMngDao.selectScheduleCount(map);			 
		}catch(Exception e){
			logger.error("::"+this.getClass()+"[--selectScheduleCount-->]"+e.toString()); 
			throw new Exception();
		}
		return cnt;
	}	

	
	/**
	 * 오늘의 일정 저장,수정
	 */	 
	public boolean actionSchedule(HashMap paramMap)throws BizException {
		
		boolean result = true;
		try{

			if((paramMap.get("insert").toString()).equals("Y")){
				scdDayInfoMngDao.insertSchedule(paramMap);
				
				//프로제트 진행상태 G50-프로젝트 진행
				paramMap.put("proc_status_code", "G50");
				scdDayInfoMngDao.updatePjtInfoStatus(paramMap);
				
				//진행상태 history
				paramMap.put("pjt_proc_name", "프로젝트 진행" );
			    paramMap.put("his_comment", (String)paramMap.get("pjt_name") );
			    
				paramMap.put("pjt_status_code", (String)paramMap.get("proc_status_code"));
				pjdInfMngDao.insertPjtHistory(paramMap);				
			}else {  
				scdDayInfoMngDao.updateSchedule(paramMap);
			}
			 
		}catch(Exception e){
			result = false;
			logger.error("::::::::::"+this.getClass()+e.toString());
		}finally{

		} 
			return result;
	}
	
	
	/**
	 * 오늘의 일정삭제
	 */	
	public boolean deleteSchedule(HashMap paramMap)throws BizException {
		
		boolean result = true;
		try{ 
			
			if(("del").equals(paramMap.get("flag"))){ 
				scdDayInfoMngDao.deleteSchedule(paramMap);
			}
			
		}catch(Exception e){
			result = false;
			logger.error("::::::::::"+this.getClass()+e.toString());
		}finally{

		} 
			return result;
	}
	

	/**
	 * 일정 등록결과 
	 */	
	@SuppressWarnings("unchecked")
	public List selectAllSchedule(HashMap paramMap){
		List list = null;
		
		try{ 
		
			list = scdDayInfoMngDao.selectAllSchedule(paramMap);
			
		}catch(Exception e){
			logger.error("::"+this.getClass()+"[--selectAllSchedule-->]"+e.toString()); 
		}
		return list;
	}
	
	
	@SuppressWarnings("unchecked")
	public int selectAllScheduleCount(HashMap map) throws Exception{
		int cnt = 0;
		try{ 
			cnt = scdDayInfoMngDao.selectAllScheduleCount(map);			 
		}catch(Exception e){
			logger.error("::"+this.getClass()+"[--selectAllScheduleCount-->]"+e.toString()); 
			throw new Exception();
		}
		return cnt;
	}
	
	
	/**
	 * 부서코드
	 */	
	public String getDeptCode(String emp_num)throws BizException {
		String result ="";
		try{
			 result = scdDayInfoMngDao.getDeptCode(emp_num);
			
		}catch(Exception e){ 
			logger.error("::::::::::"+this.getClass()+e.toString()); 
		}finally{

		} 
		return result;
	}
	
	
	/**
	 * 부서명
	 */	
	public String getDeptNm(String dept_code)throws BizException {
		String result ="";
		try{
			 result = scdDayInfoMngDao.getDeptNm(dept_code);
			
		}catch(Exception e){ 
			logger.error("::::::::::"+this.getClass()+e.toString()); 
		}finally{

		} 
		return result;
	}	


	/**
	 * 개발프로젝트 검토
	 */	
	@SuppressWarnings("unchecked")
	public List selectScheduleReview(HashMap map){
		List list = null; 
		
		try{
			list = scdDayInfoMngDao.selectScheduleReview(map); 
			
		}catch(Exception e){
			e.printStackTrace();
			logger.error(e, e);
		}
		return list;
	}
	

	@SuppressWarnings("unchecked")
	public int selectScheduleReviewCount(HashMap map) throws Exception{
		int cnt = 0;
		try{ 
			cnt = scdDayInfoMngDao.selectScheduleReviewCount(map);			 
		}catch(Exception e){
			logger.error("::"+this.getClass()+"[--selectScheduleReviewCount-->]"+e.toString()); 
			throw new Exception();
		}
		return cnt;
	}		
	
	
	/**
	 * 타스크검토결과  업데이트  
	 */	
	public boolean updateScheduleTaskChkResCode(HashMap paramMap)throws BizException {
		
		boolean result = true;
		try{ 
			
			scdDayInfoMngDao.updateScheduleTaskChkResCode(paramMap);
		
		}catch(Exception e){
			result = false;
			logger.error("::::::::::"+this.getClass()+e.toString());
		}finally{

		} 
			return result;
	}		
	
	@SuppressWarnings("unchecked")
	public int selectScdTotTaskCount(HashMap map) throws Exception{
		int cnt = 0;
		try{ 
			cnt = scdDayInfoMngDao.selectScdTotTaskCount(map);			 
		}catch(Exception e){
			logger.error("::"+this.getClass()+"[--selectScdTotTaskCount-->]"+e.toString()); 
			throw new Exception();
		}
		return cnt;
	}
	
	
	/**
	 * 담당타스크가 완료된 프로젝트의 타스크 건수
	 */	
	@SuppressWarnings("unchecked")
	public int selectScdDaySeqCount(HashMap map) throws Exception{
		int cnt = 0;
		try{ 
			cnt = scdDayInfoMngDao.selectScdDaySeqCount(map);			 
		}catch(Exception e){
			logger.error("::"+this.getClass()+"[--selectScdDaySeqCount-->]"+e.toString()); 
			throw new Exception();
		}
		return cnt;
	}	
	
	
	/**
	 * 개발프로젝트  진행상태코드 업데이트
	 */	
	public boolean updatePjtInfoStatus(HashMap paramMap)throws BizException {
		
		boolean result = true;
		try{ 
			
			scdDayInfoMngDao.updatePjtInfoStatus(paramMap);
			
		}catch(Exception e){
			result = false;
			logger.error("::::::::::"+this.getClass()+e.toString());
		}finally{

		} 
			return result;
	}	
	
	
	/**
	 * 개발프로젝트 검토 저장, 수정
	 */	
	public int actionScdDayInfoReview(HashMap paramMap,HttpServletRequest request)throws Exception{
		int result = 00;
		
		try{
			
			String new_pjt_id = "";
			
			int scdTotTaskCount =0;
			int scdDaySeqCount =0;
			
			/********** 수정 **********/

			String recvJsonDayInfo = (String)request.getParameter("edit1stData");			
			JSONArray jsonArrayDayInfo = JSONArray.fromObject(recvJsonDayInfo);
			
			for (int i=0; i < jsonArrayDayInfo.size(); i++) {
				JSONObject jsonData = new JSONObject();
				jsonData = jsonArrayDayInfo.getJSONObject(i);
			
				HashMap<String,String> map = new HashMap<String,String>();
			    Iterator iter = jsonData.keys();
			    while(iter.hasNext()){
			        String key = (String)iter.next();
			        String value = jsonData.getString(key);
			        map.put(key.toLowerCase(),value);
			    }
			    
			    // session정보 설정
			    map.put("final_mod_id", (String)paramMap.get("final_mod_id"));
			    

				//담당타스크가 완료된 프로젝트의 전체 타스크 건수
				scdTotTaskCount = selectScdTotTaskCount(map);	
				
				// 프로젝트의  완료 타스크 건수
				scdDaySeqCount = selectScdDaySeqCount(map);
				
				if(((String)map.get("task_chk_res_code")).equals("30"))	
				{
					map.put("task_end_yn", "N");
				}
				
				if(scdDaySeqCount != 0)
				{
					if((scdTotTaskCount - scdDaySeqCount) == 0)
					{
						result = 88;
						return result;
					}
				}
				
				updateScheduleTaskChkResCode(map);			// 저장
				
				if(((String)map.get("task_chk_res_code")).equals("20"))		//10-미완료, 20-완료, 30-반려
				{
					//담당타스크가 완료된 프로젝트의 전체 타스크 건수
					scdTotTaskCount = selectScdTotTaskCount(map);	
					
					// 프로젝트의  완료 타스크 건수
					scdDaySeqCount = selectScdDaySeqCount(map);
					
					
					//해당 타스크의  타스크검토결과코드가 모두 완료이면 해당 프로젝트의   진행상태코드를 완료로 업데이트함
					if((scdTotTaskCount - scdDaySeqCount) == 0)
					{
						map.put("proc_status_code", "G90");
						updatePjtInfoStatus(map);			// 프로젝트 진행상태코드 저장	
						
						//업무요청유형_제품  처리완료여부  90-요청처리완료
						map.put("deal_yn", "90"); 
						updateCsrPatternItemDealYn(map);	
						
						
						//진행상태 history
						paramMap.put("pjt_id", (String)map.get("pjt_id"));
					    paramMap.put("pjt_proc_name", "요청처리 완료" );
					    paramMap.put("his_comment", (String)map.get("pjt_name") );
						paramMap.put("pjt_status_code", (String)map.get("proc_status_code"));
						pjdInfMngDao.insertPjtHistory(paramMap);						
					}
				}
				
			}// End for
	 	
		}catch(Exception e){
			logger.error(e,e);
			result = 99;
		}
		return result;
	}	
	
	@SuppressWarnings("unchecked")
	public int selectTaskEndYnCount(HashMap map) throws Exception{
		int cnt = 0;
		try{ 
			cnt = scdDayInfoMngDao.selectTaskEndYnCount(map);			 
		}catch(Exception e){
			logger.error("::"+this.getClass()+"[--selectTaskEndYnCount-->]"+e.toString()); 
			throw new Exception();
		}
		return cnt;
	}	
	
	/**
	 * 처리완료여부 90-요청처리완료
	 * @param  paramMap
	 * @return List
	 * @throws DaoException
	 * 2011. 2. 8.
	 */		
	public boolean updateCsrPatternItemDealYn(HashMap map) throws BizException {
		boolean retBoolean = false;
		try{
			scdDayInfoMngDao.updateCsrPatternItemDealYn(map);
			retBoolean = true;
		}catch(Exception e){
			retBoolean = false;
			logger.error(e, e);
			throw new BizException("");
		}
		
		return retBoolean;
	}	
	
	
	/**
	 * 일정관리순번
	 */	
	@SuppressWarnings("unchecked")
	public int selectScdDayInfoSeq() throws Exception{
		int cnt = 0;
		try{ 
			cnt = scdDayInfoMngDao.selectScdDayInfoSeq();			 
		}catch(Exception e){
			logger.error("::"+this.getClass()+"[--selectScdDayInfoSeq-->]"+e.toString()); 
			throw new Exception();
		}
		return cnt;
	}	

}
