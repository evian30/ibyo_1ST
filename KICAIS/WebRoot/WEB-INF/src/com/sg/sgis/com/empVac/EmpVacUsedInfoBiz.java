package com.sg.sgis.com.empVac;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.sg.sgis.com.empVac.dao.EmpVacUsedInfoDaoImpl;
import com.sg.sgis.util.GetPKIdUtil;
import com.signgate.core.exception.BizException;
import com.signgate.core.exception.DaoException;

public class EmpVacUsedInfoBiz {

	protected final Log logger = LogFactory.getLog(getClass());
	
	// Dao경로 설정
	private EmpVacUsedInfoDaoImpl empVacUsedInfoDao; 



	public EmpVacUsedInfoDaoImpl getEmpVacUsedInfoDao() {
		return empVacUsedInfoDao;
	}


	public void setEmpVacUsedInfoDao(EmpVacUsedInfoDaoImpl empVacUsedInfoDao) {
		this.empVacUsedInfoDao = empVacUsedInfoDao;
	}	
	


	
	/**
	 * 품목정보관리 목록조회
	 * @param  paramMap
	 * @return list
	 * @throws DaoException
	 * 2011. 2. 8.
	 */
	@SuppressWarnings("unchecked")
	public List selectEmpVacUsedList(HashMap paramMap){
		List list = null;
		
		try{
			list = empVacUsedInfoDao.selectEmpVacUsedList(paramMap);
			System.out.println("list selectItem ---> "+list.toString());
			
		}catch(Exception e){
			logger.error(e, e);
		}
		return list;
	}
	
	
	@SuppressWarnings("unchecked")
	public int selectEmpVacUsedCount(HashMap map) throws Exception{
		int cnt = 0;
		try{ 
			cnt = empVacUsedInfoDao.selectEmpVacUsedCount(map);			 
		}catch(Exception e){
			logger.error("::"+this.getClass()+"\n<카운트 BIZ 에러>::::\n"+e.toString()); 
			throw new Exception();
		}
		return cnt;
	}	
	
	/**
	 * 개인별휴가사용관리 저장 
	 */	
	public boolean insertEmpVacUsed(HashMap map) throws BizException {
		boolean retBoolean = false;
		try{
			empVacUsedInfoDao.insertEmpVacUsed(map);
			retBoolean = true;
		}catch(Exception e){
			retBoolean = false;
			logger.error(e, e);
			throw new BizException("");
		}
		
		return retBoolean;
	}	

	/**
	 * 개인별휴가사용관리 수정 
	 */		
	public boolean updateEmpVacUsed(HashMap map) throws BizException {
		boolean retBoolean = false;
		try{
			empVacUsedInfoDao.updateEmpVacUsed(map);
			retBoolean = true;
		}catch(Exception e){
			retBoolean = false;
			logger.error(e, e);
			throw new BizException("");
		}
		
		return retBoolean;
	}
	
	/**
	 * 개인별휴가사용관리 삭제
	 */		
	public boolean deleteEmpVacUsed(HashMap paramMap,HttpServletRequest request) throws BizException {
		boolean retBoolean = false;
		try{
			
			
			String deleteData = (String)request.getParameter("deleteData");	
			
	
			JSONArray jsonArray1 = JSONArray.fromObject(deleteData);
			
			for (int i=0; i < jsonArray1.size(); i++) {
				JSONObject jsonData = jsonArray1.getJSONObject(i);
			
				HashMap<String,String> map = new HashMap<String,String>();
			    Iterator iter = jsonData.keys();
			    while(iter.hasNext()){
			        String key = (String)iter.next();
			        String value = jsonData.getString(key);
			        map.put(key.toLowerCase(),value);
			    }
			    
			    empVacUsedInfoDao.deleteEmpVacUsed(map);			// 삭제
			}				
			
			
			retBoolean = true;
		}catch(Exception e){
			retBoolean = false;
			logger.error(e, e);
			throw new BizException("");
		}
		
		return retBoolean;
	}

	
	/**
	 * 개인별휴가사용관리 저장,수정
	 */		
	public boolean actionEmpVacUsedInfo(HashMap paramMap,HttpServletRequest request)throws BizException {
		boolean result = true;
		try{

			String recvJsonData = (String)request.getParameter("data");
//			System.out.println("Object............"+recvJsonData);

			JSONArray jsonArray1 = JSONArray.fromObject(recvJsonData);
			
			for (int i=0; i < jsonArray1.size(); i++) {
				JSONObject jsonData = jsonArray1.getJSONObject(i);
			
				HashMap<String,String> map = new HashMap<String,String>();
			    Iterator iter = jsonData.keys();
			    while(iter.hasNext()){
			        String key = (String)iter.next();
			        String value = jsonData.getString(key);
			        map.put(key.toLowerCase(),value);
			    }
			    System.out.println("temp-->"+map);
				map.put("final_mod_id", (String)paramMap.get("final_mod_id"));

				if(map.get("flag").equals("I") )
		        {
					map.put("emp_vac_seq", GetPKIdUtil.getPkId("COM", "VAC"));
	        	
					insertEmpVacUsed(map);						// 저장				

				}else {
					updateEmpVacUsed(map);						// 수정
				}
				
			}				
			
		}catch(Exception e){
			//result = e.toString();
			//logger.error("::::::::::"+this.getClass()+e.toString());
			//throw new  BizException("\n에러가 발생 하였습니다." + "\n<처리 BIZ 에러>::::\n"+this.getClass()+e.toString());
			result = false;
		}finally{

		} 
			return result;
	}

	/**
	 * 개인별휴가일수
	 */		
	@SuppressWarnings("unchecked")
	public int selectEmpVacDaysCount(HashMap map) throws Exception{
		int cnt = 0;
		try{ 
			map.put("vac_days_used_from_tmp", (String)map.get("VAC_DAYS_USED_FROM_TMP"));
			map.put("vac_days_used_to_tmp", (String)map.get("VAC_DAYS_USED_TO_TMP"));
			
			cnt = empVacUsedInfoDao.selectEmpVacDaysCount(map);			 
		}catch(Exception e){
			logger.error("::"+this.getClass()+"\n<카운트 BIZ 에러>::::\n"+e.toString()); 
			throw new Exception();
		}
		return cnt;
	}		
	
	/**
	 * 개인별총휴가일수
	 */	
	@SuppressWarnings("unchecked")
	public int selectEmpVacTotCount(HashMap map) throws Exception{
		int cnt = 0;
		try{ 
			
			cnt = empVacUsedInfoDao.selectEmpVacTotCount(map);			 
		}catch(Exception e){
			logger.error("::"+this.getClass()+"\n<카운트 BIZ 에러>::::\n"+e.toString()); 
			throw new Exception();
		}
		return cnt;
	}	
	
}
