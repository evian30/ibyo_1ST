<%--
  Class Name  : csrInfoReviewMngList.jsp
  Description : 업무요청검토 관리
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
var	gridHeigth_edit_1st	=	450;
var	gridWidth_edit_1st  =	1022;
var	gridTitle_edit_1st  =   "업무요청 상세정보"	; 
var	render_edit_1st		=	"csr_reviw_grid";
var keyNm_edit_1st		= 	"CSR_ID";
var pageSize_edit_1st	=	15;
var limit_edit_1st		=	pageSize_edit_1st;
var start_edit_1st		=	0;
var proxyUrl_edit_1st	=	"/dev/csrInfo/resultReview.sg";
var gridRowDeleteYn = "Y";
var tbarHidden_edit_1st     = "Y";

//에디트그리드 추가
function addNew_edit_1st(){


}

//에디트그리드 페이징
function fnPagingValue_edit_1st(){	
	

	try{
		
		GridClass_edit_1st.store.setBaseParam('start'			,start_edit_1st);
	    GridClass_edit_1st.store.setBaseParam('limit'			,limit_edit_1st);
	    GridClass_edit_1st.store.setBaseParam('src_rw_csr_date_from'	,Ext.get('src_rw_csr_date_from').getValue());
		GridClass_edit_1st.store.setBaseParam('src_rw_csr_date_to'		,Ext.get('src_rw_csr_date_to').getValue());
		GridClass_edit_1st.store.setBaseParam('src_csr_dept_code'		,Ext.get('src_csr_dept_code').getValue());
		GridClass_edit_1st.store.setBaseParam('src_csr_type_code'		,Ext.get('src_csr_type_code').getValue());
	}catch(e){

	}

}

var statusStore = new Ext.data.SimpleStore({
  fields: ['code', 'desc'],
  data : [
		    <c:forEach items="${REQUEST_STATUS_CODE}" var="data" varStatus="status">
				['{data.COM_CODE}', '${data.COM_CODE_NAME}']
				<c:if test='${not status.last}'>,</c:if>   
			</c:forEach>
  			
  		]
});



/** 요청상태코드 combo box 생성 start **/
var CSR_STATUS_CODE_COMBO = new Ext.form.ComboBox({    
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
     <c:forEach items="${REQUEST_STATUS_CODE}" var="data" varStatus="status">
      ['${data.COM_CODE}', '${data.COM_CODE_NAME}']
      <c:if test="${not status.last}">,</c:if>
     </c:forEach>
      ]
   })
});

//combo box render
Ext.util.Format.comboRenderer = function(CSR_STATUS_CODE_COMBO){    
 return function(value){        
 var record = CSR_STATUS_CODE_COMBO.findRecord(CSR_STATUS_CODE_COMBO.valueField, value);        
 return record ? record.get(CSR_STATUS_CODE_COMBO.displayField) : CSR_STATUS_CODE_COMBO.valueNotFoundText;    
}}



