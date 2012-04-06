package sg.svc.portal.bass.schedule;

import java.util.HashMap;
import java.util.List;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.servlet.ModelAndView;

import sg.svc.portal.bass.schedule.domain.Schedule;


import com.signgate.core.web.controller.SGAdminController;
import com.signgate.core.web.util.WebUtil;


import com.signgate.core.config.SGConfigManager;
import com.signgate.core.util.DateUtil; 
/**
 * 일정 컨트롤러
 * @author badangel79
 *
 */
public class ScheduleController extends SGAdminController {
	protected final Log logger = LogFactory.getLog(getClass());	
	
	private ScheduleBiz scheduleBiz;
	
	/**
	 * 일정 biz 설정
	 * @param scheduleBiz
	 */
	public void setScheduleBiz(ScheduleBiz scheduleBiz)
	{
		this.scheduleBiz = scheduleBiz;
	}
	
	//월별 일정을 가지고 온다.
	@SuppressWarnings({ "unchecked", "static-access" })
	public ModelAndView monthSchedule(HttpServletRequest request, HttpServletResponse response) {
	   ModelAndView mv = new ModelAndView();
	   String sYear = "";
	   String sMonth = "";
	   
	   try {
		   HashMap map = WebUtil.parseRequestMap(request);   
		  
		   HashMap adminMap = (HashMap)WebUtil.getSessionAttribute(request, SGConfigManager.getString("common.session.admin.name"));
		   map.put("groups", (String)adminMap.get("GROUPS"));
		   map.put("admin_id", (String)adminMap.get("ADMIN_ID"));
		   map.put("chman_no", (String)adminMap.get("SABUN"));
			
		   //달 월이 있을 경우
		   if(map.get("year") == null || map.get("month") == null)
		   {
			   sYear = DateUtil.getCurrentDate("yyyy");
			   sMonth= DateUtil.getCurrentDate("MM");		   
			   
			   map.put("year",sYear);
			   map.put("month",sMonth);
			   
		   }
		   else
		   {
			   sYear = map.get("year").toString();
			   sMonth = map.get("month").toString();
		   }
		   
		   String sPredate = DateUtil.getIncrementMonth(sYear+""+sMonth+"01", -1, "yyyyMM"); 
		   String sNextdate = DateUtil.getIncrementMonth(sYear+""+sMonth+"01", 1, "yyyyMM");
		   
		   Object[][] azDateTab = scheduleBiz.getDateTable(Integer.parseInt(sYear),Integer.parseInt(sMonth));	 
			   
	   	   List list = scheduleBiz.getSchedulList(map, request);
	   	   
	   	   HashMap hm2 = scheduleBiz.getSchedule(list);   	   
	   	  
	   	   Object temp[][] = new Object[6][7];   	   
	   	   
	   	   for(int i=0; i<6; i++)
	   	   {
	   		   for(int j=0; j<7; j++)
	   		   {
	   			   HashMap mtb = new HashMap();
	   			   mtb.put("dday", azDateTab[i][j]);
	   			   mtb.put("datalist",hm2.get("a"+azDateTab[i][j].toString()));
	   			   if(hm2.get("a"+azDateTab[i][j].toString()) != null)   				   
	   			   		mtb.put("size",((List)hm2.get("a"+azDateTab[i][j].toString())).size());
	   			   else
	   				mtb.put("size",0);
	   			   temp[i][j]  = mtb;		                              
	   		   }
	   	   }
	   	   
	   	   HashMap viewmap = new HashMap();
	   	   
	   	   viewmap.put("year", sYear);
	   	   viewmap.put("month",sMonth);
	   	   viewmap.put("pyear", sPredate.substring(0,4));
	   	   viewmap.put("pmonth", sPredate.substring(4));
	   	   viewmap.put("nyear", sNextdate.substring(0,4));
		   viewmap.put("nmonth",sNextdate.substring(4));
	        
		   mv.addObject("dateTab",temp);
		   mv.addObject("viewData",viewmap);
	   
	   
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	  
	   return mv;
	}
	
	//주 일정 컨트롤러 
	@SuppressWarnings({ "unchecked", "static-access" })
	public ModelAndView weekSchedule(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = null;
		String[] azDay = new String[3];
		String[] weekScheduleTime = new String[scheduleBiz.SCHEDULETIME.length];
		
		String sStartDay = "";
		String sEndDay = "";
		
		try {
			mav = new ModelAndView();
			HashMap map = WebUtil.parseRequestMap(request);
			 
			if(map.get("schWeek") == null)
			{
				azDay = DateUtil.getCurrentDateArr();
			}
			else
			{
				String schDate = map.get("schWeek").toString();
				azDay[0] = schDate.substring(0, 4);
				azDay[1] = schDate.substring(4, 6);
				azDay[2] = schDate.substring(6, 8);
			}
			
			String[] azWeekDay = scheduleBiz.getWeekTable(Integer.parseInt(azDay[0]),Integer.parseInt(azDay[1]),Integer.parseInt(azDay[2]));			
			
			sStartDay = azWeekDay[0];
			sEndDay = azWeekDay[6];
			
			map.put("stdate", sStartDay);
			map.put("eddate", sEndDay);
			
			List list = scheduleBiz.getWeekSchedulList(map,request);
						
			mav.addObject("weekDay",azWeekDay);
			mav.addObject("stWeek",DateUtil.getIncrementDay(sStartDay, -1, "yyyyMMdd"));
			mav.addObject("edWeek",DateUtil.getIncrementDay(sEndDay, 1, "yyyyMMdd"));
			mav.addObject("stDay",sStartDay);
			mav.addObject("edDay",sEndDay);
			mav.addObject("list", list);
			mav.addObject("weekScheduleTime", scheduleBiz.SCHEDULETIME);
			mav.addObject("pMap",map);	  
		
		} catch (Exception e) {
			logger.error(e, e);
		}
		return mav;
	}
	
	public String getStrMonth(String n)
	{
		if(Integer.parseInt(n) < 10) return "0"+n;
		
		return n;
	}
	
	//스케줄 일정을 등록한다.
	@SuppressWarnings("unchecked")
	public ModelAndView scheduleWrite(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = null;

		try {
			mav = new ModelAndView(); 
			
			HashMap map = WebUtil.parseRequestMap(request);
			
			HashMap schedule  = scheduleBiz.selScheduleView(map);
			
			if(schedule != null){	 
				mav.addObject("chk","modify");				
			}else{				
				mav.addObject("chk","write");				
			}
			mav.addObject("schedule", scheduleBiz.selScheduleView(map));
			mav.addObject("pMap",map);
			
		} catch (Exception e) {
			logger.error(e, e);
		}
		return mav;
	}
	
	//스케줄 일정을 삭제한다.
	@SuppressWarnings("unchecked")
	public ModelAndView scheduleDelete(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = null;

		try {
			mav = new ModelAndView();		
			
			HashMap map = WebUtil.parseRequestMap(request);
			 
			scheduleBiz.delScheduleDelete(map);
			
			mav.setViewName("/jsp/sgportal/schedule/scheduleWriteAct");
		} catch (Exception e) {
			logger.error(e, e);
		}
		return mav;
	}
	
	//스케줄 일정을 등록한다.
	@SuppressWarnings("unchecked")
	public ModelAndView scheduleWriteAct(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView();
		boolean blExt = true;
		try {
			mav = new ModelAndView();
	    	HashMap map = WebUtil.parseRequestMap(request);
	    	
	    	HashMap adminMap = (HashMap)WebUtil.getSessionAttribute(request, SGConfigManager.getString("common.session.admin.name"));
	    	map.put("groups", (String)adminMap.get("GROUPS"));
	    	map.put("admin_id", (String)adminMap.get("ADMIN_ID"));
	    	map.put("chman_no", (String)adminMap.get("SABUN"));	    	
	    	 	    	
	    	String sMode = map.get("chk").toString();   	
	    	
	    	String st_date = map.get("st_date").toString()+map.get("st_time1").toString()+map.get("st_time2").toString();
	    	String end_date = map.get("end_date").toString()+map.get("end_time1").toString()+map.get("end_time2").toString();
	    	
	    	map.put("st_date", st_date.replaceAll("-", ""));
	    	map.put("end_date", end_date.replaceAll("-", ""));
	    	
	    	mav.setViewName("/sgportal/schedule/scheduleWriteAct");
	    	
	    	if(sMode.equals("write") || sMode.equals("")){
	    		//int nCnt = scheduleBiz.getScheduleCount(map);
	    		//if(nCnt ==0){
	    			scheduleBiz.insScheduleInsert(map);
	    			blExt = false;						// 존재하지 않을시
	    		//}
	    	}else if(sMode.equals("modify")){
	    		scheduleBiz.updScheduleUpdate(map);	    		
	    	}else if(sMode.equals("delete")){
	    		scheduleBiz.delScheduleDelete(map);
	    	}
	    	
	    	mav.addObject("pMap",map);
	    	mav.addObject("blExt",blExt);
		} catch (Exception e) {
			mav.addObject("error","error");
			logger.error(e, e);
		}
		return mav;
	}
	 
	 
	
}
