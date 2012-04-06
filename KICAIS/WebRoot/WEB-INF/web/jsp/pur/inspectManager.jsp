<%--
  Class Name  : purManager.jsp
  Description : 구매관리관리
  Modification Information
 
      수정일                   수정자                 수정내용
  -------      --------    ---------------------------
  2011. 3. 25   이재철            최초 생성   
  
  author   : 이재철
  since    : 2011. 3. 28.
  version  : 1.0
   
  Copyright (C) 2011 by KICA All right reserved.
--%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/web/jsp/common/inc/commonInc.jsp" %>
<script type="text/javascript" src="/resource/common/js/grid/grid_edit_3rd.js"></script>
<script type="text/javascript" src="/resource/common/js/grid/grid_edit_1st.js"></script> 
<script type="text/javascript" src="/resource/common/js/grid/grid_edit_2nd.js"></script>
 


<script type="text/javascript">
var GlobalItemCode = "";
var GlobalItemName = "";
var GlobalPurInfoSEQ = "";
/**검수결과 combo box 생성 end **/
var INSPECT_RESULT_COMBO = new Ext.form.ComboBox({    
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
				<c:forEach items="${PUR_STATUS_CODE}" var="data" varStatus="status">
					['${data.COM_CODE}', '${data.COM_CODE_NAME}']
					<c:if test="${not status.last}">,</c:if>
				</c:forEach>
			  ]
		})
});
//combo box render
Ext.util.Format.comboRenderer = function(INSPECT_RESULT_COMBO){    
	return function(value){        
	var record = INSPECT_RESULT_COMBO.findRecord(INSPECT_RESULT_COMBO.valueField, value);        
	return record ? record.get(INSPECT_RESULT_COMBO.displayField) : INSPECT_RESULT_COMBO.valueNotFoundText;    
}}
/**검수결과 combo box 생성 end **/	
	
/***************************************************************************
 * 초기값 설정
 ***************************************************************************/
var	gridHeigth_edit_3rd	=	"405";
var	gridWidth_edit_3rd;
var	gridTitle_edit_3rd   =	"구매기본정보"; 
var	render_edit_3rd		=	"render_edit_grid_3rd";
var keyNm_edit_3rd		= 	"TASK_REPORT_SEQ"; /* 요거는 확인이 필요함. */
var pageSize_edit_3rd	=	15;
var limit_edit_3rd		=	pageSize_edit_3rd;
var start_edit_3rd		=	0;
var proxyUrl_edit_3rd	= 	"/pur/inspect_edit_grid_result_3rd.sg";



var	gridHeigth_edit_1st	=	"150";
var	gridWidth_edit_1st  	;
var	gridTitle_edit_1st  =   "구매품목 정보"	; 
var	render_edit_1st		=	"render_edit_grid_1st";
var keyNm_edit_1st		= 	"TASK_REPORT_SEQ"; /* 요거는 확인이 필요함. */
var pageSize_edit_1st	=	15;
var limit_edit_1st		=	pageSize_edit_1st;
var start_edit_1st		=	0;
var proxyUrl_edit_1st	=	"/pur/pur_edit_grid_result_1st.sg";


var	gridHeigth_edit_2nd	=	"150";
var	gridWidth_edit_2nd  	;
var	gridTitle_edit_2nd  =   "구매사양정보"; 
var	render_edit_2nd		=	"render_edit_grid_2nd";
var keyNm_edit_2nd		= 	"TASK_REPORT_SEQ"; /* 요거는 확인이 필요함. */
var pageSize_edit_2nd	=	15;
var limit_edit_2nd		=	pageSize_edit_2nd;
var start_edit_2nd		=	0;
var proxyUrl_edit_2nd	=	"/pur/pur_edit_grid_result_2nd.sg";




/***************************************************************************
 * Grid의 컬럼 설정 PUR_TYPE_NAME
 ***************************************************************************/
