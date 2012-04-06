package com.sg.sgis.dev.csrInfoMng;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.servlet.ModelAndView;

import com.sg.sgis.dev.csrInfoMng.dao.CsrInfoMngImpl;
import com.sg.sgis.util.GetPKIdUtil;
import com.signgate.core.config.SGConfigManager;
import com.signgate.core.exception.BizException;
import com.signgate.core.exception.DaoException;
import com.signgate.core.web.util.WebUtil;


public class CsrInfoMngBiz {

	protected final Log logger = LogFactory.getLog(getClass());
	
	// Dao경로 설정
	private CsrInfoMngImpl csrInfoMngDao;

	public CsrInfoMngImpl getCsrInfoMngDao() {
		return csrInfoMngDao;
	}

	public void setCsrInfoMngDao(CsrInfoMngImpl csrInfoMngDao) {
		this.csrInfoMngDao = csrInfoMngDao;
	}


	/**
	 * 업무요청정보관리 목록조회
	 * @param  paramMap
	 * @return list
	 * @throws DaoException
	 * 2011. 2. 8.
	 */
	@SuppressWarnings("unchecked")
	public List selectCsrInfo(HashMap paramMap){
		List list = null;
		
		try{
			list = csrInfoMngDao.selectCsrInfo(paramMap);
			
		}catch(Exception e){
			logger.error(e, e);
		}
		return list;
	}
	
	
	@SuppressWarnings("unchecked")
	public int selectCsrInfoCount(HashMap map) throws Exception{
		int cnt = 0;
		try{ 
			cnt = csrInfoMngDao.selectCsrInfoCount(map);			 
		}catch(Exception e){
			logger.error("::"+this.getClass()+"[--selectCsrInfoCount-->]"+e.toString()); 
			throw new Exception();
		}
		return cnt;
	}	
	
	/**
	 * 업무요청정보 등록 
	 */	
	public boolean insertCsrInfo(HashMap map) throws BizException {
		boolean retBoolean = false;
		try{
			csrInfoMngDao.insertCsrInfo(map);
			retBoolean = true;
		}catch(Exception e){
			retBoolean = false;
			logger.error(e, e);
			throw new BizException("");
		}
		
		return retBoolean;
	}	

	/**
	 * 업무요청정보 수정
	 */	
	public boolean updateCsrInfo(HashMap map) throws BizException {
		boolean retBoolean = false;
		try{
			csrInfoMngDao.updateCsrInfo(map);
			retBoolean = true;
		}catch(Exception e){
			retBoolean = false;
			logger.error(e, e);
			throw new BizException("");
		}
		
		return retBoolean;
	}
	
	/**
	 * 업무요청정보  사용유무  수정
	 */	
	public boolean updateCsrInfoUseYn(HashMap map) throws BizException {
		boolean retBoolean = false;
		try{
			csrInfoMngDao.updateCsrInfoUseYn(map);
			retBoolean = true;
		}catch(Exception e){
			retBoolean = false;
			logger.error(e, e);
			throw new BizException("");
		}
		
		return retBoolean;
	}
	
	
	/**
	 * 업무요청정보  삭제
	 */	
	public boolean deleteCsrInfo(HashMap map) throws BizException {
		boolean retBoolean = false;
		try{
			csrInfoMngDao.deleteCsrInfo(map);
			retBoolean = true;
		}catch(Exception e){
			retBoolean = false;
			logger.error(e, e);
			throw new BizException("");
		}
		
		return retBoolean;
	}

	

