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
<script type="text/javascript" src="/resource/common/js/grid/grid_2nd.js"></script> 
<script type="text/javascript" src="/resource/common/js/grid/grid_3rd.js"></script>
<script type="text/javascript" src="/resource/common/js/grid/grid_4th.js"></script> 
<script type="text/javascript">
/***************************************************************************
 * 설  명 : 그리드 설정정보 (품목정보)
***************************************************************************/
var	gridHeigth_1st	= 255;
var	gridWidth_1st  	= 1000;
var	gridTitle_1st  	= "품목 정보";
var	render_1st		= "item_grid_1st";
var pageSize_1st	= 8;
var limit_1st		= pageSize_1st;
var start_1st		= 0;
var proxyUrl_1st	= "/com/item/result_1st.sg";

// 그리드 필드
var	userColumns_1st	= [ 
						 {header: "상태",		width: 100, sortable: true, dataIndex: 'FLAG', 			    editor: new Ext.form.TextField({}) , hidden : true} 
					    ,{header: "품목구분",		width: 40,  sortable: true, dataIndex: 'ITEM_TYPE', 		editor: new Ext.form.TextField({}) }
						,{header: "품목코드", 	width: 40, 	sortable: true, dataIndex: 'ITEM_CODE', 		editor: new Ext.form.TextField({}) }       
						,{header: "품목구분코드",	width: 60,  sortable: true, dataIndex: 'ITEM_TYPE_CODE', 	editor: new Ext.form.TextField({}) , hidden : true}                                                    
						,{header: "품목명", 		width: 100,	sortable: true, dataIndex: 'ITEM_NAME', 		editor: new Ext.form.TextField({}) }                  
						,{header: "품목유형", 	width: 40,  sortable: true, dataIndex: 'ITEM_PATTERN',		editor: new Ext.form.TextField({}) }
						,{header: "품목유형코드",	width: 60,  sortable: true, dataIndex: 'ITEM_PATTERN_CODE',	editor: new Ext.form.TextField({}) , hidden : true}
						,{header: "단위", 		width: 30,  sortable: true, dataIndex: 'UNIT', 				editor: new Ext.form.TextField({}) }
						,{header: "소개", 		width: 50,  sortable: true, dataIndex: 'ITEM_INTRO', 		editor: new Ext.form.TextField({}) , hidden : true}
						,{header: "기능", 		width: 100, sortable: true, dataIndex: 'ITEM_FUNCTION', 	editor: new Ext.form.TextField({}) }
						,{header: "규격", 		width: 50,  sortable: true, dataIndex: 'STANDARD', 			editor: new Ext.form.TextField({}) , hidden : true}
						,{header: "제원", 		width: 50,  sortable: true, dataIndex: 'SPEC', 				editor: new Ext.form.TextField({}) , hidden : true}
						,{header: "출시일", 		width: 50,  sortable: true, dataIndex: 'RELEASE_DATE', 		editor: new Ext.form.TextField({}) }
						,{header: "버전", 		width: 20,  sortable: true, dataIndex: 'ITEM_VERSION', 		editor: new Ext.form.TextField({}) }
						,{header: "단가1", 		width: 50,  sortable: true, dataIndex: 'UNIT_PRICE_01', 	editor: new Ext.form.TextField({}) }  
						,{header: "단가2", 		width: 100, sortable: true, dataIndex: 'UNIT_PRICE_02', 	editor: new Ext.form.TextField({}) , hidden : true}  
						,{header: "단가3", 		width: 50,  sortable: true, dataIndex: 'UNIT_PRICE_03', 	editor: new Ext.form.TextField({}) , hidden : true}
						,{header: "단가4", 		width: 50,  sortable: true, dataIndex: 'UNIT_PRICE_04', 	editor: new Ext.form.TextField({}) , hidden : true}
						,{header: "단가5", 		width: 50,  sortable: true, dataIndex: 'UNIT_PRICE_05', 	editor: new Ext.form.TextField({}) , hidden : true}
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

	var itemCode 		= fnFixNull(store.getAt(rowIndex).data.ITEM_CODE);         // 품목코드     
	var itemTypeCode    = fnFixNull(store.getAt(rowIndex).data.ITEM_TYPE_CODE);    // 품목구분코드

	Ext.get('item_code').set({value : itemCode}, false);
	Ext.get('item_type_code').set({value : itemTypeCode}, false);
	
	fnSearchHw(itemCode,itemTypeCode);  // 하드웨어정보 조회
	fnSearchSw(itemCode,itemTypeCode);  // 소프트웨어정보 조회
	fnSearchDev(itemCode,itemTypeCode); // 제품개발담당자정보 조회

}	

