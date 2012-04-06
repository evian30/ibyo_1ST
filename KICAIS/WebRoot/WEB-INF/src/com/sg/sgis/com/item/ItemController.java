/**
 *  Class Name  : ItemController.java
 *  Description : 품목정보관리 Controller
 *  Modification Information
 *
 *  수정일                   수정자               수정내용
 *  -------      --------   ---------------------------
 *  2011. 2. 8.    고기범              최초 생성
 *
 *  @author 고기범
 *  @since 2011. 2. 8.
 *  @version 1.0
 *  @see 
 * 
 *  Copyright (C) 2011 by SG All right reserved.
 */
package com.sg.sgis.com.item;

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
import com.signgate.core.config.SGConfigManager;
import com.signgate.core.web.controller.SGUserController;
import com.signgate.core.web.util.WebUtil;

public class ItemController extends SGUserController{

	protected final Log logger = LogFactory.getLog(getClass());

	// BIZ경로 설정
	// 품목정보
	private ItemBiz ItemBiz; 
	public void setItemBiz(ItemBiz itemBiz){
		this.ItemBiz = itemBiz;
	}

	// 소프트웨어 정보
	private ItemSWBiz ItemSWBiz; 
	public void setItemSWBiz(ItemSWBiz itemSWBiz){
		this.ItemSWBiz = itemSWBiz;
	}

	// 하드웨어 정보
	private ItemHWBiz ItemHWBiz; 
	public void setItemHWBiz(ItemHWBiz itemHWBiz){
		this.ItemHWBiz = itemHWBiz;
	}

	// 제품개발담당자 정보
	private ItemDeveloperBiz ItemDeveloperBiz; 
	public void setItemDeveloperBiz(ItemDeveloperBiz itemDeveloperBiz){
		this.ItemDeveloperBiz = itemDeveloperBiz;
	}

	// 공통코드 BIZ경로 설정
	private SgisCodeBiz sgisCodeBiz;
	public void setSgisCodeBiz(SgisCodeBiz sgisCodeBiz) {
		this.sgisCodeBiz = sgisCodeBiz;
	}

	/**
	 * 품목정보관리(초기화면)
	 * @param  	request 
	 * @param  	response
	 * @return 	mav	   
	 * 2011. 2. 8.
	 */
	public ModelAndView itemList(HttpServletRequest request, HttpServletResponse response) {

		ModelAndView mav = new ModelAndView();

		try {

			mav.setViewName("/com/item/itemList");
			// 공통코드 조회
			List item_pattern_code  = sgisCodeBiz.selectComboCode("ITEM_PATTERN_CODE"); // 품목유형코드
			List item_type_code  = sgisCodeBiz.selectComboCode("ITEM_TYPE_CODE");		// 품목구분코드

			mav.addObject("RESULT", "");
			mav.addObject("ITEM_PATTERN_CODE", item_pattern_code);	// 품목유형코드
			mav.addObject("ITEM_TYPE_CODE", item_type_code);		// 품목구분코드

		} catch (Exception e) {
			logger.error(e, e);
		}
		return mav;
	}


	/**
	 * 품목정보관리(초기화면)
	 * @param  	request 
	 * @param  	response
	 * @return 	mav	   
	 * 2011. 2. 8.
	 */
	public ModelAndView itemManager(HttpServletRequest request, HttpServletResponse response) {

		ModelAndView mav = new ModelAndView();

		try {

			mav.setViewName("/com/item/itemManager");
			// 공통코드 조회
			List item_pattern_code  = sgisCodeBiz.selectComboCode("ITEM_PATTERN_CODE"); // 품목유형코드
			List item_type_code  = sgisCodeBiz.selectComboCode("ITEM_TYPE_CODE");		// 품목구분코드
			List yesno_code = sgisCodeBiz.selectComboCode("YESNO_CODE");				// 사용여부	
			
			mav.addObject("RESULT", "");
			mav.addObject("ITEM_PATTERN_CODE", item_pattern_code);	// 품목유형코드
			mav.addObject("ITEM_TYPE_CODE", item_type_code);		// 품목구분코드
			mav.addObject("YESNO_CODE", yesno_code);				// 사용여부

		} catch (Exception e) {
			logger.error(e, e);
		}
		return mav;
	}
	/**
	 * 품목정보관리 : 조회된 목록을 화면으로 retuen
	 * @param  request 
	 * @param  response
	 * @return mav	   (COM_ITEM 품목관리)
	 * 2011. 2. 8.
	 */
	public ModelAndView result_1st(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView();

		try{

			mav.setViewName("/result/result_1st");	
			HashMap map = WebUtil.parseRequestMap(request);  

			HashMap mapResult = new HashMap();

			/*grid 페이징 처리시 사용 할 페이지 시작 종료 value*/
			int limit = 0;
			if((String)map.get("limit") != null)
				limit = Integer.parseInt((String)map.get("limit"));
			int start = 0;
			if((String)map.get("start") != null)
				start = Integer.parseInt((String)map.get("start"));

			map.put("limit", limit+start); 

			List result = ItemBiz.selectItem(map);						 

			JSONArray jsonArray = new JSONArray();
			jsonArray = JSONArray.fromObject(result); 			

			mapResult.put("success", "true");							// 성공여부
			mapResult.put("message", "Loaded data");					// message
			mapResult.put("data_1st", jsonArray);	
			mapResult.put("total_1st", ItemBiz.selectItemCount(map));

			JSONObject jsonObject = JSONObject.fromObject(mapResult);	
			mav.addObject("RESULT_1ST", jsonObject); 			

		}catch(Exception ex){
			logger.error(ex.getMessage());
		}

		return mav;
	}

