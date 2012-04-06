package com.sg.sgis.layout;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.sg.sgis.com.employee.dao.EmployeeDaoImpl;
import com.sg.sgis.layout.dao.LayoutDaoImpl;
import com.signgate.core.exception.BizException;

public class LayoutBiz {
	protected final Log logger = LogFactory.getLog(getClass());
	
	private LayoutDaoImpl layoutDao;
	public void setLayoutDao(LayoutDaoImpl layoutDao) {
		this.layoutDao = layoutDao;
	}
	
	private EmployeeDaoImpl employeeDao; 
	public void setEmployeeDao(EmployeeDaoImpl employeeDao){
		this.employeeDao = employeeDao;
	}
	 

	
	@SuppressWarnings("unchecked")
	public boolean insertLoginInfo(HashMap map) throws BizException {
		boolean retBoolean = false;
		try{
			 
			employeeDao.insertLoginInfo(map);
			retBoolean = true;
			
			
		}catch(Exception e){
			retBoolean = false;
			logger.error(e, e);
			throw new BizException("");
		}
		
		return retBoolean;
	}
	  
	public List selAllMenuList2(HashMap paramMap)throws Exception{
		List list = null;
		
		try{
			list = layoutDao.getAllMenuList2(paramMap);
			
		}catch(Exception e){
			logger.error(e, e);
		}
		return list;
	}
	
	public List selAllMenuList2_node(HashMap paramMap)throws Exception{
		List list = null;
		
		try{
			list = layoutDao.getAllMenuList2_node(paramMap);
			
		}catch(Exception e){
			logger.error(e, e);
		}
		return list;
	}
	
	public List selAllMenuList3_node(HashMap paramMap)throws Exception{
		List list = null;
		
		try{
			list = layoutDao.getAllMenuList3_node(paramMap);
			
		}catch(Exception e){
			logger.error(e, e);
		}
		return list;
	}
	
}
