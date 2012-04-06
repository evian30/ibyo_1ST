<%--
  Class Name  : deptManager.jsp
  Description : 부서정보관리
  Modification Information
 
      수정일                   수정자                 수정내용
  -------      --------    ---------------------------
  2011. 2. 25. 이재철              최초 생성
  2011. 3. 7   고기범    
  2011. 3. 25  고기범              디자인 변경 및 공통 JS적용          
  
  author   : 이재철
  since    : 2011. 2. 25.
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
var	gridHeigth_1st 	 	= 410; 						// 그리드 전체 높이
var	gridWidth_1st		= 500;						// 그리드 전체 폭
var gridTitle_1st 		= "부서정보관리";	  			// 그리드 제목
var	render_1st			= "user-grid";	  			// 렌더(화면에 그려질) 할 id 
var	pageSize_1st		= 15;	  					// 그리드 페이지 사이즈	
var	proxyUrl_1st		= "/com/dept/result.sg";	// 결과 값 페이지
var limit_1st			= pageSize_1st;
var start_1st			= 0;


/***************************************************************************
 * Grid의 컬럼 설정
 ***************************************************************************/
var userColumns_1st = [ {header: "상태"			,width: 100	,sortable: true	,dataIndex: 'FLAG'				,hidden : true }       
					  , {header: "부서코드"		,width:  40	,sortable: true	,dataIndex: 'DEPT_CODE'			,hidden : false}                                                    
					  , {header: "상위부서코드"	,width:  50	,sortable: true	,dataIndex: 'HIGH_DEPT_CODE'	,hidden : true }
					  , {header: "상위부서"		,width:  60	,sortable: true	,dataIndex: 'HIGH_DEPT_NAME'	,hidden : false}
					  , {header: "부서명"		,width:  60	,sortable: true	,dataIndex: 'DEPT_NAME'			,hidden : false}                  
					  , {header: "부서레벨코드"	,width:  50	,sortable: true	,dataIndex: 'DEPT_LEVEL'		,hidden : true }
					  , {header: "부서레벨"		,width:  50	,sortable: true	,dataIndex: 'DEPT_LEVEL_NAME'	,hidden : false}
					  , {header: "참조코드"		,width:  50	,sortable: true	,dataIndex: 'REF_CODE' 			,hidden : true }   
					  , {header: "사용여부"		,width:  50	,sortable: true	,dataIndex: 'USE_YN' 			,hidden : false}  
					  , {header: "최종변경자ID"	,width: 100	,sortable: true	,dataIndex: 'FINAL_MOD_ID' 		,hidden : true }  
					  , {header: "최종변경일시"	,width:  50	,sortable: true	,dataIndex: 'FINAL_MOD_DATE'	,hidden : true }
					  ];	 

/***************************************************************************
 * 그리드 결과매핑 
 ***************************************************************************/
var mappingColumns_1st = [ {name: 'FLAG' 		    , allowBlank: false}     // 상태
						 , {name: 'DEPT_LEVEL' 		, allowBlank: false}     // 부서레벨코드      
						 , {name: 'DEPT_LEVEL_NAME'	, allowBlank: false}     // 부서레벨 
						 , {name: 'DEPT_NAME' 		, allowBlank: false}     // 부서명      
						 , {name: 'DEPT_CODE' 		, allowBlank: false}     // 부서코드      
						 , {name: 'USE_YN' 			, allowBlank: false}     // 사용여부      
						 , {name: 'HIGH_DEPT_CODE' 	, allowBlank: false}     // 상위부서코드
						 , {name: 'HIGH_DEPT_NAME' 	, allowBlank: false}     // 상위부서
						 , {name: 'REF_CODE' 		, allowBlank: false}     // 참조코드            
						 , {name: 'FINAL_MOD_ID' 	, allowBlank: false}     // 최종변경자ID  
						 , {name: 'FINAL_MOD_DATE' 	, allowBlank: false}     // 최종변경일시
				         ];
 
/***************************************************************************
 * 그리드 클릭시 Event
 ***************************************************************************/
