package com.sg.sgis.com.item.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.signgate.core.dao.BaseDao;
import com.signgate.core.exception.DaoException;

public class ItemSWDao extends BaseDao implements ItemSWDaoImpl{

	protected final Log logger = LogFactory.getLog(getClass());
	
	 
	@SuppressWarnings("unchecked")
	public List selectItemSW(HashMap paramMap) throws DaoException{ 
		return  queryForList("ItemSW.selectItemSW",paramMap);
	}
	
	@SuppressWarnings("unchecked") 
	public int selectItemSWCount(Map map) throws DaoException{
		return queryForInt("ItemSW.selectItemSWCount",map); 
	}
	
	@SuppressWarnings("unchecked")
	public void insertItemSW(HashMap map) throws DaoException{
		insert("ItemSW.insertItemSW", map);
	} 
 
	@SuppressWarnings("unchecked")
	public void updateItemSW(HashMap map) throws DaoException{
		update("ItemSW.updateItemSW", map);
	} 
	 
	
}
