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
<script type="text/javascript" src="/resource/common/js/grid/grid_1st.js"></script>
<script type="text/javascript" src="/resource/common/js/grid/grid_edit_1st.js"></script> 
<script type="text/javascript" src="/resource/common/js/grid/grid_edit_2nd.js"></script>
 


<script type="text/javascript">
var GlobalItemCode = "";
var GlobalItemName = "";
var GlobalPurInfoSEQ = "";
/**유무상 구분 combo box 생성 start **/
var PAY_FREE_CODE_COMBO = new Ext.form.ComboBox({    
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
					['유상', 'Y'],
					['무상', 'N']
				  ]
			})
});
//combo box render
Ext.util.Format.comboRenderer = function(PAY_FREE_CODE_COMBO){    
	return function(value){        
	var record = PAY_FREE_CODE_COMBO.findRecord(PAY_FREE_CODE_COMBO.valueField, value);        
	return record ? record.get(PAY_FREE_CODE_COMBO.displayField) : PAY_FREE_CODE_COMBO.valueNotFoundText;    
}}
/**유무상 구분 combo box 생성 end **/	
	
/***************************************************************************
 * 초기값 설정
 ***************************************************************************/
var	gridHeigth_1st	=	"405";
var	gridWidth_1st;
var	gridTitle_1st   =	"구매기본정보"; 
var	render_1st		=	"render_1st";
var pageSize_1st	=	15;
var limit_1st		=	pageSize_1st;
var start_1st		=	0;
var proxyUrl_1st	= 	"/pur/result_1st.sg";

var	gridHeigth_edit_1st	=	"150";
var	gridWidth_edit_1st  	;
var	gridTitle_edit_1st  =   "구매품목 정보"	; 
var	render_edit_1st		=	"render_edit_grid_1st";
var keyNm_edit_1st		= 	"TASK_REPORT_SEQ"; /* 요거는 확인이 필요함. */
var pageSize_edit_1st	=	15;
var limit_edit_1st		=	pageSize_edit_1st;
var start_edit_1st		=	0;
var proxyUrl_edit_1st	=	"/pur/pur_edit_grid_result_1st.sg";
var tbarHidden_edit_1st =   "";

var	gridHeigth_edit_2nd	=	"150";
var	gridWidth_edit_2nd  	;
var	gridTitle_edit_2nd  =   "구매사양정보"; 
var	render_edit_2nd		=	"render_edit_grid_2nd";
var keyNm_edit_2nd		= 	"TASK_REPORT_SEQ"; /* 요거는 확인이 필요함. */
var pageSize_edit_2nd	=	15;
var limit_edit_2nd		=	pageSize_edit_2nd;
var start_edit_2nd		=	0;
var proxyUrl_edit_2nd	=	"/pur/pur_edit_grid_result_2nd.sg";
var tbarHidden_edit_2nd =   "";



/***************************************************************************
 * Grid의 컬럼 설정 PUR_TYPE_NAME
 ***************************************************************************/
var userColumns_1st =  [
					{header: "구매ID",  			width: 100 ,sortable: true, dataIndex: 'PUR_ID', 	 		editor: new Ext.form.TextField({}) }
					,{header: "구매명",  			width: 100 ,sortable: true, dataIndex: 'PUR_NAME', 			editor: new Ext.form.TextField({}) }
					,{header: "구매구분코드", 		width: 80 ,sortable: true, dataIndex: 'PUR_TYPE_CODE', 	editor: new Ext.form.TextField({}) , hidden : true}
					,{header: "구매구분이름", 		width: 80 ,sortable: true, dataIndex: 'PUR_TYPE_NAME', 	editor: new Ext.form.TextField({}) }
					,{header: "업무구분코드", 		width: 80 ,sortable: true, dataIndex: 'ROLL_TYPE_CODE', 	editor: new Ext.form.TextField({}) , hidden : true}
					,{header: "구매담당자",		width: 80 ,sortable: true, dataIndex: 'PUR_EMP_NAME', 		editor: new Ext.form.TextField({}) , hidden : true}
					,{header: "구매담당자사번",	width: 80 ,sortable: true, dataIndex: 'PUR_EMP_NUM', 		editor: new Ext.form.TextField({}) , hidden : true}
					,{header: "지출결의번호",		width: 80 ,sortable: true, dataIndex: 'PAY_NO', 			editor: new Ext.form.TextField({}) , hidden : true}
					,{header: "구매총액",			width: 80 ,sortable: true, dataIndex: 'PUR_TOTAL_AMT', 	editor: new Ext.form.TextField({}) , hidden : true}
					,{header: "구매총세액",		width: 80 ,sortable: true, dataIndex: 'PUR_TOTAL_TAX', 	editor: new Ext.form.TextField({}) , hidden : true}
					,{header: "입고일자",			width: 80 ,sortable: true, dataIndex: 'IN_DATE', 			editor: new Ext.form.TextField({}) , hidden : true}
					,{header: "품의서번호",		width: 80 ,sortable: true, dataIndex: 'PUR_REPORT_NUM', 	editor: new Ext.form.TextField({}) , hidden : true}
					,{header: "검수필요여부",		width: 80 ,sortable: true, dataIndex: 'INSPECT_YN', 		editor: new Ext.form.TextField({}) , hidden : true}
					,{header: "검수일자",			width: 80 ,sortable: true, dataIndex: 'INSPECT_DATE', 		editor: new Ext.form.TextField({}) , hidden : true}
					,{header: "검수담당자사번",	width: 80 ,sortable: true, dataIndex: 'INSPECT_EMP_NUM', 	editor: new Ext.form.TextField({}) , hidden : true}
					,{header: "검수담당자이름",	width: 80 ,sortable: true, dataIndex: 'INSPECT_EMP_NAME', 	editor: new Ext.form.TextField({}) , hidden : true}
					,{header: "검수내용",			width: 80 ,sortable: true, dataIndex: 'INSPECT_DESC', 		editor: new Ext.form.TextField({}) , hidden : true}
					,{header: "사용일자",			width: 80 ,sortable: true, dataIndex: 'USE_DATE', 			editor: new Ext.form.TextField({}) , hidden : true}
					,{header: "사용자",			width: 80 ,sortable: true, dataIndex: 'USE_EMP_NUM', 		editor: new Ext.form.TextField({}) , hidden : true}
					,{header: "사용자사번",		width: 80 ,sortable: true, dataIndex: 'USE_EMP_NAME', 		editor: new Ext.form.TextField({}) , hidden : true}
					,{header: "비고",			width: 80 ,sortable: true, dataIndex: 'NOTE', 				editor: new Ext.form.TextField({}) , hidden : true}
					,{header: "진행상태",			width: 80 ,sortable: true, dataIndex: 'PROC_STATUS_CODE', 	editor: new Ext.form.TextField({}) , hidden : true}
					,{header: "업무구분이름",  	width: 80 ,sortable: true, dataIndex: 'ROLL_TYPE_NAME', 	editor: new Ext.form.TextField({}) }
					,{header: "구매일자",		 	width: 80 ,sortable: true, dataIndex: 'PUR_DATE', 			editor: new Ext.form.TextField({}) , hidden : true}
					,{header: "프로젝트ID",	 	width: 80 ,sortable: true, dataIndex: 'PJT_ID', 	 		editor: new Ext.form.TextField({}) , hidden : true}
					,{header: "프로젝트명",	 	width: 100 ,sortable: true, dataIndex: 'PJT_NAME', 			editor: new Ext.form.TextField({}) }
					,{header: "최종변경자ID",	 	width: 80 ,sortable: true, dataIndex: 'FINAL_MOD_ID', 	 	editor: new Ext.form.TextField({}) , hidden : true}
					,{header: "최종변경자이름",	 	width: 80 ,sortable: true, dataIndex: 'FINAL_MOD_NAME', 	 	editor: new Ext.form.TextField({}) , hidden : true}
					,{header: "최종변경일시",	 	width: 80 ,sortable: true, dataIndex: 'FINAL_MOD_DATE', 	editor: new Ext.form.TextField({}) , hidden : true}
				   ];
