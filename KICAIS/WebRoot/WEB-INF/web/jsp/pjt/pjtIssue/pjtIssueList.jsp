<%--
  Class Name  : pjtIssueList.jsp
  Description : 프로젝트이슈관리
  Modification Information
 
      수정일                   수정자                 수정내용
  -------      --------    ---------------------------
  2011. 04. 19   여인범            최초 생성   
  
  author   : 여인범
  since    :  2011. 04. 19.
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
var	gridWidth_edit_1st  = 1000	;
var	gridTitle_edit_1st  = "프로젝트 이슈"; 
var	render_edit_1st		= "edit_grid_1st";
var keyNm_edit_1st		= "ISSUE_INFO_SEQ";
var pageSize_edit_1st	= 15;
var limit_edit_1st		= pageSize_edit_1st;
var start_edit_1st		= 0;
var proxyUrl_edit_1st	= "/pjt/pjtIssue/result_edit_1st.sg"; 
var gridRowDeleteYn	    = "";
var tbarHidden_edit_1st = "";
 
// 행추가
function addNew_edit_1st(){
			
	var Plant = GridClass_edit_1st.grid.getStore().recordType; 
    var p = new Plant({ 
        		     	 FLAG					 : 'I' 
        		  	 	,PJT_REG_DATE			 : getTimeStamp().trim() 
						,PJT_ID					 : ''
						,ISSUE_TYPE_CODE         : ''
						,ISSUE_CODE              : ''
						,ISSUE_REG_DEPT_CODE     : '${dept_code}'
						,ISSUE_REG_DEPT_NM	     : '${dept_nm}'
						
						,ISSUE_REG_DEPT_NUM      : '${sabun}'
						,ISSUE_REG_DEPT_NUM_NM   : '${admin_nm}'
						
						,ISSUE_DUTY_DEPT_CODE    : ''//'${dept_code}'
						,ISSUE_DUTY_DEPT_NM		 : ''//'${dept_nm}'  
						
						,ISSUE_DUTY_DEPT_NUM     : ''//'${sabun}'   
						,ISSUE_DUTY_DEPT_NUM_NM  : ''//'${admin_nm}'
						
						,ISSUE_TERMINATE_NOTE    : ''
						,PROC_STATUS_CODE        : ''
						,EFFECT                  : ''
						,EMERGNCY                : ''
						,NOTE                    : ''
						,ATT_FILE_NAME           : ''
						,ATT_FILE_PATH           : ''
						,FINAL_MOD_ID            : '${admin_nm}'
						,FINAL_MOD_DATE          : getTimeStamp().trim()
						,REG_DATE                : getTimeStamp().trim()
						,REG_ID					 : '${admin_nm}' 
    				  }); 
     
	  	GridClass_edit_1st.grid.stopEditing();
		GridClass_edit_1st.store.insert(0, p);
		GridClass_edit_1st.grid.startEditing(0, 0); 
}

// 페이징
function fnPagingValue_edit_1st(){	
	try{
		
		GridClass_edit_1st.store.setBaseParam('start'				,start_edit_1st);
	    GridClass_edit_1st.store.setBaseParam('limit'				,limit_edit_1st);
	    GridClass_edit_1st.store.setBaseParam('src_pjt_date_from'	,Ext.get('src_pjt_date_from').getValue());
	    GridClass_edit_1st.store.setBaseParam('src_pjt_date_to'		,Ext.get('src_pjt_date_to').getValue());
	    
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




/** 영향도 combo box 생성 start **/
var EFFECT_TYPE_CODE_COMBO = new Ext.form.ComboBox({    
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
						 
					<c:forEach items="${EFFECT_TYPE_CODE}" var="data" varStatus="status">
						['${data.COM_CODE}', '${data.COM_CODE_NAME}']
						<c:if test="${not status.last}">,</c:if>
					</c:forEach>
				  ]
			})
});
//combo box render
Ext.util.Format.comboRenderer = function(EFFECT_TYPE_CODE_COMBO){    
	return function(value){        
	var record = EFFECT_TYPE_CODE_COMBO.findRecord(EFFECT_TYPE_CODE_COMBO.valueField, value);        
	return record ? record.get(EFFECT_TYPE_CODE_COMBO.displayField) : EFFECT_TYPE_CODE_COMBO.valueNotFoundText;    
}}
/** 영향도 combo box 생성 end **/



