<%--
  Class Name  : estimateInfoInquiry.jsp
  Description : 견적정보조회
  Modification Information
 
      수정일                   수정자                 수정내용
  -------      --------    ---------------------------
  2011. 3. 21   고기범            최초 생성   
  
  author   : 고기범
  since    : 2011. 3. 21.
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
<script type="text/javascript">
/***************************************************************************
 *  견적기본정보 -- 초기값 설정 
 ***************************************************************************/
var	gridHeigth_1st 	 	= 300; 							// 그리드 전체 높이
var	gridWidth_1st		= 1000;							// 그리드 전체 폭
var gridTitle_1st 		= "견적 기본정보";	  			// 그리드 제목
var	render_1st			= "estimateBasicInfo_grid";		// 렌더(화면에 그려질) 할 id 
var	pageSize_1st		= 10;	  						// 그리드 페이지 사이즈	
var	proxyUrl_1st		= "/est/estimate/estimateInfoManageList.sg";  // 결과 값 페이지
var limit_1st			= pageSize_1st;
var start_1st			= 0;

// 그리드의 페이지 클릭시 검색조건값을 DB로 전송
function fnPagingValue_1st(){
	
	try{
		GridClass_1st.store.setBaseParam('start'		 	  ,start_1st);
	    GridClass_1st.store.setBaseParam('limit'		 	  ,limit_1st);
		GridClass_1st.store.setBaseParam('src_pjt_id'      	  ,Ext.get('src_pjt_id').getValue());		  	// 프로젝트ID   
		GridClass_1st.store.setBaseParam('src_pjt_name'    	  ,Ext.get('src_pjt_name').getValue());		  	// 프로젝트
		//GridClass_1st.store.setBaseParam('src_custom_code' 	  ,Ext.get('src_custom_code').getValue());    	// 거래처코드  
		GridClass_1st.store.setBaseParam('src_custom_name' 	  ,Ext.get('src_custom_name').getValue());    	// 거래처명
		GridClass_1st.store.setBaseParam('src_est_type_code'  ,Ext.get('src_est_type_code').getValue());   	// 견적구분 
		GridClass_1st.store.setBaseParam('src_est_id' 		  ,Ext.get('src_est_id').getValue());         	// 견적ID
		GridClass_1st.store.setBaseParam('src_est_name'		  ,Ext.get('src_est_name').getValue());        	// 견적
		GridClass_1st.store.setBaseParam('src_est_date_start' ,Ext.get('src_est_date_start').getValue()); 	// 견적기간(검색시작일)
		GridClass_1st.store.setBaseParam('src_est_date_end'   ,Ext.get('src_est_date_end').getValue());     // 견적기간(검색종료일)
		GridClass_1st.store.setBaseParam('src_final_version'  ,Ext.get('src_final_version').getValue());   	// 최종버전 
	}catch(e){

	}
}
   
