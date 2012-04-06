<%--
  Class Name  : issueList.jsp
  Description : 이슈관리
  Modification Information
 
      수정일                   수정자                 수정내용
  -------      --------    ---------------------------
  2011. 3. 11   고기범            최초 생성   
  
  author   : 고기범
  since    : 2011. 3. 11.
  version  : 1.0
   
  Copyright (C) 2011 by SG All right reserved.
--%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/web/jsp/common/inc/commonInc.jsp" %>
<script type="text/javascript" src="/resource/common/js/sgis-comm-inc.js" ></script> 
<script type="text/javascript" src="/resource/common/js/common/common-msg-box.js" ></script> 
<script type="text/javascript" src="/resource/common/js/ajax.js" ></script>

<script type="text/javascript" src="/resource/common/js/grid/grid_1st.js"></script>

<script type="text/javascript">
/***************************************************************************
 * 초기값 설정
 ***************************************************************************/
var	gridHeigth_1st	= "387";
var	gridWidth_1st  	= "500";
var	gridTitle_1st   = "이슈관리"; 
var	render_1st		= "render_1st";
var pageSize_1st	= 14;
var limit_1st		= pageSize_1st;
var start_1st		= 0;
var proxyUrl_1st	= "/com/issue/result_1st.sg";

/***************************************************************************
 * Grid의 컬럼 설정
 ***************************************************************************/
var userColumns_1st =  [ {header: "상태"			,width: 100	,sortable: true ,dataIndex: 'FLAG'				, hidden : true}       
				   	   , {header: "이슈구분코드"	,width:  60	,sortable: true ,dataIndex: 'ISSUE_TYPE_CODE'	, hidden : true}                                                    
				   	   , {header: "이슈구분"		,width:  40	,sortable: true ,dataIndex: 'ISSUE_TYPE_NAME'	}
				       , {header: "이슈코드"		,width:  40	,sortable: true ,dataIndex: 'ISSUE_CODE'		}                  
				       , {header: "순번"			,width:  40	,sortable: true ,dataIndex: 'ISSUE_INFO_SEQ'	}
				       , {header: "이슈내용"		,width: 150	,sortable: true ,dataIndex: 'ISSUE_COMMENT'		}
				       , {header: "비고"			,width:  50	,sortable: true ,dataIndex: 'NOTE'				, hidden : true}
				       , {header: "사용여부"		,width:  40	,sortable: true ,dataIndex: 'USE_YN' 			}  
				       , {header: "최종변경자ID"	,width:  70	,sortable: true ,dataIndex: 'FINAL_MOD_ID' 		, hidden : true}  
				       , {header: "최종변경일시"	,width:  50	,sortable: true ,dataIndex: 'FINAL_MOD_DATE'	, hidden : true}
				       ];	 

/***************************************************************************
 * 그리드 결과매핑 
 ***************************************************************************/
var mappingColumns_1st = [ {name: 'FLAG' 		  	,allowBlank: false}	 // 상태
					 	 , {name: 'ISSUE_TYPE_CODE'	,allowBlank: false}  // 이슈구분코드  
					 	 , {name: 'ISSUE_TYPE_NAME'	,allowBlank: false}  // 이슈구분  
					 	 , {name: 'ISSUE_CODE'	  	,allowBlank: false}  // 이슈코드
					 	 , {name: 'ISSUE_INFO_SEQ' 	,allowBlank: false}  // 순번   
					 	 , {name: 'ISSUE_COMMENT'  	,allowBlank: false}  // 이슈내용     
					 	 , {name: 'NOTE' 		  	,allowBlank: false}  // 비고
					 	 , {name: 'USE_YN' 		  	,allowBlank: false}  // 사용여부      
					 	 , {name: 'FINAL_MOD_ID'   	,allowBlank: false}  // 최종변경자ID  
					 	 , {name: 'FINAL_MOD_DATE' 	,allowBlank: false}  // 최종변경일시
    				 	 ];
 
/***************************************************************************
 * 그리드 클릭시 Event
 ***************************************************************************/