	/**
	 * 업무요청유형_제품  목록조회
	 * @param  paramMap
	 * @return list
	 * @throws DaoException
	 * 2011. 2. 8.
	 */
	@SuppressWarnings("unchecked")
	public List selectCsrPatternItem(HashMap paramMap){
		List list = null;
		
		try{
			list = csrInfoMngDao.selectCsrPatternItem(paramMap);
			
		}catch(Exception e){
			logger.error(e, e);
		}
		return list;
	}
	
	
	@SuppressWarnings("unchecked")
	public int selectCsrPatternItemCount(HashMap map) throws Exception{
		int cnt = 0;
		try{ 
			cnt = csrInfoMngDao.selectCsrPatternItemCount(map);			 
		}catch(Exception e){
			logger.error("::"+this.getClass()+"[--selectCsrPatternItemCount-->]"+e.toString()); 
			throw new Exception();
		}
		return cnt;
	}	
	
	/**
	 * 업무요청유형_제품 등록
	 */
	public boolean insertCsrPatternItem(HashMap map) throws BizException {
		boolean retBoolean = false;
		try{
			csrInfoMngDao.insertCsrPatternItem(map);
			retBoolean = true;
		}catch(Exception e){
			retBoolean = false;
			logger.error(e, e);
			throw new BizException("");
		}
		
		return retBoolean;
	}	


