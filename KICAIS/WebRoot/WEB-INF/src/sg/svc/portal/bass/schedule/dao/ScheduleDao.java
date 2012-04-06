package sg.svc.portal.bass.schedule.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import sg.svc.portal.bass.schedule.domain.Schedule;
import sg.svc.portal.bass.schedule.ifac.IScheduleDao;

import com.signgate.core.dao.BaseDao;
import com.signgate.core.exception.DaoException;


public class ScheduleDao extends BaseDao implements IScheduleDao {

	@SuppressWarnings("unchecked")
	public void setScheduleInsert(Map map) throws DaoException { 
		insert("Schedule.insertSchedule", map);
	}
	 
	@SuppressWarnings("unchecked")
	public List getScheduleList(HashMap map) throws DaoException{
		return queryForList("Schedule.selectSchedule", map);
		
	}

	@SuppressWarnings("unchecked")  
	public HashMap getScheduleView(HashMap map) throws DaoException {
		return (HashMap)queryForObject("Schedule.selectScheduleView", map);
	}
	

	@SuppressWarnings("unchecked")
	public void setScheduleUpdate(HashMap map) throws DaoException {
		update("Schedule.updateSchedule", map);
		
	}

	@SuppressWarnings("unchecked")
	public void setScheduleDelete(HashMap map) throws DaoException {
		delete("Schedule.deleteSchedule", map);
		
	}

	@SuppressWarnings("unchecked")
	public List getWeekScheduleList(HashMap map) throws DaoException { 
		return queryForList("Schedule.selectWeekSchedule", map);
	}
	
	 
	@SuppressWarnings("unchecked")
	public int getScheduleCount(HashMap map) throws DaoException { 
		return queryForInt("Schedule.selectScheduleCount", map);
	}

	
	
 

}