function fnGridOnClick_1st(store, rowIndex){

	/***** 선택된 레코드에서 데이타 가져오기 *****/
<%--	var flag		  = fnFixNull(store.getAt(rowIndex).data.FLAG);			   	// 상태        --%>
<%--	var issueTypeCode = fnFixNull(store.getAt(rowIndex).data.ISSUE_TYPE_CODE);	// 이슈구분코드--%>
<%--	var issueCode	  = fnFixNull(store.getAt(rowIndex).data.ISSUE_CODE);		// 이슈코드    --%>
<%--	var issueInfoSeq  = fnFixNull(store.getAt(rowIndex).data.ISSUE_INFO_SEQ);	// 순번        --%>
<%--	var issueComment  = fnFixNull(store.getAt(rowIndex).data.ISSUE_COMMENT);	// 이슈내용    --%>
<%--	var note	 	  = fnFixNull(store.getAt(rowIndex).data.NOTE);		   		// 비고        --%>
	var useYn		  = fnFixNull(store.getAt(rowIndex).data.USE_YN); 			// 사용여부    
<%--	var finalModId	  = fnFixNull(store.getAt(rowIndex).data.FINAL_MOD_ID); 	// 최종변경자ID--%>
<%--	var finalModDate  = fnFixNull(store.getAt(rowIndex).data.FINAL_MOD_DATE);	// 최종변경일시			--%>
	
	/***** 그리드에 선택된 값을 상세 필드에 설정 *****/		
	var dForm = document.detailForm;
	Ext.get('flag').set({value : fnFixNull(store.getAt(rowIndex).data.FLAG)}, false);						// 상태
	Ext.get('issue_type_code').set({value : fnFixNull(store.getAt(rowIndex).data.ISSUE_TYPE_CODE)}, false);	// 이슈구분코드
	Ext.get('issue_code').set({value : fnFixNull(store.getAt(rowIndex).data.ISSUE_CODE)}, false);				// 이슈코드
	Ext.get('issue_info_seq').set({value : fnFixNull(store.getAt(rowIndex).data.ISSUE_INFO_SEQ)}, false);	// 순번
	Ext.get('issue_comment').set({value : fnFixNull(store.getAt(rowIndex).data.ISSUE_COMMENT)}, false);		// 이슈내용
	//Ext.get('note').set({value : fnFixNull(store.getAt(rowIndex).data.NOTE)}, false);						// 비고
	//Ext.get('final_mod_id').set({value : fnFixNull(store.getAt(rowIndex).data.FINAL_MOD_ID)}, false);		// 최종변경자ID
	//Ext.get('final_mod_date').set({value : fnFixNull(store.getAt(rowIndex).data.FINAL_MOD_DATE)}, false);	// 최종변경일시
	
	// 사용여부
	if(useYn == 'Y'){
		 dForm.use_yn[0].checked = true;
	}else if(useYn == 'N'){
		 dForm.use_yn[1].checked = true;
	}
	
	/***** 필드 비활성화 *****/
	dForm.issue_type_code.disabled 	   = true;	  // 이슈구분코드
	dForm.issue_code.readOnly 		   = true;	  // 이슈코드
	Ext.get('saveBtn').dom.disabled    = true;
	Ext.get('updateBtn').dom.disabled  = false;
}   

/***************************************************************************
 * 설  명 : 필드 초기화
 **************************************************************************/
function fnInitValue(){
	var dForm = document.detailForm;		// 상세 FORM	
	
	dForm.reset();							// 상세필드 초기화
	dForm.issue_type_code.disabled 		= false;	// 구분코드
	dForm.issue_code.readOnly 	   		= false;	// 코드
	Ext.get('saveBtn').dom.disabled    	= false;
	Ext.get('updateBtn').dom.disabled  	= true;
	// 화면 Load시 사용여부 체크
	dForm.use_yn[0].checked = true;
}

/***************************************************************************
 * 설  명 : 검색
 **************************************************************************/
function fnSearch(){  	
	Ext.Ajax.request({   
		url: "/com/issue/result_1st.sg"
		,method : 'POST'   
		,success: function(response){
			var json = Ext.util.JSON.decode(response.responseText);
			this.GridClass_1st.store.loadData(json)
		}
		,failure: handleFailure   	   // 조회결과 실패시  
		,form   : document.searchForm  // 검색 FORM
		,params : {					   // 조회조건을 DB로 전송하기위해서 조건값 설정
					limit          : limit_1st
				  , start          : start_1st
				  }				
	});  
	fnInitValue(); // 상세필드 초기화
}  		

