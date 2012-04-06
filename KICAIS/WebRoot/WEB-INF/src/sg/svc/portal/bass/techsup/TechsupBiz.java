package sg.svc.portal.bass.techsup;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map; 

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import sg.svc.portal.bass.product.ifac.IProductDao;
import sg.svc.portal.bass.techsup.ifac.ITechsupDao;
import sg.svc.portal.util.NewPageNavigator;
import sg.svc.portal.util.ServiceUtil;
 
import com.signgate.core.config.SGConfigManager;
import com.signgate.core.exception.BizException;
import com.signgate.core.web.biz.BaseDownloadBiz;
import com.signgate.core.web.servlet.vo.DownloadFileBean;
import com.signgate.core.web.util.PageNavigator;
import com.signgate.core.web.util.WebUtil;
 

 
public class TechsupBiz extends BaseDownloadBiz {
	
	private static final HttpServletRequest request = null;

	NewPageNavigator pageNavi = new NewPageNavigator();
	
	protected final Log logger = LogFactory.getLog(getClass());
	
	private ITechsupDao techsupDao; 
	public void setTechsupDao(ITechsupDao techsupDao)
	{
		this.techsupDao = techsupDao;
	}
	
	private IProductDao productDao; 
	public void setProductDao(IProductDao productDao)
	{
		this.productDao = productDao;
	}
	
	@SuppressWarnings("unchecked")
	public DownloadFileBean selFileInfo(Map parameterMap) {
		DownloadFileBean dfb = null;
		try{ 
			dfb = (DownloadFileBean)techsupDao.getDownloadFile((HashMap)parameterMap);
			
		}catch(Exception e){
			logger.error(e, e);
		}
		return dfb;
	}
	
	@SuppressWarnings("unchecked")
	public int getTechsupAppCount(HashMap paramMap){
		int cnt = 0;
		try{
			
			cnt = techsupDao.selectTechsupAppTotCount(paramMap);
			
		}catch(Exception e){
			logger.error(e, e);
		}
		return cnt;
	}
	
	@SuppressWarnings("unchecked")
	public int getPjtTotCount(HashMap paramMap){
		int cnt = 0;
		try{
			
			cnt =  techsupDao.selectPjtTotCount(paramMap);
			
		}catch(Exception e){
			logger.error(e, e);
		}
		return cnt;
	} 
	
	@SuppressWarnings("unchecked")
	public int selectProdListCountMain(HashMap paramMap){
		int cnt = 0;
		try{
			cnt =  techsupDao.selectProdListCountMain(paramMap);
			
		}catch(Exception e){
			logger.error(e, e);
		}
		return cnt;
	} 
	
	@SuppressWarnings("unchecked")
	public List getTechsupApp(HashMap paramMap){
		List list = null;
		
		try{
			String pageNum = WebUtil.nullCheck((String)paramMap.get("pageNum"),"1");
			String pageSize = WebUtil.nullCheck((String)paramMap.get("pageSize"),"5");
			
			int totCnt = techsupDao.selectTechsupAppTotCount(paramMap);
	    	 
			NewPageNavigator pageNavi = new NewPageNavigator();
			pageNavi.setParameterMap(paramMap);
			pageNavi.setTotalRow(totCnt);
			pageNavi.setPageSize(Integer.parseInt(pageSize));
			pageNavi.setCurrentPage(Integer.parseInt(pageNum));
	    	
			paramMap.put("pageSize", pageSize);
			paramMap.put("pageNum", pageNum);
			paramMap.put("pageNavi", pageNavi);
			 
			list = techsupDao.getTechsupApp(paramMap); 
	     
		}catch(Exception e){
			logger.error(e, e);
		}
		return list;
	}
	
	@SuppressWarnings("unchecked")
	public HashMap getTechsupAppView(Map map) throws Exception
	{
		HashMap rMap = new HashMap();
		try
		{
			rMap = techsupDao.getTechsupAppView(map);
		}catch(Exception e)
		{			
			throw new Exception();
		}
		
		return rMap;
	}
	
	
	 
	@SuppressWarnings("unchecked")
	public List getTechsupList(HashMap paramMap){
		List list = null;
		
		try{
			String pageNum = WebUtil.nullCheck((String)paramMap.get("pageNum"),"1");
			String pageSize = WebUtil.nullCheck((String)paramMap.get("pageSize"),"10");
			
			int totCnt = techsupDao.selectTechsupTotCount(paramMap);
	    	 
			NewPageNavigator pageNavi = new NewPageNavigator();
			
			pageNavi.setParameterMap(paramMap);
			pageNavi.setTotalRow(totCnt);
			pageNavi.setPageSize(Integer.parseInt(pageSize));
			pageNavi.setCurrentPage(Integer.parseInt(pageNum));
	    	
			
			paramMap.put("pageSize", pageSize);
			paramMap.put("pageNum", pageNum);
			paramMap.put("pageNavi", pageNavi);
			
			list = techsupDao.selectTechsupList(paramMap); 
	     
		}catch(Exception e){
			logger.error(e, e);
		}
		return list;
	}
	
	  
	@SuppressWarnings("unchecked")
	public int getTechsupCount(HashMap map){
		int cnt = 0;
		try{
			
			cnt = techsupDao.selectTechsupTotCount(map);
			
		}catch(Exception e){
			logger.error(e, e);
		}
		return cnt;
	}
	
	
	
