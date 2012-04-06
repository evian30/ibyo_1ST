<%--
  Class Name  : csrInfoMngList.jsp
  Description : 업무요청정보 관리
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
<script type="text/javascript" src="/resource/common/js/grid/grid_1st.js"></script>
<script type="text/javascript" src="/resource/common/js/grid/grid_edit_1st.js"></script>

<script type="text/javascript">
/***************************************************************************
 * 초기값 설정
 ***************************************************************************/
var	gridHeigth_1st 	 	= 180; 						// 그리드 전체 높이
var	gridWidth_1st		= 495;						// 그리드 전체 폭
var gridTitle_1st 		= "업무요청정보관리";	  	// 그리드 제목
var	render_1st			= "task-grid";	  			// 렌더(화면에 그려질) 할 id 
var	pageSize_1st		= 4	  					// 그리드 페이지 사이즈	
var	proxyUrl_1st		= "/dev/csrInfo/result.sg";		// 결과 값 페이지
var limit_1st			= pageSize_1st;
var start_1st			= 0;




/***************************************************************************
 * Grid의 컬럼 설정
 ***************************************************************************/
var userColumns_1st =  [
						{header: "상태",		    width: 100, sortable: true, dataIndex: 'FLAG', hidden : true}  
					   ,{header: "업무요청ID",		    width: 60, sortable: true, dataIndex: 'CSR_ID', hidden : true}       
					   ,{header: "요청구분", 		width: 60,  sortable: true, dataIndex: 'CSR_TYPE_NAME'}
					   ,{header: "요청일자",     	width: 60,  sortable: true, dataIndex: 'CSR_DATE'}
					   ,{header: "요청부서명",   	width: 60,  sortable: true, dataIndex: 'CSR_DEPT_NAME', hidden : true}
					   ,{header: "요청자ID",  	    width: 60, sortable: true, dataIndex: 'CSR_EMP_NUM'       }  
					   ,{header: "요청자명",  	    width: 100, sortable: true, dataIndex: 'CSR_EMP_NAME'       }                  
					   ,{header: "요청제목",		width: 100,  sortable: true, dataIndex: 'CSR_TITLE'       }
					   ,{header: "업무요청구분코드", 		width: 60,  sortable: true, dataIndex: 'CSR_TYPE_CODE', hidden : true}   
					   ,{header: "요청부서코드",   	width: 60,  sortable: true, dataIndex: 'CSR_DEPT_CODE', hidden : true}					      
					   ,{header: "최종변경자", 	width: 100, sortable: true, dataIndex: 'FINAL_MOD_ID', hidden : true   }  
					   ,{header: "최종변경일", 	width: 50,  sortable: true, dataIndex: 'FINAL_MOD_DATE', hidden : true }
					   ];	 

/***************************************************************************
 * 그리드 결과매핑 
 ***************************************************************************/
var mappingColumns_1st = [ 
						  {name: 'FLAG' 		  , allowBlank: false}	//상태
						 ,{name: 'CSR_ID' 		  , allowBlank: false}	//업무요청ID		
						 ,{name: 'CSR_TYPE_NAME', allowBlank: false} 		//업무요청구분명
						 ,{name: 'CSR_DATE', allowBlank: false} 		//요청일자          
						 ,{name: 'CSR_DEPT_NAME'	  , allowBlank: false}  //요청부서명 
						 ,{name: 'CSR_EMP_NUM'	  , allowBlank: false}  //요청자사번  	    
						 ,{name: 'CSR_EMP_NAME'  	  , allowBlank: false}  //요청자명  	    
						 ,{name: 'CSR_TITLE'  , allowBlank: false}  	//요청제목		    
						 ,{name: 'CSR_TYPE_CODE', allowBlank: false}  	//업무요청구분코드      
						 ,{name: 'CSR_DEPT_CODE', allowBlank: false} 	//요청부서코드        
						 ,{name: 'FINAL_MOD_ID'   , allowBlank: false}  //최종변경자 
						 ,{name: 'FINAL_MOD_DATE' , allowBlank: false}  //최종변경일 
	    				 ];
 
/***************************************************************************
 * 그리드 클릭시 Event
 ***************************************************************************/
function fnGridOnClick_1st(store, rowIndex){

	var tmpdate = store.getAt(rowIndex).data.CSR_DATE.substring(0, 4)+"-"+store.getAt(rowIndex).data.CSR_DATE.substring(4, 6)+"-"+store.getAt(rowIndex).data.CSR_DATE.substring(6, 8);

	/***** 선택된 레코드에서 데이타 가져오기 *****/
	Ext.get('flag_detailForm').set({value : fnFixNull(store.getAt(rowIndex).data.FLAG)}, false);	
	
	Ext.get('csr_type_code').set({value : fnFixNull(store.getAt(rowIndex).data.CSR_TYPE_CODE)}, false);		//	업무요청구분코드  
	Ext.get('csr_date_tmp').set({value : fnFixNull(store.getAt(rowIndex).data.CSR_DATE)}, false);										//	요청일자   
	
	Ext.get('csr_id').set({value : fnFixNull(store.getAt(rowIndex).data.CSR_ID)}, false);					//	업무요청ID   
	Ext.get('csr_emp_num').set({value : fnFixNull(store.getAt(rowIndex).data.CSR_EMP_NUM)}, false);			//	요청자사번
	Ext.get('csr_title').set({value : fnFixNull(store.getAt(rowIndex).data.CSR_TITLE)}, false);				//	요청제목	
	
	Ext.get('csr_dept_code').set({value : fnFixNull(store.getAt(rowIndex).data.CSR_DEPT_CODE)}, false);		//	요청부서코드
	
	Ext.get('csr_dept_name').set({value : fnFixNull(store.getAt(rowIndex).data.CSR_DEPT_NAME)}, false);		//	요청부서명	
	Ext.get('csr_emp_name').set({value : fnFixNull(store.getAt(rowIndex).data.CSR_EMP_NAME)}, false);		//	요청자 명
	
	
	// 업무요청 상세 검색
	fnEditGridSearch(store, rowIndex);
	
	Ext.get('saveBtn').dom.disabled   = true;
	Ext.get('updateBtn').dom.disabled = false;	
	Ext.get('deleteBtn').dom.disabled = false;
	
;}   


