package com.sg.sgis.com.sgisCode;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.servlet.ModelAndView;
  
import com.sg.sgis.util.CommonUtil;
import com.signgate.core.config.SGConfigManager;
import com.signgate.core.web.controller.SGUserController; 
import com.signgate.core.web.util.WebUtil;

public class SgisCodeController extends SGUserController{
	protected final Log logger = LogFactory.getLog(getClass());

	CommonUtil comUtil = new CommonUtil();

	private SgisCodeBiz sgisCodeBiz;
	public void setSgisCodeBiz(SgisCodeBiz sgisCodeBiz) {
		this.sgisCodeBiz = sgisCodeBiz;
	} 


	@SuppressWarnings("unchecked")
	public ModelAndView sgisCodeList(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = null;

		try {
			mav = new ModelAndView();
			HashMap map = WebUtil.parseRequestMap(request); 
			
			HashMap adminMap = (HashMap)request.getSession().getAttribute(SGConfigManager.getString("common.session.admin.name")); 
					mav.addObject("admin_id",(String)adminMap.get("ADMIN_ID"));
					mav.addObject("admin_nm",(String)adminMap.get("ADMIN_NM"));
					mav.addObject("sabun",(String)adminMap.get("SABUN")); 
			
			mav.setViewName("/com/code/sgisCodeList");

			mav.addObject("pMap",map);
			mav.addAllObjects(map); 


		} catch (Exception e) { 
			logger.error("::"+this.getClass()+"\n<sgis코드관리 목록 에러>::::\n"+e.getMessage()); 
		}
		return mav;
	} 


	public ModelAndView result_1st(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = null;
		List result = null;
		try{
			mav = new ModelAndView();
			mav.setViewName("/result/result_1st");	
			HashMap map = WebUtil.parseRequestMap(request); 

			HashMap mapResult = new HashMap();
			mapResult.put("success", "true");							// 성공여부 

			/***** 그리드의 페이지 클릭시 - 검색조건에 한글조회값이 있다면 해당 필드만 decode *****/
			if("srcKoreanYn".equals(request.getParameter("exit"))){
				map.put("src_group_code",comUtil.getDecodingUTF(request.getParameter("src_group_code")));
				map.put("src_com_code",comUtil.getDecodingUTF(request.getParameter("src_com_code")));
			}

			/***** paging *****/ 
			int limit = 0;
			if((String)map.get("limit") != null)
				limit = Integer.parseInt((String)map.get("limit"));

			int start = 0;
			if((String)map.get("start") != null)
				start = Integer.parseInt((String)map.get("start"));
			map.put("limit", limit + start);

			result = sgisCodeBiz.selectCode(map);						// DB에서 목록조회

			JSONArray jsonArray = new JSONArray();
			jsonArray = JSONArray.fromObject(result); 

			mapResult.put("data_1st", jsonArray);	
			mapResult.put("total_1st", sgisCodeBiz.selectCodeCount(map));		

			JSONObject jsonObject = JSONObject.fromObject(mapResult);	// JSON형식으로 설정
			mav.addObject("RESULT_1ST", jsonObject);						// 조회된 결과값을 담기
 
		}catch(Exception ex){
			logger.error(ex.getMessage());
		}

		return mav;
	}

	// 신규 등록 또는 수정 처리
	public ModelAndView actionSgisCode(HttpServletRequest request, HttpServletResponse response)throws Exception{

		ModelAndView mav = new ModelAndView();
		JSONObject jsonObject = new JSONObject();
		HashMap mapResult = new HashMap();

		try {
			mav = new ModelAndView();
			mav.setViewName("/result/result_1st");	
			HashMap paramMap = WebUtil.parseRequestMap(request);  		
			HashMap adminMap = (HashMap)request.getSession().getAttribute(SGConfigManager.getString("common.session.admin.name"));
			paramMap.put("admin_id", (String)adminMap.get("ADMIN_ID"));
			paramMap.put("groups", (String)adminMap.get("GROUPS"));
			paramMap.put("emp_num", (String)adminMap.get("SABUN")); 

			String check = sgisCodeBiz.actionSgisCode(paramMap);			// 저장 및 수정 			

			List result = sgisCodeBiz.selectCode(paramMap);					// DB에서 목록조회

			JSONArray jsonArray = JSONArray.fromObject(result);

			// 조회된 결과 및 message
			if("".equals(check)){
				mapResult.put("success", "true");							// 성공 
			}else{
				mapResult.put("success", "false");							// 실패 
			}

			mapResult.put("total_1st", sgisCodeBiz.selectCodeCount(paramMap));		
			mapResult.put("data_1st", jsonArray);								// 조회된 결과값
			jsonObject = JSONObject.fromObject(mapResult);					// JSON형식으로 설정

		}catch (Exception e){
			mapResult.put("success", "false");								// 성공여부
			mapResult.put("message", e.toString());							// message
			logger.error(e, e);
		}finally{

		}
		mav.addObject("RESULT_1ST", jsonObject);							// 조회된 결과값을 담기
		return mav;
	}

	/**
	 * 레이아웃에서 RegPanel에 신규 코드를 등록하기 윈한 화면
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	public ModelAndView sgCodeRegPanel(HttpServletRequest request, HttpServletResponse response)throws Exception{

		ModelAndView mav = new ModelAndView();

		try {
			mav = new ModelAndView();
			mav.setViewName("/com/code/sgCodeRegPanel");

		}catch (Exception e){

		}
		return mav;
	}




}
