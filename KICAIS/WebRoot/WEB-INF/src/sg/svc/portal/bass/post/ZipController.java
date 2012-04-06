package sg.svc.portal.bass.post;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.servlet.ModelAndView;

import com.signgate.core.web.controller.SGUserController;
import com.signgate.core.web.util.WebUtil;

/**
 * 우편번호 정보 조회 컨트롤
 * <pre>
 * 우편번호 정보 조회 컨트롤
 * </pre>
 * @see 
 * @author dori
 * @version 1.0 2009. 05. 07
 */
public class ZipController extends SGUserController {
    protected final Log logger = LogFactory.getLog(getClass());

    private ZipBiz zipBiz;

	public void setZipBiz(ZipBiz zipBiz) {
		this.zipBiz = zipBiz;
	}

	/**
	 * 우편번호 정보 조회 폼
	 *
	 * @param request
	 * @param response
	 * @return
	 * @see 
	 */
	public ModelAndView searchZipForm(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = null;

		try {
			mav = new ModelAndView();
			Map map = WebUtil.parseRequestMap(request);
			mav.addObject("pMap", map);
		} catch (Exception e) {
			logger.error(e, e);
		}

		return mav;
	}
	

	public ModelAndView searchZipAjax(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = null;

    	try {
    		mav = new ModelAndView();

    		mav.addObject("result", "true");
    		mav.addObject("list", zipBiz.selZip(WebUtil.parseRequestMap(request)));
    	} catch(Exception e) {
    		logger.error("searchZipAjax Exception : ", e);
    	}

		return mav;
	}
}
