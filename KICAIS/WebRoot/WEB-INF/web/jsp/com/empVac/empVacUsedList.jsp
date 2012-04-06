<%--
  Class Name  : empVacUsedList.jsp
  Description : 개인별휴가사용관리 
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
var	gridTitle_edit_1st  =   "개인별 휴가사용정보"	; 
var	render_edit_1st		=	"empVacUsed-grid";
var keyNm_edit_1st		= 	"EMP_VAC_SEQ";
var pageSize_edit_1st	=	15;
var limit_edit_1st		=	pageSize_edit_1st;
var start_edit_1st		=	0;
var proxyUrl_edit_1st	=	"/com/empVac/result_edit_1st_used.sg";
var gridRowDeleteYn = "Y";		//삭제시
var tbarHidden_edit_1st     = "N";

var empVacTotCount =0;
	
function addNew_edit_1st(){

		
		var Plant = GridClass_edit_1st.grid.getStore().recordType; 
	    var p = new Plant({ 
		        		  	FLAG			: 'I' 
		        		  , EMP_NUM	    : '${sabun}'
		        		  //, EMP_NUM	    : '30192'		//테스트
					   	  , KOR_NAME	: '${admin_nm}'
					   	  , DEPT_CODE   : '${dept_code}'
					   	  , VAC_TOT_DAYS : empVacTotCount
	    				  }); 
	  	GridClass_edit_1st.grid.stopEditing();
		GridClass_edit_1st.store.insert(0, p);
		GridClass_edit_1st.grid.startEditing(0, 0);


	//fnEmployeePop();	
	
}

function fnPagingValue_edit_1st(){	
	
	var sForm = document.searchForm;
	var basic_year = sForm.basic_year.value;
	
	GridClass_edit_1st.store.commitChanges();
	
	try{
		
		GridClass_edit_1st.store.setBaseParam('start'			,start_edit_1st);
	    GridClass_edit_1st.store.setBaseParam('limit'			,limit_edit_1st);
	    
	    GridClass_edit_1st.store.setBaseParam('basic_year'	,basic_year);
	}catch(e){

	}

}

 renderDate=function(value,p,record){

  if (value == null || value == undefined) {
   return ;
  } 

  if ( typeof(value) != 'Number' )
  {
     value = String(value)
  }

  if(value.length!=8)
  {
  	alert("정확한 날짜를 입력하십시오");
  	return;
  }

  return Date.parseDate(value.substr(0,4)+"-"+value.substr(4,2)+"-"+value.substr(6,2), "Y-m-d").format('Y-m-d');

 }


/** 휴가구분코드 combo box 생성 start **/
var VAC_TYPE_CODE_COMBO = new Ext.form.ComboBox({    
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
     <c:forEach items="${VAC_TYPE_CODE}" var="data" varStatus="status">
      ['${data.COM_CODE}', '${data.COM_CODE_NAME}']
      <c:if test="${not status.last}">,</c:if>
     </c:forEach>
      ]
   })
});

//combo box render
Ext.util.Format.comboRenderer = function(VAC_TYPE_CODE_COMBO){    
 return function(value){        
 var record = VAC_TYPE_CODE_COMBO.findRecord(VAC_TYPE_CODE_COMBO.valueField, value);        
 return record ? record.get(VAC_TYPE_CODE_COMBO.displayField) : VAC_TYPE_CODE_COMBO.valueNotFoundText;    
}}



