package com.sg.sgis.layout;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.servlet.ModelAndView;

import com.sg.sgis.com.calendar.CalendarBiz;
import com.sg.sgis.com.dept.DeptBiz;
import com.sg.sgis.com.sgisCode.SgisCodeBiz;
import com.sg.sgis.dev.pjdInfoMng.PjdInfoMngBiz;
import com.sg.sgis.pjt.pjtManage.PjtIssueBiz;
import com.sg.sgis.pjt.pjtManage.PjtManageBiz;
import com.signgate.core.config.SGConfigManager;
import com.signgate.core.web.controller.SGAdminController;
import com.signgate.core.web.controller.SGUserController;
import com.signgate.core.web.manage.menu.MenuBiz;
import com.signgate.core.web.util.WebUtil;

public class LayoutController  extends SGAdminController{
	protected final Log logger = LogFactory.getLog(getClass());

	LayoutBiz layoutBiz; 
	public void setLayoutBiz(LayoutBiz layoutBiz) {
		this.layoutBiz = layoutBiz;
	}
	
	MenuBiz menuBiz;
	public void setMenuBiz(MenuBiz menuBiz) {
		this.menuBiz = menuBiz;
	}
	
	private PjtManageBiz pjtManageBiz; 
	public void setPjtManageBiz(PjtManageBiz pjtManageBiz){
		this.pjtManageBiz = pjtManageBiz;
	} 

	private CalendarBiz calendarBiz;
	public void setCalendarBiz(CalendarBiz calendarBiz) {
		this.calendarBiz = calendarBiz;
	} 
	
	private PjtIssueBiz pjtIssueBiz; 
	public void setPjtIssueBiz(PjtIssueBiz pjtIssueBiz){
		this.pjtIssueBiz = pjtIssueBiz;
	}
	 
	private PjdInfoMngBiz pjdInfoMngBiz; 
	public void setPjdInfoMngBiz(PjdInfoMngBiz pjdInfoMngBiz) {
		this.pjdInfoMngBiz = pjdInfoMngBiz;
	}
	
	
	public ModelAndView treeMenu(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = null;
		List result = null; 
		
		try{
			mav = new ModelAndView();
			HashMap mapResult = new HashMap();
			HashMap map = WebUtil.parseRequestMap(request);
			HashMap adminMap = (HashMap)request.getSession().getAttribute(SGConfigManager.getString("common.session.admin.name"));
					map.put("admin_id", (String)adminMap.get("ADMIN_ID"));
					map.put("groups", (String)adminMap.get("GROUPS"));
					map.put("emp_num", (String)adminMap.get("SABUN")); 
			
			String node = WebUtil.nullCheck((String)map.get("node"), ""); 
			JSONArray jsonArray = new JSONArray();
			JSONObject jsonObject = new JSONObject();
			
			String[] group_id = adminMap.get("GROUPS").toString().split(",");
			map.put("group_id", group_id);		
			
			if(node.equals("project")|| node.equals("")){
				 
				result = layoutBiz.selAllMenuList2(map); 
			
			}else if(node.length() == 3) { 
				map.put("node",node);
				result = layoutBiz.selAllMenuList2_node(map);
			}else if(node.length() == 6) { 
				map.put("node",node);
				result = layoutBiz.selAllMenuList3_node(map);
			} 
						
			
			jsonArray = JSONArray.fromObject(result); 
			mapResult.put("tree", jsonArray);	
			jsonObject = JSONObject.fromObject(mapResult);
						
			
			mav.addObject("RESULT", jsonObject);

		}catch(Exception ex){
			logger.error(ex.getMessage());
		}

		return mav;
	}
	
