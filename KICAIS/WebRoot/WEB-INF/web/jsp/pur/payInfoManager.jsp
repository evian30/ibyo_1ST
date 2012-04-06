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
<script type="text/javascript" src="/resource/common/js/sgis-comm-inc.js" ></script> 
<script type="text/javascript" src="/resource/common/js/common/common-msg-box.js" ></script> 
<script type="text/javascript" src="/resource/common/js/ajax.js" ></script>

<script type="text/javascript" src="/resource/common/js/grid/grid_1st.js"></script>
<script type="text/javascript" src="/resource/common/js/grid/grid_edit_1st.js"></script> 

<script type="text/javascript">
/***************************************************************************
 * 초기값 설정
 ***************************************************************************/
/** grid_1st **/
var	gridHeigth_1st	=	"375";
var	gridWidth_1st	= 	"";
var	gridTitle_1st   =	"지출결의 정보"; 
var	render_1st		=	"render_1st";
var pageSize_1st	=	15;
var limit_1st		=	pageSize_1st;
var start_1st		=	0;
var proxyUrl_1st	= 	"/pur/payInfo_result_grid_1st.sg";

/** grid_2nd **/
var	gridHeigth_edit_1st	=	"150";
var	gridWidth_edit_1st	= 	"";
var	gridTitle_edit_1st  =   "지출 증빙 정보"; 
var	render_edit_1st		=	"render_edit_grid_1st";
var keyNm_edit_1st		= 	"";
var pageSize_edit_1st	=	15;
var limit_edit_1st		=	pageSize_edit_1st;
var start_edit_1st		=	0;
var proxyUrl_edit_1st	=	"/pur/payInfo_result_edit_grid_1st.sg";
var tbarHidden_edit_1st =   "";

//증빙유형코드 콤보박스
var evid_type_code_combo = new Ext.form.ComboBox({    
	typeAhead: true, 
	triggerAction: 'all',
	lazyRender:true,
	mode: 'local',
	editable : false,
	valueField: 'value',
	displayField: 'displayText',
	forceSelection: true,
	selectOnFocus: true,
	valueNotFoundText: '',
	store: new Ext.data.ArrayStore({
			id: 0,
			fields: ['value', 'displayText'],
			data: [
					<c:forEach items="${BILL_TYPE_CODE}" var="data" varStatus="status">
						['${data.COM_CODE}', '${data.COM_CODE_NAME}']
						<c:if test="${not status.last}">,</c:if>
					</c:forEach>
				  ]
			})
});

//증빙유형코드 콤보박스 combo box render
Ext.util.Format.comboRenderer = function(evid_type_code_combo){    
	return function(value){        
	var record = evid_type_code_combo.findRecord(evid_type_code_combo.valueField, value);        
	return record ? record.get(evid_type_code_combo.displayField) : evid_type_code_combo.valueNotFoundText;    
}}


//기본적요구구분코드
var cost_type_code_combo = new Ext.form.ComboBox({    
	typeAhead: true, 
	triggerAction: 'all',
	lazyRender:true,
	mode: 'local',
	editable : false,
	valueField: 'value',
	displayField: 'displayText',
	forceSelection: true,
	selectOnFocus: true,
	valueNotFoundText: '',
	store: new Ext.data.ArrayStore({
			id: 0,
			fields: ['value', 'displayText'],
			data: [
					<c:forEach items="${COST_TYPE_CODE}" var="data" varStatus="status">
						['${data.COM_CODE}', '${data.COM_CODE_NAME}']
						<c:if test="${not status.last}">,</c:if>
					</c:forEach>
				  ]
			})
});

//증빙유형코드 콤보박스 combo box render
Ext.util.Format.comboRenderer = function(cost_type_code_combo){    
	return function(value){        
	var record = cost_type_code_combo.findRecord(cost_type_code_combo.valueField, value);        
	return record ? record.get(cost_type_code_combo.displayField) : cost_type_code_combo.valueNotFoundText;    
}}

/***************************************************************************
 * Grid의 컬럼 설정 PUR_TYPE_NAME
 ***************************************************************************/
var userColumns_1st =  [
					{header: "지출번호",  		width: 100 ,sortable: true, dataIndex: 'PAY_NO', 	 		editor: new Ext.form.TextField({}) }
					,{header: "지출일자",  		width: 100 ,sortable: true, dataIndex: 'PAY_DATE', 			editor: new Ext.form.TextField({}) }
					,{header: "구매ID", 			width: 80 ,sortable: true, dataIndex: 'PUR_ID', 			editor: new Ext.form.TextField({}) , hidden : true}
					,{header: "구매이름", 		width: 80 ,sortable: true, dataIndex: 'PUR_NAME', 			editor: new Ext.form.TextField({}) , hidden : true}
					,{header: "품의번호", 		width: 80 ,sortable: true, dataIndex: 'REPORT_ID', 			editor: new Ext.form.TextField({}) , hidden : true}
					,{header: "프로젝트ID", 		width: 80 ,sortable: true, dataIndex: 'PJT_ID', 			editor: new Ext.form.TextField({}) , hidden : true}
					,{header: "프로젝트이름", 		width: 80 ,sortable: true, dataIndex: 'PJT_NAME', 			editor: new Ext.form.TextField({}) }
					,{header: "기안자사번",		width: 80 ,sortable: true, dataIndex: 'DRAFT_EMP_NUM', 		editor: new Ext.form.TextField({}) , hidden : true}
					,{header: "기안자이름",		width: 80 ,sortable: true, dataIndex: 'DRAFT_EMP_NAME', 	editor: new Ext.form.TextField({}) }
					,{header: "기안부서코드",		width: 80 ,sortable: true, dataIndex: 'DRAFT_DEPT_CODE', 	editor: new Ext.form.TextField({}) , hidden : true}
					,{header: "기안부서이름",		width: 80 ,sortable: true, dataIndex: 'DRAFT_DEPT_NAME', 	editor: new Ext.form.TextField({}) , hidden : true}
					,{header: "시행자사번",		width: 80 ,sortable: true, dataIndex: 'ENFORCE_EMP_NUM', 	editor: new Ext.form.TextField({}) , hidden : true}
					,{header: "시행자이름",		width: 80 ,sortable: true, dataIndex: 'ENFORCE_EMP_NAME', 	editor: new Ext.form.TextField({}) , hidden : true}
					,{header: "시행부서코드",		width: 80 ,sortable: true, dataIndex: 'ENFORCE_DEPT_CODE', 	editor: new Ext.form.TextField({}) , hidden : true}
					,{header: "시행부서이름",		width: 80 ,sortable: true, dataIndex: 'ENFORCE_DEPT_NAME', 	editor: new Ext.form.TextField({}) , hidden : true}
					,{header: "시행일자",			width: 80 ,sortable: true, dataIndex: 'ENFORCE_DATE', 		editor: new Ext.form.TextField({}) , hidden : true}
					,{header: "결의일자",			width: 80 ,sortable: true, dataIndex: 'RESOL_DATE', 		editor: new Ext.form.TextField({}) , hidden : true}
					,{header: "사용일자",			width: 80 ,sortable: true, dataIndex: 'USE_DATE', 			editor: new Ext.form.TextField({}) , hidden : true}
					,{header: "사용자사번",		width: 80 ,sortable: true, dataIndex: 'USE_EMP_NUM', 		editor: new Ext.form.TextField({}) , hidden : true}
					,{header: "사용자이름",		width: 80 ,sortable: true, dataIndex: 'USE_EMP_NAME', 		editor: new Ext.form.TextField({}) , hidden : true}
					,{header: "사용부서코드",		width: 80 ,sortable: true, dataIndex: 'USE_DEPT_CODE', 		editor: new Ext.form.TextField({}) , hidden : true}
					,{header: "사용부서이름",		width: 80 ,sortable: true, dataIndex: 'USE_DEPT_NAME', 		editor: new Ext.form.TextField({}) , hidden : true}
					,{header: "예산구분코드",		width: 80 ,sortable: true, dataIndex: 'BUDGET_TYPE_CODE', 	editor: new Ext.form.TextField({}) , hidden : true}
					,{header: "예산사용부서코드",	width: 80 ,sortable: true, dataIndex: 'BUDGET_USE_DEPT_CODE',	editor: new Ext.form.TextField({}) , hidden : true}
					,{header: "예산사용부서이름",	width: 80 ,sortable: true, dataIndex: 'BUDGET_USE_DEPT_NAME', 	editor: new Ext.form.TextField({}) , hidden : true}
					,{header: "지출내용",			width: 80 ,sortable: true, dataIndex: 'PAY_DESC', 				editor: new Ext.form.TextField({}) , hidden : true}
					,{header: "지출총금액",		width: 80 ,sortable: true, dataIndex: 'PAY_TOTAL_AMT', 			editor: new Ext.form.TextField({}) , hidden : true}
					,{header: "지출총세액",		width: 80 ,sortable: true, dataIndex: 'PAY_TOTAL_TAX', 			editor: new Ext.form.TextField({}) , hidden : true}
					,{header: "비고",			width: 80 ,sortable: true, dataIndex: 'NOTE', 					editor: new Ext.form.TextField({}) , hidden : true}
				   ];
				   
