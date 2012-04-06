package sg.svc.portal.bass.techsup.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import sg.svc.portal.bass.techsup.ifac.ITechsupDao;

import com.signgate.core.dao.BaseDao;
import com.signgate.core.exception.DaoException; 

 
public class TechsupDao extends BaseDao implements ITechsupDao {
	
	protected final Log logger = LogFactory.getLog(getClass());

    
 	/***********************기술지원 Start*************************************************/
	/**
	 * 기술지원 count
	 * @param map
	 * @return
	 * @throws DaoException
	 */
	@SuppressWarnings("unchecked")
	public int selectTechsupTotCount(Map map) throws DaoException{
		return queryForInt("Techsup.selectTechsupTotCount",map);
	}
	
	@SuppressWarnings("unchecked")
	public int selectTechsupAppTotCount(Map map) throws DaoException{
		return queryForInt("Techsup.selectTechsupAppTotCount",map);
	}
	
	
	@SuppressWarnings("unchecked")
	public int selectProdListCount(Map map) throws DaoException{
		return queryForInt("Techsup.selectProdListCount",map);
	} 
	
	@SuppressWarnings("unchecked")
	public int selectProdListCountMain(Map map) throws DaoException{
		return queryForInt("Techsup.selectProdListCountMain",map);
	}
	
	@SuppressWarnings("unchecked")
	public List getTechsupApp(Map map) throws DaoException{
		return queryForList("Techsup.getTechsupApp",map);
	}
	
	@SuppressWarnings("unchecked")
	public HashMap getTechsupAppView(Map map) throws DaoException{
		return (HashMap)queryForObject("Techsup.getTechsupAppView", map);
	}
	
	/**
	 * 기술지원 list
	 * @param map
	 * @return
	 * @throws DaoException
	 */
	@SuppressWarnings("unchecked")
	public List selectTechsupList(Map map) throws DaoException{
		return queryForList("Techsup.selectTechsupList", map);
	}
	
	@SuppressWarnings("unchecked")
	public int supPjtListCount(Map map) throws DaoException{
		return queryForInt("Techsup.supPjtListCount",map);
	}
	 
	@SuppressWarnings("unchecked")
	public List supPjtList(Map map) throws DaoException{
		return queryForList("Techsup.supPjtList", map);
	}
	
	@SuppressWarnings("unchecked")
	public void techsupAppInsert(Map map) throws DaoException{
		insert("Techsup.techsupAppInsert", map);
	}
	
	/**
	 * 기술지원 insert
	 * @param map
	 * @return
	 * @throws DaoException
	 */
	@SuppressWarnings("unchecked")
	public void insertTechsup(Map map) throws DaoException{
		insert("Techsup.insertTechsup", map);
	}
	 
	@SuppressWarnings("unchecked")
	public void insertTechsupSubmit(Map map) throws DaoException{
		insert("Techsup.insertTechsupSubmit", map);
	}
	
	@SuppressWarnings("unchecked")
	public void insertTechsupChman(Map map) throws DaoException{
		insert("Techsup.insertTechsupChman", map);
	}
	
	@SuppressWarnings("unchecked")
	public void insertTechsupProd(Map map) throws DaoException{
		insert("Techsup.insertTechsupProd", map);
	}
	
	@SuppressWarnings("unchecked")
	public void insertTechsupTypeEtc(Map map) throws DaoException{
		insert("Techsup.insertTechsupTypeEtc", map);
	}
	
	
	/**
	 * 기술지원 update
	 * @param map
	 * @return
	 * @throws DaoException
	 */
	@SuppressWarnings("unchecked")
	public void TechsupUpdate(Map map) throws DaoException{
		update("Techsup.TechsupUpdate", map);
	}
	
	/**
	 * 기술지원 delete
	 * @param map
	 * @return
	 * @throws DaoException
	 */
	@SuppressWarnings("unchecked")
	public void TechsupDelete(Map map) throws DaoException{
		delete("Techsup.TechsupDelete", map);
	}
	
	

