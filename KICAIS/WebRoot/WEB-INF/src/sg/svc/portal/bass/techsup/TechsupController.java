package sg.svc.portal.bass.techsup;
 
import java.util.HashMap; 

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse; 

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.servlet.ModelAndView;

import sg.svc.portal.bass.chman.ChmanBiz;
import sg.svc.portal.bass.product.ProdcutBiz;

import com.signgate.core.config.SGConfigManager;
import com.signgate.core.web.controller.SGAdminController;
import com.signgate.core.web.util.SGFileBean;
import com.signgate.core.web.util.WebUtil;

 
public class TechsupController extends SGAdminController {
	
	protected final Log logger = LogFactory.getLog(getClass());
	
	private TechsupBiz techsupBiz; 
	public void settechsupBiz(TechsupBiz techsupBiz){
		this.techsupBiz = techsupBiz;
	}	
	  
	private ChmanBiz chmanBiz; 
	public void setChmanBiz(ChmanBiz chmanBiz){
		this.chmanBiz = chmanBiz;
	}	
	
	private ProdcutBiz productBiz;
	public void setProductBiz(ProdcutBiz productBiz){
		this.productBiz =productBiz;
	}
	
	/** 
	 * Method ID  	: techsupApp
	 * Method 설명  	: 기술지원 목록
	 * 최초작성일  	: 2010. 08. 26. 
	 * 작성자 		: ibyo
	 * 특이사항		:
	 * 변경이력 		: 최초작성: 2010.08.26 
	 */ 
	@SuppressWarnings("unchecked")
	public ModelAndView techsupApp(HttpServletRequest request, HttpServletResponse response) throws Exception{
		ModelAndView mav = null;

		try{
			mav = new ModelAndView();
			HashMap map = WebUtil.parseRequestMap(request);
			
			HashMap adminMap = (HashMap)request.getSession().getAttribute(SGConfigManager.getString("common.session.admin.name"));
			map.put("admin_id", (String)adminMap.get("ADMIN_ID"));
			map.put("groups", (String)adminMap.get("GROUPS"));
			map.put("chman_no", (String)adminMap.get("SABUN"));
		  	 
			mav.setViewName("/sgportal/techsup/techsupApp");
			mav.addObject("techsupApp", techsupBiz.getTechsupAppView(map)); 
			mav.addObject("devChman", 	productBiz.prodDevChmanList(map)); 
			
			mav.addObject("pMap",map);
			mav.addAllObjects(map); 
			
		} catch (Exception e) {
			logger.error(e, e);
		}
		return mav;
	}
	
	@SuppressWarnings("unchecked")
	public ModelAndView techsupApp1(HttpServletRequest request, HttpServletResponse response) throws Exception{
		ModelAndView mav = null;

		try{			
			mav = new ModelAndView();
			HashMap map = WebUtil.parseRequestMap(request);
			
			HashMap adminMap = (HashMap)request.getSession().getAttribute(SGConfigManager.getString("common.session.admin.name"));
			map.put("admin_id", (String)adminMap.get("ADMIN_ID"));
			map.put("groups", (String)adminMap.get("GROUPS"));
			map.put("chman_no", (String)adminMap.get("SABUN"));
		  
			mav.setViewName("/sgportal/techsup/techsupApp1");
			
			mav.addObject("techsupApp", techsupBiz.getTechsupAppView(map)); 
			mav.addObject("devChman", 	productBiz.prodDevChmanList(map));
			
			map.put("no", map.get("tech_sup_app_no"));
			mav.addObject("fileView", techsupBiz.selSupFile(map));		//첨부파일
			
			map.put("tech_sup_status_code", "2");
			mav.addObject("status2", techsupBiz.techAppStatus(map)); 
			
			map.put("code_sect", "TECH_SUP_TRAN_TYPE_CODE");
			mav.addObject("tech_sup_tran_type_code", chmanBiz.getCode(map));			
		 
			map.put("code_sect", "TECH_SUP_TYPE_CODE");
			mav.addObject("tech_sup_type_code", chmanBiz.getCode(map));	
			
			mav.addObject("talkList",techsupBiz.getTechSupAppTalk(map));  
						
			mav.addObject("pMap",map);
			mav.addAllObjects(map); 
			
		} catch (Exception e) {
			logger.error(e, e);
		}
		return mav;
	}
	
	@SuppressWarnings("unchecked")
	public ModelAndView techsupApp2(HttpServletRequest request, HttpServletResponse response) throws Exception{
		ModelAndView mav = null;

		try{			
			mav = new ModelAndView();
			HashMap map = WebUtil.parseRequestMap(request);
			
			HashMap adminMap = (HashMap)request.getSession().getAttribute(SGConfigManager.getString("common.session.admin.name"));
			map.put("admin_id", (String)adminMap.get("ADMIN_ID"));
			map.put("groups", (String)adminMap.get("GROUPS"));
			map.put("chman_no", (String)adminMap.get("SABUN"));
			
			mav.setViewName("/sgportal/techsup/techsupApp2");
			if(map.get("corp_no") != null && map.get("corp_no") != ""){
				mav.addObject("techsup", chmanBiz.getChmanCom(map));
			}
			mav.addObject("list", techsupBiz.selectPjtView(map));
			mav.addObject("memo", techsupBiz.pjtMemoList(map)); 
			mav.addAllObjects(map);
			
		} catch (Exception e) {
			logger.error(e, e);
		}
		return mav;
	}
	
	@SuppressWarnings("unchecked")
	public ModelAndView techsupApp3(HttpServletRequest request, HttpServletResponse response) throws Exception{
		ModelAndView mav = null;

		try{			
			mav = new ModelAndView();
			HashMap map = WebUtil.parseRequestMap(request);
			
			HashMap adminMap = (HashMap)request.getSession().getAttribute(SGConfigManager.getString("common.session.admin.name"));
			map.put("admin_id", (String)adminMap.get("ADMIN_ID"));
			map.put("groups", (String)adminMap.get("GROUPS"));
			map.put("chman_no", (String)adminMap.get("SABUN"));
		  
			mav.setViewName("/sgportal/techsup/techsupApp3");
			
			mav.addObject("deal", techsupBiz.selectDealPjtView(map)); 			//계약정보 view 
			mav.addObject("fileView",techsupBiz.selSupFile(map));  				//첨부파일
			
			map.put("tech_sup_status_code", "1");
			mav.addObject("status1", techsupBiz.techAppStatus(map)); 
		
			mav.addObject("techsupApp", techsupBiz.getTechsupAppView(map)); 
			
			mav.addObject("pMap",map);
			mav.addAllObjects(map); 
			
		} catch (Exception e) {
			logger.error(e, e);
		}
		return mav;
	}
	
