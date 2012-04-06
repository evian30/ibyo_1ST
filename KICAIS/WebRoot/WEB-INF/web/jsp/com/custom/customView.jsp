<%--
  Class Name  : customView.jsp
  Description : 거래처정보조회
  Modification Information
 
      수정일                   수정자                 수정내용
  -------      --------    ---------------------------
  2011. 3. 15   고기범            최초 생성   
  2011. 3. 24   고기범            화면 디자인 변경 및 공통JS적용
  
  author   : 고기범
  since    : 2011. 3. 15.
  version  : 1.0
   
  Copyright (C) 2011 by SG All right reserved.
--%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/web/jsp/sgis-top-inc.jsp" %>

<script type="text/javascript">
/***************************************************************************
 *  거래처정보 -- 초기값 설정 
 ***************************************************************************/
var	gridHeigth_1st 	 	= 200; 								// 그리드 전체 높이
var	gridWidth_1st		= 1000;								// 그리드 전체 폭
var gridTitle_1st 		= "거래처정보";	  					// 그리드 제목
var	render_1st			= "custom_grid";	  				// 렌더(화면에 그려질) 할 id 
var	pageSize_1st		= 10;	  							// 그리드 페이지 사이즈	
var	proxyUrl_1st		= "/com/custom/customListView.sg";	// 결과 값 페이지
var limit_1st			= pageSize_1st;
var start_1st			= 0;

// 그리드의 페이지 클릭시 검색조건값을 DB로 전송
function fnPagingValue_1st(){
	
	try{
		GridClass_1st.store.setBaseParam('start_1st'		 ,start_1st);
	    GridClass_1st.store.setBaseParam('limit_1st'		 ,limit_1st);
		GridClass_1st.store.setBaseParam('src_custom_type'   ,Ext.get('src_custom_type').getValue());
		GridClass_1st.store.setBaseParam('src_custom_code'   ,Ext.get('src_custom_code').getValue());
		GridClass_1st.store.setBaseParam('src_biz_num'		 ,Ext.get('src_biz_num').getValue());
		GridClass_1st.store.setBaseParam('src_customer_name' ,Ext.get('src_customer_name').getValue());
		GridClass_1st.store.setBaseParam('src_custom_level'  ,Ext.get('src_custom_level').getValue());
		GridClass_1st.store.setBaseParam('src_use_yn'        ,Ext.get('src_use_yn').getValue());
	}catch(e){

	}
}
   
// Grid의 컬럼 설정
var userColumns_1st =  [ {header: '거래처코드' 			,width: 60	,sortable: true ,dataIndex: 'CUSTOM_CODE'	   }
					   , {header: '거래처구분' 			,width: 60  ,sortable: true ,dataIndex: 'CUSTOM_TYPE'	   ,hidden : true}
					   , {header: '거래처구분' 			,width: 60  ,sortable: true ,dataIndex: 'CUSTOM_TYPE_NAME' ,hidden : true}
					   , {header: '거래처명' 				,width: 60  ,sortable: true ,dataIndex: 'CUSTOM_NAME'	   }
					   , {header: '개인/사업자구분' 		,width: 100 ,sortable: true ,dataIndex: 'PER_BIZ_TYPE'	   ,hidden : true}                  
					   , {header: '사업자번호' 			,width: 50  ,sortable: true ,dataIndex: 'BIZ_NUM'		   }
					   , {header: '대표자명' 				,width: 50  ,sortable: true ,dataIndex: 'CEO_NAME'		   }
					   , {header: '업태' 				,width: 50  ,sortable: true ,dataIndex: 'BIZ_TYPE'		   }
					   , {header: '업종' 				,width: 50  ,sortable: true ,dataIndex: 'BIZ_KIND'		   }
					   , {header: '우편번호' 				,width: 50  ,sortable: true ,dataIndex: 'ZIPCODE'		   ,hidden : true}  
					   , {header: '주소' 				,width: 100 ,sortable: true ,dataIndex: 'ADDR'			   ,hidden : true}  
					   , {header: '주소상세' 				,width: 50  ,sortable: true ,dataIndex: 'ADDR_DETAIL' 	   ,hidden : true}
					   , {header: '전화번호' 				,width: 50  ,sortable: true ,dataIndex: 'TELEPHONE' 	   }
					   , {header: '팩스' 				,width: 50  ,sortable: true ,dataIndex: 'FAX' 			   ,hidden : true}
					   , {header: 'E-MAIL' 				,width: 50  ,sortable: true ,dataIndex: 'EMAIL' 		   ,hidden : true}
					   , {header: '전자세금계산서발행여부'	,width: 50  ,sortable: true ,dataIndex: 'ETAX_ISSUE_YN'    }
					   , {header: '거래처등급코드' 		,width: 50  ,sortable: true ,dataIndex: 'CUSTOM_LEVEL' 	   }
					   , {header: '비고'					,width: 50  ,sortable: true ,dataIndex: 'NOTE' 			   ,hidden : true}
					   , {header: '사용여부' 				,width: 50  ,sortable: true ,dataIndex: 'USE_YN' 		   }
					   , {header: '최종변경자ID' 			,width: 50  ,sortable: true ,dataIndex: 'FINAL_MOD_ID' 	   ,hidden : true}
					   , {header: '최종변경일시'		 	,width: 50  ,sortable: true ,dataIndex: 'FINAL_MOD_DATE'   ,hidden : true}
					   ];	 