var userColumns_edit_1st =  [
					{header: "지출번호",  		width: 100 ,sortable: true, dataIndex: 'PAY_NO', 	 			editor: new Ext.form.TextField({allowBlank : true}) , hidden : true}
					,{header: "순번",  			width: 100 ,sortable: true, dataIndex: 'PAY_INFO_SEQ', 	 		editor: new Ext.form.TextField({allowBlank : true}) , hidden : true}
					,{header: "증빙유형코드",		width: 100 ,sortable: true, dataIndex: 'EVID_TYPE_CODE', 		editor: evid_type_code_combo  ,renderer: Ext.util.Format.comboRenderer(evid_type_code_combo) }
					,{header: "증빙일자",  		width: 100 ,sortable: true, dataIndex: 'EVID_DATE', 	 		editor: new Ext.form.TextField({allowBlank : true}) }
					,{header: "증빙번호",  		width: 100 ,sortable: true, dataIndex: 'EVID_NO', 	 			editor: new Ext.form.TextField({allowBlank : true}) }
					,{header: "거래처이름",  		width: 100 ,sortable: true, dataIndex: 'CUSTOM_NAME', 	 		editor: new Ext.form.TextField({allowBlank : true}) ,renderer:changeBLUE}
					,{header: "거래처코드",  		width: 100 ,sortable: true, dataIndex: 'CUSTOM_CODE', 	 		editor: new Ext.form.TextField({allowBlank : true}) , hidden : true}
					,{header: "금액",  			width: 100 ,sortable: true, dataIndex: 'AMT', 	 				editor: new Ext.form.TextField({allowBlank : true}) ,renderer: "korMoney", align : 'right'}
					,{header: "세액",  			width: 100 ,sortable: true, dataIndex: 'TAX', 	 				editor: new Ext.form.TextField({allowBlank : true}) ,editable:false ,renderer: "korMoney", align : 'right'}
					,{header: "기본적요구분코드",	width: 100 ,sortable: true, dataIndex: 'BASE_BRIEF_TYPE_CODE',	editor: cost_type_code_combo  ,renderer: Ext.util.Format.comboRenderer(cost_type_code_combo) }
					,{header: "상세내역",  		width: 100 ,sortable: true, dataIndex: 'DETAIL_DESC', 	 		editor: new Ext.form.TextField({allowBlank : true}) }
					,{header: "비고",  			width: 100 ,sortable: true, dataIndex: 'NOTE', 	 				editor: new Ext.form.TextField({allowBlank : true}) }
				   ];

/***************************************************************************
 * 그리드 결과매핑 
 ***************************************************************************/
var mappingColumns_1st = [
					  {name: 'FLAG' 		    , allowBlank: false}   //  
					 ,{name: 'PAY_NO'			, allowBlank: false}	// 지출번호
					 ,{name: 'PAY_DATE'			, allowBlank: false} 	// 지출일자  
					 ,{name: 'PUR_ID'			, allowBlank: false} 	// 구매ID  
					 ,{name: 'PUR_NAME'			, allowBlank: false} 	// 구매이름
					 ,{name: 'REPORT_ID'		, allowBlank: false} 	// 품의번호
					 ,{name: 'PJT_ID'			, allowBlank: false} 	// 프로젝트ID
					 ,{name: 'PJT_NAME'			, allowBlank: false} 	// 프로젝트이름
					 ,{name: 'DRAFT_EMP_NUM'	, allowBlank: false} 	// 기안자사번
					 ,{name: 'DRAFT_EMP_NAME'	, allowBlank: false} 	// 기안자이름
					 ,{name: 'DRAFT_DEPT_CODE'	, allowBlank: false} 	// 기안부서코드
					 ,{name: 'DRAFT_DEPT_NAME'	, allowBlank: false} 	// 기안부서이름
					 ,{name: 'ENFORCE_EMP_NUM'	, allowBlank: false} 	// 시행자사번
					 ,{name: 'ENFORCE_EMP_NAME'	, allowBlank: false} 	// 시행자이름
					 ,{name: 'ENFORCE_DEPT_CODE', allowBlank: false} 	// 시행부서코드
					 ,{name: 'ENFORCE_DEPT_NAME', allowBlank: false} 	// 시행부서이름
					 ,{name: 'ENFORCE_DATE'		, allowBlank: false} 	// 시행일자
					 ,{name: 'RESOL_DATE'		, allowBlank: false} 	// 결의일자
					 ,{name: 'USE_DATE'			, allowBlank: false} 	// 사용일자
					 ,{name: 'USE_EMP_NUM'		, allowBlank: false} 	// 사용자사번
					 ,{name: 'USE_EMP_NAME'		, allowBlank: false} 	// 사용자이름
					 ,{name: 'USE_DEPT_CODE'	, allowBlank: false} 	// 사용부서코드
					 ,{name: 'USE_DEPT_NAME'	, allowBlank: false} 	// 사용부서이름
					 ,{name: 'BUDGET_TYPE_CODE'		, allowBlank: false} 	// 예산구분코드
					 ,{name: 'BUDGET_USE_DEPT_CODE'	, allowBlank: false} 	// 예산사용부서코드 
					 ,{name: 'BUDGET_USE_DEPT_NAME'	, allowBlank: false} 	// 예산사용부서이름
					 ,{name: 'PAY_DESC' 			, allowBlank: false} 	// 지출내용
					 ,{name: 'PAY_TOTAL_AMT' 		, allowBlank: false} 	// 지출총금액
					 ,{name: 'PAY_TOTAL_TAX' 		, allowBlank: false} 	// 지출총세액
					 ,{name: 'NOTE' 				, allowBlank: false} 	// 비고
    				 ];

var mappingColumns_edit_1st = [ 
						{name: 'FLAG' 		    		, allowBlank: false}   //
						,{name: 'PAY_NO'				, allowBlank: false}	// 지출번호
						,{name: 'PAY_INFO_SEQ'			, allowBlank: false}	// 순번
						,{name: 'EVID_TYPE_CODE'		, allowBlank: false}	// 증빙유형코드
						,{name: 'EVID_DATE'				, allowBlank: false}	// 증빙일자
						,{name: 'EVID_NO'				, allowBlank: false}	// 증빙번호
						,{name: 'CUSTOM_NAME'			, allowBlank: false}	// 거래처이름
						,{name: 'CUSTOM_CODE'			, allowBlank: false}	// 거래처코드
						,{name: 'AMT'					, allowBlank: false}	// 금액
						,{name: 'TAX'					, allowBlank: false}	// 세액
						,{name: 'BASE_BRIEF_TYPE_CODE'	, allowBlank: false}	// 기본적요구분코드
						,{name: 'DETAIL_DESC'			, allowBlank: false}	// 상세내역
						,{name: 'NOTE'					, allowBlank: false}	// 비고						
    				 ];