	@SuppressWarnings("unchecked")
	public List supPjtList(HashMap paramMap){
		List list = null;
		
		try{
			String pageNum = WebUtil.nullCheck((String)paramMap.get("pageNum"),"1");
			String pageSize = WebUtil.nullCheck((String)paramMap.get("pageSize"),"10");
			
			int totCnt = techsupDao.supPjtListCount(paramMap);
	    	NewPageNavigator pageNavi = new NewPageNavigator();
			
			pageNavi.setParameterMap(paramMap);
			pageNavi.setTotalRow(totCnt);
			pageNavi.setPageSize(Integer.parseInt(pageSize));
			pageNavi.setCurrentPage(Integer.parseInt(pageNum));
	    	
			paramMap.put("pageSize", pageSize);
			paramMap.put("pageNum", pageNum);
			paramMap.put("pageNavi", pageNavi);
			 
			list = techsupDao.supPjtList(paramMap); 
	     
		}catch(Exception e){
			logger.error(e, e);
		}
		return list;
	}
	 
	
	@SuppressWarnings("unchecked")
	public String techSupMaxSeq(HashMap map){
		String cnt="";
		try{ 
			
			cnt = techsupDao.techSupMaxSeq(map);
			
		}catch(Exception e){
			logger.error(e, e);
		}
		return cnt;
	}
	
	
	  
	@SuppressWarnings("unchecked")
	public int supPjtListCount(HashMap map){
		int cnt = 0;
		try{
			
			cnt = techsupDao.supPjtListCount(map);
			
		}catch(Exception e){
			logger.error(e, e);
		}
		return cnt;
	}
	 

  
	@SuppressWarnings("unchecked") 
	public int getTechsupCount(Map map) throws Exception{
		int nRet = 0;
		try{
			
			nRet = techsupDao.selectTechsupTotCount(map);
		
		}catch(Exception e){			
			throw new Exception();
		} 
		return nRet;
	}
	
	@SuppressWarnings("unchecked")
	public boolean techsupAppInsert(HashMap map){
		boolean retBoolean = false;
		try{
			String tech_sup_app_no = techsupDao.techSupappMax(map);
			map.put("tech_sup_app_no", tech_sup_app_no);
			
			techsupDao.techsupAppInsert(map);
			techsupDao.insertTechStatus(map);
			
			List fileList = (List)map.get("uploadList");
			Iterator iterator = fileList.iterator();
			
			while(iterator.hasNext()){
				HashMap fMap = (HashMap)iterator.next();
				map.put("file_real_nm", fMap.get("sourceFileName").toString());
				map.put("file_save_nm", fMap.get("saveFileName").toString());
				map.put("file_path", fMap.get("filePath").toString());	
				map.put("file_size", fMap.get("fileSize").toString()); 
				map.put("no", tech_sup_app_no);
				techsupDao.insSupFile(map);			//첨부파일 등록
			} 
			
			retBoolean = true;
			
		}catch(Exception e){			
			retBoolean = false;
			logger.error(e, e);						
		}
		
		return retBoolean; 
	}
	
	@SuppressWarnings("unchecked")
	public boolean techsupAppUpdate(HashMap map){
		boolean retBoolean = false;
		try{
			techsupDao.techsupAppUpdate(map);
			
			List fileList = (List)map.get("uploadList");
			Iterator iterator = fileList.iterator();
			
			while(iterator.hasNext()){
				HashMap fMap = (HashMap)iterator.next();
				map.put("file_real_nm", fMap.get("sourceFileName").toString());
				map.put("file_save_nm", fMap.get("saveFileName").toString());
				map.put("file_path", fMap.get("filePath").toString());	
				map.put("file_size", fMap.get("fileSize").toString()); 
				map.put("no", map.get("tech_sup_app_no"));
				techsupDao.insSupFile(map);			//첨부파일 등록
			} 
			
			for(int i=1; i<10; i++){
				map.put("add_file_no", map.get("del_chk"+i));
				if(map.get("del_chk"+i)!=null && !map.get("del_chk"+i).equals("")){ 
					techsupDao.delSupFile(map);			//첨부파일 삭제
				}
			}
			retBoolean = true;
			
		}catch(Exception e){			
			retBoolean = false;
			logger.error(e, e);						
		}
		
		return retBoolean; 
	}
	
	@SuppressWarnings("unchecked")
	public boolean techsupAppStatus(HashMap map){
		boolean retBoolean = false;
		try{
			techsupDao.insertTechStatus(map);
			
			if(map.get("dev_chman_no") != null && map.get("dev_chman_no") != ""){
				//  제품개발 담당자
				String[] dev_chman_no =  map.get("dev_chman_no").toString().replace(" ", "").split(",");
				map.put("match_yn", "Y");
				if(dev_chman_no.length > 1){
					for(int i=1;i<dev_chman_no.length;i++){
						map.put("dev_chman_no", dev_chman_no[i].replace("[", "").replace("]", ""));
						techsupDao.insertTechsupChman(map);
					}
				}  
			}
			
			//  개발담당자 삭제
			String[] del_seq =  map.get("del_seq").toString().replace(" ", "").split(",");
			if(del_seq.length > 1){
				for(int i=1;i<del_seq.length;i++){
					map.put("chman_no", del_seq[i].replace("[", "").replace("]", ""));
					//  제품권장 WS
					techsupDao.deleteTechSupChman(map);
				}
			}
			
			if(map.get("matchY") != null && map.get("matchY").equals("N")){
				map.put("dev_chman_no", map.get("app_chman_no"));
				map.put("match_yn", "N");
				techsupDao.insertTechsupChman(map);
			}
			
			if(map.get("statsSeq4") != null && map.get("statsSeq4") != ""){
				map.put("seq", map.get("statsSeq4"));
				map.put("reject_yn", "N");
				techsupDao.updateTechStatus(map);
			}
			
			retBoolean = true;
			
		}catch(Exception e){			
			retBoolean = false;
			logger.error(e, e);						
		}
		
		return retBoolean; 
	}

	
	