// 그리드 결과매핑 
var mappingColumns_1st = [ {name: 'CUSTOM_CODE'    		,allowBlank: false}  // 거래처코드            
						 , {name: 'CUSTOM_TYPE'    		,allowBlank: false}  // 거래처구분   
						 , {name: 'CUSTOM_TYPE_NAME'    ,allowBlank: false}  // 거래처구분명 
						 , {name: 'CUSTOM_NAME'    		,allowBlank: false}  // 거래처명              
						 , {name: 'PER_BIZ_TYPE'   		,allowBlank: false}  // 개인/사업자구분       
						 , {name: 'BIZ_NUM' 	   		,allowBlank: false}  // 사업자번호            
						 , {name: 'CEO_NAME' 	   		,allowBlank: false}  // 대표자명              
						 , {name: 'BIZ_TYPE' 	   		,allowBlank: false}  // 업태                  
						 , {name: 'BIZ_KIND' 	   		,allowBlank: false}  // 업종                  
						 , {name: 'ZIPCODE' 	   		,allowBlank: false}  // 우편번호              
						 , {name: 'ADDR' 		   		,allowBlank: false}  // 주소                  
						 , {name: 'ADDR_DETAIL'    		,allowBlank: false}  // 주소상세              
						 , {name: 'TELEPHONE' 	   		,allowBlank: false}  // 전화번호                      
						 , {name: 'FAX' 		   		,allowBlank: false}  // 팩스                          
						 , {name: 'EMAIL' 		   		,allowBlank: false}  // E-MAIL                          
						 , {name: 'ETAX_ISSUE_YN'  		,allowBlank: false}  // 전자세금계산서발행여부        	
						 , {name: 'CUSTOM_LEVEL'   		,allowBlank: false}  // 거래처등급코드                  
						 , {name: 'NOTE' 		   		,allowBlank: false}  // 비고                            
						 , {name: 'USE_YN' 		   		,allowBlank: false}  // 사용여부                        
						 , {name: 'FINAL_MOD_ID'   		,allowBlank: false}  // 최종변경자ID                    
						 , {name: 'FINAL_MOD_DATE' 		,allowBlank: false}  // 최종변경일시
    				 	 ];
 
/***************************************************************************
 * 거래처 정보 --- 그리드 클릭시 Event
 ***************************************************************************/
function fnGridOnClick_1st(store, rowIndex){

	var selectedCode = fnFixNull(store.getAt(rowIndex).data.CUSTOM_CODE);
	
	Ext.Ajax.request({   
		url: "/com/custom/customMemberListView.sg"
		,method : 'POST'   
		,success: function(response){						// 조회결과 성공시
					// 조회된 결과값, store명
					handleSuccess(response,GridClass_2nd);
					Ext.get('clickCode').set({value : selectedCode}, false);
		          }   							
		,failure: handleFailure   	   						// 조회결과 실패시  
		,params : {					   						// 조회조건을 DB로 전송하기위해서 조건값 설정
					limit          	   : limit_2nd
				  , start          	   : start_2nd
				  , src_custom_code    : selectedCode
				  }				
	});
	
}   

/***************************************************************************
 * 거래처 담당자 --- 초기값 설정 
 ***************************************************************************/
