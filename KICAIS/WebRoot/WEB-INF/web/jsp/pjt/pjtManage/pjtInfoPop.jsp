<%--
  Class Name  : pjtInfoPop.jsp
  Description : 프로젝트조회 팝업
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

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<title>KICA InformationSystem</title>

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
	String fieldName = request.getParameter("fieldName");
	String src_pjt_type_code = request.getParameter("src_pjt_type_code");
%>
<script type="text/javascript">

/***************************************************************************
 * 초기값 설정
 ***************************************************************************/
var	gridHeigth_1st_pop 	 	= 300; 								  // 그리드 전체 높이
var	gridWidth_1st_pop		= 399;								  // 그리드 전체 폭
var gridTitle_1st_pop 		= "프로젝트정보";	  				      // 그리드 제목
var	render_1st_pop			= "user-grid";	        			  // 렌더(화면에 그려질) 할 id 
var	pageSize_1st_pop		= 10;	  							  // 그리드 페이지 사이즈	
var	proxyUrl_1st_pop		= "/pjt/pjtManage/pjtInfoPopList.sg"; // 결과 값 페이지
var limit_1st_pop			= pageSize_1st_pop;
var start_1st_pop			= 0;

/***************************************************************************
 * Grid의 컬럼 설정
 ***************************************************************************/