	@SuppressWarnings("unchecked")
	public boolean insertTechStatus(HashMap map){
		boolean retBoolean = false;
		try{
			
			techsupDao.insertTechStatus(map);

			retBoolean = true;
			
		}catch(Exception e){			
			retBoolean = false;
			logger.error(e, e);						
		}
		
		return retBoolean; 
	}
	
	@SuppressWarnings("unchecked")
	public boolean updateTechStatus(HashMap map){
		boolean retBoolean = false;
		try{
			techsupDao.updateTechStatus(map);
			
			retBoolean = true;
			
		}catch(Exception e){			
			retBoolean = false;
			logger.error(e, e);						
		}
		
		return retBoolean; 
	}
	
	
	
	@SuppressWarnings("unchecked")
	public boolean TechsupInsert(Map map){
		boolean retBoolean = false;
		try{
			
			String tech_code=techsupDao.techSupMaxSeq(map);
			map.put("tech_sup_no", tech_code);
			
			if(Integer.parseInt((String) map.get("listCount")) == 0){
				techsupDao.insertTechStatus(map);
			}  
			techsupDao.insertTechsup(map); 
			 
			List fileList = (List)map.get("uploadList");
			Iterator iterator = fileList.iterator();
			
			while(iterator.hasNext()){
				HashMap fMap = (HashMap)iterator.next();
				map.put("file_real_nm", fMap.get("sourceFileName").toString());
				map.put("file_save_nm", fMap.get("saveFileName").toString());
				map.put("file_path", fMap.get("filePath").toString());	
				map.put("file_size", fMap.get("fileSize").toString()); 
				map.put("no", tech_code);
				techsupDao.insSupFile(map);						//첨부파일 등록
			}  
			
			retBoolean = true;
			
		}catch(Exception e){			
			retBoolean = false;
			logger.error(e, e);						
		}
		
		return retBoolean; 
	}
 
	@SuppressWarnings("unchecked")
	public boolean TechsupUpdate(Map map){
		boolean retBoolean = false;
		try{
			techsupDao.TechsupUpdate(map); 
			
			List fileList = (List)map.get("uploadList");
			Iterator iterator = fileList.iterator();
			
			while(iterator.hasNext()){
				HashMap fMap = (HashMap)iterator.next();
				map.put("file_real_nm", fMap.get("sourceFileName").toString());
				map.put("file_save_nm", fMap.get("saveFileName").toString());
				map.put("file_path", fMap.get("filePath").toString());	
				map.put("file_size", fMap.get("fileSize").toString()); 
				map.put("no", map.get("tech_sup_no"));
				techsupDao.insSupFile(map);			//첨부파일 등록
			} 
			
			for(int i=1; i<10; i++){
				map.put("add_file_no", map.get("del_chk"+i));
				if(map.get("del_chk"+i)!=null && !map.get("del_chk"+i).equals("")){ 
					techsupDao.delSupFile(map);			//첨부파일 삭제
				}
			}
			 
			
			retBoolean = true;
			
		}catch(Exception e){			
			retBoolean = false;
			logger.error(e, e);						
		}
		
		return retBoolean; 
	}
	
 
	@SuppressWarnings("unchecked")
	public boolean TechsupDelete(Map map){
		boolean retBoolean = false;
		try{
			  	
			techsupDao.TechsupDelete(map);
			retBoolean = true;
			
		}catch(Exception e){			
			retBoolean = false;
			logger.error(e, e);						
		}
		
		return retBoolean; 
	}
	
	 
	@SuppressWarnings("unchecked")
	public HashMap getTechsup(Map map) throws Exception
	{
		HashMap rMap = new HashMap();
		try
		{
			rMap = techsupDao.selectTechsupView(map);
			
		}catch(Exception e)
		{			
			throw new Exception();
		}
		
		return rMap;
	}
	
	@SuppressWarnings("unchecked")
	public List selSupFile(HashMap paramMap){
		List list = null;
		
		try{
			list = null; 
			 
			paramMap.put("no", paramMap.get("no"));
			list = 	techsupDao.selSupFile(paramMap);
	     
		}catch(Exception e){
			logger.error(e, e);
		}
		return list;
	}
	 
	
	 
	/***********************프로젝트 Start*************************************************/
	
	
	@SuppressWarnings("unchecked")
	public List selectPjtList(Map paramMap) throws Exception
	{
		List list = null;
		try
		{
			list = null;
			String pageNum = "";
			
			pageNum= WebUtil.nullCheck((String)paramMap.get("pageNum"),"1");
			String pageSize = WebUtil.nullCheck((String)paramMap.get("pageSize"),"10");
			int totConCnt = techsupDao.selectPjtTotCount(paramMap);
	    	
			NewPageNavigator pageNavi = new NewPageNavigator();
			pageNavi.setParameterMap(paramMap);
			pageNavi.setTotalRow(totConCnt);
			pageNavi.setPageSize(Integer.parseInt(pageSize));
			pageNavi.setCurrentPage(Integer.parseInt(pageNum));
	    	
	    	paramMap.put("pageSize", pageSize);
			paramMap.put("pageNum", pageNum);
			paramMap.put("pageNavi", pageNavi);
			
			list = techsupDao.selectPjtList(paramMap);
			
		}catch(Exception e)
		{			
			throw new Exception();
		}
		
		return list;
	}
	
	@SuppressWarnings("unchecked")
	public HashMap selectPjtView(Map map) throws Exception
	{
		HashMap rMap = new HashMap();
		try
		{
			rMap = techsupDao.selectPjtView(map);
		}catch(Exception e)
		{			
			throw new Exception();
		}
		
		return rMap;
	}
	 
	
	
