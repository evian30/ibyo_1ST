package com.sg.sgis.pur;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.servlet.ModelAndView;

import com.sg.sgis.com.sgisCode.SgisCodeBiz;
import com.sg.sgis.pjt.pjtManage.PjtManageBiz;
import com.sg.sgis.util.CommonUtil;
import com.sg.sgis.util.GetPKIdUtil;
import com.signgate.core.config.SGConfigManager;
import com.signgate.core.web.controller.SGUserController;
import com.signgate.core.web.util.WebUtil;

public class PurchaseController extends SGUserController {
	protected final Log logger = LogFactory.getLog(getClass());

	PurchaseBiz purBiz;
	public void setPurBiz(PurchaseBiz purBiz) {
		this.purBiz = purBiz;
	}
	
	PayInfoBiz payBiz;
	public void setPayBiz(PayInfoBiz payBiz) {
		this.payBiz = payBiz;
	}

	// 공통코드 BIZ경로 설정
	private SgisCodeBiz sgisCodeBiz;
	public void setSgisCodeBiz(SgisCodeBiz sgisCodeBiz) {
		this.sgisCodeBiz = sgisCodeBiz;
	} 
	
	private PjtManageBiz pjtManageBiz; 
	public void setPjtManageBiz(PjtManageBiz pjtManageBiz){
		this.pjtManageBiz = pjtManageBiz;
	} 
	 

	CommonUtil comUtil = new CommonUtil();

	/**
	 * 구매정보조회
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public ModelAndView purList(HttpServletRequest request, HttpServletResponse response) throws Exception{
		ModelAndView mav = null;
		try{
			mav = new ModelAndView();

			//구매구분 공통코드 조회
			List item_type_code = sgisCodeBiz.selectComboCode("ITEM_TYPE_CODE");
			mav.addObject("ITEM_TYPE_CODE", item_type_code);

			//업무구분 공통코드 조회
			List roll_type_code = sgisCodeBiz.selectComboCode("ROLL_TYPE_CODE");
			mav.addObject("ROLL_TYPE_CODE", roll_type_code);

			//진행상태 공통코드 조회
			List flow_status_code = sgisCodeBiz.selectComboCode("PUR_STATUS_CODE");
			mav.addObject("PUR_STATUS_CODE", flow_status_code);
			
		} catch (Exception e) {

		}
		return mav;
	}
	
	/**
	 * 구매정보진행상태 관리
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public ModelAndView purProcList(HttpServletRequest request, HttpServletResponse response) throws Exception{
		ModelAndView mav = null;
		try{
			mav = new ModelAndView();

			//구매구분 공통코드 조회
			List item_type_code = sgisCodeBiz.selectComboCode("ITEM_TYPE_CODE");
			mav.addObject("ITEM_TYPE_CODE", item_type_code);

			//업무구분 공통코드 조회
			List roll_type_code = sgisCodeBiz.selectComboCode("ROLL_TYPE_CODE");
			mav.addObject("ROLL_TYPE_CODE", roll_type_code);

			//진행상태 공통코드 조회
			List flow_status_code = sgisCodeBiz.selectComboCode("PUR_STATUS_CODE");
			mav.addObject("PUR_STATUS_CODE", flow_status_code);
			
		} catch (Exception e) {

		}
		return mav;
	}
	
	/**
	 * 구매정보관리
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public ModelAndView purManager(HttpServletRequest request, HttpServletResponse response) throws Exception{
		ModelAndView mav = null;
		try{
			mav = new ModelAndView();
			HashMap paramMap = WebUtil.parseRequestMap(request);

			//구매구분 공통코드 조회
			List item_type_code = sgisCodeBiz.selectComboCode("ITEM_TYPE_CODE");
			mav.addObject("ITEM_TYPE_CODE", item_type_code);

			//업무구분 공통코드 조회
			List roll_type_code = sgisCodeBiz.selectComboCode("ROLL_TYPE_CODE");
			mav.addObject("ROLL_TYPE_CODE", roll_type_code);

			//진행상태 공통코드 조회
			List flow_status_code = sgisCodeBiz.selectComboCode("PUR_STATUS_CODE");
			mav.addObject("PUR_STATUS_CODE", flow_status_code);
			
			
			//프로젝트 관리(전체)를 위한 페이지 구분
			if(paramMap.get("totMng").equals("all")){
				mav.setViewName("/pjt/allPURManageList");
			}else{
				mav.setViewName("/pur/purManager");
			}
			
			
		} catch (Exception e) {
			logger.error(e.getMessage());
		}
		return mav;
	}

	@SuppressWarnings("unchecked")
	public ModelAndView result_1st(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = null;

		try{
			mav = new ModelAndView();
			mav.setViewName("/result/result_1st");	
			HashMap paramMap = WebUtil.parseRequestMap(request); 

			/***** paging *****/ 
			int limit = 0;
			if((String)paramMap.get("limit") != null)
				limit = Integer.parseInt((String)paramMap.get("limit"));
			int start = 0;
			if((String)paramMap.get("start") != null)
				start = Integer.parseInt((String)paramMap.get("start"));

