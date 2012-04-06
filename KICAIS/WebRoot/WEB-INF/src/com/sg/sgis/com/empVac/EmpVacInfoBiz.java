package com.sg.sgis.com.empVac;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.sg.sgis.com.empVac.dao.EmpVacInfoDaoImpl;
import com.signgate.core.config.SGConfigManager;
import com.signgate.core.exception.BizException;
import com.signgate.core.exception.DaoException;

public class EmpVacInfoBiz {

	protected final Log logger = LogFactory.getLog(getClass());
	
	// Dao경로 설정
	private EmpVacInfoDaoImpl empVacInfoDao; 


	public EmpVacInfoDaoImpl getEmpVacInfoDao() {
		return empVacInfoDao;
	}


	public void setEmpVacInfoDao(EmpVacInfoDaoImpl empVacInfoDao) {
		this.empVacInfoDao = empVacInfoDao;
	}		

	
	/**
	 * 품목정보관리 목록조회
	 * @param  paramMap
	 * @return list
	 * @throws DaoException
	 * 2011. 2. 8.
	 */
	@SuppressWarnings("unchecked")
	public List selectEmpVacList(HashMap paramMap){
		List list = null;
		
		try{
			list = empVacInfoDao.selectEmpVacList(paramMap);
			System.out.println("list selectItem ---> "+list.toString());
			
		}catch(Exception e){
			logger.error(e, e);
		}
		return list;
	}
	

	@SuppressWarnings("unchecked")
	public int selectEmpVacCount(HashMap map) throws Exception{
		int cnt = 0;
		try{ 
			cnt = empVacInfoDao.selectEmpVacCount(map);			 
		}catch(Exception e){
			logger.error("::"+this.getClass()+"[--selectEmpVacCount-->]"+e.toString()); 
			throw new Exception();
		}
		return cnt;
	}	
	

	@SuppressWarnings("unchecked")
	public int selectEmpVacSavedCount(HashMap map) throws Exception{
		int cnt = 0;
		try{ 
			cnt = empVacInfoDao.selectEmpVacSavedCount(map);			 
		}catch(Exception e){
			logger.error("::"+this.getClass()+"[--selectEmpVacSavedCount-->]"+e.toString()); 
			throw new Exception();
		}
		return cnt;
	}	
	
	/**
	 * 개인별휴가정보 등록
	 */		
	public boolean insertEmpVac(HashMap map) throws BizException {
		boolean retBoolean = false;
		try{
			empVacInfoDao.insertEmpVac(map);
			retBoolean = true;
		}catch(Exception e){
			retBoolean = false;
			logger.error(e, e);
			throw new BizException("");
		}
		
		return retBoolean;
	}	

	/**
	 * 개인별휴가정보수정
	 */		
	public boolean updateEmpVac(HashMap map) throws BizException {
		boolean retBoolean = false;
		try{
			empVacInfoDao.updateEmpVac(map);
			retBoolean = true;
		}catch(Exception e){
			retBoolean = false;
			logger.error(e, e);
			throw new BizException("");
		}
		
		return retBoolean;
	}
	
	/**
	 * 개인별휴가정보 삭제
	 */		
	public boolean deleteEmpVac(HashMap map) throws BizException {
		boolean retBoolean = false;
		try{
			empVacInfoDao.deleteEmpVac(map);
			retBoolean = true;
		}catch(Exception e){
			retBoolean = false;
			logger.error(e, e);
			throw new BizException("");
		}
		
		return retBoolean;
	}

	
	/**
	 * 개인별휴가정보 저장,수정
	 */	
	public boolean actionEmpVacInfo(HashMap paramMap,HttpServletRequest request)throws BizException {
		boolean result = true;
		try{

			String recvJsonData = (String)request.getParameter("data");
			System.out.println("actionEmpVacInfo............"+recvJsonData);

			
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
			    System.out.println("temp-00->"+map);

			    
			    deleteEmpVac(map);	//삭제	
			    

				
				ArrayList<HashMap> list = new ArrayList<HashMap>();	
				
				HashMap<String,String> map_01 = new HashMap<String,String>();
				HashMap<String,String> map_02 = new HashMap<String,String>();
				HashMap<String,String> map_03 = new HashMap<String,String>();
				HashMap<String,String> map_04 = new HashMap<String,String>();
				HashMap<String,String> map_05 = new HashMap<String,String>();
				
				if(!map.get("vac_days_01").equals(""))
				{
					
					map_01.put("emp_num", (String)map.get("emp_num"));
					map_01.put("basic_year", (String)map.get("basic_year"));
					map_01.put("vac_type_code", "01");
					map_01.put("vac_days", (String)map.get("vac_days_01"));
					map_01.put("note", (String)map.get("note"));
					
					map_01.put("final_mod_id", (String)paramMap.get("final_mod_id"));	// 로그인 ID
					
					list.add(map_01);	
				}
				if(!map.get("vac_days_02").equals(""))
				{
					
					map_02.put("emp_num", (String)map.get("emp_num"));
					map_02.put("basic_year", (String)map.get("basic_year"));
					map_02.put("vac_type_code", "02");
					map_02.put("vac_days", (String)map.get("vac_days_02"));
					map_02.put("note", (String)map.get("note"));
					
					map_02.put("final_mod_id", (String)paramMap.get("final_mod_id"));	// 로그인 ID
					
					list.add(map_02);	
				}
				if(!map.get("vac_days_03").equals(""))
				{
					
					map_03.put("emp_num", (String)map.get("emp_num"));
					map_03.put("basic_year", (String)map.get("basic_year"));
					map_03.put("vac_type_code", "03");
					map_03.put("vac_days", (String)map.get("vac_days_03"));
					map_03.put("note", (String)map.get("note"));
					
					map_03.put("final_mod_id", (String)paramMap.get("final_mod_id"));	// 로그인 ID
					
					list.add(map_03);	
				}
				if(!map.get("vac_days_04").equals(""))
				{
					
					map_04.put("emp_num", (String)map.get("emp_num"));
					map_04.put("basic_year", (String)map.get("basic_year"));
					map_04.put("vac_type_code", "04");
					map_04.put("vac_days", (String)map.get("vac_days_04"));
					map_04.put("note", (String)map.get("note"));
					
					map_04.put("final_mod_id", (String)paramMap.get("final_mod_id"));	// 로그인 ID
					
					list.add(map_04);	
				}				
				if(!map.get("vac_days_05").equals(""))
				{
					
					map_05.put("emp_num", (String)map.get("emp_num"));
					map_05.put("basic_year", (String)map.get("basic_year"));
					map_05.put("vac_type_code", "05");
					map_05.put("vac_days", (String)map.get("vac_days_05"));
					map_05.put("note", (String)map.get("note"));
					
					map_05.put("final_mod_id", (String)paramMap.get("final_mod_id"));	// 로그인 ID
					
					list.add(map_05);	
				}
				
				 for(int k = 0; k < list.size(); k++){
					 
					 selectEmpVacSavedCount(list.get(k));
					 
					 insertEmpVac(list.get(k));		//저장				
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
	

	
}