	public ModelAndView topMenu(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = null;

		try{
			mav = new ModelAndView();
			
			HashMap adminMap = (HashMap)request.getSession().getAttribute(SGConfigManager.getString("common.session.admin.name"));
					mav.addObject("admin_id", (String)adminMap.get("ADMIN_ID"));
					mav.addObject("groups", (String)adminMap.get("GROUPS"));
					mav.addObject("emp_num", (String)adminMap.get("SABUN"));
					mav.addObject("dept_code",pjtManageBiz.getDeptCode((String)adminMap.get("SABUN")));
					
					mav.addObject("dept_nm", pjtManageBiz.getDeptNm(pjtManageBiz.getDeptCode((String)adminMap.get("SABUN"))));
					 
					mav.addObject("degree_RND", pjtManageBiz.getDegreeRCode((String)adminMap.get("SABUN")));
					mav.addObject("degree_BUSINESS", pjtManageBiz.getDegreeBCode((String)adminMap.get("SABUN")));

		}catch(Exception ex){
			logger.error(ex.getMessage());
		}

		return mav;
	}
	
	public ModelAndView main(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = null;
		
		try{
			mav = new ModelAndView();
			HashMap map = WebUtil.parseRequestMap(request);
			HashMap adminMap = (HashMap)request.getSession().getAttribute(SGConfigManager.getString("common.session.admin.name"));
				map.put("admin_id", (String)adminMap.get("ADMIN_ID"));
				map.put("groups", (String)adminMap.get("GROUPS"));
				map.put("emp_num", (String)adminMap.get("SABUN")); 
				map.put("login_ip", (String)request.getRemoteAddr());
				
				mav.addObject("dept_code",pjtManageBiz.getDeptCode((String)adminMap.get("SABUN")));
				mav.addObject("dept_nm", pjtManageBiz.getDeptNm(pjtManageBiz.getDeptCode((String)adminMap.get("SABUN"))));
				mav.addObject("degree_RND", pjtManageBiz.getDegreeRCode((String)adminMap.get("SABUN")));
				mav.addObject("degree_BUSINESS", pjtManageBiz.getDegreeBCode((String)adminMap.get("SABUN")));
				 
			
			//로그인 이력 저장
			if(map.get("logSave").equals("1stSave")){
		    	//layoutBiz.insertLoginInfo(map); 
			}
			
		}catch(Exception ex){
			logger.error(ex.getMessage());
		}
		
		return mav;
	}
	
	
	public ModelAndView mainView(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = null;
		
		try{
			mav = new ModelAndView();
			HashMap map = WebUtil.parseRequestMap(request);
			HashMap adminMap = (HashMap)request.getSession().getAttribute(SGConfigManager.getString("common.session.admin.name"));
				map.put("admin_id", (String)adminMap.get("ADMIN_ID"));
			 
				
				//개인 일정  가져와 보여주기
				map.put("scd_day_reg_dept", pjtManageBiz.getDeptCode((String)adminMap.get("SABUN")));
				map.put("scd_day_reg_emp_num", (String)adminMap.get("SABUN"));
				mav.addObject("ScheduleList", calendarBiz.selectSchedule(map));
				
				
				
				
				
				
		}catch(Exception ex){
			logger.error(ex.getMessage());
		}
		
		return mav;
	}
	
	public ModelAndView main2(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = null;
		
		try{
			mav = new ModelAndView();
			
		}catch(Exception ex){
			logger.error(ex.getMessage());
		}
		
		return mav;
	}
	
	public ModelAndView centerSample(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = null;
		
		try{
			mav = new ModelAndView();
			
		}catch(Exception ex){
			logger.error(ex.getMessage());
		}
		
		return mav;
	}
	
	public ModelAndView searchSample(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = null;
		
		try{
			mav = new ModelAndView();
			
		}catch(Exception ex){
			logger.error(ex.getMessage());
		}
		
		return mav;
	}
	
	public ModelAndView regSample(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = null;
		
		try{
			mav = new ModelAndView();
			
		}catch(Exception ex){
			logger.error(ex.getMessage());
		}
		
		return mav;
	}
	
}
