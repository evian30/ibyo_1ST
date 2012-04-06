<%--
  Class Name  : orderPop.jsp
  Description : 수주ID검색 팝업
  Modification Information
 
      수정일                   수정자                 수정내용
  -------      --------    ---------------------------
  2011. 4. 28. 고기범              최초 생성
 
  author   : 고기범
  since    : 2011. 4. 28.
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
%>
<script type="text/javascript">
/***************************************************************************
 * 초기값 설정
 ***************************************************************************/
var	gridHeigth_1st_pop 	 	= 300; 								// 그리드 전체 높이
var	gridWidth_1st_pop		= 399;								// 그리드 전체 폭
var gridTitle_1st_pop 		= "수주정보";		  				// 그리드 제목
var	render_1st_pop			= "user-grid";	        			// 렌더(화면에 그려질) 할 id 
var	pageSize_1st_pop		= 10;	  							// 그리드 페이지 사이즈	
var	proxyUrl_1st_pop		= "/ord/order/orderPopList.sg"; 	// 결과 값 페이지
var limit_1st_pop			= pageSize_1st_pop;
var start_1st_pop			= 0;

/***************************************************************************
 * Grid의 컬럼 설정
 ***************************************************************************/
// Grid의 컬럼 설정
var userColumns_1st_pop =  [ checkSm
						   , {header : '상태'                	,width : 60 ,sortable : true , dataIndex : 'FLAG'               ,hidden : true}
						   , {header : '수주ID'					,width : 80 ,sortable : true , dataIndex : 'ORD_ID' 			}			
						   , {header : '수주일자'				,width : 60 ,sortable : true , dataIndex : 'ORD_DATE' 			,hidden : true}      
						   , {header : '수주구분코드'			,width : 60 ,sortable : true , dataIndex : 'ORD_TYPE_CODE' 		,hidden : true}      
						   , {header : '수주명'					,width : 60 ,sortable : true , dataIndex : 'ORD_NAME' 			}      
						   , {header : '견적ID'					,width : 60 ,sortable : true , dataIndex : 'EST_ID' 			,hidden : true}  
						   , {header : '견적'					,width : 60 ,sortable : true , dataIndex : 'EST_NAME' 			,hidden : true}
						   , {header : '수주구분'				,width : 40 ,sortable : true , dataIndex : 'ORD_TYPE_NAME' 		}
						   , {header : '버전'					,width : 60 ,sortable : true , dataIndex : 'EST_VERSION' 		,hidden : true}      
						   , {header : '업무구분코드'			,width : 60 ,sortable : true , dataIndex : 'ROLL_TYPE_CODE' 	,hidden : true}			
						   , {header : '프로젝트ID'				,width : 60 ,sortable : true , dataIndex : 'PJT_ID' 			,hidden : true}      
						   , {header : '프로젝트'				,width : 60 ,sortable : true , dataIndex : 'PJT_NAME' 			,hidden : true}
						   , {header : '수주부서코드'			,width : 60 ,sortable : true , dataIndex : 'ORD_DEPT_CODE' 		,hidden : true}      
						   , {header : '수주부서'				,width : 60 ,sortable : true , dataIndex : 'ORD_DEPT_NAME' 		,hidden : true}
						   , {header : '수주담당자번호'			,width : 60 ,sortable : true , dataIndex : 'ORD_EMP_NUM' 		,hidden : true}      
						   , {header : '수주담당자'				,width : 60 ,sortable : true , dataIndex : 'ORD_EMP_NAME' 		,hidden : true}
						   , {header : '수주처코드(거래처)'		,width : 60 ,sortable : true , dataIndex : 'ORD_CUSTOM_CODE' 	,hidden : true} 
						   , {header : '거래처명'				,width : 60 ,sortable : true , dataIndex : 'ORD_CUSTOM_NAME' 	}
						   , {header : '납품처코드'				,width : 60 ,sortable : true , dataIndex : 'DVE_CUSTOM_CODE' 	,hidden : true}      
						   , {header : '납품처'					,width : 60 ,sortable : true , dataIndex : 'DVE_CUSTOM_NAME' 	,hidden : true}
						   , {header : '검수예정일'				,width : 60 ,sortable : true , dataIndex : 'INSPECT_EXP_DATE' 	,hidden : true}      
						   , {header : '납품예정일'				,width : 60 ,sortable : true , dataIndex : 'DELIVERY_EXP_DATE' 	,hidden : true}      
						   , {header : '설치예정일시'			,width : 60 ,sortable : true , dataIndex : 'SET_EXP_DATE' 		,hidden : true}      
						   , {header : '매출예정일'				,width : 60 ,sortable : true , dataIndex : 'SAL_EXP_DATE' 		,hidden : true}      
						   , {header : '결제일'					,width : 60 ,sortable : true , dataIndex : 'ACCOUNT_DATE' 		,hidden : true}      
						   , {header : '수주총액'				,width : 60 ,sortable : true , dataIndex : 'ORD_TOTAL_AMT' 		,hidden : true}      
						   , {header : '할인총액'				,width : 60 ,sortable : true , dataIndex : 'DISCNT_TOTAL_AMT' 	,hidden : true}      
						   , {header : '수주적용총액'			,width : 60 ,sortable : true , dataIndex : 'ORD_APLY_TOTAL_AMT' ,hidden : true}      
						   , {header : '수주적용총세액'			,width : 60 ,sortable : true , dataIndex : 'ORD_APLY_TOTAL_TAX' ,hidden : true}      
						   , {header : '적용업무설명'			,width : 60 ,sortable : true , dataIndex : 'APLY_JOB_DESCRIPT'  ,hidden : true}      
						   , {header : '특이사항'				,width : 60 ,sortable : true , dataIndex : 'SUMMARY' 			,hidden : true}      
						   , {header : '유무상구분코드'			,width : 60 ,sortable : true , dataIndex : 'PAY_FREE_CODE' 		,hidden : true}      
						   , {header : '유지보수기간_From'		,width : 60 ,sortable : true , dataIndex : 'MAINTENANCE_FROM' 	,hidden : true}      
						   , {header : '유지보수기간_To'			,width : 60 ,sortable : true , dataIndex : 'MAINTENANCE_TO' 	,hidden : true}      
						   , {header : '프로젝트기간FROM'		,width : 60 ,sortable : true , dataIndex : 'PJT_DATE_FROM' 		,hidden : true}      
						   , {header : '프로젝트기간To'			,width : 60 ,sortable : true , dataIndex : 'PJT_DATE_TO' 		,hidden : true}      
						   , {header : '세금계산서발행구분'		,width : 60 ,sortable : true , dataIndex : 'TAX_ISSUE_TYPE' 	,hidden : true}      
						   , {header : '세금계산서분할발행회수' 	,width : 60 ,sortable : true , dataIndex : 'TAX_MOD_ISSUE_CNT' 	,hidden : true}      
						   , {header : '진행상태코드'          	,width : 60 ,sortable : true , dataIndex : 'PROC_STATUS_CODE' 	,hidden : true}      
						   , {header : '최종변경자ID'			,width : 60 ,sortable : true , dataIndex : 'FINAL_MOD_ID' 		,hidden : true}      
						   , {header : '최종변경일시'			,width : 60 ,sortable : true , dataIndex : 'FINAL_MOD_DATE' 	,hidden : true}      
						   , {header : '최초등록일'				,width : 60 ,sortable : true , dataIndex : 'REG_DATE' 			,hidden : true}      
						   , {header : '최초등록자'				,width : 60 ,sortable : true , dataIndex : 'REG_ID' 			,hidden : true}      
						   , {header : '수주처담당자번호'		,width : 60 ,sortable : true , dataIndex : 'ORD_CUSTOMER_NUM' 	,hidden : true}      
						   , {header : '수주처담당자'			,width : 60 ,sortable : true , dataIndex : 'ORD_CUSTOMER_NAME' 	,hidden : true}
						   , {header : '납품처담당자번호' 		,width : 60 ,sortable : true , dataIndex : 'DVE_CUSTOMER_NUM' 	,hidden : true}
						   , {header : '납품처담당자' 			,width : 60 ,sortable : true , dataIndex : 'DVE_CUSTOMER_NAME' 	,hidden : true}
					  
						   ];	 