			paramMap.put("limit", limit+start);  
			//AND    PUR_DATE BETWEEN NVL(#src_pur_date_from#, '20000101') AND NVL(#src_pur_date_to#, '20000101')
			
			HashMap adminMap = (HashMap)request.getSession().getAttribute(SGConfigManager.getString("common.session.admin.name"));
			String emp_num   =(String)adminMap.get("ADMIN_ID");
			String dept_code = pjtManageBiz.getDeptCode((String)adminMap.get("SABUN"));
			String groups	 = (String)adminMap.get("GROUPS");
			
			
			//자신의 부서에서 등록한 목록만 가져오기 - by ibyo//
			if(	groups.indexOf("G001", 0) == -1 				//시스템관리자
				&& groups.indexOf("G002", 0) == -1				//임원
				&& groups.indexOf("G005", 0) == -1				//대표이사 
			  ){
					paramMap.put("session_dept_code", dept_code);
			  }
			
			

			if((String)paramMap.get("src_pur_date_from") == null || ((String)paramMap.get("src_pur_date_from")).equals("")){
				paramMap.put("src_pur_date_from","20100101");
			}
			if((String)paramMap.get("src_pur_date_to") == null || ((String)paramMap.get("src_pur_date_to")).equals("")){
				paramMap.put("src_pur_date_to","20191230");
			}