function fnGridOnClick_1st(store, rowIndex){

	/***** 선택된 레코드에서 데이타 가져오기 *****/
	Ext.get('flag').set({value : fnFixNull(store.getAt(rowIndex).data.FLAG)}						, false);  // 상태
	Ext.get('dept_level').set({value : fnFixNull(store.getAt(rowIndex).data.DEPT_LEVEL)}			, false);  // 부서레벨코드
	Ext.get('dept_level_name').set({value : fnFixNull(store.getAt(rowIndex).data.DEPT_LEVEL_NAME)}	, false);  // 부서레벨
	Ext.get('dept_name').set({value : fnFixNull(store.getAt(rowIndex).data.DEPT_NAME)}				, false);  // 부서명
	Ext.get('dept_code').set({value : fnFixNull(store.getAt(rowIndex).data.DEPT_CODE)}				, false);  // 부서코드
	Ext.get('high_dept_code').set({value : fnFixNull(store.getAt(rowIndex).data.HIGH_DEPT_CODE)}	, false);  // 상위부서코드
	Ext.get('high_dept_name').set({value : fnFixNull(store.getAt(rowIndex).data.HIGH_DEPT_NAME)}	, false);  // 상위부서
	Ext.get('ref_code').set({value : fnFixNull(store.getAt(rowIndex).data.REF_CODE)}				, false);  // 참조코드
	
	var dForm = document.detailForm;
	var useYn         = fnFixNull(store.getAt(rowIndex).data.USE_YN);		   // 사용여부
	
	// 사용여부
	if(useYn == 'Y'){
		 dForm.use_yn[0].checked = true;
	}else if(useYn == 'N'){
		 dForm.use_yn[1].checked = true;
	}
	
	/***** 필드 비활성화 *****/
	dForm.dept_code.readOnly 		   = true;			  // 부서코드
	Ext.get('saveBtn').dom.disabled    = true;
	Ext.get('updateBtn').dom.disabled  = false;
}   

/***************************************************************************
 * 설  명 : 필드 초기화
 **************************************************************************/
function fnInitValue(){
	var dForm = document.detailForm;			// 상세 FORM	
	
	dForm.reset();								// 상세필드 초기화
	dForm.dept_code.readOnly 		   = false;	// 부서코드
	Ext.get('saveBtn').dom.disabled    = false;
	Ext.get('updateBtn').dom.disabled  = true;
	dForm.use_yn[0].checked = true;
}

/***************************************************************************
 * 설  명 : 검색
 **************************************************************************/
