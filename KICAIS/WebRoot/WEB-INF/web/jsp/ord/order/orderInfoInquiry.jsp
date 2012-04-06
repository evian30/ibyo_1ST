<%--
  Class Name  : orderInfoInquiry.jsp
  Description : 수주정보조회
  Modification Information
 
      수정일                   수정자                 수정내용
  -------      --------    ---------------------------
  2011. 3. 21   고기범            최초 생성   
  
  author   : 고기범
  since    : 2011. 4. 23.
  version  : 1.0
   
  Copyright (C) 2011 by SG All right reserved.
--%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/web/jsp/common/inc/commonInc.jsp" %>
<script type="text/javascript" src="/resource/common/js/sgis-comm-inc.js" ></script> 
<script type="text/javascript" src="/resource/common/js/common/common-msg-box.js" ></script> 
<script type="text/javascript" src="/resource/common/js/ajax.js" ></script>

<script type="text/javascript" src="/resource/common/js/grid/grid_edit_3rd.js"></script>
<script type="text/javascript" src="/resource/common/js/grid/grid_edit_2nd.js"></script>
<script type="text/javascript" src="/resource/common/js/grid/grid_edit_1st.js"></script> 
<script type="text/javascript">
/***************************************************************************
 *  수주기본정보 -- 초기값 설정 
 ***************************************************************************/
var	gridHeigth_edit_3rd 	= 300; 							// 그리드 전체 높이
var	gridWidth_edit_3rd		= 1000;							// 그리드 전체 폭
var gridTitle_edit_3rd 		= "수주정보";		  			// 그리드 제목
var	render_edit_3rd			= "grid_edit_3rd";				// 렌더(화면에 그려질) 할 id 
var keyNm_edit_3rd		    = "";
var	pageSize_edit_3rd		= 10;	  						// 그리드 페이지 사이즈	
var	proxyUrl_edit_3rd		= "/ord/order/orderProcessStateManageList.sg";  // 결과 값 페이지
var limit_edit_3rd			= pageSize_edit_3rd;
var start_edit_3rd			= 0;
var grid2ndRowDeleteYn      = "";
var tbarHidden_edit_3rd     = "Y";

// 그리드의 페이지 클릭시 검색조건값을 DB로 전송
function fnPagingValue_edit_3rd(){
	
	try{
		GridClass_edit_3rd.store.setBaseParam('start'		 	  	,start_edit_3rd);
	    GridClass_edit_3rd.store.setBaseParam('limit'		 	  	,limit_edit_3rd);
		GridClass_edit_3rd.store.setBaseParam('src_pjt_id'      	,Ext.get('src_pjt_id').getValue());		  	  // 프로젝트ID   
		GridClass_edit_3rd.store.setBaseParam('src_pjt_name'      	,Ext.get('src_pjt_name').getValue());	  	  // 프로젝트
		//GridClass_edit_3rd.store.setBaseParam('src_ord_custom_code' ,Ext.get('src_ord_custom_code').getValue());  // 거래처코드  
		GridClass_edit_3rd.store.setBaseParam('src_ord_custom_name' ,Ext.get('src_ord_custom_name').getValue());  // 거래처명
		GridClass_edit_3rd.store.setBaseParam('src_ord_type_code'  	,Ext.get('src_ord_type_code').getValue());    // 수주구분 
		GridClass_edit_3rd.store.setBaseParam('src_ord_id' 		  	,Ext.get('src_ord_id').getValue());           // 수주ID
		GridClass_edit_3rd.store.setBaseParam('src_ord_name'	  	,Ext.get('src_ord_name').getValue());         // 수주
		GridClass_edit_3rd.store.setBaseParam('src_ord_date_start' 	,Ext.get('src_ord_date_start').getValue());   // 수주기간(검색시작일)
		GridClass_edit_3rd.store.setBaseParam('src_ord_date_end'   	,Ext.get('src_ord_date_end').getValue());     // 수주기간(검색종료일)
		//GridClass_edit_3rd.store.setBaseParam('src_proc_status_code',Ext.get('src_proc_status_code').getValue()); // 진행상태
	
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
	       		 <c:if test="${fn:substring(data.COM_CODE, 0, 1)== 'C'}">
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
	return record ? record.get(FLOW_STATUS_CODE_COMBO.displayField) : FLOW_STATUS_CODE_COMBO.valueNotFoundText;    
}}

/** 업무코드 combo box 생성 start **/
var ROLL_TYPE_CODE_COMBO = new Ext.form.ComboBox({    
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
		   	   <c:forEach items="${ROLL_TYPE_CODE}" var="data" varStatus="status">
	       	     <c:if test="${status.index == 0}">['', '']</c:if>
	        		,['${data.COM_CODE}','${data.COM_CODE_NAME}']
	     	   </c:forEach>
	       	  ] 
	   })
});

//combo box render
Ext.util.Format.comboRenderer = function(ROLL_TYPE_CODE_COMBO){    
	return function(value){        
	var record = ROLL_TYPE_CODE_COMBO.findRecord(FLOW_STATUS_CODE_COMBO.valueField, value);        
	return record ? record.get(ROLL_TYPE_CODE_COMBO.displayField) : ROLL_TYPE_CODE_COMBO.valueNotFoundText;    
}}