var userColumns_edit_3rd =  [
					{header: "검수결과",			width: 100 ,sortable: true, dataIndex: 'PROC_STATUS_CODE', 	editor: INSPECT_RESULT_COMBO, renderer: Ext.util.Format.comboRenderer(INSPECT_RESULT_COMBO) }
					,{header: "검수일자",			width: 100 ,sortable: true, dataIndex: 'INSPECT_DATE', 		editor: new Ext.form.TextField({}) ,editable:false}
					,{header: "검수담당자이름",	width: 80 ,sortable: true, dataIndex: 'INSPECT_EMP_NAME', 	editor: new Ext.form.TextField({}) ,editable:false}
					,{header: "검수내용",			width: 200 ,sortable: true, dataIndex: 'INSPECT_DESC', 		editor: new Ext.form.TextField({}) ,editable:false}
					,{header: "업무구분코드", 		width: 80 ,sortable: true, dataIndex: 'ROLL_TYPE_CODE', 	editor: new Ext.form.TextField({}) ,editable:false, hidden : true}
					,{header: "구매구분이름", 		width: 80 ,sortable: true, dataIndex: 'PUR_TYPE_NAME', 	editor: new Ext.form.TextField({}) ,editable:false}
					,{header: "구매ID",  		width: 100 ,sortable: true, dataIndex: 'PUR_ID', 	 		editor: new Ext.form.TextField({}) ,editable:false, hidden : true}
					,{header: "구매명",  			width: 100 ,sortable: true, dataIndex: 'PUR_NAME', 			editor: new Ext.form.TextField({}) ,editable:false}
					,{header: "구매구분코드", 		width: 80 ,sortable: true, dataIndex: 'PUR_TYPE_CODE', 	editor: new Ext.form.TextField({}) ,editable:false}
					,{header: "프로젝트ID",	 	width: 80 ,sortable: true, dataIndex: 'PJT_ID', 	 		editor: new Ext.form.TextField({}) ,editable:false}
					,{header: "프로젝트명",	 	width: 100 ,sortable: true, dataIndex: 'PJT_NAME', 			editor: new Ext.form.TextField({}) ,editable:false}
					,{header: "구매총액",			width: 80 ,sortable: true, dataIndex: 'PUR_TOTAL_AMT', 	editor: new Ext.form.TextField({}) ,editable:false ,renderer: "korMoney", align : 'right'}
					,{header: "구매총세액",		width: 80 ,sortable: true, dataIndex: 'PUR_TOTAL_TAX', 	editor: new Ext.form.TextField({}) ,editable:false ,renderer: "korMoney", align : 'right'}
					,{header: "입고일자",			width: 80 ,sortable: true, dataIndex: 'IN_DATE', 			editor: new Ext.form.TextField({}) ,editable:false}
					,{header: "구매담당자",		width: 80 ,sortable: true, dataIndex: 'PUR_EMP_NAME', 		editor: new Ext.form.TextField({}) ,editable:false}
					,{header: "구매담당자사번",	width: 80 ,sortable: true, dataIndex: 'PUR_EMP_NUM', 		editor: new Ext.form.TextField({}) ,editable:false, hidden : true}
					,{header: "지출결의번호",		width: 80 ,sortable: true, dataIndex: 'PAY_NO', 			editor: new Ext.form.TextField({}) , hidden : true}
					,{header: "품의서번호",		width: 80 ,sortable: true, dataIndex: 'PUR_REPORT_NUM', 	editor: new Ext.form.TextField({}) , hidden : true}
					,{header: "검수필요여부",		width: 80 ,sortable: true, dataIndex: 'INSPECT_YN', 		editor: new Ext.form.TextField({}) , hidden : true}
					,{header: "검수담당자사번",	width: 80 ,sortable: true, dataIndex: 'INSPECT_EMP_NUM', 	editor: new Ext.form.TextField({}) , hidden : true}
					,{header: "사용일자",			width: 80 ,sortable: true, dataIndex: 'USE_DATE', 			editor: new Ext.form.TextField({}) , hidden : true}
					,{header: "사용자",			width: 80 ,sortable: true, dataIndex: 'USE_EMP_NUM', 		editor: new Ext.form.TextField({}) , hidden : true}
					,{header: "사용자사번",		width: 80 ,sortable: true, dataIndex: 'USE_EMP_NAME', 		editor: new Ext.form.TextField({}) , hidden : true}
					,{header: "비고",			width: 80 ,sortable: true, dataIndex: 'NOTE', 				editor: new Ext.form.TextField({}) , hidden : true}
					,{header: "업무구분이름",  	width: 80 ,sortable: true, dataIndex: 'ROLL_TYPE_NAME', 	editor: new Ext.form.TextField({}) , hidden : true}
					,{header: "구매일자",		 	width: 80 ,sortable: true, dataIndex: 'PUR_DATE', 			editor: new Ext.form.TextField({}) , hidden : true}
					,{header: "최종변경자ID",	 	width: 80 ,sortable: true, dataIndex: 'FINAL_MOD_ID', 	 	editor: new Ext.form.TextField({}) , hidden : true}
					,{header: "최종변경자이름",	 	width: 80 ,sortable: true, dataIndex: 'FINAL_MOD_NAME', 	 	editor: new Ext.form.TextField({}) , hidden : true}
					,{header: "최종변경일시",	 	width: 80 ,sortable: true, dataIndex: 'FINAL_MOD_DATE', 	editor: new Ext.form.TextField({}) , hidden : true}
				   ];
