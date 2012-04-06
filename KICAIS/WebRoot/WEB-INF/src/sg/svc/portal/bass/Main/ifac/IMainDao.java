package sg.svc.portal.bass.Main.ifac;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import com.signgate.core.exception.DaoException;
import sg.svc.portal.bass.schedule.domain.Schedule;



public interface IMainDao {	
	
	public void setScheduleInsert(Map map) throws DaoException;
	
	public List getScheduleList(HashMap map) throws DaoException;
	
	public HashMap getScheduleView(HashMap map) throws DaoException;
	  
	public void setScheduleUpdate(HashMap map)throws DaoException; 
	
	public void setScheduleDelete(HashMap map)throws DaoException;
	
	public List getWeekScheduleList(HashMap map) throws DaoException;
	
	public int getScheduleCount(HashMap map) throws DaoException;	
	
	public List selectNoticeBoard(HashMap map) throws DaoException;
	
	
	public int getTechsupAppCount(HashMap map) throws DaoException;	
	
	public List getTechsupApp(HashMap map) throws DaoException;
	public int countGetTechsupApp(HashMap map) throws DaoException; 	
	
	public List getTechsupAppIng(HashMap map) throws DaoException;
	public int selectTechsupAppTotCountIng(HashMap map) throws DaoException;
	
	public void insertLoginInfo(HashMap map)throws DaoException;
	
}
