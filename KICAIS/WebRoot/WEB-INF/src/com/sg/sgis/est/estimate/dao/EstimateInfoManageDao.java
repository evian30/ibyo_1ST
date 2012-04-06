/**
 *  Class Name  : EstimateInfoManageDao.java
 *  Description : 견적정보관리 Dao
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

public class EstimateInfoManageDao extends BaseDao implements EstimateInfoManageDaoImpl{

	protected final Log logger = LogFactory.getLog(getClass());
	
	/**
	 * 견적정보관리 목록조회(견적정보)
	 * @param  paramMap
	 * @return List		
	 * 2011. 3. 21.
	 */
	@SuppressWarnings("unchecked") 
	public List selectEstimateInfoManageList(HashMap paramMap)
			throws DaoException {
		
		return queryForList("EstimateInfoManage.selectEstimateInfoManageList", paramMap);
	}

	/**
	 * 견적정보관리 목록조회(견적정보)_ 총건수
	 * @param  paramMap
	 * @return List		
	 * 2011. 3. 21.
	 */
	@SuppressWarnings("unchecked") 
	public int selectEstimateInfoManageListCount(HashMap paramMap)
			throws DaoException {
		return queryForInt("EstimateInfoManage.selectEstimateInfoManageListCount",paramMap); 
	}

	
	/**
	 * 견적정보 입력, 수정
	 * @param request	( EST_INFO 		   : 견적정보관리
	 *                  , EST_ITEM_INFO    : 견적품목관리
	 *                  , EST_SPEC_INFO    : 설치시스템사양정보
	 * 					)
	 * @param response
	 * @return
	 * @throws Exception
	 * 2011. 4. 7.
	 */
	@SuppressWarnings("unchecked") 
	public void saveEstimateInfoManage(HashMap paramMap, HttpServletRequest request)
			throws DaoException {

		String estId = "";
		
		try{
			
			/***** session 정보 *****/
			HashMap adminMap = (HashMap)request.getSession().getAttribute(SGConfigManager.getString("common.session.admin.name"));
			
			// 날짜 형식에 "-"를 제거
			
			if(paramMap.get("est_date") != null){
				String est_date	= paramMap.get("est_date").toString();			 // 견적일자
				est_date 		= est_date.replace("-", "");
				paramMap.put("est_date", est_date);
			}
			
			if(paramMap.get("pjt_date_from") != null){
				String pjt_date_from = paramMap.get("pjt_date_from").toString();	 // 프로젝트기간  FROM
				pjt_date_from 	  	 = pjt_date_from.replace("-", "");
				paramMap.put("pjt_date_from", pjt_date_from);
			}
			
			if(paramMap.get("pjt_date_to") != null){
				String pjt_date_to = paramMap.get("pjt_date_to").toString();		 // 구축기간 To
				pjt_date_to 	   = pjt_date_to.replace("-", "");
				paramMap.put("pjt_date_to", pjt_date_to);
			}
			
			if(paramMap.get("delivery_exp_date") != null){
				String delivery_exp_date = paramMap.get("delivery_exp_date").toString(); // 납품예정일
				delivery_exp_date        = delivery_exp_date.replace("-", "");
				paramMap.put("delivery_exp_date", delivery_exp_date);
			}
			
			/********** 1. 품목관리 저장, 수정 Start **********/
			// flag값이 없으면 신규, 그렇지 않으면 저장
			if(("R").equals(paramMap.get("flag"))){
			
				// 수정
				update("EstimateInfoManage.updateEstimateInfoManage",paramMap);
				
				paramMap.put("pjt_proc_name", "견적");																			// 관련업무명
				paramMap.put("his_comment",   "["+paramMap.get("est_id")+"][ver : "+ paramMap.get("est_version") +"] 견적수정");	// 내용
				
			}else{ 
				
				// String  est_version = "0";
				
				// 견적 Rev를 통해서 생성된 자료라면 견적ID를 생성하지 않도록 처리
				//if(!("I").equals(paramMap.get("flag"))){
					// 신규저장일 경우 견적ID를 생성
				//	estId = queryForString("EstimateInfoManage.createEstId",paramMap);
				//	paramMap.put("est_id", estId);
				//}else{
				//	est_version = paramMap.get("est_version").toString();
				//}
				
				// 프로젝트 ID에 해당하는 견적이 등록되어 있는지 확인
				// 한건이라도 등록이 되어있다면 'N'
				String checkUpdatePjtStatus = queryForString("EstimateInfoManage.checkUpdatePjtStatus",paramMap); 
				
				insert("EstimateInfoManage.insertEstimateInfoManage",paramMap);
				
				// 프로젝트 ID에 해당하는 견적이 등록되어 있지 않으므로
				// 프로젝트 상태를 견적등록으로 변경
				if("Y".equals(checkUpdatePjtStatus)){
					paramMap.put("admin_id",(String)adminMap.get("ADMIN_ID"));
					paramMap.put("proc_status_code","20");	// PJT_STATUS 20 : 견적등록
					update("PjtManage.updatePjtStatusManage",paramMap);
				}
				
				paramMap.put("pjt_proc_name", "견적");															// 관련업무명
				paramMap.put("his_comment",   "["+paramMap.get("est_id")+"][ver : "+ paramMap.get("est_version") +"] 견적등록");	// 내용
				
			}
			
			// 프로젝트 이력테이블에 이력 저장
			insert("EstimateProcessStateManage.insertPjtHistory",paramMap);
			
			/********** 2. 견적 품목정보 저장, 수정 **********/
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
			    map.put("final_mod_id", (String)adminMap.get("ADMIN_ID"));

			    // 신규입력이면 채번된 코드를 설정해준다.
			    //if(("").equals(paramMap.get("flag"))){
			    	// 버전번호가 없을 경우
			    //	if(("").equals(paramMap.get("est_version"))){
			    //		map.put("est_id", estId);
			    //	}
		    	//}
			    
			    if("I".equals(map.get("flag"))){
			    	insert("EstimateInfoManage.insertEstItemInfo",map);
			    }else if("R".equals(map.get("flag"))){
			    	update("EstimateInfoManage.updateEstItemInfo",map);
			    }else if("D".equals(map.get("flag"))){
			    	delete("EstimateInfoManage.deleteEstItemInfo",map);
			    }
			}// End for
			
			/********** 3. 납품처시스템 사양정보  저장, 수정 **********/
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
			    
			    // session정보 설정
			    map.put("final_mod_id", (String)adminMap.get("ADMIN_ID"));

			    // 신규입력이면 채번된 코드를 설정해준다.
			    //if(("").equals(paramMap.get("flag"))){
			    	// 버전번호가 없을 경우
			    //	if(("").equals(paramMap.get("est_version"))){
			    //		map.put("est_id", estId);
			    //	}
		    	//}
			    
			    if("I".equals(map.get("flag"))){
					insert("EstimateInfoManage.insertEstSpecInfo",map);
			    }else if("R".equals(map.get("flag"))){
					update("EstimateInfoManage.updateEstSpecInfo",map);
			    }else if("D".equals(map.get("flag"))){
					update("EstimateInfoManage.deleteEstSpecInfo",map);
			    }
			}// End for					
			
		}catch(Exception e){
			logger.error(e,e);
			e.printStackTrace();
		}
		
	}

	/**
	 * 견적정보관리(견적 품목정보) 목록
	 * @param  request 
	 * @param  response
	 * @return 
	 * 2011. 4. 8.
	 */
	@SuppressWarnings("unchecked") 
	public List selectEstItemInfo(HashMap map) throws DaoException {
		// TODO Auto-generated method stub
		return queryForList("EstimateInfoManage.selectEstItemInfo", map);
	}

	/**
	 * 견적정보관리(견적 품목정보) 목록 총건수
	 * @param  request 
	 * @param  response
	 * @return 
	 * 2011. 4. 8.
	 */
	@SuppressWarnings("unchecked") 
	public int selectEstItemInfoCount(HashMap map) throws DaoException {
		return queryForInt("EstimateInfoManage.selectEstItemInfoCount",map); 
	}

	/**
	 * 견적정보관리(납품처 시스템사양 정보) 목록 
	 * @param  request 
	 * @param  response
	 * @return 
	 * 2011. 4. 8.
	 */
	@SuppressWarnings("unchecked") 
	public List selectEstSpecInfo(HashMap map) throws DaoException {
		// TODO Auto-generated method stub
		return queryForList("EstimateInfoManage.selectEstSpecInfo", map);
	}
	
	/**
	 * 견적정보관리(납품처 시스템사양 정보) 목록 총건수
	 * @param  request 
	 * @param  response
	 * @return 
	 * 2011. 4. 8.
	 */
	@SuppressWarnings("unchecked") 
	public int selectEstSpecInfoCount(HashMap map) throws DaoException {
		return queryForInt("EstimateInfoManage.selectEstSpecInfoCount",map); 
	}

	/**
	 * 견적정보 rev 팝업 목록조회
	 * @param paramMap
	 * @return
	 * 2011. 4. 12.
	 */
	@SuppressWarnings("unchecked") 
	public List selectEstimateInfoManageRevPopList(HashMap paramMap)
			throws DaoException {
		return queryForList("EstimateInfoManage.selectEstimateInfoManageRevPopList", paramMap);
	}

	/**
	 * 견적정보 rev 팝업 목록 총건수
	 * @param paramMap
	 * @return
	 * 2011. 4. 12.
	 */
	@SuppressWarnings("unchecked") 
	public int selectEstimateInfoManageRevPopListCount(HashMap paramMap)
			throws DaoException {
		return queryForInt("EstimateInfoManage.selectEstimateInfoManageRevPopListCount",paramMap); 
	}

	/**
	 * 견적정보 팝업 목록 
	 * @param paramMap
	 * @return
	 * 2011. 4. 18.
	 */
	@SuppressWarnings("unchecked") 
	public List estimatePopList(HashMap paramMap) throws DaoException {
		return queryForList("EstimateInfoManage.estimatePopList", paramMap);
	}

	/**
	 * 견적정보 팝업 목록 총건수
	 * @param paramMap
	 * @return
	 * 2011. 4. 18.
	 */
	@SuppressWarnings("unchecked") 
	public int estimatePopListCount(HashMap paramMap) throws DaoException {
		return queryForInt("EstimateInfoManage.estimatePopListCount",paramMap); 
	}

	/**
	 * 프로젝트조회시 프로젝트의 거래처 정보 조회
	 * @param paramMap
	 * @return
	 * @throws Exception
	 * 2011. 5. 4.
	 */
	@SuppressWarnings("unchecked")
	public List selectPjtCustom(HashMap paramMap) throws DaoException {
		return queryForList("EstimateInfoManage.selectPjtCustom", paramMap);
	}

	/**
	 * 프로젝트조회시 프로젝트의 매출품목 조회
	 * @param paramMap
	 * @return
	 * @throws Exception
	 * 2011. 5. 4.
	 */
	@SuppressWarnings("unchecked")
	public List selectPjtItemList(HashMap paramMap) throws DaoException {
		return queryForList("EstimateInfoManage.selectPjtItemList", paramMap);
	}

	/**
	 * 프로젝트조회시 프로젝트의 매출품목 조회 총건수
	 * @param paramMap
	 * @return
	 * @throws Exception
	 * 2011. 5. 4.
	 */
	@SuppressWarnings("unchecked")
	public int selectPjtItemListCount(HashMap paramMap) throws DaoException {
		return queryForInt("EstimateInfoManage.selectPjtItemListCount",paramMap); 
	}

	/**
	 * 견적ID 생성
	 * @param paramMap
	 * @return
	 * @throws Exception
	 * 2011. 5. 4.
	 */
	@SuppressWarnings("unchecked")
	public String createEstId(HashMap paramMap) throws DaoException {
		paramMap.put("createId","EST");
		return queryForString("OrderInfoManage.createId",paramMap);
	}

	/**
	 * 견적정보관리_견적등록 가능여부 확인
	 * @param paramMap
	 * @return
	 * @throws Exception
	 * 2011. 5. 11.
	 */
	@SuppressWarnings("unchecked")
	public List projectUseCheck(HashMap paramMap) throws DaoException {
		return queryForList("EstimateInfoManage.projectUseCheck",paramMap);
	}

}