	/**
	 * 업무요청유형_제품  수정
	 */
	public boolean updateCsrPatternItem(HashMap map) throws BizException {
		boolean retBoolean = false;
		try{
			csrInfoMngDao.updateCsrPatternItem(map);
			retBoolean = true;
		}catch(Exception e){
			retBoolean = false;
			logger.error(e, e);
			throw new BizException("");
		}
		
		return retBoolean;
	}
	
	
	/**
	 * 업무요청유형_제품삭제
	 */
	public boolean deleteCsrPatternItem(HashMap paramMap,HttpServletRequest request) throws BizException {
		boolean retBoolean = false;
		try{
			
			String deleteData = (String)request.getParameter("deleteData");	
			
			System.out.println("111111111-->"+deleteData);

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
			    System.out.println("deleteEmpVacUsed-->"+map);
			    
			    csrInfoMngDao.deleteCsrPatternItem(map);			// 삭제
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
	 * 업무요청유형_제품 저장,수정
	 */
	public String actionCsrPatternItem(HashMap paramMap)throws BizException {
		String result ="";
		try{

			if(paramMap.get("flag").equals("I") )
	        {
				insertCsrPatternItem(paramMap);						// 저장
				
			}else {
				updateCsrPatternItem(paramMap);						// 수정				
			}
			
		}catch(Exception e){
			//result = e.toString();
			//logger.error("::::::::::"+this.getClass()+e.toString());
			throw new  BizException("\n에러가 발생 하였습니다." + "\n<처리 BIZ 에러>::::\n"+this.getClass()+e.toString());
		}finally{

		} 
			return result;
	}		
	
	
	/**
	 * 업무요청검토관리조회
	 * @param  paramMap
	 * @return list
	 * @throws DaoException
	 * 2011. 2. 8.
	 */	
	
	@SuppressWarnings("unchecked")
	public List selectCsrReview(HashMap paramMap){
		List list = null;
		
		try{
			list = csrInfoMngDao.selectCsrReview(paramMap);
			
		}catch(Exception e){
			logger.error(e, e);
		}
		return list;
	}	
	
	@SuppressWarnings("unchecked")
	public int selectCsrReviewCount(HashMap map) throws Exception{
		int cnt = 0;
		try{ 
			cnt = csrInfoMngDao.selectCsrReviewCount(map);			 
		}catch(Exception e){
			logger.error("::"+this.getClass()+"[--selectCsrReviewCount-->]"+e.toString()); 
			throw new Exception();
		}
		return cnt;
	}		
	
	/**
	 * 업무요청검토 관리 수정 
	 */
	public boolean updateCsrReview(HashMap paramMap,HttpServletRequest request) throws BizException {
		boolean retBoolean = false;
		try{
			
			String recvJsonData = (String)request.getParameter("data");
			System.out.println("actionCsrInfoReviewMng............"+recvJsonData);

			JSONArray jsonArray1 = JSONArray.fromObject(recvJsonData);
			
			
			//에디트 그리드 데이타
			for (int i=0; i < jsonArray1.size(); i++) {
				JSONObject jsonData = jsonArray1.getJSONObject(i);
			
				HashMap<String,String> map = new HashMap<String,String>();
			    Iterator iter = jsonData.keys();
			    while(iter.hasNext()){
			        String key = (String)iter.next();
			        String value = jsonData.getString(key);
			        map.put(key.toLowerCase(),value);
			    }
			    
			    map.put("deal_dept_code", (String)paramMap.get("deal_dept_code"));	// 처리부서코드
			    map.put("deal_emp_num", (String)paramMap.get("deal_emp_num"));	// 처리자사번
			    
			    map.put("final_mod_id", (String)paramMap.get("final_mod_id"));
			    
			    System.out.println("temp-11->"+map);			    
			    csrInfoMngDao.updateCsrReview(map);		// 수정 	 
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
	 * 업무요청 저장,수정
	 */
	public boolean actionCsrInfoMng(HashMap paramMap,HttpServletRequest request)throws Exception{
		
		boolean result = true;
		
		try{
			
			String recvJsonData = (String)request.getParameter("data");
			System.out.println("actionEmpVacInfo............"+recvJsonData);

			JSONArray jsonArray1 = JSONArray.fromObject(recvJsonData);
			
			String new_csr_id = "";
			
			paramMap.put("final_mod_id", (String)paramMap.get("final_mod_id"));
			
			String csr_type_code = (String)paramMap.get("csr_type_code"); //요청구분
			if(((String)paramMap.get("csrInfoYn")).equals("N"))  //사용유무  N으로 업데이트
			{
				updateCsrInfoUseYn(paramMap);	
				return result;
			}else
			{	
				if(((String)paramMap.get("csr_id")).equals(""))
				{
					if(csr_type_code.equals("10"))//개발
					{
						new_csr_id = GetPKIdUtil.getPkId("DEV", "SRD");
					
					}else if(csr_type_code.equals("20")) //지원
					{
						new_csr_id = GetPKIdUtil.getPkId("DEV", "SRS");
					}else
					{
						new_csr_id = GetPKIdUtil.getPkId("DEV", "SRE"); //기타
					}
					
					
					paramMap.put("csr_id", new_csr_id);
	
					insertCsrInfo(paramMap);			// 저장 
				}else	
				{
					new_csr_id = (String)paramMap.get("csr_id");
					
					updateCsrInfo(paramMap);			// 수정 	
				}
				
				//에디트 그리드 데이타
				for (int i=0; i < jsonArray1.size(); i++) {
					JSONObject jsonData = jsonArray1.getJSONObject(i);
				
					HashMap<String,String> map = new HashMap<String,String>();
				    Iterator iter = jsonData.keys();
				    while(iter.hasNext()){
				        String key = (String)iter.next();
				        String value = jsonData.getString(key);
				        map.put(key.toLowerCase(),value);
				    }
				    System.out.println("temp-00->"+map);
				    
			    	map.put("csr_id", new_csr_id);
				    
				    map.put("csr_pattern_code", "20");	//업무요청유형코드(SR_PATTERN_CODE:20-제품)
				    map.put("final_mod_id", (String)paramMap.get("final_mod_id"));
				    
				    System.out.println("temp-11->"+map);			    
				    actionCsrPatternItem(map);			// 저장 및 수정 	 
				}	
			}
		}catch(Exception e){
			logger.error(e,e);
			result = false;
		}
		return result;
	}	
	
	/**
	 * 프로젝트 제품 목록조회
	 * @param  paramMap
	 * @return list
	 * @throws DaoException
	 * 2011. 2. 8.
	 */
	@SuppressWarnings("unchecked")
	public List selectPjtItem(HashMap paramMap){
		List list = null;
		
		try{
			list = csrInfoMngDao.selectPjtItem(paramMap);
			
		}catch(Exception e){
			logger.error(e, e);
		}
		return list;
	}	
	
}
