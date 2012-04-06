package sg.svc.portal.cass.techsup.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import sg.svc.portal.cass.techsup.ifac.ICassTechsupDao;

import com.signgate.core.dao.BaseDao;
import com.signgate.core.exception.DaoException; 

 
public class CassTechsupDao extends BaseDao implements ICassTechsupDao {
	
	protected final Log logger = LogFactory.getLog(getClass()); 
	
	@SuppressWarnings("unchecked")
	public Object getDownloadFile(HashMap map) throws DaoException{
		return queryForObject("CassTechsup.DownselCassFile", map);
	} 
	
	@SuppressWarnings("unchecked")
	public List selCassFile(Map map) throws DaoException{
		return queryForList("CassTechsup.selCassFile", map);
	}
		
	@SuppressWarnings("unchecked")
	public void delCassFile(Map map) throws DaoException{
		delete("CassTechsup.delCassFile", map);
	}
	
	@SuppressWarnings("unchecked")
	public String cassAppNo(Map map) throws DaoException{
		return queryForString("CassTechsup.cassAppNo",map);
	}	
	
	@SuppressWarnings("unchecked")
	public void insertCassStep1(Map map) throws DaoException{
		insert("CassTechsup.insertCassStep1", map);
	}
	
	@SuppressWarnings("unchecked")
	public void insertCassStep2(Map map) throws DaoException{
		insert("CassTechsup.insertCassStep2", map);
	}
	
	@SuppressWarnings("unchecked")
	public void insertCassStep3(Map map) throws DaoException{
		insert("CassTechsup.insertCassStep3", map);
	}
	
	@SuppressWarnings("unchecked")
	public void insertCassStep1_1(Map map) throws DaoException{
		insert("CassTechsup.insertCassStep1_1", map);
	}
	
	@SuppressWarnings("unchecked")
	public void insertCassStep1_2(Map map) throws DaoException{
		insert("CassTechsup.insertCassStep1_2", map);
	}
	
	@SuppressWarnings("unchecked")
	public void insertCassStep1_3(Map map) throws DaoException{
		insert("CassTechsup.insertCassStep1_3", map);
	}	
	
	@SuppressWarnings("unchecked")
	public void updateCassStep1(Map map) throws DaoException{
		update("CassTechsup.updateCassStep1", map);
	}
	
	@SuppressWarnings("unchecked")
	public void deleteCassStep1(Map map) throws DaoException {
		delete("CassTechsup.deleteCassStep1", map); 
	} 
		
	@SuppressWarnings("unchecked")
	public void deleteCassStep2(Map map) throws DaoException{
		delete("CassTechsup.deleteCassStep2", map);
	}
	
	@SuppressWarnings("unchecked")
	public void deleteCassStep3(Map map) throws DaoException{
		delete("CassTechsup.deleteCassStep3", map);
	}	
	
	@SuppressWarnings("unchecked")
	public void insertCassHistory(Map map) throws DaoException{
		insert("CassTechsup.insertCassStep4", map);
	}
	
	@SuppressWarnings("unchecked")
	public void insCassFile(Map map) throws DaoException{
		insert("CassTechsup.insCassFile", map);
	}
	
	@SuppressWarnings("unchecked")
	public HashMap getCassView(Map map) throws DaoException{
		return (HashMap)queryForObject("CassTechsup.getCassView", map);
	}
	
	@SuppressWarnings("unchecked")
	public HashMap getCassViewCate(Map map) throws DaoException{
		return (HashMap)queryForObject("CassTechsup.getCassViewCate", map);
	}
		
	@SuppressWarnings("unchecked")
	public List getCassViewCorp(Map map) throws DaoException{
		return queryForList("CassTechsup.getCassViewCorp",map);
	}
	
	
	@SuppressWarnings("unchecked")
	public List getCassViewHis(Map map) throws DaoException{
		return queryForList("CassTechsup.getCassViewHis",map);
	}
	
 
	@SuppressWarnings("unchecked")
	public List getCassView3(Map map) throws DaoException{
		return queryForList("CassTechsup.getCassView3",map);
	}
	
	@SuppressWarnings("unchecked")
	public List getCassView2(Map map) throws DaoException{
		return queryForList("CassTechsup.getCassView2",map);
	}
	
	@SuppressWarnings("unchecked")
	public List getCassView1(Map map) throws DaoException{
		return queryForList("CassTechsup.getCassView1",map);
	}
	
	
	@SuppressWarnings("unchecked")
	public int getCassCount(Map map) throws DaoException{
		return queryForInt("CassTechsup.getCassCount",map);
	}
	
	@SuppressWarnings("unchecked")
	public List getCassList(Map map) throws DaoException{
		return queryForList("CassTechsup.getCassList",map);
	}
	
	
	
}