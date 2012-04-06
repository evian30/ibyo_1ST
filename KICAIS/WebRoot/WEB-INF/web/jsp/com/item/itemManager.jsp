<%--
  Class Name  : itemList.jsp
  Description : 품목정보관리
  Modification Information
 
      수정일              수정자                 수정내용
  -------      --------    ---------------------------
  2011. 2. 8.  고기범              최초 생성
  2011. 4. 4.  고기범 	      공통 js 및 EditGrid 적용
  
  author   : 고기범
  since    : 2011. 2. 8.
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
<script type="text/javascript" src="/resource/common/js/grid/grid_edit_2nd.js"></script>
<script type="text/javascript" src="/resource/common/js/grid/grid_edit_3rd.js"></script> 
<script type="text/javascript">
/***************************************************************************
 * 설  명 : 그리드 설정정보 (품목정보)
***************************************************************************/
var	gridHeigth_1st	= 359;
var	gridWidth_1st  	= 500;
var	gridTitle_1st  	= "품목정보";
var	render_1st		= "item_grid_1st";
var pageSize_1st	= 12;
var limit_1st		= pageSize_1st;
var start_1st		= 0;
var proxyUrl_1st	= "/com/item/result_1st.sg";

// 그리드 필드
var	userColumns_1st	= [ 
						 {header: "상태",		width: 100, sortable: true, dataIndex: 'FLAG', 			    editor: new Ext.form.TextField({}) , hidden : true} 
					    ,{header: "품목구분",		width: 25,  sortable: true, dataIndex: 'ITEM_TYPE', 		editor: new Ext.form.TextField({}) }
						,{header: "품목코드", 	width: 60, 	sortable: true, dataIndex: 'ITEM_CODE', 		editor: new Ext.form.TextField({}) }       
						,{header: "품목구분코드",	width: 60,  sortable: true, dataIndex: 'ITEM_TYPE_CODE', 	editor: new Ext.form.TextField({}) , hidden : true}                                                    
						,{header: "품목명", 		width: 80, 	sortable: true, dataIndex: 'ITEM_NAME', 		editor: new Ext.form.TextField({}) }                  
						,{header: "품목유형", 	width: 25,  sortable: true, dataIndex: 'ITEM_PATTERN',		editor: new Ext.form.TextField({}) }
						,{header: "품목유형코드",	width: 60,  sortable: true, dataIndex: 'ITEM_PATTERN_CODE',	editor: new Ext.form.TextField({}) , hidden : true}
						,{header: "규격", 		width: 50,  sortable: true, dataIndex: 'STANDARD', 			editor: new Ext.form.TextField({}) , hidden : true}
						,{header: "단위", 		width: 20,  sortable: true, dataIndex: 'UNIT', 				editor: new Ext.form.TextField({}) }
						,{header: "제원", 		width: 50,  sortable: true, dataIndex: 'SPEC', 				editor: new Ext.form.TextField({}) , hidden : true}   
						,{header: "단가1", 		width: 50,  sortable: true, dataIndex: 'UNIT_PRICE_01', 	editor: new Ext.form.TextField({}) , hidden : true}  
						,{header: "단가2", 		width: 100, sortable: true, dataIndex: 'UNIT_PRICE_02', 	editor: new Ext.form.TextField({}) , hidden : true}  
						,{header: "단가3", 		width: 50,  sortable: true, dataIndex: 'UNIT_PRICE_03', 	editor: new Ext.form.TextField({}) , hidden : true}
						,{header: "단가4", 		width: 50,  sortable: true, dataIndex: 'UNIT_PRICE_04', 	editor: new Ext.form.TextField({}) , hidden : true}
						,{header: "단가5", 		width: 50,  sortable: true, dataIndex: 'UNIT_PRICE_05', 	editor: new Ext.form.TextField({}) , hidden : true}
						,{header: "출시일", 		width: 50,  sortable: true, dataIndex: 'RELEASE_DATE', 		editor: new Ext.form.TextField({}) , hidden : true}
						,{header: "버전", 		width: 50,  sortable: true, dataIndex: 'ITEM_VERSION', 		editor: new Ext.form.TextField({}) , hidden : true}
						,{header: "품목소개", 	width: 50,  sortable: true, dataIndex: 'ITEM_INTRO', 		editor: new Ext.form.TextField({}) , hidden : true}
						,{header: "품목기능", 	width: 50,  sortable: true, dataIndex: 'ITEM_FUNCTION', 	editor: new Ext.form.TextField({}) , hidden : true}
						,{header: "최종변경자ID",	width: 50,  sortable: true, dataIndex: 'FINAL_MOD_ID', 		editor: new Ext.form.TextField({}) , hidden : true}
						,{header: "최종변경일시",	width: 50,  sortable: true, dataIndex: 'FINAL_MOD_DATE',	editor: new Ext.form.TextField({}) , hidden : true}
					  ];

// 그리드 맵핑
var	mappingColumns_1st	= [  
							   {name: 'FLAG' 		      ,allowBlank: false}  // 상태
							 , {name: 'ITEM_CODE' 		  ,allowBlank: false}  // 품목코드    
							 , {name: 'ITEM_TYPE_CODE' 	  ,allowBlank: false}  // 품목구분코드
							 , {name: 'ITEM_TYPE' 		  ,allowBlank: false}  // 품목구분
							 , {name: 'ITEM_NAME' 		  ,allowBlank: false}  // 품목명      
							 , {name: 'STANDARD' 		  ,allowBlank: false}  // 규격        
							 , {name: 'UNIT' 			  ,allowBlank: false}  // 단위        
							 , {name: 'SPEC' 			  ,allowBlank: false}  // 제원        
							 , {name: 'UNIT_PRICE_01' 	  ,allowBlank: false}  // 단가1       
							 , {name: 'UNIT_PRICE_02' 	  ,allowBlank: false}  // 단가2       
							 , {name: 'UNIT_PRICE_03' 	  ,allowBlank: false}  // 단가3       
							 , {name: 'UNIT_PRICE_04' 	  ,allowBlank: false}  // 단가4       
							 , {name: 'UNIT_PRICE_05' 	  ,allowBlank: false}  // 단가5       
							 , {name: 'RELEASE_DATE'   	  ,allowBlank: false}  // 출시일      
							 , {name: 'ITEM_VERSION' 	  ,allowBlank: false}  // 버전        
							 , {name: 'ITEM_PATTERN' 	  ,allowBlank: false}  // 품목유형
							 , {name: 'ITEM_PATTERN_CODE' ,allowBlank: false}  // 품목유형코드
							 , {name: 'ITEM_INTRO' 		  ,allowBlank: false}  // 품목소개    
							 , {name: 'ITEM_FUNCTION' 	  ,allowBlank: false}  // 품목기능    
							 , {name: 'FINAL_MOD_ID' 	  ,allowBlank: false}  // 최종변경자ID
							 , {name: 'FINAL_MOD_DATE' 	  ,allowBlank: false}  // 최종변경일시
	    				 ]; 

