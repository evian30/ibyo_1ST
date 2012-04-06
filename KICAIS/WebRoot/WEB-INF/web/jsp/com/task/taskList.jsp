<%--
  Class Name  : taskList.jsp
  Description : 타스크 관리
  Modification Information
 
      수정일                   수정자                 수정내용
  -------      --------    ---------------------------
  2011. 3. 11   고기범            최초 생성   
  2011. 3. 25  고기범              디자인 변경 및 공통 JS적용   
  
  author   : 고기범
  since    : 2011. 3. 11.
  version  : 1.0
   
  Copyright (C) 2011 by SG All right reserved.
--%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/web/jsp/common/inc/commonInc.jsp" %>
<script type="text/javascript" src="/resource/common/js/sgis-comm-inc.js" ></script> 
<script type="text/javascript" src="/resource/common/js/common/common-msg-box.js" ></script> 
<script type="text/javascript" src="/resource/common/js/ajax.js" ></script>

<script type="text/javascript" src="/resource/common/js/grid/grid_1st.js"></script>
<script type="text/javascript" src="/resource/common/js/grid/grid_edit_1st.js"></script>

<script type="text/javascript">
/***************************************************************************
 * 초기값 설정
 ***************************************************************************/
var	gridHeigth_1st 	 	= 388; 						// 그리드 전체 높이
var	gridWidth_1st		= 500;						// 그리드 전체 폭
var gridTitle_1st 		= "타스크정보관리";	  		// 그리드 제목
var	render_1st			= "task-grid";	  			// 렌더(화면에 그려질) 할 id 
var	pageSize_1st		= 14;	  					// 그리드 페이지 사이즈	
var	proxyUrl_1st		= "/com/task/result.sg";	// 결과 값 페이지
var limit_1st			= pageSize_1st;
var start_1st			= 0;

/***************************************************************************
 * Grid의 컬럼 설정
 ***************************************************************************/
var userColumns_1st = [	{header: "상태",		    width: 100, sortable: true, dataIndex: 'FLAG', 			 hidden : true}       
					  , {header: "그룹", 		width: 60,  sortable: true, dataIndex: 'TASK_GROUP_CODE',hidden : true}
					  , {header: "그룹",     	width: 40,  sortable: true, dataIndex: 'TASK_GROUP_NAME1'}
					  , {header: "그룹명",     	width: 60,  sortable: true, dataIndex: 'TASK_GROUP_NAME',hidden : true}
					  , {header: "코드",  	    width: 30,  sortable: true, dataIndex: 'TASK_CODE'       }                  
					  , {header: "타스크명",		width: 50,  sortable: true, dataIndex: 'TASK_NAME'       }
					  , {header: "타스크설명",	width: 130, sortable: true, dataIndex: 'TASK_DESC'       }
					  , {header: "순번",			width: 50,  sortable: true, dataIndex: 'TASK_INFO_SEQ',	 hidden : true}
					  , {header: "비고",	  	    width: 50,  sortable: true, dataIndex: 'NOTE', 			 hidden : true}
					  , {header: "사용여부", 	width: 50,  sortable: true, dataIndex: 'USE_YN' , 		 hidden : true}  
					  , {header: "최종변경자", 	width: 100, sortable: true, dataIndex: 'FINAL_MOD_ID', 	 hidden : true}  
					  , {header: "최종변경일", 	width: 50,  sortable: true, dataIndex: 'FINAL_MOD_DATE', hidden : true}
					  ];	 

/***************************************************************************
 * 그리드 결과매핑 
 ***************************************************************************/
var mappingColumns_1st = [ 
						  {name: 'FLAG' 		  	,allowBlank: false}	 // 상태
						 ,{name: 'TASK_GROUP_CODE'	,allowBlank: false}  // 타스크그룹코드  
						 ,{name: 'TASK_GROUP_NAME1'	,allowBlank: false}  // 타스크그룹명
						 ,{name: 'TASK_GROUP_NAME'	,allowBlank: false}  // 타스크그룹명
						 ,{name: 'TASK_CODE'	  	,allowBlank: false}  // 타스크코드
						 ,{name: 'TASK_NAME'	  	,allowBlank: false}  // 타스크명
						 ,{name: 'TASK_DESC'  	  	,allowBlank: false}  // 타스크설명
						 ,{name: 'TASK_INFO_SEQ'  	,allowBlank: false}  // 순번
						 ,{name: 'NOTE' 		  	,allowBlank: false}  // 비고
						 ,{name: 'USE_YN' 		  	,allowBlank: false}  // 사용여부      
						 ,{name: 'FINAL_MOD_ID'   	,allowBlank: false}  // 최종변경자ID  
						 ,{name: 'FINAL_MOD_DATE' 	,allowBlank: false}  // 최종변경일시
	    				 ];
 