/***************************************************************************
 * 설  명 : 저장버튼 클릭
 ***************************************************************************/
function fnSave(str){  	

	var dForm = document.detailForm;		// 상세 FORM
	dForm.issue_type_code.disabled = false; // 이슈구분코드값이 넘어갈수 있도록 disable 해제
	
	Ext.Ajax.request({   
		url: "/com/issue/updateIssue.sg"   
		,success: function(response){
			//var json = Ext.util.JSON.decode(response.responseText);
			//this.GridClass_1st.store.loadData(json)
			handleSuccess(response,GridClass_1st,'save');
			
		}   	    // 조회결과 성공시
		,failure: handleFailure   	    // 조회결과 실패시  
		,form   : document.detailForm   // 상세 FORM
		,params : {					    // 조회조건을 DB로 전송하기위해서 조건값 설정
				  // 페이지정보
					limit          : limit_1st
			  	  , start          : start_1st
				  // 검색정보
				  , src_issue_type_code : Ext.get('src_issue_type_code').getValue() // 이슈구분코드
			  	  , src_issue_code 		: Ext.get('src_issue_code').getValue() 		// 이슈코드
			  	  , src_issue_comment   : Ext.get('src_issue_comment').getValue() 	// 이슈내용
				  }  		
	});  
	
	fnInitValue(); // 상세필드 초기화
		
}  		


/***************************************************************************
 * Event 및 필드 validation 설정
 ***************************************************************************/
Ext.onReady(function() {
	// QuickTips 초기화
    //Ext.QuickTips.init();
	var dForm = document.detailForm;
	var sForm = document.searchForm;
	
	//검색하기 버튼 
	Ext.get('searchBtn').on('click', function(){
		fnSearch();
	});
	
	//조건해제 버튼 -> 검색조건 초기화
	Ext.get('searchClearBtn').on('click', function(){
		sForm.reset();
		fnSearch();
	});
	
	//신규 버튼 -> 상세필드 초기화
	Ext.get('detailClearBtn').on('click', function(){
		fnInitValue();
	});
	
	//등록 버튼 -> 데이터를 server로 전송
	Ext.get('saveBtn').on('click', function(){
		if(fnValidation()){
			Ext.MessageBox.confirm('Confirm', '저장하시겠습니까?', showResult);
		};
	});
	
	//수정 버튼 -> 데이터를 server로 전송
	Ext.get('updateBtn').on('click', function(){
		if(fnValidation()){
			Ext.MessageBox.confirm('Confirm', '수정하시겠습니까?', showResult);
		};
	});
	
	fnInitValue(); // 상세필드 초기화
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
		GridClass_1st.store.setBaseParam('start', 			 	start_1st);
		GridClass_1st.store.setBaseParam('limit', 			 	limit_1st);
    	GridClass_1st.store.setBaseParam('src_issue_type_code', Ext.get('src_issue_type_code').getValue());
    	GridClass_1st.store.setBaseParam('src_issue_code', 	    Ext.get('src_issue_code').getValue());
    	GridClass_1st.store.setBaseParam('src_issue_comment',   Ext.get('src_issue_comment').getValue());
	}catch(e){

	}
}

function fnValidation(){
	
	var issue_type_code = Ext.get('issue_type_code').getValue();	// 이슈구분코드
	var issue_code = Ext.get('issue_code').getValue(); 				// 이슈코드
	var issue_comment_len = getByteLength(Ext.get('issue_comment').getValue());
	
	if(issue_type_code.length == 0 || issue_type_code == ""){
		Ext.Msg.alert('확인', '구분코드를 선택해주세요.')
		return false;
	}
	
	if(issue_code.length == 0 || issue_code == ""){
		Ext.Msg.alert('확인', '코드를 입력해주세요.')
		return false;
	}
	
	if(issue_comment_len > 1000){
		Ext.Msg.alert('확인', '이슈내용은 한글 500자까지 입력가능합니다.')
		return false;
	}
	
	return true;
	
}
</script>

