package sg.svc.portal.bass.BassCode.ifac;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.signgate.core.exception.DaoException;

 
public interface IBassCodeDao { 
 
	@SuppressWarnings("unchecked")
	public int selectTotCountDe(Map map) throws DaoException;
	
	
	@SuppressWarnings("unchecked")
	public List listDataDe(Map map) throws DaoException; 
	 
	 
	@SuppressWarnings("unchecked")
	public int selectTotCountGr(Map map) throws DaoException;
	
	
	@SuppressWarnings("unchecked") 
	public List listDataGr(Map map) throws DaoException; 
	
	 
	@SuppressWarnings("unchecked")
	public void insertData(HashMap map) throws DaoException;
	
	 
	@SuppressWarnings("unchecked")
	public void updateData(HashMap map) throws DaoException;
	
	 
	@SuppressWarnings("unchecked")
	public void deleteData(Map map) throws DaoException;
	
	 
	@SuppressWarnings("unchecked")
	public HashMap selectData(Map map) throws DaoException;
	
	
	@SuppressWarnings("unchecked")
	public int check(Map map) throws DaoException;
	 
	
}