/***************************************************************************
 * 그리드 클릭시 Event
 ***************************************************************************/
function fnGridOnClick_1st(store, rowIndex){

	/***** 선택된 레코드에서 데이타 가져오기 *****/
	var flag		  = fnFixNull(store.getAt(rowIndex).data.FLAG);			   	// 상태        
	var taskGroupCode = fnFixNull(store.getAt(rowIndex).data.TASK_GROUP_CODE);	// 타스크그룹코드
	var taskGroupName = fnFixNull(store.getAt(rowIndex).data.TASK_GROUP_NAME);	// 타스크그룹명    
	var taskCode      = fnFixNull(store.getAt(rowIndex).data.TASK_CODE);		// 타스크코드        
	var taskName      = fnFixNull(store.getAt(rowIndex).data.TASK_NAME);		// 타스크명 
	var taskDesc	  = fnFixNull(store.getAt(rowIndex).data.TASK_DESC);		// 타스크설명
	var taskInfoSeq	  = fnFixNull(store.getAt(rowIndex).data.TASK_INFO_SEQ);	// 순번      
	var note	 	  = fnFixNull(store.getAt(rowIndex).data.NOTE);		   		// 비고
	var useYn		  = fnFixNull(store.getAt(rowIndex).data.USE_YN); 			// 사용여부    
	var finalModId	  = fnFixNull(store.getAt(rowIndex).data.FINAL_MOD_ID); 	// 최종변경자ID
	var finalModDate  = fnFixNull(store.getAt(rowIndex).data.FINAL_MOD_DATE);	// 최종변경일시			
	
	/***** 그리드에 선택된 값을 상세 필드에 설정 *****/		
	var dForm = document.detailForm;
	dForm.flag.value            = flag;		   	 // 상태
	dForm.task_group_code.value = taskGroupCode; // 타스크그룹코드
	dForm.task_group_name.value = taskGroupName; // 타스크그룹명
	dForm.task_code.value 		= taskCode;	 	 // 타스크코드
	dForm.task_name.value   	= taskName;	 	 // 타스크명
	dForm.task_desc.value  		= taskDesc;  	 // 타스크설명
	dForm.note.value  			= note;  		 // 비고
	//dForm.use_yn.value  		= useYn;  		 // 사용여부
	//dForm.final_mod_id.value    = finalModId;	 // 최종변경자ID
	//dForm.final_mod_date.value  = finalModDate;	 // 최종변경일시
	
	// 사용여부
	if(useYn == 'Y'){
		 dForm.use_yn[0].checked = true;
	}else if(useYn == 'N'){
		 dForm.use_yn[1].checked = true;
	}
	
	/***** 필드 비활성화 *****/
	dForm.task_group_code.disabled = true;		  // 타스크그룹코드
	dForm.task_code.disabled 	   = true;		  // 타스크코드
	dForm.task_code_Btn.disabled   = true;
	Ext.get('saveBtn').dom.disabled    = true;
	Ext.get('updateBtn').dom.disabled  = false;

	// 타스크산출물 검색
	fnEditGridSearch(store, rowIndex);
	
;}   

// ********************************************************************* //
/** 서버스펙 EditGrid - edit_1st Start**/
var	gridHeigth_edit_1st	=	"168";
var	gridWidth_edit_1st  =	500 ;
var	gridTitle_edit_1st  =   "타스크산출물"	; 
var	render_edit_1st		=	"task-report-grid";
var keyNm_edit_1st		= 	"TASK_REPORT_SEQ";
var gridRowDeleteYn     =   "Y";
var pageSize_edit_1st	=	15;
var limit_edit_1st		=	pageSize_edit_1st;
var start_edit_1st		=	0;
var proxyUrl_edit_1st	=	"/com/task/taskReportInfoResult.sg";
var gridRowDeleteYn     = "";

function addNew_edit_1st(){

	var task_group_code = Ext.get('task_group_code').getValue();
	var task_code = Ext.get('task_code').getValue();
	
	if(task_group_code.length == 0 || task_group_code == ""){
		Ext.Msg.alert('확인', '그룹코드를 선택해주세요.')
		return false;
	}
	
	if(task_code.length == 0 || task_code == ""){
		Ext.Msg.alert('확인', '코드를 입력해주세요.')
		return false;
	}
	
	var Plant = GridClass_edit_1st.grid.getStore().recordType; 
    var p = new Plant({ FLAG	        : 'I' 
	        		  , TASK_GROUP_CODE	: Ext.get('task_group_code').getValue()
				   	  , TASK_CODE       : Ext.get('task_code').getValue()
				   	  , MANDETORY_YN    : true
				   	  , USE_YN          : 'Y'
		    		 }); 
  	GridClass_edit_1st.grid.stopEditing();
	GridClass_edit_1st.store.insert(0, p);
	GridClass_edit_1st.grid.startEditing(0, 0);
	
}

