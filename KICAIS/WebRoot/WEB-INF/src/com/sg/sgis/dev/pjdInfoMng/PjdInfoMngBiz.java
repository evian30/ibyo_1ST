package com.sg.sgis.dev.pjdInfoMng;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.sg.sgis.dev.pjdInfoMng.dao.PjdInfoMngImpl;
import com.sg.sgis.util.CommonUtil;
import com.sg.sgis.util.GetPKIdUtil;
import com.signgate.core.config.SGConfigManager;
import com.signgate.core.exception.BizException;
import com.signgate.core.exception.DaoException;

public class PjdInfoMngBiz {
	
	protected final Log logger = LogFactory.getLog(getClass());
	
	// Dao경로 설정
	private PjdInfoMngImpl pjdInfMngDao;

	public PjdInfoMngImpl getPjdInfMngDao() {
		return pjdInfMngDao;
	}

	public void setPjdInfMngDao(PjdInfoMngImpl pjdInfMngDao) {
		this.pjdInfMngDao = pjdInfMngDao;
	}


	/**
	 * 개발프로젝트정보
	 * @param  paramMap
	 * @return list
	 * @throws DaoException
	 * 2011. 2. 8.
	 */
	@SuppressWarnings("unchecked")
	public List selectPjdInfo(HashMap paramMap){
		List list = null;
		
		try{
			list = pjdInfMngDao.selectPjdInfo(paramMap);
			
		}catch(Exception e){
			logger.error(e, e);
		}
		return list;
	}
	
	
	@SuppressWarnings("unchecked")
	public int selectPjdInfoCount(HashMap map) throws Exception{
		int cnt = 0;
		try{ 
			cnt = pjdInfMngDao.selectPjdInfoCount(map);			 
		}catch(Exception e){
			logger.error("::"+this.getClass()+"[--selectPjdInfoCount-->]"+e.toString()); 
			throw new Exception();
		}
		return cnt;
	}	
	
	/**
	 * 프로젝트정보관리 등록
	 */	
	public boolean insertPjdInfo(HashMap map) throws BizException {
		boolean retBoolean = false;
		try{
			pjdInfMngDao.insertPjdInfo(map);
			retBoolean = true;
		}catch(Exception e){
			retBoolean = false;
			logger.error(e, e);
			throw new BizException("");
		}
		
		return retBoolean;
	}	

	/**
	 * 프로젝트정보관리 수정
	 */	
	public boolean updatePjdInfo(HashMap map) throws BizException {
		boolean retBoolean = false;
		try{
			pjdInfMngDao.updatePjdInfo(map);
			retBoolean = true;
		}catch(Exception e){
			retBoolean = false;
			logger.error(e, e);
			throw new BizException("");
		}
		
		return retBoolean;
	}
	
	
	/**
	 * 프로젝트정보관리 삭제
	 */	
	public boolean deletePjdInfo(HashMap map) throws BizException {
		boolean retBoolean = false;
		try{
			pjdInfMngDao.deletePjdInfo(map);
			retBoolean = true;
		}catch(Exception e){
			retBoolean = false;
			logger.error(e, e);
			throw new BizException("");
		}
		
		return retBoolean;
	}
	
	
	/**
	 * 업무요청정보  사용유무 수정
	 */	
	public boolean updatePjdInfoYn(HashMap map) throws BizException {
		boolean retBoolean = false;
		try{
			pjdInfMngDao.updatePjdInfoYn(map);
			retBoolean = true;
		}catch(Exception e){
			retBoolean = false;
			logger.error(e, e);
			throw new BizException("");
		}
		
		return retBoolean;
	}	
	
	/**
	 * 개발프로젝트관리
	 * @param  paramMap
	 * @return list
	 * @throws DaoException
	 * 2011. 2. 8.
	 */
	@SuppressWarnings("unchecked")
	public List selectPjdDevInfo(HashMap paramMap){
		List list = null;
		
		try{
			list = pjdInfMngDao.selectPjdDevInfo(paramMap);
			
		}catch(Exception e){
			logger.error(e, e);
		}
		return list;
	}
	
	
	/**
	 * 개발프로젝트관리 상세 총갯수
	 */	
	@SuppressWarnings("unchecked")
	public int selectPjdDevInfoCount(HashMap map) throws Exception{
		int cnt = 0;
		try{ 
			cnt = pjdInfMngDao.selectPjdDevInfoCount(map);			 
		}catch(Exception e){
			logger.error("::"+this.getClass()+"[--selectPjdDevInfoCount-->]"+e.toString()); 
			throw new Exception();
		}
		return cnt;
	}	
	
	
	/**
	 * 개발프로젝트관리 등록
	 */	
	public boolean insertPjdDevInfo(HashMap map) throws BizException {
		boolean retBoolean = false;
		try{
			pjdInfMngDao.insertPjdDevInfo(map);
			retBoolean = true;
		}catch(Exception e){
			retBoolean = false;
			logger.error(e, e);
			throw new BizException("");
		}
		
		return retBoolean;
	}	