	/**
	 * 품목정보관리(하드웨어 정보) 목록조회
	 * @param  request 
	 * @param  response
	 * @return 
	 * 2011. 2. 8.
	 */
	public ModelAndView result_2nd(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView();

		try{
			mav.setViewName("/result/result_edit_1st");	
			HashMap map = WebUtil.parseRequestMap(request);   

			HashMap mapResult = new HashMap();

			/*grid 페이징 처리시 사용 할 페이지 시작 종료 value*/
			int limit = 0;
			if((String)map.get("limit") != null)
				limit = Integer.parseInt((String)map.get("limit"));

			int start = 0;
			if((String)map.get("start") != null)
				start = Integer.parseInt((String)map.get("start"));

			map.put("limit", limit+start);			

			List result_edit_1st = ItemHWBiz.selectItemHW(map);		

			JSONArray jsonArray = new JSONArray();
			jsonArray = JSONArray.fromObject(result_edit_1st);		

			mapResult.put("success", "true");							// 성공여부
			mapResult.put("message", "Loaded data");					// message
			mapResult.put("data_2nd", jsonArray);
			mapResult.put("total_2nd", ItemHWBiz.selectItemHWCount(map));

			JSONObject jsonObject = JSONObject.fromObject(mapResult);	 
			mav.addObject("RESULT_EDIT_1ST", jsonObject);	

		}catch(Exception ex){
			logger.error(ex.getMessage());
		}

		return mav;
	}

	/**
	 * 품목정보관리(소프트웨어 정보) 목록조회
	 * @param  request 
	 * @param  response
	 * @return 
	 * 2011. 4. 5.
	 */
	public ModelAndView result_3rd(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView();

		try{
			mav.setViewName("/result/result_edit_2nd");	
			HashMap map = WebUtil.parseRequestMap(request);   

			HashMap mapResult = new HashMap();

			/*grid 페이징 처리시 사용 할 페이지 시작 종료 value*/
			int limit = 0;
			if((String)map.get("limit") != null)
				limit = Integer.parseInt((String)map.get("limit"));

			int start = 0;
			if((String)map.get("start") != null)
				start = Integer.parseInt((String)map.get("start"));

			map.put("limit", limit+start);			

			List result_edit_1st = ItemSWBiz.selectItemSW(map);		

			JSONArray jsonArray = new JSONArray();
			jsonArray = JSONArray.fromObject(result_edit_1st);		

			mapResult.put("success", "true");							// 성공여부
			mapResult.put("message", "Loaded data");					// message
			mapResult.put("data_3rd", jsonArray);
			mapResult.put("total_3rd", ItemSWBiz.selectItemSWCount(map));

			JSONObject jsonObject = JSONObject.fromObject(mapResult);	 
			mav.addObject("RESULT_EDIT_2ND", jsonObject);	

		}catch(Exception ex){
			logger.error(ex.getMessage());
		}

		return mav;
	}