function fnPagingValue_edit_1st(){	
	
	
	try{
		
		var checkColumn = new Ext.grid.CheckColumn({
       		header: '필수여부',
       		dataIndex: 'mandetory_yn',
       		width: 100
    	});	
		
		GridClass_edit_1st.store.setBaseParam('start'			,start_edit_1st);
	    GridClass_edit_1st.store.setBaseParam('limit'			,limit_edit_1st);
		GridClass_edit_1st.store.setBaseParam('task_group_code'	,Ext.get('task_group_code').getValue());
		GridClass_edit_1st.store.setBaseParam('task_code'		,Ext.get('task_code').getValue());
	}catch(e){

	}

}

// 사용여부코드 combo box 생성 start
var YESNO_CODE_COMBO = new Ext.form.ComboBox({    
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
	  ['', ''],
     <c:forEach items="${YESNO_CODE}" var="data" varStatus="status">
      ['${data.COM_CODE}', '${data.COM_CODE_NAME}']
      <c:if test="${not status.last}">,</c:if>
     </c:forEach>
      ]
   })
});

//combo box render
Ext.util.Format.comboRenderer = function(YESNO_CODE_COMBO){    
 return function(value){        
 var record = YESNO_CODE_COMBO.findRecord(YESNO_CODE_COMBO.valueField, value);        
 return record ? record.get(YESNO_CODE_COMBO.displayField) : YESNO_CODE_COMBO.valueNotFoundText;    
}}
 

var	userColumns_edit_1st	= [  // checkSm
							 	 {header: "타스크그룹코드"	,width:   0	,sortable: true	,dataIndex: "TASK_GROUP_CODE"	, hidden : true}
								,{header: "타스크코드"		,width:   0	,sortable: true	,dataIndex: "TASK_CODE"			, hidden : true}
								,{header: "순번"				,width:  50	,sortable: true	,dataIndex: "TASK_REPORT_SEQ"	,id:'task_report_seq' }
								,{header: "산출물명"			,width: 150	,sortable: true	,dataIndex: "TASK_REPORT"		,editor: new Ext.form.TextField({ allowBlank : true }) }
								,{header: "필수여부"			,width: 100	,sortable: true	,dataIndex: "MANDETORY_YN"		,editor: YESNO_CODE_COMBO ,renderer: Ext.util.Format.comboRenderer(YESNO_CODE_COMBO)}
								,{header: "사용여부"			,width: 100	,sortable: true	,dataIndex: "USE_YN"			,editor: YESNO_CODE_COMBO ,renderer: Ext.util.Format.comboRenderer(YESNO_CODE_COMBO)}
								,{header: "비고"				,width: 100	,sortable: true	,dataIndex: "NOTE"				,editor: new Ext.form.TextField({ allowBlank : true }) , hidden : true}
								,{header: "최종변경자ID"		,width: 100	,sortable: true	,dataIndex: "FINAL_MOD_ID"		, hidden : true}
								,{header: "최종변경일시"		,width: 100	,sortable: true	,dataIndex: "FINAL_MOD_DATE"	, hidden : true}
						  	  ];	

var	mappingColumns_edit_1st	= [ {name: "TASK_GROUP_CODE" ,type:"string" ,mapping: "TASK_GROUP_CODE"} // 타스크그룹코드  
							  , {name: "TASK_CODE"		 ,type:"string" ,mapping: "TASK_CODE"}       // 타스크 코드     
							  , {name: "TASK_REPORT_SEQ" ,type:"string" ,mapping: "TASK_REPORT_SEQ"} // 타스크산출물순번
							  , {name: "TASK_REPORT"	 ,type:"string" ,mapping: "TASK_REPORT"}     // 관련산출물      
							  , {name: "MANDETORY_YN"	 ,type:"string" ,mapping: "MANDETORY_YN"}    // 필수여부        
							  , {name: "USE_YN"			 ,type:"string" ,mapping: "USE_YN"}          // 사용여부        
							  , {name: "NOTE"			 ,type:"string" ,mapping: "NOTE"}            // 비고            
							  , {name: "FINAL_MOD_ID"	 ,type:"string" ,mapping: "FINAL_MOD_ID"}    // 최종변경자ID    
							  , {name: "FINAL_MOD_DATE"	 ,type:"string" ,mapping: "FINAL_MOD_DATE"}  // 최종변경일시 
	    				 	  ]; 

function renderCheckbox(val){ 
     return val ? "Y" : "N"; 
} 

