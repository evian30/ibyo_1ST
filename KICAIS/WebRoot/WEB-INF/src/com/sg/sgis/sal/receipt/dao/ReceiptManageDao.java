/**
 *  Class Name  : ReceiptManageDao.java
 *  Description : 수금관리  Dao
 *  Modification Information
 *
 *  수정일                   수정자               수정내용
 *  -------      --------   ---------------------------
 *  2011. 4. 29. 고기범              최초 생성
 *
 *  @author 고기범
 *  @since 2011. 4. 29.
 *  @version 1.0
 *  @see 
 * 
 *  Copyright (C) 2011 by SG All right reserved.
 */
package com.sg.sgis.sal.receipt.dao;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.signgate.core.config.SGConfigManager;
import com.signgate.core.dao.BaseDao;
import com.signgate.core.exception.DaoException;

public class ReceiptManageDao extends BaseDao implements ReceiptManageDaoImpl{

	protected final Log logger = LogFactory.getLog(getClass());

	/**
	 * 수금관리_프로젝트별 수금정보
	 * @param  paramMap
	 * @return List		
	 * 2011. 4. 29.
	 */
	@SuppressWarnings("unchecked")
	public List selectReceiptManageList(HashMap paramMap) throws DaoException {
		return queryForList("ReceiptManage.selectReceiptManageList", paramMap);
	}

	/**
	 * 수금관리_프로젝트별 수금정보 총건수
	 * @param  paramMap
	 * @return List		
	 * 2011. 4. 29.
	 */
	@SuppressWarnings("unchecked")
	public int selectReceiptManageListCount(HashMap paramMap)
			throws DaoException {
		return queryForInt("ReceiptManage.selectReceiptManageListCount",paramMap); 
	}

	/**
	 * 수금관리_수금상세정보
	 * @param  paramMap
	 * @return List		
	 * 2011. 4. 29.
	 */
	@SuppressWarnings("unchecked")
	public List selectReceiptProjectList(HashMap paramMap) throws DaoException {
		return queryForList("ReceiptManage.selectReceiptProjectList", paramMap);
	}

	/**
	 * 수금관리_수금상세정보 총건수
	 * @param  paramMap
	 * @return List		
	 * 2011. 4. 29.
	 */
	@SuppressWarnings("unchecked")
	public int selectReceiptProjectListCount(HashMap paramMap)
			throws DaoException {
		return queryForInt("ReceiptManage.selectReceiptProjectListCount",paramMap);
	}

	/**
	 * 수금관리_수금상세정보 저장, 수정
	 * @param  request
	 * @param  response
	 * @return mav		
	 * 2011. 5. 2.
	 */
	@SuppressWarnings("unchecked")
	public boolean saveReceiptManage(HashMap paramMap,
			HttpServletRequest request) throws DaoException {
		boolean result = true;
		
		try{
		
			/********** 1. 수금상세정보  저장, 수정 **********/
			// 편집그리드의 내용을 받아서 처리하는부분
			String recvJsonDataSw = (String)request.getParameter("edit2ndData");			
			JSONArray jsonArraySw = JSONArray.fromObject(recvJsonDataSw);
			
			for (int i=0; i < jsonArraySw.size(); i++) {
				JSONObject jsonData = new JSONObject();
				jsonData = jsonArraySw.getJSONObject(i);
			
				HashMap<String,String> map = new HashMap<String,String>();
			    Iterator iter = jsonData.keys();
			    while(iter.hasNext()){
			        String key = (String)iter.next();
			        String value = jsonData.getString(key);
			        map.put(key.toLowerCase(),value);
			    }
			    
			    // 수금일자에 '-'를 제거
				if(map.get("receipt_date") != null){
					String receipt_date = map.get("receipt_date").toString(); 
					receipt_date        = receipt_date.replace("-", "");
					map.put("receipt_date", receipt_date);
				}
				
				// 전표일자에 '-'를 제거
				if(map.get("slip_date") != null){
					String slip_date = map.get("slip_date").toString(); 
					slip_date        = slip_date.replace("-", "");
					map.put("slip_date", slip_date);
				}
				
			    // session정보 설정
			    map.put("final_mod_id", (String)paramMap.get("final_mod_id"));
			    
			    
			    if("R".equals(map.get("flag"))){
			    	update("ReceiptManage.updateReceiptManage",map);
			    }else{
			    	
			    	// 수금ID생성
			    	paramMap.put("createId","REC");
			    	String receiptId = queryForString("OrderInfoManage.createId",paramMap);
			    	map.put("receipt_id",receiptId);
			    	
			    	insert("ReceiptManage.insertReceiptManage",map);
			    }
			    
			}// End for		
			
		}catch(Exception e){
			result = false;
			logger.error(e,e);
			e.printStackTrace();
		}
		return result;
	}
	
	
	public List selectReceiptInfo(HashMap paramMap) throws DaoException {
		return queryForList("ReceiptManage.selectReceiptInfo", paramMap);
	}

	public int selectReceiptInfoCount(HashMap paramMap) throws DaoException{
		return queryForInt("ReceiptManage.selectReceiptInfoCount",paramMap);
	}

	public List selectReceiptItemInfo(HashMap paramMap) throws DaoException {
		return queryForList("ReceiptManage.selectReceiptItemInfo", paramMap);
	}

	public int selectReceiptItemInfoCount(HashMap paramMap) throws DaoException {
		return queryForInt("ReceiptManage.selectReceiptItemInfoCount",paramMap);
	}
	
	
}
