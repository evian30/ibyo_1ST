package com.sg.sgis.pur;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.sg.sgis.pur.dao.PayInfoDaoImpl;
import com.sg.sgis.pur.dao.PurchaseDaoImpl;

public class PayInfoBiz {
	protected final Log logger = LogFactory.getLog(getClass());
	
	PayInfoDaoImpl payDao;
	public void setPayDao(PayInfoDaoImpl payDao) {
		this.payDao = payDao;
	}
	@SuppressWarnings("unchecked")
	public boolean insertPayInfo(HashMap paramMap) {
		boolean insertResult = false;

		try{
			
			//폼 데이터 저장 시작
			//시간 포멧 바꿔주기
			paramMap.put("pay_date", ((String)paramMap.get("pay_date")).replaceAll("-", ""));
			paramMap.put("resol_date", ((String)paramMap.get("resol_date")).replaceAll("-", ""));
			paramMap.put("use_date", ((String)paramMap.get("use_date")).replaceAll("-", ""));
			paramMap.put("enforce_date", ((String)paramMap.get("enforce_date")).replaceAll("-", ""));

			paramMap.put("pay_total_amt", ((String)paramMap.get("pay_total_amt")).replaceAll(",", ""));
			paramMap.put("pay_total_tax", ((String)paramMap.get("pay_total_tax")).replaceAll(",", ""));
			
			int purchaseInsertResult = payDao.insertPayInfo(paramMap);
			//폼 데이터 저장 끝
			
			//에디터 그리드 저장 시작
			//paramMap에서 구매품목 json을 가져와서 처리하고 dao에 넘김
			if((String)paramMap.get("payEvidInfo") != null){
				String recvPayEvidInfo = (String)paramMap.get("payEvidInfo");
				JSONArray jsonArrayPayEvidInfo = JSONArray.fromObject(recvPayEvidInfo);
				for (int i=0; i < jsonArrayPayEvidInfo.size(); i++) {
					JSONObject jsonData = new JSONObject();
					jsonData = jsonArrayPayEvidInfo.getJSONObject(i);

					HashMap<String,String> map = new HashMap<String,String>();
					Iterator iter = jsonData.keys();
					while(iter.hasNext()){
						String key = (String)iter.next();
						String value = jsonData.getString(key);
						map.put(key.toLowerCase(),value);
					}
					
					int purItemInfoInsertResult = 0;
					if(map.get("flag").equals("I")){
						purItemInfoInsertResult = payDao.insertPayEvidInfo(map);
					}else{
						purItemInfoInsertResult = payDao.updatePayEvidInfo(map);
					}
					
					logger.debug("test");

				}// End for
			}
			//에디터 그리드 저장 끝
			insertResult = true;
		}catch(Exception ex){
		}

		return insertResult;
	}
	
	@SuppressWarnings("unchecked")
	public boolean updatePayInfo(HashMap paramMap) {
		boolean insertResult = false;

		try{
			
			//폼 데이터 저장 시작
			//시간 포멧 바꿔주기
			paramMap.put("pay_date", ((String)paramMap.get("pay_date")).replaceAll("-", ""));
			paramMap.put("resol_date", ((String)paramMap.get("resol_date")).replaceAll("-", ""));
			paramMap.put("use_date", ((String)paramMap.get("use_date")).replaceAll("-", ""));
			paramMap.put("enforce_date", ((String)paramMap.get("enforce_date")).replaceAll("-", ""));
			
			paramMap.put("pay_total_amt", ((String)paramMap.get("pay_total_amt")).replaceAll(",", ""));
			paramMap.put("pay_total_tax", ((String)paramMap.get("pay_total_tax")).replaceAll(",", ""));


			int purchaseInsertResult = payDao.updatePayInfo(paramMap);
			//폼 데이터 저장 끝
			
			//에디터 그리드 저장 시작
			//paramMap에서 구매품목 json을 가져와서 처리하고 dao에 넘김
			if((String)paramMap.get("payEvidInfo") != null){
				String recvPayEvidInfo = (String)paramMap.get("payEvidInfo");
				JSONArray jsonArrayPayEvidInfo = JSONArray.fromObject(recvPayEvidInfo);
				for (int i=0; i < jsonArrayPayEvidInfo.size(); i++) {
					JSONObject jsonData = new JSONObject();
					jsonData = jsonArrayPayEvidInfo.getJSONObject(i);

					HashMap<String,String> map = new HashMap<String,String>();
					Iterator iter = jsonData.keys();
					while(iter.hasNext()){
						String key = (String)iter.next();
						String value = jsonData.getString(key);
						map.put(key.toLowerCase(),value);
					}
					
					int purItemInfoInsertResult = 0;
					if(map.get("flag").equals("I")){
						purItemInfoInsertResult = payDao.insertPayEvidInfo(map);
					}else{
						purItemInfoInsertResult = payDao.updatePayEvidInfo(map);
					}
					
					logger.debug("test");

				}// End for
			}
			//에디터 그리드 저장 끝
			insertResult = true;
		}catch(Exception ex){
		}

		return insertResult;
	}
	public List selectPayInfo(HashMap paramMap) {
		List list = null;

		try{
			list = payDao.selectPayInfo(paramMap);
		}catch(Exception e){
			logger.error(e, e);
		}

		return list;
	}
	public int selectPayInfoCount(HashMap paramMap) {
		int result = 0;
		try{
			result = payDao.selectPayInfoCount(paramMap);
		}catch(Exception ex){
			logger.error(ex.getMessage());
			ex.printStackTrace();
		}

		return result;
	}
	public List selectPayEvidInfo(HashMap paramMap) {
		List list = null;

		try{
			list = payDao.selectPayEvidInfo(paramMap);
		}catch(Exception e){
			logger.error(e, e);
		}
		
		return list;
	}
	public int selectPayEvidInfoCount(HashMap paramMap) {
		return 0;
	}
	
}
