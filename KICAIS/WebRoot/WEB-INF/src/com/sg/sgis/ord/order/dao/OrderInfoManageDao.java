/**
 *  Class Name  : OrderInfoInquiryDao.java
 *  Description : 수주정보 조회 Dao
 *  Modification Information
 *
 *  수정일                   수정자               수정내용
 *  -------      --------   ---------------------------
 *  2011. 4. 15. 고기범              최초 생성
 *
 *  @author 고기범
 *  @since 2011. 4. 15.
 *  @version 1.0
 *  @see 
 * 
 *  Copyright (C) 2011 by SG All right reserved.
 */
package com.sg.sgis.ord.order.dao;

import java.math.BigDecimal;
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

public class OrderInfoManageDao extends BaseDao implements OrderInfoManageDaoImpl{

	protected final Log logger = LogFactory.getLog(getClass());

	/**
	 * 수주정보관리 목록조회(수주정보)
	 * @param  paramMap
	 * @return List		
	 * 2011. 4. 15.
	 */
	@SuppressWarnings("unchecked")
	public List selectOrderInfoManageList(HashMap paramMap) throws DaoException {
		return queryForList("OrderInfoManage.selectOrderInfoManageList", paramMap);
	}

	/**
	 * 수주정보관리 목록조회(수주정보)_총건수
	 * @param  paramMap
	 * @return int		
	 * 2011. 4. 15.
	 */
	@SuppressWarnings("unchecked")
	public int selectOrderInfoManageListCount(HashMap paramMap)
			throws DaoException {
		return queryForInt("OrderInfoManage.selectOrderInfoManageListCount",paramMap); 
	}

	/**
	 * 수주정보관리 목록조회(품목정보)
	 * @param  paramMap
	 * @return List		
	 * 2011. 4. 18.
	 */
	@SuppressWarnings("unchecked")
	public List selectOrdItemInfo(HashMap paramMap) throws DaoException {
		return queryForList("OrderInfoManage.selectOrdItemInfo", paramMap);
	}

	/**
	 * 수주정보관리 목록조회(품목정보)_총건수
	 * @param  paramMap
	 * @return int		
	 * 2011. 4. 18.
	 */
	@SuppressWarnings("unchecked")
	public int selectOrdItemInfoCount(HashMap paramMap) throws DaoException {
		return queryForInt("OrderInfoManage.selectOrdItemInfoCount",paramMap); 
	}

	/**
	 * 수주정보관리 목록조회(시스템 사양정보)
	 * @param  paramMap
	 * @return List		
	 * 2011. 4. 18.
	 */
	@SuppressWarnings("unchecked")
	public List selectOrdSpecInfo(HashMap paramMap) throws DaoException {
		return queryForList("OrderInfoManage.selectOrdSpecInfo", paramMap);
	}

	/**
	 * 수주정보관리 목록조회(시스템 사양정보)_총건수
	 * @param  paramMap
	 * @return int		
	 * 2011. 4. 18.
	 */
	@SuppressWarnings("unchecked")
	public int selectOrdSpecInfoCount(HashMap paramMap) throws DaoException {
		return queryForInt("OrderInfoManage.selectOrdSpecInfoCount",paramMap); 
	}