	@SuppressWarnings("unchecked")
	public boolean pjtUpdate(Map map){
		boolean retBoolean = false;
		try{
			  	
			techsupDao.pjtUpdate(map);
			
			//프로젝트 SG담당자 등록
			map.put("chman_sect_code", "1");
			map.put("chman_no", map.get("chman_no1"));
			map.put("chman_nm", map.get("chman_nm1"));
			//techsupDao.updatePjtChman(map);
			//프로젝트 고객담당자 등록
			map.put("chman_sect_code", "2");
			map.put("chman_no", map.get("chman_no2"));
			map.put("chman_nm", map.get("chman_nm2"));
			//techsupDao.updatePjtChman(map);	
//			if(map.get("memoActType") != null && map.get("memoActType").equals("ins")){
//				//프로젝트 메모 등록
//				techsupDao.insertPjtMemo(map);
//			}else if(map.get("memoActType") != null && map.get("memoActType").equals("mod")){
//				//프로젝트 메모 수정
//				techsupDao.pjtMemoUpdate(map);
//			}
			
			retBoolean = true;
			
		}catch(Exception e){			
			retBoolean = false;
			logger.error(e, e);						
		}
		return retBoolean; 
	}	
	
	@SuppressWarnings("unchecked")
	public boolean pjtMemoDelete(Map map){
		boolean retBoolean = false;
		try{
			techsupDao.pjtMemoDelete(map);
			
			retBoolean = true;
			
		}catch(Exception e){			
			retBoolean = false;
			logger.error(e, e);						
		}
		return retBoolean; 
	}
	
	@SuppressWarnings("unchecked")
	public boolean pjtInsert(HashMap map){
		boolean retBoolean = false;
		try{
			String pjt_no = techsupDao.techSupPjtMax(map);
			map.put("pjt_no", pjt_no);
			
			//프로젝트 등록
			techsupDao.insertPjt(map);
			
			//프로젝트 SG담당자 등록
			map.put("chman_sect_code", "1");
			map.put("chman_no", map.get("chman_no1"));
			map.put("chman_nm", map.get("chman_nm1"));
			techsupDao.insertPjtChman(map);
			//프로젝트 고객담당자 등록
			map.put("chman_sect_code", "2");
			map.put("chman_no", map.get("chman_no2"));
			map.put("chman_nm", map.get("chman_nm2"));
			techsupDao.insertPjtChman(map);			
			
			//프로젝트 메모 등록
//			if(map.get("pjt_memo_contents") != null && map.get("pjt_memo_contents") != ""){
//				techsupDao.insertPjtMemo(map);
//			}
			
			retBoolean = true;
			
		}catch(Exception e){			
			retBoolean = false;
			logger.error(e, e);						
		}
		
		return retBoolean; 
	}
	
	@SuppressWarnings("unchecked")
	public boolean memoInsert(HashMap map){
		boolean retBoolean = false;
		try{
			  	
			techsupDao.insertPjtMemo(map);
			
			retBoolean = true;
			
		}catch(Exception e){			
			retBoolean = false;
			logger.error(e, e);						
		}
		
		return retBoolean; 
	}
	
	@SuppressWarnings("unchecked")
	public boolean pjtMemoUpdate(Map map){
		boolean retBoolean = false;
		try{
			//프로젝트 메모 수정
			techsupDao.pjtMemoUpdate(map);
			
			retBoolean = true;
			
		}catch(Exception e){			
			retBoolean = false;
			logger.error(e, e);						
		}
		
		return retBoolean; 
	}

	@SuppressWarnings("unchecked")
	public boolean tjtDelete(Map map){
		boolean retBoolean = false;
		try{
			String pjt_no = (String) map.get("pjt_no");
			if(pjt_no != null && pjt_no != ""){
				//담당자 삭제
				techsupDao.pjtChmanDelete(map);
				//메모 삭제
				techsupDao.pjtMemoDelete(map);
				//프로젝트 삭제
				techsupDao.tjtDelete(map);
				
			}
			
			retBoolean = true;
			
		}catch(Exception e){			
			retBoolean = false;
			logger.error(e, e);						
		}
		
		return retBoolean; 
	}
	
	@SuppressWarnings("unchecked")
	public boolean tjtUseDelete(Map map){
		boolean retBoolean = false;
		try{
			techsupDao.tjtUseDelete(map);
			
			retBoolean = true;
			
		}catch(Exception e){			
			retBoolean = false;
			logger.error(e, e);						
		}
		
		return retBoolean; 
	}
	
	@SuppressWarnings("unchecked")
	public List pjtMemoList(HashMap paramMap){
		List list = null;
		
		try{
			String pageNum = WebUtil.nullCheck((String)paramMap.get("pageNum"),"1");
			String pageSize = WebUtil.nullCheck((String)paramMap.get("pageSize"),"10");
			
			int totCnt = techsupDao.selectPjtMemoCount(paramMap);
	    	 
			NewPageNavigator pageNavi = new NewPageNavigator();
			
			pageNavi.setParameterMap(paramMap);
			pageNavi.setTotalRow(totCnt);
			pageNavi.setPageSize(Integer.parseInt(pageSize));
			pageNavi.setCurrentPage(Integer.parseInt(pageNum));
	    	
			paramMap.put("pageSize", pageSize);
			paramMap.put("pageNum", pageNum);
			paramMap.put("pageNavi", pageNavi);
			
			list = techsupDao.selectPjtMemoList(paramMap); 
	     
		}catch(Exception e){
			logger.error(e, e);
		}
		return list;
	}
	