<body>
	<table border="0" width="1000" height="200">
		<tr>
			<td colspan="2">
				<form name="searchForm">
				<!----------------- SEARCH Hearder Start	 ----------------->
				<div id="ext-comp-1002" class=" x-panel x-form-label-left" style="margin-top: 0em;"><%-- 0em <- 1em으로 수정하면 상위 공백 --%>
					<div class="x-panel-tl">
						<div class="x-panel-tr">
							<div class="x-panel-tc">
								<div id="ext-gen4" class="x-panel-header x-unselectable" style="-moz-user-select: none;">
									<span id="ext-gen8" class="x-panel-header-text">이슈 검색</span>
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
								<table border="0" width="100%">
									<%-- 1 Row Start --%>
									<tr>
										<td width="25%">
											<div tabindex="-1" class="x-form-item " >
												<label class="x-form-item-label" style="width: auto;" for="src_issue_type_code">이슈구분 :</label>
												<div style="padding-left: 30px;" class="x-form-element">
													<select name="src_issue_type_code" id="src_issue_type_code" style="width: 80px;" type="text" class=" x-form-select x-form-field" >
														<option value="">전체</option>
														<c:forEach items="${ISSUE_TYPE_CODE}" var="data" varStatus="status">
														<option value="${data.COM_CODE}"><c:out value="${data.COM_CODE_NAME}"/></option>
														</c:forEach>
													</select>
												</div>
											</div>
										</td>
										
										<td width="25%">
											<div tabindex="-1" class="x-form-item " >
												<label class="x-form-item-label" style="width: auto;" for="src_issue_code" >이슈코드 :</label>
												<div style="padding-left: 30px;" class="x-form-element">
													<input type="text" name="src_issue_code" id="src_issue_code" autocomplete="off" size="15" class="x-form-text x-form-field" style="width: auto;"/>
												</div>
											</div>
										</td>
										
										<td width="25%">
											<div tabindex="-1" class="x-form-item " >
												<label class="x-form-item-label" style="width: auto;" for="src_issue_comment" >이슈내용 :</label>
												<div style="padding-left: 80px;" class="x-form-element">
													<input type="text" name="src_issue_comment" id="src_issue_comment" autocomplete="off" size="15" class="x-form-text x-form-field" style="width: auto;">
												</div>
											</div>
										</td>
										
										<td width="25%" align="right">
											<table>
												<tr>
													<td>
													<%-- 검색하기버튼 Start --%>
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
																		<button type="button" id="searchBtn" class=" x-btn-text">검색하기</button>
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
													<%-- 검색하기버튼 End	--%>
													</td>
													<td width="1">
													</td>
													<td>
													<%-- 조건초기화 버튼 Start --%>
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
																		<button type="button" id="searchClearBtn" class=" x-btn-text">조건해제</button>
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
													<%-- 조건초기화 버튼 End --%>
													</td>
												</tr>
											</table>
										</td>
									</tr>
									<%-- 1 Row End --%>
								</table>
							</div>
						</div>
					</div>
				</div>
				<%-- footer Start --%>
				<div id="" class="x-panel-bl x-panel-nofooter">
					<div class="x-panel-br">
						<div class="x-panel-bc">
						</div>
					</div>
				</div>
				<%-- footer End  --%>
				<!----------------- SEARCH Field End	 ----------------->
				</form>
			</td>
		</tr>
		<tr>
			<!------------------------------ GRID START ---------------------------------->
			<td width="40%" valign="top">
				<div id="render_1st" style="margin-top: 0em;"></div> <%-- 0em <- 1em으로 수정하면 상위 공백 --%><!----------------- 그리드명을 동일하게 설정 ----------------->		
			</td>
			<!------------------------------ GRID END ------------------------------------>
			<td width="60%" valign="top">
				<div class=" x-panel x-form-label-left" style="margin-top: 0em; width: 100%;"><%-- 0em <- 1em으로 수정하면 상위 공백 --%>
					<!----------------- SEARCH Hearder Start	 ----------------->
					<div class="x-panel-tl">
						<div class="x-panel-tr">
							<div class="x-panel-tc">
								<div class="x-panel-header x-unselectable" style="-moz-user-select: none;">
									<span class="x-panel-header-text">이슈 상세정보</span><!----------------- 이름변경 ----------------->		
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
									<form id="detailForm" name="detailForm" method="POST" class="x-panel-body x-form" style="padding: 1px 1px 0pt; width: 480px;">
									<input type="hidden" id="flag" name="flag"/>
									
									<!-- DETAIL 1_ROW Start -->
									<div class="x-column-inner" style="width: 100%;">
										<!-- 신규 버튼 시작 -->
										<div tabindex="-1" class="x-form-item" >
											<table cellspacing="0" class="x-btn  x-btn-noicon" style="width: 75px;" align="right">
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
																<button type="button" id="detailClearBtn" class=" x-btn-text">신규</button>
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
										</div>
										<!-- 신규 버튼 끝 -->
									</div>
									<!-- DETAIL 1_ROW End -->

									<!-- DETAIL 2_ROW Start -->
									<div class="x-column-inner" style="width: 100%; margin-top: 0.2em;">
										<div class=" x-panel x-column" style="width: 100%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label class="x-form-item-label" style="width: auto;" for="issue_type_code"><font color="red">* </font>구분코드 :</label>
														<div style="padding-left: 85px;" class="x-form-element">
															<select name="issue_type_code" id="issue_type_code" style="width: 132px;" type="text" class="x-form-select x-form-field" >
																<option value="">선택하세요</option>
																<c:forEach items="${ISSUE_TYPE_CODE}" var="data" varStatus="status">
																<option value="${data.COM_CODE}"><c:out value="${data.COM_CODE_NAME}"/></option>
																</c:forEach>
															</select>
														</div>
														<div class="x-form-clear-left">
														</div>
													</div>
												</div>
											</div>
										</div>