	@SuppressWarnings("unchecked")
	public ModelAndView techsupApp4(HttpServletRequest request, HttpServletResponse response) throws Exception{
		ModelAndView mav = null;

		try{			
			mav = new ModelAndView();
			HashMap map = WebUtil.parseRequestMap(request);
			
			HashMap adminMap = (HashMap)request.getSession().getAttribute(SGConfigManager.getString("common.session.admin.name"));
			map.put("admin_id", (String)adminMap.get("ADMIN_ID"));
			map.put("groups", (String)adminMap.get("GROUPS"));
			map.put("chman_no", (String)adminMap.get("SABUN"));
		 
			mav.setViewName("/sgportal/techsup/techsupApp4");
			
			mav.addObject("tech_sup_chman", techsupBiz.techSupChman(map));
			
			map.put("tech_sup_status_code", "1");
			mav.addObject("status1", techsupBiz.techAppStatus(map)); 	
			map.put("tech_sup_status_code", "2"); 
			mav.addObject("status2", techsupBiz.techAppStatus(map)); 	
			map.put("tech_sup_status_code", "3");
			mav.addObject("status3", techsupBiz.techAppStatus(map)); 	
			map.put("tech_sup_status_code", "4");
			mav.addObject("status4", techsupBiz.techAppStatus(map)); 	
			map.put("tech_sup_status_code", "5");
			mav.addObject("status5", techsupBiz.techAppStatus(map)); 	
			map.put("tech_sup_status_code", "6");
			mav.addObject("status6", techsupBiz.techAppStatus(map)); 	
			map.put("tech_sup_status_code", "7");
			mav.addObject("status7", techsupBiz.techAppStatus(map)); 	
			map.put("tech_sup_status_code", "8");
			mav.addObject("status8", techsupBiz.techAppStatus(map)); 	
			map.put("tech_sup_status_code", "9");
			mav.addObject("status9", techsupBiz.techAppStatus(map)); 
			map.put("tech_sup_status_code", "10");
			mav.addObject("status10", techsupBiz.techAppStatus(map)); 
			
			mav.addObject("totHis", techsupBiz.techSupAppTot(map));
			
			mav.addObject("pMap",map);
			mav.addAllObjects(map); 
			
			mav.addObject("schedule", techsupBiz.selectScheduleView(map));
			mav.addObject("techsupApp", techsupBiz.getTechsupAppView(map)); 
			
		} catch (Exception e) {
			logger.error(e, e);
		}
		return mav;
	}
	
	@SuppressWarnings("unchecked")
	public ModelAndView techsupApp5(HttpServletRequest request, HttpServletResponse response) throws Exception{
		ModelAndView mav = null;

		try{			
			mav = new ModelAndView();
			HashMap map = WebUtil.parseRequestMap(request);
			
			HashMap adminMap = (HashMap)request.getSession().getAttribute(SGConfigManager.getString("common.session.admin.name"));
			map.put("admin_id", (String)adminMap.get("ADMIN_ID"));
			map.put("groups", (String)adminMap.get("GROUPS"));
			map.put("chman_no", (String)adminMap.get("SABUN"));
		  
			mav.setViewName("/sgportal/techsup/techsupApp5");
			
			mav.addObject("supList", techsupBiz.supPjtList(map));
			
			mav.addObject("tech_sup_chman", techsupBiz.techSupChman(map));
			
			map.put("tech_sup_status_code", "5");
			mav.addObject("status5", techsupBiz.techAppStatus(map)); 
			map.put("tech_sup_status_code", "7");
			mav.addObject("status7", techsupBiz.techAppStatus(map)); 	
			map.put("tech_sup_status_code", "8");
			mav.addObject("status8", techsupBiz.techAppStatus(map)); 	
			map.put("tech_sup_status_code", "9");
			mav.addObject("status9", techsupBiz.techAppStatus(map)); 
			
			mav.addObject("pMap",map);
			mav.addAllObjects(map); 
			
		} catch (Exception e) {
			logger.error(e, e);
		}
		return mav;
	}
	
	
	@SuppressWarnings("unchecked")
	public ModelAndView techsupApp7(HttpServletRequest request, HttpServletResponse response) throws Exception{
		ModelAndView mav = null;

		try{			
			mav = new ModelAndView();
			HashMap map = WebUtil.parseRequestMap(request);
			
			HashMap adminMap = (HashMap)request.getSession().getAttribute(SGConfigManager.getString("common.session.admin.name"));
			map.put("admin_id", (String)adminMap.get("ADMIN_ID"));
			map.put("groups", (String)adminMap.get("GROUPS"));
			map.put("chman_no", (String)adminMap.get("SABUN"));
		  
			mav.setViewName("/sgportal/techsup/techsupApp7");  
																		
			mav.addObject("prodList", techsupBiz.selectSupProdList(map)); 			//고객지원정보 목록
			mav.addObject("prodTotCnt",techsupBiz.selectSupProdListCount(map)); 	//고객지원정보 COUNT	 
			map.put("tech_sup_status_code", "1");
			mav.addObject("status1", techsupBiz.techAppStatus(map)); 
			
			mav.addObject("pMap",map);
			mav.addAllObjects(map);  
			
		} catch (Exception e) {
			logger.error(e, e);
		}
		return mav;
	}
	
	
	
	@SuppressWarnings("unchecked")
	public ModelAndView techsupApp8(HttpServletRequest request, HttpServletResponse response) throws Exception{
		ModelAndView mav = null;

		try{
			mav = new ModelAndView();
			HashMap map = WebUtil.parseRequestMap(request);
			
			String actType = map.get("actType").toString();
			mav.setViewName("/sgportal/techsup/techsupApp8");
			
			if("ins".equals(actType)){ 				
				if(map.get("corp_no") != null && map.get("corp_no") != ""){
					mav.addObject("corp", chmanBiz.getChmanCom(map));						//고객사정보
				}
				mav.addObject("techsup", techsupBiz.selectPjtView(map));				//프로젝트 정보									
			}else if("view".equals(actType)){ 
				if(map.get("corp_no") != null && map.get("corp_no") != ""){
					mav.addObject("corp", chmanBiz.getChmanCom(map));						//고객사정보
				}
				
				mav.addObject("techsup", techsupBiz.selectPjtView(map));				//프로젝트 정보	
				
				mav.addObject("prodView", techsupBiz.selectSupProdView(map)); 			//고객지원정보 View
				map.put("no", "PSP" + map.get("prod_seq"));
				mav.addObject("fileView",techsupBiz.selSupFile(map));  					//첨부파일
				
			}else if("mod".equals(actType)){ 
				if(map.get("corp_no") != null && map.get("corp_no") != ""){
					mav.addObject("corp", chmanBiz.getChmanCom(map));					//고객사정보
				}
				mav.addObject("techsup", techsupBiz.selectPjtView(map));				//프로젝트 정보	
				mav.addObject("prodView", techsupBiz.selectSupProdView(map)); 			//고객지원정보 View
				map.put("no", "PSP" + map.get("prod_seq"));
				mav.addObject("fileView",techsupBiz.selSupFile(map));  					//첨부파일 
			} 
			mav.addObject("osList", techsupBiz.getOsList(map));	 //OS 정보
			map.put("sw_type_code", "4");
			mav.addObject("swList1", techsupBiz.getOtherSwList(map));  //기타 SW SDK 정보
			map.put("sw_type_code", "2");
			mav.addObject("swList2", techsupBiz.getOtherSwList(map));  //기타 SW WEB 정보
			map.put("sw_type_code", "3");
			mav.addObject("swList3", techsupBiz.getOtherSwList(map));  //기타 SW WAS 정보
			
			//업무프로세스
			map.put("code_sect", "PROD_USE_CODE");
			mav.addObject("prod_use_code", chmanBiz.getCode(map));
			
			mav.addObject("pMap",map);
			mav.addAllObjects(map); 
			
		} catch (Exception e) {
			logger.error(e, e);
		}
		return mav;
	}
	
	
	@SuppressWarnings("unchecked")
	public ModelAndView techsupAppList(HttpServletRequest request, HttpServletResponse response) throws Exception{
		ModelAndView mav = null;

		try{
			mav = new ModelAndView();
			HashMap map = WebUtil.parseRequestMap(request);
			
			HashMap adminMap = (HashMap)request.getSession().getAttribute(SGConfigManager.getString("common.session.admin.name"));
			map.put("admin_id", (String)adminMap.get("ADMIN_ID"));
			map.put("groups", (String)adminMap.get("GROUPS"));
			map.put("chman_no", (String)adminMap.get("SABUN"));
			
			mav.setViewName("/sgportal/techsup/techsupAppList");
			mav.addObject("list", techsupBiz.getTechsupApp(map));  
			
			mav.addObject("listCnt", techsupBiz.getTechsupAppCount(map));  			
			
			map.put("code_sect", "TECH_SUP_STATUS_CODE");
			mav.addObject("STATUS", chmanBiz.getCode(map));
			
			mav.addObject("pMap",map);
			mav.addAllObjects(map); 
			
		} catch (Exception e) {
			logger.error(e, e);
		}
		return mav;
	}
	