	/***********************기술지원 End*************************************************/
	/***********************기술지원 End*************************************************/
	
	
	
	/***********************프로젝트 Start*************************************************/

	
	
	/**
	 * 프로젝트 list
	 * @param map
	 * @return
	 * @throws DaoException
	 */
	public List selectPjtList(Map map) throws DaoException{
		return queryForList("Techsup.selectPjtList", map);
	}
	
	/**
	 * 프로젝트 list
	 * @param map
	 * @return
	 * @throws DaoException
	 */
	public List selectPjtNo(Map map) throws DaoException{
		return queryForList("Techsup.selectPjtNo", map);
	}
	

	/**
	 * 프로젝트 view
	 * @param map
	 * @return
	 * @throws DaoException
	 */
	@SuppressWarnings("unchecked")
	public HashMap selectTechsupView(Map map) throws DaoException{
		return (HashMap)queryForObject("Techsup.selectTechsupView", map);
	}
	
	@SuppressWarnings("unchecked")
	public List selSupFile(Map map) throws DaoException{
		return queryForList("Techsup.selSupFile", map);
	}
 
	
	/**
	 * 프로젝트 insert
	 * @param map
	 * @return
	 * @throws DaoException
	 */
	@SuppressWarnings("unchecked")
	public void insertPjt(Map map) throws DaoException{
		insert("Techsup.insertPjt", map);
	}
	
	@SuppressWarnings("unchecked")
	public void TechsupChmanDelete(Map map) throws DaoException{
		delete("Techsup.TechsupChmanDelete", map);
	}
	@SuppressWarnings("unchecked")
	public void TechsupProdDelete(Map map) throws DaoException{
		delete("Techsup.TechsupProdDelete", map);
	}
	@SuppressWarnings("unchecked")
	public void TechsupTypeEtcDelete(Map map) throws DaoException{
		delete("Techsup.TechsupTypeEtcDelete", map);
	}
	@SuppressWarnings("unchecked")
	public void pjtChmanDelete(Map map) throws DaoException{
		delete("Techsup.pjtChmanDelete", map);
	}
	
	@SuppressWarnings("unchecked")
	public void tjtUseDelete(Map map) throws DaoException{
		update("Techsup.tjtUseDelete", map);
	}
	
	/**
	 * 프로젝트 update
	 * @param map
	 * @return
	 * @throws DaoException
	 */
	@SuppressWarnings("unchecked")
	public void pjtUpdate(Map map) throws DaoException{
		update("Techsup.pjtUpdate", map);
	}
	
	/**
	 * 프로젝트 delete
	 * @param map
	 * @return
	 * @throws DaoException
	 */
	@SuppressWarnings("unchecked")
	public void tjtDelete(Map map) throws DaoException{
		delete("Techsup.tjtDelete", map);
	} 
	
	/**
	 * 프로젝트 담당자 insert
	 * @param map
	 * @return
	 * @throws DaoException
	 */
	@SuppressWarnings("unchecked")
	public void insertPjtChman(Map map) throws DaoException{
		insert("Techsup.insertPjtChman", map);
	}
	
	/**
	 * 프로젝트 담당자 update
	 * @param map
	 * @return
	 * @throws DaoException
	 */
	@SuppressWarnings("unchecked")
	public void updatePjtChman(Map map) throws DaoException{
		update("Techsup.updatePjtChman", map);
	}

	/**
	 * 프로젝트 메모 insert
	 * @param map
	 * @return
	 * @throws DaoException
	 */
	@SuppressWarnings("unchecked")
	public void insertPjtMemo(Map map) throws DaoException{
		insert("Techsup.insertPjtMemo", map);
	}
	
