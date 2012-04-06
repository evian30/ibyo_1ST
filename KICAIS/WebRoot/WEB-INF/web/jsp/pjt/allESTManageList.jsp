<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/web/jsp/common/inc/commonInc.jsp" %>

<html> 
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr"> 
<title>KICA InformationSystem</title>
<!-- EXTJS CSS -->
<link rel="stylesheet" type="text/css" href="/resource/common/js/ext3/resources/css/ext-all.css" />
 
<!-- EXTJS SCRIPT  -->
<script type="text/javascript" src="/resource/common/js/ext3/adapter/ext/ext-base.js"></script>
<script type="text/javascript" src="/resource/common/js/ext3/ext-all-debug.js"></script>
<script type="text/javascript" src="/resource/common/js/ext3/src/locale/ext-lang-ko.js" charset="utf-8"></script>

<!-- EXTJS APP SCRIPT -->
<script type="text/javascript" src="/resource/common/js/common/App.js"></script>

<!-- KICA VALIDATION SCRIPT -->
<script type="text/javascript" src="/resource/common/js/validator.js"></script>

<!-- KICA COMMON SCRIPT -->
<script type="text/javascript" src="/resource/common/js/sgis-comm-inc.js"></script> 

<script type="text/javascript" src="/resource/common/js/common/common-msg-box.js" ></script> 

<script type="text/javascript" src="/resource/common/js/ajax.js" ></script>
<script type="text/javascript" src="/resource/common/js/grid/grid_1st.js"></script>
<script type="text/javascript" src="/resource/common/js/grid/grid_edit_1st.js"></script> 
<script type="text/javascript" src="/resource/common/js/grid/grid_edit_2nd.js"></script>
<script type="text/javascript">
/***************************************************************************
 *  견적기본정보 -- 초기값 설정 
 ***************************************************************************/
var	gridHeigth_1st 	 	= 378; 							// 그리드 전체 높이
var	gridWidth_1st		= 400;							// 그리드 전체 폭
var gridTitle_1st 		= "견적 목록";	  				// 그리드 제목
var	render_1st			= "estimateBasicInfo_grid";		// 렌더(화면에 그려질) 할 id 
var	pageSize_1st		= 15;	  						// 그리드 페이지 사이즈	
var	proxyUrl_1st		= "/est/estimate/estimateInfoManageList.sg";  // 결과 값 페이지
var limit_1st			= pageSize_1st;
var start_1st			= 0;

// 그리드의 페이지 클릭시 검색조건값을 DB로 전송
function fnPagingValue_1st(){
	
	try{
		GridClass_1st.store.setBaseParam('start'		 	  ,start_1st);
	    GridClass_1st.store.setBaseParam('limit'		 	  ,limit_1st);
		  
		GridClass_1st.store.setBaseParam('src_custom_name' 	  ,'');
		GridClass_1st.store.setBaseParam('src_est_type_code'  ,'');
		GridClass_1st.store.setBaseParam('src_est_id' 		  ,'');
		GridClass_1st.store.setBaseParam('src_est_date_start' ,'');
		GridClass_1st.store.setBaseParam('src_est_date_end'   ,'');
		GridClass_1st.store.setBaseParam('src_final_version'  ,'Y');   	// 최종버전 
		GridClass_1st.store.setBaseParam('src_est_name'  	  ,'');
		
		GridClass_1st.store.setBaseParam('src_pjt_id'                	    ,'<%=request.getParameter("src_pjt_id")%>');
		GridClass_1st.store.setBaseParam('src_pjt_name'                	    ,'<%=request.getParameter("src_pjt_name")%>');
		
	}catch(e){

	}
}
   
// Grid의 컬럼 설정
var userColumns_1st =  [ {header: '상태'                	,width: 60  ,sortable: true ,dataIndex: 'FLAG'                  ,hidden : true}              
					   , {header: '견적ID'              	,width: 100  ,sortable: true ,dataIndex: 'EST_ID'                }              
					   , {header: '버전'                	,width: 40  ,sortable: true ,dataIndex: 'EST_VERSION'			}               
					   , {header: '진행상태'           	,width: 70  ,sortable: true ,dataIndex: 'PROC_STATUS_NAME'      }              
					   , {header: '진행상태'           	,width: 40  ,sortable: true ,dataIndex: 'PROC_STATUS_CODE'      ,hidden : true}
					   , {header: '견적구분'            	,width: 50  ,sortable: true ,dataIndex: 'EST_TYPE_NAME'         ,hidden : true}
					   , {header: '견적구분'            	,width: 70  ,sortable: true ,dataIndex: 'EST_TYPE_CODE'         ,hidden : true}              
					   , {header: '거래처'           		,width: 90  ,sortable: true ,dataIndex: 'CUSTOM_NAME'           }              
					   , {header: '견적일자'            	,width: 70  ,sortable: true ,dataIndex: 'EST_DATE'              }
					   , {header: '업무구분코드'        	,width: 60  ,sortable: true ,dataIndex: 'ROLL_TYPE_CODE'        ,hidden : true}
					   , {header: '프로젝트ID'          	,width: 60  ,sortable: true ,dataIndex: 'PJT_ID'                ,hidden : true}
					   , {header: '프로젝트'          	,width: 60  ,sortable: true ,dataIndex: 'PJT_NAME'              ,hidden : true}
					   , {header: '견적명'              	,width: 60  ,sortable: true ,dataIndex: 'EST_NAME'              ,hidden : true}
					   , {header: '견적부서코드'        	,width: 60  ,sortable: true ,dataIndex: 'EST_DEPT_CODE'         ,hidden : true}
					   , {header: '견적부서'          	,width: 60  ,sortable: true ,dataIndex: 'EST_DEPT_NAME'         ,hidden : true}
					   , {header: '견적담당자사번'      	,width: 60  ,sortable: true ,dataIndex: 'EST_EMP_NUM'           ,hidden : true}
					   , {header: '견적담당자'        	,width: 60  ,sortable: true ,dataIndex: 'EST_EMP_NAME'           ,hidden : true}
					   , {header: '거래처코드'          	,width: 60  ,sortable: true ,dataIndex: 'CUSTOM_CODE'           ,hidden : true}
					   , {header: '거래처담당자번호'	 	,width: 60  ,sortable: true ,dataIndex: 'COSTOMER_NUM'          ,hidden : true}
					   , {header: '거래처담당자'	    	,width: 60  ,sortable: true ,dataIndex: 'COSTOMER_NAME'          ,hidden : true}
					   , {header: '거래처담당부서'	   		,width: 60  ,sortable: true ,dataIndex: 'CUSTOMER_DEPT'          ,hidden : true}
					   , {header: '견적유효기간구분코드'	,width: 60  ,sortable: true ,dataIndex: 'EST_VALID_TYPE_CODE'   ,hidden : true}
					   , {header: '납품예정일'          	,width: 60  ,sortable: true ,dataIndex: 'DELIVERY_EXP_DATE'     ,hidden : true}
					   , {header: '납품처코드'          	,width: 60  ,sortable: true ,dataIndex: 'DELIVERY_CUSTOM_CODE'  ,hidden : true}
					   , {header: '지불조건'            	,width: 60  ,sortable: true ,dataIndex: 'PAY_CONDITON'          ,hidden : true}
					   , {header: '견적총액'            	,width: 60  ,sortable: true ,dataIndex: 'EST_TOTAL_AMT'         ,hidden : true}
					   , {header: '할인총액'            	,width: 60  ,sortable: true ,dataIndex: 'DISCNT_TOTAL_AMT'      ,hidden : true}
					   , {header: '견적적용총액'        	,width: 60  ,sortable: true ,dataIndex: 'EST_APLY_TOTAL_AMT'    ,hidden : true}
					   , {header: '견적적용총세액'      	,width: 60  ,sortable: true ,dataIndex: 'EST_APLY_TOTAL_TAX'    ,hidden : true}
					   , {header: '프로젝트기간  FROM'   	,width: 60  ,sortable: true ,dataIndex: 'PJT_DATE_FROM'         ,hidden : true}
					   , {header: '구축기간 To'          	,width: 60  ,sortable: true ,dataIndex: 'PJT_DATE_TO'           ,hidden : true}
					   , {header: '참고사항'            	,width: 60  ,sortable: true ,dataIndex: 'REF_DESC'              ,hidden : true}
					   , {header: '최종변경자ID'        	,width: 60  ,sortable: true ,dataIndex: 'FINAL_MOD_ID'          ,hidden : true}
					   , {header: '최종변경일시'   		,width: 60  ,sortable: true ,dataIndex: 'FINAL_MOD_DATE'        ,hidden : true}
					   , {header: '수정가능여부'   		,width: 60  ,sortable: true ,dataIndex: 'MODIFY_YN'        		,hidden : true}
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
						 , {name: 'CUSTOMER_DEPT'       , allowBlank: false}	// 거래처담당자부서
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
    				 	 , {name: 'MODIFY_YN'           , allowBlank: false}	// 수정가능여부
						 ];
 
