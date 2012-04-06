package com.sg.sgis.com.item.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.signgate.core.exception.DaoException;

public interface ItemDaoImpl {

	/**
	 * 품목정보관리 목록조회
	 * @param  paramMap
	 * @return List
	 * @throws DaoException
	 * 2011. 2. 8.
	 */
	@SuppressWarnings("unchecked")
	public List selectItem(HashMap paramMap)throws DaoException;
	
	
	@SuppressWarnings("unchecked") 
	public int selectItemCount(Map map) throws DaoException;
	
 	
	@SuppressWarnings("unchecked")
	public void insertItem(HashMap map) throws DaoException;
 
	@SuppressWarnings("unchecked")
	public void updateItem(HashMap map) throws DaoException;
	
	
	/**
	 * 품목정보관리 상세조회
	 * @param  paramMap
	 * @return HashMap
	 * @throws DaoException
	 * 2011. 2. 8.
	 */
	@SuppressWarnings("unchecked")
	public HashMap selectItembyPK(HashMap paramMap)throws DaoException;


	/**
	 * 품목정보관리 입력, 수정
	 * @param  paramMap
	 * @return HashMap
	 * @throws DaoException
	 * 2011. 4. 5.
	 */
	@SuppressWarnings("unchecked")
	public void saveItem(HashMap paramMap, HttpServletRequest request)throws DaoException;

	
	/**
	 * 아이템(장비-제품이 아닌것) 조회(팝업) 조회
	 * @param  paramMap
	 * @return List
	 * @throws DaoException
	 * 2011. 2. 8.
	 */
	@SuppressWarnings("unchecked")
	public List selectItemEquip(HashMap paramMap)throws DaoException;
	
	
	@SuppressWarnings("unchecked") 
	public int selectItemEquipCount(Map map) throws DaoException;	
}
