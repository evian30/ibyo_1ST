<%--
  Class Name  : receiptManage.jsp
  Description : 수금관리조회
  Modification Information
 
      수정일                   수정자                 수정내용
  -------      --------    ---------------------------
  2011. 4. 29  고기범                 최초 생성   
  
  author   : 고기범
  since    : 2011. 4. 29.
  version  : 1.0
   
  Copyright (C) 2011 by SG All right reserved.
--%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/web/jsp/common/inc/commonInc.jsp" %>
<script type="text/javascript" src="/resource/common/js/sgis-comm-inc.js" ></script> 
<script type="text/javascript" src="/resource/common/js/common/common-msg-box.js" ></script> 
<script type="text/javascript" src="/resource/common/js/ajax.js" ></script>

<script type="text/javascript" src="/resource/common/js/grid/grid_edit_1st.js"></script> 
<script type="text/javascript" src="/resource/common/js/grid/grid_edit_2nd.js"></script>
<script type="text/javascript">
/***************************************************************************
 * 설  명 : 편집그리드 설정 (프로젝트별 수금정보)
***************************************************************************/
var	gridHeigth_edit_1st	= 210;
var	gridWidth_edit_1st  = 1000;
var	gridTitle_edit_1st  = "프로젝트별 수금정보"	; 
var	render_edit_1st		= "edit_grid_1st";
var keyNm_edit_1st		= "PJT_ID";
var pageSize_edit_1st	= 6;
var limit_edit_1st		= pageSize_edit_1st;
var start_edit_1st		= 0;
var proxyUrl_edit_1st	= "/sal/receipt/receiptProjectList.sg";
var gridRowDeleteYn	    = "";
var tbarHidden_edit_1st = "Y";

// 행추가
function addNew_edit_1st(){
		
}

// 페이징
function fnPagingValue_edit_1st(){	
	try{
		GridClass_edit_1st.store.setBaseParam('start'					,start_edit_1st);
	    GridClass_edit_1st.store.setBaseParam('limit'					,limit_edit_1st);
	    GridClass_edit_1st.store.setBaseParam('src_receipt_date_start'	,Ext.get('src_receipt_date_start').getValue());
	    GridClass_edit_1st.store.setBaseParam('src_receipt_date_end'	,Ext.get('src_receipt_date_end').getValue());
	    GridClass_edit_1st.store.setBaseParam('src_custom_code'			,Ext.get('src_custom_code').getValue());
	    GridClass_edit_1st.store.setBaseParam('src_custom_name'			,Ext.get('src_custom_name').getValue());
	    GridClass_edit_1st.store.setBaseParam('src_pjt_id'				,Ext.get('src_pjt_id').getValue());
	    GridClass_edit_1st.store.setBaseParam('src_pjt_name'			,Ext.get('src_pjt_name').getValue());
	}catch(e){

	}
}
/*
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
 
*/
// 그리드 필드
var	userColumns_edit_1st	= [ {header: '상태',				width: 60,  sortable: true ,dataIndex: 'FLAG'               ,hidden : true}
				  			  ,	{header: "프로젝트ID",		width: 10,	sortable: true,	dataIndex: "PJT_ID"				,hidden : true}
				  			  ,	{header: "프로젝트",		    width: 10,	sortable: true,	dataIndex: "PJT_NAME"			}
		  					  ,	{header: "매출ID",			width: 10,	sortable: true,	dataIndex: "SAL_ID"				,hidden : true}
		  					  ,	{header: "매출",				width: 10,	sortable: true,	dataIndex: "SAL_NAME"			}
		  					  ,	{header: "세금계산서ID",		width: 12,	sortable: true,	dataIndex: "TAX_ID"				}
				  			  , {header: "거래처코드",		width: 10,	sortable: true,	dataIndex: "CUSTOM_CODE"		,hidden : true}
							  , {header: "거래처",			width: 10,	sortable: true,	dataIndex: "CUSTOM_NAME"		}
				  			  , {header: "사업자등록번호",	width: 10,	sortable: true,	dataIndex: "BIZ_NUM"			}
							  , {header: "매출총금액",  		width: 10,	sortable: true,	dataIndex: "SUP_PRICE"			, renderer: "korMoney" , align : 'right'}
							  , {header: "매출총세액",		width: 10,	sortable: true,	dataIndex: "TAX_AMT"			, renderer: "korMoney" , align : 'right'}
							  , {header: "매출합계",			width: 10,	sortable: true,	dataIndex: "SUM_AMT"			, renderer: "korMoney" , align : 'right'}
							  , {header: "수금금액",			width: 10,	sortable: true,	dataIndex: "RECEIPT_AMT"		, renderer: korMoneyChangeBLUE , align : 'right'}
							  , {header: "미수금액",			width: 10,	sortable: true,	dataIndex: "AMOUNT"				, renderer: korMoneyChangeRED , align : 'right'}
							  ];

