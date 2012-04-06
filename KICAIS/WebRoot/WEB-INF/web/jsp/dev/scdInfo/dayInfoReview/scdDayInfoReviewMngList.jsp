<%--
  Class Name  : scdDayInfoReviewMngList.jsp
  Description : 개발프로젝트  검토
  Modification Information
 
      수정일                   수정자                 수정내용
  -------      --------    ---------------------------
  2011. 4. 01   이준영            최초 생성   

  
  author   : 이준영
  since    : 2011. 4. 01.
  version  : 1.0
   
  Copyright (C) 2011 by SG All right reserved.
--%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/web/jsp/common/inc/commonInc.jsp" %>
<html>
<head>

<script type="text/javascript" src="/resource/common/js/sgis-comm-inc.js" ></script> 
<script type="text/javascript" src="/resource/common/js/common/common-msg-box.js" ></script> 

<script type="text/javascript" src="/resource/common/js/ajax.js" ></script>
<script type="text/javascript" src="/resource/common/js/grid/grid_edit_1st.js"></script>

<script type="text/javascript">



// ********************************************************************* //
/** 서버스펙 EditGrid - edit_1st Start**/
var	gridHeigth_edit_1st	=	300;
var	gridWidth_edit_1st  =	1022;
var	gridTitle_edit_1st  =   "개발 프로젝트 관리"	; 
var	render_edit_1st		=	"scd_day_info_grid";
var keyNm_edit_1st		= 	"SCD_DAY_SEQ";
var pageSize_edit_1st	=	15;
var limit_edit_1st		=	pageSize_edit_1st;
var start_edit_1st		=	0;
var proxyUrl_edit_1st	=	"/dev/scdInfo/dayInfoReview/scdDayInfoReviewResult.sg";
var gridRowDeleteYn = "N";
var tbarHidden_edit_1st ="Y"

//에디트그리드 추가
function addNew_edit_1st(){

	
}

//에디트그리드 페이징
function fnPagingValue_edit_1st(){	
	
	
	try{
		
		GridClass_edit_1st.store.setBaseParam('start'			,start_edit_1st);
	    GridClass_edit_1st.store.setBaseParam('limit'			,limit_edit_1st);

		GridClass_edit_1st.store.setBaseParam('src_pjt_id'		,Ext.get('src_pjt_id').getValue());
		GridClass_edit_1st.store.setBaseParam('src_pjt_name'		,Ext.get('src_pjt_name').getValue());
		GridClass_edit_1st.store.setBaseParam('scd_plan_from_date'	,Ext.get('scd_plan_from_date').getValue());
		GridClass_edit_1st.store.setBaseParam('scd_plan_to_date'	,Ext.get('scd_plan_to_date').getValue());
		
	}catch(e){

	}

}


/** 이슈구분코드 combo box 생성 start **/
var TASK_CHK_RES_CODE_COMBO = new Ext.form.ComboBox({    
	typeAhead: true, 
	triggerAction: 'all',
	lazyRender:true,
	mode: 'local',
	valueField: 'value',
	displayField: 'displayText',
	valueNotFoundText: '',
	store: new Ext.data.ArrayStore({
			id: 0,
			fields: ['value', 'displayText'],
			data: [
					 
					<c:forEach items="${TASK_CHK_RES_CODE}" var="data" varStatus="status">
						['${data.COM_CODE}', '${data.COM_CODE_NAME}']
						<c:if test="${not status.last}">,</c:if>
					</c:forEach>
				  ]
			})
});
//combo box render
Ext.util.Format.comboRenderer = function(TASK_CHK_RES_CODE_COMBO){    
	return function(value){        
	var record = TASK_CHK_RES_CODE_COMBO.findRecord(TASK_CHK_RES_CODE_COMBO.valueField, value);        
	return record ? record.get(TASK_CHK_RES_CODE_COMBO.displayField) : TASK_CHK_RES_CODE_COMBO.valueNotFoundText;    
}}
/** 이슈구분코드 combo box 생성 end **/