	@SuppressWarnings("unchecked")
	public HashMap pjtMemoListXML(HashMap paramMap){
		List list = null;
		HashMap resultMap = new HashMap();
		
		try{
			list = null;
			
			String pageNum = WebUtil.nullCheck((String)paramMap.get("pageNum"),"1");
			String pageSize = WebUtil.nullCheck((String)paramMap.get("pageSize"),"10");
			 
			int totCnt = techsupDao.selectPjtMemoCount(paramMap);
	    	 
			NewPageNavigator pageNavi = new NewPageNavigator();
			
			pageNavi.setParameterMap(paramMap);
			pageNavi.setTotalRow(totCnt);
			pageNavi.setPageSize(Integer.parseInt(pageSize));
			pageNavi.setCurrentPage(Integer.parseInt(pageNum));
	    	
			paramMap.put("pageSize", pageSize);
			paramMap.put("pageNum", pageNum);
			paramMap.put("pageNavi", pageNavi);
			
			list = techsupDao.selectPjtMemoList(paramMap); 
			
			StringBuffer pageing = new StringBuffer();
			String result = ServiceUtil.parseXmlMap(list) + pageing.toString();		
			resultMap.put("result", result);
	     
		}catch(Exception e){
			logger.error(e, e);
		}
		return resultMap;
	}
	
	@SuppressWarnings("unchecked")
	public HashMap pjtListXML(HashMap paramMap, HttpServletRequest request2){
		List list = null;
		HashMap resultMap = new HashMap();
		
		try{
			list = null;
			list =(List) techsupDao.pjtListXML(resultMap);
	    	
			StringBuffer pageing = new StringBuffer();
			String result = ServiceUtil.parseXmlMap(list) + pageing.toString();	
			resultMap.put("result", result);
		}catch(Exception e){
			logger.error(e, e);
		}
		return resultMap;
	}
	
	
	
	/***********************프로젝트 End*************************************************/

	
	/***********************고객지원 고객 환경정보 Start*************************************************/
	@SuppressWarnings("unchecked")
	public List selectSupProdList(HashMap paramMap){
		List list = null;
		
		try{
			paramMap.put("pageSize_prod", "20");
			paramMap.put("pageNum_prod", "1");
			
			list = techsupDao.selectSupProdList(paramMap); 
	     
		}catch(Exception e){
			logger.error(e, e);
		}
		return list;
	}
	  
	@SuppressWarnings("unchecked")
	public int selectSupProdListCount(HashMap map){
		int cnt = 0;
		try{
			cnt = techsupDao.selectSupProdListCount(map);
			
		}catch(Exception e){
			logger.error(e, e);
		}
		return cnt;
	}
	/***********************고객지원 고객 환경정보 End*************************************************/
	
	
	@SuppressWarnings("unchecked")
	public boolean insertTechsupSubmit(Map map){
		boolean retBoolean = false;
		try{
			techsupDao.insertTechsupSubmit(map);
			retBoolean = true;
			
		}catch(Exception e){			
			retBoolean = false;
			logger.error(e, e);						
		}
		
		return retBoolean; 
	}
	@SuppressWarnings("unchecked")
	public boolean insertTechsupChman(Map map){
		boolean retBoolean = false;
		try{ 
			techsupDao.insertTechsupChman(map);
			retBoolean = true;
			
		}catch(Exception e){			
			retBoolean = false;
			logger.error(e, e);						
		}
		
		return retBoolean; 
	}
	@SuppressWarnings("unchecked")
	public boolean insertTechsupProd(Map map){
		boolean retBoolean = false;
		try{
			techsupDao.insertTechsupProd(map);
			retBoolean = true;
			
		}catch(Exception e){			
			retBoolean = false;
			logger.error(e, e);						
		}
		
		return retBoolean; 
	}
	@SuppressWarnings("unchecked")
	public boolean insertTechsupTypeEtc(Map map){
		boolean retBoolean = false;
		try{
			techsupDao.insertTechsupTypeEtc(map);
			retBoolean = true;
			
		}catch(Exception e){			
			retBoolean = false;
			logger.error(e, e);						
		}
		return retBoolean; 
	}
	
	@SuppressWarnings("unchecked")
	public boolean TechsupChmanDelete(Map map){
		boolean retBoolean = false;
		try{
			techsupDao.TechsupChmanDelete(map);
			
			retBoolean = true;
			
		}catch(Exception e){			
			retBoolean = false;
			logger.error(e, e);						
		}
		
		return retBoolean; 
	}
	
	@SuppressWarnings("unchecked")
	public boolean TechsupProdDelete(Map map){
		boolean retBoolean = false;
		try{
			techsupDao.TechsupProdDelete(map);
			
			retBoolean = true;
			
		}catch(Exception e){			
			retBoolean = false;
			logger.error(e, e);						
		}
		
		return retBoolean; 
	}
	@SuppressWarnings("unchecked")
	public boolean TechsupTypeEtcDelete(Map map){
		boolean retBoolean = false;
		try{
			techsupDao.TechsupTypeEtcDelete(map);
			
			retBoolean = true;
			
		}catch(Exception e){			
			retBoolean = false;
			logger.error(e, e);						
		}
		return retBoolean; 
	}
	
	
	@SuppressWarnings("unchecked")
	public List selectProdList(HashMap paramMap){
		List list = null;
		
		try{
			String pageNum = WebUtil.nullCheck((String)paramMap.get("pageNum"),"1");
			String pageSize = WebUtil.nullCheck((String)paramMap.get("pageSize"),"10");
			 
			int totCnt = techsupDao.selectProdListCount(paramMap);
	    	 
			NewPageNavigator pageNavi = new NewPageNavigator();
			
			pageNavi.setParameterMap(paramMap);
			pageNavi.setTotalRow(totCnt);
			pageNavi.setPageSize(Integer.parseInt(pageSize));
			pageNavi.setCurrentPage(Integer.parseInt(pageNum)); 
			
			paramMap.put("pageSize", pageSize);
			paramMap.put("pageNum", pageNum);
			paramMap.put("pageNavi", pageNavi);
			
			list = techsupDao.selectProdList(paramMap); 
	     
		}catch(Exception e){
			logger.error(e, e);
		}
		return list;
	}
	