var userColumns_edit_1st =  [
					{header: "구매ID",  		sortable: true, dataIndex: 'PUR_ID', 	 	editor: new Ext.form.TextField({}) , hidden : true}
					,{header: "순번",  		sortable: true, dataIndex: 'PUR_INFO_SEQ',  editor: new Ext.form.TextField({}) , hidden : true}
					,{header: "거래처코드",  	sortable: true, dataIndex: 'CUSTOM_CODE',  	editor: new Ext.form.Label({})		, hidden : true}
					,{header: "거래처이름",  	sortable: true, dataIndex: 'CUSTOM_NAME',  	editor: new Ext.form.TextField({}), editable:false 		,renderer:changeBLUE}
					,{header: "품목코드",  	sortable: true, dataIndex: 'ITEM_CODE',  	editor: new Ext.form.Label({}) 		, hidden : true}
					,{header: "품목이름",  	sortable: true, dataIndex: 'ITEM_NAME',  	editor: new Ext.form.TextField({}), editable:false  ,renderer:changeBLUE}
					,{header: "규격",		sortable: true, dataIndex: 'STANDARD',  	editor: new Ext.form.TextField({}), editable:false  }
					,{header: "수량",  	 	sortable: true, dataIndex: 'CNT',  			editor: new Ext.form.TextField({}) }
					,{header: "단위",  	 	sortable: true, dataIndex: 'UNIT',  		editor: new Ext.form.TextField({}) }
					,{header: "단가",  	 	sortable: true, dataIndex: 'UNIT_PRICE',  	editor: new Ext.form.Label({}) , editable:false ,renderer: "korMoney", align : 'right'}
					,{header: "금액",  	 	sortable: true, dataIndex: 'AMT',  			editor: new Ext.form.Label({}) , editable:false ,renderer: "korMoney", align : 'right'}
					,{header: "세액",  	 	sortable: true, dataIndex: 'TAX',  			editor: new Ext.form.Label({}) , editable:false ,renderer: "korMoney", align : 'right' , hidden : true}
					,{header: "유무상구분",  	sortable: true, dataIndex: 'PAY_FREE_CODE', editor: new Ext.form.Label({}) 		, hidden : true}
					,{header: "비고",  	 	sortable: true, dataIndex: 'NOTE',  		editor: new Ext.form.TextField({}) }
				   ];
