<%--
  Class Name  : scdExecPrpdInfoPop.jsp.jsp
  Description : 산출물조회 팝업
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
<script type="text/javascript" src="/resource/common/js/sgis-comm-inc.js" ></script> 
<script type="text/javascript" src="/resource/common/js/common/common-msg-box.js" ></script> 
<script type="text/javascript" src="/resource/common/js/ajax.js" ></script>

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
	String src_prod_reg_emp_num = request.getParameter("src_prod_reg_emp_num");
	String src_scd_day_seq = request.getParameter("src_scd_day_seq");
	
	

%>
<script type="text/javascript">

/***************************************************************************
 * 초기값 설정
 ***************************************************************************/
var	gridHeigth_1st_pop 	 	= 300; 								  // 그리드 전체 높이
var	gridWidth_1st_pop		= 410;								  // 그리드 전체 폭
var gridTitle_1st_pop 		= "산출물정보";	  				      // 그리드 제목
var	render_1st_pop			= "user-grid";	        			  // 렌더(화면에 그려질) 할 id 
var	pageSize_1st_pop		= 20;	  							  // 그리드 페이지 사이즈	
var	proxyUrl_1st_pop		= "/dev/scdInfo/dayInfo/resultScdExecPrpdInfoPop.sg"; // 결과 값 페이지
var limit_1st_pop			= pageSize_1st_pop;
var start_1st_pop			= 0;

/***************************************************************************
 * Grid의 컬럼 설정
 ***************************************************************************/
var userColumns_1st_pop =  [
							     checkSm
							   , {header: '조회상태'               ,width: 60  ,sortable: true ,dataIndex: 'FLAG'                      ,hidden : true}              
							   , {header: '일정수행산출물순번'     ,width: 60  ,sortable: true ,dataIndex: 'SCD_EXEC_PRPD_SEQ'         ,hidden : true}              
							   , {header: '일정관리순번'           	,width: 60  ,sortable: true ,dataIndex: 'SCD_DAY_SEQ'             ,hidden : true}               
							   , {header: '타스크그룹코드'         	,width: 60  ,sortable: true ,dataIndex: 'TASK_GROUP_CODE'         ,hidden : true}              
							   , {header: '타스크 코드'            	,width: 60  ,sortable: true ,dataIndex: 'TASK_CODE'              ,hidden : true}
							   , {header: '타스크명'            	,width: 60  ,sortable: true ,dataIndex: 'TASK_NAME'              }
							   , {header: '타스크산출물순번'       	,width: 60  ,sortable: true ,dataIndex: 'TASK_INFO_SEQ'             ,hidden : true}
							   , {header: '등록일자'         	,width: 60  ,sortable: true ,dataIndex: 'PROD_REG_DATE'               	}              
							   , {header: '등록자사번'       	,width: 60  ,sortable: true ,dataIndex: 'PROD_REG_EMP_NUM'         		,hidden : true}              
							   , {header: '등록자명'       	,width: 60  ,sortable: true ,dataIndex: 'PROD_REG_EMP_NAME'         		}              
							   , {header: '산출물파일명'           	,width: 60  ,sortable: true ,dataIndex: 'PROD_FILE_NAME'           	, renderer: changeBLUE}
							   , {header: '산출물저장파일경로'     ,width: 60  ,sortable: true ,dataIndex: 'PROD_FIL_PATH'         ,hidden : true}
							   , {header: '비고'                   ,width: 60  ,sortable: true ,dataIndex: 'NOTE'           		,hidden : true}
							   , {header: '최종변경자ID'           ,width: 60  ,sortable: true ,dataIndex: 'FINAL_MOD_ID'            ,hidden : true}
							   , {header: '최종변경일시'           ,width: 60  ,sortable: true ,dataIndex: 'FINAL_MOD_DATE'             ,hidden : true}
							   , {header: '등록자'                 ,width: 60  ,sortable: true ,dataIndex: 'REG_DATE'             ,hidden : true}
							   , {header: '등록일시'               ,width: 60  ,sortable: true ,dataIndex: 'REG_ID'            		,hidden : true}
							   , {header: '서버등록파일명'         ,width: 60  ,sortable: true ,dataIndex: 'SAVED_FILE_NAME'                  ,hidden : true}
						   ];	 

/***************************************************************************
 * 그리드 결과매핑 
 ***************************************************************************/
