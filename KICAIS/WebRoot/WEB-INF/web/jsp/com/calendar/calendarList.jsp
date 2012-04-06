<%--
  Class Name  : calendarList.jsp
  Description : 공휴일관리
  Modification Information
 
      수정일                   수정자                 수정내용
  -------      --------    ---------------------------
  2011. 3. 31   여인범            최초 생성   
  
  author   : 여인범
  since    : 2011. 3. 31.
  version  : 1.0
   
  Copyright (C) 2011 by SG All right reserved.
--%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>


<%@ include file="/WEB-INF/web/jsp/common/inc/commonInc.jsp" %>
<script type="text/javascript" src="/resource/common/js/ajax.js" ></script>
<script type="text/javascript" src="/resource/common/js/grid/grid_1st.js"></script>

<script type="text/javascript">
/***************************************************************************
 * 초기값 설정
 ***************************************************************************/
var	gridHeigth_1st 	 	= 370; 						// 그리드 전체 높이
var	gridWidth_1st		= 490;						// 그리드 전체 폭
var gridTitle_1st 		= "공휴일목록";				// 그리드 제목
var	render_1st			= "custom-grid";	        // 렌더(화면에 그려질) 할 id 
var	pageSize_1st		= 10;	  					// 그리드 페이지 사이즈	
var	proxyUrl_1st		= "/com/calendar/result_1st.sg";  // 결과 값 페이지
var limit_1st			= pageSize_1st;
var start_1st			= 0;

/***************************************************************************
 * Grid의 컬럼 설정
 ***************************************************************************/
var userColumns_1st =  [  {header: '일'         ,width: 100 ,sortable: true ,dataIndex: 'DAY'            }       
						, {header: '월'        	,width: 60	,sortable: true ,dataIndex: 'MONTH'          }
						, {header: '연도'       	,width: 60  ,sortable: true ,dataIndex: 'YEAR'           }
						, {header: '요일'       	,width: 60  ,sortable: true ,dataIndex: 'WHATDAY'        }
						, {header: '상태값'      	,width: 60  ,sortable: true ,dataIndex: 'STATUS_VAL'     }
						, {header: '내용'        ,width: 100 ,sortable: true ,dataIndex: 'CONTENT'        }                  
						, {header: '비고'       	,width: 50  ,sortable: true ,dataIndex: 'NOTE'           }
						, {header: '최종변경자ID'	,width: 50  ,sortable: true ,dataIndex: 'FINAL_MOD_ID'   ,hidden : true}
						, {header: '최종변경일시'	,width: 50  ,sortable: true ,dataIndex: 'FINAL_MOD_DATE' ,hidden : true}
						]; 

/***************************************************************************
 * 그리드 결과매핑 
 ***************************************************************************/
var mappingColumns_1st = [ 	  {name: 'DAY'         		,allowBlank: false}
							, {name: 'MONTH'       		,allowBlank: false}
							, {name: 'YEAR'        		,allowBlank: false}
							, {name: 'WHATDAY'      	,allowBlank: false}
							, {name: 'STATUS_VAL'   	,allowBlank: false}
							, {name: 'CONTENT'      	,allowBlank: false}
							, {name: 'NOTE'         	,allowBlank: false}
							, {name: 'FINAL_MOD_ID' 	,allowBlank: false}
							, {name: 'FINAL_MOD_DATE' 	,allowBlank: false}
						];
 
/***************************************************************************
 * 그리드 클릭시 Event
 ***************************************************************************/
function fnGridOnClick_1st(store, rowIndex){

	/***** 선택된 레코드에서 데이타 가져오기 *****/
	document.detailForm.day.value			=fnFixNull(store.getAt(rowIndex).data.DAY);                      
	document.detailForm.month.value			=fnFixNull(store.getAt(rowIndex).data.MONTH);                  
	document.detailForm.year.value			=fnFixNull(store.getAt(rowIndex).data.YEAR);
	
	document.detailForm.src_day.value			=fnFixNull(store.getAt(rowIndex).data.DAY);                      
	document.detailForm.src_month.value			=fnFixNull(store.getAt(rowIndex).data.MONTH);                  
	document.detailForm.src_year.value			=fnFixNull(store.getAt(rowIndex).data.YEAR);
	
	document.detailForm.whatday.value		=fnFixNull(store.getAt(rowIndex).data.WHATDAY);              
	document.detailForm.status_val.value	=fnFixNull(store.getAt(rowIndex).data.STATUS_VAL);        
	document.detailForm.content.value		=fnFixNull(store.getAt(rowIndex).data.CONTENT);              
	document.detailForm.note.value			=fnFixNull(store.getAt(rowIndex).data.NOTE);                    
	document.detailForm.final_mod_id.value	=fnFixNull(store.getAt(rowIndex).data.FINAL_MOD_ID);    
	document.detailForm.final_mod_date.value=fnFixNull(store.getAt(rowIndex).data.FINAL_MOD_DATE);

	/***** 필드 비활성화 *****/
	Ext.get('saveBtn').dom.disabled    = true;
	Ext.get('updateBtn').dom.disabled  = false;
}   

