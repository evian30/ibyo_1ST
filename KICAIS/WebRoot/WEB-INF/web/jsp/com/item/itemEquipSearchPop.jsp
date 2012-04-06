<%--
  Class Name  : itemEquipSearchPop.jsp
  Description : 아이템(장비-제품이 아닌것) 검색 팝업
  Modification Information
 
      수정일                수정자                 수정내용
  -------      --------    ---------------------------
  2011. 4. 11.  이준영              최초 생성
 
  author   : 이준영
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

<script type="text/javascript" src="/resource/common/js/grid/grid_2nd.js"></script>
<!-- EXTJS APP SCRIPT -->
<script type="text/javascript" src="/resource/common/js/common/App.js"></script>
<script type="text/javascript" src="/resource/common/js/sgis-comm-inc.js"></script>

<%
	String openerGridName = request.getParameter("grid_name");	// 부모창의 그리드 이름
	String openerGridRow = request.getParameter("grid_row");	// 그리드의 row index;
%>
<script type="text/javascript">
/***************************************************************************
 * 초기값 설정
 ***************************************************************************/
var	gridHeigth_2nd 	 	= 270; 									// 그리드 전체 높이
var	gridWidth_2nd		= 399;									// 그리드 전체 폭
var gridTitle_2nd 		= "장비조회결과";							// 그리드 제목
var	render_2nd			= "user-grid";	        				// 렌더(화면에 그려질) 할 id 
var	pageSize_2nd		= 10;	  								// 그리드 페이지 사이즈	
var	proxyUrl_2nd		= "/com/item/itemEquipPopList.sg";  		// 결과 값 페이지
var limit_2nd			= pageSize_2nd;
var start_2nd			= 0;

/***************************************************************************
 * Grid의 컬럼 설정
 ***************************************************************************/
var userColumns_2nd =  [ {header: "상태",		width: 100, sortable: true, dataIndex: 'FLAG', 			    editor: new Ext.form.TextField({}) , hidden : true} 
					    ,{header: "품목구분",		width: 60,  sortable: true, dataIndex: 'ITEM_TYPE', 		editor: new Ext.form.TextField({}) , hidden : true}
						,{header: "품목코드", 	width: 80, 	sortable: true, dataIndex: 'ITEM_CODE', 		editor: new Ext.form.TextField({}) }       
						,{header: "품목구분코드",	width: 60,  sortable: true, dataIndex: 'ITEM_TYPE_CODE', 	editor: new Ext.form.TextField({}) , hidden : true}                                                    
						,{header: "품목명", 		width: 60, 	sortable: true, dataIndex: 'ITEM_NAME', 		editor: new Ext.form.TextField({}) }                  
						,{header: "품목유형", 	width: 60,  sortable: true, dataIndex: 'ITEM_PATTERN',		editor: new Ext.form.TextField({}) , hidden : true}
						,{header: "품목유형코드",	width: 60,  sortable: true, dataIndex: 'ITEM_PATTERN_CODE',	editor: new Ext.form.TextField({}) , hidden : true}
						,{header: "단위", 		width: 50,  sortable: true, dataIndex: 'UNIT', 				editor: new Ext.form.TextField({}) , hidden : true}
						,{header: "소개", 		width: 50,  sortable: true, dataIndex: 'ITEM_INTRO', 		editor: new Ext.form.TextField({}) , hidden : true}
						,{header: "기능", 		width: 50,  sortable: true, dataIndex: 'ITEM_FUNCTION', 	editor: new Ext.form.TextField({}) , hidden : true}
						,{header: "규격", 		width: 50,  sortable: true, dataIndex: 'STANDARD', 			editor: new Ext.form.TextField({}) }
						,{header: "제원", 		width: 50,  sortable: true, dataIndex: 'SPEC', 				editor: new Ext.form.TextField({}) , hidden : true}
						,{header: "출시일", 		width: 50,  sortable: true, dataIndex: 'RELEASE_DATE', 		editor: new Ext.form.TextField({}) , hidden : true}
						,{header: "버전", 		width: 50,  sortable: true, dataIndex: 'ITEM_VERSION', 		editor: new Ext.form.TextField({}) }
						,{header: "단가1", 		width: 50,  sortable: true, dataIndex: 'UNIT_PRICE_01', 	editor: new Ext.form.TextField({}) }  
						,{header: "단가2", 		width: 100, sortable: true, dataIndex: 'UNIT_PRICE_02', 	editor: new Ext.form.TextField({}) , hidden : true}  
						,{header: "단가3", 		width: 50,  sortable: true, dataIndex: 'UNIT_PRICE_03', 	editor: new Ext.form.TextField({}) , hidden : true}
						,{header: "단가4", 		width: 50,  sortable: true, dataIndex: 'UNIT_PRICE_04', 	editor: new Ext.form.TextField({}) , hidden : true}
						,{header: "단가5", 		width: 50,  sortable: true, dataIndex: 'UNIT_PRICE_05', 	editor: new Ext.form.TextField({}) , hidden : true}
						,{header: "최종변경자ID",	width: 50,  sortable: true, dataIndex: 'FINAL_MOD_ID', 		editor: new Ext.form.TextField({}) , hidden : true}
						,{header: "최종변경일시",	width: 50,  sortable: true, dataIndex: 'FINAL_MOD_DATE',	editor: new Ext.form.TextField({}) , hidden : true}
				       ];	 

