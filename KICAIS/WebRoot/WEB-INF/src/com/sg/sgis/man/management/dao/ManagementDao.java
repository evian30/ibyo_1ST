package com.sg.sgis.man.management.dao;

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

public class ManagementDao extends BaseDao implements ManagementDaoImpl{

	protected final Log logger = LogFactory.getLog(getClass());
	
	
	@SuppressWarnings("unchecked")
	public List selectManagement(HashMap paramMap) throws DaoException{
		return  queryForList("Management.selectManagement",paramMap);
	}
	
	@SuppressWarnings("unchecked") 
	public int selectManagementCount(Map map) throws DaoException{
		return queryForInt("Management.selectManagementCount",map); 
	} 
	  
 
	@SuppressWarnings("unchecked")
	public List selectPjtManagement(HashMap paramMap) throws DaoException{
		return  queryForList("Management.selectPjtManagement",paramMap);
	}
	
	@SuppressWarnings("unchecked") 
	public int selectPjtManagementCount(Map map) throws DaoException{
		return queryForInt("Management.selectPjtManagementCount",map); 
	} 
	 
	
	@SuppressWarnings("unchecked")
	public List selectManagementItem(HashMap paramMap) throws DaoException{
		return  queryForList("Management.selectManagementItem",paramMap);
	}
	
	@SuppressWarnings("unchecked") 
	public int selectManagementItemCount(Map map) throws DaoException{
		return queryForInt("Management.selectManagementItemCount",map); 
	} 
	   
	@SuppressWarnings("unchecked")
	public String selectManID(HashMap map) throws DaoException{
		return queryForString("Management.selectManID", map);
	}
	
	@SuppressWarnings("unchecked")
	public String selectSalID(HashMap map) throws DaoException{
		return queryForString("Management.selectSalID", map);
	}
	
	
	@SuppressWarnings("unchecked") 
	public void actionManagement(HashMap paramMap, HttpServletRequest request)throws DaoException {
 		
		try{
			/***** session 정보 *****/
			HashMap adminMap = (HashMap)request.getSession().getAttribute(SGConfigManager.getString("common.session.admin.name"));
			
			// 날짜 형식에 "-"를 제거			
			if(paramMap.get("maintenance_from") != null){
				String maintenance_from	= paramMap.get("maintenance_from").toString();
				maintenance_from 		= maintenance_from.replace("-", "");
				paramMap.put("maintenance_from", maintenance_from);
			}
			if(paramMap.get("maintenance_to") != null){
				String maintenance_to	= paramMap.get("maintenance_to").toString();
				maintenance_to 		= maintenance_to.replace("-", "");
				paramMap.put("maintenance_to", maintenance_to);
			}
			
			if(paramMap.get("maintenance_amt") != null){
				String maintenance_amt = paramMap.get("maintenance_amt").toString(); 
				maintenance_amt        = maintenance_amt.replace(",", "");
				if(maintenance_amt.equals("")){
					maintenance_amt="0";
				}
				paramMap.put("maintenance_amt",  Integer.parseInt(maintenance_amt));
				
				paramMap.put("maintenance_tax", Integer.parseInt(maintenance_amt)*0.1 );
			}
			
			  
			/********** 1. 품목관리 저장, 수정 Start **********/
			// flag값이 없으면 신규, 그렇지 않으면 저장
			if(("R").equals(paramMap.get("flag"))){
				update("Management.updateManagement",paramMap);
			}else {
				insert("Management.insertManagement",paramMap);
			}
				//진행상태 history  테이블 무조건 저장
				//insert("Management.insertPjtHistory",paramMap);
			
			
			/********** 2. 거래처정보 저장, 수정 **********/
			// 편집그리드의 내용을 받아서 처리하는부분
			String recvJsonData1 = (String)request.getParameter("edit1stData");			
			JSONArray jsonArray1 = JSONArray.fromObject(recvJsonData1);
			
			for (int i=0; i < jsonArray1.size(); i++) {
				JSONObject jsonData = new JSONObject();
				jsonData = jsonArray1.getJSONObject(i);
			
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
			    	insert("Management.insertPjtManagement",map);
			    }else if("R".equals(map.get("flag"))){
			    	update("Management.updatePjtManagement",map);
			    }
			}// End for
			
			/********** 3. item 정보  저장, 수정 **********/
			// 편집그리드의 내용을 받아서 처리하는부분
			String recvJsonData2 = (String)request.getParameter("edit2ndData");			
			JSONArray jsonArray2 = JSONArray.fromObject(recvJsonData2);
			
			for (int i=0; i < jsonArray2.size(); i++) {
				JSONObject jsonData = new JSONObject();
				jsonData = jsonArray2.getJSONObject(i);
			
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
					insert("Management.insertManagementItem",map);
			    }else if("R".equals(map.get("flag"))){
					update("Management.updateManagementItem",map);
			    }
			}// End for					
			
		}catch(Exception e){
			logger.error(e,e);
			e.printStackTrace();
		}
	}

	public List selectSalCheck(HashMap map) throws DaoException {
		return queryForList("Management.selectSalCheck", map);
	}
	    
}
