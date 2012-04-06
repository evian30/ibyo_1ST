package com.sg.sgis.pur;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.sg.sgis.pur.dao.PurchaseDaoImpl;
import com.sg.sgis.util.GetPKIdUtil;
import com.signgate.core.exception.DaoException;
import com.signgate.core.web.util.WebUtil;

@SuppressWarnings("unchecked")
public class PurchaseBiz {
	protected final Log logger = LogFactory.getLog(getClass());

	PurchaseDaoImpl purDao;
	public void setPurDao(PurchaseDaoImpl purDao) {
		this.purDao = purDao;
	}


	public List selectPurchase(HashMap paramMap) {
		List list = null;

		try{
			list = purDao.selectPurchase(paramMap);
		}catch(Exception e){
			logger.error(e, e);
		}

		return list;
	}


	public int selectPurchaseCount(HashMap paramMap) {
		int result = 0;

		try{
			result = purDao.selectPurchaseCount(paramMap);
		}catch(Exception e){
			logger.error(e, e);
		}

		return result;
	}

	/**
	 * 
	 * @param paramMap 
	 * @return int
	 */
	@SuppressWarnings("unchecked")
	public boolean insertPurchaseInfo(HashMap paramMap) {
		boolean insertResult = false;

		//여기서 ibatis 트렌젝션을 처리하자
		try{
			//구매 ID를 등록할때 자동으로 생성해서 저장한다.
			String pur_id = GetPKIdUtil.getPkId("PUR", "PUR");
			paramMap.put("pur_id", pur_id);
			
			//시간 포멧 바꿔주기
			paramMap.put("pur_date", ((String)paramMap.get("pur_date")).replaceAll("-", ""));
			paramMap.put("in_date", ((String)paramMap.get("in_date")).replaceAll("-", ""));
			paramMap.put("inspect_date", ((String)paramMap.get("inspect_date")).replaceAll("-", ""));
			paramMap.put("use_date", ((String)paramMap.get("use_date")).replaceAll("-", ""));
			
			paramMap.put("pur_total_amt", ((String)paramMap.get("pur_total_amt")).replaceAll(",", ""));
			paramMap.put("pur_total_tax", ((String)paramMap.get("pur_total_tax")).replaceAll(",", ""));

			int purchaseInsertResult = purDao.insertPurchaseInfo(paramMap);

			
			
			//paramMap에서 구매품목 json을 가져와서 처리하고 dao에 넘김
			if((String)paramMap.get("purchaseItem") != null){
				String recvPurchaseItem = (String)paramMap.get("purchaseItem");
				JSONArray jsonArrayPurchaseItem = JSONArray.fromObject(recvPurchaseItem);
				for (int i=0; i < jsonArrayPurchaseItem.size(); i++) {
					JSONObject jsonData = new JSONObject();
					jsonData = jsonArrayPurchaseItem.getJSONObject(i);

					HashMap<String,String> map = new HashMap<String,String>();
					Iterator iter = jsonData.keys();
					while(iter.hasNext()){
						String key = (String)iter.next();
						String value = jsonData.getString(key);
						map.put(key.toLowerCase(),value);
					}
					map.put("pur_id", pur_id);
					int purItemInfoInsertResult = purDao.insertPurItemInfo(map);

				}// End for
			}
			//만약 구매품목 사양정보가 있다면 PUR_SPEC_INFO에 insert
			if((String)paramMap.get("purchaseSpec") != null ){
				//paramMap에서 구매품목 스펙 json을 가져와서 처리하고 dao에 넘김
				String recvPurchaseSpec = (String)paramMap.get("purchaseSpec");
				JSONArray jsonArrayPurchaseItemSpec = JSONArray.fromObject(recvPurchaseSpec);
				for (int i=0; i < jsonArrayPurchaseItemSpec.size(); i++) {
					JSONObject jsonData = new JSONObject();
					jsonData = jsonArrayPurchaseItemSpec.getJSONObject(i);

					HashMap<String,String> map = new HashMap<String,String>();
					Iterator iter = jsonData.keys();
					while(iter.hasNext()){
						String key = (String)iter.next();
						String value = jsonData.getString(key);
						map.put(key.toLowerCase(),value);
					}
					map.put("pur_id", pur_id);
					int purItemSpecInsertResult = purDao.insertPurItemSpec(map);
				}// End for
			}

			insertResult = true;
		}catch(Exception ex){
			logger.error(ex.getMessage());
			ex.printStackTrace();
		}

		return insertResult;
	}


	public List selectPurItem(HashMap paramMap) {
		List list = null;

		try{
			list = purDao.selectPurItem(paramMap);
		}catch(Exception e){
			logger.error(e, e);
		}

		return list;
	}


	public int selectPurItemCount(HashMap paramMap) {
		int result = 0;
		try{
			result = purDao.selectPurItemCount(paramMap);
		}catch(Exception ex){
			logger.error(ex.getMessage());
			ex.printStackTrace();
		}

		return result;
	}


	public List selectPurItemSpec(HashMap paramMap) {
		List list = null;

		try{
			list = purDao.selectPurItemSpec(paramMap);
		}catch(Exception e){
			logger.error(e, e);
		}

		return list;
	}