	/**
	 * 프로젝트 메모 update
	 * @param map
	 * @return
	 * @throws DaoException
	 */
	@SuppressWarnings("unchecked")
	public void pjtMemoUpdate(Map map) throws DaoException{
		update("Techsup.pjtMemoUpdate", map);
	}
	
	/**
	 * 프로젝트 메모 delete
	 * @param map
	 * @return
	 * @throws DaoException
	 */
	@SuppressWarnings("unchecked")
	public void pjtMemoDelete(Map map) throws DaoException{
		delete("Techsup.pjtMemoDelete", map);
	}
	
	
	
	public HashMap selectPjtView(Map map) throws DaoException{
		return (HashMap)queryForObject("Techsup.selectPjtView", map);
	}	
	
	/**
	 * 프로젝트 total count
	 * @param map
	 * @return
	 * @throws DaoException
	 */
	@SuppressWarnings("unchecked")
	public int selectPjtTotCount(Map map) throws DaoException{
		return queryForInt("Techsup.selectPjtTotCount",map);
	}
	
	
	/**
	 * 프로젝트 memo list
	 * @param map
	 * @return
	 * @throws DaoException
	 */
	@SuppressWarnings("unchecked")
	public List selectPjtMemoList(Map map) throws DaoException{
		return queryForList("Techsup.selectPjtMemoList", map);
	}
	
	@SuppressWarnings("unchecked")
	public int selectPjtMemoCount(Map map) throws DaoException{
		return queryForInt("Techsup.selectPjtMemoCount",map);
	} 
	
	/***********************프로젝트 End*************************************************/

	@SuppressWarnings("unchecked")
	public void insSupFile(Map map) throws DaoException{
		insert("Techsup.insSupFile", map);
	}
	
	@SuppressWarnings("unchecked")
	public void delSupFile(Map map) throws DaoException{
		insert("Techsup.delSupFile", map);
	}
	
	public Object getDownloadFile(HashMap map) throws DaoException{
		return queryForObject("Techsup.DownselSupFile", map);
	}	
	
 	 
	@SuppressWarnings("unchecked")
	public int selectSupProdListCount(Map map) throws DaoException{
		return queryForInt("Techsup.selectSupProdListCount",map);
	} 
	 
	@SuppressWarnings("unchecked")
	public List selectSupProdList(Map map) throws DaoException{
		return queryForList("Techsup.selectSupProdList", map);
	}
	 
	@SuppressWarnings("unchecked")
	public List selectProdList(Map map) throws DaoException{
		return queryForList("Techsup.selectProdList", map);
	}
	
	 
	@SuppressWarnings("unchecked")
	public String techSupMaxSeq(Map map) throws DaoException{
		return queryForString("Techsup.techSupMaxSeq",map);
	}
	
	@SuppressWarnings("unchecked")
	public String techSupPjtMax(Map map) throws DaoException{
		return queryForString("Techsup.techSupPjtMax",map);
	}
	
	

	@SuppressWarnings("unchecked")
	public String techSupappMax(Map map) throws DaoException{
		return queryForString("Techsup.techSupappMax",map);
	}
	
	
	
	/**
	 * 고객환경 정보 list
	 * @param map
	 * @return
	 * @throws DaoException
	 */	
	public HashMap selectSupProdView(Map map) throws DaoException{
		return (HashMap)queryForObject("Techsup.selectSupProdView", map);
	}


	
	
	/**
	 * 고객환경 등록 insert
	 * @param map
	 * @return
	 * @throws DaoException
	 */	
	@SuppressWarnings("unchecked")
	public void insertPjtSupProd(Map map) throws DaoException{	
		insert("Techsup.insertPjtSupProd", map);
	}

	/**
	 * 제품로그경로 등록 insert
	 * @param map
	 * @return
	 * @throws DaoException
	 */	
	@SuppressWarnings("unchecked")
	public void insertProdLogPath(Map map) throws DaoException{	
		insert("Techsup.insertProdLogPath", map);
	}
	