// Grid의 컬럼 설정
var userColumns_edit_3rd = [ {header : '상태'                	,width : 0 ,sortable : true , dataIndex : 'FLAG'               ,hidden : true}              
					   			
						   , {header : '수주일자'				,width : 0 ,sortable : true , dataIndex : 'ORD_DATE' 			,hidden : true}      
						   , {header : '수주구분코드'			,width : 0 ,sortable : true , dataIndex : 'ORD_TYPE_CODE' 		,hidden : true}      
						         
						   , {header : '진행상태' 	         	,width : 55 ,sortable : true , dataIndex : 'PROC_STATUS_CODE' 	,renderer: Ext.util.Format.comboRenderer(FLOW_STATUS_CODE_COMBO)} 
						   , {header : '버전'					,width : 60 ,sortable : true , dataIndex : 'EST_VERSION' 		,hidden : true}      
						   , {header : '업무구분코드'			,width : 60 ,sortable : true , dataIndex : 'ROLL_TYPE_CODE' 	,renderer: Ext.util.Format.comboRenderer(ROLL_TYPE_CODE_COMBO),hidden : true} 
						   , {header : '수주ID'					,width : 60 ,sortable : true , dataIndex : 'ORD_ID' 			}
						   , {header : '수주명'					,width : 60 ,sortable : true , dataIndex : 'ORD_NAME' 			,hidden : true} 
						   , {header : '수주구분'			    ,width : 40 ,sortable : true , dataIndex : 'ORD_TYPE_NAME' 		}
						   , {header : '견적ID'					,width : 60 ,sortable : true , dataIndex : 'EST_ID' 			}
						   
						   , {header : '프로젝트ID'				,width : 60 ,sortable : true , dataIndex : 'PJT_ID' 			}      
						   , {header : '프로젝트'				,width : 70 ,sortable : true , dataIndex : 'PJT_NAME' 			}
						   , {header : '거래처명'			    ,width : 60 ,sortable : true , dataIndex : 'ORD_CUSTOM_NAME' 	}
						   , {header : '납품예정일'				,width : 45 ,sortable : true , dataIndex : 'DELIVERY_EXP_DATE' 	}
						   , {header : '수주적용총액'			,width : 60 ,sortable : true , dataIndex : 'ORD_APLY_TOTAL_AMT' ,renderer: "korMoney" , align : 'right'}      
						   , {header : '수주적용총세액'			,width : 60 ,sortable : true , dataIndex : 'ORD_APLY_TOTAL_TAX' ,renderer: "korMoney" , align : 'right'} 
						   , {header : '수주담당자번호'			,width : 0  ,sortable : true , dataIndex : 'ORD_EMP_NUM' 		,hidden : true}      
						   , {header : '수주담당자'				,width : 60 ,sortable : true , dataIndex : 'ORD_EMP_NAME' 		,hidden : true}
						   , {header : '수주부서코드'			,width : 0  ,sortable : true , dataIndex : 'ORD_DEPT_CODE' 		,hidden : true}      
						   , {header : '수주부서'				,width : 60 ,sortable : true , dataIndex : 'ORD_DEPT_NAME' 		,hidden : true}
						   
						   , {header : '수주처코드(거래처)'		,width : 0 ,sortable : true , dataIndex : 'ORD_CUSTOM_CODE' 	,hidden : true} 
						   
						   , {header : '납품처코드'				,width : 0 ,sortable : true , dataIndex : 'DVE_CUSTOM_CODE' 	,hidden : true}      
						   , {header : '납품처'					,width : 0 ,sortable : true , dataIndex : 'DVE_CUSTOM_NAME' 	,hidden : true}
						   , {header : '검수예정일'				,width : 0 ,sortable : true , dataIndex : 'INSPECT_EXP_DATE' 	,hidden : true}      
						         
						   , {header : '설치예정일시'			,width : 0 ,sortable : true , dataIndex : 'SET_EXP_DATE' 		,hidden : true}      
						   , {header : '매출예정일'				,width : 0 ,sortable : true , dataIndex : 'SAL_EXP_DATE' 		,hidden : true}      
						   , {header : '결제일'					,width : 0 ,sortable : true , dataIndex : 'ACCOUNT_DATE' 		,hidden : true}      
						   , {header : '수주총액'				,width : 0 ,sortable : true , dataIndex : 'ORD_TOTAL_AMT' 		,hidden : true}      
						   , {header : '할인총액'				,width : 0 ,sortable : true , dataIndex : 'DISCNT_TOTAL_AMT' 	,hidden : true}      
						        
						   , {header : '적용업무설명'			,width : 0 ,sortable : true , dataIndex : 'APLY_JOB_DESCRIPT'  ,hidden : true}      
						   , {header : '특이사항'				,width : 40 ,sortable : true , dataIndex : 'SUMMARY' 			}      
						   , {header : '유무상구분코드'			,width : 0 ,sortable : true , dataIndex : 'PAY_FREE_CODE' 		,hidden : true}      
						   , {header : '유지보수기간_From'		,width : 0 ,sortable : true , dataIndex : 'MAINTENANCE_FROM' 	,hidden : true}      
						   , {header : '유지보수기간_To'			,width : 0 ,sortable : true , dataIndex : 'MAINTENANCE_TO' 	,hidden : true}      
						   , {header : '프로젝트기간FROM'		,width : 0 ,sortable : true , dataIndex : 'PJT_DATE_FROM' 		,hidden : true}      
						   , {header : '프로젝트기간To'			,width : 0 ,sortable : true , dataIndex : 'PJT_DATE_TO' 		,hidden : true}      
						   , {header : '세금계산서발행구분'		,width : 0 ,sortable : true , dataIndex : 'TAX_ISSUE_TYPE' 	,hidden : true}      
						   , {header : '세금계산서분할발행회수' 	,width : 0 ,sortable : true , dataIndex : 'TAX_MOD_ISSUE_CNT' 	,hidden : true}      
						        
						   , {header : '최종변경자ID'			,width : 0 ,sortable : true , dataIndex : 'FINAL_MOD_ID' 		,hidden : true}      
						   , {header : '최종변경일시'			,width : 0 ,sortable : true , dataIndex : 'FINAL_MOD_DATE' 	,hidden : true}      
						   , {header : '최초등록일'				,width : 0 ,sortable : true , dataIndex : 'REG_DATE' 			,hidden : true}      
						   , {header : '최초등록자'				,width : 0 ,sortable : true , dataIndex : 'REG_ID' 			,hidden : true}      
						   , {header : '수주처담당자번호'		,width : 0 ,sortable : true , dataIndex : 'ORD_CUSTOMER_NUM' 	,hidden : true}      
						   , {header : '수주처담당자'			,width : 0 ,sortable : true , dataIndex : 'ORD_CUSTOMER_NAME' 	,hidden : true}
						   , {header : '납품처담당자번호' 		,width : 0 ,sortable : true , dataIndex : 'DVE_CUSTOMER_NUM' 	,hidden : true}
						   , {header : '납품처담당자' 			,width : 0 ,sortable : true , dataIndex : 'DVE_CUSTOMER_NAME' 	,hidden : true}
						   , {header : '수정가능여부'   			,width : 0 ,sortable : true , dataIndex : 'MODIFY_YN'          ,hidden : true}
						   
						   ];	 

