package com.sg.sgis.pur.dao;

import java.util.HashMap;
import java.util.List;

import com.signgate.core.exception.DaoException;

public interface PurchaseDaoImpl {

	int selectPurchaseCount(HashMap paramMap) throws DaoException;

	List selectPurchase(HashMap paramMap) throws DaoException;

	int insertPurchaseInfo(HashMap paramMap) throws DaoException;

	int insertPurItemInfo(HashMap paramMap) throws DaoException;

	List selectPurItem(HashMap paramMap) throws DaoException;

	int selectPurItemCount(HashMap paramMap) throws DaoException;

	List selectPurItemSpec(HashMap paramMap) throws DaoException;

	int selectPurItemSpecCount(HashMap paramMap) throws DaoException;

	int insertPurItemSpec(HashMap<String, String> map) throws DaoException;

	int updatePurchaseInfo(HashMap<String, String> map) throws DaoException;

	int updatePurchaseItem(HashMap<String, String> map) throws DaoException;

	int updatePurchaseSpec(HashMap<String, String> map) throws DaoException;

	int updateInspectInfo(HashMap paramMap) throws DaoException;

	int updatePjtProcCode(HashMap paramMap) throws DaoException;

	int insertPjtHistory(HashMap paramMap) throws DaoException;

}