/***************************************************************************
 * 그리드 결과매핑 
 ***************************************************************************/
var mappingColumns_2nd = [ 
								{name: 'FLAG' 		      ,allowBlank: false}  // 상태
							 , {name: 'ITEM_CODE' 		  ,allowBlank: false}  // 품목코드    
							 , {name: 'ITEM_TYPE_CODE' 	  ,allowBlank: false}  // 품목구분코드
							 , {name: 'ITEM_TYPE' 		  ,allowBlank: false}  // 품목구분
							 , {name: 'ITEM_NAME' 		  ,allowBlank: false}  // 품목명      
							 , {name: 'STANDARD' 		  ,allowBlank: false}  // 규격        
							 , {name: 'UNIT' 			  ,allowBlank: false}  // 단위        
							 , {name: 'SPEC' 			  ,allowBlank: false}  // 제원        
							 , {name: 'UNIT_PRICE_01' 	  ,allowBlank: false}  // 단가1       
							 , {name: 'UNIT_PRICE_02' 	  ,allowBlank: false}  // 단가2       
							 , {name: 'UNIT_PRICE_03' 	  ,allowBlank: false}  // 단가3       
							 , {name: 'UNIT_PRICE_04' 	  ,allowBlank: false}  // 단가4       
							 , {name: 'UNIT_PRICE_05' 	  ,allowBlank: false}  // 단가5       
							 , {name: 'RELEASE_DATE'   	  ,allowBlank: false}  // 출시일      
							 , {name: 'ITEM_VERSION' 	  ,allowBlank: false}  // 버전        
							 , {name: 'ITEM_PATTERN' 	  ,allowBlank: false}  // 품목유형
							 , {name: 'ITEM_PATTERN_CODE' ,allowBlank: false}  // 품목유형코드
							 , {name: 'ITEM_INTRO' 		  ,allowBlank: false}  // 품목소개    
							 , {name: 'ITEM_FUNCTION' 	  ,allowBlank: false}  // 품목기능    
							 , {name: 'FINAL_MOD_ID' 	  ,allowBlank: false}  // 최종변경자ID
							 , {name: 'FINAL_MOD_DATE' 	  ,allowBlank: false}  // 최종변경일시
				         ];

/***************************************************************************
 * 설  명 : 그리드의 페이지 클릭시 검색조건값을 DB로 전송
 ***************************************************************************/