var	gridHeigth_2nd 	 	= 200; 						 // 그리드 전체 높이
var	gridWidth_2nd		= 1000;						 // 그리드 전체 폭
var gridTitle_2nd 		= "거래처 담당자 정보 ";		 // 그리드 제목
var	render_2nd			= "customMember-grid";		 // 렌더(화면에 그려질) 할 id 
var	pageSize_2nd		= 10;	  					 // 그리드 페이지 사이즈	
var	proxyUrl_2nd		= "/com/custom/customMemberListView.sg"; // 결과 값 페이지
var limit_2nd			= pageSize_2nd;
var start_2nd			= 0;

// 그리드의 페이지 클릭시 검색조건값을 DB로 전송
function fnPagingValue_2nd(){
	
<%--	alert("ff");--%>
<%--	alert(GridClass_1st.getSelectedRows());--%>
	
	var sForm = document.searchForm;
	
	try{
		GridClass_2nd.store.setBaseParam('start', start_2nd);
		GridClass_2nd.store.setBaseParam('limit', limit_2nd);
		GridClass_2nd.store.setBaseParam('src_custom_code', Ext.get('clickCode').getValue());
	}catch(e){

	}
}

// Grid의 컬럼 설정
var userColumns_2nd =  [ {header: '상태'       	   		 ,width: 100 ,sortable: true ,dataIndex: 'FLAG'			      ,hidden : true}       
				   	   , {header: '거래처코드' 			 ,width: 60	 ,sortable: true ,dataIndex: 'CUSTOM_CODE'	      ,hidden : true}
				   	   , {header: '거래처구분' 			 ,width: 60  ,sortable: true ,dataIndex: 'CUSTOM_TYPE'	   	  ,hidden : true}
				   	   , {header: '거래처명' 				 ,width: 60  ,sortable: true ,dataIndex: 'CUSTOM_NAME'	   	  }
				   	   , {header: '사업자번호' 			 ,width: 50  ,sortable: true ,dataIndex: 'BIZ_NUM'		   	  }
				   	   , {header: '거래처담당자번호' 		 ,width: 50  ,sortable: true ,dataIndex: 'CUSTOMER_NUM' 	  ,hidden : true}
				   	   , {header: '담당자명' 		 		 ,width: 50  ,sortable: true ,dataIndex: 'CUSTOMER_NAME' 	  }
				   	   , {header: '부서' 		 		 ,width: 50  ,sortable: true ,dataIndex: 'CUSTOMER_DEPT' 	  }
				   	   , {header: '직위' 				 ,width: 50  ,sortable: true ,dataIndex: 'CUSTOMER_POSITION'  }
				   	   , {header: '업무구분' 				 ,width: 50  ,sortable: true ,dataIndex: 'CUSTOMER_ROLL_CODE' }
				   	   , {header: '전화번호' 	 			 ,width: 50  ,sortable: true ,dataIndex: 'CUSTOMER_TELEPHONE' }
				   	   , {header: '휴대폰번호' 	 		 ,width: 50  ,sortable: true ,dataIndex: 'CUSTOMER_MOBILE' 	  }
	   				   , {header: '내선번호' 	 			 ,width: 50  ,sortable: true ,dataIndex: 'CUSTOMER_DIRECT' 	  }
			   		   , {header: 'E-MAIL' 	 		 	 ,width: 50  ,sortable: true ,dataIndex: 'CUSTOMER_EMAIL' 	  }
					   , {header: '거래처담당자등급' 		 ,width: 50  ,sortable: true ,dataIndex: 'CUSTOMER_LEVEL' 	  ,hidden : true}
				   	   , {header: '거래처담당자메모사항'	 ,width: 50  ,sortable: true ,dataIndex: 'CUSTOMER_NOTICE' 	  ,hidden : true}
				   	   , {header: '비고'					 ,width: 50  ,sortable: true ,dataIndex: 'NOTE' 			  ,hidden : true}
				   	   , {header: '사용여부' 				 ,width: 50  ,sortable: true ,dataIndex: 'USE_YN' 		   	  ,hidden : true}
				   	   , {header: '최종변경자ID' 			 ,width: 50  ,sortable: true ,dataIndex: 'FINAL_MOD_ID' 	  ,hidden : true}
				   	   , {header: '최종변경일시'		 	 ,width: 50  ,sortable: true ,dataIndex: 'FINAL_MOD_DATE'     ,hidden : true}
				   	   ];	 

