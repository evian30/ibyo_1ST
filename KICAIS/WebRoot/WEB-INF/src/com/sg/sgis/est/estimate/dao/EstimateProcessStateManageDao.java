package com.sg.sgis.est.estimate.dao;

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

public class EstimateProcessStateManageDao extends BaseDao implements EstimateProcessStateManageDaoImpl{

	protected final Log logger = LogFactory.getLog(getClass());

	/**
	 * 견적정보진행상태(견적정보)조회
	 * @param paramMap
	 * @return
	 * @throws Exception
	 * 2011. 4. 13.
	 */
	@SuppressWarnings("unchecked") 
	public List selectEstimateProcessStateEstInfoList(HashMap paramMap)
			throws DaoException {
		return queryForList("EstimateProcessStateManage.selectEstimateProcessStateEstInfoList", paramMap);
	}

	/**
	 * 견적정보진행상태(견적정보)조회 총건수
	 * @param paramMap
	 * @return
	 * @throws Exception
	 * 2011. 4. 13.
	 */
	@SuppressWarnings("unchecked") 
	public int selectEstimateProcessStateEstInfoListCount(HashMap paramMap)
			throws DaoException {
		return queryForInt("EstimateProcessStateManage.selectEstimateProcessStateEstInfoListCount",paramMap); 
	}

	/**
	 * 견적정보진행상태(견적 품목정보)조회
	 * @param paramMap
	 * @return
	 * @throws Exception
	 * 2011. 4. 13.
	 */
	@SuppressWarnings("unchecked") 
	public List selectEstimateProcessStateEstItemInfoList(HashMap paramMap)
			throws DaoException {
		return queryForList("EstimateProcessStateManage.selectEstimateProcessStateEstItemInfoList", paramMap);
	}

	/**
	 * 견적정보진행상태(견적 품목정보)조회 총건수
	 * @param paramMap
	 * @return
	 * @throws Exception
	 * 2011. 4. 13.
	 */
	@SuppressWarnings("unchecked") 
	public int selectEstimateProcessStateEstItemInfoListCount(HashMap paramMap)
			throws DaoException {
		return queryForInt("EstimateProcessStateManage.selectEstimateProcessStateEstItemInfoListCount",paramMap); 
	}

	/**
	 * 견적정보진행상태 수정
	 * @param paramMap		( EST_INFO : 견적정보관리 )
	 * @param request
	 * @return
	 * @throws Exception
	 * 2011. 4. 13.
	 */
	public void saveEstimateProcessStateEstInfo(HashMap paramMap,
			HttpServletRequest request) throws DaoException {
		
		
		/***** session 정보 *****/
		HashMap adminMap = (HashMap)request.getSession().getAttribute(SGConfigManager.getString("common.session.admin.name"));
		
		
		/********** 1. 견적기본 정보 **********/
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
		    
		    // 프로젝트 ID에 해당하는 '견적확정'이 등록되어 있는지 확인
			// 한건이라도 등록이 되어있다면 'N'
	    	map.put("procStatusDiv","ProcStatus");
			String checkUpdatePjtStatus = queryForString("EstimateInfoManage.checkUpdatePjtStatus",map);
			
		    // session정보 설정
		    map.put("final_mod_id", (String)adminMap.get("ADMIN_ID"));
		    
	    	update("EstimateProcessStateManage.updateEstimateProcessStateManage",map);
	    	
	    	map.put("pjt_proc_name", "견적");										// 관련업무명
	    	map.put("his_comment",   "["+map.get("est_id")+"][ver : "+ map.get("est_version") +"] 견적진행상태 변경");	// 내용
		    
	    	insert("EstimateProcessStateManage.insertPjtHistory",map);
	    	
	    	String status = map.get("proc_status_code").toString();
			
	    	if("B90".equals(status)){	// FLOW_STATUS_CODE  : B90 (견적확정)
	    		update("EstimateProcessStateManage.updateProcStatusCode",map);
				
				// 프로젝트 ID에 해당하는 견적확정이 등록되어 있지 않으므로 'Y'
				// 프로젝트 상태를 '견적확정'으로 변경
				if("Y".equals(checkUpdatePjtStatus)){
					// 프로젝트 진행상태 수정 *******
					map.put("admin_id",(String)adminMap.get("ADMIN_ID"));
					map.put("proc_status_code","29");	// PJT_STATUS 20 : 견적확정
					update("PjtManage.updatePjtStatusManage",map);	
				}
	    	}
	    	
		}// End for
		
	}
}
