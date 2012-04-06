/**
 *  Class Name  : OrderProcessStateManageDao.java
 *  Description : 수주진행상태 관리 Dao
 *  Modification Information
 *
 *  수정일                   수정자               수정내용
 *  -------      --------   ---------------------------
 *  2011. 3. 21.    고기범              최초 생성
 *
 *  @author 고기범
 *  @since 2011. 3. 21.
 *  @version 1.0
 *  @see 
 * 
 *  Copyright (C) 2011 by SG All right reserved.
 */
package com.sg.sgis.ord.order.dao;

import java.util.HashMap;
import java.util.Iterator;

import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.signgate.core.config.SGConfigManager;
import com.signgate.core.dao.BaseDao;
import com.signgate.core.exception.DaoException;

public class OrderProcessStateManageDao extends BaseDao implements OrderProcessStateManageDaoImpl{

	protected final Log logger = LogFactory.getLog(getClass());

	/**
	 * 수주진행상태 수정
	 * @param request	( ORD_INFO 		   : 수주정보관리
	 * 					)
	 * @param response
	 * @return
	 * @throws Exception
	 * 2011. 4. 22.
	 */
	@SuppressWarnings("unchecked")
	public void saveOrderProcessStateManage(HashMap paramMap,
			HttpServletRequest request) throws DaoException {
		
		try{
			
			/***** session 정보 *****/
			HashMap adminMap = (HashMap)request.getSession().getAttribute(SGConfigManager.getString("common.session.admin.name"));
		
			/********** 1. 수주진행상태 수정 **********/
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
			    
			    // 프로젝트 ID에 해당하는 '견적확정'이 등록되어 있는지 확인
				// 한건이라도 등록이 되어있다면 'N'
		    	map.put("procStatusDiv","ProcStatus");
				String checkUpdatePjtStatus = queryForString("OrderInfoManage.checkUpdatePjtStatusOrd",map);
			    
			    // session정보 설정
			    map.put("final_mod_id", (String)adminMap.get("ADMIN_ID"));
				
			    // 진행상태 수정
			    update("OrderProcessStateManage.updateOrderProcessStateManage",map);
			    
			    // 프로젝트 이력 등록
			    map.put("pjt_proc_name", "수주");										// 관련업무명
		    	map.put("his_comment",   "["+map.get("ord_id")+"상태코드 ["+ map.get("proc_status_code")+" ] 수주진행상태 변경");		// 내용
			    
		    	insert("EstimateProcessStateManage.insertPjtHistory",map);
		    	
			    String status = map.get("proc_status_code").toString();
			    
			    if("C90".equals(status)){	// FLOW_STATUS_CODE  : C90 (수주확정)
				    
					// 프로젝트 ID에 해당하는수주확정이 등록되어 있지 않으므로 'Y'
					// 프로젝트 상태를 '수주확정'으로 변경
					if("Y".equals(checkUpdatePjtStatus)){
						map.put("admin_id",(String)adminMap.get("ADMIN_ID"));
						map.put("proc_status_code","39");	// PJT_STATUS 39 : 수주확정
						update("PjtManage.updatePjtStatusManage",map);
					}
			    	
			    }
			}// End for		
									
		}catch(Exception e){
			logger.error(e,e);
			e.printStackTrace();
		}
		
		
	}
}
