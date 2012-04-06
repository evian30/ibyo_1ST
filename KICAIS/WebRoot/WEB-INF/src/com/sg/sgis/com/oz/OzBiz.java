package com.sg.sgis.com.oz;
 

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory; 

import com.sg.sgis.com.oz.dao.OzDaoImpl;

public class OzBiz {
	protected final Log logger = LogFactory.getLog(getClass());
	
	OzDaoImpl ozDao;
	public void setOzDao(OzDaoImpl ozDao) {
		this.ozDao = ozDao;
	} 
	
	
	 
	
	
	
}