// 그리드 결과매핑 
var mappingColumns_edit_3rd =[ { name : 'FLAG'               ,allowBlank : false }		// 상태                	               
							 , { name : 'ORD_ID' 			 ,allowBlank : false }		// 수주ID					 			
							 , { name : 'ORD_DATE' 			 ,allowBlank : false }		// 수주일자				 			  
							 , { name : 'ORD_TYPE_CODE' 	 ,allowBlank : false }		// 수주구분코드			 		      
							 , { name : 'ORD_NAME' 			 ,allowBlank : false }		// 수주명					 			  
							 , { name : 'EST_ID' 			 ,allowBlank : false }		// 견적ID					 			
							 , { name : 'ORD_TYPE_NAME' 	 ,allowBlank : false }		// 수주구분			 				
							 , { name : 'EST_VERSION' 		 ,allowBlank : false }		// 버전					 				    
							 , { name : 'ROLL_TYPE_CODE' 	 ,allowBlank : false }		// 업무구분코드			 				
							 , { name : 'PJT_ID' 			 ,allowBlank : false }		// 프로젝트ID		
							 , { name : 'PJT_NAME' 			 ,allowBlank : false }		// 프로젝트
							 , { name : 'ORD_DEPT_CODE' 	 ,allowBlank : false }		// 수주부서코드		
							 , { name : 'ORD_DEPT_NAME' 	 ,allowBlank : false }		// 수주부서
							 , { name : 'ORD_EMP_NUM' 		 ,allowBlank : false }		// 수주담당자번호	
							 , { name : 'ORD_EMP_NAME' 		 ,allowBlank : false }		// 수주담당자
							 , { name : 'ORD_CUSTOM_CODE' 	 ,allowBlank : false }		// 수주처코드(거래처)		 
							 , { name : 'ORD_CUSTOM_NAME' 	 ,allowBlank : false }		// 거래처명			 				
							 , { name : 'DVE_CUSTOM_CODE' 	 ,allowBlank : false }		// 납품처코드				 		      
							 , { name : 'DVE_CUSTOM_NAME' 	 ,allowBlank : false }		// 납품처				 				
							 , { name : 'INSPECT_EXP_DATE' 	 ,allowBlank : false }		// 검수예정일				 		      
							 , { name : 'DELIVERY_EXP_DATE'  ,allowBlank : false }		// 납품예정일				 			      
							 , { name : 'SET_EXP_DATE' 		 ,allowBlank : false }		// 설치예정일시			 		    
							 , { name : 'SAL_EXP_DATE' 		 ,allowBlank : false }		// 매출예정일				 		    
							 , { name : 'ACCOUNT_DATE' 		 ,allowBlank : false }		// 결제일					 			    
							 , { name : 'ORD_TOTAL_AMT' 	 ,allowBlank : false }		// 수주총액				 			      
							 , { name : 'DISCNT_TOTAL_AMT' 	 ,allowBlank : false }		// 할인총액				 			      
							 , { name : 'ORD_APLY_TOTAL_AMT' ,allowBlank : false }		// 수주적용총액			 		       
							 , { name : 'ORD_APLY_TOTAL_TAX' ,allowBlank : false }		// 수주적용총세액			 	       
							 , { name : 'APLY_JOB_DESCRIPT'  ,allowBlank : false }		// 적용업무설명			 		       
							 , { name : 'SUMMARY' 			 ,allowBlank : false }		// 특이사항				 			  
							 , { name : 'PAY_FREE_CODE' 	 ,allowBlank : false }		// 유무상구분코드			 	      
							 , { name : 'MAINTENANCE_FROM' 	 ,allowBlank : false }		// 유지보수기간_From		 	      
							 , { name : 'MAINTENANCE_TO' 	 ,allowBlank : false }		// 유지보수기간_To			 	    
							 , { name : 'PJT_DATE_FROM' 	 ,allowBlank : false }		// 프로젝트기간FROM		 	      
							 , { name : 'PJT_DATE_TO' 		 ,allowBlank : false }		// 프로젝트기간To			 	    
							 , { name : 'TAX_ISSUE_TYPE' 	 ,allowBlank : false }		// 세금계산서발행구분		    
							 , { name : 'TAX_MOD_ISSUE_CNT'  ,allowBlank : false }		// 세금계산서분할발행회수	      
							 , { name : 'PROC_STATUS_CODE' 	 ,allowBlank : false }		// 진행상태코드                
							 , { name : 'FINAL_MOD_ID' 		 ,allowBlank : false }		// 최종변경자ID				 	    
							 , { name : 'FINAL_MOD_DATE' 	 ,allowBlank : false }		// 최종변경일시				 	    
							 , { name : 'REG_DATE' 			 ,allowBlank : false }		// 최초등록일					 	  
							 , { name : 'REG_ID' 			 ,allowBlank : false }		// 최초등록자					 	
							 , { name : 'ORD_CUSTOMER_NUM' 	 ,allowBlank : false }		// 수주처담당자번호		 	      
							 , { name : 'ORD_CUSTOMER_NAME'  ,allowBlank : false }		// 수주처담당자				 		
							 , { name : 'DVE_CUSTOMER_NUM' 	 ,allowBlank : false }		// 납품처담당자번호 		 	
							 , { name : 'DVE_CUSTOMER_NAME'  ,allowBlank : false }		// 납품처담당자 	
							 , { name : 'MODIFY_YN'			 ,allowBlank : false }		// 수정가능여부
	    				 	 ];

