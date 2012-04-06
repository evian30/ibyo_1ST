package sg.svc.portal.bass.techsup.ifac;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.signgate.core.exception.DaoException;

 
public interface ITechsupDao {
	 
	
	/***********************기술지원 Start*************************************************/
	
	
	/**
	 * 기술지원 getTechsupApp
	 * @param map
	 * @return
	 * @throws DaoException
	 */
	@SuppressWarnings("unchecked")
	public List getTechsupApp(Map map) throws DaoException;
	
	
	@SuppressWarnings("unchecked")
	public HashMap getTechsupAppView(Map map) throws DaoException;
	
	/**
	 * 기술지원 count
	 * @param map
	 * @return
	 * @throws DaoException
	 */
	@SuppressWarnings("unchecked")
	public List selectTechsupList(Map map) throws DaoException;
	
	
	/**
	 * 기술지원 count
	 * @param map
	 * @return
	 * @throws DaoException
	 */
	@SuppressWarnings("unchecked")
	public int selectTechsupTotCount(Map map) throws DaoException;
	
	@SuppressWarnings("unchecked")
	public int selectTechsupAppTotCount(Map map) throws DaoException;
	
	@SuppressWarnings("unchecked")
	public List supPjtList(Map map) throws DaoException;
	
	@SuppressWarnings("unchecked")
	public int supPjtListCount(Map map) throws DaoException;
	
	@SuppressWarnings("unchecked")
	public int selectProdListCountMain(Map map) throws DaoException; 
	
	@SuppressWarnings("unchecked")
	public String techSupMaxSeq(Map map) throws DaoException;
	
	@SuppressWarnings("unchecked")
	public String techSupPjtMax(Map map) throws DaoException;
	
	@SuppressWarnings("unchecked")
	public void techsupAppInsert(Map map) throws DaoException;
	
	@SuppressWarnings("unchecked")
	public String techSupappMax(Map map) throws DaoException;
	
	
	/**
	 * 기술지원 insert
	 * @param map
	 * @return
	 * @throws DaoException
	 */	
	@SuppressWarnings("unchecked")
	public void insertTechsup(Map map) throws DaoException;
	
	/**
	 * 기술지원 update
	 * @param map 
	 * @return
	 * @throws DaoException
	 */
	@SuppressWarnings("unchecked")
	public void TechsupUpdate(Map map) throws DaoException;
	
	/**
	 * 기술지원 delete
	 * @param map
	 * @return
	 * @throws DaoException
	 */
	@SuppressWarnings("unchecked")
	public void TechsupDelete(Map map) throws DaoException;
	
	
	/**
	 * 기술지원 view
	 * @param map
	 * @return
	 * @throws DaoException
	 */
	@SuppressWarnings("unchecked")
	public HashMap selectTechsupView(Map map) throws DaoException;
	
	/***********************기술지원 End*************************************************/
	
	/***********************프로젝트 Start*************************************************/
	
	/**
	 * 프로젝트 list
	 * @param map
	 * @return
	 * @throws DaoException
	 */
	@SuppressWarnings("unchecked")
	public List selectPjtList(Map map) throws DaoException;
	
	/**
	 * 프로젝트 list
	 * @param map
	 * @return
	 * @throws DaoException
	 */
	@SuppressWarnings("unchecked")
	public List selectPjtNo(Map map) throws DaoException;
	
	
	/**
	 * 프로젝트 view
	 * @param map
	 * @return
	 * @throws DaoException
	 */
	@SuppressWarnings("unchecked")
	public HashMap selectPjtView(Map map) throws DaoException;
	
	/**
	 * 프로젝트 insert
	 * @param map
	 * @return
	 * @throws DaoException
	 */	
	@SuppressWarnings("unchecked")
	public void insertPjt(Map map) throws DaoException;
	
	/**
	 * 프로젝트 update
	 * @param map
	 * @return
	 * @throws DaoException
	 */	
	@SuppressWarnings("unchecked")
	public void pjtUpdate(Map map) throws DaoException;	
	
	/**
	 * 프로젝트 delete
	 * @param map
	 * @return
	 * @throws DaoException
	 */	
	@SuppressWarnings("unchecked")
	public void tjtDelete(Map map) throws DaoException;		

	/**
	 * 프로젝트 담당자 insert
	 * @param map
	 * @return
	 * @throws DaoException
	 */	
	@SuppressWarnings("unchecked")
	public void insertPjtChman(Map map) throws DaoException;	
	
	@SuppressWarnings("unchecked")
	public void insertTechsupSubmit(Map map) throws DaoException;	
	