var	userColumns_edit_1st	= [  
								{header: "요청상태", 	  width: 60,	sortable: true,	dataIndex: "CSR_STATUS_CODE",				editor: CSR_STATUS_CODE_COMBO  ,renderer: Ext.util.Format.comboRenderer(CSR_STATUS_CODE_COMBO)  }
								,{header: "검토내용", 	  	width: 100,	sortable: true,	dataIndex: "CSR_STATUS_REASON",				editor: new Ext.form.TextField({ allowBlank : true, maxLength : 200, maxLengthText: '최대길이는 200자 입니다' })  }
								,{header: "요청구분", 		width: 60,  sortable: true, dataIndex: "CSR_TYPE_NAME"}
								,{header: "요청일자",     	width: 60,  sortable: true, dataIndex: "CSR_DATE"}
							    ,{header: "요청ID", 		width: 100,	sortable: true,	dataIndex: "CSR_ID"}							    
							    ,{header: "요청제목",		width: 100,  sortable: true, dataIndex: "CSR_TITLE"       }
							    ,{header: "요청자사번",  	width: 60, sortable: true, dataIndex: "CSR_EMP_NUM"       , hidden : true}  
							    ,{header: "요청자명",  	    width: 100, sortable: true, dataIndex: "CSR_EMP_NAME"       }
							    ,{header: "프로젝트ID", 	width: 100,	sortable: true,	dataIndex: "PJT_ID"}
							    ,{header: "제품", 	  		width: 100,	sortable: true,	dataIndex: "ITEM_NAME"}
							    ,{header: "업무요청내용", 	width: 100,	sortable: true,	dataIndex: "CSR_NOTE"}  
								,{header: "상태", 			width: 0,	sortable: true,	dataIndex: "FLAG", hidden : true}	
								,{header: "업무요청순번",	  	width: 0,	sortable: true,	dataIndex: "CSR_INFO_SEQ", hidden : true}
								,{header: "업무요청유형코드", 	width: 50,	sortable: true,	dataIndex: "CSR_PATTERN_CODE", hidden : true}
								,{header: "품목코드", 	  	  	width: 100,	sortable: true,	dataIndex: "ITEM_CODE", hidden : true}
								,{header: "프로젝트순번", 	  	width: 100,	sortable: true,	dataIndex: "PJT_INFO_SEQ", hidden : true}
							    ,{header: "요청부서명",   		width: 60,  sortable: true, dataIndex: "CSR_DEPT_NAME", hidden : true}
							    ,{header: "업무요청구분코드",	width: 60,  sortable: true, dataIndex: "CSR_TYPE_CODE", hidden : true}   
							    ,{header: "요청부서코드",   	width: 60,  sortable: true, dataIndex: "CSR_DEPT_CODE", hidden : true}
								,{header: "처리일자", 		  width: 100,	sortable: true,	dataIndex: "DEAL_DATE", hidden : true}
								,{header: "처리부서코드", 	  width: 100,	sortable: true,	dataIndex: "DEAL_DEPT_CODE", hidden : true}
								,{header: "처리자사번", 	  width: 100,	sortable: true,	dataIndex: "DEAL_EMP_NUM", hidden : true}
								,{header: "처리내용", 		  width: 100,	sortable: true,	dataIndex: "DEAL_NOTE", hidden : true}
								,{header: "처리완료여부", 	  width: 100,	sortable: true,	dataIndex: "DEAL_YN", hidden : true}
								,{header: "최종변경자ID",	  width: 100,	sortable: true,	dataIndex: "FINAL_MOD_ID", hidden : true}
								,{header: "최종변경일시",	  width: 100,	sortable: true,	dataIndex: "FINAL_MOD_DATE" , hidden : true}
						  	  ];


var	mappingColumns_edit_1st	= [ 
								 {name: "CSR_STATUS_CODE"			 ,type:"string" ,mapping: "CSR_STATUS_CODE"}    //요청상태코드
								, {name: "CSR_STATUS_REASON"			 ,type:"string" ,mapping: "CSR_STATUS_REASON"}  //요청상태사유		 							    
								, {name: 'CSR_TYPE_NAME', type:"string" ,mapping: "CSR_TYPE_NAME"}							    
								, {name: 'CSR_DATE', type:"string" ,mapping: "CSR_DATE"} 					//요청일자						    
								, {name: "CSR_ID" ,type:"string" ,mapping: "CSR_ID"} 						//업무요청ID							    
								, {name: 'CSR_TITLE', type:"string" ,mapping: "CSR_TITLE"}  											//요청제목	
								, {name: 'CSR_EMP_NUM', type:"string" ,mapping: "CSR_EMP_NUM"}  										//요청자사번  
								, {name: 'CSR_EMP_NAME', type:"string" ,mapping: "CSR_EMP_NAME"}  									//요청자명  
								, {name: "PJT_ID"			 ,type:"string" ,mapping: "PJT_ID"}          	            //프로젝트ID		
								, {name: "ITEM_NAME"			 ,type:"string" ,mapping: "ITEM_NAME"}          	            //제품		
								, {name: "CSR_NOTE"	 ,type:"string" ,mapping: "CSR_NOTE"}    	                    //업무요청내용	
								, {name: "FLAG" ,type:"string" ,mapping: "FLAG"} 										//상태			
								, {name: "CSR_INFO_SEQ"		 ,type:"string" ,mapping: "CSR_INFO_SEQ"}       	    //업무요청순번		
								, {name: "CSR_PATTERN_CODE" ,type:"string" ,mapping: "CSR_PATTERN_CODE"} 	            //업무요청유형코드	
								, {name: "ITEM_CODE"	 ,type:"string" ,mapping: "ITEM_CODE"}     	                    //품목코드			
								, {name: "PJT_INFO_SEQ"			 ,type:"string" ,mapping: "PJT_INFO_SEQ"}           //프로젝트순번		
								, {name: 'CSR_DEPT_NAME', type:"string" ,mapping: "CSR_DEPT_NAME"}  										//요청부서명   	    
								, {name: 'CSR_TYPE_CODE', type:"string" ,mapping: "CSR_TYPE_CODE"}  											//업무요청구분코드      
								, {name: 'CSR_DEPT_CODE', type:"string" ,mapping: "CSR_DEPT_CODE"} 											//요청부서코드        
								, {name: "DEAL_DATE"			 ,type:"string" ,mapping: "DEAL_DATE"}                  //처리일자			
								, {name: "DEAL_DEPT_CODE"			 ,type:"string" ,mapping: "DEAL_DEPT_CODE"}         //처리부서코드		
								, {name: "DEAL_EMP_NUM"			 ,type:"string" ,mapping: "DEAL_EMP_NUM"}           //처리자사번			
								, {name: "DEAL_NOTE"			 ,type:"string" ,mapping: "DEAL_NOTE"}                  //처리내용			
								, {name: "DEAL_YN"			 ,type:"string" ,mapping: "DEAL_YN"}            	    //처리완료여부		
								, {name: "FINAL_MOD_ID",type:"string" ,mapping: "FINAL_MOD_ID"}    				// 최종변경자ID    
								, {name: "FINAL_MOD_DATE",type:"string" ,mapping: "FINAL_MOD_DATE"}  				// 최종변경일시 							       
	    				 	  ]; 





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
}

