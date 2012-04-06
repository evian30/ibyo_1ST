<%--
  Class Name  : empVacList.jsp
  Description : 개인별휴가정보관리 
  Modification Information
 
      수정일              수정자                 수정내용
  -------      --------    ---------------------------
  2011. 3. 25.  이준영                 최초 생성
 
  author   : 이준영
  since    : 2011. 3. 28.
  version  : 1.0
   
  Copyright (C) 2011 by SG All right reserved.
--%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/web/jsp/common/inc/commonInc.jsp" %>
<html>
<head>

<script type="text/javascript" src="/resource/common/js/ajax.js" ></script>
<script type="text/javascript" src="/resource/common/js/grid/grid_edit_1st.js"></script>

<script type="text/javascript">


// ********************************************************************* //
/** 서버스펙 EditGrid - edit_1st Start**/
var	gridHeigth_edit_1st	=	"300";
var	gridWidth_edit_1st  	;
var	gridTitle_edit_1st  =   "개인별휴가정보"	; 
var	render_edit_1st		=	"empVac-grid";
var keyNm_edit_1st		= 	"EMP_VAC_SEQ";
var pageSize_edit_1st	=	15;
var limit_edit_1st		=	pageSize_edit_1st;
var start_edit_1st		=	0;
var proxyUrl_edit_1st	=	"/com/empVac/empVacInfoList.sg";
var edit1_add_btn_hidden = true;
var tbarHidden_edit_1st     = "Y";
	
function addNew_edit_1st(){
	
}

function fnPagingValue_edit_1st(){	
	
	
	try{
		
		GridClass_edit_1st.store.setBaseParam('start'			,start_edit_1st);
	    GridClass_edit_1st.store.setBaseParam('limit'			,limit_edit_1st);
	}catch(e){

	}

}

var	userColumns_edit_1st	= [ {header: '조회상태'                 ,width: 60  ,sortable: true ,dataIndex: 'FLAG'                      ,hidden : true}  
			 					,{header: "기준년도",	width: 100,	sortable: true,	dataIndex: "BASIC_YEAR" }
			 					,{header: "사원번호",	width: 100,	sortable: true,	dataIndex: "EMP_NUM"  }
							 	,{header: "사원명",		width: 100,	sortable: true,	dataIndex: "KOR_NAME" }
								,{header: "총휴가일수",	width: 100,	sortable: true,	dataIndex: "VAC_TOT_DAYS" }
								,{header: "연차휴가",	width: 100,	sortable: true,	dataIndex: "VAC_DAYS_01",		editor: new Ext.form.NumberField({ allowBlank : false, maxLength:3, minValue :0  }) }
								,{header: "자기개발휴가",width: 100,	sortable: true,	dataIndex: "VAC_DAYS_02",		editor: new Ext.form.NumberField({ allowBlank : false, maxLength:3, minValue :0  }) }
								,{header: "장기근속휴가",width: 100,	sortable: true,	dataIndex: "VAC_DAYS_03",		editor: new Ext.form.NumberField({ allowBlank : false, maxLength:3, minValue :0 }) }
								,{header: "대체휴가",	width: 100,	sortable: true,	dataIndex: "VAC_DAYS_04",	editor: new Ext.form.NumberField({ allowBlank : false, maxLength:3, minValue :0 }) }
								,{header: "비정산휴가",	width: 100,	sortable: true,	dataIndex: "VAC_DAYS_05",		editor: new Ext.form.NumberField({ allowBlank : false, maxLength:3, minValue :0 }) }								
								,{header: "부서코드",	width: 100,	sortable: true,	dataIndex: "DEPT_CODE",		editor: new Ext.form.TextField({ allowBlank : true }), hidden : true }
								,{header: "연차휴가",	width: 100,	sortable: true,	dataIndex: "VAC_TYPE_CODE_01",		editor: new Ext.form.TextField({ allowBlank : false }) , hidden : true}
								,{header: "자기개발휴가",width: 100,	sortable: true,	dataIndex: "VAC_TYPE_CODE_02",		editor: new Ext.form.TextField({ allowBlank : true }) , hidden : true}
								,{header: "장기근속휴가",width: 100,	sortable: true,	dataIndex: "VAC_TYPE_CODE_03",		editor: new Ext.form.TextField({ allowBlank : true }) , hidden : true}
								,{header: "대체휴가",	width: 100,	sortable: true,	dataIndex: "VAC_TYPE_CODE_04",	editor: new Ext.form.TextField({ allowBlank : true }) , hidden : true}
								,{header: "비정산휴가",	width: 100,	sortable: true,	dataIndex: "VAC_TYPE_CODE_05",		editor: new Ext.form.TextField({ allowBlank : true }) , hidden : true}
						  	  ];	