/***************************************************************************
 * GRID_1ST 에 필수 항목 정의 시작
 ***************************************************************************/
//검색 후 스토어 리로드 후 한글깨짐 현상 방지를 위해 파라메터 설정하는 함수
function fnPagingValue_1st(){
	
}

//그리드의 ROW 클릭시 Event
function fnGridOnClick_1st(store, rowIndex){
	Ext.get('pay_no').set({ value: fnFixNull(store.getAt(rowIndex).data.PAY_NO)}, false);
	Ext.get('pay_date').set({ value: fnFixNull(store.getAt(rowIndex).data.PAY_DATE)}, false);
	Ext.get('pur_id').set({ value: fnFixNull(store.getAt(rowIndex).data.PUR_ID)}, false);
	Ext.get('pur_name').set({ value: fnFixNull(store.getAt(rowIndex).data.PUR_NAME)}, false);
	Ext.get('report_id').set({ value: fnFixNull(store.getAt(rowIndex).data.REPORT_ID)}, false);
	Ext.get('pjt_id').set({ value: fnFixNull(store.getAt(rowIndex).data.PJT_ID)}, false);
	Ext.get('draft_emp_num').set({ value: fnFixNull(store.getAt(rowIndex).data.DRAFT_EMP_NUM)}, false);
	Ext.get('draft_emp_name').set({ value: fnFixNull(store.getAt(rowIndex).data.DRAFT_EMP_NAME)}, false);
	Ext.get('draft_dept_code').set({ value: fnFixNull(store.getAt(rowIndex).data.DRAFT_DEPT_CODE)}, false);
	Ext.get('enforce_emp_num').set({ value: fnFixNull(store.getAt(rowIndex).data.ENFORCE_EMP_NUM)}, false);
	Ext.get('enforce_emp_name').set({ value: fnFixNull(store.getAt(rowIndex).data.ENFORCE_EMP_NAME)}, false);
	Ext.get('enforce_dept_code').set({ value: fnFixNull(store.getAt(rowIndex).data.ENFORCE_DEPT_CODE)}, false);
	Ext.get('enforce_date').set({ value: fnFixNull(store.getAt(rowIndex).data.ENFORCE_DATE)}, false);
	Ext.get('resol_date').set({ value: fnFixNull(store.getAt(rowIndex).data.RESOL_DATE)}, false);
	Ext.get('use_date').set({ value: fnFixNull(store.getAt(rowIndex).data.USE_DATE)}, false);
	Ext.get('use_emp_num').set({ value: fnFixNull(store.getAt(rowIndex).data.USE_EMP_NUM)}, false);
	Ext.get('use_emp_name').set({ value: fnFixNull(store.getAt(rowIndex).data.USE_EMP_NAME)}, false);
	Ext.get('use_dept_code').set({ value: fnFixNull(store.getAt(rowIndex).data.USE_DEPT_CODE)}, false);
	Ext.get('budget_type_code').set({ value: fnFixNull(store.getAt(rowIndex).data.BUDGET_TYPE_CODE)}, false);
	Ext.get('budget_use_dept_code').set({ value: fnFixNull(store.getAt(rowIndex).data.BUDGET_USE_DEPT_CODE)}, false);
	Ext.get('budget_use_dept_name').set({ value: fnFixNull(store.getAt(rowIndex).data.BUDGET_USE_DEPT_NAME)}, false);
	Ext.get('pay_desc').set({ value: fnFixNull(store.getAt(rowIndex).data.PAY_DESC)}, false);
	Ext.get('pay_total_amt').set({ value: MoneyComma( fnFixNull(store.getAt(rowIndex).data.PAY_TOTAL_AMT) )}, false);
	Ext.get('pay_total_tax').set({ value: MoneyComma( fnFixNull(store.getAt(rowIndex).data.PAY_TOTAL_TAX) )}, false);
	Ext.get('note').set({ value: fnFixNull(store.getAt(rowIndex).data.NOTE)}, false);
	Ext.get('final_mod_id').set({ value: fnFixNull(store.getAt(rowIndex).data.FINAL_MOD_ID)}, false);
	Ext.get('final_mod_date').set({ value: fnFixNull(store.getAt(rowIndex).data.FINAL_MOD_DATE)}, false);
	
	//지출증빙정보 가져오기
	fnGetPayEvidInfo(fnFixNull(store.getAt(rowIndex).data.PAY_NO));
	
}
/***************************************************************************
 * GRID_1ST 에 필수 항목 정의 끝
 ***************************************************************************/








/***************************************************************************
 * EDIT_GRID_1ST 에 필수 항목 정의 시작
 ***************************************************************************/
//검색 후 스토어 리로드 후 한글깨짐 현상 방지를 위해 파라메터 설정하는 함수
function fnPagingValue_edit_1st(){
	try{
		GridClass_edit_1st.store.setBaseParam('start'		,start_edit_1st);
	    GridClass_edit_1st.store.setBaseParam('limit'		,limit_edit_1st);
	}catch(e){

	}
}
//행 추가시 참조 키 값 자동으로 Edit Grid에 넘겨주는 함수
function addNew_edit_1st(){
	
	var pay_no = Ext.get('pay_no').getValue();
	
	if(pay_no == ""){
		Ext.Msg.alert('확인', '지출결의번호를  조회해주세요'); 
		return false;
	}
	
	var Plant = GridClass_edit_1st.grid.getStore().recordType; 
	var p = new Plant(
		{ 
			FLAG			:	'I'
			,PAY_NO			:	Ext.get("pay_no").getValue()
			,AMT			:	'0'
			,TAX			:	'0'
	  	}
	); 
  	GridClass_edit_1st.grid.stopEditing();
	GridClass_edit_1st.store.insert(0, p);
	GridClass_edit_1st.grid.startEditing(0, 0);
}

//변경된 레코드가 있는 모든 ROW를 데이터 통신 하는 함수
function goAction_edit_1st(){
	
}

//행을 삭제시 DB로 행의 값을 전달하는 함수
function fnGridDeleteRow(){
	
}

//cell을 클릭하였을 경우 수행되는 함수
function fnEdit1stCellClickEvent(grid, rowIndex, columnIndex, e){
	//거래처 코드 팝업
	if(columnIndex == '5'){ //거래처 이름을 클릭하면
		var temp= GridClass_edit_1st.store;
		var gridName = "GridClass_edit_1st";
		var grid_name = "grid_name=" + gridName;
		var grid_row = "grid_row=" + rowIndex;
		var grid_fieldName = "grid_fieldName=" + 'CUSTOM_CODE';
		var param = grid_name +'&'+ grid_row +'&'+ grid_fieldName;
		fnCustomPop(param);
	}
}

// cell을 수정하였을 경우 수행되는 함수
function fnEdit1stAfterCellEdit(obj){
	var editedRow = obj.row;
	var editedColumn = obj.column;
	var editedValue = obj.value;
	var fieldName = obj.field;
	
	// 해당 컬럼의 값이 변경 되었을 경우
	if( fieldName == 'AMT'){
		fnCalculatePayEvidInfoAmt(fieldName);
	}

	if( fieldName == 'EVID_DATE'){

		var record = GridClass_edit_1st.store.getAt(editedRow);
		var val = '';
	
		editedValue = editedValue.replaceAll('-','');
		
		if(editedValue.length == 8){
			val = fnGridDateCheck(editedValue);
		}else{
			Ext.Msg.alert('확인', '유효한 날짜가 아닙니다. 날짜를 다시 입력해 주십시요.\n\n예)20110508'); 
		}
		record.set(fieldName, val);						
	}
	
}

