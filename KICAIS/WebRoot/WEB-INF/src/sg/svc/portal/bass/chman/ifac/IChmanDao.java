package sg.svc.portal.bass.chman.ifac;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.signgate.core.exception.DaoException;
 
public interface IChmanDao {
	 
	@SuppressWarnings("unchecked") 
	public List<Object>getChmanList(HashMap<Object, Object> map) throws DaoException;

	@SuppressWarnings("unchecked") 
	public HashMap getChmanView(Map map) throws DaoException;

	public List<Object>getCode(HashMap<Object, Object> map) throws DaoException;

	public String selectChman_no(Map map) throws DaoException;
	
	public void insChmanInsert(HashMap map) throws DaoException;
	
	public void modChmanUpdate(HashMap map) throws DaoException;
	
	public int selChmanCount(HashMap map) throws DaoException;
	
	public List<Object>selectXmlChmanList(HashMap<Object, Object> map) throws DaoException;
	
	public List<Object>selectChmanComListXml(HashMap<Object, Object> map) throws DaoException;
	
	public void deleteChman(Map map) throws DaoException;
	
	public void delChmanUseDelete(Map map) throws DaoException;
	
	
	/***********************고객 회사정보 Start*************************************************/
	/**
	 * 고객 회사 정보 count
	 * @param map
	 * @return
	 * @throws DaoException
	 */
	@SuppressWarnings("unchecked")
	public List selectChmanComList(Map map) throws DaoException;
	
	
	/**
	 * 고객 회사 정보 count
	 * @param map
	 * @return
	 * @throws DaoException
	 */
	@SuppressWarnings("unchecked")
	public int selectChmanComTotCount(Map map) throws DaoException;
	
	/**
	 * 고객 회사 정보 insert
	 * @param map
	 * @return
	 * @throws DaoException
	 */	
	@SuppressWarnings("unchecked")
	public void insertChmanCom(Map map) throws DaoException;
	
	/**
	 * 고객 회사 정보 update
	 * @param map
	 * @return
	 * @throws DaoException
	 */
	@SuppressWarnings("unchecked")
	public void ChmanComUpdate(Map map) throws DaoException;
	
	@SuppressWarnings("unchecked")
	public void ChmanComUseUpdate(Map map) throws DaoException;
	
	/**
	 * 고객 회사 정보 delete
	 * @param map
	 * @return
	 * @throws DaoException
	 */
	@SuppressWarnings("unchecked")
	public void ChmanComDelete(Map map) throws DaoException;
	
	/**
	 * 고객 회사 정보 view
	 * @param map
	 * @return
	 * @throws DaoException
	 */
	@SuppressWarnings("unchecked")
	public HashMap selectChmanComView(Map map) throws DaoException;
	
	/***********************고객 회사정보 End*************************************************/
	
	@SuppressWarnings("unchecked")
	public void insertADMIN(Map map) throws DaoException;
	
	@SuppressWarnings("unchecked")
	public void updateChmanADMIN(Map map) throws DaoException;
	
	@SuppressWarnings("unchecked")
	public String selectCorpNo(Map map) throws DaoException;
	
	
	@SuppressWarnings("unchecked")
	public List<Object>ssnCheck(HashMap<Object, Object> map) throws DaoException;
	
	@SuppressWarnings("unchecked")
	public List chman_login_his(Map map) throws DaoException;
	
	@SuppressWarnings("unchecked")
	public int chman_login_hisCount(Map map) throws DaoException;
}
