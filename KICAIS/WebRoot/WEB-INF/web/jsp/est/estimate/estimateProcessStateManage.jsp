<%--
  Class Name  : estimateProcessStateManage.jsp
  Description : 견적진행상태관리
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

<script type="text/javascript" src="/resource/common/js/grid/grid_edit_1st.js"></script>
<script type="text/javascript" src="/resource/common/js/grid/grid_2nd.js"></script>
<script type="text/javascript">
/***************************************************************************
 *  견적기본정보 -- 초기값 설정 
 ***************************************************************************/
var	gridHeigth_edit_1st 	= 190; 													// 그리드 전체 높이
var	gridWidth_edit_1st		= 1000;													// 그리드 전체 폭
var gridTitle_edit_1st 		= "견적 기본정보";	  									// 그리드 제목
var	render_edit_1st			= "estimateBasicInfo_grid";								// 렌더(화면에 그려질) 할 id 
var keyNm_edit_1st		    = "EST_INFO_SEQ";
var	pageSize_edit_1st		= 5;	  												// 그리드 페이지 사이즈	
var	proxyUrl_edit_1st		= "/est/estimate/estimateProcessStateEstInfoList.sg";	// 결과 값 페이지
var limit_edit_1st			= pageSize_edit_1st;
var start_edit_1st			= 0;
var gridRowDeleteYn	    	= "";
var tbarHidden_edit_1st     = "Y";

// 행추가
function addNew_edit_1st(){
	
}

function fnEdit1stCellClickEvent(grid, rowIndex, columnIndex, e){

}

// 그리드의 페이지 클릭시 검색조건값을 DB로 전송
function fnPagingValue_edit_1st(){
	
	try{
		GridClass_edit_1st.store.setBaseParam('start'				,start_edit_1st);
	    GridClass_edit_1st.store.setBaseParam('limit'		 		,limit_edit_1st);
		GridClass_edit_1st.store.setBaseParam('src_pjt_id'      	,Ext.get('src_pjt_id').getValue());		  		// 프로젝트ID
		GridClass_edit_1st.store.setBaseParam('src_pjt_name'      	,Ext.get('src_pjt_name').getValue());		  	// 프로젝트
		//GridClass_edit_1st.store.setBaseParam('src_custom_code' 	,Ext.get('src_custom_code').getValue());    	// 거래처코드  
		GridClass_edit_1st.store.setBaseParam('src_custom_name' 	,Ext.get('src_custom_name').getValue());    	// 거래처명
		GridClass_edit_1st.store.setBaseParam('src_est_type_code'  	,Ext.get('src_est_type_code').getValue());   	// 견적구분 
		GridClass_edit_1st.store.setBaseParam('src_est_id' 		  	,Ext.get('src_est_id').getValue());         	// 견적ID
		GridClass_edit_1st.store.setBaseParam('src_est_name'	  	,Ext.get('src_est_name').getValue());         	// 견적
		GridClass_edit_1st.store.setBaseParam('src_est_date_start' 	,Ext.get('src_est_date_start').getValue()); 	// 견적기간(검색시작일)
		GridClass_edit_1st.store.setBaseParam('src_est_date_end'   	,Ext.get('src_est_date_end').getValue());     	// 견적기간(검색종료일)
		GridClass_edit_1st.store.setBaseParam('src_proc_status_code',Ext.get('src_proc_status_code').getValue());   // 진행상태
	}catch(e){

	}
}

/** 진행상태코드 combo box 생성 start **/
var FLOW_STATUS_CODE_COMBO = new Ext.form.ComboBox({    
	 typeAhead         : true 
	,triggerAction     : 'all'
	,lazyRender        : true
	,mode              : 'local'
	,valueField        : 'value'
	,displayField      : 'displayText'
	,valueNotFoundText : ''
	,editable          : false
	,store             : new Ext.data.ArrayStore({
	   	id: 0,
	   	fields: ['value', 'displayText'],
	   	data: [
		   	   <c:forEach items="${FLOW_STATUS_CODE}" var="data" varStatus="status">
	       	     <c:if test="${status.index == 0}">['', '']</c:if>
	       		 <c:if test="${fn:substring(data.COM_CODE, 0, 1)== 'B'}">
	        		,['${data.COM_CODE}','${data.COM_CODE_NAME}']
	       		 </c:if>
	     	   </c:forEach>
	       	  ] 
	   })
});

