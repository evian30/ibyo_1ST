/**
 *  Class Name  : OrderInfoInquiryDao.java
 *  Description : 수주정보 조회 Dao
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

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.signgate.core.dao.BaseDao;

public class OrderInfoInquiryDao extends BaseDao implements OrderInfoInquiryDaoImpl{

	protected final Log logger = LogFactory.getLog(getClass());
}