/***************************************************************************
 * 견적기본정보 --- 그리드 클릭시 Event
 ***************************************************************************/
function fnGridOnClick_1st(store, rowIndex){
	
	fnInitValue();
	
	Ext.get('flag').set({value : fnFixNull(store.getAt(rowIndex).data.FLAG)}, false);   								// 상태                               
	Ext.get('est_id').set({value : fnFixNull(store.getAt(rowIndex).data.EST_ID)}, false);   							// 견적ID               
	Ext.get('est_version').set({value : fnFixNull(store.getAt(rowIndex).data.EST_VERSION)}, false);   					// 버전                   
	Ext.get('proc_status_code').set({value : fnFixNull(store.getAt(rowIndex).data.PROC_STATUS_CODE)}, false);   		// 진행상태코드         
	Ext.get('est_type_code').set({value : fnFixNull(store.getAt(rowIndex).data.EST_TYPE_CODE)}, false);   				// 견적구분             
	Ext.get('custom_name').set({value : fnFixNull(store.getAt(rowIndex).data.CUSTOM_NAME)}, false);   					// 거래처코드           
	Ext.get('est_date').set({value : fnFixNull(store.getAt(rowIndex).data.EST_DATE)}, false);   						// 견적일자             
	Ext.get('roll_type_code').set({value : fnFixNull(store.getAt(rowIndex).data.ROLL_TYPE_CODE)}, false);   			// 업무구분코드         
	Ext.get('pjt_id').set({value : fnFixNull(store.getAt(rowIndex).data.PJT_ID)}, false);   							// 프로젝트ID           
	Ext.get('pjt_name').set({value : fnFixNull(store.getAt(rowIndex).data.PJT_NAME)}, false);   						// 프로젝트ID
	Ext.get('est_name').set({value : fnFixNull(store.getAt(rowIndex).data.EST_NAME)}, false);   						// 견적명               
	Ext.get('est_dept_code').set({value : fnFixNull(store.getAt(rowIndex).data.EST_DEPT_CODE)}, false);   				// 견적부서코드  
	Ext.get('est_dept_name').set({value : fnFixNull(store.getAt(rowIndex).data.EST_DEPT_NAME)}, false);   				// 견적부서
	Ext.get('est_emp_num').set({value : fnFixNull(store.getAt(rowIndex).data.EST_EMP_NUM)}, false);   					// 견적담당자사번       
	Ext.get('est_emp_name').set({value : fnFixNull(store.getAt(rowIndex).data.EST_EMP_NAME)}, false);   				// 견적담당자
	Ext.get('custom_code').set({value : fnFixNull(store.getAt(rowIndex).data.CUSTOM_CODE)}, false);   					// 거래처코드         
	Ext.get('custom_name').set({value : fnFixNull(store.getAt(rowIndex).data.CUSTOM_NAME)}, false);   					// 거래처코드
	Ext.get('costomer_num').set({value : fnFixNull(store.getAt(rowIndex).data.COSTOMER_NUM)}, false);   				// 거래처담당자번호  
	Ext.get('costomer_name').set({value : fnFixNull(store.getAt(rowIndex).data.COSTOMER_NAME)}, false);   				// 거래처담당자
	Ext.get('customer_dept').set({value : fnFixNull(store.getAt(rowIndex).data.CUSTOMER_DEPT)}, false);   				// 거래처담당자부서
	Ext.get('est_valid_type_code').set({value : fnFixNull(store.getAt(rowIndex).data.EST_VALID_TYPE_CODE)}, false);   	// 견적유효기간구분코드 
	Ext.get('delivery_exp_date').set(  {value : fnFixNull(store.getAt(rowIndex).data.DELIVERY_EXP_DATE)}, false);   	// 납품예정일           
	//Ext.get('delivery_custom_code').set({value : fnFixNull(store.getAt(rowIndex).data.DELIVERY_CUSTOM_CODE)}, false); // 납품처코드           
	Ext.get('pay_conditon').set({value : fnFixNull(store.getAt(rowIndex).data.PAY_CONDITON)}, false);   				// 지불조건             
	Ext.get('est_total_amt').set({value : fnFixNull(MoneyComma(store.getAt(rowIndex).data.EST_TOTAL_AMT))}, false);   				// 견적총액             
	Ext.get('discnt_total_amt').set({value : fnFixNull(MoneyComma(store.getAt(rowIndex).data.DISCNT_TOTAL_AMT))}, false);   		// 할인총액             
	Ext.get('est_aply_total_amt').set({value : fnFixNull(MoneyComma(store.getAt(rowIndex).data.EST_APLY_TOTAL_AMT))}, false);   	// 견적적용총액         
	Ext.get('est_aply_total_tax').set({value : fnFixNull(MoneyComma(store.getAt(rowIndex).data.EST_APLY_TOTAL_TAX))}, false);   	// 견적적용총세액       
	Ext.get('pjt_date_from').set({value : fnFixNull(store.getAt(rowIndex).data.PJT_DATE_FROM)}, false);   				// 프로젝트기간 FROM    
	Ext.get('pjt_date_to').set({value : fnFixNull(store.getAt(rowIndex).data.PJT_DATE_TO)}, false);   					// 구축기간 To          
	Ext.get('ref_desc').set({value : fnFixNull(store.getAt(rowIndex).data.REF_DESC)}, false);   						// 침고시항             
	Ext.get('final_mod_id').set({value : fnFixNull(store.getAt(rowIndex).data.FINAL_MOD_ID)}, false);   				// 최종변경자ID         
	Ext.get('final_mod_date').set({value : fnFixNull(store.getAt(rowIndex).data.FINAL_MOD_DATE)}, false);  	 			// 최종변경일시         

	var keyValue1 = fnFixNull(store.getAt(rowIndex).data.EST_VERSION);		 // 버전
	var keyValue2 = fnFixNull(store.getAt(rowIndex).data.EST_ID);			 // 견적ID
	var modify_yn = fnFixNull(store.getAt(rowIndex).data.MODIFY_YN);		 // 수정가능여부
	
	// 버튼 disable
	Ext.get('saveBtn').dom.disabled   = true;
	Ext.get('updateBtn').dom.disabled = false;
	Ext.get('printBtn').dom.disabled  = false;
	Ext.get('estimateRevBtn').dom.disabled = false;
	
	// 견적상태가 (B90 : 견적확정)또는 프로젝트가 드롭(99:DROP)되면
	// 해당견적은 더이상 수정을 할수 없도록 변경
	if(modify_yn == 'N'){
		Ext.get('updateBtn').dom.disabled = true;	
	}
	
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
						
						var rowCnt2nd = GridClass_edit_2nd.store.getCount();  // Grid의 총갯수
					
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
var keyNm_edit_1st		= "";
var pageSize_edit_1st	= 4;
var limit_edit_1st		= pageSize_edit_1st;
var start_edit_1st		= 0;
var proxyUrl_edit_1st	= "/est/estimate/result_edit_1st.sg";
var gridRowDeleteYn	    = "";

// 행추가
function addNew_edit_1st(){
			
	var Plant = GridClass_edit_1st.grid.getStore().recordType; 
    var p = new Plant({ 
	        		    FLAG			: 'I' 
	        		  , EST_ID		    : Ext.get('est_id').getValue()
				   	  , EST_VERSION	    : Ext.get('est_version').getValue()
				   	  , ITEM_CODE       : ''
  				   	  , CNT             : 0
				   	  , UNIT_PRICE      : 0
				   	  , AMT             : 0
				   	  , DISCOUNT_RATIO  : 0
				   	  , APLY_UNIT_PRICE : 0
				   	  , APLY_AMT        : 0
				   	  , APLY_TAX        : 0
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
	   ['','선택하세요'],
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
var	userColumns_edit_1st	= [ {header: '상태',			width: 60,  sortable: true, dataIndex: 'FLAG'              ,hidden : true}
							  , {header: "버전",			width: 50,	sortable: true,	dataIndex: "EST_VERSION",		editor: new Ext.form.TextField({ allowBlank : false })}
							  , {header: "견적ID",		width: 80,	sortable: true,	dataIndex: "EST_ID",			editor: new Ext.form.TextField({ allowBlank : false })}
		  , {id:'est_info_seq',  header: "순번",			width: 10,	sortable: true,	dataIndex: "EST_INFO_SEQ",		editor: new Ext.form.TextField({ allowBlank : false }), hidden:true}
							  , {header: "* 품목코드",	width: 100,	sortable: true,	dataIndex: "ITEM_CODE",			editor: new Ext.form.TextField({ allowBlank : false }), renderer: changeBLUE}
							  , {header: "품목명",		width: 100,	sortable: true,	dataIndex: "ITEM_NAME",			editor: new Ext.form.TextField({ allowBlank : false })}
							  , {header: "수량",			width: 50,	sortable: true,	dataIndex: "CNT",				editor: new Ext.form.TextField({ allowBlank : false }), align : 'right'}
							  , {header: "단가",			width: 50,	sortable: true,	dataIndex: "UNIT_PRICE",		editor: new Ext.form.TextField({ allowBlank : false }), editable:false ,renderer: "korMoney" , align : 'right'}
							  , {header: "금액",			width: 70,	sortable: true,	dataIndex: "AMT",				editor: new Ext.form.TextField({ allowBlank : false }), editable:false ,renderer: "korMoney" , align : 'right'}
							  , {header: "할인율",		width: 70,	sortable: true,	dataIndex: "DISCOUNT_RATIO",	editor: new Ext.form.TextField({ allowBlank : false }), align : 'right'}
							  , {header: "유무상구분",	width: 70,	sortable: true,	dataIndex: "PAY_FREE_CODE",		editor: PAY_FREE_CODE_COMBO  ,renderer: Ext.util.Format.comboRenderer(PAY_FREE_CODE_COMBO)}
							  , {header: "적용단가",		width: 70,	sortable: true,	dataIndex: "APLY_UNIT_PRICE",	editor: new Ext.form.TextField({ allowBlank : false }), editable:false ,renderer: "korMoney", align : 'right'}
							  , {header: "적용금액",		width: 70,	sortable: true,	dataIndex: "APLY_AMT",			editor: new Ext.form.TextField({ allowBlank : false }), renderer: "korMoney", align : 'right'}
							  , {header: "적용세액",		width: 70,	sortable: true,	dataIndex: "APLY_TAX",			editor: new Ext.form.TextField({ allowBlank : false }), editable:false ,renderer: "korMoney", align : 'right'}
							  , {header: "비고",			width: 150,	sortable: true,	dataIndex: "NOTE",				editor: new Ext.form.TextField({ allowBlank : false })}
							  , {header: "최종변경자ID",	width: 10,	sortable: true,	dataIndex: "FINAL_MOD_ID",		editor: new Ext.form.TextField({ allowBlank : false }), hidden:true}
							  , {header: "최종변경일시",	width: 10,	sortable: true,	dataIndex: "FINAL_MOD_DATE",	editor: new Ext.form.TextField({ allowBlank : false }), hidden:true}
							  ];

// 맵핑 필드
var	mappingColumns_edit_1st	= [ {name: "FLAG", 		        type:"string", mapping: "FLAG"}
							  , {name: "EST_VERSION", 		type:"string", mapping: "EST_VERSION"}
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
var	gridWidth_edit_2nd  = 1000	;
var	gridTitle_edit_2nd  = "납품처 시스템 사양정보"	; 
var	render_edit_2nd		= "edit_grid_2nd";
var keyNm_edit_2nd		= "";
var pageSize_edit_2nd	= 4;
var limit_edit_2nd		= pageSize_edit_2nd;
var start_edit_2nd		= 0;
var proxyUrl_edit_2nd	= "/est/estimate/result_edit_2nd.sg";
var grid2ndRowDeleteYn  = "";

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
	  ['', '선택하세요'],
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
var	userColumns_edit_2nd	= [ {header: '상태',			width: 80,  sortable: true, dataIndex: 'FLAG'          ,hidden : true}
							  , {header: "버전",			width: 70,	sortable: true,	dataIndex: "EST_VERSION",	editor: new Ext.form.TextField({ allowBlank : false }) }
							  , {header: "견적ID",		width: 100,	sortable: true,	dataIndex: "EST_ID",		editor: new Ext.form.TextField({ allowBlank : false }) }
							  , {header: "순번",			width: 50,	sortable: true,	dataIndex: "EST_INFO_SEQ",	editor: new Ext.form.TextField({ allowBlank : false }) , hidden:true}
							  , {header: "제원구분코드",	width: 100,	sortable: true,	dataIndex: "SPEC_TYPE_CODE",editor: SPEC_TYPE_CODE_COMBO  ,renderer: Ext.util.Format.comboRenderer(SPEC_TYPE_CODE_COMBO) }
							  , {header: "제원설명",		width: 250,	sortable: true,	dataIndex: "SPEC_INTRO",	editor: new Ext.form.TextField({ allowBlank : false }) }
							  , {header: "제원수량",		width: 70,	sortable: true,	dataIndex: "SPEC_CNT",		editor: new Ext.form.TextField({ allowBlank : false }) }
							  , {header: "제원용량",		width: 70,	sortable: true,	dataIndex: "SPEC_VOL",		editor: new Ext.form.TextField({ allowBlank : false }) }
							  , {header: "비고",			width: 250,	sortable: true,	dataIndex: "NOTE",			editor: new Ext.form.TextField({ allowBlank : false }) }
							  , {header: "최종변경자ID",	width: 10,	sortable: true,	dataIndex: "FINAL_MOD_ID",	editor: new Ext.form.TextField({ allowBlank : false }) , hidden:true}
							  , {header: "최종변경일시",	width: 10,	sortable: true,	dataIndex: "FINAL_MOD_DATE",editor: new Ext.form.TextField({ allowBlank : false }) , hidden:true}
							  ];

// 맵핑 필드
var	mappingColumns_edit_2nd	= [ {name: "FLAG",		 	type:"string", mapping: "FLAG"}
							  , {name: "EST_VERSION", 	type:"string", mapping: "EST_VERSION"}		// 버전        
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

	var dForm = document.detailForm;		// 상세 FORM	
	dForm.reset();							// 상세필드 초기화
	
	// 버튼 초기화
	Ext.get('saveBtn').dom.disabled    	   = false;
	Ext.get('updateBtn').dom.disabled  	   = true;
	Ext.get('printBtn').dom.disabled  	   = true;
	Ext.get('estimateRevBtn').dom.disabled = true;
	Ext.get('proc_status_code').dom.disabled = true;
	Ext.get('proc_status_code').set({value : 'B10'}, false);   
	
	// 견적담당자, 견적부서 설정
	Ext.get('est_emp_num').set({value : '${admin_id}'}, false);  
	Ext.get('est_dept_code').set({value : '${dept_code}'}, false);  
	Ext.get('est_dept_name').set({value : '${dept_nm}'}, false);  
	Ext.get('est_emp_name').set({value : '${admin_nm}'}, false);  
		
	Ext.get('roll_type_code').set({value: 'SAL'} , false);	// 업무구분
	Ext.get('est_id').set({value : Ext.get('new_est_id').getValue()}, false);
	Ext.get('est_version').set({value : 0}, false);
	Ext.get('final_mod_name').set({value : '${admin_nm}'}, false);
    Ext.get('final_mod_id').set({value : '${admin_id}'}, false);
	Ext.get('final_mod_date').set({value : getTimeStamp().trim()}, false);
	
	try{
		GridClass_edit_1st.store.commitChanges();	// 변경된 record를 commit
		GridClass_edit_1st.store.removeAll();		// store자료를 삭제
		GridClass_edit_2nd.store.commitChanges();
		GridClass_edit_2nd.store.removeAll();
	}catch(e){
		
	}
}

/***************************************************************************
 * 설  명 : 저장버튼 클릭
 ***************************************************************************/
function fnSave(divValue){  	

	// 변경된 견적 품목정보 Grid의 record 
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
    	
	// 변경된 납품처 시스템 사양정보 Grid의 record
	var record2 = GridClass_edit_2nd.store.getModifiedRecords();	  
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
		url: "/est/estimate/saveEstimateInfoManage.sg"   
		,success: function(response){						// 조회결과 성공시
					// 조회된 결과값, store명
					handleSuccess(response,GridClass_1st,'save');
				 
 				    var json = Ext.util.JSON.decode(response.responseText);
		            var new_est_id = json.new_est_id;
		            
		          	if(divValue == 'save'){
		          		Ext.get('new_est_id').set({value : new_est_id}, false);
					}
		          	 
		          	fnInitValue();
		
		          } 
		,failure: handleFailure   	    // 조회결과 실패시  
		,form   : document.detailForm	// 상세 FORM	
		,params : {					    // 조회조건을 DB로 전송하기위해서 조건값 설정
				  // 페이지정보
					limit          	   : limit_1st
			  	  , start          	   : start_1st
			  	  , edit1stData		   : edit1stJson 		// 견적품목정보
  				  , edit2ndData        : edit2ndJson		// 납품처시스템 사양정보
  				  // disable처리된 필드값
  				  , est_id			   : Ext.get('est_id').getValue()		  	  // 견적ID  
				  , est_version        : Ext.get('est_version').getValue()		  // 버전  
				  , proc_status_code   : Ext.get('proc_status_code').getValue()	  // 진행상태
				  
				  // 검색정보
			  	  , src_pjt_id   	   : '<%=request.getParameter("src_pjt_id")%>'		  // 프로젝트ID   
			  	  , src_pjt_name   	   : '<%=request.getParameter("src_pjt_name")%>'	  // 프로젝트명
			  	
			  	  , src_custom_name    : ''
			  	  , src_est_type_code  : ''
			  	  , src_est_id         : ''
			  	  , src_est_date_start : ''
			  	  , src_est_date_end   : ''
			  	  , src_final_version  : 'Y'    
			  	  , src_est_name   	   : ''
			  	  
			  	  // disable필드
			  	  , est_total_amt      : Ext.get('est_total_amt').getValue()      // 견적총액
			  	  , discnt_total_amt   : Ext.get('discnt_total_amt').getValue()   // 할인총액
			  	  , est_aply_total_amt : Ext.get('est_aply_total_amt').getValue() // 견적적용총액
			  	  , est_aply_total_tax : Ext.get('est_aply_total_tax').getValue() // 견적적용총세액
			  	  , roll_type_code     : Ext.get('roll_type_code').getValue() 	  // 업무구분
			  	  , saveDiv			   : divValue								  // 등록(save), 수정(update)구분
				  }  		
	});  

}  		

function fnOzReport(){
	
	alert("오즈");
	Ext.Ajax.request({   
		url: "/est/estimate/ozReport.sg"   
		,success: function(response){									  // 조회결과 성공시
					// 조회된 결과값, store명
					// handleSuccess(response,GridClass_1st);
		          } 
		,failure: handleFailure   	    // 조회결과 실패시  
		,params : {					    // 조회조건을 DB로 전송하기위해서 조건값 설정
				  // 페이지정보
  				    est_id		   : Ext.get('est_id').getValue()		  // 견적ID  
				  , est_version    : Ext.get('est_version').getValue()	  // 버전  
			  	  , pjt_id   	   : Ext.get('pjt_id').getValue()		  // 프로젝트ID   
				  }  		
	});  

}

/***************************************************************************
 * 설  명 : 화면 설정
 ***************************************************************************/
// ExtJS 진입함수
Ext.onReady(function() {

	var dForm = document.detailForm;
	
	var toDay = getTimeStamp();	
	toDay = toDay.replaceAll('-','');
	toDay = addDate(toDay, 'M', -3);
	toDay = toDay.substring(0,4)+"-"+toDay.substring(4,6)+"-"+toDay.substring(6,8);
	var fromDay = toDay;
	toDay = getTimeStamp().trim();
	
   	
   	// 거래처검색 버튼
   	Ext.get('customCodeBtn').on('click', function(e){
		var param = '';
		fnCostomerPop(param)
	});
   	
   	// 프로젝트 검색팝업
   	Ext.get('pjtIdBtn').on('click', function(e){
		param = "?fieldName=pjt_id&src_pjt_type_code=10";		// 10_영업관리 프로젝트만 검색
		fnPjtPop(param);
	});
   	
   	
   	// 담당자검색 버튼
   	// 여러건을 팝업으로 부터 전송 받을경우 param뒤에 &multiSelectYn=Y 를 추가 
	Ext.get('estEmpNumBtn').on('click', function(e){
		var param = '';
		fnEmployeePop(param)
	});
   	
   	// 담당자검색 버튼
   	// 여러건을 팝업으로 부터 전송 받을경우 param뒤에 &multiSelectYn=Y 를 추가 
	Ext.get('costomerNumBtn').on('click', function(e){
		var param = '';
		fnCostomerPop(param)
	});
			
   	//신규 버튼 -> 상세필드 초기화
	Ext.get('detailClearBtn').on('click', function(e){
		fnInitValue();		   
	});		
   	
   	//견적 Rev 버튼 -> 상세필드 초기화
	Ext.get('estimateRevBtn').on('click', function(e){
		
		var param = "?estId="+Ext.get('est_id').getValue();
		param = param + "&pjtId="+Ext.get('pjt_id').getValue();
		fnEstimateInfoRev(param);	   
	});
   	
   	//출력버튼 -> 상세필드 초기화
	Ext.get('printBtn').on('click', function(e){
		alert("출력");
		//	fnOzReport();	   
	});		
			
	//저장 버튼 -> 데이터를 server로 전송
	Ext.get('saveBtn').on('click', function(e){	
		if(fnValidation()){
			Ext.MessageBox.confirm('Confirm', '저장하시겠습니까?', showResultSave);
		};
	});
	
	//수정 버튼 -> 데이터를 server로 전송
	Ext.get('updateBtn').on('click', function(e){	
		if(fnValidation()){
			Ext.MessageBox.confirm('Confirm', '수정하시겠습니까?', showResultUpdate);
		};	
	});
   	
    
	/*
	// 프로젝트 시작
	var pjt_date_from = new Ext.form.DateField({
    	applyTo: 'pjt_date_from',
		allowBlank: false,
		format:'Y-m-d',
		editable : false
	});
	
	// 프로젝트 종료
	var pjt_date_to = new Ext.form.DateField({
    	applyTo: 'pjt_date_to',
		allowBlank: false,
		format:'Y-m-d',
		editable : false
	});
	
	// 견적일자
	var est_date = new Ext.form.DateField({
    	applyTo: 'est_date',
		allowBlank: false,
		format:'Y-m-d',
		editable : false
	});
   	
	// 납품예정일
	var delivery_exp_date = new Ext.form.DateField({
    	applyTo: 'delivery_exp_date',
		allowBlank: false,
		format:'Y-m-d',
		editable : false
	});
	*/
	
	//견적담당자 이름 수정시    
	Ext.get('est_emp_name').on('change', function(e){	
		
		var est_emp_name = Ext.get('est_emp_name').getValue();
		
		if(est_emp_name == ""){
			Ext.get('est_emp_num').set({value: ''} , false);				
		}
	});
	
	//견적담당자 이름 수정시
	Ext.get('est_dept_name').on('change', function(e){	
		var est_dept_name = Ext.get('est_dept_name').getValue();
		if(est_dept_name == ""){
			Ext.get('est_dept_code').set({value: ''} , false);				
		}
	});
	
	//거래처 이름 수정시
	Ext.get('custom_name').on('change', function(e){	
		var custom_name = Ext.get('custom_name').getValue();
		if(custom_name == ""){
			Ext.get('custom_code').set({value: ''} , false);				
		}
	});
	
	//거래처담당자 이름 수정시
	Ext.get('costomer_name').on('change', function(e){	
		var costomer_name = Ext.get('costomer_name').getValue();
		if(costomer_name == ""){
			Ext.get('costomer_num').set({value: ''} , false);		
			Ext.get('customer_dept').set({value: ''} , false);
		}
	});

	// disable처리
	Ext.get('final_mod_name').dom.disabled    = true;
	Ext.get('final_mod_date').dom.disabled  = true;
	Ext.get('est_id').dom.disabled  		= true;
	Ext.get('est_version').dom.disabled  	= true;
	
	Ext.get('est_total_amt').dom.disabled      = true;	// 견적총액
	Ext.get('discnt_total_amt').dom.disabled   = true;  // 할인총액
	Ext.get('est_aply_total_amt').dom.disabled = true;  // 견적적용총액
	Ext.get('est_aply_total_tax').dom.disabled = true;  // 견적적용총세액
 	Ext.get('roll_type_code').dom.disabled = true;  	// 업무구분
 	
 	Ext.get('new_est_id').set({value : '${new_est_id}'}, false);
 	
	fnInitValue();
	
}); // end Ext.onReady

// 저장, 수정버튼 클릭시 '예','아니오' 
function showResultSave(btn){
   	if(btn == 'yes'){
   		fnSave('save');
   	}    	
};

function showResultUpdate(btn){
   	if(btn == 'yes'){
   		fnSave('update');
   	}    	
};
	
/***************************************************************************
 * 설  명 : 그리드의 페이지 클릭시 검색조건값을 DB로 전송
 ***************************************************************************/
// 견적 Rev 팝업 ********************************************
function fnEstimateInfoRev(param){
	var sURL      = "/est/estimate/estimateInfoManageRevPop.sg"+param;
	var dlgWidth  = 399;
	var dlgHeight = 414;
	var winName   = "estimate";
	fnOpenPop(sURL, dlgWidth, dlgHeight, winName);
} 

function fnEstimateInfoManagePopValue(records){
	
	// 전송받은 값이 한건일 경우
    var record = records[0].data;				
    
    Ext.get('flag').set({value : 'I'}, false);   													// 상태                               
	Ext.get('est_id').set({value : fnFixNull(record.EST_ID)}, false);   							// 견적ID               
	Ext.get('est_version').set({value : fnFixNull(record.FINAL)}, false);   						// 버전                   
	Ext.get('proc_status_code').set({value : fnFixNull(record.PROC_STATUS_CODE)}, false);   		// 진행상태코드         
	Ext.get('est_type_code').set({value : fnFixNull(record.EST_TYPE_CODE)}, false);   				// 견적구분             
	Ext.get('custom_name').set({value : fnFixNull(record.CUSTOM_NAME)}, false);   					// 거래처코드           
	Ext.get('est_date').set({value : fnFixNull(record.EST_DATE)}, false);   						// 견적일자             
	Ext.get('roll_type_code').set({value : fnFixNull(record.ROLL_TYPE_CODE)}, false);   			// 업무구분코드         
	Ext.get('pjt_id').set({value : fnFixNull(record.PJT_ID)}, false);   							// 프로젝트ID           
	Ext.get('est_name').set({value : fnFixNull(record.EST_NAME)}, false);   						// 견적명               
	Ext.get('est_dept_code').set({value : fnFixNull(record.EST_DEPT_CODE)}, false);   				// 견적부서코드        
	Ext.get('est_emp_num').set({value : fnFixNull(record.EST_EMP_NUM)}, false);   					// 견적담당자사번       
	Ext.get('custom_code').set({value : fnFixNull(record.CUSTOM_CODE)}, false);   					// 거래처코드           
	Ext.get('costomer_num').set({value : fnFixNull(record.COSTOMER_NUM)}, false);   				// 거래처담당자번호     
	Ext.get('est_valid_type_code').set({value : fnFixNull(record.EST_VALID_TYPE_CODE)}, false);   	// 견적유효기간구분코드 
	Ext.get('delivery_exp_date').set(  {value : fnFixNull(record.DELIVERY_EXP_DATE)}, false);   	// 납품예정일           
	//Ext.get('delivery_custom_code').set({value : fnFixNull(record.DELIVERY_CUSTOM_CODE)}, false); // 납품처코드           
	Ext.get('pay_conditon').set({value : fnFixNull(record.PAY_CONDITON)}, false);   				// 지불조건             
	Ext.get('est_total_amt').set({value : fnFixNull(MoneyComma(record.EST_TOTAL_AMT))}, false);   				// 견적총액             
	Ext.get('discnt_total_amt').set({value : fnFixNull(MoneyComma(record.DISCNT_TOTAL_AMT))}, false);   		// 할인총액             
	Ext.get('est_aply_total_amt').set({value : fnFixNull(MoneyComma(record.EST_APLY_TOTAL_AMT))}, false);   	// 견적적용총액         
	Ext.get('est_aply_total_tax').set({value : fnFixNull(MoneyComma(record.EST_APLY_TOTAL_TAX))}, false);   	// 견적적용총세액       
	Ext.get('pjt_date_from').set({value : fnFixNull(record.PJT_DATE_FROM)}, false);   				// 프로젝트기간 FROM    
	Ext.get('pjt_date_to').set({value : fnFixNull(record.PJT_DATE_TO)}, false);   					// 구축기간 To          
	Ext.get('ref_desc').set({value : fnFixNull(record.REF_DESC)}, false);   						// 침고시항             
	Ext.get('final_mod_id').set({value : ''}, false);   											// 최종변경자ID         
	Ext.get('final_mod_date').set({value : ''}, false);  	 										// 최종변경일시         
    
	var keyValue1 = fnFixNull(record.EST_VERSION);		 // 버전
	var keyValue2 = fnFixNull(record.EST_ID);		     // 견적ID
	var value3 = fnFixNull(record.FINAL);
	
	fnSearchEdit1st(keyValue1,keyValue2,value3);
	fnSearchEdit2nd(keyValue1,keyValue2,value3);
	
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
	
	// 전송받은 값이 한건일 경우
    var record = records[0].data;	
	
	if(fieldName == 'pjt_id'){
	    
		GridClass_edit_1st.store.commitChanges();	// 변경된 record를 commit
		GridClass_edit_1st.store.removeAll();		// store자료를 삭제
		GridClass_edit_2nd.store.commitChanges();
		GridClass_edit_2nd.store.removeAll();
		
		Ext.get('pjt_id').set({value:fnFixNull(record.PJT_ID)} , false);
	    Ext.get('pjt_name').set({value:fnFixNull(record.PJT_NAME)} , false);
	    Ext.get('pjt_date_from').set({value:fnFixNull(record.PJT_DATE_FROM)} , false);
	    Ext.get('pjt_date_to').set({value:fnFixNull(record.PJT_DATE_TO)} , false);
	    Ext.get('est_name').set({value:fnFixNull(record.PJT_NAME)+"_견적"} , false);
	    
	    fnPjtCustom(record.PJT_ID)	//  프로젝트 거래처 정보
	    
    } 
}

function fnPjtCustom(ptj_id){  	
	
	Ext.Ajax.request({   
		url: "/est/estimate/selectPjtCustom.sg"
		,method : 'POST'   
		,success: function(response){						// 조회결과 성공시
					// 조회된 결과값, store명
					var json = Ext.util.JSON.decode(response.responseText);
					
					// 거래처 정보가 있다면
					if(json.data.length > 0){
						Ext.get('custom_code').set({value:fnFixNull(json.data[0].CUSTOM_CODE)} , false); // 거래처코드
						Ext.get('custom_name').set({value:fnFixNull(json.data[0].CUSTOM_NAME)} , false); 
						Ext.get('costomer_name').set({value:fnFixNull(json.data[0].CUSTOMER_NAME)} , false);
						Ext.get('costomer_num').set({value:fnFixNull(json.data[0].COSTOMER_NUM)} , false);
						Ext.get('customer_dept').set({value:fnFixNull(json.data[0].CUSTOMER_DEPT)} , false);
					}
					
					GridClass_edit_1st.store.loadData(json)
					fnCalculateItemAmt('');
					
					var rowCnt1st = GridClass_edit_1st.store.getCount();  // Grid의 총갯수
				
					for(i = 0 ; i < rowCnt1st ; i++){
						var record1 = GridClass_edit_1st.store.getAt(i);
						record1.set('EST_ID', Ext.get('est_id').getValue());
					    record1.set('EST_VERSION', Ext.get('est_version').getValue());
					} // end for
		          }   							
		,failure: handleFailure   	   						// 조회결과 실패시  
		,params : {					   						// 조회조건을 DB로 전송하기위해서 조건값 설정
			 		// 페이지 		
					 limit			: limit_edit_1st
				   , start			: start_edit_1st
				   
				   , src_pjt_id   	: '<%=request.getParameter("src_pjt_id")%>'   
			  	   , src_pjt_name   : '<%=request.getParameter("src_pjt_name")%>'
				  }				
	});  
	
}  
// 거래처 **************************************************
function fnCustomPop(param){
	var sURL      = "/com/custom/customPop.sg"+param;
	var dlgWidth  = 399;
	var dlgHeight = 364;
	var winName   = "custom";
	fnOpenPop(sURL, dlgWidth, dlgHeight, winName);
}

// 거래처담당자 검색팝업 *************************************
function fnCostomerPop(param){
	var sURL      = "/com/custom/customMemberPop.sg"+param;
	var dlgWidth  = 399;
	var dlgHeight = 396;
	var winName   = "customer";
	fnOpenPop(sURL, dlgWidth, dlgHeight, winName);
}

// 거래처담당자 검색 결과 return Value
function fnCostomerPopValue(records){
		
	// 전송받은 값이 한건일 경우
    var record = records[0].data;				

    Ext.get('costomer_name').set({value:fnFixNull(record.CUSTOMER_NAME)} , false);
    Ext.get('costomer_num').set({value:fnFixNull(record.CUSTOMER_NUM)} , false);
    Ext.get('customer_dept').set({value:fnFixNull(record.CUSTOMER_DEPT)} , false);
    Ext.get('custom_name').set({value:fnFixNull(record.CUSTOM_NAME)} , false);
    Ext.get('custom_code').set({value:fnFixNull(record.CUSTOM_CODE)} , false);
    
}

// 견적담당자 검색팝업 ****************************************
function fnEmployeePop(param){
	var sURL      = "/com/employee/employeePop.sg"+param;
	var dlgWidth  = 399;
	var dlgHeight = 396;
	var winName   = "담당자";
	fnOpenPop(sURL, dlgWidth, dlgHeight, winName);
}

// 견적담당자 검색 결과 return Value
function fnEmployeePopValue(records,fileName){
		
	// 전송받은 값이 한건일 경우
    var record = records[0].data;				

    Ext.get('est_emp_num').set({value:fnFixNull(record.EMP_NUM)} , false);
    Ext.get('est_emp_name').set({value:fnFixNull(record.KOR_NAME)} , false);
    Ext.get('est_dept_code').set({value:fnFixNull(record.DEPT_CODE)} , false);
    Ext.get('est_dept_name').set({value:fnFixNull(record.DEPT_NAME)} , false);
	
	// 전송 받은 값이 여러건일 경우
	/*
    var popGrid1stJson = "[";
    for (var i = 0; i < records.length; i++) {
      popGrid1stJson += Ext.util.JSON.encode(records[i].data);				
      if (i < (records.length-1)) {
        popGrid1stJson += ",";
      }
    }
   	popGrid1stJson += "]"
	*/    	
}

// 품목 팝업 ****************************************
function fnItemPop(param){
	var sURL      = "/com/item/itemSearchPop.sg"+param;
	var dlgWidth  = 399;
	var dlgHeight = 396;
	var winName   = "item";
	fnOpenPop(sURL, dlgWidth, dlgHeight, winName);
}

function fnItemSearchPopValue(records){
	
	// 선택된 row
	var record = GridClass_edit_1st.grid.selModel.getSelected(); 
	// popUp에서 선택된 아이템 코드값
	var item_code = records[0].data.ITEM_CODE;
	var item_name = records[0].data.ITEM_NAME;
	var unit_price_01 = records[0].data.UNIT_PRICE_01;
	
	// 값을 설정
	record.set('ITEM_CODE', item_code);			// 품목코드
	record.set('ITEM_NAME', item_name);			// 품목명
	record.set('UNIT_PRICE', unit_price_01);	// 단가
	
	fnCalculateItemAmt('');
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
		//var temp= GridClass_edit_1st.store;
		//var gridName = "GridClass_edit_1st";
		//var grid_name = "grid_name=" + gridName;
		//var grid_row = "grid_row=" + rowIndex;
		//var grid_fieldName = "grid_fieldName=" + 'ITEM_CODE';
		//var param = "?"+grid_name +'&'+ grid_row +'&'+ grid_fieldName;
		//fnCustomPop(param);
	}
	//품목 코드 팝업
	if(columnIndex == '4'){
		param = "";
		fnItemPop(param);
	}
}

// 새로 추가된 행을 삭제 하면
function fnEdit1stBeforeRowDeleteEvent(){
	var records = GridClass_edit_1st.grid.selModel.getSelections(); 
	
	records[0].set('FLAG','D');
}

// 새로 추가된 행을 삭제 하면
function fnEdit2ndBeforeRowDeleteEvent(){
	var records = GridClass_edit_2nd.grid.selModel.getSelections(); 
	
	records[0].set('FLAG','D');
}
/***************************************************************************
 * 설  명 : 에디트 그리드의 CELL을 수정하였을 경우 이벤트
 ***************************************************************************/
function  fnEdit1stAfterCellEdit(obj){

	var editedRow = obj.row;
	var editedColumn = obj.column;
	var editedValue = obj.value;
	var fieldName = obj.field;
	
	// 해당 컬럼의 값이 변경 되었을 경우
	if( fieldName == 'CNT' || fieldName == 'UNIT_PRICE' 
	 || fieldName == 'DISCOUNT_RATIO' || fieldName == 'PAY_FREE_CODE' 
	 || fieldName == 'APLY_AMT'){
		fnCalculateItemAmt(fieldName);
	}// end if

}

function fnEdit1stAfterRowDeleteEvent(){
	fnCalculateItemAmt('');
}

// 견적 품목정보 금액 계산
function fnCalculateItemAmt(fieldName){
	
	var rowCnt = GridClass_edit_1st.store.getCount();  // Grid의 총갯수
	var estTotalAmt = 0;		// 수주총액
	var discntTotalAmt = 0 ; 	// 할인총액
	var estAplyTotalAmt = 0;    // 수주적용총액
	var estAplyTotalTax = 0;	// 수주적용총세액
	
	if( rowCnt > 0){
		//row 숫자만큼 돌면서 수량*단가를 가져옴
		for(i = 0 ; i < rowCnt ; i++){
				
			var record = GridClass_edit_1st.store.getAt(i);
			var discount_ratio = parseFloat(GridClass_edit_1st.store.data.items[i].data.DISCOUNT_RATIO)/100 ;   // 할인율
			var pay_free_code = GridClass_edit_1st.store.data.items[i].data.PAY_FREE_CODE;						// 유무상구분
			var aply_amt = parseFloat(GridClass_edit_1st.store.data.items[i].data.APLY_AMT) ;   				// 할인율
			
			//alert('1 : '+aply_amt);
			
			// 금액 = 수량 * 단가
			var rowAMT = parseInt(GridClass_edit_1st.store.data.items[i].data.CNT) * parseInt(GridClass_edit_1st.store.data.items[i].data.UNIT_PRICE);
			
			// 적용금액이 변경되면
			if(fieldName == 'APLY_AMT'){
				discount_ratio = 1 - (aply_amt  / rowAMT  ) ;
			//	alert('2 : '+discount_ratio);
			//	alert('3 : '+Math.round(discount_ratio*100));
				record.set('DISCOUNT_RATIO', fnIsNaN(Math.round(discount_ratio*1000)/10));	// 할인율
			}
			
			// 적용 금액 = 금액  - (금액 * 할인율)
			var discountAMT = parseInt(rowAMT - ( rowAMT * discount_ratio ));
			// 적용단가 = 적용금액 / 수량
			var aplyUnitPrice = parseInt(discountAMT / parseInt(GridClass_edit_1st.store.data.items[i].data.CNT));
			// 적용세액 = 적용금액 * 0.1
			var aplyTaxAMT = parseInt(discountAMT * 0.1); 
			
			// 유무상구분이 (0:무상)일 경우
			if(pay_free_code == '0'){
				discountAMT = 0;		// 적용금액
				aplyUnitPrice  = 0;		// 적용단가
				aplyTaxAMT = 0;			// 적용세액
			}
		
			record.set('AMT', fnIsNaN(rowAMT));						// 금액
			record.set('APLY_AMT', fnIsNaN(discountAMT));			// 적용금액
			record.set('APLY_TAX', fnIsNaN(aplyTaxAMT));			// 적용세액
			record.set('APLY_UNIT_PRICE', fnIsNaN(aplyUnitPrice));	// 적용단가
			
			estTotalAmt += fnIsNaN(parseInt(rowAMT));   // 견적총액
			estAplyTotalAmt += fnIsNaN(discountAMT);    // 견적적용총액
			estAplyTotalTax += fnIsNaN(aplyTaxAMT);		// 견적적용총세액
	
		} // end for	
		
	// 할인총액 = 견적총액 - 견적적용총액
	discntTotalAmt = estTotalAmt - estAplyTotalAmt;
	
	// 견적총액
	Ext.get('est_total_amt').set({value:MoneyComma(estTotalAmt)});
	// 할인총액
	Ext.get('discnt_total_amt').set({value:MoneyComma(discntTotalAmt)});
	// 견적적용총액
	Ext.get('est_aply_total_amt').set({value:MoneyComma(estAplyTotalAmt)});
	// 견적적용총세액
	Ext.get('est_aply_total_tax').set({value:MoneyComma(estAplyTotalTax)});
			
	} // end if
}

function fnValidation(){
	
	var est_type_code = Ext.get('est_type_code').getValue();			// 견적구분
	var est_date = Ext.get('est_date').getValue(); 						// 견적일자
	var est_name = Ext.get('est_name').getValue(); 						// 견적명
	var roll_type_code = Ext.get('roll_type_code').getValue();			// 업무구분
	var pjt_id = Ext.get('pjt_id').getValue();							// 프로젝트ID
	var est_emp_num = Ext.get('est_emp_num').getValue();				// 견적담당자
	var custom_code = Ext.get('custom_code').getValue();				// 거래처
	var est_valid_type_code = Ext.get('est_valid_type_code').getValue();// 유효기간
	
	if(est_type_code.length == 0 || est_type_code == ""){
		Ext.Msg.alert('확인', '견적구분을 선택해주세요.')
		return false;
	}
	
	if(est_date.length == 0 || est_date == ""){
		Ext.Msg.alert('확인', '견적일자를 입력해주세요.')
		return false;
	}
	
	if(est_name.length == 0 || est_name == ""){
		Ext.Msg.alert('확인', '견적명을 입력해주세요.')
		return false;
	}
	
	if(roll_type_code.length == 0 || roll_type_code == ""){
		Ext.Msg.alert('확인', '업무구분을 선택해주세요.')
		return false;
	}
	
	if(pjt_id.length == 0 || pjt_id == ""){
		Ext.Msg.alert('확인', '프로젝트ID를 입력해주세요.')
		return false;
	}
	
	if(est_emp_num.length == 0 || est_emp_num == ""){
		Ext.Msg.alert('확인', '견적담당자를 입력해주세요.')
		return false;
	}
	
	if(custom_code.length == 0 || custom_code == ""){
		Ext.Msg.alert('확인', '거래처를 입력해주세요.')
		return false;
	}
	
	if(est_valid_type_code.length == 0 || est_valid_type_code == ""){
		Ext.Msg.alert('확인', '유효기간을 선택해주세요.')
		return false;
	}
	
		var rowCnt = GridClass_edit_1st.store.getCount();  // Grid의 총갯수
 
		//row 숫자만큼 돌면서 수량*단가를 가져옴
		for(i = 0 ; i < rowCnt ; i++){
			var record = GridClass_edit_1st.store.getAt(i);
			var item_code = record.data.ITEM_CODE;
			if(item_code ==''){
				Ext.Msg.alert('확인', '견적정보관리의 ['+(i+1)+']번째행의 품목코드를 입력해주세요')
				return false;
			}
		}
		
	return true;
	
	

}
</script>

</head>
<body class=" ext-gecko ext-gecko3">
<input type="hidden" id="new_est_id" name="new_est_id" value=""/>
	<table border="0" width="1000" height="200"> 
		<tr>
			<!----------------- 견적기본정보 GRID START ----------------->
			<td width="40%" valign="top">
				<div id="estimateBasicInfo_grid" style="margin-top: 0em;"></div>
			</td>
			<!----------------- 견적기본정보 GRID END ----------------->
			<td width="60%" valign="top">
				<div class=" x-panel x-form-label-left" style="margin-top: 0; width: 100%;"><%-- 0em <- 1em으로 수정하면 상위 공백 --%>
					<!----------------- SEARCH Hearder Start	 ----------------->
					<div class="x-panel-tl">
						<div class="x-panel-tr">
							<div class="x-panel-tc">
								<div class="x-panel-header x-unselectable" style="-moz-user-select: none;">
									<span class="x-panel-header-text">견적 기본정보</span>
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
									<form id="detailForm" name="detailForm" method="POST" class="x-panel-body x-form" style="padding: 1px 1px 0pt; width: 600px;">
									<input type="hidden" id="flag" name="flag"/>
									<!-- 1_ROW Start -->
									<div class="x-column-inner" style="width: 100%; margin-top: 0.2em;">
										<div class=" x-panel x-column" style="width: 80%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<table cellspacing="0" class="x-btn  x-btn-noicon" style="width: 70px;" align="right">
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
												</div>
											</div>
										</div>
										<div class=" x-panel x-column" style="width: 15%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<table cellspacing="0" class="x-btn  x-btn-noicon" style="width: 70px;" align="right">
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
																			<button type="button" id="estimateRevBtn" class=" x-btn-text">견적 Rev</button>
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


									<!-- 2_ROW Start -->
									<div class="x-column-inner" style="width: 100%; margin-top: 0.2em;">
										<div class=" x-panel x-column" style="width: 48%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label class="x-form-item-label" style="width: auto;" for="est_type_code" ><font color="red">* </font>견적구분:</label>
														<div style="padding-left: 80px;" class="x-form-element">
															<select name="est_type_code" id="est_type_code" title="견적구분" style="width: 193px;" type="text" class=" x-form-select x-form-field" >
																<option value="">선택하세요</option>
																<c:forEach items="${EST_TYPE_CODE}" var="data" varStatus="status">
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
										<div class=" x-panel x-column" style="width: 48%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label class="x-form-item-label" style="width: auto;" for="est_date" ><font color="red">* </font>견적일자:</label>
														<div style="padding-left: 80px;" class="x-form-element">
															<input type="text" name="est_date" id="est_date" autocomplete="off" size="35" class=" x-form-text x-form-field" style="width: auto;"
															onFocus="restoreDateString(this, this.value)" onKeydown="_chkKeyPressNumPoint(this)" onblur="isValidDate(this, this.value)"/>
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
										<div class=" x-panel x-column" style="width: 48%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label class="x-form-item-label" style="width: auto;" for="est_id" >견적ID/버전:</label>
														<div style="padding-left: 80px;" class="x-form-element">
															<input type="text" name="est_id" id="est_id" autocomplete="off" size="24" class=" x-form-text x-form-field" style="width: auto;">
															<input type="text" name="est_version" id="est_version" autocomplete="off" size="4" class=" x-form-text x-form-field" style="width: auto;">
<%--															<select name="est_version" id="est_version" title="버전" style="width: 28%;" type="text" class=" x-form-text x-form-field" >--%>
<%--																<option value="">선택하세요</option>--%>
<%--																<c:forEach items="${EST_VERSION}" var="data" varStatus="status">--%>
<%--																	<option value="${data.COM_CODE}"><c:out value="${data.COM_CODE_NAME}"/></option>--%>
<%--																</c:forEach>--%>
<%--															</select>--%>
														</div>
														<div class="x-form-clear-left">
														</div>
													</div>
												</div>
											</div>
										</div>
										<div class=" x-panel x-column" style="width: 48%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label class="x-form-item-label" style="width: auto;" for="est_name" ><font color="red">* </font>견적명:</label>
														<div style="padding-left: 80px;" class="x-form-element">
															<input type="text" name="est_name" id="est_name" autocomplete="off" size="35" class=" x-form-text x-form-field" style="width: auto;">
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
										<div class=" x-panel x-column" style="width: 48%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label class="x-form-item-label" style="width: auto;" for="roll_type_code" ><font color="red">* </font>업무구분:</label>
														<div style="padding-left: 80px;" class="x-form-element">
															<select name="roll_type_code" id="roll_type_code" title="업무구분" style="width: 193px;" type="text" class=" x-form-select x-form-field" >
																<option value="">선택하세요</option>
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
										<div class=" x-panel x-column" style="width: 48%;" >
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label class="x-form-item-label" style="width: auto;" for="pjt_id" ><font color="red">* </font>프로젝트ID:</label>
														<div style="padding-left: 80px;" class="x-form-element">
															<table style="width:200px;" cellspacing="0" class="x-btn  x-btn-noicon">
																<tr>
																	<td>
																		<input type="text" name="pjt_id" id="pjt_id" autocomplete="off" size="26" class=" x-form-text x-form-field" style="width: auto;">
																	</td>
																	<td>
																		<%-- Button Start--%>
																		<table cellspacing="0" class="x-btn  x-btn-noicon" style="width: 20px;" align="right">
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
																							<button type="button" id="pjtIdBtn" class=" x-btn-text">검색</button>
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
									
									
									<!-- 8_ROW Start -->
									<div class="x-column-inner" style="width: 100%;">
										<div class=" x-panel x-column" style="width: 48%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label class="x-form-item-label" style="width: auto;" for="pay_conditon" >지불조건:</label>
														<div style="padding-left: 80px;" class="x-form-element">
															<select name="pay_conditon" id="pay_conditon" title="지불조건" style="width: 193px;" type="text" class=" x-form-select x-form-field" >
																<option value="">선택하세요</option>
																<c:forEach items="${PAY_CONDITION}" var="data" varStatus="status">
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
										<div class=" x-panel x-column" style="width: 48%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label class="x-form-item-label" style="width: auto;" for="pjt_name" ></label>
														<div style="padding-left: 80px;" class="x-form-element">
															<input type="text" name="pjt_name" id="pjt_name" autocomplete="off" size="26" class=" x-form-text x-form-field" style="width: auto;">
														</div>
														<div class="x-form-clear-left">
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>
									<!-- 8_ROW End -->
									
									
									<!-- 5_ROW Start -->
									<div class="x-column-inner" style="width: 100%;">
										<div class=" x-panel x-column" style="width: 48%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label class="x-form-item-label" style="width: auto;" for="pjt_date_from" >프로젝트기간:</label>
														<div style="padding-left: 70px;" class="x-form-element">
															<table>
																<tr>
																	<td>
																		<input type="text" name="pjt_date_from" id="pjt_date_from" autocomplete="off" size="12" class=" x-form-text x-form-field" style="width: auto;" 
																		onFocus="restoreDateString(this, this.value)" onKeydown="_chkKeyPressNumPoint(this)" onblur="isValidDate(this, this.value)" />		
																	</td>
																	<td>
																		&nbsp;~&nbsp;
																	</td>
																	<td>
																		<input type="text" name="pjt_date_to" id="pjt_date_to" autocomplete="off" size="12" class=" x-form-text x-form-field" style="width: auto;" 
																		onFocus="restoreDateString(this, this.value)" onKeydown="_chkKeyPressNumPoint(this)" onblur="isValidDate(this, this.value)"/>		
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
										<div class=" x-panel x-column" style="width: 48%;" >
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label class="x-form-item-label" style="width: auto;" for="est_emp_num" ><font color="red">* </font>견적담당자:</label>
														<div style="padding-left: 80px;" class="x-form-element">
															<table style="width: 200px;" cellspacing="0" class="x-btn  x-btn-noicon">
																<tr>
																	<td>
																		<input type="hidden" name="est_emp_num" id="est_emp_num" autocomplete="off" size="6" class=" x-form-text x-form-field" style="width: auto;">
																		<input type="hidden" name="est_dept_code" id="est_dept_code" autocomplete="off" size="6" class=" x-form-text x-form-field" style="width: auto;">
																		<input type="text" name="est_dept_name" id="est_dept_name" autocomplete="off" size="13" class=" x-form-text x-form-field" style="width: auto;">
																		<input type="text" name="est_emp_name" id="est_emp_name" autocomplete="off" size="8" class=" x-form-text x-form-field" style="width: auto;">
																	</td>
																	<td>
																		<%-- Button Start--%>
																		<table cellspacing="0" class="x-btn  x-btn-noicon" style="width: 20px;" align="right">
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
																							<button type="button" id="estEmpNumBtn" class=" x-btn-text">검색</button>
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
									<!-- 5_ROW End -->

									<!-- 6_ROW Start -->
									<div class="x-column-inner" style="width: 100%;">
										<div class=" x-panel x-column" style="width: 48%;" >
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label class="x-form-item-label" style="width: auto;" for="custom_code" ><font color="red">* </font>거래처:</label>
														<div style="padding-left: 80px;" class="x-form-element">
															<table style="width: 195px;" cellspacing="0" class="x-btn  x-btn-noicon">
																<tr>
																	<td>
																		<input type="hidden" name="custom_code" id="custom_code" autocomplete="off" size="9" class=" x-form-text x-form-field" style="width: auto;">
																		<input type="text" name="custom_name" id="custom_name" autocomplete="off" size="26" class=" x-form-text x-form-field" style="width: auto;">
																	</td>
																	<td>
																		<%-- Button Start--%>
																		<table cellspacing="0" class="x-btn  x-btn-noicon" style="width: 20px;" align="right">
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
																							<button type="button" id="customCodeBtn" class=" x-btn-text">검색</button>
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
										<div class=" x-panel x-column" style="width: 48%;" >
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label class="x-form-item-label" style="width: auto;" for="costomer_name" >거래처담당자:</label>
														<div style="padding-left: 80px;" class="x-form-element">
															<table style="width: 200px;" cellspacing="0" class="x-btn  x-btn-noicon">
																<tr>
																	<td>
																		<input type="hidden" name="costomer_num" id="costomer_num" autocomplete="off" size="13" class=" x-form-text x-form-field" style="width: auto;">
																		<input type="text" name="customer_dept" id="customer_dept" autocomplete="off" size="13" class=" x-form-text x-form-field" style="width: auto;">
																		<input type="text" name="costomer_name" id="costomer_name" autocomplete="off" size="8" class=" x-form-text x-form-field" style="width: auto;">
																	</td>
																	<td>
																		<%-- Button Start--%>
																		<table cellspacing="0" class="x-btn  x-btn-noicon" style="width: 20px;" align="right">
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
																							<button type="button" id="costomerNumBtn" class=" x-btn-text">검색</button>
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
									<!-- 6_ROW End -->

									<!-- 7_ROW Start -->
									<div class="x-column-inner" style="width: 100%;">
										<div class=" x-panel x-column" style="width: 48%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label class="x-form-item-label" style="width: auto;" for="est_valid_type_code" ><font color="red">* </font>유효기간:</label>
														<div style="padding-left: 80px;" class="x-form-element">
															<select name="est_valid_type_code" id="est_valid_type_code" title="유효기간" style="width: 193px;" type="text" class=" x-form-select x-form-field" >
																<option value="">선택하세요</option>
																<c:forEach items="${EST_VALID_TYPE_CODE}" var="data" varStatus="status">
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
										<div class=" x-panel x-column" style="width: 48%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label class="x-form-item-label" style="width: auto;" for="delivery_exp_date" >납품예정일:</label>
														<div style="padding-left: 80px;" class="x-form-element">
															<input type="text" name="delivery_exp_date" id="delivery_exp_date" autocomplete="off" size="35" class=" x-form-text x-form-field" style="width: auto;" 
															onFocus="restoreDateString(this, this.value)" onKeydown="_chkKeyPressNumPoint(this)" onblur="isValidDate(this, this.value)"/>
														</div>
														<div class="x-form-clear-left">
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>
									<!-- 7_ROW End -->


									
									<!-- 9_ROW Start -->
									<div class="x-column-inner" style="width: 100%;">
										<div class=" x-panel x-column" style="width: 48%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label class="x-form-item-label" style="width: auto;" for="est_total_amt" >견적총액:</label>
														<div style="padding-left: 80px;" class="x-form-element">
															<input type="text" name="est_total_amt" id="est_total_amt" autocomplete="off" size="34" class=" x-form-text x-form-field" style="width: auto; text-align:right; IME-MODE:disabled;" onkeyPress="return _chkKeyPressNumOnly(this)" onBlur="_numFormat(this, Math.round(this.value));" onfocus="_removeComma(this, this.value)">
														</div>
														<div class="x-form-clear-left">
														</div>
													</div>
												</div>
											</div>
										</div>
										<div class=" x-panel x-column" style="width: 48%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label class="x-form-item-label" style="width: auto;" for="discnt_total_amt" >할인총액:</label>
														<div style="padding-left: 80px;" class="x-form-element">
															<input type="text" name="discnt_total_amt" id="discnt_total_amt" autocomplete="off" size="35" class=" x-form-text x-form-field" style="width: auto; text-align:right; IME-MODE:disabled;" onkeyPress="return _chkKeyPressNumOnly(this)" onBlur="_numFormat(this, Math.round(this.value));" onfocus="_removeComma(this, this.value)">
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
										<div class=" x-panel x-column" style="width: 48%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label class="x-form-item-label" style="width: auto;" for="est_aply_total_amt" >견적적용총액:</label>
														<div style="padding-left: 80px;" class="x-form-element">
															<input type="text" name="est_aply_total_amt" id="est_aply_total_amt" autocomplete="off" size="34" class=" x-form-text x-form-field" style="width: auto; text-align:right; IME-MODE:disabled;" onkeyPress="return _chkKeyPressNumOnly(this)" onBlur="_numFormat(this, Math.round(this.value));" onfocus="_removeComma(this, this.value)">
														</div>
														<div class="x-form-clear-left">
														</div>
													</div>
												</div>
											</div>
										</div>
										<div class=" x-panel x-column" style="width: 48%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label class="x-form-item-label" style="width: auto;" for="est_aply_total_tax" >견적적용총세액:</label>
														<div style="padding-left: 80px;" class="x-form-element">
															<input type="text" name="est_aply_total_tax" id="est_aply_total_tax" autocomplete="off" size="33" class=" x-form-text x-form-field" style="width: auto; text-align:right; IME-MODE:disabled;" onkeyPress="return _chkKeyPressNumOnly(this)" onBlur="_numFormat(this, Math.round(this.value));" onfocus="_removeComma(this, this.value)">
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
														<label class="x-form-item-label" style="width: auto;" for="ref_desc" >참고사항:</label>
														<div style="padding-left: 80px;" class="x-form-element">
															<textarea name="ref_desc" id="ref_desc" autocomplete="off" class=" x-form-text x-form-field" style="width:487; height:60px"></textarea>
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
										<div class=" x-panel x-column" style="width: 48%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label class="x-form-item-label" style="width: auto;" for="proc_status_code" >진행상태:</label>
														<div style="padding-left: 80px;" class="x-form-element">
															<select name="proc_status_code" id="proc_status_code" title="진행상태코드" style="width: 193px;" type="text" class=" x-form-select x-form-field" >
																<option value="">선택하세요</option>
																<c:forEach items="${FLOW_STATUS_CODE}" var="data" varStatus="status">
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
										<div class=" x-panel x-column" style="width: 48%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
<%--														<label class="x-form-item-label" style="width: auto;" for="est_decision_yn" >확정여부:</label>--%>
<%--														<div style="padding-left: 80px;" class="x-form-element">--%>
<%--															<select name="est_decision_yn" id="est_decision_yn" title="확정여부" style="width: 58%;" type="text" class=" x-form-select x-form-field" >--%>
<%--																<option value="">선택하세요</option>--%>
<%--																<c:forEach items="${YESNO_CODE}" var="data" varStatus="status">--%>
<%--																	<option value="${data.COM_CODE}"><c:out value="${data.COM_CODE_NAME}"/></option>--%>
<%--																</c:forEach>--%>
<%--															</select>--%>
<%--														</div>--%>
<%--														<div class="x-form-clear-left">--%>
<%--														</div>--%>
													</div>
												</div>
											</div>
										</div>
									</div>
									<!-- 12_ROW End -->
									
									<!-- 13_ROW Start -->
									<div class="x-column-inner" style="width: 100%;">
										<div class=" x-panel x-column" style="width: 48%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label class="x-form-item-label" style="width: auto;" for="final_mod_name" >최종변경자:</label>
														<div style="padding-left: 80px;" class="x-form-element">
															<input type="text" name="final_mod_name" id="final_mod_name" autocomplete="off" size="35" class=" x-form-text x-form-field" style="width: auto;">
															<input type="hidden" name="final_mod_id" id="final_mod_id" autocomplete="off" size="35" class=" x-form-text x-form-field" style="width: auto;">
														</div>
														<div class="x-form-clear-left">
														</div>
													</div>
												</div>
											</div>
										</div>
										<div class=" x-panel x-column" style="width: 48%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label class="x-form-item-label" style="width: auto;" for="final_mod_date" >최종변경일시:</label>
														<div style="padding-left: 80px;" class="x-form-element">
															<input type="text" name="final_mod_date" id="final_mod_date" autocomplete="off" size="35" class=" x-form-text x-form-field" style="width: auto;">
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
		</tr>
		<tr>
			<!----------------- 견적 품목정보 GRID START ----------------->
			<td width="100%" valign="top" colspan="2">
				<div id="edit_grid_1st" style="margin-top: 0em;"></div>
			</td>
			<!----------------- 견적 품목정보 GRID END ----------------->
		</tr>
		<tr>
			<!----------------- 납품처 시스템사양 정보 GRID START ----------------->
			<td width="100%" valign="top" colspan="2">
				<div id="edit_grid_2nd" style="margin-top: 0em;"></div>
			</td>
			<!----------------- 납품처 시스템사양 정보 GRID END ----------------->
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
											<button type="button" id="printBtn" name="printBtn" class=" x-btn-text">출력</button>
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