package sg.svc.portal.bass.product;

import java.util.ArrayList;
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

import com.signgate.core.exception.BizException;
import com.signgate.core.exception.DaoException;
import com.signgate.core.web.servlet.vo.DownloadFileBean;
import com.signgate.core.web.util.PageNavigator;
import com.signgate.core.web.util.WebUtil;

public class ProdcutBiz {
	NewPageNavigator pageNavi = new NewPageNavigator();
	
	protected final Log logger = LogFactory.getLog(getClass());
	
	private ITechsupDao techsupDao; 
	public void setTechsupDao(ITechsupDao techsupDao)
	{
		this.techsupDao = techsupDao;
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
	
	private IProductDao productDao; 
	public void setProductDao(IProductDao productDao)
	{
		this.productDao = productDao;
	}
	
	@SuppressWarnings("unchecked")
	public boolean insertProduct(HashMap map) throws BizException {
		boolean retBoolean = false;
		try {
			String prod_no = productDao.productMax(map);
			map.put("prod_no", prod_no);
			
			//  제품등록
			productDao.insertProduct(map);
			
			List fileList = (List)map.get("uploadList");
			Iterator iterator = fileList.iterator();
			map.put("no", prod_no);
			while(iterator.hasNext()){
				HashMap fMap = (HashMap)iterator.next();
				map.put("file_real_nm", fMap.get("sourceFileName").toString());
				map.put("file_save_nm", fMap.get("saveFileName").toString());
				map.put("file_path", fMap.get("filePath").toString());	
				map.put("file_size", fMap.get("fileSize").toString()); 
				map.put("chman_no", "");
				productDao.insSupFile(map);			//첨부파일 등록
			} 
			
			//  제품권장 WS 등록
			String[] sw_no =  map.get("sw_code").toString().replace(" ", "").split(",");
			for(int i=1;i<sw_no.length;i++){
				map.put("sw_no", sw_no[i].replace("[", "").replace("]", ""));
				productDao.insertProductSW(map);
			}
			
			//  제품개발 담당자
			String[] dev_chman_no =  map.get("dev_chman_no").toString().replace(" ", "").split(",");
			if(dev_chman_no.length > 1){
				for(int i=1;i<dev_chman_no.length;i++){
					map.put("dev_chman_no", dev_chman_no[i].replace("[", "").replace("]", ""));
					productDao.insertProductDev(map);
				}
			}
			
			//  제품권장 OS
			String[] os_no = map.get("os_no").toString().replace(" ", "").split(",");
			if(os_no.length > 1){
				for(int i=1;i<os_no.length;i++){
					map.put("os_no", os_no[i].replace("[", "").replace("]", ""));
					productDao.recmdOsIns(map);
				}
			}
				
			retBoolean = true;
		} catch (DaoException e) {
			retBoolean = false;
           logger.error("제품 등록 오류", e);
           throw new BizException("제품 등록 오류",e.getMessage());
		}
		
		return retBoolean;
		
	}
	
	
	@SuppressWarnings("unchecked")
	public boolean updateProduct(HashMap map) throws BizException{
		boolean retBoolean = false;
		try {
			retBoolean = true;
			
			List fileList = (List)map.get("uploadList");
			Iterator iterator = fileList.iterator();
			
			while(iterator.hasNext()){
				HashMap fMap = (HashMap)iterator.next();
				
				map.put("file_real_nm", fMap.get("sourceFileName").toString());
				map.put("file_save_nm", fMap.get("saveFileName").toString());
				map.put("file_path", fMap.get("filePath").toString());	
				map.put("file_size", fMap.get("fileSize").toString()); 
				map.put("chman_no", "");
				productDao.insSupFile(map);			//첨부파일 등록
			} 
			//  파일삭제
			for(int i=1; i<10; i++){
				map.put("add_file_no", map.get("del_chk"+i));
				if(map.get("del_chk"+i)!=null && !map.get("del_chk"+i).equals("")){ 
					techsupDao.delSupFile(map);			//첨부파일 삭제
				}
			}
			
			//  제품등록
			productDao.updateProduct(map);
			
			//  제품개발 담당자
			String[] dev_chman_no =  map.get("dev_chman_no").toString().replace(" ", "").split(",");
			if(dev_chman_no.length > 1){
				for(int i=1;i<dev_chman_no.length;i++){
					map.put("dev_chman_no", dev_chman_no[i].replace("[", "").replace("]", ""));
					
					productDao.insertProductDev(map);
					
				}
			}
			
			//  개발담당자 삭제
			String[] del_seq =  map.get("del_seq").toString().replace(" ", "").split(",");
			if(del_seq.length > 1){
				for(int i=1;i<del_seq.length;i++){
					map.put("seq", del_seq[i].replace("[", "").replace("]", ""));
					//  제품권장 WS
					productDao.deleteProdDevChman(map);
				}
			}
			
			//  제품권장 OS
			String[] os_no = map.get("os_no").toString().replace(" ", "").split(",");
			if(os_no.length > 1){
				for(int i=1;i<os_no.length;i++){
					map.put("os_no", os_no[i].replace("[", "").replace("]", ""));
					productDao.recmdOsIns(map);
				}
			}
			
			//  제품권장 OS 삭제
			if(map.get("del_os") != null && map.get("del_os") != ""){
				String[] del_os =  map.get("del_os").toString().replace(" ", "").split(",");
				for(int i=1;i<del_os.length;i++){
					map.put("seq", del_os[i].replace("[", "").replace("]", ""));
					//  제품권장 OS
					productDao.deleteProductOS(map);
				}
			}
			
			//  제품권장 SW 등록
			if(map.get("sw_code") != null && map.get("sw_code") != ""){
			String[] sw_no =  map.get("sw_code").toString().replace(" ", "").split(",");
				for(int i=1;i<sw_no.length;i++){
					map.put("sw_no", sw_no[i].replace("[", "").replace("]", ""));
					//  제품권장 WS
					productDao.insertProductSW(map);
				}
			}
			
			//  제품권장 SW 삭제
			if(map.get("del_sw") != null && map.get("del_sw") != ""){
				String[] del_sw =  map.get("del_sw").toString().replace(" ", "").split(",");
				for(int i=1;i<del_sw.length;i++){
					map.put("sw_no", del_sw[i].replace("[", "").replace("]", ""));
					//  제품권장 WS
					productDao.deleteProductSW(map);
				}
			}
			
			
			//  제품권장 WS
			//productDao.updateProductSW(map);
			//  제품개발 담당자
			//productDao.updateProductDev(map);
			//  제품권장 OS
			//productDao.recmdOsMod(map);
			
		} catch (DaoException e) {
			retBoolean = false;
           logger.error("제품  수정 오류", e);
           throw new BizException("제품 수정 오류",e.getMessage());
		}
		return retBoolean;
	}
	
	
	@SuppressWarnings("unchecked")
	public List getProductList(HashMap paramMap){
		List list = null;
		
		try{
			list = null;
			
			String pageNum = WebUtil.nullCheck((String)paramMap.get("pageNum"),"1");
			String pageSize = WebUtil.nullCheck((String)paramMap.get("pageSize"),"10");
			 
			int totCnt = productDao.countProductSelect(paramMap);
	    	 
			NewPageNavigator pageNavi = new NewPageNavigator();
			
			pageNavi.setParameterMap(paramMap);
			pageNavi.setTotalRow(totCnt);
			pageNavi.setPageSize(Integer.parseInt(pageSize));
			pageNavi.setCurrentPage(Integer.parseInt(pageNum));
	    	
			paramMap.put("pageSize", pageSize);
			paramMap.put("pageNum", pageNum);
			paramMap.put("pageNavi", pageNavi);
			 
			list = productDao.listProduct(paramMap);
			
		}catch(Exception e){
			logger.error(e, e);
		}
		return list;
	}
	
	@SuppressWarnings("unchecked")
	public HashMap getProduct(Map map) throws Exception
	{
		HashMap rMap = new HashMap();
		try
		{
			rMap = productDao.getProduct(map);
		}catch(Exception e)
		{			
			throw new Exception();
		}
		return rMap;
	}
	
	public boolean deleteProduct(HashMap map) throws BizException{
		boolean retBoolean = false;
		try {
			productDao.deleteProductSW(map);
			productDao.deleteProductDev(map);
			productDao.deleteProductOS(map);
			productDao.deleteProduct(map);
			
			retBoolean = true;
		} catch (DaoException e) {
           logger.error("제품 등록 오류", e);
           throw new BizException("제품 등록 오류",e.getMessage());
		}
		return retBoolean;
	}
	
	
	public boolean deleteUseProduct(HashMap map) throws BizException{
		boolean retBoolean = false;
		try {
			productDao.deleteUseProduct(map);
			
			retBoolean = true;
		} catch (DaoException e) {
           logger.error("제품 삭제 오류", e);
           throw new BizException("제품 삭제 오류",e.getMessage());
		}
		return retBoolean;
	}
	
	public ArrayList getSWList() throws BizException {
		
		ArrayList swList = null;
		try {
			 swList =productDao.getSWList();
			
		} catch (DaoException e) {
			logger.error("getSWList", e);
			throw new BizException("BZ002","SW 정보 조회 오류");
		}
		return swList;
	}
	
	public HashMap getOsList() throws BizException {
		ArrayList osList = null;
		try {
			 osList =productDao.getOSList();
		} catch (DaoException e) {
			logger.error("getOsList", e);
			throw new BizException("BZ001","OS 정보 조회 오류");
		}	
		return listToMap(osList);
	}
	
	public HashMap getSWNameList() throws BizException {
		ArrayList osList = null;
		try {
			 osList =productDao.getSWNameList();
		} catch (DaoException e) {
			// TODO Auto-generated catch block
			logger.error("getSWNameList", e);
			throw new BizException("BZ003","SW Name 정보 조회 오류");
		}	
		return listToMap(osList);
	}
	
	private HashMap  listToMap(ArrayList list){
		HashMap swMap = new HashMap();
		
		if(list != null && list.size()>0)
			for(int i =0; i<list.size() ; i++){
				HashMap temp = (HashMap)list.get(i);
				swMap.put(temp.get("CODE"), temp.get("VALUE"));
			}
		return swMap;
	}
	
	/**
	 * 제품권장 OS 정보
	 * @param map
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List osList(HashMap paramMap){
		List list = null;
		
		try{
			list =productDao.getOSList();
			
		}catch(Exception e){
			logger.error(e, e);
		}
		return list;
	}
	
	/**
	 * 제품권장 SW 정보
	 * @param map
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List swList(HashMap paramMap){
		List list = null;
		
		try{
			list =productDao.getSWList();
			
		}catch(Exception e){
			logger.error(e, e);
		}
		return list;
	}
	
	/**
	 * 제품권장 SW Name 정보
	 * @param map
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List swNameList(HashMap paramMap){
		List list = null;
		
		try{
			list =productDao.getSWNameList();
			
		}catch(Exception e){
			logger.error(e, e);
		}
		return list;
	}
	
	@SuppressWarnings("unchecked")
	public int prodMaxSeq(HashMap map){
		int cnt = 0;
		try{
			cnt = productDao.prodMaxSeq(map);
			
		}catch(Exception e){
			logger.error(e, e);
		}
		return cnt;
	}
	
	
	/**
	 * 제품권장 SW 정보
	 * @param map
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List prodRecmdSwList(HashMap paramMap){
		List list = null;
		
		try{
			list =productDao.prodRecmdSwList(paramMap);
			
		}catch(Exception e){
			logger.error(e, e);
		}
		return list;
	}
	
	/**
	 * 제품권장 OS 정보
	 * @param map
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List prodRecmdOsList(HashMap paramMap){
		List list = null;
		
		try{
			list =productDao.prodRecmdOsList(paramMap);
			
		}catch(Exception e){
			logger.error(e, e);
		}
		return list;
	}
	
	/**
	 * 개발담당자 정보
	 * @param map
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List prodDevChmanList(HashMap paramMap){
		List list = null;
		
		try{
			list =productDao.prodDevChmanList(paramMap);
			
		}catch(Exception e){
			logger.error(e, e);
		}
		return list;
	}

	/**
	 * 제품정보 XML정보 가져오기
	 * @param map
	 * @param request
	 * @return
	 */
	public HashMap listProductXML(Map map, HttpServletRequest request){
		List list = null;
		HashMap resultMap = new HashMap();
		try{
			list =productDao.listProductXML(resultMap);
	    	StringBuffer pageing = new StringBuffer();
			String result = ServiceUtil.parseXmlMap(list) + pageing.toString();		
			resultMap.put("result", result);									
		}catch(Exception e){
			logger.error(e, e);
		}
		return resultMap;
	}
	
	
	/**
	 * XML정보 가져오기
	 * @param map
	 * @param request
	 * @return
	 */
	public HashMap getXml(Map map, HttpServletRequest request){
		List list = null;
		HashMap resultMap = new HashMap();
		try{
			int rows = 0;
	    	if(map.get("user_rows") == null || map.get("user_rows").toString().equals("")){
	    		rows = 5;
	    	}else{
	    		rows = Integer.parseInt(map.get("user_rows").toString());
	    	}

	    	list =productDao.prodRecmdSwList(map);
	    	
			StringBuffer pageing = new StringBuffer();
			String result = ServiceUtil.parseXmlMap(list) + pageing.toString();		
			resultMap.put("result", result);									
		}catch(Exception e){
			logger.error(e, e);
		}
		return resultMap;
	}
	
}
