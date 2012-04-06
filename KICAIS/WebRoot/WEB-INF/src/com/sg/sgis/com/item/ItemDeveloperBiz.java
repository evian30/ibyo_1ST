package com.sg.sgis.com.item;

import java.util.HashMap;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.sg.sgis.com.item.dao.ItemDeveloperDao;
import com.sg.sgis.com.item.dao.ItemDeveloperDaoImpl;

public class ItemDeveloperBiz {

protected final Log logger = LogFactory.getLog(getClass());
	
	// Dao경로 설정
	private ItemDeveloperDaoImpl itemDeveloperDao; 
	public void setItemDeveloperDao(ItemDeveloperDaoImpl itemDeveloperDao)
	{
		this.itemDeveloperDao = itemDeveloperDao;
	}
	
	/**
	 * 품목정보관리(제품개발담당자 정보) 목록조회
	 * @param map( item_type_code : 품목구분
	 * 			   item_code      : 품목코드
	 * 			 )
	 * @return
	 * 2011. 4. 6.
	 */
	public List selectItemDeveloper(HashMap map)throws Exception {
		List list = null;
		
		try{
			list = itemDeveloperDao.selectItemDeveloper(map);
		}catch(Exception e){
			logger.error(e, e);
		}
		return list;
	}
	
	/**
	 * 품목정보관리(제품개발담당자 정보) 목록 총건수
	 * @param map( item_type_code : 품목구분
	 * 			   item_code      : 품목코드
	 * 			 )
	 * @return
	 * 2011. 4. 6.
	 */
	public int selectItemDeveloperCount(HashMap map)throws Exception{
		int cnt = 0;
		try{ 
			cnt = itemDeveloperDao.selectItemDeveloperCount(map);			 
		}catch(Exception e){
			logger.error(e,e);
		}
		return cnt;
	}
}
