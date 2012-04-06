package com.sg.sgis.dev.scdInfoMng.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.signgate.core.dao.BaseDao;
import com.signgate.core.exception.DaoException;

public class ScdDayInfoMngDao extends BaseDao implements ScdDayInfoMngImpl {
	protected final Log logger = LogFactory.getLog(getClass());
	 

	@SuppressWarnings("unchecked")
	public List selectComboCode(String searchCode)throws DaoException{ 
		return  queryForList("ScdDayInfoMng.selectComboCode",searchCode);
	}
	 

	public List selectSchedule(HashMap paramMap) throws DaoException {
		return  queryForList("ScdDayInfoMng.selectSchedule",paramMap);
	} 
	
	@SuppressWarnings("unchecked") 
	public int selectScheduleCount(Map map) throws DaoException{
		return queryForInt("ScdDayInfoMng.selectScheduleCount",map); 
	}	
	
	@SuppressWarnings("unchecked")
	public void insertSchedule(HashMap map) throws DaoException{
		insert("ScdDayInfoMng.insertSchedule", map);
	} 
 
	@SuppressWarnings("unchecked")
	public void updateSchedule(HashMap map) throws DaoException{
		update("ScdDayInfoMng.updateSchedule", map);
	} 
	
	@SuppressWarnings("unchecked")
	public void deleteSchedule(Map map) throws DaoException{
		delete("ScdDayInfoMng.deleteSchedule", map);
	}
	
	
	
	@SuppressWarnings("unchecked") 
	public int selectAllScheduleCount(Map map) throws DaoException{
		return queryForInt("ScdDayInfoMng.selectAllScheduleCount",map); 
	}
	 
	@SuppressWarnings("unchecked")
	public List selectAllSchedule(Map map) throws DaoException{
		return queryForList("ScdDayInfoMng.selectAllSchedule", map);
	}	
	
	@SuppressWarnings("unchecked")
	public String getDeptCode(String emp_num) throws DaoException{
		return queryForString("ScdDayInfoMng.getDeptCode", emp_num);
	}
	
	@SuppressWarnings("unchecked")
	public String getDeptNm(String dept_code) throws DaoException{
		return queryForString("ScdDayInfoMng.getDeptNm", dept_code);
	}
	
	
	@SuppressWarnings("unchecked")
	public void updateScheduleTaskChkResCode(HashMap map) throws DaoException{
		update("ScdDayInfoMng.updateScheduleTaskChkResCode", map);
	} 
	
	@SuppressWarnings("unchecked")
	public List selectScheduleReview(HashMap map) throws DaoException{
		return queryForList("ScdDayInfoMng.selectScheduleReview", map);
	}	
	
	@SuppressWarnings("unchecked") 
	public int selectScheduleReviewCount(Map map) throws DaoException{
		return queryForInt("ScdDayInfoMng.selectScheduleReviewCount",map); 
	}
	
	@SuppressWarnings("unchecked") 
	public int selectScdTotTaskCount(Map map) throws DaoException{
		return queryForInt("ScdDayInfoMng.selectScdTotTaskCount",map); 
	}
	
	@SuppressWarnings("unchecked") 
	public int selectScdDaySeqCount(Map map) throws DaoException{
		return queryForInt("ScdDayInfoMng.selectScdDaySeqCount",map); 
	}	
	
	
	@SuppressWarnings("unchecked")
	public void updatePjtInfoStatus(HashMap map) throws DaoException{
		update("ScdDayInfoMng.updatePjtInfoStatus", map);
	} 	
	
	@SuppressWarnings("unchecked") 
	public int selectTaskEndYnCount(Map map) throws DaoException{
		return queryForInt("ScdDayInfoMng.selectTaskEndYnCount",map); 
	}	
	
	@SuppressWarnings("unchecked")
	public void updateCsrPatternItemDealYn(HashMap map) throws DaoException{
		update("ScdDayInfoMng.updateCsrPatternItemDealYn", map);
	} 	
	
	@SuppressWarnings("unchecked") 
	public int selectScdDayInfoSeq() throws DaoException{
		return queryForInt("ScdDayInfoMng.selectScdDayInfoSeq"); 
	}
	
}
