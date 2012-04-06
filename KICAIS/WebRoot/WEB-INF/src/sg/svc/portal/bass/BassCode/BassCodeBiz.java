package sg.svc.portal.bass.BassCode;

import java.util.HashMap;
import java.util.List;
import java.util.Map; 
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import sg.svc.portal.bass.BassCode.ifac.IBassCodeDao; 
import sg.svc.portal.util.NewPageNavigator;
 
import com.signgate.core.exception.BizException;
import com.signgate.core.web.util.PageNavigator;
import com.signgate.core.web.util.WebUtil;
 

 
public class BassCodeBiz {
	
	//PageNavigator pageNavi = new PageNavigator();
	NewPageNavigator pageNavi = new NewPageNavigator();
	
	protected final Log logger = LogFactory.getLog(getClass());
	
	private IBassCodeDao bassCodeDao; 
	public void setBassCodeDao(IBassCodeDao bassCodeDao)
	{
		this.bassCodeDao = bassCodeDao;
	}
	
	  
	 
	@SuppressWarnings("unchecked")
	public List listData(HashMap paramMap){
		List list = null;
		
		try{
			list = null;
			
			String pageNum = WebUtil.nullCheck((String)paramMap.get("pageNum"),"1");
			String pageSize = WebUtil.nullCheck((String)paramMap.get("pageSize"),"10");
			
			int eventCount = 0; 
				
			if(paramMap.get("cd_type").equals("Group")){
				eventCount = bassCodeDao.selectTotCountGr(paramMap);
			}else{
				eventCount = bassCodeDao.selectTotCountDe(paramMap);
			}
			
			
	    	
			//PageNavigator pageNavi = new PageNavigator();
			NewPageNavigator pageNavi = new NewPageNavigator();
			
			pageNavi.setParameterMap(paramMap);
			pageNavi.setTotalRow(eventCount);
			pageNavi.setPageSize(Integer.parseInt(pageSize));
			pageNavi.setCurrentPage(Integer.parseInt(pageNum));
	    	
	    	paramMap.put("pageSize", pageSize);
			paramMap.put("pageNum", pageNum);
			paramMap.put("pageNavi", pageNavi);
			
			list = null;
			if(paramMap.get("cd_type").equals("Group")){
				list = bassCodeDao.listDataGr(paramMap);
			}else{
				list = bassCodeDao.listDataDe(paramMap);
			}
			
			
		}catch(Exception e){
			logger.error(e, e);
		}
		return list;
	}
	 
	
	@SuppressWarnings("unchecked")
	public HashMap selectData(Map map) throws Exception
	{
		HashMap rMap = new HashMap();
		try{
			rMap = bassCodeDao.selectData(map);
			
		}catch(Exception e){			
			throw new Exception();
		}
		
		return rMap;
	}
	 
	 
	@SuppressWarnings("unchecked")
	public int selectTotCount(HashMap map){
		int cnt = 0;
		try{
			
			if(map.get("cd_type").equals("Group")){
				cnt = bassCodeDao.selectTotCountGr(map);
			}else{
				cnt = bassCodeDao.selectTotCountDe(map);
			}
			 
		}catch(Exception e){
			logger.error(e, e);
		}
		return cnt;
	}
	 
	 
	@SuppressWarnings("unchecked")
	public boolean bassAction(HashMap map, String actType) throws BizException{
		boolean retTrue = false;
		try{
			 
			int dupCheck = bassCodeDao.check(map); 
			
			
				if(actType.equals("ins")){  
					if(dupCheck == 0){ 
						bassCodeDao.insertData(map);
					}
				}else if(actType.equals("mod")){
					if(dupCheck == 1){ 
						bassCodeDao.updateData(map);
					}
				}else if(actType.equals("del")){
					if(dupCheck == 1){
						bassCodeDao.deleteData(map);
					}
					
				}
				
				retTrue = true;
			  
			
		}catch(Exception e){
			retTrue = false;
			logger.error(e, e);
			throw new  BizException("");
		}
		return retTrue;
		
	}
	
	 
	 
	
	 

}