// 그리드 필드
var	userColumns_edit_1st	= [ 
								{header:  '조회상태'           		, width: 60, sortable:true, dataIndex: 'FLAG'               		,hidden : true} 
								,{header: '프로젝트 아이디'	                 ,width: 70, sortable: true, dataIndex:'PJT_ID'    		    }                   	                                                     
								,{header: '프로젝트 명'                   ,width: 140, sortable: true, dataIndex:'PJT_NAME'                   }            	                                                                                             
								,{header: '타스크그룹'                     ,width: 60, sortable: true, dataIndex:'TASK_GROUP_CODE'              ,hidden : true}
								,{header: '타스크 그룹명'                  ,width: 60, sortable: true, dataIndex:'TASK_CODE_NAME'            	,hidden : true	}			                                                       
								,{header: '타스크 아이디'                 ,width: 60, sortable: true, dataIndex:'TASK_CODE'             ,hidden : true}            	                                                
								,{header: '타스크명'                     ,width: 50, sortable: true, dataIndex:'TASK_NAME'            		}				                                                
								,{header: '책임자사번'                   ,width: 60, sortable: true, dataIndex:'SCD_REG_EMP_NUM'               ,hidden : true}                                                               
								,{header: '책임자'                   ,width: 60, sortable: true, dataIndex:'SCD_REG_EMP_NAME'        ,hidden : true       }                                                               
								,{header: '담당자사번'                  ,width: 60, sortable: true, dataIndex:'EMP_NUM'				,hidden : true}			                                                              
								,{header: '담당자'                  ,width: 40, sortable: true, dataIndex:'EMP_NAME'				}			                                                              
								,{header: '계획시작일자'                  ,width: 60, sortable: true, dataIndex:'SCD_PLAN_FROM_DATE'             }            	
								,{header: '계획종료일자'                   ,width: 60, sortable: true, dataIndex:'SCD_PLAN_TO_DATE'          }                                                                                                         
								,{header: '일정관리순번'                ,width: 60, sortable: true, dataIndex:'SCD_DAY_SEQ'            ,hidden : true}                                                                   
								,{header: '검토결과'              ,width: 50, sortable: true, dataIndex:'TASK_CHK_RES_CODE', 	editor: TASK_CHK_RES_CODE_COMBO  ,renderer: Ext.util.Format.comboRenderer(TASK_CHK_RES_CODE_COMBO)         }                                                                                                                                                            
								,{header: '비고'                ,width: 100, sortable: true, dataIndex:'NOTE'       ,		editor: new Ext.form.TextField({ allowBlank : true, maxLength : 200, maxLengthText: '최대길이는 200자 입니다'}) }                   
								,{header: '타스크검토결과명'                ,width: 60, sortable: true, dataIndex:'TASK_CHK_RES_NAME'          ,hidden : true}                   
								,{header: '산출물'              		  ,width: 60, sortable: true, dataIndex:'SCD_EXEC_PRPD_SEQ'       ,hidden : true}                   
								,{header: '산출물'              		  ,width: 60, sortable: true, dataIndex:'SCD_EXEC_PRPD_SEQ_NM'       , renderer: changeBLUE}                   
								,{header: '타스크완료여부'                ,width: 60, sortable: true, dataIndex:'TASK_END_YN'       ,hidden : true}                   
								,{header: '타스크완료여부'                ,width: 70, sortable: true, dataIndex:'TASK_END_YN_NM'       }                   
								,{header: '타스크검토결과코드'                ,width: 60, sortable: true, dataIndex:'SAVED_TASK_CHK_RES_CODE'       ,hidden : true}                   
							   ];	