var	mappingColumns_edit_1st	= [  
							   	{name: 'FLAG'              , allowBlank: false        }     //조회상태'  
							   	,{name: "BASIC_YEAR", 		type:"string", mapping: "BASIC_YEAR"}
							   	,{name: "EMP_NUM", 			type:"string", mapping: "EMP_NUM"}
								,{name: "KOR_NAME", 		type:"string", mapping: "KOR_NAME"}
								,{name: "VAC_TOT_DAYS", 	type:"string", mapping: "VAC_TOT_DAYS"}
								,{name: "VAC_DAYS_01", 		type:"string", mapping: "VAC_DAYS_01"}
								,{name: "VAC_DAYS_02", 		type:"string", mapping: "VAC_DAYS_02"}
								,{name: "VAC_DAYS_03", 		type:"string", mapping: "VAC_DAYS_03"}
								,{name: "VAC_DAYS_04", 		type:"string", mapping: "VAC_DAYS_04"}
								,{name: "VAC_DAYS_05", 		type:"string", mapping: "VAC_DAYS_05"}								
								,{name: "DEPT_CODE", 		type:"string", mapping: "DEPT_CODE"}
								,{name: "VAC_TYPE_CODE_01", type:"string", mapping: "VAC_TYPE_CODE_01"}
								,{name: "VAC_TYPE_CODE_02", type:"string", mapping: "VAC_TYPE_CODE_02"}
								,{name: "VAC_TYPE_CODE_03", type:"string", mapping: "VAC_TYPE_CODE_03"}
								,{name: "VAC_TYPE_CODE_04", type:"string", mapping: "VAC_TYPE_CODE_04"}
								,{name: "VAC_TYPE_CODE_05", type:"string", mapping: "VAC_TYPE_CODE_05"}
	    				 	  ]; 
 
function goAction_edit_1st(){
	
	var modifyRecords = GridClass_edit_1st.store.getModifiedRecords();		//수정된 레코드 지정한 키 값으로 찾아 내기  
	var modifyLen = modifyRecords.length;

} 

/** 서버스펙 EditGrid - edit_1st End**/


/***************************************************************************
 * 설  명 : 필드 초기화
 **************************************************************************/
function fnInitValue(){
	
	
	try{
		GridClass_edit_1st.store.commitChanges();
		GridClass_edit_1st.store.removeAll();
	}catch(e){
		
	}
	
	 var toDayYear = getTimeStamp(); 
	 toDayYear = toDayYear.replaceAll('-','');
	 toDayYear = addDate(toDayYear, 'M', -3);
	 toDayYear = toDayYear.substring(0,4)
	 	
	Ext.get('basic_year').set({value:toDayYear});
}

/***************************************************************************
 * 설  명 : 검색
 **************************************************************************/