/***************************************************************************
 * 수주기본정보 --- 그리드의 행이 클릭되었을때 Event
 ***************************************************************************/
function fnGridOnClick_edit_3rd(model, rowIndex, record){
	
	var record = GridClass_edit_3rd.store.getAt(rowIndex);
	//var modifyYn = record.data.MODIFY_YN;
	var ord_id = record.data.ORD_ID;							 // 수주ID
	//var proc_status_code = record.data.PROC_STATUS_CODE;
	
	// proc_status_code_C00 : 수주DROP
//	if(modifyYn == 'N' || proc_status_code == 'C00'){
	//	GridClass_edit_3rd.grid.colModel.setEditable(3, false);
	//}else{
	//	GridClass_edit_3rd.grid.colModel.setEditable(3, true);
	//}
	Ext.get('ord_id').set({value : ord_id}, false);							// 수주ID
	
	fnSearchEdit1st(ord_id);
	fnSearchEdit2nd(ord_id);
}

// 수주품목 정보 조회
function fnSearchEdit1st(keyValue1){
	
	Ext.Ajax.request({
		url: "/ord/order/result_edit_1st.sg" 
		,success: function(response){							// 조회결과 성공시
					GridClass_edit_1st.store.commitChanges();	// 변경된 record를 commit
					GridClass_edit_1st.store.removeAll();		// store자료를 삭제
						
					// 조회된 결과값, store명
					var json = Ext.util.JSON.decode(response.responseText);
					GridClass_edit_1st.store.loadData(json);
		          }
		,failure: handleFailure 
		,params : {
				   // 페이지 		
					 limit			: limit_edit_1st
				   , start			: start_edit_1st
				   // 키 value
				   , ord_id			: keyValue1
				  }				
	}); // end Ext.Ajax.request   
}