// 맵핑 필드
var	mappingColumns_edit_1st	= [  
								{name: "FLAG"               		 , type:"string", mapping:"FLAG"                	}  	    
								,{name: "PJT_ID"    		     , type:"string", mapping:"PJT_ID"    		    }	                                                     
								,{name: "PJT_NAME"                   , type:"string", mapping:"PJT_NAME"                  }                                                                                                                                      
								,{name: "TASK_GROUP_CODE"             , type:"string", mapping:"TASK_GROUP_CODE"            }                                        
								,{name: "TASK_CODE_NAME"            	     , type:"string", mapping:"TASK_CODE_NAME"            	}                                                   
								,{name: "TASK_CODE"              , type:"string", mapping:"TASK_CODE"           }                                             
								,{name: "TASK_NAME"            	     , type:"string", mapping:"TASK_NAME"            	}                                                
								,{name: "SCD_REG_EMP_NUM"                , type:"string", mapping:"SCD_REG_EMP_NUM"             }                                            
								,{name: "SCD_REG_EMP_NAME"                , type:"string", mapping:"SCD_REG_EMP_NAME"             }                                            
								,{name: "EMP_NUM"			     , type:"string", mapping:"EMP_NUM"			    }                                                      
								,{name: "EMP_NAME"			     , type:"string", mapping:"EMP_NAME"			    }                                                      
								,{name: "SCD_PLAN_FROM_DATE"              , type:"string", mapping:"SCD_PLAN_FROM_DATE"           } 
								,{name: "SCD_PLAN_TO_DATE"         , type:"string", mapping:"SCD_PLAN_TO_DATE"        }                                                                                      
								,{name: "SCD_DAY_SEQ"             , type:"string", mapping:"SCD_DAY_SEQ"          }                                                
								,{name: "TASK_CHK_RES_CODE"        , type:"string", mapping:"TASK_CHK_RES_CODE"       }                                                                                                                                         
								,{name: "NOTE"      , type:"string", mapping:"NOTE"     } 
								,{name: "TASK_CHK_RES_NAME"           , type:"string", mapping:"TASK_CHK_RES_NAME"        } 
								,{name: "SCD_EXEC_PRPD_SEQ"      , type:"string", mapping:"SCD_EXEC_PRPD_SEQ"     } 
								,{name: "SCD_EXEC_PRPD_SEQ_NM"      , type:"string", mapping:"SCD_EXEC_PRPD_SEQ_NM"     } 
								,{name: "TASK_END_YN"      , type:"string", mapping:"TASK_END_YN"     } 
								,{name: "TASK_END_YN_NM"      , type:"string", mapping:"TASK_END_YN_NM"     } 
								,{name: "SAVED_TASK_CHK_RES_CODE"      , type:"string", mapping:"TASK_CHK_RES_CODE"     } 
	    				 	  ]; 




/***************************************************************************
 * 설  명 : 에디트 그리드의 CELL을 클릭하였을 경우 이벤트
 ***************************************************************************/
function  fnEdit1stCellClickEvent(grid, rowIndex, columnIndex, e){
	
	var selRecord = grid.selModel.getSelections();
	
	if(columnIndex == '18' && selRecord[0].data.SCD_EXEC_PRPD_SEQ !=''){
		var param = "src_prod_reg_emp_num="+selRecord[0].data.EMP_NUM+"&src_scd_day_seq="+selRecord[0].data.SCD_DAY_SEQ;
		
		fnExecPrpdInfoPop(param);		 		
	}

}





/***************************************************************************
 * 설  명 : 에디트 그리드의 CELL을 수정하였을 경우 이벤트
 ***************************************************************************/
function  fnEdit1stAfterCellEdit(obj){
	var rowCnt = GridClass_edit_1st.store.getCount();  // Grid의 총갯수
	var totalATM = 0;
	var editedRow = obj.row;
	var editedColumn = obj.column;
	var editedValue = obj.value;
	var fieldName = obj.field;
	

}

function fnEdit1stAfterRowDeleteEvent(){
	
}


/** 서버스펙 EditGrid - edit_1st End**/


/***************************************************************************
 * 설  명 : 필드 초기화
 **************************************************************************/
function fnInitValue(){

	try{
		//GridClass_edit_1st.store.commitChanges();	// 변경된 record를 commit
		//GridClass_edit_1st.store.removeAll();		// store자료를 삭제

	}catch(e){
		
	}

}

