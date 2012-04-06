package sg.svc.portal.bass.chman;
 
import java.util.HashMap; 

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse; 

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.servlet.ModelAndView;

import com.signgate.core.config.SGConfigManager;
import com.signgate.core.web.controller.SGAdminController;
import com.signgate.core.web.util.WebUtil;

 
public class ChmanController extends SGAdminController {
	
	protected final Log logger = LogFactory.getLog(getClass());
	
	private ChmanBiz chmanBiz; 
	public void setChmanBiz(ChmanBiz chmanBiz){
		this.chmanBiz = chmanBiz;
	}	
	  
	/** 
	 * Method ID  	: chmanList
	 * Method 설명  	: SG담당자/고객 정보 목록
	 * 최초작성일  	: 2010. 08. 24. 
	 * 작성자 		: ibyo
	 * 특이사항		:
	 * 변경이력 		: 최초작성: 2010.08.24
	 * 
	 * @param request
	 * @param response
	 * @throws Exception
	 * @return 
	 */ 
	@SuppressWarnings("unchecked")
	public ModelAndView chmanList(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = null;
		
		try {
			mav = new ModelAndView();
			HashMap map = WebUtil.parseRequestMap(request);
			
			HashMap adminMap = (HashMap)request.getSession().getAttribute(SGConfigManager.getString("common.session.admin.name"));
			map.put("admin_id", (String)adminMap.get("ADMIN_ID"));
			map.put("groups", (String)adminMap.get("GROUPS"));
			
			if(map.get("viewName") == null || map.get("viewName") == ""){
				mav.setViewName("/sgportal/chman/chmanList");
			}else{
				mav.setViewName(map.get("viewName").toString());
			}
			 
			mav.addObject("list", chmanBiz.getChmanList(map));
			
			if(map.get("corp_no") != null && map.get("corp_no") != ""){
				mav.addObject("corp", chmanBiz.getChmanCom(map));
			}
			
			mav.addAllObjects(map);
			mav.addObject("pMap",map);
			
		} catch (Exception e) {
			logger.error(e, e);
		}
		return mav;
	}
	
	
	