// Grid의 컬럼 설정
var userColumns_1st =  [ {header: '상태'                	,width:  0  ,sortable: true ,dataIndex: 'FLAG'                  ,hidden : true}              
					   , {header: '견적ID'              	,width: 110  ,sortable: true ,dataIndex: 'EST_ID'                }
					   , {header: '견적명'              	,width: 250  ,sortable: true ,dataIndex: 'EST_NAME'              }
					   , {header: '버전'                	,width:  40  ,sortable: true ,dataIndex: 'EST_VERSION'			}               
					   , {header: '프로젝트ID'          	,width: 100  ,sortable: true ,dataIndex: 'PJT_ID'                }
					   , {header: '프로젝트'          	,width: 140  ,sortable: true ,dataIndex: 'PJT_NAME'              }
					   , {header: '진행상태'           	,width: 90  ,sortable: true ,dataIndex: 'PROC_STATUS_NAME'      }              
					   , {header: '진행상태'           	,width:  0  ,sortable: true ,dataIndex: 'PROC_STATUS_CODE'      ,hidden : true}
					   , {header: '견적구분'            	,width: 65  ,sortable: true ,dataIndex: 'EST_TYPE_NAME'         }
					   , {header: '견적구분'            	,width:  0  ,sortable: true ,dataIndex: 'EST_TYPE_CODE'         ,hidden : true}              
					   , {header: '거래처'           	,width: 135  ,sortable: true ,dataIndex: 'CUSTOM_NAME'           }              
					   , {header: '견적일자'            	,width: 70  ,sortable: true ,dataIndex: 'EST_DATE'              }
					   , {header: '업무구분코드'        	,width:  0  ,sortable: true ,dataIndex: 'ROLL_TYPE_CODE'        ,hidden : true}
					   , {header: '견적부서코드'        	,width:  0  ,sortable: true ,dataIndex: 'EST_DEPT_CODE'         ,hidden : true}
					   , {header: '견적부서'          	,width:  0  ,sortable: true ,dataIndex: 'EST_DEPT_NAME'         ,hidden : true}
					   , {header: '견적담당자사번'      	,width:  0  ,sortable: true ,dataIndex: 'EST_EMP_NUM'           ,hidden : true}
					   , {header: '견적담당자'        	,width:  0  ,sortable: true ,dataIndex: 'EST_EMP_NAME'           ,hidden : true}
					   , {header: '거래처코드'          	,width:  0  ,sortable: true ,dataIndex: 'CUSTOM_CODE'           ,hidden : true}
					   , {header: '거래처담당자번호'	 	,width:  0  ,sortable: true ,dataIndex: 'COSTOMER_NUM'          ,hidden : true}
					   , {header: '거래처담당자'	    	,width:  0  ,sortable: true ,dataIndex: 'COSTOMER_NAME'          ,hidden : true}
					   , {header: '견적유효기간구분코드'	,width:  0  ,sortable: true ,dataIndex: 'EST_VALID_TYPE_CODE'   ,hidden : true}
					   , {header: '납품예정일'          	,width:  0  ,sortable: true ,dataIndex: 'DELIVERY_EXP_DATE'     ,hidden : true}
					   , {header: '납품처코드'          	,width:  0  ,sortable: true ,dataIndex: 'DELIVERY_CUSTOM_CODE'  ,hidden : true}
					   , {header: '지불조건'            	,width:  0  ,sortable: true ,dataIndex: 'PAY_CONDITON'          ,hidden : true}
					   , {header: '견적총액'            	,width:  0  ,sortable: true ,dataIndex: 'EST_TOTAL_AMT'         ,hidden : true ,renderer: "korMoney" , align : 'right'}
					   , {header: '할인총액'            	,width:  0  ,sortable: true ,dataIndex: 'DISCNT_TOTAL_AMT'      ,hidden : true ,renderer: "korMoney" , align : 'right'}
					   , {header: '견적적용총액'        	,width:  0  ,sortable: true ,dataIndex: 'EST_APLY_TOTAL_AMT'    ,hidden : true ,renderer: "korMoney" , align : 'right'}
					   , {header: '견적적용총세액'      	,width:  0  ,sortable: true ,dataIndex: 'EST_APLY_TOTAL_TAX'    ,hidden : true ,renderer: "korMoney" , align : 'right'}
					   , {header: '프로젝트기간  FROM'   	,width:  0  ,sortable: true ,dataIndex: 'PJT_DATE_FROM'         ,hidden : true}
					   , {header: '구축기간 To'          	,width:  0  ,sortable: true ,dataIndex: 'PJT_DATE_TO'           ,hidden : true}
					   , {header: '참고사항'            	,width:  0  ,sortable: true ,dataIndex: 'REF_DESC'              ,hidden : true}
					   , {header: '최종변경자ID'        	,width:  0  ,sortable: true ,dataIndex: 'FINAL_MOD_ID'          ,hidden : true}
					   , {header: '최종변경일시'   		,width:  0  ,sortable: true ,dataIndex: 'FINAL_MOD_DATE'        ,hidden : true}
					   ];	 

// 그리드 결과매핑 
var mappingColumns_1st = [ {name: 'FLAG'                , allowBlank: false}	// 상태'                 
						 , {name: 'EST_ID'              , allowBlank: false}	// 견적ID               
						 , {name: 'EST_VERSION'		    , allowBlank: false}	// 버전                
						 , {name: 'PROC_STATUS_CODE'    , allowBlank: false}	// 진행상태코드        
						 , {name: 'PROC_STATUS_NAME'    , allowBlank: false}	// 진행상태
						 , {name: 'EST_TYPE_CODE'       , allowBlank: false}	// 견적구분   
						 , {name: 'EST_TYPE_NAME'       , allowBlank: false}	// 견적구분  
						 , {name: 'CUSTOM_NAME'         , allowBlank: false}	// 거래처코드           
						 , {name: 'EST_DATE'            , allowBlank: false}	// 견적일자             
						 , {name: 'ROLL_TYPE_CODE'      , allowBlank: false}	// 업무구분코드         
						 , {name: 'PJT_ID'              , allowBlank: false}	// 프로젝트ID  
						 , {name: 'PJT_NAME'            , allowBlank: false}	// 프로젝트
						 , {name: 'EST_NAME'            , allowBlank: false}	// 견적명               
						 , {name: 'EST_DEPT_CODE'       , allowBlank: false}	// 견적부서코드  
						 , {name: 'EST_DEPT_NAME'       , allowBlank: false}	// 견적부서
						 , {name: 'EST_EMP_NUM'         , allowBlank: false}	// 견적담당자사번   
						 , {name: 'EST_EMP_NAME'        , allowBlank: false}	// 견적담당자 
						 , {name: 'CUSTOM_CODE'         , allowBlank: false}	// 거래처코드           
						 , {name: 'COSTOMER_NUM'        , allowBlank: false}	// 거래처담당자번호 
						 , {name: 'COSTOMER_NAME'       , allowBlank: false}	// 거래처담당자
						 , {name: 'EST_VALID_TYPE_CODE' , allowBlank: false}	// 견적유효기간구분코드 
						 , {name: 'DELIVERY_EXP_DATE'   , allowBlank: false}	// 납품예정일           
						 , {name: 'DELIVERY_CUSTOM_CODE', allowBlank: false}	// 납품처코드           
						 , {name: 'PAY_CONDITON'        , allowBlank: false}	// 지불조건             
						 , {name: 'EST_TOTAL_AMT'       , allowBlank: false}	// 견적총액             
						 , {name: 'DISCNT_TOTAL_AMT'    , allowBlank: false}	// 할인총액             
						 , {name: 'EST_APLY_TOTAL_AMT'  , allowBlank: false}	// 견적적용총액         
						 , {name: 'EST_APLY_TOTAL_TAX'  , allowBlank: false}	// 견적적용총세액       
						 , {name: 'PJT_DATE_FROM'       , allowBlank: false}	// 프로젝트기간 FROM  
						 , {name: 'PJT_DATE_TO'         , allowBlank: false}	// 구축기간 To          
						 , {name: 'REF_DESC'            , allowBlank: false}	// 침고시항             
						 , {name: 'FINAL_MOD_ID'        , allowBlank: false}	// 최종변경자ID         
						 , {name: 'FINAL_MOD_DATE'      , allowBlank: false}	// 최종변경일시 
    				 	 ];
 