// 수주처 시스템사양 정보 조회
function fnSearchEdit2nd(keyValue1){
	
	Ext.Ajax.request({
		url: "/ord/order/result_edit_2nd.sg" 
		,success: function(response){						// 조회결과 성공시
					// 조회된 결과값, store명
					GridClass_edit_2nd.store.commitChanges();
					GridClass_edit_2nd.store.removeAll();
					
					var json = Ext.util.JSON.decode(response.responseText);
					GridClass_edit_2nd.store.loadData(json);
			
		          }
		,failure: handleFailure 
		,params : {
				   // 페이지 		
					 limit			: limit_edit_2nd
				   , start			: start_edit_2nd
				   // 키 value
				   , ord_id			: keyValue1
				  }				
	}); // end Ext.Ajax.request   
}

/***************************************************************************
 * 설  명 : 편집그리드 설정 (수주품목정보)
***************************************************************************/
var	gridHeigth_edit_1st	= 200;
var	gridWidth_edit_1st  = 1000;
var	gridTitle_edit_1st  = "수주 품목정보"	; 
var	render_edit_1st		= "edit_grid_1st";
var keyNm_edit_1st		= "ORD_INFO_SEQ";
var pageSize_edit_1st	= 4;
var limit_edit_1st		= pageSize_edit_1st;
var start_edit_1st		= 0;
var proxyUrl_edit_1st	= "/ord/order/result_edit_1st.sg";
var gridRowDeleteYn	    = "";
var tbarHidden_edit_1st = "Y";

// 행추가
function addNew_edit_1st(){
		
}

// 페이징
function fnPagingValue_edit_1st(){	
	try{
		GridClass_edit_1st.store.setBaseParam('start'		,start_edit_1st);
	    GridClass_edit_1st.store.setBaseParam('limit'		,limit_edit_1st);
	    GridClass_edit_1st.store.setBaseParam('ord_id'		,Ext.get('ord_id').getValue());
	}catch(e){

	}
}

// 유무상구분코드 combo box 생성 start
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
	  ['', ''],
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
var	userColumns_edit_1st	= [ {header: "상태",			width: 0,  	sortable: true ,dataIndex: 'FLAG'               , hidden : true}
				  			  ,	{header: "수주ID",		width: 0,	sortable: true,	dataIndex: "ORD_ID"				, hidden:true}
		  , {id:'ord_info_seq',  header: "순번",			width: 0,	sortable: true,	dataIndex: "ORD_INFO_SEQ"		, hidden:true}
							  , {header: "품목코드",  	width: 0,	sortable: true,	dataIndex: "ITEM_CODE"			, hidden:true}
							  , {header: "품목명",		width: 200,	sortable: true,	dataIndex: "ITEM_NAME"			}
							  , {header: "수량",			width:  50,	sortable: true,	dataIndex: "CNT"				, align : 'right'}
							  , {header: "총액",			width: 90,	sortable: true,	dataIndex: "UNIT_PRICE"			, renderer: "korMoney" , align : 'right'}
							  , {header: "금액",			width: 90,	sortable: true,	dataIndex: "AMT"				, renderer: "korMoney" , align : 'right'}
							  , {header: "할인율",		width:  50,	sortable: true,	dataIndex: "DISCOUNT_RATIO"		, align : 'right'}
							  , {header: "유무상구분",	width:  75,	sortable: true,	dataIndex: "PAY_FREE_CODE"		, renderer: Ext.util.Format.comboRenderer(PAY_FREE_CODE_COMBO)}
							  , {header: "적용단가",		width: 90,	sortable: true,	dataIndex: "APLY_UNIT_PRICE"	, renderer: "korMoney" , align : 'right'}
							  , {header: "적용금액",		width: 90,	sortable: true,	dataIndex: "APLY_AMT"			, renderer: "korMoney" , align : 'right'}
							  , {header: "적용세액",		width: 90,	sortable: true,	dataIndex: "APLY_TAX"			, renderer: "korMoney" , align : 'right'}
							  , {header: "비고",			width: 175,	sortable: true,	dataIndex: "NOTE"				}
							  , {header: "최종변경자ID",	width: 0,	sortable: true,	dataIndex: "FINAL_MOD_ID"		, hidden:true}
							  , {header: "최종변경일시",	width: 0,	sortable: true,	dataIndex: "FINAL_MOD_DATE"		, hidden:true}
							  ];