// 하드웨어정보 조회
function fnSearchHw(itemCode,itemTypeCode){
	
	Ext.Ajax.request({
		url: "/com/item/result_2nd.sg" 
		,success: function(response){						// 조회결과 성공시
					// 조회된 결과값, store명
					handleSuccess(response,GridClass_2nd);
		          }
		,failure: handleFailure 
		,params : {
				   // 페이지 		
					 limit			: limit_2nd
				   , start			: start_2nd
				   // 키 value
				   , item_code		: itemCode
				   , item_type_code	: itemTypeCode
				  }				
	}); // end Ext.Ajax.request   
}

// 소프트웨어정보 조회
function fnSearchSw(itemCode,itemTypeCode){
	
	Ext.Ajax.request({
		url: "/com/item/result_3rd.sg" 
		,success: function(response){						// 조회결과 성공시
					// 조회된 결과값, store명
					handleSuccess(response,GridClass_3rd);
		          }
		,failure: handleFailure 
		,params : {
				   // 페이지 		
					 limit			: limit_3rd
				   , start			: start_3rd
				   // 키 value
				   , item_code		: itemCode
				   , item_type_code	: itemTypeCode
				  }				
	}); // end Ext.Ajax.request   
}

// 제품개발담당자정보 조회
function fnSearchDev(itemCode,itemTypeCode){
	
	Ext.Ajax.request({
		url: "/com/item/result_4th.sg" 
		,success: function(response){						// 조회결과 성공시
					// 조회된 결과값, store명
					handleSuccess(response,GridClass_4th);
		          }
		,failure: handleFailure 
		,params : {
				   // 페이지 		
					 limit			: limit_4th
				   , start			: start_4th
				   // 키 value
				   , item_code		: itemCode
				   , item_type_code	: itemTypeCode
				  }				
	}); // end Ext.Ajax.request   
}

/***************************************************************************
 * 설  명 : 편집그리드 설정 (하드웨어정보 )
***************************************************************************/
var	gridHeigth_2nd	= 200;
var	gridWidth_2nd   = 393;
var	gridTitle_2nd   = "하드웨어 정보"	; 
var	render_2nd		= "hw_grid";
var pageSize_2nd	= 4;
var limit_2nd		= pageSize_2nd;
var start_2nd		= 0;
var proxyUrl_2nd	= "/com/item/result_2nd.sg";

// 페이징
function fnPagingValue_2nd(){	
	try{
		GridClass_2nd.store.setBaseParam('start'			,start_2nd);
	    GridClass_2nd.store.setBaseParam('limit'			,limit_2nd);
	    GridClass_2nd.store.setBaseParam('item_code'		,Ext.get('item_code').getValue());
		GridClass_2nd.store.setBaseParam('item_type_code'	,Ext.get('item_type_code').getValue());
	}catch(e){

	}
}

// 그리드 필드
var	userColumns_2nd	= [ 
							 	 {header: "품목구분코드",	width: 10,	sortable: true,	dataIndex: "ITEM_TYPE_CODE",	editor: new Ext.form.TextField({ allowBlank : false }) , hidden : true}
								,{header: "품목코드",		width: 10,	sortable: true,	dataIndex: "ITEM_CODE",			editor: new Ext.form.TextField({ allowBlank : false }) , hidden : true}
								,{header: "순번",		width: 10,	sortable: true,	dataIndex: "SPEC_HW_SEQ",		editor: new Ext.form.TextField({ allowBlank : false }) , hidden : true}
								,{header: "CPU", 		width: 10,	sortable: true,	dataIndex: "SPEC_HW_CPU",		editor: new Ext.form.TextField({ allowBlank : true }) }
								,{header: "기본메모리", 	width: 15,	sortable: true,	dataIndex: "SPEC_HW_MEM",		editor: new Ext.form.TextField({ allowBlank : true }) }
								,{header: "최소저장공간", 	width: 15,	sortable: true,	dataIndex: "SPEC_HW_STORAGE",	editor: new Ext.form.TextField({ allowBlank : true }) }
								,{header: "NIC", 		width: 5,	sortable: true,	dataIndex: "SPEC_HW_NIC",		editor: new Ext.form.TextField({ allowBlank : true }) }
								,{header: "사용여부", 	width: 10,	sortable: true,	dataIndex: "USE_YN",			editor: new Ext.form.TextField({ allowBlank : true }) }
								,{header: "비고", 		width: 10,	sortable: true,	dataIndex: "NOTE",				editor: new Ext.form.TextField({ allowBlank : true }) }
								,{header: "최종변경자ID",	width: 10,	sortable: true,	dataIndex: "FINAL_MOD_ID",		editor: new Ext.form.TextField({ allowBlank : true }) , hidden : true}
								,{header: "최종변경일시",	width: 10,	sortable: true,	dataIndex: "FINAL_MOD_DATE",	editor: new Ext.form.TextField({ allowBlank : true }) , hidden : true}
						  	  ];