// 그리드 결과매핑 
var mappingColumns_1st_pop = [ { name : 'FLAG'               ,allowBlank : false }		// 상태                	               
							 , { name : 'ORD_ID' 			 ,allowBlank : false }		// 수주ID					 			
							 , { name : 'ORD_DATE' 			 ,allowBlank : false }		// 수주일자				 			  
							 , { name : 'ORD_TYPE_CODE' 	 ,allowBlank : false }		// 수주구분코드			 		      
							 , { name : 'ORD_NAME' 			 ,allowBlank : false }		// 수주명					 			  
							 , { name : 'EST_ID' 			 ,allowBlank : false }		// 견적ID
							 , { name : 'EST_NAME' 			 ,allowBlank : false }		// 견적	
							 , { name : 'ORD_TYPE_NAME' 	 ,allowBlank : false }		// 수주구분			 				
							 , { name : 'EST_VERSION' 		 ,allowBlank : false }		// 버전					 				    
							 , { name : 'ROLL_TYPE_CODE' 	 ,allowBlank : false }		// 업무구분코드			 				
							 , { name : 'PJT_ID' 			 ,allowBlank : false }		// 프로젝트ID		
							 , { name : 'PJT_NAME' 			 ,allowBlank : false }		// 프로젝트
							 , { name : 'ORD_DEPT_CODE' 	 ,allowBlank : false }		// 수주부서코드		
							 , { name : 'ORD_DEPT_NAME' 	 ,allowBlank : false }		// 수주부서
							 , { name : 'ORD_EMP_NUM' 		 ,allowBlank : false }		// 수주담당자번호	
							 , { name : 'ORD_EMP_NAME' 		 ,allowBlank : false }		// 수주담당자
							 , { name : 'ORD_CUSTOM_CODE' 	 ,allowBlank : false }		// 수주처코드(거래처)		 
							 , { name : 'ORD_CUSTOM_NAME' 	 ,allowBlank : false }		// 거래처명			 				
							 , { name : 'DVE_CUSTOM_CODE' 	 ,allowBlank : false }		// 납품처코드				 		      
							 , { name : 'DVE_CUSTOM_NAME' 	 ,allowBlank : false }		// 납품처				 				
							 , { name : 'INSPECT_EXP_DATE' 	 ,allowBlank : false }		// 검수예정일				 		      
							 , { name : 'DELIVERY_EXP_DATE'  ,allowBlank : false }		// 납품예정일				 			      
							 , { name : 'SET_EXP_DATE' 		 ,allowBlank : false }		// 설치예정일시			 		    
							 , { name : 'SAL_EXP_DATE' 		 ,allowBlank : false }		// 매출예정일				 		    
							 , { name : 'ACCOUNT_DATE' 		 ,allowBlank : false }		// 결제일					 			    
							 , { name : 'ORD_TOTAL_AMT' 	 ,allowBlank : false }		// 수주총액				 			      
							 , { name : 'DISCNT_TOTAL_AMT' 	 ,allowBlank : false }		// 할인총액				 			      
							 , { name : 'ORD_APLY_TOTAL_AMT' ,allowBlank : false }		// 수주적용총액			 		       
							 , { name : 'ORD_APLY_TOTAL_TAX' ,allowBlank : false }		// 수주적용총세액			 	       
							 , { name : 'APLY_JOB_DESCRIPT'  ,allowBlank : false }		// 적용업무설명			 		       
							 , { name : 'SUMMARY' 			 ,allowBlank : false }		// 특이사항				 			  
							 , { name : 'PAY_FREE_CODE' 	 ,allowBlank : false }		// 유무상구분코드			 	      
							 , { name : 'MAINTENANCE_FROM' 	 ,allowBlank : false }		// 유지보수기간_From		 	      
							 , { name : 'MAINTENANCE_TO' 	 ,allowBlank : false }		// 유지보수기간_To			 	    
							 , { name : 'PJT_DATE_FROM' 	 ,allowBlank : false }		// 프로젝트기간FROM		 	      
							 , { name : 'PJT_DATE_TO' 		 ,allowBlank : false }		// 프로젝트기간To			 	    
							 , { name : 'TAX_ISSUE_TYPE' 	 ,allowBlank : false }		// 세금계산서발행구분		    
							 , { name : 'TAX_MOD_ISSUE_CNT'  ,allowBlank : false }		// 세금계산서분할발행회수	      
							 , { name : 'PROC_STATUS_CODE' 	 ,allowBlank : false }		// 진행상태코드                
							 , { name : 'FINAL_MOD_ID' 		 ,allowBlank : false }		// 최종변경자ID				 	    
							 , { name : 'FINAL_MOD_DATE' 	 ,allowBlank : false }		// 최종변경일시				 	    
							 , { name : 'REG_DATE' 			 ,allowBlank : false }		// 최초등록일					 	  
							 , { name : 'REG_ID' 			 ,allowBlank : false }		// 최초등록자					 	
							 , { name : 'ORD_CUSTOMER_NUM' 	 ,allowBlank : false }		// 수주처담당자번호		 	      
							 , { name : 'ORD_CUSTOMER_NAME'  ,allowBlank : false }		// 수주처담당자				 		
							 , { name : 'DVE_CUSTOMER_NUM' 	 ,allowBlank : false }		// 납품처담당자번호 		 	
							 , { name : 'DVE_CUSTOMER_NAME'  ,allowBlank : false }		// 납품처담당자 	
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
		url: "/ord/order/orderPopList.sg"
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
    	GridClass_1st_pop.store.setBaseParam('src_ord_id'	  ,Ext.get('src_ord_id').getValue());
    	GridClass_1st_pop.store.setBaseParam('src_ord_name'   ,Ext.get('src_ord_name').getValue());
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
		window.opener.fnOrdIdPopValue(records);
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
						    			<td width="50%">
											<div tabindex="-1" class="x-form-item " >
												<label class="x-form-item-label" style="width: auto;" for="src_ord_id" >수주ID :</label>
												<div style="padding-left: 0px;" class="x-form-element">
													<input type="text" id="src_ord_id" name="src_ord_id" autocomplete="off" size="18" class=" x-form-text x-form-field" style="width: auto;">
												</div>
											</div>
										</td>
										<td width="50%">
											<div tabindex="-1" class="x-form-item " >
												<label class="x-form-item-label" style="width: auto;" for="src_ord_name" >수주명 :</label>
												<div style="padding-left: 0px;" class="x-form-element">
													<input type="text" id="src_ord_name" name="src_ord_name" autocomplete="off" size="18" class=" x-form-text x-form-field" style="width: auto;">
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