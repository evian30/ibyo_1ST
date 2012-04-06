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

public class PjtManageDao extends BaseDao implements PjtManageDaoImpl{

	protected final Log logger = LogFactory.getLog(getClass());
	
	
	@SuppressWarnings("unchecked")
	public List selectPjtManage(HashMap paramMap) throws DaoException{
		return  queryForList("PjtManage.selectPjtManage",paramMap);
	}
	
	@SuppressWarnings("unchecked") 
	public int selectPjtManageCount(Map map) throws DaoException{
		return queryForInt("PjtManage.selectPjtManageCount",map); 
	} 
	 
	@SuppressWarnings("unchecked")
	public void deletePjtManage(HashMap map) throws DaoException{
		update("PjtManage.deletePjtManage", map);
	} 
 
	@SuppressWarnings("unchecked")
	public List selectPjtCustom(HashMap paramMap) throws DaoException{
		return  queryForList("PjtManage.selectPjtCustom",paramMap);
	}
	
	@SuppressWarnings("unchecked") 
	public int selectPjtCustomCount(Map map) throws DaoException{
		return queryForInt("PjtManage.selectPjtCustomCount",map); 
	} 
	 
	
	@SuppressWarnings("unchecked")
	public List selectPjtItem(HashMap paramMap) throws DaoException{
		return  queryForList("PjtManage.selectPjtItem",paramMap);
	}
	
	@SuppressWarnings("unchecked") 
	public int selectPjtItemCount(Map map) throws DaoException{
		return queryForInt("PjtManage.selectPjtItemCount",map); 
	} 
	  
	@SuppressWarnings("unchecked") 
	public void actionPjtManage(HashMap paramMap, HttpServletRequest request)throws DaoException {
 		
		try{
			/***** session 정보 *****/
			HashMap adminMap = (HashMap)request.getSession().getAttribute(SGConfigManager.getString("common.session.admin.name"));
			
			// 날짜 형식에 "-"를 제거			
			if(paramMap.get("pjt_reg_date") != null){
				String pjt_reg_date	= paramMap.get("pjt_reg_date").toString();
				pjt_reg_date 		= pjt_reg_date.replace("-", "");
				paramMap.put("pjt_reg_date", pjt_reg_date);
			}
			
			if(paramMap.get("pjt_date_from") != null){
				String pjt_date_from = paramMap.get("pjt_date_from").toString();
				pjt_date_from 	  	 = pjt_date_from.replace("-", "");
				paramMap.put("pjt_date_from", pjt_date_from);
			}
			
			if(paramMap.get("pjt_date_to") != null){
				String pjt_date_to = paramMap.get("pjt_date_to").toString();
				pjt_date_to 	   = pjt_date_to.replace("-", "");
				paramMap.put("pjt_date_to", pjt_date_to);
			}
			
			if(paramMap.get("order_exp_date") != null){
				String order_exp_date = paramMap.get("order_exp_date").toString();
				order_exp_date        = order_exp_date.replace("-", "");
				paramMap.put("order_exp_date", order_exp_date);
			}
			
			if(paramMap.get("bid_dday") != null){
				String bid_dday = paramMap.get("bid_dday").toString(); 
				bid_dday        = bid_dday.replace("-", "");
				paramMap.put("bid_dday", bid_dday);
			}
			
			if(paramMap.get("exp_sal_total_amt") != null){
				String exp_sal_total_amt = paramMap.get("exp_sal_total_amt").toString(); 
				exp_sal_total_amt        = exp_sal_total_amt.replace(",", "");
				if(exp_sal_total_amt.equals("")){
					exp_sal_total_amt="0";
				}
				paramMap.put("exp_sal_total_amt",  Integer.parseInt(exp_sal_total_amt));
				
				paramMap.put("pay_total_tax", Integer.parseInt(exp_sal_total_amt)*0.1 );
			}
			 
			  
			/********** 1. 품목관리 저장, 수정 Start **********/
			// flag값이 없으면 신규, 그렇지 않으면 저장
			if(("R").equals(paramMap.get("flag"))){
				update("PjtManage.updatePjtManage",paramMap);
			}else {
				insert("PjtManage.insertPjtManage",paramMap);
			}
				//진행상태 history  테이블 무조건 저장
				insert("PjtManage.insertPjtHistory",paramMap);
			
			
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
			    
			    if(!"R".equals(map.get("flag"))){
			    	insert("PjtManage.insertPjtCustom",map);
			    }else if("R".equals(map.get("flag"))){
			    	update("PjtManage.updatePjtCustom",map);
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
 
			    if(!"R".equals(map.get("flag"))){
					insert("PjtManage.insertPjtItem",map);
			    }else if("R".equals(map.get("flag"))){
					update("PjtManage.updatePjtItem",map);
			    }
			}// End for					
			
		}catch(Exception e){
			logger.error(e,e);
			e.printStackTrace();
		}
	}
	
	
	@SuppressWarnings("unchecked")
	public String getDeptCode(String emp_num) throws DaoException{
		return queryForString("PjtManage.getDeptCode", emp_num);
	}
	