function fnEdit1stAfterRowDeleteEvent(){
	fnCalculatePayEvidInfoAmt('');
}

function fnGridOnClick_edit_1st(model, rowIndex, record){
	
}
//편집그리드의 Tbar를 숨길경우 'Y'로 선언
var tbarHidden_edit_1st = '';

//그리드의 자료를 실제로 DB에서 삭제할경우 'Y'로 설정
var gridRowDeleteYn = '';

/***************************************************************************
 * EDIT_GRID_1ST 에 필수 항목 정의 끝
 ***************************************************************************/


/***************************************************************************
 * 자바 스크립트 시작점 정의
 ***************************************************************************/
Ext.onReady(function() {
	Ext.get('saveBtn').dom.disabled = true;
	Ext.get('updateBtn').dom.disabled = false;
	
	var toDay = getTimeStamp();	
	toDay = toDay.replaceAll('-','');
	toDay = addDate(toDay, 'M', -3);
	toDay = toDay.substring(0,4)+"-"+toDay.substring(4,6)+"-"+toDay.substring(6,8);
	var fromDay = toDay;
	toDay = getTimeStamp().trim();
	
	//검색-지출기간시작
	var src_pay_date_from = new Ext.form.DateField({
	    applyTo: 'src_pay_date_from',
		allowBlank: true,
		format:'Y-m-d',
		editable : false,
		value : fromDay
	});
	//검색-지출기간끝
	var src_pay_date_to = new Ext.form.DateField({
	    applyTo: 'src_pay_date_to',
		allowBlank: true,
		format:'Y-m-d',
		editable : false,
		value : toDay
		
	});
	//지출일자
	var pay_date = new Ext.form.DateField({
	    applyTo: 'pay_date',
		allowBlank: true,
		format:'Y-m-d',
		editable : true
	});
	//시행일자
	var enforce_date = new Ext.form.DateField({
	    applyTo: 'enforce_date',
		allowBlank: true,
		format:'Y-m-d',
		editable : true
	});
	//결의일자
	var resol_date = new Ext.form.DateField({
	    applyTo: 'resol_date',
		allowBlank: true,
		format:'Y-m-d',
		editable : true
	});
	//사용일자
	var use_date = new Ext.form.DateField({
	    applyTo: 'use_date',
		allowBlank: true,
		format:'Y-m-d',
		editable : true
	});
	
	//구매ID 를 입력하려고 클릭한 경우 구매 검색 팝업 창
	Ext.get('pur_name').on('click', function(e){
		var param = "";
		fnPopGetPurInfo(param);
	});
	
	//기안자 를 입력하려고 클릭한 경우 사원 검색 팝업 창
	Ext.get('draft_emp_name').on('click', function(e){
		fnPopGetEmployeeInfo("draft_emp_name");
	});
	
	//시행자 를 입력하려고 클릭한 경우 사원 검색 팝업 창
	Ext.get('enforce_emp_name').on('click', function(e){
		fnPopGetEmployeeInfo("enforce_emp_name");
	});
	
	//사용자 를 입력하려고 클릭한 경우 사원 검색 팝업 창
	Ext.get('use_emp_name').on('click', function(e){
		fnPopGetEmployeeInfo("use_emp_name");
	});

	//예산사용부서를 입력하려고 클릭한 경우 사원 검색 팝업 창
	Ext.get('budget_use_dept_name').on('click', function(e){
		var param = "";
		fnPopGetDeptInfo(param);
	});

	//신규버튼 클릭
	Ext.get('btn_newPayInfo').on('click', function(e){
		Ext.MessageBox.confirm('지출번호등록', '지출번호를 새로 등록하시겠습니까?', fnNewPayItemConfirm);
		Ext.get('saveBtn').dom.disabled = false;
		Ext.get('updateBtn').dom.disabled = true;
	});

	//등록 클릭
	Ext.get('saveBtn').on('click', function(e){
		if(fnValidation()){
			Ext.MessageBox.confirm('Confirm', '등록하시겠습니까?', showNewPayInfoReg);
		};
	});
	
	//수정 클릭
	Ext.get('updateBtn').on('click', function(e){
		if(fnValidation()){
			Ext.MessageBox.confirm('Confirm', '수정하시겠습니까?', showPayInfoUpdate);
		};
	});
	
	//검색하기 클릭
	Ext.get('searchBtn').on('click', function(e){
		var startDate = Ext.get('src_pay_date_from').getValue()  // 검색시작일
		var endDate = Ext.get('src_pay_date_to').getValue()      // 검색종료일
	  
		if(fnCalDate(startDate,endDate,'D') < 0){
			Ext.Msg.alert('확인', '검색시작일이 검색종료일보다 이전입니다.'); 
		}else{
			fnInitValue();
			fnSearch();
		}
	});
	
	//조건해제 클릭
	Ext.get('searchClearBtn').on('click', function(e){
		document.searchForm.reset();
		fnInitValue();
		fnSearch();
	});

});

function showNewPayInfoReg(btn){
   	if(btn == 'yes'){
		fnNewPayInfoReg();
   	}    	
};

function showPayInfoUpdate(btn){
   	if(btn == 'yes'){
		fnPayInfoUpdate();
   	}    	
};

/***************************************************************************
 * 기능 구현 자바스크립트 함수 정의 시작
 ***************************************************************************/
//지출결의 번호 획득 기능함수
function fnNewPayItemConfirm(btn){
	if(btn == 'yes'){
		Ext.Ajax.request({   
			url: "/pur/makePayNo.sg"   
			,mothod : 'POST'
			,success: function(response){
				//폼 초기화 기능
				//구매ID채번 및 읽기 전용
				fnInitValue();
				
				var input_pay_no = Ext.get('pay_no');
				input_pay_no.set({value : response.responseText}, false);
				input_pay_no.set({readOnly : true}, false);

			} 					
			,failure: function(response){
				Ext.Msg.alert('확인', '구매ID를 생성하는데 실패하였습니다.'); 
			}			   	    	
		});
   	}else{
		Ext.Msg.alert('확인', '취소하셨습니다.'); 
	}
}