var mappingColumns_1st_pop = [ 
							  	 {name: 'FLAG'              , allowBlank: false        }     			//조회상태
							   , {name: 'SCD_EXEC_PRPD_SEQ'            , allowBlank: false        }     //일정수행산출물순번         
							   , {name: 'SCD_DAY_SEQ'     , allowBlank: false        }     				//일정관리순번               
							   , {name: 'TASK_GROUP_CODE'          , allowBlank: false        }     	//타스크그룹코드             
							   , {name: 'TASK_CODE'      , allowBlank: false        }     				//타스크 코드                
							   , {name: 'TASK_NAME'      , allowBlank: false        }     				//타스크 명                
							   , {name: 'TASK_INFO_SEQ'     , allowBlank: false        }     			//타스크산출물순번           
							   , {name: 'PROD_REG_DATE'       , allowBlank: false        }     			//산출물등록일자             
							   , {name: 'PROD_REG_EMP_NUM' , allowBlank: false        }     			//산출물등록자사번           
							   , {name: 'PROD_REG_EMP_NAME' , allowBlank: false        }     			//산출물등록자명         
							   , {name: 'PROD_FILE_NAME'   , allowBlank: false        }     			//산출물파일명               
							   , {name: 'PROD_FIL_PATH' , allowBlank: false        }     				//산출물저장파일경로         
							   , {name: 'NOTE'   , allowBlank: false        }     						//비고                       
							   , {name: 'FINAL_MOD_ID'    , allowBlank: false        }     				//최종변경자ID               
							   , {name: 'FINAL_MOD_DATE'     , allowBlank: false        }   	  		//최종변경일시               
							   , {name: 'REG_DATE'     , allowBlank: false        }     				//등록자                            
							   , {name: 'REG_ID'    , allowBlank: false        }     					//등록일시                           
							   , {name: 'SAVED_FILE_NAME'          , allowBlank: false        }     	//서버등록파일명             
		    				 ];
 
 
/***************************************************************************
 * 그리드 클릭시 Event
 ***************************************************************************/
function fnGridOnClick_1st_pop(store, rowIndex){

	window.opener.downLoadFile(fnFixNull(store.getAt(rowIndex).data.SCD_EXEC_PRPD_SEQ));		//부모창으로 함수호출
	window.close();	
	
	
}   

/***************************************************************************
 * 함수명 : fnSearch
 * 설  명 : 검색
***************************************************************************/
function fnSearch(){  	

	var sForm = document.searchForm;

 
	Ext.Ajax.request({   
		url: "/dev/scdInfo/dayInfo/resultScdExecPrpdInfoPop.sg"
		,method : 'POST'   
		,success: function(response){						
					handleSuccess(response,GridClass_1st_pop);
		          }
		,failure: handleFailure   
		,form	: document.searchForm
		,params : {				
					  start 	    : start_1st_pop
    				, limit         : limit_1st_pop 
    				, prod_file_name : Ext.get('src_prod_file_name').getValue()    				 
    				
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


/*
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
*/

	
	//document.searchForm.src_prod_reg_emp_num.value="<%=src_prod_reg_emp_num%>";
	
});

/***************************************************************************
 * 설  명 : 그리드의 페이지 클릭시 검색조건값을 DB로 전송
 ***************************************************************************/
function fnPagingValue_1st_pop(){
	var sForm = document.searchForm;
	
	try{
		GridClass_1st_pop.store.setBaseParam('start'		  ,start_1st_pop);
    	GridClass_1st_pop.store.setBaseParam('limit'		  ,limit_1st_pop);
    	
    	
    	GridClass_1st_pop.store.setBaseParam('src_prod_reg_emp_num',"<%=src_prod_reg_emp_num%>");
    	GridClass_1st_pop.store.setBaseParam('src_scd_day_seq',"<%=src_scd_day_seq%>");
    	
    	
    	GridClass_1st_pop.store.setBaseParam('src_prod_file_name'	  ,Ext.get('src_prod_file_name').getValue());
		 	
    	
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
		
	var sForm = document.searchForm;	// 상세 FORM
	
	var scdExecPrpdSeq = records[0].data.SCD_EXEC_PRPD_SEQ;


/*
	var dForm = document.detailForm;	// 상세 FORM
	
	dForm.target = "fileFrame";
	dForm.action="/dev/scdInfo/dayInfo/fileDownLoad.sg?scd_exec_prpd_seq="+scdExecPrpdSeq+"&start=0&limit=5";
    dForm.submit();
*/
	window.opener.downLoadFile(scdExecPrpdSeq);		//부모창으로 함수호출
	window.close();
	}
}


/***************************************************************************
 * 설  명 : 에디트 그리드의 CELL을 클릭하였을 경우 이벤트
 ***************************************************************************/
function  fnEdit1stCellClickEvent(grid, rowIndex, columnIndex, e){
	


}

</script>

</head>
<body>
	<table border="0" width="400" height="200">
		<tr>
			<td colspan="2">
			
			<form name="searchForm" id="searchForm">
				<input type="hidden" id="src_prod_reg_emp_num" name="src_prod_reg_emp_num"  value="<%=src_prod_reg_emp_num%>"/>
				<input type="hidden" id="src_scd_day_seq" name="src_scd_day_seq"  value="<%=src_scd_day_seq%>"/>
				
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
												<label class="x-form-item-label" style="width: auto;" for="src_prod_file_name" >산출물명 :</label>
												<div style="padding-left: 80px;" class="x-form-element">
													<input type="text" name="src_prod_file_name" id="src_prod_file_name" autocomplete="off" size="15" class="x-form-text x-form-field" style="width: auto;">
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
				
				<form id="detailForm" name="detailForm" method="POST" class="x-panel-body x-form" style="padding: 1px 1px 0pt; ">
					<iframe name="fileFrame" id="fileFrame" style="display:none; position:absolute; left:0; top:0; width:0; height:0" FrameBorder="0"></iframe>	
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