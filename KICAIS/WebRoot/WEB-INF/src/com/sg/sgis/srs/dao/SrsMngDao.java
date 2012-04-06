package com.sg.sgis.srs.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.sg.sgis.srs.dao.SrsMngImpl;
import com.signgate.core.dao.BaseDao;
import com.signgate.core.exception.DaoException;

public class SrsMngDao extends BaseDao implements SrsMngImpl{

	protected final Log logger = LogFactory.getLog(getClass());
	
	/**
	 * 기술지원요청정보관리 목록조회
	 * @param  paramMap
	 * @return List
	 * @throws DaoException
	 * 2011. 2. 8.
	 */
	@SuppressWarnings("unchecked")
	public List selectSrsInfo(HashMap paramMap) throws DaoException{
		return  queryForList("SrsMng.selectSrsInfo",paramMap);
	}
	
	@SuppressWarnings("unchecked") 
	public int selectSrsInfoCount(Map map) throws DaoException{
		return queryForInt("SrsMng.selectSrsInfoCount",map); 
	} 
	
	@SuppressWarnings("unchecked")
	public void insertSrsInfo(HashMap map) throws DaoException{
		insert("SrsMng.insertSrsInfo", map);
	} 
 
	@SuppressWarnings("unchecked")
	public void updateSrsReqEmp(HashMap map) throws DaoException{
		update("SrsMng.updateSrsReqEmp", map);
	} 
	
	
	@SuppressWarnings("unchecked")
	public void updateSrsMgr1(HashMap map) throws DaoException{
		update("SrsMng.updateSrsMgr1", map);
	} 
	
	@SuppressWarnings("unchecked")
	public void updateSrsMgr2(HashMap map) throws DaoException{
		update("SrsMng.updateSrsMgr2", map);
	} 
	
	@SuppressWarnings("unchecked")
	public void updateSupEmp1(HashMap map) throws DaoException{
		update("SrsMng.updateSupEmp1", map);
	} 
	
	@SuppressWarnings("unchecked")
	public void updateSupEmp2(HashMap map) throws DaoException{
		update("SrsMng.updateSupEmp2", map);
	} 
	
	@SuppressWarnings("unchecked")
	public void deleteSrsInfo(HashMap map) throws DaoException{
		update("SrsMng.deleteSrsInfo", map);
	} 
	

	
	
	/**
	 * 기술지원요청검토 관리조회
	 * @param  paramMap
	 * @return List
	 * @throws DaoException
	 * 2011. 2. 8.
	 */
	@SuppressWarnings("unchecked")
	public List selectSrsReview(HashMap paramMap) throws DaoException{
		return  queryForList("SrsMng.selectSrsReview",paramMap);
	}
	
	@SuppressWarnings("unchecked") 
	public int selectSrsReviewCount(Map map) throws DaoException{
		return queryForInt("SrsMng.selectSrsReviewCount",map); 
	} 
	
	
	/**
	 * 2차 기술지원부서
	 * @param  paramMap
	 * @return List
	 * @throws DaoException
	 * 2011. 2. 8.
	 */
	@SuppressWarnings("unchecked")
	public List selectSrsMgrDept2() throws DaoException{
		return  queryForList("SrsMng.selectSrsMgrDept2");
	}	
	

	/**
	 * 팀장조회
	 * @param  paramMap
	 * @return List
	 * @throws DaoException
	 * 2011. 2. 8.
	 */
	@SuppressWarnings("unchecked")
	public List selectTeamLeader(HashMap paramMap) throws DaoException{
		return  queryForList("SrsMng.selectTeamLeader",paramMap);
	}		
}