	/**
	 * 수주정보 입력, 수정
	 * @param request	( ORD_INFO 		   : 수주정보관리
	 *                  , ORD_ITEM_INFO    : 수주품목관리
	 *                  , ORD_SPEC_INFO    : 수주설치시스템사양정보
	 * 					)
	 * @param response
	 * @return
	 * @throws Exception
	 * 2011. 4. 18.
	 */
	@SuppressWarnings("unchecked")
	public void saveOrderInfoManage(HashMap paramMap, HttpServletRequest request)
			throws DaoException {
		// String ordId = "";
		
		try{
			
			/***** session 정보 *****/
			HashMap adminMap = (HashMap)request.getSession().getAttribute(SGConfigManager.getString("common.session.admin.name"));
			
			/*************** 0. 날짜 형식에 "-"를 제거 *****************************/
			
			// 수주일자
			if(paramMap.get("ord_date") != null){
				String ord_date	= paramMap.get("ord_date").toString();			 	
				ord_date 		= ord_date.replace("-", "");
				paramMap.put("ord_date", ord_date);
			}
			
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
			
			/********** 1. 품목관리 저장, 수정 Start **********/
			// flag값이 없으면 신규, 그렇지 않으면 저장
			if(("R").equals(paramMap.get("flag"))){
			
				// 수정
				update("OrderInfoManage.updateOrderInfoManage",paramMap);
				
				paramMap.put("pjt_proc_name", "수주");																			// 관련업무명
				paramMap.put("his_comment",   "["+paramMap.get("ord_id")+"][ver : "+ paramMap.get("est_version") +"] 수주수정");	// 내용
				
			}else{ 
				
				// 견적 Rev를 통해서 생성된 자료라면 견적ID를 생성하지 않도록 처리
				//if(!("I").equals(paramMap.get("flag"))){
					// 신규저장일 경우 견적ID를 생성
				//	paramMap.put("createId","ORD");
				//	ordId = queryForString("OrderInfoManage.createId",paramMap);
				//	paramMap.put("ord_id", ordId);
				//}
				
				// 수주저장
				insert("OrderInfoManage.insertOrderInfoManage",paramMap);
				
				// 프로젝트 ID에 해당하는 수주등록이 등록되어 있는지 확인
				// 한건이라도 등록이 되어있다면 'N'
				String checkUpdatePjtStatus = queryForString("OrderInfoManage.checkUpdatePjtStatusOrd",paramMap); 
				
				// 프로젝트 ID에 해당하는 수주등록이 등록되어 있지 않으므로
				// 프로젝트 상태를 견적등록으로 변경
				if("Y".equals(checkUpdatePjtStatus)){
					paramMap.put("admin_id",(String)adminMap.get("ADMIN_ID"));
					paramMap.put("proc_status_code","30");	// PJT_STATUS 30 : 수주등록
					update("PjtManage.updatePjtStatusManage",paramMap);
				}
				
				paramMap.put("pjt_proc_name", "수주");									// 관련업무명
				paramMap.put("his_comment",   "["+paramMap.get("ord_id")+"][ver : "+ paramMap.get("est_version") +"] 수주등록");	// 내용
			    
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
			    	// 수주ID가 없을 경우
			    //	if(("").equals(map.get("ord_id"))){
			    //		map.put("ord_id", ordId);
			    //	}
		    	//}
			    
			    if("R".equals(map.get("flag"))){
			    	update("OrderInfoManage.updateOrdItemInfo",map);
			    }else if("I".equals(map.get("flag"))){
			    	insert("OrderInfoManage.insertOrdItemInfo",map);
			    }else if("D".equals(map.get("flag"))){

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
			    //	// 수주ID가 없을 경우
			    //	if(("").equals(map.get("ord_id"))){
			    //		map.put("ord_id", ordId);
			    //	}
		    	//}
			    
			    if("R".equals(map.get("flag"))){
			    	update("OrderInfoManage.updateOrdSpecInfo",map);
			    }else if("I".equals(map.get("flag"))){
			    	insert("OrderInfoManage.insertOrdSpecInfo",map);
			    }else if("D".equals(map.get("flag"))){
			    	update("OrderInfoManage.deleteOrdSpecInfo",map);
			    }
			}// End for		
			
			/********** 4. 세금계산서 분할 발행정보  저장, 수정 **********/
			/**
			// 편집그리드의 내용을 받아서 처리하는부분
			String recvJsonDataTax = (String)request.getParameter("edit3rdData");			
			JSONArray jsonArrayTax = JSONArray.fromObject(recvJsonDataTax);

	    	// 세금계산서 계산을 다시 하였을 경우 기존 자료를 삭제
	    	if("Y".equals(paramMap.get("taxDeleteYn"))){
	    		delete("OrderInfoManage.deleteTaxItemInfo",paramMap);
	    		delete("OrderInfoManage.deleteTaxInfo",paramMap);
	    	}
			
	    	int sup_price = 0;
	    	int tax_amt = 0;
	    	String ord_type_code = paramMap.get("ord_type_code").toString(); 
	    	String taxId = "";
	    	
	    	// System.out.println("여보세요...ord_type_code ."+ord_type_code);
	    	
			for (int i=0; i < jsonArrayTax.size(); i++) {
				JSONObject jsonData = new JSONObject();
				jsonData = jsonArrayTax.getJSONObject(i);
				
			
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
			    	// 수주ID가 없을 경우
			    //	if(("").equals(map.get("ord_id"))){
			    //		map.put("ord_id", ordId);
			    //	}
		    	//}
			    
			    if("R".equals(map.get("flag"))){
					update("OrderInfoManage.updateTaxInfo",map);
					update("OrderInfoManage.updateTaxItemInfo",map);
			    }else{

		    		// 세금계산서 ID생성
		    		paramMap.put("createId","SAT");
			    	
			    	if("10".equals(ord_type_code)){	// 프로젝트
			    		
			    		if(i==0){
					    	taxId = queryForString("OrderInfoManage.createId",paramMap);
					    	map.put("tax_id",taxId);
					    	map.put("amt",paramMap.get("ord_aply_total_amt").toString());
					    	map.put("tax",paramMap.get("ord_aply_total_tax").toString());
					    //	System.out.println("insertTaxInfo.............tax_id ["+i+"] :"+taxId);
					    //	System.out.println("insertTaxInfo.............PUR_SAL_TYPE_CODE ["+i+"] :"+map.get("pur_sal_type_code"));
					    //	System.out.println("insertTaxInfo.............매출총액    :"+paramMap.get("ord_aply_total_amt"));
					    //	System.out.println("insertTaxInfo.............매출세액    :"+paramMap.get("ord_aply_total_tax"));
					    //	System.out.println("insertTaxInfo.............paramMap :"+paramMap.toString());
					    	// 세금계산서관리
							insert("OrderInfoManage.insertTaxInfo",map);
			    		}
			    		
			    		map.put("tax_id",taxId);
			    		
			    		//System.out.println("insertTaxItemInfo.............tax_id   :"+taxId);
			    		//System.out.println("insertTaxItemInfo.............금액 :"+map.get("amt"));
				    	//System.out.println("insertTaxItemInfo.............세액 :"+map.get("tax"));

						// 세금계산서품목관리
						insert("OrderInfoManage.insertTaxItemInfo",map);
			    	}else if("20".equals(ord_type_code)){ // 유지보수
			    		taxId = queryForString("OrderInfoManage.createId",paramMap);
				    	map.put("tax_id",taxId);
				    	
				    	//System.out.println("20-tax_info.............tax_id  :"+map.get("tax_id"));
				    	//System.out.println("20-tax_item_info.............금액 :"+paramMap.get("amt"));
				    	//System.out.println("20-tax_item_info.............세액:"+paramMap.get("tax"));
				    	
				    	// 세금계산서관리
						insert("OrderInfoManage.insertTaxInfo",map);
						// 세금계산서품목관리
						insert("OrderInfoManage.insertTaxItemInfo",map);
				    	
			    	}
			    	//if(!"R".equals(paramMap.get("flag"))){
			    	//	map.put("pur_sal_id", ordId);
			    	//}
			    }
			}// End for	
			
			**/
		}catch(Exception e){
			logger.error(e,e);
			e.printStackTrace();
		}
		
	}

	/**
	 * 세금계산서관리 목록조회
	 * @param  paramMap
	 * @return List
	 * @throws Exception
	 * 2011. 4. 20.
	 */
	@SuppressWarnings("unchecked")
	public List selectTaxInfo(HashMap paramMap) throws DaoException {
		paramMap.put("menuDiv", "ord");
		return queryForList("OrderInfoManage.selectTaxInfo", paramMap);
	}

	/**
	 * 세금계산서관리 목록조회 총건수
	 * @param  paramMap
	 * @return int
	 * @throws Exception
	 * 2011. 4. 20.
	 */
	@SuppressWarnings("unchecked")
	public int selectTaxInfoCount(HashMap paramMap) throws DaoException {
		paramMap.put("menuDiv", "ord");
		return queryForInt("OrderInfoManage.selectTaxInfoCount",paramMap); 
	}

	/**
	 * 수주팝업 목록조회 
	 * @param  paramMap
	 * @return List
	 * @throws Exception
	 * 2011. 4. 28.
	 */
	@SuppressWarnings("unchecked")
	public List selectOrderPopList(HashMap paramMap) throws DaoException {
		return queryForList("OrderInfoManage.selectOrderPopList", paramMap);
	}

	/**
	 * 수주팝업 목록조회 총건수
	 * @param  paramMap
	 * @return int
	 * @throws Exception
	 * 2011. 4. 28.
	 */
	@SuppressWarnings("unchecked")
	public int selectOrderPopListCount(HashMap paramMap) throws DaoException {
		// TODO Auto-generated method stub
		return queryForInt("OrderInfoManage.selectOrderPopListCount",paramMap); 
	}

	/**
	 * 수주ID 생성
	 * @param paramMap
	 * @return String
	 * @throws Exception
	 * 2011. 5. 6.
	 */
	@SuppressWarnings("unchecked")
	public String createOrdId(HashMap paramMap) throws DaoException {
		paramMap.put("createId","ORD");
		return queryForString("OrderInfoManage.createId",paramMap);
	}

	/**
	 * 세금계산서 발행정보
	 * @param paramMap
	 * @return String
	 * @throws Exception
	 * 2011. 6. 3.
	 */
	@SuppressWarnings("unchecked")
	public List selectTaxPublishInfoManageList(HashMap paramMap)
			throws DaoException {
		// TODO Auto-generated method stub
		return queryForList("OrderInfoManage.selectTaxPublishInfoManageList", paramMap);
	}

	/**
	 * 세금계산서 발행정보 총건수
	 * @param paramMap
	 * @return String
	 * @throws Exception
	 * 2011. 6. 3.
	 */
	@SuppressWarnings("unchecked")
	public int selectTaxPublishInfoManageListCount(HashMap paramMap)
			throws DaoException {
		// TODO Auto-generated method stub
		return queryForInt("OrderInfoManage.selectTaxPublishInfoManageListCount",paramMap); 
	}

	/**
	 * 세금계산서 발행정보 저장, 수정
	 * @param map
	 * @param request
	 * @return
	 * 2011. 6. 3.
	 */
	@SuppressWarnings("unchecked")
	public void saveTaxPublishInfoManage(HashMap paramMap, HttpServletRequest request)
			throws DaoException {
		// TODO Auto-generated method stub
		try{
			
			/***** session 정보 *****/
			HashMap adminMap = (HashMap)request.getSession().getAttribute(SGConfigManager.getString("common.session.admin.name"));
			
			/********** 1. 품목관리 저장, 수정 Start **********/
	
			// 수주수정
			
			System.out.println("");
	    	System.out.println("수주수정...."+paramMap.toString());
	    	System.out.println("");
	    	
			update("OrderInfoManage.updateTaxPublishInfoManage",paramMap);
			
			paramMap.put("pjt_proc_name", "수주");																						// 관련업무명
			paramMap.put("his_comment",   "["+paramMap.get("ord_id")+"][ver : "+ paramMap.get("est_version") +"] 세금계산서 발행정보");	// 내용

			// 프로젝트 이력테이블에 이력 저장
			// insert("EstimateProcessStateManage.insertPjtHistory",paramMap);
					
			// 거래처정보 수정
			update("OrderInfoManage.updateTaxPublishInfoCustom",paramMap);
			
			/********** 2. 세금계산서 분할 발행정보  저장, 수정 **********/
			// 편집그리드의 내용을 받아서 처리하는부분
			String recvJsonDataTax = (String)request.getParameter("edit3rdData");			
			JSONArray jsonArrayTax = JSONArray.fromObject(recvJsonDataTax);

	       	String taxId = "";
	    	
			for (int i=0; i < jsonArrayTax.size(); i++) {
				JSONObject jsonData = new JSONObject();
				jsonData = jsonArrayTax.getJSONObject(i);
				
			
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
					
			    	System.out.println("");
			    	System.out.println("세금계산서 수정...."+map.toString());
			    	System.out.println("");
			    	
			    	update("OrderInfoManage.updateTaxInfo",map);
					update("OrderInfoManage.updateTaxItemInfo",map);
					
			    }else if("I".equals(map.get("flag"))){

		    		// 세금계산서 ID생성
		    		paramMap.put("createId","SAT");
	    			taxId = queryForString("OrderInfoManage.createId",paramMap);
			    	map.put("tax_id",taxId);
			    	
			    	System.out.println("");
			    	System.out.println("세금계산서 입력...."+map.toString());
			    	System.out.println("");

			    	// 세금계산서관리
					insert("OrderInfoManage.insertTaxInfo",map);
					// 세금계산서품목관리
					insert("OrderInfoManage.insertTaxItemInfo",map);
				    	
			    }
			}// End for	
			
		}catch(Exception e){
			logger.error(e,e);
			e.printStackTrace();
		}
	}

