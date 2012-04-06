<%--
  Class Name  : employeePop.jsp
  Description : 담당자조회 팝업
  Modification Information
 
      수정일                수정자                 수정내용
  -------      --------    ---------------------------
  2011. 3. 8.  고기범              최초 생성
 
  author   : 고기범
  since    : 2011. 4. 11.
  version  : 1.0
   
  Copyright (C) 2011 by SG All right reserved.
--%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/web/jsp/common/inc/commonInc.jsp" %>
<!-- EXTJS CSS -->
<link rel="stylesheet" type="text/css" href="/resource/common/js/ext3/resources/css/ext-all.css" />
 
<!-- EXTJS SCRIPT  -->
<script type="text/javascript" src="/resource/common/js/ext3/adapter/ext/ext-base.js"></script>
<script type="text/javascript" src="/resource/common/js/ext3/ext-all-debug.js"></script>
<script type="text/javascript" src="/resource/common/js/ext3/src/locale/ext-lang-ko.js" charset="utf-8"></script>

<!-- EXTJS APP SCRIPT -->
<script type="text/javascript" src="/resource/common/js/common/App.js"></script>
<script type="text/javascript" src="/resource/common/js/sgis-comm-inc.js"></script>
<script type="text/javascript" src="/resource/common/js/grid/pop_grid_1st.js"></script>
<%
	String multiSelectYn = request.getParameter("multiSelectYn");	// 여러건 선택가능 여부
	String fieldName = request.getParameter("requestFieldName");
	String src_dept_code = request.getParameter("requestDeptCode");
%>
<script type="text/javascript">
/***************************************************************************
 * 초기값 설정
 ***************************************************************************/
var	gridHeigth_1st_pop 	 	= 300; 								  // 그리드 전체 높이
var	gridWidth_1st_pop		= 399;								  // 그리드 전체 폭
var gridTitle_1st_pop 		= "사원정보";	  				      // 그리드 제목
var	render_1st_pop			= "user-grid";	        			  // 렌더(화면에 그려질) 할 id 
var	pageSize_1st_pop		= 10;	  							  // 그리드 페이지 사이즈	
var	proxyUrl_1st_pop		= "/com/employee/employeePopList.sg"; // 결과 값 페이지
var limit_1st_pop			= pageSize_1st_pop;
var start_1st_pop			= 0;

/***************************************************************************
 * Grid의 컬럼 설정
 ***************************************************************************/
var userColumns_1st_pop =  [ checkSm,
							{header: "상태",		    width: 100, sortable: true, dataIndex: 'FLAG', 			editor: new Ext.form.TextField({}) , hidden : true},       
							{header: "사번", 		width: 60,  sortable: true, dataIndex: 'EMP_NUM' },                                                    
							{header: "주민등록번호", width: 100, sortable: true, dataIndex: 'SSN', 			editor: new Ext.form.TextField({}) , hidden : true},                  
							{header: "성명", 		width: 50,  sortable: true, dataIndex: 'KOR_NAME' , 	editor: new Ext.form.TextField({})},
							{header: "영어성명", 	width: 50,  sortable: true, dataIndex: 'ENG_NAME' , 	editor: new Ext.form.TextField({}) , hidden : true},                  
							{header: "한자성명",		width: 50,  sortable: true, dataIndex: 'CHN_NAME' , 	editor: new Ext.form.TextField({}) , hidden : true},  
							{header: "부서", 		width: 50,  sortable: true, dataIndex: 'DEPT_NAME' , 	editor: new Ext.form.TextField({}) },
							{header: "부서코드", 	width: 50,  sortable: true, dataIndex: 'DEPT_CODE' , 	editor: new Ext.form.TextField({}) , hidden : true},                  
							{header: "직위",			width: 50,  sortable: true, dataIndex: 'POSTION_NAME' , editor: new Ext.form.TextField({}) },  
							{header: "직위코드",		width: 50,  sortable: true, dataIndex: 'POSTION_CODE' , editor: new Ext.form.TextField({}) , hidden : true},  
							{header: "직책",			width: 50,  sortable: true, dataIndex: 'DUTY_NAME' , 	editor: new Ext.form.TextField({}) },   
							{header: "직책코드",		width: 50,  sortable: true, dataIndex: 'DUTY_CODE' , 	editor: new Ext.form.TextField({}) , hidden : true},   
							{header: "휴대폰", 		width: 40,  sortable: true, dataIndex: 'MOBILE' , 		editor: new Ext.form.TextField({}) , hidden : true},                                                      
							{header: "집전화번호",  	width: 100, sortable: true, dataIndex: 'TEL_HOME' , 	editor: new Ext.form.TextField({}) , hidden : true},  
							{header: "사내전화번호", width: 50,  sortable: true, dataIndex: 'TEL_OFFICE' , 	editor: new Ext.form.TextField({}) , hidden : true},
							{header: "E-MAIL", 		width: 50,  sortable: true, dataIndex: 'EMAIL' ,	 	editor: new Ext.form.TextField({}) , hidden : true},                  
							{header: "우편번호",		width: 50,  sortable: true, dataIndex: 'ZIPCODE' , 		editor: new Ext.form.TextField({}) , hidden : true},  
							{header: "주소", 		width: 50,  sortable: true, dataIndex: 'ADDR' , 		editor: new Ext.form.TextField({}) , hidden : true},                  
							{header: "주소상세",		width: 50,  sortable: true, dataIndex: 'ADDR_DETAIL' , 	editor: new Ext.form.TextField({}) , hidden : true},  
							{header: "사진이미지",	width: 50,  sortable: true, dataIndex: 'PHOTO_IMG' , 	editor: new Ext.form.TextField({}) , hidden : true},
							{header: "사진파일경로",	width: 50,  sortable: true, dataIndex: 'PHOTO_PATH' , 	editor: new Ext.form.TextField({}) , hidden : true},   
							{header: "사용여부", 	width: 50,  sortable: true, dataIndex: 'USE_YN' , 		editor: new Ext.form.TextField({}) , hidden : true},  
							{header: "최종변경자ID", width: 100, sortable: true, dataIndex: 'FINAL_MOD_ID' , editor: new Ext.form.TextField({}) , hidden : true},  
							{header: "최종변경일시", width: 50,  sortable: true, dataIndex: 'FINAL_MOD_DATE',editor: new Ext.form.TextField({}) , hidden : true},
							{header: "ID", 			width: 60,  sortable: true, dataIndex: 'ID' , hidden : true}
						    ];	 