/***************************************************************************
 * 설  명 : 필드 초기화
 **************************************************************************/
function fnInitValue(){
	var dForm = document.detailForm;	// 상세 FORM	
	
	dForm.reset();						// 상세필드 초기화
	Ext.get('saveBtn').dom.disabled    = false;
	Ext.get('updateBtn').dom.disabled  = true;
}

/***************************************************************************
 * 설  명 : 검색
 **************************************************************************/
function fnSearch(){  	
	
	Ext.Ajax.request({   
		url: "/com/calendar/result_1st.sg"
		,method : 'POST'   
		,success: function(response){						// 조회결과 성공시
					// 조회된 결과값, store명
					handleSuccess(response,GridClass_1st);
		          }
		,failure: handleFailure   	   // 조회결과 실패시  
		,form   : document.searchForm  // 검색 FORM
		,params : {					   // 조회조건을 DB로 전송하기위해서 조건값 설정
					// 페이지정보
					limit           : limit_1st
			  	  , start           : start_1st
				  }				
	});  
	
	fnInitValue(); // 상세필드 초기화
}  		

/***************************************************************************
 * 설  명 : 저장버튼 클릭
 ***************************************************************************/
function fnSave(){  	

	var sForm = document.searchForm;	// 검색 FORM
	var dForm = document.detailForm;	// 상세 FORM

	Ext.Ajax.request({   
		url: "/com/calendar/actionCalendar.sg"   
		,success: function(response){						// 조회결과 성공시
					// 조회된 결과값, store명
					handleSuccess(response,GridClass_1st,'save');
		          }
		,failure: handleFailure   	    // 조회결과 실패시  
		,form   : document.detailForm   // 상세 FORM
		,params : {					    // 조회조건을 DB로 전송하기위해서 조건값 설정
				  // 페이지정보
					limit           : limit_1st
			  	  , start           : start_1st
				  
			  	  // 검색정보
				  , src_whatday 	: sForm.src_whatday.value
				  }  		
	});  
	
	fnInitValue(); // 상세필드 초기화
		
}  		

/***************************************************************************
 * 설  명 : 화면 설정
 ***************************************************************************/
// ExtJS 진입함수
Ext.onReady(function() {
	
	var sForm = document.searchForm;	// 검색 FORM
	var dForm = document.detailForm;	// 상세 FORM

    // 수정버튼 클릭
	Ext.get('updateBtn').on('click', function(e){
		if(Validator.validate(dForm)){
			dForm.isNew.value="";
			Ext.MessageBox.confirm('Confirm', '수정하시겠습니까?', showResult);
		}
    });
    
    // 저장버튼 클릭
	Ext.get('saveBtn').on('click', function(e){
        if(Validator.validate(dForm)){
			dForm.isNew.value="yes";
        	Ext.MessageBox.confirm('Confirm', '저장하시겠습니까?', showResult);
			
		}	
    });
    
    // 검색버튼 클릭
	Ext.get('searchBtn').on('click', function(e){
        if(Validator.validate(sForm)){
			fnSearch()
		}	
    });
    
   	//조건해제 버튼 -> 검색조건 초기화
   	Ext.get('searchClearBtn').on('click', function(e){
        sForm.reset();	
    });
		
	//신규 버튼 -> 상세필드 초기화
	Ext.get('detailClearBtn').on('click', function(e){
		fnInitValue();		   
	});		
	
	 
	
	
fnInitValue();
	
});
	
// 저장, 수정버튼 클릭시 '예','아니오' 
function showResult(btn){
   	if(btn == 'yes'){
   		fnSave();
   	}    	
};   
	