	/**
	 * 세금계산서 발행정보(매출등록)
	 * @param map
	 * @param request
	 * @return
	 * 2011. 6. 4.
	 */
	@SuppressWarnings("unchecked")
	public void saveSaleRegister(HashMap paramMap, HttpServletRequest request)
			throws DaoException {
		// TODO Auto-generated method stub
		try{
			
			/***** session 정보 *****/
			HashMap adminMap = (HashMap)request.getSession().getAttribute(SGConfigManager.getString("common.session.admin.name"));
			
			/********** 세금계산서 수정 및 매출등록 Start **********/
			// 편집그리드의 내용을 받아서 처리하는부분
			String recvJsonDataTax = (String)request.getParameter("edit3rdData");			
			JSONArray jsonArrayTax = JSONArray.fromObject(recvJsonDataTax);

	       	String salId = "";
	    	
			for (int i=0; i < jsonArrayTax.size(); i++) {
				JSONObject jsonData = new JSONObject();
				jsonData = jsonArrayTax.getJSONObject(i);
			
				HashMap<String,String> map = new HashMap<String,String>();
			    Iterator iter = jsonData.keys();
			    while(iter.hasNext()){
			        String key = (String)iter.next();
			        String value = jsonData.getString(key);
			        map.put(key.toLowerCase(),value);
			    }
			    
			    // session정보 설정
			    map.put("final_mod_id", (String)adminMap.get("ADMIN_ID"));
			    
			    // 매출ID생성
		    	paramMap.put("createId","SAL");
		    	salId = queryForString("OrderInfoManage.createId",paramMap);
				
		    	map.put("sal_id", salId);	// 생성된 매출ID설정
		    	map.put("ord_id", map.get("pur_ord_id"));
		    	
			    /********** 1. 매출등록 **********/
				insert("SaleInfoManage.insertSaleInfoManage",map);
				
			    /********** 2. 매출품목등록 **********/
				// 수주 품목정보를 조회
				List itemList = queryForList("OrderInfoManage.selectOrdItemInfo", map);
				
				if(itemList.size() > 0){
					for(int j=0 ; j < itemList.size() ; j++){
						HashMap<String,String> itemMap = new HashMap<String,String>();
						itemMap = (HashMap)itemList.get(j);
						itemMap.put("SAL_INFO_SEQ", String.valueOf(itemMap.get("ORD_INFO_SEQ")));
						itemMap.put("FINAL_MOD_ID", (String)adminMap.get("ADMIN_ID"));
						itemMap.put("SAL_ID", salId);
						insert("SaleInfoManage.insertSalItemInfo",itemMap);
					}
				}
			    
			    /********** 3. 세금계산서에 ERP세금계산서 및 매출ID 등록 **********/
			    if("R".equals(map.get("flag"))){
			    	map.put("pur_sal_id",salId);
			    	update("OrderInfoManage.updateSaleRegisterTaxInfo",map);
			    }else if("I".equals(map.get("flag"))){
			    	// 세금계산서 ID생성
		    		paramMap.put("createId","SAT");
	    			String taxId = queryForString("OrderInfoManage.createId",paramMap);
			    	map.put("tax_id",taxId);
			    	map.put("pur_sal_id",salId);
			    	
			    	// 세금계산서관리
					insert("OrderInfoManage.insertTaxInfo",map);
					// 세금계산서품목관리
					insert("OrderInfoManage.insertTaxItemInfo",map);
			    }
			    
			}// End for	
			
			
			/********** 1. 품목관리 저장, 매출등록 Start **********/
			
			//paramMap.put("pjt_proc_name", "매출");																						// 관련업무명
			//paramMap.put("his_comment",   "["+paramMap.get("ord_id")+"][ver : "+ paramMap.get("est_version") +"] 세금계산서 발행정보에서 매출등록");	// 내용

			// 프로젝트 이력테이블에 이력 저장
			//insert("EstimateProcessStateManage.insertPjtHistory",paramMap);
					
			
		}catch(Exception e){
			logger.error(e,e);
			e.printStackTrace();
		}
	}
}