//화면의 모든 데이터를 읽어와 DB에 저장하는 AJAX통신 수행
function fnNewPayInfoReg(){
	//등록된 지출 증빙 정보
	var records = GridClass_edit_1st.store.getModifiedRecords();

	//등록된 지출 증빙 정보 record의 자료를 json형식으로
    var payEvidInfo = "[";
	for (var i = 0; i < records.length; i++) {
		payEvidInfo += Ext.util.JSON.encode(records[i].data);				
		if (i < (records.length-1)) {
			payEvidInfo += ",";
		}
	}
	payEvidInfo += "]"
	
	//Form Data 체크
	var pay_no = Ext.get('pay_no').getValue();
	var pay_date = Ext.get('pay_date').getValue();
	var report_id = Ext.get('report_id').getValue();
	var draft_emp_num = Ext.get('draft_emp_num').getValue();
	var pur_id = Ext.get('pur_id').getValue();
	var pjt_id = Ext.get('pjt_id').getValue();
	var draft_dept_code = Ext.get('draft_dept_code').getValue();
	var enforce_emp_num = Ext.get('enforce_emp_num').getValue();
	var enforce_dept_code = Ext.get('enforce_dept_code').getValue();
	var enforce_date = Ext.get('enforce_date').getValue();
	var resol_date = Ext.get('resol_date').getValue();
	var use_date = Ext.get('use_date').getValue();
	var use_emp_num = Ext.get('use_emp_num').getValue();
	var use_dept_code = Ext.get('use_dept_code').getValue();
	var budget_type_code = Ext.get("budget_type_code").getValue()
	var budget_use_dept_code = Ext.get('budget_use_dept_code').getValue();
	var pay_desc = Ext.get('pay_desc').getValue();
	var pay_total_amt = Ext.get('pay_total_amt').getValue();
	var pay_total_tax = Ext.get('pay_total_tax').getValue();
	var note = Ext.get('note').getValue();
	
	//데이터 전송
	Ext.Ajax.request({   
		url: "/pur/payInfoRegProc.sg"   
		,success: function(response){
					//handleSuccess(response,GridClass_1st);
					//Ext.Msg.alert('확인', '성공'); 
					fnInitValue();
					fnSearch();
		          }
		,failure: handleFailure   	  
		,params : {					
					limit			: limit_1st
					,start			: start_1st
					,payEvidInfo		: payEvidInfo
					,pay_no 			: pay_no
					,pay_date 			: pay_date
					,pur_id 			: pur_id
					,report_id 			: report_id
					,pjt_id 			: pjt_id
					,draft_emp_num 		: draft_emp_num
					,draft_dept_code 	: draft_dept_code
					,enforce_emp_num 	: enforce_emp_num
					,enforce_dept_code 	: enforce_dept_code
					,enforce_date 		: enforce_date
					,resol_date 		: resol_date
					,use_date 			: use_date
					,use_emp_num 		: use_emp_num
					,use_dept_code 		: use_dept_code
					,budget_type_code 	: budget_type_code
					,budget_use_dept_code : budget_use_dept_code
					,pay_desc 			: pay_desc
					,pay_total_amt 		: pay_total_amt
					,pay_total_tax 		: pay_total_tax
					,note 				: note
					,req_type			: ""
				  }  		
	});
}

//화면의 모든 데이터를 읽어와 DB에 업데이트하는 AJAX통신 수행
function fnPayInfoUpdate(){
	//등록된 지출 증빙 정보
	var records = GridClass_edit_1st.store.getModifiedRecords();

	//등록된 지출 증빙 정보 record의 자료를 json형식으로
    var payEvidInfo = "[";
	for (var i = 0; i < records.length; i++) {
		payEvidInfo += Ext.util.JSON.encode(records[i].data);				
		if (i < (records.length-1)) {
			payEvidInfo += ",";
		}
	}
	payEvidInfo += "]"
	
	//Form Data 체크
	var pay_no = Ext.get('pay_no').getValue();
	var pay_date = Ext.get('pay_date').getValue();
	var report_id = Ext.get('report_id').getValue();
	var draft_emp_num = Ext.get('draft_emp_num').getValue();
	var pur_id = Ext.get('pur_id').getValue();
	var pjt_id = Ext.get('pjt_id').getValue();
	var draft_dept_code = Ext.get('draft_dept_code').getValue();
	var enforce_emp_num = Ext.get('enforce_emp_num').getValue();
	var enforce_dept_code = Ext.get('enforce_dept_code').getValue();
	var enforce_date = Ext.get('enforce_date').getValue();
	var resol_date = Ext.get('resol_date').getValue();
	var use_date = Ext.get('use_date').getValue();
	var use_emp_num = Ext.get('use_emp_num').getValue();
	var use_dept_code = Ext.get('use_dept_code').getValue();
	var budget_type_code = Ext.get("budget_type_code").getValue()
	var budget_use_dept_code = Ext.get('budget_use_dept_code').getValue();
	var pay_desc = Ext.get('pay_desc').getValue();
	var pay_total_amt = Ext.get('pay_total_amt').getValue();
	var pay_total_tax = Ext.get('pay_total_tax').getValue();
	var note = Ext.get('note').getValue();
	
	//데이터 전송
	Ext.Ajax.request({   
		url: "/pur/payInfoRegProc.sg"   
		,success: function(response){
					//handleSuccess(response,GridClass_1st);
					//Ext.Msg.alert('확인', '성공');
					fnInitValue();
					fnSearch();
		          }
		,failure: handleFailure   	  
		,params : {					
					limit			: limit_1st
					,start			: start_1st
					,payEvidInfo		: payEvidInfo
					,pay_no 			: pay_no
					,pay_date 			: pay_date
					,pur_id 			: pur_id
					,report_id 			: report_id
					,pjt_id 			: pjt_id
					,draft_emp_num 		: draft_emp_num
					,draft_dept_code 	: draft_dept_code
					,enforce_emp_num 	: enforce_emp_num
					,enforce_dept_code 	: enforce_dept_code
					,enforce_date 		: enforce_date
					,resol_date 		: resol_date
					,use_date 			: use_date
					,use_emp_num 		: use_emp_num
					,use_dept_code 		: use_dept_code
					,budget_type_code 	: budget_type_code
					,budget_use_dept_code : budget_use_dept_code
					,pay_desc 			: pay_desc
					,pay_total_amt 		: pay_total_amt
					,pay_total_tax 		: pay_total_tax
					,note 				: note
					,req_type			: "UPDATE"
				  }  		
	});
}

//지출결의정보 그리드 클릭시 지출 증빙 정보 가져오기 함수
function fnGetPayEvidInfo(pay_no){
	//그리드 리셋.
	GridClass_edit_1st.store.removeAll();
	Ext.Ajax.request({
		url: "/pur/payInfo_result_edit_grid_1st.sg" 
		,success: function(response){
						handleSuccess(response,GridClass_edit_1st);	
					}
		,failure: function(){
					fnGetPayEvidInfoFail();	
					} 
		,params : {
					 limit			: limit_edit_1st
				   , start			: start_edit_1st
				   , pay_no			: pay_no
				  }				
	});   
}

//금액이 변경되었을 경우 세액/지출총금액/지출총세액을 계산하여 설정
function fnCalculatePayEvidInfoAmt(fieldName){
	
	var rowCnt = GridClass_edit_1st.store.getCount();  // Grid의 총갯수
	var payEvidInfoTotalAmt = 0;		//총 금액
	var payEvidInfoTotalTax = 0;		//총 세액
	
	if( rowCnt > 0){
		//row 숫자만큼 돌면서 수량*단가를 가져옴
		for(i = 0 ; i < rowCnt ; i++){
				
			var record = GridClass_edit_1st.store.getAt(i);
			var amt = parseInt(GridClass_edit_1st.store.data.items[i].data.AMT);
			var tax = parseInt(amt * 0.1); 
		
			record.set('AMT', fnIsNaN(amt));			//금액
			record.set('TAX', fnIsNaN(tax));			//세액
			
			payEvidInfoTotalAmt += fnIsNaN(parseInt(amt));   // 총 액
			payEvidInfoTotalTax += fnIsNaN(parseInt(tax));   // 총 세액
	
		} // end for	
		
	//	alert(payEvidInfoTotalAmt);
	//	alert(payEvidInfoTotalTax);

	}
	
	// 수주총액
	Ext.get('pay_total_amt').set({value:MoneyComma(payEvidInfoTotalAmt)}, false);
	// 할인총액
	Ext.get('pay_total_tax').set({value:MoneyComma(payEvidInfoTotalTax)}, false);
}


//검색하기 버튼
function fnSearch(){  	
	Ext.Ajax.request({   
		url: "/pur/payInfo_result_grid_1st.sg"
		,method : 'POST'   
		,success: function(response){						// 조회결과 성공시
					handleSuccess(response,GridClass_1st);
				 }   							
		,failure: handleFailure   	   						// 조회결과 실패시  
		,params : {					   						// 조회조건을 DB로 전송하기위해서 조건값 설정
						limit				: limit_1st
					  , start				: start_1st
					  , src_pay_no			: Ext.get('src_pay_no').getValue()   
				  	  , src_pjt_id			: Ext.get('src_pjt_id').getValue()  
				  	  , src_pjt_name		: Ext.get('src_pjt_name').getValue()
				  	  , src_draft_emp_name	: Ext.get('src_draft_emp_name').getValue()
				  	  , src_pay_date_from	: Ext.get('src_pay_date_from').getValue() 
				  	  , src_pay_date_to		: Ext.get('src_pay_date_to').getValue()
				  }				
	});  
} 