	@SuppressWarnings("unchecked")
	public String getDegreeRCode(String emp_num) throws DaoException{
		return queryForString("PjtManage.getDegreeRCode", emp_num);
	}
	@SuppressWarnings("unchecked")
	public String getDegreeBCode(String emp_num) throws DaoException{
		return queryForString("PjtManage.getDegreeBCode", emp_num);
	}
	 
	
	@SuppressWarnings("unchecked")
	public String getDeptNm(String dept_code) throws DaoException{
		return queryForString("PjtManage.getDeptNm", dept_code);
	}
	 
	
	@SuppressWarnings("unchecked")
	public String selectPjtID(HashMap map) throws DaoException{
		return queryForString("PjtManage.selectPjtID", map);
	}
	
	
	
	@SuppressWarnings("unchecked") 
	public void actionPjtStatusManage(HashMap paramMap, HttpServletRequest request)throws DaoException {
 		
		try{
			/***** session 정보 *****/
			HashMap adminMap = (HashMap)request.getSession().getAttribute(SGConfigManager.getString("common.session.admin.name"));
		 
			
			/********** 1. 기본정보의 진행상태  수정 **********/
			// 편집그리드의 내용을 받아서 처리하는부분
			String recvJsonData1 = (String)request.getParameter("edit3rdData");			
			JSONArray jsonArray1 = JSONArray.fromObject(recvJsonData1);
			
			for (int i=0; i < jsonArray1.size(); i++) {
				JSONObject jsonData = new JSONObject();
				jsonData = jsonArray1.getJSONObject(i);
			
				HashMap map = new HashMap();
			    Iterator iter = jsonData.keys();
			    while(iter.hasNext()){
			        String key = (String)iter.next();
			        String value = jsonData.getString(key);
			        map.put(key.toLowerCase(),value);
			    } 
			    
			    map.put("admin_id", (String)adminMap.get("ADMIN_ID")); 
			    
			    //진행상태 history  테이블 무조건 저장
				update("PjtManage.updatePjtStatusManage",map);
				insert("PjtManage.insertPjtHistory",map);
			    
			}// End for
			
			/********** 2. 거래처정보의 계약여부 수정 **********/
			// 편집그리드의 내용을 받아서 처리하는부분
			String recvJsonData2 = (String)request.getParameter("edit1stData");			
			JSONArray jsonArray2 = JSONArray.fromObject(recvJsonData2);
			
			for (int i=0; i < jsonArray2.size(); i++) {
				JSONObject jsonData = new JSONObject();
				jsonData = jsonArray2.getJSONObject(i);
			
				HashMap map = new HashMap();
			    Iterator iter = jsonData.keys();
			    while(iter.hasNext()){
			        String key = (String)iter.next();
			        String value = jsonData.getString(key);
			        map.put(key.toLowerCase(),value);
			    }
			    
			    map.put("admin_id", (String)adminMap.get("ADMIN_ID"));
			    
			    update("PjtManage.updatePjtStatusCustom",map);
			    
			}// End for 
			
		}catch(Exception e){
			logger.error(e,e);
			e.printStackTrace();
		}
	}
	
	
	@SuppressWarnings("unchecked")
	public List selectPjtStatusHIS(HashMap paramMap) throws DaoException{
		return  queryForList("PjtManage.selectPjtStatusHIS",paramMap);
	}
	
	@SuppressWarnings("unchecked") 
	public int selectPjtStatusHISCount(Map map) throws DaoException{
		return queryForInt("PjtManage.selectPjtStatusHISCount",map); 
	} 
	
	
	
	@SuppressWarnings("unchecked")
	public List selectPjtStatus(HashMap paramMap) throws DaoException{
		return  queryForList("PjtManage.selectPjtStatus",paramMap);
	}
	
	@SuppressWarnings("unchecked") 
	public int selectPjtStatusCount(Map map) throws DaoException{
		return queryForInt("PjtManage.selectPjtStatusCount",map); 
	} 
	
	@SuppressWarnings("unchecked")
	public String getAuthority(String emp_num) throws DaoException{
		return queryForString("PjtManage.getAuthority", emp_num);
	}
	
	
}
