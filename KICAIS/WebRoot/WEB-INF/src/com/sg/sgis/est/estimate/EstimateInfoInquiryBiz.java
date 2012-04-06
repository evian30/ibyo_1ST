package com.sg.sgis.est.estimate;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.sg.sgis.est.estimate.dao.EstimateInfoInquiryDaoImpl;
import com.sg.sgis.est.estimate.dao.EstimateInfoManageDaoImpl;
import com.sg.sgis.est.estimate.dao.EstimateProcessStateManageDaoImpl;

public class EstimateInfoInquiryBiz {

	protected final Log logger = LogFactory.getLog(getClass());
	
	// 견적정보조회 Dao경로 설정
	private EstimateInfoInquiryDaoImpl estimateInfoInquiryDao; 
	public void setEstimateInfoInquiryDao(EstimateInfoInquiryDaoImpl estimateInfoInquiryDao)
	{
		this.estimateInfoInquiryDao = estimateInfoInquiryDao;
	}
	
}
