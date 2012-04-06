<%--
  Class Name  : statusManageList.jsp
  Description : 프로젝트 진행상태(전체)
  Modification Information
 
      수정일                   수정자                 수정내용
  -------      --------    ---------------------------
  2011. 04. 26   여인범            최초 생성   
  
  author   : 여인범
  since    :  2011. 04. 26.
  version  : 1.0
   
  Copyright (C) 2011 by SG All right reserved.
--%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/web/jsp/common/inc/commonInc.jsp" %>

<script type="text/javascript" src="/resource/common/js/sgis-comm-inc.js" ></script> 
<script type="text/javascript" src="/resource/common/js/common/common-msg-box.js" ></script> 
<script type="text/javascript" src="/resource/common/js/ajax.js" ></script>

<script type="text/javascript" src="/resource/common/js/grid/grid_edit_1st.js"></script>
 
<script type="text/javascript"> 
 
/***************************************************************************
 * 설  명 : 이슈처리 설정 
***************************************************************************/
var	gridHeigth_edit_1st	= 400;
var	gridWidth_edit_1st  = 1400	;
var	gridTitle_edit_1st  = "프로젝트 진행상태(통합)"; 
var	render_edit_1st		= "edit_grid_1st";
var keyNm_edit_1st		= "PJT_ID";
var pageSize_edit_1st	= 15;
var limit_edit_1st		= pageSize_edit_1st;
var start_edit_1st		= 0;
var proxyUrl_edit_1st	= "/pjt/pjtManage/statusManageListResult.sg"; 
var gridRowDeleteYn	    = "";
var tbarHidden_edit_1st = "Y";
 

// 페이징
function fnPagingValue_edit_1st(){	
	try{
		
		GridClass_edit_1st.store.setBaseParam('start'		,start_edit_1st);
	    GridClass_edit_1st.store.setBaseParam('limit'		,limit_edit_1st);
	    
	  	GridClass_edit_1st.store.setBaseParam('src_pjt_date_from'	,Ext.get('src_pjt_date_from').getValue().replaceAll("-", ""));
	    GridClass_edit_1st.store.setBaseParam('src_pjt_date_to'		,Ext.get('src_pjt_date_to').getValue().replaceAll("-", ""));
	    
	}catch(e){

	}
}

/** 진행현황코드 combo box 생성 start **/
var PJT_STATUS_CODE_COMBO = new Ext.form.ComboBox({    
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
					 
					<c:forEach items="${PJT_STATUS_CODE}" var="data" varStatus="status">
						['${data.COM_CODE}', '${data.COM_CODE_NAME}']
						<c:if test="${not status.last}">,</c:if>
					</c:forEach>
				  ]
			})
});
//combo box render
Ext.util.Format.comboRenderer = function(PJT_STATUS_CODE_COMBO){    
	return function(value){        
	var record = PJT_STATUS_CODE_COMBO.findRecord(PJT_STATUS_CODE_COMBO.valueField, value);        
	return record ? record.get(PJT_STATUS_CODE_COMBO.displayField) : PJT_STATUS_CODE_COMBO.valueNotFoundText;    
}}
/** 진행현황코드 combo box 생성 end **/
 