/***************************************************************************
 * 설  명 : 검색
 **************************************************************************/
function fnSearch(){  	


	var sForm = document.searchForm;

	sForm.scd_plan_from_date.value = sForm.scd_plan_from_date_tmp.value.replaceAll('-','');		   	 
	sForm.scd_plan_to_date.value = sForm.scd_plan_to_date_tmp.value.replaceAll('-','');	


	
	Ext.Ajax.request({   
		url: "/dev/scdInfo/dayInfoReview/scdDayInfoReviewResult.sg"
		,method : 'POST'   
		,success: function(response){						// 조회결과 성공시
					// 조회된 결과값, store명
					handleSuccess(response,GridClass_edit_1st);
		          }
		,failure: handleFailure   	   // 조회결과 실패시  
		,form   : document.searchForm  // 검색 FORM
		,params : {					   // 조회조건을 DB로 전송하기위해서 조건값 설정
					limit          : limit_edit_1st
				  , start          : start_edit_1st
				  }				
	});  
	
	fnInitValue(); // 상세필드 초기화
}  		


/***************************************************************************
 * 설  명 :일정등록 상세검색
 **************************************************************************/
function fnEditGridListSearch(store, rowIndex){  	
		
	
}





/***************************************************************************
 * 설  명 : 저장버튼 클릭
 ***************************************************************************/
function fnSave(){  	

	var sForm = document.searchForm;	// 검색 FORM

	sForm.scd_plan_from_date.value = sForm.scd_plan_from_date_tmp.value.replaceAll('-','');		   	 
	sForm.scd_plan_to_date.value = sForm.scd_plan_to_date_tmp.value.replaceAll('-','');	

    var task_chk_res_code_chk =0;
    var task_end_yn_chk =0;

	// 변경된 상세정보 Grid의 record 
	var records = GridClass_edit_1st.store.getModifiedRecords();	  
	// 변경된 record의 자료를 json형식으로
    var edit1stJson = "[";
	    for (var i = 0; i < records.length; i++) {
	    
	    	if(records[i].data.SAVED_TASK_CHK_RES_CODE == '20')
	    	{
	    		task_chk_res_code_chk++;
	    		continue;
	    	}
	    	
			if(records[i].data.TASK_END_YN =='N')
	    	{
	    		task_end_yn_chk++;
	    		continue;
	    	}	    	

	      edit1stJson += Ext.util.JSON.encode(records[i].data);		
	      		
	      if (i < (records.length-1)) {
	        edit1stJson += ",";
	      }
	    }
    	edit1stJson += "]"	
   

	     
	     if(task_chk_res_code_chk > 0)
	     {
	     	Ext.Msg.alert('확인', '이미 완료처리 되었습니다.');
	     	//GridClass_edit_1st.store.reload();
	     	task_chk_res_code_chk =0;
	     	//return;
	     }


	     if(task_end_yn_chk > 0)
	     {
	     	Ext.Msg.alert('확인', '타스크가 미완료된 건이 있습니다.');
	     	//GridClass_edit_1st.store.reload();
	     	task_end_yn_chk =0;
	     	//return;
	     }	     
	     

			Ext.Ajax.request({   
				url: "/dev/scdInfo/dayInfoReview/actionScdDayInfoReview.sg"   
				,success: function(response){						// 조회결과 성공시
							// 조회된 결과값, store명
							//alert(response.responseText);
							var json = Ext.util.JSON.decode(response.responseText);
							
							if(json.success  == "false")
							{
								Ext.Msg.alert('확인', '이미 완료처리 되었습니다.');
							}
							
							handleSuccess(response,GridClass_edit_1st,'save');
		
				          }
				,failure: handleFailure   	    // 조회결과 실패시  
				,form   : document.searchForm   // 상세 FORM
				,params : { 
						   limit            : limit_edit_1st
						  , start           : start_edit_1st
						  , edit1stData		: edit1stJson 		// 프로젝트 상세(제품)정보
					      } 
			});  

			fnInitValue(); // 상세필드 초기화


}  		