var userColumns_1st_pop =  [
								 checkSm,
							     {header: '조회상태'                 	,width: 60  ,sortable: true ,dataIndex: 'FLAG'                      ,hidden : true}              
							   , {header: '프로젝트ID'               	,width: 40  ,sortable: true ,dataIndex: 'PJT_ID'                    }              
							   , {header: '프로젝트구분코드'         	,width: 60  ,sortable: true ,dataIndex: 'PJT_TYPE_CODE'             ,hidden : true}               
							   , {header: '프로젝트명'               	,width: 150 ,sortable: true ,dataIndex: 'PJT_NAME'                  }              
							   , {header: '등록일자'                 	,width: 60  ,sortable: true ,dataIndex: 'PJT_REG_DATE'              ,hidden : true}
							   , {header: '프로젝트기간 FROM'        	,width: 60  ,sortable: true ,dataIndex: 'PJT_DATE_FROM'             ,hidden : true}
							   , {header: '프로젝트기간 TO'          	,width: 60  ,sortable: true ,dataIndex: 'PJT_DATE_TO'               ,hidden : true}              
							   , {header: '프로젝트담당자부서코드'   	,width: 60  ,sortable: true ,dataIndex: 'PJT_OWN_DEPT_CODE'         ,hidden : true}              
							   , {header: '프로젝트담당자사번'       	,width: 60  ,sortable: true ,dataIndex: 'PJT_OWN_EMP_NUM'           ,hidden : true}
							   , {header: '프로젝트등록자부서코드'   	,width: 60  ,sortable: true ,dataIndex: 'PJT_REG_DEPT_CODE'         ,hidden : true}
							   , {header: '프로젝트등록자사번'       	,width: 60  ,sortable: true ,dataIndex: 'PJT_REG_EMP_NUM'           ,hidden : true}
							   , {header: '업무구분코드'             	,width: 60  ,sortable: true ,dataIndex: 'ROLL_TYPE_CODE'            ,hidden : true}
							   , {header: '수주가능성'               	,width: 60  ,sortable: true ,dataIndex: 'ORDER_POSSBLE'             ,hidden : true}
							   , {header: '유/무상구분코드'          	,width: 60  ,sortable: true ,dataIndex: 'PAY_FREE_CODE'             ,hidden : true}
							   , {header: '수주예정일'               	,width: 60  ,sortable: true ,dataIndex: 'ORDER_EXP_DATE'            ,hidden : true}
							   , {header: '제안(입찰)마감일'         	,width: 60  ,sortable: true ,dataIndex: 'BID_DDAY'                  ,hidden : true}
							   , {header: '진행상태코드'             	,width: 60  ,sortable: true ,dataIndex: 'PROC_STATUS_CODE'          ,hidden : true}
							   , {header: '개요및특이사항'           	,width: 60  ,sortable: true ,dataIndex: 'PJT_SUMMARY'               ,hidden : true}
							   , {header: '예상매출총액'             	,width: 60  ,sortable: true ,dataIndex: 'EXP_SAL_TOTAL_AMT'         ,hidden : true}
							   , {header: '예상매출총세액'           	,width: 60  ,sortable: true ,dataIndex: 'EXP_SAL_TOTAL_TAX'         ,hidden : true}
							   , {header: '비고'                     ,width: 60  ,sortable: true ,dataIndex: 'NOTE'                      ,hidden : true}
							   , {header: '최종변경자ID'             	,width: 60  ,sortable: true ,dataIndex: 'FINAL_MOD_ID'              ,hidden : true}
							   , {header: '최종변경일시'             	,width: 60  ,sortable: true ,dataIndex: 'FINAL_MOD_DATE'    		,hidden : true}
							   , {header: '프로젝트구분명'           	,width: 60  ,sortable: true ,dataIndex: 'PJT_TYPE_CODE_NAME'        ,hidden : true}
							   , {header: '프로젝트담당자부서명'     	,width: 60  ,sortable: true ,dataIndex: 'PJT_OWN_DEPT_NAME'         ,hidden : true}
							   , {header: '프로젝트담당자명'         	,width: 60  ,sortable: true ,dataIndex: 'PJT_OWN_EMP_NAME'          ,hidden : true}
							   , {header: '프로젝트등록자부서코드'   	,width: 60  ,sortable: true ,dataIndex: 'PJT_REG_DEPT_NAME'         ,hidden : true}
							   , {header: '프로젝트등록자명'         	,width: 60  ,sortable: true ,dataIndex: 'PJT_REG_EMP_NAME'          ,hidden : true}
							   , {header: '유/무상'            		,width: 30  ,sortable: true ,dataIndex: 'PAY_FREE_NAME'             ,hidden : true}
							   , {header: '진행상태명'               	,width: 55  ,sortable: true ,dataIndex: 'PROC_STATUS_NAME'            }
							   , {header: '업무구분명'               	,width: 60  ,sortable: true ,dataIndex: 'ROLL_TYPE_NAME'            ,hidden : true}
							   
							   , {header: '거래처코드'               	,width: 10  ,sortable: true ,dataIndex: 'CUSTOM_CODE'            	,hidden : true}
							   , {header: '거래처명'               	,width: 10  ,sortable: true ,dataIndex: 'CUSTOM_NAME'            	,hidden : true}
							   , {header: '거래처담당자번호'           ,width: 10  ,sortable: true ,dataIndex: 'COSTOMER_NUM'            	,hidden : true}
							   , {header: '거래처담당자'              	,width: 10  ,sortable: true ,dataIndex: 'CUSTOMER_NAME'            	,hidden : true}
							   , {header: '거래처부서'              	,width: 10  ,sortable: true ,dataIndex: 'CUSTOMER_DEPT_NAME'        ,hidden : true}
							   , {header: '거래처연락처'              	,width: 10  ,sortable: true ,dataIndex: 'CUSTOMER_TELEPHONE'        ,hidden : true} 
							   
							   
							   
							   
						   ];	 

/***************************************************************************
 * 그리드 결과매핑 
 ***************************************************************************/