// 페이지 설정
function fnPagingValue_1st(){
	try{
		GridClass_1st.store.setBaseParam('start'				 ,start_1st);
	    GridClass_1st.store.setBaseParam('limit'				 ,limit_1st);
	    GridClass_1st.store.setBaseParam('src_item_code'		 ,Ext.get('src_item_code').getValue());
	    GridClass_1st.store.setBaseParam('src_item_name'		 ,Ext.get('src_item_name').getValue());
	    GridClass_1st.store.setBaseParam('src_item_type_code'	 ,Ext.get('src_item_type_code').getValue());
	    GridClass_1st.store.setBaseParam('src_item_pattern_code' ,Ext.get('src_item_pattern_code').getValue());
	}catch(e){

	}
}

// 그리드 클릭
function fnGridOnClick_1st(store, rowIndex){ 
	var form = document.detailForm;
 
	var flag 			= fnFixNull(store.getAt(rowIndex).data.FLAG);			   // 상태
	var itemCode 		= fnFixNull(store.getAt(rowIndex).data.ITEM_CODE);         // 품목코드     
	var itemTypeCode    = fnFixNull(store.getAt(rowIndex).data.ITEM_TYPE_CODE);    // 품목구분코드
	var itemName        = fnFixNull(store.getAt(rowIndex).data.ITEM_NAME);         // 품목명      
	var standard        = fnFixNull(store.getAt(rowIndex).data.STANDARD);          // 규격        
	var unit            = fnFixNull(store.getAt(rowIndex).data.UNIT);              // 단위        
	var spec            = fnFixNull(store.getAt(rowIndex).data.SPEC);              // 제원        
	var unitPrice01     = fnFixNull(store.getAt(rowIndex).data.UNIT_PRICE_01);     // 단가1       
	var unitPrice02     = fnFixNull(store.getAt(rowIndex).data.UNIT_PRICE_02);     // 단가2       
	var unitPrice03     = fnFixNull(store.getAt(rowIndex).data.UNIT_PRICE_03);     // 단가3       
	var unitPrice04     = fnFixNull(store.getAt(rowIndex).data.UNIT_PRICE_04);     // 단가4       
	var unitPrice05     = fnFixNull(store.getAt(rowIndex).data.UNIT_PRICE_05);     // 단가5       
	var releaseDate     = fnFixNull(store.getAt(rowIndex).data.RELEASE_DATE);      // 출시일      
	var itemVersion     = fnFixNull(store.getAt(rowIndex).data.ITEM_VERSION);      // 버전        
	var itemPatternCode = fnFixNull(store.getAt(rowIndex).data.ITEM_PATTERN_CODE); // 품목유형코드
	var itemIntro       = fnFixNull(store.getAt(rowIndex).data.ITEM_INTRO);        // 품목소개    
	var itemFunction    = fnFixNull(store.getAt(rowIndex).data.ITEM_FUNCTION);     // 품목기능    
				
	form.flag.value 			 = flag;			 // 상태
	form.item_code.value 	 	 = itemCode; 		 // 품목코드     
	form.item_type_code.value 	 = itemTypeCode;     // 품목구분코드
	form.item_name.value 		 = itemName;         // 품목명      
	form.standard.value 		 = standard;         // 규격        
	form.unit.value 			 = unit;             // 단위        
	form.spec.value 			 = spec;             // 제원        
	form.unit_price_01.value 	 = MoneyComma(unitPrice01);     // 단가1       
	form.unit_price_02.value 	 = MoneyComma(unitPrice02);     // 단가2       
	form.unit_price_03.value 	 = MoneyComma(unitPrice03);     // 단가3       
	form.unit_price_04.value 	 = MoneyComma(unitPrice04);     // 단가4       
	form.unit_price_05.value 	 = MoneyComma(unitPrice05);     // 단가5       
	form.release_date.value 	 = releaseDate;      // 출시일      
	form.item_version.value 	 = itemVersion;      // 버전        
	form.item_pattern_code.value = itemPatternCode;  // 품목유형코드
	form.item_intro.value 		 = itemIntro;        // 품목소개    
	form.item_function.value 	 = itemFunction;     // 품목기능   
	
	fnShowEditGrid(itemTypeCode);		// 편집가능 그리드 
	Ext.get('saveBtn').dom.disabled    = true;
	Ext.get('updateBtn').dom.disabled  = false;
	Ext.get('item_type_code').dom.disabled  = true;
	
	fnSearchHw(itemCode,itemTypeCode);  // 하드웨어정보 조회
	fnSearchSw(itemCode,itemTypeCode);  // 소프트웨어정보 조회
	fnSearchDev(itemCode,itemTypeCode); // 제품개발담당자정보 조회

}	

// 하드웨어정보 조회
function fnSearchHw(itemCode,itemTypeCode){
	
	Ext.Ajax.request({
		url: "/com/item/result_edit_1st.sg" 
		,success: function(response){						// 조회결과 성공시
					// 조회된 결과값, store명
					handleSuccess(response,GridClass_edit_1st);
		          }
		,failure: handleFailure 
		,params : {
				   // 페이지 		
					 limit			: limit_edit_1st
				   , start			: start_edit_1st
				   // 키 value
				   , item_code		: itemCode
				   , item_type_code	: itemTypeCode
				  }				
	}); // end Ext.Ajax.request   
}

// 소프트웨어정보 조회
function fnSearchSw(itemCode,itemTypeCode){
	
	Ext.Ajax.request({
		url: "/com/item/result_edit_2nd.sg" 
		,success: function(response){						// 조회결과 성공시
					// 조회된 결과값, store명
					handleSuccess(response,GridClass_edit_2nd);
		          }
		,failure: handleFailure 
		,params : {
				   // 페이지 		
					 limit			: limit_edit_2nd
				   , start			: start_edit_2nd
				   // 키 value
				   , item_code		: itemCode
				   , item_type_code	: itemTypeCode
				  }				
	}); // end Ext.Ajax.request   
}

// 제품개발담당자정보 조회
function fnSearchDev(itemCode,itemTypeCode){
	
	Ext.Ajax.request({
		url: "/com/item/result_edit_3rd.sg" 
		,success: function(response){						// 조회결과 성공시
					// 조회된 결과값, store명
					handleSuccess(response,GridClass_edit_3rd);
		          }
		,failure: handleFailure 
		,params : {
				   // 페이지 		
					 limit			: limit_edit_3rd
				   , start			: start_edit_3rd
				   // 키 value
				   , item_code		: itemCode
				   , item_type_code	: itemTypeCode
				  }				
	}); // end Ext.Ajax.request   
}

/***************************************************************************
 * 설  명 : 편집그리드 설정 (하드웨어정보 )
***************************************************************************/
var	gridHeigth_edit_1st	= 200;
var	gridWidth_edit_1st  = 400	;
var	gridTitle_edit_1st  = "지원 가능한 하드웨어 정보"	; 
var	render_edit_1st		= "hw_grid";
var keyNm_edit_1st		= "SPEC_HW_SEQ";
var pageSize_edit_1st	= 4;
var limit_edit_1st		= pageSize_edit_1st;
var start_edit_1st		= 0;
var proxyUrl_edit_1st	= "/com/item/result_edit_1st.sg";
var gridRowDeleteYn	    = "";

