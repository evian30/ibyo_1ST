package sg.svc.portal.bass.chman;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map; 

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import sg.svc.portal.bass.chman.ifac.IChmanDao;
import sg.svc.portal.bass.techsup.TechsupBiz;
import sg.svc.portal.bass.techsup.ifac.ITechsupDao;
import sg.svc.portal.util.NewPageNavigator;
import sg.svc.portal.util.ServiceUtil;
 
import com.signgate.core.exception.BizException;
import com.signgate.core.web.util.PageNavigator;
import com.signgate.core.web.util.WebUtil;
  
public class ChmanBiz {
	NewPageNavigator pageNavi = new NewPageNavigator();
	
	protected final Log logger = LogFactory.getLog(getClass());
	private IChmanDao chmanDao; 
	
	public void setChmanDao(IChmanDao chmanDao)
	{
		this.chmanDao = chmanDao;
	}
	
	private ITechsupDao techsupDao; 
	public void setTechsupDao(ITechsupDao techsupDao)
	{
		this.techsupDao = techsupDao;
	}
	
	/***********************담당자 정보 Start*************************************************/
	/**
	 * 담당자 정보 LIST
	 * @param map
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List getChmanList(HashMap paramMap){
		List list = null;
		try{
			list = null;
			
			String pageNum = WebUtil.nullCheck((String)paramMap.get("pageNum"),"1");
			String pageSize = WebUtil.nullCheck((String)paramMap.get("pageSize"),"10");
			
			int eventCount = chmanDao.selChmanCount(paramMap);
	    	
			NewPageNavigator pageNavi = new NewPageNavigator();
			pageNavi.setParameterMap(paramMap);
			pageNavi.setTotalRow(eventCount);
			pageNavi.setPageSize(Integer.parseInt(pageSize));
			pageNavi.setCurrentPage(Integer.parseInt(pageNum));
	    	
	    	paramMap.put("pageSize", pageSize);
			paramMap.put("pageNum", pageNum);
			list = chmanDao.getChmanList(paramMap);
			paramMap.put("pageNavi", pageNavi);
		}catch(Exception e){
			logger.error(e, e);
		}
		return list;
	}
	
	/**
	 * 담당자 정보 VIEW
	 * @param map
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public HashMap getChmanView(Map map) throws Exception{
		HashMap rMap = new HashMap();
		try{
			rMap = chmanDao.getChmanView(map);
		}catch(Exception e){			
			throw new Exception();
		}
		return rMap;
	}		
	
	/**
	 * 담당자정보 카운트
	 * @param map
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public int getChmanCount(HashMap map){
		int cnt = 0;
		try{
			cnt =  0;
		}catch(Exception e){
			logger.error(e, e);
		}
		return cnt;
	}
	 
	/**
	 * 담당자정보 등록
	 * @param map
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public boolean insChmanInsert(HashMap map) throws BizException{
		boolean retTrue = false;
		try{
			chmanDao.insChmanInsert(map);
			chmanDao.insertADMIN(map);
			
			retTrue = true;
		}catch(Exception e){
			retTrue = false;
			logger.error(e, e);
			throw new  BizException("");
		}
		return retTrue;
	}
	
	/**
	 * 담당자정보 수정
	 * @param map
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public boolean modChmanUpdate(HashMap map) throws BizException{
		boolean retTrue = false;
		try{
			chmanDao.modChmanUpdate(map);
			chmanDao.updateChmanADMIN(map);
			retTrue = true;
		}catch(Exception e){
			retTrue = false;
			logger.error(e, e);
			throw new  BizException("");
		}
		return retTrue;
	}
 
	/**
	 * 담당자정보 삭제
	 * @param map
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public boolean delChmanDelete(Map map){
		boolean retBoolean = false;
		try{		
			chmanDao.deleteChman(map);
			retBoolean = true;
		}catch(Exception e){			
			retBoolean = false;
			logger.error(e, e);						
		}
		return retBoolean;
	}
	
	/**
	 * 담당자정보 사용여부 수정
	 * @param map
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public boolean delChmanUseDelete(Map map){
		boolean retBoolean = false;
		try{		
			chmanDao.delChmanUseDelete(map);
			retBoolean = true;
		}catch(Exception e){			
			retBoolean = false;
			logger.error(e, e);						
		}
		return retBoolean;
	}
	
	/***********************담당자 정보 End*************************************************/	
	