function fnSearch(){  	
	
	Ext.Ajax.request({   
		url: "/com/dept/result.sg"
		,method : 'POST'   
		,success: function(response){						// 조회결과 성공시
					// 조회된 결과값, store명
					handleSuccess(response,GridClass_1st);
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

	Ext.Ajax.request({   
		url: "/com/dept/deptRegProc.sg"   
		,success: function(response){						// 조회결과 성공시
					// 조회된 결과값, store명
					handleSuccess(response,GridClass_1st,'save');
		          }
		,failure: handleFailure   	    // 조회결과 실패시  
		,form   : document.detailForm   // 상세 FORM
		,params : {					    // 조회조건을 DB로 전송하기위해서 조건값 설정
				  // 페이지정보
					limit          : limit_1st
			  	  , start          : start_1st
				  // 검색정보
				  , src_dept_name  : Ext.get('src_dept_name').getValue()
			  	  , src_dept_level : Ext.get('src_dept_level').getValue()
			  	  , src_use_yn     : Ext.get('src_use_yn').getValue()
				  }  		
	});  
	
	fnInitValue(); // 상세필드 초기화
		
}  		

/***************************************************************************
 * Event 및 필드 validation 설정
 ***************************************************************************/
// ExtJS 진입함수
Ext.onReady(function() {

	var dForm = document.detailForm;
	var sForm = document.searchForm;
	
	//검색하기 버튼 
	Ext.get('searchBtn').on('click', function(e){	
		fnSearch()
	});	
		
	//조건해제 버튼 -> 검색조건 초기화
	Ext.get('searchClearBtn').on('click', function(e){
		sForm.reset();
		fnSearch();
	});	
			
	//신규 버튼 -> 상세필드 초기화
	Ext.get('detailClearBtn').on('click', function(e){
		fnInitValue();		   
	});		
			
	//등록 버튼 -> 데이터를 server로 전송
	Ext.get('saveBtn').on('click', function(e){	
		if(fnValidation()){
			Ext.MessageBox.confirm('Confirm', '저장하시겠습니까?', showResult);
		};
		
	});
	
	//수정 버튼 -> 데이터를 server로 전송
	Ext.get('updateBtn').on('click', function(e){	
		if(fnValidation()){
			Ext.MessageBox.confirm('Confirm', '수정하시겠습니까?', showResult);
		};	
	});
	
	// 부서레벨 명이 초기화되면 부서레벨코드값도 초기화
    Ext.get('dept_level_name').on('change', function(){
        var val  = dForm.dept_level_name.value;
		
		if(val == "" || val.length == 0){
			dForm.dept_level.value = "";
		}
    });
    	
	//상위부서코드 검색팝업
	Ext.get('highDeptCodeBtn').on('click', function(e){
		
		//var deptLevel = Ext.get('dept_level').getValue();
		
		//if(deptLevel.length == 0){
		//	Ext.Msg.alert('확인', '부서레벨을 입력해주세요.'); 
		//}else{
			//fnPop('high_dept_code','high_dept_name',deptLevel);
			param = "";
			searchHighDeptp(param);
		//}
	});
	
	Ext.get('high_dept_name').on('click', function(e){
		var deptLevel = Ext.get('dept_level').getValue();
		
		//if(deptLevel.length == 0){
		//	Ext.Msg.alert('확인', '부서레벨을 입력해주세요.'); 
		//}else{
			//fnPop('high_dept_code','high_dept_name',deptLevel);
			param = "";
			searchHighDeptp(param);
		//}
	});
	
	// 상위부서 명이 초기화되면 상위부서코드값도 초기화
	Ext.get('high_dept_name').on('change', function(e){	

		var val  = dForm.high_dept_name.value;
		
		if(val == "" || val.length == 0){
			dForm.high_dept_code.value = "";
		}
	});
	
	fnInitValue(); // 상세필드 초기화
 });
	
// 저장, 수정버튼 클릭시 '예','아니오' 
function showResult(btn){
   	if(btn == 'yes'){
   		fnSave();
   	}    	
};

function checkNumber(str) { 

	var val = "";
	
    if (str.length > 0) { 
        for (i = 0; i < str.length; i++) {  
            if (str.charAt(i) >= "0" && str.charAt(i) <= "9") { 
                val += str.charAt(i); 
            } 
        } 
    } 
    return val;
} 

/***************************************************************************
 * 설  명 : 그리드의 페이지 클릭시 검색조건값을 DB로 전송
 ***************************************************************************/
function searchHighDeptp(param){
	var sURL      = "/com/dept/deptPop.sg"+param;
	var dlgWidth  = 416;
	var dlgHeight = 356;
	var winName   = "부서레벨";
	fnOpenPop(sURL, dlgWidth, dlgHeight, winName);
}

function fnDeptPopValue(records, fieldName){
	// 전송받은 값이 한건일 경우
    var record = records[0].data;				

    Ext.get('high_dept_name').set({value:fnFixNull(record.DEPT_NAME)} , false);
    Ext.get('high_dept_code').set({value:fnFixNull(record.DEPT_CODE)} , false);
}
<%--
function searchHighDeptp(fieldCode,fieldName,fieldValue){
	var targetUrl = "/com/dept/deptPop.sg"
	searchPanel.toggleCollapse();
	searchPanel.remove();
	searchPanel.load({
		url: targetUrl,
		params:{
			fieldCode: fieldCode,
			fieldName: fieldName,
			fieldValue: fieldValue
		},
		scripts:true,
		nocache: true,
		text: "Loading..."
	});
}
--%>
// 팝업
function fnOpenPop(sURL, dlgWidth, dlgHeight, winName){
  var xPos=(window.screen.width) ? (window.screen.width-dlgWidth)/2 : 0;
  var yPos=(window.screen.height) ? (window.screen.height-dlgHeight)/2 : 0;
  var sFeatures = "titlebar=no, scrollbars=yes,location=no ,menubar=no, resizable=yes, status=yes, width="+dlgWidth+",height="+dlgHeight+",left="+xPos+", top="+yPos;
  window.open(sURL,winName, sFeatures);
}

/***************************************************************************
 * 설  명 : 그리드의 페이지 클릭시 검색조건값을 DB로 전송
 ***************************************************************************/
function fnPagingValue_1st(){
	var sForm = document.searchForm;
	
	try{
		GridClass_1st.store.setBaseParam('start'		 	 ,start_1st);
    	GridClass_1st.store.setBaseParam('limit'		 	 ,limit_1st);
    	GridClass_1st.store.setBaseParam('src_dept_level'    ,Ext.get('src_dept_level').getValue());
    	GridClass_1st.store.setBaseParam('src_dept_name'     ,Ext.get('src_dept_name').getValue());
    	GridClass_1st.store.setBaseParam('src_use_yn'        ,Ext.get('src_use_yn').getValue());
   		GridClass_1st.store.setBaseParam('div'				 ,'grid_page');
	}catch(e){

	}
}

function fnValidation(){
	
	var dept_code = Ext.get('dept_code').getValue();			// 부서코드
	var dept_name = Ext.get('dept_name').getValue(); 			// 부서명
	var dept_level = Ext.get('dept_level').getValue(); 			// 부서레벨
	var high_dept_code = Ext.get('high_dept_code').getValue();	// 상위부서코드
	var dept_name_len = getByteLength(dept_name);	
	
	if(dept_code.length == 0 || dept_code == ""){
		Ext.Msg.alert('확인', '부서코드를 입력해주세요.')
		return false;
	}else if(dept_code.length > 0 && dept_code.length < 5){
		Ext.Msg.alert('확인', '부서코드는 5자리를 입력해주세요.')
		return false;
	}
	
	if(dept_name.length == 0 || dept_name == ""){
		Ext.Msg.alert('확인', '부서명을 입력해주세요.')
		return false;
	}
	
	if(dept_name_len > 30){
		Ext.Msg.alert('확인', '부서명은 한글 15자까지 입력가능합니다.')
		return false;
	}
	
	if(dept_level.length == 0 || dept_level == ""){
		Ext.Msg.alert('확인', '부서레벨을 선택해주세요.')
		return false;
	}
	
	if(high_dept_code.length == 0 || high_dept_code == ""){
		Ext.Msg.alert('확인', '상위부서코드를 입력해주세요.')
		return false;
	}
	
	return true;
	
}
</script>

</head>
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
									<span id="ext-gen8" class="x-panel-header-text">부서정보 검색</span>
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
												<label class="x-form-item-label" style="width: auto;" for="src_dept_name">부서명 :</label>
												<div style="padding-left: 30px;" class="x-form-element">
													<input type="text" name="src_dept_name" id="src_dept_name" autocomplete="off" size="15" class="x-form-text x-form-field" style="width: auto;">
												</div>
											</div>
										</td>
										
										<td width="25%">
											<div tabindex="-1" class="x-form-item " >
												<label class="x-form-item-label" style="width: auto;" for="src_dept_level" >부서레벨 :</label>
												<div style="padding-left: 30px;" class="x-form-element">
													<select name="src_dept_level" id="src_dept_level" style="width: 100px;" type="text" class=" x-form-select x-form-field" >
														<option value="">전체</option>
														<c:forEach items="${DEPT_LEVEL_CODE}" var="data" varStatus="status">
														<option value="${data.COM_CODE}"><c:out value="${data.COM_CODE_NAME}"/></option>
														</c:forEach>
													</select>
												</div>
											</div>
										</td>
										
										<td width="25%">
											<div tabindex="-1" class="x-form-item " >
												<label class="x-form-item-label" style="width: auto;" for="src_use_yn" >사용여부 :</label>
												<div style="padding-left: 80px;" class="x-form-element">
													<select name="src_use_yn" id="src_use_yn" title="사용여부" style="width: 29%;" type="text" class=" x-form-select x-form-field" >
														<option value="">전체</option>
														<c:forEach items="${YESNO_CODE}" var="data" varStatus="status">
														<option value="${data.COM_CODE}"><c:out value="${data.COM_CODE_NAME}"/></option>
														</c:forEach>
													</select>
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
				<div id="user-grid" style="margin-top: 0em;"></div><%-- 0em <- 1em으로 수정하면 상위 공백 --%><!----------------- 그리드명을 동일하게 설정 ----------------->		
			</td>
			<!------------------------------ GRID END ------------------------------------>
			<td width="60%" valign="top">
				<div class=" x-panel x-form-label-left" style="margin-top: 0em; width: 100%;"><%-- 0em <- 1em으로 수정하면 상위 공백 --%>
					<!----------------- SEARCH Hearder Start	 ----------------->
					<div class="x-panel-tl">
						<div class="x-panel-tr">
							<div class="x-panel-tc">
								<div class="x-panel-header x-unselectable" style="-moz-user-select: none;">
									<span class="x-panel-header-text">부서 정보</span><!----------------- 이름변경 ----------------->		
								</div>
							</div>
						</div>
					</div>
					<!----------------- SEARCH Hearder End	 ----------------->
					<div class="x-panel-bwrap">
						<div class="x-panel-ml">
							<div class="x-panel-mr">
								<div class="x-panel-mc" >
									<!-- 폼 시작 -->
									<form id="detailForm" name="detailForm" method="POST" class="x-panel-body x-form" style="padding: 1px 1px 0pt; width: 480px;">
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
										<div class=" x-panel x-column" style="width: 50%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label class="x-form-item-label" style="width: auto;" for="dept_code" ><font color="red">* </font>부서코드 :</label>
														<div style="padding-left: 94px;" class="x-form-element">
															<input type="text" name="dept_code" id="dept_code" autocomplete="off" size="20" class=" x-form-text x-form-field" style="width: auto;" maxlength="5"/>
															<input type="hidden" id="flag" name="flag" style="width:80px"/>
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
														<label class="x-form-item-label" style="width: auto;" for="dept_name" ><font color="red">* </font>부서명 :</label>
														<div style="padding-left: 74px;" class="x-form-element">
															<input type="text" name="dept_name" id="dept_name" autocomplete="off" size="22" class=" x-form-text x-form-field" style="width: auto;"/>
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
														<label class="x-form-item-label" style="width: auto;" for="dept_level_name" ><font color="red">* </font>부서레벨 :</label>
														<div style="padding-left: 94px;" class="x-form-element">
														<select name="dept_level" id="dept_level" style="width: 51%;" type="text" class=" x-form-select x-form-field" >
															<option value="">전체</option>
															<c:forEach items="${DEPT_LEVEL_CODE}" var="data" varStatus="status">
															<option value="${data.COM_CODE}"><c:out value="${data.COM_CODE_NAME}"/></option>
															</c:forEach>
														</select>
<%--															<table style="width: 100px;" cellspacing="0" class="x-btn  x-btn-noicon">--%>
<%--																<tr>--%>
<%--																	<td>--%>
																		<input type="hidden" name="dept_level_name" id="dept_level_name" title="부서레벨" autocomplete="off" size="13" class="x-form-text x-form-field " style="width: auto;">
<%--																		<input type="hidden" id="dept_level" name="dept_level" style="width:80px"/>--%>
<%--																	</td>--%>
<%--																	<td>--%>
<%--																		 Button Start--%>
<%--																		<table cellspacing="0" class="x-btn  x-btn-noicon" style="width: 20px;" align="right">--%>
<%--																			<tbody class="x-btn-small x-btn-icon-small-left">--%>
<%--																				<tr>--%>
<%--																					<td class="x-btn-tl">--%>
<%--																						<i>&nbsp;</i>--%>
<%--																					</td>--%>
<%--																					<td class="x-btn-tc">--%>
<%--																					</td>--%>
<%--																					<td class="x-btn-tr">--%>
<%--																						<i>&nbsp;</i>--%>
<%--																					</td>--%>
<%--																				</tr>--%>
<%--																				<tr>--%>
<%--																					<td class="x-btn-ml">--%>
<%--																						<i>&nbsp;</i>--%>
<%--																					</td>--%>
<%--																					<td class="x-btn-mc">--%>
<%--																						<em unselectable="on" class="">--%>
<%--																							<button type="button" id="deptLevelBtn" name="deptLevelBtn" class=" x-btn-text">검색</button>--%>
<%--																						</em>--%>
<%--																					</td>--%>
<%--																					<td class="x-btn-mr">--%>
<%--																						<i>&nbsp;</i>--%>
<%--																					</td>--%>
<%--																				</tr>--%>
<%--																				<tr>--%>
<%--																					<td class="x-btn-bl">--%>
<%--																						<i>&nbsp;</i>--%>
<%--																					</td>--%>
<%--																					<td class="x-btn-bc">--%>
<%--																					</td>--%>
<%--																					<td class="x-btn-br">--%>
<%--																						<i>&nbsp;</i>--%>
<%--																					</td>--%>
<%--																				</tr>--%>
<%--																			</tbody>--%>
<%--																		</table>--%>
<%--																		 Button End--%>
<%--																	</td>--%>
<%--																</tr>--%>
<%--															</table>--%>
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
														<label class="x-form-item-label" style="width: auto;" for="ref_code" >&nbsp;&nbsp;&nbsp;참조코드 :</label>
														<div style="padding-left:74px;" class="x-form-element">
															<input type="text" name="ref_code" id="ref_code" autocomplete="off" size="22" class=" x-form-text x-form-field" style="width: auto;" maxlength="20"/>
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
														<label class="x-form-item-label" style="width: auto;" for="high_dept_name" ><font color="red">* </font>상위부서코드 :</label>
														<div style="padding-left: 85px;" class="x-form-element">
															<table style="width: 125px;" cellspacing="0" class="x-btn  x-btn-noicon" border="0">
																<tr>
																	<td>
																		<input type="text" name="high_dept_name" id="high_dept_name" title="상위부서코드" autocomplete="off" size="16" class="x-form-text x-form-field " style="width: auto;"/>
																		<input type="hidden" id="high_dept_code" name="high_dept_code" style="width:80px"/>
																	</td>
																	<td>
																		<%-- Button Start--%>
																		<div style="padding-left: 1px;" >
																			<img align="center" id="highDeptCodeBtn" name="highDeptCodeBtn" alt="" src="/resource/images/bass_1st/icon_src1.gif" style="cursor: hand;">
																		</div>
																		<%-- Button End--%>
																	</td>
																</tr>
															</table>
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
														<input type="radio" name="use_yn" id="use_yn1" autocomplete="off" class=" x-form-radio x-form-field" value="Y">
													    <label class="x-form-cb-label" for="use_yn2" >Yes</label>
													    <input type="radio" name="use_yn" id="use_yn2" autocomplete="off" class=" x-form-radio x-form-field" value="N">
													    <label class="x-form-cb-label" for="use_yn2" >No</label>
														<div class="x-form-clear-left">
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>
									<!-- DETAIL 4_ROW End -->
									
									<!-- DETAIL 5_ROW Start -->
									<div class="x-column-inner" style="width: 100%;  margin-top: 22em;">
										<div class=" x-panel x-column" style="width: 100%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														
													</div>
												</div>
											</div>
										</div>
									</div>
									<!-- DETAIL 5_ROW End -->
																	
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