// 그리드 필드
var	userColumns_edit_1st	= [  
								 {header: "프로젝트ID"           ,	width: 100,	sortable: true,	dataIndex: "PJT_ID"           	,editor: new Ext.form.TextField({ allowBlank : false }), hidden:false, editable:false}
								,{header: "프로젝트"             ,	width: 100,	sortable: true,	dataIndex: "PJT_NAME"           ,editor: new Ext.form.TextField({ allowBlank : false }), hidden:false, editable:false}
								
								,{header: "진행상태코드"   	   ,	width: 100,	sortable: true,	dataIndex: "PROC_STATUS_CODE"   ,editor: PJT_STATUS_CODE_COMBO  ,renderer: Ext.util.Format.comboRenderer(PJT_STATUS_CODE_COMBO)}
								,{header: "진행상태"			   ,	width: 100,	sortable: true,	dataIndex: "PROC_STATUS_CODE_NM",editor: new Ext.form.TextField({ allowBlank : false }), hidden:true, editable:false}
								
								,{header: "이력"			   	   ,	width: 50,	sortable: true,	dataIndex: "HIS"				,editor: new Ext.form.TextField({ allowBlank : false }), hidden:false, editable:false, renderer:changeBLUE}
								,{header: "이슈"			   	   ,	width: 50,	sortable: true,	dataIndex: "REG_ISSUE"			,editor: new Ext.form.TextField({ allowBlank : false }), hidden:false, editable:false, renderer:changeBLUE}
								
								,{header: "EST_ID"             ,	width: 10,	sortable: true,	dataIndex: "EST_ID"             ,editor: new Ext.form.TextField({ allowBlank : false }), hidden:true, editable:false}
								,{header: "EST_MOD_ID"         ,	width: 10,	sortable: true,	dataIndex: "EST_MOD_ID"         ,editor: new Ext.form.TextField({ allowBlank : false }), hidden:true, editable:false}
								,{header: "견적확정인"           ,	width: 100,	sortable: true,	dataIndex: "EST_MOD_NM"         ,editor: new Ext.form.TextField({ allowBlank : false }), hidden:false, editable:false}
								,{header: "견적확정일"       	   ,	width: 100,	sortable: true,	dataIndex: "EST_MOD_DATE"       ,editor: new Ext.form.TextField({ allowBlank : false }), hidden:false, editable:false}
								
								,{header: "ORD_ID"             ,	width: 10,	sortable: true,	dataIndex: "ORD_ID"             ,editor: new Ext.form.TextField({ allowBlank : false }), hidden:true, editable:false}
								,{header: "ORD_MOD_ID"         ,	width: 10,	sortable: true,	dataIndex: "ORD_MOD_ID"         ,editor: new Ext.form.TextField({ allowBlank : false }), hidden:true, editable:false}
								,{header: "수주확정인"	       ,	width: 100,	sortable: true,	dataIndex: "ORD_MOD_NM"         ,editor: new Ext.form.TextField({ allowBlank : false }), hidden:false, editable:false}
								,{header: "수주확정일"       	   ,	width: 100,	sortable: true,	dataIndex: "ORD_MOD_DATE"       ,editor: new Ext.form.TextField({ allowBlank : false }), hidden:false, editable:false}
								
								,{header: "PUR_ID"             ,	width: 10,	sortable: true,	dataIndex: "PUR_ID"             ,editor: new Ext.form.TextField({ allowBlank : false }), hidden:true, editable:false}
								,{header: "PUR_MOD_ID"         ,	width: 10,	sortable: true,	dataIndex: "PUR_MOD_ID"         ,editor: new Ext.form.TextField({ allowBlank : false }), hidden:true, editable:false}
								,{header: "구매확정인"           ,	width: 100,	sortable: true,	dataIndex: "PUR_MOD_NM"         ,editor: new Ext.form.TextField({ allowBlank : false }), hidden:false, editable:false}
								,{header: "구매확정일"       	   ,	width: 100,	sortable: true,	dataIndex: "PUR_MOD_DATE"       ,editor: new Ext.form.TextField({ allowBlank : false }), hidden:false, editable:false}
								
								,{header: "SAL_ID"             ,	width: 10,	sortable: true,	dataIndex: "SAL_ID"             ,editor: new Ext.form.TextField({ allowBlank : false }), hidden:true, editable:false}
								,{header: "SAL_MOD_ID"         ,	width: 10,	sortable: true,	dataIndex: "SAL_MOD_ID"         ,editor: new Ext.form.TextField({ allowBlank : false }), hidden:true, editable:false}
								,{header: "매출등록인"           ,	width: 100,	sortable: true,	dataIndex: "SAL_MOD_NM"         ,editor: new Ext.form.TextField({ allowBlank : false }), hidden:false, editable:false}
								,{header: "매출등록일"       	   ,	width: 100,	sortable: true,	dataIndex: "SAL_MOD_DATE"       ,editor: new Ext.form.TextField({ allowBlank : false }), hidden:false, editable:false}								 
							  ];

