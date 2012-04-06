package sg.svc.portal.bass.Main.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import sg.svc.portal.bass.Main.ifac.IMainDao;
import sg.svc.portal.bass.schedule.domain.Schedule;
import sg.svc.portal.bass.schedule.ifac.IScheduleDao;

import com.signgate.core.dao.BaseDao;
import com.signgate.core.exception.DaoException;


public class MainDao extends BaseDao implements IMainDao {

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

	
	@SuppressWarnings("unchecked")
	public List selectNoticeBoard(HashMap map) throws DaoException { 
		return queryForList("Main.selectNoticeBoard", map);
	}
	
	
	
	@SuppressWarnings("unchecked")
	public int getTechsupAppCount(HashMap map) throws DaoException{
		return queryForInt("Main.selectTechsupAppTotCount",map);
	}
	
	@SuppressWarnings("unchecked")
	public List getTechsupApp(HashMap map) throws DaoException{
		return queryForList("Main.getTechsupApp",map);
	}
	@SuppressWarnings("unchecked")
	public int countGetTechsupApp(HashMap map) throws DaoException{
		return queryForInt("Main.getTechsupAppCount",map);
	} 
 
	
	@SuppressWarnings("unchecked")
	public List getTechsupAppIng(HashMap map) throws DaoException{
		return queryForList("Main.getTechsupAppIng",map);
	}
	
	@SuppressWarnings("unchecked")
	public int selectTechsupAppTotCountIng(HashMap map) throws DaoException{
		return queryForInt("Main.selectTechsupAppTotCountIng",map);
	}
	
	
	@SuppressWarnings("unchecked")
	public void insertLoginInfo(HashMap map) throws DaoException {
		insert("Main.insertLoginInfo", map);
		
	}
	
	

}
