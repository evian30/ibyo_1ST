package com.sg.sgis.pur.dao;

import java.util.HashMap;
import java.util.List;

import com.signgate.core.exception.DaoException;

public interface PayInfoDaoImpl {

	int insertPayInfo(HashMap paramMap) throws DaoException;
	
	int updatePayInfo(HashMap paramMap) throws DaoException;

	List selectPayInfo(HashMap paramMap) throws DaoException;

	int insertPayEvidInfo(HashMap<String, String> map) throws DaoException;
	
	int updatePayEvidInfo(HashMap<String, String> map) throws DaoException;

	int selectPayInfoCount(HashMap paramMap) throws DaoException;

	List selectPayEvidInfo(HashMap paramMap) throws DaoException;

	

	


}