	@SuppressWarnings("unchecked")
	public int getProdListCount(HashMap map){
		int cnt = 0;
		try{
			cnt = techsupDao.selectProdListCount(map);
			
		}catch(Exception e){
			logger.error(e, e);
		}
		return cnt;
	}
	
	@SuppressWarnings("unchecked")
	public HashMap selectSupProdView(HashMap paramMap){
		HashMap rMap = new HashMap();
		try{
			rMap = techsupDao.selectSupProdView(paramMap); 
	     
		}catch(Exception e){
			logger.error(e, e);
		}
		return rMap;
	}
	
	@SuppressWarnings("unchecked")
	public boolean pjtSupProdInsert(Map map){
		boolean retBoolean = false;
		try{
			//  환경정보 등록
			techsupDao.insertPjtSupProd(map); 
			List fileList = (List)map.get("uploadList");
			Iterator iterator = fileList.iterator();
			if(fileList.size() > 0){
				while(iterator.hasNext()){
					HashMap fMap = (HashMap)iterator.next();
					map.put("file_real_nm", fMap.get("sourceFileName").toString());
					map.put("file_save_nm", fMap.get("saveFileName").toString());
					map.put("file_path", fMap.get("filePath").toString());	
					map.put("file_size", fMap.get("fileSize").toString()); 
					map.put("chman_no", "");
					
					techsupDao.insSupFile(map);			//첨부파일 등록
				} 
			}
			
			//  기타SW 등록
			if( map.get("sdk") != null &&  map.get("sdk").toString().length() > 0){
				map.put("sw_no", map.get("sdk"));
				map.put("sw_setup_path", map.get("sdk_path"));
				techsupDao.insertOtherSwSetup(map);
			}
			if( map.get("web") != null &&  map.get("web").toString().length() > 0){
				map.put("sw_no", map.get("web"));
				map.put("sw_setup_path", map.get("web_path"));
				techsupDao.insertOtherSwSetup(map);
			}
			if( map.get("was") != null &&  map.get("was").toString().length() > 0){
				map.put("sw_no", map.get("was"));
				map.put("sw_setup_path", map.get("was_path"));
				techsupDao.insertOtherSwSetup(map);
			}
			
			
			if( map.get("cab") != null &&  map.get("cab").toString().length() > 0){
				// 설정파일경로
				map.put("set_file_path", map.get("cab"));
				map.put("set_file_code","1");
				techsupDao.insertSetFilePath(map);
			}
			if( map.get("lib") != null &&  map.get("lib").toString().length() > 0){
				map.put("set_file_path", map.get("lib"));
				map.put("set_file_code", "2");
				techsupDao.insertSetFilePath(map);
			}
			if( map.get("config") != null &&  map.get("config").toString().length() > 0){
				map.put("set_file_path", map.get("config"));
				map.put("set_file_code", "3");
				techsupDao.insertSetFilePath(map);
			}
			if( map.get("certification") != null &&  map.get("certification").toString().length() > 0){
				map.put("set_file_path", map.get("certification"));
				map.put("set_file_code", "4");
				techsupDao.insertSetFilePath(map); 
			}
			
			
			if( map.get("log_path") != null &&  map.get("log_path").toString().length() > 0){
				// 제품로그경로 등록
				techsupDao.insertProdLogPath(map);
			}
			
			retBoolean = true;
			
		}catch(Exception e){			
			retBoolean = false;
			logger.error(e, e);						
		}
		return retBoolean; 
	}
	