/***************************************************************************
 * 그리드 결과매핑 
 ***************************************************************************/
var mappingColumns_1st_pop = [ 
							  {name: 'FLAG' 		  , allowBlank: false},     // 상태
							  {name: 'EMP_NUM' 		  , allowBlank: false},     // 사번               
							  {name: 'SSN' 			  , allowBlank: false},     // 주민등록번호           
							  {name: 'KOR_NAME' 	  , allowBlank: false},     // 한글성명          
							  {name: 'ENG_NAME' 	  , allowBlank: false},     // 영어성명          
							  {name: 'CHN_NAME' 	  , allowBlank: false},     // 한자성명          
							  {name: 'DEPT_NAME' 	  , allowBlank: false},     // 부서
							  {name: 'DEPT_CODE' 	  , allowBlank: false},     // 부서코드         
							  {name: 'POSTION_NAME'   , allowBlank: false},     // 직위
							  {name: 'POSTION_CODE'   , allowBlank: false},     // 직위코드         
							  {name: 'DUTY_NAME' 	  , allowBlank: false},     // 직책
							  {name: 'DUTY_CODE' 	  , allowBlank: false},     // 직책코드          
							  {name: 'MOBILE' 		  , allowBlank: false},     // 휴대폰              
							  {name: 'TEL_HOME' 	  , allowBlank: false},     // 집전화번호        
							  {name: 'TEL_OFFICE' 	  , allowBlank: false},     // 사내전화번호    
							  {name: 'EMAIL' 		  , allowBlank: false},     // E-MAIL               
							  {name: 'ZIPCODE' 		  , allowBlank: false},     // 우편번호           
							  {name: 'ADDR' 		  , allowBlank: false},     // 주소                  
							  {name: 'ADDR_DETAIL' 	  , allowBlank: false},     // 주소상세
							  {name: 'PHOTO_IMG' 	  , allowBlank: false},     // 사진이미지      
							  {name: 'PHOTO_PATH' 	  , allowBlank: false},     // 사진파일경로    
							  {name: 'USE_YN' 		  , allowBlank: false},     // 사용여부            
							  {name: 'FINAL_MOD_ID'   , allowBlank: false},     // 최종변경자ID  
							  {name: 'FINAL_MOD_DATE' , allowBlank: false},     // 최종변경일시
							  {name: 'ID' 			  , allowBlank: false} 
					    	 ];
 
/***************************************************************************
 * 그리드 클릭시 Event
 ***************************************************************************/
function fnGridOnClick_1st_pop(store, rowIndex){

}   