var userColumns_edit_2nd =  [
					{header: "구매ID",  	 	sortable: true, dataIndex: 'PUR_ID', 	 		editor: new Ext.form.TextField({}) , hidden : true}
					,{header: "순번",  		sortable: true, dataIndex: 'PUR_INFO_SEQ',  	editor: new Ext.form.TextField({}) , hidden : true}
					,{header: "품목이름",  	sortable: true, dataIndex: 'ITEM_NAME',  		editor: new Ext.form.TextField({}), editable:false  }
					,{header: "품목코드", 	sortable: true, dataIndex: 'ITEM_CODE',  		editor: new Ext.form.Label({}) , hidden : true}
					,{header: "제원설명",  	sortable: true, dataIndex: 'SPEC_INTRO',  		editor: new Ext.form.TextField({}) }
					,{header: "제원수량",  	sortable: true, dataIndex: 'SPEC_CNT',  		editor: new Ext.form.TextField({}) }
					,{header: "제원용량",  	sortable: true, dataIndex: 'SPEC_VOL',  		editor: new Ext.form.TextField({}) }
					,{header: "비고",  		sortable: true, dataIndex: 'NOTE',  			editor: new Ext.form.TextField({}) }
				   ];				   				   

/***************************************************************************
 * 그리드 결과매핑 
 ***************************************************************************/
var mappingColumns_edit_3rd = [
					  {name: 'FLAG' 		    , allowBlank: false}   // 상태 
					 ,{name: 'PROC_STATUS_CODE'	, allowBlank: false} 	// 진행상태
					 ,{name: 'INSPECT_DATE'		, allowBlank: false} 	// 검수일자
					 ,{name: 'INSPECT_EMP_NAME'	, allowBlank: false} 	// 검수담당자이름
					 ,{name: 'INSPECT_DESC'		, allowBlank: false} 	// 검수담당자이름
					 ,{name: 'ROLL_TYPE_CODE'	, allowBlank: false} 	// 업무구분코드
					 ,{name: 'ROLL_TYPE_NAME'	, allowBlank: false} 	// 업무구분이름
					 ,{name: 'PUR_ID'			, allowBlank: false}	// 구매ID
					 ,{name: 'PUR_NAME'			, allowBlank: false} 	// 구매명  
					 ,{name: 'PUR_TYPE_CODE'	, allowBlank: false} 	// 구매구분코드  
					 ,{name: 'PUR_TYPE_NAME'	, allowBlank: false} 	// 구매구분이름
					 ,{name: 'PJT_ID'			, allowBlank: false} 	// 프로젝트ID
					 ,{name: 'PJT_NAME' 		, allowBlank: false} 	// 프로젝트명 
					 ,{name: 'PUR_TOTAL_AMT'	, allowBlank: false} 	// 구매총액
					 ,{name: 'PUR_TOTAL_TAX'	, allowBlank: false} 	// 구매총세액
					 ,{name: 'IN_DATE'			, allowBlank: false} 	// 입고일자
					 ,{name: 'PUR_EMP_NUM'		, allowBlank: false} 	// 구매담당자사번
					 ,{name: 'PUR_EMP_NAME'		, allowBlank: false} 	// 구매당당자이름
					 ,{name: 'PAY_NO'			, allowBlank: false} 	// 지출결의번호
					 ,{name: 'PUR_REPORT_NUM'	, allowBlank: false} 	// 품의서번호
					 ,{name: 'INSPECT_YN'		, allowBlank: false} 	// 검수필요여부
					 ,{name: 'INSPECT_EMP_NUM'	, allowBlank: false} 	// 검수담당자사번
					 ,{name: 'USE_DATE'			, allowBlank: false} 	// 사용일자
					 ,{name: 'USE_EMP_NUM'		, allowBlank: false} 	// 사용일자
					 ,{name: 'USE_EMP_NAME'		, allowBlank: false} 	// 사용일자
					 ,{name: 'NOTE'				, allowBlank: false} 	// 비고
					 ,{name: 'PUR_DATE'			, allowBlank: false} 	// 구매일
					 ,{name: 'FINAL_MOD_ID' 	, allowBlank: false} 	// 최종변경자ID
					 ,{name: 'FINAL_MOD_NAME' 	, allowBlank: false} 	// 최종변경자 이름
					 ,{name: 'FINAL_MOD_DATE'	, allowBlank: false} 	// 최종변경일시
    				 ];
