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

import com.sg.sgis.pjt.pjtManage.dao.PjtIssueDaoImpl;
import com.sg.sgis.pjt.pjtManage.dao.PjtManageDaoImpl;
import com.signgate.core.exception.BizException;
import com.signgate.core.exception.DaoException;
 
public class PjtIssueBiz {

	protected final Log logger = LogFactory.getLog(getClass());
	
	private PjtIssueDaoImpl pjtIssueDao; 
	public void setPjtIssueDao(PjtIssueDaoImpl pjtIssueDao){
		this.pjtIssueDao = pjtIssueDao;
	}
	
	private PjtManageDaoImpl pjtManageDao; 
	public void setPjtManageDao(PjtManageDaoImpl pjtManageDao){
		this.pjtManageDao = pjtManageDao;
	}
	  
	 
	@SuppressWarnings("unchecked")
	public List selectPjtIssue(HashMap paramMap)throws Exception{
		List list = null; 
		
		try{
			list = pjtIssueDao.selectPjtIssue(paramMap); 
			
		}catch(Exception e){
			logger.error(e, e);
		}
		return list;
	}
  
	@SuppressWarnings("unchecked")
	public int selectPjtIssueCount(HashMap map) throws Exception{
		int cnt = 0;
		try{ 
			cnt = pjtIssueDao.selectPjtIssueCount(map);			 
		}catch(Exception e){
			logger.error("::"+this.getClass()+"\n<카운트 BIZ 에러>::::\n"+e.toString()); 
			throw new Exception();
		}
		return cnt;
	}
	 
	
	@SuppressWarnings("unchecked")
	public boolean actionPjtIssue(HashMap map, HttpServletRequest request)throws Exception{
		boolean result = true;
		
		try{
			pjtIssueDao.actionPjtIssue(map, request);
		}catch(Exception e){
			logger.error(e,e);
			result = false;
		}
		return result;
	}
	  
	
	
}
