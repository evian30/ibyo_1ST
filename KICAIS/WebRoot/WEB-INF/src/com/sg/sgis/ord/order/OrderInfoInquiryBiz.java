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

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.sg.sgis.ord.order.dao.OrderInfoInquiryDaoImpl;

public class OrderInfoInquiryBiz {

	protected final Log logger = LogFactory.getLog(getClass());
	
	// 수주정보조회 Dao경로 설정
	private OrderInfoInquiryDaoImpl orderInfoInquiryDao; 
	public void setOrderInfoInquiryDao(OrderInfoInquiryDaoImpl orderInfoInquiryDao)
	{
		this.orderInfoInquiryDao = orderInfoInquiryDao;
	}
}