	/**
	 * 개발프로젝트관리 수정
	 */	
	public boolean updatePjdDevInfo(HashMap map) throws BizException {
		boolean retBoolean = false;
		try{
			pjdInfMngDao.updatePjdDevInfo(map);
			retBoolean = true;
		}catch(Exception e){
			retBoolean = false;
			logger.error(e, e);
			throw new BizException("");
		}
		
		return retBoolean;
	}
	
	
	/**
	 * 개발프로젝트관리 삭제
	 */	
	public boolean deletePjdDevInfo(HashMap paramMap,HttpServletRequest request) throws BizException {
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
			    
			    map.put("pjt_info_seq", "");  //     해당프로젝트의 동일 제품삭제를 위해 
				pjdInfMngDao.deletePjdDevInfo(map);			// 삭제

			}				

			String recvJsonCrPatternItem = (String)request.getParameter("csrPatternItem");			
			JSONArray jsonArrayCrPatternItem = JSONArray.fromObject(recvJsonCrPatternItem);
			
			for (int i=0; i < jsonArrayCrPatternItem.size(); i++) {
				JSONObject jsonData = new JSONObject();
				jsonData = jsonArrayCrPatternItem.getJSONObject(i);
			
				HashMap<String,String> map = new HashMap<String,String>();
			    Iterator iter = jsonData.keys();
			    while(iter.hasNext()){
			        String key = (String)iter.next();
			        String value = jsonData.getString(key);
			        map.put(key.toLowerCase(),value);
			    }
			    
			    //10-요청중 
			    paramMap.put("csr_id", (String)map.get("csr_id")); 
			    paramMap.put("csr_info_seq", (String)map.get("csr_info_seq")); 
			    
			  //업무요청유형_제품  처리완료여부  10-요청중, 50-요청처리중 -->프로젝트 등록시
			    paramMap.put("deal_yn", "50"); 
				updateCsrPatternItemDealYn(paramMap);						    
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
	 * 개발프로젝트 제품 관리
	 * @param  paramMap
	 * @return list
	 * @throws DaoException
	 * 2011. 2. 8.
	 */
	@SuppressWarnings("unchecked")
	public List selectPjdDevInfoNitem(HashMap paramMap){
		List list = null;
		
		try{
			list = pjdInfMngDao.selectPjdDevInfoNitem(paramMap);
			
		}catch(Exception e){
			logger.error(e, e);
		}
		return list;
	}
	
	
	@SuppressWarnings("unchecked")
	public int selectPjdDevInfoNitemCount(HashMap map) throws Exception{
		int cnt = 0;
		try{ 
			cnt = pjdInfMngDao.selectPjdDevInfoNitemCount(map);			 
		}catch(Exception e){
			logger.error("::"+this.getClass()+"[--selectPjdDevInfoNitemCount-->]"+e.toString()); 
			throw new Exception();
		}
		return cnt;
	}
	
	
	/**
	 * 개발프로젝트장비
	 * @param  paramMap
	 * @return list
	 * @throws DaoException
	 * 2011. 2. 8.
	 */
	@SuppressWarnings("unchecked")
	public List selectPjdEquipInfo(HashMap paramMap){
		List list = null;
		
		try{
			list = pjdInfMngDao.selectPjdEquipInfo(paramMap);
			
		}catch(Exception e){
			logger.error(e, e);
		}
		return list;
	}
	
	
	@SuppressWarnings("unchecked")
	public int selectPjdEquipInfoCount(HashMap map) throws Exception{
		int cnt = 0;
		try{ 
			cnt = pjdInfMngDao.selectPjdEquipInfoCount(map);			 
		}catch(Exception e){
			logger.error("::"+this.getClass()+"[--selectPjdEquipInfoCount-->]"+e.toString()); 
			throw new Exception();
		}
		return cnt;
	}	
	
	
	/**
	 * 개발프로젝트장비관리 등록
	 */	
	public boolean insertPjdEquipInfo(HashMap map) throws BizException {
		boolean retBoolean = false;
		try{
			pjdInfMngDao.insertPjdEquipInfo(map);
			retBoolean = true;
		}catch(Exception e){
			retBoolean = false;
			logger.error(e, e);
			throw new BizException("");
		}
		
		return retBoolean;
	}	


	/**
	 * 개발프로젝트장비관리  수정
	 */	
	public boolean updatePjdEquipInfo(HashMap map) throws BizException {
		boolean retBoolean = false;
		try{
			pjdInfMngDao.updatePjdEquipInfo(map);
			retBoolean = true;
		}catch(Exception e){
			retBoolean = false;
			logger.error(e, e);
			throw new BizException("");
		}
		
		return retBoolean;
	}
	
	
	/**
	 * 개발프로젝트장비관리  삭제
	 */	
	public boolean deletePjdEquipInfo(HashMap paramMap,HttpServletRequest request) throws BizException {
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
			    
			    pjdInfMngDao.deletePjdEquipInfo(map);			// 삭제
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
	 * 개발프로젝트정보팝업
	 * @param  paramMap
	 * @return list
	 * @throws DaoException
	 * 2011. 2. 8.
	 */
	@SuppressWarnings("unchecked")
	public List selectPjdInfoPop(HashMap paramMap){
		List list = null;
		
		try{
			list = pjdInfMngDao.selectPjdInfoPop(paramMap);
			
		}catch(Exception e){
			logger.error(e, e);
		}
		return list;
	}
	
	
	/**
	 * 개발프로젝트정보 팝업 총갯수 
	 */	
	@SuppressWarnings("unchecked")
	public int selectPjdInfoPopCount(HashMap map) throws Exception{
		int cnt = 0;
		try{ 
			cnt = pjdInfMngDao.selectPjdInfoPopCount(map);			 
		}catch(Exception e){
			logger.error("::"+this.getClass()+"[--selectPjdInfoPopCount-->]"+e.toString()); 
			throw new Exception();
		}
		return cnt;
	}	
		
	
	/**
	 * 개발프로젝트정보별 제품 팝업
	 * @param  paramMap
	 * @return list
	 * @throws DaoException
	 * 2011. 2. 8.
	 */
	@SuppressWarnings("unchecked")
	public List selectPjdInfoNitemPop(HashMap paramMap){
		List list = null;
		
		try{
			list = pjdInfMngDao.selectPjdInfoNitemPop(paramMap);
			
		}catch(Exception e){
			logger.error(e, e);
		}
		return list;
	}
	
	
	/**
	 * 개발프로젝트 (제품) 팝업 총갯수
	 */	
	@SuppressWarnings("unchecked")
	public int selectPjdInfoNitemPopCount(HashMap map) throws Exception{
		int cnt = 0;
		try{ 
			cnt = pjdInfMngDao.selectPjdInfoNitemPopCount(map);			 
		}catch(Exception e){
			logger.error("::"+this.getClass()+"[--selectPjdInfoNitemPopCount-->]"+e.toString()); 
			throw new Exception();
		}
		return cnt;
	}	
			
	/**
	 * 프로젝트 정보 입력, 수정
	 * @param request	
	 * @param response
	 * @return
	 * @throws Exception
	 * 2011. 4. 7.
	 */
	@SuppressWarnings("unchecked")
	public boolean actionPjtInfoMng(HashMap paramMap,HttpServletRequest request)throws Exception{
		boolean result = true;
		
		try{
			
			String new_pjt_id = "";

			
			String csr_type_code = (String)paramMap.get("csr_type_code"); //요청구분
			
			if(((String)paramMap.get("pjdInfoYn")).equals("N"))  //사용유무  N으로 업데이트
			{
				//G00-프로잭트DROP
				paramMap.put("proc_status_code", "G00");	
				updatePjdInfoYn(paramMap);	
				
				String recvJsonCrPatternItem = (String)request.getParameter("csrPatternItem");			
				JSONArray jsonArrayCrPatternItem = JSONArray.fromObject(recvJsonCrPatternItem);
				
				for (int i=0; i < jsonArrayCrPatternItem.size(); i++) {
					JSONObject jsonData = new JSONObject();
					jsonData = jsonArrayCrPatternItem.getJSONObject(i);
				
					HashMap<String,String> map = new HashMap<String,String>();
				    Iterator iter = jsonData.keys();
				    while(iter.hasNext()){
				        String key = (String)iter.next();
				        String value = jsonData.getString(key);
				        map.put(key.toLowerCase(),value);
				    }
				    
				    paramMap.put("csr_id", (String)map.get("csr_id")); 
				    paramMap.put("csr_info_seq", (String)map.get("csr_info_seq")); 
				    
				  //업무요청유형_제품  처리완료여부  10-요청중
				    paramMap.put("deal_yn", "10"); 
					updateCsrPatternItemDealYn(paramMap);						    
				}	
				
				//진행상태 history G00-프로잭트DROP
			    paramMap.put("pjt_proc_name", "요청중" );
			    paramMap.put("his_comment", (String)paramMap.get("pjt_name"));
				paramMap.put("pjt_status_code", "G00");
				insertPjtHistory(paramMap);
				
				return result;
			}else
			{
				/********** 1. 프로젝트 정보  저장, 수정 **********/
				//G10-프로젝트등록
				paramMap.put("proc_status_code", "G10");
				
				if(((String)paramMap.get("pjt_id")).equals(""))		//신규
				{
					new_pjt_id = GetPKIdUtil.getPkId("DEV", "PJD");
					
					paramMap.put("pjt_id", new_pjt_id);
					insertPjdInfo(paramMap);	// 저장  
				
					//진행상태 history
				    paramMap.put("pjt_proc_name", "프로젝트등록");
				    paramMap.put("his_comment", (String)paramMap.get("pjt_name") );					
					paramMap.put("pjt_status_code", (String)paramMap.get("proc_status_code"));
					insertPjtHistory(paramMap);
					
				}else	
				{
					new_pjt_id = (String)paramMap.get("pjt_id");
					
					updatePjdInfo(paramMap);	// 수정
				}
				
				
				/********** 2. 프로젝트 상세정보 저장, 수정 **********/
				String recvJsonPjtDevInfo = (String)request.getParameter("edit1stData");			
				JSONArray jsonArrayPjtDevInfo = JSONArray.fromObject(recvJsonPjtDevInfo);
				
				for (int i=0; i < jsonArrayPjtDevInfo.size(); i++) {
					JSONObject jsonData = new JSONObject();
					jsonData = jsonArrayPjtDevInfo.getJSONObject(i);
				
					HashMap<String,String> map = new HashMap<String,String>();
				    Iterator iter = jsonData.keys();
				    while(iter.hasNext()){
				        String key = (String)iter.next();
				        String value = jsonData.getString(key);
				        map.put(key.toLowerCase(),value);
				    }
				    
				    // session정보 설정
				    map.put("final_mod_id", (String)paramMap.get("final_mod_id"));
				    
				    //map.put("sal_pjt_id", (String)map.get("pjt_id"));

					if(((String)map.get("flag")).equals("I"))		//신규
					{
						map.put("pjt_id", new_pjt_id);
						insertPjdDevInfo(map);			// 저장	
					}
					
					//업무요청유형_제품  처리완료여부 50- 요청처리중
					map.put("deal_yn", "50"); 
					updateCsrPatternItemDealYn(map);
				}// End for
				
				/********** 3. 개발장비관리 정보  저장, 수정 **********/
				String recvJsonDataPjtEquipInfo = (String)request.getParameter("edit2ndData");			
				JSONArray jsonArrayPjtEquipInfo = JSONArray.fromObject(recvJsonDataPjtEquipInfo);
				
				for (int i=0; i < jsonArrayPjtEquipInfo.size(); i++) {
					JSONObject jsonData = new JSONObject();
					jsonData = jsonArrayPjtEquipInfo.getJSONObject(i);
				
					HashMap<String,String> map = new HashMap<String,String>();
				    Iterator iter = jsonData.keys();
				    while(iter.hasNext()){
				        String key = (String)iter.next();
				        String value = jsonData.getString(key);
				        map.put(key.toLowerCase(),value);
				    }
				    
				    // session정보 설정
				    map.put("final_mod_id", (String)paramMap.get("final_mod_id"));

					if(((String)map.get("flag")).equals("I"))		//신규
					{
						map.put("pjt_id", new_pjt_id);
						insertPjdEquipInfo(map);			// 저장	
					}else
					{
					    updatePjdEquipInfo(map);			// 수정
					}
				}// End for	
		}
			
		}catch(Exception e){
			logger.error(e,e);
			result = false;
		}
		return result;
	}	
	
	
	/**
	 * 처리완료여부 50-요청처리중 -->프로젝트 등록시
	 * @param  paramMap
	 * @return List
	 * @throws DaoException
	 * 2011. 2. 8.
	 */		
	public boolean updateCsrPatternItemDealYn(HashMap map) throws BizException {
		boolean retBoolean = false;
		try{
			pjdInfMngDao.updateCsrPatternItemDealYn(map);
			retBoolean = true;
		}catch(Exception e){
			retBoolean = false;
			logger.error(e, e);
			throw new BizException("");
		}
		
		return retBoolean;
	}	
	
	
	/**
	 * 진행상태 history
	 * @param  paramMap
	 * @return List
	 * @throws DaoException
	 * 2011. 2. 8.
	 */		
	public boolean insertPjtHistory(HashMap map) throws BizException {
		boolean retBoolean = false;
		try{
			pjdInfMngDao.insertPjtHistory(map);
			retBoolean = true;
		}catch(Exception e){
			retBoolean = false;
			logger.error(e, e);
			throw new BizException("");
		}
		
		return retBoolean;
	}	
}
