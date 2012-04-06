package com.sg.sgis.com.item.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.signgate.core.dao.BaseDao;
import com.signgate.core.exception.DaoException;

public class ItemHWDao extends BaseDao implements ItemHWDaoImpl{

	protected final Log logger = LogFactory.getLog(getClass());
	
	 
	@SuppressWarnings("unchecked")
	public List selectItemHW(HashMap paramMap) throws DaoException{ 
		return  queryForList("ItemHW.selectItemHW",paramMap);
	}
	
	@SuppressWarnings("unchecked") 
	public int selectItemHWCount(Map map) throws DaoException{
		return queryForInt("ItemHW.selectItemHWCount",map); 
	}
	
	@SuppressWarnings("unchecked")
	public void insertItemHW(HashMap map) throws DaoException{
		insert("ItemHW.insertItemHW", map);
	} 
 
	@SuppressWarnings("unchecked")
	public void updateItemHW(HashMap map) throws DaoException{
		update("ItemHW.updateItemHW", map);
	} 
	 
	
}
