package com.sg.sgis.srs;

import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.sg.sgis.dev.pjdInfoMng.dao.PjdInfoMngImpl;
import com.sg.sgis.srs.dao.SrsMngImpl;
import com.sg.sgis.util.GetPKIdUtil;
import com.signgate.core.exception.BizException;
import com.signgate.core.exception.DaoException;


public class SrsMngBiz {

	protected final Log logger = LogFactory.getLog(getClass());
	
	// Dao경로 설정
	private SrsMngImpl srsMngDao;


	public SrsMngImpl getSrsMngDao() {
		return srsMngDao;
	}


	public void setSrsMngDao(SrsMngImpl srsMngDao) {
		this.srsMngDao = srsMngDao;
	}

	
	private PjdInfoMngImpl pjdInfMngDao;

	public PjdInfoMngImpl getPjdInfMngDao() {
		return pjdInfMngDao;
	}

	public void setPjdInfMngDao(PjdInfoMngImpl pjdInfMngDao) {
		this.pjdInfMngDao = pjdInfMngDao;
	}



	/**
	 * 기술지원요청정보관리 목록조회
	 * @param  paramMap
	 * @return list
	 * @throws DaoException
	 * 2011. 2. 8.
	 */
	@SuppressWarnings("unchecked")
	public List selectSrsInfo(HashMap paramMap){
		List list = null;
		
		try{
			list = srsMngDao.selectSrsInfo(paramMap);
			
		}catch(Exception e){
			logger.error(e, e);
		}
		return list;
	}
	
	
	@SuppressWarnings("unchecked")
	public int selectSrsInfoCount(HashMap map) throws Exception{
		int cnt = 0;
		try{ 
			cnt = srsMngDao.selectSrsInfoCount(map);			 
		}catch(Exception e){
			logger.error("::"+this.getClass()+"[--selectSrsInfoCount-->]"+e.toString()); 
			throw new Exception();
		}
		return cnt;
	}	
	
	/**
	 * 기술지원요청정보 등록 
	 */	
	public boolean insertSrsInfo(HashMap map) throws BizException {
		boolean retBoolean = false;
		try{
			srsMngDao.insertSrsInfo(map);
			retBoolean = true;
		}catch(Exception e){
			retBoolean = false;
			logger.error(e, e);
			throw new BizException("");
		}
		
		return retBoolean;
	}	

	/**
	 * 기술지원요청정보 의뢰자 수정
	 */	
	public boolean updateSrsReqEmp(HashMap map) throws BizException {
		boolean retBoolean = false;
		try{
			srsMngDao.updateSrsReqEmp(map);
			retBoolean = true;
		}catch(Exception e){
			retBoolean = false;
			logger.error(e, e);
			throw new BizException("");
		}
		
		return retBoolean;
	}
	
	/**
	 * 기술지원요청정보 1차 승인자 수정
	 */	
	public boolean updateSrsMgr1(HashMap map) throws BizException {
		boolean retBoolean = false;
		try{
			srsMngDao.updateSrsMgr1(map);
			retBoolean = true;
		}catch(Exception e){
			retBoolean = false;
			logger.error(e, e);
			throw new BizException("");
		}
		
		return retBoolean;
	}
	
	/**
	 * 기술지원요청정보  2차 승인자 수정
	 */	
	public boolean updateSrsMgr2(HashMap map) throws BizException {
		boolean retBoolean = false;
		try{
			srsMngDao.updateSrsMgr2(map);
			retBoolean = true;
		}catch(Exception e){
			retBoolean = false;
			logger.error(e, e);
			throw new BizException("");
		}
		
		return retBoolean;
	}
	
	/**
	 * 기술지원요청정보 1차 지원담당자  수정
	 */	
	public boolean updateSupEmp1(HashMap map) throws BizException {
		boolean retBoolean = false;
		try{
			srsMngDao.updateSupEmp1(map);
			retBoolean = true;
		}catch(Exception e){
			retBoolean = false;
			logger.error(e, e);
			throw new BizException("");
		}
		
		return retBoolean;
	}
	
	/**
	 * 기술지원요청정보 2차 지원담당자 수정
	 */	
	public boolean updateSupEmp2(HashMap map) throws BizException {
		boolean retBoolean = false;
		try{
			srsMngDao.updateSupEmp2(map);
			retBoolean = true;
		}catch(Exception e){
			retBoolean = false;
			logger.error(e, e);
			throw new BizException("");
		}
		
		return retBoolean;
	}	
	
	
	/**
	 * 기술지원요청정보  삭제
	 */	
	public boolean deleteSrsInfo(HashMap map) throws BizException {
		boolean retBoolean = false;
		try{
			srsMngDao.deleteSrsInfo(map);
			retBoolean = true;
		}catch(Exception e){
			retBoolean = false;
			logger.error(e, e);
			throw new BizException("");
		}
		
		return retBoolean;
	}

	


	
	