function fnPagingValue_2nd(){
	var sForm = document.searchForm;
	
	try{
    	GridClass_2nd.store.setBaseParam('search_div', sForm.src_item_name.value);
    	GridClass_2nd.store.setBaseParam('div', 'grid_page');
		GridClass_2nd.store.setBaseParam('limit', limit_2nd);
		GridClass_2nd.store.setBaseParam('start', start_2nd);
		GridClass_2nd.store.setBaseParam('src_item_type_code', Ext.get('src_item_type_code').getValue());
	}catch(e){

	}
}

/***************************************************************************
 * 함수명 : fnSearch
 * 설  명 : 검색
***************************************************************************/
function fnSearch(){  	
	
	Ext.Ajax.request({   
		url: "/com/item/itemEquipPopList.sg"
		,method : 'POST'   
		,success: function(response){						// 조회결과 성공시
					// 조회된 결과값, store명
					handleSuccess(response,GridClass_2nd);
		          }
		,failure: handleFailure   		// 조회결과 실패시  
		,form   : document.searchForm	// 검색 Form
		,params : {						// 조회조건을 DB로 전송하기위해서 조건값 설정
					limit: limit_2nd,
					start: start_2nd
				  }				
	});  
} 
/***************************************************************************
 * 설  명 : 화면 초기설정
 ***************************************************************************/
// ExtJS 진입함수
Ext.onReady(function() {
	//검색하기 버튼 
	Ext.get('searchBtn').on('click', function(e){
		fnSearch()
	});	
	
	
});

/***************************************************************************
 * 그리드 클릭시 Event
 ***************************************************************************/
function fnGridOnClick_2nd(store, rowIndex){
	/*
	var itemCode = 'tempItem1';
	var itemName = '가상아이템1';
	
	var itemCode = fnFixNull(store.getAt(rowIndex).data.ITEM_CODE); // 품목 코드
	var itemName = fnFixNull(store.getAt(rowIndex).data.ITEM_NAME); // 품목 이름
	var itemStandard = fnFixNull(store.getAt(rowIndex).data.STANDARD); // 품목 이름
	var itemUnitPrice = fnFixNull(store.getAt(rowIndex).data.UNIT_PRICE_01); // 품목 이름
	
	//그리드에서 팝업을 호출한 것임
	//그리드에서 팝업을 호출한 것임
	var openerGridName = '<%= openerGridName %>';
	
	if(openerGridName != 'null'){
		<% if(openerGridName != null){%>
			var openerStore = opener.<%= openerGridName %>.store;
			var openerRecored = openerStore.getAt(<%=openerGridRow%>);
			openerRecored.set('ITEM_CODE', itemCode);
			openerRecored.set('ITEM_NAME', itemName);
			openerRecored.set('STANDARD', itemStandard);
			openerRecored.set('UNIT_PRICE', itemUnitPrice);
		<%}%>
	}
	*/
	//선택된 그리드의 
	var records = GridClass_2nd.grid.selModel.getSelections(); 
	
	window.opener.fnEquipSearchPopValue(records);
	window.close();

}
</script>

</head>
<body>
	<table border="0" width="400" height="200">
		<tr>
			<td colspan="2">
			
			<form name="searchForm" id="searchForm">
			<input type="hidden" id="src_item_type_code" name="src_item_type_code"  value="20"/>		<!-- 품목구분 ITEM_TYPE_CODE-20:제품 -->
			
			
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
										<td width="32%">
											<!-- 품목명 검색 시작-->
											<div tabindex="-1" class="x-form-item " >
												<label class="x-form-item-label" style="width: auto;" for="pur_date" >품목명 :</label>
												<div style="padding-left:80px;" class="x-form-element">
													<input type="text" name="src_item_name" id="src_item_name" autocomplete="off" class=" x-form-text x-form-field" style="width: auto;">
												</div>
												<div class="x-form-clear-left">
												</div>
											</div>
											<!-- 품목명 검색 시작-->
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