/***************************************************************************
 * 견적기본정보 --- 그리드 클릭시 Event
 ***************************************************************************/
function fnGridOnClick_1st(store, rowIndex){
	
	fnInitValue();

	var keyValue1 = fnFixNull(store.getAt(rowIndex).data.EST_VERSION);		 // 버전
	var keyValue2 = fnFixNull(store.getAt(rowIndex).data.EST_ID);			 // 견적ID
	
	fnSearchEdit1st(keyValue1,keyValue2,'');
	fnSearchEdit2nd(keyValue1,keyValue2,'');
}   

// 견적품목 정보 조회
function fnSearchEdit1st(keyValue1,keyValue2,value3){
	
	Ext.Ajax.request({
		url: "/est/estimate/result_edit_1st.sg" 
		,success: function(response){						// 조회결과 성공시
					GridClass_edit_1st.store.commitChanges();	// 변경된 record를 commit
					GridClass_edit_1st.store.removeAll();		// store자료를 삭제
						
					// 조회된 결과값, store명
					var json = Ext.util.JSON.decode(response.responseText);
					GridClass_edit_1st.store.loadData(json);
					
					if(value3 != '' && value3 != 'undefined'){
		
						var rowCnt1st = GridClass_edit_1st.store.getCount();  // Grid의 총갯수
						
						for(i = 0 ; i < rowCnt1st ; i++){
							var record1 = GridClass_edit_1st.store.getAt(i);
							record1.set('FLAG', 'I');
							record1.set('EST_VERSION', value3);						
						} // end for	
					}
		          }
		,failure: handleFailure 
		,params : {
				   // 페이지 		
					 limit			: limit_edit_1st
				   , start			: start_edit_1st
				   // 키 value
				   , est_version	: keyValue1
				   , est_id			: keyValue2
				  }				
	}); // end Ext.Ajax.request   
}

// 납품처 시스템사양 정보 조회
function fnSearchEdit2nd(keyValue1,keyValue2,value3){
	
	Ext.Ajax.request({
		url: "/est/estimate/result_edit_2nd.sg" 
		,success: function(response){						// 조회결과 성공시
					// 조회된 결과값, store명
					GridClass_edit_2nd.store.commitChanges();
					GridClass_edit_2nd.store.removeAll();
					
					var json = Ext.util.JSON.decode(response.responseText);
					GridClass_edit_2nd.store.loadData(json);
			
					if(value3 != '' && value3 != 'undefined'){
						
						var rowCnt2nd = GridClass_edit_1st.store.getCount();  // Grid의 총갯수
					
						for(j = 0 ; j < rowCnt2nd ; j++){
							var record2 = GridClass_edit_2nd.store.getAt(j);
							record2.set('FLAG', 'I');
							record2.set('EST_VERSION', value3);						
						} // end for
					}
		          }
		,failure: handleFailure 
		,params : {
				   // 페이지 		
					 limit			: limit_edit_2nd
				   , start			: start_edit_2nd
				   // 키 value
				   , est_version	: keyValue1
				   , est_id			: keyValue2
				  }				
	}); // end Ext.Ajax.request   
}

/***************************************************************************
 * 설  명 : 편집그리드 설정 (견적품목정보)
***************************************************************************/
var	gridHeigth_edit_1st	= 200;
var	gridWidth_edit_1st  = 1000	;
var	gridTitle_edit_1st  = "견적 품목정보"	; 
var	render_edit_1st		= "edit_grid_1st";
var keyNm_edit_1st		= "EST_INFO_SEQ";
var pageSize_edit_1st	= 1000;
var limit_edit_1st		= pageSize_edit_1st;
var start_edit_1st		= 0;
var proxyUrl_edit_1st	= "/est/estimate/result_edit_1st.sg";
var gridRowDeleteYn	    = "";
var tbarHidden_edit_1st = "Y";

// 행추가
function addNew_edit_1st(){
			
	var Plant = GridClass_edit_1st.grid.getStore().recordType; 
    var p = new Plant({ 
	        		    FLAG			: 'I' 
	        		  , EST_ID		    : Ext.get('est_id').getValue()
				   	  , EST_VERSION	    : Ext.get('est_version').getValue()
  				   	  , CNT             : 0
				   	  , UNIT_PRICE      : 0
				   	  , AMT             : 0
				   	  , DISCOUNT_RATIO  : 0
		    		  , USE_YN          : 'Y'
    				  }); 
  	GridClass_edit_1st.grid.stopEditing();
	GridClass_edit_1st.store.insert(0, p);
	GridClass_edit_1st.grid.startEditing(0, 0);
}

