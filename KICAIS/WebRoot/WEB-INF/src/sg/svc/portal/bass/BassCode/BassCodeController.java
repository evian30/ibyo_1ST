package sg.svc.portal.bass.BassCode;
 
import java.util.HashMap; 

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse; 

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.servlet.ModelAndView;
import com.signgate.core.web.controller.SGAdminController;
import com.signgate.core.web.util.WebUtil;

 
public class BassCodeController extends SGAdminController {
	
	protected final Log logger = LogFactory.getLog(getClass());
	
	private BassCodeBiz bassCodeBiz; 
	public void setBassCodeBiz(BassCodeBiz bassCodeBiz){
		this.bassCodeBiz = bassCodeBiz;
	}
	
 
	@SuppressWarnings("unchecked")
	public ModelAndView bassCodeList(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = null;

		try {
			mav = new ModelAndView();
			HashMap map = WebUtil.parseRequestMap(request); 
			 
			mav.setViewName("/sgportal/bassCode/bassCodeList");	
			 
			mav.addObject("bassCodeList", bassCodeBiz.listData(map)); 
			mav.addObject("bassCodeView",bassCodeBiz.selectData(map)); 
			 
			mav.addObject("pMap",map);
			mav.addAllObjects(map);
			
		} catch (Exception e) {
			logger.error(e, e);
		}
		return mav;
	}
		 
	
	@SuppressWarnings("unchecked")
	public ModelAndView bassCodeView(HttpServletRequest request, HttpServletResponse response) throws Exception{
		ModelAndView mav = null;

		try{
			
			mav = new ModelAndView();
			HashMap map = WebUtil.parseRequestMap(request);
			
			mav.setViewName("/sgportal/bassCode/bassCodeView"); 
						
			mav.addObject("bassCodeView",bassCodeBiz.selectData(map)); 
			
			mav.addObject("pMap",map);
			mav.addAllObjects(map);
			
			
		} catch (Exception e) {
			logger.error(e, e);
		}
		return mav;
	}
	 
	 
	@SuppressWarnings("unchecked")
	public ModelAndView bassCodeAction(HttpServletRequest request, HttpServletResponse response) throws Exception{
		ModelAndView mav = null;
		boolean result=false;
		try{
			
			mav = new ModelAndView();
			HashMap map = WebUtil.parseRequestMap(request); 
			
			mav.setViewName("/sgportal/bassCode/bassCodeAction");  
			
			String actType = map.get("actType").toString(); 
			 			
			 
			map.put("command", actType);
			result = bassCodeBiz.bassAction(map, actType); 
			
			mav.addObject("result", result); 	
			mav.addObject("pMap",map);	  
			mav.addAllObjects(map);
			
		} catch (Exception e) {
			logger.error(e, e);
		}
		return mav;
	}

	 


}