// 그리드 결과매핑 
var mappingColumns_2nd = [ {name: 'FLAG' 		   	   ,allowBlank: false}	// 상태
					     , {name: 'CUSTOM_CODE'	       ,allowBlank: false}  // 거래처코드 			 	  		                                                
					 	 , {name: 'CUSTOM_TYPE'	   	   ,allowBlank: false}  // 거래처구분 			    		                                               
					 	 , {name: 'CUSTOM_NAME'	   	   ,allowBlank: false}  // 거래처명 				    		                                              
					 	 , {name: 'BIZ_NUM'		   	   ,allowBlank: false}  // 사업자번호 			    		                                                
					 	 , {name: 'CUSTOMER_NUM' 	   ,allowBlank: false}  // 거래처담당자번호 		    	                                               
					 	 , {name: 'CUSTOMER_NAME' 	   ,allowBlank: false}  // 당자명 		 		    			                                                
					 	 , {name: 'CUSTOMER_DEPT' 	   ,allowBlank: false}  // 거래처담당자부서 		                                                    
					 	 , {name: 'CUSTOMER_POSITION'  ,allowBlank: false}  // 직위 				    				                                                
					 	 , {name: 'CUSTOMER_ROLL_CODE' ,allowBlank: false}  // 거래처담당자업무구분코드                                                
					 	 , {name: 'CUSTOMER_TELEPHONE' ,allowBlank: false}  // 거래처담당자전화번호 	                                                 
					 	 , {name: 'CUSTOMER_MOBILE'    ,allowBlank: false}  // 거래처담당자휴대폰번호 	                                               
					 	 , {name: 'CUSTOMER_DIRECT'    ,allowBlank: false}  // 거래처담당자내선번호 	                                                 
					 	 , {name: 'CUSTOMER_EMAIL' 	   ,allowBlank: false}  // 거래처담당자E-MAIL 	                                                   
					 	 , {name: 'CUSTOMER_LEVEL' 	   ,allowBlank: false}  // 거래처담당자등급 		                            
					 	 , {name: 'CUSTOMER_NOTICE'    ,allowBlank: false}  // 거래처담당자메모사항	                          
					 	 , {name: 'NOTE' 			   ,allowBlank: false}  // 비고					    			                        
					 	 , {name: 'USE_YN' 		   	   ,allowBlank: false}  // 사용여부 				    		                        
					 	 , {name: 'FINAL_MOD_ID' 	   ,allowBlank: false}  // 최종변경자ID 			    	                        
					 	 , {name: 'FINAL_MOD_DATE'     ,allowBlank: false}  // 최종변경일시
    				 	 ];
 
/***************************************************************************
 * 거래처담당자 --- 그리드 클릭시 Event
 ***************************************************************************/
function fnGridOnClick_2nd(store, rowIndex){

}  

/***************************************************************************
 * 설  명 : 필드 초기화
 **************************************************************************/
function fnInitValue(){

}

/***************************************************************************
 * 설  명 : 검색
 **************************************************************************/
function fnSearch(){  	
	
	Ext.Ajax.request({   
		url: "/com/custom/customListView.sg"
		,method : 'POST'   
		,success: function(response){						// 조회결과 성공시
					// 조회된 결과값, store명
					handleSuccess(response,GridClass_1st);
					GridClass_2nd.store.reload()
		          }   							
		,failure: handleFailure   	   						// 조회결과 실패시  
		,params : {					   						// 조회조건을 DB로 전송하기위해서 조건값 설정
					limit          	   : limit_1st
				  , start          	   : start_1st
				  , src_custom_type    : Ext.get('src_custom_type').getValue()
				  , src_custom_code    : Ext.get('src_custom_code').getValue()
				  , src_biz_num        : Ext.get('src_biz_num').getValue()
				  , src_customer_name  : Ext.get('src_customer_name').getValue()
				  , src_custom_level   : Ext.get('src_custom_level').getValue()
				  , src_use_yn         : Ext.get('src_use_yn').getValue()
				  }				
	});  
	
}  		

/***************************************************************************
 * 설  명 : 저장버튼 클릭
 ***************************************************************************/
