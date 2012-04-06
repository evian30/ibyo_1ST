package com.sg.sgis.com.sgisCode.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.signgate.core.exception.DaoException;

public interface SgisCodeDaoImpl {	 
	
	@SuppressWarnings("unchecked") 
	public int selectCodeCount(Map map) throws DaoException;
	 
	@SuppressWarnings("unchecked")
	public List selectCode(Map map) throws DaoException;
		 
	@SuppressWarnings("unchecked")
	public void insertCode(HashMap map) throws DaoException;
 
	@SuppressWarnings("unchecked")
	public void updateCode(HashMap map) throws DaoException;
	
	@SuppressWarnings("unchecked")
	public void deleteCode(Map map) throws DaoException;
	
	@SuppressWarnings("unchecked")
	public HashMap selectCodeView(Map map) throws DaoException;

	@SuppressWarnings("unchecked")
	public List selectComboCode(String searchCode)throws DaoException;
	
	@SuppressWarnings("unchecked")
	public List selectComboCode2(Map map)throws DaoException;
}