	/**
	 * 품목정보관리(제품개발담당자 정보) 목록조회
	 * @param  request	( item_type_code : 품목구분
	 * 					  item_code      : 품목코드
	 * 					)
	 * @param  response
	 * @return 
	 * 2011. 4. 5.
	 */
	public ModelAndView result_4th(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView();

		try{
			mav.setViewName("/result/result_edit_3rd");	
			HashMap map = WebUtil.parseRequestMap(request);   

			HashMap mapResult = new HashMap();

			/*grid 페이징 처리시 사용 할 페이지 시작 종료 value*/
			int limit = 0;
			if((String)map.get("limit") != null)
				limit = Integer.parseInt((String)map.get("limit"));

			int start = 0;
			if((String)map.get("start") != null)
				start = Integer.parseInt((String)map.get("start"));

			map.put("limit", limit+start);			

			List result_edit_1st = ItemDeveloperBiz.selectItemDeveloper(map);		

			JSONArray jsonArray = new JSONArray();
			jsonArray = JSONArray.fromObject(result_edit_1st);		

			mapResult.put("success", "true");							// 성공여부
			mapResult.put("message", "Loaded data");					// message
			mapResult.put("data_4th", jsonArray);
			mapResult.put("total_4th", ItemDeveloperBiz.selectItemDeveloperCount(map));

			JSONObject jsonObject = JSONObject.fromObject(mapResult);	 
			mav.addObject("RESULT_EDIT_3RD", jsonObject);	

		}catch(Exception ex){
			logger.error(ex.getMessage());
		}

		return mav;
	}

	/**
	 * 품목정보관리(하드웨어 정보) 목록조회
	 * @param  request 
	 * @param  response
	 * @return 
	 * 2011. 2. 8.
	 */
	public ModelAndView result_edit_1st(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView();

		try{
			mav.setViewName("/result/result_edit_1st");	
			HashMap map = WebUtil.parseRequestMap(request);   

			HashMap mapResult = new HashMap();

			/*grid 페이징 처리시 사용 할 페이지 시작 종료 value*/
			int limit = 0;
			if((String)map.get("limit") != null)
				limit = Integer.parseInt((String)map.get("limit"));

			int start = 0;
			if((String)map.get("start") != null)
				start = Integer.parseInt((String)map.get("start"));

			map.put("limit", limit+start);			

			List result_edit_1st = ItemHWBiz.selectItemHW(map);		

			JSONArray jsonArray = new JSONArray();
			jsonArray = JSONArray.fromObject(result_edit_1st);		

			mapResult.put("success", "true");							// 성공여부
			mapResult.put("message", "Loaded data");					// message
			mapResult.put("data_edit_1st", jsonArray);
			mapResult.put("total_edit_1st", ItemHWBiz.selectItemHWCount(map));

			JSONObject jsonObject = JSONObject.fromObject(mapResult);	 
			mav.addObject("RESULT_EDIT_1ST", jsonObject);	

		}catch(Exception ex){
			logger.error(ex.getMessage());
		}

		return mav;
	}

	/**
	 * 품목정보관리(소프트웨어 정보) 목록조회
	 * @param  request 
	 * @param  response
	 * @return 
	 * 2011. 4. 5.
	 */
	public ModelAndView result_edit_2nd(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView();

		try{
			mav.setViewName("/result/result_edit_2nd");	
			HashMap map = WebUtil.parseRequestMap(request);   

			HashMap mapResult = new HashMap();

			/*grid 페이징 처리시 사용 할 페이지 시작 종료 value*/
			int limit = 0;
			if((String)map.get("limit") != null)
				limit = Integer.parseInt((String)map.get("limit"));

			int start = 0;
			if((String)map.get("start") != null)
				start = Integer.parseInt((String)map.get("start"));

			map.put("limit", limit+start);			

			List result_edit_1st = ItemSWBiz.selectItemSW(map);		

			JSONArray jsonArray = new JSONArray();
			jsonArray = JSONArray.fromObject(result_edit_1st);		

			mapResult.put("success", "true");							// 성공여부
			mapResult.put("message", "Loaded data");					// message
			mapResult.put("data_edit_2nd", jsonArray);
			mapResult.put("total_edit_2nd", ItemSWBiz.selectItemSWCount(map));

			JSONObject jsonObject = JSONObject.fromObject(mapResult);	 
			mav.addObject("RESULT_EDIT_2ND", jsonObject);	

		}catch(Exception ex){
			logger.error(ex.getMessage());
		}

		return mav;
	}