var	userColumns_edit_1st	= [ {header: '조회상태'                 ,width: 60  ,sortable: true ,dataIndex: 'FLAG'                     , hidden : true }              
			 					,{header: "일련번호",	width: 100,	sortable: true,	dataIndex: "EMP_VAC_SEQ", editor: new Ext.form.TextField({ allowBlank : false }) , hidden : true  }
			 					,{header: "사원번호",	width: 100,	sortable: true,	dataIndex: "EMP_NUM" }
							 	,{header: "사원명",		width: 100,	sortable: true,	dataIndex: "KOR_NAME" }
							 	,{header: "부서코드",	width: 100,	sortable: true,	dataIndex: "DEPT_CODE",		editor: new Ext.form.TextField({ allowBlank : true }) , hidden : true }
								,{header: "휴가구분",	width: 100,	sortable: true,	dataIndex: "VAC_TYPE", editor: VAC_TYPE_CODE_COMBO  ,renderer: Ext.util.Format.comboRenderer(VAC_TYPE_CODE_COMBO)   }
								,{header: "사용일자(FROM)",	width: 100,	sortable: true,	dataIndex: "VAC_DAYS_USED_FROM",		 renderer:renderDate, editor : new Ext.form.NumberField( { allowBlank : false })  }
								,{header: "사용일자(TO)",	width: 100,	sortable: true,	dataIndex: "VAC_DAYS_USED_TO",		renderer:renderDate, editor : new Ext.form.NumberField( {allowBlank : false})  }
								,{header: "사용내역",		width: 100,	sortable: true,	dataIndex: "VAC_USED_EXP",		editor: new Ext.form.TextField({ allowBlank : true, maxLength : 200, maxLengthText: '최대길이는 200자 입니다' })  }
								,{header: "휴가일수",		width: 100,	sortable: true,	dataIndex: "VAC_DAYS"}
								,{header: "총휴가일수",		width: 100,	sortable: true,	dataIndex: "VAC_TOT_DAYS"}
								,{header: "비고",			width: 100,	sortable: true,	dataIndex: "NOTE",	editor: new Ext.form.TextField({ allowBlank : true }) , hidden : true}
								,{header: "최종변경자ID",	width: 100,	sortable: true,	dataIndex: "FINAL_MOD_ID",		editor: new Ext.form.TextField({ allowBlank : true }) , hidden : true}
								,{header: "최종변경일시",	width: 100,	sortable: true,	dataIndex: "FINAL_MOD_DATE",		editor: new Ext.form.TextField({ allowBlank : true }), hidden : true }
								,{header: "",	width: 100,	sortable: true,	dataIndex: "VAC_DAYS_USED_FROM_TMP",	editor: new Ext.form.TextField({ allowBlank : true }) , hidden : true}
								,{header: "",	width: 100,	sortable: true,	dataIndex: "VAC_DAYS_USED_TO_TMP",	editor: new Ext.form.TextField({ allowBlank : true }) , hidden : true}
								
						  	  ];	