	@SuppressWarnings("unchecked")
	public boolean pjtSupProdUpdate(Map map){
		boolean retBoolean = false;
		try{
			//  환경정보 등록
			techsupDao.updatePjtSupProd(map);
			
			//  기타SW 등록
			if( map.get("o_sdk").toString().length() == 0 &&  map.get("sdk").toString().length() > 0){
				map.put("sw_no", map.get("sdk"));
				map.put("sw_setup_path", map.get("sdk_path"));
				techsupDao.insertOtherSwSetup(map);
			}
			if( map.get("o_web").toString().length() == 0 &&  map.get("web").toString().length() > 0){
				map.put("sw_no", map.get("web"));
				map.put("sw_setup_path", map.get("web_path"));
				techsupDao.insertOtherSwSetup(map);
			}
			if( map.get("o_was").toString().length() == 0 &&  map.get("was").toString().length() > 0){
				map.put("sw_no", map.get("was"));
				map.put("sw_setup_path", map.get("was_path"));
				techsupDao.insertOtherSwSetup(map);
			}
			
			
			if( map.get("o_cab").toString().length() == 0 &&  map.get("cab").toString().length() > 0){
				// 설정파일경로
				map.put("set_file_path", map.get("cab"));
				map.put("set_file_code","1");
				techsupDao.insertSetFilePath(map);
			}
			if( map.get("o_lib").toString().length() == 0 &&  map.get("lib").toString().length() > 0){
				map.put("set_file_path", map.get("lib"));
				map.put("set_file_code", "2");
				techsupDao.insertSetFilePath(map);
			}
			if( map.get("o_config").toString().length() == 0 &&  map.get("config").toString().length() > 0){
				map.put("set_file_path", map.get("config"));
				map.put("set_file_code", "3");
				techsupDao.insertSetFilePath(map);
			}
			if( map.get("o_certification").toString().length() == 0 &&  map.get("certification").toString().length() > 0){
				map.put("set_file_path", map.get("certification"));
				map.put("set_file_code", "4");
				techsupDao.insertSetFilePath(map); 
			}
			
			if( map.get("o_log_path").toString().length() == 0 &&  map.get("log_path").toString().length() > 0){
				// 제품로그경로 등록
				techsupDao.insertProdLogPath(map);
			}
			
			
			
			if( map.get("o_log_path").toString().length() > 0){
				//  제품로그경로 등록
				techsupDao.updateProdLogPath(map);
			}

			if( map.get("o_sdk").toString().length() > 0){
				//  기타SW 등록
				map.put("sw_no", map.get("sdk"));
				map.put("o_sw_no", map.get("o_sdk"));
				map.put("sw_setup_path", map.get("sdk_path"));
				techsupDao.updateOtherSwSetup(map);
			}
			if( map.get("o_web").toString().length() > 0){
				map.put("sw_no", map.get("web"));
				map.put("o_sw_no", map.get("o_web"));
				map.put("sw_setup_path", map.get("web_path"));
				techsupDao.updateOtherSwSetup(map);
			}
			if( map.get("o_was").toString().length() > 0){
				map.put("sw_no", map.get("was"));
				map.put("o_sw_no", map.get("o_was"));
				map.put("sw_setup_path", map.get("was_path"));
				techsupDao.updateOtherSwSetup(map);
			}
			if( map.get("o_cab").toString().length() > 0){
				//  설정파일경로
				map.put("set_file_path", map.get("cab"));
				map.put("set_file_code","1");
				techsupDao.updateSetFilePath(map);
			}
			if( map.get("o_lib").toString().length() > 0){
				map.put("set_file_path", map.get("lib"));
				map.put("set_file_code", "2");
				techsupDao.updateSetFilePath(map);
			}
			if( map.get("o_config").toString().length() > 0){
				map.put("set_file_path", map.get("config"));
				map.put("set_file_code", "3");
				techsupDao.updateSetFilePath(map);
			}
			if( map.get("o_certification").toString().length() > 0){
				map.put("set_file_path", map.get("certification"));
				map.put("set_file_code", "4");
				techsupDao.updateSetFilePath(map);
			}
			
			List fileList = (List)map.get("uploadList");
			Iterator iterator = fileList.iterator();
			
			if(fileList.size() > 0){
				while(iterator.hasNext()){
					HashMap fMap = (HashMap)iterator.next();
					
					map.put("file_real_nm", fMap.get("sourceFileName").toString());
					map.put("file_save_nm", fMap.get("saveFileName").toString());
					map.put("file_path", fMap.get("filePath").toString());	
					map.put("file_size", fMap.get("fileSize").toString());  
					
					techsupDao.insSupFile(map);			//첨부파일 등록
				} 
			}
			
			for(int i=1; i<10; i++){
				map.put("add_file_no", map.get("del_chk"+i));
				if(map.get("del_chk"+i)!=null && !map.get("del_chk"+i).equals("")){ 
					techsupDao.delSupFile(map);			//첨부파일 삭제
				}
			}
			
			retBoolean = true;
			
		}catch(Exception e){			
			retBoolean = false;
			logger.error(e, e);						
		}
		
		return retBoolean; 
	}
	
	@SuppressWarnings("unchecked")
	public List getOsList(HashMap paramMap){
		List list = null;
		
		try{
			list = null;
			
			list = techsupDao.getOsList(paramMap); 
	     
		}catch(Exception e){
			logger.error(e, e);
		}
		return list;
	}
	
	@SuppressWarnings("unchecked")
	public List getOtherSwList(HashMap paramMap){
		List list = null;
		
		try{
			list = techsupDao.getOtherSwList(paramMap); 
	     
		}catch(Exception e){
			logger.error(e, e);
		}
		return list;
	}
	
	
	@SuppressWarnings("unchecked")
	public int techSupProdMaxSeq(HashMap map){
		int cnt = 0;
		try{
			
			cnt = techsupDao.techSupProdMaxSeq(map);
			
		}catch(Exception e){
			logger.error(e, e);
		}
		return cnt;
	}
	
	
	/****************************************계약정보 Start***************************************/
	@SuppressWarnings("unchecked")
	public int selectDealPjtCount(HashMap map){
		int cnt = 0;
		try{
			
			cnt = techsupDao.selectDealPjtCount(map);
			
		}catch(Exception e){
			logger.error(e, e);
		}
		return cnt;
	}
	
	
	@SuppressWarnings("unchecked")
	public List selectDealPjtList(HashMap paramMap){
		List list = null;
		
		try{
			paramMap.put("need_corp_no", paramMap.get("corp_no"));
			
			list = techsupDao.selectDealPjtList(paramMap); 
	     
		}catch(Exception e){
			logger.error(e, e);
		}
		return list;
	}
	
	
	@SuppressWarnings("unchecked")
	public boolean dealPjtInsert(Map map){
		boolean retBoolean = false;
		try{ 
			techsupDao.dealPjtInsert(map);
			String DEAL_PJT_MAX = "CON" + techsupDao.dealPjtMaxSeq(map);
			map.put("cont_no",  DEAL_PJT_MAX);
			map.put("no", 		DEAL_PJT_MAX); 
			List fileList = (List)map.get("uploadList");
			Iterator iterator = fileList.iterator();

			retBoolean = true;
			
		}catch(Exception e){			
			retBoolean = false;
			logger.error(e, e);						
		}
		
		return retBoolean; 
	}
 