	/**
	 * 품목정보관리(제품개발담당자 정보) 목록조회
	 * @param  request	( item_type_code : 품목구분
	 * 					  item_code      : 품목코드
	 * 					)
	 * @param  response
	 * @return 
	 * 2011. 4. 5.
	 */
	public ModelAndView result_edit_3rd(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView();

		try{
			mav.setViewName("/result/result_edit_3rd");	
			HashMap map = WebUtil.parseRequestMap(request);   

			HashMap mapResult = new HashMap();

			/*grid 페이징 처리시 사용 할 페이지 시작 종료 value*/
			int limit = 0;
			if((String)map.get("limit") != null)
				limit = Integer.parseInt((String)map.get("limit"));

			int start = 0;
			if((String)map.get("start") != null)
				start = Integer.parseInt((String)map.get("start"));

			map.put("limit", limit+start);			

			List result_edit_1st = ItemDeveloperBiz.selectItemDeveloper(map);		

			JSONArray jsonArray = new JSONArray();
			jsonArray = JSONArray.fromObject(result_edit_1st);		

			mapResult.put("success", "true");							// 성공여부
			mapResult.put("message", "Loaded data");					// message
			mapResult.put("data_edit_3rd", jsonArray);
			mapResult.put("total_edit_3rd", ItemDeveloperBiz.selectItemDeveloperCount(map));

			JSONObject jsonObject = JSONObject.fromObject(mapResult);	 
			mav.addObject("RESULT_EDIT_3RD", jsonObject);	

		}catch(Exception ex){
			logger.error(ex.getMessage());
		}

		return mav;
	}

	/**
	 * 품목정보관리 상세조회 : 조회된 목록을 화면으로 retuen
	 * @param  request (
	 *
	 *                 )
	 * @param  response
	 * @return mav	   (COM_ITEM 품목관리
	 * 					,COM_CODE 공통코드관리)
	 * 2011. 2. 8.
	 */
	public ModelAndView itemDetail(HttpServletRequest request, HttpServletResponse response) {

		ModelAndView mav = new ModelAndView();

		try {

			// 조회조건 설정
			HashMap paramMap = WebUtil.parseRequestMap(request); 

			// 공통코드 조회
			//List com_code = DeptBiz.selectComboCode("YESNO_CODE");	// 사용여부(group_code:YESNO_CODE)

			logger.debug("상세조회 parameter :: "+paramMap.toString());

			// 상세조회			
			HashMap result = ItemBiz.selectItembyPK(paramMap);		// DB에서 목록조회

			logger.debug("상세조회 결과  result:: "+result.toString());

			//			JSONArray jsonArray = JSONArray.fromObject(result);

			//			logger.debug("상세조회 결과  jsonArray:: "+jsonArray.toString());

			// 조회된 결과를 JSON형식으로 screen에 Return
			//			HashMap<String,Object> mapResult = new HashMap<String, Object>();
			//			mapResult.put("success", "true");							// 성공여부
			//			mapResult.put("message", "Loaded data");					// message
			//			mapResult.put("data", jsonArray);							// 조회된 결과값
			//			JSONObject jsonObject = JSONObject.fromObject(mapResult);	// JSON형식으로 설정

			//			logger.debug("상세조회 결과  jsonObject:: "+jsonObject.toString());

			// 조회결과를 mav에 담기
			mav.addObject("RESULT", result);	// 품목정보관리 상세조회 결과
			//mav.addObject("COM_CODE", com_code);	// comboBox 사용여부

			//			logger.debug("test Edit_grid -----------------------------------");
			//			logger.debug(jsonObject);
			//			logger.debug("test Edit_grid -----------------------------------");

		} catch (Exception e) {
			logger.error(e, e);
		}
		return mav;
	}

	/**
	 * 품목관리 입력, 수정
	 * @param request	( COM_ITEM 		   : 품목관리
	 *                  , COM_ITEM_SPEC_HW : 제품권장사양_HW
	 *                  , COM_ITEM_SPEC_SW : 제품권장사양_SW
	 *                  , COM_DEVELOPER    : 제품개발담당자관리
	 * 					)
	 * @param response
	 * @return
	 * @throws Exception
	 * 2011. 4. 5.
	 */
	public ModelAndView saveItem(HttpServletRequest request, HttpServletResponse response)throws Exception{

		ModelAndView mav = new ModelAndView(); 
		HashMap mapResult = new HashMap();
		JSONArray jsonArray = new JSONArray();
		JSONObject jsonObject = new JSONObject();

		try {
			mav = new ModelAndView();
			mav.setViewName("/result/result_1st");

			/***** 조회조건 및 parameter설정 *****/
			HashMap map = WebUtil.parseRequestMap(request);  

			/***** session 정보 *****/
			HashMap adminMap = (HashMap)request.getSession().getAttribute(SGConfigManager.getString("common.session.admin.name"));
			map.put("final_mod_id", (String)adminMap.get("ADMIN_ID"));	// 로그인 ID

			/***** 저장 및 수정 *****/
			boolean deptRegResult = ItemBiz.saveItem(map, request);

			/***** 목록조회 *****/
			List result = ItemBiz.selectItem(map);						 

			/***** 조회된 결과를 JSON형식으로 screen에 Return *****/

			jsonArray = JSONArray.fromObject(result); 			
			mapResult.put("success", "true");							// 성공여부
			mapResult.put("message", "Loaded data");					// message
			mapResult.put("data_1st", jsonArray);						// 조회된 결과값
			mapResult.put("total_1st", ItemBiz.selectItemCount(map));	// 목록의 총갯수 조회
			jsonObject = JSONObject.fromObject(mapResult);	

		}catch (Exception e){
			logger.error(e, e);
		}finally{

		}
		mav.addObject("RESULT_1ST", jsonObject); 	
		return mav;
	}

