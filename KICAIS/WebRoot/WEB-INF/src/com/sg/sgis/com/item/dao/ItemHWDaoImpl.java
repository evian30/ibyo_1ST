package com.sg.sgis.com.item.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.signgate.core.exception.DaoException;

public interface ItemHWDaoImpl {

	@SuppressWarnings("unchecked")
	public List selectItemHW(HashMap paramMap) throws DaoException;
	
	@SuppressWarnings("unchecked") 
	public int selectItemHWCount(Map map) throws DaoException;
	
	@SuppressWarnings("unchecked")
	public void insertItemHW(HashMap map) throws DaoException;
 
	@SuppressWarnings("unchecked")
	public void updateItemHW(HashMap map) throws DaoException;
	 

}