	/** 
	 * Method ID  	: techsupAppAction
	 * Method 설명  	: 기술지원 요청 처리(insert, update, delete)
	 * 최초작성일  	: 2010. 08. 26. 
	 * 작성자 		: ibyo
	 * 특이사항		:
	 * 변경이력 		: 최초작성: 2010.08.26 
	 */ 
	@SuppressWarnings("unchecked")
	public ModelAndView techsupAppAction(HttpServletRequest request, HttpServletResponse response) throws Exception{
		ModelAndView mav = null;
		boolean result=false;
		try{
			mav = new ModelAndView();
			HashMap map = WebUtil.parseRequestMap(request);
			
			HashMap adminMap = (HashMap)request.getSession().getAttribute(SGConfigManager.getString("common.session.admin.name"));
			map.put("groups", (String)adminMap.get("GROUPS"));
			map.put("admin_id", (String)adminMap.get("ADMIN_ID"));
			map.put("chman_no", (String)adminMap.get("SABUN"));
			
			if(map.get("multipartYn") != null && map.get("multipartYn") != "" && map.get("multipartYn").equals("Y") ){
				//첨부파일
				SGFileBean sgfb = new SGFileBean("");			
				WebUtil.processMultipart(request, sgfb, map); 
			}
			
			if(map.get("viewName") == null || map.get("viewName") == ""){
				mav.setViewName("/sgportal/techsupAppAction"); 
			}else{
				mav.setViewName(map.get("viewName").toString());
			}
			 
			String actType = map.get("actType").toString();
			if("ins".equals(actType)){
				mav.setViewName("/sgportal/techsupAppAction"); 
				map.put("command", "appIns");
				result = techsupBiz.techsupAppInsert(map);
			}else if("mod".equals(actType)){
				map.put("command", "appMod");
				result = techsupBiz.techsupAppUpdate(map);
				
			}else if("status2".equals(actType)){
				map.put("command", "status2");
				map.put("app_chman_no", (String)adminMap.get("SABUN"));
				result = techsupBiz.techsupAppStatus(map);
			}else if("status3".equals(actType)){
				map.put("command", "status3");
				result = techsupBiz.techsupAppStatus(map);
			}else if("del".equals(actType)){
				map.put("command", "del");
			}else if("useYn".equals(actType)){
				if(map.get("use_yn").equals("Y")){
					map.put("command", "delY");
				}else{
					map.put("command", "del");
				}
			} 	 	
			
			mav.addObject("result", result); 	
			mav.addObject("pMap",map);	  
			mav.addAllObjects(map); 
			
		} catch (Exception e) {
			logger.error(e, e);
		}
		return mav;
	}

	/** 
	 * Method ID  	: techsupList
	 * Method 설명  	: 기술지원 목록
	 * 최초작성일  	: 2010. 08. 26. 
	 * 작성자 		: ibyo
	 * 특이사항		:
	 * 변경이력 		: 최초작성: 2010.08.26 
	 */ 
	@SuppressWarnings("unchecked")
	public ModelAndView techsupList(HttpServletRequest request, HttpServletResponse response) throws Exception{
		ModelAndView mav = null;

		try{
			mav = new ModelAndView();
			HashMap map = WebUtil.parseRequestMap(request);
			
			HashMap adminMap = (HashMap)request.getSession().getAttribute(SGConfigManager.getString("common.session.admin.name"));
			map.put("admin_id", (String)adminMap.get("ADMIN_ID"));
			map.put("groups", (String)adminMap.get("GROUPS"));
			map.put("chman_no", (String)adminMap.get("SABUN"));
			
			if(map.get("viewName") == null || map.get("viewName") == ""){
				mav.setViewName("/sgportal/techsup/techsupList");
			}else{
				mav.setViewName(map.get("viewName").toString());
			}
			
			mav.addObject("list", techsupBiz.getTechsupList(map)); 
			mav.addObject("totCnt",techsupBiz.getTechsupCount(map)); 
			
			mav.addObject("pMap",map);
			mav.addAllObjects(map); 
			
		} catch (Exception e) {
			logger.error(e, e);
		}
		return mav;
	}
	  
	
	/** 
	 * Method ID  	: techsupComView
	 * Method 설명  	: 기술지원 이력 상세보기
	 * 최초작성일  	: 2010. 08. 26. 
	 * 작성자 		: ibyo
	 * 특이사항		:
	 * 변경이력 		: 최초작성: 2010.08.26 
	 */ 
	@SuppressWarnings("unchecked")
	public ModelAndView techsupComView(HttpServletRequest request, HttpServletResponse response) throws Exception{
		ModelAndView mav = null;

		try{
			
			mav = new ModelAndView();
			HashMap map = WebUtil.parseRequestMap(request);
			
			mav.setViewName("/sgportal/techsup/techsupComView"); 
						
			mav.addObject("companyView",techsupBiz.getTechsup(map));	 
			mav.addObject("pMap",map);	 
			
		} catch (Exception e) {
			logger.error(e, e);
		}
		return mav;
	}
	
	/** 
	 * Method ID  	: techsupAction
	 * Method 설명  	: 기술지원이력 처리(insert, update, delete)
	 * 최초작성일  	: 2010. 08. 26. 
	 * 작성자 		: ibyo
	 * 특이사항		:
	 * 변경이력 		: 최초작성: 2010.08.26 
	 */ 
	@SuppressWarnings("unchecked")
	public ModelAndView techsupAction(HttpServletRequest request, HttpServletResponse response) throws Exception{
		ModelAndView mav = null;
		boolean result=false;
		try{
			
			mav = new ModelAndView();
			HashMap map = WebUtil.parseRequestMap(request); 
			HashMap adminMap = (HashMap)request.getSession().getAttribute(SGConfigManager.getString("common.session.admin.name"));
			map.put("groups", (String)adminMap.get("GROUPS"));
			map.put("admin_id", (String)adminMap.get("ADMIN_ID"));
			map.put("chman_no", (String)adminMap.get("SABUN"));
			
			if(map.get("viewName") == null || map.get("viewName") == ""){
				mav.setViewName("/sgportal/techsupAppAction");	
			}else{
				mav.setViewName(map.get("viewName").toString());
			}
			
			
			if(map.get("multipartYn") != null && map.get("multipartYn") != "" && map.get("multipartYn").equals("Y") ){ 
				SGFileBean sgfb = new SGFileBean("");			
				WebUtil.processMultipart(request, sgfb, map); 
			}
			
			String actType = map.get("actType").toString(); 
			
			 
			if("ins".equals(actType)){
				map.put("command", "ins_status6"); 
				result = techsupBiz.TechsupInsert(map);
			}else if("mod".equals(actType)){
				map.put("command", "mod_status6"); 
				map.put("actType", "view");
				result = techsupBiz.TechsupUpdate(map);
			}else if("del".equals(actType)){
				map.put("command", "del");
			} 
			
			mav.addObject("result", result); 	
			mav.addObject("pMap",map);	  
			mav.addAllObjects(map); 
			
		} catch (Exception e) {
			logger.error(e, e);
		}
		return mav;
	}
	