var mappingColumns_edit_1st = [ 
					  {name: 'FLAG' 		    , allowBlank: false}   // 상태
					 ,{name: 'PUR_ID'			, allowBlank: false}	// 구매ID
					 ,{name: 'PUR_INFO_SEQ'		, allowBlank: false} 	// 순번  
					 ,{name: 'CUSTOM_CODE'		, allowBlank: false} 	// 거래처코드
					 ,{name: 'CUSTOM_NAME'		, allowBlank: false} 	// 거래처이름
					 ,{name: 'ITEM_CODE'		, allowBlank: false} 	// 품목코드
					 ,{name: 'ITEM_NAME'		, allowBlank: false} 	// 품목이름
					 ,{name: 'STANDARD' 		, allowBlank: false} 	// 규격   
					 ,{name: 'UNIT'  			, allowBlank: false} 	// 단위
					 ,{name: 'CNT' 		  		, allowBlank: false} 	// 수량
					 ,{name: 'UNIT_PRICE' 		, allowBlank: false} 	// 단가      
					 ,{name: 'AMT'   			, allowBlank: false} 	// 금액
					 ,{name: 'TAX'   			, allowBlank: false} 	// 세액 
					 ,{name: 'PAY_FREE_CODE' 	, allowBlank: false} 	// 유무상구분
					 ,{name: 'NOTE'   			, allowBlank: false} 	// 비고
    				 ];
					 
var mappingColumns_edit_2nd = [ 
					  {name: 'PUR_ID'				, allowBlank: false}	//구매ID
					 ,{name: 'PUR_INFO_SEQ'			, allowBlank: false} 	//순번  
					 ,{name: 'ITEM_NAME'			, allowBlank: false} 	//품목이름  
					 ,{name: 'ITEM_CODE'			, allowBlank: false} 	//품목코드
					 ,{name: 'SPEC_INTRO' 		  	, allowBlank: false} 	//제원설명
					 ,{name: 'SPEC_CNT' 			, allowBlank: false} 	//제원수량  
					 ,{name: 'SPEC_VOL' 			, allowBlank: false} 	//제원용량
					 ,{name: 'NOTE'   				, allowBlank: false} 	//비고
    				 ];
 
 /***************************************************************************
 * 그리드 클래스 필수 입력값 정의
 ***************************************************************************/

//그리드_1st 클릭시 Event
function fnGridOnClick_edit_3rd(store, rowIndex){
	var pur_id = fnFixNull(store.getAt(rowIndex).data.PUR_ID)
	fnSearchPurItem(pur_id);
}

//에디트 그리드_1st row 클릭시 Event
function fnGridOnClick_edit_1st(store, rowIndex){
}
//에디트  그리드_2nd row 클릭시 Event
function fnGridOnClick_edit_2nd(store, rowIndex){
}  

//편집그리드의 Tbar를 숨길경우 'Y'로 선언
var tbarHidden_edit_1st = 'Y'
var tbarHidden_edit_2nd = 'Y'
var tbarHidden_edit_3rd = 'Y'

//에디트 그리드1st 의 CELL을 수정하였을 경우 이벤트
function  fnEdit1stAfterCellEdit(obj){
}

//에디트 그리드 2nd 의 CELL을 수정하였을 경우 이벤트 
function  fnEdit2ndAfterCellEdit(obj){
}
function  fnEdit3rdAfterCellEdit(obj){
}

//구매 품목 에디트 그리드의 CELL을 클릭하였을 경우 이벤트
 function  fnEdit1stCellClickEvent(grid, rowIndex, columnIndex, e){
	var record = GridClass_edit_1st.grid.selModel.getSelected()
	var pur_id = record.get('PUR_ID');
	var itemCode = record.get('ITEM_CODE');
	GlobalItemCode = itemCode;
	GlobalItemName = record.get('ITEM_NAME');
	GlobalPurInfoSEQ = record.get('PUR_INFO_SEQ');
	fnSearchPurSpec(pur_id,itemCode);
}

//구매 스펙 에디트 그리드의 CELL을 클릭하였을 경우 이벤트
 function  fnEdit2ndCellClickEvent(grid, rowIndex, columnIndex, e){
}
 function  fnEdit3rdCellClickEvent(grid, rowIndex, columnIndex, e){
 	var record = GridClass_edit_3rd.grid.selModel.getSelected()
	var pur_id = record.get('PUR_ID');
	fnSearchPurItem(pur_id);
}


