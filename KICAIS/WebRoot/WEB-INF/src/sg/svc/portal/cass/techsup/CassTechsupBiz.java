package sg.svc.portal.cass.techsup;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map; 

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import sg.svc.portal.bass.product.ifac.IProductDao;
import sg.svc.portal.cass.techsup.ifac.ICassTechsupDao;
import sg.svc.portal.util.NewPageNavigator;
import sg.svc.portal.util.ServiceUtil;
 
import com.signgate.core.config.SGConfigManager;
import com.signgate.core.exception.BizException;
import com.signgate.core.web.biz.BaseDownloadBiz;
import com.signgate.core.web.servlet.vo.DownloadFileBean;
import com.signgate.core.web.util.PageNavigator;
import com.signgate.core.web.util.WebUtil;
 

 
public class CassTechsupBiz extends BaseDownloadBiz {
	
	private static final HttpServletRequest request = null;

	NewPageNavigator pageNavi = new NewPageNavigator();
	
	protected final Log logger = LogFactory.getLog(getClass());
	
	private ICassTechsupDao cassTechsupDao; 
	
	public void setCassTechsupDao(ICassTechsupDao cassTechsupDao)	{
		this.cassTechsupDao = cassTechsupDao;
	}
	
	private IProductDao productDao; 
	public void setProductDao(IProductDao productDao)	{
		this.productDao = productDao;
	}
	
	@SuppressWarnings("unchecked")
	public DownloadFileBean selFileInfo(Map parameterMap) {
		DownloadFileBean dfb = null;
		try{ 
			dfb = (DownloadFileBean)cassTechsupDao.getDownloadFile((HashMap)parameterMap);
			
		}catch(Exception e){
			logger.error(e, e);
		}
		return dfb;
	}
	
	
	@SuppressWarnings("unchecked")
	public List selCassFile(HashMap paramMap){
		List list = null;
		
		try{
				list = cassTechsupDao.selCassFile(paramMap);
	     
		}catch(Exception e){
			logger.error(e, e);
		}
		return list;
	}
	
	
	@SuppressWarnings("unchecked")
	public String cassAppNo(HashMap map){
		String cassID="";
		try{ 			
				cassID = cassTechsupDao.cassAppNo(map);
			
		}catch(Exception e){
			logger.error(e, e);
		}
		return cassID;
	}
	
	
	