var userColumns_edit_1st =  [
					{header: "구매ID",  		sortable: true, dataIndex: 'PUR_ID', 	 	editor: new Ext.form.TextField({}) , hidden : true}
					,{header: "순번",  		sortable: true, dataIndex: 'PUR_INFO_SEQ',  editor: new Ext.form.TextField({}) , hidden : true}
					,{header: "거래처코드",  	sortable: true, dataIndex: 'CUSTOM_CODE',  	editor: new Ext.form.Label({})		, hidden : true}
					,{header: "거래처이름",  	sortable: true, dataIndex: 'CUSTOM_NAME',  	editor: new Ext.form.TextField({}), editable:false		,renderer:changeBLUE}
					,{header: "품목코드",  	sortable: true, dataIndex: 'ITEM_CODE',  	editor: new Ext.form.Label({}) 		, hidden : true}
					,{header: "품목이름",  	sortable: true, dataIndex: 'ITEM_NAME',  	editor: new Ext.form.TextField({}), editable:false ,renderer:changeBLUE}
					,{header: "규격",		sortable: true, dataIndex: 'STANDARD',  	editor: new Ext.form.TextField({}) }
					,{header: "수량",  	 	sortable: true, dataIndex: 'CNT',  			editor: new Ext.form.TextField({}) }
					,{header: "단위",  	 	sortable: true, dataIndex: 'UNIT',  		editor: new Ext.form.TextField({}) }
					,{header: "단가",  	 	sortable: true, dataIndex: 'UNIT_PRICE',  	editor: new Ext.form.Label({}) , editable:false ,renderer: "korMoney", align : 'right'}
					,{header: "금액",  	 	sortable: true, dataIndex: 'AMT',  			editor: new Ext.form.Label({}) , editable:false ,renderer: "korMoney", align : 'right'}
					,{header: "세액",  	 	sortable: true, dataIndex: 'TAX',  			editor: new Ext.form.Label({}) , editable:false ,renderer: "korMoney", align : 'right' , hidden : true}
					,{header: "유무상구분",  	sortable: true, dataIndex: 'PAY_FREE_CODE', editor: PAY_FREE_CODE_COMBO, renderer: Ext.util.Format.comboRenderer(PAY_FREE_CODE_COMBO)}
					,{header: "비고",  	 	sortable: true, dataIndex: 'NOTE',  		editor: new Ext.form.TextField({}) }
				   ];
var userColumns_edit_2nd =  [
					{header: "구매ID",  	 	sortable: true, dataIndex: 'PUR_ID', 	 		editor: new Ext.form.TextField({}) , hidden : true}
					,{header: "순번",  		sortable: true, dataIndex: 'PUR_INFO_SEQ',  	editor: new Ext.form.TextField({}) , hidden : true}
					,{header: "품목이름",  	sortable: true, dataIndex: 'ITEM_NAME',  		editor: new Ext.form.TextField({}) }
					,{header: "품목코드", 	sortable: true, dataIndex: 'ITEM_CODE',  		editor: new Ext.form.Label({}) , hidden : true}
					//,{header: "제원구분이름", 	sortable: true, dataIndex: 'SPEC_TYPE_NAME',	editor: new Ext.form.TextField({}) }
					//,{header: "제원구분코드", 	sortable: true, dataIndex: 'SPEC_TYPE_CODE',	editor: new Ext.form.TextField({}) }
					,{header: "제원설명",  	sortable: true, dataIndex: 'SPEC_INTRO',  		editor: new Ext.form.TextField({}) }
					,{header: "제원수량",  	sortable: true, dataIndex: 'SPEC_CNT',  		editor: new Ext.form.TextField({}) }
					,{header: "제원용량",  	sortable: true, dataIndex: 'SPEC_VOL',  		editor: new Ext.form.TextField({}) }
					,{header: "비고",  		sortable: true, dataIndex: 'NOTE',  			editor: new Ext.form.TextField({}) }
				   ];				   				   

/***************************************************************************
 * 그리드 결과매핑 
 ***************************************************************************/
var mappingColumns_1st = [
					  {name: 'FLAG' 		    , allowBlank: false}   // 상태 
					 ,{name: 'PUR_ID'			, allowBlank: false}	// 구매ID
					 ,{name: 'PUR_NAME'			, allowBlank: false} 	// 구매명  
					 ,{name: 'PUR_TYPE_CODE'	, allowBlank: false} 	// 구매구분코드  
					 ,{name: 'PUR_TYPE_NAME'	, allowBlank: false} 	// 구매구분이름
					 ,{name: 'ROLL_TYPE_CODE'	, allowBlank: false} 	// 업무구분코드
					 ,{name: 'ROLL_TYPE_NAME'	, allowBlank: false} 	// 업무구분이름
					 ,{name: 'PUR_EMP_NUM'		, allowBlank: false} 	// 구매담당자사번
					 ,{name: 'PUR_EMP_NAME'		, allowBlank: false} 	// 구매당당자이름
					 ,{name: 'PAY_NO'			, allowBlank: false} 	// 지출결의번호
					 ,{name: 'PUR_TOTAL_AMT'	, allowBlank: false} 	// 구매총액
					 ,{name: 'PUR_TOTAL_TAX'	, allowBlank: false} 	// 구매총세액
					 ,{name: 'IN_DATE'			, allowBlank: false} 	// 입고일자
					 ,{name: 'PUR_REPORT_NUM'	, allowBlank: false} 	// 품의서번호
					 ,{name: 'INSPECT_YN'		, allowBlank: false} 	// 검수필요여부
					 ,{name: 'INSPECT_DATE'		, allowBlank: false} 	// 검수일자
					 ,{name: 'INSPECT_EMP_NUM'	, allowBlank: false} 	// 검수담당자사번
					 ,{name: 'INSPECT_EMP_NAME'	, allowBlank: false} 	// 검수담당자이름
					 ,{name: 'INSPECT_DESC'		, allowBlank: false} 	// 검수담당자이름
					 ,{name: 'USE_DATE'			, allowBlank: false} 	// 사용일자
					 ,{name: 'USE_EMP_NUM'		, allowBlank: false} 	// 사용일자
					 ,{name: 'USE_EMP_NAME'		, allowBlank: false} 	// 사용일자
					 ,{name: 'NOTE'				, allowBlank: false} 	// 비고
					 ,{name: 'PROC_STATUS_CODE'	, allowBlank: false} 	// 진행상태
					 ,{name: 'PUR_DATE'			, allowBlank: false} 	// 구매일
					 ,{name: 'PJT_ID'			, allowBlank: false} 	// 프로젝트ID
					 ,{name: 'PJT_NAME' 		, allowBlank: false} 	// 프로젝트명   
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
					 //,{name: 'SPEC_TYPE_NAME' 		, allowBlank: false} 	//제원구분이름   
					 //,{name: 'SPEC_TYPE_CODE'  		, allowBlank: false} 	//제원구분코드 
					 ,{name: 'SPEC_INTRO' 		  	, allowBlank: false} 	//제원설명
					 ,{name: 'SPEC_CNT' 			, allowBlank: false} 	//제원수량  
					 ,{name: 'SPEC_VOL' 			, allowBlank: false} 	//제원용량
					 ,{name: 'NOTE'   				, allowBlank: false} 	//비고
    				 ];
 
 /***************************************************************************
 * 그리드 클래스 필수 입력값 정의
 ***************************************************************************/

