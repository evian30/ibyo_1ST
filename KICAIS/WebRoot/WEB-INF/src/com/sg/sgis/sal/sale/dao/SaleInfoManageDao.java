/**
 *  Class Name  : SaleInfoManageDao.java
 *  Description : 매출정보관리 Dao
 *  Modification Information
 *
 *  수정일                   수정자               수정내용
 *  -------      --------   ---------------------------
 *  2011. 4. 25.    고기범              최초 생성
 *
 *  @author 고기범
 *  @since 2011. 4. 25.
 *  @version 1.0
 *  @see 
 * 
 *  Copyright (C) 2011 by SG All right reserved.
 */
package com.sg.sgis.sal.sale.dao;

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

public class SaleInfoManageDao extends BaseDao implements SaleInfoManageDaoImpl{
	
	protected final Log logger = LogFactory.getLog(getClass());

	/**
	 * 매출정보관리 목록조회(매출정보)
	 * @param  paramMap
	 * @return List		
	 * 2011. 4. 26.
	 */
	@SuppressWarnings("unchecked")
	public List selectSaleInfoManageList(HashMap paramMap)throws DaoException{
		return queryForList("SaleInfoManage.selectSaleInfoManageList", paramMap);
	}

	/**
	 * 매출정보관리 목록조회(매출정보)_총건수
	 * @param  paramMap
	 * @return int		
	 * 2011. 4. 26.
	 */
	@SuppressWarnings("unchecked")
	public int selectSaleInfoManageListCount(HashMap paramMap)throws DaoException{
		return queryForInt("SaleInfoManage.selectSaleInfoManageListCount",paramMap); 
	}

	/**
	 * 매출정보관리 목록조회(품목정보)
	 * @param  paramMap
	 * @return List		
	 * 2011. 4. 26.
	 */
	@SuppressWarnings("unchecked")
	public List selectSalItemInfo(HashMap paramMap)throws DaoException{
		return queryForList("SaleInfoManage.selectSalItemInfo", paramMap);
	}

	/**
	 * 매출정보관리 목록조회(품목정보)_총건수
	 * @param  paramMap
	 * @return int		
	 * 2011. 4. 26.
	 */
	@SuppressWarnings("unchecked")
	public int selectSalItemInfoCount(HashMap paramMap)throws DaoException{
		return queryForInt("SaleInfoManage.selectSalItemInfoCount",paramMap); 
	}

	/**
	 * 매출정보관리 목록조회(시스템 사양 정보)
	 * @param  paramMap
	 * @return List		
	 * 2011. 4. 26.
	 */
	@SuppressWarnings("unchecked")
	public List selectSalSpecInfo(HashMap paramMap)throws DaoException{
		return queryForList("SaleInfoManage.selectSalSpecInfo", paramMap);
	}

	/**
	 * 매출정보관리 목록조회(시스템 사양정보)_총건수
	 * @param  paramMap
	 * @return int		
	 * 2011. 4. 26.
	 */
	@SuppressWarnings("unchecked")
	public int selectSalSpecInfoCount(HashMap paramMap)throws DaoException{
		return queryForInt("SaleInfoManage.selectSalSpecInfoCount",paramMap); 
	}

	/**
	 * 세금계산서관리 목록조회
	 * @param request	( 
	 *                   SAL_ID : 매출ID
	 * 					)
	 * @param response
	 * @return List
	 * @throws Exception
	 * 2011. 4. 26.
	 */
	@SuppressWarnings("unchecked")
	public List selectTaxInfo(HashMap paramMap)throws DaoException{
		paramMap.put("menuDiv", "sal");
		return queryForList("OrderInfoManage.selectTaxInfo", paramMap);
	}

	/**
	 * 세금계산서관리 목록조회 총건수
	 * @param request	( 
	 *                   SAL_ID 		   : 매출ID
	 * 					)
	 * @param response
	 * @return 
	 * @throws Exception
	 * 2011. 4. 26.
	 */
	@SuppressWarnings("unchecked")
	public int selectTaxInfoCount(HashMap paramMap)throws DaoException{
		paramMap.put("menuDiv", "sal");
		return queryForInt("OrderInfoManage.selectTaxInfoCount",paramMap); 
	}

