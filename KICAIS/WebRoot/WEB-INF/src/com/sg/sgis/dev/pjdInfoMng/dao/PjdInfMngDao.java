package com.sg.sgis.dev.pjdInfoMng.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.sg.sgis.dev.pjdInfoMng.dao.*;
import com.signgate.core.dao.BaseDao;
import com.signgate.core.exception.DaoException;


public class PjdInfMngDao extends BaseDao implements PjdInfoMngImpl{

	protected final Log logger = LogFactory.getLog(getClass());
	
	/**
	 * 개발프로젝트정보 
	 * @param  paramMap
	 * @return List
	 * @throws DaoException
	 * 2011. 2. 8.
	 */
	@SuppressWarnings("unchecked")
	public List selectPjdInfo(HashMap paramMap) throws DaoException{
		return  queryForList("PjdInfo.selectPjdInfo",paramMap);
	}
	
	@SuppressWarnings("unchecked") 
	public int selectPjdInfoCount(Map map) throws DaoException{
		return queryForInt("PjdInfo.selectPjdInfoCount",map); 
	} 
	
	@SuppressWarnings("unchecked")
	public void insertPjdInfo(HashMap map) throws DaoException{
		insert("PjdInfo.insertPjdInfo", map);
	} 
 
	@SuppressWarnings("unchecked")
	public void updatePjdInfo(HashMap map) throws DaoException{
		update("PjdInfo.updatePjdInfo", map);
	} 
	
	@SuppressWarnings("unchecked")
	public void updatePjdInfoYn(HashMap map) throws DaoException{
		update("PjdInfo.updatePjdInfoYn", map);
	} 
	
	
	@SuppressWarnings("unchecked")
	public void deletePjdInfo(HashMap map) throws DaoException{
		update("PjdInfo.deletePjdInfo", map);
	} 
		

	/**
	 * 개발프로젝트관리
	 * @param  paramMap
	 * @return List
	 * @throws DaoException
	 * 2011. 2. 8.
	 */
	@SuppressWarnings("unchecked")
	public List selectPjdDevInfo(HashMap paramMap) throws DaoException{
		return  queryForList("PjdInfo.selectPjdDevInfo",paramMap);
	}
	
	@SuppressWarnings("unchecked") 
	public int selectPjdDevInfoCount(Map map) throws DaoException{
		return queryForInt("PjdInfo.selectPjdDevInfoCount",map); 
	} 
	
	@SuppressWarnings("unchecked")
	public void insertPjdDevInfo(HashMap map) throws DaoException{
		insert("PjdInfo.insertPjdDevInfo", map);
	} 
 
	@SuppressWarnings("unchecked")
	public void updatePjdDevInfo(HashMap map) throws DaoException{
		update("PjdInfo.updatePjdDevInfo", map);
	} 
	
	@SuppressWarnings("unchecked")
	public void deletePjdDevInfo(HashMap map) throws DaoException{
		update("PjdInfo.deletePjdDevInfo", map);
	} 	

	/**
	 * 개발프로젝트 제품 관리 
	 * @param  paramMap
	 * @return List
	 * @throws DaoException
	 * 2011. 2. 8.
	 */	
	@SuppressWarnings("unchecked")
	public List selectPjdDevInfoNitem(HashMap paramMap) throws DaoException{
		return  queryForList("PjdInfo.selectPjdDevInfoNitem",paramMap);
	}
	
	@SuppressWarnings("unchecked") 
	public int selectPjdDevInfoNitemCount(Map map) throws DaoException{
		return queryForInt("PjdInfo.selectPjdDevInfoNitemCount",map); 
	} 
	
	
	
	/**
	 * 개발프로젝트장비
	 * @param  paramMap
	 * @return List
	 * @throws DaoException
	 * 2011. 2. 8.
	 */
	@SuppressWarnings("unchecked")
	public List selectPjdEquipInfo(HashMap paramMap) throws DaoException{
		return  queryForList("PjdInfo.selectPjdEquipInfo",paramMap);
	}
	
	@SuppressWarnings("unchecked") 
	public int selectPjdEquipInfoCount(Map map) throws DaoException{
		return queryForInt("PjdInfo.selectPjdEquipInfoCount",map); 
	} 
	
	@SuppressWarnings("unchecked")
	public void insertPjdEquipInfo(HashMap map) throws DaoException{
		insert("PjdInfo.insertPjdEquipInfo", map);
	} 
 
	@SuppressWarnings("unchecked")
	public void updatePjdEquipInfo(HashMap map) throws DaoException{
		update("PjdInfo.updatePjdEquipInfo", map);
	} 
	
	@SuppressWarnings("unchecked")
	public void deletePjdEquipInfo(HashMap map) throws DaoException{
		update("PjdInfo.deletePjdEquipInfo", map);
	} 	

	/**
	 * 개발프로젝트정보 팝업
	 * @param  paramMap
	 * @return List
	 * @throws DaoException
	 * 2011. 2. 8.
	 */
	@SuppressWarnings("unchecked")
	public List selectPjdInfoPop(HashMap paramMap) throws DaoException{
		return  queryForList("PjdInfo.selectPjdInfoPop",paramMap);
	}
	
	@SuppressWarnings("unchecked") 
	public int selectPjdInfoPopCount(Map map) throws DaoException{
		return queryForInt("PjdInfo.selectPjdInfoPopCount",map); 
	}	

	
	/**
	 * 개발프로젝트정보별 제품 팝업
	 * @param  paramMap
	 * @return List
	 * @throws DaoException
	 * 2011. 2. 8.
	 */	
	@SuppressWarnings("unchecked")
	public List selectPjdInfoNitemPop(HashMap paramMap) throws DaoException{
		return  queryForList("PjdInfo.selectPjdInfoNitemPop",paramMap);
	}
	
	@SuppressWarnings("unchecked") 
	public int selectPjdInfoNitemPopCount(Map map) throws DaoException{
		return queryForInt("PjdInfo.selectPjdInfoNitemPopCount",map); 
	}	
	
	
	/**
	 * 처리완료여부  90-요청처리완료
	 * @param  paramMap
	 * @return List
	 * @throws DaoException
	 * 2011. 2. 8.
	 */		
	@SuppressWarnings("unchecked")
	public void updateCsrPatternItemDealYn(HashMap map) throws DaoException{
		update("PjdInfo.updateCsrPatternItemDealYn", map);
	} 	
	
	/**
	 * 진행상태 history
	 * @param  paramMap
	 * @return List
	 * @throws DaoException
	 * 2011. 2. 8.
	 */		
	@SuppressWarnings("unchecked")
	public void insertPjtHistory(HashMap map) throws DaoException{
		insert("PjdInfo.insertPjtHistory", map);
	} 	
	
}