// 페이징
function fnPagingValue_edit_1st(){	
	try{
		GridClass_edit_1st.store.setBaseParam('start'		,start_edit_1st);
	    GridClass_edit_1st.store.setBaseParam('limit'		,limit_edit_1st);
	    GridClass_edit_1st.store.setBaseParam('est_id'		,Ext.get('est_id').getValue());
		GridClass_edit_1st.store.setBaseParam('est_version'	,Ext.get('est_version').getValue());
	}catch(e){

	}
}

/** 유무상구분코드 combo box 생성 start **/
var PAY_FREE_CODE_COMBO = new Ext.form.ComboBox({    
 typeAhead: true, 
 triggerAction: 'all',
 lazyRender:true,
 mode: 'local',
 valueField: 'value',
 displayField: 'displayText',
 valueNotFoundText: '',
 editable : false,
 store: new Ext.data.ArrayStore({
   id: 0,
   fields: ['value', 'displayText'],
   data: [
	   ['',''],
     <c:forEach items="${PAY_FREE_CODE}" var="data" varStatus="status">
      ['${data.COM_CODE}', '${data.COM_CODE_NAME}']
      <c:if test="${not status.last}">,</c:if>
     </c:forEach>
      ]
   })
});
//combo box render
Ext.util.Format.comboRenderer = function(PAY_FREE_CODE_COMBO){    
 return function(value){        
 var record = PAY_FREE_CODE_COMBO.findRecord(PAY_FREE_CODE_COMBO.valueField, value);        
 return record ? record.get(PAY_FREE_CODE_COMBO.displayField) : PAY_FREE_CODE_COMBO.valueNotFoundText;    
}}

// 그리드 필드
var	userColumns_edit_1st	= [ {header: "버전",			width: 0,	sortable: true,	dataIndex: "EST_VERSION"		,hidden:true}
							  , {header: "견적ID",		width: 0,	sortable: true,	dataIndex: "EST_ID"				,hidden:true}
		  , {id:'est_info_seq',  header: "순번",			width: 0,	sortable: true,	dataIndex: "EST_INFO_SEQ"		,hidden:true}
							  , {header: "품목코드",		width: 0,	sortable: true,	dataIndex: "ITEM_CODE"			,hidden:true}
							  , {header: "품목명",		width: 200,	sortable: true,	dataIndex: "ITEM_NAME"			}
							  , {header: "수량",			width: 50,	sortable: true,	dataIndex: "CNT"				,align : 'right'}
							  , {header: "단가",			width: 90,	sortable: true,	dataIndex: "UNIT_PRICE"			,renderer: "korMoney" , align : 'right'}
							  , {header: "금액",			width: 90,	sortable: true,	dataIndex: "AMT"				,renderer: "korMoney" , align : 'right'}
							  , {header: "할인율",		width: 50,	sortable: true,	dataIndex: "DISCOUNT_RATIO"		,align : 'right'}
							  , {header: "유무상구분",	width: 75,	sortable: true,	dataIndex: "PAY_FREE_CODE"		,renderer: Ext.util.Format.comboRenderer(PAY_FREE_CODE_COMBO)}
							  , {header: "적용단가",		width: 90,	sortable: true,	dataIndex: "APLY_UNIT_PRICE"	,renderer: "korMoney" , align : 'right'}
							  , {header: "적용금액",		width: 90,	sortable: true,	dataIndex: "APLY_AMT"			,renderer: "korMoney" , align : 'right'}
							  , {header: "적용세액",		width: 90,	sortable: true,	dataIndex: "APLY_TAX"			,renderer: "korMoney" , align : 'right'}
							  , {header: "비고",			width: 175,	sortable: true,	dataIndex: "NOTE"				}
							  , {header: "최종변경자ID",	width: 0,	sortable: true,	dataIndex: "FINAL_MOD_ID"		,hidden:true}
							  , {header: "최종변경일시",	width: 0,	sortable: true,	dataIndex: "FINAL_MOD_DATE"		,hidden:true}
							  ];

// 맵핑 필드
var	mappingColumns_edit_1st	= [  
							    {name: "EST_VERSION", 		type:"string", mapping: "EST_VERSION"}
							  , {name: "EST_ID", 			type:"string", mapping: "EST_ID"}
							  , {name: "EST_INFO_SEQ", 		type:"string", mapping: "EST_INFO_SEQ"}
							  , {name: "ITEM_CODE", 		type:"string", mapping: "ITEM_CODE"}
							  , {name: "ITEM_NAME", 		type:"string", mapping: "ITEM_NAME"}
							  , {name: "CNT", 				type:"string", mapping: "CNT"}
							  , {name: "UNIT_PRICE", 		type:"string", mapping: "UNIT_PRICE"}
							  , {name: "AMT", 				type:"string", mapping: "AMT"}
							  , {name: "DISCOUNT_RATIO",	type:"string", mapping: "DISCOUNT_RATIO"}
							  , {name: "PAY_FREE_CODE", 	type:"string", mapping: "PAY_FREE_CODE"}
							  , {name: "APLY_UNIT_PRICE", 	type:"string", mapping: "APLY_UNIT_PRICE"}
							  , {name: "APLY_AMT", 			type:"string", mapping: "APLY_AMT"}
							  , {name: "APLY_TAX", 			type:"string", mapping: "APLY_TAX"}       
							  , {name: "NOTE", 				type:"string", mapping: "NOTE"}           
							  , {name: "FINAL_MOD_ID", 		type:"string", mapping: "FINAL_MOD_ID"}   
							  , {name: "FINAL_MOD_DATE", 	type:"string", mapping: "FINAL_MOD_DATE"} 
	    				 	  ]; 
 