// 맵핑 필드
var	mappingColumns_edit_1st	= [ {name: "FLAG", 			    type:"string", mapping: "FLAG"}
							  , {name: "PJT_ID", 			type:"string", mapping: "PJT_ID"}
							  , {name: "PJT_NAME", 			type:"string", mapping: "PJT_NAME"}
							  , {name: "SAL_ID", 			type:"string", mapping: "SAL_ID"}
						      , {name: "SAL_NAME", 			type:"string", mapping: "SAL_NAME"}
							  , {name: "TAX_ID", 			type:"string", mapping: "TAX_ID"}
						      , {name: "CUSTOM_CODE", 		type:"string", mapping: "CUSTOM_CODE"}
						      , {name: "CUSTOM_NAME", 		type:"string", mapping: "CUSTOM_NAME"}
        					  , {name: "BIZ_NUM", 			type:"string", mapping: "BIZ_NUM"}
						      , {name: "SUP_PRICE", 		type:"string", mapping: "SUP_PRICE"}
						      , {name: "TAX_AMT", 			type:"string", mapping: "TAX_AMT"}
						      , {name: "SUM_AMT", 			type:"string", mapping: "SUM_AMT"}
						      , {name: "RECEIPT_AMT", 		type:"string", mapping: "RECEIPT_AMT"}	
						      , {name: "AMOUNT", 			type:"string", mapping: "AMOUNT"}	
	    				 	  ]; 

/***************************************************************************
 * 설  명 : 편집그리드 설정 (수주처 시스템 사양정보)
***************************************************************************/
var	gridHeigth_edit_2nd	= 200;
var	gridWidth_edit_2nd  = 1000	;
var	gridTitle_edit_2nd  = "수금상세정보"	; 
var	render_edit_2nd		= "edit_grid_2nd";
var keyNm_edit_2nd		= "ORD_INFO_SEQ";
var pageSize_edit_2nd	= 4;
var limit_edit_2nd		= pageSize_edit_2nd;
var start_edit_2nd		= 0;
var proxyUrl_edit_2nd	= "/sal/receipt/receiptManageList.sg";
var grid2ndRowDeleteYn  = "";
var tbarHidden_edit_2nd = "N";

// 행추가
function addNew_edit_2nd(){
	
	var selectedRecord = GridClass_edit_1st.grid.selModel.getSelected(); 
	
	if( undefined == selectedRecord){
		Ext.Msg.alert('확인', '프로젝트별 수금정보를 선택 해 주세요'); 
		return false;
	}
	
	var Plant = GridClass_edit_2nd.grid.getStore().recordType; 
    var p = new Plant({ 
	        		    FLAG			: 'I' 
	        		  , PJT_ID			: selectedRecord.data.PJT_ID
	        		  , PJT_NAME		: selectedRecord.data.PJT_NAME
	        		  , SAL_ID			: selectedRecord.data.SAL_ID
	        		  , SAL_NAME		: selectedRecord.data.SAL_NAME
	        		  , TAX_ID			: selectedRecord.data.TAX_ID
	        		  , CUSTOM_CODE		: selectedRecord.data.CUSTOM_CODE
	        		  , RECEIPT_AMT		: 0
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
	}catch(e){

	}
}

// 수금분류코드 combo box 생성 start 
var PAY_CONDITION_COMBO = new Ext.form.ComboBox({    
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
     <c:forEach items="${PAY_CONDITION}" var="data" varStatus="status">
      ['${data.COM_CODE}', '${data.COM_CODE_NAME}']
      <c:if test="${not status.last}">,</c:if>
     </c:forEach>
      ]
   })
});

