package com.sg.sgis.com.sgisCode;

import java.util.HashMap;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import sg.svc.portal.util.NewPageNavigator;

import com.sg.sgis.com.calendar.dao.CalendarDaoImpl;
import com.sg.sgis.com.sgisCode.dao.SgisCodeDaoImpl;
import com.signgate.core.exception.BizException;
import com.signgate.core.exception.DaoException;
import com.signgate.core.web.util.WebUtil;

public class SgisCodeBiz {
	protected final Log logger = LogFactory.getLog(getClass());
	
	SgisCodeDaoImpl sgisCodeDao;
	public void setSgisCodeDao(SgisCodeDaoImpl sgisCodeDao) {
		this.sgisCodeDao = sgisCodeDao;
	} 
	
	
	@SuppressWarnings("unchecked")
	public List selectCode(HashMap paramMap){
		List list = null;
		
		try{  
			
			list = sgisCodeDao.selectCode(paramMap);
			
		}catch(Exception e){
			logger.error("::"+this.getClass()+"\n<sgis코드관리 목록 BIZ 에러>::::\n"+e.toString()); 
		}
		return list;
	}
	
	
	@SuppressWarnings("unchecked")
	public int selectCodeCount(HashMap map) throws Exception{
		int cnt = 0;
		try{ 
			cnt = sgisCodeDao.selectCodeCount(map);			 
		}catch(Exception e){
			logger.error("::"+this.getClass()+"\n<sgis코드관리 카운트 BIZ 에러>::::\n"+e.toString()); 
			throw new Exception();
		}
		return cnt;
	}
	
	
	
	public String actionSgisCode(HashMap paramMap)throws BizException {
		String result ="";
		try{

			if("I".equals(paramMap.get("flag"))){
				sgisCodeDao.insertCode(paramMap);		// 저장
			}else if("R".equals(paramMap.get("flag"))){ 
				sgisCodeDao.updateCode(paramMap);		// 수정
			}
			
		}catch(Exception e){
			result = e.toString();
			logger.error("::::::::::"+this.getClass()+e.toString());
			throw new  BizException("\n에러가 발생 하였습니다." + "\n<sgis코드관리 처리 BIZ 에러>::::\n"+this.getClass()+e.toString());
		}finally{

		} 
			return result;
	}

	
	
	/**
	 * 공통코드 조회
	 * @param  String (공통코드의 group_code) 
	 * @return list	  
	 * @throws DaoException
	 * 2011. 1. 28.
	 */
	 
	@SuppressWarnings("unchecked")
	public List selectComboCode(String searchCode){
		List list = null; 
		
		try{
			list = sgisCodeDao.selectComboCode(searchCode); 
			
		}catch(Exception e){
			e.printStackTrace();
			logger.error(e, e);
		}
		return list;
	}
		
	
	/**
	 * 공통코드 조회
	 * @param  String (공통코드의 group_code) 
	 * @return list	  ('','','')의 형식으로 값을 return
	 * @throws DaoException
	 * 2011. 1. 28.
	 */
	@SuppressWarnings("unchecked")
	public List selectComboCode2(String group_code, String level){
		List list = null;
		
		try{
			
			HashMap paramMap = new HashMap();
			paramMap.put("group_code", group_code);
			paramMap.put("level", level);
			
			list = sgisCodeDao.selectComboCode2(paramMap); 
			
		}catch(Exception e){
			e.printStackTrace();
			logger.error(e, e);
		}
		return list;
	}

	
}