	/**
	 * 기타SW 설치 insert
	 * @param map
	 * @return
	 * @throws DaoException
	 */	
	@SuppressWarnings("unchecked")
	public void insertOtherSwSetup(Map map) throws DaoException{	
		insert("Techsup.insertOtherSwSetup", map);
	}
	
	
	/**
	 * 고객환경 update
	 * @param map
	 * @return
	 * @throws DaoException
	 */	
	@SuppressWarnings("unchecked")
	public void updatePjtSupProd(Map map) throws DaoException{
		update("Techsup.updatePjtSupProd", map);
	}
	
	/**
	 * 제품로그경로 update
	 * @param map
	 * @return
	 * @throws DaoException
	 */	
	@SuppressWarnings("unchecked")
	public void updateProdLogPath(Map map) throws DaoException{
		update("Techsup.updateProdLogPath", map);
	}
	
	/**
	 * 기타SW 설치 update
	 * @param map
	 * @return
	 * @throws DaoException
	 */	
	@SuppressWarnings("unchecked")
	public void updateOtherSwSetup(Map map) throws DaoException{
		update("Techsup.updateOtherSwSetup", map);
	}

	
	/**
	 * 고객환경 delete
	 * @param map
	 * @return
	 * @throws DaoException
	 */	
	@SuppressWarnings("unchecked")
	public void deletePjtSupProd(Map map) throws DaoException{
		delete("Techsup.deletePjtSupProd", map);
	}
	/**
	 * 제품로그경로 delete
	 * @param map
	 * @return
	 * @throws DaoException
	 */	
	@SuppressWarnings("unchecked")
	public void deleteProdLogPath(Map map) throws DaoException{
		delete("Techsup.deleteProdLogPath", map);
	}
	/**
	 * 기타SW 설치 delete
	 * @param map
	 * @return
	 * @throws DaoException
	 */	
	@SuppressWarnings("unchecked")
	public void deleteOtherSwSetup(Map map) throws DaoException{
		delete("Techsup.deleteOtherSwSetup", map);
	}
	
	@SuppressWarnings("unchecked")
	public List getOsList(Map map) throws DaoException{
		return queryForList("Techsup.getOsList", map);
	}
	
	@SuppressWarnings("unchecked")
	public List getOtherSwList(Map map) throws DaoException{
		return queryForList("Techsup.getOtherSwList", map);
	}
	
	@SuppressWarnings("unchecked")
	public int techSupProdMaxSeq(Map map) throws DaoException{
		return queryForInt("Techsup.techSupProdMaxSeq",map);
	}
	
	
	
	/*****************************************계약정보 Start*************************************************/
	@SuppressWarnings("unchecked")
	public String dealPjtMaxSeq(Map map) throws DaoException{
		return queryForString("Techsup.dealPjtMaxSeq",map);
	}
	
	@SuppressWarnings("unchecked")
	public int selectDealPjtCount(Map map) throws DaoException{
		return queryForInt("Techsup.selectDealPjtCount",map);
	}
	
	@SuppressWarnings("unchecked")
	public List selectDealPjtList(Map map) throws DaoException{
		return queryForList("Techsup.selectDealPjtList", map);
	}
	
	
	@SuppressWarnings("unchecked")
	public void dealPjtInsert(Map map) throws DaoException{
		insert("Techsup.dealPjtInsert", map);
	}
	
	
	@SuppressWarnings("unchecked")
	public void dealPjtUpdate(Map map) throws DaoException{
		update("Techsup.dealPjtUpdate", map);
	}
	
	
	@SuppressWarnings("unchecked")
	public void dealPjtDelete(Map map) throws DaoException{
		delete("Techsup.dealPjtDelete", map);
	}
	
	@SuppressWarnings("unchecked")
	public HashMap selectDealPjtView(Map map) throws DaoException{
		return (HashMap)queryForObject("Techsup.selectDealPjtView", map);
	}
	