/***************************************************************************
 * 설  명 : 편집그리드 설정 (납품처 시스템 사양정보)
***************************************************************************/
var	gridHeigth_edit_2nd	= 200;
var	gridWidth_edit_2nd  = 1000;
var	gridTitle_edit_2nd  = "납품처 시스템 사양정보"	; 
var	render_edit_2nd		= "edit_grid_2nd";
var keyNm_edit_2nd		= "EST_INFO_SEQ";
var pageSize_edit_2nd	= 4;
var limit_edit_2nd		= pageSize_edit_2nd;
var start_edit_2nd		= 0;
var proxyUrl_edit_2nd	= "/est/estimate/result_edit_2nd.sg";
var grid2ndRowDeleteYn  = "";
var tbarHidden_edit_2nd = "Y";

// 행추가
function addNew_edit_2nd(){
	var Plant = GridClass_edit_2nd.grid.getStore().recordType; 
    var p = new Plant({ 
	        		    FLAG			: 'I' 
	        		  , EST_ID		    : Ext.get('est_id').getValue()
				   	  , EST_VERSION	    : Ext.get('est_version').getValue()
		    		  , USE_YN          : 'Y'
    				  }); 
  	GridClass_edit_2nd.grid.stopEditing();
	GridClass_edit_2nd.store.insert(0, p);
	GridClass_edit_2nd.grid.startEditing(0, 0);
}

// 페이징
function fnPagingValue_edit_2nd(){	
	try{
		GridClass_edit_2nd.store.setBaseParam('start'		,start_edit_2nd);
	    GridClass_edit_2nd.store.setBaseParam('limit'		,limit_edit_2nd);
	    GridClass_edit_2nd.store.setBaseParam('est_id'		,Ext.get('est_id').getValue());
		GridClass_edit_2nd.store.setBaseParam('est_version'	,Ext.get('est_version').getValue());
	}catch(e){

	}
}

// 제원구분코드 combo box 생성 start 
var SPEC_TYPE_CODE_COMBO = new Ext.form.ComboBox({    
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
     <c:forEach items="${SPEC_TYPE_CODE}" var="data" varStatus="status">
      ['${data.COM_CODE}', '${data.COM_CODE_NAME}']
      <c:if test="${not status.last}">,</c:if>
     </c:forEach>
      ]
   })
});

//combo box render
Ext.util.Format.comboRenderer = function(SPEC_TYPE_CODE_COMBO){    
 return function(value){        
 var record = SPEC_TYPE_CODE_COMBO.findRecord(SPEC_TYPE_CODE_COMBO.valueField, value);        
 return record ? record.get(SPEC_TYPE_CODE_COMBO.displayField) : SPEC_TYPE_CODE_COMBO.valueNotFoundText;    
}}

// 그리드 필드
var	userColumns_edit_2nd	= [ {header: "버전",			width:   0,	sortable: true,	dataIndex: "EST_VERSION"	,hidden:true}
							  , {header: "견적ID",		width:   0,	sortable: true,	dataIndex: "EST_ID"			,hidden:true}
							  , {header: "순번",			width:   0,	sortable: true,	dataIndex: "EST_INFO_SEQ"	,hidden:true}
							  , {header: "제원구분코드",	width: 100,	sortable: true,	dataIndex: "SPEC_TYPE_CODE"	,renderer: Ext.util.Format.comboRenderer(SPEC_TYPE_CODE_COMBO) }
							  , {header: "제원설명",		width: 320,	sortable: true,	dataIndex: "SPEC_INTRO"		}
							  , {header: "제원수량",		width:  80,	sortable: true,	dataIndex: "SPEC_CNT"		}
							  , {header: "제원용량",		width: 100,	sortable: true,	dataIndex: "SPEC_VOL"		}
							  , {header: "비고",			width: 400,	sortable: true,	dataIndex: "NOTE"			}
							  , {header: "최종변경자ID",	width:   0,	sortable: true,	dataIndex: "FINAL_MOD_ID"	, hidden:true}
							  , {header: "최종변경일시",	width:   0,	sortable: true,	dataIndex: "FINAL_MOD_DATE"	, hidden:true}
							  ];