	@SuppressWarnings("unchecked")
	public void insertTechsupChman(Map map) throws DaoException;	
	
	@SuppressWarnings("unchecked")
	public void insertTechsupProd(Map map) throws DaoException;	
	
	@SuppressWarnings("unchecked")
	public void insertTechsupTypeEtc(Map map) throws DaoException;
	
	@SuppressWarnings("unchecked")
	public void TechsupTypeEtcDelete(Map map) throws DaoException;
	
	
	/**
	 * 프로젝트 메모 insert
	 * @param map
	 * @return
	 * @throws DaoException
	 */	
	@SuppressWarnings("unchecked")
	public void insertPjtMemo(Map map) throws DaoException;	

	/**
	 * 프로젝트 메모 delete
	 * @param map
	 * @return
	 * @throws DaoException
	 */	
	@SuppressWarnings("unchecked")
	public void pjtMemoDelete(Map map) throws DaoException;
	
	
	@SuppressWarnings("unchecked")
	public void TechsupChmanDelete(Map map) throws DaoException;	
	@SuppressWarnings("unchecked")
	public void TechsupProdDelete(Map map) throws DaoException;	
	@SuppressWarnings("unchecked")
	public void pjtChmanDelete(Map map) throws DaoException;	
	
	@SuppressWarnings("unchecked")
	public void tjtUseDelete(Map map) throws DaoException;
	
	
	/**
	 * 프로젝트 메모 update
	 * @param map
	 * @return
	 * @throws DaoException
	 */	
	@SuppressWarnings("unchecked")
	public void updatePjtChman(Map map) throws DaoException;	
	
	
	/**
	 * 프로젝트 메모 update
	 * @param map
	 * @return
	 * @throws DaoException
	 */	
	@SuppressWarnings("unchecked")
	public void pjtMemoUpdate(Map map) throws DaoException;
	
	
	/**
	 * 프로젝트 total count
	 * @param map
	 * @return
	 * @throws DaoException
	 */
	@SuppressWarnings("unchecked")
	public int selectPjtTotCount(Map map) throws DaoException;
	
	/**
	 * 프로젝트 memo list
	 * @param map
	 * @return
	 * @throws DaoException
	 */
	@SuppressWarnings("unchecked")
	public List selectPjtMemoList(Map map) throws DaoException;	
	
	@SuppressWarnings("unchecked")
	public int selectPjtMemoCount(Map map) throws DaoException;
	
	
	/***********************프로젝트 End*************************************************/
	
	
	
	@SuppressWarnings("unchecked")
	public List selectSupProdList(Map map) throws DaoException;
	
	 
	@SuppressWarnings("unchecked")
	public int selectSupProdListCount(Map map) throws DaoException;

	
	@SuppressWarnings("unchecked")
	public List selectProdList(Map map) throws DaoException;
	
	@SuppressWarnings("unchecked")
	public int selectProdListCount(Map map) throws DaoException;

	
	
	@SuppressWarnings("unchecked")
	public HashMap selectSupProdView(Map map) throws DaoException;
	
	/**
	 * 고객환경 등록 insert
	 * @param map
	 * @return
	 * @throws DaoException
	 */	
	@SuppressWarnings("unchecked")
	public void insertPjtSupProd(Map map) throws DaoException;	

	/**
	 * 제품로그경로 등록 insert
	 * @param map
	 * @return
	 * @throws DaoException
	 */	
	@SuppressWarnings("unchecked")
	public void insertProdLogPath(Map map) throws DaoException;	
	
	/**
	 * 기타SW 설치 insert
	 * @param map
	 * @return
	 * @throws DaoException
	 */	
	@SuppressWarnings("unchecked")
	public void insertOtherSwSetup(Map map) throws DaoException;	
	
	
	/**
	 * 고객환경 update
	 * @param map
	 * @return
	 * @throws DaoException
	 */	
	@SuppressWarnings("unchecked")
	public void updatePjtSupProd(Map map) throws DaoException;
	
	/**
	 * 제품로그경로 update
	 * @param map
	 * @return
	 * @throws DaoException
	 */	
	@SuppressWarnings("unchecked")
	public void updateProdLogPath(Map map) throws DaoException;
	