/** 긴급성 combo box 생성 start **/
var EMERGNCY_TYPE_CODE_COMBO = new Ext.form.ComboBox({    
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
					 
					<c:forEach items="${EMERGNCY_TYPE_CODE}" var="data" varStatus="status">
						['${data.COM_CODE}', '${data.COM_CODE_NAME}']
						<c:if test="${not status.last}">,</c:if>
					</c:forEach>
				  ]
			})
});
//combo box render
Ext.util.Format.comboRenderer = function(EMERGNCY_TYPE_CODE_COMBO){    
	return function(value){        
	var record = EMERGNCY_TYPE_CODE_COMBO.findRecord(EMERGNCY_TYPE_CODE_COMBO.valueField, value);        
	return record ? record.get(EMERGNCY_TYPE_CODE_COMBO.displayField) : EMERGNCY_TYPE_CODE_COMBO.valueNotFoundText;    
}}
/** 긴급성 combo box 생성 end **/



/** 이슈구분코드 combo box 생성 start **/
var ISSUE_TYPE_CODE_COMBO = new Ext.form.ComboBox({    
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
					 
					<c:forEach items="${ISSUE_TYPE_CODE}" var="data" varStatus="status">
						['${data.COM_CODE}', '${data.COM_CODE_NAME}']
						<c:if test="${not status.last}">,</c:if>
					</c:forEach>
				  ]
			})
});
//combo box render
Ext.util.Format.comboRenderer = function(ISSUE_TYPE_CODE_COMBO){    
	return function(value){        
	var record = ISSUE_TYPE_CODE_COMBO.findRecord(ISSUE_TYPE_CODE_COMBO.valueField, value);        
	return record ? record.get(ISSUE_TYPE_CODE_COMBO.displayField) : ISSUE_TYPE_CODE_COMBO.valueNotFoundText;    
}}
/** 이슈구분코드 combo box 생성 end **/


