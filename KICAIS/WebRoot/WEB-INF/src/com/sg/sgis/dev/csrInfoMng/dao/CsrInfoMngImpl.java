package com.sg.sgis.dev.csrInfoMng.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.signgate.core.exception.DaoException;

public interface CsrInfoMngImpl {
	
	/**
	 * 업무요청정보 목록조회
	 * @param  paramMap
	 * @return List
	 * @throws DaoException
	 * 2011. 2. 8.
	 */
	@SuppressWarnings("unchecked")
	public List selectCsrInfo(HashMap paramMap)throws DaoException;	
	
	@SuppressWarnings("unchecked") 
	public int selectCsrInfoCount(Map map) throws DaoException;
	
	@SuppressWarnings("unchecked")
	public void insertCsrInfo(HashMap map) throws DaoException;
 
	@SuppressWarnings("unchecked")
	public void updateCsrInfo(HashMap map) throws DaoException;	
	
	@SuppressWarnings("unchecked")
	public void deleteCsrInfo(HashMap map) throws DaoException;		
	
	@SuppressWarnings("unchecked")
	public void updateCsrInfoUseYn(HashMap map) throws DaoException;	
	
	
	/**
	 * 업무요청유형_제품 목록조회
	 * @param  paramMap
	 * @return List
	 * @throws DaoException
	 * 2011. 2. 8.
	 */
	@SuppressWarnings("unchecked")
	public List selectCsrPatternItem(HashMap paramMap)throws DaoException;	
	
	@SuppressWarnings("unchecked") 
	public int selectCsrPatternItemCount(Map map) throws DaoException;
	
	@SuppressWarnings("unchecked")
	public void insertCsrPatternItem(HashMap map) throws DaoException;
 
	@SuppressWarnings("unchecked")
	public void updateCsrPatternItem(HashMap map) throws DaoException;	
	
	@SuppressWarnings("unchecked")
	public void deleteCsrPatternItem(HashMap map) throws DaoException;		
	
	
	/**
	 * 업무요청검토 관리조회
	 * @param  paramMap
	 * @return List
	 * @throws DaoException
	 * 2011. 2. 8.
	 */
	@SuppressWarnings("unchecked")
	public List selectCsrReview(HashMap paramMap)throws DaoException;	
	
	@SuppressWarnings("unchecked") 
	public int selectCsrReviewCount(Map map) throws DaoException;
	
	@SuppressWarnings("unchecked")
	public void updateCsrReview(HashMap map) throws DaoException;		
	
	
	/**
	 *프로젝트 제품 목록조회
	 * @param  paramMap
	 * @return List
	 * @throws DaoException
	 * 2011. 2. 8.
	 */
	@SuppressWarnings("unchecked")
	public List selectPjtItem(HashMap paramMap)throws DaoException;		

}