// 행추가
function addNew_edit_1st(){
	var Plant = GridClass_edit_1st.grid.getStore().recordType; 
    var p = new Plant({ 
	        		    FLAG			: 'I' 
	        		  , ITEM_CODE		: Ext.get('item_code').getValue()
				   	  , ITEM_TYPE_CODE	: Ext.get('item_type_code').getValue()
		    		  , USE_YN          : 'Y'
    				  }); 
  	GridClass_edit_1st.grid.stopEditing();
	GridClass_edit_1st.store.insert(0, p);
	GridClass_edit_1st.grid.startEditing(0, 0);
}

// 페이징
function fnPagingValue_edit_1st(){	
	try{
		GridClass_edit_1st.store.setBaseParam('start'			,start_edit_1st);
	    GridClass_edit_1st.store.setBaseParam('limit'			,limit_edit_1st);
	    GridClass_edit_1st.store.setBaseParam('item_code'		,Ext.get('item_code').getValue());
		GridClass_edit_1st.store.setBaseParam('item_type_code'	,Ext.get('item_type_code').getValue());
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

// 그리드 필드
var	userColumns_edit_1st	= [ 
							 	 {header: "품목구분코드",	width: 10,	sortable: true,	dataIndex: "ITEM_TYPE_CODE",	editor: new Ext.form.TextField({ allowBlank : true }) , hidden : true}
								,{header: "품목코드",		width: 10,	sortable: true,	dataIndex: "ITEM_CODE",			editor: new Ext.form.TextField({ allowBlank : true }) , hidden : true}
			,{id:'spec_info_seq', header: "순번",			width: 10,	sortable: true,	dataIndex: "SPEC_HW_SEQ",		editor: new Ext.form.TextField({ allowBlank : true }) , hidden : true}
								,{header: "CPU", 			width: 10,	sortable: true,	dataIndex: "SPEC_HW_CPU",		editor: new Ext.form.TextField({ allowBlank : true }) }
								,{header: "기본메모리", 		width: 10,	sortable: true,	dataIndex: "SPEC_HW_MEM",		editor: new Ext.form.TextField({ allowBlank : true }) }
								,{header: "최소저장공간", 	width: 10,	sortable: true,	dataIndex: "SPEC_HW_STORAGE",	editor: new Ext.form.TextField({ allowBlank : true }) }
								,{header: "NIC", 			width: 10,	sortable: true,	dataIndex: "SPEC_HW_NIC",		editor: new Ext.form.TextField({ allowBlank : true }) }
								,{header: "사용여부", 		width: 10,	sortable: true,	dataIndex: "USE_YN",			editor: YESNO_CODE_COMBO ,renderer: Ext.util.Format.comboRenderer(YESNO_CODE_COMBO)}
								,{header: "비고", 			width: 10,	sortable: true,	dataIndex: "NOTE",				editor: new Ext.form.TextField({ allowBlank : true }) }
								,{header: "최종변경자ID",	width: 10,	sortable: true,	dataIndex: "FINAL_MOD_ID",		editor: new Ext.form.TextField({ allowBlank : true }) , hidden : true}
								,{header: "최종변경일시",	width: 10,	sortable: true,	dataIndex: "FINAL_MOD_DATE",	editor: new Ext.form.TextField({ allowBlank : true }) , hidden : true}
						  	  ];

// 맵핑 필드
var	mappingColumns_edit_1st	= [  
							   	 {name: "ITEM_TYPE_CODE", 	type:"string", mapping: "ITEM_TYPE_CODE"}
								,{name: "ITEM_CODE", 		type:"string", mapping: "ITEM_CODE"}
								,{name: "SPEC_HW_SEQ", 		type:"string", mapping: "SPEC_HW_SEQ"}
								,{name: "SPEC_HW_CPU", 		type:"string", mapping: "SPEC_HW_CPU"}
								,{name: "SPEC_HW_MEM", 		type:"string", mapping: "SPEC_HW_MEM"}
								,{name: "SPEC_HW_STORAGE", 	type:"string", mapping: "SPEC_HW_STORAGE"}
								,{name: "SPEC_HW_NIC", 		type:"string", mapping: "SPEC_HW_NIC"}
								,{name: "USE_YN", 			type:"string", mapping: "USE_YN"}
								,{name: "NOTE", 			type:"string", mapping: "NOTE"}
								,{name: "FINAL_MOD_ID", 	type:"string", mapping: "FINAL_MOD_ID"}
								,{name: "FINAL_MOD_DATE", 	type:"string", mapping: "FINAL_MOD_DATE" }
	    				 	  ]; 
 

/***************************************************************************
 * 설  명 : 편집그리드 설정 (소프트웨어 정보 )
***************************************************************************/
var	gridHeigth_edit_2nd	= 200;
var	gridWidth_edit_2nd  = 300	;
var	gridTitle_edit_2nd  = "지원 가능한 소프트웨어 정보"	; 
var	render_edit_2nd		= "sw_grid";
var keyNm_edit_2nd		= "SPEC_SW_SEQ";
var pageSize_edit_2nd	= 4;
var limit_edit_2nd		= pageSize_edit_2nd;
var start_edit_2nd		= 0;
var proxyUrl_edit_2nd	= "/com/item/result_edit_2nd.sg";
var grid2ndRowDeleteYn  = "";

// 행추가
function addNew_edit_2nd(){
	var Plant = GridClass_edit_2nd.grid.getStore().recordType; 
    var p = new Plant({ 
	        		    FLAG			: 'I' 
	        		  , ITEM_CODE		: Ext.get('item_code').getValue()
				   	  , ITEM_TYPE_CODE	: Ext.get('item_type_code').getValue()
		    		  , USE_YN          : 'Y'
    				  });
  	GridClass_edit_2nd.grid.stopEditing();
	GridClass_edit_2nd.store.insert(0, p);
	GridClass_edit_2nd.grid.startEditing(0, 0);
}

// 페이징
function fnPagingValue_edit_2nd(){	
	try{
		GridClass_edit_2nd.store.setBaseParam('start'			,start_edit_2nd);
	    GridClass_edit_2nd.store.setBaseParam('limit'			,limit_edit_2nd);
	    GridClass_edit_2nd.store.setBaseParam('item_code'		,Ext.get('item_code').getValue());
		GridClass_edit_2nd.store.setBaseParam('item_type_code'	,Ext.get('item_type_code').getValue());
	
	}catch(e){

	}
}

// 사용여부코드 combo box 생성 start
var YESNO_CODE_COMBO1 = new Ext.form.ComboBox({    
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
Ext.util.Format.comboRenderer = function(YESNO_CODE_COMBO1){    
 return function(value){        
 var record = YESNO_CODE_COMBO1.findRecord(YESNO_CODE_COMBO1.valueField, value);        
 return record ? record.get(YESNO_CODE_COMBO1.displayField) : YESNO_CODE_COMBO1.valueNotFoundText;    
}}

// 그리드 필드
var	userColumns_edit_2nd	= [ 
							 	 {header: "품목구분코드",	width: 10,	sortable: true,	dataIndex: "ITEM_TYPE_CODE",	editor: new Ext.form.TextField({ allowBlank : true }) , hidden : true}
								,{header: "품목코드",		width: 10,	sortable: true,	dataIndex: "ITEM_CODE",			editor: new Ext.form.TextField({ allowBlank : true }) , hidden : true}
			  ,{id:'spec_sw_seq', header: "순번",			width: 10,	sortable: true,	dataIndex: "SPEC_SW_SEQ",		editor: new Ext.form.TextField({ allowBlank : true }) , hidden : true}
			  				    ,{header: "운영체제", 		width: 15,	sortable: true,	dataIndex: "SPEC_OS",			editor: new Ext.form.TextField({ allowBlank : true }) }
								,{header: "소프트웨어", 		width: 15,	sortable: true,	dataIndex: "SPEC_SW",			editor: new Ext.form.TextField({ allowBlank : true }) }
								,{header: "사용여부", 		width: 10,	sortable: true,	dataIndex: "USE_YN",			editor: YESNO_CODE_COMBO1 ,renderer: Ext.util.Format.comboRenderer(YESNO_CODE_COMBO1)}
								,{header: "비고", 			width: 10,	sortable: true,	dataIndex: "NOTE",				editor: new Ext.form.TextField({ allowBlank : true }) }
								,{header: "최종변경자ID",	width: 10,	sortable: true,	dataIndex: "FINAL_MOD_ID",		editor: new Ext.form.TextField({ allowBlank : true }) , hidden : true}
								,{header: "최종변경일시",	width: 10,	sortable: true,	dataIndex: "FINAL_MOD_DATE",	editor: new Ext.form.TextField({ allowBlank : true }) , hidden : true}
						  	  ];

// 맵핑 필드
var	mappingColumns_edit_2nd	= [  
							   	 {name: "ITEM_TYPE_CODE", 	type:"string", mapping: "ITEM_TYPE_CODE"}	// 품목구분코드
								,{name: "ITEM_CODE", 		type:"string", mapping: "ITEM_CODE"}		// 품목코드
								,{name: "SPEC_SW_SEQ", 		type:"string", mapping: "SPEC_SW_SEQ"}		// 순번
								,{name: "SPEC_OS", 			type:"string", mapping: "SPEC_OS"}			// 운영체제
								,{name: "SPEC_SW", 			type:"string", mapping: "SPEC_SW"}			// 소프트웨어
								,{name: "USE_YN", 			type:"string", mapping: "USE_YN"}			// 사용여부
								,{name: "NOTE", 			type:"string", mapping: "NOTE"}				// 비고
								,{name: "FINAL_MOD_ID", 	type:"string", mapping: "FINAL_MOD_ID"}		// 최종변경자ID
								,{name: "FINAL_MOD_DATE", 	type:"string", mapping: "FINAL_MOD_DATE" }	// 최종변경일시
	    				 	  ]; 

/***************************************************************************
 * 설  명 : 편집그리드 설정 (담당자 정보 )
***************************************************************************/
var	gridHeigth_edit_3rd	= 200;
var	gridWidth_edit_3rd  = 300	;
var	gridTitle_edit_3rd  = "담당자 정보"	; 
var	render_edit_3rd		= "custom_member_grid";
var keyNm_edit_3rd		= "ITEM_INFO_SEQ";
var pageSize_edit_3rd	= 4;
var limit_edit_3rd		= pageSize_edit_3rd;
var start_edit_3rd		= 0;
var proxyUrl_edit_3rd	= "/com/item/result_edit_3rd.sg";
var grid3rdRowDeleteYn  = "";

// 행추가
function addNew_edit_3rd(){
	var Plant = GridClass_edit_3rd.grid.getStore().recordType; 
    var p = new Plant({ 
	        		    FLAG		    : 'I' 
	        		  , ITEM_CODE		: Ext.get('item_code').getValue()
				   	  , ITEM_TYPE_CODE  : Ext.get('item_type_code').getValue()
		    		  , USE_YN          : 'Y'
    				  });
  	GridClass_edit_3rd.grid.stopEditing();
	GridClass_edit_3rd.store.insert(0, p);
	GridClass_edit_3rd.grid.startEditing(0, 0);
}

// 페이징
function fnPagingValue_edit_3rd(){	
	try{
		GridClass_edit_3rd.store.setBaseParam('start'			,start_edit_3rd);
	    GridClass_edit_3rd.store.setBaseParam('limit'			,limit_edit_3rd);
	    GridClass_edit_3rd.store.setBaseParam('item_code'		,Ext.get('item_code').getValue());
		GridClass_edit_3rd.store.setBaseParam('item_type_code'	,Ext.get('item_type_code').getValue());
	}catch(e){

	}
}

// 사용여부코드 combo box 생성 start
var YESNO_CODE_COMBO2 = new Ext.form.ComboBox({    
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
Ext.util.Format.comboRenderer = function(YESNO_CODE_COMBO2){    
 return function(value){        
 var record = YESNO_CODE_COMBO2.findRecord(YESNO_CODE_COMBO2.valueField, value);        
 return record ? record.get(YESNO_CODE_COMBO2.displayField) : YESNO_CODE_COMBO2.valueNotFoundText;    
}}

// 그리드 필드
var	userColumns_edit_3rd	= [ 
							 	 {header: "품목구분코드",	width: 10,	sortable: true,	dataIndex: "ITEM_TYPE_CODE",	editor: new Ext.form.TextField({ allowBlank : true }) , hidden : true}
								,{header: "품목코드",		width: 10,	sortable: true,	dataIndex: "ITEM_CODE",			editor: new Ext.form.TextField({ allowBlank : true }) , hidden : true}
			,{id:'item_info_seq', header: "순번",			width: 10,	sortable: true,	dataIndex: "ITEM_INFO_SEQ",		editor: new Ext.form.TextField({ allowBlank : true }) , hidden : true}
								,{header: "사번", 			width: 10,	sortable: true,	dataIndex: "EMP_NUM",			editor: new Ext.form.TextField({ allowBlank : true }) }
								,{header: "이름", 			width: 10,	sortable: true,	dataIndex: "EMP_NAME",			editor: new Ext.form.TextField({ allowBlank : true }) }
								,{header: "사용여부", 		width: 10,	sortable: true,	dataIndex: "USE_YN",			editor: YESNO_CODE_COMBO2 ,renderer: Ext.util.Format.comboRenderer(YESNO_CODE_COMBO2)}
								,{header: "비고", 			width: 10,	sortable: true,	dataIndex: "NOTE",				editor: new Ext.form.TextField({ allowBlank : true }) }
								,{header: "최종변경자ID",	width: 10,	sortable: true,	dataIndex: "FINAL_MOD_ID",		editor: new Ext.form.TextField({ allowBlank : true }) , hidden : true}
								,{header: "최종변경일시",	width: 10,	sortable: true,	dataIndex: "FINAL_MOD_DATE",	editor: new Ext.form.TextField({ allowBlank : true }) , hidden : true}
						  	  ];

// 맵핑 필드
var	mappingColumns_edit_3rd	= [  
							   	 {name: "ITEM_TYPE_CODE", 	type:"string", mapping: "ITEM_TYPE_CODE"}
								,{name: "ITEM_CODE", 		type:"string", mapping: "ITEM_CODE"}
								,{name: "ITEM_INFO_SEQ", 	type:"string", mapping: "ITEM_INFO_SEQ"}
								,{name: "EMP_NUM", 			type:"string", mapping: "EMP_NUM"}
								,{name: "EMP_NAME", 		type:"string", mapping: "EMP_NAME"}
								,{name: "USE_YN", 			type:"string", mapping: "USE_YN"}
								,{name: "NOTE", 			type:"string", mapping: "NOTE"}
								,{name: "FINAL_MOD_ID", 	type:"string", mapping: "FINAL_MOD_ID"}
								,{name: "FINAL_MOD_DATE", 	type:"string", mapping: "FINAL_MOD_DATE" }
	    				 	  ]; 

/***************************************************************************
 * 설  명 : 검색
***************************************************************************/
function fnSearch(){  	
	
	Ext.Ajax.request({   
		url: "/com/item/result_1st.sg"
		,method : 'POST'   
		,success: function(response){						// 조회결과 성공시
					// 조회된 결과값, store명
					handleSuccess(response,GridClass_1st);
		          }
		,failure: handleFailure   		// 조회결과 실패시  
		,form   : document.searchForm
		,params : {						// 조회조건을 DB로 전송하기위해서 조건값 설정
					limit           : limit_1st
				  , start           : start_1st
				  }				
	});  
	
	fnInitValue();
}  		
/***************************************************************************
 * 설  명 : 이벤트 설정
 ***************************************************************************/
// ExtJS 진입함수
Ext.onReady(function() {

	var dForm = document.detailForm;
	var sForm = document.searchForm;
	
	//출시일
	var enddt = new Ext.form.DateField({
	    applyTo: 'release_date',
		allowBlank: false,
		format:'Y-m-d'
	});
	
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
			
	//저장 버튼 -> 데이터를 server로 전송
	Ext.get('saveBtn').on('click', function(e){	
		if(fnValidation()){
			Ext.MessageBox.confirm('Confirm', '저장하시겠습니까?', showResult);
		};
	});
	
	//수정 버튼 -> 데이터를 server로 전송
	Ext.get('updateBtn').on('click', function(e){	
		if(fnValidation()){
			Ext.MessageBox.confirm('Confirm', '수정하시겠습니까?', showResult);
		};	
	});
	
	//품목구분 "제품"을 선택했을 경우 
	Ext.get('item_type_code').on('change', function(e){	
		var val = Ext.get('item_type_code').getValue()
		fnShowEditGrid(val);
		
	});
	
	Ext.get('hw_grid').setStyle({'visibility':'hidden'}); 
	Ext.get('sw_grid').setStyle({'visibility':'hidden'});
	Ext.get('custom_member_grid').setStyle({'visibility':'hidden'});
	
    setTimeout("fnInitValue()",10);
});

function fnShowEditGrid(val){
	// val:20 <- 제품
	if(val == '20'){
		
		GridClass_edit_1st.grid.setVisible(true);
		GridClass_edit_2nd.grid.setVisible(true);
		GridClass_edit_3rd.grid.setVisible(true);
		
		Ext.get('hw_grid').show();
		Ext.get('sw_grid').show();
		Ext.get('custom_member_grid').show();
	}else{
		GridClass_edit_1st.grid.setVisible(false);
		GridClass_edit_2nd.grid.setVisible(false);
		GridClass_edit_3rd.grid.setVisible(false);
	}
}

// 저장, 수정버튼 클릭시 '예','아니오' 
function showResult(btn){
   	if(btn == 'yes'){
   		fnSave();
   	}    	
};

/***************************************************************************
 * 설  명 : 화면 초기값 설정
 ***************************************************************************/
function fnInitValue(){
	
	var dForm = document.detailForm;		// 상세 FORM	
	
	dForm.reset();							// 상세필드 초기화
	
	// 버튼 초기화
	Ext.get('saveBtn').dom.disabled    	  = false;
	Ext.get('updateBtn').dom.disabled  	  = true;
	Ext.get('item_type_code').dom.disabled  = false;
	
	// 편집가능 그리드 초기화
//	Ext.get('hw_grid').setVisible(false);
//	GridClass_edit_1st.setHeight(0);
//	Ext.get('sw_grid').setVisible(false);
//	Ext.get('sw_grid').setSize(0,0,true);
//	Ext.get('custom_member_grid').setVisible(false);
//	Ext.get('custom_member_grid').setSize(0,0,true);

	// Ext.get('show_grid').isVisible()
	Ext.get('hw_grid').setStyle({'visibility':'hidden'}); 
	Ext.get('sw_grid').setStyle({'visibility':'hidden'});
	Ext.get('custom_member_grid').setStyle({'visibility':'hidden'});
	
	try{
		GridClass_edit_1st.store.commitChanges();	// 변경된 record를 commit
		GridClass_edit_1st.store.removeAll();		// store자료를 삭제
		GridClass_edit_2nd.store.commitChanges();
		GridClass_edit_2nd.store.removeAll();
		GridClass_edit_3rd.store.commitChanges();
		GridClass_edit_3rd.store.removeAll();
		
		GridClass_edit_1st.grid.setVisible(false);
		GridClass_edit_2nd.grid.setVisible(false);
		GridClass_edit_3rd.grid.setVisible(false);
	}catch(e){
		
	}
}

/***************************************************************************
 * 설  명 : 저장
 ***************************************************************************/
function fnSave(){  	

	// 변경된 하드웨어 Grid의 record 
	var records = GridClass_edit_1st.store.getModifiedRecords();	  
	// 변경된 record의 자료를 json형식으로
    var hwJson = "[";
	    for (var i = 0; i < records.length; i++) {
	      hwJson += Ext.util.JSON.encode(records[i].data);				
	      if (i < (records.length-1)) {
	        hwJson += ",";
	      }
	    }
    	hwJson += "]"
    	
	// 변경된 소프트웨어 Grid의 record
	var record2 = GridClass_edit_2nd.store.getModifiedRecords();	  
	// 변경된 record의 자료를 json형식으로
    var SwJson = "[";
	    for (var i = 0; i < record2.length; i++) {
	      SwJson += Ext.util.JSON.encode(record2[i].data);				
	      if (i < (record2.length-1)) {
	        SwJson += ",";
	      }
	    }
    	SwJson += "]"
	
	// 변경된 담당자 Grid의 record
	var record3 = GridClass_edit_3rd.store.getModifiedRecords();	  
	// 변경된 record의 자료를 json형식으로
    var DevJson = "[";
	    for (var i = 0; i < record3.length; i++) {
	      DevJson += Ext.util.JSON.encode(record3[i].data);				
	      if (i < (record3.length-1)) {
	        DevJson += ",";
	      }
	    }
    	DevJson += "]"
	
    Ext.get('item_type_code').dom.disabled  = false;	
 
	Ext.Ajax.request({   
		url: "/com/item/saveItem.sg"   
		,success: function(response){						// 조회결과 성공시
					// 조회된 결과값, store명
					handleSuccess(response,GridClass_1st,'save');
		          }
		,failure: handleFailure   	// 조회결과 실패시  
		,form   : document.detailForm
		,params : {					// 조회조건을 DB로 전송하기위해서 조건값 설정
					limit          : limit_1st
				  , start          : start_1st      
  				  , hw_data		   : hwJson 		// 하드웨어 정보
  				  , sw_data        : SwJson			// 소프트웨어 정보
  				  , dev_data       : DevJson        // 개발담당자 정보
				  }  		
	});

	fnInitValue();
	 
}  		

/***************************************************************************
 * 설  명 : 팝업 호출
 ***************************************************************************/
function fnPop(field){
	
	var sURL = "/com/dept/deptPop.sg?field="+field;
	var dlgWidth = 420;
	var dlgHeight = 360;
	var winName = "부서레벨";
	
	fnOpenPop(sURL, dlgWidth, dlgHeight, winName);
}

// 팝업
function fnOpenPop(sURL, dlgWidth, dlgHeight, winName){
  var xPos=(window.screen.width) ? (window.screen.width-dlgWidth)/2 : 0;
  var yPos=(window.screen.height) ? (window.screen.height-dlgHeight)/2 : 0;
  var sFeatures = "titlebar=no, scrollbars=yes,location=no ,menubar=no, resizable=yes, status=yes, width="+dlgWidth+",height="+dlgHeight+",left="+xPos+", top="+yPos;
  window.open(sURL,winName, sFeatures);
}

function fnValidation(){

	var item_type_code = Ext.get('item_type_code').getValue();			// 품목구분코드
	var item_name = Ext.get('item_name').getValue(); 					// 품목명
	var item_pattern_code = Ext.get('item_pattern_code').getValue();	// 품목유형
	var item_version = Ext.get('item_version').getValue();				// 품목버전
	var unit = Ext.get('unit').getValue();								// 품목단위
	
	var item_name_len = getByteLength(item_name);
	var item_intro_len = getByteLength(Ext.get('item_intro').getValue());
	var item_function_len = getByteLength(Ext.get('item_function').getValue());
	var standard_len = getByteLength(Ext.get('standard').getValue());
	var spec_len = getByteLength(Ext.get('spec').getValue());

	if(item_type_code.length == 0 || item_type_code == ""){
		Ext.Msg.alert('확인', '품목구분을 선택해주세요.')
		return false;
	}
	
	if(item_name.length == 0 || item_name == ""){
		Ext.Msg.alert('확인', '품목명을 입력해주세요.')
		return false;
	}
	
	if(item_name_len > 100){
		Ext.Msg.alert('확인', '품목명은 한글 50자까지 입력가능합니다.')
		return false;
	}
	
	if(item_pattern_code.length == 0 || item_pattern_code == ""){
		Ext.Msg.alert('확인', '품목유형을 선택해주세요.')
		return false;
	}
	
	if(item_version.length == 0 || item_version == ""){
		Ext.Msg.alert('확인', '품목버전을 입력해주세요.')
		return false;
	}
	
	if(unit.length == 0 || unit == ""){
		Ext.Msg.alert('확인', '품목단위를 입력해주세요.')
		return false;
	}
	
	 
	
	
	if(item_intro_len > 500){
		Ext.Msg.alert('확인', '품목소개는 한글 250자까지 입력가능합니다.')
		return false;
	}
	
	if(item_function_len > 500){
		Ext.Msg.alert('확인', '품목기능은 한글 250자까지 입력가능합니다.')
		return false;
	}
	
	if(standard_len > 50){
		Ext.Msg.alert('확인', '품목규격은 한글 25자까지 입력가능합니다.')
		return false;
	}
	
	if(spec_len > 100){
		Ext.Msg.alert('확인', '제원은 한글 50자까지 입력가능합니다.')
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
				<div class="x-panel-tl">
					<div class="x-panel-tr">
						<div class="x-panel-tc">
							<div class="x-panel-header x-unselectable" style="-moz-user-select: none;">
								<span class="x-panel-header-text">품목 정보검색</span><!----------------- 이름변경 ----------------->		
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
										<td width="20%">
											<div tabindex="-1" class="x-form-item " >
												<label class="x-form-item-label" style="width: auto;" for="src_item_code">품목코드 :</label>
												<div style="padding-left: 20px;" class="x-form-element">
														<input type="text" name="src_item_code" id="src_item_code" autocomplete="off" size="20" class="x-form-text x-form-field" style="width: auto;">
<%--													<select name="src_task_group_code" id="src_task_group_code" style="width: 29%;" type="text" class=" x-form-select x-form-field" >--%>
<%--														<option value="">전체</option>--%>
<%--														<c:forEach items="${TASK_GROUP_CODE}" var="data" varStatus="status">--%>
<%--														<option value="${data.COM_CODE}"><c:out value="${data.COM_CODE_NAME}"/></option>--%>
<%--														</c:forEach>--%>
<%--													</select>--%>
												</div>
											</div>
										</td>
										
										<td width="20%">
											<div tabindex="-1" class="x-form-item " >
												<label class="x-form-item-label" style="width: auto;" for="src_item_name" >품목명 :</label>
												<div style="padding-left: 20px;" class="x-form-element">
													<input type="text" name="src_item_name" id="src_item_name" autocomplete="off" size="20" class="x-form-text x-form-field" style="width: auto;">
												</div>
											</div>
										</td>
										
										<td width="20%">
											<div tabindex="-1" class="x-form-item " >
												<label class="x-form-item-label" style="width: auto;" for="src_item_pattern_code" >품목유형 :</label>
												<div style="padding-left: 60px;" class="x-form-element">
													<select name="src_item_pattern_code" id="src_item_pattern_code" style="width: 45%;" type="text" class=" x-form-select x-form-field" >
														<option value="">전체</option>
														<c:forEach items="${ITEM_PATTERN_CODE}" var="data" varStatus="status">
														<option value="${data.COM_CODE}"><c:out value="${data.COM_CODE_NAME}"/></option>
														</c:forEach>
													</select>
												</div>
											</div>
										</td>
										
										<td width="20%">
											<div tabindex="-1" class="x-form-item " >
												<label class="x-form-item-label" style="width: auto;" for="src_item_type_code" >품목구분 :</label>
												<div style="padding-left: 60px;" class="x-form-element">
													<select name="src_item_type_code" id="src_item_type_code" style="width: 45%;" type="text" class=" x-form-select x-form-field" >
														<option value="">전체</option>
														<c:forEach items="${ITEM_TYPE_CODE}" var="data" varStatus="status">
														<option value="${data.COM_CODE}"><c:out value="${data.COM_CODE_NAME}"/></option>
														</c:forEach>
													</select>
												</div>
											</div>
										</td>
										<td colspan="4" align="right">
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
				<div id="item_grid_1st" style="margin-top: 0em;"></div> <!----------------- 그리드명을 동일하게 설정 ----------------->		
			</td>
			<!------------------------------ GRID END ------------------------------------>
			<td width="51%" valign="top">
				<div class=" x-panel x-form-label-left" style="margin-top: 0em; width: 100%;"><%-- 0em <- 1em으로 수정하면 상위 공백 --%>
					<!----------------- SEARCH Hearder Start	 ----------------->
					<div class="x-panel-tl">
						<div class="x-panel-tr">
							<div class="x-panel-tc">
								<div class="x-panel-header x-unselectable" style="-moz-user-select: none;">
									<span class="x-panel-header-text">품목 상세정보</span><!----------------- 이름변경 ----------------->		
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
									<input type="hidden" name="flag" id="flag"/>
									<input type="hidden" name="item_code" id="item_code"/>
									
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
									<div class="x-column-inner" style="width: 100%; margin-top: 0.1em;">
										<div class=" x-panel x-column" style="width: 50%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label class="x-form-item-label " style="width: auto;" for="item_type_code" ><font color="red">* </font>품목구분 :</label>
														<div style="padding-left: 83px;" class="x-form-element">
															<select name="item_type_code" id="item_type_code" style="width: 126px;" type="text" class=" x-form-select x-form-field" >
															<option value="">선택하세요</option>
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
														<label style="padding-rigth: 100px;"  class="x-form-item-label" style="width: auto;" for="item_pattern_code" ><font color="red">* </font>품목유형 :</label>
														<div style="padding-left: 83px;" class="x-form-element">
															<select name="item_pattern_code" id="item_pattern_code" style="width: 126px;" type="text" class=" x-form-select x-form-field" >
																<option value="">전체</option>
																<c:forEach items="${ITEM_PATTERN_CODE}" var="data" varStatus="status">
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
									<!-- DETAIL 2_ROW End -->
								
									<!-- DETAIL 3_ROW Start -->
									<div class="x-column-inner" style="width: 100%; margin-top: 0.1em;">
										<div class=" x-panel x-column" style="width: 100%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label class="x-form-item-label" style="width: auto;" for="item_name" ><font color="red">* </font>품목명 :</label>
														<div style="padding-left: 83px;" class="x-form-element">
															<input type="text" name="item_name" id="item_name" autocomplete="off" size="69" class="x-form-text x-form-field " style="width: auto;">
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
<%--														<input type="hidden" name="task_group_name" id="task_group_name" autocomplete="off" size="22" class=" x-form-text x-form-field" style="width: auto;">--%>
<%--														<div class="x-form-clear-left">--%>
<%--														</div>--%>
<%--													</div>--%>
<%--												</div>--%>
<%--											</div>--%>
<%--										</div>--%>
									</div>
									<!-- DETAIL 3_ROW End -->
								
									<!-- DETAIL 4_ROW Start -->
									<div class="x-column-inner" style="width: 100%; margin-top: 0.1em;">
										<div class=" x-panel x-column" style="width: 100%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label class="x-form-item-label" style="width: auto;" for="item_intro" >&nbsp;&nbsp;&nbsp;품목소개 :</label>
														<div style="padding-left: 86px;" class="x-form-element">
															<textarea name="item_intro" id="item_intro" autocomplete="off" style="width: 366px; height: 40px; left: 0px; top: 0px;" class="x-form-textarea x-form-field x-box-item"></textarea>
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
									<div class="x-column-inner" style="width: 100%; margin-top: 0.6em;">
										<div class=" x-panel x-column" style="width: 100%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label class="x-form-item-label" style="width: auto;" for="item_function" >&nbsp;&nbsp;&nbsp;품목기능 :</label>
														<div style="padding-left: 86px;" class="x-form-element">
															<textarea name="item_function" id="item_function" autocomplete="off" style="width: 366px; height: 80px; left: 0px; top: 0px;" class="x-form-textarea x-form-field x-box-item"></textarea>
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
									<div class="x-column-inner" style="width: 100%; margin-top: 0.6em;">
										<div class=" x-panel x-column" style="width: 100%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label class="x-form-item-label" style="width: auto;" for="standard" >&nbsp;&nbsp;&nbsp;품목규격 :</label>
														<div style="padding-left: 86px;" class="x-form-element">
															<textarea name="standard" id="standard" autocomplete="off" style="width: 366px; height: 40px; left: 0px; top: 0px;" class="x-form-textarea x-form-field x-box-item"></textarea>
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
									<div class="x-column-inner" style="width: 100%; margin-top: 0.6em;">
										<div class=" x-panel x-column" style="width: 50%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label class="x-form-item-label " style="width: auto;" for="item_version" ><font color="red">* </font>품목버전 :</label>
														<div style="padding-left: 83px;" class="x-form-element">
															<input type="text" name="item_version" id="item_version" autocomplete="off" size="21" class=" x-form-text x-form-field" style="width: auto;">
<%--															<select name="item_version" id="item_version" style="width: 126px;" type="text" class=" x-form-select x-form-field" >--%>
<%--															<option value="">전체</option>--%>
<%--															<c:forEach items="${ITEM_TYPE_CODE}" var="data" varStatus="status">--%>
<%--															<option value="${data.COM_CODE}"><c:out value="${data.COM_CODE_NAME}"/></option>--%>
<%--															</c:forEach>--%>
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
														<label class="x-form-item-label " style="width: auto;" for="unit" ><font color="red">* </font>품목단위 :</label>
														<div style="padding-left: 83px;" class="x-form-element">
															<input type="text" name="unit" id="unit" autocomplete="off" size="21" class=" x-form-text x-form-field" style="width: auto;">
<%--															<select name="unit" id="unit" style="width: 126px;" type="text" class=" x-form-select x-form-field" >--%>
<%--																<option value="">전체</option>--%>
<%--																<c:forEach items="${ITEM_TYPE_CODE}" var="data" varStatus="status">--%>
<%--																<option value="${data.COM_CODE}"><c:out value="${data.COM_CODE_NAME}"/></option>--%>
<%--																</c:forEach>--%>
<%--															</select>--%>
														</div>
														<div class="x-form-clear-left">
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>
									<!-- DETAIL 7_ROW End -->
									
									<!-- DETAIL 8_ROW Start -->
									<div class="x-column-inner" style="width: 100%; margin-top: 0.1em;">
										<div class=" x-panel x-column" style="width: 50%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label style="padding-rigth: 100px;"  class="x-form-item-label" style="width: auto;" for="spec" >&nbsp;&nbsp;&nbsp;제원 :</label>
														<div style="padding-left: 83px;" class="x-form-element">
															<input type="text" name="spec" id="spec" autocomplete="off" size="21" class=" x-form-text x-form-field" style="width: auto;">
														</div>
													</div>
												</div>
											</div>
										</div>
										<div class=" x-panel x-column" style="width: 50%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label class="x-form-item-label" style="width: auto;" for="release_date" >&nbsp;&nbsp;&nbsp;출시일 :</label>
														<div style="padding-left: 83px;" class="x-form-element">
															<input type="text" name="release_date" id="release_date" autocomplete="off" class="x-form-text x-form-field " style="width: 110px;">
														</div>
														<div class="x-form-clear-left">
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>
									<!-- DETAIL 8_ROW End -->
									
									<!-- DETAIL 9_ROW Start -->
									<div class="x-column-inner" style="width: 100%; margin-top: 0.1em;">
										<div class=" x-panel x-column" style="width: 50%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label style="padding-rigth: 100px;"  class="x-form-item-label" style="width: auto;" for="unit_price_01" ><font color="red">* </font>단가1 :</label>
														<div style="padding-left: 83px;" class="x-form-element">
															<input type="text" name="unit_price_01" id="unit_price_01" autocomplete="off" size="21" class=" x-form-text x-form-field" style="width: auto;text-align:right; IME-MODE:disabled;" onkeyPress="return _chkKeyPressNumOnly(this)" onBlur="_numFormat(this, Math.round(this.value));" onfocus="_removeComma(this, this.value)"/>
														</div>
													</div>
												</div>
											</div>
										</div>
										<div class=" x-panel x-column" style="width: 50%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label class="x-form-item-label" style="width: auto;" for="unit_price_02" >&nbsp;&nbsp;&nbsp;단가2 :</label>
														<div style="padding-left: 83px;" class="x-form-element">
															<input type="text" name="unit_price_02" id="unit_price_02" autocomplete="off" size="21" class=" x-form-text x-form-field" style="width: auto; text-align:right; IME-MODE:disabled;" onkeyPress="return _chkKeyPressNumOnly(this)" onBlur="_numFormat(this, Math.round(this.value));" onfocus="_removeComma(this, this.value)"/>
														</div>
														<div class="x-form-clear-left">
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>
									<!-- DETAIL 9_ROW End -->
									
									<!-- DETAIL 10_ROW Start -->
									<div class="x-column-inner" style="width: 100%; margin-top: 0.1em;">
										<div class=" x-panel x-column" style="width: 50%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label style="padding-rigth: 100px;"  class="x-form-item-label" style="width: auto;" for="unit_price_03" >&nbsp;&nbsp;&nbsp;단가3 :</label>
														<div style="padding-left: 83px;" class="x-form-element">
															<input type="text" name="unit_price_03" id="unit_price_03" autocomplete="off" size="21" class=" x-form-text x-form-field" style="width: auto; text-align:right; IME-MODE:disabled;" onkeyPress="return _chkKeyPressNumOnly(this)" onBlur="_numFormat(this, Math.round(this.value));" onfocus="_removeComma(this, this.value)"/>
														</div>
													</div>
												</div>
											</div>
										</div>
										<div class=" x-panel x-column" style="width: 50%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label class="x-form-item-label" style="width: auto;" for="unit_price_04" >&nbsp;&nbsp;&nbsp;단가4 :</label>
														<div style="padding-left: 83px;" class="x-form-element">
															<input type="text" name="unit_price_04" id="unit_price_04" autocomplete="off" size="21" class=" x-form-text x-form-field" style="width: auto; text-align:right; IME-MODE:disabled;" onkeyPress="return _chkKeyPressNumOnly(this)" onBlur="_numFormat(this, Math.round(this.value));" onfocus="_removeComma(this, this.value)"/>
														</div>
														<div class="x-form-clear-left">
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>
									<!-- DETAIL 10_ROW End -->
									
									<!-- DETAIL 11_ROW Start -->
									<div class="x-column-inner" style="width: 100%; margin-top: 0.1em;">
										<div class=" x-panel x-column" style="width: 100%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label style="padding-rigth: 100px;"  class="x-form-item-label" style="width: auto;" for="unit_price_05" >&nbsp;&nbsp;&nbsp;단가5 :</label>
														<div style="padding-left: 83px;" class="x-form-element">
															<input type="text" name="unit_price_05" id="unit_price_05" autocomplete="off" size="21" class=" x-form-text x-form-field" style="width: auto; text-align:right; IME-MODE:disabled;" onkeyPress="return _chkKeyPressNumOnly(this)" onBlur="_numFormat(this, Math.round(this.value));" onfocus="_removeComma(this, this.value)"/>
														</div>
													</div>
												</div>
											</div>
										</div>
<%--										<div class=" x-panel x-column" style="width: 50%;">--%>
<%--											<div class="x-panel-bwrap" >--%>
<%--												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">--%>
<%--													<div tabindex="-1" class="x-form-item " >--%>
<%--														<label class="x-form-item-label" style="width: auto;" for="task_code" ><font color="red">* </font>코드 :</label>--%>
<%--														<div style="padding-left: 83px;" class="x-form-element">--%>
<%--															<input type="text" name="task_name" id="task_name" autocomplete="off" size="21" class=" x-form-text x-form-field" style="width: auto;">--%>
<%--														</div>--%>
<%--														<div class="x-form-clear-left">--%>
<%--														</div>--%>
<%--													</div>--%>
<%--												</div>--%>
<%--											</div>--%>
<%--										</div>--%>
									</div>
									<!-- DETAIL 11_ROW End -->
<%--									
									<!-- DETAIL 7_ROW Start -->
									<div class="x-column-inner" style="width: 100%; margin-top: 0em;">
										<div class=" x-panel x-column" style="width: 100%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
													</div>
												</div>
											</div>
										</div>					
									</div>
									<!-- DETAIL 7_ROW End -->
									--%>
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
			<td colspan="2">
				<table border='0'>
					<tr id="a" height="0">
						<td width="300px">
							<div id="sw_grid" style="margin-top: 0em; "></div> <!----------------- 그리드명을 동일하게 설정 ----------------->		
						</td>
						<td width="400px">
							<div id="hw_grid" style="margin-top: 0em; "></div> <!----------------- 그리드명을 동일하게 설정 ----------------->
						</td>
						<td width="300px">
							<div id="custom_member_grid" style="margin-top: 0em; "></div> <!----------------- 그리드명을 동일하게 설정 ----------------->
						</td>
					</tr>

					<tr>
						<td colspan="3" align="center">
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
			</td>
		</tr>
	</table>
</body>

<%@ include file="/WEB-INF/web/jsp/sgis-bottom-inc.jsp" %>