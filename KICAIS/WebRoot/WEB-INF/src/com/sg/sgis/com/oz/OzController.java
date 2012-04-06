package com.sg.sgis.com.oz;
 

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
 

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.servlet.ModelAndView;
import com.signgate.core.config.SGConfigManager;

import com.sg.sgis.util.CommonUtil;
import com.signgate.core.web.controller.SGUserController;
 
 
public class OzController extends SGUserController{
	protected final Log logger = LogFactory.getLog(getClass());
	
	private OzBiz ozBiz;
	public void setOzBiz(OzBiz ozBiz) {
		this.ozBiz = ozBiz;
	} 
	 
	CommonUtil comUtil = new CommonUtil();
	 
	/**
	 * 보고서 초기화면
	 * @param request
	 * @param response
	 * @return
	 * 2011. 5. 27.
	 */
	public ModelAndView ozReport(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = null;
		
		try {
			mav = new ModelAndView();
			mav.setViewName("/ozr/ozReport");  
			
			mav.addObject("oz", SGConfigManager.getString("common.ozReport")); 

		} catch (Exception e) {
			logger.error(e, e);
		}
		return mav;
	} 
	
	/**
	 * 레포트 팝업 호출(공통)
	 * @param request
	 * @param response
	 * @return
	 * 2011. 5. 27.
	 */
	public ModelAndView ozReportPop(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = null;
		
		try {
			mav = new ModelAndView();
			mav.setViewName("/ozr/ozReportPop");  
			
			mav.addObject("oz", SGConfigManager.getString("common.ozReport")); 

		} catch (Exception e) {
			logger.error(e, e);
		}
		return mav;
	}  
	
	/**
	 * 보고서_영업접대비 현황
	 * @param request
	 * @param response
	 * @return
	 * 2011. 5. 27.
	 */
	public ModelAndView receptionAccountMonthlyPop(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = null;
		
		try {
			mav = new ModelAndView();
			mav.setViewName("/ozr/receptionAccountMonthlyPop");
		} catch (Exception e) {
			logger.error(e, e);
		}
		return mav;
	}  
	
	/**
	 * 프로젝트별 영업비용분석
	 * @param request
	 * @param response
	 * @return
	 * 2011. 5. 30.
	 */
	public ModelAndView projectSalesActivityPop(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = null;
		
		try {
			mav = new ModelAndView();
			mav.setViewName("/ozr/projectSalesActivityPop");
		} catch (Exception e) {
			logger.error(e, e);
		}
		return mav;
	}  
	
	/**
	 * 프로젝트별 원가분석
	 * @param request
	 * @param response
	 * @return
	 * 2011. 5. 30.
	 */
	public ModelAndView projectCostPop(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = null;
		
		try {
			mav = new ModelAndView();
			mav.setViewName("/ozr/projectCostPop");
		} catch (Exception e) {
			logger.error(e, e);
		}
		return mav;
	} 
	
	/**
	 * 프로젝트별 상세비용분석
	 * @param request
	 * @param response
	 * @return
	 * 2011. 6. 1.
	 */
	public ModelAndView accountDetailByProjectPop(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = null;
		
		try {
			mav = new ModelAndView();
			mav.setViewName("/ozr/accountDetailByProjectPop");
		} catch (Exception e) {
			logger.error(e, e);
		}
		return mav;
	} 
	
	/**
	 * 연도별 매출보고서_전사팀장주간업무보고
	 * @param request
	 * @param response
	 * @return
	 * 2011. 5. 30.
	 */
	public ModelAndView weeklySalesResulttPop(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = null;
		
		try {
			mav = new ModelAndView();
			mav.setViewName("/ozr/weeklySalesResulttPop");
		} catch (Exception e) {
			logger.error(e, e);
		}
		return mav;
	} 
	
	/**
	 * 연도별 매출보고서_매출보고서
	 * @param request
	 * @param response
	 * @return
	 * 2011. 5. 30.
	 */
	public ModelAndView salesReportPop(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = null;
		
		try {
			mav = new ModelAndView();
			mav.setViewName("/ozr/salesReportPop");
		} catch (Exception e) {
			logger.error(e, e);
		}
		return mav;
	} 
	
	/**
	 * 연도별 매출보고서_수주보고서
	 * @param request
	 * @param response
	 * @return
	 * 2011. 5. 30.
	 */
	public ModelAndView orderReportPop(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = null;
		
		try {
			mav = new ModelAndView();
			mav.setViewName("/ozr/orderReportPop");
		} catch (Exception e) {
			logger.error(e, e);
		}
		return mav;
	} 
	
	/**
	 * 연도별 매출보고서_년간영업실적보고서
	 * @param request
	 * @param response
	 * @return
	 * 2011. 5. 30.
	 */
	public ModelAndView netSalesAmount2009Pop(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = null;
		
		try {
			mav = new ModelAndView();
			mav.setViewName("/ozr/netSalesAmount2009Pop");
		} catch (Exception e) {
			logger.error(e, e);
		}
		return mav;
	} 
	
	/**
	 * 고객리스트(등급)
	 * @param request
	 * @param response
	 * @return
	 * 2011. 5. 30.
	 */
	public ModelAndView customerListPop(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = null;
		
		try {
			mav = new ModelAndView();
			mav.setViewName("/ozr/customerListPop");
		} catch (Exception e) {
			logger.error(e, e);
		}
		return mav;
	}  
	
	/**
	 * 유지보수정보
	 * @param request
	 * @param response
	 * @return
	 * 2011. 6. 1.
	 */
	public ModelAndView maintenanceInfoPop(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = null;
		
		try {
			mav = new ModelAndView();
			mav.setViewName("/ozr/maintenanceInfoPop");
		} catch (Exception e) {
			logger.error(e, e);
		}
		return mav;
	}
	
	/**
	 * 레포트 일반
	 * @param request
	 * @param response
	 * @return
	 * 2011. 6. 1.
	 */
	public ModelAndView ozReportGeneral(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = null;
		
		try {
			mav = new ModelAndView();
			mav.setViewName("/ozr/ozReportGeneral");
		} catch (Exception e) {
			logger.error(e, e);
		}
		return mav;
	}
	
	/**
	 * 주간업무일지
	 * @param request
	 * @param response
	 * @return
	 * 2011. 6. 1.
	 */
	public ModelAndView devdmsBlReportPop(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = null;
		
		try {
			mav = new ModelAndView();
			mav.setViewName("/ozr/devdmsBlReportPop");
		} catch (Exception e) {
			logger.error(e, e);
		}
		return mav;
	}
	
	
}
