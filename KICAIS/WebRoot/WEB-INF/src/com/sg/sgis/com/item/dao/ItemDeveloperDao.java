package com.sg.sgis.com.item.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.signgate.core.dao.BaseDao;
import com.signgate.core.exception.DaoException;

public class ItemDeveloperDao extends BaseDao implements ItemDeveloperDaoImpl{

	protected final Log logger = LogFactory.getLog(getClass());

	/**
	 * 품목정보관리(제품개발담당자 정보) 목록조회
	 * @param map( item_type_code : 품목구분
	 * 			   item_code      : 품목코드
	 * 			 )
	 * @return
	 * 2011. 4. 6.
	 */
	public List selectItemDeveloper(HashMap map)throws DaoException{
		return queryForList("ItemDeveloper.selectItemDeveloper",map);
	}

	/**
	 * 품목정보관리(제품개발담당자 정보) 목록 총건수
	 * @param map( item_type_code : 품목구분
	 * 			   item_code      : 품목코드
	 * 			 )
	 * @return
	 * 2011. 4. 6.
	 */
	public int selectItemDeveloperCount(HashMap map)throws DaoException{
		return queryForInt("ItemDeveloper.selectItemDeveloperCount",map); 
	}
}
