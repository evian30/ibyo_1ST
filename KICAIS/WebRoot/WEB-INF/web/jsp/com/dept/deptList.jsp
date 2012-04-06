<%--
  Class Name  : deptList.jsp
  Description : 부서정보관리
  Modification Information
 
      수정일                   수정자                 수정내용
  -------      --------    ---------------------------
  2011. 2. 25. 이재철              최초 생성
  2011. 3. 7   고기범              
  2011. 3. 25  고기범              화면 디자인 변경 및 공통JS적용
  
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
 *  초기값 설정 
 ***************************************************************************/
var	gridHeigth_1st 	 	= 400; 						// 그리드 전체 높이
var	gridWidth_1st		= 1000;						// 그리드 전체 폭
var gridTitle_1st 		= "부서정보관리";	  			// 그리드 제목
var	render_1st			= "user-grid";	  			// 렌더(화면에 그려질) 할 id 
var	pageSize_1st		= 10;	  					// 그리드 페이지 사이즈	
var	proxyUrl_1st		= "/com/dept/result.sg";	// 결과 값 페이지
var limit_1st			= pageSize_1st;
var start_1st			= 0;

// Grid의 컬럼 설정
var userColumns_1st =  [
						{header: "상태",		    width: 100, sortable: true, dataIndex: 'FLAG', 			  editor: new Ext.form.TextField({}) , hidden : true},       
						{header: "부서코드", 		width: 40,  sortable: true, dataIndex: 'DEPT_CODE', 	  editor: new Ext.form.TextField({}) , hidden : false},                                                    
						{header: "부서명",  		width: 80,  sortable: true, dataIndex: 'DEPT_NAME', 	  editor: new Ext.form.TextField({}) , hidden : false},                  
						{header: "부서레벨", 		width: 50,  sortable: true, dataIndex: 'DEPT_LEVEL' , 	  editor: new Ext.form.TextField({}) , hidden : true},
						{header: "부서레벨", 		width: 50,  sortable: true, dataIndex: 'DEPT_LEVEL_NAME', editor: new Ext.form.TextField({}) , hidden : false},
						{header: "상위부서코드",	width: 50,  sortable: true, dataIndex: 'HIGH_DEPT_CODE',  editor: new Ext.form.TextField({}) , hidden : false},
						{header: "참조코드",		width: 50,  sortable: true, dataIndex: 'REF_CODE' , 	  editor: new Ext.form.TextField({}) , hidden : true},   
						{header: "사용여부", 		width: 50,  sortable: true, dataIndex: 'USE_YN_NAME' ,    editor: new Ext.form.TextField({}) , hidden : false},  
						{header: "사용여부", 		width: 50,  sortable: true, dataIndex: 'USE_YN' , 		  editor: new Ext.form.TextField({}) , hidden : true},
						{header: "최종변경자ID", 	width: 100, sortable: true, dataIndex: 'FINAL_MOD_ID' ,   editor: new Ext.form.TextField({}) , hidden : false},  
						{header: "최종변경일시", 	width: 50,  sortable: true, dataIndex: 'FINAL_MOD_DATE',  editor: new Ext.form.TextField({}) , hidden : true}
						];	 

// 결과필드를 매핑
var mappingColumns_1st = [ 
						 {name: 'FLAG' 		    	, allowBlank: false},     // 상태
						 {name: 'DEPT_LEVEL' 		, allowBlank: false},     // 부서레벨    
						 {name: 'DEPT_LEVEL_NAME' 	, allowBlank: false},     // 부서레벨
						 {name: 'DEPT_NAME' 		, allowBlank: false},     // 부서명      
						 {name: 'DEPT_CODE' 		, allowBlank: false},     // 부서코드      
						 {name: 'USE_YN' 			, allowBlank: false},     // 사용여부
						 {name: 'USE_YN_NAME'		, allowBlank: false},     // 사용여부    
						 {name: 'HIGH_DEPT_CODE' 	, allowBlank: false},     // 상위부서코드      
						 {name: 'REF_CODE' 			, allowBlank: false},     // 참조코드            
						 {name: 'FINAL_MOD_ID' 		, allowBlank: false},     // 최종변경자ID  
						 {name: 'FINAL_MOD_DATE' 	, allowBlank: false}      // 최종변경일시
				    	 ];
  