	/** 
	 * Method ID  	: techsupView			<br/>
	 * Method 설명  	: 기술지원 이력 상세보기		<br/>
	 * 최초작성일  	: 2010. 08. 26. 		<br/>
	 * 작성자 		: ibyo					<br/>
	 * 특이사항		:						<br/>
	 * 변경이력 		: 최초작성 - 2010.08.26 
	 */ 
	@SuppressWarnings("unchecked")
	public ModelAndView techsupView(HttpServletRequest request, HttpServletResponse response) throws Exception{
		ModelAndView mav = null;
		try{
			mav = new ModelAndView();
			HashMap map = WebUtil.parseRequestMap(request);
			HashMap adminMap = (HashMap)request.getSession().getAttribute(SGConfigManager.getString("common.session.admin.name"));
			map.put("groups", (String)adminMap.get("GROUPS"));
			map.put("admin_id", (String)adminMap.get("ADMIN_ID"));
			map.put("chman_no", (String)adminMap.get("SABUN"));
			
			map.put("actType", map.get("actType"));
			
			if(map.get("viewName") == null || map.get("viewName") == ""){
				mav.setViewName("/sgportal/techsup/techsupApp6"); 
			}else{
				mav.setViewName(map.get("viewName").toString());
			}
			
			mav.addObject("talkList",techsupBiz.getTechSupAppTalk(map));  
			
			
			map.put("code_sect", "TECH_SUP_TRAN_TYPE_CODE");
			mav.addObject("tech_sup_tran_type_code", chmanBiz.getCode(map));			
		 
			map.put("code_sect", "TECH_SUP_TYPE_CODE");
			mav.addObject("tech_sup_type_code", chmanBiz.getCode(map));			
			
			map.put("code_sect", "TECH_SUP_RESULT_CODE");
			mav.addObject("tech_sup_result_code", chmanBiz.getCode(map));	
			
			map.put("tech_sup_status_code", "9");
			mav.addObject("status9", techsupBiz.techAppStatus(map)); 
			
			mav.addObject("techsupView",techsupBiz.getTechsup(map));	
			
			map.put("no", map.get("tech_sup_no"));
			mav.addObject("fileView",techsupBiz.selSupFile(map));  
			 
			
			mav.addObject("pMap",map); 
			mav.addAllObjects(map);
		} catch (Exception e) {
			logger.error(e, e);
		}
		return mav;
	} 
	 


	/***********************프로젝트 Start*************************************************/
	