//그리드_1st 클릭시 Event
function fnGridOnClick_1st(store, rowIndex){
	Ext.get('pur_type_code').set({ value: fnFixNull(store.getAt(rowIndex).data.PUR_TYPE_CODE)}, false);
	//구매일자
	Ext.get('pur_date').set({ value: fnFixNull(store.getAt(rowIndex).data.PUR_DATE)}, false);
	//구매ID
	var pur_id = fnFixNull(store.getAt(rowIndex).data.PUR_ID)
	Ext.get('pur_id').set({ value: pur_id}, false);
	//구매명
	Ext.get('pur_name').set({ value: fnFixNull(store.getAt(rowIndex).data.PUR_NAME)}, false);
	//업무구분코드
	Ext.get('roll_type_code').set({ value: fnFixNull(store.getAt(rowIndex).data.ROLL_TYPE_CODE)}, false);
	//구매담당자 이름,사번
	Ext.get('pur_emp_num').set({ value: fnFixNull(store.getAt(rowIndex).data.PUR_EMP_NUM)}, false);
	Ext.get('pur_emp_name').set({ value: fnFixNull(store.getAt(rowIndex).data.PUR_EMP_NAME)}, false);
	//프로젝트ID
	Ext.get('pjt_id').set({ value: fnFixNull(store.getAt(rowIndex).data.PJT_ID)}, false);
	//지출결의번호
	Ext.get('pay_no').set({ value: fnFixNull(store.getAt(rowIndex).data.PAY_NO)}, false);
	//구매총액
	Ext.get('pur_total_amt').set({ value: MoneyComma(fnFixNull(store.getAt(rowIndex).data.PUR_TOTAL_AMT))}, false);
	//구매총세액
	Ext.get('pur_total_tax').set({ value: MoneyComma(fnFixNull(store.getAt(rowIndex).data.PUR_TOTAL_TAX))}, false);
	//입고일자
	Ext.get('in_date').set({ value: fnFixNull(store.getAt(rowIndex).data.IN_DATE)}, false);
	//품의서번호
	Ext.get('pur_report_num').set({ value: fnFixNull(store.getAt(rowIndex).data.PUR_REPORT_NUM)}, false);
	//검수필요여부
	Ext.get('inspect_yn').set({ value: fnFixNull(store.getAt(rowIndex).data.INSPECT_YN)}, false);
	//검수일자
	Ext.get('inspect_date').set({ value: fnFixNull(store.getAt(rowIndex).data.INSPECT_DATE)}, false);
	//검수담당자
	Ext.get('inspect_emp_num').set({ value: fnFixNull(store.getAt(rowIndex).data.INSPECT_EMP_NUM)}, false);
	Ext.get('inspect_emp_name').set({ value: fnFixNull(store.getAt(rowIndex).data.INSPECT_EMP_NAME)}, false);
	//검수내용
	Ext.get('inspect_desc').set({ value: fnFixNull(store.getAt(rowIndex).data.INSPECT_DESC)}, false);
	//사용일자
	Ext.get('use_date').set({ value: fnFixNull(store.getAt(rowIndex).data.USE_DATE)}, false);
	//사용자
	Ext.get('use_emp_num').set({ value: fnFixNull(store.getAt(rowIndex).data.USE_EMP_NUM)}, false);
	Ext.get('use_emp_name').set({ value: fnFixNull(store.getAt(rowIndex).data.USE_EMP_NAME)}, false);
	//비고
	Ext.get('note').set({ value: fnFixNull(store.getAt(rowIndex).data.NOTE)}, false);
	//진행상태
	Ext.get('proc_status_code').set({ value: fnFixNull(store.getAt(rowIndex).data.PROC_STATUS_CODE)}, false);
	
	//최종 변경자ID
	Ext.get('final_mod_id').set({ value: fnFixNull(store.getAt(rowIndex).data.FINAL_MOD_ID)}, false);
	Ext.get('final_mod_name').set({ value: fnFixNull(store.getAt(rowIndex).data.FINAL_MOD_NAME)}, false);
	//최종변경일자
	Ext.get('final_mod_date').set({ value: fnFixNull(store.getAt(rowIndex).data.FINAL_MOD_DATE)}, false);
	
	
	//구매 품목 정보 가져오기
	fnSearchPurItem(pur_id);
	Ext.get('saveBtn').dom.disabled = true;
	Ext.get('updateBtn').dom.disabled = false;
	Ext.get('printBtn').dom.disabled  = false;
}

//에디트 그리드_1st row 클릭시 Event
function fnGridOnClick_edit_1st(store, rowIndex){
}
//에디트  그리드_2nd row 클릭시 Event
function fnGridOnClick_edit_2nd(store, rowIndex){
}  

//편집그리드의 Tbar를 숨길경우 'Y'로 선언
var tbarHidden_edit_1st = ''
var tbarHidden_edit_2nd = ''

//에디트 그리드1st 의 CELL을 수정하였을 경우 이벤트
function  fnEdit1stAfterCellEdit(obj){
	var editedRow = obj.row;
	var editedColumn = obj.column;
	var editedValue = obj.value;
	var fieldName = obj.field;
	
	// 해당 컬럼의 값이 변경 되었을 경우
	if( fieldName == 'UNIT_PRICE' || fieldName == 'CNT'){
		fnCalculatePurItemInfoAmt(fieldName);
	}
}

//금액이 변경되었을 경우 세액/지출총금액/지출총세액을 계산하여 설정
function fnCalculatePurItemInfoAmt(fieldName){
	var rowCnt = GridClass_edit_1st.store.getCount();  // Grid의 총갯수
	var purItemInfoTotalAmt = 0;		//총 금액
	var purItemInfoTotalTax = 0;		//총 세액
	
	if( rowCnt > 0){
		//row 숫자만큼 돌면서 수량*단가를 가져옴
		for(i = 0 ; i < rowCnt ; i++){
				
			var record = GridClass_edit_1st.store.getAt(i);
			var unit_price = parseInt(GridClass_edit_1st.store.data.items[i].data.UNIT_PRICE);
			var cnt = parseInt(GridClass_edit_1st.store.data.items[i].data.CNT);
			var amt = parseInt(unit_price * cnt);
			var tax = parseInt(amt * 0.1); 
		
			record.set('AMT', fnIsNaN(amt));			//금액
			record.set('TAX', fnIsNaN(tax));			//세액
			
			purItemInfoTotalAmt += fnIsNaN(parseInt(amt));   // 총 액
			purItemInfoTotalTax += fnIsNaN(parseInt(tax));   // 총 세액
	
		} // end for	
		
		// 수주총액
		Ext.get('pur_total_amt').set({value:MoneyComma(purItemInfoTotalAmt)}, false);
		// 할인총액
		Ext.get('pur_total_tax').set({value:MoneyComma(purItemInfoTotalTax)}, false);
	}
}

//에디트 그리드 2nd 의 CELL을 수정하였을 경우 이벤트 
function  fnEdit2ndAfterCellEdit(obj){
}

//구매 품목 에디트 그리드의 CELL을 클릭하였을 경우 이벤트
 function  fnEdit1stCellClickEvent(grid, rowIndex, columnIndex, e){
	//거래처 코드 팝업
	if(columnIndex == '3'){
		var temp= GridClass_edit_1st.store;
		var gridName = "GridClass_edit_1st";
		var grid_name = "grid_name=" + gridName;
		var grid_row = "grid_row=" + rowIndex;
		var grid_fieldName = "grid_fieldName=" + 'CUSTOM_CODE';
		var param = grid_name +'&'+ grid_row +'&'+ grid_fieldName;
		fnCustomPop(param);
	}else if(columnIndex == '5'){ //품목 코드 팝업
		var temp= GridClass_edit_1st.store;
		var gridName = "GridClass_edit_1st";
		var grid_name = "grid_name=" + gridName;
		var grid_row = "grid_row=" + rowIndex;
		var grid_fieldName = "grid_fieldName=" + 'ITEM_CODE';
		var param = grid_name +'&'+ grid_row +'&'+ grid_fieldName;
		fnItemPop(param);
	}
	
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
	/*
	if(columnIndex == '2'){
		var temp= GridClass_edit_2nd.store;
		var gridName = "GridClass_edit_2nd";
		var grid_name = "grid_name=" + gridName;
		var grid_row = "grid_row=" + rowIndex;
		var grid_fieldName = "grid_fieldName=" + 'ITEM_CODE';
		var param = grid_name +'&'+ grid_row +'&'+ grid_fieldName;
		fnItemPop(param);
	}
	*/
}