function fnSearch(){  	

	var sFrom 		  = document.searchForm;
	var basic_year = sFrom.basic_year.value;
	var dept_name      = sFrom.dept_name.value;

	if(basic_year == '')
	{
		Ext.Msg.alert('확인', '기준년도는 필수입력입니다.');
		return;
	}
	if(dept_name == '')
	{
		Ext.Msg.alert('확인', '부서는 필수입력입니다.');
		return;
	}

	Ext.Ajax.request({   
		url: "/com/empVac/result_edit_1st.sg"
		,method : 'POST'   
		,success: function(response){						// 조회결과 성공시
					// 조회된 결과값, store명
					//handleSuccess(response,GridClass_edit_1st);
					
					GridClass_edit_1st.store.commitChanges();	// 변경된 record를 commit
					GridClass_edit_1st.store.removeAll();		// store자료를 삭제
						
					// 조회된 결과값, store명
					var json = Ext.util.JSON.decode(response.responseText);
										
					GridClass_edit_1st.store.loadData(json);					
		          }
		,failure: handleFailure   	   // 조회결과 실패시  
		,form   : document.searchForm  // 검색 FORM
		,params : {					   // 조회조건을 DB로 전송하기위해서 조건값 설정
					limit          : limit_edit_1st
				  , start          : start_edit_1st
				  }				
	});  
	
	//fnInitValue(); // 상세필드 초기화
}  		

/***************************************************************************
 * 설  명 : 저장버튼 클릭
 ***************************************************************************/
function fnSave(){  	

	var sForm = document.searchForm;	// 검색 FORM
	
	var records = GridClass_edit_1st.store.getModifiedRecords();	// 변경된 자료의 record  
	var modifyLen = records.length;
	
	var basic_year_chk= 0;
	var vac_days_chk= 0;
	
	var toDay = getTimeStamp(); 
	 toDayYear = toDay.replaceAll('-','');
	 toDayYear = toDayYear.substring(0,4);
	
	
	if(modifyLen == 0){

		alert("수정된 내용이 없습니다.");
		return;
	
	}else{
		for(var i = 0; i < modifyLen ; i++){
			var basic_year          = records[i].get("BASIC_YEAR");
			

			if(basic_year == undefined || basic_year.trim() == '')
			{
				basic_year_chk ++;
			}
			
			var vac_days_01     = records[i].get("VAC_DAYS_01");	 
			var vac_days_02     = records[i].get("VAC_DAYS_02");	 
			var vac_days_03     = records[i].get("VAC_DAYS_03");	 
			var vac_days_04     = records[i].get("VAC_DAYS_04");	 
			var vac_days_05     = records[i].get("VAC_DAYS_05");	
			
			if(vac_days_01 == "" && vac_days_02 == "" && vac_days_03 == "" && vac_days_04 == " && vac_days_05 == ")
			{
				vac_days_chk ++;
			} 

			if(basic_year_chk > 0)
			{
				Ext.Msg.alert('확인', '기준년도를 입력하세요');
				return;
			}else
			{
				if(parseInt(toDayYear) > parseInt(basic_year))		
		 		{
		 			Ext.Msg.alert('확인', '이전년도 변경이 불가합니다.');
					return false;
		 		}
			}	

			if(vac_days_chk > 0)
			{
				Ext.Msg.alert('확인', '휴가일수를 입력하세요');
				return;
			}					
		}


		var json = "[";
		    for (var i = 0; i < records.length; i++) {
		      json += Ext.util.JSON.encode(records[i].data);				// 변경된 record의 자료를 json형식으로
		      if (i < (records.length-1)) {
		        json += ",";
		      }
		    }
		    json += "]"
	    
	    //alert("json--->"+json);
	    
	    var cnt = GridClass_edit_1st.store.getCount();		// Grid의 총갯수	
		
		Ext.Ajax.request({   
			url: "/com/empVac/actionEmpVacInfo.sg"   
			,success: function(response){						// 조회결과 성공시
						// 조회된 결과값, store명

						handleSuccess(response,GridClass_edit_1st,'save');
						
			          }
			,failure: handleFailure   	    // 조회결과 실패시  
			,form   : document.searchForm  // 검색 FORM
			,params:	
			{			
						limit : limit_edit_1st
					  , start : start_edit_1st
					  ,data : json
			} 			
		});  
		
		//fnInitValue(); // 상세필드 초기화

	}
		
}  		

/***************************************************************************
 * 설  명 : 화면 설정
 ***************************************************************************/