/***************************************************************************
 * 함수명 : fnSearch
 * 설  명 : 검색
***************************************************************************/
function fnSearch(){  	
	
	Ext.Ajax.request({   
		url: "/com/employee/employeePopList.sg"
		,method : 'POST'   
		,success: function(response){						// 조회결과 성공시
					// 조회된 결과값, store명
					handleSuccess(response,GridClass_1st_pop);
		          }
		,failure: handleFailure   		// 조회결과 실패시  
		,form	: document.searchForm
		,params : {						// 조회조건을 DB로 전송하기위해서 조건값 설정
				  start 	    : start_1st_pop
    			, limit         : limit_1st_pop
    			//, src_kor_name  : Ext.get('src_kor_name').getValue()
    	        //, src_dept_name : Ext.get('src_dept_name').getValue()
    	        , src_dept_code : '<%=src_dept_code%>'
				  }				
	});  
}  		

/***************************************************************************
 * 설  명 : 화면 초기설정
 ***************************************************************************/
// ExtJS 진입함수
Ext.onReady(function() {
	
	// 검색버튼 클릭
	Ext.get('searchBtn').on('click', function(e){
        fnSearch()	
    });
	
	// 검색버튼 클릭
	Ext.get('searchClearBtn').on('click', function(e){
        document.searchForm.reset();
        fnSearch();
    });
	
	
});

/***************************************************************************
 * 설  명 : 그리드의 페이지 클릭시 검색조건값을 DB로 전송
 ***************************************************************************/
function fnPagingValue_1st_pop(){
	var sForm = document.searchForm;
	
	try{
		GridClass_1st_pop.store.setBaseParam('start'		  ,start_1st_pop);
    	GridClass_1st_pop.store.setBaseParam('limit'		  ,limit_1st_pop);
    	GridClass_1st_pop.store.setBaseParam('src_kor_name'	  ,Ext.get('src_kor_name').getValue());
    	GridClass_1st_pop.store.setBaseParam('src_dept_name'  ,Ext.get('src_dept_name').getValue());
    	
    	GridClass_1st_pop.store.setBaseParam('src_dept_code',"<%=src_dept_code%>");
	}catch(e){

	}
}

function fnSelectPopUpGridRow1st(){
	
	//선택된 그리드의 
	var records = GridClass_1st_pop.grid.selModel.getSelections(); 
	var multiSelectYn = '<%=multiSelectYn%>';
	
	//alert(records.length +" : "+multiSelectYn);
	
	if(records.length == 0){
		Ext.Msg.alert('확인', '선택된 자료가 없습니다.');
		return false;
	}else if(records.length > 1 && (multiSelectYn != 'Y' || multiSelectYn == 'null')){
		Ext.Msg.alert('확인', '1행 이상 선택할수 없습니다.');
		return false;
	}else{	
		window.opener.fnEmployeePopValue(records, '<%= fieldName%>');
		window.close();
	}
}

function fnRowSelectPop1st(SelectionModel,rowIndex, record){
}

function fnRowdeSelectPop1st(SelectionModel,rowIndex, record){
}
</script>

</head>
<body>
	<table border="0" width="400" height="200">
		<tr>
			<td colspan="2">
			
			<form name="searchForm" id="searchForm">

				<!----------------- SEARCH Hearder Start	 ----------------->
				<div id="ext-comp-1002" class=" x-panel x-form-label-left"><%-- 0em <- 1em으로 수정하면 상위 공백 --%>
					<div class="x-panel-tl">
						<div class="x-panel-tr">
							<div class="x-panel-tc">
								<div id="ext-gen4" class="x-panel-header x-unselectable" style="-moz-user-select: none;">
									
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
						    			<td width="50%">
											<div tabindex="-1" class="x-form-item " >
												<label class="x-form-item-label" style="width: auto;" for="src_dept_name" >부서명 :</label>
												<div style="padding-left: 0px;" class="x-form-element">
													<input type="text" id="src_dept_name" name="src_dept_name" autocomplete="off" size="18" class=" x-form-text x-form-field" style="width: auto;" 
													<%if(fieldName.equals("src_scd_day_reg_emp_name")){%> 
														<c:choose>
															<c:when test="${(getAuthority == '팀장' || getAuthority == '팀장대행') && emp_num != '30198'}">value="${dept_nm}" readonly="readonly"</c:when>
														</c:choose>
													<%} %>
													/>
												</div>
											</div>
										</td>
										<td width="50%">
											<div tabindex="-1" class="x-form-item " >
												<label class="x-form-item-label" style="width: auto;" for="src_kor_name" >사원명 :</label>
												<div style="padding-left: 0px;" class="x-form-element">
													<input type="text" id="src_kor_name" name="src_kor_name" autocomplete="off" size="18" class=" x-form-text x-form-field" style="width: auto;">
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
			<!----------------- GRID START ----------------->
			<td width="50%" valign="top">
				<div id="user-grid"></div>
			</td>
			<!----------------- GRID END ----------------->
		</tr>
	</table>
</body>

<%@ include file="/WEB-INF/web/jsp/sgis-bottom-inc.jsp" %>