//combo box render
Ext.util.Format.comboRenderer = function(PAY_CONDITION_COMBO){    
 return function(value){        
 var record = PAY_CONDITION_COMBO.findRecord(PAY_CONDITION_COMBO.valueField, value);        
 return record ? record.get(PAY_CONDITION_COMBO.displayField) : PAY_CONDITION_COMBO.valueNotFoundText;    
}}

// 그리드 필드
var	userColumns_edit_2nd	= [ {header: '상태'        		,width: 60,  sortable: true ,dataIndex: 'FLAG'              ,hidden : true} 
							  , {header: '수금ID'			,width: 80	,sortable: true ,dataIndex: 'RECEIPT_ID'		,hidden : true}
							  , {header: '수금일자'			,width: 50	,sortable: true ,dataIndex: 'RECEIPT_DATE'     	,editor: new Ext.form.TextField({ allowBlank : true}) /*, renderer: fnGridDateCheck*/}
							  , {header: '프로젝트ID'		,width: 60	,sortable: true ,dataIndex: 'PJT_ID'           	,hidden : true}
							  , {header: '프로젝트'			,width: 110	,sortable: true ,dataIndex: 'PJT_NAME'          }
							  , {header: '매출ID'			,width: 60	,sortable: true ,dataIndex: 'SAL_ID'           	,hidden : true}
							  , {header: '매출'				,width: 110	,sortable: true ,dataIndex: 'SAL_NAME'          }
							  , {header: '수금구분코드'		,width: 50	,sortable: true ,dataIndex: 'RECEIPT_TYPE_CODE'	,editor: PAY_CONDITION_COMBO  ,renderer: Ext.util.Format.comboRenderer(PAY_CONDITION_COMBO)}
							  
							  , {header: '수금담당부서코드'	,width: 60	,sortable: true ,dataIndex: 'RECEIPT_DEPT_CODE'	,hidden : true}							  
							  , {header: '수금담당부서'		,width: 60	,sortable: true ,dataIndex: 'RECEIPT_DEPT_NAME'	}
							  , {header: '수금담당자번호'	,width: 60	,sortable: true ,dataIndex: 'RECEIPT_EMP_NUM'  	,hidden : true}
							  , {header: '수금담당자'		,width: 60	,sortable: true ,dataIndex: 'RECEIPT_EMP_NAME' 	}
							  , {header: '거래처코드'		,width: 60	,sortable: true ,dataIndex: 'CUSTOM_CODE'      	,hidden : true}
							  , {header: '세금계산서ID'		,width: 60	,sortable: true ,dataIndex: 'TAX_ID'           	,hidden : true}
							  
							  , {header: '수금금액'			,width: 60	,sortable: true ,dataIndex: 'RECEIPT_AMT'      	,editor: new Ext.form.NumberField({ allowBlank : true }) , renderer: "korMoney" , align : 'right'}	
							  , {header: '전표일자'			,width: 50	,sortable: true ,dataIndex: 'SLIP_DATE'        	,editor: new Ext.form.TextField({ allowBlank : true })/* , renderer: fnGridDateCheck*/}
							  , {header: '전표번호'			,width: 60	,sortable: true ,dataIndex: 'SLIP_NUM'         	,editor: new Ext.form.TextField({ allowBlank : true })}
							  
							  , {header: '비고'				,width: 60	,sortable: true ,dataIndex: 'NOTE'             	,hidden : true}	
							  , {header: '최종변경자ID'		,width: 60	,sortable: true ,dataIndex: 'FINAL_MOD_ID'     	,hidden : true}
							  , {header: '최종변경일시'		,width: 60	,sortable: true ,dataIndex: 'FINAL_MOD_DATE'   	,hidden : true}
							  ];