<%--										<div class=" x-panel x-column" style="width: 50%;">--%>
<%--											<div class="x-panel-bwrap" >--%>
<%--												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">--%>
<%--													<div tabindex="-1" class="x-form-item " >--%>
<%--														<label class="x-form-item-label" style="width: auto;" for="issue_info_seq" >순번 :</label>--%>
<%--														<div style="padding-left: 85px;" class="x-form-element">--%>
															<input type="hidden" name="issue_info_seq" id="issue_info_seq" autocomplete="off" size="20" class="x-form-text x-form-field " style="width: auto;">
<%--														</div>--%>
<%--														<div class="x-form-clear-left">--%>
<%--														</div>--%>
<%--													</div>--%>
<%--												</div>--%>
<%--											</div>--%>
<%--										</div>--%>
									</div>
									<!-- DETAIL 2_ROW End -->
								
									<!-- DETAIL 3_ROW Start -->
									<div class="x-column-inner" style="width: 100%; margin-top: 0.2em;">
										<div class=" x-panel x-column" style="width: 50%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label class="x-form-item-label" style="width: auto;" for="issue_code" ><font color="red">* </font>코드 :</label>
														<div style="padding-left: 84px;" class="x-form-element">
															<input type="text" name="issue_code" id="issue_code" autocomplete="off" class=" x-form-text x-form-field" style="width: 133px;"  maxlength="5"/>
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
														<label style="padding-rigth: 100px;"  class="x-form-item-label" style="width: auto;" for="use_yn1" ><font color="red">* </font>사용여부 :</label>
														<div style="padding-left: 85px;" class="x-form-element">
															<input type="radio" name="use_yn" id="use_yn1" autocomplete="off" class=" x-form-radio x-form-field" value="Y" >
														    <label class="x-form-cb-label" for="use_yn2" >Yes</label>
														    <input type="radio" name="use_yn" id="use_yn2" autocomplete="off" class=" x-form-radio x-form-field" value="N">
														    <label class="x-form-cb-label" for="use_yn2" >No</label>
														</div>	
													</div>
												</div>
											</div>
										</div>
									</div>
									<!-- DETAIL 3_ROW End -->
									
									<!-- DETAIL 4_ROW Start -->
									<div class="x-column-inner" style="width: 100%; margin-top: 0.2em;">
										<div class=" x-panel x-column" style="width: 100%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label class="x-form-item-label" style="width: auto;" for="issue_comment" >&nbsp;&nbsp;&nbsp;이슈내용 :</label>
														<div style="padding-left: 50px; height: 259px; " class="x-form-element">
															<textarea name="issue_comment" id="issue_comment" autocomplete="off" style="width: 375px; height: 230px; left: 13px; top: 0px;" class="x-form-textarea x-form-field x-box-item"></textarea>
														</div>
														<div class="x-form-clear-left">
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>
									<!-- DETAIL 4_ROW End -->
																								
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