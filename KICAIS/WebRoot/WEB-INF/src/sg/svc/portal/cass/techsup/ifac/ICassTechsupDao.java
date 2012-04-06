package sg.svc.portal.cass.techsup.ifac;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.signgate.core.exception.DaoException;

 
public interface ICassTechsupDao {
	 
	@SuppressWarnings("unchecked")
	public Object getDownloadFile(HashMap map) throws DaoException;
	
	@SuppressWarnings("unchecked")
	public List selCassFile(Map map) throws DaoException;
		
	@SuppressWarnings("unchecked")
	public void delCassFile(Map map) throws DaoException;
	
	@SuppressWarnings("unchecked")
	public String cassAppNo(Map map) throws DaoException; 
	
	
	@SuppressWarnings("unchecked")
	public void insertCassStep1(Map map) throws DaoException;
	
	
	@SuppressWarnings("unchecked")
	public void insertCassStep2(Map map) throws DaoException;
	
	
	@SuppressWarnings("unchecked")
	public void insertCassStep3(Map map) throws DaoException;
	
	
	@SuppressWarnings("unchecked")
	public void insertCassStep1_1(Map map) throws DaoException;
	
	
	@SuppressWarnings("unchecked")
	public void insertCassStep1_2(Map map) throws DaoException;
	
	
	@SuppressWarnings("unchecked")
	public void insertCassStep1_3(Map map) throws DaoException;
	
	  
	@SuppressWarnings("unchecked")
	public void updateCassStep1(Map map) throws DaoException;
	
	@SuppressWarnings("unchecked")
	public void deleteCassStep1(Map map) throws DaoException;
	
	
	@SuppressWarnings("unchecked")
	public void deleteCassStep2(Map map) throws DaoException;
	
	
	@SuppressWarnings("unchecked")
	public void deleteCassStep3(Map map) throws DaoException;
	
	
	@SuppressWarnings("unchecked")
	public void insertCassHistory(Map map) throws DaoException;
	
	
	@SuppressWarnings("unchecked")
	public void insCassFile(Map map) throws DaoException;
	
	
	@SuppressWarnings("unchecked")
	public HashMap getCassViewCate(Map map) throws DaoException;
	

	@SuppressWarnings("unchecked")
	public List getCassViewCorp(Map map) throws DaoException;
	

	@SuppressWarnings("unchecked")
	public List getCassViewHis(Map map) throws DaoException;	
	
	@SuppressWarnings("unchecked")
	public List getCassView1(Map map) throws DaoException;
	
	@SuppressWarnings("unchecked")
	public List getCassView2(Map map) throws DaoException;
	
	@SuppressWarnings("unchecked")
	public List getCassView3(Map map) throws DaoException;
	
	
	@SuppressWarnings("unchecked")
	public HashMap getCassView(Map map) throws DaoException; 
	
	@SuppressWarnings("unchecked")
	public int getCassCount(Map map) throws DaoException;
	
	@SuppressWarnings("unchecked")
	public List getCassList(Map map) throws DaoException;

}