var	mappingColumns_edit_1st	= [  
							   	{name: 'FLAG'              , allowBlank: false        }    				 //조회상태'  
							   	,{name: "EMP_VAC_SEQ", 		type:"string", mapping: "EMP_VAC_SEQ"}
							   	,{name: "EMP_NUM", 			type:"string", mapping: "EMP_NUM"}
								,{name: "KOR_NAME", 		type:"string", mapping: "KOR_NAME"}
								,{name: "DEPT_CODE", 		type:"string", mapping: "DEPT_CODE"}
								,{name: "VAC_TYPE", 		type:"string", mapping: "VAC_TYPE"}
								,{name: "VAC_DAYS_USED_FROM", 	type:"string", mapping: "VAC_DAYS_USED_FROM"}
								,{name: "VAC_DAYS_USED_TO", 	type:"string", mapping: "VAC_DAYS_USED_TO"}
								,{name: "VAC_USED_EXP", 		type:"string", mapping: "VAC_USED_EXP"}
								,{name: "VAC_DAYS", 			type:"string", mapping: "VAC_DAYS"}
								,{name: "VAC_TOT_DAYS", 			type:"string", mapping: "VAC_TOT_DAYS"}								
								,{name: "NOTE", 				type:"string", mapping: "NOTE"}
								,{name: "FINAL_MOD_ID", 		type:"string", mapping: "FINAL_MOD_ID"}
								,{name: "FINAL_MOD_DATE", 		type:"string", mapping: "FINAL_MOD_DATE"}
								,{name: "VAC_DAYS_USED_FROM_TMP", 		type:"string", mapping: "VAC_DAYS_USED_FROM_TMP"}
								,{name: "VAC_DAYS_USED_TO_TMP", 		type:"string", mapping: "VAC_DAYS_USED_TO_TMP"}
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
	//var dept_name      = sFrom.dept_name.value;

	if(basic_year == '')
	{
		Ext.Msg.alert('확인', '기준년도는 필수입력입니다.');
		return;
	}
/*	
	if(dept_name == '')
	{
		Ext.Msg.alert('확인', '부서는 필수입력입니다.');
		return;
	}
*/

	Ext.Ajax.request({   
		url: "/com/empVac/result_edit_1st_used.sg"
		,method : 'POST'   
		,success: function(response){						// 조회결과 성공시
					// 조회된 결과값, store명
					//handleSuccess(response,GridClass_edit_1st);
					var json = Ext.util.JSON.decode(response.responseText);
					
					Ext.get('basic_year').set({value:json.pMap.basic_year} , false);	
					empVacTotCount = json.empVacTotCount;
					
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
	var chkCnt =0;
	var vacDayChkCnt =0;
	var vacTypeChkCnt =0;
	
	var usedVacDaysTot = 0;
	
	if(modifyLen == 0){

		Ext.Msg.alert('확인', '추가,수정된 내용이 없습니다.');
		return;
	
	}else{
	
//alert("--records.length--"+records.length);	
		var json = "[";
		    for (var i = 0; i < records.length; i++) {

				if(records[i].data.FLAG != 'D')	    
				{
//alert("--records[i].data.VAC_TYPE--"+records[i].data.VAC_TYPE);
					if(records[i].data.VAC_TYPE == "" || records[i].data.VAC_TYPE == undefined)	//휴가구분 
					{	
						vacTypeChkCnt++;
					}		

					if(records[i].data.VAC_DAYS == undefined || records[i].data.VAC_DAYS == "")	//휴가일수 
					{	
						vacDayChkCnt++;
					}
			        
					if(records[i].data.VAC_DAYS_USED_FROM == undefined && records[i].data.VAC_DAYS_USED_TO == undefined)
					{
						if(parseInt(records[i].data.VAC_DAYS_USED_FROM) > parseInt(records[i].data.VAC_DAYS_USED_TO))
						{
							chkCnt ++;
						}
					}				
	        		        
			        records[i].set('VAC_DAYS_USED_FROM_TMP', records[i].data.VAC_DAYS_USED_FROM) ;	
			        records[i].set('VAC_DAYS_USED_TO_TMP', records[i].data.VAC_DAYS_USED_TO) ;	
			     
			     
			      json += Ext.util.JSON.encode(records[i].data);				// 변경된 record의 자료를 json형식으로
			      if (i < (records.length-1)) {
			        json += ",";
			      }
			   }
			   
			   usedVacDaysTot  += parseInt(records[i].data.VAC_DAYS);
		    }
		    json += "]"
	    

	    var cnt = GridClass_edit_1st.store.getCount();		// Grid의 총갯수
	
		if(vacTypeChkCnt >0)
		{
			Ext.Msg.alert('확인', '휴가구분을 선택하십시오.');
			return;
		}
			
		if(chkCnt >0)
		{
			Ext.Msg.alert('확인', '사용일자(TO)가 사용일자(FROM) 보다 이전날짜 입니다.');
			return;
		}
		
		if(vacDayChkCnt > 0)
		{	
			Ext.Msg.alert('확인', '휴가일수가 없습니다.');
			return;
		}
//alert("--usedVacDaysTot--"+usedVacDaysTot+"::"+"--empVacTotCount--"+empVacTotCount);
		if( parseInt(usedVacDaysTot) > parseInt(empVacTotCount))
		{	
			Ext.Msg.alert('확인', '총휴가일수를 초과했습니다.');
			return;
		}

//alert("json--->"+json);		
				Ext.Ajax.request({   
					url: "/com/empVac/actionEmpVacUsedInfo.sg"   
					,success: function(response){						// 조회결과 성공시
								// 조회된 결과값, store명
								
								handleSuccess(response,GridClass_edit_1st,'save');
								
					          }
					,failure: handleFailure   	    // 조회결과 실패시  
					,form   : document.searchForm   // 검색 FORM
					,params:	
					{					    // 조회조건을 DB로 전송하기위해서 조건값 설정
							  // 페이지정보
								limit          		: limit_edit_1st
							  , start          		: start_edit_1st
							  ,data : json
					} 		
				});  
			
				//fnInitValue(); // 상세필드 초기화

	}
		
}  		


/***************************************************************************
 * 설  명 : 삭제버튼 클릭
 ***************************************************************************/
function fnGridDeleteRow(selectedRecord){

	var json = "["+Ext.util.JSON.encode(selectedRecord.data)+"]";

	Ext.Ajax.request({   
		url: "/com/empVac/deleteEmpVacUsed.sg"   
		,success: function(response){						// 조회결과 성공시
					// 조회된 결과값, store명
					handleSuccess(response,GridClass_edit_1st);
		          }
		,failure: handleFailure   	    // 조회결과 실패시  
		,form   : document.searchForm   // 검색 FORM
		,params : { 
					limit          		: limit_edit_1st
				   , start         		: start_edit_1st
				   ,deleteData : json
			      } 
	});
	
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
	
/*
   	// 부서검색 버튼
   	// 여러건을 팝업으로 부터 전송 받을경우 param뒤에 &multiSelectYn=Y 를 추가 
	Ext.get('deptSearchBtn').on('click', function(e){
		var param = '';
		fnDeptPop(param)
	});
*/
	
	empVacTotCount = '${empVacTotCount}';
			
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
	 var dlgHeight = 358
	 var winName   = "dept";
	 fnOpenPop(sURL, dlgWidth, dlgHeight, winName);
}


/***************************************************************************
 * 설  명 : 부서검색 결과 반영
 ***************************************************************************/
function fnDeptPopValue(records, fieldName){
		
	// 전송받은 값이 한건일 경우
    var record = records[0].data;				

   	Ext.get('dept_code').set({value:record.DEPT_CODE} , false);
   	Ext.get('dept_name').set({value:record.DEPT_NAME} , false);


}


/***************************************************************************
 * 설  명 : 담당자검색
 ***************************************************************************/
function fnEmployeePop(param){
	var sURL      = "/com/employee/employeePop.sg?multiSelectYn=Y";
	var dlgWidth  = 399;
	var dlgHeight = 396;
	var winName   = "emp";
	
	fnOpenPop(sURL, dlgWidth, dlgHeight, winName);
}



/***************************************************************************
 * 설  명 : 프로젝트색 결과 반영
 ***************************************************************************/
function fnEmployeePopValue(records, fieldName){
		

	var dupChk =0;
	var alertMsg ="";
	
	var rowTotCnt = GridClass_edit_1st.store.getCount();
    var oldData ="";
	for (var i = 0; i < records.length; i++) {

		var Plant = GridClass_edit_1st.grid.getStore().recordType; 
	    var p = new Plant({ 
		        		  	FLAG			: 'I' 
		        		  , EMP_NUM	    : records[i].data.EMP_NUM
					   	  , KOR_NAME	: records[i].data.KOR_NAME
					   	  , DEPT_CODE   : records[i].data.DEPT_CODE
	    				  }); 
	  	GridClass_edit_1st.grid.stopEditing();
		GridClass_edit_1st.store.insert(0, p);
		GridClass_edit_1st.grid.startEditing(0, 0);
	}
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



}



/**
 *  Date 객체를 Time 스트링으로 변환
 * parameter date: JavaScript Date Object
 */
function toTimeString(date,gubun) { //formatTime(date)
    var year  = date.getFullYear();
    var month = date.getMonth() + 1; // 
    var day   = date.getDate();
    //var hour  = date.getHours();
    //var min   = date.getMinutes();
 
    if (("" + month).length == 1) { month = "0" + month; }
    if (("" + day).length   == 1) { day   = "0" + day;   }
    //if (("" + hour).length  == 1) { hour  = "0" + hour;  }
    //if (("" + min).length   == 1) { min   = "0" + min;   }
 
    //return ("" + year + month + day + hour + min)
    if(gubun == '1')
    {
    	return (year + month + day)
    }else if(gubun == '2')
    {
    	return (year+"-"+month+"-"+ day)
    }
    
    
}


/**
 * 스트링을 자바스크립트 Date 객체로 변환
 * parameter time: Time 형식의 String
 */
function toTimeObject(dateStr) { 
    var year  = dateStr.substr(0,4);
    var month = dateStr.substr(4,2) - 1; // 1월=0,12월=11
    var day   = dateStr.substr(6,2);
 
    return new Date(year,month,day);
}
 


/***************************************************************************
 * 설  명 : 에디트 그리드의 CELL을 수정하였을 경우 이벤트
 ***************************************************************************/
function  fnEdit1stAfterCellEdit(obj){

	var rowCnt = GridClass_edit_1st.store.getCount();  // Grid의 총갯수
	var vacDaysTot = 0;	// 총휴가일수 
	
	
	var editedRow = obj.row;
	var editedColumn = obj.column;
	var editedValue = obj.value;
	var fieldName = obj.field;

	var fromChkCnt =0;
	var toChkCnt =0;

	// 해당 컬럼의 값이 변경 되었을 경우
	if( fieldName == 'VAC_DAYS_USED_FROM' ||  fieldName == 'VAC_DAYS_USED_TO'){
			
				var record = GridClass_edit_1st.store.getAt(editedRow);
				
					Ext.Ajax.request({   
						url: "/com/empVac/selectEmpVacDaysCount.sg"   
						,success: function(response){						// 조회결과 성공시
									// 조회된 결과값, store명
									var json = Ext.util.JSON.decode(response.responseText);
	//alert("---json--"+json.empVacDaysCount);	
									if(json.empVacDaysCount == '0')
									{
										record.set('VAC_DAYS', '');
									}else
									{
										record.set('VAC_DAYS', json.empVacDaysCount);
									}
									
						          }
						,failure: handleFailure   	    // 조회결과 실패시  
						,form   : document.searchForm   // 검색 FORM
						,params : { 
									limit          		: limit_edit_1st
								   , start         		: start_edit_1st
								   ,VAC_DAYS_USED_FROM_TMP : record.data.VAC_DAYS_USED_FROM
								   ,VAC_DAYS_USED_TO_TMP : record.data.VAC_DAYS_USED_TO
							      } 
					});

	} // end if

}


// 그리드 행삭제
function fnEdit1stBeforeRowDeleteEvent(){

	var delRecord = GridClass_edit_1st.grid.selModel.getSelections();
	delRecord[0].set('FLAG', 'D');						//상태
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
									<span id="ext-gen8" class="x-panel-header-text">개인별 휴가사용 정보  검색</span>
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
<!--										
										<td width="17%">
											<div tabindex="-1" class="x-form-item " >
												<label class="x-form-item-label" style="width: auto;" for="dept_name" ><font color="red">* </font>부서 :</label>
												<div style="padding-left: 30px;" class="x-form-element">
													<input type="text" name="dept_name" id="dept_name" autocomplete="off" size="15" class="x-form-text x-form-field" style="width: auto;" >
												</div>
											</div>
										</td>
										<td>
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
																		<button type="button" id="deptSearchBtn" class=" x-btn-text">검색</button>
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
										</td>	
-->																			
									</tr>
									<%-- 1 Row End --%>
									<%-- 2 Row 버튼 Start --%>
									<tr align="right">
										<td colspan="3">
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
				<div id="empVacUsed-grid" style="margin-top: 0.4em;"></div> <!----------------- 그리드명을 동일하게 설정 ----------------->
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
											<button type="button" id="saveBtn" name="saveBtn" class="x-btn-text">등록</button>
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
						<td width="1">
						</td>
						<td>
						<%-- 수정 버튼 Start --%>
						<%--
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
											<button type="button" id="updateBtn" name="updateBtn" class="x-btn-text">수정</button>
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
						--%>
						<%-- 수정 버튼 End --%>
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
</body>

</html>