function fnEdit1stRowDeleteBb(){
}
function fnEdit2ndRowDeleteBb(){
}
function fnEdit3rdRowDeleteBb(){
}
function fnGridDeleteRow(record){
}
 
 
function goAction_edit_1st(){
}
function goAction_edit_2nd(){
}
function goAction_edit_3rd(){
}

 function addNew_edit_1st(){
}
function addNew_edit_2nd(){
}
function addNew_edit_3rd(){
}

function fnPagingValue_1st(){
}
function fnPagingValue_edit_1st(){
}
function fnPagingValue_edit_2nd(){
}
function fnPagingValue_edit_3rd(){
}

/***************************************************************************
 * 설  명 : 기능 정의 자바스크립트 함수 정의 시작
 **************************************************************************/
//구매 품목 정보 가져오기
 function fnSearchPurItem(pur_id){
	//그리드 리셋.
	GridClass_edit_1st.store.removeAll();
	GridClass_edit_2nd.store.removeAll();
	Ext.Ajax.request({
		url: "/pur/pur_edit_grid_result_1st.sg" 
		,success: function(response){
					handleSuccess(response,GridClass_edit_1st);
		          }
		,failure: handleFailure 
		,params : {
					 limit			: limit_edit_1st
				   , start			: start_edit_1st
				   , pur_id			: pur_id
				  }				
	});   
}

//구매 스펙 가져오기
function fnSearchPurSpec(pur_id,itemCode){
	GridClass_edit_2nd.store.removeAll();
	Ext.Ajax.request({
		url: "/pur/pur_edit_grid_result_2nd.sg" 
		,success: function(response){
					handleSuccess(response,GridClass_edit_2nd);
		          }
		,failure: handleFailure 
		,params : {
					 limit			: limit_edit_2nd
				   , start			: start_edit_2nd
				   , pur_id			: pur_id
				   , item_code		: itemCode
				  }				
	});   
}

//필드 초기화
function fnInitValue(){
}

//검색
//검색하기 버튼
function fnSearch(){  	
	Ext.Ajax.request({   
		url: "/pur/result_1st.sg"
		,method : 'POST'   
		,success: function(response){						// 조회결과 성공시
					handleSuccess(response,GridClass_1st);
				 }   							
		,failure: handleFailure   	   						// 조회결과 실패시  
		,params : {					   						// 조회조건을 DB로 전송하기위해서 조건값 설정
						limit				: limit_1st
					  , start				: start_1st
					  , src_pur_id			: Ext.get('src_pur_id').getValue()   
				  	  , src_pjt_id			: Ext.get('src_pjt_id').getValue()  
				  	  , src_pur_date_from	: Ext.get('src_pur_date_from').getValue() 
				  	  , src_pur_date_to		: Ext.get('src_pur_date_to').getValue()
				  
				  }				
	});  
	
} 		

//저장버튼 클릭
function fnSave(str){  	
}  		

//검수정보 업데이트
function updateInspectInfo(){
	
	var records = GridClass_edit_3rd.store.getModifiedRecords();
	var record = records[0].data;
	var pur_id = record.PUR_ID;
	var proc_status_code = record.PROC_STATUS_CODE;
	
	alert(pur_id);
	alert(proc_status_code);
	
	
	//데이터 전송
	Ext.Ajax.request({   
		url: "/pur/inspectUpdateInfoProc.sg"   
		,success: function(response){						// 조회결과 성공시
					// 조회된 결과값, store명
					handleSuccess(response,GridClass_edit_3rd);
		          }
		,failure: handleFailure   	// 조회결과 실패시  
		,params : {					// 조회조건을 DB로 전송하기위해서 조건값 설정
					limit				: limit_edit_3rd
				  , start				: start_edit_3rd
				  , pur_id				: pur_id      
				  , proc_status_code	: proc_status_code
				  , req_type 			: "UPDATE"
				  }  		
	});
}
/***************************************************************************
 * EXTJS 시작
 ***************************************************************************/