function fnSave(){  	

<%--	var sForm = document.searchForm;	// 검색 FORM--%>
<%--	var dForm = document.detailForm;	// 상세 FORM--%>

	// 거래처구분, 거래처코드값이 넘어갈수 있도록 disable 해제
<%--	dForm.customer_num.disabled = false; --%>
	
	Ext.Ajax.request({   
		url: "/com/custom/updateCustomMember.sg"   
		,success: function(response){						// 조회결과 성공시
					// 조회된 결과값, store명
					handleSuccess(response,GridClass_1st,'save');
		          } 
		,failure: handleFailure   	    // 조회결과 실패시  
<%--		,form   : document.detailForm   // 상세 FORM--%>
		,params : {					    // 조회조건을 DB로 전송하기위해서 조건값 설정
				  // 페이지정보
					limit_1st             : limit_1st
			  	  , start_1st             : start_1st
				  // 검색정보
			  	  , src_custom_code   : sForm.src_custom_code.value   // 거래처코드
			  	  , src_biz_num       : sForm.src_biz_num.value       // 사업자번호
			  	  , src_customer_name : sForm.src_customer_name.value // 담당자명
			  	  // disable된 컬럼의 자료
<%--			  	  , custom_code  	  : dForm.custom_code.value		  // 거래처코드--%>
<%--			  	  , custom_name  	  : dForm.custom_name.value		  // 거래처명--%>
<%--			  	  , custom_type  	  : dForm.custom_type.value		  // 거래처구분--%>
<%--			  	  , biz_num  	      : dForm.biz_num.value		  	  // 사업자번호--%>
				  }  		
	});  
	
}  		

/***************************************************************************
 * 설  명 : 화면 설정
 ***************************************************************************/
function fnInit(){

	var sForm = document.searchForm;	// 검색 FORM
<%--	var dForm = document.detailForm;	// 상세 FORM--%>
	
	// ExtJS 진입함수
	Ext.onReady(function() {
	
 
	    // 검색버튼 클릭
		Ext.get('searchBtn').on('click', function(e){
	        if(Validator.validate(sForm)){
	        	Ext.get('clickCode').set({value : ''}, false);
				fnSearch()
			}	
	    });
	    
    	//조건해제 버튼 -> 검색조건 초기화
    	Ext.get('searchClearBtn').on('click', function(e){
	        sForm.reset();
	        Ext.get('clickCode').set({value : ''}, false);
	        fnSearch();
	    });
    	
    	// 거래처검색 버튼
		Ext.get('src_custom_btn').on('click', function(e){
			var param = '?fieldCode=src_custom_code&fieldName=src_custom_name';
			param = param + '&form=searchForm';
			fnCustomPop(param)
		});
							
	}); // end Ext.onReady
	
}    
	
/***************************************************************************
 * 설  명 : 그리드의 페이지 클릭시 검색조건값을 DB로 전송
 ***************************************************************************/
function fnCustomPop(param){
	var sURL      = "/com/custom/customPop.sg"+param;
	var dlgWidth  = 420;
	var dlgHeight = 360;
	var winName   = "부서레벨";
	fnOpenPop(sURL, dlgWidth, dlgHeight, winName);
}

// 팝업
function fnOpenPop(sURL, dlgWidth, dlgHeight, winName){
  var xPos=(window.screen.width) ? (window.screen.width-dlgWidth)/2 : 0;
  var yPos=(window.screen.height) ? (window.screen.height-dlgHeight)/2 : 0;
  var sFeatures = "titlebar=no, scrollbars=yes,location=no ,menubar=no, resizable=yes, status=yes, width="+dlgWidth+",height="+dlgHeight+",left="+xPos+", top="+yPos;
  window.open(sURL,winName, sFeatures);
}
	
</script>
<script type="text/javascript" src="/resource/common/js/grid/grid_1st.js"></script>
<script type="text/javascript" src="/resource/common/js/grid/grid_2nd.js"></script>
<!-- <script type="text/javascript" src="/resource/common/js/GridType_two.js"></script> -->
<!-- <script type="text/javascript" src="/resource/common/js/GridType_three.js"></script> -->
<!-- <script type="text/javascript" src="/resource/common/js/GridType_four.js"></script> -->

