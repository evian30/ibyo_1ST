package com.sg.sgis.com.item;

import java.util.HashMap;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
  
import com.sg.sgis.com.item.dao.ItemSWDaoImpl;
import com.signgate.core.exception.BizException; 
 

public class ItemSWBiz {
  
	protected final Log logger = LogFactory.getLog(getClass());
	
	// Dao경로 설정
	private ItemSWDaoImpl itemSWDao; 
	public void setItemSWDao(ItemSWDaoImpl itemSWDao)
	{
		this.itemSWDao = itemSWDao;
	}
	
	 
	@SuppressWarnings("unchecked")
	public List selectItemSW(HashMap paramMap){
		List list = null;
		
		try{
			list = itemSWDao.selectItemSW(paramMap);
			
		}catch(Exception e){
			logger.error(e, e);
		}
		return list;
	}
	
	
	@SuppressWarnings("unchecked")
	public int selectItemSWCount(HashMap map) throws Exception{
		int cnt = 0;
		try{ 
			cnt = itemSWDao.selectItemSWCount(map);			 
		}catch(Exception e){
			logger.error("::"+this.getClass()+"\n<카운트 BIZ 에러>::::\n"+e.toString()); 
			throw new Exception();
		}
		return cnt;
	}  
	
	
	public String actionItemSW(HashMap paramMap)throws BizException {
		String result ="";
		try{

			if(("").equals(paramMap.get("item_code")) 
					&& ("").equals(paramMap.get("item_type_code")) 
					&& ("").equals(paramMap.get("spec_sw_seq"))){
				itemSWDao.insertItemSW(paramMap);						// 저장
			}else{ 
				itemSWDao.updateItemSW(paramMap);						// 수정
			}
			
		}catch(Exception e){
			result = e.toString();
			logger.error("::::::::::"+this.getClass()+e.toString());
			throw new  BizException("\n에러가 발생 하였습니다." + "\n<처리 BIZ 에러>::::\n"+this.getClass()+e.toString());
		}finally{

		} 
			return result;
	}
	
	
	
	
}