/***************************************************************************
 * 설  명 : 검색
 **************************************************************************/
function fnSearch(){  	
		
	var sForm = document.searchForm;

	sForm.src_rw_csr_date_from.value = sForm.src_rw_csr_date_from_tmp.value.replaceAll('-','');		   	 
	sForm.src_rw_csr_date_to.value = sForm.src_rw_csr_date_to_tmp.value.replaceAll('-','');			

	Ext.Ajax.request({   
		url: "/dev/csrInfo/resultReview.sg"
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
					limit           : limit_edit_1st
				  , start           : start_edit_1st
				  }				
	});  
	
	//fnInitValue(); // 상세필드 초기화
}  		



/***************************************************************************
 * 설  명 : 저장버튼 클릭
 ***************************************************************************/
function fnSave(){  	

	var sForm = document.searchForm;	// 검색 FORM
	
	// 변경된 Gride의 record
	var records = GridClass_edit_1st.store.getModifiedRecords();	  
	// 변경된 record의 자료를 json형식으로
    var modifyLen = records.length;
    
    var valiChk =0
    
    
    var json = "[";
	    for (var i = 0; i < records.length; i++) {
	    	
	    	var csr_status_chk          = records[i].get("CSR_STATUS_CODE");
	    	var csr_status_reason_chk   = records[i].get("CSR_STATUS_REASON");
	    	
	    	if(csr_status_chk == '')
	    	{
	    		Ext.Msg.alert('확인', '요청상태코드를 선택하십시오');
	    		valiChk++;
	    		break;
	    	}else if(csr_status_reason_chk =='' && csr_status_chk !='10')
	    	{
	    		Ext.Msg.alert('확인', '검토내용을 입력하십시오');
	    		valiChk++;
	    		break;
	    	}
	    	
	    
	      json += Ext.util.JSON.encode(records[i].data);				
	      if (i < (records.length-1)) {
	        json += ",";
	      }
	    }
    	json += "]"    
    
    
   if(valiChk == 0 && modifyLen >0)
   {
	    var cnt = GridClass_edit_1st.store.getCount();		// Grid의 총갯수
	     

		//alert("---->json--"+json+"--cnt--"+cnt);
		
		Ext.Ajax.request({   
			url: "/dev/csrInfo/actionCsrInfoReviewMng.sg"   
			,success: function(response){						// 조회결과 성공시
						// 조회된 결과값, store명
						//alert(response.responseText);
						handleSuccess(response,GridClass_edit_1st,'save');
											
			          }
			,failure: handleFailure   	    // 조회결과 실패시  
			,form   : document.searchForm   // 상세 FORM
			,params : { 
					   limit          : limit_edit_1st
					  , start          : start_edit_1st
					  , data  : json 		
				      } 
		});  
		
		fnInitValue(); // 상세필드 초기화
	}
}  		



