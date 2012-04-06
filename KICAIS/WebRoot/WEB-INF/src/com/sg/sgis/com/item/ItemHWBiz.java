package com.sg.sgis.com.item;

import java.util.HashMap;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
  
import com.sg.sgis.com.item.dao.ItemHWDaoImpl;
import com.signgate.core.exception.BizException; 
 

public class ItemHWBiz {
  
	protected final Log logger = LogFactory.getLog(getClass());
	
	// Dao경로 설정
	private ItemHWDaoImpl itemHWDao; 
	public void setItemHWDao(ItemHWDaoImpl itemHWDao)
	{
		this.itemHWDao = itemHWDao;
	}
	
	 
	@SuppressWarnings("unchecked")
	public List selectItemHW(HashMap paramMap){
		List list = null;
		
		try{
			list = itemHWDao.selectItemHW(paramMap);
			
		}catch(Exception e){
			logger.error(e, e);
		}
		return list;
	}
	
	
	@SuppressWarnings("unchecked")
	public int selectItemHWCount(HashMap map) throws Exception{
		int cnt = 0;
		try{ 
			cnt = itemHWDao.selectItemHWCount(map);			 
		}catch(Exception e){
			logger.error("::"+this.getClass()+"\n<카운트 BIZ 에러>::::\n"+e.toString()); 
			throw new Exception();
		}
		return cnt;
	}  
	
	
	public String actionItemHW(HashMap paramMap)throws BizException {
		String result ="";
		try{

			if(!paramMap.get("item_code").equals("") && !paramMap.get("item_type_code").equals("")){
				if(paramMap.get("spec_hw_seq").equals("")){
					itemHWDao.insertItemHW(paramMap);						// 저장
					 
				}else if(!paramMap.get("spec_hw_seq").equals("")){
					itemHWDao.updateItemHW(paramMap);						// 수정
					 
				}
			}
			
		}catch(Exception e){
			//result = e.toString();
			//logger.error("::::::::::"+this.getClass()+e.toString());
			//throw new  BizException("\n에러가 발생 하였습니다." + "\n<처리 BIZ 에러>::::\n"+this.getClass()+e.toString());
		}finally{

		} 
			return result;
	}
	
	
	
	
}