//combo box render
Ext.util.Format.comboRenderer = function(FLOW_STATUS_CODE_COMBO){    
	return function(value){        
	var record = FLOW_STATUS_CODE_COMBO.findRecord(FLOW_STATUS_CODE_COMBO.valueField, value);
	
	if(record != 'undefined'){
		if(value=='B90'){
			return '<span style="color:red; background-color:">' + record.get(FLOW_STATUS_CODE_COMBO.displayField) + '</span>';
		}else if(value=='B50'){
			return '<span style="color:blue; background-color:">' + record.get(FLOW_STATUS_CODE_COMBO.displayField) + '</span>';
		}else{
			return '<span style="cursor:hand;cursor:pointer;background-color:">'+record.get(FLOW_STATUS_CODE_COMBO.displayField)+ '</span>';
		}
	}else{
		return FLOW_STATUS_CODE_COMBO.valueNotFoundText;  
	}
	  
}}

// Grid의 컬럼 설정
var userColumns_edit_1st =  [ {header: '상태'                	,width: 60  ,sortable: true ,dataIndex: 'FLAG'                  ,hidden : true}              
					   , {header: "진행상태"				,width: 60  ,sortable: true ,dataIndex: 'PROC_STATUS_NAME'		,editor: new Ext.form.TextField({ allowBlank : false }), editable:false ,hidden : true }
					   , {header: '진행상태코드'         ,width: 70  ,sortable: true ,dataIndex: 'PROC_STATUS_CODE'      ,editor: FLOW_STATUS_CODE_COMBO  ,renderer: Ext.util.Format.comboRenderer(FLOW_STATUS_CODE_COMBO)}
					   , {header: '이슈등록'			    ,width: 50  ,sortable : true , dataIndex : 'REG_ISSUE'   		,renderer: changeBLUE}
					   , {header: '견적구분'            	,width: 50  ,sortable: true ,dataIndex: 'EST_TYPE_NAME'         }
					   , {header: '견적구분코드'        	,width: 60  ,sortable: true ,dataIndex: 'EST_TYPE_CODE'         ,hidden : true}              
					   , {header: '견적일자'            	,width: 60  ,sortable: true ,dataIndex: 'EST_DATE'              }
					   
					   , {header: '업무구분코드'        	,width: 60  ,sortable: true ,dataIndex: 'ROLL_TYPE_CODE'        ,hidden : true}
					   , {header: '견적ID'              	,width: 60  ,sortable: true ,dataIndex: 'EST_ID'                }              
					   , {header: '버전'                	,width: 30  ,sortable: true ,dataIndex: 'EST_VERSION'			}               
					   , {header: '견적명'              	,width:  0  ,sortable: true ,dataIndex: 'EST_NAME'              ,hidden : true}
					   , {header: '프로젝트ID'          	,width: 60  ,sortable: true ,dataIndex: 'PJT_ID'                }
					   , {header: '프로젝트'          	,width: 110  ,sortable: true ,dataIndex: 'PJT_NAME'              }
					   , {header: '거래처'           	,width: 60  ,sortable: true ,dataIndex: 'CUSTOM_NAME'           } 
					   
					   , {header: '지불조건'            	,width: 60  ,sortable: true ,dataIndex: 'PAY_CONDITON'          ,hidden : true}
					  
					   , {header: '견적총액'            	,width: 70  ,sortable: true ,dataIndex: 'EST_TOTAL_AMT'         ,renderer: "korMoney" , align : 'right'}
					   , {header: '할인총액'            	,width: 70  ,sortable: true ,dataIndex: 'DISCNT_TOTAL_AMT'      ,renderer: "korMoney" , align : 'right'}
					   , {header: '견적적용총액'        	,width: 70  ,sortable: true ,dataIndex: 'EST_APLY_TOTAL_AMT'    ,renderer: "korMoney" , align : 'right'}
					   , {header: '견적적용총세액'      	,width: 70  ,sortable: true ,dataIndex: 'EST_APLY_TOTAL_TAX'    ,renderer: "korMoney" , align : 'right'}
					   , {header: '견적담당자'        	,width: 60  ,sortable: true ,dataIndex: 'EST_EMP_NAME'          ,hidden : true}
					   , {header: '견적부서'          	,width: 60  ,sortable: true ,dataIndex: 'EST_DEPT_NAME'         ,hidden : true}
					   , {header: '참고사항'            	,width: 60  ,sortable: true ,dataIndex: 'REF_DESC'              ,hidden : true}
					   
					   , {header: '견적부서코드'        	,width: 60  ,sortable: true ,dataIndex: 'EST_DEPT_CODE'         ,hidden : true}
					   , {header: '견적담당자사번'      	,width: 60  ,sortable: true ,dataIndex: 'EST_EMP_NUM'           ,hidden : true}
					   , {header: '거래처코드'          	,width: 60  ,sortable: true ,dataIndex: 'CUSTOM_CODE'           ,hidden : true}
					   , {header: '거래처담당자번호'	 	,width: 60  ,sortable: true ,dataIndex: 'COSTOMER_NUM'          ,hidden : true}
					   , {header: '거래처담당자'	    	,width: 60  ,sortable: true ,dataIndex: 'COSTOMER_NAME'         ,hidden : true}
					   , {header: '견적유효기간구분코드'	,width: 60  ,sortable: true ,dataIndex: 'EST_VALID_TYPE_CODE'   ,hidden : true}
					   , {header: '납품예정일'          	,width: 60  ,sortable: true ,dataIndex: 'DELIVERY_EXP_DATE'     ,hidden : true}
					   , {header: '납품처코드'          	,width: 60  ,sortable: true ,dataIndex: 'DELIVERY_CUSTOM_CODE'  ,hidden : true}
					   , {header: '프로젝트기간  FROM'   	,width: 60  ,sortable: true ,dataIndex: 'PJT_DATE_FROM'         ,hidden : true}
					   , {header: '구축기간 To'          	,width: 60  ,sortable: true ,dataIndex: 'PJT_DATE_TO'           ,hidden : true}
					   , {header: '최종변경자ID'        	,width: 60  ,sortable: true ,dataIndex: 'FINAL_MOD_ID'          ,hidden : true}
					   , {header: '최종변경일시'   		,width: 60  ,sortable: true ,dataIndex: 'FINAL_MOD_DATE'        ,hidden : true}
					   , {header: '수정가능여부'   		,width: 60  ,sortable: true ,dataIndex: 'MODIFY_YN'             ,hidden : true}
					   ];	 