/***************************************************************************
 * 설  명 : 삭제버튼 클릭
 ***************************************************************************/
function fnGridDeleteRow(selectedRecord){
	
	var json = "["+Ext.util.JSON.encode(selectedRecord.data)+"]";
	
	//alert("-fnGridDeleteRow->"+json);

/*	
	Ext.Ajax.request({   
		url: "/dev/csrInfo/deleteCsrReviewInfoMng.sg"   
		,success: function(response){						// 조회결과 성공시
					// 조회된 결과값, store명
					handleSuccess(response,GridClass_1st);
		          }
		,failure: handleFailure   	    // 조회결과 실패시  
		,form   : document.searchForm   // 검색 FORM
		,params : { 
					limit          		: limit_edit_1st
				   , start         		: start_edit_1st
				   ,deleteData : json
			      } 
	});
	
	
	fnInitValue(); // 상세필드 초기화
*/	
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
		Ext.get('src_rw_csr_date_from_tmp').set({value:fromDay} , false);
		Ext.get('src_rw_csr_date_to_tmp').set({value:toDay} , false);
	});	
			

			
	//등록 버튼 -> 데이터를 server로 전송
	Ext.get('saveBtn').on('click', function(e){	
			Ext.MessageBox.confirm('Confirm', '저장하시겠습니까?', showResult);
	});
	
	//수정 버튼 -> 데이터를 server로 전송
	/*
	Ext.get('updateBtn').on('click', function(e){	
			Ext.MessageBox.confirm('Confirm', '수정하시겠습니까?', showResult);
	});
	*/
	

	 	

	// 업무요청기간 from
	var enddt = new Ext.form.DateField({
	    	applyTo: 'src_rw_csr_date_from_tmp',
			allowBlank: false,
			format:'Y-m-d',
			editable : true,
			value : fromDay
	});
	
	Ext.get('src_rw_csr_date_from_tmp').on('change', function(e){	
		
		var val = Ext.get('src_rw_csr_date_from_tmp').getValue();
		var reVal = fnGridDateCheck(val);
		
		Ext.get('src_rw_csr_date_from_tmp').set({value:reVal} , false);
	});
	
	
	
	// 업무요청기간 to
	var enddt = new Ext.form.DateField({
	    	applyTo: 'src_rw_csr_date_to_tmp',
			allowBlank: false,
			format:'Y-m-d',
			editable : true,
			value : toDay
	});
	
	Ext.get('src_rw_csr_date_to_tmp').on('change', function(e){	
		
		var val = Ext.get('src_rw_csr_date_to_tmp').getValue();
		var reVal = fnGridDateCheck(val);
		
		Ext.get('src_rw_csr_date_to_tmp').set({value:reVal} , false);
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
	 var dlgWidth  = 417;
	 var dlgHeight = 360;
	 var winName   = "dept";
	 fnOpenPop(sURL, dlgWidth, dlgHeight, winName);
}


/***************************************************************************
 * 설  명 : 부서검색 결과 반영
 ***************************************************************************/
function fnDeptPopValue(records, fieldName){
		
	// 전송받은 값이 한건일 경우
    var record = records[0].data;				

   	Ext.get('src_csr_dept_code').set({value:record.DEPT_CODE} , false);
   	Ext.get('src_csr_dept_name').set({value:record.DEPT_NAME} , false);


}

// 팝업
function fnOpenPop(sURL, dlgWidth, dlgHeight, winName){
  var xPos=(window.screen.width) ? (window.screen.width-dlgWidth)/2 : 0;
  var yPos=(window.screen.height) ? (window.screen.height-dlgHeight)/2 : 0;
  var sFeatures = "titlebar=no, scrollbars=yes,location=no ,menubar=no, resizable=yes, status=yes, width="+dlgWidth+",height="+dlgHeight+",left="+xPos+", top="+yPos;
  window.open(sURL,winName, sFeatures);
}


/***************************************************************************
 * 설  명 : 에디트 그리드의 CELL을 수정하였을 경우 이벤트
 ***************************************************************************/
function  fnEdit1stAfterCellEdit(obj){

	var rowCnt = GridClass_edit_1st.store.getCount();  // Grid의 총갯수
	
	var editedRow = obj.row;
	var editedColumn = obj.column;
	var editedValue = obj.value;		//선택한 컬럼의 값
	var fieldName = obj.field;
	
	var cmpCsrId = GridClass_edit_1st.store.data.items[editedRow].data.CSR_ID; // 선택한 행의 csr_id
//alert("--editedRow-"+editedRow+"-editedColumn--"+editedColumn+"-editedValue-"+editedValue+"--fieldName-->"+fieldName+"--data.CSR_ID-"+GridClass_edit_1st.store.data.items[editedRow].data.CSR_ID);	

/*
	if(fieldName == 'CSR_STATUS_CODE')
	{
		for(var k=0;  k < rowCnt; k++)
		{
			var recodeAt = GridClass_edit_1st.store.getAt(k);
	 		var data = recodeAt.data.CSR_ID;       //기존 데이타

			if(cmpCsrId == data)
			{
				recodeAt.set('CSR_STATUS_CODE',editedValue);
			
			}
		}
	}
*/

}



</script>


</head>
<body>
	<table border="0" width="1000" height="200">
		<tr>
			<td colspan="2">
				<form name="searchForm">
				<input type="hidden" id="src_rw_csr_date_from" name="src_rw_csr_date_from"  />
				<input type="hidden" id="src_rw_csr_date_to" name="src_rw_csr_date_to"  />
                <input type="hidden" id="src_csr_dept_code" name="src_csr_dept_code"  />				<!-- 부서코드-->								
                
				<!----------------- SEARCH Hearder Start	 ----------------->
				<div id="ext-comp-1002" class=" x-panel x-form-label-left" style="margin-top: 0.4em;"><%-- 0em <- 1em으로 수정하면 상위 공백 --%>
					<div class="x-panel-tl">
						<div class="x-panel-tr">
							<div class="x-panel-tc">
								<div id="ext-gen4" class="x-panel-header x-unselectable" style="-moz-user-select: none;">
									<span id="ext-gen8" class="x-panel-header-text">업무요청정보 검색</span>
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
										
										<td width="9%">
											<div tabindex="-1" class="x-form-item " >
												<label class="x-form-item-label" style="width: auto;" for="src_rw_csr_date_from_tmp" >업무요청기간 :</label>
											</div>
										</td>										


										<td width="20%" align="left">
											<div tabindex="-1" class="x-form-item " >
													<table border="0" width="100%" >
														<tr>
															<td align="center">
																<input type="text" name="src_rw_csr_date_from_tmp" id="src_rw_csr_date_from_tmp"  style="width:80px; " >
															</td>
															<td align="left">~</td>
														    <td align="center">
																<input type="text" name="src_rw_csr_date_to_tmp" id="src_rw_csr_date_to_tmp"  style="width:80px;" >
															</td>
														</tr>
													</table>
											</div>
										</td>										
										
										
										<td width="16%">
											<div tabindex="-1" class="x-form-item " >
												<label class="x-form-item-label" style="width: auto;" for="src_csr_dept_name" >요청부서 :</label>
												<div style="padding-left: 80px;" class="x-form-element">
													<input type="text" name="src_csr_dept_name" id="src_csr_dept_name" autocomplete="off" size="15" class="x-form-text x-form-field" style="width: auto;">
												</div>
											</div>
										</td>
										<td width="10%" valign="top">
											<%-- Button Start--%>
												<div style="padding-left: 0px;" >
													<img align="center" id="deptSearchBtn" name="deptSearchBtn" alt="" src="/resource/images/bass_1st/icon_src1.gif" style="cursor: hand;">
												</div>
											<%-- Button End--%>
											
										</td>
																				
										<td width="30%">
											<div tabindex="-1" class="x-form-item " >
												<label class="x-form-item-label" style="width: auto;" for="src_task_group_code">업무요청구분 :</label>
												<div style="padding-left: 30px;" class="x-form-element">
													<select name="src_csr_type_code" id="src_csr_type_code" style="width: 29%;" type="text" class=" x-form-select x-form-field" >
														<option value="">전체</option>
														<c:forEach items="${SR_TYPE_CODE}" var="data" varStatus="status">
															<c:if test="${data.COM_CODE != '20'}">   
																<option value="${data.COM_CODE}"><c:out value="${data.COM_CODE_NAME}"/></option>
															</c:if>
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
			<td colspan="2">
				<div id="csr_reviw_grid" style="margin-top: 0.4em;"></div> <!----------------- 그리드명을 동일하게 설정 ----------------->
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
											<button type="button" id="updateBtn" name="updateBtn" class=" x-btn-text">수정</button>
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