	@SuppressWarnings("unchecked")
	public void dealPjtChmanInsert(Map map) throws DaoException{
		update("Techsup.dealPjtChmanInsert", map);
	}
	
	@SuppressWarnings("unchecked")
	public void dealPjtProdInsert(Map map) throws DaoException{
		update("Techsup.dealPjtProdInsert", map);
	}
	
	@SuppressWarnings("unchecked")
	public void dealPjtChmanDelete(Map map) throws DaoException{
		update("Techsup.dealPjtChmanDelete", map);
	}
	
	@SuppressWarnings("unchecked")
	public void dealPjtProdDelete(Map map) throws DaoException{
		update("Techsup.dealPjtProdDelete", map);
	}
	
	@SuppressWarnings("unchecked")
	public void dealPjtUseDelete(Map map) throws DaoException{
		update("Techsup.dealPjtUseDelete", map);
	}
	
	
	/*****************************************계약정보 End*************************************************/
 

	
	
	/**
	 * 설정파일 경로 insert
	 * @param map
	 * @return
	 * @throws DaoException
	 */	
	@SuppressWarnings("unchecked")
	public void insertSetFilePath(Map map) throws DaoException{
		insert("Techsup.insertSetFilePath", map);
	}
	
	/**
	 * 제품로그경로 update
	 * @param map
	 * @return
	 * @throws DaoException
	 */	
	@SuppressWarnings("unchecked")
	public void updateSetFilePath(Map map) throws DaoException{
		update("Techsup.updateSetFilePath", map);
	}
	
	/**
	 * 설정파일 경로 delete
	 * @param map
	 * @return
	 * @throws DaoException
	 */	
	@SuppressWarnings("unchecked")
	public void deleteSetFilePath(Map map) throws DaoException{
		delete("Techsup.deleteSetFilePath", map);
	}
	
	@SuppressWarnings("unchecked")
	public void insertTechStatus(Map map) throws DaoException{
		insert("Techsup.insertTechStatus", map);
	}
	
	@SuppressWarnings("unchecked")
	public HashMap techAppStatus(Map map) throws DaoException{
		return (HashMap)queryForObject("Techsup.techAppStatus", map);
	}
	
	@SuppressWarnings("unchecked")
	public List techSupChman(Map map) throws DaoException{
		return queryForList("Techsup.techSupChman", map);
	}
	
	@SuppressWarnings("unchecked")
	public void deleteTechSupChman(Map map) throws DaoException{
		delete("Techsup.deleteTechSupChman", map);
	}
	
	@SuppressWarnings("unchecked")
	public List pjtListXML(Map map) throws DaoException{
		return queryForList("Techsup.pjtListXML", map);
	}
	
	@SuppressWarnings("unchecked")
	public void techsupAppUpdate(Map map) throws DaoException{
		update("Techsup.techsupAppUpdate", map);
	}
	
	@SuppressWarnings("unchecked")
	public void updateTechStatus(Map map) throws DaoException{
		update("Techsup.updateTechStatus", map);
	}
	
	
	public HashMap selectScheduleView(Map map) throws DaoException{
		return (HashMap)queryForObject("Techsup.selectScheduleView", map);
	}
	
	
	@SuppressWarnings("unchecked")
	public List getTechSupAppTalk(Map map) throws DaoException{
		return queryForList("Techsup.getTechSupAppTalk", map);
	} 
	@SuppressWarnings("unchecked")
	public void insertTechSupAppTalk(Map map) throws DaoException{
		update("Techsup.insertTechSupAppTalk", map);
	}
	@SuppressWarnings("unchecked")
	public void deleteTechSupAppTalk(Map map) throws DaoException{
		update("Techsup.deleteTechSupAppTalk", map);
	}
	
	@SuppressWarnings("unchecked")
	public List techSupAppTot(Map map) throws DaoException{
		return queryForList("Techsup.techSupAppTot", map);
	} 
	
}