// 그리드 필드
var	userColumns_edit_1st	= [  {header: "순번"            		,	width: 15,	sortable: true,	dataIndex: "ISSUE_INFO_SEQ"  		,		editor: new Ext.form.TextField({ allowBlank : false }), editable:false}
								,{header: "등록일자"          	,	width: 35,	sortable: true,	dataIndex: "PJT_REG_DATE"  			,		editor: new Ext.form.TextField({ allowBlank : false }), editable:false}
								,{header: "* 프로젝트ID"         	,	width: 50,	sortable: true,	dataIndex: "PJT_ID"  				,		editor: new Ext.form.TextField({ allowBlank : false }), editable:false, renderer: changeBLUE}
								,{header: "* 프로젝트"         	,	width: 50,	sortable: true,	dataIndex: "PJT_NAME"  				,		editor: new Ext.form.TextField({ allowBlank : false }), hidden:true, editable:false, renderer: changeBLUE}
								
								,{header: "* 상태"        		,	width: 30,	sortable: true,	dataIndex: "ISSUE_TYPE_CODE"  		,		editor: ISSUE_TYPE_CODE_COMBO  ,renderer: Ext.util.Format.comboRenderer(ISSUE_TYPE_CODE_COMBO)  }
								,{header: "영향도"           		,	width: 20,	sortable: true,	dataIndex: "EFFECT"  				,		editor: EFFECT_TYPE_CODE_COMBO  ,renderer: Ext.util.Format.comboRenderer(EFFECT_TYPE_CODE_COMBO)  }
								,{header: "긴급성"           		,	width: 20,	sortable: true,	dataIndex: "EMERGNCY"  				,		editor: EMERGNCY_TYPE_CODE_COMBO  ,renderer: Ext.util.Format.comboRenderer(EMERGNCY_TYPE_CODE_COMBO)  }
								
								,{header: "이슈코드"          	,	width: 10,	sortable: true,	dataIndex: "ISSUE_CODE"  			,		editor: new Ext.form.TextField({ allowBlank : false }), hidden:true}
								
								,{header: "등록자부서코드"    		,	width: 10,	sortable: true,	dataIndex: "ISSUE_REG_DEPT_CODE"	,		editor: new Ext.form.TextField({ allowBlank : false }), hidden:true}
								,{header: "등록자부서"    		,	width: 60,	sortable: true,	dataIndex: "ISSUE_REG_DEPT_NM"		,		editor: new Ext.form.TextField({ allowBlank : false }), hidden:true , editable:false , renderer: changeBLUE}
								
								,{header: "등록자사번"       		,	width: 10,	sortable: true,	dataIndex: "ISSUE_REG_DEPT_NUM" 	,		editor: new Ext.form.TextField({ allowBlank : false }), hidden:true}
								,{header: "등록자"       			,	width: 30,	sortable: true,	dataIndex: "ISSUE_REG_DEPT_NUM_NM" 	,		editor: new Ext.form.TextField({ allowBlank : false }), editable:false , renderer: changeBLUE}
								,{header: "* 내용"        		,	width: 80,	sortable: true,	dataIndex: "ISSUE_TERMINATE_NOTE" 	,		editor: new Ext.form.TextField({ allowBlank : false }) }
								
								,{header: "책임자부서코드"			,	width: 10,	sortable: true,	dataIndex: "ISSUE_DUTY_DEPT_CODE" 	,		editor: new Ext.form.TextField({ allowBlank : false }), hidden:true}
								,{header: "책임자부서"			,	width: 50,	sortable: true,	dataIndex: "ISSUE_DUTY_DEPT_NM" 	,		editor: new Ext.form.TextField({ allowBlank : false }), hidden:true, editable:false , renderer: changeBLUE}
								
								,{header: "책임자사번"    		,	width: 10,	sortable: true,	dataIndex: "ISSUE_DUTY_DEPT_NUM"  	,		editor: new Ext.form.TextField({ allowBlank : false }), hidden:true}
								,{header: "책임자"    			,	width: 30,	sortable: true,	dataIndex: "ISSUE_DUTY_DEPT_NUM_NM"	,		editor: new Ext.form.TextField({ allowBlank : false }), editable:false , renderer: changeBLUE}
								,{header: "비고"            		,	width: 80,	sortable: true,	dataIndex: "NOTE"  					,		editor: new Ext.form.TextField({ allowBlank : false })}
								
								
								,{header: "진행현황"        		,	width: 40,	sortable: true,	dataIndex: "PROC_STATUS_CODE"  		,		editor: PJT_STATUS_CODE_COMBO  ,renderer: Ext.util.Format.comboRenderer(PJT_STATUS_CODE_COMBO)  , editable:false}
								,{header: "첨부파일명"         	,	width: 10,	sortable: true,	dataIndex: "ATT_FILE_NAME"  		,		editor: new Ext.form.TextField({ allowBlank : false }), hidden:true, editable:false}
								,{header: "첨부파일경로명"       	,	width: 10,	sortable: true,	dataIndex: "ATT_FILE_PATH"  		,		editor: new Ext.form.TextField({ allowBlank : false }), hidden:true, editable:false}
								
								,{header: "최종변경자"    		,	width: 50,	sortable: true,	dataIndex: "FINAL_MOD_ID"       	,		editor: new Ext.form.TextField({ allowBlank : false }), hidden:true, editable:false}
								,{header: "최종변경일"    		,	width: 50,	sortable: true,	dataIndex: "FINAL_MOD_DATE"     	,		editor: new Ext.form.TextField({ allowBlank : false }), hidden:true, editable:false}
								,{header: "최초등록일"      		,	width: 50,	sortable: true,	dataIndex: "REG_DATE"           	,		editor: new Ext.form.TextField({ allowBlank : false }), hidden:true, editable:false}
								,{header: "최초등록자"      		,	width: 50,	sortable: true,	dataIndex: "REG_ID"             	,		editor: new Ext.form.TextField({ allowBlank : false }), hidden:true, editable:false} 
							    ,{header: "상태"            		,	width: 15,	sortable: true,	dataIndex: "FLAG"  		,		editor: new Ext.form.TextField({ allowBlank : false }), editable:false, hidden:true}
								];

