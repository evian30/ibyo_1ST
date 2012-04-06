/**
 *  Class Name  : EmployeeBiz.java
 *  Description : 사원정보관리 Biz
 *  Modification Information
 *
 *  수정일                   수정자               수정내용
 *  -------      --------   ---------------------------
 *  2011. 2. 7.    고기범              최초 생성
 *
 *  @author 고기범
 *  @since 2011. 2. 7.
 *  @version 1.0
 *  @see 
 * 
 *  Copyright (C) 2011 by SG All right reserved.
 */
package com.sg.sgis.com.employee;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.sg.sgis.com.employee.dao.EmployeeDaoImpl;
import com.signgate.core.exception.BizException;
import com.signgate.core.exception.DaoException;
import com.signgate.core.web.biz.BaseDownloadBiz;
import com.signgate.core.web.servlet.vo.DownloadFileBean;

import sg.svc.portal.util.NewPageNavigator;

public class EmployeeBiz extends BaseDownloadBiz{

	private static final HttpServletRequest request = null;
	
	protected final Log logger = LogFactory.getLog(getClass());
	
	// Dao경로 설정
	private EmployeeDaoImpl employeeDao; 
	public void setEmployeeDao(EmployeeDaoImpl employeeDao)
	{
		this.employeeDao = employeeDao;
	}
	
	@SuppressWarnings("unchecked")
	public DownloadFileBean selFileInfo(Map parameterMap) {
		DownloadFileBean dfb = null;
		try{ 
			dfb = (DownloadFileBean)employeeDao.downPhotoFile((HashMap)parameterMap);			
		}catch(Exception e){ 
			logger.error(e, e);
		}
		return dfb; 
	}
	
	
		 
	/**
	 * 사원정보관리 목록조회
	 * @param  map
	 * @return list
	 * @throws Exception
	 * 2011. 2. 8.
	 */
	@SuppressWarnings("unchecked")
	public List selectEmployee(HashMap paramMap)throws Exception{
		List list = null;
		
		try{
			
			list = employeeDao.selectEmployee(paramMap);
			
		}catch(Exception e){
			logger.error(e, e);
		}
		return list;
	}

	/**
	 * 사원정보관리 상세조회
	 * @param  map
	 * @return HashMap
	 * @throws Exception
	 * 2011. 2. 9.
	 */
	@SuppressWarnings("unchecked")
	public HashMap selectEmployeebyPK(HashMap paramMap)throws Exception {
		HashMap result = null;
		
		try{
			
			result = employeeDao.selectEmployeebyPK(paramMap);

		}catch(Exception e){
			logger.error(e, e);
		}
		return result;
	}

	/**
	 * 사원정보관리 저장, 수정
	 * @param  paramMap
	 * @return 
	 * @throws Exception
	 * 2011. 2. 11.
	 */
	public String updateEmployee(HashMap paramMap)throws Exception  {
		
		String result ="";
		
		try{

			/*
			List fileList = (List)paramMap.get("uploadList");
			Iterator iterator = fileList.iterator(); 
			 			
			while(iterator.hasNext()){
				HashMap fMap = (HashMap)iterator.next();
				paramMap.put("photo_real_nm", fMap.get("sourceFileName").toString());
				paramMap.put("photo_save_nm", fMap.get("saveFileName").toString());
				paramMap.put("photo_path", fMap.get("filePath").toString());
			} 
			*/
			
			// emp_num값이 없으면 신규, 그렇지 않으면 저장
			if(("").equals(paramMap.get("flag"))){
				// 저장
				employeeDao.saveEmployee(paramMap);
				employeeDao.insertADMIN(paramMap);
			}else{ 
				// 수정 
				employeeDao.updateEmployee(paramMap);
				employeeDao.updateADMIN(paramMap);
			}
			 
			
			
			
		}catch(Exception e){
			result = e.toString();
			logger.error(e, e);
			e.printStackTrace();
		}finally{

		}
		
		return result;
	}

	/**
	 * 사원정보관리 목록 총갯수
	 * @param  map
	 * @return list
	 * @throws Exception
	 * 2011. 2. 8.
	 */
	public int selectEmployeeCount(HashMap map)throws Exception {
		int result = 0;
		
		try{

			result = employeeDao.selectEmployeeCount(map);
			logger.debug("selectEmployeeCount............");
			
		}catch(Exception e){
			logger.error(e, e);
		}
		return result;
	}

	/**
	 * 사원정보관리  팝업 목록조회
	 * @param  paramMap
	 * @return List
	 * 2011. 4. 11.
	 */
	public List selectEmployeePop(HashMap paramMap)throws Exception {
		List list = null;
		
		try{
			
			list = employeeDao.selectEmployeePop(paramMap);
			
		}catch(Exception e){
			logger.error(e, e);
		}
		return list;
	}

	/**
	 * 사원정보관리  팝업 목록 총건수
	 * @param  paramMap
	 * @return List
	 * 2011. 4. 11.
	 */
	public int selectEmployeePopCount(HashMap paramMap)throws Exception {
		int result = 0;
		
		try{

			result = employeeDao.selectEmployeePopCount(paramMap);
			logger.debug("selectEmployeeCount............");
			
		}catch(Exception e){
			logger.error(e, e);
		}
		return result;
	}
	
}
