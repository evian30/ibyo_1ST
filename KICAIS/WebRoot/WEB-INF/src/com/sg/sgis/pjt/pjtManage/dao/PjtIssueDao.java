package com.sg.sgis.pjt.pjtManage.dao;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.signgate.core.config.SGConfigManager;
import com.signgate.core.dao.BaseDao;
import com.signgate.core.exception.DaoException;

public class PjtIssueDao extends BaseDao implements PjtIssueDaoImpl{

	protected final Log logger = LogFactory.getLog(getClass());
	
	
	@SuppressWarnings("unchecked")
	public List selectPjtIssue(HashMap paramMap) throws DaoException{
		return  queryForList("PjtIssue.selectPjtIssue",paramMap);
	}
	
	@SuppressWarnings("unchecked") 
	public int selectPjtIssueCount(Map map) throws DaoException{
		return queryForInt("PjtIssue.selectPjtIssueCount",map); 
	} 
	   
	@SuppressWarnings("unchecked") 
	public void actionPjtIssue(HashMap paramMap, HttpServletRequest request)throws DaoException {
 		
		try{
			/***** session 정보 *****/
			HashMap adminMap = (HashMap)request.getSession().getAttribute(SGConfigManager.getString("common.session.admin.name"));
			
			// 날짜 형식에 "-"를 제거			
			if(paramMap.get("pjt_reg_date") != null){
				String pjt_reg_date	= paramMap.get("pjt_reg_date").toString();
				pjt_reg_date 		= pjt_reg_date.replace("-", "");
				paramMap.put("pjt_reg_date", pjt_reg_date);
			} 
			
			/********** 1. 이슈정보 저장, 수정 **********/
			// 편집그리드의 내용을 받아서 처리하는부분
			String recvJsonDataHw = (String)request.getParameter("edit1stData");			
			JSONArray jsonArrayHw = JSONArray.fromObject(recvJsonDataHw);
			
			for (int i=0; i < jsonArrayHw.size(); i++) {
				JSONObject jsonData = new JSONObject();
				jsonData = jsonArrayHw.getJSONObject(i);
			
				HashMap<String,String> map = new HashMap<String,String>();
			    Iterator iter = jsonData.keys();
			    while(iter.hasNext()){
			        String key = (String)iter.next();
			        String value = jsonData.getString(key);
			        map.put(key.toLowerCase(),value);
			    }
			    
			    // session정보 설정
			    map.put("admin_id", (String)adminMap.get("ADMIN_ID")); 
			    
			    if("I".equals(map.get("flag"))){
			    	insert("PjtIssue.insertPjtIssue",map);
			    }else if("R".equals(map.get("flag"))){
			    	update("PjtIssue.updatePjtIssue",map);
			    }
			}// End for
			 
			
		}catch(Exception e){
			logger.error(e,e);
			e.printStackTrace();
		}
	}
	  
	
	
}