// 맵핑 필드
var	mappingColumns_edit_2nd	= [ {name: "EST_VERSION", 	type:"string", mapping: "EST_VERSION"}		// 버전        
							  , {name: "EST_ID", 		type:"string", mapping: "EST_ID"}			// 견적ID      
							  , {name: "EST_INFO_SEQ", 	type:"string", mapping: "EST_INFO_SEQ"}		// 순번        
							  , {name: "SPEC_TYPE_CODE",type:"string", mapping: "SPEC_TYPE_CODE"}	// 제원구분코드
							  , {name: "SPEC_INTRO", 	type:"string", mapping: "SPEC_INTRO"}		// 제원설명    
							  , {name: "SPEC_CNT", 		type:"string", mapping: "SPEC_CNT"}			// 제원수량    
							  , {name: "SPEC_VOL", 		type:"string", mapping: "SPEC_VOL"}			// 제원용량    
							  , {name: "NOTE", 			type:"string", mapping: "NOTE"}				// 비고        
							  , {name: "FINAL_MOD_ID", 	type:"string", mapping: "FINAL_MOD_ID"}		// 최종변경자ID
							  , {name: "FINAL_MOD_DATE",type:"string", mapping: "FINAL_MOD_DATE"}	// 최종변경일시
	    				 	  ]; 

/***************************************************************************
 * 설  명 : 필드 초기화
 **************************************************************************/
function fnInitValue(){
	
	try{
		GridClass_edit_1st.store.commitChanges();	// 변경된 record를 commit
		GridClass_edit_1st.store.removeAll();		// store자료를 삭제
		GridClass_edit_2nd.store.commitChanges();
		GridClass_edit_2nd.store.removeAll();
	}catch(e){
		
	}
}

/***************************************************************************
 * 설  명 : 검색
 **************************************************************************/
function fnSearch(){  	
	
	Ext.Ajax.request({   
		url: "/est/estimate/estimateInfoManageList.sg"
		,method : 'POST'   
		,success: function(response){						// 조회결과 성공시
					// 조회된 결과값, store명
					handleSuccess(response,GridClass_1st);
		          }   							
		,failure: handleFailure   	   						// 조회결과 실패시  
		,params : {					   						// 조회조건을 DB로 전송하기위해서 조건값 설정
					limit              : limit_1st
				  , start              : start_1st
				  , src_pjt_id   	   : Ext.get('src_pjt_id').getValue()		  // 프로젝트ID   
				  , src_pjt_name   	   : Ext.get('src_pjt_name').getValue()		  // 프로젝트
			  	  //, src_custom_code    : Ext.get('src_custom_code').getValue()    // 거래처코드  
			  	  , src_custom_name    : Ext.get('src_custom_name').getValue()    // 거래처명
			  	  , src_est_type_code  : Ext.get('src_est_type_code').getValue()  // 견적구분 
			  	  , src_est_id         : Ext.get('src_est_id').getValue()         // 견적ID
			  	  , src_est_name       : Ext.get('src_est_name').getValue()       // 견적
			  	  , src_est_date_start : Ext.get('src_est_date_start').getValue() // 견적기간(검색시작일)
			  	  , src_est_date_end   : Ext.get('src_est_date_end').getValue()   // 견적기간(검색종료일)
			  	  , src_final_version  : Ext.get('src_final_version').getValue()  // 최종버전    
				  
				  }				
	});  
	
}  		

/***************************************************************************
 * 설  명 : 화면 설정
 ***************************************************************************/
// ExtJS 진입함수
Ext.onReady(function() {

	var sForm = document.searchForm;	// 검색 FORM

	var day = getTimeStamp();	
	var fromDay = day.replaceAll('-','');
	fromDay = addDate(fromDay, 'M', -3);
	fromDay = fromDay.substring(0,4)+"-"+fromDay.substring(4,6)+"-"+fromDay.substring(6,8);
	var toDay = day.replaceAll('-','');
	toDay = addDate(toDay, 'M', 3);
	toDay = toDay.substring(0,4)+"-"+toDay.substring(4,6)+"-"+toDay.substring(6,8);
	
    // 검색버튼 클릭
	Ext.get('searchBtn').on('click', function(e){
        
		var startDate = Ext.get('src_est_date_start').getValue()  // 검색시작일
		var endDate = Ext.get('src_est_date_end').getValue()      // 검색종료일
	  
		if(fnCalDate(startDate,endDate,'D') < 0){
			Ext.Msg.alert('확인', '검색시작일이 검색종료일보다 이전입니다.'); 
		}else{
			fnSearch()
		}	
    });
    
   	//조건해제 버튼 -> 검색조건 초기화
   	Ext.get('searchClearBtn').on('click', function(e){
        sForm.reset();	
        
        //Ext.get('src_est_date_start').set({value : fromDay }, false);
	    //Ext.get('src_est_date_end').set({value : toDay }, false);
	    
	    fnSearch();
    });
   	
   	// 거래처검색 버튼
	Ext.get('src_custom_btn').on('click', function(e){
		var param = '?fieldCode=src_custom_code&fieldName=src_custom_name';
		param = param + '&form=searchForm';
		fnCustomPop(param)
	});
   	   	
   	// 검색조건의 최종버전 체크시
	Ext.get('src_final_version_check').on('click', function(e){
		
		// 체크박스의 ID값으로 체크가 되었다면 'Y' 그렇지 않다면 'N'
		// 해당 ID값을  전부 검색하므로 1개만 검색하는 함수로 변경 필요
		Ext.select("input[name=src_final_version_check]").each(function(el){  
				
				if(el.dom.checked == true){
					Ext.get('src_final_version').set({value:'Y'} , false);
				}else{
					Ext.get('src_final_version').set({value:'N'} , false);
				}
			}  
		);  // end Ext.select
	}); // end Ext.get
   	
	// 견적기간_검색시작일자
	var startDate = new Ext.form.DateField({
    	applyTo: 'src_est_date_start',
		allowBlank: false,
		format:'Y-m-d',
		editable : true,
		value : fromDay
	});
	
	Ext.get('src_est_date_start').on('change', function(e){	
		
		var val = Ext.get('src_est_date_start').getValue();
		var reVal = fnGridDateCheck(val);
		
		Ext.get('src_est_date_start').set({value:reVal} , false);
	});
   	
	// 견적기간_검색종료일자
	var endDate = new Ext.form.DateField({
    	applyTo: 'src_est_date_end',
		allowBlank: false,
		format:'Y-m-d',
		editable : true,
		value : toDay
	});
	
	Ext.get('src_est_date_end').on('change', function(e){	
		
		var val = Ext.get('src_est_date_end').getValue();
		var reVal = fnGridDateCheck(val);
		
		Ext.get('src_est_date_end').set({value:reVal} , false);
	});
	
	// 프로젝트 검색팝업
   	//Ext.get('src_pjt_id_btn').on('click', function(e){
	//	param = "?fieldName=src_pjt_id";
	//	fnPjtPop(param);
	//});
	
	// GridClass_edit_1st.grid.bbar.refresh.hide(); 

	fnInitValue();
	
}); // end Ext.onReady
	