var mappingColumns_1st_pop = [ 
							  	 {name: 'FLAG'              , allowBlank: false        }     //조회상태'                          
							   , {name: 'PJT_ID'            , allowBlank: false        }     //프로젝트ID'                        
							   , {name: 'PJT_TYPE_CODE'     , allowBlank: false        }     //프로젝트구분코드'                   
							   , {name: 'PJT_NAME'          , allowBlank: false        }     //프로젝트명'                        
							   , {name: 'PJT_REG_DATE'      , allowBlank: false        }     //등록일자'                 
							   , {name: 'PJT_DATE_FROM'     , allowBlank: false        }     //프로젝트기간 FROM'        
							   , {name: 'PJT_DATE_TO'       , allowBlank: false        }     //프로젝트기간 TO'                   
							   , {name: 'PJT_OWN_DEPT_CODE' , allowBlank: false        }     //프로젝트담당자부서코드'            
							   , {name: 'PJT_OWN_EMP_NUM'   , allowBlank: false        }     //프로젝트담당자사번'       
							   , {name: 'PJT_REG_DEPT_CODE' , allowBlank: false        }     //프로젝트등록자부서코드'   
							   , {name: 'PJT_REG_EMP_NUM'   , allowBlank: false        }     //프로젝트등록자사번'       
							   , {name: 'ROLL_TYPE_CODE'    , allowBlank: false        }     //업무구분코드'             
							   , {name: 'ORDER_POSSBLE'     , allowBlank: false        }     //수주가능성'               
							   , {name: 'PAY_FREE_CODE'     , allowBlank: false        }     //유/무상구분코드'          
							   , {name: 'ORDER_EXP_DATE'    , allowBlank: false        }     //수주예정일'               
							   , {name: 'BID_DDAY'          , allowBlank: false        }     //제안(입찰)마감일'         
							   , {name: 'PROC_STATUS_CODE'  , allowBlank: false        }     //진행상태코드'             
							   , {name: 'PJT_SUMMARY'       , allowBlank: false        }     //개요및특이사항'           
							   , {name: 'EXP_SAL_TOTAL_AMT' , allowBlank: false        }     //예상매출총액'             
							   , {name: 'EXP_SAL_TOTAL_TAX' , allowBlank: false        }     //예상매출총세액'           
							   , {name: 'NOTE'              , allowBlank: false        }     //비고'                     
							   , {name: 'FINAL_MOD_ID'      , allowBlank: false        }     //최종변경자ID'             
							   , {name: 'FINAL_MOD_DATE'    , allowBlank: false		   }     //최종변경일시'             
							   , {name: 'PJT_TYPE_CODE_NAME'  , allowBlank: false      }     //프로젝트구분명'           
							   , {name: 'PJT_OWN_DEPT_NAME'   , allowBlank: false      }     //프로젝트담당자부서명'     
							   , {name: 'PJT_OWN_EMP_NAME'    , allowBlank: false      }     //프로젝트담당자명'         
							   , {name: 'PJT_REG_DEPT_NAME'   , allowBlank: false      }     //프로젝트등록자부서코드'   
							   , {name: 'PJT_REG_EMP_NAME'    , allowBlank: false      }     //프로젝트등록자명'         
							   , {name: 'PAY_FREE_NAME'       , allowBlank: false      }     //유/무상구분명'            
							   , {name: 'PROC_STATUS_NAME'    , allowBlank: false      }     //진행상태명'               
							   , {name: 'ROLL_TYPE_NAME'      , allowBlank: false      }     //업무구분명'
							   
							   , {name: 'CUSTOM_CODE'      , allowBlank: false        	}
							   , {name: 'CUSTOM_NAME'      , allowBlank: false        	}
							   , {name: 'COSTOMER_NUM'     , allowBlank: false       	}
							   , {name: 'CUSTOMER_NAME'    , allowBlank: false      	}
							   , {name: 'CUSTOMER_DEPT_NAME'    , allowBlank: false     }
							   , {name: 'CUSTOMER_TELEPHONE'    , allowBlank: false     }
							   
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

	var sForm = document.searchForm;

	sForm.src_pjt_date_from.value = sForm.src_pjt_date_from_tmp.value.replace(/-/g,"");		   	 
	sForm.src_pjt_date_to.value = sForm.src_pjt_date_to_tmp.value.replace(/-/g,"");	

 
	Ext.Ajax.request({   
		url: "/pjt/pjtManage/pjtInfoPopList.sg"
		,method : 'POST'   
		,success: function(response){						
					handleSuccess(response,GridClass_1st_pop);
		          }
		,failure: handleFailure   
		,form	: document.searchForm
		,params : {				
					  start 	    : start_1st_pop
    				, limit         : limit_1st_pop 
    				
    				
    				
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

	// 검색시작일자
	var startDate = new Ext.form.DateField({
    	applyTo: 'src_pjt_date_from_tmp',
		allowBlank: false,
		format:'Y-m-d',
		editable : false
	});
   	
	// 검색종료일자
	var endDate = new Ext.form.DateField({
    	applyTo: 'src_pjt_date_to_tmp',
		allowBlank: false,
		format:'Y-m-d',
		editable : false
	});
	
	document.searchForm.src_pjt_type_code.value="<%=src_pjt_type_code%>";
	//Ext.get('src_pjt_type_code').dom.disabled   = true;
	
});

/***************************************************************************
 * 설  명 : 그리드의 페이지 클릭시 검색조건값을 DB로 전송
 ***************************************************************************/
function fnPagingValue_1st_pop(){
	var sForm = document.searchForm;
	
	try{
		GridClass_1st_pop.store.setBaseParam('start'		  ,start_1st_pop);
    	GridClass_1st_pop.store.setBaseParam('limit'		  ,limit_1st_pop);
    	
    	
    	GridClass_1st_pop.store.setBaseParam('src_pjt_type_code',"<%=src_pjt_type_code%>");
    	GridClass_1st_pop.store.setBaseParam('src_pjt_name'	  ,Ext.get('src_pjt_name').getValue());
		
		GridClass_1st.store.setBaseParam('src_pjt_date_from' ,Ext.get('src_pjt_date_from').getValue()); 	// 프로젝트기간(검색시작일
		GridClass_1st.store.setBaseParam('src_pjt_date_to'   ,Ext.get('src_pjt_date_to').getValue());    	 // 프로젝트기간(검색종료일)    	
    	
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
		window.opener.fnPjtPopValue(records, '<%=fieldName%>');		//부모창으로 함수호출
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
				<input type="hidden" id="src_pjt_date_from" name="src_pjt_date_from"  />
				<input type="hidden" id="src_pjt_date_to" name="src_pjt_date_to"  />
				
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
												<label class="x-form-item-label" style="width: auto;" for="src_pjt_type_code">구분코드 :</label>
												<div style="padding-left: 30px;" class="x-form-element">
													<select name="src_pjt_type_code" id="src_pjt_type_code" style="width: 60%;" type="text" class=" x-form-select x-form-field" >
														<option value="">전체</option>
														<c:forEach items="${PJT_TYPE_CODE}" var="data" varStatus="status">
														<option value="${data.COM_CODE}"><c:out value="${data.COM_CODE_NAME}"/></option>
														</c:forEach>
													</select>
												</div>
											</div>
										</td>
										<td width="20%">
											<div tabindex="-1" class="x-form-item " >
												<label class="x-form-item-label" style="width: auto;" for="src_pjt_name" >프로젝트명 :</label>
												<div style="padding-left: 80px;" class="x-form-element">
													<input type="text" name="src_pjt_name" id="src_pjt_name" autocomplete="off" size="15" class="x-form-text x-form-field" style="width: auto;">
												</div>
											</div>
										</td>										
									</tr>
									
									<tr>
										<td width="40%" colspan="2">
											<div tabindex="-1" class="x-form-item " >
												<label class="x-form-item-label" style="width: auto;" for="src_pjt_date_from_tmp" >프로젝트기간 :</label>
												<div style="padding-left: 30px;" >
													<table>
														<tr>
															<td>
																<input type="text" name="src_pjt_date_from_tmp" id="src_pjt_date_from_tmp" autocomplete="off" size="10" style="width: auto;">		
															</td>
															<td>
																~
															</td>
															<td>
																<input type="text" name="src_pjt_date_to_tmp" id="src_pjt_date_to_tmp" autocomplete="off" size="10" style="width: auto;">		
															</td>
														</tr>
													</table>
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