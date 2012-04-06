package sg.svc.portal.bass.chman.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import sg.svc.portal.bass.chman.ifac.IChmanDao;

import com.signgate.core.dao.BaseDao;
import com.signgate.core.exception.DaoException; 

 
public class ChmanDao extends BaseDao implements IChmanDao {
	
	protected final Log logger = LogFactory.getLog(getClass());

 	@SuppressWarnings("unchecked")
	public List<Object> getChmanList(HashMap<Object, Object> map) throws DaoException{
		return (List<Object>)queryForList("Chman.selectChmanList", map);
	}
 	
	public HashMap getChmanView(Map map) throws DaoException {
		return (HashMap)queryForObject("Chman.selectChmanView", map);
	}

	public List<Object> getCode(HashMap<Object, Object> map) throws DaoException{
		return (List<Object>)queryForList("Chman.getCode", map);
	}
	
	public String selectChman_no(Map map) throws DaoException{
		return (String)queryForObject("Chman.selectChman_no", map);
	}
	
 	public void insChmanInsert(HashMap map) throws DaoException{
		insert("Chman.insChmanInsert", map);;
	}
	
	public void modChmanUpdate(HashMap map) throws DaoException{
		insert("Chman.modChmanUpdate", map);;
	}
	
	public int selChmanCount(HashMap map) throws DaoException{
		return queryForInt("Chman.selChmanCount", map);
	}
	
	/**
	 * 담당자 정보 delete
	 * @param map
	 * @return
	 * @throws DaoException
	 */
	@SuppressWarnings("unchecked")
	public void deleteChman(Map map) throws DaoException{
		delete("Chman.deleteChman", map);
	}
	
	@SuppressWarnings("unchecked")
	public void delChmanUseDelete(Map map) throws DaoException{
		update("Chman.delChmanUseDelete", map);
	}
	
 	@SuppressWarnings("unchecked")
	public List<Object> selectXmlChmanList(HashMap<Object, Object> map) throws DaoException{
		return (List<Object>)queryForList("Chman.selectXmlChmanList", map);
	}
 	
 	@SuppressWarnings("unchecked")
	public List<Object> selectChmanComListXml(HashMap<Object, Object> map) throws DaoException{
		return (List<Object>)queryForList("Chman.selectChmanComListXml", map);
	}
 		
 	/***********************고객 회사정보 Start*************************************************/
 	/**
	 * 고객 회사 정보 count
	 * @param map
	 * @return
	 * @throws DaoException
	 */
	@SuppressWarnings("unchecked")
	public int selectChmanComTotCount(Map map) throws DaoException{
		return queryForInt("Chman.selectChmanComTotCount",map);
	}
	
	/**
	 * 고객 회사 정보 list
	 * @param map
	 * @return
	 * @throws DaoException
	 */
	@SuppressWarnings("unchecked")
	public List selectChmanComList(Map map) throws DaoException{
		return queryForList("Chman.selectChmanComList", map);
	}
	
	/**
	 * 고객 회사 정보 insert
	 * @param map
	 * @return
	 * @throws DaoException
	 */
	@SuppressWarnings("unchecked")
	public void insertChmanCom(Map map) throws DaoException{
		insert("Chman.insertChmanCom", map);
	}
	

	/**
	 * 고객 회사 정보 update
	 * @param map
	 * @return
	 * @throws DaoException
	 */
	@SuppressWarnings("unchecked")
	public void ChmanComUpdate(Map map) throws DaoException{
		update("Chman.ChmanComUpdate", map);
	}
	
	@SuppressWarnings("unchecked")
	public void ChmanComUseUpdate(Map map) throws DaoException{
		update("Chman.ChmanComUseUpdate", map);
	}
	
	/**
	 * 고객 회사 정보 delete
	 * @param map
	 * @return
	 * @throws DaoException
	 */
	@SuppressWarnings("unchecked")
	public void ChmanComDelete(Map map) throws DaoException{
		delete("Chman.ChmanComDelete", map);
	}
	
	/**
	 * 고객 회사 정보 view
	 * @param map
	 * @return
	 * @throws DaoException
	 */
	@SuppressWarnings("unchecked")
	public HashMap selectChmanComView(Map map) throws DaoException{
		return (HashMap)queryForObject("Chman.selectChmanComView", map);
	}
	
	
	/***********************고객 회사정보 End*************************************************/
	
	@SuppressWarnings("unchecked")
	public void insertADMIN(Map map) throws DaoException{
		insert("Chman.insertADMIN", map);
	}
	
	@SuppressWarnings("unchecked")
	public void updateChmanADMIN(Map map) throws DaoException{
		update("Chman.updateChmanADMIN", map);
	}
	
	
	@SuppressWarnings("unchecked")
	public String selectCorpNo(Map map) throws DaoException{
		return queryForString("Chman.selectCorpNo",map);
	}
	
	@SuppressWarnings("unchecked")
	public List<Object> ssnCheck(HashMap<Object, Object> map) throws DaoException{
		return (List<Object>)queryForList("Chman.ssnCheck", map);
	}
	
	
	@SuppressWarnings("unchecked")
	public List chman_login_his(Map map) throws DaoException{
		return queryForList("Chman.chman_login_his", map);
	}
	
	@SuppressWarnings("unchecked")
	public int chman_login_hisCount(Map map) throws DaoException{
		return queryForInt("Chman.chman_login_hisCount",map);
	}
	
	 
}