Ext.onReady(function() {
	
	//검색 구매일자 FROM
	var startdt = new Ext.form.DateField({
	    applyTo: 'src_pur_date_from',
		allowBlank: false,
		format:'Y-m-d'
	});
	//검색 구매일자 TO
	var enddt = new Ext.form.DateField({
	    applyTo: 'src_pur_date_to',
		allowBlank: false,
		format:'Y-m-d'
	});
	
	
	
	//구매ID InputText (src_pur_id)를 클릭했을 경우 프로젝트 검색화면 제공
	Ext.get('src_pur_id').on('click', function(e){
		//alert(' 구매정보 검색화면 제공');
	});
	
	//프로젝트ID를 클릭하면 프로젝트 정보 검색 화면을 제공
	Ext.get('src_pjt_id').on('click', function(e){
		var param = "";
		var multiSelectYn = "";
		var fieldName = "src_pjt_id";
		var pjt_type_code = "10";
		param = "multiSelectYn=" + multiSelectYn + "&fieldName=" + fieldName + "&src_pjt_type_code=" +  pjt_type_code;
		fnPjtPop(param);
	});
	
	
	
	/**
	 * 검색하기 버튼 클릭 searchBtn
	 */
	Ext.get('searchBtn').on('click', function(e){	
		GridClass_edit_1st.store.removeAll();
		fnSearch();
	});
	
	/**
	 * 검색하기 버튼 클릭 searchBtn
	 */
	Ext.get('updateBtn').on('click', function(e){	
		GridClass_edit_1st.store.removeAll();
		GridClass_edit_2nd.store.removeAll();
		updateInspectInfo();
	});
	
});


//품목사양  에디트 그리드의 CELL을 수정하였을 경우 이벤트
 function fnEdit1stAfterRowDeleteEvent(){
}




/***************************************************************************
 * 팝업 관련 자바스크립트 함수 정리
 ***************************************************************************/
//프로젝트 검색 팝업을 띄우는 화면
function fnPjtPop(param){
	var sURL      = "/pjt/pjtManage/pjtInfoPop.sg?"+param;
	var dlgWidth  = 399;
	var dlgHeight = 444;
	var winName   = "project";
	fnOpenPop(sURL, dlgWidth, dlgHeight, winName);
}

//프로젝트 팝업 결과값을 받아서 처리하는 함수
function fnPjtPopValue(records, fieldName){
	
	// 전송받은 값이 한건일 경우
    var record = records[0].data;	
	if(fieldName == 'pjt_id'){
	    Ext.get('pjt_id').set({value:fnFixNull(record.PJT_ID)} , false);
    }else if(fieldName == 'src_pjt_id'){
		Ext.get('src_pjt_id').set({value:fnFixNull(record.PJT_ID)} , false);
	}
}

// 팝업 창 만드는 함수
function fnOpenPop(sURL, dlgWidth, dlgHeight, winName){
  var xPos=(window.screen.width) ? (window.screen.width-dlgWidth)/2 : 0;
  var yPos=(window.screen.height) ? (window.screen.height-dlgHeight)/2 : 0;
  var sFeatures = "titlebar=no, scrollbars=yes,location=no ,menubar=no, resizable=yes, status=yes, width="+dlgWidth+",height="+dlgHeight+",left="+xPos+", top="+yPos;
  window.open(sURL,winName, sFeatures);
}
</script>