// ExtJS 진입함수
Ext.onReady(function() {

	var sForm = document.searchForm;
	
	//검색하기 버튼 
	Ext.get('searchBtn').on('click', function(e){
		fnSearch()
	});	
		
	//조건해제 버튼 -> 검색조건 초기화
	Ext.get('searchClearBtn').on('click', function(e){
		sForm.reset();
	});	
			
	//등록 버튼 -> 데이터를 server로 전송
	Ext.get('saveBtn').on('click', function(e){	
		Ext.MessageBox.confirm('Confirm', '저장하시겠습니까?', showResult);
	});
	


   	// 부서검색 버튼
   	// 여러건을 팝업으로 부터 전송 받을경우 param뒤에 &multiSelectYn=Y 를 추가 
	Ext.get('deptSearchBtn').on('click', function(e){
		var param = '';
		fnDeptPop(param)
	});


	
    fnInitValue();
 
});

// 저장, 수정버튼 클릭시 '예','아니오' 
function showResult(btn){
   	if(btn == 'yes'){
   		fnSave();
   	}    	
};

/***************************************************************************
 * 설  명 : 그리드의 페이지 클릭시 검색조건값을 DB로 전송
 ***************************************************************************/
function fnDeptPop(param){
	var sURL      = "/com/dept/deptPop.sg?requestFieldName="+param;
	 var dlgWidth  = 399;
	 var dlgHeight = 358;
	 var winName   = "dept";
	 fnOpenPop(sURL, dlgWidth, dlgHeight, winName);
}


/***************************************************************************
 * 설  명 : 부서검색 결과 반영
 ***************************************************************************/
function fnDeptPopValue(records, fieldName){
		
	// 전송받은 값이 한건일 경우
    var record = records[0].data;				

   Ext.get('dept_code').set({value:fnFixNull(record.DEPT_CODE)} , false);
    Ext.get('dept_name').set({value:fnFixNull(record.DEPT_NAME)} , false);

   	//Ext.get('dept_code').set({value:record.DEPT_CODE} , false);
   	//Ext.get('dept_name').set({value:record.DEPT_NAME} , false);


}



// 팝업
function fnOpenPop(sURL, dlgWidth, dlgHeight, winName){
  var xPos=(window.screen.width) ? (window.screen.width-dlgWidth)/2 : 0;
  var yPos=(window.screen.height) ? (window.screen.height-dlgHeight)/2 : 0;
  var sFeatures = "titlebar=no, scrollbars=no,location=no ,menubar=no, resizable=no, status=yes, width="+dlgWidth+",height="+dlgHeight+",left="+xPos+", top="+yPos;

  window.open(sURL,winName, sFeatures);
}


/***************************************************************************
 * 설  명 : 그리드의 페이지 클릭시 검색조건값을 DB로 전송
 ***************************************************************************/
function fnPagingValue_1st(){
	var sForm = document.searchForm;
	

}


/***************************************************************************
 * 설  명 : 에디트 그리드의 CELL을 수정하였을 경우 이벤트
 ***************************************************************************/