// 맵핑 필드
var	mappingColumns_edit_1st	= [  
							         {name:"PJT_ID"             	,type:"string"		,mapping:"PJT_ID"             }
									,{name:"PJT_NAME"           	,type:"string"		,mapping:"PJT_NAME"           }
									,{name:"PROC_STATUS_CODE"   	,type:"string"		,mapping:"PROC_STATUS_CODE"   }
									,{name:"HIS"   					,type:"string"		,mapping:"HIS"   			  }
									,{name:"REG_ISSUE"   			,type:"string"		,mapping:"REG_ISSUE"   		  }
									,{name:"PROC_STATUS_CODE_NM"	,type:"string"		,mapping:"PROC_STATUS_CODE_NM"}
									,{name:"EST_ID"             	,type:"string"		,mapping:"EST_ID"             }
									,{name:"EST_MOD_ID"         	,type:"string"		,mapping:"EST_MOD_ID"         }
									,{name:"EST_MOD_NM"         	,type:"string"		,mapping:"EST_MOD_NM"         }
									,{name:"EST_MOD_DATE"       	,type:"string"		,mapping:"EST_MOD_DATE"       }
									,{name:"ORD_ID"             	,type:"string"		,mapping:"ORD_ID"             }
									,{name:"ORD_MOD_ID"         	,type:"string"		,mapping:"ORD_MOD_ID"         }
									,{name:"ORD_MOD_NM"         	,type:"string"		,mapping:"ORD_MOD_NM"         }
									,{name:"ORD_MOD_DATE"       	,type:"string"		,mapping:"ORD_MOD_DATE"       }
									,{name:"PUR_ID"             	,type:"string"		,mapping:"PUR_ID"             }
									,{name:"PUR_MOD_ID"         	,type:"string"		,mapping:"PUR_MOD_ID"         }
									,{name:"PUR_MOD_NM"         	,type:"string"		,mapping:"PUR_MOD_NM"         }
									,{name:"PUR_MOD_DATE"       	,type:"string"		,mapping:"PUR_MOD_DATE"       }
									,{name:"SAL_ID"             	,type:"string"		,mapping:"SAL_ID"             }
									,{name:"SAL_MOD_ID"         	,type:"string"		,mapping:"SAL_MOD_ID"         }
									,{name:"SAL_MOD_NM"         	,type:"string"		,mapping:"SAL_MOD_NM"         }
									,{name:"SAL_MOD_DATE"       	,type:"string"		,mapping:"SAL_MOD_DATE"       }
	    				 	  ]; 
 

/***************************************************************************
 * 설  명 : 필드 초기화
 **************************************************************************/
function fnInitValue(){
  
	try{
		GridClass_edit_1st.store.commitChanges();	 
		GridClass_edit_1st.store.removeAll();	 
	}catch(e){
		
	}
}


/***************************************************************************
 * 설  명 : 검색
 **************************************************************************/
function fnSearch(){
	
	fnInitValue();
	
	Ext.Ajax.request({   
		url: "/pjt/pjtManage/statusManageListResult.sg"
		,method : 'POST'   
		,success: function(response){
					handleSuccess(response,GridClass_edit_1st);
				 }   							
		,failure: handleFailure   	   						  
		,params : {					   						
						limit              	: limit_edit_1st
					  , start              	: start_edit_1st
					  
					  , src_pjt_id   	   	: Ext.get('src_pjt_id').getValue()
					  , src_pjt_name    	: Ext.get('src_pjt_name').getValue()
				  	  
					  , src_proc_status_code: Ext.get('src_proc_status_code').getValue()   
				  	   
				  	  , src_pjt_date_from   : Ext.get('src_pjt_date_from').getValue().replaceAll("-", "")
				  	  , src_pjt_date_to     : Ext.get('src_pjt_date_to').getValue().replaceAll("-", "")
				  	  , src_pjt_type_code   : Ext.get('src_pjt_type_code').getValue()
				  
				  }				
	});  
	
} 

/***************************************************************************
 * 설  명 : 저장버튼 클릭
 ***************************************************************************/