			/***** DB에서 목록조회 *****/
			List result = purBiz.selectPurchase(paramMap);
			if(result != null && result.size() > 0){

			/***** 조회된 결과를 JSON형식으로 screen에 Return *****/
			JSONArray jsonArray = JSONArray.fromObject(result);
			HashMap<String,Object> mapResult = new HashMap<String, Object>();
			mapResult.put("success", "true");								// 성공여부
			mapResult.put("message", "Loaded data");						// message

			mapResult.put("data_1st", jsonArray);							// 조회된 결과값
			mapResult.put("total_1st", purBiz.selectPurchaseCount(paramMap)); 	// 목록의 총갯수 조회
			JSONObject jsonObject = JSONObject.fromObject(mapResult);		// JSON형식으로 설정
			mav.addObject("RESULT_1ST", jsonObject);						// 조회된 결과값을 담기
			}else if(result == null || result.size() <= 0){
				/***** 조회된 결과를 JSON형식으로 screen에 Return *****/
				JSONArray jsonArray = JSONArray.fromObject(result);
				HashMap<String,Object> mapResult = new HashMap<String, Object>();
				mapResult.put("success", "true");								// 성공여부
				mapResult.put("message", "Loaded data");						// message

				mapResult.put("data_1st", "");							// 조회된 결과값
				mapResult.put("total_1st", "0"); 	// 목록의 총갯수 조회
				JSONObject jsonObject = JSONObject.fromObject(mapResult);		// JSON형식으로 설정
				mav.addObject("RESULT_1ST", jsonObject);						// 조회된 결과값을 담기
			}
			

		}catch(Exception ex){
			logger.error(ex.getMessage());
		}

		return mav;
	}
	
	@SuppressWarnings("unchecked")
	public ModelAndView result_1st_pop(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = null;

		try{
			mav = new ModelAndView();
			mav.setViewName("/result/result_1st");	
			HashMap paramMap = WebUtil.parseRequestMap(request); 

			/***** paging *****/ 
			int limit = 0;
			if((String)paramMap.get("limit") != null)
				limit = Integer.parseInt((String)paramMap.get("limit"));
			int start = 0;
			if((String)paramMap.get("start") != null)
				start = Integer.parseInt((String)paramMap.get("start"));

			paramMap.put("limit", limit+start);  

			if((String)paramMap.get("src_pur_date_from") == null || ((String)paramMap.get("src_pur_date_from")).equals("")){
				paramMap.put("src_pur_date_from","20100101");
			}
			if((String)paramMap.get("src_pur_date_to") == null || ((String)paramMap.get("src_pur_date_to")).equals("")){
				paramMap.put("src_pur_date_to","20191230");
			}

			/***** DB에서 목록조회 *****/
			List result = purBiz.selectPurchase(paramMap);
			
			if(result != null && result.size() > 0){

				/***** 조회된 결과를 JSON형식으로 screen에 Return *****/
				JSONArray jsonArray = JSONArray.fromObject(result);
				HashMap<String,Object> mapResult = new HashMap<String, Object>();
				mapResult.put("success", "true");								// 성공여부
				mapResult.put("message", "Loaded data");						// message
	
				mapResult.put("data_1st_pop", jsonArray);							// 조회된 결과값
				mapResult.put("total_1st_pop", purBiz.selectPurchaseCount(paramMap)); 	// 목록의 총갯수 조회
				JSONObject jsonObject = JSONObject.fromObject(mapResult);		// JSON형식으로 설정
				mav.addObject("RESULT_1ST", jsonObject);						// 조회된 결과값을 담기
			}else if(result == null || result.size() <= 0 ){
				/***** 조회된 결과를 JSON형식으로 screen에 Return *****/
				JSONArray jsonArray = JSONArray.fromObject(result);
				HashMap<String,Object> mapResult = new HashMap<String, Object>();
				mapResult.put("success", "true");								// 성공여부
				mapResult.put("message", "Loaded data");						// message
	
				mapResult.put("data_1st_pop", "");							// 조회된 결과값
				mapResult.put("total_1st_pop", "0"); 	// 목록의 총갯수 조회
				JSONObject jsonObject = JSONObject.fromObject(mapResult);		// JSON형식으로 설정
				mav.addObject("RESULT_1ST", jsonObject);						// 조회된 결과값을 담기
			}

		}catch(Exception ex){
			logger.error(ex.getMessage());
		}

		return mav;
	}

	@SuppressWarnings("unchecked")
	public ModelAndView pur_edit_grid_result_1st(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = null;

		try{
			mav = new ModelAndView();
			mav.setViewName("/result/result_edit_1st");

			HashMap paramMap = WebUtil.parseRequestMap(request); 

			/***** paging *****/ 
			int limit = 0;
			if((String)paramMap.get("limit") != null)
				limit = Integer.parseInt((String)paramMap.get("limit"));
			int start = 0;
			if((String)paramMap.get("start") != null)
				start = Integer.parseInt((String)paramMap.get("start"));

			paramMap.put("limit", limit+start);  
			//AND    PUR_DATE BETWEEN NVL(#src_pur_date_from#, '20000101') AND NVL(#src_pur_date_to#, '20000101')

			/***** DB에서 목록조회 *****/
			//구매 품목 정보를 가져오는 것을 만들자.
			List result = purBiz.selectPurItem(paramMap);			

			if(result.size() > 0){
				/***** 조회된 결과를 JSON형식으로 screen에 Return *****/
				JSONArray jsonArray = JSONArray.fromObject(result);
				HashMap<String,Object> mapResult = new HashMap<String, Object>();
				mapResult.put("success", "true");								// 성공여부
				mapResult.put("message", "Loaded data");						// message

				mapResult.put("data_edit_1st", jsonArray);							// 조회된 결과값
				mapResult.put("total_edit_1st", purBiz.selectPurItemCount(paramMap)); 	// 목록의 총갯수 조회
				JSONObject jsonObject = JSONObject.fromObject(mapResult);		// JSON형식으로 설정
				mav.addObject("RESULT_EDIT_1ST", jsonObject);						// 조회된 결과값을 담기
			}else if(result == null || result.size() <= 0){
				/***** 조회된 결과를 JSON형식으로 screen에 Return *****/
				HashMap<String,Object> mapResult = new HashMap<String, Object>();
				mapResult.put("success", "true");								// 성공여부
				mapResult.put("message", "Loaded data");						// message

				mapResult.put("data_edit_1st", "");							// 조회된 결과값
				mapResult.put("total_edit_1st", 0); 	// 목록의 총갯수 조회
				JSONObject jsonObject = JSONObject.fromObject(mapResult);		// JSON형식으로 설정
				mav.addObject("RESULT_EDIT_1ST", jsonObject);						// 조회된 결과값을 담기
			}
		}catch(Exception ex){
			logger.error(ex.getMessage());
			ex.printStackTrace();
		}

		return mav;
	}

	@SuppressWarnings("unchecked")
	public ModelAndView pur_edit_grid_result_2nd(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = null;

		try{
			mav = new ModelAndView();
			mav.setViewName("/result/result_edit_2nd");

			HashMap paramMap = WebUtil.parseRequestMap(request); 

			/***** paging *****/ 
			int limit = 0;
			if((String)paramMap.get("limit") != null)
				limit = Integer.parseInt((String)paramMap.get("limit"));
			int start = 0;
			if((String)paramMap.get("start") != null)
				start = Integer.parseInt((String)paramMap.get("start"));

			paramMap.put("limit", limit+start);  

			/***** DB에서 목록조회 *****/
			//구매 품목 정보를 가져오는 것을 만들자
			List result = purBiz.selectPurItemSpec(paramMap);			

			if(result.size() > 0){
				/***** 조회된 결과를 JSON형식으로 screen에 Return *****/
				JSONArray jsonArray = JSONArray.fromObject(result);
				HashMap<String,Object> mapResult = new HashMap<String, Object>();
				mapResult.put("success", "true");								// 성공여부
				mapResult.put("message", "Loaded data");						// message

				mapResult.put("data_edit_2nd", jsonArray);							// 조회된 결과값
				mapResult.put("total_edit_2nd", purBiz.selectPurItemSpecCount(paramMap)); 	// 목록의 총갯수 조회
				JSONObject jsonObject = JSONObject.fromObject(mapResult);		// JSON형식으로 설정
				mav.addObject("RESULT_EDIT_2ND", jsonObject);						// 조회된 결과값을 담기
			}else if(result == null || result.size() <= 0){
				/***** 조회된 결과를 JSON형식으로 screen에 Return *****/
				JSONArray jsonArray = JSONArray.fromObject(result);
				HashMap<String,Object> mapResult = new HashMap<String, Object>();
				mapResult.put("success", "true");								// 성공여부
				mapResult.put("message", "Loaded data");						// message

				mapResult.put("data_edit_2nd", "");							// 조회된 결과값
				mapResult.put("total_edit_2nd", "0"); 	// 목록의 총갯수 조회
				JSONObject jsonObject = JSONObject.fromObject(mapResult);		// JSON형식으로 설정
				mav.addObject("RESULT_EDIT_2ND", jsonObject);						// 조회된 결과값을 담기
			}
		}catch(Exception ex){
			logger.error(ex.getMessage());
			ex.printStackTrace();
		}

		return mav;
	}

	/**
	 * 신규 버튼을 클릭했을 경우 AJAX를 통해 구매ID를 생성하여 리턴함 
	 * @param request 
	 * @param response NEW_PUR_ID
	 * @return
	 * @throws Exception
	 */
	public ModelAndView newPurchaseReg(HttpServletRequest request, HttpServletResponse response) throws Exception{
		ModelAndView mav = null;
		try{
			mav = new ModelAndView();
			mav.addObject("NEW_PUR_ID", GetPKIdUtil.getPkId("PUR", "PUR"));
		} catch (Exception e) {
			logger.error(e.getMessage());
		}
		return mav;
	}

	/**
	 * 신규 구매 정보 등록 처리
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public ModelAndView purRegProc(HttpServletRequest request, HttpServletResponse response) throws Exception{
		ModelAndView mav = null;
		try{
			mav = new ModelAndView();
			mav.setViewName("/result/result_1st");	
			//로그인한 사용자ID가져오기
			HashMap paramMap = WebUtil.parseRequestMap(request);

			//최초등록자
			HashMap adminMap = (HashMap)request.getSession().getAttribute(SGConfigManager.getString("common.session.admin.name"));
			//mav.addObject("admin_id",(String)adminMap.get("ADMIN_ID"));
			//mav.addObject("admin_nm",(String)adminMap.get("ADMIN_NM"));
			paramMap.put("reg_id", (String)adminMap.get("ADMIN_ID"));
			
			
			
			
			boolean purInsertResult = false;
			//신규, update를 구분
			if( ((String)paramMap.get("req_type")).equals("UPDATE")){ //업데이트면
				purInsertResult = purBiz.updatePurchaseInfo(paramMap);
			}else{ //신규면
				purInsertResult = purBiz.insertPurchaseInfo(paramMap);
			}
			
			
			

			//구매정보 가져오기
			/***** paging *****/ 
			int limit = 0;
			if((String)paramMap.get("limit") != null)
				limit = Integer.parseInt((String)paramMap.get("limit"));
			int start = 0;
			if((String)paramMap.get("start") != null)
				start = Integer.parseInt((String)paramMap.get("start"));
			if((String)paramMap.get("src_pur_date_from") == null || ((String)paramMap.get("src_pur_date_from")).equals("") ){
				paramMap.put("src_pur_date_from","20100101");
			}
			if((String)paramMap.get("src_pay_date_to") == null||((String)paramMap.get("src_pay_date_to")).equals("")){
				paramMap.put("src_pur_date_to","20191230");
			}
			paramMap.put("limit", limit+start); 
			List result = purBiz.selectPurchase(paramMap);
			
			if(purInsertResult){
				/***** 조회된 결과를 JSON형식으로 screen에 Return *****/
				JSONArray jsonArray = JSONArray.fromObject(result);
				HashMap<String,Object> mapResult = new HashMap<String, Object>();
				mapResult.put("success", "true");								// 성공여부
				mapResult.put("message", "Loaded data");						// message

				mapResult.put("data_1st", jsonArray);							// 조회된 결과값
				mapResult.put("total_1st", payBiz.selectPayInfoCount(paramMap)); 	// 목록의 총갯수 조회
				JSONObject jsonObject = JSONObject.fromObject(mapResult);		// JSON형식으로 설정
				mav.addObject("RESULT_1ST", jsonObject);						// 조회된 결과값을 담기
			}else{
				//저장실패
				/***** 조회된 결과를 JSON형식으로 screen에 Return *****/
				JSONArray jsonArray = JSONArray.fromObject(result);
				HashMap<String,Object> mapResult = new HashMap<String, Object>();
				mapResult.put("success", "true");								// 성공여부
				mapResult.put("message", "Loaded data");						// message

				mapResult.put("data_1st", "");							// 조회된 결과값
				mapResult.put("total_1st", "0"); 	// 목록의 총갯수 조회
				JSONObject jsonObject = JSONObject.fromObject(mapResult);		// JSON형식으로 설정
				mav.addObject("RESULT_1ST", jsonObject);						// 조회된 결과값을 담기
			}

		} catch (Exception e) {

		}
		return mav;
	}

	@SuppressWarnings("unchecked")
	public ModelAndView purSearchPop(HttpServletRequest request, HttpServletResponse response) throws Exception{
		ModelAndView mav = null;
		try{
			mav = new ModelAndView();
			
		} catch (Exception e) {
			logger.error(e.getMessage());
		}
		return mav;
	}
	/**
	 * 지출결의 메인화면 
	 * @param request 
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public ModelAndView payInfoManager(HttpServletRequest request, HttpServletResponse response) throws Exception{
		ModelAndView mav = null;
		try{
			mav = new ModelAndView();
			//예산구분 공통코드 조회
			List item_type_code = sgisCodeBiz.selectComboCode("BUDGET_TYPE_CODE");
			mav.addObject("BUDGET_TYPE_CODE", item_type_code);
			
			//증빙유형코드
			List evid_type_code = sgisCodeBiz.selectComboCode("BILL_TYPE_CODE");
			mav.addObject("BILL_TYPE_CODE", evid_type_code);
			
			//기본적요구구분코드
			List cost_type_code = sgisCodeBiz.selectComboCode("COST_TYPE_CODE");
			mav.addObject("COST_TYPE_CODE", cost_type_code);
			
		} catch (Exception e) {

		}
		return mav;
	}
	
	/**
	 * 지출결의 첫번째 그리드 처리 
	 * @param request 
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public ModelAndView payInfo_result_grid_1st(HttpServletRequest request, HttpServletResponse response) throws Exception{
		ModelAndView mav = null;
		try{
			mav = new ModelAndView();
			mav.setViewName("/result/result_1st");	
			HashMap paramMap = WebUtil.parseRequestMap(request); 

			/***** paging *****/ 
			int limit = 0;
			if((String)paramMap.get("limit") != null)
				limit = Integer.parseInt((String)paramMap.get("limit"));
			int start = 0;
			if((String)paramMap.get("start") != null)
				start = Integer.parseInt((String)paramMap.get("start"));

			paramMap.put("limit", limit+start);  

			if((String)paramMap.get("src_pay_date_from") == null || ((String)paramMap.get("src_pay_date_from")).equals("") ){
				paramMap.put("src_pay_date_from","20100101");
			}
			if((String)paramMap.get("src_pay_date_to") == null||((String)paramMap.get("src_pay_date_to")).equals("")){
				paramMap.put("src_pay_date_to","20191230");
			}

			/***** DB에서 목록조회 *****/
			List result = payBiz.selectPayInfo(paramMap);			
			if(result.size() > 0){
				/***** 조회된 결과를 JSON형식으로 screen에 Return *****/
				JSONArray jsonArray = JSONArray.fromObject(result);
				HashMap<String,Object> mapResult = new HashMap<String, Object>();
				mapResult.put("success", "true");								// 성공여부
				mapResult.put("message", "Loaded data");						// message

				mapResult.put("data_1st", jsonArray);							// 조회된 결과값
				mapResult.put("total_1st", payBiz.selectPayInfoCount(paramMap)); 	// 목록의 총갯수 조회
				JSONObject jsonObject = JSONObject.fromObject(mapResult);		// JSON형식으로 설정
				mav.addObject("RESULT_1ST", jsonObject);						// 조회된 결과값을 담기
			}else if(result == null || result.size() <=0 ){
				/***** 조회된 결과를 JSON형식으로 screen에 Return *****/
				JSONArray jsonArray = JSONArray.fromObject(result);
				HashMap<String,Object> mapResult = new HashMap<String, Object>();
				mapResult.put("success", "false");								// 성공여부
				mapResult.put("message", "Loaded data");						// message

				mapResult.put("data_1st", "");							// 조회된 결과값
				mapResult.put("total_1st", payBiz.selectPayInfoCount(paramMap)); 	// 목록의 총갯수 조회
				JSONObject jsonObject = JSONObject.fromObject(mapResult);		// JSON형식으로 설정
				mav.addObject("RESULT_1ST", jsonObject);						// 조회된 결과값을 담기
			}
				
			
		} catch (Exception e) {

		}
		return mav;
	}
	
	/**
	 * 지출결의 첫번째 에디트 그리드 처리 
	 * @param request 
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public ModelAndView payInfo_result_edit_grid_1st(HttpServletRequest request, HttpServletResponse response) throws Exception{
		ModelAndView mav = null;

		try{
			mav = new ModelAndView();
			mav.setViewName("/result/result_edit_1st");

			HashMap paramMap = WebUtil.parseRequestMap(request); 

			/***** paging *****/ 
			int limit = 0;
			if((String)paramMap.get("limit") != null)
				limit = Integer.parseInt((String)paramMap.get("limit"));
			int start = 0;
			if((String)paramMap.get("start") != null)
				start = Integer.parseInt((String)paramMap.get("start"));

			paramMap.put("limit", limit+start);  

			/***** DB에서 목록조회 *****/
			List result = payBiz.selectPayEvidInfo(paramMap);			

			if(result != null && result.size() > 0){
				/***** 조회된 결과를 JSON형식으로 screen에 Return *****/
				JSONArray jsonArray = JSONArray.fromObject(result);
				HashMap<String,Object> mapResult = new HashMap<String, Object>();
				mapResult.put("success", "true");											// 성공여부
				mapResult.put("message", "Loaded data");									// message

				mapResult.put("data_edit_1st", jsonArray);	
				// 조회된 결과값
				mapResult.put("total_edit_1st", payBiz.selectPayEvidInfoCount(paramMap)); 	// 목록의 총갯수 조회
				JSONObject jsonObject = JSONObject.fromObject(mapResult);					// JSON형식으로 설정
				mav.addObject("RESULT_EDIT_1ST", jsonObject);								// 조회된 결과값을 담기
			}else if(result == null || result.size() <= 0  ){
				/***** 조회된 결과를 JSON형식으로 screen에 Return *****/
				HashMap<String,Object> mapResult = new HashMap<String, Object>();
				mapResult.put("success", "false");											// 성공여부
				mapResult.put("message", "Loaded data");									// message

				mapResult.put("data_edit_1st", "");											// 조회된 결과값
				mapResult.put("total_edit_1st", 0); 										// 목록의 총갯수 조회
				JSONObject jsonObject = JSONObject.fromObject(mapResult);					// JSON형식으로 설정
				mav.addObject("RESULT_EDIT_1ST", jsonObject);								// 조회된 결과값을 담기
			}
		}catch(Exception ex){
			logger.error(ex.getMessage());
			ex.printStackTrace();
		}

		return mav;
	}
	
	/**
	 * 지출번호를 생성하여 리턴 
	 * @param request 
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public ModelAndView makePayNo(HttpServletRequest request, HttpServletResponse response) throws Exception{
		ModelAndView mav = null;
		try{
			mav = new ModelAndView();
			mav.addObject("NEW_PAY_NO", GetPKIdUtil.getPkId("PAY", "PAY"));
		} catch (Exception e) {
			logger.error(e.getMessage());
		}
		return mav;
	}
	
	/**
	 * 클라이언트에서 넘오언 데이터를 Inser || Update
	 * @param request 
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public ModelAndView payInfoRegProc(HttpServletRequest request, HttpServletResponse response) throws Exception{
		ModelAndView mav = null;
		try{
			mav = new ModelAndView();
			mav.setViewName("/result/result_1st");	
			
			//로그인한 사용자ID가져오기
			HashMap adminMap = (HashMap)request.getSession().getAttribute(SGConfigManager.getString("common.session.admin.name"));

			HashMap paramMap = WebUtil.parseRequestMap(request);
			HashMap<String,Object> mapResult = new HashMap<String, Object>();

			//최초등록자
			paramMap.put("reg_id", "jclee");
			boolean purInsertResult = false;
			
			//신규, update를 구분
			if( ((String)paramMap.get("req_type")).equals("UPDATE")){ //업데이트면
				purInsertResult = payBiz.updatePayInfo(paramMap);
			}else{ //신규면
				purInsertResult = payBiz.insertPayInfo(paramMap);
			}

			//구매정보 DB저장
			if(purInsertResult){
				mapResult.put("success", "true");								// 성공여부
				mapResult.put("message", "Loaded data");						// message
			}else{
				mapResult.put("success", "false");								// 성공여부
				mapResult.put("message", "False Loaded data");					// message
			}
			
			JSONObject jsonObject = JSONObject.fromObject(mapResult);			// JSON형식으로 설정
			mav.addObject("RESULT_1ST", jsonObject);							// 조회된 결과값을 담기
			
		} catch (Exception e) {
			logger.error(e.getMessage());
		}
		return mav;
	}
	
	/**
	 * 검수정보관리 페이지
	 * @param request 
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public ModelAndView inspectManager(HttpServletRequest request, HttpServletResponse response) throws Exception{
		ModelAndView mav = null;
		try{
			mav = new ModelAndView();
			
			//구매구분 공통코드 조회
			List item_type_code = sgisCodeBiz.selectComboCode("ITEM_TYPE_CODE");
			mav.addObject("ITEM_TYPE_CODE", item_type_code);

			//업무구분 공통코드 조회
			List roll_type_code = sgisCodeBiz.selectComboCode("ROLL_TYPE_CODE");
			mav.addObject("ROLL_TYPE_CODE", roll_type_code);

			//진행상태 공통코드 조회
			List flow_status_code = sgisCodeBiz.selectComboCode("PUR_STATUS_CODE");
			mav.addObject("PUR_STATUS_CODE", flow_status_code);
			
		} catch (Exception e) {
			logger.error(e.getMessage());
		}
		return mav;
	}
	
	
	/**
	 * 검수관리 화면
	 * @param request
	 * @param response
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public ModelAndView inspect_edit_grid_result_3rd(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = null;

		try{
			mav = new ModelAndView();
			mav.setViewName("/result/result_edit_3rd");	
			HashMap paramMap = WebUtil.parseRequestMap(request); 

			/***** paging *****/ 
			int limit = 0;
			if((String)paramMap.get("limit") != null)
				limit = Integer.parseInt((String)paramMap.get("limit"));
			int start = 0;
			if((String)paramMap.get("start") != null)
				start = Integer.parseInt((String)paramMap.get("start"));

			paramMap.put("limit", limit+start);  
			//AND    PUR_DATE BETWEEN NVL(#src_pur_date_from#, '20000101') AND NVL(#src_pur_date_to#, '20000101')

			if((String)paramMap.get("src_pur_date_from") == null || ((String)paramMap.get("src_pur_date_from")).equals("")){
				paramMap.put("src_pur_date_from","20100101");
			}
			if((String)paramMap.get("src_pur_date_to") == null || ((String)paramMap.get("src_pur_date_to")).equals("")){
				paramMap.put("src_pur_date_to","20191230");
			}

			/***** DB에서 목록조회 *****/
			List result = purBiz.selectPurchase(paramMap);
			if(result != null && result.size() > 0){

			/***** 조회된 결과를 JSON형식으로 screen에 Return *****/
			JSONArray jsonArray = JSONArray.fromObject(result);
			HashMap<String,Object> mapResult = new HashMap<String, Object>();
			mapResult.put("success", "true");								// 성공여부
			mapResult.put("message", "Loaded data");						// message

			mapResult.put("data_edit_3rd", jsonArray);							// 조회된 결과값
			mapResult.put("total_edit_3rd", purBiz.selectPurchaseCount(paramMap)); 	// 목록의 총갯수 조회
			JSONObject jsonObject = JSONObject.fromObject(mapResult);		// JSON형식으로 설정
			mav.addObject("RESULT_EDIT_3RD", jsonObject);						// 조회된 결과값을 담기
			}else if(result == null || result.size() <= 0){
				/***** 조회된 결과를 JSON형식으로 screen에 Return *****/
				JSONArray jsonArray = JSONArray.fromObject(result);
				HashMap<String,Object> mapResult = new HashMap<String, Object>();
				mapResult.put("success", "true");								// 성공여부
				mapResult.put("message", "Loaded data");						// message

				mapResult.put("data_edit_3rd", "");							// 조회된 결과값
				mapResult.put("total_edit_3rd", "0"); 	// 목록의 총갯수 조회
				JSONObject jsonObject = JSONObject.fromObject(mapResult);		// JSON형식으로 설정
				mav.addObject("RESULT_EDIT_3RD", jsonObject);						// 조회된 결과값을 담기
			}
			

		}catch(Exception ex){
			logger.error(ex.getMessage());
		}

		return mav;
	}
	/**
	 * 검수정보 수정 처리
	 * @param request 
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public ModelAndView inspectUpdateInfoProc(HttpServletRequest request, HttpServletResponse response) throws Exception{
		ModelAndView mav = null;
		try{
			mav = new ModelAndView();
			mav.setViewName("/result/result_edit_3rd");
			
			//로그인한 사용자ID가져오기
			HashMap adminMap = (HashMap)request.getSession().getAttribute(SGConfigManager.getString("common.session.admin.name"));

			HashMap paramMap = WebUtil.parseRequestMap(request);

			//최종 수정자
			paramMap.put("final_mod_id", "jclee");
			
			int updateInspectInfoResult = purBiz.updateInspectInfo(paramMap);
			
			//구매정보 가져오기
			/***** paging *****/ 
			int limit = 0;
			if((String)paramMap.get("limit") != null)
				limit = Integer.parseInt((String)paramMap.get("limit"));
			int start = 0;
			if((String)paramMap.get("start") != null)
				start = Integer.parseInt((String)paramMap.get("start"));
			if((String)paramMap.get("src_pur_date_from") == null || ((String)paramMap.get("src_pur_date_from")).equals("") ){
				paramMap.put("src_pur_date_from","20100101");
			}
			if((String)paramMap.get("src_pay_date_to") == null||((String)paramMap.get("src_pay_date_to")).equals("")){
				paramMap.put("src_pur_date_to","20191230");
			}
			paramMap.put("limit", limit+start); 
			List result = purBiz.selectPurchase(paramMap);
			
			if(updateInspectInfoResult > 0){
				/***** 조회된 결과를 JSON형식으로 screen에 Return *****/
				JSONArray jsonArray = JSONArray.fromObject(result);
				HashMap<String,Object> mapResult = new HashMap<String, Object>();
				mapResult.put("success", "true");								// 성공여부
				mapResult.put("message", "Loaded data");						// message

				mapResult.put("data_edit_3rd", jsonArray);							// 조회된 결과값
				mapResult.put("total_edit_3rd", purBiz.selectPurchaseCount(paramMap)); 	// 목록의 총갯수 조회
				JSONObject jsonObject = JSONObject.fromObject(mapResult);		// JSON형식으로 설정
				mav.addObject("RESULT_EDIT_3RD", jsonObject);						// 조회된 결과값을 담기
			}else if(updateInspectInfoResult <= 0){
				//저장실패
				/***** 조회된 결과를 JSON형식으로 screen에 Return *****/
				JSONArray jsonArray = JSONArray.fromObject(result);
				HashMap<String,Object> mapResult = new HashMap<String, Object>();
				mapResult.put("success", "true");								// 성공여부
				mapResult.put("message", "Loaded data");						// message

				mapResult.put("data_edit_3rd", "");							// 조회된 결과값
				mapResult.put("total_edit_3rd", "0"); 	// 목록의 총갯수 조회
				JSONObject jsonObject = JSONObject.fromObject(mapResult);		// JSON형식으로 설정
				mav.addObject("RESULT_EDIT_3RD", jsonObject);						// 조회된 결과값을 담기
			}
			
		} catch (Exception e) {
			logger.error(e.getMessage());
		}
		return mav;
	}
	
	
}