/***************************************************************************
 * 기능 구현 자바스크립트 함수 정의 끝
 ***************************************************************************/

/***************************************************************************
 * 팝업 관련 자바스크립트 정의 시작
 ***************************************************************************/

//구매 정보 검색 팝업을 가져오는 함수
function fnPopGetPurInfo(param){
	var sURL 	  = "/pur/purSearchPop.sg"+param;
	var dlgWidth  = 399;
	var dlgHeight = 395;
	var winName   = "purInfo";
	fnOpenPop(sURL, dlgWidth, dlgHeight, winName);
}
//구매 팝업에서 결과를 가져와서 처리하는 함수
function fnPurSearchValue(records){
	var record = records[0].data;
	//구매ID
	Ext.get("pur_id").set({ value: fnFixNull(record.PUR_ID) });
	//구매명
	Ext.get("pur_name").set({ value: fnFixNull(record.PUR_NAME) });
	//프로젝트 ID
	Ext.get("pjt_id").set({ value: fnFixNull(record.PJT_ID) });
}

//사원 정보 검색 팝업을 가져오는 함수
function fnPopGetEmployeeInfo(requestFieldName){
	var sURL 	  = "/com/employee/employeePop.sg?requestFieldName="+requestFieldName;
	var dlgWidth  = 420;
	var dlgHeight = 400;
	var winName   = "empInfo";
	fnOpenPop(sURL, dlgWidth, dlgHeight, winName);
}

//사원 정보 검색 결과를 가져와서 처리하는 함수
function fnEmployeePopValue(records, fieldName){
	var record = records[0].data;
	if(fieldName == 'draft_emp_name'){
		Ext.get('draft_emp_name').set({value : fnFixNull(record.KOR_NAME)});
		Ext.get('draft_emp_num').set({value : fnFixNull(record.EMP_NUM)});
		Ext.get('draft_dept_code').set({value : fnFixNull(record.DEPT_CODE)});
		Ext.get('draft_emp_name').set({readOnly : true}, false);
	}else if(fieldName == 'enforce_emp_name'){
		Ext.get('enforce_emp_num').set({value : fnFixNull(record.EMP_NUM)});
		Ext.get('enforce_emp_name').set({value : fnFixNull(record.KOR_NAME)});
		Ext.get('enforce_dept_code').set({value : fnFixNull(record.DEPT_CODE)});
		Ext.get('enforce_emp_name').set({readOnly : true}, false);
	}else if(fieldName == 'use_emp_name'){
		Ext.get('use_emp_num').set({value : fnFixNull(record.EMP_NUM)});
		Ext.get('use_emp_name').set({value : fnFixNull(record.KOR_NAME)});
		Ext.get('use_dept_code').set({value : fnFixNull(record.DEPT_CODE)});
		Ext.get('use_emp_name').set({readOnly : true}, false);
	}
}

//예산사용부서 검색 팝업을 가져오는 함수
function fnPopGetDeptInfo(param){
	var sURL 	  = "/com/dept/deptPop.sg?"+param;
	var dlgWidth  = 420;
	var dlgHeight = 380;
	var winName   = "budgetUseDept";
	fnOpenPop(sURL, dlgWidth, dlgHeight, winName);
}

//예산사용부서 검색 결과를 가져와서 처리하는 함수
function fnDeptPopValue(records,temp){
	var record = records[0].data;
	Ext.get('budget_use_dept_name').set({value : fnFixNull(record.DEPT_NAME)});
	Ext.get('budget_use_dept_code').set({value : fnFixNull(record.DEPT_CODE)});
	Ext.get('budget_use_dept_name').set({readOnly : true}, false);
}

//거래처 검색 팝업을 가져오는 함수
function fnCustomPop(param){
	var sURL      = "/com/custom/customPop.sg?"+param;
	var dlgWidth  = 420;
	var dlgHeight = 360;
	var winName   = "customer";
	fnOpenPop(sURL, dlgWidth, dlgHeight, winName);
}

//팝업 만드는 함수
function fnOpenPop(sURL, dlgWidth, dlgHeight, winName){
	var xPos=(window.screen.width) ? (window.screen.width-dlgWidth)/2 : 0;
	var yPos=(window.screen.height) ? (window.screen.height-dlgHeight)/2 : 0;
	var sFeatures = "titlebar=no, scrollbars=no,location=no ,menubar=no, resizable=no, status=yes, width="+dlgWidth+",height="+dlgHeight+",left="+xPos+", top="+yPos;
	window.open(sURL,winName, sFeatures);
}

/***************************************************************************
 * 팝업 관련 자바스크립트 정의 끝
 ***************************************************************************/
function fnValidation(){
	
	var pay_no 		  = Ext.get('pay_no').getValue();			// 지출번호
	var pay_date 	  = Ext.get('pay_date').getValue();			// 지출일자
	var pur_id		  = Ext.get('pur_id').getValue();			// 구매ID
	var report_id 	  =	Ext.get('report_id').getValue();		// 품의번호
	var draft_emp_num = Ext.get('draft_emp_num').getValue();	// 기안자
	var pay_total_amt = Ext.get('pay_total_amt').getValue();	// 지출총금액
	
	if(pay_no == '' || pay_no.length == 0){
		Ext.Msg.alert('확인', '지출결의번호가 필요합니다.');
		return false;
	}
	
	if(pay_date == '' || pay_date.length == 0){
		Ext.Msg.alert('확인', '지출날짜를 입력해주세요.');
		return false;
	}
	
	if(report_id == '' || report_id.length == 0){
		Ext.Msg.alert('확인', '구매ID를 입력해주세요.');
		return false;
	}
	
	if(report_id == '' || report_id.length == 0){
		Ext.Msg.alert('확인', '품의번호를 입력해주세요.');
		return false;
	}
	
	if(draft_emp_num == '' || draft_emp_num.length == 0){
		Ext.Msg.alert('확인', '기안자를 입력해주세요.');
		return false;
	}
	
	var rowCnt = GridClass_edit_1st.store.getCount();  // Grid의 총갯수
		
	if(rowCnt == 0){
		Ext.Msg.alert('확인', '지출증빙정보를 입력해주세요.');
		return false;
	}else{
		if(pay_total_amt == '' || pay_total_amt.length == 0){
			Ext.Msg.alert('확인', '지출증빙정보의 지출금액을 입력해주세요.');
			return false;
		}
	}
	
	return true;
}