	/**
	 * 코드 정보
	 * @param map
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List getCode(HashMap paramMap){
		List list = null;
		try{
			list = null;
			list = chmanDao.getCode(paramMap);
			
		}catch(Exception e){
			logger.error(e, e);
		}
		return list;
	}
	
	
	/***********************고객 회사정보 Start*************************************************/
	/**
	 * 고객 회사정보 LIST
	 * @param map
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List getChmanComList(HashMap paramMap){
		List list = null;
		try{
			String pageNum = WebUtil.nullCheck((String)paramMap.get("pageNum"),"1");
			String pageSize = WebUtil.nullCheck((String)paramMap.get("pageSize"),"10");
			
			int totConCnt = chmanDao.selectChmanComTotCount(paramMap);
	    	
			NewPageNavigator pageNavi = new NewPageNavigator();
			pageNavi.setParameterMap(paramMap);
			pageNavi.setTotalRow(totConCnt);
			pageNavi.setPageSize(Integer.parseInt(pageSize));
			pageNavi.setCurrentPage(Integer.parseInt(pageNum));
	    	
	    	paramMap.put("pageSize", pageSize);
			paramMap.put("pageNum", pageNum);
			
			list = chmanDao.selectChmanComList(paramMap);
			paramMap.put("pageNavi", pageNavi);
			
		}catch(Exception e){
			logger.error(e, e);
		}
		return list;
	}
	
	/**
	 * 고객 회사정보 카운트
	 * @param map
	 * @return
	 */  
	@SuppressWarnings("unchecked") 
	public int getChmanComCount(Map map) throws Exception{
		int nRet = 0;
		try{
			nRet = chmanDao.selectChmanComTotCount(map);
		}catch(Exception e){			
			throw new Exception();
		} 
		return nRet;
	}
	
	/**
	 * 고객 회사정보 insert
	 * @param map
	 * @return
	 */  
	@SuppressWarnings("unchecked")
	public boolean ChmanComInsert(Map map){
		boolean retBoolean = false;
		try{
			String corp_no = chmanDao.selectCorpNo(map);
			map.put("corp_no", corp_no);
			chmanDao.insertChmanCom(map);
			retBoolean = true;
		}catch(Exception e){			
			retBoolean = false;
			logger.error(e, e);						
		}
		return retBoolean; 
	}
	
	/**
	 * 계정정보 insert
	 * @param map
	 * @return
	 */  
	@SuppressWarnings("unchecked")
	public boolean insertADMIN(Map map){
		boolean retBoolean = false;
		try{
			chmanDao.insertADMIN(map);
			retBoolean = true;
		}catch(Exception e){			
			retBoolean = false;
			logger.error(e, e);						
		}
		return retBoolean; 
	}
	
	/**
	 * 계정정보 update
	 * @param map
	 * @return
	 */  
	@SuppressWarnings("unchecked")
	public boolean updateChmanADMIN(Map map){
		boolean retBoolean = false;
		try{
			chmanDao.updateChmanADMIN(map);
			retBoolean = true;
		}catch(Exception e){			
			retBoolean = false;
			logger.error(e, e);						
		}
		return retBoolean; 
	}
	
	/**
	 * 고객 회사정보 update
	 * @param map
	 * @return
	 */  
	@SuppressWarnings("unchecked")
	public boolean ChmanComUpdate(Map map){
		boolean retBoolean = false;
		try{
			chmanDao.ChmanComUpdate(map);
			retBoolean = true;
		}catch(Exception e){			
			retBoolean = false;
			logger.error(e, e);						
		}
		return retBoolean; 
	}
	
	/**
	 * 고객 회사정보 사용여부 update
	 * @param map
	 * @return
	 */  
	@SuppressWarnings("unchecked")
	public boolean ChmanComUseUpdate(Map map){
		boolean retBoolean = false;
		try{
			chmanDao.ChmanComUseUpdate(map);
			retBoolean = true;
		}catch(Exception e){			
			retBoolean = false;
			logger.error(e, e);						
		}
		return retBoolean; 
	}
	