function fnEdit1stRowDeleteBb(){
}
function fnEdit2ndRowDeleteBb(){
}
function fnGridDeleteRow(record){
}
 
 
function goAction_edit_1st(){
}
function goAction_edit_2nd(){
}

//구매품목 에디트 그리드의 ADD NEW 버튼을 클릭시 수행할 함수
 function addNew_edit_1st(){
	/*
	if(Ext.get('pur_id').getValue() == ''){
		alert('신규 버튼을 클릭하여 구매 ID를 받아야합니다.')
	}else{
		var Plant = GridClass_edit_1st.grid.getStore().recordType;
	    var p = new Plant({ 
		        		    FLAG			: 'I'
							,PUR_ID			: Ext.get('pur_id').getValue()
							,UNIT_PRICE		: '0'
							,CNT			: '0'
	    				  }); 
	  	GridClass_edit_1st.grid.stopEditing();
		GridClass_edit_1st.store.insert(0, p);
		GridClass_edit_1st.grid.startEditing(0, 0);
	}
	*/
	//그리드 리셋.
	GridClass_edit_1st.store.removeAll();
	GridClass_edit_2nd.store.removeAll();
	var Plant = GridClass_edit_1st.grid.getStore().recordType;
    var p = new Plant({ 
	        		    FLAG			: 'I'
						//,PUR_ID			: Ext.get('pur_id').getValue()
						,UNIT_PRICE		: '0'
						,CNT			: '0'
    				  }); 
  	GridClass_edit_1st.grid.stopEditing();
	GridClass_edit_1st.store.insert(0, p);
	GridClass_edit_1st.grid.startEditing(0, 0);
}

//구매 스펙 에디트 그리드의 ADD NEW 버튼을 클릭시 수행할 함수
function addNew_edit_2nd(){
	var Plant = GridClass_edit_2nd.grid.getStore().recordType;
    var p = new Plant({ 
	        		    FLAG			: 'I'
						//,PUR_ID			: Ext.get('pur_id').getValue()
						,ITEM_CODE		: GlobalItemCode
						,ITEM_NAME		: GlobalItemName
						,PUR_INFO_SEQ	: GlobalPurInfoSEQ
    				  }); 
  	GridClass_edit_2nd.grid.stopEditing();
	GridClass_edit_2nd.store.insert(0, p);
	GridClass_edit_2nd.grid.startEditing(0, 0);
	GlobalItemCode = '';
	GlobalItemName = '';
	GlobalPurInfoSEQ = '';
}