</head>
<body>
	<table border="0" width="1000px" height="100%">
		<tr>
			<td colspan="2">
				<!-- 상단 검색 제목 시작 -->
				<div class=" x-panel x-form-label-left" style="width: auto">
					<div class="x-panel-tl">
						<div class="x-panel-tr">
							<div class="x-panel-tc">
								<div class="x-panel-header x-unselectable" style="-moz-user-select: none;">
									<center><span class="x-panel-header-text">구매 정보 조회</span></center>
								</div>
							</div>
						</div>
					</div>
				</div>
				<!-- 상단 검색 제목 끝-->
				<!----------------- SEARCH START	 ----------------->
				<div id="calendar"></div>
				<form name="searchForm" id='searchForm' >
					<div class="x-panel-bwrap" >
						<div class="x-panel-ml">
							<div class="x-panel-mr">
								<div class="x-panel-mc" >
									<table border="0" width="100%"  style="font-size: 12px">
										<tr>
											<td width='20%'>
												<div tabindex="-1" class="x-form-item " >
													<label class="x-form-item-label" style="width: auto;" for="src_pur_id">구매ID:</label>
													<div style="padding-left: 10px;" class="x-form-element">
														<input type="text" name="src_pur_id" id="src_pur_id" autocomplete="off" size="10" class="x-form-text x-form-field" style="width: auto;">
													</div>
												</div>
											</td>
											<td width='18%'>
												<div tabindex="-1" class="x-form-item " >
													<div style="padding-left: 10px;" class="x-form-element">
													<label class="x-form-item-label" style="width: auto;" for="src_pur_date_from">구매기간 :</label>
														<input type="text" name="src_pur_date_from" id="src_pur_date_from" size="10" class="x-form-text x-form-field" style="width: auto;">
													</div>
												</div>
												
											</td>
											<td width='18%'>
												<div tabindex="-1" class="x-form-item " >
													<div style="padding-left: 10px;" class="x-form-element">
														<input type="text" name="src_pur_date_to" id="src_pur_date_to" autocomplete="off" size="10" class="x-form-text x-form-field" style="width: auto;">
													</div>
												</div>
												
											</td>
											<td width='23%'>
												<div tabindex="-1" class="x-form-item " >
													<label class="x-form-item-label" style="width: auto;" for="src_dept_level" >구매구분 :</label>
													<div style="padding-left: 10px;" class="x-form-element">
														<select name="src_pur_type_code" id="src_pur_type_code" style="width: 29%;" type="text" class=" x-form-select x-form-field" >
															<option value="">전체</option>
															<c:forEach items="${ITEM_TYPE_CODE}" var="data" varStatus="status">
															<option value="${data.COM_CODE}"><c:out value="${data.COM_CODE_NAME}"/></option>
															</c:forEach>
														</select>
													</div>
												</div>
											</td>
											<td>
												<div tabindex="-1" class="x-form-item " >
													<label class="x-form-item-label" style="width: auto;" for="src_pjt_id">프로젝트ID :</label>
													<div style="padding-left: 10px;" class="x-form-element">
														<input type="text" name="src_pjt_id" id="src_pjt_id" autocomplete="off" size="15" class="x-form-text x-form-field" style="width: auto;">
													</div>
												</div>
											</td>
										</tr>
										
										<tr align="right">
											<td colspan="6">
												<input type="button" id="searchBtn" name="searchBtn" value="검색하기"/>
												<input type="button" id="searchClearBtn" name="searchClearBtn" value="조건해제"/>
											</td>
										</tr>
									</table>
								</div>
							</div>
						</div>
					</div>
				</form>
				<!----------------- SEARCH END	 ----------------->
			</td>
		</tr>
		<tr>
			<!----------------- GRID_1st START ----------------->
			<td colspan='2'>
				<div id="render_edit_grid_3rd"></div>
			</td>
			<!----------------- GRID_1st END ----------------->
		</tr>
		<tr>
			<!----------------- EDIT_GRID_1st START ----------------->
			<td colspan='2'>
				<div id="render_edit_grid_1st"></div>
			</td>
			<!----------------- EDIT_GRID_1st END ----------------->
		</tr>
		<tr>
			<!----------------- GRID_3rd START ----------------->
			<td colspan='2'>
				<div id="render_edit_grid_2nd"></div>
			</td>
			<!----------------- GRID_3rd END ----------------->
		</tr>
		
		<tr>
			<td colspan="2" align="center"  height="100%">
				<input type="button" id="updateBtn" name="updateBtn" value="수정" />
			</td>
		</tr>
	</table>
</body>
<%@ include file="/WEB-INF/web/jsp/sgis-bottom-inc.jsp" %>