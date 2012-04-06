package com.sg.sgis.pur.dao;

import java.util.HashMap;
import java.util.List;

import com.signgate.core.dao.BaseDao;
import com.signgate.core.exception.DaoException;

public class PayInfoDao extends BaseDao implements PayInfoDaoImpl {

	public int insertPayInfo(HashMap paramMap) throws DaoException {
		return update("Purchase.insertPayInfo", paramMap);
	}

	public List selectPayInfo(HashMap paramMap) throws DaoException {
		return queryForList("Purchase.selectPayInfo", paramMap);
	}

	public int insertPayEvidInfo(HashMap<String, String> map) throws DaoException {
		return update("Purchase.insertPayEvidInfo", map);
	}

	public int updatePayEvidInfo(HashMap<String, String> map) throws DaoException {
		return update("Purchase.updatePayEvidInfo", map);
	}

	public int selectPayInfoCount(HashMap paramMap) throws DaoException {
		return queryForInt("Purchase.selectPayInfoCount",paramMap);
	
	}

	public List selectPayEvidInfo(HashMap paramMap) throws DaoException {
		return queryForList("Purchase.selectPayEvidInfo", paramMap);
	}

	public int updatePayInfo(HashMap paramMap) throws DaoException {
		return update("Purchase.updatePayInfo", paramMap);
	}



}