	@SuppressWarnings("unchecked")
	public boolean insertCassStep1(HashMap map){
		boolean retBoolean = false;
		try{
			
			cassTechsupDao.insertCassStep1(map);
			
			List fileList = (List)map.get("uploadList");
			Iterator iterator = fileList.iterator();
			
			while(iterator.hasNext()){
				HashMap fMap = (HashMap)iterator.next();
				map.put("file_real_nm", fMap.get("sourceFileName").toString());
				map.put("file_save_nm", fMap.get("saveFileName").toString());
				map.put("file_path", fMap.get("filePath").toString());	
				map.put("file_size", fMap.get("fileSize").toString());
				map.put("c_tech_sup_st_no", "1");
			 
				cassTechsupDao.insCassFile(map);			 
			}
			
			 
			for(int i=1; i<10; i++){
				map.put("add_file_no", map.get("st_del_chk"+i));
				if(map.get("st_del_chk"+i)!=null && !map.get("st_del_chk"+i).equals("")){ 
					cassTechsupDao.delCassFile(map);
				}
			}

			
			if(map.get("dev_chman_no") != null && map.get("dev_chman_no") != ""){ 
				String[] dev_chman_no =  map.get("dev_chman_no").toString().replace(" ", "").split(",");
				if(dev_chman_no.length > 1){
					for(int i=1;i<dev_chman_no.length;i++){
						map.put("c_corp_chman_no", dev_chman_no[i].replace("[", "").replace("]", ""));
						cassTechsupDao.insertCassStep3(map);
					}
					map.put("c_tech_sup_pr_id", "6");
					cassTechsupDao.insertCassHistory(map);	
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
	public boolean insertCassStep2(HashMap map){
		boolean retBoolean = false;
		try{   			
 		 
			if(map.get("c_tech_sup_cate_no") != null && map.get("c_tech_sup_cate_no") != ""){ 
				String[] c_tech_sup_cate_no =  map.get("c_tech_sup_cate_no").toString().replace(" ", "").split(","); 
				if(c_tech_sup_cate_no.length > 1){
					for(int i=1;i<c_tech_sup_cate_no.length;i++){
						//map.put("c_tech_sup_cate_no", c_tech_sup_cate_no[i].replace("[", "").replace("]", ""));
						cassTechsupDao.insertCassStep2(map);
					}
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
	public boolean insertCassStep3(HashMap map){
		boolean retBoolean = false;
		try{   			
			
			if(map.get("dev_chman_no") != null && map.get("dev_chman_no") != ""){
				String[] dev_chman_no =  map.get("dev_chman_no").toString().replace(" ", "").split(",");
				if(dev_chman_no.length > 1){
					for(int i=1;i<dev_chman_no.length;i++){
						map.put("c_corp_chman_no", dev_chman_no[i].replace("[", "").replace("]", ""));
						cassTechsupDao.insertCassStep3(map);
					}
				}
			}
			
			String[] del_seq =  map.get("del_seq").toString().replace(" ", "").split(",");
			if(del_seq.length > 1){
				for(int i=1;i<del_seq.length;i++){
					map.put("c_corp_chman_no", del_seq[i].replace("[", "").replace("]", "")); 
					cassTechsupDao.deleteCassStep3(map);
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
	public boolean insertCassHistory(HashMap map){
		boolean retBoolean = false;
		try{   	
			
			cassTechsupDao.insertCassHistory(map);	
			retBoolean = true;	
			
		}catch(Exception e){			
			retBoolean = false;
			logger.error(e, e);						
		}		
		return retBoolean; 
	} 
	
	
	@SuppressWarnings("unchecked")
	public boolean insertCassStep1_1(HashMap map){
		boolean retBoolean = false;
		try{   					 
			cassTechsupDao.insertCassStep1_1(map);	
			
			 
			retBoolean = true;				
		}catch(Exception e){			
			retBoolean = false;
			logger.error(e, e);						
		}		
		return retBoolean; 
	}
	
	@SuppressWarnings("unchecked")
	public boolean insertCassStep1_2(HashMap map){
		boolean retBoolean = false;
		try{   					 
			cassTechsupDao.insertCassStep1_2(map);			
			 
			 
			retBoolean = true;			
		}catch(Exception e){			
			retBoolean = false;
			logger.error(e, e);						
		}		
		return retBoolean; 
	}
	
	@SuppressWarnings("unchecked")
	public boolean insertCassStep1_3(HashMap map){
		boolean retBoolean = false;
		try{   					 
			cassTechsupDao.insertCassStep1_3(map);		
			
			retBoolean = true;			
		}catch(Exception e){			
			retBoolean = false;
			logger.error(e, e);						
		}		
		return retBoolean; 
	}
	
	
	@SuppressWarnings("unchecked")
	public boolean deleteCassStep1(HashMap map){
		boolean retBoolean = false;
		try{   					 
			cassTechsupDao.deleteCassStep1(map);	 			
			retBoolean = true;				
		}catch(Exception e){			
			retBoolean = false;
			logger.error(e, e);						
		}		
		return retBoolean; 
	}
	
	@SuppressWarnings("unchecked")
	public boolean deleteCassStep2(HashMap map){
		boolean retBoolean = false;
		try{   					 
			cassTechsupDao.deleteCassStep2(map);	 			
			retBoolean = true;				
		}catch(Exception e){			
			retBoolean = false;
			logger.error(e, e);						
		}		
		return retBoolean; 
	}
	
	@SuppressWarnings("unchecked")
	public boolean deleteCassStep3(HashMap map){
		boolean retBoolean = false;
		try{   					 
			cassTechsupDao.deleteCassStep3(map);	 			
			retBoolean = true;				
		}catch(Exception e){			
			retBoolean = false;
			logger.error(e, e);						
		}		
		return retBoolean; 
	}
	
	@SuppressWarnings("unchecked")
	public boolean updateCassStep1(HashMap map){
		boolean retBoolean = false;
		try{ 
			
			cassTechsupDao.updateCassStep1(map);  
			
			List fileList = (List)map.get("uploadList");
			Iterator iterator = fileList.iterator();
			
			while(iterator.hasNext()){
				HashMap fMap = (HashMap)iterator.next();
				map.put("file_real_nm", fMap.get("sourceFileName").toString());
				map.put("file_save_nm", fMap.get("saveFileName").toString());
				map.put("file_path", fMap.get("filePath").toString());	
				map.put("file_size", fMap.get("fileSize").toString());
				map.put("c_tech_sup_st_no", "1");
				 
				cassTechsupDao.insCassFile(map);			 
			}
			
			
			for(int i=1; i<10; i++){
				map.put("add_file_no", map.get("del_chk"+i));
				if(map.get("del_chk"+i)!=null && !map.get("del_chk"+i).equals("")){ 
					cassTechsupDao.delCassFile(map);
				}
			}

			 
			
			if(map.get("dev_chman_no") != null && map.get("dev_chman_no") != ""){ 
				String[] dev_chman_no =  map.get("dev_chman_no").toString().replace(" ", "").split(",");
				if(dev_chman_no.length > 1){
					for(int i=1;i<dev_chman_no.length;i++){
						map.put("c_corp_chman_no", dev_chman_no[i].replace("[", "").replace("]", ""));
						cassTechsupDao.insertCassStep3(map);
					}
					map.put("c_tech_sup_pr_id", "6");
					cassTechsupDao.insertCassHistory(map);
				}  
			} 
			
			
			String[] del_seq =  map.get("del_seq").toString().replace(" ", "").split(",");
			if(del_seq.length > 1){
				for(int i=1;i<del_seq.length;i++){
					map.put("c_tech_sup_corp_seq", del_seq[i].replace("[", "").replace("]", "")); 
					cassTechsupDao.deleteCassStep3(map);
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
	public HashMap getCassView(Map map) throws Exception{
		HashMap rMap = new HashMap();
		try{
			rMap = cassTechsupDao.getCassView(map);
		}catch(Exception e){			
			throw new Exception();
		}		
		return rMap;
	}
	
	@SuppressWarnings("unchecked")
	public HashMap getCassViewCate(Map map) throws Exception{
		HashMap rMap = new HashMap();
		try{
			rMap = cassTechsupDao.getCassViewCate(map);
		}catch(Exception e){			
			throw new Exception();
		}		
		return rMap;
	}
	
 
	
	@SuppressWarnings("unchecked")
	public List getCassViewCorp(HashMap paramMap){
		List list = null;
		
		try{
			String pageNum = WebUtil.nullCheck((String)paramMap.get("pageNum"),"1");
			String pageSize = WebUtil.nullCheck((String)paramMap.get("pageSize"),"100");
			
			int totCnt = 1000;
	    	 
			NewPageNavigator pageNavi = new NewPageNavigator();
			pageNavi.setParameterMap(paramMap);
			pageNavi.setTotalRow(totCnt);
			pageNavi.setPageSize(Integer.parseInt(pageSize));
			pageNavi.setCurrentPage(Integer.parseInt(pageNum));
	    	
			paramMap.put("pageSize", pageSize);
			paramMap.put("pageNum", pageNum);
			paramMap.put("pageNavi", pageNavi);
			 
			list = cassTechsupDao.getCassViewCorp(paramMap); 
	     
		}catch(Exception e){
			logger.error(e, e);
		}
		return list;
	}
	
	 
	
	@SuppressWarnings("unchecked")
	public List getCassViewHis(HashMap paramMap){
		List list = null;
		
		try{
			 
			list = cassTechsupDao.getCassViewHis(paramMap); 
	     
		}catch(Exception e){
			logger.error(e, e);
		}
		return list;
	}
	
	
	
	@SuppressWarnings("unchecked")
	public List getCassView1(HashMap paramMap){
		List list = null;
		
		try{
			 
			list = cassTechsupDao.getCassView1(paramMap); 
	     
		}catch(Exception e){
			logger.error(e, e);
		}
		return list;
	}
	
	
	@SuppressWarnings("unchecked")
	public List getCassView2(HashMap paramMap){
		List list = null;
		
		try{
			 
			list = cassTechsupDao.getCassView2(paramMap); 
	     
		}catch(Exception e){
			logger.error(e, e);
		}
		return list;
	}
	
	 
	@SuppressWarnings("unchecked")
	public List getCassView3(HashMap paramMap){
		List list = null;
		
		try{
			
			list = cassTechsupDao.getCassView3(paramMap); 
	     
		}catch(Exception e){
			logger.error(e, e);
		}
		return list;
	}
	
	
	@SuppressWarnings("unchecked")
	public int getCassCount(HashMap paramMap){
		int cnt = 0;
		try{
			cnt =  cassTechsupDao.getCassCount(paramMap);
			
		}catch(Exception e){
			logger.error(e, e);
		}
		return cnt;
	} 
	
	@SuppressWarnings("unchecked")
	public List getCassList(HashMap paramMap){
		List list = null;
		
		try{
			String pageNum = WebUtil.nullCheck((String)paramMap.get("pageNum"),"1");
			String pageSize = WebUtil.nullCheck((String)paramMap.get("pageSize"),"10");
			
			int totCnt = cassTechsupDao.getCassCount(paramMap);
	    	 
			NewPageNavigator pageNavi = new NewPageNavigator();
			pageNavi.setParameterMap(paramMap);
			pageNavi.setTotalRow(totCnt);
			pageNavi.setPageSize(Integer.parseInt(pageSize));
			pageNavi.setCurrentPage(Integer.parseInt(pageNum));
	    	
			paramMap.put("pageSize", pageSize);
			paramMap.put("pageNum", pageNum);
			paramMap.put("pageNavi", pageNavi);
			 
			list = cassTechsupDao.getCassList(paramMap); 
	     
		}catch(Exception e){
			logger.error(e, e);
		}
		return list;
	}
	
	
	
	
	
	
	
}