// 그리드 클릭
function fnGridOnClick_1st(rowIndex){

}   

/***************************************************************************
 * 함수명 : fnSearch
 * 설  명 : 검색
***************************************************************************/
function fnSearch(){  	
	
	var form = document.searchForm;
	
	Ext.Ajax.request({   
		url: "/com/dept/result.sg"
		,method : 'POST'   
		,success: function(response){						// 조회결과 성공시
					// 조회된 결과값, store명
					handleSuccess(response,GridClass_1st);
		          }
		,failure: handleFailure   	// 조회결과 실패시  
		,params : {					// 조회조건을 DB로 전송하기위해서 조건값 설정
					limit        	 : limit_1st
				  , start        	 : start_1st
		 	      , src_dept_name  	 : Ext.get('src_dept_name').getValue()
				  , src_dept_level 	 : Ext.get('src_dept_level').getValue()
				  , src_use_yn     	 : Ext.get('src_use_yn').getValue()
				  }				
	});  

}  		

/***************************************************************************
 * 설  명 : 초기설정 화면설정
***************************************************************************/
Ext.onReady(function() {
	
	//검색하기 버튼 
	Ext.get('searchBtn').on('click', function(e){
		fnSearch()
	});	
		
	//조건해제 버튼 -> 검색조건 초기화
	Ext.get('searchClearBtn').on('click', function(e){
		document.searchForm.reset();
		fnSearch()
	});	
});

function fnPagingValue_1st(){
	var form = document.searchForm;
	
	try{
		GridClass_1st.store.setBaseParam('start'		 	 ,start_1st);
    	GridClass_1st.store.setBaseParam('limit'		 	 ,limit_1st);
		GridClass_1st.store.setBaseParam('src_dept_level'    ,Ext.get('src_dept_level').getValue());
    	GridClass_1st.store.setBaseParam('src_dept_name'     ,Ext.get('src_dept_name').getValue());
    	GridClass_1st.store.setBaseParam('src_use_yn'        ,Ext.get('src_use_yn').getValue());
   		GridClass_1st.store.setBaseParam('div', 'grid_page');
	}catch(e){

	}
}
</script>

<body>
	<table border="0" width="600" height="200">
		<tr>
			<td colspan="2">
				<form name="searchForm">
				<!----------------- SEARCH Hearder Start	 ----------------->
				<div id="ext-comp-1002" class=" x-panel x-form-label-left" style="margin-top: 0.4em;"><%-- 0em <- 1em으로 수정하면 상위 공백 --%>
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
								<table border="0" width="100%"  style="font-size: 12px">
									<%-- 1 Row Start --%>
									<tr>
										<td width="20%">
											<div tabindex="-1" class="x-form-item " >
												<label class="x-form-item-label" style="width: auto;" for="src_dept_name">부서명 :</label>
												<div style="padding-left: 30px;" class="x-form-element">
													<input type="text" name="src_dept_name" id="src_dept_name" autocomplete="off" size="15" class="x-form-text x-form-field" style="width: auto;">
												</div>
											</div>
										</td>
										
										<td colspan="3" width="20%">
											<div tabindex="-1" class="x-form-item " >
												<label class="x-form-item-label" style="width: auto;" for="src_dept_level" >부서레벨 :</label>
												<div style="padding-left: 30px;" class="x-form-element">
													<select name="src_dept_level" id="src_dept_level" style="width: 29%;" type="text" class=" x-form-select x-form-field" >
														<option value="">전체</option>
														<c:forEach items="${DEPT_LEVEL_CODE}" var="data" varStatus="status">
														<option value="${data.COM_CODE}"><c:out value="${data.COM_CODE_NAME}"/></option>
														</c:forEach>
													</select>
												</div>
											</div>
										</td>
										
										<td width="20%">
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
									</tr>
									<%-- 1 Row End --%>
									<%-- 2 Row 버튼 Start --%>
									<tr align="right">
										<td colspan="5">
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
			<!----------------- GRID START ----------------->
			<td width="50%" valign="top">
				<div id="user-grid" style="margin-top: 0.4em;"></div>
			</td>
			<!----------------- GRID END ----------------->
		</tr>
	</table>
</body>

<%@ include file="/WEB-INF/web/jsp/sgis-bottom-inc.jsp" %>