/***************************************************************************
 * 설  명 : 삭제버튼 클릭
 ***************************************************************************/
function fnGridDeleteRow(selectedRecord){
	
	
	fnInitValue(); // 상세필드 초기화
}







/***************************************************************************
 * 설  명 : 화면 설정
 ***************************************************************************/
// ExtJS 진입함수
Ext.onReady(function() {


	var sForm = document.searchForm;
	

	var toDay = getTimeStamp(); 
	 toDay = toDay.replaceAll('-','');
	 toDay = addDate(toDay, 'M', -3);
	 toDay = toDay.substring(0,4)+"-"+toDay.substring(4,6)+"-"+toDay.substring(6,8);
	 var fromDay = toDay;
	 toDay = getTimeStamp().trim();
	 	
	
	//검색하기 버튼 
	Ext.get('searchBtn').on('click', function(e){
		fnSearch()
	});	
		
	//조건해제 버튼 -> 검색조건 초기화
	Ext.get('searchClearBtn').on('click', function(e){
		sForm.reset();
		Ext.get('scd_plan_from_date_tmp').set({value:fromDay} , false);
		Ext.get('scd_plan_to_date_tmp').set({value:toDay} , false);
	});	
			
	
			
	//등록 버튼 -> 데이터를 server로 전송
	Ext.get('saveBtn').on('click', function(e){	
			Ext.MessageBox.confirm('Confirm', '등록하시겠습니까?', showResult);
	});




	
	// 업무요청기간 from
	var enddt = new Ext.form.DateField({
	    	applyTo: 'scd_plan_from_date_tmp',
			allowBlank: false,
			format:'Y-m-d',
			editable : true,
			value : fromDay
	});
	
	Ext.get('scd_plan_from_date_tmp').on('change', function(e){	
		
		var val = Ext.get('scd_plan_from_date_tmp').getValue();
		var reVal = fnGridDateCheck(val);
		
		Ext.get('scd_plan_from_date_tmp').set({value:reVal} , false);
	});
	
	
	
	
	// 업무요청기간 to
	var enddt = new Ext.form.DateField({
	    	applyTo: 'scd_plan_to_date_tmp',
			allowBlank: false,
			format:'Y-m-d',
			editable : true,
			value : toDay
	});
	
	Ext.get('scd_plan_to_date_tmp').on('change', function(e){	
		
		var val = Ext.get('scd_plan_to_date_tmp').getValue();
		var reVal = fnGridDateCheck(val);
		
		Ext.get('scd_plan_to_date_tmp').set({value:reVal} , false);
	});
	
	
		

		
	
    fnInitValue();
  
});

// 저장, 수정버튼 클릭시 '예','아니오' 
function showResult(btn){
   	if(btn == 'yes'){
   		fnSave();
   	}    	
};



//프로젝트 검색 팝업을 띄우는 화면
function fnExecPrpdInfoPop(param){

	var sURL      = "/dev/scdInfo/dayInfoReview/scdExecPrpdInfoPop.sg?"+param;
	var dlgWidth  = 430;
	var dlgHeight = 415;
	var winName   = "SCDFILE";
	fnOpenPop(sURL, dlgWidth, dlgHeight, winName);
}



// 팝업
function fnOpenPop(sURL, dlgWidth, dlgHeight, winName){
  var xPos=(window.screen.width) ? (window.screen.width-dlgWidth)/2 : 0;
  var yPos=(window.screen.height) ? (window.screen.height-dlgHeight)/2 : 0;
  var sFeatures = "titlebar=no, scrollbars=yes,location=no ,menubar=no, resizable=yes, status=yes, width="+dlgWidth+",height="+dlgHeight+",left="+xPos+", top="+yPos;
  window.open(sURL,winName, sFeatures);
}


/***************************************************************************
 * 설  명 : 파일다운로드
 ***************************************************************************/