/***************************************************************************
 * 설  명 : 그리드의 페이지 클릭시 검색조건값을 DB로 전송
 ***************************************************************************/
function fnPagingValue_1st(){
	var sForm = document.searchForm;
	
	try{
    	GridClass_1st.store.setBaseParam('src_whatday', sForm.src_whatday.value);
    	GridClass_1st.store.setBaseParam('src_content', sForm.src_content.value);
    	GridClass_1st.store.setBaseParam('div', 'grid_page');
	}catch(e){

	}
}

</script>

	<table border="0" width="1000" height="200">
		<tr>
			<td colspan="2">
				<form name="searchForm" id="searchForm">
				<!----------------- SEARCH Hearder Start	 ----------------->
				<div id="ext-comp-1002" class=" x-panel x-form-label-left" style="margin-top: 0.4em;"><%-- 0em <- 1em으로 수정하면 상위 공백 --%>
					<div class="x-panel-tl">
						<div class="x-panel-tr">
							<div class="x-panel-tc">
								<div id="ext-gen4" class="x-panel-header x-unselectable" style="-moz-user-select: none;">
									<span id="ext-gen8" class="x-panel-header-text">공휴일 검색</span>
								</div>
							</div>
						</div>
					</div>
				</div>
				<!----------------- SEARCH Hearder END	 ----------------->
				<!----------------- SEARCH Field Start	 ----------------->
				<div class="x-panel-bwrap" >
					<div class="x-panel-ml">
						<div class="x-panel-mr">
							<div class="x-panel-mc" >
								<table border="0" width="100%"  style="font-size: 12px">
						    		<%-- 1 Row Start --%>
						    		<tr>
						    			<td>
											<div tabindex="-1" class="x-form-item " >
												<label class="x-form-item-label" style="width: auto;" for="src_custom_type" >공휴일명 :</label>
												<div style="padding-left: 30px;" class="x-form-element">
													<input type="text" name="src_whatday" id="src_whatday" title="공휴일명" style="width: 150;" />
												</div>
											</div>
										</td>
										<td>
											<div tabindex="-1" class="x-form-item " >
												<label class="x-form-item-label" style="width: auto;" for="src_content" >내용 :</label>
												<div style="padding-left: 30px;" class="x-form-element">
													<input type="text" name="src_content" id="src_content" title="내용" style="width: 150;" />
												</div>
											</div>
										</td>  
									</tr>
									<%-- 1 Row End --%>
									
									<%-- 2 Row 버튼 Start --%>
									<tr align="right">
										<td colspan="2">
											<table>
												<tr>
													<td>
													<%-- 검색하기버튼 Start --%>
													<table border="0" cellspacing="0" class="x-btn  x-btn-noicon" style="width: 50px;">
														<tbody class="x-btn-small x-btn-icon-small-left">
															<tr><td class="x-btn-tl"><i>&nbsp;</i></td><td class="x-btn-tc"></td><td class="x-btn-tr"><i>&nbsp;</i></td></tr>
															<tr>
																<td class="x-btn-ml"><i>&nbsp;</i></td>
																<td class="x-btn-mc">
																	<em unselectable="on" class="">
																		<button type="button" id="searchBtn" class=" x-btn-text">검색하기</button>
																	</em>
																</td>
																<td class="x-btn-mr"><i>&nbsp;</i></td>
															</tr>
															<tr><td class="x-btn-bl"><i>&nbsp;</i></td><td class="x-btn-bc"></td><td class="x-btn-br"><i>&nbsp;</i></td></tr>
														</tbody>
													</table>
													<%-- 검색하기버튼 End	--%>
													</td>
													
													<td width="1"></td>
													
													<td>
													<%-- 조건초기화 버튼 Start --%>
													<table border="0" cellspacing="0" class="x-btn  x-btn-noicon" style="width: width: 50px;;">
														<tbody class="x-btn-small x-btn-icon-small-left">
															<tr><td class="x-btn-tl"><i>&nbsp;</i></td><td class="x-btn-tc"></td><td class="x-btn-tr"><i>&nbsp;</i></td></tr>
															<tr>
																<td class="x-btn-ml"><i>&nbsp;</i></td>
																<td class="x-btn-mc">
																	<em unselectable="on" class="">
																		<button type="button" id="searchClearBtn" class=" x-btn-text">조건해제</button>
																	</em>
																</td>
																<td class="x-btn-mr"><i>&nbsp;</i></td>
															</tr>
															<tr><td class="x-btn-bl"><i>&nbsp;</i></td><td class="x-btn-bc"></td><td class="x-btn-br"><i>&nbsp;</i></td></tr>
														</tbody>
													</table>
													<%-- 조건초기화 버튼 End --%>
													</td>
												</tr>
											</table>
										</td>
									</tr>
									<%-- 2 Row 버튼 End --%>					
								</table>
							</div>
						</div>
					</div>
				</div>
				<!------------------ footer Start -------------------------->
				<div id="" class="x-panel-bl x-panel-nofooter">
					<div class="x-panel-br">
						<div class="x-panel-bc">
						</div>
					</div>
				</div>
				<!----------------- footer End  ---------------------------->
				<!----------------- SEARCH Field End ----------------------->
				</form>
			</td>
		</tr>
		<tr>
			<!------------------------------ GRID START ---------------------------------->
			<td width="50%" valign="top">
				<div id="custom-grid" style="margin-top: 0.4em;"></div>
			</td>
			<!------------------------------ GRID END ------------------------------------>
			<td width="50%" valign="top">
				<div class=" x-panel x-form-label-left" style="margin-top: 0.4em; width: 100%;"><%-- 0em <- 1em으로 수정하면 상위 공백 --%>
					<!----------------- SEARCH Hearder Start	 ----------------->
					<div class="x-panel-tl">
						<div class="x-panel-tr">
							<div class="x-panel-tc">
								<div class="x-panel-header x-unselectable" style="-moz-user-select: none;">
									<span class="x-panel-header-text">공휴일 정보</span>
								</div>
							</div>
						</div>
					</div>
					<!----------------- SEARCH Hearder End	 ----------------->
					<div class="x-panel-bwrap" >
						<div class="x-panel-ml">
							<div class="x-panel-mr">
								<div class="x-panel-mc" >
									<!-- 폼 시작 -->
									<form id="detailForm" name="detailForm" method="POST" class="x-panel-body x-form" style="padding: 1px 1px 0pt; width: 480px;height:333">
									<input type="hidden" name="src_day" id="src_day">
									<input type="hidden" name="src_month" id="src_month">
									<input type="hidden" name="src_year" id="src_year">
									
									<input type="hidden" name="isNew" id="isNew">
									<!-- DETAIL 1_ROW Start -->
									<div class="x-column-inner" style="width: 100%;">
										<!-- 신규 버튼 시작 -->
										<div tabindex="-1" class="x-form-item" >
											<table cellspacing="0" class="x-btn  x-btn-noicon" style="width: 75px;" align="right">
												<tbody class="x-btn-small x-btn-icon-small-left">
													<tr><td class="x-btn-tl"><i>&nbsp;</i></td><td class="x-btn-tc"></td><td class="x-btn-tr"><i>&nbsp;</i></td></tr>
													<tr>
														<td class="x-btn-ml"><i>&nbsp;</i></td>
														<td class="x-btn-mc">
															<em unselectable="on" class="">
																<button type="button" id="detailClearBtn" class=" x-btn-text">신규</button>
															</em>
														</td>
														<td class="x-btn-mr"><i>&nbsp;</i></td>
													</tr>
													<tr><td class="x-btn-bl"><i>&nbsp;</i></td><td class="x-btn-bc"></td><td class="x-btn-br"><i>&nbsp;</i></td></tr>
												</tbody>
											</table>
										</div>
										<!-- 신규 버튼 끝 -->
									</div>
									<!-- DETAIL 1_ROW End -->

									<!-- DETAIL 2_ROW Start -->
									<div class="x-column-inner" style="width: 100%; margin-top: 0.2em;">
										<div class=" x-panel x-column" style="width: 50%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label class="x-form-item-label" style="width: auto;" for="year" ><font color="red">* </font>연도 :</label>
														<input type="hidden" name="flag" id="flag" autocomplete="off" size="1" class=" x-form-text x-form-field" style="width: auto;">
														<div style="padding-left: 107px;" class="x-form-element">
															<select name="year" id="year" title="연도" style="width: 46%;" type="text" class="x-form-select x-form-field" >
																<option value="">::선택::</option>
																<c:forEach var="year" begin="2011" end="2020" varStatus="status">
																<option value="${status.index}"><c:out value="${status.index}"/></option>
																</c:forEach>
															</select>
														</div>
														<div class="x-form-clear-left">
														</div>
													</div>
												</div>
											</div>
										</div>
										<div class=" x-panel x-column" style="width: 50%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label class="x-form-item-label" style="width: auto;" for="month" ><font color="red">* </font>월:</label>
														<div style="padding-left: 91px;" class="x-form-element">
															<select name="month" id="month" title="월" style="width: 45%;" type="text" class="x-form-select x-form-field" >
																<option value="">::선택::</option>
																<c:forEach var="month" begin="1" end="12" varStatus="status">
																<option value="<c:if test='${status.index < 10}'>0</c:if>${status.index}"><c:if test='${status.index < 10}'>0</c:if><c:out value="${status.index}"/></option>
																</c:forEach>
															</select>
														</div>
														<div class="x-form-clear-left">
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>
									<!-- DETAIL 2_ROW End -->
									
									<!-- DETAIL 3_ROW Start -->
									<div class="x-column-inner" style="width: 100%; margin-top: 0.2em;">
										<div class=" x-panel x-column" style="width: 50%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label class="x-form-item-label" style="width: auto;" for="day" ><font color="red">* </font>일 :</label>
														<div style="padding-left: 107px;" class="x-form-element">
															<select name="day" id="day" title="일" style="width: 46%;" type="text" class="x-form-select x-form-field" >
																<option value="">::선택::</option>
																<c:forEach var="day" begin="1" end="31" varStatus="status">
																
																<option value="<c:if test='${status.index < 10}'>0</c:if>${status.index}"><c:if test='${status.index < 10}'>0</c:if><c:out value="${status.index}"/></option>
																</c:forEach>
															</select>
														</div>
														<div class="x-form-clear-left">
														</div>
													</div>
												</div>
											</div>
										</div>
										<div class=" x-panel x-column" style="width: 50%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label class="x-form-item-label" style="width: auto;" for="est_date" ></label>
														<div style="padding-left: 91px;" class="">
															
														</div>
														<div class="x-form-clear-left">
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>
									<!-- DETAIL 3_ROW End -->
									
									<!-- DETAIL 4_ROW Start -->
									<div class="x-column-inner" style="width: 100%; margin-top: 0.2em;">
										<div class=" x-panel x-column" style="width: 50%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label class="x-form-item-label" style="width: auto;" for="whatday" ><font color="red">* </font>요일 :</label>
														<div style="padding-left: 107px;" class="x-form-element">
															<input type="text" name="whatday" id="whatday" autocomplete="off" size="18" class=" x-form-text x-form-field" style="width: auto;">
														</div>
														<div class="x-form-clear-left">
														</div>
													</div>
												</div>
											</div>
										</div>
										<div class=" x-panel x-column" style="width: 50%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label class="x-form-item-label" style="width: auto;" for="status_val" >상태값 :</label>
														<div style="padding-left: 91px;" class="x-form-element">
															<select name="status_val" id="status_val" title="상태값" style="width: 45%;" type="text" class="x-form-select x-form-field" >
																<option value="">::선택::</option>
																<option value="Y">적용</option>
																<option value="Y">미적용</option>
															</select>
														</div>
														<div class="x-form-clear-left">
														</div>
													</div>
												</div>
											</div>
										</div>
									<!-- DETAIL 4_ROW End -->
									
									<!-- DETAIL 5_ROW Start -->
									<div class="x-column-inner" style="width: 100%; margin-top: 0.2em;">
										<div class=" x-panel x-column" style="width: 50%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label class="x-form-item-label" style="width: auto;" for="content" >내용 :</label>
														<div style="padding-left: 107px;" class="x-form-element">
															<input type="text" name="content" id="content" autocomplete="off" size="18" class=" x-form-text x-form-field" style="width: auto;">
														</div>
														<div class="x-form-clear-left">
														</div>
													</div>
												</div>
											</div>
										</div>
										<div class=" x-panel x-column" style="width: 50%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label class="x-form-item-label" style="width: auto;" for="note" >비고 :</label>
														<div style="padding-left: 91px;" class="x-form-element">
															<input type="text" name="note" id="note" autocomplete="off" size="18" class=" x-form-text x-form-field" style="width: auto;">
														</div>
														<div class="x-form-clear-left">
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>
									<!-- DETAIL 5_ROW End -->
									<!-- DETAIL 6_ROW Start -->
									<div class="x-column-inner" style="width: 100%; margin-top: 0.2em;">
										<div class=" x-panel x-column" style="width: 50%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label class="x-form-item-label" style="width: auto;" for="final_mod_date" >최종수정일 :</label>
														<div style="padding-left: 107px;" class="x-form-element">
															<input readonly="readonly" type="text" name="final_mod_date" id="final_mod_date" autocomplete="off" size="18" class=" x-form-text x-form-field" style="width: auto;">
														</div>
														<div class="x-form-clear-left">
														</div>
													</div>
												</div>
											</div>
										</div>
										<div class=" x-panel x-column" style="width: 50%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label class="x-form-item-label" style="width: auto;" for="final_mod_id" >최종수정자 :</label>
														<div style="padding-left: 91px;" class="x-form-element">
															<input readonly="readonly" type="text" name="final_mod_id" id="final_mod_id" autocomplete="off" size="18" class=" x-form-text x-form-field" style="width: auto;">
														</div>
														<div class="x-form-clear-left">
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>
									<!-- DETAIL 6_ROW End -->
									
									 
									</form>
								</div>
							</div>
						</div>
					</div>
				</div>
				<!----------------- DETAIL Field End	 ----------------->
				<%-- footer Start --%>
				<div id="" class="x-panel-bl x-panel-nofooter">
					<div class="x-panel-br">
						<div class="x-panel-bc">
						</div>
					</div>
				</div>
				<%-- footer End  --%>
			</td>
		</tr>
		<tr>
			<td colspan="2" align="center" height="35">
				<table>
					<tr>
						<td>
						<%-- 저장 버튼 Start --%>
						<table border="0" cellspacing="0" class="x-btn  x-btn-noicon" style="width: 50px;">
							<tbody class="x-btn-small x-btn-icon-small-left">
								<tr>
									<td class="x-btn-tl">
										<i>&nbsp;</i>
									</td>
									<td class="x-btn-tc">
									</td>
									<td class="x-btn-tr">
										<i>&nbsp;</i>
									</td>
								</tr>
								<tr>
									<td class="x-btn-ml">
										<i>&nbsp;</i>
									</td>
									<td class="x-btn-mc">
										<em unselectable="on" class="">
											<button type="button" id="saveBtn" name="saveBtn" class=" x-btn-text">저장</button>
										</em>
									</td>
									<td class="x-btn-mr">
										<i>&nbsp;</i>
									</td>
								</tr>
								<tr>
									<td class="x-btn-bl">
										<i>&nbsp;</i>
									</td>
									<td class="x-btn-bc">
									</td>
									<td class="x-btn-br">
										<i>&nbsp;</i>
									</td>
								</tr>
							</tbody>
						</table>
						<%-- 저장버튼 End	--%>
						</td>
						<td width="1">
						</td>
						<td>
						<%-- 수정 버튼 Start --%>
						<table border="0" cellspacing="0" class="x-btn  x-btn-noicon" style="width: width: 50px;;">
							<tbody class="x-btn-small x-btn-icon-small-left">
								<tr>
									<td class="x-btn-tl">
										<i>&nbsp;</i>
									</td>
									<td class="x-btn-tc">
									</td>
									<td class="x-btn-tr">
										<i>&nbsp;</i>
									</td>
								</tr>
								<tr>
									<td class="x-btn-ml">
										<i>&nbsp;</i>
									</td>
									<td class="x-btn-mc">
										<em unselectable="on" class="">
											<button type="button" id="updateBtn" name="updateBtn" class=" x-btn-text">수정</button>
										</em>
									</td>
									<td class="x-btn-mr">
										<i>&nbsp;</i>
									</td>
								</tr>
								<tr>
									<td class="x-btn-bl">
										<i>&nbsp;</i>
									</td>
									<td class="x-btn-bc">
									</td>
									<td class="x-btn-br">
										<i>&nbsp;</i>
									</td>
								</tr>
							</tbody>
						</table>
						<%-- 수정 버튼 End --%>
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
</body>

<%@ include file="/WEB-INF/web/jsp/sgis-bottom-inc.jsp" %>