	/** 
	 * Method ID  	: chmanComList
	 * Method 설명  	: SG회사 정보 및 고객 회사정보 목록
	 * 최초작성일  	: 2010. 08. 24. 
	 * 작성자 		: ibyo
	 * 특이사항		:
	 * 변경이력 		: 최초작성: 2010.08.24
	 * 
	 * @param request
	 * @param response
	 * @throws Exception
	 * @return 
	 */ 
	@SuppressWarnings("unchecked")
	public ModelAndView chmanComList(HttpServletRequest request, HttpServletResponse response) throws Exception{
		ModelAndView mav = null;

		try{
			mav = new ModelAndView();
			HashMap map = WebUtil.parseRequestMap(request);
			
			HashMap adminMap = (HashMap)request.getSession().getAttribute(SGConfigManager.getString("common.session.admin.name"));
			map.put("admin_id", (String)adminMap.get("ADMIN_ID"));
			map.put("groups", (String)adminMap.get("GROUPS"));
			map.put("chman_no", (String)adminMap.get("SABUN"));
			
			if(map.get("viewName") == null || map.get("viewName") == ""){
				mav.setViewName("/sgportal/chman/chmanComList");
			}else{
				mav.setViewName(map.get("viewName").toString());
			}
			
			map.put("comT", map.get("comT"));	
			map.put("hmenu_id", map.get("hmenu_id"));
			
			mav.addObject("companyList",chmanBiz.getChmanComList(map));	
			mav.addObject("companyCnt",chmanBiz.getChmanComCount(map)); 
			
			mav.addObject("pMap",map);
			mav.addAllObjects(map); 
			
		} catch (Exception e) {
			logger.error(e, e);
		}
		return mav;
	}
	
	
	/** 
	 * Method ID  	: chmanComView
	 * Method 설명  	: SG회사 정보 및 고객 회사정보 상세보기
	 * 최초작성일  	: 2010. 08. 24. 
	 * 작성자 		: ibyo
	 * 특이사항		:
	 * 변경이력 		: 최초작성: 2010.08.24
	 * 
	 * @param request
	 * @param response
	 * @throws Exception
	 * @return 
	 */ 
	@SuppressWarnings("unchecked")
	public ModelAndView chmanComView(HttpServletRequest request, HttpServletResponse response) throws Exception{
		ModelAndView mav = null;

		try{
			
			mav = new ModelAndView();
			HashMap map = WebUtil.parseRequestMap(request);
			
			HashMap adminMap = (HashMap)request.getSession().getAttribute(SGConfigManager.getString("common.session.admin.name"));
			map.put("admin_id", (String)adminMap.get("ADMIN_ID"));
			map.put("groups", (String)adminMap.get("GROUPS"));
			map.put("chman_no", (String)adminMap.get("SABUN"));
			
			if(map.get("viewName") == null || map.get("viewName") == ""){
				mav.setViewName("/sgportal/chman/chmanComView"); 
			}else{
				mav.setViewName(map.get("viewName").toString());
			}
			
			
			if(map.get("actType").equals("view") || map.get("actType").equals("mod")){
				mav.addObject("companyView",chmanBiz.getChmanCom(map));
				mav.addObject("list", chmanBiz.getChmanList(map));
			}
			
			mav.addObject("pMap",map);
			mav.addAllObjects(map);
			
		} catch (Exception e) {
			logger.error(e, e);
		}
		return mav;
	}
	
	
	/** 
	 * Method ID  	: chmanComAction
	 * Method 설명  	: SG회사 정보 및 고객 회사정보 처리 (insert, update, delete)
	 * 최초작성일  	: 2010. 08. 24. 
	 * 작성자 		: ibyo
	 * 특이사항		:
	 * 변경이력 		: 최초작성: 2010.08.24
	 * 
	 * @param request
	 * @param response
	 * @throws Exception
	 * @return 
	 */ 
	@SuppressWarnings("unchecked")
	public ModelAndView chmanComAction(HttpServletRequest request, HttpServletResponse response) throws Exception{
		ModelAndView mav = null;
		boolean result=false;
		try{
			mav = new ModelAndView();
			HashMap map = WebUtil.parseRequestMap(request);
			
			HashMap adminMap = (HashMap)request.getSession().getAttribute(SGConfigManager.getString("common.session.admin.name"));
			map.put("admin_id", (String)adminMap.get("ADMIN_ID"));
			map.put("groups", (String)adminMap.get("GROUPS"));
			map.put("chman_no", (String)adminMap.get("SABUN"));
			
			if(map.get("viewName") == null || map.get("viewName") == ""){
				mav.setViewName("/sgportal/chmanComAction");
			}else{
				mav.setViewName(map.get("viewName").toString());
			}
			
			//map.put("comT", map.get("comT"));	
			
			String ssn= request.getParameter("ssn1")+request.getParameter("ssn2")+request.getParameter("ssn3");
			String zipcode= request.getParameter("zipcode1")+request.getParameter("zipcode2");
			
			map.put("ssn", ssn); 
			map.put("zipcode", zipcode);	
		 
			String actType = map.get("actType").toString();
						
			if("ins".equals(actType)){ 
				result = chmanBiz.ChmanComInsert(map);
				map.put("command", "ins");
			}else if("mod".equals(actType)){ 
				result = chmanBiz.ChmanComUpdate(map);		  
				map.put("command", "upd");
			}else if("del".equals(actType)){ 
				result = chmanBiz.ChmanComDelete(map); 
				map.put("command", "del");
			}else if("useYn".equals(actType)){ 
				result = chmanBiz.ChmanComUseUpdate(map); 
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
	 * Method ID  	: chmanView
	 * Method 설명  	: SG/고객 담당자 정보 및 고객 회사정보 view 상세보기
	 * 최초작성일  	: 2010. 08. 24. 
	 * 작성자 		: ibyo
	 * 특이사항		:
	 * 변경이력 		: 최초작성: 2010.08.24
	 * 
	 * @param request
	 * @param response
	 * @throws Exception
	 * @return 
	 */ 
	@SuppressWarnings("unchecked")
	public ModelAndView chmanView(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = null;
 
		try {
			mav = new ModelAndView();
			HashMap map = WebUtil.parseRequestMap(request);
			
			HashMap adminMap = (HashMap)request.getSession().getAttribute(SGConfigManager.getString("common.session.admin.name"));
			map.put("admin_id", (String)adminMap.get("ADMIN_ID"));
			map.put("groups", (String)adminMap.get("GROUPS"));
			
			if(map.get("viewName") == null || map.get("viewName") == ""){
				mav.setViewName("/sgportal/chman/chmanView");
			}else{
				mav.setViewName(map.get("viewName").toString());
			}
			
			String actType = map.get("actType").toString();
			if("ins".equals(actType)){ 
				if(map.get("corp_no") != null && map.get("corp_no") != ""){
					mav.addObject("corp", chmanBiz.getChmanCom(map));
				}
			}else if("view".equals(actType)){ 
				mav.addObject("list", chmanBiz.getChmanView(map));
				mav.addObject("corp", chmanBiz.getChmanCom(map));
				mav.addAllObjects(map);
			}else if("mod".equals(actType)){ 
				mav.addObject("list", chmanBiz.getChmanView(map));
				mav.addObject("corp", chmanBiz.getChmanCom(map));
				mav.addAllObjects(map);
			}else if("del".equals(actType)){ 
			}
			
			mav.addObject("login_his", chmanBiz.chman_login_his(map));
			mav.addObject("login_hisCount", chmanBiz.chman_login_hisCount(map));
			
			//직급 코드
			map.put("code_sect", "GRADE_CODE");
			mav.addObject("c_grade_code", chmanBiz.getCode(map));
			//부서 코드
			map.put("code_sect", "DEPT_CODE");
			mav.addObject("c_dept_code", chmanBiz.getCode(map));
			//담당업무 코드
			map.put("code_sect", "CHMAN_TYPE_CODE");
			mav.addObject("c_chman_type_code", chmanBiz.getCode(map));
			mav.addObject("pMap",map);
			 
			mav.addAllObjects(map); 
			
		} catch (Exception e) {
			logger.error(e, e);
		}
		return mav;
	}
	

	/** 
	 * Method ID  	: chmanInsert
	 * Method 설명  	: SG담당자/고객 등록 정보 목록
	 * 최초작성일  	: 2010. 08. 24. 
	 * 작성자 		: ibyo
	 * 특이사항		:
	 * 변경이력 		: 최초작성: 2010.08.24
	 * 
	 * @param request
	 * @param response
	 * @throws Exception
	 * @return 
	 */ 
	@SuppressWarnings("unchecked")
	public ModelAndView chmanInsert(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = null;
 
		try {
			mav = new ModelAndView();
			HashMap map = WebUtil.parseRequestMap(request);
			
			HashMap adminMap = (HashMap)request.getSession().getAttribute(SGConfigManager.getString("common.session.admin.name"));
			map.put("admin_id", (String)adminMap.get("ADMIN_ID"));
			map.put("groups", (String)adminMap.get("GROUPS"));
			
			mav.setViewName("/sgportal/chmanAction");
			mav.addObject("eventList", chmanBiz.insChmanInsert(map));
			
		} catch (Exception e) {
			logger.error(e, e);
		}
		return mav;
	}
	
	/** 
	 * Method ID  	: chmanCudAction
	 * Method 설명  	: SG/고객 담당자 정보 처리 (insert, update, delete)
	 * 최초작성일  	: 2010. 08. 24. 
	 * 작성자 		: ibyo
	 * 특이사항		:
	 * 변경이력 		: 최초작성: 2010.08.24
	 * 
	 * @param request
	 * @param response
	 * @throws Exception
	 * @return 
	 */ 
	@SuppressWarnings("unchecked")
	public ModelAndView chmanCudAction(HttpServletRequest request, HttpServletResponse response) throws Exception{
		ModelAndView mav = null;
		boolean result=false;
		try{
			mav = new ModelAndView();
			HashMap map = WebUtil.parseRequestMap(request);
			
			HashMap adminMap = (HashMap)request.getSession().getAttribute(SGConfigManager.getString("common.session.admin.name"));
			map.put("admin_id", (String)adminMap.get("ADMIN_ID"));
			map.put("groups", (String)adminMap.get("GROUPS"));
			
			String actType = map.get("actType").toString();
			
			if(map.get("viewName") == null || map.get("viewName") == ""){
				mav.setViewName("/sgportal/chman/chmanView");
			}else{
				mav.setViewName(map.get("viewName").toString());
			}
			
			if("ins".equals(actType)){ 
				result = chmanBiz.insChmanInsert(map);
				map.put("command", "ins");
				map.put("actType", "view");
			}else if("mod".equals(actType)){ 
				result = chmanBiz.modChmanUpdate(map);
				
				map.put("command", "upd");
				map.put("actType", "view");
			}else if("del".equals(actType)){ 
				result = chmanBiz.delChmanDelete(map);	
				map.put("command", "del");
				map.put("actType", "del");
			}else if("useYn".equals(actType)){ 
				result = chmanBiz.delChmanUseDelete(map);	
				if(map.get("use_yn").equals("Y")){
					map.put("command", "delY");
				}else{
					map.put("command", "del");
				}
			}
				
			mav.addObject("pMap", map);
			mav.addObject("result", result);
			
		} catch (Exception e) {
			logger.error(e, e);
		}
		return mav;
	}
	
	
	/** 
	 * Method ID  	: xmlChmanList
	 * Method 설명  	: SG담당자/고객 정보 목록 XML
	 * 최초작성일  	: 2010. 08. 24. 
	 * 작성자 		: ibyo
	 * 특이사항		:
	 * 변경이력 		: 최초작성: 2010.08.24
	 * 
	 * @param request
	 * @param response
	 * @throws Exception
	 * @return 
	 */ 
	@SuppressWarnings("unchecked")
	public ModelAndView xmlChmanList(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = null;

		try {
			mav = new ModelAndView();
			HashMap map = WebUtil.parseRequestMap(request);
			HashMap adminMap = (HashMap)request.getSession().getAttribute(SGConfigManager.getString("common.session.admin.name"));
		
			mav.setViewName("/sgportal/sgAjax");
			HashMap paraMap = chmanBiz.selectXmlChmanList(map, request);
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
	
	@SuppressWarnings("unchecked")
	public ModelAndView selectChmanComListXml(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = null;

		try {
			mav = new ModelAndView();
			HashMap map = WebUtil.parseRequestMap(request);
			HashMap adminMap = (HashMap)request.getSession().getAttribute(SGConfigManager.getString("common.session.admin.name"));
		
			mav.setViewName("/sgportal/sgAjax");
			HashMap paraMap = chmanBiz.selectChmanComListXml(map, request);
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
	
	
	@SuppressWarnings("unchecked")
	public ModelAndView ssnCheck(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = null;

		try {
			mav = new ModelAndView();
			HashMap map = WebUtil.parseRequestMap(request);
			HashMap adminMap = (HashMap)request.getSession().getAttribute(SGConfigManager.getString("common.session.admin.name"));
		

			mav.setViewName("/sgportal/sgAjax");
			HashMap paraMap = chmanBiz.ssnCheck(map, request);
			
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


}