function fnSave(){  
																					 
	var records = GridClass_edit_1st.store.getModifiedRecords();	  
    var edit1stJson = "[";
	    for (var i = 0; i < records.length; i++) { 
	    	
	    	edit1stJson += Ext.util.JSON.encode(records[i].data);				
	      if (i < (records.length-1)) {
	        edit1stJson += ",";
	      }
	    }
    	edit1stJson += "]"
     
	Ext.Ajax.request({   
		url: "/pjt/pjtManage/statusActionPjtManage.sg"
		,success: function(response){
					handleSuccess(response,GridClass_edit_1st,'save');
		          } 
		,failure: handleFailure  
			
		,params : {
				      limit          		: limit_edit_1st
			  	  	, start          		: start_edit_1st 
			  	  
			  	  	, edit3rdData		    : edit1stJson 
  				  
				  	, src_pjt_id   	   		: Ext.get('src_pjt_id').getValue()   
				  	, src_proc_status_code	: Ext.get('src_proc_status_code').getValue()  
				  	, src_pjt_name    		: Ext.get('src_pjt_name').getValue()
				  	
				  	, src_pjt_date_from   : Ext.get('src_pjt_date_from').getValue().replaceAll("-", "")
				  	, src_pjt_date_to     : Ext.get('src_pjt_date_to').getValue().replaceAll("-", "")
				  	, src_pjt_type_code   : Ext.get('src_pjt_type_code').getValue()
				  	
				  	 
				  }  		
	});  

	fnInitValue();
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
	
	
    // 검색버튼 클릭
	Ext.get('searchBtn').on('click', function(e){
        if(Validator.validate(sForm)){
			fnSearch();
		}	
    });
    
   	//조건해제 버튼 -> 검색조건 초기화
   	Ext.get('searchClearBtn').on('click', function(e){
        sForm.reset();	
    });
   	
   
  	//저장 버튼 -> 데이터를 server로 전송
	Ext.get('saveBtn').on('click', function(e){	 
	   Ext.MessageBox.confirm('Confirm', '저장하시겠습니까?', showResult);
		
	});
	 
	
	// 검색시작일자
	var src_pjt_date_from = new Ext.form.DateField({
    	applyTo: 'src_pjt_date_from',
		allowBlank: false,
		format:'Y-m-d',
		editable : false,
		value : fromDay
	});
   	
	// 검색종료일자
	var src_pjt_date_to = new Ext.form.DateField({
    	applyTo: 'src_pjt_date_to',
		allowBlank: false,
		format:'Y-m-d',
		editable : false,
		value : toDay
	});
	  
	fnInitValue();
	
}); // end Ext.onReady

// 저장, 수정버튼 클릭시 '예','아니오' 
function showResult(btn){
   	if(btn == 'yes'){
   		fnSave();
   	}    	
};
	
 
// 팝업
function fnOpenPop(sURL, dlgWidth, dlgHeight, winName){
  var xPos=(window.screen.width) ? (window.screen.width-dlgWidth)/2 : 0;
  var yPos=(window.screen.height) ? (window.screen.height-dlgHeight)/2 : 0;
  var sFeatures = "titlebar=no, scrollbars=no,location=no ,menubar=no, resizable=no, status=yes, width="+dlgWidth+",height="+dlgHeight+",left="+xPos+", top="+yPos;
  window.open(sURL,winName, sFeatures);
}


// 프로젝트 진행상태 이력 조회 **************************************************
function fnHisPop(param){
	var sURL      = "/pjt/pjtManage/pjtStatusHISPop.sg"+param;
	var dlgWidth  = 399;
	var dlgHeight = 300;
	var winName   = "history";
	fnOpenPop(sURL, dlgWidth, dlgHeight, winName);
} 
 

function fnIssuePopUp(param){
	var sURL      = "/pjt/pjtIssue/pjtIssueList.sg"+param;
	var dlgWidth  = 1000;
	var dlgHeight = 250;
	var winName   = "이슈등록";
	fnOpenPop(sURL, dlgWidth, dlgHeight, winName);
}
/***************************************************************************
 * 설  명 : 에디트 그리드의 CELL을 클릭하였을 경우 이벤트
 ***************************************************************************/
function  fnEdit1stCellClickEvent(grid, rowIndex, columnIndex, e){
	
	var record = GridClass_edit_1st.grid.selModel.getSelected();  
	var pjt_id 		= record.data.PJT_ID;  
	
	if(columnIndex == '4'){ 
		var param = "?grd_pjt_id="+pjt_id;
		fnHisPop(param);		 
	} 
	
	if(columnIndex == '5'){
		fnIssuePopUp("?popUp_YN=Y&src_pjt_id="+pjt_id);
	}
} 

</script>

