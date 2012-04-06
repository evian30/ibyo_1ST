/**
 *  Class Name  : OrderInfoInquiryBiz.java
 *  Description : 수주정보조회 Biz
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
package com.sg.sgis.ord.order;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.sg.sgis.ord.order.dao.OrderProcessStateManageDaoImpl;

public class OrderProcessStateManageBiz {

	protected final Log logger = LogFactory.getLog(getClass());
	
	// 수주정보조회 Dao경로 설정
	private OrderProcessStateManageDaoImpl orderProcessStateManageDao; 
	public void setOrderProcessStateManageDao(OrderProcessStateManageDaoImpl orderProcessStateManageDao)
	{
		this.orderProcessStateManageDao = orderProcessStateManageDao;
	}
	
	/**
	 * 수주진행상태  수정
	 * @param request	( ORD_INFO 		   : 수주정보관리
	 * 					)
	 * @param  response
	 * @return 
	 * 2011. 4. 22.
	 */
	@SuppressWarnings("unchecked")
	public boolean saveOrderProcessStateManage(HashMap map,
			HttpServletRequest request)throws Exception {
		boolean result = true;
		
		try{
			orderProcessStateManageDao.saveOrderProcessStateManage(map, request);
		}catch(Exception e){
			logger.error(e,e);
			result = false;
		}
		return result;
	}
}
