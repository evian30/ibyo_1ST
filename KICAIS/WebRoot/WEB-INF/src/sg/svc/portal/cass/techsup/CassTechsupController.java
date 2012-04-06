package sg.svc.portal.cass.techsup;
 
import java.util.HashMap; 

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse; 

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.servlet.ModelAndView;

import sg.svc.portal.cass.techsup.CassTechsupBiz;
import sg.svc.portal.bass.chman.ChmanBiz;
import sg.svc.portal.bass.product.ProdcutBiz;

import com.signgate.core.config.SGConfigManager;
import com.signgate.core.web.controller.SGAdminController;
import com.signgate.core.web.util.SGFileBean;
import com.signgate.core.web.util.WebUtil;

 
public class CassTechsupController extends SGAdminController {
	
	protected final Log logger = LogFactory.getLog(getClass());
	
	private CassTechsupBiz cassTechsupBiz;
	public void setCassTechsupBiz(CassTechsupBiz cassTechsupBiz){
		this.cassTechsupBiz = cassTechsupBiz;
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
	 * 장애처리 등록/조회/수정
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public ModelAndView cassTechsupApp(HttpServletRequest request, HttpServletResponse response) throws Exception{
		ModelAndView mav = null;

		try{
			mav = new ModelAndView();
			HashMap map = WebUtil.parseRequestMap(request);
			
			HashMap adminMap = (HashMap)request.getSession().getAttribute(SGConfigManager.getString("common.session.admin.name"));
			map.put("admin_id", (String)adminMap.get("ADMIN_ID"));
			map.put("groups", (String)adminMap.get("GROUPS"));
			map.put("chman_no", (String)adminMap.get("SABUN"));
			 
			mav.setViewName("/sgportal/cass/techsup/cassTechsupApp"); 
			   
			
			if(!"ins".equals(map.get("actType").toString())){
				mav.addObject("getCass", cassTechsupBiz.getCassView(map));
				mav.addObject("getCorp", cassTechsupBiz.getCassViewCorp(map));
				mav.addObject("getHis", cassTechsupBiz.getCassViewHis(map));
				mav.addObject("getST1", cassTechsupBiz.getCassView1(map));
				mav.addObject("getST2", cassTechsupBiz.getCassView2(map));
				mav.addObject("getST3", cassTechsupBiz.getCassView3(map));
				
				mav.addObject("fileView", cassTechsupBiz.selCassFile(map));
				
				//mav.addObject("getCate", cassTechsupBiz.getCassViewCate(map));
			}
			
			mav.addObject("appID", cassTechsupBiz.cassAppNo(map));
			  
						  
			map.put("code_sect", "CASS_CATE");		 
			mav.addObject("cass_cate_id", chmanBiz.getCode(map));	
			
			mav.addObject("pMap",map);
			mav.addAllObjects(map); 
			
		} catch (Exception e) {
			logger.error(e, e);
		}
		return mav;
	}
	
	
	
	
	@SuppressWarnings("unchecked")
	public ModelAndView cassTechsupAction(HttpServletRequest request, HttpServletResponse response) throws Exception{
		ModelAndView mav = null;
		boolean result=false;
		try{
			mav = new ModelAndView();
			HashMap map = WebUtil.parseRequestMap(request);
			
			HashMap adminMap = (HashMap)request.getSession().getAttribute(SGConfigManager.getString("common.session.admin.name"));
			map.put("groups", (String)adminMap.get("GROUPS"));
			map.put("admin_id", (String)adminMap.get("ADMIN_ID"));
			map.put("chman_no", (String)adminMap.get("SABUN"));
			 
			
			SGFileBean sgfb = new SGFileBean("");			
			WebUtil.processMultipart(request, sgfb, map);  
			 
			mav.setViewName("/sgportal/cass/techsup/cassAction"); 
			 
			 
			String actType = map.get("actType").toString();
			
			if("ins".equals(actType)){
				
				map.put("command", "insert"); 
				result = cassTechsupBiz.insertCassStep1(map);
				
				map.put("c_tech_sup_pr_id", "1");
				result = cassTechsupBiz.insertCassHistory(map);
				
				if(!(map.get("c_st1_content").toString()).equals("")){
					result = cassTechsupBiz.insertCassStep1_1(map);
					
					map.put("c_tech_sup_pr_id", "2");
					 result = cassTechsupBiz.insertCassHistory(map);
				}
				
				if(!(map.get("c_st2_content").toString()).equals("")){
					result = cassTechsupBiz.insertCassStep1_2(map);
					
					map.put("c_tech_sup_pr_id", "3");
					 result = cassTechsupBiz.insertCassHistory(map);
				}
				
				if(!(map.get("c_st3_content").toString()).equals("")){
					result = cassTechsupBiz.insertCassStep1_3(map);
					
					map.put("c_tech_sup_pr_id", "4");
					 result = cassTechsupBiz.insertCassHistory(map);
				}
				 

			}else if("ins_ST1".equals(actType)){
				 map.put("command", "insert_st1");
				 result = cassTechsupBiz.insertCassStep1_1(map);
				 
				 map.put("c_tech_sup_pr_id", "2");
				 result = cassTechsupBiz.insertCassHistory(map);
			
			}else if("ins_ST2".equals(actType)){
				 map.put("command", "insert_st2");
				 result = cassTechsupBiz.insertCassStep1_2(map);
				 
				 map.put("c_tech_sup_pr_id", "3");
				 result = cassTechsupBiz.insertCassHistory(map);
				 
			}else if("ins_ST3".equals(actType)){
				 map.put("command", "insert_st3");
				 result = cassTechsupBiz.insertCassStep1_3(map);
				 
				 map.put("c_tech_sup_pr_id", "4");
				 result = cassTechsupBiz.insertCassHistory(map);
			
				 
			}else if("ins_ST".equals(actType)){
				 map.put("command", "insert_st");
				if(!(map.get("c_st1_content").toString()).equals("")){
					result = cassTechsupBiz.insertCassStep1_1(map);
					
					map.put("c_tech_sup_pr_id", "2");
					 result = cassTechsupBiz.insertCassHistory(map);
				}
				
				if(!(map.get("c_st2_content").toString()).equals("")){
					result = cassTechsupBiz.insertCassStep1_2(map);
					
					map.put("c_tech_sup_pr_id", "3");
					 result = cassTechsupBiz.insertCassHistory(map);
				}
				
				if(!(map.get("c_st3_content").toString()).equals("")){
					result = cassTechsupBiz.insertCassStep1_3(map);
					
					map.put("c_tech_sup_pr_id", "4");
					 result = cassTechsupBiz.insertCassHistory(map);
				} 
			
			}else if("close_ST".equals(actType)){
				 	map.put("command", "finish");  
					map.put("c_tech_sup_pr_id", "7");
					result = cassTechsupBiz.insertCassHistory(map);
				  
			}else if("mod".equals(actType)){
				
				map.put("command", "update");
				result = cassTechsupBiz.updateCassStep1(map);
				 
				map.put("c_tech_sup_pr_id", "5");
				result = cassTechsupBiz.insertCassHistory(map);
		 
			}else if("del_st1".equals(actType)){
				map.put("command", "delete_st");
				map.put("c_st1_seq", map.get("c_st_seq"));
				result = cassTechsupBiz.deleteCassStep2(map);
			}else if("del_st2".equals(actType)){
				map.put("command", "delete_st");
				map.put("c_st2_seq", map.get("c_st_seq"));
				result = cassTechsupBiz.deleteCassStep2(map);
			}else if("del_st3".equals(actType)){
				map.put("command", "delete_st");
				map.put("c_st3_seq", map.get("c_st_seq"));
				result = cassTechsupBiz.deleteCassStep2(map);
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
	public ModelAndView cassTechSupAppList(HttpServletRequest request, HttpServletResponse response) throws Exception{
		ModelAndView mav = null;

		try{
			mav = new ModelAndView();
			HashMap map = WebUtil.parseRequestMap(request);
			
			HashMap adminMap = (HashMap)request.getSession().getAttribute(SGConfigManager.getString("common.session.admin.name"));
			map.put("admin_id", (String)adminMap.get("ADMIN_ID"));
			map.put("groups", (String)adminMap.get("GROUPS"));
			map.put("chman_no", (String)adminMap.get("SABUN"));
		  	 
			mav.setViewName("/sgportal/cass/techsup/cassTechSupAppList");
			
			mav.addObject("getCassList", cassTechsupBiz.getCassList(map)); 
			mav.addObject("getCassCount", cassTechsupBiz.getCassCount(map)); 
			
			map.put("code_sect", "CASS_CATE");		 
			mav.addObject("cass_cate_id", chmanBiz.getCode(map));	
			
			
			mav.addObject("pMap",map);
			mav.addAllObjects(map); 
			
		} catch (Exception e) {
			logger.error(e, e);
		}
		return mav;
	}


	
	@SuppressWarnings("unchecked")
	public ModelAndView viewProdSG(HttpServletRequest request, HttpServletResponse response) throws Exception{
		ModelAndView mav = null;
		boolean result=false;
		try{
			mav = new ModelAndView();
			HashMap map = WebUtil.parseRequestMap(request);
			
			HashMap adminMap = (HashMap)request.getSession().getAttribute(SGConfigManager.getString("common.session.admin.name"));
			map.put("groups", (String)adminMap.get("GROUPS"));
			map.put("admin_id", (String)adminMap.get("ADMIN_ID"));
			map.put("chman_no", (String)adminMap.get("SABUN"));
			 
			
			SGFileBean sgfb = new SGFileBean("");			
			WebUtil.processMultipart(request, sgfb, map);  
			 
			mav.setViewName("/sgportal/cass/techsup/viewProdSG"); 
			 
			 
			mav.addObject("pMap",map);	  
			mav.addAllObjects(map); 
			
		} catch (Exception e) {
			logger.error(e, e);
		}
		return mav;
	}

	
}