</head>
<body onload="fnInit()">
	<table border="0" width="1000" height="200">
		<input type="hidden" id="clickCode" name="clickCode"/><%--1번째 그리드를 클릭했을때 코드 임시저장 --%>
		<tr>
			<td colspan="2">
				<form name="searchForm" id="searchForm" method="post" enctype="multipart/form-data">
				<!----------------- SEARCH Hearder Start	 ----------------->
				<div id="ext-comp-1002" class=" x-panel x-form-label-left" style="margin-top: 0.4em;"><%-- 0em <- 1em으로 수정하면 상위 공백 --%>
					<div class="x-panel-tl">
						<div class="x-panel-tr">
							<div class="x-panel-tc">
								<div id="ext-gen4" class="x-panel-header x-unselectable" style="-moz-user-select: none;">
									<span id="ext-gen8" class="x-panel-header-text">거래처정보 검색</span>
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
												<label class="x-form-item-label" style="width: auto;" for="src_custom_type" >거래처구분 :</label>
												<div style="padding-left: 30px;" class="x-form-element">
													<select name="src_custom_type" id="src_custom_type" title="거래처구분" style="width: 29%;" type="text" class=" x-form-select x-form-field" >
														<option value="">전체</option>
														<c:forEach items="${CUSTOM_TYPE}" var="data" varStatus="status">
														<option value="${data.COM_CODE}"><c:out value="${data.COM_CODE_NAME}"/></option>
														</c:forEach>
													</select>
												</div>
											</div>
										</td>
								
										<td width="8%">
											<div tabindex="-1" class="x-form-item " >
												<label class="x-form-item-label" style="width: auto;" for="src_custom_code" >거래처 :</label>
												<div style="padding-left: 0px;" class="x-form-element">
													<input type="text" name="src_custom_code" id="src_custom_code" autocomplete="off" size="10" class=" x-form-text x-form-field" style="width: auto;">		
												</div>
											</div>
										</td>
										<td width="2%">
											<div tabindex="-1" class="x-form-item " >
												<div style="padding-left: 0px;" class="x-form-element">
												
													<%-- 거래처검색 버튼 Start --%>
													<table border="0" cellspacing="0" class="x-btn  x-btn-noicon" style="width: 30px;">
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
																		<button type="button" id="src_custom_btn" name="src_custom_btn" class="x-btn-text">검색</button>
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
													<%-- 거래처검색 버튼 End	--%>
												
												</div>
											</div>
										</td>
										<td width="10%">
												<div style="padding-left: 0px;" class="x-form-element">
													<input type="text" name="src_custom_name" id="src_custom_name" autocomplete="off" size="20" class=" x-form-text x-form-field" style="width: auto;">
												</div>
										</td>
								
										<td width="20%">
											<div tabindex="-1" class="x-form-item " >
												<label class="x-form-item-label" style="width: auto;" for="src_biz_num" >사업자번호 :</label>
												<div style="padding-left: 80px;" class="x-form-element">
													<input type="text" name="src_biz_num" id="src_biz_num" autocomplete="off" size="20" class=" x-form-text x-form-field" style="width: auto;">
												</div>
											</div>
										</td>
									</tr>
									<%-- 1 Row End --%>
									<%-- 2 Row Start --%>
									<tr>
										<td width="20%">
											<div tabindex="-1" class="x-form-item " >
												<label class="x-form-item-label" style="width: auto;" for="src_customer_name">담당자명 :</label>
												<div style="padding-left: 30px;" class="x-form-element">
													<input type="text" name="src_customer_name" id="src_customer_name" autocomplete="off" size="5" class="x-form-text x-form-field" style="width: auto;">
												</div>
											</div>
										</td>
										
										<td colspan="3" width="20%">
											<div tabindex="-1" class="x-form-item " >
												<label class="x-form-item-label" style="width: auto;" for="src_custom_level" >거래처등급 :</label>
												<div style="padding-left: 30px;" class="x-form-element">
													<select name="src_custom_level" id="src_custom_level" style="width: 29%;" type="text" class=" x-form-select x-form-field" >
														<option value="">전체</option>
														<c:forEach items="${CUSTOM_LEVEL_CODE}" var="data" varStatus="status">
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
									<%-- 2 Row End --%>
									<%-- 3 Row 버튼 Start --%>
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
									<%-- 3 Row 버튼 End --%>
								</table>
							</div>
						</div>
					</div>
				</div>
				<%-- footer Start --%>
				<div id="" class="x-panel-bl x-panel-nofooter">
					<div class="x-panel-br">
						<div class="x-panel-bc" >
						</div>
					</div>
				</div>
				<%-- footer End  --%>
				<!----------------- SEARCH Field End	 ----------------->
				</form>
			</td>
		</tr>
	
		<tr>
			<!----------------- 거래처정보 GRID START ----------------->
			<td width="50%" valign="top">
				<div id="custom_grid" style="margin-top: 0.4em;"></div>
			</td>
			<!----------------- 거래처정보 GRID END ----------------->
		</tr>
		<tr>
			<!----------------- 거래처정보 GRID START ----------------->
			<td width="50%" valign="top">
				<div id="customMember-grid" style="margin-top: 0.4em;"></div>
			</td>
			<!----------------- 거래처정보 GRID END ----------------->
		</tr>
	</table>
</body>

<%@ include file="/WEB-INF/web/jsp/sgis-bottom-inc.jsp" %>