/***************************************************************************
 * 설  명 : 그리드의 페이지 클릭시 검색조건값을 DB로 전송
 ***************************************************************************/
function fnPagingValue_1st(){

	
	try{
    	GridClass_1st.store.setBaseParam('src_csr_date_from', Ext.get('src_csr_date_from').getValue());
    	GridClass_1st.store.setBaseParam('src_csr_date_to', 	    Ext.get('src_csr_date_to').getValue());
    	GridClass_1st.store.setBaseParam('src_csr_dept_code',       Ext.get('src_csr_dept_code').getValue());
    	GridClass_1st.store.setBaseParam('src_csr_type_code',       Ext.get('src_csr_type_code').getValue());
	}catch(e){

	}
}



// ********************************************************************* //
/** 서버스펙 EditGrid - edit_1st Start**/
var	gridHeigth_edit_1st	=	250;
var	gridWidth_edit_1st  =	"";
var	gridTitle_edit_1st  =   "업무요청 상세정보"	; 
var	render_edit_1st		=	"csr_pattern_item_grid";
var keyNm_edit_1st		= 	"CSR_ID";
var pageSize_edit_1st	=	15;
var limit_edit_1st		=	pageSize_edit_1st;
var start_edit_1st		=	0;
var proxyUrl_edit_1st	=	"/dev/csrInfo/csrPatternItem.sg";
var gridRowDeleteYn = "Y";
var tbarHidden_edit_1st ="N";

//에디트그리드 추가
function addNew_edit_1st(){

	var dForm = document.detailForm;	// 상세 FORM

	//alert("--dForm.csr_type_code.value--"+dForm.csr_type_code.value);
    //alert("--dForm.flag_detailForm.value--"+dForm.flag_detailForm.value);
    	
	
	if(dForm.flag_detailForm.value !='' && Ext.get('csr_id').getValue() =='')
	{
		Ext.Msg.alert('확인', '해당 업무요청을 선택하십시오');
		return;
	}
	else
	{
		var Plant = GridClass_edit_1st.grid.getStore().recordType; 
	    var p = new Plant({ FLAG	        : 'I' 
			    		 }); 
	  	GridClass_edit_1st.grid.stopEditing();
		GridClass_edit_1st.store.insert(0, p);
		GridClass_edit_1st.grid.startEditing(0, 0);
	}
	
}

//에디트그리드 페이징
function fnPagingValue_edit_1st(){	
	
	try{
		
		GridClass_edit_1st.store.setBaseParam('start'			,start_edit_1st);
	    GridClass_edit_1st.store.setBaseParam('limit'			,limit_edit_1st);
	    GridClass_edit_1st.store.setBaseParam('csr_id'	,Ext.get('csr_id').getValue());		// 조회된 그리드의 조건값
 
	}catch(e){

	}

}

