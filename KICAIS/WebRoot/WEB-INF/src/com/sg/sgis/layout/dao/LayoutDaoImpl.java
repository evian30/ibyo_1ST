package com.sg.sgis.layout.dao;

import java.util.HashMap;
import java.util.List;

import com.signgate.core.exception.DaoException;

public interface LayoutDaoImpl { 
	
	public List getAllMenuList2(HashMap paramMap)throws DaoException;
	
	public List getAllMenuList2_node(HashMap paramMap)throws DaoException;

	public List getAllMenuList3_node(HashMap paramMap)throws DaoException;
}
 