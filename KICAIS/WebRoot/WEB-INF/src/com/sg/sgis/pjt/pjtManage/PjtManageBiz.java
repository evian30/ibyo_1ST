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
package com.sg.sgis.pjt.pjtManage;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.sg.sgis.pjt.pjtManage.dao.PjtManageDaoImpl;
import com.signgate.core.exception.BizException;
import com.signgate.core.exception.DaoException;

public class PjtManageBiz {

	protected final Log logger = LogFactory.getLog(getClass());
	
	private PjtManageDaoImpl pjtManageDao; 
	public void setPjtManageDao(PjtManageDaoImpl pjtManageDao)
	{
		this.pjtManageDao = pjtManageDao;
	}
		 
	 
	@SuppressWarnings("unchecked")
	public List selectPjtManage(HashMap paramMap)throws Exception{
		List list = null; 
		
		try{
			list = pjtManageDao.selectPjtManage(paramMap); 
			
		}catch(Exception e){
			logger.error(e, e);
		}
		return list;
	}
  
	@SuppressWarnings("unchecked")
	public int selectPjtManageCount(HashMap map) throws Exception{
		int cnt = 0;
		try{ 
			cnt = pjtManageDao.selectPjtManageCount(map);			 
		}catch(Exception e){
			logger.error("::"+this.getClass()+"\n<카운트 BIZ 에러>::::\n"+e.toString()); 
			throw new Exception();
		}
		return cnt;
	}
	 
	
	@SuppressWarnings("unchecked")
	public boolean actionPjtManage(HashMap map, HttpServletRequest request)throws Exception{
		boolean result = true;
		
		try{
			pjtManageDao.actionPjtManage(map, request);
		}catch(Exception e){
			logger.error(e,e);
			result = false;
		}
		return result;
	}
	
	
	@SuppressWarnings("unchecked")
	public boolean actionPjtStatusManage(HashMap map, HttpServletRequest request)throws Exception{
		boolean result = true;
		
		try{
			pjtManageDao.actionPjtStatusManage(map, request);
		}catch(Exception e){
			logger.error(e,e);
			result = false;
		}
		return result;
	} 
	
	
	@SuppressWarnings("unchecked")
	public List selectPjtCustom(HashMap paramMap)throws Exception{
		List list = null; 
		
		try{
			list = pjtManageDao.selectPjtCustom(paramMap); 
			
		}catch(Exception e){
			logger.error(e, e);
		}
		return list;
	}
  
	@SuppressWarnings("unchecked")
	public int selectPjtCustomCount(HashMap map) throws Exception{
		int cnt = 0;
		try{ 
			cnt = pjtManageDao.selectPjtCustomCount(map);			 
		}catch(Exception e){
			logger.error("::"+this.getClass()+"\n<카운트 BIZ 에러>::::\n"+e.toString()); 
			throw new Exception();
		}
		return cnt;
	}
	  	 
	  
	@SuppressWarnings("unchecked")
	public List selectPjtItem(HashMap paramMap)throws Exception{
		List list = null; 
		
		try{
			list = pjtManageDao.selectPjtItem(paramMap); 
			
		}catch(Exception e){
			logger.error(e, e);
		}
		return list;
	}
  
	@SuppressWarnings("unchecked")
	public int selectPjtItemCount(HashMap map) throws Exception{
		int cnt = 0;
		try{ 
			cnt = pjtManageDao.selectPjtItemCount(map);			 
		}catch(Exception e){
			logger.error("::"+this.getClass()+"\n<카운트 BIZ 에러>::::\n"+e.toString()); 
			throw new Exception();
		}
		return cnt;
	}
	 
	
	public boolean deletePjtManage(HashMap map) throws BizException {
		boolean retBoolean = false;
		try{
			pjtManageDao.deletePjtManage(map);
			retBoolean = true;
		}catch(Exception e){
			retBoolean = false;
			logger.error(e, e);
			throw new BizException("");
		}
		
		return retBoolean;
	}
	
	
	
	public String getDeptCode(String emp_num)throws BizException {
		String result ="";
		try{
			 result = pjtManageDao.getDeptCode(emp_num);
			
		}catch(Exception e){ 
			logger.error("::::::::::"+this.getClass()+e.toString()); 
		}finally{

		} 
		return result;
	}
	
	public String getDegreeRCode(String emp_num)throws BizException {
		String result ="";
		try{
			 result = pjtManageDao.getDegreeRCode(emp_num);
			
		}catch(Exception e){ 
			logger.error("::::::::::"+this.getClass()+e.toString()); 
		}finally{

		} 
		return result;
	}
	

	public String getDegreeBCode(String emp_num)throws BizException {
		String result ="";
		try{
			 result = pjtManageDao.getDegreeBCode(emp_num);
			
		}catch(Exception e){ 
			logger.error("::::::::::"+this.getClass()+e.toString()); 
		}finally{

		} 
		return result;
	}
	
	
	public String selectPjtID(HashMap map)throws BizException {
		String result ="";
		try{
			 result = pjtManageDao.selectPjtID(map);
			
		}catch(Exception e){ 
			logger.error("::::::::::"+this.getClass()+e.toString()); 
		}finally{

		} 
		return result;
	}
	
	
	public String getDeptNm(String dept_code)throws BizException {
		String result ="";
		try{
			 result = pjtManageDao.getDeptNm(dept_code);
			
		}catch(Exception e){ 
			logger.error("::::::::::"+this.getClass()+e.toString()); 
		}finally{

		} 
		return result;
	}
	
	 
	@SuppressWarnings("unchecked")
	public List selectPjtStatusHIS(HashMap paramMap)throws Exception{
		List list = null; 
		
		try{
			list = pjtManageDao.selectPjtStatusHIS(paramMap); 
			
		}catch(Exception e){
			logger.error(e, e);
		}
		return list;
	}
  
	@SuppressWarnings("unchecked")
	public int selectPjtStatusHISCount(HashMap map) throws Exception{
		int cnt = 0;
		try{ 
			cnt = pjtManageDao.selectPjtStatusHISCount(map);			 
		}catch(Exception e){
			logger.error("::"+this.getClass()+"\n<카운트 BIZ 에러>::::\n"+e.toString()); 
			throw new Exception();
		}
		return cnt;
	}
	
	@SuppressWarnings("unchecked")
	public List selectPjtStatus(HashMap paramMap)throws Exception{
		List list = null; 
		
		try{
			list = pjtManageDao.selectPjtStatus(paramMap); 
			
		}catch(Exception e){
			logger.error(e, e);
		}
		return list;
	}
  
	@SuppressWarnings("unchecked")
	public int selectPjtStatusCount(HashMap map) throws Exception{
		int cnt = 0;
		try{ 
			cnt = pjtManageDao.selectPjtStatusCount(map);			 
		}catch(Exception e){
			logger.error("::"+this.getClass()+"\n<카운트 BIZ 에러>::::\n"+e.toString()); 
			throw new Exception();
		}
		return cnt;
	}
	
	
	public String getAuthority(String emp_num)throws BizException {
		String result ="";
		try{
			 result = pjtManageDao.getAuthority(emp_num);
			
		}catch(Exception e){ 
			logger.error("::::::::::"+this.getClass()+e.toString()); 
		}finally{

		} 
		return result;
	}
	
	
}