	/**
	 * 기타SW 설치 update
	 * @param map
	 * @return
	 * @throws DaoException
	 */	
	@SuppressWarnings("unchecked")
	public void updateOtherSwSetup(Map map) throws DaoException;

	
	/**
	 * 고객환경 delete
	 * @param map
	 * @return
	 * @throws DaoException
	 */	
	@SuppressWarnings("unchecked")
	public void deletePjtSupProd(Map map) throws DaoException;
	/**
	 * 제품로그경로 delete
	 * @param map
	 * @return
	 * @throws DaoException
	 */	
	@SuppressWarnings("unchecked")
	public void deleteProdLogPath(Map map) throws DaoException;
	/**
	 * 기타SW 설치 delete
	 * @param map
	 * @return
	 * @throws DaoException
	 */	
	@SuppressWarnings("unchecked")
	public void deleteOtherSwSetup(Map map) throws DaoException;
	
	
	/**
	 * 설정파일 경로 insert
	 * @param map
	 * @return
	 * @throws DaoException
	 */	
	@SuppressWarnings("unchecked")
	public void insertSetFilePath(Map map) throws DaoException;	
	
	/**
	 * 제품로그경로 update
	 * @param map
	 * @return
	 * @throws DaoException
	 */	
	@SuppressWarnings("unchecked")
	public void updateSetFilePath(Map map) throws DaoException;
	
	/**
	 * 설정파일 경로 delete
	 * @param map
	 * @return
	 * @throws DaoException
	 */	
	@SuppressWarnings("unchecked")
	public void deleteSetFilePath(Map map) throws DaoException;
	
	
	
	@SuppressWarnings("unchecked")
	public List getOsList(Map map) throws DaoException;

	@SuppressWarnings("unchecked")
	public List getOtherSwList(Map map) throws DaoException;

  
	@SuppressWarnings("unchecked")
	public void delSupFile(Map map) throws DaoException;
	
	@SuppressWarnings("unchecked")
	public void insSupFile(Map map) throws DaoException;
	
	public Object getDownloadFile(HashMap map) throws DaoException;
		 
	@SuppressWarnings("unchecked")
	public List selSupFile(Map map) throws DaoException;
	
	@SuppressWarnings("unchecked")
	public int techSupProdMaxSeq(Map map) throws DaoException;
	
	
	
	
	
	/*****************************************계약정보 Start*************************************************/
	@SuppressWarnings("unchecked")
	public String dealPjtMaxSeq(Map map) throws DaoException; 
	
	@SuppressWarnings("unchecked")
	public int selectDealPjtCount(Map map) throws DaoException; 
	  
	@SuppressWarnings("unchecked")
	public List selectDealPjtList(Map map) throws DaoException;
		 
	@SuppressWarnings("unchecked")
	public void dealPjtInsert(Map map) throws DaoException;
 
	@SuppressWarnings("unchecked")
	public void dealPjtUpdate(Map map) throws DaoException;
 
	@SuppressWarnings("unchecked")
	public void dealPjtDelete(Map map) throws DaoException;

	@SuppressWarnings("unchecked")
	public HashMap selectDealPjtView(Map map) throws DaoException;
	
	@SuppressWarnings("unchecked")
	public void dealPjtChmanInsert(Map map) throws DaoException;
	
	@SuppressWarnings("unchecked")
	public void dealPjtProdInsert(Map map) throws DaoException;
	
	@SuppressWarnings("unchecked")
	public void dealPjtChmanDelete(Map map) throws DaoException;
	
	@SuppressWarnings("unchecked")
	public void dealPjtProdDelete(Map map) throws DaoException;
	
	@SuppressWarnings("unchecked")
	public void dealPjtUseDelete(Map map) throws DaoException;
	
	
	/*****************************************계약정보 End*************************************************/
	
	@SuppressWarnings("unchecked")
	public void insertTechStatus(Map map) throws DaoException;	

	@SuppressWarnings("unchecked")
	public HashMap techAppStatus(Map map) throws DaoException;
	
	@SuppressWarnings("unchecked")
	public List techSupChman(Map map) throws DaoException;
	 
	@SuppressWarnings("unchecked")
	public void deleteTechSupChman(Map map) throws DaoException;

	@SuppressWarnings("unchecked")
	public List pjtListXML(Map map) throws DaoException;
	
	@SuppressWarnings("unchecked")
	public void techsupAppUpdate(Map map) throws DaoException;
	
	@SuppressWarnings("unchecked")
	public void updateTechStatus(Map map) throws DaoException;
	
	@SuppressWarnings("unchecked")
	public HashMap selectScheduleView(Map map) throws DaoException;

	
	@SuppressWarnings("unchecked")
	public List getTechSupAppTalk(Map map) throws DaoException;  
	
	@SuppressWarnings("unchecked")
	public void insertTechSupAppTalk(Map map) throws DaoException;	
	
	@SuppressWarnings("unchecked")
	public void deleteTechSupAppTalk(Map map) throws DaoException;	
	
	@SuppressWarnings("unchecked")
	public List techSupAppTot(Map map) throws DaoException;  
	
}