	/**
	 * 매출정보 입력, 수정
	 * @param request	( SAL_INFO 		   : 매출정보관리
	 *                  , SAL_ITEM_INFO    : 매출품목관리
	 *                  , SAL_SPEC_INFO    : 매출설치시스템사양정보
	 * 					)
	 * @param response
	 * @return
	 * @throws Exception
	 * 2011. 4. 26.
	 */
	@SuppressWarnings("unchecked")
	public boolean saveSaleInfoManage(HashMap paramMap, HttpServletRequest request)throws DaoException{

		boolean result = true;
		
		try{
			
			/***** session 정보 *****/
			HashMap adminMap = (HashMap)request.getSession().getAttribute(SGConfigManager.getString("common.session.admin.name"));
			
			/*************** 0. 날짜 형식에 "-"를 제거 *****************************/
			
			// 매출일자
			if(paramMap.get("sal_date") != null){
				String sal_date	= paramMap.get("sal_date").toString();			 	
				       sal_date	= sal_date.replace("-", "");
				paramMap.put("sal_date", sal_date);
			}
		/*	
			// 프로젝트기간  FROM
			if(paramMap.get("pjt_date_from") != null){
				String pjt_date_from = paramMap.get("pjt_date_from").toString();	 
				pjt_date_from 	  	 = pjt_date_from.replace("-", "");
				paramMap.put("pjt_date_from", pjt_date_from);
			}
			
			// 구축기간 To
			if(paramMap.get("pjt_date_to") != null){
				String pjt_date_to = paramMap.get("pjt_date_to").toString();		 
				pjt_date_to 	   = pjt_date_to.replace("-", "");
				paramMap.put("pjt_date_to", pjt_date_to);
			}
		*/	
			// 납품예정일
			if(paramMap.get("delivery_exp_date") != null){
				String delivery_exp_date = paramMap.get("delivery_exp_date").toString(); 
				delivery_exp_date        = delivery_exp_date.replace("-", "");
				paramMap.put("delivery_exp_date", delivery_exp_date);
			}
			
			// 검수예정일
			if(paramMap.get("inspect_exp_date") != null){
				String inspect_exp_date = paramMap.get("inspect_exp_date").toString(); 
				inspect_exp_date        = inspect_exp_date.replace("-", "");
				paramMap.put("inspect_exp_date", inspect_exp_date);
			}
			
			// 설치예정일시
			if(paramMap.get("set_exp_date") != null){
				String set_exp_date = paramMap.get("set_exp_date").toString(); 
				set_exp_date        = set_exp_date.replace("-", "");
				paramMap.put("set_exp_date", set_exp_date);
			}
			
			// 매출예정일
			if(paramMap.get("sal_exp_date") != null){
				String sal_exp_date = paramMap.get("sal_exp_date").toString(); 
				sal_exp_date        = sal_exp_date.replace("-", "");
				paramMap.put("sal_exp_date", sal_exp_date);
			}
			
			// 결제일
			if(paramMap.get("account_date") != null){
				String account_date = paramMap.get("account_date").toString(); 
				account_date        = account_date.replace("-", "");
				paramMap.put("account_date", account_date);
			}
			
			// 유지보수기간_From
			if(paramMap.get("maintenance_from") != null){
				String maintenance_from = paramMap.get("maintenance_from").toString(); 
				maintenance_from        = maintenance_from.replace("-", "");
				paramMap.put("maintenance_from", maintenance_from);
			}
			
			// 유지보수기간_To
			if(paramMap.get("maintenance_to") != null){
				String maintenance_to = paramMap.get("maintenance_to").toString(); 
				maintenance_to        = maintenance_to.replace("-", "");
				paramMap.put("maintenance_to", maintenance_to);
			}
			
			/********** 1. 매출관리 저장, 수정 Start **********/
			// flag값이 없으면 신규, 그렇지 않으면 저장
			if(("R").equals(paramMap.get("flag"))){
			
				// 프로젝트 ID에 해당하는매출이 등록되어 있는지 확인
				// 한건이라도 등록이 되어있다면 'N'
				paramMap.put("procStatusDiv", "ProcStatus");
				String checkUpdatePjtStatus = queryForString("SaleInfoManage.checkUpdatePjtStatusSalse",paramMap); 
				
				// 수정
				update("SaleInfoManage.updateSaleInfoManage",paramMap);
				
				paramMap.put("pjt_proc_name", "매출");									// 관련업무명
				paramMap.put("his_comment",   "["+paramMap.get("sal_id")+"] 매출수정");	// 내용
				
				if("D90".equals(paramMap.get("proc_status_code"))){
					
					// 프로젝트 ID에 해당하는 매출이 등록되어 있지 않으므로
					// 프로젝트 상태를 매출등록으로 변경
					if("Y".equals(checkUpdatePjtStatus)){
						
						paramMap.put("admin_id",(String)adminMap.get("ADMIN_ID")); 	// 수정자 ID
						paramMap.put("proc_status_code", "49");						// PJT_STATUS 49 : 매출확정
						update("PjtManage.updatePjtStatusManage",paramMap);
					}
				}
				
			}else{ 
				
				// 프로젝트 ID에 해당하는매출이 등록되어 있는지 확인
				// 한건이라도 등록이 되어있다면 'N'
				String checkUpdatePjtStatus = queryForString("SaleInfoManage.checkUpdatePjtStatusSalse",paramMap); 
				
				// 매출저장
				insert("SaleInfoManage.insertSaleInfoManage",paramMap);
				
				// 프로젝트 ID에 해당하는 매출이 등록되어 있지 않으므로
				// 프로젝트 상태를 매출등록으로 변경
				if("Y".equals(checkUpdatePjtStatus)){
					paramMap.put("admin_id",(String)adminMap.get("ADMIN_ID")); 	// 수정자 ID
					paramMap.put("proc_status_code", "40");						// PJT_STATUS 40 : 매출등록
					update("PjtManage.updatePjtStatusManage",paramMap);
				}
				
				paramMap.put("pjt_proc_name", "매출");									// 관련업무명
				paramMap.put("his_comment",   "["+paramMap.get("sal_id")+"] 매출등록");	// 내용
			    
			}
			
			// 프로젝트 이력테이블에 이력 저장
			insert("EstimateProcessStateManage.insertPjtHistory",paramMap);
			
			
			/********** 2. 매출 품목정보 저장, 수정 **********/
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

			    if("R".equals(map.get("flag"))){
			    	update("SaleInfoManage.updateSalItemInfo",map);
			    }else{
			    	insert("SaleInfoManage.insertSalItemInfo",map);
			    }
			}// End for
		
			/********** 3. 매출처 시스템 사양정보  저장, 수정 **********/
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
			    
			    if("R".equals(map.get("flag"))){
			    	update("SaleInfoManage.updateSalSpecInfo",map);
			    }else{
			    	insert("SaleInfoManage.insertSalSpecInfo",map);
			    }
			}// End for		
			