// 맵핑 필드
var	mappingColumns_edit_2nd	= [ {name : "FLAG"				 ,type : "string", mapping : "FLAG"}
							  , {name : "RECEIPT_ID"		 ,type : "string" ,mapping : "RECEIPT_ID"}		  // 수금ID              
							  , {name : "RECEIPT_DATE"       ,type : "string" ,mapping : "RECEIPT_DATE"}      // 수금일자            
							  , {name : "PJT_ID"             ,type : "string" ,mapping : "PJT_ID"}            // 프로젝트ID
							  , {name : "PJT_NAME"           ,type : "string" ,mapping : "PJT_NAME"}          // 프로젝트   
							  , {name : "SAL_ID"             ,type : "string" ,mapping : "SAL_ID"}            // 매출ID
							  , {name : "SAL_NAME"           ,type : "string" ,mapping : "SAL_NAME"}          // 매출
							  , {name : "RECEIPT_DEPT_CODE"  ,type : "string" ,mapping : "RECEIPT_DEPT_CODE"} // 수금담당부서코드    
							  , {name : "RECEIPT_DEPT_NAME"  ,type : "string" ,mapping : "RECEIPT_DEPT_NAME"} // 수금담당부서
							  , {name : "RECEIPT_EMP_NUM"    ,type : "string" ,mapping : "RECEIPT_EMP_NUM"}   // 수금담당자번호      
							  , {name : "RECEIPT_EMP_NAME"   ,type : "string" ,mapping : "RECEIPT_EMP_NAME"}  // 수금담당자
							  , {name : "CUSTOM_CODE"        ,type : "string" ,mapping : "CUSTOM_CODE"}       // 거래처코드          
							  , {name : "TAX_ID"             ,type : "string" ,mapping : "TAX_ID"}            // 세금계산서ID        
							  , {name : "RECEIPT_TYPE_CODE"  ,type : "string" ,mapping : "RECEIPT_TYPE_CODE"} // 수금구분코드        
							  , {name : "RECEIPT_AMT"        ,type : "string" ,mapping : "RECEIPT_AMT"}       // 수금금액            
							  , {name : "SLIP_DATE"          ,type : "string" ,mapping : "SLIP_DATE"}         // 전표일자            
							  , {name : "SLIP_NUM"           ,type : "string" ,mapping : "SLIP_NUM"}          // 전표번호            
							  , {name : "NOTE"               ,type : "string" ,mapping : "NOTE"}              // 비고                
							  , {name : "FINAL_MOD_ID"       ,type : "string" ,mapping : "FINAL_MOD_ID"}      // 최종변경자ID        
							  , {name : "FINAL_MOD_DATE"     ,type : "string" ,mapping : "FINAL_MOD_DATE"}    // 최종변경일시        
	    				 	  ]; 

/***************************************************************************
 * 설  명 : 필드 초기화
 **************************************************************************/