// 맵핑 필드
var	mappingColumns_edit_1st	= [ {name: "FLAG", 			    type:"string", mapping: "FLAG"}
							  , {name: "ORD_ID", 			type:"string", mapping: "ORD_ID"}
							  , {name: "ORD_INFO_SEQ", 		type:"string", mapping: "ORD_INFO_SEQ"}
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
 * 설  명 : 편집그리드 설정 (수주처 시스템 사양정보)
***************************************************************************/
var	gridHeigth_edit_2nd	= 200;
var	gridWidth_edit_2nd  = 1000	;
var	gridTitle_edit_2nd  = "납품처 시스템 사양정보"	; 
var	render_edit_2nd		= "edit_grid_2nd";
var keyNm_edit_2nd		= "ORD_INFO_SEQ";
var pageSize_edit_2nd	= 4;
var limit_edit_2nd		= pageSize_edit_2nd;
var start_edit_2nd		= 0;
var proxyUrl_edit_2nd	= "/ord/order/result_edit_2nd.sg";
var grid2ndRowDeleteYn  = "";
var tbarHidden_edit_2nd = "Y";

// 행추가
function addNew_edit_2nd(){

}

// 페이징
function fnPagingValue_edit_2nd(){	
	try{
		GridClass_edit_2nd.store.setBaseParam('start'		,start_edit_2nd);
	    GridClass_edit_2nd.store.setBaseParam('limit'		,limit_edit_2nd);
	    GridClass_edit_2nd.store.setBaseParam('ord_id'		,Ext.get('ord_id').getValue());
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
var	userColumns_edit_2nd	= [ {header: '상태',			width:   0, sortable: true ,dataIndex: 'FLAG'           ,hidden : true} 
							  , {header: "수주ID",		width:   0,	sortable: true,	dataIndex: "ORD_ID",		editor: new Ext.form.TextField({ allowBlank : false }) , hidden:true}
							  , {header: "순번",			width:   0,	sortable: true,	dataIndex: "ORD_INFO_SEQ",	editor: new Ext.form.TextField({ allowBlank : false }) , hidden:true}
							  , {header: "제원구분코드",	width: 100,	sortable: true,	dataIndex: "SPEC_TYPE_CODE",editor: SPEC_TYPE_CODE_COMBO  ,renderer: Ext.util.Format.comboRenderer(SPEC_TYPE_CODE_COMBO) }
							  , {header: "제원설명",		width: 320,	sortable: true,	dataIndex: "SPEC_INTRO",	editor: new Ext.form.TextField({ allowBlank : false }) }
							  , {header: "제원수량",		width: 80,	sortable: true,	dataIndex: "SPEC_CNT",		editor: new Ext.form.TextField({ allowBlank : false }) , align : 'right'}
							  , {header: "제원용량",		width: 100,	sortable: true,	dataIndex: "SPEC_VOL",		editor: new Ext.form.TextField({ allowBlank : false }) }
							  , {header: "비고",			width: 400,	sortable: true,	dataIndex: "NOTE",			editor: new Ext.form.TextField({ allowBlank : false }) }
							  , {header: "최종변경자ID",	width:   0,	sortable: true,	dataIndex: "FINAL_MOD_ID",	editor: new Ext.form.TextField({ allowBlank : false }) , hidden:true}
							  , {header: "최종변경일시",	width:   0,	sortable: true,	dataIndex: "FINAL_MOD_DATE",editor: new Ext.form.TextField({ allowBlank : false }) , hidden:true}
							  ];

// 맵핑 필드
var	mappingColumns_edit_2nd	= [ {name: "FLAG", 		    type:"string", mapping: "FLAG"}
							  , {name: "ORD_ID", 		type:"string", mapping: "ORD_ID"}			// 수주ID      
							  , {name: "ORD_INFO_SEQ", 	type:"string", mapping: "ORD_INFO_SEQ"}		// 순번        
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
	}catch(e){
		
	}
}

/***************************************************************************
 * 설  명 : 검색
 **************************************************************************/
function fnSearch(){  	
	
	Ext.Ajax.request({   
		url: "/ord/order/orderProcessStateManageList.sg"
		,method : 'POST'   
		,success: function(response){						// 조회결과 성공시
					// 조회된 결과값, store명
					handleSuccess(response,GridClass_edit_3rd);
					//var json = Ext.util.JSON.decode(response.responseText);
					//this.GridClass_1st.store.loadData(json)
					//alert(json.success);
		          }   							
		,failure: handleFailure   	   						// 조회결과 실패시  
		,params : {					   						// 조회조건을 DB로 전송하기위해서 조건값 설정
					limit              	: limit_edit_3rd
				  , start              	: start_edit_3rd
				  , src_pjt_id   	   	: Ext.get('src_pjt_id').getValue()		  	// 프로젝트ID   
				  , src_pjt_name   	   	: Ext.get('src_pjt_name').getValue()	  	// 프로젝트
			  	  //, src_ord_custom_code : Ext.get('src_ord_custom_code').getValue() // 거래처코드  
			  	  , src_ord_custom_name : Ext.get('src_ord_custom_name').getValue() // 거래처명
			  	  , src_ord_type_code  	: Ext.get('src_ord_type_code').getValue()   // 수주구분 
			  	  , src_ord_id         	: Ext.get('src_ord_id').getValue()          // 수주ID
			  	  , src_ord_name       	: Ext.get('src_ord_name').getValue()        // 수주
			  	  , src_ord_date_start 	: Ext.get('src_ord_date_start').getValue()  // 수주기간(검색시작일)
			  	  , src_ord_date_end   	: Ext.get('src_ord_date_end').getValue()    // 수주기간(검색종료일)
			  	  //, src_proc_status_code: Ext.get('src_proc_status_code').getValue()// 진행상태
				  }				
	});  
	
	fnInitValue();
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
        
		var startDate = Ext.get('src_ord_date_start').getValue()  // 검색시작일
		var endDate = Ext.get('src_ord_date_end').getValue()      // 검색종료일
	  
		if(fnCalDate(startDate,endDate,'D') < 0){
			Ext.Msg.alert('확인', '검색시작일이 검색종료일보다 이전입니다.'); 
		}else{
			fnSearch()
			// GridClass_2nd.store.reload()
		}	
    });
    
   	//조건해제 버튼 -> 검색조건 초기화
   	Ext.get('searchClearBtn').on('click', function(e){
        sForm.reset();
        
        //Ext.get('src_ord_date_start').set({value : fromDay }, false);
	    //Ext.get('src_ord_date_end').set({value : toDay }, false);
	    
	    fnSearch();
    });
   	
   	// 프로젝트 검색팝업
   	//Ext.get('src_pjt_id_btn').on('click', function(e){
	//	param = "?fieldName=src_pjt_id";
	//	fnPjtPop(param);
	//});
   	
   	// 거래처검색 버튼
	Ext.get('src_custom_btn').on('click', function(e){
		var param = '?fieldCode=src_ord_custom_code&fieldName=src_ord_custom_name';
		param = param + '&form=searchForm';
		fnCustomPop(param)
	});
   	
   	// 수주시간_검색시작일자
	var startDate = new Ext.form.DateField({
    	applyTo: 'src_ord_date_start',
		allowBlank: false,
		format:'Y-m-d',
		editable : true,
		value : fromDay
	});

   	Ext.get('src_ord_date_start').on('change', function(e){	
		
		var val = Ext.get('src_ord_date_start').getValue();
		var reVal = fnGridDateCheck(val);
		
		Ext.get('src_ord_date_start').set({value:reVal} , false);
	});
   		
	// 수주시간_검색종료일자
	var endDate = new Ext.form.DateField({
    	applyTo: 'src_ord_date_end',
		allowBlank: false,
		format:'Y-m-d',
		editable : true,
		value : toDay
	});
	
	Ext.get('src_ord_date_end').on('change', function(e){	
		
		var val = Ext.get('src_ord_date_end').getValue();
		var reVal = fnGridDateCheck(val);
		
		Ext.get('src_ord_date_end').set({value:reVal} , false);
	});
	
	fnInitValue();
	
}); // end Ext.onReady

