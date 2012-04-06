package com.sg.sgis.com.item.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.signgate.core.exception.DaoException;

public interface ItemSWDaoImpl {

	@SuppressWarnings("unchecked")
	public List selectItemSW(HashMap paramMap) throws DaoException;
	
	@SuppressWarnings("unchecked") 
	public int selectItemSWCount(Map map) throws DaoException;
	
	@SuppressWarnings("unchecked")
	public void insertItemSW(HashMap map) throws DaoException;
 
	@SuppressWarnings("unchecked")
	public void updateItemSW(HashMap map) throws DaoException;
	 

}
