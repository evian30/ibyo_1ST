package com.sg.sgis.com.item.dao;

import java.util.HashMap;
import java.util.List;

import com.signgate.core.exception.DaoException;

public interface ItemDeveloperDaoImpl {

	/**
	 * 품목정보관리(제품개발담당자 정보) 목록조회
	 * @param map( item_type_code : 품목구분
	 * 			   item_code      : 품목코드
	 * 			 )
	 * @return
	 * 2011. 4. 6.
	 */
	@SuppressWarnings("unchecked")
	public List selectItemDeveloper(HashMap map)throws DaoException;

	/**
	 * 품목정보관리(제품개발담당자 정보) 목록 총건수
	 * @param map( item_type_code : 품목구분
	 * 			   item_code      : 품목코드
	 * 			 )
	 * @return
	 * 2011. 4. 6.
	 */
	@SuppressWarnings("unchecked")
	public int selectItemDeveloperCount(HashMap map)throws DaoException;

}