function goAction_edit_1st(){
	
	var modifyRecords = GridClass_edit_1st.store.getModifiedRecords();		//수정된 레코드 지정한 키 값으로 찾아 내기  
	var modifyLen = modifyRecords.length;
	
	if(modifyLen > 0){
		for(var i = 0; i < modifyLen ; i++){
			var modifyKeyNm = modifyRecords[i].get(keyNm_edit_1st) 
			                   	                                    	
			var task_code       = modifyRecords[i].get("TASK_CODE")
			var task_group_code = modifyRecords[i].get("TASK_GROUP_CODE")	 

			Ext.Ajax.request({   
				 url	: "/com/item/actionItemHW.sg"
				,method : 'POST'
				,params : { task_group_code : modifyRecords[i].get("TASK_GROUP_CODE") // 타스크그룹코드  
						  , task_code       : modifyRecords[i].get("TASK_CODE") 	  // 타스크 코드     
						  , task_report_seq	: modifyRecords[i].get("TASK_REPORT_SEQ") // 타스크산출물순번
						  , task_report     : modifyRecords[i].get("TASK_REPORT") 	  // 관련산출물      
						  , mandetory_yn    : modifyRecords[i].get("MANDETORY_YN") 	  // 필수여부        
						  , use_yn          : modifyRecords[i].get("USE_YN") 		  // 사용여부        
						  , note            : modifyRecords[i].get("NOTE") 			  // 비고            
						  , final_mod_id    : modifyRecords[i].get("FINAL_MOD_ID") 	  // 최종변경자ID    
						  , final_mod_date  : modifyRecords[i].get("FINAL_MOD_DATE")  // 최종변경일시  
						  }
			});								
			
			//마지막 
			GridClass_edit_1st.store.reload({
				params: {
					 task_group_code : task_group_code
					,task_code       : task_code
				}
			});  
			
		}
	}		

} 

/** 서버스펙 EditGrid - edit_1st End**/


/***************************************************************************
 * 설  명 : 필드 초기화
 **************************************************************************/
function fnInitValue(){
	var dForm = document.detailForm;		// 상세 FORM	
	
	dForm.reset();							// 상세필드 초기화
	dForm.task_group_code.disabled = false;	// 타스크그룹코드
	dForm.task_code.disabled 	   = false;	// 타스크코드
	Ext.get('task_code_Btn').dom.disabled = false;
	Ext.get('saveBtn').dom.disabled    	  = false;
	Ext.get('updateBtn').dom.disabled  	  = true;
	dForm.use_yn[0].checked = true;
	
	try{
		GridClass_edit_1st.store.reload();
	}catch(e){
		
	}
}

/***************************************************************************
 * 설  명 : 검색
 **************************************************************************/
function fnSearch(){  	
	
	Ext.Ajax.request({   
		url: "/com/task/result.sg"
		,method : 'POST'   
		,success: function(response){						// 조회결과 성공시
					// 조회된 결과값, store명
					handleSuccess(response,GridClass_1st);
		          }
		,failure: handleFailure   	   // 조회결과 실패시  
		,form   : document.searchForm  // 검색 FORM
		,params : {					   // 조회조건을 DB로 전송하기위해서 조건값 설정
					limit          : limit_1st
				  , start          : start_1st
				  }				
	});  
	
	fnInitValue(); // 상세필드 초기화
}  		


/***************************************************************************
 * 설  명 : 타스크 산출물 검색
 **************************************************************************/
function fnEditGridSearch(store, rowIndex){  	
		
	Ext.Ajax.request({   
		url: "/com/task/taskReportInfoResult.sg"
		,method : 'POST'   
		,success: function(response){						// 조회결과 성공시
					// 조회된 결과값, store명
					handleSuccess(response,GridClass_edit_1st);
		          }
		,failure: handleFailure   	   // 조회결과 실패시  
		,form   : document.searchForm  // 검색 FORM
		,params : {					   // 조회조건을 DB로 전송하기위해서 조건값 설정
					limit           : limit_edit_1st
				  , start           : start_edit_1st
				  , task_group_code : fnFixNull(store.getAt(rowIndex).data.TASK_GROUP_CODE)	// 타스크그룹코드
				  , task_code		: fnFixNull(store.getAt(rowIndex).data.TASK_CODE)		// 타스크코드
				  }				
	});  
	
} 
/***************************************************************************
 * 설  명 : 저장버튼 클릭
 ***************************************************************************/
