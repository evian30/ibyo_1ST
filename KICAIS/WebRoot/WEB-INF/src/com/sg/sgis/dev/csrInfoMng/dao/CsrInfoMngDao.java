package com.sg.sgis.dev.csrInfoMng.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.sg.sgis.dev.csrInfoMng.dao.CsrInfoMngImpl;
import com.signgate.core.dao.BaseDao;
import com.signgate.core.exception.DaoException;

public class CsrInfoMngDao extends BaseDao implements CsrInfoMngImpl{

	protected final Log logger = LogFactory.getLog(getClass());
	
	/**
	 * 업무요청정보관리 목록조회
	 * @param  paramMap
	 * @return List
	 * @throws DaoException
	 * 2011. 2. 8.
	 */
	@SuppressWarnings("unchecked")
	public List selectCsrInfo(HashMap paramMap) throws DaoException{
		return  queryForList("CsrInfo.selectCsrInfo",paramMap);
	}
	
	@SuppressWarnings("unchecked") 
	public int selectCsrInfoCount(Map map) throws DaoException{
		return queryForInt("CsrInfo.selectCsrInfoCount",map); 
	} 
	
	@SuppressWarnings("unchecked")
	public void insertCsrInfo(HashMap map) throws DaoException{
		insert("CsrInfo.insertCsrInfo", map);
	} 
 
	@SuppressWarnings("unchecked")
	public void updateCsrInfo(HashMap map) throws DaoException{
		update("CsrInfo.updateCsrInfo", map);
	} 
	
	@SuppressWarnings("unchecked")
	public void deleteCsrInfo(HashMap map) throws DaoException{
		update("CsrInfo.deleteCsrInfo", map);
	} 
	
	@SuppressWarnings("unchecked")
	public void updateCsrInfoUseYn(HashMap map) throws DaoException{
		update("CsrInfo.updateCsrInfoUseYn", map);
	} 	
	
	/**
	 * 업무요청유형_제품 목록조회
	 * @param  paramMap
	 * @return List
	 * @throws DaoException
	 * 2011. 2. 8.
	 */
	@SuppressWarnings("unchecked")
	public List selectCsrPatternItem(HashMap paramMap) throws DaoException{
		return  queryForList("CsrInfo.selectCsrPatternItem",paramMap);
	}
	
	@SuppressWarnings("unchecked") 
	public int selectCsrPatternItemCount(Map map) throws DaoException{
		return queryForInt("CsrInfo.selectCsrPatternItemCount",map); 
	} 
	
	@SuppressWarnings("unchecked")
	public void insertCsrPatternItem(HashMap map) throws DaoException{
		insert("CsrInfo.insertCsrPatternItem", map);
	} 
 
	@SuppressWarnings("unchecked")
	public void updateCsrPatternItem(HashMap map) throws DaoException{
		update("CsrInfo.updateCsrPatternItem", map);
	} 
	
	@SuppressWarnings("unchecked")
	public void deleteCsrPatternItem(HashMap map) throws DaoException{
		update("CsrInfo.deleteCsrPatternItem", map);
	}	

	
	/**
	 * 업무요청검토 관리조회
	 * @param  paramMap
	 * @return List
	 * @throws DaoException
	 * 2011. 2. 8.
	 */
	@SuppressWarnings("unchecked")
	public List selectCsrReview(HashMap paramMap) throws DaoException{
		return  queryForList("CsrInfo.selectCsrReview",paramMap);
	}
	
	@SuppressWarnings("unchecked") 
	public int selectCsrReviewCount(Map map) throws DaoException{
		return queryForInt("CsrInfo.selectCsrReviewCount",map); 
	} 
	
	@SuppressWarnings("unchecked")
	public void updateCsrReview(HashMap map) throws DaoException{
		update("CsrInfo.updateCsrReview", map);
	}	

	
	/**
	 * 프로젝트 제품 목록조회
	 * @param  paramMap
	 * @return List
	 * @throws DaoException
	 * 2011. 2. 8.
	 */
	@SuppressWarnings("unchecked")
	public List selectPjtItem(HashMap paramMap) throws DaoException{
		return  queryForList("CsrInfo.selectPjtItem",paramMap);
	}
	
}