	/**
	 * 업무요청 저장,수정
	 */
	public boolean actionSrsInfoMng(HashMap paramMap,HttpServletRequest request, List ListSrsStatus)throws Exception{
		
		boolean result = true;
		
		try{

			String new_csr_id = "";
			
			paramMap.put("final_mod_id", (String)paramMap.get("final_mod_id"));
			
			
	
			String flag_detailForm = nullToBlank((String)paramMap.get("flag_detailForm")); //저장,수정구분
			String srs_status = nullToBlank((String)paramMap.get("srs_status"));
			
			String src_srs_emp_gubun = nullToBlank((String)paramMap.get("src_srs_emp_gubun")); 
			
			if(flag_detailForm.equals(""))
			{
					new_csr_id = GetPKIdUtil.getPkId("DEV", "SRS");
					paramMap.put("csr_id", new_csr_id);
					insertSrsInfo(paramMap);			// 저장 
			}else	
			{
				new_csr_id = (String)paramMap.get("csr_id");
				paramMap.put("csr_id", new_csr_id);
				
				if(src_srs_emp_gubun.equals("AA"))		//의뢰자
				{
					updateSrsReqEmp(paramMap);			
				}else if(src_srs_emp_gubun.equals("BB")){		//1차팀장
					
					if(srs_status.equals("20"))						//지원승인
					{
						paramMap.put("srs_agr_date", getToday());	//의뢰승인일
					}
					
					if(srs_status.equals("50"))					//팀장확인완료
					{
						paramMap.put("terminate_date", getToday());	//완료일
					}
					updateSrsMgr1(paramMap);			
				}else if(src_srs_emp_gubun.equals("CC")){		//1차팀원
					updateSupEmp1(paramMap);			
				}else if(src_srs_emp_gubun.equals("DD")){		//2차팀장
					
					if(srs_status.equals("20"))						//지원승인
					{
						paramMap.put("srs_agr_date", getToday());	//의뢰승인일
					}
					
					if(srs_status.equals("50"))						//팀장확인완료
					{
						paramMap.put("terminate_date", getToday());	//완료일
					}
					updateSrsMgr2(paramMap);			
				}else if(src_srs_emp_gubun.equals("EE")){		//2차팀원
					updateSupEmp2(paramMap);			
				}else if(src_srs_emp_gubun.equals("ZZ")){		//대표이사,임원
					updateSrsReqEmp(paramMap);			
				}
			}
	
			//진행상태 history
			HashMap historyMap = new HashMap();
			Map listStamapData = null;
			historyMap.put("pjt_id", (String)paramMap.get("pjt_id"));
			for(int zz = 0; zz < ListSrsStatus.size(); zz++)
			{
				listStamapData = (Map)ListSrsStatus.get(zz);	
				if(((String)listStamapData.get("COM_CODE")).equals((String)paramMap.get("srs_status")))
				{
					historyMap.put("pjt_proc_name", (String)listStamapData.get("COM_CODE_NAME") );
				}
			}
			
			historyMap.put("his_comment", "기술지원요청["+new_csr_id+"]");
			historyMap.put("pjt_status_code", (String)paramMap.get("srs_status"));
			historyMap.put("final_mod_id", (String)paramMap.get("final_mod_id"));
			
			if(!((String)paramMap.get("saved_srs_status")).equals((String)paramMap.get("srs_status")))
			{
				pjdInfMngDao.insertPjtHistory(historyMap);
			}
			
		}catch(Exception e){
			logger.error(e,e);
			result = false;
		}
		return result;
	}	
	

	
	
	/**
	 * 기술지원요청검토 관리조회
	 * @param  paramMap
	 * @return list
	 * @throws DaoException
	 * 2011. 2. 8.
	 */	
	
	@SuppressWarnings("unchecked")
	public List selectSrsReview(HashMap paramMap){
		List list = null;
		
		try{
			list = srsMngDao.selectSrsReview(paramMap);
			
		}catch(Exception e){
			logger.error(e, e);
		}
		return list;
	}	
	
	@SuppressWarnings("unchecked")
	public int selectSrsReviewCount(HashMap map) throws Exception{
		int cnt = 0;
		try{ 
			cnt = srsMngDao.selectSrsReviewCount(map);			 
		}catch(Exception e){
			logger.error("::"+this.getClass()+"[--selectSrsReviewCount-->]"+e.toString()); 
			throw new Exception();
		}
		return cnt;
	}


	/**
	 * 2차 기술지원부서
	 * @param  paramMap
	 * @return list
	 * @throws DaoException
	 * 2011. 2. 8.
	 */
	@SuppressWarnings("unchecked")
	public List selectSrsMgrDept2(){
		List list = null;
		
		try{
			list = srsMngDao.selectSrsMgrDept2();
			
		}catch(Exception e){
			logger.error(e, e);
		}
		return list;
	}	

	
	/**
	 * 팀장조회
	 * @param  paramMap
	 * @return list
	 * @throws DaoException
	 * 2011. 2. 8.
	 */
	@SuppressWarnings("unchecked")
	public List selectTeamLeader(HashMap paramMap){
		List list = null;
		
		try{
			list = srsMngDao.selectTeamLeader(paramMap);
			
		}catch(Exception e){
			logger.error(e, e);
		}
		return list;
	}	
	
	
	//오늘날짜
	public String getToday()
	{
		return getDateTime().substring(0, 8);
	}	
	
	
	public String getDateTime()
	{
		Calendar cal = Calendar.getInstance();

		StringBuffer sb = new StringBuffer();
	        int [] getDate = new int[6];

	        getDate[0] = cal.get(Calendar.YEAR);
	        getDate[1] = cal.get(Calendar.MONTH) + 1;
	        getDate[2] = cal.get(Calendar.DAY_OF_MONTH);
	        getDate[3] = cal.get(Calendar.HOUR_OF_DAY);
	        getDate[4] = cal.get(Calendar.MINUTE);
	        getDate[5] = cal.get(Calendar.SECOND);
	
		sb.append(Integer.toString(getDate[0]));
	        for(int i=1;i<=5;i++) {
			sb.append(addZero(Integer.toString(getDate[i]), 2));
		}
		
		return sb.toString();
	}	
	
	public String addZero(String data, int len) {
		int mlen = len - data.length();
		StringBuffer sb = new StringBuffer();
		for(int i=0;i<mlen;i++) sb.append("0");
		sb.append(data);
		return sb.toString();
	}	
	
	public String nullToBlank(String str)	{
		if(str == null) {
			return "";
		}else{
			return str;
		}
	}	
}