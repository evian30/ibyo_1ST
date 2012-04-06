package sg.svc.portal.bass.product;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.servlet.ModelAndView;

import sg.svc.portal.bass.chman.ChmanBiz;
import sg.svc.portal.bass.techsup.TechsupBiz;

import com.signgate.core.config.SGConfigManager;
import com.signgate.core.exception.BizException;
import com.signgate.core.exception.SGFileUploadException;
import com.signgate.core.util.StringUtil;
import com.signgate.core.web.controller.SGAdminController;
import com.signgate.core.web.util.SGFileBean;
import com.signgate.core.web.util.WebUtil;

/**
 *  ClassName  : ProductController
 *  기능                : 제품 등록/조회/수정/삭제/팝업 처리(CLUD)
 * @author simshu
 *
 */
public class ProductController extends SGAdminController {
	protected final Log logger = LogFactory.getLog(getClass());
	
	private ProdcutBiz productBiz;
	private TechsupBiz techsupBiz; 
	
	public void setTechsupBiz(TechsupBiz techsupBiz){
		this.techsupBiz = techsupBiz;
	}	
	
	public void setProductBiz(ProdcutBiz productBiz){
		this.productBiz =productBiz;
	}
	 
	 
	 /** 
		 * Method ID  	:  productAdd
		 * Method 설명  	:  
		 * 최초작성일  	: 2010. 8. 26.  
		 * 작성자 		:  simshu
		 * 특이사항		:
		 * 변경이력 		:  
		 * 
		 * @param   
		 * @param  
		 * @throws  
		 * @return ModelAndView
		 */ 
	public ModelAndView productAdd(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = null;
		mav = new ModelAndView();
		HashMap map = WebUtil.parseRequestMap(request);
		
		try {
			mav.addObject("pMap",map);	 
			mav.addObject("osList", productBiz.osList(map));	 //제품권장 OS 정보
			mav.addObject("swList", productBiz.swList(map));	 
			mav.addObject("swNameList", productBiz.swNameList(map));	 
			mav.addObject("location","");	
			mav.addObject("resultMessage","");	
		} catch (Exception e) {
			logger.error(e, e);
		}
		return mav;
	 }

	/** 
		 * Method ID  	:  productModify
		 * Method 설명  	:  
		 * 최초작성일  	: 2010. 8. 26.  
		 * 작성자 		:  simshu
		 * 특이사항		:
		 * 변경이력 		:  
		 * 
		 * @param   
		 * @param  
		 * @throws  
		 * @return ModelAndView
		 */ 
	public ModelAndView productModify(HttpServletRequest request, HttpServletResponse response) {
		 ModelAndView mav = null;
		 mav = new ModelAndView();
		HashMap map = WebUtil.parseRequestMap(request);
		try {
			productBiz.updateProduct(map);
		} catch (BizException e) {
			e.printStackTrace();
		}
		mav.addObject("pMap",map);	 
		mav.addObject("location","");	
		mav.addObject("resultMessage","");	
		return mav;
	 }
	
	/** 
		 * Method ID  	: productList
		 * Method 설명  	:  
		 * 최초작성일  	: 2010. 8. 26.  
		 * 작성자 		:  simshu
		 * 특이사항		:
		 * 변경이력 		:  
		 * 
		 * @param   
		 * @param  
		 * @throws  
		 * @return ModelAndView
		 */ 
	public ModelAndView productList(HttpServletRequest request, HttpServletResponse response) throws Exception{
		ModelAndView mav = null;
		try{
			mav = new ModelAndView();
			HashMap map = WebUtil.parseRequestMap(request);
			HashMap adminMap = (HashMap)request.getSession().getAttribute(SGConfigManager.getString("common.session.admin.name"));
			map.put("admin_id", (String)adminMap.get("ADMIN_ID"));
			map.put("groups", (String)adminMap.get("GROUPS"));
			map.put("chman_no", (String)adminMap.get("SABUN"));
			
			if(map.get("viewName") == null || map.get("viewName") == ""){
				
			}else{
				mav.setViewName(map.get("viewName").toString());
			}
			
			mav.addObject("productList", productBiz.getProductList(map));
			mav.addObject("devChmanList", productBiz.prodDevChmanList(map));
			
			mav.addObject("pMap",map);
			mav.addAllObjects(map); 
			
		} catch (Exception e) {
			logger.error(e, e);
		}
		return mav;
	}

	
	/** 
	 * Method ID  	: productListXML
	 * Method 설명  	:  
	 * 최초작성일  	: 2010. 8. 26.  
	 * 작성자 		:  simshu
	 * 특이사항		:
	 * 변경이력 		:  
	 * 
	 * @param   
	 * @param  
	 * @throws  
	 * @return ModelAndView
	 */ 
	public ModelAndView productListXML(HttpServletRequest request, HttpServletResponse response) throws Exception{
		ModelAndView mav = null;
		try{
			mav = new ModelAndView();
			HashMap map = WebUtil.parseRequestMap(request);
			mav.setViewName("/sgportal/sgAjax");
			
			HashMap paraMap = productBiz.listProductXML(map, request);
			
			mav.addObject("pMap",map);
			mav.addObject("result", paraMap.get("result"));
			mav.addAllObjects(map); 
			
		} catch (Exception e) {
			logger.error(e, e);
		}
		return mav;
	}
	