function fnInitValue(){

	try{
		GridClass_edit_1st.store.commitChanges();	// 변경된 record를 commit
		GridClass_edit_1st.store.removeAll();		// store자료를 삭제
		// 수금상세정보 초기화 
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
		url: "/sal/receipt/receiptProjectList.sg"
		,method : 'POST'   
		,success: function(response){						// 조회결과 성공시
					// 조회된 결과값, store명
					handleSuccess(response,GridClass_edit_1st);
					//var json = Ext.util.JSON.decode(response.responseText);
					//this.GridClass_1st.store.loadData(json)
					//alert(json.success);
		          }   							
		,failure: handleFailure   	   						// 조회결과 실패시  
		,params : {					   						// 조회조건을 DB로 전송하기위해서 조건값 설정
					limit              		: limit_edit_1st
				  , start              		: start_edit_1st
				  , src_receipt_date_start	: Ext.get('src_receipt_date_start').getValue()
	        	  , src_receipt_date_end	: Ext.get('src_receipt_date_end').getValue()
	    		  , src_custom_code			: Ext.get('src_custom_code').getValue()
	    		  , src_custom_name			: Ext.get('src_custom_name').getValue()
	    		  , src_pjt_id				: Ext.get('src_pjt_id').getValue()
	    		  , src_pjt_name			: Ext.get('src_pjt_name').getValue()
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
	
	var toDay = getTimeStamp();	
	toDay = toDay.replaceAll('-','');
	toDay = addDate(toDay, 'M', -3);
	toDay = toDay.substring(0,4)+"-"+toDay.substring(4,6)+"-"+toDay.substring(6,8);
	var fromDay = toDay;
	toDay = getTimeStamp().trim();
	
    // 검색버튼 클릭
	Ext.get('searchBtn').on('click', function(e){
			
		var startDate = Ext.get('src_receipt_date_start').getValue()		// 검색시작일
		var endDate = Ext.get('src_receipt_date_end').getValue()		  	// 검색종료일
		// fnCalDate('검색시작일','검색종료일','D_날짜 M_월');
		var cnt = fnCalDate(startDate,endDate,'D'); 
		
		if(fnCalDate(startDate,endDate,'D') < 0){
			Ext.Msg.alert('확인', '검색시작일이 검색종료일보다 이전입니다.'); 
		}else{
			fnSearch()	
		}

	});
    
   	//조건해제 버튼 -> 검색조건 초기화
   	Ext.get('searchClearBtn').on('click', function(e){
        sForm.reset();	
    });
   /*	
   	// 수금일자_검색시작일자
	var startDate = new Ext.form.DateField({
    	applyTo: 'src_receipt_date_start',
		allowBlank: false,
		format:'Y-m-d',
		editable : false
	});
   	
	// 수금일자_검색종료일자
	var endDate = new Ext.form.DateField({
    	applyTo: 'src_receipt_date_end',
		allowBlank: false,
		format:'Y-m-d',
		editable : false
	});
	*/
	// 저장버튼 클릭
	Ext.get('saveBtn').on('click', function(e){
		if(fnValidation()){
			Ext.MessageBox.confirm('Confirm', '저장하시겠습니까?', showResult);
		};
    });
	   
/*	
	// 프로젝트 검색팝업
   	Ext.get('src_pjt_id_btn').on('click', function(e){
		param = "?fieldName=src_pjt_id";
		fnPjtPop(param);
	});
   	
   	// 거래처검색 버튼
	Ext.get('src_custom_btn').on('click', function(e){
		var param = '?fieldCode=src_ord_custom_code&fieldName=src_ord_custom_name';
		param = param + '&form=searchForm';
		fnCustomPop(param)
	});
	
	fnInitValue();
	*/
}); // end Ext.onReady

// 등록버튼 클릭시 '예','아니오' 
function showResult(btn){
   	if(btn == 'yes'){
   		fnSave();
   	}    	
};

function fnValidation(){
	
	var selectRecord = GridClass_edit_1st.grid.selModel.getSelected(); 
	var taxCnt = GridClass_edit_2nd.store.getCount();  // Grid의 총갯수 
	var totAmt = 0;
	var amt = selectRecord.data.SUM_AMT;
	
	for (var i = 0; i < taxCnt; i++) {
    	
		var record = GridClass_edit_2nd.store.getAt(i);
		var receipt_date = record.data.RECEIPT_DATE; 
      	totAmt = totAmt + parseInt(record.data.RECEIPT_AMT);
      
      	if(receipt_date == undefined || receipt_date == ''){
      		Ext.Msg.alert('확인', '['+(i+1)+']번째행의 수금일자를 입력해주세요.'); 
			return false;	
      	}
    }
	
	if(amt < totAmt ){
		Ext.Msg.alert('확인', '매출합계 금액보다 수금금액의 총급액이 많습니다.'); 
		return false;		
	
	}
	
	return true;
	
}
/***************************************************************************
 * 설  명 : 저장버튼 클릭
 ***************************************************************************/
function fnSave(){  	
	
	// 수주진행상태 Grid의 record
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
		url: "/sal/receipt/saveReceiptManage.sg"   
		,success: function(response){						// 조회결과 성공시
					// 조회된 결과값, store명
					handleSuccess(response,GridClass_edit_1st,'save');
		          } 
		,failure: handleFailure   	    // 조회결과 실패시  
		,form   : document.detailForm	// 상세 FORM	
		,params : {					    // 조회조건을 DB로 전송하기위해서 조건값 설정
				  // 페이지정보
			  	    limit              		: limit_edit_1st
				  , start              		: start_edit_1st
				  , edit2ndData        		: edit2ndJson		// 수금상세정보
				  // 검색정보
				  , src_receipt_date_start	: Ext.get('src_receipt_date_start').getValue()
	        	  , src_receipt_date_end	: Ext.get('src_receipt_date_end').getValue()
	    		  , src_custom_code			: Ext.get('src_custom_code').getValue()
	    		  , src_custom_name			: Ext.get('src_custom_name').getValue()
	    		  , src_pjt_id				: Ext.get('src_pjt_id').getValue()
	    		  , src_pjt_name			: Ext.get('src_pjt_name').getValue()
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
    	//Ext.get('src_pjt_id').set({value:fnFixNull(record.PJT_ID)} , false);
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

// 담당자 검색팝업 ****************************************
function fnEmployeePop(param){
	var sURL      = "/com/employee/employeePop.sg"+param;
	var dlgWidth  = 399;
	var dlgHeight = 396;
	var winName   = "담당자";
	fnOpenPop(sURL, dlgWidth, dlgHeight, winName);
}

// 담당자 검색 결과 return Value
function fnEmployeePopValue(records,fileName){
		
	// 전송받은 값이 한건일 경우
    var record = records[0].data;				
	// 선택된 행
	var selectedRecord = GridClass_edit_2nd.store.getAt(fileName); 
	
    selectedRecord.set('RECEIPT_EMP_NUM',fnFixNull(record.EMP_NUM));
    selectedRecord.set('RECEIPT_EMP_NAME',fnFixNull(record.KOR_NAME));
    selectedRecord.set('RECEIPT_DEPT_CODE',fnFixNull(record.DEPT_CODE));
    selectedRecord.set('RECEIPT_DEPT_NAME',fnFixNull(record.DEPT_NAME));
	
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
// 프로젝트별 수금관리
function  fnEdit1stCellClickEvent(grid, rowIndex, columnIndex, e){
	
	// 수금상세정보 초기화 
	GridClass_edit_2nd.store.commitChanges();
	GridClass_edit_2nd.store.removeAll();
		
	// 선택된 행의 값을 받아서
	var record = GridClass_edit_1st.grid.store.getAt(rowIndex); 
	
    // 상세조회
	Ext.Ajax.request({   
		url: "/sal/receipt/receiptManageList.sg"
		,method : 'POST'   
		,success: function(response){						// 조회결과 성공시
					// 조회된 결과값, store명
					handleSuccess(response,GridClass_edit_2nd);
		          }   							
		,failure: handleFailure   	   						// 조회결과 실패시  
		,params : {					   						// 조회조건을 DB로 전송하기위해서 조건값 설정
					limit              		: limit_edit_2nd
				  , start              		: start_edit_2nd
				  // 검색조건
				  , src_receipt_date_start	: Ext.get('src_receipt_date_start').getValue()
	        	  , src_receipt_date_end	: Ext.get('src_receipt_date_end').getValue()
	    		  , src_custom_code			: Ext.get('src_custom_code').getValue()
	    		  , src_custom_name			: Ext.get('src_custom_name').getValue()
	    		  , src_pjt_id				: Ext.get('src_pjt_id').getValue()
	    		  , src_pjt_name			: Ext.get('src_pjt_name').getValue()
				  // 검색
				  , pjt_id					: record.data.PJT_ID
				  , sal_id				 	: record.data.SAL_ID
				  , tax_id					: record.data.TAX_ID
				  }				
	});  
	
}
// 수금상세정보
function  fnEdit2ndCellClickEvent(grid, rowIndex, columnIndex, e){
	
	var param = "?requestFieldName="+rowIndex;
	
	if(columnIndex == 9 || columnIndex == 11){
		fnEmployeePop(param);
	}
	
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
	//if( fieldName == 'RECEIPT_DATE' || fieldName == 'SLIP_DATE'){
		
	//}
}

// 수금상세정보의 cell을 수정하였을 경우
function  fnEdit2ndAfterCellEdit(obj){
	      
	var editedRow = obj.row;
	var editedColumn = obj.column;
	var editedValue = obj.value;
	var fieldName = obj.field;
	var val = '';
	
	// alert('change');
	
	// 해당 컬럼의 값이 변경 되었을 경우
	if( fieldName == 'RECEIPT_DATE' || fieldName == 'SLIP_DATE'){

		var record = GridClass_edit_2nd.store.getAt(editedRow);
		
		val = fnGridDateCheck(editedValue);
		record.set(fieldName, val);						
		
	}
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
									<span id="ext-gen8" class="x-panel-header-text">수금관리  검색</span>
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
								<table width="100%">
						    		<%-- 1 Row Start --%>
						    		<tr>
						    			<td width="18%">
											<div tabindex="-1" class="x-form-item " >
												<label class="x-form-item-label" style="width: auto;" for="src_pjt_id" >프로젝트ID :</label>
												<div style="padding-left: 61px;" class="x-form-element">
													<input type="text" name="src_pjt_id" id="src_pjt_id" autocomplete="off" size="13" class=" x-form-text x-form-field" style="width: auto;">		
												</div>
											</div>
										</td>
										<td width="18%">
											<div tabindex="-1" class="x-form-item " >
												<label class="x-form-item-label" style="width: auto;" for="src_pjt_name" >프로젝트명 :</label>
												<div style="padding-left: 61px;" class="x-form-element">
													<input type="text" name="src_pjt_name" id="src_pjt_name" autocomplete="off" size="13" class=" x-form-text x-form-field" style="width: auto;">		
												</div>
											</div>
										</td>
										<td width="18%">
											<div tabindex="-1" class="x-form-item " >
												<label class="x-form-item-label" style="width: auto;" for="src_custom_code" >거래처코드:</label>
												<div style="padding-left: 61px;" class="x-form-element">
													<input type="text" name="src_custom_code" id="src_custom_code" autocomplete="off" size="13" class=" x-form-text x-form-field" style="width: auto;">		
												</div>
											</div>
										</td>
										<td width="18%">
											<div tabindex="-1" class="x-form-item " >
												<label class="x-form-item-label" style="width: auto;" for="src_custom_name" >거래처명 :</label>
												<div style="padding-left: 61px;" class="x-form-element">
													<input type="text" name="src_custom_name" id="src_custom_name" autocomplete="off" size="13" class=" x-form-text x-form-field" style="width: auto;">		
												</div>
											</div>
										</td>
										<td width="0%">
<%--											<div tabindex="-1" class="x-form-item " >--%>
<%--												<label class="x-form-item-label" style="width: auto;" for="src_receipt_date_start" >수금일자 :</label>--%>
<%--												<div style="padding-left: 30px;" class="x-form-element">--%>
<%--													<table>--%>
<%--														<tr>--%>
<%--															<td>--%>
																<input type="hidden" name="src_receipt_date_start" id="src_receipt_date_start" autocomplete="off" size="10" style="width: auto;">		
<%--															</td>--%>
<%--															<td>--%>
<%--																~--%>
<%--															</td>--%>
<%--															<td>--%>
																<input type="hidden" name="src_receipt_date_end" id="src_receipt_date_end" autocomplete="off" size="10" style="width: auto;">		
<%--															</td>--%>
<%--														</tr>--%>
<%--													</table>--%>
<%--												</div>--%>
<%--											</div>--%>
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
		<tr>
			<td colspan="2" align="center" height="35">
				<table>
					<tr>
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
						<%-- 수정 버튼 End --%>
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
</body>

<%@ include file="/WEB-INF/web/jsp/sgis-bottom-inc.jsp" %>