function fnPagingValue_1st(){
}
function fnPagingValue_edit_1st(){
}
function fnPagingValue_edit_2nd(){
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

/**
 * 1. 사용자 컨펌창 
 * 2. 입력항목 clear
 * 3. 등록버튼 활성화, 수정,삭제 비활성화
 * 4. 구매ID를 자동으로 채번되며 읽기 전용으로 세팅
 * @param {Object} btn
 */
function fnNewPurchaseConfirm(btn){
	if(btn == 'yes'){
		/*
		Ext.Ajax.request({   
			url: "/pur/newPurchaseReg.sg"   
			,mothod : 'POST'
			,success: function(response){
				//입력창 clear
				document.regPurchaseForm.reset();
				Ext.get('pur_date').set({value : ""}, false);
				
				//구매ID채번 및 읽기 전용
				var input_pur_id = Ext.get('pur_id');
				input_pur_id.set({value : response.responseText}, false);
				input_pur_id.set({readOnly : true}, false);

			} 					
			,failure: function(response){
				alert('구매ID를 생성하는데 실패하였습니다.');
			}			   	    	
		});
		*/
   	}else{
		alert('취소하셨습니다.');
	} 
}

//구매 정보 신규 등록시 처리하는 함수
function fnPurchaseNewReg(){
	
	//변경된 구매품목 Grid의 record
	var records = GridClass_edit_1st.store.getModifiedRecords();
	
	//변경된 구매스팩 Grid의 record
	var recordsSpec = GridClass_edit_2nd.store.getModifiedRecords();
	
	//변경된 구매 품목 record의 자료를 json형식으로
    var purchaseItem = "[";
	for (var i = 0; i < records.length; i++) {
		purchaseItem += Ext.util.JSON.encode(records[i].data);				
		if (i < (records.length-1)) {
			purchaseItem += ",";
		}
	}
	purchaseItem += "]"
	
	//변경된 구매 스펙 record의 자료를 json형식으로
	var purchaseSpec = "[";
	for (var i = 0; i < recordsSpec.length; i++) {
		purchaseSpec += Ext.util.JSON.encode(recordsSpec[i].data);				
		if (i < (recordsSpec.length-1)) {
			purchaseSpec += ",";
		}
	}
	purchaseSpec += "]"
	
	//오른쪽 폼의 데이터 Validation 및 prams로 전송을 위해 처리; (이게 최선입니까? )
	/*
	var pur_id = Ext.get('pur_id').getValue();
	if(pur_id == '' || pur_id == null){ alert('구매ID가 필요합니다.');	return; }
	*/
	var pur_date = Ext.get('pur_date').getValue();
	if(pur_date == '' || pur_date == null){ alert('구매 일자는  필수항목 입니다.'); return;}
	
	var pur_type_code = Ext.get('pur_type_code').getValue();
	if(pur_type_code == '' || pur_type_code == null){ alert('구매 구분은  필수항목 입니다.'); return;}
	
	var roll_type_code = Ext.get('roll_type_code').getValue();
	if(roll_type_code == '' || roll_type_code == null){alert('업무 구분은  필수항목 입니다.');	return;}
	
	var pur_name = Ext.get('pur_name').getValue();
	if(pur_name == '' || pur_name == null){alert('구매명은  필수항목 입니다.');	return;}
	
	var pay_no = Ext.get('pay_no').getValue();
	var pjt_id = Ext.get('pjt_id').getValue();
	var pur_emp_num = Ext.get('pur_emp_num').getValue();
	if(pur_emp_num == '' || pur_emp_num == null){alert('구매담당자는  필수항목 입니다.');	return;}
	
	var pur_total_amt = Ext.get('pur_total_amt').getValue();
	var pur_total_tax = Ext.get('pur_total_tax').getValue();
	var in_date = Ext.get('in_date').getValue();
	var pur_report_num = Ext.get('pur_report_num').getValue();
	var inspect_yn = Ext.get('inspect_yn').getValue();
	var inspect_date = Ext.get('inspect_date').getValue();
	var inspect_emp_num = Ext.get('inspect_emp_num').getValue();
	var inspect_desc = Ext.get('inspect_desc').getValue();
	var use_date = Ext.get('use_date').getValue();
	var use_emp_num = Ext.get('use_emp_num').getValue();
	var note = Ext.get('note').getValue();
	var proc_status_code = Ext.get('proc_status_code').getValue();
	
	//데이터 전송
	Ext.Ajax.request({   
		url: "/pur/purRegProc.sg"   
		,success: function(response){						// 조회결과 성공시
					// 조회된 결과값, store명
					handleSuccess(response,GridClass_1st,'save');
		          }
		,failure: handleFailure   	// 조회결과 실패시  
		,params : {					// 조회조건을 DB로 전송하기위해서 조건값 설정
					limit			: limit_1st
				  , start			: start_1st      
  				  , purchaseItem	: purchaseItem 		//구매 품목 정보
  				  , purchaseSpec	: purchaseSpec		//구매 품목 스펙
				  //, pur_id			: pur_id
				  , pur_date 		: pur_date
				  , pur_type_code	: pur_type_code
				  , roll_type_code	: roll_type_code
				  , pur_name 		: pur_name
				  , pay_no			: pay_no
				  , pjt_id			: pjt_id
				  , pur_emp_num 	: pur_emp_num
				  , pur_total_amt	: pur_total_amt
				  , pur_total_tax	: pur_total_tax
				  , in_date 		: in_date
				  , pur_report_num 	: pur_report_num
				  , inspect_yn 		: inspect_yn
				  , inspect_date 	: inspect_date
				  , inspect_emp_num : inspect_emp_num
				  , inspect_desc 	: inspect_desc
				  , use_date		: use_date
				  , use_emp_num 	: use_emp_num
				  , note 			: note
				  , proc_status_code: proc_status_code
				  , req_type 		: ""
				  }  		
	});
	
	//초기화
	//fnInitValue();
	GridClass_edit_1st.store.removeAll();
	GridClass_edit_2nd.store.removeAll();
	document.regPurchaseForm.reset();
	Ext.get('saveBtn').dom.disabled = true;
	Ext.get('updateBtn').dom.disabled = false;
}

//구매 정보 수정 시 처리하는 함수
function fnPurchaseUpdate(){
	
	//변경된 구매품목 Grid의 record
	var records = GridClass_edit_1st.store.getModifiedRecords();
	
	//변경된 구매스팩 Grid의 record
	var recordsSpec = GridClass_edit_2nd.store.getModifiedRecords();
	
	//변경된 구매 품목 record의 자료를 json형식으로
    var purchaseItem = "[";
	for (var i = 0; i < records.length; i++) {
		purchaseItem += Ext.util.JSON.encode(records[i].data);				
		if (i < (records.length-1)) {
			purchaseItem += ",";
		}
	}
	purchaseItem += "]"
	
	//변경된 구매 스펙 record의 자료를 json형식으로
	var purchaseSpec = "[";
	for (var i = 0; i < recordsSpec.length; i++) {
		purchaseSpec += Ext.util.JSON.encode(recordsSpec[i].data);				
		if (i < (recordsSpec.length-1)) {
			purchaseSpec += ",";
		}
	}
	purchaseSpec += "]"
	
	//오른쪽 폼의 데이터 Validation 및 prams로 전송을 위해 처리; (이게 최선입니까? )
	var pur_id = Ext.get('pur_id').getValue();
	if(pur_id == '' || pur_id == null){ alert('구매ID가 필요합니다.');	return; }
	
	var pur_date = Ext.get('pur_date').getValue();
	if(pur_date == '' || pur_date == null){ alert('구매 일자는  필수항목 입니다.'); return;}
	
	var pur_type_code = Ext.get('pur_type_code').getValue();
	if(pur_type_code == '' || pur_type_code == null){ alert('구매 구분은  필수항목 입니다.'); return;}
	
	var roll_type_code = Ext.get('roll_type_code').getValue();
	if(roll_type_code == '' || roll_type_code == null){alert('업무 구분은  필수항목 입니다.');	return;}
	
	var pur_name = Ext.get('pur_name').getValue();
	if(pur_name == '' || pur_name == null){alert('구매명은  필수항목 입니다.');	return;}
	
	var pay_no = Ext.get('pay_no').getValue();
	var pjt_id = Ext.get('pjt_id').getValue();
	var pur_emp_num = Ext.get('pur_emp_num').getValue();
	if(pur_emp_num == '' || pur_emp_num == null){alert('구매담당자는  필수항목 입니다.');	return;}
	
	var pur_total_amt = Ext.get('pur_total_amt').getValue();
	var pur_total_tax = Ext.get('pur_total_tax').getValue();
	var in_date = Ext.get('in_date').getValue();
	var pur_report_num = Ext.get('pur_report_num').getValue();
	var inspect_yn = Ext.get('inspect_yn').getValue();
	var inspect_date = Ext.get('inspect_date').getValue();
	var inspect_emp_num = Ext.get('inspect_emp_num').getValue();
	var inspect_desc = Ext.get('inspect_desc').getValue();
	var use_date = Ext.get('use_date').getValue();
	var use_emp_num = Ext.get('use_emp_num').getValue();
	var note = Ext.get('note').getValue();
	var proc_status_code = Ext.get('proc_status_code').getValue();
	
	
	//데이터 전송
	Ext.Ajax.request({   
		url: "/pur/purRegProc.sg"   
		,success: function(response){						// 조회결과 성공시
					// 조회된 결과값, store명
					handleSuccess(response,GridClass_1st,'save');
		          
				  }
		,failure: handleFailure   	// 조회결과 실패시  
		,params : {					// 조회조건을 DB로 전송하기위해서 조건값 설정
					limit			: limit_1st
				  , start			: start_1st      
  				  , purchaseItem	: purchaseItem 		//구매 품목 정보
  				  , purchaseSpec	: purchaseSpec		//구매 품목 스펙
				  , pur_id			: pur_id
				  , pur_date 		: pur_date
				  , pur_type_code	: pur_type_code
				  , roll_type_code	: roll_type_code
				  , pur_name 		: pur_name
				  , pay_no			: pay_no
				  , pjt_id			: pjt_id
				  , pur_emp_num 	: pur_emp_num
				  , pur_total_amt	: pur_total_amt
				  , pur_total_tax	: pur_total_tax
				  , in_date 		: in_date
				  , pur_report_num 	: pur_report_num
				  , inspect_yn 		: inspect_yn
				  , inspect_date 	: inspect_date
				  , inspect_emp_num : inspect_emp_num
				  , inspect_desc 	: inspect_desc
				  , use_date		: use_date
				  , use_emp_num 	: use_emp_num
				  , note 			: note
				  , proc_status_code: proc_status_code
				  , req_type 		: "UPDATE"
				  }  		
	});
	
	//초기화
	//fnInitValue();
	GridClass_edit_1st.store.removeAll();
	GridClass_edit_2nd.store.removeAll();
	document.regPurchaseForm.reset();
	Ext.get('saveBtn').dom.disabled = true;
	Ext.get('updateBtn').dom.disabled = true;
	Ext.get('printBtn').dom.disabled  = true;
}

/***************************************************************************
 * 설  명 : 화면 초기값 설정
 ***************************************************************************/
function fnInitValue(){
	
	var dForm = document.regPurchaseForm;		// 상세 FORM	
	
	dForm.reset();							// 상세필드 초기화
	

	try{
		GridClass_edit_1st.store.commitChanges();	// 변경된 record를 commit
		GridClass_edit_1st.store.removeAll();		// store자료를 삭제
	}catch(e){
		
	}
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
	
	//신규 구매일자 
	var purdate = new Ext.form.DateField({
	    applyTo: 'pur_date',
		allowBlank: false,
		format:'Y-m-d'
	});
	
	//신규 입고일자
	var in_date = new Ext.form.DateField({
	    applyTo: 'in_date',
		allowBlank: false,
		format:'Y-m-d'
	});
	
	//신규 검수일자 
	var inspect_date = new Ext.form.DateField({
	    applyTo: 'inspect_date',
		allowBlank: false,
		format:'Y-m-d'
	});
	
	//신규 사용일자 
	var use_date = new Ext.form.DateField({
	    applyTo: 'use_date',
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
	 * 신규버튼을 클릭
	 */
	Ext.get('btn_newPurchaseReg').on('click', function(e){
		Ext.MessageBox.confirm('구매정보등록', '구매정보를 새로 등록하시겠습니까?', fnNewPurchaseConfirm);
		Ext.get('saveBtn').dom.disabled = false;
		Ext.get('updateBtn').dom.disabled = true;
		Ext.get('printBtn').dom.disabled  = true;
		document.regPurchaseForm.reset();
	});
	
	/**
	 * 구매 담당자 필드를 클릭
	 */
	Ext.get('btnSearchPurEmp').on('click', function(e){
		fnEmployeeSearchPop('pur_emp_name');
	});
	
	/**
	 * 프로젝트ID 필드를 클릭
	 */
	Ext.get('pjt_id').on('click', function(e){	
		var param = "";
		var multiSelectYn = "";
		var fieldName = "pjt_id";
		var pjt_type_code = "10";
		param = "multiSelectYn=" + multiSelectYn + "&fieldName=" + fieldName + "&src_pjt_type_code=" +  pjt_type_code;
		fnPjtPop(param);
	});
	
	/**
	 * 검수 담당자 필드를 클릭
	 */
	Ext.get('btnSearchInspectEmp').on('click', function(e){	
		fnEmployeeSearchPop('inspect_emp_name');
	});
	
	/**
	 * 사용자 필드를 클릭
	 */
	Ext.get('btnSearchUseEmp').on('click', function(e){	
		fnEmployeeSearchPop('use_emp_name');
	});
	
	/**
	 * 등록 버튼을 클릭
	 */
	Ext.get('saveBtn').on('click', function(e){	
		fnPurchaseNewReg();
	});
	
	/**
	 * 수정 버튼을 클릭
	 */
	Ext.get('updateBtn').on('click', function(e){	
		fnPurchaseUpdate();
	});
	
	/**
	 * 검색하기 버튼 클릭 searchBtn
	 */
	Ext.get('searchBtn').on('click', function(e){	
		GridClass_edit_1st.store.removeAll();
		fnSearch();
	});
	
	//품목구분 "제품"을 선택했을 경우 
	Ext.get('inspect_yn').on('change', function(e){	
		var val = Ext.get('inspect_yn').getValue()
		if(val == 'YES'){
			Ext.get('inspect_date').dom.disabled = false;
			Ext.get('inspect_emp_name').dom.disabled = false;
			Ext.get('inspect_desc').dom.disabled = false;
		}else if(val == 'NO'){
			Ext.get('inspect_date').dom.disabled = true;
			Ext.get('inspect_emp_name').dom.disabled = true;
			Ext.get('inspect_desc').dom.disabled = true;
		}
	});
	
	//출력버튼 -> 상세필드 초기화
	Ext.get('printBtn').on('click', function(e){
		fnOzReport();	   
	});	
	
	Ext.get('saveBtn').dom.disabled = true;
	Ext.get('updateBtn').dom.disabled = true;
	Ext.get('printBtn').dom.disabled  = true;
});


//품목사양  에디트 그리드의 CELL을 수정하였을 경우 이벤트
 function fnEdit1stAfterRowDeleteEvent(){
	var rowCnt = GridClass_edit_1st.store.getCount();  // Grid의 총갯수
	var totalATM = 0;
	if( rowCnt > 0){
		//row 숫자만큼 돌면서 수량*단가를 가져옴
		for(i = 0 ; i < rowCnt ; i++){
			var rowAMT = parseInt(GridClass_edit_1st.store.data.items[i].data.CNT) *  parseInt(GridClass_edit_1st.store.data.items[i].data.UNIT_PRICE);
			totalATM += parseInt(rowAMT);
		}
		//구매총액에 결과를 세팅
		Ext.get('pur_total_amt').set({value:totalATM});
		//구매 총세액은 구매총액의 10%
		Ext.get('pur_total_tax').set({value: parseInt( totalATM * 0.1 )});
	}
	if(rowCnt == 0){
		Ext.get('pur_total_amt').set({value:'0'});
		//구매 총세액은 구매총액의 10%
		Ext.get('pur_total_tax').set({value: '0'});
	}
}




/***************************************************************************
 * 팝업 관련 자바스크립트 함수 정리
 ***************************************************************************/
//구매품목 EDIT GRID에서 거래처 CELL을 클릭하였을 경우 거래처 검색 팝업
function fnCustomPop(param){
	var sURL      = "/com/custom/customPop.sg?"+param;
	var dlgWidth  = 420;
	var dlgHeight = 360;
	var winName   = "거래처검색";
	fnOpenPop(sURL, dlgWidth, dlgHeight, winName);
}

//EDIT GRID에서 품목 CELL을 클릭하였을 경우 아이템 검색 팝업
function fnItemPop(param){
	var sURL      = "/com/item/itemSearchPop.sg?"+param;
	var dlgWidth  = 420;
	var dlgHeight = 360;
	var winName   = "품목검색";
	fnOpenPop(sURL, dlgWidth, dlgHeight, winName);
}
//아이템 검색 팝업에서 선택한 그리드의 값을 받아 처리하는 함수
function fnItemSearchPopValue(records, gridName){
	var record = records[0].data;
	var parentsRecord;
	if(gridName == 'GridClass_edit_1st'){
		parentsRecord = GridClass_edit_1st.grid.selModel.getSelected();
		parentsRecord.set('ITEM_CODE', fnFixNull(record.ITEM_CODE));
		parentsRecord.set('ITEM_NAME', fnFixNull(record.ITEM_NAME));
		parentsRecord.set('STANDARD', fnFixNull(record.STANDARD));
		parentsRecord.set('UNIT_PRICE', fnFixNull(record.UNIT_PRICE_01));
	}else if(gridName == 'GridClass_edit_2nd'){
		parentsRecord = GridClass_edit_2nd.grid.selModel.getSelected();
		parentsRecord.set('ITEM_CODE', fnFixNull(record.ITEM_CODE));
		parentsRecord.set('ITEM_NAME', fnFixNull(record.ITEM_NAME));
	}
	
	
}
//오른쪽 신규 폼에서 구매담당자를 클릭하였을 경우 사원 검색 팝업
function fnEmployeeSearchPop(requestFieldName){
	var sURL      = "/com/employee/employeePop.sg?requestFieldName="+requestFieldName;
	var dlgWidth  = 410;
	var dlgHeight = 390;
	var winName   = "사원검색";
	fnOpenPop(sURL, dlgWidth, dlgHeight, winName);
}
//사원 검색 팝업에서 선택한 그리드의 값을 받아 처리하는 함수
function fnEmployeePopValue(records, fieldName){
	var record = records[0].data;
	if(fieldName == 'pur_emp_name'){
		Ext.get('pur_emp_num').set({value : fnFixNull(record.EMP_NUM)});
		Ext.get('pur_emp_name').set({value : fnFixNull(record.KOR_NAME)});
		Ext.get('pur_dept_code').set({value : fnFixNull(record.DEPT_CODE)});
		Ext.get('pur_dept_name').set({value : fnFixNull(record.DEPT_NAME)});
		Ext.get('pur_emp_name').set({readOnly : true}, false);
		Ext.get('pur_dept_name').set({readOnly : true}, false);
	}else if(fieldName == 'inspect_emp_name'){
		Ext.get('inspect_emp_num').set({value : fnFixNull(record.EMP_NUM)});
		Ext.get('inspect_emp_name').set({value : fnFixNull(record.KOR_NAME)});
		Ext.get('inspect_dept_code').set({value : fnFixNull(record.DEPT_CODE)});
		Ext.get('inspect_dept_name').set({value : fnFixNull(record.DEPT_NAME)});
		Ext.get('inspect_emp_name').set({readOnly : true}, false);
		Ext.get('inspect_dept_name').set({readOnly : true}, false);
	}else if(fieldName == 'use_emp_name'){
		Ext.get('use_emp_num').set({value : fnFixNull(record.EMP_NUM)});
		Ext.get('use_emp_name').set({value : fnFixNull(record.KOR_NAME)});
		Ext.get('use_dept_code').set({value : fnFixNull(record.DEPT_CODE)});
		Ext.get('use_dept_name').set({value : fnFixNull(record.DEPT_NAME)});
		Ext.get('use_emp_name').set({readOnly : true}, false);
		Ext.get('use_dept_name').set({readOnly : true}, false);
	}
	
	
}

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

function fnOzReport(){
	
	var pay_no		= Ext.get('pur_id').getValue()		  // 지출번호/구매번호  
 	var set_date	= Ext.get('pur_date').getValue()	  // 지출/구매일자  
 	var pjt_id   	= Ext.get('pjt_id').getValue()		  // 프로젝트ID   
 	
 	var param = '?param=PAY_NO='+pay_no+',PJT_ID='+pjt_id+',SETDATE='+set_date;
    var param = param+'&odi=BuyPlan&ozr=BuyPlan';
	var sURL      = "/ozr/ozReportPop.sg"+param;
	var dlgWidth  = 840;
	var dlgHeight = 630;
	var winName   = "BuyPlan";
	fnOpenPop(sURL, dlgWidth, dlgHeight, winName);
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
	<table border="0" width="1000" height="200">
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
			<td width='40%'>
				<div id="render_1st"></div>
			</td>
			<!----------------- GRID_1st END ----------------->
			<!----------------- 구매기본정보 폼 시작 ----------------->
			<td width='60%'  height='100%'>
				<div class=" x-panel x-form-label-left" style=" width: 100%;"><%-- 0em <- 1em으로 수정하면 상위 공백 --%>
					<!----------------- FROM Hearder Start	 ----------------->
					<div class="x-panel-tl">
						<div class="x-panel-tr">
							<div class="x-panel-tc">
								<div class="x-panel-header x-unselectable" style="-moz-user-select: none;">
									<span class="x-panel-header-text">구매내역 상세 정보</span><!----------------- 이름변경 ----------------->		
								</div>
							</div>
						</div>
					</div>
					<!----------------- FROM Hearder end	 ----------------->
					<div class="x-panel-bwrap">
						<div class="x-panel-ml">
							<div class="x-panel-mr">
								<div class="x-panel-mc" >
									<!-- 폼 시작 -->
									<form name='regPurchaseForm' id='regPurchaseForm' method='POST'>
						<!-- 신규버튼 시작-->
						<!-- 1_ROW Start -->
						<div class="x-column-inner" style="width: 100%; margin-top: 0.2em;">
							<div class=" x-panel x-column" style="width: 100%;">
								<div class="x-panel-bwrap" >
									<div class="x-panel-body x-panel-body-noheader" style="width: 94%;">
										<div tabindex="-1" class="x-form-item " >
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
																<button type="button" id="btn_newPurchaseReg" class=" x-btn-text">신규</button>
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
									</div>
								</div>
							</div>
						</div>
						<!-- 1_ROW End -->
						<!-- 신규버튼 끝-->
						
						<!-- 2_ROW Start -->
						<div class="x-column-inner" style="width: 100%; margin-top: 0.2em;">
							<div class=" x-panel x-column" style="width: 50%;">
								<div class="x-panel-bwrap" >
									<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
										<div tabindex="-1" class="x-form-item " >
											<label class="x-form-item-label" style="width: auto;" for="pur_type_code" >구매구분코드 :</label>
											<div style="padding-left: 80px;" class="x-form-element">
											<select name="pur_type_code" id="pur_type_code" " type="text" class=" x-form-select x-form-field" >
												<option value="">-----선택 하세요-----</option>
												<c:forEach items="${ITEM_TYPE_CODE}" var="data" varStatus="status">
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
							<div class=" x-panel x-column" style="width: 50%;">
								<div class="x-panel-bwrap" >
									<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
										<div tabindex="-1" class="x-form-item " >
											<label class="x-form-item-label" style="width: auto;" for="pur_date" >구매일자 :</label>
											<div style="padding-left:80px;" class="x-form-element">
												<input type="text" name="pur_date" id="pur_date" autocomplete="off" class=" x-form-text x-form-field" size='17'>
											</div>
											<div class="x-form-clear-left">
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
						<!-- 2_ROW End -->
						<!-- 3_ROW Start -->
						<div class="x-column-inner" style="width: 100%;">
							<div class=" x-panel x-column" style="width: 50%;">
								<div class="x-panel-bwrap" >
									<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
										<div tabindex="-1" class="x-form-item " >
											<label class="x-form-item-label" style="width: auto;" for="pur_id" >구매ID :</label>
											<div style="padding-left:80px;" class="x-form-element">
												<input type="text" name="pur_id" id="pur_id" autocomplete="off" class=" x-form-text x-form-field" style="width: auto;" disabled="true" >
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
											<label class="x-form-item-label" style="width: auto;" for="pur_name" >구매명 :</label>
											<div style="padding-left:80px;" class="x-form-element">
												<input type="text" name="pur_name" id="pur_name" autocomplete="off" class=" x-form-text x-form-field" style="width: auto;">
											</div>
											<div class="x-form-clear-left">
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
						<!-- 3_ROW End -->
						<!-- 4_ROW Start -->
						<div class="x-column-inner" style="width: 100%;">
							<div class=" x-panel x-column" style="width: 50%;">
								<div class="x-panel-bwrap" >
									<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
										<div tabindex="-1" class="x-form-item " >
											<label class="x-form-item-label" style="width: auto;" for="roll_type_code" >업무구분코드 :</label>
											<div style="padding-left: 80px;" class="x-form-element">
											<select name="roll_type_code" id="roll_type_code" " type="text" class=" x-form-select x-form-field" >
												<option value="">-----선택 하세요-----</option>
												<c:forEach items="${ROLL_TYPE_CODE}" var="data" varStatus="status">
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
							<div class=" x-panel x-column" style="width: 50%;" >
								<div class="x-panel-bwrap" >
									<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
										<div tabindex="-1" class="x-form-item " >
											<label class="x-form-item-label" style="width: auto;" for="pur_emp_name" >구매담당자:</label>
											<div style="padding-left: 80px;" class="x-form-element">
												<table style="width: 165px;" cellspacing="0" class="x-btn  x-btn-noicon">
													<tr>
														<td>
															<input type="hidden" name="pur_emp_num" id="pur_emp_num" size="6" autocomplete="off" class=" x-form-text x-form-field" style="width: auto;"/>
															<input type="text" name="pur_emp_name" id="pur_emp_name" size="8" autocomplete="off" class=" x-form-text x-form-field" style="width: 40px"/>
															<input type="hidden" name="pur_dept_code" id="pur_dept_code" size="6" autocomplete="off" class=" x-form-text x-form-field" style="width: auto;"/>
															<input type="text" name="pur_dept_name" id="pur_dept_name" size="13" autocomplete="off" class=" x-form-text x-form-field" style="width: 50px"/>
														</td>
														<td>
															<%-- Button Start--%>
															<table cellspacing="0" class="x-btn  x-btn-noicon" style="width: 20px;" align="left">
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
																				<button type="button" id="btnSearchPurEmp" class=" x-btn-text">검색</button>
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
						</div>
						<!-- 4_ROW End -->
						<!-- 5_ROW Start -->
						<div class="x-column-inner" style="width: 100%;">
							<div class=" x-panel x-column" style="width: 50%;">
								<div class="x-panel-bwrap" >
									<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
										<div tabindex="-1" class="x-form-item " >
											<label class="x-form-item-label" style="width: auto;" for="pjt_id" >프로젝트ID :</label>
											<div style="padding-left:80px;" class="x-form-element">
												<input type="text" name="pjt_id" id="pjt_id" autocomplete="off" class=" x-form-text x-form-field" style="width: auto;">
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
											<label class="x-form-item-label" style="width: auto;" for="pay_no" >지출결의번호:</label>
											<div style="padding-left:80px;" class="x-form-element">
												<input type="text" name="pay_no" id="pay_no" autocomplete="off" class=" x-form-text x-form-field" style="width: auto;">
											</div>
											<div class="x-form-clear-left">
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
						<!-- 5_ROW End -->
						<!-- 6_ROW Start -->
						<div class="x-column-inner" style="width: 100%;">
							<div class=" x-panel x-column" style="width: 50%;">
								<div class="x-panel-bwrap" >
									<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
										<div tabindex="-1" class="x-form-item " >
											<label class="x-form-item-label" style="width: auto;" for="pur_total_amt" >구매총액:</label>
											<div style="padding-left:80px;" class="x-form-element">
												<input type="text" name="pur_total_amt" id="pur_total_amt" autocomplete="off" class=" x-form-text x-form-field" style="width: auto;" readOnly='true'>
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
											<label class="x-form-item-label" style="width: auto;" for="pur_total_tax" >구매총세액:</label>
											<div style="padding-left:80px;" class="x-form-element">
												<input type="text" name="pur_total_tax" id="pur_total_tax" autocomplete="off" class=" x-form-text x-form-field" style="width: auto;" readOnly='true'>
											</div>
											<div class="x-form-clear-left">
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
						<!-- 6_ROW End -->
						<!-- 7_ROW Start -->
						<div class="x-column-inner" style="width: 100%;">
							<div class=" x-panel x-column" style="width: 50%;">
								<div class="x-panel-bwrap" >
									<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
										<div tabindex="-1" class="x-form-item " >
											<label class="x-form-item-label" style="width: auto;" for="in_date" >입고일자:</label>
											<div style="padding-left:80px;" class="x-form-element">
												<input type="text" name="in_date" id="in_date" autocomplete="off" class=" x-form-text x-form-field" size='17'>
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
											<label class="x-form-item-label" style="width: auto;" for="pur_report_num" >품의서번호:</label>
											<div style="padding-left:80px;" class="x-form-element">
												<input type="text" name="pur_report_num" id="pur_report_num" autocomplete="off" class=" x-form-text x-form-field" style="width: auto;">
											</div>
											<div class="x-form-clear-left">
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
						<!-- 7_ROW End -->
						<!-- 8_ROW Start -->
						<div class="x-column-inner" style="width: 100%;">
							<div class=" x-panel x-column" style="width: 50%;">
								<div class="x-panel-bwrap" >
									<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
										<div tabindex="-1" class="x-form-item " >
											<label class="x-form-item-label" style="width: auto;" for="inspect_yn" >검수필요여부 :</label>
											<div style="padding-left: 80px;" class="x-form-element">
												<select name="inspect_yn" id="inspect_yn" " type="text" class=" x-form-select x-form-field" >
													<option value="">-----선택 하세요-----</option>
													<option value="YES">필요</option>
													<option value="NO">불필요</option>
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
											<label class="x-form-item-label" style="width: auto;" for="inspect_date" >검수일자:</label>
											<div style="padding-left:80px;" class="x-form-element">
												<input type="text" name="inspect_date" id="inspect_date" autocomplete="off" class=" x-form-text x-form-field" size='17'>
											</div>
											<div class="x-form-clear-left">
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
						<!-- 8_ROW End -->
						<!-- 9_ROW Start -->
						<div class="x-column-inner" style="width: 100%;">
							<div class=" x-panel x-column" style="width: 50%;">
								<div class="x-panel-bwrap" >
									<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
										<div tabindex="-1" class="x-form-item " >
											<label class="x-form-item-label" style="width: auto;" for="inspect_emp_name" >검수담당자:</label>
											<div style="padding-left: 80px;" class="x-form-element">
												<table style="width: 165px;" cellspacing="0" class="x-btn  x-btn-noicon">
													<tr>
														<td>
															<input type="hidden" name="inspect_emp_num" id="inspect_emp_num" autocomplete="off" class=" x-form-text x-form-field" style="width: auto;">
															<input type="text" name="inspect_emp_name" id="inspect_emp_name" autocomplete="off" class=" x-form-text x-form-field" style="width: 40px">
															<input type="hidden" name="inspect_dept_code" id="inspect_dept_code" autocomplete="off" class=" x-form-text x-form-field" style="width: auto;">
															<input type="text" name="inspect_dept_name" id="inspect_dept_name" autocomplete="off" class=" x-form-text x-form-field" style="width: 50px">
														</td>
														<td>
															<%-- Button Start--%>
															<table cellspacing="0" class="x-btn  x-btn-noicon" style="width: 20px;" align="left">
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
																				<button type="button" id="btnSearchInspectEmp" class=" x-btn-text">검색</button>
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
											<label class="x-form-item-label" style="width: auto;" for="inspect_desc" >검수내용:</label>
											<div style="padding-left:80px;" class="x-form-element">
												<input type="text" name="inspect_desc" id="inspect_desc" autocomplete="off" class=" x-form-text x-form-field" style="width: auto;">
											</div>
											<div class="x-form-clear-left">
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
						<!-- 9_ROW End -->
						<!-- 10_ROW Start -->
						<div class="x-column-inner" style="width: 100%;">
							<div class=" x-panel x-column" style="width: 50%;">
								<div class="x-panel-bwrap" >
									<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
										<div tabindex="-1" class="x-form-item " >
											<label class="x-form-item-label" style="width: auto;" for="use_date" >사용일자:</label>
											<div style="padding-left:80px;" class="x-form-element">
												<input type="text" name="use_date" id="use_date" autocomplete="off" class=" x-form-text x-form-field" size='17'>
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
											<label class="x-form-item-label" style="width: auto;" for="use_emp_name" >사용자:</label>
											<div style="padding-left: 80px;" class="x-form-element">
												<table style="width: 165px;" cellspacing="0" class="x-btn  x-btn-noicon">
													<tr>
														<td>
															<input type="hidden" name="use_emp_num" id="use_emp_num" autocomplete="off" class=" x-form-text x-form-field" style="width: auto;">
															<input type="text" name="use_emp_name" id="use_emp_name" autocomplete="off" class=" x-form-text x-form-field" style="width: 40px">
															<input type="hidden" name="use_dept_code" id="use_dept_code" autocomplete="off" class=" x-form-text x-form-field" style="width: auto;">
															<input type="text" name="use_dept_name" id="use_dept_name" autocomplete="off" class=" x-form-text x-form-field" style="width: 50px">
														</td>
														<td>
															<%-- Button Start--%>
															<table cellspacing="0" class="x-btn  x-btn-noicon" style="width: 20px;" align="left">
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
																				<button type="button" id="btnSearchUseEmp" class=" x-btn-text">검색</button>
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
						</div>
						<!-- 10_ROW End -->
						<!-- 11_ROW Start -->
						<div class="x-column-inner" style="width: 100%;">
							<div class=" x-panel x-column" style="width: 100%;">
								<div class="x-panel-bwrap" >
									<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
										<div tabindex="-1" class="x-form-item " >
											<label class="x-form-item-label" style="width: auto;" for="note" >비고:</label>
											<div style="padding-left: 80px;" class="x-form-element">
												<textarea type="text" id="note" name="note" style="width:95%"></textarea>
											</div>
											<div class="x-form-clear-left">
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
						<!-- 11_ROW End -->
						<!-- 12_ROW Start -->
						<div class="x-column-inner" style="width: 100%;">
							<div class=" x-panel x-column" style="width: 50%;">
								<div class="x-panel-bwrap" >
									<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
										<div tabindex="-1" class="x-form-item " >
											<label class="x-form-item-label" style="width: auto;" for="proc_status_code" >진행상태 :</label>
											<div style="padding-left: 80px;" class="x-form-element">
												<select name="proc_status_code" id="proc_status_code" " type="text" class=" x-form-select x-form-field" >
													<option value="">-----선택 하세요-----</option>
													<c:forEach items="${PUR_STATUS_CODE}" var="data" varStatus="status">
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
						</div>
						<!-- 12_ROW End -->
						<!-- 13_ROW Start -->
						<div class="x-column-inner" style="width: 100%;">
							<div class=" x-panel x-column" style="width: 50%;">
								<div class="x-panel-bwrap" >
									<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
										<div tabindex="-1" class="x-form-item " >
											<label class="x-form-item-label" style="width: auto;" for="final_mod_id" >최종변경자이름:</label>
											<div style="padding-left:80px;" class="x-form-element">
												<input type="hidden" name="final_mod_id" id="final_mod_id" autocomplete="off" class=" x-form-text x-form-field" style="width: auto;" disabled="true">
												<input type="text" name="final_mod_name" id="final_mod_name" autocomplete="off" class=" x-form-text x-form-field" style="width: auto;" disabled="true">
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
											<label class="x-form-item-label" style="width: auto;" for="final_mod_date" >최종변경일시:</label>
											<div style="padding-left:80px;" class="x-form-element">
												<input type="text" name="final_mod_date" id="final_mod_date" autocomplete="off" class=" x-form-text x-form-field" style="width: auto;">
											</div>
											<div class="x-form-clear-left">
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
						<!-- 13_ROW End -->
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
			<!----------------- GRID_3rd START ----------------->
			<td colspan='2'>
				<div id="render_edit_grid_2nd"></div>
			</td>
			<!----------------- GRID_3rd END ----------------->
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
											<button type="button" id="printBtn" name="printBtn" class=" x-btn-text">REPORT</button>
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