function fnInitValue(){
	
	regPayInfoForm.reset();
	
	try{
		GridClass_edit_1st.store.commitChanges();	// 변경된 record를 commit
		GridClass_edit_1st.store.removeAll();		// store자료를 삭제
	}catch(e){
		
	}
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
									<center><span class="x-panel-header-text">지출결의 정보 조회</span></center>
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
													<label class="x-form-item-label" style="width: auto;" for="src_pay_no">지출번호:</label>
													<div style="padding-left: 10px;" class="x-form-element">
														<input type="text" name="src_pay_no" id="src_pay_no" autocomplete="off" size="10" class="x-form-text x-form-field" style="width: auto;">
													</div>
												</div>
											</td>
											<td width='18%'>
												<div tabindex="-1" class="x-form-item " >
													<div style="padding-left: 10px;" class="x-form-element">
													<label class="x-form-item-label" style="width: auto;" for="src_pay_date_from">지출기간 :</label>
														<input type="text" name="src_pay_date_from" id="src_pay_date_from" size="10" class="x-form-text x-form-field" style="width: auto;">
													</div>
												</div>
												
											</td>
											<td width='18%'>
												<div tabindex="-1" class="x-form-item " >
													<div style="padding-left: 10px;" class="x-form-element">
														<input type="text" name="src_pay_date_to" id="src_pay_date_to" autocomplete="off" size="10" class="x-form-text x-form-field" style="width: auto;">
													</div>
												</div>
												
											</td>
											<td>
												<div tabindex="-1" class="x-form-item " >
													<label class="x-form-item-label" style="width: auto;" for="src_pjt_name">프로젝트ID :</label>
													<div style="padding-left: 10px;" class="x-form-element">
														<input type="text" name="src_pjt_name" id="src_pjt_name" autocomplete="off" size="15" class="x-form-text x-form-field" style="width: auto;">
														<input type="hidden" name="src_pjt_id" id="src_pjt_id" autocomplete="off" size="15" class="x-form-text x-form-field" style="width: auto;">
													</div>
												</div>
											</td>
											<td>
												<div tabindex="-1" class="x-form-item " >
													<label class="x-form-item-label" style="width: auto;" for="src_draft_emp_name">기안자 :</label>
													<div style="padding-left: 10px;" class="x-form-element">
														<input type="text" name="src_draft_emp_name" id="src_draft_emp_name" autocomplete="off" size="15" class="x-form-text x-form-field" style="width: auto;">
														<input type="hidden" name="src_draft_emp_num" id="src_draft_emp_num" autocomplete="off" size="15" class="x-form-text x-form-field" style="width: auto;">
													</div>
												</div>
											</td>
										</tr>
										
										<tr align="right">
											<td colspan="6">
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
				</form>
				<!----------------- SEARCH END	 ----------------->
			</td>
		</tr>
		<tr>
			<!----------------- GRID_1st START ----------------->
			<td width='50%' height='100%'>
				<div id="render_1st"></div>
			</td>
			<!----------------- GRID_1st END ----------------->
			<!----------------- 구매기본정보 폼 시작 ----------------->
			<td width='50%'  height='100%'>
				<div class=" x-panel x-form-label-left" style="margin-top: 0; width: 100%;"><%-- 0em <- 1em으로 수정하면 상위 공백 --%>
					<!----------------- FROM Hearder Start	 ----------------->
					<div class="x-panel-tl">
						<div class="x-panel-tr">
							<div class="x-panel-tc">
								<div class="x-panel-header x-unselectable" style="-moz-user-select: none;">
									<span class="x-panel-header-text">지출결의 상세 정보</span><!----------------- 이름변경 ----------------->		
								</div>
							</div>
						</div>
					</div>
					<!----------------- FROM Hearder end	 ----------------->
					<div class="x-panel-bwrap">
					<div class="x-panel-ml">
					<div class="x-panel-mr">
					<div class="x-panel-mc" >
					<table>
						<form name='regPayInfoForm' id='regPayInfoForm' method='POST'>
						<!-- 신규버튼 시작-->
						<tr>
							<td colspan='2'>
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
														<button type="button" id="btn_newPayInfo" class=" x-btn-text">신규</button>
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
							</td>
						</tr>
						<!-- 신규버튼 끝-->
						<tr>
							<td width='225px'>
								<!-- 지출일자 시작-->
								<div tabindex="-1" class="x-form-item " >
									<label class="x-form-item-label" style="width: auto;" for="pay_date" ><font color="red">* </font>지출일자 :</label>
									<div style="padding-left:80px;" class="x-form-element">
										<input type="text" name="pay_date" id="pay_date" autocomplete="off" class=" x-form-text x-form-field" size='17' >
									</div>
									<div class="x-form-clear-left">
									</div>
								</div>
								<!-- 지출일자 종료-->
								
							</td>
							<td width='225px'>
								<!-- 지출결의번호 시작-->
								<div tabindex="-1" class="x-form-item " >
									<label class="x-form-item-label" style="width: auto;" for="pay_no" ><font color="red">* </font>지출결의번호 :</label>
									<div style="padding-left:80px;" class="x-form-element">
										<input type="text" name="pay_no" id="pay_no" autocomplete="off" class=" x-form-text x-form-field" size='20' disabled='true'>
									</div>
									<div class="x-form-clear-left">
									</div>
								</div>
								<!-- 지출결의번호 종료-->
							</td>
							
						</tr>
						<tr>
							<td width='225px'>
								<!-- 구매ID 시작 -->
								<div tabindex="-1" class="x-form-item " >
									<label class="x-form-item-label" style="width: auto;" for="pur_name" ><font color="red">* </font>구매ID :</label>
									<div style="padding-left:80px;" class="x-form-element">
										<input type="text" name="pur_name" id="pur_name" autocomplete="off" class=" x-form-text x-form-field" style="width: auto;">
										<input type="hidden" name="pur_id" id="pur_id" autocomplete="off" class=" x-form-text x-form-field" style="width: auto;">
										<input type="hidden" name="pjt_id" id="pjt_id" autocomplete="off" class=" x-form-text x-form-field" style="width: auto;">
									</div>
									<div class="x-form-clear-left">
									</div>
								</div>
								<!-- 구매ID 종료-->
							</td>
							<td width='225px'>
								<!-- 품의번호 시작 -->
								<div tabindex="-1" class="x-form-item " >
									<label class="x-form-item-label" style="width: auto;" for="report_id" ><font color="red">* </font>품의번호 :</label>
									<div style="padding-left:94px;" class="x-form-element">
										<input type="text" name="report_id" id="report_id" autocomplete="off" class=" x-form-text x-form-field" style="width: auto;">
									</div>
									<div class="x-form-clear-left">
									</div>
								</div>
								<!-- 품의번호 종료-->
							</td>
						</tr>
						<tr>
							<td width='225px'>
								<!-- 기안자 시작 -->
								<div tabindex="-1" class="x-form-item " >
									<label class="x-form-item-label" style="width: auto;" for="draft_emp_name" ><font color="red">* </font>기안자 :</label>
									<div style="padding-left:80px;" class="x-form-element">
										<input type="text" name="draft_emp_name" id="draft_emp_name" autocomplete="off" class=" x-form-text x-form-field" style="width: auto;">
										<input type="hidden" name="draft_emp_num" id="draft_emp_num" autocomplete="off" class=" x-form-text x-form-field" style="width: auto;">
										<input type="hidden" name="draft_dept_code" id="draft_dept_code" autocomplete="off" class=" x-form-text x-form-field" style="width: auto;">
									</div>
									<div class="x-form-clear-left">
									</div>
								</div>
								<!-- 기안자 종료-->
							</td>
							<td width='225px'>
								<!-- 시행일자 시작 -->
								<div tabindex="-1" class="x-form-item " >
									<label class="x-form-item-label" style="width: auto;" for="enforce_date" >시행일자 :</label>
									<div style="padding-left:94px;" class="x-form-element">
										<input type="text" name="enforce_date" id="enforce_date" autocomplete="off" class=" x-form-text x-form-field" size='17' >
									</div>
									<div class="x-form-clear-left">
									</div>
								</div>
								<!-- 시행일자 종료-->
							</td>
						</tr>
						<tr>
							<td width='225px'>
								<!-- 시행자 시작 -->
								<div tabindex="-1" class="x-form-item " >
									<label class="x-form-item-label" style="width: auto;" for="enforce_emp_name" >시행자 :</label>
									<div style="padding-left:80px;" class="x-form-element">
										<input type="text" name="enforce_emp_name" id="enforce_emp_name" autocomplete="off" class=" x-form-text x-form-field" style="width: auto;">
										<input type="hidden" name="enforce_emp_num" id="enforce_emp_num" autocomplete="off" class=" x-form-text x-form-field" style="width: auto;">
										<input type="hidden" name="enforce_dept_code" id="enforce_dept_code" autocomplete="off" class=" x-form-text x-form-field" style="width: auto;">
									</div>
									<div class="x-form-clear-left">
									</div>
								</div>
								<!-- 시행자 종료-->
							</td>
							<td width='225px'>
								<!-- 결의일자 시작 -->
								<div tabindex="-1" class="x-form-item " >
									<label class="x-form-item-label" style="width: auto;" for="resol_date" >결의일자 :</label>
									<div style="padding-left:94px;" class="x-form-element">
										<input type="text" name="resol_date" id="resol_date" autocomplete="off" class=" x-form-text x-form-field" size='17' >
									</div>
									<div class="x-form-clear-left">
									</div>
								</div>
								<!-- 결의일자 종료-->
							</td>
						</tr>
						<tr>
							<td width='225px'>
								<!-- 사용일자 시작 -->
								<div tabindex="-1" class="x-form-item " >
									<label class="x-form-item-label" style="width: auto;" for="use_date" >사용일자 :</label>
									<div style="padding-left:80px;" class="x-form-element">
										<input type="text" name="use_date" id="use_date" autocomplete="off" class=" x-form-text x-form-field" size='17' >
									</div>
									<div class="x-form-clear-left">
									</div>
								</div>
								<!-- 사용일자 종료-->
							</td>
							<td width='225px'>
								<!-- 사용자 시작 -->
								<div tabindex="-1" class="x-form-item " >
									<label class="x-form-item-label" style="width: auto;" for="use_emp_name" >사용자:</label>
									<div style="padding-left:94px;" class="x-form-element">
										<input type="text" name="use_emp_name" id="use_emp_name" autocomplete="off" class=" x-form-text x-form-field" style="width: auto;">
										<input type="hidden" name="use_emp_num" id="use_emp_num" autocomplete="off" class=" x-form-text x-form-field" style="width: auto;">
										<input type="hidden" name="use_dept_code" id="use_dept_code" autocomplete="off" class=" x-form-text x-form-field" style="width: auto;">
									</div>
									<div class="x-form-clear-left">
									</div>
								</div>
								<!-- 사용자 종료-->
							</td>
						</tr>
						<tr>
							<td width='225px'>
								<!-- 예산구분 시작 -->
								<div tabindex="-1" class="x-form-item " >
									<label class="x-form-item-label" style="width: auto;" for="budget_type_code" >예산구분 :</label>
									<div style="padding-left: 80px;" class="x-form-element">
									<select name="budget_type_code" style="width : 123px" id="budget_type_code" type="text" class=" x-form-select x-form-field" >
										<option value="">전체</option>
										<c:forEach items="${BUDGET_TYPE_CODE}" var="data" varStatus="status">
										<option value="${data.COM_CODE}"><c:out value="${data.COM_CODE_NAME}"/></option>
										</c:forEach>
									</select>
									</div>
									<div class="x-form-clear-left">
									</div>
								</div>
								<!-- 예산구분 종료-->
							</td>
							<td width='225px'>
								<!-- 예산사용부서 시작 -->
								<div tabindex="-1" class="x-form-item " >
									<label class="x-form-item-label" style="width: auto;" for="budget_use_dept_name" >예산사용부서:</label>
									<div style="padding-left:94px;" class="x-form-element">
										<input type="text" name="budget_use_dept_name" id="budget_use_dept_name" autocomplete="off" class=" x-form-text x-form-field" style="width: auto;">
										<input type="hidden" name="budget_use_dept_code" id="budget_use_dept_code" autocomplete="off" class=" x-form-text x-form-field" style="width: auto;">
									</div>
									<div class="x-form-clear-left">
									</div>
								</div>
								<!-- 예산사용부서 종료-->
							</td>
						</tr>
						<tr>
							<td colspan='2'>
								<!-- 지출내용 시작 -->
								<div tabindex="-1" class="x-form-item " >
									<label class="x-form-item-label" style="width: auto;" for="pay_desc" >지출내용:</label>
									<div style="padding-left:80px;" class="x-form-element">
										<input type="text" name="pay_desc" id="pay_desc" autocomplete="off" class=" x-form-text x-form-field" style="width: 98%;">
									</div>
									<div class="x-form-clear-left">
									</div>
								</div>
								<!-- 지출내용 종료-->
							</td>
						</tr>
						<tr>
							<td width='225px'>
								<!-- 지출총금액 시작 -->
								<div tabindex="-1" class="x-form-item " >
									<label class="x-form-item-label" style="width: auto;" for="pay_total_amt" >지출총금액:</label>
									<div style="padding-left:80px;" class="x-form-element">
										<input type="text" name="pay_total_amt" id="pay_total_amt" autocomplete="off" class=" x-form-text x-form-field" style="width: auto; text-align:right;" readOnly="true">
									</div>
									<div class="x-form-clear-left">
									</div>
								</div>
								<!-- 지출총금액 종료-->
							</td>
							<td width='225px'>
								<!-- 지출총세액 시작 -->
								<div tabindex="-1" class="x-form-item " >
									<label class="x-form-item-label" style="width: auto;" for="pay_total_tax" >지출총세액:</label>
									<div style="padding-left:94px;" class="x-form-element">
										<input type="text" name="pay_total_tax" id="pay_total_tax" autocomplete="off" class=" x-form-text x-form-field" style="width: auto; text-align:right;" readOnly="true">
									</div>
									<div class="x-form-clear-left">
									</div>
								</div>
								<!-- 지출총세액 종료-->
							</td>
						</tr>
						<tr>
							<td colspan='2'>
								<!-- 비고 시작 -->
								<div tabindex="-1" class="x-form-item " >
									<div tabindex="-1" class="x-form-item " >
										<label class="x-form-item-label" style="width: auto;" for="note" >비고:</label>
										<div style="padding-left: 80px;" class="x-form-element">
											<textarea type="text" id="note" name="note" style="width:98%"></textarea>
										</div>
									</div>
								</div>
								<!-- 비고 종료-->
							</td>
						</tr>
						<tr>
							<td width='225px'>
								<!-- 최종변경자ID 시작 -->
								<div tabindex="-1" class="x-form-item " >
									<label class="x-form-item-label" style="width: auto;" for="final_mod_id" >최종변경자ID:</label>
									<div style="padding-left:80px;" class="x-form-element">
										<input type="text" name="final_mod_id" id="final_mod_id" autocomplete="off" class=" x-form-text x-form-field" style="width: auto;">
									</div>
									<div class="x-form-clear-left">
									</div>
								</div>
								<!-- 최종변경자ID 종료-->
							</td>
							<td width='225px'>
								<!-- 최종변경일시 시작  -->
								<div tabindex="-1" class="x-form-item " >
									<label class="x-form-item-label" style="width: auto;" for="final_mod_date" >최종변경일시:</label>
									<div style="padding-left:94px;" class="x-form-element">
										<input type="text" name="final_mod_date" id="final_mod_date" autocomplete="off" class=" x-form-text x-form-field" style="width: auto;">
									</div>
									<div class="x-form-clear-left">
									</div>
								</div>
								<!-- 최종변경일시 종료-->
							</td>
						</tr>
						</form>
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
				</div>
			</td>
			<!----------------- 구매기본정보 폼 끝 ----------------->
		</tr>
		<tr>
			<!----------------- EDIT_GRID_1st START ----------------->
			<td colspan='2'>
				<div id="render_edit_grid_1st"></div>
			</td>
			<!----------------- EDIT_GRID_1st END ----------------->
		</tr>
		<tr>
			<td colspan="2" align="center"  height="100%">
				<input type="button" id="saveBtn" name="saveBtn" value="등록" />
				<input type="button" id="updateBtn" name="updateBtn" value="수정" />
			</td>
		</tr>
	</table>
</body>
<%@ include file="/WEB-INF/web/jsp/sgis-bottom-inc.jsp" %>