// 맵핑 필드
var	mappingColumns_edit_1st	= [   {name:"FLAG"					,type:"string"		,mapping:"FLAG"}
							     ,{name:"ISSUE_INFO_SEQ"		,type:"string"		,mapping:"ISSUE_INFO_SEQ"}
							     ,{name:"PJT_REG_DATE"			,type:"string"		,mapping:"PJT_REG_DATE"}
							     ,{name:"PJT_ID"				,type:"string"		,mapping:"PJT_ID"}
							     ,{name:"PJT_NAME"				,type:"string"		,mapping:"PJT_NAME"}
							     
							     ,{name:"ISSUE_TYPE_CODE"		,type:"string"		,mapping:"ISSUE_TYPE_CODE"}
							     ,{name:"ISSUE_CODE"			,type:"string"		,mapping:"ISSUE_CODE"}
							     ,
							     ,{name:"ISSUE_REG_DEPT_CODE"	,type:"string"		,mapping:"ISSUE_REG_DEPT_CODE"}
							     ,{name:"ISSUE_REG_DEPT_NM"		,type:"string"		,mapping:"ISSUE_REG_DEPT_NM"}
							     ,
							     ,{name:"ISSUE_REG_DEPT_NUM"	,type:"string"		,mapping:"ISSUE_REG_DEPT_NUM"}
							     ,{name:"ISSUE_REG_DEPT_NUM_NM"	,type:"string"		,mapping:"ISSUE_REG_DEPT_NUM_NM"}
							     ,
							     ,{name:"ISSUE_DUTY_DEPT_CODE"	,type:"string"		,mapping:"ISSUE_DUTY_DEPT_CODE"}
							     ,{name:"ISSUE_DUTY_DEPT_NM"	,type:"string"		,mapping:"ISSUE_DUTY_DEPT_NM"}
							     ,
							     ,{name:"ISSUE_DUTY_DEPT_NUM"	,type:"string"		,mapping:"ISSUE_DUTY_DEPT_NUM"}
							     ,{name:"ISSUE_DUTY_DEPT_NUM_NM",type:"string"		,mapping:"ISSUE_DUTY_DEPT_NUM_NM"}
							     ,
							     ,{name:"ISSUE_TERMINATE_NOTE"	,type:"string"		,mapping:"ISSUE_TERMINATE_NOTE"}
							     ,
							     ,{name:"PROC_STATUS_CODE"		,type:"string"		,mapping:"PROC_STATUS_CODE"}
							     ,{name:"PROC_STATUS_NM"		,type:"string"		,mapping:"PROC_STATUS_NM"}
							     ,{name:"EFFECT"				,type:"string"		,mapping:"EFFECT"}
							     ,{name:"EFFECT_NM"				,type:"string"		,mapping:"EFFECT_NM"}
							     ,{name:"EMERGNCY"				,type:"string"		,mapping:"EMERGNCY"}
							     ,{name:"EMERGNCY_NM"			,type:"string"		,mapping:"EMERGNCY_NM"}
							     ,{name:"NOTE"					,type:"string"		,mapping:"NOTE"}
							     ,{name:"ATT_FILE_NAME"			,type:"string"		,mapping:"ATT_FILE_NAME"}
							     ,{name:"ATT_FILE_PATH"			,type:"string"		,mapping:"ATT_FILE_PATH"}
							     ,{name:"FINAL_MOD_ID"			,type:"string"		,mapping:"FINAL_MOD_ID"}
							     ,{name:"FINAL_MOD_DATE"		,type:"string"		,mapping:"FINAL_MOD_DATE"}
							     ,{name:"REG_DATE"				,type:"string"		,mapping:"REG_DATE"}
							     ,{name:"REG_ID"				,type:"string"		,mapping:"REG_ID"}
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
	
	Ext.Ajax.request({   
		 url: "/pjt/pjtIssue/result_edit_1st.sg"
		,method : 'POST'
		,success: function(response){
					handleSuccess(response,GridClass_edit_1st);
				 }
		,failure: handleFailure
		,params : {
						limit              	: limit_edit_1st
					  , start              	: start_edit_1st
					  , src_pjt_type_code   : Ext.get('src_pjt_type_code').getValue()
 					  , src_pjt_id   	   	: Ext.get('src_pjt_id').getValue()
					  , src_pjt_name    	: Ext.get('src_pjt_name').getValue()
					  
				  	  , src_issue_type_code	: Ext.get('src_issue_type_code').getValue()  
				  	  
				  	  , src_pjt_date_from  	: Ext.get('src_pjt_date_from').getValue() 
				  	  , src_pjt_date_to    	: Ext.get('src_pjt_date_to').getValue()
				  
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
	      
	    	if(records[i].data.FLAG != 'D'){
	    	
		    	if(records[i].data.PJT_ID == ""){
		    		SGAlert("[프로젝트 이슈]", [i+1]+"번째 행의 [프로젝트]를 선택 입력 해 주세요");
		    		return false;
		    	} 
		    	if(records[i].data.ISSUE_TERMINATE_NOTE == ""){
		    		SGAlert("[프로젝트 이슈]", [i+1]+"번째 행의 [내용]을 입력 해 주세요");
		    		return false;
		    	} 
	    	}
	    	edit1stJson += Ext.util.JSON.encode(records[i].data);				
	      if (i < (records.length-1)) {
	        edit1stJson += ",";
	      }
	    }
    	edit1stJson += "]"
    
	Ext.Ajax.request({   
		url: "/pjt/pjtIssue/actionPjtIssue.sg"   
		,success: function(response){
					handleSuccess(response,GridClass_edit_1st,'save');
		          } 
		,failure: handleFailure  
			
		,params : {
				      limit          		: limit_edit_1st
			  	  	, start          		: start_edit_1st 
			  	  
			  	  	, edit1stData		    : edit1stJson 
  				  
			  	  	, src_pjt_type_code     : '<%=request.getParameter("src_pjt_type_code")%>'
			  	  	, src_pjt_id   	   		: Ext.get('src_pjt_id').getValue()   
				  	, src_pjt_name    		: Ext.get('src_pjt_name').getValue()
				  	
			  	  	, src_issue_type_code	: Ext.get('src_issue_type_code').getValue()
				  	
				  	, src_pjt_date_from  	: Ext.get('src_pjt_date_from').getValue() 
				  	, src_pjt_date_to    	: Ext.get('src_pjt_date_to').getValue()    
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
	
	var day = getTimeStamp();	
	var fromDay = day.replaceAll('-','');
	fromDay = addDate(fromDay, 'M', -3);
	fromDay = fromDay.substring(0,4)+"-"+fromDay.substring(4,6)+"-"+fromDay.substring(6,8);
	var toDay = day.replaceAll('-','');
	toDay = addDate(toDay, 'M', 3);
	toDay = toDay.substring(0,4)+"-"+toDay.substring(4,6)+"-"+toDay.substring(6,8);
	
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
	
  
  	/*
	
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
	  
	*/
	
	document.getElementById("src_pjt_date_from").value=fromDay;
	document.getElementById("src_pjt_date_to").value=toDay;
	
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


// 프로젝트 **************************************************
function fnPjtPop(param){
	var sURL      = "/pjt/pjtManage/pjtInfoPop.sg"+param;
	var dlgWidth  = 399;
	var dlgHeight = 444;
	var winName   = "project";
	fnOpenPop(sURL, dlgWidth, dlgHeight, winName);
}

function fnPjtPopValue(records, fieldName){
	
	if(fieldName == 'pjt_id'){ 
		var record = GridClass_edit_1st.grid.selModel.getSelected();
		var PJT_ID = records[0].data.PJT_ID;
		var PJT_NAME = records[0].data.PJT_NAME;
		var PROC_STATUS_CODE = records[0].data.PROC_STATUS_CODE;
		
		record.set('PJT_ID', PJT_ID);
		record.set('PJT_NAME', PJT_NAME);
		record.set('PROC_STATUS_CODE', PROC_STATUS_CODE);
	    
    }else if(fieldName == 'src_pjt_id'){
    	var record = records[0].data;	
    	Ext.get('src_pjt_id').set({value:fnFixNull(record.PJT_ID)} , false);
	    Ext.get('src_pjt_name').set({value:fnFixNull(record.PJT_NAME)} , false);
    }
}


// 담당자, 등록자 검색팝업 ****************************************
function fnEmployeePop(param){
	
	var sURL      = "/com/employee/employeePop.sg"+param;
	var dlgWidth  = 399;
	var dlgHeight = 396;
	
	var winName;
	
	if(param=="?requestFieldName=duty"){
		winName  = "담당자";
	}else{
		winName  = "등록자";
	}
	fnOpenPop(sURL, dlgWidth, dlgHeight, winName);
}
 
  
// 담당자, 등록자 검색 결과 return Value
function fnEmployeePopValue(records, obj){
	
	var record = GridClass_edit_1st.grid.selModel.getSelected();
	
	if(obj=="duty"){
		
		var ISSUE_DUTY_DEPT_CODE 	= records[0].data.DEPT_CODE;
		var ISSUE_DUTY_DEPT_NM 		= records[0].data.DEPT_NAME;
		var ISSUE_DUTY_DEPT_NUM 	= records[0].data.EMP_NUM;
		var ISSUE_DUTY_DEPT_NUM_NM 	= records[0].data.KOR_NAME;
		
		record.set('ISSUE_DUTY_DEPT_CODE'	, ISSUE_DUTY_DEPT_CODE);
		record.set('ISSUE_DUTY_DEPT_NM'		, ISSUE_DUTY_DEPT_NM);
		record.set('ISSUE_DUTY_DEPT_NUM'	, ISSUE_DUTY_DEPT_NUM);
		record.set('ISSUE_DUTY_DEPT_NUM_NM'	, ISSUE_DUTY_DEPT_NUM_NM);
		
	}else if(obj=="reg"){
		 
		var ISSUE_REG_DEPT_CODE 	= records[0].data.DEPT_CODE; 
		var ISSUE_REG_DEPT_NM 		= records[0].data.DEPT_NAME; 
		var ISSUE_REG_DEPT_NUM 		= records[0].data.EMP_NUM;   
		var ISSUE_REG_DEPT_NUM_NM 	= records[0].data.KOR_NAME;  
		
		record.set('ISSUE_REG_DEPT_CODE' 	, ISSUE_REG_DEPT_CODE);
		record.set('ISSUE_REG_DEPT_NM'	 	, ISSUE_REG_DEPT_NM);
		record.set('ISSUE_REG_DEPT_NUM'	 	, ISSUE_REG_DEPT_NUM);
		record.set('ISSUE_REG_DEPT_NUM_NM'	, ISSUE_REG_DEPT_NUM_NM); 
	}
} 
 
/***************************************************************************
 * 설  명 : 에디트 그리드의 CELL을 클릭하였을 경우 이벤트
 ***************************************************************************/
function  fnEdit1stCellClickEvent(grid, rowIndex, columnIndex, e){
	//거래처
	if(columnIndex == '2' ){
		var check = grid.store.getAt(rowIndex);
		// 프로젝트 ID는 key이므로 신규입력일때만 검색 가능
		
		
		if(check.data.FLAG == 'I'){
			var param = "?fieldName=pjt_id&src_pjt_type_code=10";
			fnPjtPop(param);		 
		}
	}
	 
	if(columnIndex == '11' || columnIndex == '16'){
	 	var param = "";
	 	if(columnIndex == '11'){
	 		param = '?requestFieldName=reg';
	 	}else if(columnIndex == '16'){
	 		param = '?requestFieldName=duty';
	 	}
	 	
		fnEmployeePop(param);
	}
} 

function fnEdit1stBeforeRowDeleteEvent(){
	var records = GridClass_edit_1st.grid.selModel.getSelections(); 
	
	records[0].set('FLAG','D');
}
</script>

</head>
<body class=" ext-gecko ext-gecko3">
	<table border="0" width="1000" height="200">
		<tr>
			<td colspan="2">
				<form name="searchForm" id="searchForm">
				<!----------------- SEARCH Hearder Start	 ----------------->
				<div id="ext-comp-1002" class=" x-panel x-form-label-left" style="margin-top: 0em;"><%-- 0em <- 1em으로 수정하면 상위 공백 --%>
					<div class="x-panel-tl">
						<div class="x-panel-tr">
							<div class="x-panel-tc">
								<div id="ext-gen4" class="x-panel-header x-unselectable" style="-moz-user-select: none;">
									<span id="ext-gen8" class="x-panel-header-text">프로젝트 이슈  검색</span>
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
													<input type="text" name="src_pjt_id" id="src_pjt_id" autocomplete="off" size="18" class=" x-form-text x-form-field" style="width: auto;" />
												</div>
											</div>
										</td>
										<td width="10%">&nbsp;</td> 
										<td width="25%">
											<div tabindex="-1" class="x-form-item " >
												<label class="x-form-item-label" style="width: auto;" for="src_pjt_name" >프로젝트명 :</label>
												<div style="padding-left: 0px;" class="x-form-element">
													<input type="text" name="src_pjt_name" id="src_pjt_name" autocomplete="off" size="18" class=" x-form-text x-form-field" style="width: auto;" />
												</div>
											</div>
										</td>
										<td width="10%">&nbsp;</td>
										<td width="30%" align="left" colspan="3">
											<div tabindex="-1" class="x-form-item " >
												<label class="x-form-item-label" style="width: auto;" for="src_issue_type_code" >상태 :</label>
												<div style="padding-left: 61px;" class="x-form-element">
													<select name="src_issue_type_code" id="src_issue_type_code" title="상태" style="width: 65%;" type="text" class=" x-form-select x-form-field" >
														<option value="">선택하세요</option>
														<c:forEach items="${ISSUE_TYPE_CODE}" var="data" varStatus="status">
															<option value="${data.COM_CODE}"><c:out value="${data.COM_CODE_NAME}"/></option>
														</c:forEach>
													</select>		
												</div>
											</div>
										</td> 
									</tr>
									<%-- 1 Row End --%>
									<tr>
										<td align="">
											<div tabindex="-1" class="x-form-item " >
												<label class="x-form-item-label" style="width: auto;" for="src_pjt_date_from" ><font color="red"> </font>사업구분 :</label>
												<div style="padding-left: 70px;" class="x-form-element">
													<table>
														<tr>
															<td>
																<select name="src_pjt_type_code" id="src_pjt_type_code" title="사업구분" style="width: 115px;" type="text" class=" x-form-select x-form-field" />
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
										<td colspan="6" align="">
											<div tabindex="-1" class="x-form-item " >
												<label class="x-form-item-label" style="width: auto;" for="src_pjt_date_from" ><font color="red"> </font>기간 :</label>
												<div style="padding-left: 70px;" class="x-form-element">
													<table>
														<tr>
															<td>
																<input type="text" name="src_pjt_date_from" id="src_pjt_date_from" autocomplete="off" size="13" style="width: auto;">		
															</td>
															<td>
																&nbsp;~&nbsp;
															</td>
															<td>
																<input type="text" name="src_pjt_date_to" id="src_pjt_date_to" autocomplete="off" size="13" style="width: auto;">
<!--																<span class="x-form-item " >ex)20110604</span>-->
															</td>
														</tr>
													</table>
												</div>
											</div>
										</td>
									</tr>
									<%-- 3 Row 버튼 Start --%>
									<tr align="right">
										<td colspan="8" style="padding-right: 30">
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
				<div id="edit_grid_1st" style="margin-top: 0em;"></div>
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