	/**
	 * 아이템 조회 화면(팝업)
	 * @param  request
	 * @param  response
	 * @return mav		(공통코드 목록)
	 * 2011. 3. 15.
	 */
	public ModelAndView itemSearchPop(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = null;

		try {
			mav = new ModelAndView();
			// 공통코드 조회
			List item_pattern_code  = sgisCodeBiz.selectComboCode("ITEM_PATTERN_CODE"); // 품목유형코드

			mav.addObject("ITEM_PATTERN_CODE", item_pattern_code);	// 품목유형코드
			
			mav.addObject("RESULT", "");

		} catch (Exception e) {
			logger.error(e, e);
		}
		return mav;
	}

	/**
	 * 아이템 조회(팝업) 검색 결과
	 * @param  request
	 * @param  response
	 * @return mav		(아이템 조회 결과 )
	 * 2011. 3. 15.
	 */
	public ModelAndView itemPopList(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView();

		try{

			mav.setViewName("/result/result_2nd");	
			HashMap map = WebUtil.parseRequestMap(request);  

			HashMap mapResult = new HashMap();

			/*grid 페이징 처리시 사용 할 페이지 시작 종료 value*/
			int limit = 0;
			if((String)map.get("limit") != null)
				limit = Integer.parseInt((String)map.get("limit"));
			int start = 0;
			if((String)map.get("start") != null)
				start = Integer.parseInt((String)map.get("start"));

			map.put("limit", limit+start);

			List result = ItemBiz.selectItem(map);						 

			JSONArray jsonArray = new JSONArray();
			jsonArray = JSONArray.fromObject(result); 			

			mapResult.put("success", "true");							// 성공여부
			mapResult.put("message", "Loaded data");					// message
			mapResult.put("data_2nd", jsonArray);	
			mapResult.put("total_2nd", ItemBiz.selectItemCount(map));

			JSONObject jsonObject = JSONObject.fromObject(mapResult);	
			mav.addObject("RESULT_2ND", jsonObject); 			

		}catch(Exception ex){
			logger.error(ex.getMessage());
		}

		return mav;
	}


	/**
	 * 아이템(장비-제품이 아닌것) 조회 화면(팝업)
	 * @param  request
	 * @param  response
	 * @return mav		(공통코드 목록)
	 * 2011. 3. 15.
	 */
	public ModelAndView itemEquipSearchPop(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = null;

		try {
			mav = new ModelAndView();
			mav.addObject("RESULT", "");

		} catch (Exception e) {
			logger.error(e, e);
		}
		return mav;
	}	
	
	/**
	 * 아이템(장비-제품이 아닌것) 조회(팝업) 검색 결과
	 * @param  request
	 * @param  response
	 * @return mav		(아이템 조회 결과 )
	 * 2011. 3. 15.
	 */
	public ModelAndView itemEquipPopList(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView();

		try{

			mav.setViewName("/result/result_2nd");	
			HashMap map = WebUtil.parseRequestMap(request);  

			HashMap mapResult = new HashMap();

			/*grid 페이징 처리시 사용 할 페이지 시작 종료 value*/
			int limit = 0;
			if((String)map.get("limit") != null)
				limit = Integer.parseInt((String)map.get("limit"));
			int start = 0;
			if((String)map.get("start") != null)
				start = Integer.parseInt((String)map.get("start"));

			map.put("limit", limit+start);

			List result = ItemBiz.selectItemEquip(map);						 

			JSONArray jsonArray = new JSONArray();
			jsonArray = JSONArray.fromObject(result); 			

			mapResult.put("success", "true");							// 성공여부
			mapResult.put("message", "Loaded data");					// message
			mapResult.put("data_2nd", jsonArray);	
			mapResult.put("total_2nd", ItemBiz.selectItemEquipCount(map));

			JSONObject jsonObject = JSONObject.fromObject(mapResult);	
			mav.addObject("RESULT_2ND", jsonObject); 			

		}catch(Exception ex){
			logger.error(ex.getMessage());
		}

		return mav;
	}	

}