/***************************************************************************
 * 설  명 : 그리드의 페이지 클릭시 검색조건값을 DB로 전송
 ***************************************************************************/
  // 프로젝트 **************************************************
function fnPjtPop(param){
	var sURL      = "/dev/pjdInfo/pjtInfoPop.sg"+param;
	var dlgWidth  = 399;
	var dlgHeight = 444;
	var winName   = "project";
	fnOpenPop(sURL, dlgWidth, dlgHeight, winName);
}

function fnPjtPopValue(records, fieldName){
	
	// 전송받은 값이 한건일 경우
    var record = records[0].data;	
	
    if(fieldName == 'src_pjt_id'){
    	Ext.get('src_pjt_id').set({value:fnFixNull(record.PJT_ID)} , false);
	   // Ext.get('src_pjt_name').set({value:fnFixNull(record.PJT_NAME)} , false);
    }
}
// 거래처 **************************************************
function fnCustomPop(param){
	var sURL      = "/com/custom/customPop.sg"+param;
	var dlgWidth  = 399;
	var dlgHeight = 364;
	var winName   = "custom";
	fnOpenPop(sURL, dlgWidth, dlgHeight, winName);
}

// 팝업
function fnOpenPop(sURL, dlgWidth, dlgHeight, winName){
  var xPos=(window.screen.width) ? (window.screen.width-dlgWidth)/2 : 0;
  var yPos=(window.screen.height) ? (window.screen.height-dlgHeight)/2 : 0;
  var sFeatures = "titlebar=no, scrollbars=no,location=no ,menubar=no, resizable=no, status=yes, width="+dlgWidth+",height="+dlgHeight+",left="+xPos+", top="+yPos;
  window.open(sURL,winName, sFeatures);
}
	
/***************************************************************************
 * 설  명 : 에디트 그리드의 CELL을 클릭하였을 경우 이벤트
 ***************************************************************************/
function  fnEdit1stCellClickEvent(grid, rowIndex, columnIndex, e){
	//거래처 코드 팝업
	if(columnIndex == '2'){			

	}
	//품목 코드 팝업
	if(columnIndex == '3'){

	}
}
/***************************************************************************
 * 설  명 : 에디트 그리드의 CELL을 수정하였을 경우 이벤트
 ***************************************************************************/
function  fnEdit1stAfterCellEdit(obj){

}

function fnEdit1stAfterRowDeleteEvent(){

}
</script>