			/********** 4. 세금계산서 분할 발행정보  저장, 수정 **********/
			// 편집그리드의 내용을 받아서 처리하는부분
			String recvJsonDataTax = (String)request.getParameter("edit3rdData");			
			JSONArray jsonArrayTax = JSONArray.fromObject(recvJsonDataTax);

	    	// 세금계산서 계산을 다시 하였을 경우 기존 자료를 삭제
	    	if("Y".equals(paramMap.get("taxDeleteYn"))){
	    		//delete("SaleInfoManage.deleteTaxItemInfoSal",paramMap);
	    		//delete("SaleInfoManage.deleteTaxInfoSal",paramMap);
	    	}
			
	    	String sal_type_code = paramMap.get("sal_type_code").toString(); 
	    	
			for (int i=0; i < jsonArrayTax.size(); i++) {
				JSONObject jsonData = new JSONObject();
				jsonData = jsonArrayTax.getJSONObject(i);
				String taxId = "";
			
				HashMap<String,String> map = new HashMap<String,String>();
			    Iterator iter = jsonData.keys();
			    while(iter.hasNext()){
			        String key = (String)iter.next();
			        String value = jsonData.getString(key);
			        map.put(key.toLowerCase(),value);
			    }
			    
			    // session정보 설정
			    map.put("final_mod_id", (String)adminMap.get("ADMIN_ID"));

			    if("R".equals(map.get("flag"))){
			    	
			    	if("10".equals(sal_type_code)){	// 프로젝트
			    		if(i==0){
			    			update("SaleInfoManage.updateTaxInfo",map);
			    		}
			    	}else{
			    		update("SaleInfoManage.updateTaxInfo",map);
			    	}
			    	
					update("OrderInfoManage.updateTaxItemInfo",map);
					
			    }else{
			    	
			    	// 세금계산서 ID생성
//			    	paramMap.put("createId","SAT");
//			    	taxId = queryForString("OrderInfoManage.createId",paramMap);
//			    	map.put("tax_id",taxId);
			    	
			    	// 세금계산서관리
//					insert("OrderInfoManage.insertTaxInfo",map);
					// 세금계산서품목관리
//					insert("OrderInfoManage.insertTaxItemInfo",map);
			    }
			}// End for	
			
		}catch(Exception e){
			logger.error(e,e);
			e.printStackTrace();
			result = false;
		}
		
		return result;
	}

	/**
	 * 매출ID 생성
	 * @return
	 * @throws DaoException
	 * 2011. 4. 27.
	 */
	@SuppressWarnings("unchecked")
	public String createSalId(HashMap paramMap) throws DaoException {
		paramMap.put("createId","SAL");
		return queryForString("OrderInfoManage.createId",paramMap);
	}

	/**
	 * 매출정보관리 목록조회
	 * @param  paramMap
	 * @param  response
	 * @return mav		
	 * 2011. 6. 8.
	 */
	@SuppressWarnings("unchecked")
	public List saleInfoManageList(HashMap paramMap) throws DaoException {
		// TODO Auto-generated method stub
		System.out.println("A...................................");
		
		return queryForList("SaleInfoManage.saleInfoManageList", paramMap);
	}

	/**
	 * 매출정보관리 목록조회 총건수
	 * @param  paramMap
	 * @param  response
	 * @return mav		
	 * 2011. 6. 8.
	 */
	@SuppressWarnings("unchecked")
	public int saleInfoManageListCount(HashMap paramMap) throws DaoException {
		// TODO Auto-generated method stub
		return queryForInt("OrderInfoManage.saleInfoManageListCount",paramMap); 
	}

}