function  fnEdit1stAfterCellEdit(obj){

	var rowCnt = GridClass_edit_1st.store.getCount();  // Grid의 총갯수
	var vacDaysTot = 0;	// 총휴가일수 
	
	var vacDays01Amt = 0 ; 	// 연차휴가
	var vacDays02Amt = 0;    // 자기개발휴가
	var vacDays03Amt = 0;	// 장기근속휴가
	var vacDays04Amt = 0;	// 대체휴가
	var vacDays05Amt = 0;	// 비정산휴가
	
	var editedRow = obj.row;
	var editedColumn = obj.column;
	var editedValue = obj.value;
	var fieldName = obj.field;
//alert("--obj-fieldName-"+fieldName+"-rowCnt--"+rowCnt);	

	// 해당 컬럼의 값이 변경 되었을 경우
	if( fieldName == 'VAC_DAYS_01' || fieldName == 'VAC_DAYS_02' || fieldName == 'VAC_DAYS_03' || fieldName == 'VAC_DAYS_04' || fieldName == 'VAC_DAYS_05'){

				
				var record = GridClass_edit_1st.store.getAt(editedRow);
				
				// 연차휴가
				if(GridClass_edit_1st.store.data.items[editedRow].data.VAC_DAYS_01 != '')
				{
					var vacDays01Amt =  parseInt(GridClass_edit_1st.store.data.items[editedRow].data.VAC_DAYS_01);
				}
			
				// 자기개발휴가
				if(GridClass_edit_1st.store.data.items[editedRow].data.VAC_DAYS_02 != '')
				{
					var vacDays02Amt =  parseInt(GridClass_edit_1st.store.data.items[editedRow].data.VAC_DAYS_02);
				}				

					
				// 장기근속휴가
				if(GridClass_edit_1st.store.data.items[editedRow].data.VAC_DAYS_03 != '')
				{
					var vacDays03Amt =  parseInt(GridClass_edit_1st.store.data.items[editedRow].data.VAC_DAYS_03);
				}	
					
				// 대체휴가
				if(GridClass_edit_1st.store.data.items[editedRow].data.VAC_DAYS_04 != '')
				{
					var vacDays04Amt =  parseInt(GridClass_edit_1st.store.data.items[editedRow].data.VAC_DAYS_04);
				}				
				
				// 연차휴가
				if(GridClass_edit_1st.store.data.items[editedRow].data.VAC_DAYS_05 != '')
				{
					var vacDays05Amt =  parseInt(GridClass_edit_1st.store.data.items[editedRow].data.VAC_DAYS_05);
				}				
					
				vacDaysTot += vacDays01Amt;   	
				vacDaysTot += vacDays02Amt;   	
				vacDaysTot += vacDays03Amt;   	
				vacDaysTot += vacDays04Amt;   	
				vacDaysTot += vacDays05Amt;   	

				record.set('VAC_TOT_DAYS', vacDaysTot);						// 총휴가일수

	}// end if

}


</script>

</head>
<body>
	<table border="0" width="900" height="200">
		<tr>
			<td >
				<form name="searchForm">
				<input type="hidden" id="dept_code" name="dept_code"  />				<!-- 부서코드-->
				
				<!----------------- SEARCH Hearder Start	 ----------------->
				<div id="ext-comp-1002" class=" x-panel x-form-label-left" style="margin-top: 0.4em;"><%-- 0em <- 1em으로 수정하면 상위 공백 --%>
					<div class="x-panel-tl">
						<div class="x-panel-tr">
							<div class="x-panel-tc">
								<div id="ext-gen4" class="x-panel-header x-unselectable" style="-moz-user-select: none;">
									<span id="ext-gen8" class="x-panel-header-text">개인별휴가정보 검색</span>
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
										
										<td colspan="2" width="20%">
											<div tabindex="-1" class="x-form-item " >
												<label class="x-form-item-label" style="width: auto;" for="basic_year" ><font color="red">* </font>기준년도 :</label>
												<div style="padding-left: 30px;" class="x-form-element">
													<input type="text" name="basic_year" id="basic_year" autocomplete="off" size="15" class="x-form-text x-form-field" style="width: auto;" >
												</div>
											</div>
										</td>
										
										<td width="17%">
											<div tabindex="-1" class="x-form-item " >
												<label class="x-form-item-label" style="width: auto;" for="dept_name" ><font color="red">* </font>부서 :</label>
												<div style="padding-left: 30px;" class="x-form-element">
													<input type="text" name="dept_name" id="dept_name" autocomplete="off" size="15" class="x-form-text x-form-field" style="width: auto;" readOnly >
												</div>
											</div>
										</td>
										<td valign="top">
											<%-- Button Start--%>
												<div style="padding-left: 0px;" >
													<img align="center" id="deptSearchBtn" name="deptSearchBtn" alt="" src="/resource/images/bass_1st/icon_src1.gif" style="cursor: hand;">
												</div>
											<%-- Button End--%>											
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
			<!------------------------------ GRID START ---------------------------------->
			<td  valign="top">
				<div id="empVac-grid" style="margin-top: 0.4em;"></div> <!----------------- 그리드명을 동일하게 설정 ----------------->
			</td>
		</tr>
		
		<tr>
			<td  align="center" height="35">
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