function fnSave(){  	

	var sForm = document.searchForm;	// 검색 FORM
	var dForm = document.detailForm;	// 상세 FORM
	// 변경된 Gride의 record
	var records = GridClass_edit_1st.store.getModifiedRecords();	  
	// 변경된 record의 자료를 json형식으로
    var json = "[";
	    for (var i = 0; i < records.length; i++) {
	      json += Ext.util.JSON.encode(records[i].data);				
	      if (i < (records.length-1)) {
	        json += ",";
	      }
	    }
    	json += "]"
    
   
    /* 화면에 보여지는 그리드를 server로 보낼경우 
     * 행이 삭제되어 화면에 보여지지 않으면 현재 상태에 표시되지 않음
     * */	
    var cnt = GridClass_edit_1st.store.getCount();		// Grid의 총갯수
     
    var json1 = "[";
	    for (var i = 0; i < cnt; i++) {						// 그리드의 수만큼 for문
	      	records = GridClass_edit_1st.store.getAt(i);	// i번째 행의 record를 받아서
	      	
	      	if(records.data.FLAG == 'I'){
	      		records.set('TASK_GROUP_CODE',Ext.get('task_group_code').getValue());
	      		records.set('TASK_CODE',Ext.get('task_code').getValue());
	      	}
	      	
	      	json1 += Ext.util.JSON.encode(records.data);   	// record을 자료를 json형식으로 
	   		if (i < (cnt-1)) {
	        	json1 += ",";
	      	}// end if
	    }// end for
	    json1 += "]"
    
	// 그룹코드값이 넘어갈수 있도록 disable 해제
	dForm.task_group_code.disabled = false; 
	dForm.task_code.disabled = false; 
	
	Ext.Ajax.request({   
		url: "/com/task/updateTask.sg"   
		,success: function(response){						// 조회결과 성공시
					// 조회된 결과값, store명
					handleSuccess(response,GridClass_1st,'save');
		          }
		,failure: handleFailure   	    // 조회결과 실패시  
		,form   : document.detailForm   // 상세 FORM
		,params : { 
					limit          : limit_1st
				  , start          : start_1st
				  , data  		   : json 		// grid_edit_1st
			      } 
	});  
	
	fnInitValue(); // 상세필드 초기화
}  		

/***************************************************************************
 * 설  명 : 화면 설정
 ***************************************************************************/
