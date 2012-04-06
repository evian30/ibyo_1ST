/**
 *  Class Name  : OrderProcessStateManageDaoImpl.java
 *  Description : 수주진행상태관리 Impl
 *  Modification Information
 *
 *  수정일                   수정자               수정내용
 *  -------      --------   ---------------------------
 *  2011. 4. 15. 고기범              최초 생성
 *
 *  @author 고기범
 *  @since 2011. 4. 15.
 *  @version 1.0
 *  @see 
 * 
 *  Copyright (C) 2011 by SG All right reserved.
 */
package com.sg.sgis.ord.order.dao;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

import com.signgate.core.exception.DaoException;

public interface OrderProcessStateManageDaoImpl {

	/**
	 * 수주진행상태 수정
	 * @param request	( ORD_INFO 		   : 수주정보관리
	 * 					)
	 * @param response
	 * @return
	 * @throws Exception
	 * 2011. 4. 22.
	 */
	@SuppressWarnings("unchecked")
	public void saveOrderProcessStateManage(HashMap map, HttpServletRequest request) throws DaoException;

}
