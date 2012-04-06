<%--
  Class Name  : deptPop.jsp
  Description : 부서조회 팝업
  Modification Information
 
      수정일                수정자                 수정내용
  -------      --------    ---------------------------
  2011. 3. 8.  고기범              최초 생성
  2011. 3. 25    고기범	     디자인 변경 및 공통적용
 
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
<script type="text/javascript" src="/resource/common/js/grid/pop_grid_1st.js"></script>
<%
	String multiSelectYn = request.getParameter("multiSelectYn");	// 여러건 선택가능 여부
	String fieldName = request.getParameter("requestFieldName");
	String fieldValue = request.getParameter("fieldValue");
%>
<script type="text/javascript">
/***************************************************************************
 * 초기값 설정
 ***************************************************************************/
var	gridHeigth_1st_pop 	 	= 260; 								  // 그리드 전체 높이
var	gridWidth_1st_pop		= 399;								  // 그리드 전체 폭
var gridTitle_1st_pop 		= "부서정보관리";	  				  // 그리드 제목
var	render_1st_pop			= "user-grid";	        			  // 렌더(화면에 그려질) 할 id 
var	pageSize_1st_pop		= 8;	  							  // 그리드 페이지 사이즈	
var	proxyUrl_1st_pop		= "/com/dept/deptPopList.sg"; 		  // 결과 값 페이지
var limit_1st_pop			= pageSize_1st_pop;
var start_1st_pop			= 0;

/***************************************************************************
 * Grid의 컬럼 설정
 ***************************************************************************/
var userColumns_1st_pop =  [checkSm 
							, {header: "부서코드", 		width: 50,  sortable: true, dataIndex: 'DEPT_CODE', 	  editor: new Ext.form.TextField({})}                                                    
				   			, {header: "부서명",  		width: 100, sortable: true, dataIndex: 'DEPT_NAME', 	  editor: new Ext.form.TextField({})}                  
				   			, {header: "부서레벨", 		width: 50,  sortable: true, dataIndex: 'DEPT_LEVEL_NAME', editor: new Ext.form.TextField({})}
				   	    	, {header: "부서레벨코드",		width: 50,  sortable: true, dataIndex: 'DEPT_LEVEL' , 	  editor: new Ext.form.TextField({}), hidden : true}
				   	   	    ];	 

/***************************************************************************
 * 그리드 결과매핑 
 ***************************************************************************/
var mappingColumns_1st_pop = [ {name: 'DEPT_LEVEL' 	    , allowBlank: false} // 부서레벨코드     
						     , {name: 'DEPT_NAME' 	    , allowBlank: false} // 부서명      
						     , {name: 'DEPT_CODE' 	    , allowBlank: false} // 부서코드     
						     , {name: 'DEPT_LEVEL_NAME' , allowBlank: false} // 부서레벨 
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
		url: "/com/dept/deptPopList.sg"
		,method : 'POST'   
		,success: function(response){						// 조회결과 성공시
					// 조회된 결과값, store명
					handleSuccess(response,GridClass_1st_pop);
		          }
		,failure: handleFailure   		// 조회결과 실패시  
		,form	: document.pop_searchForm
		,params : {						// 조회조건을 DB로 전송하기위해서 조건값 설정
				  start 	    : start_1st_pop
    			, limit         : limit_1st_pop
    			, search_level  : <%=fieldValue%>
				  }				
	});  
}  

/***************************************************************************
 * 설  명 : 화면 초기설정
 ***************************************************************************/
// ExtJS 진입함수
Ext.onReady(function() {
	
	// 검색버튼 클릭
	Ext.get('pop_searchBtn').on('click', function(e){
        fnSearch()	
    });
	
	// 초기화 클릭
	Ext.get('pop_searchClearBtn').on('click', function(e){
        document.pop_searchForm.reset();
        fnSearch();
    });
	
	Ext.get('pop_newReg').on('click', function(){
		alert("신규등록");
		var targetUrl = "/com/sgisCode/sgCodeRegPanel.sg"
		searchPanel.toggleCollapse();
		regPanel.toggleCollapse();
		regPanel.remove();
		regPanel.load({
			url: targetUrl,
			scripts:true,
			nocache: true,
			text: "Loading..."
		});
	});
});


/***************************************************************************
 * 설  명 : 그리드의 페이지 클릭시 검색조건값을 DB로 전송
 ***************************************************************************/
function fnPagingValue_1st_pop(){
	var sForm = document.pop_searchForm;
	
	try{
		GridClass_1st_pop.store.setBaseParam('start'		  ,start_1st_pop);
    	GridClass_1st_pop.store.setBaseParam('limit'		  ,limit_1st_pop);
    	GridClass_1st_pop.store.setBaseParam('search_div'	  ,Ext.get('search_div').getValue());
    	GridClass_1st_pop.store.setBaseParam('search_val'  	  ,Ext.get('search_val').getValue());
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
		window.opener.fnDeptPopValue(records, '<%= fieldName%>');
		window.close();
	}
}
</script>


</head>
<body>
	<table border="0" width="400" height="200">
		<tr>
			<td colspan="2">
				<!----------------- SEARCH START	 ----------------->
				<form name="pop_searchForm" id="pop_searchForm">
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
														<option value="dept_name">부서명</option>
														<option value="dept_code">부서코드</option>
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
																		<button type="button" id="pop_searchBtn" class=" x-btn-text">검색하기</button>
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
																		<button type="button" id="pop_searchClearBtn" class=" x-btn-text">조건해제</button>
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
																		<button type="button" id="pop_newReg" class=" x-btn-text">신규등록</button>
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
				<!----------------- SEARCH END	 ----------------->
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