</head>
<body class=" ext-gecko ext-gecko3">
	<table border="0" width="1000" height="200">
		<tr>
			<td colspan="2">
				<form name="searchForm" id="searchForm">
				<!----------------- SEARCH Hearder Start	 ----------------->
				<div id="ext-comp-1002" class=" x-panel x-form-label-left" style="margin-top: 0.4em;"><%-- 0em <- 1em으로 수정하면 상위 공백 --%>
					<div class="x-panel-tl">
						<div class="x-panel-tr">
							<div class="x-panel-tc">
								<div id="ext-gen4" class="x-panel-header x-unselectable" style="-moz-user-select: none;">
									<span id="ext-gen8" class="x-panel-header-text">프로젝트 검색</span>
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
								<table border="0" width="100%">
						    		<%-- 1 Row Start --%> 
						    		<tr>
										<td width="25%">
											<div tabindex="-1" class="x-form-item " >
												<label class="x-form-item-label" style="width: auto;" for="src_pjt_id" >프로젝트ID :</label>
												<div style="padding-left: 0px;" class="x-form-element">
													<input type="text" name="src_pjt_id" id="src_pjt_id" autocomplete="off" size="22" class=" x-form-text x-form-field" style="width: auto;" />
												</div>
											</div>
										</td> 
										<td width="10%">&nbsp;</td>
										<td width="25%">
											<div tabindex="-1" class="x-form-item " >
												<label class="x-form-item-label" style="width: auto;" for="src_pjt_id" >프로젝트명:</label>
												<div style="padding-left: 0px;" class="x-form-element">
													<input type="text" name="src_pjt_name" id="src_pjt_name" autocomplete="off" size="22" class=" x-form-text x-form-field" style="width: auto;" />
												</div>
											</div>
										</td>
										<td width="10%">&nbsp;</td> 
										<td width="30%" align="left">
											<div tabindex="-1" class="x-form-item " >
												<label class="x-form-item-label" style="width: auto;" for="src_proc_status_code" >진행상태 :</label>
												<div style="padding-left: 0px;" class="x-form-element">
													<select name="src_proc_status_code" id="src_proc_status_code" title="진행상태" style="width: 150;" type="text" class=" x-form-select x-form-field" >
														<option value="">선택하세요</option>
														<c:forEach items="${PJT_STATUS_CODE}" var="data" varStatus="status">
															<option value="${data.COM_CODE}"><c:out value="${data.COM_CODE_NAME}"/></option>
														</c:forEach>
													</select>		
												</div>
											</div>
										</td> 
									</tr>
									<%-- 1 Row End --%>
									<tr>
										<td>
											<div tabindex="-1" class="x-form-item " >
												<label class="x-form-item-label" style="width: auto;" for="src_pjt_date_from" ><font color="red"> </font>사업구분 :</label>
												<div style="padding-left: 70px;" class="x-form-element">
													<table>
														<tr>
															<td>
																<select name="src_pjt_type_code" id="src_pjt_type_code" title="사업구분" style="width: 135px;" type="text" class=" x-form-select x-form-field" />
																	<option value="">선택하세요</option>
																	<c:forEach items="${PJT_TYPE_CODE}" var="data" varStatus="status">
																		<c:if test="${data.COM_CODE=='10' || data.COM_CODE=='20'}">	
																			<option value="${data.COM_CODE}" <c:if test="${data.COM_CODE == pMap.src_pjt_type_code}">selected='selected'</c:if> ><c:out value="${data.COM_CODE_NAME}"/></option>
																		</c:if>
																	</c:forEach>
																</select>
															</td> 
														</tr>
													</table>
												</div>
											</div>
										</td>
										<td width="10%">&nbsp;</td>  
										<td colspan="3" width="">
											<div tabindex="-1" class="x-form-item " >
												<label class="x-form-item-label" style="width: auto;" for="src_pjt_date_from" ><font color="red"> </font>기간 :</label>
												<div style="padding-left: 70px;" class="x-form-element">
													<table>
														<tr>
															<td>
																<input type="text" name="src_pjt_date_from" id="src_pjt_date_from" autocomplete="off" size="14" style="width: auto;">		
															</td>
															<td>
																&nbsp;~&nbsp;
															</td>
															<td>
																<input type="text" name="src_pjt_date_to" id="src_pjt_date_to" autocomplete="off" size="14" style="width: auto;">		
															</td>
														</tr>
													</table>
												</div>
											</div>
										</td>
									</tr>
									<%-- 3 Row 버튼 Start --%>
									<tr align="right">
										<td colspan="5" style="padding-right: 30" align="right">
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
			<!----------------- 거래처정보 GRID START ----------------->
			<td width="100%" valign="top" colspan="2">
				<div id="edit_grid_1st" style="margin-top: 0.4em;"></div>
			</td>
			<!----------------- 거래처정보 GRID END ----------------->
		</tr>
		<tr height="10"></tr> 
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
											<button type="button" id="saveBtn" name="saveBtn" class=" x-btn-text">저장</button>
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

<%@ include file="/WEB-INF/web/jsp/sgis-bottom-inc.jsp" %>