/** 요청상태코드 combo box 생성 start **/
var CSR_STATUS_CODE_COMBO = new Ext.form.ComboBox({    
 typeAhead: true, 
 triggerAction: 'all',
 lazyRender:true,
 mode: 'local',
 valueField: 'value',
 displayField: 'displayText',
 valueNotFoundText: '',
 disabled  : true, 
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



/** 처리완료여부  combo box 생성 start **/
var SR_FLOW_CODE_COMBO = new Ext.form.ComboBox({    
 typeAhead: true, 
 triggerAction: 'all',
 lazyRender:true,
 mode: 'local',
 valueField: 'value',
 displayField: 'displayText',
 valueNotFoundText: '',
 disabled  : true, 
 store: new Ext.data.ArrayStore({
   id: 0,
   fields: ['value', 'displayText'],
   data: [
     <c:forEach items="${SR_FLOW_CODE}" var="data" varStatus="status">
      ['${data.COM_CODE}', '${data.COM_CODE_NAME}']
      <c:if test="${not status.last}">,</c:if>
     </c:forEach>
      ]
   })
});

//combo box render
Ext.util.Format.comboRenderer = function(SR_FLOW_CODE_COMBO){    
 return function(value){        
 var record = SR_FLOW_CODE_COMBO.findRecord(SR_FLOW_CODE_COMBO.valueField, value);        
 return record ? record.get(SR_FLOW_CODE_COMBO.displayField) : SR_FLOW_CODE_COMBO.valueNotFoundText;    
}}





var	userColumns_edit_1st	= [  
								 {header: "프로젝트ID", 		  width: 100,	sortable: true,	dataIndex: "PJT_ID" , renderer: changeBLUE}
								,{header: "제품", 	  width: 150,	sortable: true,	dataIndex: "ITEM_NAME"						, renderer: changeBLUE}
								,{header: "제품코드", 	  width: 150,	sortable: true,	dataIndex: "ITEM_CODE"					, hidden : true }
								,{header: "요청내용", 		  width: 100,	sortable: true,	dataIndex: "CSR_NOTE",				editor: new Ext.form.TextField({ allowBlank : true, maxLength : 200, maxLengthText: '최대길이는 200자 입니다' }) , renderer: changeBLUE}
								,{header: "요청상태", 		  width: 100,	sortable: true,	dataIndex: "CSR_STATUS_CODE", editor: CSR_STATUS_CODE_COMBO  ,renderer: Ext.util.Format.comboRenderer(CSR_STATUS_CODE_COMBO)  }
								,{header: "요청상태사유", 		  width: 100,	sortable: true,	dataIndex: "CSR_STATUS_REASON"				 }
								,{header: "처리일자", 		  width: 100,	sortable: true,	dataIndex: "DEAL_DATE"			 }
								,{header: "요청처리담당자사번", 		  width: 100,	sortable: true,	dataIndex: "DEAL_EMP_NUM" , hidden : true }
								,{header: "요청처리담당자", 		  width: 100,	sortable: true,	dataIndex: "DEAL_EMP_NAME" }
								,{header: "처리완료여부", 		  width: 100,	sortable: true,	dataIndex: "DEAL_YN" , editor: SR_FLOW_CODE_COMBO  ,renderer: Ext.util.Format.comboRenderer(SR_FLOW_CODE_COMBO)  }
								,{header: "상태", width: 0,		sortable: true,	dataIndex: "FLAG", hidden : true}	
								,{header: "업무요청ID", width: 0,		sortable: true,	dataIndex: "CSR_ID", hidden : true }
								,{header: "업무요청순번",	  width: 0,		sortable: true,	dataIndex: "CSR_INFO_SEQ", hidden : true}
								,{header: "업무요청유형코드",		  width: 50,	sortable: true,	dataIndex: "CSR_PATTERN_CODE", hidden : true }
								,{header: "프로젝트순번", 		  width: 100,	sortable: true,	dataIndex: "PJT_INFO_SEQ", hidden : true }
								,{header: "처리부서코드", 		  width: 100,	sortable: true,	dataIndex: "DEAL_DEPT_CODE", hidden : true }
								,{header: "처리내용", 		  width: 100,	sortable: true,	dataIndex: "DEAL_NOTE", hidden : true }
								,{header: "최종변경자ID",	  width: 100,	sortable: true,	dataIndex: "FINAL_MOD_ID", hidden : true }
								,{header: "최종변경일시",	  width: 100,	sortable: true,	dataIndex: "FINAL_MOD_DATE", hidden : true}
						  	  ];






var	mappingColumns_edit_1st	= [ 
								{name: "PJT_ID"			 ,type:"string" ,mapping: "PJT_ID"}          	            //프로젝트ID	
								, {name: "ITEM_NAME"	 ,type:"string" ,mapping: "ITEM_NAME"}     	                    //품목
								, {name: "ITEM_CODE"	 ,type:"string" ,mapping: "ITEM_CODE"}     	                    //품목
								, {name: "CSR_NOTE"	 ,type:"string" ,mapping: "CSR_NOTE"}    	                    //업무요청내용		
								, {name: "CSR_STATUS_CODE"			 ,type:"string" ,mapping: "CSR_STATUS_CODE"}    //요청상태코드		
								, {name: "CSR_STATUS_REASON"			 ,type:"string" ,mapping: "CSR_STATUS_REASON"}  //요청상태사유	
								, {name: "DEAL_DATE"			 ,type:"string" ,mapping: "DEAL_DATE"}                  //처리일자	
								, {name: "DEAL_EMP_NUM"			 ,type:"string" ,mapping: "DEAL_EMP_NUM"}           //처리자사번			
								, {name: "DEAL_EMP_NAME"			 ,type:"string" ,mapping: "DEAL_EMP_NAME"}           //처리자명			
								, {name: "DEAL_YN"			 ,type:"string" ,mapping: "DEAL_YN"}            	    //처리완료여부		
								, {name: "FLAG" ,type:"string" ,mapping: "FLAG"} 										//상태			
								, {name: "CSR_ID" ,type:"string" ,mapping: "CSR_ID"} 									//업무요청ID			
								, {name: "CSR_INFO_SEQ"		 ,type:"string" ,mapping: "CSR_INFO_SEQ"}       	    //업무요청순번		
								, {name: "CSR_PATTERN_CODE" ,type:"string" ,mapping: "CSR_PATTERN_CODE"} 	            //업무요청유형코드	
								, {name: "PJT_INFO_SEQ"			 ,type:"string" ,mapping: "PJT_INFO_SEQ"}           //프로젝트순번								  
								, {name: "DEAL_DEPT_CODE"			 ,type:"string" ,mapping: "DEAL_DEPT_CODE"}         //처리부서코드		
								, {name: "DEAL_NOTE"			 ,type:"string" ,mapping: "DEAL_NOTE"}                  //처리내용			
								, {name: "FINAL_MOD_ID"	 ,type:"string" ,mapping: "FINAL_MOD_ID"}    				// 최종변경자ID    
								, {name: "FINAL_MOD_DATE"	 ,type:"string" ,mapping: "FINAL_MOD_DATE"}  				// 최종변경일시 
	    				 	  ]; 





/***************************************************************************
 * 설  명 : 에디트 그리드의 CELL을 클릭하였을 경우 이벤트
 ***************************************************************************/
function  fnEdit1stCellClickEvent(grid, rowIndex, columnIndex, e){

	var selRecord = grid.selModel.getSelections();

	if(columnIndex == '0' && (selRecord[0].data.ITEM_CODE == undefined || (selRecord[0].data.PJT_ID == undefined && selRecord[0].data.ITEM_CODE == undefined))){
		var temp= GridClass_edit_1st.store;
		var gridName = "GridClass_edit_1st";
		var grid_name = "grid_name=" + gridName;
		var grid_row = "grid_row=" + rowIndex;
		var grid_fieldName = "grid_fieldName=" + 'PJT_ID';
		var param = "?"+grid_name +'&'+ grid_row +'&'+ grid_fieldName + "&fieldName=pjt_id&src_pjt_type_code=10";
		fnPjtPop(param);		 		
		
		
		
	}
	
	if(columnIndex == '1' && selRecord[0].data.PJT_ID == undefined){
		param = "";
		fnItemPop(param);
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
	var rowCnt = GridClass_edit_1st.store.getCount();  // Grid의 총갯수
	var totalATM = 0;
	
}


/** 서버스펙 EditGrid - edit_1st End**/


/***************************************************************************
 * 설  명 : 필드 초기화
 **************************************************************************/
function fnInitValue(){
	var dForm = document.detailForm;		// 상세 FORM	
	
	dForm.reset();							// 상세필드 초기화
	
	try{
		GridClass_edit_1st.store.commitChanges();
		GridClass_edit_1st.store.removeAll();
	}catch(e){
		
	}
	
	// 담당자 설정
	 Ext.get('csr_emp_num').set({value : '${sabun}'}, false);  
	 Ext.get('csr_emp_name').set({value : '${admin_nm}'}, false);  
	 Ext.get('csr_dept_code').set({value : '${dept_code}'}, false);  
	 Ext.get('csr_dept_name').set({value : '${dept_nm}'}, false); 	

	Ext.get('saveBtn').dom.disabled   = false;
	Ext.get('updateBtn').dom.disabled = true;
	Ext.get('deleteBtn').dom.disabled = true;		
}

/***************************************************************************
 * 설  명 : 검색
 **************************************************************************/
function fnSearch(){  	


	var sForm = document.searchForm;

	sForm.src_csr_date_from.value = sForm.src_csr_date_from_tmp.value.replaceAll('-','');		   	 
	sForm.src_csr_date_to.value = sForm.src_csr_date_to_tmp.value.replaceAll('-','');	

	
	Ext.Ajax.request({   
		url: "/dev/csrInfo/result.sg"
		,method : 'POST'   
		,success: function(response){						// 조회결과 성공시
					// 조회된 결과값, store명
					handleSuccess(response,GridClass_1st);
					var json = Ext.util.JSON.decode(response.responseText);
					
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
 * 설  명 :업무요청 상세 검색
 **************************************************************************/
function fnEditGridSearch(store, rowIndex){  	

		
	var sForm = document.searchForm;

	sForm.src_csr_date_from.value = sForm.src_csr_date_from_tmp.value.replaceAll('-','');		   	 
	sForm.src_csr_date_to.value = sForm.src_csr_date_to_tmp.value.replaceAll('-','');			
	
	Ext.Ajax.request({   
		url: "/dev/csrInfo/csrPatternItem.sg"
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
				  , csr_id : fnFixNull(store.getAt(rowIndex).data.CSR_ID)	// 업무요청ID
				  }				
	});  
	
} 


/***************************************************************************
 * 설  명 :저장후 업무요청 상세 검색
 **************************************************************************/
function fnEditGridSearch_2(savedCsrId){  	


	var sForm = document.searchForm;

	sForm.src_csr_date_from.value = sForm.src_csr_date_from_tmp.value.replaceAll('-','');		   	 
	sForm.src_csr_date_to.value = sForm.src_csr_date_to_tmp.value.replaceAll('-','');			
	
	Ext.Ajax.request({   
		url: "/dev/csrInfo/csrPatternItem.sg"
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
				  , csr_id : savedCsrId	// 업무요청ID
				  }				
	});  
	
} 


/***************************************************************************
 * 설  명 : 저장버튼 클릭
 ***************************************************************************/
function fnSave(){  	

	var sForm = document.searchForm;	// 검색 FORM
	var dForm = document.detailForm;	// 상세 FORM
	
	sForm.src_csr_date_from.value = sForm.src_csr_date_from_tmp.value.replaceAll('-','');		   	 
	sForm.src_csr_date_to.value = sForm.src_csr_date_to_tmp.value.replaceAll('-','');		
	
	// 변경된 Gride의 record
	var records = GridClass_edit_1st.store.getModifiedRecords();	  	// 변경된 record의 자료를 json형식으로
	var modifyLen = records.length;
    
    
    dForm.csr_date.value = dForm.csr_date_tmp.value.replaceAll('-','');	
    
    var csrStatusCodeChk=0;
    
    if(dForm.csr_type_code.value == '')
    {
    	Ext.Msg.alert('확인', '요청구분을 선택하십시오.');
    	return;
    }
    
    if(dForm.csr_date_tmp.value == '')
    {
    	Ext.Msg.alert('확인', '요청일자을 선택하십시오.');
    	return;
    }

    if(dForm.csr_emp_num.value == '')
    {
    	Ext.Msg.alert('확인', '요청자를 선택하십시오.');
    	return;
    }


    var json = "[";
	    for (var i = 0; i < modifyLen; i++) {
	    	if(records[i].data.FLAG != 'D' && (records[i].data.ITEM_CODE != undefined &&  records[i].data.ITEM_CODE !=""))	    
			{

				if(records[i].data.CSR_STATUS_CODE == '10')
				{
					csrStatusCodeChk++;
				}
			
		      json += Ext.util.JSON.encode(records[i].data);				
		      if (i < (records.length-1)) {
		        json += ",";
		      }
		    }
	    }
    	json += "]"
    
   
   if(modifyLen == 0)
   {
		var rowTotCnt = GridClass_edit_1st.store.getCount();
		for(var k=0;  k < rowTotCnt; k++){	//기존 데이타 전체 검색
	
			var recodeAt = GridClass_edit_1st.store.getAt(k);
	
			if(recodeAt.data.CSR_STATUS_CODE == '10')
			{
					csrStatusCodeChk++;
			}
		}    
   }
   
   
   if(csrStatusCodeChk > 0) 
   {
   		Ext.Msg.alert('확인', '이미 수락되었습니다.');
   		fnEditGridSearch_2(document.detailForm.csr_id.value);		//상세조회
   		
   		return;
   }
       
   if(dForm.flag_detailForm.value == '' && modifyLen ==0) 
   {
   		Ext.Msg.alert('확인', '제품을 선택하십시오');
   		return;
   }
    
//alert("--json---"+json);
	    var cnt = GridClass_edit_1st.store.getCount();		// Grid의 총갯수
	     
	    
		Ext.Ajax.request({   
			url: "/dev/csrInfo/actionCsrInfoMng.sg"   
			,success: function(response){						// 조회결과 성공시
						// 조회된 결과값, store명
						//alert(response.responseText);
						handleSuccess(response,GridClass_1st,'save');
						
						var json = Ext.util.JSON.decode(response.responseText);

						fnEditGridSearch_2(document.detailForm.csr_id.value);		//상세조회
			          }
			,failure: handleFailure   	    // 조회결과 실패시  
			,form   : document.detailForm   // 상세 FORM
			,params : { 
					   limit          : limit_1st
					  , start          : start_1st
					  , data  : json 
					  ,src_csr_date_from : sForm.src_csr_date_from.value
					  ,src_csr_date_to : sForm.src_csr_date_to.value	
					  ,src_csr_type_code : sForm.src_csr_type_code.value		
					  ,src_csr_dept_code : sForm.src_csr_dept_code.value		
					  ,csrInfoYn : "Y"				//사용유무 
				      } 
		});  
		
		//fnInitValue(); // 상세필드 초기화

}  		


/***************************************************************************
 * 설  명 : 삭제버튼 클릭
 ***************************************************************************/
function fnDelete(btn){  	

   	if(btn != 'yes'){
   		return;
   	} 


	var sForm = document.searchForm;	// 검색 FORM
	var dForm = document.detailForm;	// 상세 FORM
	
	sForm.src_csr_date_from.value = sForm.src_csr_date_from_tmp.value.replaceAll('-','');		   	 
	sForm.src_csr_date_to.value = sForm.src_csr_date_to_tmp.value.replaceAll('-','');	
	
	// 변경된 Gride의 record
	var records = GridClass_1st.grid.selModel.getSelections(); 
	var modifyLen = records.length;
    
    if(modifyLen == 0)
    {
    	Ext.Msg.alert('확인', '개발요청정보를 선택하십시오.')
		return false;
    }    
    
    
	var rowTotCnt = GridClass_edit_1st.store.getCount();
	var csrStatusCodeChk =0;
	for(var k=0;  k < rowTotCnt; k++){	//기존 데이타 전체 검색

		var recodeAt = GridClass_edit_1st.store.getAt(k);

		if(recodeAt.data.CSR_STATUS_CODE == '10')
		{
				csrStatusCodeChk++;
		}
	}    
    
    
   if(csrStatusCodeChk > 0) 
   {
   		Ext.Msg.alert('확인', '이미 수락되었습니다.');
   		return;
   }    
    
    dForm.csr_date.value = dForm.csr_date_tmp.value.replaceAll('-','');	
    
     	    
		Ext.Ajax.request({   
			url: "/dev/csrInfo/actionCsrInfoMng.sg"   
			,success: function(response){						// 조회결과 성공시
						// 조회된 결과값, store명
						//alert(response.responseText);
						//handleSuccess(response,GridClass_1st);
						
						GridClass_1st.store.commitChanges();	// 변경된 record를 commit
						GridClass_1st.store.removeAll();		// store자료를 삭제
							
						// 조회된 결과값, store명
						var json = Ext.util.JSON.decode(response.responseText);
											
						GridClass_1st.store.loadData(json);							
			          }
			,failure: handleFailure   	    // 조회결과 실패시  
			,form   : document.detailForm   // 상세 FORM
			,params : { 
					   limit          : limit_1st
					  , start          : start_1st
					  ,src_csr_date_from : sForm.src_csr_date_from.value
					  ,src_csr_date_to : sForm.src_csr_date_to.value	
					  ,src_csr_type_code : sForm.src_csr_type_code.value		
					  ,src_csr_dept_code : sForm.src_csr_dept_code.value			
					  ,csrInfoYn : "N"	
				      } 
		});  
		
		fnInitValue(); // 상세필드 초기화


}



/***************************************************************************
 * 설  명 : 삭제버튼 클릭
 ***************************************************************************/
function fnGridDeleteRow(selectedRecord){
	
	var json = "["+Ext.util.JSON.encode(selectedRecord.data)+"]";

	var sForm = document.searchForm;

	sForm.src_csr_date_from.value = sForm.src_csr_date_from_tmp.value.replaceAll('-','');		   	 
	sForm.src_csr_date_to.value = sForm.src_csr_date_to_tmp.value.replaceAll('-','');	
	

   if(selectedRecord.data.CSR_STATUS_CODE == '10') 
   {
   		Ext.Msg.alert('확인', '이미 수락되었습니다.');
   		fnEditGridSearch_2(selectedRecord.data.CSR_ID);		//상세조회
   		return;
   }	
	
	Ext.Ajax.request({   
		url: "/dev/csrInfo/deleteCsrPatternItem.sg"   
		,success: function(response){						// 조회결과 성공시
					// 조회된 결과값, store명
					//handleSuccess(response,GridClass_1st);
					
					GridClass_edit_1st.store.commitChanges();	// 변경된 record를 commit
					GridClass_edit_1st.store.removeAll();		// store자료를 삭제
						
					// 조회된 결과값, store명
					var json = Ext.util.JSON.decode(response.responseText);
										
					GridClass_edit_1st.store.loadData(json);
										
		          }
		,failure: handleFailure   	    // 조회결과 실패시  
		,form   : document.searchForm   // 검색 FORM
		,params : { 
					limit          		: limit_1st
				   , start         		: start_1st
				   ,deleteData : json
				   ,csr_id : 	selectedRecord.data.CSR_ID	
			      } 
	});
	
	
	//fnInitValue(); // 상세필드 초기화
}







/***************************************************************************
 * 설  명 : 화면 설정
 ***************************************************************************/
// ExtJS 진입함수
Ext.onReady(function() {

	var dForm = document.detailForm;
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

		Ext.get('src_csr_date_from_tmp').set({value:fromDay} , false);
		Ext.get('src_csr_date_to_tmp').set({value:toDay} , false);
	});	
			
	//신규 버튼 -> 상세필드 초기화
	Ext.get('detailClearBtn').on('click', function(e){
		fnInitValue();		   
	});		
			
	//등록 버튼 -> 데이터를 server로 전송
	Ext.get('saveBtn').on('click', function(e){	
		if(Validator.validate(dForm)){
			
			Ext.MessageBox.confirm('Confirm', '저장하시겠습니까?', showResult);
		};
	});
	
	//수정 버튼 -> 데이터를 server로 전송
	Ext.get('updateBtn').on('click', function(e){	
		if(Validator.validate(dForm)){
			Ext.MessageBox.confirm('Confirm', '수정하시겠습니까?', showResult);
		};	
	});
	
	Ext.get('deleteBtn').on('click', function(e){	
		Ext.MessageBox.confirm('Confirm', '삭제하시겠습니까?', fnDelete);

	});	

	

	 	
	
	// 업무요청기간 from
	var enddt = new Ext.form.DateField({
	    	applyTo: 'src_csr_date_from_tmp',
			allowBlank: false,
			format:'Y-m-d',
			editable : true,
			value : fromDay
	});
	
	Ext.get('src_csr_date_from_tmp').on('change', function(e){	
		
		var val = Ext.get('src_csr_date_from_tmp').getValue();
		var reVal = fnGridDateCheck(val);
		
		Ext.get('src_csr_date_from_tmp').set({value:reVal} , false);
	});
	
	
	// 업무요청기간 to
	var enddt = new Ext.form.DateField({
	    	applyTo: 'src_csr_date_to_tmp',
			allowBlank: false,
			format:'Y-m-d',
			editable : true,
			value : toDay
	});
	
	Ext.get('src_csr_date_to_tmp').on('change', function(e){	
		
		var val = Ext.get('src_csr_date_to_tmp').getValue();
		var reVal = fnGridDateCheck(val);
		
		Ext.get('src_csr_date_to_tmp').set({value:reVal} , false);
	});
		

	// 요청일자
	var enddt = new Ext.form.DateField({
	    	applyTo: 'csr_date_tmp',
			allowBlank: true,
			format:'Y-m-d',
			editable : true
	});
	
	Ext.get('csr_date_tmp').on('change', function(e){	
		
		var val = Ext.get('csr_date_tmp').getValue();
		var reVal = fnGridDateCheck(val);
		
		Ext.get('csr_date_tmp').set({value:reVal} , false);
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
 * 설  명 : 부서검색 
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


/***************************************************************************
 * 설  명 : 담당자검색
 ***************************************************************************/
function fnEmployeePop(param){
	var sURL      = "/com/employee/employeePop.sg?requestFieldName="+param;
	var dlgWidth  = 420;
	var dlgHeight = 400;
	var winName   = "emp";
	
	fnOpenPop(sURL, dlgWidth, dlgHeight, winName);
}


/***************************************************************************
 * 설  명 : 담당자검색 결과 반영
 ***************************************************************************/
function fnEmployeePopValue(records, fieldName){
		
	// 전송받은 값이 한건일 경우
    var record = records[0].data;				

		Ext.get('csr_emp_num').set({value:record.EMP_NUM} , false);
    	Ext.get('csr_emp_name').set({value:record.KOR_NAME} , false);
    	Ext.get('csr_dept_code').set({value:record.DEPT_CODE} , false);
    	Ext.get('csr_dept_name').set({value:record.DEPT_NAME} , false);
}


// 품목 팝업 ****************************************
function fnItemPop(param){
	var sURL      = "/com/item/itemSearchPop.sg"+param;
	var dlgWidth  = 420;
	var dlgHeight = 370;
	var winName   = "item";
	fnOpenPop(sURL, dlgWidth, dlgHeight, winName);
}

function fnItemSearchPopValue(records){
	
	// 선택된 row
	var record = GridClass_edit_1st.grid.selModel.getSelections(); 
	// popUp에서 선택된 아이템 코드값
	var item_code = records[0].data.ITEM_CODE;
	var item_name = records[0].data.ITEM_NAME;

	// 값을 설정
	record[0].set('ITEM_CODE', item_code);	// 품목코드
	record[0].set('ITEM_NAME', item_name);	// 품목명
	
}


 // 프로젝트 **************************************************
function fnPjtPop(param){
	var sURL      = "/pjt/pjtManage/pjtInfoPop.sg"+param;
	var dlgWidth  = 420;
	var dlgHeight = 430;
	var winName   = "project";
	fnOpenPop(sURL, dlgWidth, dlgHeight, winName);
}

function fnPjtPopValue(records, fieldName){
	
	if(fieldName == 'pjt_id'){ 
		var record = records[0].data;	
		
		
		var PJT_ID = record.PJT_ID;
		var PJT_NAME = record.PJT_NAME;
		var PROC_STATUS_CODE = record.PROC_STATUS_CODE;
		
		if(PJT_ID.substr(0,3)!= "PJT")
		{	
			Ext.Msg.alert('확인', '영업프로젝트가 아닙니다');
			return;
		}
		
		if(PROC_STATUS_CODE.substr(0,3)!= "19")	//영업프로젝트의 상태코드-PJT_STATUS
		{	
			//Ext.Msg.alert('확인', '프로젝트가 확정되지 않았습니다.');
			//return;
		}		
						
					Ext.Ajax.request({   
						url: "/dev/csrInfo/selectPjtItem.sg"   
						,success: function(response){						// 조회결과 성공시
									// 조회된 결과값, store명
									var json = Ext.util.JSON.decode(response.responseText);
									
									GridClass_edit_1st.store.removeAt(0);
									//GridClass_edit_1st.store.commitChanges();
									
									for (var i = 0; i < json.pjtItem.length; i++) {
										
										
									 		var Plant = GridClass_edit_1st.grid.getStore().recordType; 
										    var p = new Plant({ 
											        		    FLAG			: 'I' 
											        		  , PJT_ID          : json.pjtItem[i].PJT_ID
												    		  , PJT_NAME        : json.pjtItem[i].PJT_NAME
												    		  , ITEM_CODE	    : json.pjtItem[i].ITEM_CODE
														   	  , ITEM_NAME	    : json.pjtItem[i].ITEM_NAME
										    				  }); 
										  	GridClass_edit_1st.grid.stopEditing();
											GridClass_edit_1st.store.insert(0, p);
											GridClass_edit_1st.grid.startEditing(0, 0);
								
									}	
							
						          }
						,failure: handleFailure   	    // 조회결과 실패시  
						,form   : document.searchForm   // 검색 FORM
						,params : { 
									pjt_id : PJT_ID
							      } 
					});		
		   
	    
    }
}



// 팝업
function fnOpenPop(sURL, dlgWidth, dlgHeight, winName){
  var xPos=(window.screen.width) ? (window.screen.width-dlgWidth)/2 : 0;
  var yPos=(window.screen.height) ? (window.screen.height-dlgHeight)/2 : 0;
  var sFeatures = "titlebar=no, scrollbars=yes,location=no ,menubar=no, resizable=yes, status=yes, width="+dlgWidth+",height="+dlgHeight+",left="+xPos+", top="+yPos;
  window.open(sURL,winName, sFeatures);
}


// 그리드 행삭제
function fnEdit1stBeforeRowDeleteEvent(){

	var delRecord = GridClass_edit_1st.grid.selModel.getSelections();
	delRecord[0].set('FLAG', 'D');						//상태
}



</script>
</head>
<body>
	<table border="0" width="1000" height="200">
		<tr>
			<td colspan="2">
				<form name="searchForm">
				<input type="hidden" id="src_csr_date_from" name="src_csr_date_from"  />
				<input type="hidden" id="src_csr_date_to" name="src_csr_date_to"  />
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
												<label class="x-form-item-label" style="width: auto;" for="src_csr_date_from_tmp" >업무요청기간 :</label>
											</div>
										</td>										


										<td width="20%" align="left">
											<div tabindex="-1" class="x-form-item " >
													<table border="0" width="100%" >
														<tr>
															<td align="center">
																<input type="text" name="src_csr_date_from_tmp" id="src_csr_date_from_tmp"  style="width:80px; " >
															</td>
															<td align="left">~</td>
														    <td align="center">
																<input type="text" name="src_csr_date_to_tmp" id="src_csr_date_to_tmp"  style="width:80px;" >
															</td>
														</tr>
													</table>
											</div>
										</td>
									
										
										<td width="16%">
											<div tabindex="-1" class="x-form-item " >
												<label class="x-form-item-label" style="width: auto;" for="src_csr_dept_name" >요청부서 :</label>
												<div style="padding-left: 30px;" class="x-form-element">
													<input type="text" name="src_csr_dept_name" id="src_csr_dept_name" autocomplete="off" size="15" class="x-form-text x-form-field" style="width: auto;">
												</div>
											</div>
										</td>
										<td width="20%" valign="top">
											<%-- Button Start--%>
												<div style="padding-left: 0px;" >
													<img align="center" id="deptSearchBtn" name="deptSearchBtn" alt="" src="/resource/images/bass_1st/icon_src1.gif" style="cursor: hand;">
												</div>
											<%-- Button End--%>
											
										</td>														

																				
										<td width="30%">
											<div tabindex="-1" class="x-form-item " >
												<label class="x-form-item-label" style="width: auto;" for="src_csr_type_code">업무요청구분 :</label>
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
			<!------------------------------ GRID START ---------------------------------->
			<td width="50%" valign="top">
				<div id="task-grid" style="margin-top: 0.4em;"></div> <!----------------- 그리드명을 동일하게 설정 ----------------->		
			</td>
			<!------------------------------ GRID END ------------------------------------>
			<td width="50%" valign="top">
				<div class=" x-panel x-form-label-left" style="margin-top: 0.4em; width: 100%;"><%-- 0em <- 1em으로 수정하면 상위 공백 --%>
					<!----------------- SEARCH Hearder Start	 ----------------->
					<div class="x-panel-tl">
						<div class="x-panel-tr">
							<div class="x-panel-tc">
								<div class="x-panel-header x-unselectable" style="-moz-user-select: none;">
									<span class="x-panel-header-text">업무요청 기본정보</span><!----------------- 이름변경 ----------------->		
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
									<input type="hidden" id="flag_detailForm" name="flag_detailForm" style="width:80px" />
									<input type="hidden" id="csr_dept_code" name="csr_dept_code" style="width:80px" />	<!-- 요청자 부서코드 -->
									<input type="hidden" id="csr_date" name="csr_date" style="width:80px" />
									
									<input type="hidden" id="csr_emp_num" name="csr_emp_num"  />		<!-- 요청자 사번 -->
									
									
									<!-- DETAIL 1_ROW Start -->
									<div class="x-column-inner" style="width: 100%;">
										<!-- 신규 버튼 시작 -->
										<div tabindex="-1" class="x-form-item" >
											<table   cellspacing="0" class="x-btn  x-btn-noicon" style="width: 75px;" align="right">
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
										<div class=" x-panel x-column" style="width: 50%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label class="x-form-item-label " style="width: auto;" for="task_group_code" ><font color="red">* </font>요청구분 :</label>
														<div style="padding-left: 83px;" class="x-form-element">
															
															<select name="csr_type_code" id="csr_type_code" style="width: 29%;" type="text" class=" x-form-select x-form-field" >
																<option value="">전체</option>
																<c:forEach items="${SR_TYPE_CODE}" var="data" varStatus="status">
																	<c:if test="${data.COM_CODE != '20'}"> 
																		<option value="${data.COM_CODE}"><c:out value="${data.COM_CODE_NAME}"/></option>
																	</c:if>
																</c:forEach>
															</select>															
															
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
														<label style="padding-rigth: 100px;"  class="x-form-item-label" style="width: auto;" for="csr_date_tmp" ><font color="red">* </font>요청일자 :</label>
														<div style="padding-left: 83px;" class="x-form-element">
															<input type="text" name="csr_date_tmp" id="csr_date_tmp" autocomplete="off" size="22" class=" x-form-text x-form-field" style="width: auto;">
														</div>
													</div>
												</div>
											</div>
										</div>

									</div>
									<!-- DETAIL 2_ROW End -->
								
									<!-- DETAIL 3_ROW Start -->
									<div class="x-column-inner" style="width: 100%; margin-top: 0.2em;">
										<div class=" x-panel x-column" style="width: 50%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label style="padding-rigth: 100px;"  class="x-form-item-label" style="width: auto;" for="spec" ><font color="red">* </font>요청ID :</label>
														<div style="padding-left: 83px;" class="x-form-element">
															<input type="text" name="csr_id" id="csr_id" autocomplete="off" size="18" class=" x-form-text x-form-field" style="width: auto;" readonly="true">
														</div>
													</div>
												</div>
											</div>
										</div>
										<div class=" x-panel x-column" style="width: 50%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label class="x-form-item-label" style="width: auto;" for="csr_emp_name" ><font color="red">* </font>요청자 :</label>
														<div style="padding-left: 83px;" class="x-form-element">
															<table style="width: 150px;" cellspacing="0" class="x-btn  x-btn-noicon" border="0">
																<tr>
																	<td>
																		<input type="text" name="csr_dept_name" id="csr_dept_name" autocomplete="off" size="9" class=" x-form-text x-form-field" style="width: auto;" readOnly >
																		<input type="text" name="csr_emp_name" id="csr_emp_name" autocomplete="off" size="7" class=" x-form-text x-form-field" style="width: auto;" readOnly >
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
									</div>
									<!-- DETAIL 3_ROW End -->
								
									<!-- DETAIL 4_ROW Start -->
									<div class="x-column-inner" style="width: 100%; margin-top: 0.2em;">
										<div class=" x-panel x-column" style="width: 100%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label class="x-form-item-label" style="width: auto;" for="task_desc" >요청제목 :</label>
														<div style="padding-left: 83px;" class="x-form-element">
															<input type="text" name="csr_title" id="csr_title" autocomplete="off" size="70" class="x-form-text x-form-field " style="width: auto;" maxlength="50" >
														</div>
														<div class="x-form-clear-left">
														</div>
													</div>
												</div>
											</div>
										</div>					
									</div>
									<!-- DETAIL 4_ROW End -->
								
				
									
									
									<!-- DETAIL 7_ROW Start -->
									<div class="x-column-inner" style="width: 100%; margin-top: 0em;">
										<div class=" x-panel x-column" style="width:100%; height:30px;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
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
				
				
			</td>
		</tr>
		
		<tr>
			<td width="100%" valign="top" colspan="2">
				<div id="csr_pattern_item_grid" style="margin-top: 0.4em;"></div> <!----------------- 그리드명을 동일하게 설정 ----------------->
			</td>
		</tr>
		
		
		<tr>
			<td colspan="3" align="center" height="35">
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
						<td width="1">
						</td>
						<td>
						<%-- 삭제 버튼 Start --%>
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
											<button type="button" id="deleteBtn" name="deleteBtn" class=" x-btn-text">삭제</button>
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
						<%-- 삭제 버튼 End --%>
						</td>						
					</tr>
				</table>
			</td>
		</tr>
	</table>
</body>

</html>