</head>
<body class=" ext-gecko ext-gecko3">
	<table border="0" width="1000" height="200">
		<tr>
			<td>
				<form name="searchForm" id="searchForm">
				<input type="hidden" name="src_custom_code" id="src_custom_code" autocomplete="off" size="10" class=" x-form-text x-form-field" style="width: auto;">
				<!----------------- SEARCH Hearder Start	 ----------------->
				<div id="ext-comp-1002" class=" x-panel x-form-label-left" style="margin-top: 0em;"><%-- 0em <- 1em으로 수정하면 상위 공백 --%>
					<div class="x-panel-tl">
						<div class="x-panel-tr">
							<div class="x-panel-tc">
								<div id="ext-gen4" class="x-panel-header x-unselectable" style="-moz-user-select: none;">
									<span id="ext-gen8" class="x-panel-header-text">견적정보  검색</span>
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
								<table width="100%" border="0">
						    		<%-- 1 Row Start --%>
						    		<tr>
										<td width="20%">
											<div tabindex="-1" class="x-form-item " >
												<label class="x-form-item-label" style="width: auto;" for="src_pjt_id" >프로젝트ID :</label>
												<div style="padding-left: 0px;" class="x-form-element">
													<input type="text" name="src_pjt_id" id="src_pjt_id" autocomplete="off" size="19" class=" x-form-text x-form-field" style="width: auto;">
												</div>
											</div>
										</td>
										<td width="20%">
											<div tabindex="-1" class="x-form-item " >
												<label class="x-form-item-label" style="width: auto;" for="src_pjt_name" >프로젝트명 :</label>
												<div style="padding-left: 0px;" class="x-form-element">
													<input type="text" name="src_pjt_name" id="src_pjt_name" autocomplete="off" size="19" class=" x-form-text x-form-field" style="width: auto;">
												</div>
											</div>
										</td>
								
										<td width="22%">
											<div tabindex="-1" class="x-form-item " >
										    	<label class="x-form-item-label " style="width: auto;" for="src_custom_name" >&nbsp;&nbsp;&nbsp;거래처명 :</label>
												<div style="padding-left: 0px;" class="x-form-element">
													<input type="text" name="src_custom_name" id="src_custom_name" autocomplete="off" size="23" class=" x-form-text x-form-field" style="width: auto;">
												</div>
											</div>
										</td>
										<td width="5%">
											<div tabindex="-1" class="x-form-item " >
												<div style="padding-left: 0px;" class="x-form-element">
													<%-- 검색 버튼 Start --%>
													<img align="center" id="src_custom_btn" name="src_custom_btn" alt="" src="/resource/images/bass_1st/icon_src1.gif" style="cursor: hand;">
													<%-- 검색 버튼 End	--%>
												</div>
											</div>
										</td>
										<td width="16%">
											<div tabindex="-1" class="x-form-item " >
												<label class="x-form-item-label" style="width: auto;" for="src_est_type_code" >견적구분 :</label>
												<div style="padding-left: 30px;" class="x-form-element">
													<select name="src_est_type_code" id="src_est_type_code" title="견적구분" style="width: 80px;" type="text" class=" x-form-select x-form-field" >
														<option value="">전체</option>
														<c:forEach items="${EST_TYPE_CODE}" var="data" varStatus="status">
														<option value="${data.COM_CODE}"><c:out value="${data.COM_CODE_NAME}"/></option>
														</c:forEach>
													</select>
												</div>
											</div>
										</td>
								
										<td width="20%">
											<div tabindex="-1" class="x-form-item " >
												<label class="x-form-item-label" style="width: auto;" for="src_final_version" >최종버전 :</label>
												<div style="padding-left: 30px;" class="x-form-element">
													<input type="checkbox" name="src_final_version_check" id="src_final_version_check" value="all" autocomplete="off" class=" x-form-checkbox x-form-field" checked="">
													<input type="hidden" name="src_final_version" id="src_final_version" value="Y" autocomplete="off" size="5" class="x-form-text x-form-field" style="width: auto;">
												</div>
											</div>
										</td>
									</tr>
									<%-- 1 Row End --%>
									<%-- 2 Row Start --%>
									<tr>
										<td>
											<div tabindex="-1" class="x-form-item " >
												<label class="x-form-item-label" style="width: auto;" for="src_est_id">견적ID :</label>
												<div style="padding-left: 70px;" class="x-form-element">
													<input type="text" name="src_est_id" id="src_est_id" autocomplete="off" size="19" class=" x-form-text x-form-field" style="width: auto;">
												</div>
											</div>
										</td>
										<td>
											<div tabindex="-1" class="x-form-item " >
												<label class="x-form-item-label" style="width: auto;" for="src_est_name">견적명 :</label>
												<div style="padding-left: 70px;" class="x-form-element">
													<input type="text" name="src_est_name" id="src_est_name" autocomplete="off" size="19" class=" x-form-text x-form-field" style="width: auto;">
												</div>
											</div>
										</td>
										<td colspan="3">
											<div tabindex="-1" class="x-form-item " >
												<label class="x-form-item-label" style="width: auto;" for="src_est_date_start" ><font color="red">* </font>견적기간 :</label>
												<div style="padding-left: 30px;" class="x-form-element">
													<table>
														<tr>
															<td>
																<input type="text" name="src_est_date_start" id="src_est_date_start" autocomplete="off" size="10" style="width: auto;">		
															</td>
															<td>
																~
															</td>
															<td>
																<input type="text" name="src_est_date_end" id="src_est_date_end" autocomplete="off" size="10" style="width: auto;">		
															</td>
														</tr>
													</table>
												</div>
											</div>
										</td>
										<td align="right">
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
									<%-- 2 Row End --%>
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
			<!----------------- 견적기본정보 GRID START ----------------->
			<td width="100%" valign="top">
				<div id="estimateBasicInfo_grid" style="margin-top: 0em;"></div>
			</td>
			<!----------------- 견적기본정보 GRID END ----------------->
		</tr>
		<tr>
			<!----------------- 견적 품목정보 GRID START ----------------->
			<td width="100%" valign="top">
				<div id="edit_grid_1st" style="margin-top: 0em;"></div>
			</td>
			<!----------------- 견적 품목정보 GRID END ----------------->
		</tr>
		<tr>
			<!----------------- 납품처 시스템사양 정보 GRID START ----------------->
			<td width="100%" valign="top">
				<div id="edit_grid_2nd" style="margin-top: 0em;"></div>
			</td>
			<!----------------- 납품처 시스템사양 정보 GRID END ----------------->
		</tr>
	</table>
</body>

<%@ include file="/WEB-INF/web/jsp/sgis-bottom-inc.jsp" %>