	/**
	 * 고객 회사정보 delete
	 * @param map
	 * @return
	 */  
	@SuppressWarnings("unchecked")
	public boolean ChmanComDelete(HashMap<Object, Object> map){
		boolean retBoolean = false;
		try{
			List list = techsupDao.selectPjtNo(map);
			Iterator iterator = list.iterator();
			
			while(iterator.hasNext()){
				HashMap pjtNo = (HashMap)iterator.next();
				map.put("pjt_no", pjtNo.get("PJT_NO"));
				techsupDao.tjtDelete(map);
				techsupDao.pjtChmanDelete(map);
				techsupDao.pjtMemoDelete(map);
			}


//			//고객환경 삭제
//			techsupDao.deletePjtSupProd(map);
//			//지원 정보 삭제
//			techsupDao.TechsupDelete(map);
//			//계약 삭제
//			techsupDao.dealPjtDelete(map);
//			
//			//고객사 삭제
//			chmanDao.ChmanComDelete(map);
			retBoolean = true;
			
		}catch(Exception e){			
			retBoolean = false;
			logger.error(e, e);						
		}
		return retBoolean; 
	}
	
	/**
	 * 고객 회사정보 view
	 * @param map
	 * @return
	 */  
	@SuppressWarnings("unchecked")
	public HashMap getChmanCom(Map map) throws Exception
	{
		HashMap rMap = new HashMap();
		try
		{
			rMap = chmanDao.selectChmanComView(map);
		}catch(Exception e)
		{			
			throw new Exception();
		}
		return rMap;
	}
	/***********************고객 회사정보 End*************************************************/
	
	/**
	 *  사용자 XML정보 가져오기
	 * @param map
	 * @param request
	 * @return
	 */
	public HashMap selectXmlChmanList(HashMap map, HttpServletRequest request){
		List list = null;
		HashMap resultMap = new HashMap();
		try{
			map.put("pageSize", "10");
			map.put("pageNum", "1");
			
			list =chmanDao.selectXmlChmanList(map);
			
			String result = ServiceUtil.parseXmlMap(list);		
			resultMap.put("result", result);									
		}catch(Exception e){
			logger.error(e, e);
		}
		return resultMap;
	}
	
	/**
	 *  고객사 XML정보 가져오기
	 * @param map
	 * @param request
	 * @return
	 */
	public HashMap selectChmanComListXml(HashMap map, HttpServletRequest request){
		List list = null;
		HashMap resultMap = new HashMap();
		try{
			list =chmanDao.selectChmanComListXml(map);
			
			String result = ServiceUtil.parseXmlMap(list);		
			resultMap.put("result", result);									
		}catch(Exception e){
			logger.error(e, e);
		}
		return resultMap;
	}
	
	public HashMap ssnCheck(HashMap map, HttpServletRequest request){
		List list = null;
		HashMap resultMap = new HashMap();
		try{
			list = chmanDao.ssnCheck(map);
			String result = ServiceUtil.parseXmlMap(list);		
			resultMap.put("result", result);									
		}catch(Exception e){
			logger.error(e, e);
		}
		return resultMap;
	}
	
	
	
	@SuppressWarnings("unchecked")
	public List chman_login_his(HashMap paramMap){
		List list = null;
		
		try{
			String pageNum = WebUtil.nullCheck((String)paramMap.get("pageNum"),"1");
			String pageSize = WebUtil.nullCheck((String)paramMap.get("pageSize"),"10");
			
			int totCnt = chmanDao.chman_login_hisCount(paramMap);
	    	 
			NewPageNavigator pageNavi = new NewPageNavigator();
			pageNavi.setParameterMap(paramMap);
			pageNavi.setTotalRow(totCnt);
			pageNavi.setPageSize(Integer.parseInt(pageSize));
			pageNavi.setCurrentPage(Integer.parseInt(pageNum));
	    	
			paramMap.put("pageSize", pageSize);
			paramMap.put("pageNum", pageNum);
			paramMap.put("pageNavi", pageNavi);
			 
			list = chmanDao.chman_login_his(paramMap);
	     
		}catch(Exception e){
			logger.error(e, e);
		}
		return list;
	}
	
	@SuppressWarnings("unchecked") 
	public int chman_login_hisCount(Map map) throws Exception{
		int nRet = 0;
		try{
			nRet = chmanDao.chman_login_hisCount(map);
		}catch(Exception e){			
			throw new Exception();
		} 
		return nRet;
	}
	 
	

}