	public int selectPurItemSpecCount(HashMap paramMap) {
		int result = 0;
		try{
			result = purDao.selectPurItemSpecCount(paramMap);
		}catch(Exception ex){
			logger.error(ex.getMessage());
			ex.printStackTrace();
		}

		return result;
	}


	public boolean updatePurchaseInfo(HashMap paramMap) {
		boolean insertResult = false;

		//여기서 ibatis 트렌젝션을 처리하자
		try{
			//시간 포멧 바꿔주기
			paramMap.put("pur_date", ((String)paramMap.get("pur_date")).replaceAll("-", ""));
			paramMap.put("in_date", ((String)paramMap.get("in_date")).replaceAll("-", ""));
			paramMap.put("inspect_date", ((String)paramMap.get("inspect_date")).replaceAll("-", ""));
			paramMap.put("use_date", ((String)paramMap.get("use_date")).replaceAll("-", ""));
			
			paramMap.put("pur_total_amt", ((String)paramMap.get("pur_total_amt")).replaceAll(",", ""));
			paramMap.put("pur_total_tax", ((String)paramMap.get("pur_total_tax")).replaceAll(",", ""));
			
			paramMap.put("final_mod_id", (String)paramMap.get("reg_id"));

			int purchaseInsertResult = purDao.updatePurchaseInfo(paramMap);

			//paramMap에서 구매품목 json을 가져와서 처리하고 dao에 넘김
			if((String)paramMap.get("purchaseItem") != null){
				String recvPurchaseItem = (String)paramMap.get("purchaseItem");
				JSONArray jsonArrayPurchaseItem = JSONArray.fromObject(recvPurchaseItem);
				for (int i=0; i < jsonArrayPurchaseItem.size(); i++) {
					JSONObject jsonData = new JSONObject();
					jsonData = jsonArrayPurchaseItem.getJSONObject(i);

					HashMap<String,String> map = new HashMap<String,String>();
					Iterator iter = jsonData.keys();
					while(iter.hasNext()){
						String key = (String)iter.next();
						String value = jsonData.getString(key);
						map.put(key.toLowerCase(),value);
					}
					
					int purItemInfoInsertResult = 0;
					if(map.get("flag").equals("I")){
						map.put("reg_id", (String)paramMap.get("reg_id"));
						purItemInfoInsertResult = purDao.insertPurItemInfo(map);
					}else{
						map.put("final_mod_id",(String)paramMap.get("reg_id"));
						purItemInfoInsertResult = purDao.updatePurchaseItem(map);
					}

				}// End for
			}
			//만약 구매품목 사양정보가 있다면 PUR_SPEC_INFO에 insert
			if((String)paramMap.get("purchaseSpec") != null ){
				//paramMap에서 구매품목 스펙 json을 가져와서 처리하고 dao에 넘김
				String recvPurchaseSpec = (String)paramMap.get("purchaseSpec");
				JSONArray jsonArrayPurchaseItemSpec = JSONArray.fromObject(recvPurchaseSpec);
				for (int i=0; i < jsonArrayPurchaseItemSpec.size(); i++) {
					JSONObject jsonData = new JSONObject();
					jsonData = jsonArrayPurchaseItemSpec.getJSONObject(i);

					HashMap<String,String> map = new HashMap<String,String>();
					Iterator iter = jsonData.keys();
					while(iter.hasNext()){
						String key = (String)iter.next();
						String value = jsonData.getString(key);
						map.put(key.toLowerCase(),value);
					}
					int purItemSpecInsertResult = 0;
					if(map.get("flag") != null && map.get("flag").equals("I")){
						map.put("reg_id", (String)paramMap.get("reg_id"));
						purItemSpecInsertResult = purDao.insertPurItemSpec(map);
					}else{
						map.put("final_mod_id", (String)paramMap.get("reg_id"));
						purItemSpecInsertResult = purDao.updatePurchaseSpec(map);
					}
					
				}// End for
			}
			
			//구매 진행상태 변경에 따른 프로젝트 진행상태 업데이트 처리
			//1. pjt_id가 있어야함
			//2. 구매 완료 상태에 있을때만 업데이트
			String pjt_id = WebUtil.nullCheck((String)paramMap.get("pjt_id"), "");
			String proc_status_code = WebUtil.nullCheck((String)paramMap.get("proc_status_code"), "");
			int projectProcCodeUpdateResult = 0;
			int projectHistoryInsertResult = 0;
			if(!pjt_id.equals("")){
				if(proc_status_code.equals("99")){
					paramMap.put("pjt_status_code", "79");
					//프로젝트 업데이트
					projectProcCodeUpdateResult = purDao.updatePjtProcCode(paramMap);
					//프로젝트 히스토리 인서트
					projectHistoryInsertResult = purDao.insertPjtHistory(paramMap);
				}
			}
			

			insertResult = true;
		}catch(Exception ex){
			logger.error(ex.getMessage());
			ex.printStackTrace();
		}
		return insertResult;
	}

	//검수결과 업데이트 처리
	public int updateInspectInfo(HashMap paramMap) {
		try {
			return purDao.updateInspectInfo(paramMap);
		} catch (DaoException ex) {
			logger.error(ex.getMessage());
			return 0;
		}
	}
}