	 /** 
		 * Method ID  	:  productInfo
		 * Method 설명  	:  
		 * 최초작성일  	: 2010. 8. 26.  
		 * 작성자 		:  simshu
		 * 특이사항		:
		 * 변경이력 		:  
		 * 
		 * @param   
		 * @param  
		 * @throws  
		 * @return ModelAndView
		 */ 
	public ModelAndView productInfo(HttpServletRequest request, HttpServletResponse response) {
		 ModelAndView mav = null;
		 mav = new ModelAndView();
			HashMap map = WebUtil.parseRequestMap(request);
		   try {
			mav.addObject("productView", 	productBiz.getProduct(map));
			
		} catch (BizException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		   mav.addObject("pMap",map);	 
			mav.addObject("location","");	
			mav.addObject("resultMessage","");	
		   return mav;
	 }
	
	 /** 
		 * Method ID  	:  productDelete
		 * Method 설명  	:  
		 * 최초작성일  	: 2010. 8. 26.  
		 * 작성자 		:  simshu
		 * 특이사항		:
		 * 변경이력 		:  
		 * 
		 * @param   
		 * @param  
		 * @throws  
		 * @return ModelAndView
		 */ 
	public ModelAndView productDelete(HttpServletRequest request, HttpServletResponse response) {
		 ModelAndView mav = null;
		 mav = new ModelAndView();
		HashMap map = WebUtil.parseRequestMap(request);
		HashMap sessionMap = (HashMap)WebUtil.getSessionAttribute(request, SGConfigManager.getString("common.session.sgportal.name"));	
		try {
			productBiz.deleteProduct(map);
		} catch (BizException e) {
			e.printStackTrace();
		}
		mav.addObject("pMap",map);	 
		mav.addObject("location","");	
		mav.addObject("resultMessage","");	
		return mav;
	 }
	
	@SuppressWarnings("unchecked")
	public ModelAndView productAction(HttpServletRequest request, HttpServletResponse response) throws Exception{
		ModelAndView mav = null;
		boolean result=false;
		try{
			mav = new ModelAndView();
			HashMap map = WebUtil.parseRequestMap(request);
			
			//첨부파일
			SGFileBean sgfb = new SGFileBean("");			
			WebUtil.processMultipart(request, sgfb, map); 
			String actType = map.get("actType").toString(); 
			mav.setViewName("/sgportal/productAction"); 
			
			HashMap adminMap = (HashMap)request.getSession().getAttribute(SGConfigManager.getString("common.session.admin.name"));
			map.put("groups", (String)adminMap.get("GROUPS"));
			map.put("admin_id", (String)adminMap.get("ADMIN_ID"));
			map.put("chman_no", (String)adminMap.get("SABUN"));
			
			if("ins".equals(actType)){
				map.put("command", "ins");
				result = productBiz.insertProduct(map);
			}else if("mod".equals(actType)){
				map.put("no", map.get("prod_no"));
				map.put("command", "mod");
				result = productBiz.updateProduct(map);
			}else if("del".equals(actType)){
				map.put("no", map.get("prod_no"));
				map.put("command", "del");
				result = productBiz.deleteProduct(map);
			}else if("useYn".equals(actType)){
				map.put("no", map.get("prod_no"));
				if(map.get("use_yn").equals("Y")){
					map.put("command", "delY");
				}else{
					map.put("command", "del");
				}
				result = productBiz.deleteUseProduct(map);
			}
			
			mav.addObject("result", result); 	
			mav.addObject("pMap",map);	  
			mav.addAllObjects(map); 
			
		} catch (Exception e) {
			logger.error(e, e);
		}
		return mav;
	}
	
	@SuppressWarnings("unchecked")
	public ModelAndView prodAction(HttpServletRequest request, HttpServletResponse response) throws Exception{
		ModelAndView mav = null;
		try{
			mav = new ModelAndView();
			HashMap map = WebUtil.parseRequestMap(request);
			
			HashMap adminMap = (HashMap)request.getSession().getAttribute(SGConfigManager.getString("common.session.admin.name"));
			map.put("groups", (String)adminMap.get("GROUPS"));
			map.put("admin_id", (String)adminMap.get("ADMIN_ID"));
			map.put("chman_no", (String)adminMap.get("SABUN"));
			
			String actType = map.get("actType").toString();
			
			if("ins".equals(actType)){ 
				mav.addObject("osList",		productBiz.osList(map));	 //제품권장 OS 정보
				mav.addObject("swList", 	productBiz.swList(map));
				mav.addObject("swNameList", productBiz.swNameList(map));				
				
			}else if("view".equals(actType)){ 
				map.put("no", map.get("prod_no"));
				mav.addObject("fileView", techsupBiz.selSupFile(map));  				//첨부파일
				
				mav.setViewName("/sgportal/product/productAdd"); 
				//  제품정보
				mav.addObject("productView", 		productBiz.getProduct(map));
				//  개발담당자 정보
				mav.addObject("productDevChman", 	productBiz.prodDevChmanList(map));
				//  제품권장 OS정보
				mav.addObject("productOs", 			productBiz.prodRecmdOsList(map));
				//  제품권장 SW정보
				mav.addObject("productSw", 			productBiz.prodRecmdSwList(map));
				
				mav.addObject("osList", 			productBiz.osList(map));	 //제품권장 OS 정보
				mav.addObject("swList", 			productBiz.swList(map));
				mav.addObject("swNameList", 		productBiz.swNameList(map));	
				
			}else if("mod".equals(actType)){ 
				map.put("no", map.get("prod_no"));
				mav.addObject("fileView", techsupBiz.selSupFile(map));  				//첨부파일
				
				mav.setViewName("/sgportal/product/productAdd"); 
				//  제품정보
				mav.addObject("productView", 		productBiz.getProduct(map));
				//  개발담당자 정보
				mav.addObject("productDevChman", 	productBiz.prodDevChmanList(map));
				//  제품권장 OS정보
				mav.addObject("productOs", 			productBiz.prodRecmdOsList(map));
				//  제품권장 SW정보
				mav.addObject("productSw", 			productBiz.prodRecmdSwList(map));
				
				mav.addObject("osList", 			productBiz.osList(map));	 //제품권장 OS 정보
				mav.addObject("swList", 			productBiz.swList(map));
				mav.addObject("swNameList", 		productBiz.swNameList(map));
				
			}
			
			mav.addObject("pMap",map);
			mav.addAllObjects(map); 
			
		} catch (Exception e) {
			logger.error(e, e);
		}
		return mav;
	}
  
	/**
	 * XML로 출력
	 * @param request
	 * @param response
	 * @return
	 */
	public ModelAndView testXml(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = null;
		try {
			mav = new ModelAndView();			
			Map map = WebUtil.parseRequestMap(request);		
			
			HashMap sessionMap = (HashMap)WebUtil.getSessionAttribute(request, SGConfigManager.getString("common.session.admin.name"));						
			HashMap paraMap = productBiz.getXml(map, request);
			
			mav.setViewName("/sgportal/sgAjax");
			
			mav.addObject("result", paraMap.get("result"));
			mav.addObject("pageNavi", paraMap.get("pageNavi"));
			
			mav.addObject("pMap", map);
		} catch (Exception e) {
			logger.error(e, e);
		}
		return mav;
	}
	
}