// 등록버튼 클릭시 '예','아니오' 
function showResult(btn){
   	if(btn == 'yes'){
   		fnSave();
   	}    	
};

/***************************************************************************
 * 설  명 : 저장버튼 클릭
 ***************************************************************************/
function fnSave(){  	

	// 수주진행상태 Grid의 record
	var record2 = GridClass_edit_3rd.store.getModifiedRecords();	  
	// 변경된 record의 자료를 json형식으로
    var edit2ndJson = "[";
	    for (var i = 0; i < record2.length; i++) {
	      edit2ndJson += Ext.util.JSON.encode(record2[i].data);				
	      if (i < (record2.length-1)) {
	        edit2ndJson += ",";
	      }
	    }
    	edit2ndJson += "]"
    	
	Ext.Ajax.request({   
		url: "/ord/order/saveOrderProcessStateManage.sg"   
		,success: function(response){						// 조회결과 성공시
					// 조회된 결과값, store명
					handleSuccess(response,GridClass_edit_3rd,'save');
		          } 
		,failure: handleFailure   	    // 조회결과 실패시  
		,form   : document.detailForm	// 상세 FORM	
		,params : {					    // 조회조건을 DB로 전송하기위해서 조건값 설정
				  // 페이지정보
					limit              	: limit_edit_3rd
				  , start              	: start_edit_3rd
  				  , edit2ndData        	: edit2ndJson		// 수주진행상태
				  // 검색정보
			  	  , src_pjt_id   	   	: Ext.get('src_pjt_id').getValue()		  	// 프로젝트ID   
			  	  , src_pjt_name   	   	: Ext.get('src_pjt_name').getValue()	 	// 프로젝트ID
			  	  //, src_ord_custom_code : Ext.get('src_ord_custom_code').getValue() // 거래처코드  
			  	  , src_ord_custom_name : Ext.get('src_ord_custom_name').getValue() // 거래처명
			  	  , src_ord_type_code  	: Ext.get('src_ord_type_code').getValue()  	// 수주구분 
			  	  , src_ord_id         	: Ext.get('src_ord_id').getValue()         	// 수주ID
			  	  , src_ord_name        : Ext.get('src_ord_name').getValue()       	// 수주
			  	  , src_ord_date_start 	: Ext.get('src_ord_date_start').getValue() 	// 수주기간(검색시작일)
			  	  , src_ord_date_end   	: Ext.get('src_ord_date_end').getValue()   	// 수주기간(검색종료일)
			  	 // , src_proc_status_code: Ext.get('src_proc_status_code').getValue()// 진행상태 
				  }  		
	});  

	fnInitValue();
}  	
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
	
	if(fieldName == 'pjt_id'){
	 //   Ext.get('pjt_id').set({value:fnFixNull(record.PJT_ID)} , false);
	 //   Ext.get('pjt_name').set({value:fnFixNull(record.PJT_NAME)} , false);
    }else if(fieldName == 'src_pjt_id'){
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

}
/***************************************************************************
 * 설  명 : 에디트 그리드의 CELL을 수정하였을 경우 이벤트
 ***************************************************************************/
