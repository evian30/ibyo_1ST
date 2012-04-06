package com.sg.sgis.dev.scdInfoMng.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.sg.sgis.dev.scdInfoMng.dao.*;
import com.signgate.core.dao.BaseDao;
import com.signgate.core.exception.DaoException;


public class ScdInfoMngDao extends BaseDao implements ScdInfoMngImpl{

	protected final Log logger = LogFactory.getLog(getClass());
	
	/**
	 * 개발일정계획관리
	 * @param  paramMap
	 * @return List
	 * @throws DaoException
	 * 2011. 2. 8.
	 */

	
	@SuppressWarnings("unchecked")
	public List selectScdPjdInfo(HashMap paramMap) throws DaoException{
		return  queryForList("ScdInfoMng.selectScdPjdInfo",paramMap);
	}
	
	@SuppressWarnings("unchecked") 
	public int selectScdPjdInfoCount(Map map) throws DaoException{
		return queryForInt("ScdInfoMng.selectScdPjdInfoCount",map); 
	} 
	
	
	@SuppressWarnings("unchecked")
	public List selectScdPlanInfo(HashMap paramMap) throws DaoException{
		return  queryForList("ScdInfoMng.selectScdPlanInfo",paramMap);
	}
	
	@SuppressWarnings("unchecked") 
	public int selectScdPlanInfoCount(Map map) throws DaoException{
		return queryForInt("ScdInfoMng.selectScdPlanInfoCount",map); 
	} 
	
	@SuppressWarnings("unchecked") 
	public int selectScdPlanSeq() throws DaoException{
		return queryForInt("ScdInfoMng.selectScdPlanSeq"); 
	} 	
	
	@SuppressWarnings("unchecked")
	public void insertScdPlanInfo(HashMap map) throws DaoException{
		insert("ScdInfoMng.insertScdPlanInfo", map);
	} 
 
	@SuppressWarnings("unchecked")
	public void updateScdPlanInfo(HashMap map) throws DaoException{
		update("ScdInfoMng.updateScdPlanInfo", map);
	} 
	
	@SuppressWarnings("unchecked")
	public void deleteScdPlanInfo(HashMap map) throws DaoException{
		update("ScdInfoMng.deleteScdPlanInfo", map);
	} 	
	
	
	/**
	 * 타스크담당자정보
	 * @param  paramMap
	 * @return List
	 * @throws DaoException
	 * 2011. 2. 8.
	 */
	
	@SuppressWarnings("unchecked")
	public List selectScdDutyAssign(HashMap paramMap) throws DaoException{
		return  queryForList("ScdInfoMng.selectScdDutyAssign",paramMap);
	}
	
	@SuppressWarnings("unchecked") 
	public int selectScdDutyAssignCount(Map map) throws DaoException{
		return queryForInt("ScdInfoMng.selectScdDutyAssignCount",map); 
	} 
	
	
	@SuppressWarnings("unchecked")
	public void insertScdDutyAssign(HashMap map) throws DaoException{
		insert("ScdInfoMng.insertScdDutyAssign", map);
	} 
 
	@SuppressWarnings("unchecked")
	public void updateScdDutyAssign(HashMap map) throws DaoException{
		update("ScdInfoMng.updateScdDutyAssign", map);
	} 
	
	@SuppressWarnings("unchecked")
	public void deleteScdDutyAssign(HashMap map) throws DaoException{
		update("ScdInfoMng.deleteScdDutyAssign", map);
	} 	

	/**
	 * 일정관리(개인별)
	 * @param  paramMap
	 * @return List
	 * @throws DaoException
	 * 2011. 2. 8.
	 */
	
	@SuppressWarnings("unchecked")
	public List selectScdDayTaskInfo(HashMap paramMap) throws DaoException{
		return  queryForList("ScdInfoMng.selectScdDayTaskInfo",paramMap);
	}
	
	@SuppressWarnings("unchecked") 
	public int selectScdDayTaskInfoCount(Map map) throws DaoException{
		return queryForInt("ScdInfoMng.selectScdDayTaskInfoCount",map); 
	} 	
	
	@SuppressWarnings("unchecked")
	public List selectScdDayInfo(HashMap paramMap) throws DaoException{
		return  queryForList("ScdInfoMng.selectScdDayTaskInfo",paramMap);
	}
	