	@SuppressWarnings("unchecked")
	public boolean dealPjtUpdate(Map map){
		boolean retBoolean = false;
		try{
			List fileList = (List)map.get("uploadList");
			Iterator iterator = fileList.iterator();
			if(fileList.size() > 0){
				while(iterator.hasNext()){
					HashMap fMap = (HashMap)iterator.next();
					
					map.put("file_real_nm", fMap.get("sourceFileName").toString());
					map.put("file_save_nm", fMap.get("saveFileName").toString());
					map.put("file_path", fMap.get("filePath").toString());	
					map.put("file_size", fMap.get("fileSize").toString()); 
					
					map.put("chman_no", "");
					techsupDao.insSupFile(map);			//첨부파일 등록
				} 
			}
			 
			for(int i=1; i<10; i++){
				map.put("add_file_no", map.get("del_chk"+i));
				if(map.get("del_chk"+i)!=null && !map.get("del_chk"+i).equals("")){ 
					techsupDao.delSupFile(map);			//첨부파일 삭제
				}
			}
			
			techsupDao.dealPjtUpdate(map);
			retBoolean = true;
			
		}catch(Exception e){			
			retBoolean = false;
			logger.error(e, e);						
		}
		
		return retBoolean; 
	}
	
 
	@SuppressWarnings("unchecked")
	public boolean dealPjtDelete(Map map){
		boolean retBoolean = false;
		try{
			techsupDao.dealPjtProdDelete(map);
			techsupDao.dealPjtDelete(map);
			
			retBoolean = true;
			
		}catch(Exception e){			
			retBoolean = false;
			logger.error(e, e);						
		}
		
		return retBoolean; 
	}
	
	@SuppressWarnings("unchecked")
	public boolean dealPjtUseDelete(Map map){
		boolean retBoolean = false;
		try{
			techsupDao.dealPjtUseDelete(map);
			
			retBoolean = true;
			
		}catch(Exception e){			
			retBoolean = false;
			logger.error(e, e);						
		}
		
		return retBoolean; 
	}
	
	
	
	
	@SuppressWarnings("unchecked")
	public HashMap selectDealPjtView(Map map) throws Exception
	{
		HashMap rMap = new HashMap();
		try
		{
			rMap = techsupDao.selectDealPjtView(map);
			
		}catch(Exception e)
		{			
			throw new Exception();
		}
		
		return rMap;
	}
	
 
	@SuppressWarnings("unchecked")
	public int dealPjtMaxSeq(HashMap map){
		int cnt = 0;
		try{
			
			//cnt = techsupDao.dealPjtMaxSeq(map);
			
		}catch(Exception e){
			logger.error(e, e);
		}
		return cnt;
	}
	
	@SuppressWarnings("unchecked")
	public boolean dealPjtChmanInsert(Map map){
		boolean retBoolean = false;
		try{
			  	
			techsupDao.dealPjtChmanInsert(map);
			retBoolean = true;
			
		}catch(Exception e){			
			retBoolean = false;
			logger.error(e, e);						
		}
		
		return retBoolean; 
	}
	
	@SuppressWarnings("unchecked")
	public boolean dealPjtProdInsert(Map map){
		boolean retBoolean = false;
		try{
			  	
			techsupDao.dealPjtProdInsert(map);
			retBoolean = true;
			
		}catch(Exception e){			
			retBoolean = false;
			logger.error(e, e);						
		}
		
		return retBoolean; 
	}
	
	@SuppressWarnings("unchecked")
	public boolean dealPjtChmanDelete(Map map){
		boolean retBoolean = false;
		try{
			  	
			techsupDao.dealPjtChmanDelete(map);
			retBoolean = true;
			
		}catch(Exception e){			
			retBoolean = false;
			logger.error(e, e);						
		}
		
		return retBoolean; 
	}
	
	@SuppressWarnings("unchecked")
	public boolean dealPjtProdDelete(Map map){
		boolean retBoolean = false;
		try{
			  	
			techsupDao.dealPjtProdDelete(map);
			retBoolean = true;
			
		}catch(Exception e){			
			retBoolean = false;
			logger.error(e, e);						
		}
		
		return retBoolean; 
	}
 
	
	/****************************************계약정보 End***************************************/
	
	@SuppressWarnings("unchecked")
	public HashMap techAppStatus(HashMap paramMap){
		HashMap rMap = new HashMap();
		try{
			rMap = techsupDao.techAppStatus(paramMap); 
	     
		}catch(Exception e){
			logger.error(e, e);
		}
		return rMap;
	}
	
	@SuppressWarnings("unchecked")
	public List techSupChman(HashMap paramMap){
		List list = null;
		HashMap rMap = new HashMap();
		try{
			list = techsupDao.techSupChman(paramMap); 
	     
		}catch(Exception e){
			logger.error(e, e);
		}
		return list;
	}
	
	@SuppressWarnings("unchecked")
	public HashMap selectScheduleView(HashMap paramMap){
		HashMap rMap = new HashMap();
		try{
			rMap = techsupDao.selectScheduleView(paramMap); 
	     
		}catch(Exception e){
			logger.error(e, e);
		}
		return rMap;
	}
	
	@SuppressWarnings("unchecked")
	public List getTechSupAppTalk(HashMap paramMap){
		List list = null;
		HashMap rMap = new HashMap();
		try{
			list = techsupDao.getTechSupAppTalk(paramMap); 
	     
		}catch(Exception e){
			logger.error(e, e);
		}
		return list;
	}
	 
	
	@SuppressWarnings("unchecked")
	public boolean insertTechSupAppTalk(Map map){
		boolean retBoolean = false;
		try{
			  	
			techsupDao.insertTechSupAppTalk(map);
			retBoolean = true;
			
		}catch(Exception e){			
			retBoolean = false;
			logger.error(e, e);						
		}
		
		return retBoolean; 
	}
	
	@SuppressWarnings("unchecked")
	public boolean deleteTechSupAppTalk(Map map){
		boolean retBoolean = false;
		try{
			  	
			techsupDao.deleteTechSupAppTalk(map);
			retBoolean = true;
			
		}catch(Exception e){			
			retBoolean = false;
			logger.error(e, e);						
		}
		
		return retBoolean; 
	}
	
	@SuppressWarnings("unchecked")
	public List techSupAppTot(HashMap paramMap){
		List list = null;
		HashMap rMap = new HashMap();
		try{
			list = techsupDao.techSupAppTot(paramMap); 
	     
		}catch(Exception e){
			logger.error(e, e);
		}
		return list;
	}
	
	
}
