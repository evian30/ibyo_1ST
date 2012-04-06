package com.sg.sgis.com.item.dao;

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

public class ItemDao extends BaseDao implements ItemDaoImpl{

	protected final Log logger = LogFactory.getLog(getClass());
	
	/**
	 * 품목정보관리 목록조회
	 * @param  paramMap
	 * @return List
	 * @throws DaoException
	 * 2011. 2. 8.
	 */
	@SuppressWarnings("unchecked")
	public List selectItem(HashMap paramMap) throws DaoException{
		return  queryForList("Item.selectItem",paramMap);
	}
	
	@SuppressWarnings("unchecked") 
	public int selectItemCount(Map map) throws DaoException{
		return queryForInt("Item.selectItemCount",map); 
	} 
 
	@SuppressWarnings("unchecked")
	public void insertItem(HashMap map) throws DaoException{
		insert("Item.insertItem", map);
	} 
 
	@SuppressWarnings("unchecked")
	public void updateItem(HashMap map) throws DaoException{
		update("Item.updateItem", map);
	} 
	
	/**
	 * 품목정보관리 상세조회
	 * @param  paramMap
	 * @return List
	 * @throws DaoException
	 * 2011. 2. 8.
	 */
	@SuppressWarnings("unchecked")
	public HashMap selectItembyPK(HashMap paramMap)throws DaoException{
		return  (HashMap)queryForObject("Item.selectItembyPK",paramMap);
	}

	/**
	 * 품목정보관리 저장, 수정
	 * @param  paramMap
	 * @return List
	 * @throws DaoException
	 * 2011. 4. 5.
	 */
	@SuppressWarnings("unchecked")
	public void saveItem(HashMap paramMap, HttpServletRequest request)
			throws DaoException {

		String itemCode = "";
		
		try{
			
			/***** session 정보 *****/
			HashMap adminMap = (HashMap)request.getSession().getAttribute(SGConfigManager.getString("common.session.admin.name"));
			
			// 날짜 형식에 "-"를 제거
			String releaseDate = paramMap.get("release_date").toString();
			releaseDate = releaseDate.replace("-", "");
			paramMap.put("release_date", releaseDate);
			
			/********** 1. 품목관리 저장, 수정 Start **********/
			// flag값이 없으면 신규, 그렇지 않으면 저장
			if(("R").equals(paramMap.get("flag"))){
			
				// 수정
				update("Item.updateItem",paramMap);
				
			}else{ 
				
				// 신규저장일 경우 품목코드를 생성
				itemCode = queryForString("Item.createItemCode",paramMap);
				paramMap.put("item_code", itemCode);
				// 신규 저장
				insert("Item.insertItem",paramMap);
			}
			
			/********** 2. 하드웨어 저장, 수정 **********/
			// 편집그리드의 내용을 받아서 처리하는부분
			String recvJsonDataHw = (String)request.getParameter("hw_data");			
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
			    if(("").equals(paramMap.get("flag"))){
		    		map.put("item_code", itemCode);
		    	}
			    
			    if("I".equals(map.get("flag"))){
			    	insert("ItemHW.insertItemHW",map);
			    }else{
			    	update("ItemHW.updateItemHW",map);
			    }
			}// End for
			
			/********** 3. 소프트웨어 저장, 수정 **********/
			// 편집그리드의 내용을 받아서 처리하는부분
			String recvJsonDataSw = (String)request.getParameter("sw_data");			
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
			    if(("").equals(paramMap.get("flag"))){
		    		map.put("item_code", itemCode);
		    	}
			    
			    if("I".equals(map.get("flag"))){
			    	insert("ItemSW.insertItemSW",map);
			    }else{
			    	update("ItemSW.updateItemSW",map);
			    }
			}// End for
			
			/********** 4. 개발 담당자 저장, 수정 **********/
			// 편집그리드의 내용을 받아서 처리하는부분
			String recvJsonData = (String)request.getParameter("dev_data");			
			JSONArray jsonArray = JSONArray.fromObject(recvJsonData);
			
			for (int i=0; i < jsonArray.size(); i++) {
				JSONObject jsonData = new JSONObject();
				jsonData = jsonArray.getJSONObject(i);
			
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
			    if(("").equals(paramMap.get("flag"))){
		    		map.put("item_code", itemCode);
		    	}
			    
			    if("I".equals(map.get("flag"))){
			    	insert("ItemDeveloper.insertItemDeveloper",map);
			    }else{
			    	update("ItemDeveloper.updateItemDeveloper",map);
			    }
			}// End for
			
		}catch(Exception e){
			logger.error(e,e);
			e.printStackTrace();
		}
	}
	
	
	/**
	 * 아이템(장비-제품이 아닌것) 조회(팝업)
	 * @param  paramMap
	 * @return List
	 * @throws DaoException
	 * 2011. 2. 8.
	 */
	@SuppressWarnings("unchecked")
	public List selectItemEquip(HashMap paramMap) throws DaoException{
		return  queryForList("Item.selectItemEquip",paramMap);
	}
	
	@SuppressWarnings("unchecked") 
	public int selectItemEquipCount(Map map) throws DaoException{
		return queryForInt("Item.selectItemEquipCount",map); 
	} 
	
}