	@SuppressWarnings("unchecked") 
	public int selectScdDayInfoCount(Map map) throws DaoException{
		return queryForInt("ScdInfoMng.selectScdDayTaskInfoCount",map); 
	}	

	@SuppressWarnings("unchecked")
	public void insertScdDayInfo(HashMap map) throws DaoException{
		insert("ScdInfoMng.insertScdDayInfo", map);
	} 
 
	@SuppressWarnings("unchecked")
	public void updateScdDayInfo(HashMap map) throws DaoException{
		update("ScdInfoMng.updateScdDayInfo", map);
	} 
	
	@SuppressWarnings("unchecked")
	public void deleteScdDayInfo(HashMap map) throws DaoException{
		update("ScdInfoMng.deleteScdDayInfo", map);
	} 		
	
	@SuppressWarnings("unchecked") 
	public List selectScdExecPrpdInfo(HashMap map) throws DaoException{
		return queryForList("ScdInfoMng.selectScdExecPrpdInfo",map); 
	}	

	@SuppressWarnings("unchecked")
	public int selectScdExecPrpdInfoCount(Map map) throws DaoException{
		return queryForInt("ScdInfoMng.selectScdExecPrpdInfoCount", map);
	} 
 	
	@SuppressWarnings("unchecked")
	public void insertScdExecPrpdInfo(HashMap map) throws DaoException{
		insert("ScdInfoMng.insertScdExecPrpdInfo", map);
	} 
 
	@SuppressWarnings("unchecked")
	public void updateScdExecPrpdInfo(HashMap map) throws DaoException{
		update("ScdInfoMng.updateScdExecPrpdInfo", map);
	} 
	
	@SuppressWarnings("unchecked")
	public void deleteScdExecPrpdInfo(HashMap map) throws DaoException{
		update("ScdInfoMng.deleteScdExecPrpdInfo", map);
	} 		
	
	/**
	 * 일정별담당자배정에 따라 등록된  일정관리(개인별) 총갯수
	 * @param  paramMap
	 * @return List
	 * @throws DaoException
	 * 2011. 2. 8.
	 */	
	@SuppressWarnings("unchecked")
	public int selectScdDaySeqCount(Map map) throws DaoException{
		return queryForInt("ScdInfoMng.selectScdDaySeqCount",map); 
	}
	
	
	/**
	 * 산출물 조회팝업
	 * @param  paramMap
	 * @return List
	 * @throws DaoException
	 * 2011. 2. 8.
	 */		
	@SuppressWarnings("unchecked") 
	public List selectScdExecPrpdInfoPop(HashMap map) throws DaoException{
		return queryForList("ScdInfoMng.selectScdExecPrpdInfoPop",map); 
	}	

	@SuppressWarnings("unchecked")
	public int selectScdExecPrpdInfoPopCount(Map map) throws DaoException{
		return queryForInt("ScdInfoMng.selectScdExecPrpdInfoPopCount", map);
	} 	
	

	/**
	 * 일정관리에 등록된 타스크수
	 * @param  paramMap
	 * @return List
	 * @throws DaoException
	 * 2011. 2. 8.
	 */		
	@SuppressWarnings("unchecked") 
	public int selectScdDayInfoTaskCnt(HashMap map) throws DaoException{
		return queryForInt("ScdInfoMng.selectScdDayInfoTaskCnt",map); 
	} 	

	/**
	 * 일정관리에 등록된 담당자수
	 * @param  paramMap
	 * @return List
	 * @throws DaoException
	 * 2011. 2. 8.
	 */		
	@SuppressWarnings("unchecked") 
	public int selectScdDayInfoRegEmpCnt(HashMap map) throws DaoException{
		return queryForInt("ScdInfoMng.selectScdDayInfoRegEmpCnt",map); 
	} 
	
	/**
	 * 산출물다운로드
	 * @param  paramMap
	 * @return List
	 * @throws DaoException
	 * 2011. 2. 8.
	 */		
	@SuppressWarnings("unchecked") 
	public Object getDownloadFile(HashMap map) throws DaoException{
		return queryForObject("ScdInfoMng.DownselSupFile", map);
	}	
}
