package sg.svc.portal.bass.BassCode.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import sg.svc.portal.bass.BassCode.ifac.IBassCodeDao;
 

import com.signgate.core.dao.BaseDao;
import com.signgate.core.exception.DaoException; 
import com.signgate.core.web.manage.code.ifac.ICodeDao;

 
public class BassCodeDao extends BaseDao implements IBassCodeDao {
	 
	protected final Log logger = LogFactory.getLog(getClass());
  
	@SuppressWarnings("unchecked")
	public int selectTotCountDe(Map map) throws DaoException{
		return queryForInt("Code.selectTotCountDe",map);
	}
	 
	@SuppressWarnings("unchecked")
	public List listDataDe(Map map) throws DaoException{
		return queryForList("Code.listDataDe", map);
	}	
	
	 
	@SuppressWarnings("unchecked") 
	public int selectTotCountGr(Map map) throws DaoException{
		return queryForInt("Code.selectTotCountGr",map); 
	}
	 
	@SuppressWarnings("unchecked")
	public List listDataGr(Map map) throws DaoException{
		return queryForList("Code.listDataGr", map);
	}	
	
	 
	@SuppressWarnings("unchecked")
	public void insertData(HashMap map) throws DaoException{
		insert("Code.insertData", map);
	} 
 
	@SuppressWarnings("unchecked")
	public void updateData(HashMap map) throws DaoException{
		update("Code.updateData", map);
	} 
	
	@SuppressWarnings("unchecked")
	public void deleteData(Map map) throws DaoException{
		delete("Code.deleteData", map);
	}
	
	@SuppressWarnings("unchecked")
	public HashMap selectData(Map map) throws DaoException{
		return (HashMap)queryForObject("Code.selectData", map);
	} 
	
	@SuppressWarnings("unchecked")
	public int check(Map map) throws DaoException{
		return queryForInt("Code.check", map);
	}
	 
}