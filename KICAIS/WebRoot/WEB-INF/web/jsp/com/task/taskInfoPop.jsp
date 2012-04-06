<%--
  Class Name  : taskInfoPop.jsp
  Description : 타스크조회 팝업
  Modification Information
 
      수정일                수정자                 수정내용
  -------      --------    ---------------------------
  2011. 3. 8.  이준영              최초 생성
 
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

<!-- EXTJS APP SCRIPT -->
<script type="text/javascript" src="/resource/common/js/common/App.js"></script>
<script type="text/javascript" src="/resource/common/js/sgis-comm-inc.js"></script>
<script type="text/javascript" src="/resource/common/js/grid/pop_grid_1st.js"></script>
<%
	String multiSelectYn = request.getParameter("multiSelectYn");	// 여러건 선택가능 여부
	String fieldName = request.getParameter("requestFieldName");
%>
<script type="text/javascript">

/***************************************************************************
 * 초기값 설정
 ***************************************************************************/
var	gridHeigth_1st_pop 	 	= 300; 								  // 그리드 전체 높이
var	gridWidth_1st_pop		= 399;								  // 그리드 전체 폭
var gridTitle_1st_pop 		= "타스크정보";	  				      // 그리드 제목
var	render_1st_pop			= "user-grid";	        			  // 렌더(화면에 그려질) 할 id 
var	pageSize_1st_pop		= 10;	  							  // 그리드 페이지 사이즈	
var	proxyUrl_1st_pop		= "/com/task/taskInfoPopList.sg"; // 결과 값 페이지
var limit_1st_pop			= pageSize_1st_pop;
var start_1st_pop			= 0;

/***************************************************************************
 * Grid의 컬럼 설정
 ***************************************************************************/
var userColumns_1st_pop =  [
							checkSm
						   ,{header: "상태",		    width: 100, sortable: true, dataIndex: 'FLAG', 			 hidden : true}       
						   ,{header: "그룹", 		width: 60,  sortable: true, dataIndex: 'TASK_GROUP_CODE',hidden : true}
						   ,{header: "그룹",     	width: 60,  sortable: true, dataIndex: 'TASK_GROUP_NAME1'}
						   ,{header: "그룹명",   	width: 60,  sortable: true, dataIndex: 'TASK_GROUP_NAME',hidden : true}
						   ,{header: "코드",  	    width: 60, sortable: true, dataIndex: 'TASK_CODE',hidden : true       }                  
						   ,{header: "타스크명",		width: 100,  sortable: true, dataIndex: 'TASK_NAME'       }
						   ,{header: "타스크설명",	width: 50,  sortable: true, dataIndex: 'TASK_DESC'}
						   ,{header: "순번",			width: 50,  sortable: true, dataIndex: 'TASK_INFO_SEQ',	 hidden : true}
						   ,{header: "비고",	  	    width: 50,  sortable: true, dataIndex: 'NOTE', 			 hidden : true}
						   ,{header: "사용여부", 		width: 50,  sortable: true, dataIndex: 'USE_YN', 		 hidden : true}  
						   ,{header: "최종변경자", 	width: 100, sortable: true, dataIndex: 'FINAL_MOD_ID', 		 hidden : true   }  
						   ,{header: "최종변경일", 	width: 50,  sortable: true, dataIndex: 'FINAL_MOD_DATE', 		 hidden : true }
						   ];	 

/***************************************************************************
 * 그리드 결과매핑 
 ***************************************************************************/
var mappingColumns_1st_pop = [ 
							  {name: 'FLAG' 		  , allowBlank: false}	// 상태
							 ,{name: 'TASK_GROUP_CODE', allowBlank: false}  // 타스크그룹코드  
							 ,{name: 'TASK_GROUP_NAME1', allowBlank: false} // 타스크그룹명
							 ,{name: 'TASK_GROUP_NAME', allowBlank: false}  // 타스크그룹명
							 ,{name: 'TASK_CODE'	  , allowBlank: false}  // 타스크코드
							 ,{name: 'TASK_NAME'	  , allowBlank: false}  // 타스크명
							 ,{name: 'TASK_DESC'  	  , allowBlank: false}  // 타스크설명
							 ,{name: 'TASK_INFO_SEQ'  , allowBlank: false}  // 순번
							 ,{name: 'NOTE' 		  , allowBlank: false}  // 비고
							 ,{name: 'USE_YN' 		  , allowBlank: false}  // 사용여부      
							 ,{name: 'FINAL_MOD_ID'   , allowBlank: false}  // 최종변경자ID  
							 ,{name: 'FINAL_MOD_DATE' , allowBlank: false}  // 최종변경일시
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
		url: "/com/task/taskInfoPopList.sg"
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
    			//, src_task_name  : Ext.get('src_task_name').getValue()
    	        //, src_issue_type_code : Ext.get('src_issue_type_code').getValue()
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
    	
    	
    	GridClass_1st_pop.store.setBaseParam('src_task_group_code'	  ,Ext.get('src_task_group_code').getValue());
    	GridClass_1st_pop.store.setBaseParam('src_task_name'	  ,Ext.get('src_task_name').getValue());
    	
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
		window.opener.fnTaskPopValue(records, '<%= fieldName%>');	//부모창으로 함수호출
		window.close();
	}
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
										<td width="20%">
											<div tabindex="-1" class="x-form-item " >
												<label class="x-form-item-label" style="width: auto;" for="src_task_group_code">그룹코드 :</label>
												<div style="padding-left: 30px;" class="x-form-element">
													<select name="src_task_group_code" id="src_task_group_code" style="width: 50%;" type="text" class=" x-form-select x-form-field" >
														<option value="">전체</option>
														<c:forEach items="${TASK_GROUP_CODE}" var="data" varStatus="status">
														<option value="${data.COM_CODE}"><c:out value="${data.COM_CODE_NAME}"/></option>
														</c:forEach>
													</select>
												</div>
											</div>
										</td>
										
										<td width="20%">
											<div tabindex="-1" class="x-form-item " >
												<label class="x-form-item-label" style="width: auto;" for="src_task_name" >타스크명 :</label>
												<div style="padding-left: 80px;" class="x-form-element">
													<input type="text" name="src_task_name" id="src_task_name" autocomplete="off" size="15" class="x-form-text x-form-field" style="width: auto;">
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