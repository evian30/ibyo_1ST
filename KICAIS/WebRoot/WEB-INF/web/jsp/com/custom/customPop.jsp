<%--
  Class Name  : deptPop.jsp
  Description : 부서조회 팝업
  Modification Information
 
      수정일                수정자                 수정내용
  -------      --------    ---------------------------
  2011. 3. 8.  고기범              최초 생성
 
  author   : 고기범
  since    : 2011. 3. 8.
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
<script type="text/javascript" src="/resource/common/js/grid/grid_2nd.js"></script>
<%
	String fieldName = request.getParameter("fieldName");	// 부모창의 컬럼명
	String fieldCode = request.getParameter("fieldCode");	// 부모창의 컬럼코드명
	String customType = request.getParameter("customType");	// 부모창의 컬럼코드명(거래처구분)
	String bizNum = request.getParameter("bizNum");			// 부모창의 컬럼코드명(사업자번호)
	String form = request.getParameter("form");				// 부모창의 form명
	
	String openerGridName = request.getParameter("grid_name");				// 부모창의 그리드 이름
	String openerGridRow  = request.getParameter("grid_row");				// 그리드의 row index;
	String openerGridFeildName = request.getParameter("grid_fieldName");	// 그리드의 row의 fieldName
	
%>
<script type="text/javascript">
/***************************************************************************
 * 초기값 설정
 ***************************************************************************/
var	gridHeigth_2nd 	 	= 270; 									// 그리드 전체 높이
var	gridWidth_2nd		= 399;									// 그리드 전체 폭
var gridTitle_2nd 		= "부서정보관리";							// 그리드 제목
var	render_2nd			= "user-grid";	        				// 렌더(화면에 그려질) 할 id 
var	pageSize_2nd		= 10;	  								// 그리드 페이지 사이즈	
var	proxyUrl_2nd		= "/com/custom/customPopList.sg";  		// 결과 값 페이지
var limit_2nd			= pageSize_2nd;
var start_2nd			= 0;

/***************************************************************************
 * Grid의 컬럼 설정
 ***************************************************************************/
var userColumns_2nd =  [ {header: "거래처코드", 		width: 50,  sortable: true, dataIndex: 'CUSTOM_CODE', 	  editor: new Ext.form.TextField({})}                                                    
				       , {header: "거래처명",  		width: 100, sortable: true, dataIndex: 'CUSTOM_NAME', 	  editor: new Ext.form.TextField({})}                  
				       , {header: "거래처구분",  		width: 100, sortable: true, dataIndex: 'CUSTOM_TYPE', 	  editor: new Ext.form.TextField({}) ,hidden : true} 
				       , {header: "사업자번호",  		width: 100, sortable: true, dataIndex: 'BIZ_NUM',    	  editor: new Ext.form.TextField({}) ,hidden : true} 
				       ];	 

/***************************************************************************
 * 그리드 결과매핑 
 ***************************************************************************/
var mappingColumns_2nd = [ {name: 'CUSTOM_CODE' 	    , allowBlank: false} // 부서레벨코드     
					     , {name: 'CUSTOM_NAME' 	    , allowBlank: false} // 부서명  
					     , {name: 'CUSTOM_TYPE' 	    , allowBlank: false} // 거래처구분
					     , {name: 'BIZ_NUM' 	        , allowBlank: false} // 사업자번호
				         ];
 
/***************************************************************************
 * 그리드 클릭시 Event
 ***************************************************************************/
function fnGridOnClick_2nd(store, rowIndex){

	// 선택된 레코드에서 데이타 가져오기
	var form = document.detailForm;
	<%if(fieldCode != null){%>
	var openerForm = opener.<%=form%>;
	var biz_num = '<%=bizNum%>';
	<%}%>
	
	var customCode = fnFixNull(store.getAt(rowIndex).data.CUSTOM_CODE); // 거래처코드
	var customName = fnFixNull(store.getAt(rowIndex).data.CUSTOM_NAME); // 거래처명
	var customType = fnFixNull(store.getAt(rowIndex).data.CUSTOM_TYPE); // 거래처구분
	var bizNum     = fnFixNull(store.getAt(rowIndex).data.BIZ_NUM);     // 거래처명
	
	//그리드에서 팝업을 호출한 것임
	var openerGridName = '<%= openerGridName %>';
	
	if(openerGridName != 'null'){
		<% if(openerGridName != null){%>
			var openerStore = opener.<%= openerGridName %>.store;
			var openerRecored = openerStore.getAt(<%=openerGridRow%>);
			openerRecored.set('CUSTOM_CODE', customCode);
			openerRecored.set('CUSTOM_NAME', customName)
		<%}%>
	}else{
		<%if(fieldCode != null){%>
		openerForm.<%=fieldCode%>.value = customCode;
		openerForm.<%=fieldName%>.value = customName;
		
			<% if(bizNum != null && bizNum != ""){%>
			   	openerForm.<%=bizNum%>.value = bizNum;
			<%}%>
			
			<% if(customType != null && customType != ""){%>
			   	openerForm.<%=customType%>.value = customType;
			<%}%>
		<%}%>
	}

	window.close();
	
}   

/***************************************************************************
 * 함수명 : fnSearch
 * 설  명 : 검색
***************************************************************************/
function fnSearch(){  	
	
	Ext.Ajax.request({   
		url: "/com/custom/customPopList.sg"
		,method : 'POST'   
		,success: function(response){						// 조회결과 성공시
					// 조회된 결과값, store명
					handleSuccess(response,GridClass_2nd);
		          }
		,failure: handleFailure   		// 조회결과 실패시  
		,form   : document.searchForm	// 검색 Form
		,params : {						// 조회조건을 DB로 전송하기위해서 조건값 설정
					
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
		
		var search_div = Ext.get('search_div').getValue();
		if(search_div == ""){
			Ext.Msg.alert('알림', '검색조건을 선택해주세요.');
			Ext.get('search_div').dom.Focus();
		}else{
        	fnSearch()
        }
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
function fnPagingValue_2nd(){
	var sForm = document.searchForm;
	
	try{
    	GridClass_2nd.store.setBaseParam('search_div', sForm.search_div.value);
    	GridClass_2nd.store.setBaseParam('search_val', sForm.search_val.value);
    	GridClass_2nd.store.setBaseParam('div', 'grid_page');
	}catch(e){

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
						    			<td width="12%">
											<div tabindex="-1" class="x-form-item " >
												<div style="padding-left: 0px;" class="x-form-element">
													<select id="search_div" name="search_div" style="width: 100px;" type="text" class="x-form-select x-form-field">
														<option value="">선택하세요</option>
														<option value="custom_name">거래처명</option>
														<option value="custom_code">거래처코드</option>
													</select>	
												</div>
											</div>
										</td>
										<td width="32%">
											<div tabindex="-1" class="x-form-item " >
												<div style="padding-left: 0px;" class="x-form-element">
													<input type="text" id="search_val" name="search_val" autocomplete="off" size="22" class=" x-form-text x-form-field" style="width: auto;">
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