// ExtJS 진입함수
Ext.onReady(function() {

	var dForm = document.detailForm;
	var sForm = document.searchForm;
	
	//검색하기 버튼 
	Ext.get('searchBtn').on('click', function(e){
		fnSearch()
	});	
		
	//조건해제 버튼 -> 검색조건 초기화
	Ext.get('searchClearBtn').on('click', function(e){
		sForm.reset();
		fnSearch();
	});	
			
	//신규 버튼 -> 상세필드 초기화
	Ext.get('detailClearBtn').on('click', function(e){
		fnInitValue();		   
	});	

	// 코드변경이 일어나면
	Ext.get('task_code').on('change', function(e){
		dForm.task_code_check.value = '';
	});	
	
			
	//등록 버튼 -> 데이터를 server로 전송
	Ext.get('saveBtn').on('click', function(e){	
		if(fnValidation()){
			
			/* 신규등록시 코드 중복체크 */
			var checkTaskCode = dForm.task_code_check.value;
			if(checkTaskCode != 'Y'){
				alert("코드 중복체크를 해주세요.");
				dForm.task_code_Btn.focus();
				return false;	
			}
			
			Ext.MessageBox.confirm('Confirm', '저장하시겠습니까?', showResult);
		};
	});
	
	//수정 버튼 -> 데이터를 server로 전송
	Ext.get('updateBtn').on('click', function(e){	
		if(fnValidation()){
			Ext.MessageBox.confirm('Confirm', '수정하시겠습니까?', showResult);
		};	
	});
	
	//타스크코드 중복체크
	Ext.get('task_code_Btn').on('click', function(e){	

	    var dFrom 		  = document.detailForm;
		var taskGroupCode = dFrom.task_group_code.value;
	    var taskCode      = dFrom.task_code.value;
		
		if(taskGroupCode.length == 0 || taskGroupCode == ""){
			alert("그룹코드를 선택하세요");
	    	dFrom.task_group_code.focus();
		}else if(taskCode.length == 0 || taskCode == ""){
	    	alert("코드를 입력하세요");
	    	dFrom.task_code.focus();
	    }else{
	    	Ext.Ajax.request({   
			url: "/com/task/checkTaskCode.sg"   
			,mothod : 'POST'
			,success: function(response){    // 조회결과 성공시
	    		 		var jsonData = Ext.util.JSON.decode(response.responseText);
	    				var checkValue = jsonData.CHECK_TASK_CODE;
	    				dFrom.task_code_check.value = checkValue;
  		  			  	if(checkValue == 'Y'){
  		  			  		alert("사용가능한 코드입니다.");
  		  			  	}else{
  		  			  		alert("사용불가능한 코드입니다.");
  		  			  	}
  		  			  	
	    			  } 					
			,failure: function(response){   // 조회결과 실패시  
					    var jsonData = Ext.util.JSON.decode(response.responseText);
	    				var checkValue = jsonData.CHECK_TASK_CODE;
	    				dFrom.task_code_check.value = checkValue;
  		  			  	if(checkValue != 'Y'){
  		  			  		alert("사용불가능한 코드입니다.");
  		  			  	}
  		  			  }			   	    	
			,form   : document.detailForm   // 상세 FORM
			}); 
	    }// end if
		
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
function fnPop(fieldCode,fieldName){
	var sURL      = "/com/dept/deptPop.sg?fieldCode="+fieldCode+'&fieldName='+fieldName;
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

/***************************************************************************
 * 설  명 : 그리드의 페이지 클릭시 검색조건값을 DB로 전송
 ***************************************************************************/
function fnPagingValue_1st(){
	var sForm = document.searchForm;
	
	try{
    	GridClass_1st.store.setBaseParam('src_task_group_code', Ext.get('src_task_group_code').getValue());
    	GridClass_1st.store.setBaseParam('src_task_code', 	    Ext.get('src_task_code').getValue());
    	GridClass_1st.store.setBaseParam('src_task_name',       Ext.get('src_task_name').getValue());
	}catch(e){

	}
}

function fnValidation(){

	var task_group_code = Ext.get('task_group_code').getValue();	// 그룹코드
	var task_code = Ext.get('task_code').getValue(); 				// 타스크코드
	var task_name = Ext.get('task_name').getValue(); 				// 타스크명
	var task_name_len = getByteLength(task_name);	
	var task_desc_len = getByteLength(Ext.get('task_desc').getValue());
	var note_len = getByteLength(Ext.get('note').getValue());

	if(task_group_code.length == 0 || task_group_code == ""){
		Ext.Msg.alert('확인', '그룹코드를 선택해주세요.')
		return false;
	}
	
	if(task_code.length == 0 || task_code == ""){
		Ext.Msg.alert('확인', '코드를 입력해주세요.')
		return false;
	}
	
	if(task_name.length == 0 || task_name == ""){
		Ext.Msg.alert('확인', '타스크명을 입력해주세요.')
		return false;
	}
	
	if(task_name_len > 100){
		Ext.Msg.alert('확인', '타스크명은 한글 50자까지 입력가능합니다.')
		return false;
	}
	
	if(task_desc_len > 500){
		Ext.Msg.alert('확인', '타스크설명은 한글 250자까지 입력가능합니다.')
		return false;
	}
	
	if(note_len > 1000){
		Ext.Msg.alert('확인', '비고는 한글 500자까지 입력가능합니다.')
		return false;
	}
	
	return true;
	
}

</script>

<body>
	<table border="0" width="1000" height="200">
		<tr>
			<td colspan="2">
				<form name="searchForm">
				<!----------------- SEARCH Hearder Start	 ----------------->
				<div id="ext-comp-1002" class=" x-panel x-form-label-left" style="margin-top: 0em;"><%-- 0em <- 1em으로 수정하면 상위 공백 --%>
					<div class="x-panel-tl">
						<div class="x-panel-tr">
							<div class="x-panel-tc">
								<div id="ext-gen4" class="x-panel-header x-unselectable" style="-moz-user-select: none;">
									<span id="ext-gen8" class="x-panel-header-text">타스크정보 검색</span>
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
										<td width="23%">
											<div tabindex="-1" class="x-form-item " >
												<label class="x-form-item-label" style="width: auto;" for="src_task_group_code">그룹코드 :</label>
												<div style="padding-left: 30px;" class="x-form-element">
													<select name="src_task_group_code" id="src_task_group_code" style="width: 50%;" type="text" class=" x-form-select x-form-field" >
														<option value="">전체</option>
														<c:forEach items="${TASK_GROUP_CODE}" var="data" varStatus="status">
														<option value="${data.COM_CODE}"><c:out value="${data.COM_CODE_NAME}"/></option>
														</c:forEach>
													</select>
												</div>
											</div>
										</td>
										
										<td width="23%">
											<div tabindex="-1" class="x-form-item " >
												<label class="x-form-item-label" style="width: auto;" for="src_task_code" >타스크코드 :</label>
												<div style="padding-left: 30px;" class="x-form-element">
													<input type="text" name="src_task_code" id="src_task_code" autocomplete="off" size="15" class="x-form-text x-form-field" style="width: auto;" maxlength="10">
												</div>
											</div>
										</td>
										
										<td width="29%">
											<div tabindex="-1" class="x-form-item " >
												<label class="x-form-item-label" style="width: auto;" for="src_task_name" >타스크명 :</label>
												<div style="padding-left: 80px;" class="x-form-element">
													<input type="text" name="src_task_name" id="src_task_name" autocomplete="off" size="30" class="x-form-text x-form-field" style="width: auto;" maxlength="50">
												</div>
											</div>
										</td>
										
										<td width="25%" align="right">
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
									<%-- 1 Row End --%>
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
			<td width="50%" valign="top">
				<div id="task-grid" style="margin-top: 0em;"></div><%-- 0em <- 1em으로 수정하면 상위 공백 --%><!----------------- 그리드명을 동일하게 설정 ----------------->		
			</td>
			<!------------------------------ GRID END ------------------------------------>
			<td width="50%" valign="top">
				<div class=" x-panel x-form-label-left" style="margin-top: 0em; width: 100%;"><%-- 0em <- 1em으로 수정하면 상위 공백 --%>
					<!----------------- SEARCH Hearder Start	 ----------------->
					<div class="x-panel-tl">
						<div class="x-panel-tr">
							<div class="x-panel-tc">
								<div class="x-panel-header x-unselectable" style="-moz-user-select: none;">
									<span class="x-panel-header-text">타스크 상세정보</span><!----------------- 이름변경 ----------------->		
								</div>
							</div>
						</div>
					</div>
					<!----------------- SEARCH Hearder End	 ----------------->
					<div class="x-panel-bwrap" >
						<div class="x-panel-ml">
							<div class="x-panel-mr">
								<div class="x-panel-mc" >
									<!-- 폼 시작 -->
									<form id="detailForm" name="detailForm" method="POST" class="x-panel-body x-form" style="padding: 1px 1px 0pt; width: 480px;">
									<!-- DETAIL 1_ROW Start -->
									<div class="x-column-inner" style="width: 100%;">
										<!-- 신규 버튼 시작 -->
										<div tabindex="-1" class="x-form-item" >
											<table cellspacing="0" class="x-btn  x-btn-noicon" style="width: 75px;" align="right">
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
																<button type="button" id="detailClearBtn" class=" x-btn-text">신규</button>
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
										</div>
										<!-- 신규 버튼 끝 -->
									</div>
									<!-- DETAIL 1_ROW End -->

									<!-- DETAIL 2_ROW Start -->
									<div class="x-column-inner" style="width: 100%; margin-top: 0.2em;">
										<div class=" x-panel x-column" style="width: 100%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label class="x-form-item-label " style="width: auto;" for="task_group_code" ><font color="red">* </font>그룹코드 :</label>
														<div style="padding-left: 85px;" class="x-form-element">
															<input type="hidden" id="flag" name="flag" style="width:80px" />
															<select name="task_group_code" id="task_group_code" style="width: 25%;" type="text" class=" x-form-select x-form-field" >
															<option value="">전체</option>
															<c:forEach items="${TASK_GROUP_CODE}" var="data" varStatus="status">
															<option value="${data.COM_CODE}"><c:out value="${data.COM_CODE_NAME}"/></option>
															</c:forEach>
														</select>
														</div>
														<div class="x-form-clear-left">
														</div>
													</div>
												</div>
											</div>
										</div>
<%--										<div class=" x-panel x-column" style="width: 50%;">--%>
<%--											<div class="x-panel-bwrap" >--%>
<%--												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">--%>
<%--													<div tabindex="-1" class="x-form-item " >--%>
<%--														<label class="x-form-item-label" style="width: auto;" for="task_group_name" ><font color="red">* </font>그룹명 :</label>--%>
														<input type="hidden" name="task_group_name" id="task_group_name" autocomplete="off" size="22" class=" x-form-text x-form-field" style="width: auto;">
<%--														<div class="x-form-clear-left">--%>
<%--														</div>--%>
<%--													</div>--%>
<%--												</div>--%>
<%--											</div>--%>
<%--										</div>--%>
									</div>
									<!-- DETAIL 2_ROW End -->
								
									<!-- DETAIL 3_ROW Start -->
									<div class="x-column-inner" style="width: 100%; margin-top: 0.2em;">
										<div class=" x-panel x-column" style="width: 50%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label class="x-form-item-label" style="width: auto;" for="task_code" ><font color="red">* </font>코드 :</label>
														<div style="padding-left: 85px;" class="x-form-element">
															<table style="width: 100px;" cellspacing="0" class="x-btn  x-btn-noicon" border="0">
																<tr>
																	<td>
																		<input type="text" name="task_code" id="task_code" autocomplete="off" size="13" class="x-form-text x-form-field " style="width: auto;" maxlength="10"/>
																		<input type="hidden" id="task_code_check" name="task_code_check" style="width:20px"/>
																	</td>
																	<td>
																		<%-- Button Start--%>
																		<table cellspacing="0" class="x-btn  x-btn-noicon" style="width: 20px;" align="right">
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
																							<button type="button" id="task_code_Btn" name="task_code_Btn" class=" x-btn-text">체크</button>
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
																		<%-- Button End--%>
																	</td>
																</tr>
															</table>
														</div>
														<div class="x-form-clear-left">
														</div>
													</div>
												</div>
											</div>
										</div>
										<div class=" x-panel x-column" style="width: 50%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label style="padding-rigth: 100px;"  class="x-form-item-label" style="width: auto;" for="task_name" ><font color="red">* </font>타스크명 :</label>
														<input type="text" name="task_name" id="task_name" autocomplete="off" size="22" class=" x-form-text x-form-field" style="width: auto;" maxlength="25">
													</div>
												</div>
											</div>
										</div>
									</div>
									<!-- DETAIL 3_ROW End -->
								
									<!-- DETAIL 4_ROW Start -->
									<div class="x-column-inner" style="width: 100%; margin-top: 0.2em;">
										<div class=" x-panel x-column" style="width: 100%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label style="padding-rigth: 100px;"  class="x-form-item-label" style="width: auto;" for="use_yn1" ><font color="red">* </font>사용여부 :</label>
														<input type="radio" name="use_yn" id="use_yn1" autocomplete="off" class=" x-form-radio x-form-field" value="Y" >
													    <label class="x-form-cb-label" for="use_yn2" >Yes</label>
													    <input type="radio" name="use_yn" id="use_yn2" autocomplete="off" class=" x-form-radio x-form-field" value="N">
													    <label class="x-form-cb-label" for="use_yn2" >No</label>
														<div class="x-form-clear-left">
														</div>
														<div class="x-form-clear-left">
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>
									<!-- DETAIL 4_ROW End -->
								
									<!-- DETAIL 5_ROW Start -->
									<div class="x-column-inner" style="width: 100%; margin-top: 0.2em;">
										<div class=" x-panel x-column" style="width: 100%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label class="x-form-item-label" style="width: auto;" for="task_desc" >&nbsp;&nbsp;&nbsp;설명 :</label>
														<div style="padding-left: 86px;" class="x-form-element">
															<textarea name="task_desc" id="task_desc" autocomplete="off" style="width: 379px; height: 40px; left: 0px; top: 0px;" class="x-form-textarea x-form-field x-box-item"></textarea>
														</div>
														<div class="x-form-clear-left">
														</div>
													</div>
												</div>
											</div>
										</div>					
									</div>
									<!-- DETAIL 5_ROW End -->
									
									<!-- DETAIL 6_ROW Start -->
									<div class="x-column-inner" style="width: 100%; margin-top: 0.2em;">
										<div class=" x-panel x-column" style="width: 100%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label class="x-form-item-label" style="width: auto;" for="note" >&nbsp;&nbsp;&nbsp;비고 :</label>
														<div style="padding-left: 86px;" class="x-form-element">
															<textarea name="note" id="note" autocomplete="off" style="width: 379px; height: 40px; left: 0px; top: 0px;" class="x-form-textarea x-form-field x-box-item"></textarea>
														</div>
														<div class="x-form-clear-left">
														</div>
													</div>
												</div>
											</div>
										</div>					
									</div>
									<!-- DETAIL 6_ROW End -->
									
									
									<!-- DETAIL 7_ROW Start -->
									<div class="x-column-inner" style="width: 100%; margin-top: 0em;">
										<div class=" x-panel x-column" style="width: 100%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%; height: 8px;" >
													<div tabindex="-1" class="x-form-item " >
													</div>
												</div>
											</div>
										</div>					
									</div>
									<!-- DETAIL 7_ROW End -->
									
									</form>
								</div>
							</div>
						</div>
					</div>
				</div>
				<!----------------- DETAIL Field End	 ----------------->
				<%-- footer Start --%>
				<div id="" class="x-panel-bl x-panel-nofooter">
					<div class="x-panel-br">
						<div class="x-panel-bc">
						</div>
					</div>
				</div>
				<%-- footer End  --%>
				
				<div id="task-report-grid" style="margin-top: 0.2em;"></div><%-- 0em <- 1em으로 수정하면 상위 공백 --%><!----------------- 그리드명을 동일하게 설정 ----------------->
				
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
						<td width="1">
						</td>
						<td>
						<%-- 수정 버튼 Start --%>
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
						<%-- 수정 버튼 End --%>
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
</body>

<%@ include file="/WEB-INF/web/jsp/sgis-bottom-inc.jsp" %>