package com.sg.sgis.com.item;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
 
import com.sg.sgis.com.item.dao.ItemDaoImpl; 
import com.signgate.core.config.SGConfigManager;
import com.signgate.core.exception.DaoException;
 

public class ItemBiz {
  
	protected final Log logger = LogFactory.getLog(getClass());
	
	// Dao경로 설정
	private ItemDaoImpl itemDao; 
	public void setItemDao(ItemDaoImpl itemDao)
	{
		this.itemDao = itemDao;
	}
	
	/**
	 * 품목정보관리 목록조회
	 * @param  paramMap
	 * @return list
	 * @throws Exception
	 * 2011. 2. 8.
	 */
	@SuppressWarnings("unchecked")
	public List selectItem(HashMap paramMap)throws Exception{
		List list = null;
		
		try{
			list = itemDao.selectItem(paramMap);
		}catch(Exception e){
			logger.error(e, e);
		}
		return list;
	}
	
	/**
	 * 품목정보관리 목록조회 총건수
	 * @param  paramMap
	 * @return int
	 * @throws Exception
	 * 2011. 2. 8.
	 */
	@SuppressWarnings("unchecked")
	public int selectItemCount(HashMap map)throws Exception{
		int cnt = 0;
		try{ 
			cnt = itemDao.selectItemCount(map);			 
		}catch(Exception e){
			logger.error("::"+this.getClass()+"\n<카운트 BIZ 에러>::::\n"+e.toString()); 
			throw new Exception();
		}
		return cnt;
	}
	   

	/**
	 * 품목정보관리 상세조회
	 * @param  paramMap
	 * @return list
	 * @throws DaoException
	 * 2011. 2. 8.
	 */
	@SuppressWarnings("unchecked")
	public HashMap selectItembyPK(HashMap paramMap)throws Exception {
		HashMap result = null;
		
		try{
			result = itemDao.selectItembyPK(paramMap);
			//System.out.println("list selectItembyPK ---> "+result.toString());
			
		}catch(Exception e){
			logger.error(e, e);
		}
		return result;
	}

	/**
	 * 품목정보관리 저장, 수정
	 * @param paramMap
	 * @param request
	 * @return
	 * 2011. 4. 5.
	 */
	@SuppressWarnings("unchecked")
	public boolean saveItem(HashMap paramMap, HttpServletRequest request) {
		
		boolean result = true;
		
		try{
			itemDao.saveItem(paramMap, request);
		}catch(Exception e){
			logger.error(e,e);
			result = false;
		}
		return result;
	}
	
	
	/**
	 * 아이템(장비-제품이 아닌것) 조회(팝업)
	 * @param  paramMap
	 * @return list
	 * @throws Exception
	 * 2011. 2. 8.
	 */
	@SuppressWarnings("unchecked")
	public List selectItemEquip(HashMap paramMap)throws Exception{
		List list = null;
		
		try{
			list = itemDao.selectItemEquip(paramMap);
		}catch(Exception e){
			logger.error(e, e);
		}
		return list;
	}
	
	/**
	 * 아이템(장비-제품이 아닌것) 조회(팝업) 총건수
	 * @param  paramMap
	 * @return int
	 * @throws Exception
	 * 2011. 2. 8.
	 */
	@SuppressWarnings("unchecked")
	public int selectItemEquipCount(HashMap map)throws Exception{
		int cnt = 0;
		try{ 
			cnt = itemDao.selectItemEquipCount(map);			 
		}catch(Exception e){
			logger.error("::"+this.getClass()+"\n<카운트 BIZ 에러>::::\n"+e.toString()); 
			throw new Exception();
		}
		return cnt;
	}
	
}
