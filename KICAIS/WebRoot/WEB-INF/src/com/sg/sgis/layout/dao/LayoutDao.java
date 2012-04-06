package com.sg.sgis.layout.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.signgate.core.dao.BaseDao;
import com.signgate.core.exception.DaoException;

public class LayoutDao extends BaseDao implements LayoutDaoImpl {
	protected final Log logger = LogFactory.getLog(getClass());
	
	
	public List getAllMenuList2(HashMap map) throws DaoException {
		return getSqlMapClientTemplate().queryForList("SV_MAIN_LAYOUT.selectAllMenu2", map);
	}
	
	public List getAllMenuList2_node(HashMap map) throws DaoException {
		return getSqlMapClientTemplate().queryForList("SV_MAIN_LAYOUT.selectAllMenu2_node", map);
	}
	
	public List getAllMenuList3_node(HashMap map) throws DaoException {
		return getSqlMapClientTemplate().queryForList("SV_MAIN_LAYOUT.selectAllMenu3_node", map);
	}
	
 
}
 