// 그리드 결과매핑 
var mappingColumns_edit_1st = [ {name: 'FLAG'                , allowBlank: false}	// 상태'                 
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
							 , {name: 'MODIFY_YN'     	 	, allowBlank: false}	// 수정가능여부
							 , {name: 'REG_ISSUE'			,allowBlank : false}	// 이슈등록
	    				 	 ];

/***************************************************************************
 * 견적 품목정보 --- 초기값 설정 
 ***************************************************************************/
var	gridHeigth_2nd 	 	= 190; 						 // 그리드 전체 높이
var	gridWidth_2nd		= 1000;						 // 그리드 전체 폭
var gridTitle_2nd 		= "견적 품목정보";	   			 // 그리드 제목
var	render_2nd			= "estimateItemInfo-grid";	 // 렌더(화면에 그려질) 할 id 
var	pageSize_2nd		= 5;	  					 // 그리드 페이지 사이즈	
var	proxyUrl_2nd		= "/est/estimate/estimateProcessStateEstItemInfoList.sg"; // 결과 값 페이지
var limit_2nd			= pageSize_2nd;
var start_2nd			= 0;

// 그리드의 페이지 클릭시 검색조건값을 DB로 전송
function fnPagingValue_2nd(){
	
	try{
    	GridClass_2nd.store.setBaseParam('start'			  	,start_2nd);
	    GridClass_2nd.store.setBaseParam('limit'			  	,limit_2nd);
	    GridClass_2nd.store.setBaseParam('src_pjt_id'      	  	,Ext.get('src_pjt_id').getValue());		  		// 프로젝트ID 
	    GridClass_2nd.store.setBaseParam('src_pjt_name'    	  	,Ext.get('src_pjt_name').getValue());		 	// 프로젝트
		// GridClass_2nd.store.setBaseParam('src_custom_code' 	  	,Ext.get('src_custom_code').getValue());    	// 거래처코드  
		GridClass_2nd.store.setBaseParam('src_custom_name' 	  	,Ext.get('src_custom_name').getValue());    	// 거래처명
		GridClass_2nd.store.setBaseParam('src_est_type_code'  	,Ext.get('src_est_type_code').getValue());   	// 견적구분 
		GridClass_2nd.store.setBaseParam('src_est_id' 		  	,Ext.get('src_est_id').getValue());         	// 견적ID
		GridClass_2nd.store.setBaseParam('src_est_name' 	  	,Ext.get('src_est_name').getValue());         	// 견적
		GridClass_2nd.store.setBaseParam('src_est_date_start' 	,Ext.get('src_est_date_start').getValue()); 	// 견적기간(검색시작일)
		GridClass_2nd.store.setBaseParam('src_est_date_end'   	,Ext.get('src_est_date_end').getValue());     	// 견적기간(검색종료일)
		GridClass_2nd.store.setBaseParam('src_proc_status_code' ,Ext.get('src_proc_status_code').getValue());   // 진행상태
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

// Grid의 컬럼 설정
var userColumns_2nd = [ {header: "버전",			width:   0,	sortable: true,	dataIndex: "EST_VERSION",		editor: new Ext.form.TextField({ allowBlank : false }), hidden:true}
					  , {header: "견적ID",		width:   0,	sortable: true,	dataIndex: "EST_ID",			editor: new Ext.form.TextField({ allowBlank : false }), hidden:true}
  				      , {header: "순번"	,		width:   0,	sortable: true,	dataIndex: "EST_INFO_SEQ",		editor: new Ext.form.TextField({ allowBlank : false }), hidden:true}
					  , {header: "품목코드",		width: 130,	sortable: true,	dataIndex: "ITEM_CODE",			editor: new Ext.form.TextField({ allowBlank : false }), editable:true}
					  , {header: "품목명",		width: 180,	sortable: true,	dataIndex: "ITEM_NAME",			editor: new Ext.form.TextField({ allowBlank : false })}
					  , {header: "수량",			width:  40,	sortable: true,	dataIndex: "CNT",				editor: new Ext.form.TextField({ allowBlank : false }), align : 'right'}
					  , {header: "단가",			width:  85,	sortable: true,	dataIndex: "UNIT_PRICE",		editor: new Ext.form.TextField({ allowBlank : false }), renderer: "korMoney" , align : 'right'}
					  , {header: "금액",			width:  85,	sortable: true,	dataIndex: "AMT",				editor: new Ext.form.TextField({ allowBlank : false }), editable:false ,renderer: "korMoney" , align : 'right'}
					  , {header: "할인율",		width:  50,	sortable: true,	dataIndex: "DISCOUNT_RATIO",	editor: new Ext.form.TextField({ allowBlank : false }), align : 'right'}
					  , {header: "유무상구분",	width:  75,	sortable: true,	dataIndex: "PAY_FREE_CODE",		editor: PAY_FREE_CODE_COMBO  ,renderer: Ext.util.Format.comboRenderer(PAY_FREE_CODE_COMBO)}
					  , {header: "적용단가",		width:  85,	sortable: true,	dataIndex: "APLY_UNIT_PRICE",	editor: new Ext.form.TextField({ allowBlank : false }), editable:false ,renderer: "korMoney" , align : 'right'}
					  , {header: "적용금액",		width:  85,	sortable: true,	dataIndex: "APLY_AMT",			editor: new Ext.form.TextField({ allowBlank : false }), editable:false ,renderer: "korMoney" , align : 'right'}
					  , {header: "적용세액",		width:  85,	sortable: true,	dataIndex: "APLY_TAX",			editor: new Ext.form.TextField({ allowBlank : false }), editable:false ,renderer: "korMoney" , align : 'right'}
					  , {header: "비고",			width: 100,	sortable: true,	dataIndex: "NOTE",				editor: new Ext.form.TextField({ allowBlank : false })}
					  , {header: "최종변경자ID",	width:   0,	sortable: true,	dataIndex: "FINAL_MOD_ID",		editor: new Ext.form.TextField({ allowBlank : false }), hidden:true}
					  , {header: "최종변경일시",	width:   0,	sortable: true,	dataIndex: "FINAL_MOD_DATE",	editor: new Ext.form.TextField({ allowBlank : false }), hidden:true}
					  ];	 

// 그리드 결과매핑 
var mappingColumns_2nd = [  {name: "EST_VERSION", 		type:"string", mapping: "EST_VERSION"}
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
 * 견적 품목정보 --- 그리드 클릭시 Event
 ***************************************************************************/
function fnGridOnClick_2nd(store, rowIndex){

}  

/***************************************************************************
 * 설  명 : 검색
 **************************************************************************/
function fnSearchEstInfo(){
	
	Ext.Ajax.request({   
		url: "/est/estimate/estimateProcessStateEstInfoList.sg"
		,method : 'POST'   
		,success: function(response){						// 조회결과 성공시
					// 조회된 결과값, store명
					handleSuccess(response,GridClass_edit_1st);
		          }   							
		,failure: handleFailure   	   						// 조회결과 실패시  
		,params : {					   						// 조회조건을 DB로 전송하기위해서 조건값 설정
					limit          		 : limit_edit_1st
				  , start          		 : start_edit_1st
				  // 검색정보
			  	  , src_pjt_id   	     : Ext.get('src_pjt_id').getValue()		  	  // 프로젝트ID   
			  	  , src_pjt_name   	     : Ext.get('src_pjt_name').getValue()		  // 프로젝트
			  	  //, src_custom_code      : Ext.get('src_custom_code').getValue()   	  // 거래처코드  
			  	  , src_custom_name      : Ext.get('src_custom_name').getValue()      // 거래처명
			  	  , src_est_type_code    : Ext.get('src_est_type_code').getValue()    // 견적구분 
			  	  , src_est_id           : Ext.get('src_est_id').getValue()           // 견적ID
			  	  , src_est_name         : Ext.get('src_est_name').getValue()         // 견적
			  	  , src_est_date_start   : Ext.get('src_est_date_start').getValue()   // 견적기간(검색시작일)
			  	  , src_est_date_end     : Ext.get('src_est_date_end').getValue()     // 견적기간(검색종료일)
			  	  , src_proc_status_code : Ext.get('src_proc_status_code').getValue() // 진행상태    
				  }				
	});  
	
}

function fnSearchEstItemInfo(est_id, est_version){
	
	Ext.Ajax.request({   
		url: "/est/estimate/estimateProcessStateEstItemInfoList.sg"
		,method : 'POST'   
		,success: function(response){						// 조회결과 성공시
					// 조회된 결과값, store명
					handleSuccess(response,GridClass_2nd);
		          }   							
		,failure: handleFailure   	   						// 조회결과 실패시  
		,params : {					   						// 조회조건을 DB로 전송하기위해서 조건값 설정
					limit          : limit_2nd
				  , start          : start_2nd
				  , est_version    : est_version
				  , est_id         : est_id
				  }				
	});
}

/***************************************************************************
 * 설  명 : 저장버튼 클릭
 ***************************************************************************/
function fnSave(){  	

	// 변경된 견적 기본정보 Grid의 record 
	var records = GridClass_edit_1st.store.getModifiedRecords();
	
	// 변경된 record의 자료를 json형식으로
    var edit1stJson = "[";
	    for (var i = 0; i < records.length; i++) {
	      edit1stJson += Ext.util.JSON.encode(records[i].data);				
	      if (i < (records.length-1)) {
	        edit1stJson += ",";
	      }
	    }
    	edit1stJson += "]"

	Ext.Ajax.request({   
		url: "/est/estimate/saveEstimateProcessStateEstInfo.sg"   
		,success: function(response){						// 조회결과 성공시
					// 조회된 결과값, store명
					handleSuccess(response,GridClass_edit_1st,'save');
		          } 
		,failure: handleFailure   	    // 조회결과 실패시  
		,params : {					    // 조회조건을 DB로 전송하기위해서 조건값 설정
				  // 페이지정보
					limit                : limit_edit_1st
			  	  , start                : start_edit_1st
			  	  // 검색정보
			  	  , src_pjt_id   	     : Ext.get('src_pjt_id').getValue()		  	  // 프로젝트ID   
			  	  , src_pjt_name   	     : Ext.get('src_pjt_name').getValue()		  // 프로젝트
			  	  //, src_custom_code      : Ext.get('src_custom_code').getValue()   	  // 거래처코드  
			  	  , src_custom_name      : Ext.get('src_custom_name').getValue()      // 거래처명
			  	  , src_est_type_code    : Ext.get('src_est_type_code').getValue()    // 견적구분 
			  	  , src_est_id           : Ext.get('src_est_id').getValue()           // 견적ID
			  	  , src_est_name         : Ext.get('src_est_name').getValue()         // 견적
			  	  , src_est_date_start   : Ext.get('src_est_date_start').getValue()   // 견적기간(검색시작일)
			  	  , src_est_date_end     : Ext.get('src_est_date_end').getValue()     // 견적기간(검색종료일)
			  	  , src_proc_status_code : Ext.get('src_proc_status_code').getValue() // 진행상태
			  	  // json
			  	  , edit1stData 		 : edit1stJson
				  }  		
	});  
	
	GridClass_edit_1st.store.commitChanges();	// 변경된 record를 commit
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
	
    // 검색버튼
	Ext.get('searchBtn').on('click', function(e){
        var startDate = Ext.get('src_est_date_start').getValue()  // 검색시작일
		var endDate = Ext.get('src_est_date_end').getValue()      // 검색종료일
		
		if(fnCalDate(startDate,endDate,'D') < 0){
			Ext.Msg.alert('확인', '검색시작일이 검색종료일보다 이전입니다.'); 
		}else{
			fnSearchEstInfo();
			GridClass_2nd.store.removeAll();
		}	
    });
    
   	//조건해제 버튼 -> 검색조건 초기화
   	Ext.get('searchClearBtn').on('click', function(e){
        
   		sForm.reset();	
        
        //Ext.get('src_est_date_start').set({value : fromDay }, false);
	    // Ext.get('src_est_date_end').set({value : toDay }, false);
	    
	    fnSearchEstInfo();
		GridClass_2nd.store.removeAll();
    });
   	
   	//등록 버튼
   	Ext.get('saveBtn').on('click', function(e){
   		
   		var records = GridClass_edit_1st.store.getModifiedRecords();
   		
   		if(records.length <= 0 ){
 			Ext.Msg.alert('확인', '변경된 자료가 없습니다.'); 
   			return false;
   		}
   		
   		Ext.MessageBox.confirm('Confirm', '저장하시겠습니까?', showResult);
    });
   	
   	// 거래처검색 버튼
	Ext.get('src_custom_btn').on('click', function(e){
		var param = '?fieldCode=src_custom_code&fieldName=src_custom_name';
		param = param + '&form=searchForm';
		fnCustomPop(param)
	});
		
   	// 견적시간_검색시작일자
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
	
   	
	// 견적시간_검색종료일자
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
	
}); // end Ext.onReady
	
// 등록버튼 클릭시 '예','아니오' 
function showResult(btn){
   	if(btn == 'yes'){
   		fnSave();
   	}    	
};

/***************************************************************************
 * 설  명 : 그리드의 페이지 클릭시 검색조건값을 DB로 전송
 ***************************************************************************/
 // 이슈 **************************************************
function fnIssuePopUp(param){
	var sURL      = "/pjt/pjtIssue/pjtIssueList.sg"+param;
	var dlgWidth  = 1017;
	var dlgHeight = 250;
	var winName   = "이슈등록";
	fnOpenPop(sURL, dlgWidth, dlgHeight, winName);
}

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

function fnCustomPop(param){
	var sURL      = "/com/custom/customPop.sg"+param;
	var dlgWidth  = 416;
	var dlgHeight = 364;
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
 * 설  명 : 에디트 그리드의 CELL을 수정하였을 경우 이벤트
 ***************************************************************************/
function  fnEdit1stAfterCellEdit(obj){

	var rowCnt = GridClass_edit_1st.store.getCount();  // Grid의 총갯수
	var editedRow = obj.row;
	var editedColumn = obj.column;
	var editedValue = obj.value;
	var fieldName = obj.field;
	
	var editedRecord = GridClass_edit_1st.store.getAt(editedRow);
	var editedEstId = editedRecord.data.EST_ID;
	var editedPjtId = editedRecord.data.PJT_ID;
	
	// 해당 컬럼의 값이 변경 되었을 경우
	if( fieldName == 'PROC_STATUS_CODE'){
		if( rowCnt > 0){
			
			for(i = 0 ; i < rowCnt ; i++){
				
				var record = GridClass_edit_1st.store.getAt(i);
				var estId = record.data.EST_ID;
				var pjtId = record.data.PJT_ID;
								
				if(editedValue == 'B90'){ // 견적확정
					if(editedEstId == estId && editedPjtId == pjtId && editedRow != i){
						record.set('PROC_STATUS_CODE', 'B50');			// 진행상태
					}
				}
			} // end for	
		} // end if
	}// end if

}

/***************************************************************************
 * 설  명 : 에디트 그리드의 CELL을 클릭하였을 경우 이벤트
 ***************************************************************************/
function fnEdit1stCellClickEvent(grid, rowIndex, columnIndex, e){
		
	var record = GridClass_edit_1st.store.getAt(rowIndex);
	var modifyYn = record.data.MODIFY_YN;
	var est_id = record.data.EST_ID;
	var est_version = record.data.EST_VERSION;
	var proc_status_code = record.data.PROC_STATUS_CODE;
	var pjt_id = record.data.PJT_ID;
	
	// alert(modifyYn +" : "+ columnIndex +" : "+ proc_status_code);
	
	// proc_status_code_B00 : 견적DROP
	if(modifyYn == 'N' && columnIndex == '2'){
		grid.colModel.setEditable(columnIndex, false);
		//record.set('PROC_STATUS_CODE', 'B50');			// 진행상태
		//Ext.Msg.alert('확인', '[견적확정]된 견적입니다.'); 
	}else if(proc_status_code == 'B00' && columnIndex == '2'){
	    grid.colModel.setEditable(columnIndex, false);
	}else{
		grid.colModel.setEditable(columnIndex, true);
	}
	
	fnSearchEstItemInfo(est_id, est_version);
	
	if(columnIndex == '3'){
		fnIssuePopUp("?popUp_YN=Y&src_pjt_id="+pjt_id);
	}
	
}
	
/***************************************************************************
 * 수주기본정보 --- 그리드의 행이 클릭되었을때 Event
 ***************************************************************************/
function fnGridOnClick_edit_1st(model, rowIndex, record){
	
	var record = GridClass_edit_1st.store.getAt(rowIndex);
	var est_id = record.data.EST_ID;
	var est_version = record.data.EST_VERSION;

	fnSearchEstItemInfo(est_id, est_version);
}
</script>
</head>
<body>
	<table border="0" width="1000" height="200">
		<tr>
			<td colspan="2">
				<form name="searchForm" id="searchForm" method="post" enctype="multipart/form-data">
					<!----------------- SEARCH Hearder Start	 ----------------->
				<div id="ext-comp-1002" class=" x-panel x-form-label-left" style="margin-top: 0em;"><%-- 0em <- 1em으로 수정하면 상위 공백 --%>
					<div class="x-panel-tl">
						<div class="x-panel-tr">
							<div class="x-panel-tc">
								<div id="ext-gen4" class="x-panel-header x-unselectable" style="-moz-user-select: none;">
									<span id="ext-gen8" class="x-panel-header-text">견적진행상태 검색</span>
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
								<table border="0">
						    		<%-- 1 Row Start --%>
						    		<tr>
										<td width="4%">
											<div tabindex="-1" class="x-form-item " >
												<label class="x-form-item-label" style="width: auto;" for="src_pjt_id" >프로젝트ID :</label>
												<div style="padding-left: 0px;" class="x-form-element">
													<input type="text" name="src_pjt_id" id="src_pjt_id" autocomplete="off" size="19" class=" x-form-text x-form-field" style="width: auto;">
												</div>
											</div>
										</td>
										<td width="21%">
											<div tabindex="-1" class="x-form-item " >
												<label class="x-form-item-label" style="width: auto;" for="src_pjt_name" >프로젝트명 :</label>
												<div style="padding-left: 0px;" class="x-form-element">
													<input type="text" name="src_pjt_name" id="src_pjt_name" autocomplete="off" size="19" class=" x-form-text x-form-field" style="width: auto;">
												</div>
											</div>
										</td>
								
										<td width="22%">
											<div tabindex="-1" class="x-form-item " >
												<label class="x-form-item-label" style="width: auto;" for="src_custom_name" >&nbsp;&nbsp;&nbsp;거래처명 :</label>
												<div style="padding-left: 62px;" class="x-form-element">
													<input type="text" name="src_custom_name" id="src_custom_name" autocomplete="off" size="25" class=" x-form-text x-form-field" style="width: auto;">		
												</div>
											</div>
										</td>
										<td width="2%">
											<div tabindex="-1" class="x-form-item " >
												<div style="padding-left: 0px;" class="x-form-element">
													<%-- 검색 버튼 Start --%>
													<div style="padding-left: 0px;" >
														<img align="center" id="src_custom_btn" name="src_custom_btn" alt="" src="/resource/images/bass_1st/icon_src1.gif" style="cursor: hand;">
													</div>
													<%-- 검색 버튼 End	--%>
												</div>
											</div>
										</td>
										<td width="5%">
											<div style="padding-left: 0px;" class="x-form-element">
												<input type="hidden" name="src_custom_code" id="src_custom_code" autocomplete="off" size="20" class=" x-form-text x-form-field" style="width: auto;">
											</div>
										</td>
								
										<td width="24%">
											<div tabindex="-1" class="x-form-item " >
												<label class="x-form-item-label" style="width: auto;" for="src_est_type_code" >견적구분 :</label>
												<div style="padding-left: 30px;" class="x-form-element">
													<select name="src_est_type_code" id="src_est_type_code" title="견적구분" style="width: 100px;" type="text" class=" x-form-select x-form-field" >
														<option value="">전체</option>
														<c:forEach items="${EST_TYPE_CODE}" var="data" varStatus="status">
														<option value="${data.COM_CODE}"><c:out value="${data.COM_CODE_NAME}"/></option>
														</c:forEach>
													</select>
												</div>
											</div>
										</td>
									</tr>
									<%-- 1 Row End --%>
									<%-- 2 Row Start --%>
									<tr>
										<td width="20%">
											<div tabindex="-1" class="x-form-item " >
												<label class="x-form-item-label" style="width: auto;" for="src_est_id">견적ID :</label>
												<div style="padding-left: 70px;" class="x-form-element">
													<input type="text" name="src_est_id" id="src_est_id" autocomplete="off" size="19" class=" x-form-text x-form-field" style="width: auto;">
												</div>
											</div>
										</td>
										<td width="2%">
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
<%--												<div style="padding-left: 30px;" class="x-form-element">--%>
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
<%--												</div>--%>
											</div>
										</td>
										<td>
											<div tabindex="-1" class="x-form-item " >
												<label class="x-form-item-label" style="width: auto;" for="src_proc_status_code" >진행상태 :</label>
												<div style="padding-left: 30px;" class="x-form-element">
													<select name="src_proc_status_code" id="src_proc_status_code" title="진행상태" style="width: 100px;" type="text" class=" x-form-select x-form-field" >
														<option value="">전체</option>
														<c:forEach items="${FLOW_STATUS_CODE}" var="data" varStatus="status">
														<c:if test="${fn:substring(data.COM_CODE, 0, 1)== 'B'}">
														<option value="${data.COM_CODE}"><c:out value="${data.COM_CODE_NAME}"/></option>
														</c:if>
														</c:forEach>
													</select>
												</div>
											</div>
										</td>
										
									</tr>
									<%-- 2 Row End --%>
									<%-- 3 Row 버튼 Start --%>
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
			<!----------------- 견적기본정보 GRID START ----------------->
			<td width="50%" valign="top">
				<div id="estimateBasicInfo_grid" style="margin-top: 0em;"></div>
			</td>
			<!----------------- 견적기본정보 GRID END ----------------->
		</tr>
		<tr>
			<!----------------- 견적 품목정보 GRID START ----------------->
			<td width="50%" valign="top">
				<div id="estimateItemInfo-grid" style="margin-top: 0em;"></div>
			</td>
			<!----------------- 견적 품목정보 GRID END ----------------->
		</tr>
		<tr>
			<td colspan="2" align="center" height="35">
				<table>
					<tr>
						<td>
						<%-- 등록 버튼 Start --%>
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
						<%-- 등록버튼 End	--%>
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
</body>

<%@ include file="/WEB-INF/web/jsp/sgis-bottom-inc.jsp" %>