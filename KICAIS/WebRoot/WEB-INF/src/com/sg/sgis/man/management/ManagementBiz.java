/**
 *  Class Name  : PjtManageBiz.java
 *  Description : 프로젝트관리 Biz
 *  Modification Information
 *
 *  수정일                   수정자               수정내용
 *  -------      --------   ---------------------------
 *  2011. 3. 9.    여인범              최초 생성
 *
 *  @author 여인범
 *  @since 2011. 3. 9.
 *  @version 1.0
 *  @see 
 * 
 *  Copyright (C) 2011 by SG All right reserved.
 */
package com.sg.sgis.man.management;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.sg.sgis.man.management.dao.ManagementDaoImpl; 
import com.signgate.core.exception.BizException; 

public class ManagementBiz {

	protected final Log logger = LogFactory.getLog(getClass());
	
	private ManagementDaoImpl managementDao; 
	public void setManagementDao(ManagementDaoImpl managementDao)
	{
		this.managementDao = managementDao;
	}
		 
	 
	@SuppressWarnings("unchecked")
	public List selectManagement(HashMap paramMap)throws Exception{
		List list = null; 
		
		try{
			list = managementDao.selectManagement(paramMap); 
			
		}catch(Exception e){
			logger.error(e, e);
		}
		return list;
	}
  
	@SuppressWarnings("unchecked")
	public int selectManagementCount(HashMap map) throws Exception{
		int cnt = 0;
		try{ 
			cnt = managementDao.selectManagementCount(map);			 
		}catch(Exception e){
			logger.error("::"+this.getClass()+"\n<카운트 BIZ 에러>::::\n"+e.toString()); 
			throw new Exception();
		}
		return cnt;
	}
	 
	
	@SuppressWarnings("unchecked")
	public boolean actionManagement(HashMap map, HttpServletRequest request)throws Exception{
		boolean result = true;
		
		try{
			managementDao.actionManagement(map, request);
		}catch(Exception e){
			logger.error(e,e);
			result = false;
		}
		return result;
	}
	  
	
	
	@SuppressWarnings("unchecked")
	public List selectPjtManagement(HashMap paramMap)throws Exception{
		List list = null; 
		
		try{
			list = managementDao.selectPjtManagement(paramMap); 
			
		}catch(Exception e){
			logger.error(e, e);
		}
		return list;
	}
  
	@SuppressWarnings("unchecked")
	public int selectPjtManagementCount(HashMap map) throws Exception{
		int cnt = 0;
		try{ 
			cnt = managementDao.selectPjtManagementCount(map);			 
		}catch(Exception e){
			logger.error("::"+this.getClass()+"\n<카운트 BIZ 에러>::::\n"+e.toString()); 
			throw new Exception();
		}
		return cnt;
	}
	  	 
	  
	@SuppressWarnings("unchecked")
	public List selectManagementItem(HashMap paramMap)throws Exception{
		List list = null; 
		
		try{
			list = managementDao.selectManagementItem(paramMap); 
			
		}catch(Exception e){
			logger.error(e, e);
		}
		return list;
	}
  
	@SuppressWarnings("unchecked")
	public int selectManagementItemCount(HashMap map) throws Exception{
		int cnt = 0;
		try{ 
			cnt = managementDao.selectManagementItemCount(map);			 
		}catch(Exception e){
			logger.error("::"+this.getClass()+"\n<카운트 BIZ 에러>::::\n"+e.toString()); 
			throw new Exception();
		}
		return cnt;
	}
	 
	  
	 
	
	public String selectManID(HashMap map)throws BizException {
		String result ="";
		try{
			 result = managementDao.selectManID(map);
			
		}catch(Exception e){ 
			logger.error("::::::::::"+this.getClass()+e.toString()); 
		}finally{

		} 
		return result;
	}
	
	
	public String selectSalID(HashMap map)throws BizException {
		String result ="";
		try{
			 result = managementDao.selectSalID(map);
			
		}catch(Exception e){ 
			logger.error("::::::::::"+this.getClass()+e.toString()); 
		}finally{

		} 
		return result;
	}

	/**
	 * 유지보수 등록가능한 프로젝트인지 체크
	 * @param map
	 * @return
	 * @throws BizException
	 * 2011. 5. 18.
	 */
	public List selectSalCheck(HashMap map)throws BizException {
		List result = null; 
		try{
			 result = managementDao.selectSalCheck(map);
			
		}catch(Exception e){ 
			logger.error("::::::::::"+this.getClass()+e.toString()); 
		}finally{

		} 
		return result;
	}
	
	
}