	/** 
	 * Method ID  	: pjtList
	 * Method 설명  	: 프로젝트 목록
	 * 최초작성일  	: 2010. 08. 26. 
	 * 작성자 		: ibyo
	 * 특이사항		:
	 * 변경이력 		: 최초작성: 2010.08.26 
	 */ 
	@SuppressWarnings("unchecked")
	public ModelAndView pjtList(HttpServletRequest request, HttpServletResponse response) throws Exception{
		ModelAndView mav = null;
		
		HashMap adminMap = (HashMap)request.getSession().getAttribute(SGConfigManager.getString("common.session.admin.name"));
		
		try{
			
			mav = new ModelAndView();
			HashMap map = WebUtil.parseRequestMap(request);
			
			map.put("groups", (String)adminMap.get("GROUPS"));
			map.put("admin_id", (String)adminMap.get("ADMIN_ID"));
			map.put("chman_no", (String)adminMap.get("SABUN"));
			
			if(map.get("viewName") == null || map.get("viewName") == ""){
				mav.setViewName("/sgportal/techsup/pjtList");
			}else{
				mav.setViewName(map.get("viewName").toString());
			}
			
			map.put("corp_no", map.get("corp_no"));
			mav.addObject("pjt", techsupBiz.selectPjtList(map)); 
			
			if(map.get("corp_no") != null && map.get("corp_no") != ""){
				mav.addObject("corp", chmanBiz.getChmanCom(map));
			}
			
			mav.addObject("pMap",map);
			mav.addAllObjects(map); 
			
		} catch (Exception e) {
			logger.error(e, e);
		}
		return mav;
	}
	
	
	/** 
	 * Method ID  	: pjtView
	 * Method 설명  	: 프로젝트 정보 view
	 * 최초작성일  	: 2010. 08. 24. 
	 * 작성자 		: ibyo
	 * 특이사항		:
	 * 변경이력 		: 최초작성: 2010.08.24 
	 */ 
	@SuppressWarnings("unchecked")
	public ModelAndView pjtView(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = null;
 
		try {
			mav = new ModelAndView();
			HashMap map = WebUtil.parseRequestMap(request);
			
			HashMap adminMap = (HashMap)request.getSession().getAttribute(SGConfigManager.getString("common.session.admin.name"));
			map.put("groups", (String)adminMap.get("GROUPS"));
			map.put("admin_id", (String)adminMap.get("ADMIN_ID"));
			map.put("chman_no", (String)adminMap.get("SABUN"));
			
			map.put("admin_nm", (String)adminMap.get("ADMIN_NM"));
			map.put("cor_nm", (String)adminMap.get("COR_NM"));
			
			if(map.get("viewName") == null || map.get("viewName") == ""){
				mav.setViewName("/sgportal/techsup/pjtPopup");
			}else{
				mav.setViewName(map.get("viewName").toString());
			}
			
			String actType = map.get("actType").toString();
			
			if("ins".equals(actType)){ 
				mav.setViewName("/sgportal/techsup/pjtPopup");
				if(map.get("corp_no") != null && map.get("corp_no") != ""){
					mav.addObject("techsup", chmanBiz.getChmanCom(map));
				}
			}else if("view".equals(actType)){ 
				
				mav.addObject("techsup", chmanBiz.getChmanCom(map));
				mav.addObject("list", techsupBiz.selectPjtView(map));
				
				mav.addAllObjects(map);
			}else if("mod".equals(actType)){ 
				mav.setViewName("/sgportal/techsup/pjtPopup");
				mav.addObject("techsup", chmanBiz.getChmanCom(map));
				mav.addObject("list", techsupBiz.selectPjtView(map));
					
				mav.addAllObjects(map);
			}else if("del".equals(actType)){ 
			}
			
			map.put("code_sect", "WORK_TYPE_CODE");
			mav.addObject("code_work", chmanBiz.getCode(map));
						
			mav.addObject("pMap",map);
			
		} catch (Exception e) {
			logger.error(e, e);
		}
		return mav;
	}
	
	
	/** 
	  :  pjtMemoListXML
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
	public ModelAndView pjtMemoListXML(HttpServletRequest request, HttpServletResponse response) throws Exception{
		ModelAndView mav = null;
		try{
			mav = new ModelAndView();
			HashMap map = WebUtil.parseRequestMap(request);
			
			mav.setViewName("/sgportal/sgAjax");
			
			HashMap paraMap = techsupBiz.pjtMemoListXML(map);
			
			mav.addObject("pMap",map);
			mav.addObject("result", paraMap.get("result"));
			mav.addAllObjects(map);
			
		} catch (Exception e) {
			logger.error(e, e);
		}
		return mav;
	}
	
	/** 
	  :  pjtListXML
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

	@SuppressWarnings("unchecked")
	public ModelAndView pjtListXML(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = null;

		try {
			mav = new ModelAndView();
			HashMap map = WebUtil.parseRequestMap(request);
			HashMap adminMap = (HashMap)request.getSession().getAttribute(SGConfigManager.getString("common.session.admin.name"));
		
			mav.setViewName("/sgportal/sgAjax");
			HashMap paraMap = techsupBiz.pjtListXML(map, request);
			mav.addObject("result", paraMap.get("result"));
			
			map.put("admin_id", (String)adminMap.get("ADMIN_ID"));
			map.put("groups", (String)adminMap.get("GROUPS"));
			map.put("chman_no", (String)adminMap.get("SABUN"));
			
			mav.addObject("pMap",map);
			
		} catch (Exception e) {
			logger.error(e, e);
		}
		return mav;
	}
	
	/** 
	 * Method ID  	: pjtComAction
	 * Method 설명  	: 프로젝트 처리(insert, update, delete)
	 * 최초작성일  	: 2010. 08. 26. 
	 * 작성자 		: ibyo
	 * 특이사항		:
	 * 변경이력 		: 최초작성: 2010.08.26 
	 */ 
	@SuppressWarnings("unchecked")
	public ModelAndView pjtComAction(HttpServletRequest request, HttpServletResponse response) throws Exception{
		ModelAndView mav = null;
		boolean result=false;
		try{
			mav = new ModelAndView();
			HashMap map = WebUtil.parseRequestMap(request);
			
			HashMap adminMap = (HashMap)request.getSession().getAttribute(SGConfigManager.getString("common.session.admin.name"));
			map.put("groups", (String)adminMap.get("GROUPS"));
			map.put("admin_id", (String)adminMap.get("ADMIN_ID"));
			map.put("chman_no", (String)adminMap.get("SABUN"));
			
			if(map.get("viewName") == null || map.get("viewName") == ""){
				mav.setViewName("/sgportal/techsup/pjtPopup"); 
			}else{
				mav.setViewName(map.get("viewName").toString());
			}
			 
			String actType = map.get("actType").toString();
						
			if("ins".equals(actType)){
				map.put("command", "ins");
				result = techsupBiz.pjtInsert(map);
				
			}else if("mod".equals(actType)){
				map.put("command", "mod");
				result = techsupBiz.pjtUpdate(map);
				
			}else if("del".equals(actType)){
				map.put("command", "del");
				result = techsupBiz.tjtDelete(map);
			}else if("useYn".equals(actType)){
				if(map.get("use_yn").equals("Y")){
					map.put("command", "delY");
				}else{
					map.put("command", "del");
				}
				result = techsupBiz.tjtUseDelete(map);
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
	public ModelAndView memoAction(HttpServletRequest request, HttpServletResponse response) throws Exception{
		ModelAndView mav = null;
		boolean result=false;
		try{
			mav = new ModelAndView();
			HashMap map = WebUtil.parseRequestMap(request);
			
			HashMap adminMap = (HashMap)request.getSession().getAttribute(SGConfigManager.getString("common.session.admin.name"));
			map.put("groups", (String)adminMap.get("GROUPS"));
			map.put("admin_id", (String)adminMap.get("ADMIN_ID"));
			map.put("chman_no", (String)adminMap.get("SABUN"));
			
			
			if(map.get("viewName") == null || map.get("viewName") == ""){
				mav.setViewName("/sgportal/techsup/pjtMemo"); 
			}else{
				mav.setViewName(map.get("viewName").toString());
			}
						 
			String actType = map.get("actType").toString();
						
			if("ins".equals(actType)){
				map.put("command", "ins");
				result = techsupBiz.memoInsert(map);
				
			}else if("mod".equals(actType)){
				map.put("command", "mod");
				result = techsupBiz.pjtMemoUpdate(map);
				
			}else if("del".equals(actType)){
				map.put("command", "del");
				
			}
			
			mav.addObject("result", result); 	
			mav.addObject("pMap",map);	  
			mav.addAllObjects(map); 
			
		} catch (Exception e) {
			logger.error(e, e);
		}
		return mav;
	}

	
	/***********************프로젝트 End*************************************************/	
	
	
	
	
	
	/** 
	 * Method ID  	: techsupPjtList
	 * Method 설명  	: 프로젝트 지원 목록
	 * 최초작성일  	: 2010. 08. 27. 
	 * 작성자 		: ibyo
	 * 특이사항		:
	 * 변경이력 		: 최초작성: 2010.08.27 
	 */ 
	@SuppressWarnings("unchecked")
	public ModelAndView techsupPjtList(HttpServletRequest request, HttpServletResponse response) throws Exception{
		ModelAndView mav = null;

		try{
			mav = new ModelAndView();
			HashMap map = WebUtil.parseRequestMap(request);
			
			HashMap adminMap = (HashMap)request.getSession().getAttribute(SGConfigManager.getString("common.session.admin.name"));
			map.put("groups", (String)adminMap.get("GROUPS"));
			map.put("admin_id", (String)adminMap.get("ADMIN_ID"));
			map.put("chman_no", (String)adminMap.get("SABUN"));
			
			mav.setViewName("/sgportal/techsup/techsupPjtList");
			
			mav.addObject("corp", chmanBiz.getChmanCom(map));						//고객사정보
			mav.addObject("techsup", techsupBiz.selectPjtView(map));				//프로젝트 정보	
																		
			mav.addObject("prodList", techsupBiz.selectSupProdList(map)); 			//고객지원정보 목록
			mav.addObject("prodTotCnt",techsupBiz.selectSupProdListCount(map)); 	//고객지원정보 COUNT	 
			 
			mav.addObject("supList", techsupBiz.supPjtList(map)); 					//고객지원정보 목록
			mav.addObject("supTotCnt",techsupBiz.supPjtListCount(map)); 			//고객지원정보 COUNT
			
			mav.addObject("dealList", techsupBiz.selectDealPjtList(map)); 			 
			mav.addObject("dealTotCnt",techsupBiz.selectDealPjtCount(map)); 
			
			mav.addObject("pMap",map);
			mav.addAllObjects(map); 
			
		} catch (Exception e) {
			logger.error(e, e);
		}
		return mav;
	}
	
	/** 
	 * Method ID  	: techsupPjtSupList
	 * Method 설명  	: 프로젝트 환경 정보 List
	 * 최초작성일  	: 2010. 08. 27. 
	 * 작성자 		: ibyo
	 * 특이사항		:
	 * 변경이력 		: 최초작성: 2010.08.27 
	 */ 
	@SuppressWarnings("unchecked")
	public ModelAndView techsupPjtSupList(HttpServletRequest request, HttpServletResponse response) throws Exception{
		ModelAndView mav = null;

		try{
			mav = new ModelAndView();
			HashMap map = WebUtil.parseRequestMap(request);
			
			mav.setViewName("/sgportal/techsup/techsupPjtList");
			
			mav.addObject("corp", chmanBiz.getChmanCom(map));						//고객사정보
			mav.addObject("techsup", techsupBiz.selectPjtView(map));				//프로젝트 정보	
																		
			mav.addObject("prodList", techsupBiz.selectSupProdList(map)); 			//고객지원정보 목록
			mav.addObject("prodTotCnt",techsupBiz.selectSupProdListCount(map)); 	//고객지원정보 COUNT																		
			
			mav.addObject("supList", techsupBiz.supPjtList(map)); 					//고객지원정보 목록
			mav.addObject("supTotCnt",techsupBiz.supPjtListCount(map)); 				//고객지원정보 COUNT
			
			mav.addObject("pMap",map);
			mav.addAllObjects(map); 
			
		} catch (Exception e) {
			logger.error(e, e);
		}
		return mav;
	}
	
	
	/** 
	 * Method ID  	: techsupPjtSupView
	 * Method 설명  	: 프로젝트 환경 정보 View
	 * 최초작성일  	: 2010. 08. 27. 
	 * 작성자 		: ibyo
	 * 특이사항		:
	 * 변경이력 		: 최초작성: 2010.08.27 
	 */ 
	@SuppressWarnings("unchecked")
	public ModelAndView techsupPjtSupView(HttpServletRequest request, HttpServletResponse response) throws Exception{
		ModelAndView mav = null;

		try{
			mav = new ModelAndView();
			HashMap map = WebUtil.parseRequestMap(request);
			
			String actType = map.get("actType").toString();
			
			if("ins".equals(actType)){ 
				mav.setViewName("/sgportal/techsup/techsupPjtProdView");
				mav.addObject("corp", chmanBiz.getChmanCom(map));						//고객사정보
				mav.addObject("techsup", techsupBiz.selectPjtView(map));				//프로젝트 정보	
								
				
			}else if("view".equals(actType)){ 
				mav.setViewName("/sgportal/techsup/techsupPjtProdView");
				mav.addObject("corp", chmanBiz.getChmanCom(map));						//고객사정보
				mav.addObject("techsup", techsupBiz.selectPjtView(map));				//프로젝트 정보	
				mav.addObject("prodView", techsupBiz.selectSupProdView(map)); 			//고객지원정보 View
				map.put("no", "PSP" + map.get("prod_seq"));
				mav.addObject("fileView",techsupBiz.selSupFile(map));  					//첨부파일
			}else if("mod".equals(actType)){ 
				mav.setViewName("/sgportal/techsup/techsupPjtProdView");
				mav.addObject("corp", chmanBiz.getChmanCom(map));						//고객사정보
				mav.addObject("techsup", techsupBiz.selectPjtView(map));				//프로젝트 정보	
				mav.addObject("prodView", techsupBiz.selectSupProdView(map)); 			//고객지원정보 View
				map.put("no", "PSP" + map.get("prod_seq"));
				mav.addObject("fileView",techsupBiz.selSupFile(map));  					//첨부파일
				
			}
			
			
			mav.addObject("osList", techsupBiz.getOsList(map));	 //OS 정보
			map.put("sw_type_code", "4");
			mav.addObject("swList1", techsupBiz.getOtherSwList(map));  //기타 SW SDK 정보
			map.put("sw_type_code", "2");
			mav.addObject("swList2", techsupBiz.getOtherSwList(map));  //기타 SW WEB 정보
			map.put("sw_type_code", "3");
			mav.addObject("swList3", techsupBiz.getOtherSwList(map));  //기타 SW WAS 정보
			
			//업무프로세스
			map.put("code_sect", "PROD_USE_CODE");
			mav.addObject("prod_use_code", chmanBiz.getCode(map));
			
			
			mav.addObject("pMap",map);
			mav.addAllObjects(map); 
			
		} catch (Exception e) {
			logger.error(e, e);
		}
		return mav;
	}
	
	
	/** 
	 * Method ID  	: techsupPjtProdList
	 * Method 설명  	: 프로젝트 공급제품 목록
	 * 최초작성일  	: 2010. 08. 27. 
	 * 작성자 		: ibyo
	 * 특이사항		:
	 * 변경이력 		: 최초작성: 2010.08.27 
	 */ 
	@SuppressWarnings("unchecked")
	public ModelAndView techsupPjtProdList(HttpServletRequest request, HttpServletResponse response) throws Exception{
		ModelAndView mav = null;

		try{
			
			mav = new ModelAndView();
			HashMap map = WebUtil.parseRequestMap(request);
			
			mav.setViewName("/sgportal/techsup/pjtProdPopup");
			
			mav.addObject("productList", techsupBiz.selectProdList(map));
			
			mav.addObject("pMap",map);
			mav.addAllObjects(map); 
			
		} catch (Exception e) {
			logger.error(e, e);
		}
		return mav;
	}
	
	
	/** 
	 * Method ID  	: pjtSupProdAction
	 * Method 설명  	: 프로젝트 처리(insert, update, delete)
	 * 최초작성일  	: 2010. 08. 26. 
	 * 작성자 		: ibyo
	 * 특이사항		:
	 * 변경이력 		: 최초작성: 2010.08.26 
	 */ 
	@SuppressWarnings("unchecked")
	public ModelAndView pjtSupProdAction(HttpServletRequest request, HttpServletResponse response) throws Exception{
		ModelAndView mav = null;
		boolean result=false;
		try{ 
			mav = new ModelAndView();
			HashMap map = WebUtil.parseRequestMap(request);
			
			
			HashMap adminMap = (HashMap)request.getSession().getAttribute(SGConfigManager.getString("common.session.admin.name"));
			map.put("groups", (String)adminMap.get("GROUPS"));
			map.put("admin_id", (String)adminMap.get("ADMIN_ID"));
			map.put("chman_no", (String)adminMap.get("SABUN"));
			
			//첨부파일
			SGFileBean sgfb = new SGFileBean("");			
			WebUtil.processMultipart(request, sgfb, map); 
			
			if(map.get("ctChk") != null){
				mav.setViewName("/sgportal/techsup/techsupApp8"); 
			}else{
				mav.setViewName("/sgportal/techsup/techsupPjtProdView"); 
			} 	 
			
			String actType = map.get("actType").toString();
						
			if("ins".equals(actType)){ 
				
				map.put("no", "PSP" + techsupBiz.techSupProdMaxSeq(map)); 
				map.put("prod_seq", techsupBiz.techSupProdMaxSeq(map)); 
				
				map.put("command", "ins");
				map.put("actType", "view");
				result = techsupBiz.pjtSupProdInsert(map);
				
			}else if("mod".equals(actType)){
				map.put("no", "PSP"+map.get("prod_seq")); 
				map.put("command", "mod");
				map.put("actType", "view");
				result = techsupBiz.pjtSupProdUpdate(map);
				
			}else if("del".equals(actType)){
				map.put("no", "PSP"+techsupBiz.techSupProdMaxSeq(map)); 
				map.put("command", "del");
				map.put("actType", "view");
				
			} 		 	
			
			mav.addObject("result", result); 	
			mav.addObject("pMap",map);
			
			mav.addAllObjects(map); 
			
		} catch (Exception e) {
			logger.error(e, e);
		}
		return mav;
	}
	
	
	 
	
	/***********************계약정보 Start*************************************************/
	/** 
	 * Method ID  	: dealPjtList
	 * Method 설명  	: 계약정보  목록
	 * 최초작성일  	: 2010. 09. 03. 
	 * 작성자 		: ibyo
	 * 특이사항		:
	 * 변경이력 		: 최초작성: 2010.09.03 
	 */ 
	@SuppressWarnings("unchecked")
	public ModelAndView dealPjtList(HttpServletRequest request, HttpServletResponse response) throws Exception{
		ModelAndView mav = null;

		try{
			mav = new ModelAndView();
			HashMap map = WebUtil.parseRequestMap(request);
			
			HashMap adminMap = (HashMap)request.getSession().getAttribute(SGConfigManager.getString("common.session.admin.name"));
			map.put("groups", (String)adminMap.get("GROUPS"));
			map.put("admin_id", (String)adminMap.get("ADMIN_ID"));
			map.put("chman_no", (String)adminMap.get("SABUN"));
			
			mav.setViewName("/sgportal/techsup/dealPjtList");			 
			
			mav.addObject("list", techsupBiz.getTechsupList(map)); 
			mav.addObject("totCnt",techsupBiz.getTechsupCount(map));
			
			mav.addObject("pMap",map);
			mav.addAllObjects(map); 
			
		} catch (Exception e) {
			logger.error(e, e);
		}
		return mav;
	}
	
	
	/** 
	 * Method ID  	: dealPjtAction
	 * Method 설명  	: 계약정보 처리(insert, update, delete)
	 * 최초작성일  	: 2010. 09. 03. 
	 * 작성자 		: ibyo
	 * 특이사항		:
	 * 변경이력 		: 최초작성: 2010.09.03 
	 */ 
	@SuppressWarnings("unchecked")
	public ModelAndView dealPjtAction(HttpServletRequest request, HttpServletResponse response) throws Exception{
		ModelAndView mav = null;
		boolean result=false;
		try{
			
			mav = new ModelAndView();
			HashMap map = WebUtil.parseRequestMap(request);
			
			HashMap adminMap = (HashMap)request.getSession().getAttribute(SGConfigManager.getString("common.session.admin.name"));
			map.put("groups", (String)adminMap.get("GROUPS"));
			map.put("admin_id", (String)adminMap.get("ADMIN_ID"));
			map.put("chman_no", (String)adminMap.get("SABUN"));
			
			if(map.get("viewName") == null || map.get("viewName") == ""){
				mav.setViewName("/sgportal/techsup/dealPjtAction");
			}else{
				mav.setViewName(map.get("viewName").toString());
			}
			
			
			//첨부파일
			SGFileBean sgfb = new SGFileBean("");			
			WebUtil.processMultipart(request, sgfb, map); 
			
			String actType = map.get("actType").toString(); 
			
			String[] chman_no   = new String[2];
			chman_no[0]   = map.get("chman_no_sg").toString();
			chman_no[1]   = map.get("chman_no_cu").toString();
			
			String[] chman_sect_code   =  new String[2];
			chman_sect_code[0] = map.get("chman_sect_code_sg").toString();
			chman_sect_code[1] = map.get("chman_sect_code_cu").toString();
			
			 		
			if("ins".equals(actType)){
				map.put("command", "ins");
				result = techsupBiz.dealPjtInsert(map);
				
				for(int i=0;i<chman_no.length;i++){	
					if(chman_no[i]!=null && !chman_no[i].equals("")){
						map.put("chman_no", chman_no[i]);
						map.put("chman_sect_code", chman_sect_code[i]);
						
						result = techsupBiz.dealPjtChmanInsert(map);
					}
				} 
				result = techsupBiz.dealPjtProdInsert(map);
			}else if("mod".equals(actType)){
				map.put("command", "mod");
				
				//담당자 삭제 후 insert
				result = techsupBiz.dealPjtChmanDelete(map); 
				for(int i=0; i<chman_no.length; i++){	
					if(chman_no[i]!=null && !chman_no[i].equals("")){
						map.put("chman_no", chman_no[i]);
						map.put("chman_sect_code", chman_sect_code[i]);
						
						result = techsupBiz.dealPjtChmanInsert(map);
					}
				}
				  
				//제품명 삭제후 insert 
				if(!map.get("prod_no").equals("")){
					result = techsupBiz.dealPjtProdDelete(map);
					result = techsupBiz.dealPjtProdInsert(map);
				} 
				
				result = techsupBiz.dealPjtUpdate(map); 
				
			}else if("del".equals(actType)){
				map.put("command", "del");
				
				result = techsupBiz.dealPjtDelete(map);
			}else if("useYn".equals(actType)){
				if(map.get("use_yn").equals("Y")){
					map.put("command", "delY");
				}else{
					map.put("command", "del");
				}
				result = techsupBiz.dealPjtUseDelete(map);
			} 			 
			
			mav.addObject("result", result); 	
			mav.addObject("pMap",map);	  
			mav.addAllObjects(map); 
			
		} catch (Exception e) {
			logger.error(e, e);
		}
		return mav;
	}

	
	
	/** 
	 * Method ID  	: dealPjtView
	 * Method 설명  	: 계약정보 View
	 * 최초작성일  	: 2010. 09. 03. 
	 * 작성자 		: ibyo
	 * 특이사항		:
	 * 변경이력 		: 최초작성: 2010.09.03 
	 */ 
	@SuppressWarnings("unchecked")
	public ModelAndView dealPjtView(HttpServletRequest request, HttpServletResponse response) throws Exception{
		ModelAndView mav = null;

		try{
			
			mav = new ModelAndView();
			HashMap map = WebUtil.parseRequestMap(request); 
			
			HashMap adminMap = (HashMap)request.getSession().getAttribute(SGConfigManager.getString("common.session.admin.name"));
			map.put("groups", (String)adminMap.get("GROUPS"));
			map.put("admin_id", (String)adminMap.get("ADMIN_ID"));
			map.put("chman_no", (String)adminMap.get("SABUN"));
			
			mav.setViewName("/sgportal/techsup/dealPjtView");  
			
			mav.addObject("corp", chmanBiz.getChmanCom(map));	//고객사정보  
			
			if(map.get("actType").equals("view") || map.get("actType").equals("mod")){
				mav.addObject("deal", techsupBiz.selectDealPjtView(map));	//계약정보 view 
				mav.addObject("fileView",techsupBiz.selSupFile(map));	//첨부파일
			}
			
			map.put("code_sect", "CONT_TYPE_CODE");
			mav.addObject("cont_type_code", chmanBiz.getCode(map));			
			
			mav.addObject("pMap",map);
			mav.addAllObjects(map); 
			
		} catch (Exception e) {
			logger.error(e, e);
		}
		return mav;
	}
	
	
	
	/** 
	 * Method ID  	: dealPjtViewList
	 * Method 설명  	: 계약정보 List View
	 * 최초작성일  	: 2010. 09. 03. 
	 * 작성자 		: ibyo
	 * 특이사항		:
	 * 변경이력 		: 최초작성: 2010.09.03 
	 */ 
	@SuppressWarnings("unchecked")
	public ModelAndView dealPjtViewList(HttpServletRequest request, HttpServletResponse response) throws Exception{
		ModelAndView mav = null;

		try{
			mav = new ModelAndView();
			HashMap map = WebUtil.parseRequestMap(request); 
			
			HashMap adminMap = (HashMap)request.getSession().getAttribute(SGConfigManager.getString("common.session.admin.name"));
			map.put("groups", (String)adminMap.get("GROUPS"));
			map.put("admin_id", (String)adminMap.get("ADMIN_ID"));
			map.put("chman_no", (String)adminMap.get("SABUN"));
			
			if(map.get("viewName") == null || map.get("viewName") == ""){
				mav.setViewName("/sgportal/techsup/dealPjtViewList");  
			}else{
				mav.setViewName(map.get("viewName").toString());
			}
			
			mav.addObject("corp", chmanBiz.getChmanCom(map));					//고객사정보 
			 
			mav.addObject("dealList", techsupBiz.selectDealPjtList(map)); 			 
			mav.addObject("dealTotCnt",techsupBiz.selectDealPjtCount(map));  
			
			mav.addObject("pMap",map);
			mav.addAllObjects(map); 
			
		} catch (Exception e) {
			logger.error(e, e);
		}
		return mav;
	} 
	
	/***********************계약정보 End*************************************************/	
	
	/** 
	 * Method ID  	: techAppStatus
	 * Method 설명  	: 기술지원요청상태
	 * 최초작성일  	: 2010. 09. 03. 
	 * 작성자 		: ibyo
	 * 특이사항		:
	 * 변경이력 		: 최초작성: 2010.09.03 
	 */ 
	@SuppressWarnings("unchecked")
	public ModelAndView techAppStatus(HttpServletRequest request, HttpServletResponse response) throws Exception{
		ModelAndView mav = null;
		try{
			mav = new ModelAndView();
			HashMap map = WebUtil.parseRequestMap(request); 
			HashMap adminMap = (HashMap)request.getSession().getAttribute(SGConfigManager.getString("common.session.admin.name"));
			map.put("groups", (String)adminMap.get("GROUPS"));
			map.put("admin_id", (String)adminMap.get("ADMIN_ID"));
			map.put("chman_no", (String)adminMap.get("SABUN"));
			
			if(map.get("viewName") == null || map.get("viewName") == ""){
				mav.setViewName("/sgportal/techsup/techsupApp4");
			}else{
				mav.setViewName(map.get("viewName").toString());
			}
			
			map.put("tech_sup_status_code", "1");
			mav.addObject("status1", techsupBiz.techAppStatus(map)); 	
			map.put("tech_sup_status_code", "2");
			
			HashMap tech_sup_status_code2 = techsupBiz.techAppStatus(map);
			if(tech_sup_status_code2.size() > 0){
				mav.addObject("tech_sup_chman", techsupBiz.techSupChman(map));
			}
			mav.addObject("status2", tech_sup_status_code2); 	
			
			map.put("tech_sup_status_code", "3");
			mav.addObject("status3", techsupBiz.techAppStatus(map)); 	
			map.put("tech_sup_status_code", "4");
			mav.addObject("status4", techsupBiz.techAppStatus(map)); 	
			map.put("tech_sup_status_code", "5");
			mav.addObject("status5", techsupBiz.techAppStatus(map)); 	
			
			mav.addObject("pMap",map);
			mav.addAllObjects(map); 
			
		} catch (Exception e) {
			logger.error(e, e);
		}
		return mav;
	} 
	
	
	/** 
	 * Method ID  	: techsupAppStatusAction
	 * Method 설명  	: 기술지원요청상태 처리(insert, update, delete)
	 * 최초작성일  	: 2010. 08. 26. 
	 * 작성자 		: ibyo
	 * 특이사항		:
	 * 변경이력 		: 최초작성: 2010.08.26 
	 */ 
	@SuppressWarnings("unchecked")
	public ModelAndView techsupAppStatusAction(HttpServletRequest request, HttpServletResponse response) throws Exception{
		ModelAndView mav = null;
		boolean result=false;
		try{
			
			mav = new ModelAndView();
			HashMap map = WebUtil.parseRequestMap(request);
			
			HashMap adminMap = (HashMap)request.getSession().getAttribute(SGConfigManager.getString("common.session.admin.name"));
			map.put("groups", (String)adminMap.get("GROUPS"));
			map.put("admin_id", (String)adminMap.get("ADMIN_ID"));
			map.put("chman_no", (String)adminMap.get("SABUN"));
			
			
			if(map.get("viewName") == null || map.get("viewName") == ""){
				mav.setViewName("/sgportal/techsupAppAction"); 
			}else{
				mav.setViewName(map.get("viewName").toString());
			}
			 
			String actType = map.get("actType").toString();
			String tech_sup_status_code = map.get("tech_sup_status_code").toString();
						
			if("ins".equals(actType)){
				map.put("command", "ins_status" + tech_sup_status_code);
				result = techsupBiz.insertTechStatus(map);
				
			}else if("mod".equals(actType)){
				
			}else if("del".equals(actType)){
				map.put("command", "del");
			}else if("useYn".equals(actType)){
				if(map.get("use_yn").equals("Y")){
					map.put("command", "delY");
				}else{
					map.put("command", "del");
				}
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
	public ModelAndView techsupMemo(HttpServletRequest request, HttpServletResponse response) throws Exception{
		ModelAndView mav = null;

		try{			
			mav = new ModelAndView();
			HashMap map = WebUtil.parseRequestMap(request);
			
			HashMap adminMap = (HashMap)request.getSession().getAttribute(SGConfigManager.getString("common.session.admin.name"));
			map.put("admin_id", (String)adminMap.get("ADMIN_ID"));
			map.put("groups", (String)adminMap.get("GROUPS"));
			map.put("chman_no", (String)adminMap.get("SABUN"));
		  
			mav.setViewName("/sgportal/techsup/pjtMemo");
			
			mav.addObject("memoList", techsupBiz.pjtMemoList(map));
			
			mav.addObject("pMap",map);
			mav.addAllObjects(map); 
			
		} catch (Exception e) {
			logger.error(e, e);
		}
		return mav;
	}
	
	
	@SuppressWarnings("unchecked")
	public ModelAndView supTalkAction(HttpServletRequest request, HttpServletResponse response) throws Exception{
		ModelAndView mav = null;
		boolean result=false;
		try{
			mav = new ModelAndView();
			HashMap map = WebUtil.parseRequestMap(request);
			
			HashMap adminMap = (HashMap)request.getSession().getAttribute(SGConfigManager.getString("common.session.admin.name"));
			map.put("groups", (String)adminMap.get("GROUPS"));
			map.put("admin_id", (String)adminMap.get("ADMIN_ID"));
			map.put("chman_no", (String)adminMap.get("SABUN"));
			 
			mav.setViewName("/sgportal/techsupAppAction");  
			 
			String actType = map.get("actType").toString();
						
			if("ins_talk".equals(actType)){
				map.put("command", "ins_talk");
				result = techsupBiz.insertTechSupAppTalk(map); 
				
			}else if("del_talk".equals(actType)){
				map.put("command", "del_talk");
				result = techsupBiz.deleteTechSupAppTalk(map);  
			} 	 	
			
			mav.addObject("result", result); 	
			mav.addObject("pMap",map);	  
			mav.addAllObjects(map); 
			
		} catch (Exception e) {
			logger.error(e, e);
		}
		return mav;
	}
	
}
