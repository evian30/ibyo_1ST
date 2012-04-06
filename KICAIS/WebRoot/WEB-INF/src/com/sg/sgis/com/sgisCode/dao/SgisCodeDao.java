package com.sg.sgis.com.sgisCode.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.signgate.core.dao.BaseDao;
import com.signgate.core.exception.DaoException;

public class SgisCodeDao extends BaseDao implements SgisCodeDaoImpl {
	protected final Log logger = LogFactory.getLog(getClass());
	 
	@SuppressWarnings("unchecked") 
	public int selectCodeCount(Map map) throws DaoException{
		return queryForInt("SgisCode.selectCodeCount",map); 
	}
	 
	@SuppressWarnings("unchecked")
	public List selectCode(Map map) throws DaoException{
		return queryForList("SgisCode.selectCode", map);
	}	
		 
	@SuppressWarnings("unchecked")
	public void insertCode(HashMap map) throws DaoException{
		insert("SgisCode.insertCode", map);
	} 
 
	@SuppressWarnings("unchecked")
	public void updateCode(HashMap map) throws DaoException{
		update("SgisCode.updateCode", map);
	} 
	
	@SuppressWarnings("unchecked")
	public void deleteCode(Map map) throws DaoException{
		delete("SgisCode.deleteCode", map);
	}
	
	@SuppressWarnings("unchecked")
	public HashMap selectCodeView(Map map) throws DaoException{
		return (HashMap)queryForObject("SgisCode.selectCodeView", map);
	}
	
	@SuppressWarnings("unchecked")
	public List selectComboCode(String searchCode)throws DaoException{ 
		return  queryForList("SgisCode.selectComboCode",searchCode);
	}
	
	@SuppressWarnings("unchecked")
	public List selectComboCode2(Map map)throws DaoException{ 
		return  queryForList("SgisCode.selectComboCode2",map);
	}
	
	
	
	
}