// 맵핑 필드
var	mappingColumns_2nd	= [  
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
 

// 그리드 클릭                                                                                                                                                                                         
function fnGridOnClick_2nd(store, rowIndex){}	

/***************************************************************************
 * 설  명 : 편집그리드 설정 (소프트웨어 정보 )
***************************************************************************/
var	gridHeigth_3rd	= 200;
var	gridWidth_3rd   = 300	;
var	gridTitle_3rd   = "소프트웨어 정보"	; 
var	render_3rd		= "sw_grid";
var pageSize_3rd	= 4;
var limit_3rd		= pageSize_3rd;
var start_3rd		= 0;
var proxyUrl_3rd	= "/com/item/result_3rd.sg";

// 페이징
function fnPagingValue_3rd(){	
	try{
		GridClass_3rd.store.setBaseParam('start'			,start_3rd);
	    GridClass_3rd.store.setBaseParam('limit'			,limit_3rd);
	    GridClass_3rd.store.setBaseParam('item_code'		,Ext.get('item_code').getValue());
		GridClass_3rd.store.setBaseParam('item_type_code'	,Ext.get('item_type_code').getValue());
	
	}catch(e){

	}
}

// 그리드 필드
var	userColumns_3rd	= [ 
							 	 {header: "품목구분코드",	width: 10,	sortable: true,	dataIndex: "ITEM_TYPE_CODE",	editor: new Ext.form.TextField({ allowBlank : false }) , hidden : true}
								,{header: "품목코드",		width: 10,	sortable: true,	dataIndex: "ITEM_CODE",			editor: new Ext.form.TextField({ allowBlank : false }) , hidden : true}
			  ,{id:'spec_sw_seq', header: "순번",		width: 10,	sortable: true,	dataIndex: "SPEC_SW_SEQ",		editor: new Ext.form.TextField({ allowBlank : false }) , hidden : true}
			  				    ,{header: "운영체제", 	width: 15,	sortable: true,	dataIndex: "SPEC_OS",			editor: new Ext.form.TextField({ allowBlank : true }) }
								,{header: "소프트웨어", 	width: 20,	sortable: true,	dataIndex: "SPEC_SW",			editor: new Ext.form.TextField({ allowBlank : true }) }
								,{header: "사용여부", 	width: 8,	sortable: true,	dataIndex: "USE_YN",			editor: new Ext.form.TextField({ allowBlank : true }) }
								,{header: "비고", 		width: 10,	sortable: true,	dataIndex: "NOTE",				editor: new Ext.form.TextField({ allowBlank : true }) }
								,{header: "최종변경자ID",	width: 10,	sortable: true,	dataIndex: "FINAL_MOD_ID",		editor: new Ext.form.TextField({ allowBlank : true }) , hidden : true}
								,{header: "최종변경일시",	width: 10,	sortable: true,	dataIndex: "FINAL_MOD_DATE",	editor: new Ext.form.TextField({ allowBlank : true }) , hidden : true}
						  	  ];

// 맵핑 필드
var	mappingColumns_3rd	= [  
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

// 그리드 클릭                                                                                                                                                                                         
function fnGridOnClick_3rd(store, rowIndex){}	

/***************************************************************************
 * 설  명 : 편집그리드 설정 (담당자 정보 )
***************************************************************************/
var	gridHeigth_4th	= 200;
var	gridWidth_4th   = 300	;
var	gridTitle_4th   = "담당자 정보"	; 
var	render_4th		= "custom_member_grid";
var pageSize_4th	= 4;
var limit_4th		= pageSize_4th;
var start_4th		= 0;
var proxyUrl_4th	= "/com/item/result_4th.sg";

// 페이징
function fnPagingValue_4th(){	
	try{
		GridClass_4th.store.setBaseParam('start'			,start_4th);
	    GridClass_4th.store.setBaseParam('limit'			,limit_4th);
	    GridClass_4th.store.setBaseParam('item_code'		,Ext.get('item_code').getValue());
		GridClass_4th.store.setBaseParam('item_type_code'	,Ext.get('item_type_code').getValue());
	}catch(e){

	}
}

// 그리드 필드
var	userColumns_4th	= [ 
							 	 {header: "품목구분코드",	width: 10,	sortable: true,	dataIndex: "ITEM_TYPE_CODE",	editor: new Ext.form.TextField({ allowBlank : false }) , hidden : true}
								,{header: "품목코드",		width: 10,	sortable: true,	dataIndex: "ITEM_CODE",			editor: new Ext.form.TextField({ allowBlank : false }) , hidden : true}
								,{header: "순번",		width: 10,	sortable: true,	dataIndex: "ITEM_INFO_SEQ",		editor: new Ext.form.TextField({ allowBlank : false }) , hidden : true}
								,{header: "사번", 		width: 10,	sortable: true,	dataIndex: "EMP_NUM",			editor: new Ext.form.TextField({ allowBlank : true }) }
								,{header: "이름", 		width: 15,	sortable: true,	dataIndex: "EMP_NAME",			editor: new Ext.form.TextField({ allowBlank : true }) }
								,{header: "사용여부", 	width: 10,	sortable: true,	dataIndex: "USE_YN",			editor: new Ext.form.TextField({ allowBlank : true }) }
								,{header: "비고", 		width: 10,	sortable: true,	dataIndex: "NOTE",				editor: new Ext.form.TextField({ allowBlank : true }) }
								,{header: "최종변경자ID",	width: 10,	sortable: true,	dataIndex: "FINAL_MOD_ID",		editor: new Ext.form.TextField({ allowBlank : true }) , hidden : true}
								,{header: "최종변경일시",	width: 10,	sortable: true,	dataIndex: "FINAL_MOD_DATE",	editor: new Ext.form.TextField({ allowBlank : true }) , hidden : true}
						  	  ];

// 맵핑 필드
var	mappingColumns_4th	= [  
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

// 그리드 클릭                                                                                                                                                                                         
function fnGridOnClick_4th(store, rowIndex){}	

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

}  		
/***************************************************************************
 * 설  명 : 이벤트 설정
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
		fnSearch();
	});	
			
});

</script>

<body>
<input type="hidden" id="item_code" name="item_code"/>
<input type="hidden" id="item_type_code" name="item_type_code"/>
	<table border="0" width="1000" height="200">
		<tr>
			<td>
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
								<table border="0" width="100%">
									<%-- 1 Row Start --%>
									<tr>
										<td width="20%">
											<div tabindex="-1" class="x-form-item " >
												<label class="x-form-item-label" style="width: auto;" for="src_item_code">품목코드 :</label>
												<div style="padding-left: 30px;" class="x-form-element">
														<input type="text" name="src_item_code" id="src_item_code" autocomplete="off" size="15" class="x-form-text x-form-field" style="width: auto;">
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
												<div style="padding-left: 30px;" class="x-form-element">
													<input type="text" name="src_item_name" id="src_item_name" autocomplete="off" size="15" class="x-form-text x-form-field" style="width: auto;">
												</div>
											</div>
										</td>
										
										<td width="20%">
											<div tabindex="-1" class="x-form-item " >
												<label class="x-form-item-label" style="width: auto;" for="src_item_pattern_code" >품목유형 :</label>
												<div style="padding-left: 80px;" class="x-form-element">
													<select name="src_item_pattern_code" id="src_item_pattern_code" style="width: 100px;" type="text" class=" x-form-select x-form-field" >
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
												<div style="padding-left: 80px;" class="x-form-element">
													<select name="src_item_type_code" id="src_item_type_code" style="width: 100px;" type="text" class=" x-form-select x-form-field" >
														<option value="">전체</option>
														<c:forEach items="${ITEM_TYPE_CODE}" var="data" varStatus="status">
														<option value="${data.COM_CODE}"><c:out value="${data.COM_CODE_NAME}"/></option>
														</c:forEach>
													</select>
												</div>
											</div>
										</td>
										
										<td width="20%" align="right">
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
			<td width="100%" valign="top">
				<div id="item_grid_1st" style="margin-top: 0em;"></div> <!----------------- 그리드명을 동일하게 설정 ----------------->		
			</td>
			<!------------------------------ GRID END ------------------------------------>
		</tr>
		<tr id="show_grid">
			<td>
				<table>
					<tr>
						<td width="30%">
							<div id="sw_grid" style="margin-top: 0em;"></div> <!----------------- 그리드명을 동일하게 설정 ----------------->		
						</td>
						<td width="40%">
							<div id="hw_grid" style="margin-top: 0em;"></div> <!----------------- 그리드명을 동일하게 설정 ----------------->
						</td>
						<td width="30%">
							<div id="custom_member_grid" style="margin-top: 0em;"></div> <!----------------- 그리드명을 동일하게 설정 ----------------->
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
</body>

<%@ include file="/WEB-INF/web/jsp/sgis-bottom-inc.jsp" %>