function downLoadFile(scdExecPrpdSeq){  	
    
	var dForm = document.detailForm;	// 상세 FORM
	
	dForm.action="/download.ddo?fid=scdInfofile&scd_exec_prpd_seq="+scdExecPrpdSeq;
    dForm.submit();    
     
}


</script>

</head>
<body>
	<table border="0" width="1000" height="200">
		<tr>
			<td colspan="2">
				<form name="searchForm">
				<input type="hidden" id="scd_plan_from_date" name="scd_plan_from_date"  />
				<input type="hidden" id="scd_plan_to_date" name="scd_plan_to_date"  />
				<input type="hidden" id="src_csr_dept_code" name="src_csr_dept_code"  />				<!-- 부서코드-->
				
				<!----------------- SEARCH Hearder Start	 ----------------->
				<div id="ext-comp-1002" class=" x-panel x-form-label-left" style="margin-top: 0.4em;"><%-- 0em <- 1em으로 수정하면 상위 공백 --%>
					<div class="x-panel-tl">
						<div class="x-panel-tr">
							<div class="x-panel-tc">
								<div id="ext-gen4" class="x-panel-header x-unselectable" style="-moz-user-select: none;">
									<span id="ext-gen8" class="x-panel-header-text">개발 프로젝트 정보 검색</span>
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
										
										<td width="15%">
											<div tabindex="-1" class="x-form-item " style="width: auto">
												<label class="x-form-item-label" style="width: 80px;" for="src_pjt_id" >프로젝트ID :</label>
												<div style="padding-left: 0px;" class="x-form-element">
													<input type="text" name="src_pjt_id" id="src_pjt_id" autocomplete="off" size="22" class=" x-form-text x-form-field" style="width: auto;"  />
												</div>
											</div>
										</td>
										<td width="15%">
											<div tabindex="-1" class="x-form-item " style="width: auto">
												<label class="x-form-item-label" style="width: 80px;" for="src_pjt_name" >프로젝트명 :</label>
												<div style="padding-left: 0px;" class="x-form-element">
													<input type="text" name="src_pjt_name" id="src_pjt_name" autocomplete="off" size="22" class=" x-form-text x-form-field" style="width: auto;"  />
												</div>
											</div>
										</td>
																						
										<td width="4%">
											<div tabindex="-1" class="x-form-item " >
												<label class="x-form-item-label"  for="scd_plan_from_date_tmp" >프로젝트 기간 :</label>
											</div>
										</td>										


										<td width="10%" align="left">
											<div tabindex="-1" class="x-form-item " >
													<table border="0" width="100%" >
														<tr>
															<td align="center">
																<input type="text" name="scd_plan_from_date_tmp" id="scd_plan_from_date_tmp"  style="width:80px; " >
															</td>
															<td align="left">~</td>
														    <td align="center">
																<input type="text" name="scd_plan_to_date_tmp" id="scd_plan_to_date_tmp"  style="width:80px;" >
															</td>
														</tr>
													</table>
											</div>
										</td>

									
									
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
				
				<form id="detailForm" name="detailForm" method="POST" class="x-panel-body x-form" style="padding: 1px 1px 0pt; ">
					<iframe name="fileFrame" id="fileFrame" style="display:none; position:absolute; left:0; top:0; width:0; height:0" FrameBorder="0"></iframe>	
				</form>				
			</td>
		</tr>
		
		<tr>
			<td width="100%" valign="top" colspan="2">
				<div id="scd_day_info_grid" style="margin-top: 0.4em;"></div> <!----------------- 그리드명을 동일하게 설정 ----------------->
			</td>
		</tr>
		
		<tr>
			<td colspan="2" align="center" height="35">
				<table>
					<tr>
						<td>
						<%-- 저장 버튼 Start --%>
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
											<button type="button" id="saveBtn" name="saveBtn" class=" x-btn-text">등록</button>
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
						<%-- 저장버튼 End	--%>
						</td>
					</tr>
				</table>
			</td>
		</tr>

		

	</table>
</body>

</html>