function  fnEdit1stAfterCellEdit(obj){

}

// 추가된 행이 삭제 되었을 때
function fnEdit1stAfterRowDeleteEvent(){
		
}
</script>
<body class=" ext-gecko ext-gecko3">
	<table border="0" width="1000" height="200">
		<tr>
			<td colspan="2">
				<form name="searchForm" id="searchForm">
				<input type ="hidden" id="ord_id" name="ord_id"/>
				<!----------------- SEARCH Hearder Start	 ----------------->
				<div id="ext-comp-1002" class=" x-panel x-form-label-left" style="margin-top: 0em;"><%-- 0em <- 1em으로 수정하면 상위 공백 --%>
					<div class="x-panel-tl">
						<div class="x-panel-tr">
							<div class="x-panel-tc">
								<div id="ext-gen4" class="x-panel-header x-unselectable" style="-moz-user-select: none;">
									<span id="ext-gen8" class="x-panel-header-text">수주정보  검색</span>
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
										<td width="21%">
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
								
										<td width="25%">
											<div tabindex="-1" class="x-form-item " >
												<label class="x-form-item-label" style="width: auto;" for="src_ord_custom_name" >&nbsp;&nbsp;&nbsp;거래처명 :</label>
												<div style="padding-left: 61px;" class="x-form-element">
													<input type="text" name="src_ord_custom_name" id="src_ord_custom_name" autocomplete="off" size="28" class=" x-form-text x-form-field" style="width: auto;">		
												</div>
											</div>
										</td>
										<td width="2%">
											<div tabindex="-1" class="x-form-item " >
												<div style="padding-left: 0px;" class="x-form-element">
													<%-- 검색 버튼 Start --%>
													<img align="center" id="src_custom_btn" name="src_custom_btn" alt="" src="/resource/images/bass_1st/icon_src1.gif" style="cursor: hand;">
													<%-- 검색 버튼 End	--%>
												</div>
											</div>
										</td>
										<td width="3%">
											<div style="padding-left: 0px;" class="x-form-element">
												<input type="hidden" name="src_ord_custom_code" id="src_ord_custom_code" autocomplete="off" size="20" class=" x-form-text x-form-field" style="width: auto;">
											</div>
										</td>
								
										<td width="28%">
											<div tabindex="-1" class="x-form-item " >
												<label class="x-form-item-label" style="width: auto;" for="src_ord_type_code" >수주구분 :</label>
												<div style="padding-left: 30px;" class="x-form-element">
													<select name="src_ord_type_code" id="src_ord_type_code" title="수주구분" style="width: 100px;" type="text" class=" x-form-select x-form-field" >
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
												<label class="x-form-item-label" style="width: auto;" for="src_ord_id">수주ID :</label>
												<div style="padding-left: 70px;" class="x-form-element">
													<input type="text" name="src_ord_id" id="src_ord_id" autocomplete="off" size="19" class=" x-form-text x-form-field" style="width: auto;">
												</div>
											</div>
										</td>
										<td width="2%">
											<div tabindex="-1" class="x-form-item " >
												<label class="x-form-item-label" style="width: auto;" for="src_ord_name">수주명 :</label>
												<div style="padding-left: 70px;" class="x-form-element">
													<input type="text" name="src_ord_name" id="src_ord_name" autocomplete="off" size="19" class=" x-form-text x-form-field" style="width: auto;">
												</div>
											</div>
										</td>
										<td colspan="3">
											<div tabindex="-1" class="x-form-item " >
												<label class="x-form-item-label" style="width: auto;" for="src_ord_date_start" ><font color="red">* </font>수주기간 :</label>
												<div style="padding-left: 30px;" class="x-form-element">
													<table>
														<tr>
															<td>
																<input type="text" name="src_ord_date_start" id="src_ord_date_start" autocomplete="off" size="10" style="width: auto;">		
															</td>
															<td>
																~
															</td>
															<td>
																<input type="text" name="src_ord_date_end" id="src_ord_date_end" autocomplete="off" size="10" style="width: auto;">		
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
			<!----------------- 수주기본정보 GRID START ----------------->
			<td width="100%" valign="top" colspan="2">
				<div id="grid_edit_3rd" style="margin-top: 0em;"></div>
			</td>
		</tr>
		<tr>
			<!----------------- 수주 품목정보 GRID START ----------------->
			<td width="100%" valign="top" colspan="2">
				<div id="edit_grid_1st" style="margin-top: 0em;"></div>
			</td>
			<!----------------- 수주 품목정보 GRID END ----------------->
		</tr>
		<tr>
			<!----------------- 시스템 사양정보  GRID START ----------------->
			<td width="100%" valign="top" colspan="2">
				<div id="edit_grid_2nd" style="margin-top: 0em;"></div>
			</td>
			<!----------------- 시스템 사양정보 GRID END ----------------->
		</tr>
	</table>
</body>

<%@ include file="/WEB-INF/web/jsp/sgis-bottom-inc.jsp" %>