<%--
  Class Name  : customList.jsp
  Description : 거래처 관리
  Modification Information
 
      수정일                   수정자                 수정내용
  -------      --------    ---------------------------
  2011. 3. 15   고기범            최초 생성   
  
  author   : 고기범
  since    : 2011. 3. 15.
  version  : 1.0
   
  Copyright (C) 2011 by SG All right reserved.
--%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/web/jsp/common/inc/commonInc.jsp" %>
<script type="text/javascript" src="/resource/common/js/sgis-comm-inc.js" ></script> 
<script type="text/javascript" src="/resource/common/js/common/common-msg-box.js" ></script> 
<script type="text/javascript" src="/resource/common/js/ajax.js" ></script>

<script type="text/javascript" src="/resource/common/js/grid/grid_1st.js"></script>
<script type="text/javascript">
/***************************************************************************
 * 초기값 설정
 ***************************************************************************/
var	gridHeigth_1st 	 	= 369; 						// 그리드 전체 높이
var	gridWidth_1st		= 497;						// 그리드 전체 폭
var gridTitle_1st 		= "거래처 목록";				// 그리드 제목
var	render_1st			= "custom-grid";	        // 렌더(화면에 그려질) 할 id 
var	pageSize_1st		= 13;	  					// 그리드 페이지 사이즈	
var	proxyUrl_1st		= "/com/custom/result.sg";  // 결과 값 페이지
var limit_1st			= pageSize_1st;
var start_1st			= 0;

// 거래처등급코드 combo box 생성 start 
var CUSTOM_LEVEL_CODE_COMBO = new Ext.form.ComboBox({    
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
     <c:forEach items="${CUSTOM_LEVEL_CODE}" var="data" varStatus="status">
      ['${data.COM_CODE}', '${data.COM_CODE_NAME}']
      <c:if test="${not status.last}">,</c:if>
     </c:forEach>
      ]
   })
});

//combo box render
Ext.util.Format.comboRenderer = function(CUSTOM_LEVEL_CODE_COMBO){    
 return function(value){        
 var record = CUSTOM_LEVEL_CODE_COMBO.findRecord(CUSTOM_LEVEL_CODE_COMBO.valueField, value);        
 return record ? record.get(CUSTOM_LEVEL_CODE_COMBO.displayField) : CUSTOM_LEVEL_CODE_COMBO.valueNotFoundText;    
}}

/***************************************************************************
 * Grid의 컬럼 설정
 ***************************************************************************/
var userColumns_1st =  [ {header: '상태'       	   			,width: 0   ,sortable: true ,dataIndex: 'FLAG'			   ,hidden : true}       
				   	   , {header: '거래처코드' 				,width: 0	,sortable: true ,dataIndex: 'CUSTOM_CODE'	   ,hidden : true}
				   	   , {header: '거래처구분' 				,width: 0   ,sortable: true ,dataIndex: 'CUSTOM_TYPE'	   ,hidden : true}
				   	   , {header: '구분' 					,width: 50  ,sortable: true ,dataIndex: 'CUSTOM_TYPE_NAME' }
				   	   , {header: '거래처명' 				,width: 100 ,sortable: true ,dataIndex: 'CUSTOM_NAME'	   }
				   	   , {header: '개인/사업자구분' 			,width: 0   ,sortable: true ,dataIndex: 'PER_BIZ_TYPE'	   ,hidden : true}                  
				   	   , {header: '사업자번호' 				,width: 100 ,sortable: true ,dataIndex: 'BIZ_NUM'		   }
				   	   , {header: '대표자명' 				,width: 0   ,sortable: true ,dataIndex: 'CEO_NAME'		   ,hidden : true}
				   	   , {header: '업태' 					,width: 0   ,sortable: true ,dataIndex: 'BIZ_TYPE'		   ,hidden : true}
				   	   , {header: '업종' 					,width: 0   ,sortable: true ,dataIndex: 'BIZ_KIND'		   ,hidden : true}
				   	   , {header: '우편번호' 				,width: 0   ,sortable: true ,dataIndex: 'ZIPCODE'		   ,hidden : true}  
				   	   , {header: '주소' 					,width: 150 ,sortable: true ,dataIndex: 'ADDR'			   }  
				   	   , {header: '주소상세' 				,width: 0   ,sortable: true ,dataIndex: 'ADDR_DETAIL' 	   ,hidden : true}
				   	   , {header: '전화번호' 				,width: 100 ,sortable: true ,dataIndex: 'TELEPHONE' 	   }
				   	   , {header: '팩스' 					,width: 0   ,sortable: true ,dataIndex: 'FAX' 			   ,hidden : true}
				   	   , {header: 'E-MAIL' 					,width: 0   ,sortable: true ,dataIndex: 'EMAIL' 		   ,hidden : true}
				   	   , {header: '전자세금계산서발행여부'	,width: 0   ,sortable: true ,dataIndex: 'ETAX_ISSUE_YN'    ,hidden : true}
				   	   , {header: '등급' 					,width: 50  ,sortable: true ,dataIndex: 'CUSTOM_LEVEL' 	   ,renderer: Ext.util.Format.comboRenderer(CUSTOM_LEVEL_CODE_COMBO)}
				   	   , {header: '비고'						,width: 0   ,sortable: true ,dataIndex: 'NOTE' 			   ,hidden : true}
				   	   , {header: '사용여부' 				,width: 0   ,sortable: true ,dataIndex: 'USE_YN' 		   ,hidden : true}
				   	   , {header: '최종변경자ID' 			,width: 0   ,sortable: true ,dataIndex: 'FINAL_MOD_ID' 	   ,hidden : true}
				   	   , {header: '최종변경일시'		 		,width: 0   ,sortable: true ,dataIndex: 'FINAL_MOD_DATE'   ,hidden : true}
				   	   , {header: '최종변경자' 				,width: 0   ,sortable: true ,dataIndex: 'FINAL_MOD_NAME'   ,hidden : true}
				   	   ];	 

/***************************************************************************
 * 그리드 결과매핑 
 ***************************************************************************/
var mappingColumns_1st = [ {name: 'FLAG' 		   		,allowBlank: false}	 // 상태
					     , {name: 'CUSTOM_CODE'    		,allowBlank: false}  // 거래처코드            
					 	 , {name: 'CUSTOM_TYPE'    		,allowBlank: false}  // 거래처구분   
					 	 , {name: 'CUSTOM_TYPE_NAME'    ,allowBlank: false}  // 거래처구분명 
					 	 , {name: 'CUSTOM_NAME'    		,allowBlank: false}  // 거래처명              
					 	 , {name: 'PER_BIZ_TYPE'   		,allowBlank: false}  // 개인/사업자구분       
					 	 , {name: 'BIZ_NUM' 	   		,allowBlank: false}  // 사업자번호            
					 	 , {name: 'CEO_NAME' 	   		,allowBlank: false}  // 대표자명              
					 	 , {name: 'BIZ_TYPE' 	   		,allowBlank: false}  // 업태                  
					 	 , {name: 'BIZ_KIND' 	   		,allowBlank: false}  // 업종                  
					 	 , {name: 'ZIPCODE' 	   		,allowBlank: false}  // 우편번호              
					 	 , {name: 'ADDR' 		   		,allowBlank: false}  // 주소                  
					 	 , {name: 'ADDR_DETAIL'    		,allowBlank: false}  // 주소상세              
						 , {name: 'TELEPHONE' 	   		,allowBlank: false}  // 전화번호                      
					 	 , {name: 'FAX' 		   		,allowBlank: false}  // 팩스                          
					 	 , {name: 'EMAIL' 		   		,allowBlank: false}  // E-MAIL                          
					 	 , {name: 'ETAX_ISSUE_YN'  		,allowBlank: false}  // 전자세금계산서발행여부        	
					 	 , {name: 'CUSTOM_LEVEL'   		,allowBlank: false}  // 거래처등급코드                  
					 	 , {name: 'NOTE' 		   		,allowBlank: false}  // 비고                            
					 	 , {name: 'USE_YN' 		   		,allowBlank: false}  // 사용여부                        
					 	 , {name: 'FINAL_MOD_ID'   		,allowBlank: false}  // 최종변경자ID                    
					 	 , {name: 'FINAL_MOD_DATE' 		,allowBlank: false}  // 최종변경일시
					 	 , {name: 'FINAL_MOD_NAME'  	,allowBlank: false}  // 최종변경자  
    				 	 ];
 
/***************************************************************************
 * 그리드 클릭시 Event
 ***************************************************************************/
function fnGridOnClick_1st(store, rowIndex){

	/***** 선택된 레코드에서 데이타 가져오기 *****/
	var flag		 = fnFixNull(store.getAt(rowIndex).data.FLAG		   );  	// 상태        
	var customCode   = fnFixNull(store.getAt(rowIndex).data.CUSTOM_CODE    );	// 거래처코드            
	var customType   = fnFixNull(store.getAt(rowIndex).data.CUSTOM_TYPE    );	// 거래처구분              
	var customName   = fnFixNull(store.getAt(rowIndex).data.CUSTOM_NAME    );	// 거래처명              
	var perBizType   = fnFixNull(store.getAt(rowIndex).data.PER_BIZ_TYPE   );	// 개인/사업자구분       
	var bizNum       = fnFixNull(store.getAt(rowIndex).data.BIZ_NUM        );	// 사업자번호            
	var ceoName      = fnFixNull(store.getAt(rowIndex).data.CEO_NAME       );	// 대표자명              
	var bizType      = fnFixNull(store.getAt(rowIndex).data.BIZ_TYPE       );	// 업태                  
	var bizKind      = fnFixNull(store.getAt(rowIndex).data.BIZ_KIND       );	// 업종                  
	var zipcode      = fnFixNull(store.getAt(rowIndex).data.ZIPCODE        );	// 우편번호              
	var addr         = fnFixNull(store.getAt(rowIndex).data.ADDR           );	// 주소                  
	var addrDetail   = fnFixNull(store.getAt(rowIndex).data.ADDR_DETAIL    );	// 주소상세              
	var telephone    = fnFixNull(store.getAt(rowIndex).data.TELEPHONE      );	// 전화번호              
	var fax          = fnFixNull(store.getAt(rowIndex).data.FAX            );	// 팩스                  
	var email        = fnFixNull(store.getAt(rowIndex).data.EMAIL          );	// E-MAIL                
	var etaxIssueYn  = fnFixNull(store.getAt(rowIndex).data.ETAX_ISSUE_YN  );	// 전자세금계산서발행여부
	var customLevel  = fnFixNull(store.getAt(rowIndex).data.CUSTOM_LEVEL   );	// 거래처등급코드        
	var note         = fnFixNull(store.getAt(rowIndex).data.NOTE           );	// 비고                  
	var useYn        = fnFixNull(store.getAt(rowIndex).data.USE_YN         );	// 사용여부              
	var finalModId   = fnFixNull(store.getAt(rowIndex).data.FINAL_MOD_ID   );   // 최종변경자ID          
	var finalModDate = fnFixNull(store.getAt(rowIndex).data.FINAL_MOD_DATE );   // 최종변경일시 	
	var finalModName = fnFixNull(store.getAt(rowIndex).data.FINAL_MOD_NAME );   // 최종변경자  
	
	/***** 그리드에 선택된 값을 상세 필드에 설정 *****/		
	var dForm = document.detailForm;
	dForm.flag.value 		   = flag		   				// 상태                  
	dForm.custom_code.value    = customCode    				// 거래처코드            
	dForm.custom_type.value    = customType    				// 거래처구분            
	dForm.custom_name.value    = customName    				// 거래처명              
	dForm.per_biz_type.value   = perBizType    				// 개인/사업자구분       
	dForm.biz_num.value 	   = bizNum        				// 사업자번호            
	dForm.ceo_name.value 	   = ceoName       				// 대표자명              
	dForm.biz_type.value 	   = bizType       				// 업태                  
	dForm.biz_kind.value 	   = bizKind       				// 업종                  
	dForm.zipcode1.value       = zipcode.substring(0,3); 	// 우편번호
	dForm.zipcode2.value       = zipcode.substring(3,6); 	// 우편번호
	dForm.addr.value 		   = addr          				// 주소                  
	dForm.addr_detail.value    = addrDetail    				// 주소상세              
	dForm.telephone.value 	   = telephone     				// 전화번호              
	dForm.fax.value 		   = fax           				// 팩스                  
	dForm.email.value 		   = email         				// E-MAIL                
//	dForm.etax_issue_yn.value  = etaxIssueYn   				// 전자세금계산서발행여부
	dForm.custom_level.value   = customLevel   				// 거래처등급코드        
	dForm.note.value 		   = note          				// 비고                  
//	dForm.use_yn.value 		   = useYn         				// 사용여부              
	dForm.final_mod_id.value   = finalModId    				// 최종변경자ID          
	dForm.final_mod_date.value = finalModDate  				// 최종변경일시
	dForm.final_mod_name.value = finalModName  				// 최종변경
	
	// 전자세금계산서발행여부
	if(etaxIssueYn == 'Y'){
		 dForm.etax_issue_yn[0].checked = true;
	}else if(etaxIssueYn == 'N'){
		 dForm.etax_issue_yn[1].checked = true;
	}
	
	// 사용여부
	if(useYn == 'Y'){
		 dForm.use_yn[0].checked = true;
	}else if(useYn == 'N'){
		 dForm.use_yn[1].checked = true;
	}
	
	/***** 필드 비활성화 *****/
	dForm.custom_type.disabled 		   = true;	// 거래처구분
	dForm.custom_code.disabled 		   = true;	// 거래처코드
	Ext.get('saveBtn').dom.disabled    = true;
	Ext.get('updateBtn').dom.disabled  = false;
}   

/***************************************************************************
 * 설  명 : 필드 초기화
 **************************************************************************/
function fnInitValue(){
	var dForm = document.detailForm;	// 상세 FORM	
	var toDay = getTimeStamp().trim();
	
	dForm.reset();						// 상세필드 초기화
	dForm.custom_type.disabled = false;	// 거래처구분
	dForm.custom_code.disabled = true;	// 거래처코드
	Ext.get('saveBtn').dom.disabled    = false;
	Ext.get('updateBtn').dom.disabled  = true;
	dForm.use_yn[0].checked = true;
	dForm.etax_issue_yn[0].checked = true;
	Ext.get('final_mod_date').set({value : toDay}, false);   
	Ext.get('final_mod_name').set({value : '${admin_nm}'}, false);
}

/***************************************************************************
 * 설  명 : 검색
 **************************************************************************/
function fnSearch(){  	
	
	Ext.Ajax.request({   
		url: "/com/custom/result.sg"
		,method : 'POST'   
		,success: function(response){						// 조회결과 성공시
					// 조회된 결과값, store명
					handleSuccess(response,GridClass_1st);
		          }
		,failure: handleFailure   	   // 조회결과 실패시  
		,form   : document.searchForm  // 검색 FORM
		,params : {					   // 조회조건을 DB로 전송하기위해서 조건값 설정
					// 페이지정보
					limit           : limit_1st
			  	  , start           : start_1st
				  }				
	});  
	
	fnInitValue(); // 상세필드 초기화
}  		

/***************************************************************************
 * 설  명 : 저장버튼 클릭
 ***************************************************************************/
function fnSave(){  	

	var sForm = document.searchForm;	// 검색 FORM
	var dForm = document.detailForm;	// 상세 FORM

	// 거래처구분, 거래처코드값이 넘어갈수 있도록 disable 해제
	dForm.custom_type.disabled = false; 
	dForm.custom_code.disabled = false; 
	
	Ext.Ajax.request({   
		url: "/com/custom/updateCustom.sg"   
		,success: function(response){						// 조회결과 성공시
					// 조회된 결과값, store명
					handleSuccess(response,GridClass_1st,'save');
		          }
		,failure: handleFailure   	    // 조회결과 실패시  
		,form   : document.detailForm   // 상세 FORM
		,params : {					    // 조회조건을 DB로 전송하기위해서 조건값 설정
				  // 페이지정보
					limit           : limit_1st
			  	  , start           : start_1st
				  // 검색정보
				  , src_custom_type : sForm.src_custom_type.value // 거래처구분
			  	  //, src_custom_code : sForm.src_custom_code.value // 거래처코드
			  	  , src_biz_num     : sForm.src_biz_num.value     // 사업자번호
			  	//  , custom_code     : Ext.get('custom_code').getValue()
				  }  		
	});  
	
	fnInitValue(); // 상세필드 초기화
		
}  		

/***************************************************************************
 * 설  명 : 화면 설정
 ***************************************************************************/
// ExtJS 진입함수
Ext.onReady(function() {
	
	var sForm = document.searchForm;	// 검색 FORM
	var dForm = document.detailForm;	// 상세 FORM
		
    // 수정버튼 클릭
	Ext.get('updateBtn').on('click', function(e){
		if(fnValidation()){
			Ext.MessageBox.confirm('Confirm', '수정하시겠습니까?', showResult);
		}
    });
    
    // 저장버튼 클릭
	Ext.get('saveBtn').on('click', function(e){
        if(fnValidation()){
			Ext.MessageBox.confirm('Confirm', '저장하시겠습니까?', showResult);
		}	
    });
    
    // 검색버튼 클릭
	Ext.get('searchBtn').on('click', function(e){
        if(Validator.validate(sForm)){
			fnSearch()
		}	
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
	
	// 주소검색 버튼
	Ext.get('addrBtn').on('click', function(e){
		getPost(this,'addr',' ');
	});
	
	// 거래처검색 버튼
	Ext.get('src_custom_btn').on('click', function(e){
		fnCustomPop('src_custom_code','src_custom_name','searchForm')
	});
	
	dForm.custom_code.disabled = false;	// 거래처코드
	
	fnInitValue();
	
}); // end Ext.onReady
	
// 저장, 수정버튼 클릭시 '예','아니오' 
function showResult(btn){
   	if(btn == 'yes'){
   		fnSave();
   	}    	
};   
	
/***************************************************************************
 * 설  명 : 그리드의 페이지 클릭시 검색조건값을 DB로 전송
 ***************************************************************************/
function fnCustomPop(fieldCode,fieldName,form,div,search_val){
	var sURL      = "/com/custom/customPop.sg?fieldCode="+fieldCode+"&fieldName="+fieldName+"&form="+form;
	var dlgWidth  = 416;
	var dlgHeight = 366;
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
 * 설  명 : 그리드의 페이지 클릭시 검색조건값을 DB로 전송
 ***************************************************************************/
function fnPagingValue_1st(){
	var sForm = document.searchForm;
	
	try{
    	GridClass_1st.store.setBaseParam('src_custom_type', sForm.src_custom_type.value);
    	//GridClass_1st.store.setBaseParam('src_custom_code', sForm.src_custom_code.value);
    	GridClass_1st.store.setBaseParam('src_biz_num',     sForm.src_biz_num.value);
    	GridClass_1st.store.setBaseParam('div', 'grid_page');
	}catch(e){

	}
}

function fnValidation(){
	
	var custom_type = Ext.get('custom_type').getValue();		// 거래처구분
	var per_biz_type = Ext.get('per_biz_type').getValue(); 		// 개인/사업자구분
	var biz_num = Ext.get('biz_num').getValue(); 				// 사업자번호
	var custom_name = Ext.get('custom_name').getValue();		// 거래처명
	var custom_name_len = getByteLength(custom_name);
	var ceo_name_len = getByteLength(Ext.get('ceo_name').getValue());	// 대표자명
	var email_len = getByteLength(Ext.get('email').getValue());			// E-Mail
	var biz_type_len = getByteLength(Ext.get('biz_type').getValue());	// 업태
	var biz_kind_len = getByteLength(Ext.get('biz_kind').getValue());	// 업종
	var note_len = getByteLength(Ext.get('note').getValue());			// 비고
	
	if(custom_type.length == 0 || custom_type == ""){
		Ext.Msg.alert('확인', '거래처구분을 선택해주세요.')
		return false;
	}
	
	if(per_biz_type.length == 0 || per_biz_type == ""){
		Ext.Msg.alert('확인', '개인/사업자구분을 선택해주세요.')
		return false;
	}
	
	if(biz_num.length == 0 || biz_num == ""){
		Ext.Msg.alert('확인', '사업자번호를 입력해주세요.')
		return false;
	}else if(biz_num.length < 10){
		Ext.Msg.alert('확인', '사업자번호는 10자리입니다.')
		return false;
	}else if(biz_num.length == 10){
		if(!isValidBizNo('',biz_num)){
			return false;
		}
	}
	
	if(custom_name.length == 0 || custom_name == ""){
		Ext.Msg.alert('확인', '거래처명을 입력해주세요.')
		return false;
	}
	
	if(custom_name_len > 100){
		Ext.Msg.alert('확인', '거래처명은 한글 50자까지 입력가능합니다.')
		return false;
	}
	
	if(ceo_name_len > 20){
		Ext.Msg.alert('확인', '대표자명은 한글 10자까지 입력가능합니다.')
		return false;
	}
	
	if(email_len > 30){
		Ext.Msg.alert('확인', 'E-Mail은 영문30자까지 입력가능합니다.')
		return false;
	}

	if(biz_type_len > 30){
		Ext.Msg.alert('확인', '업태는 한글15자까지 입력가능합니다.')
		return false;
	}
	
	if(biz_kind_len > 30){
		Ext.Msg.alert('확인', '업종는 한글15자까지 입력가능합니다.')
		return false;
	}
	
	if(note_len > 1000){
		Ext.Msg.alert('확인', '비고는 한글500자까지 입력가능합니다.')
		return false;
	}
	
	return true;
}
</script>

</head>
<body>
	<table border="0" width="1000" height="200">
		<tr>
			<td colspan="2">
				<form name="searchForm" id="searchForm">
				<!----------------- SEARCH Hearder Start	 ----------------->
				<div id="ext-comp-1002" class=" x-panel x-form-label-left" style="margin-top: 0em;"><%-- 0em <- 1em으로 수정하면 상위 공백 --%>
					<div class="x-panel-tl">
						<div class="x-panel-tr">
							<div class="x-panel-tc">
								<div id="ext-gen4" class="x-panel-header x-unselectable" style="-moz-user-select: none;">
									<span id="ext-gen8" class="x-panel-header-text">거래처 검색</span>
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
								<table border="0" width="100%">
						    		<%-- 1 Row Start --%>
						    		<tr>
						    			<td width="24%">
											<div tabindex="-1" class="x-form-item " >
												<label class="x-form-item-label" style="width: auto;" for="src_custom_type" >거래처구분 :</label>
												<div style="padding-left: 30px;" class="x-form-element">
													<select name="src_custom_type" id="src_custom_type" title="거래처구분" style="width: 44%;" type="text" class="x-form-select x-form-field" >
														<option value="">전체</option>
														<c:forEach items="${CUSTOM_TYPE}" var="data" varStatus="status">
														<option value="${data.COM_CODE}"><c:out value="${data.COM_CODE_NAME}"/></option>
														</c:forEach>
													</select>
												</div>
											</div>
										</td>
										
						    			<td width="16%">
											<div tabindex="-1" class="x-form-item " >
												<label class="x-form-item-label" style="width: auto; padding-left: 2px;" for="src_custom_code" >거래처명 :</label>
												<div style="padding-left: 0px;" class="x-form-element">
													<input type="text" name="src_custom_name" id="src_custom_name" autocomplete="off" size="20" class=" x-form-text x-form-field" style="width: auto;">
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
										<td width="5%">
<%--											<div tabindex="-1" class="x-form-item " >--%>
<%--												<div style="padding-left: 2px; " class="x-form-element">--%>
													<input type="hidden" name="src_custom_code" id="src_custom_code" autocomplete="off" size="1" class=" x-form-text x-form-field" style="width: auto;">													
<%--												</div>--%>
<%--											</div>--%>
										</td>
										<td width="20%">
											<div tabindex="-1" class="x-form-item " >
												<label class="x-form-item-label" style="width: auto;" for="src_biz_num" >사업자번호 :</label>
												<div style="padding-left: 30px;" class="x-form-element">
													<input type="text" name="src_biz_num" id="src_biz_num" autocomplete="off" size="20" class=" x-form-text x-form-field" style="width: auto;">
												</div>
											</div>
										</td>
										<td width="14%" align="right">
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
				<!------------------ footer Start -------------------------->
				<div id="" class="x-panel-bl x-panel-nofooter">
					<div class="x-panel-br">
						<div class="x-panel-bc">
						</div>
					</div>
				</div>
				<!----------------- footer End  ---------------------------->
				<!----------------- SEARCH Field End ----------------------->
				</form>
			</td>
		</tr>
		<tr>
			<!------------------------------ GRID START ---------------------------------->
			<td width="49%" valign="top">
				<div id="custom-grid" style="margin-top: 0em;"></div>
			</td>
			<!------------------------------ GRID END ------------------------------------>
			<td width="51%" valign="top">
				<div class=" x-panel x-form-label-left" style="margin-top: 0em; width: 100%;"><%-- 0em <- 1em으로 수정하면 상위 공백 --%>
					<!----------------- SEARCH Hearder Start	 ----------------->
					<div class="x-panel-tl">
						<div class="x-panel-tr">
							<div class="x-panel-tc">
								<div class="x-panel-header x-unselectable" style="-moz-user-select: none;">
									<span class="x-panel-header-text">거래처 정보</span>
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
									<div class="x-column-inner" style="width: 100%; margin-top: 0.2em;">
										<div class=" x-panel x-column" style="width: 50%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label class="x-form-item-label" style="width: auto;" for="custom_type" ><font color="red">* </font>거래처구분 :</label>
														<input type="hidden" name="flag" id="flag" autocomplete="off" size="1" class=" x-form-text x-form-field" style="width: auto;">
														<div style="padding-left: 111px;" class="x-form-element">
															<select name="custom_type" id="custom_type" title="거래처구분" style="width: 45%;" type="text" class="x-form-select x-form-field" >
																<option value="">선택하세요</option>
																<c:forEach items="${CUSTOM_TYPE}" var="data" varStatus="status">
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
														<label class="x-form-item-label" style="width: auto;" for="custom_code" >&nbsp;&nbsp;&nbsp;거래처코드:</label>
														<div style="padding-left: 90px;" class="x-form-element">
															<input type="text" name="custom_code" id="custom_code" autocomplete="off" size="22" class=" x-form-text x-form-field" style="width: auto;">
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
									<div class="x-column-inner" style="width: 100%; margin-top: 0em;">
										<div class=" x-panel x-column" style="width: 50%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label class="x-form-item-label" style="width: auto;" for="per_biz_type" ><font color="red">* </font>개인/사업자구분 :</label>
														<div style="padding-left: 107px;" class="x-form-element">
															<select name="per_biz_type" id="per_biz_type" style="width: 45%;" type="text" class="x-form-select x-form-field" >
																<option value="">선택하세요</option>
																<c:forEach items="${PER_BIZ_TYPE_CODE}" var="data" varStatus="status">
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
														<label class="x-form-item-label" style="width: auto;" for="est_date" ><font color="red">* </font>사업자번호:</label>
														<div style="padding-left: 90px;" class="x-form-element">
															<input type="text" name="biz_num" id="biz_num" autocomplete="off" size="22" class=" x-form-text x-form-field" style="width: auto;" maxlength="10" onkeyPress="return _chkKeyPressNumOnly(this)" onBlur="_removeComma(this, this.value)" onfocus="_removeComma(this, this.value)">
														</div>
														<div class="x-form-clear-left">
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>
									<!-- DETAIL 3_ROW End -->
									
									<!-- DETAIL 4_ROW Start -->
									<div class="x-column-inner" style="width: 100%; margin-top: 0em;">
										<div class=" x-panel x-column" style="width: 50%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label class="x-form-item-label" style="width: auto;" for="est_date" ><font color="red">* </font>거래처명 :</label>
														<div style="padding-left: 107px;" class="x-form-element">
															<input type="text" name="custom_name" id="custom_name" autocomplete="off" size="18" class=" x-form-text x-form-field" style="width: auto;" maxlength="100"/>
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
														<label style="padding-rigth: 100px;"  class="x-form-item-label" style="width: auto;" for="use_yn1" ><font color="red">* </font>전자세금계산서:</label>
														<input type="radio" name="etax_issue_yn" id="etax_issue_yn1" autocomplete="off" class=" x-form-radio x-form-field" value="Y">
													    <label class="x-form-cb-label" for="etax_issue_yn1" >발행</label>
													    <input type="radio" name="etax_issue_yn" id="etax_issue_yn2" autocomplete="off" class=" x-form-radio x-form-field" value="N">
													    <label class="x-form-cb-label" for="etax_issue_yn2" >미발행</label>
														<div class="x-form-clear-left">
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>
									<!-- DETAIL 4_ROW End -->
									
									<!-- DETAIL 5_ROW Start -->
									<div class="x-column-inner" style="width: 100%; margin-top: 0em;">
										<div class=" x-panel x-column" style="width: 50%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label class="x-form-item-label" style="width: auto;" for="ceo_name" >&nbsp;&nbsp;&nbsp;대표자명 :</label>
														<div style="padding-left: 107px;" class="x-form-element">
															<input type="text" name="ceo_name" id="ceo_name" autocomplete="off" size="18" class=" x-form-text x-form-field" style="width: auto;" maxlength="20"/>
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
														<label class="x-form-item-label" style="width: auto;" for="email" >&nbsp;&nbsp;&nbsp;홈페이지<!--대표 E-mail --> :</label>
														<div style="padding-left: 90px;" class="x-form-element">
															<input type="text" name="email" id="email" autocomplete="off" size="22" class=" x-form-text x-form-field" style="width: auto;" maxlength="30"/>
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
									<div class="x-column-inner" style="width: 100%; margin-top: 0em;">
										<div class=" x-panel x-column" style="width: 50%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label class="x-form-item-label" style="width: auto;" for="biz_type" >&nbsp;&nbsp;&nbsp;업태 :</label>
														<div style="padding-left: 107px;" class="x-form-element">
															<input type="text" name="biz_type" id="biz_type" autocomplete="off" size="18" class=" x-form-text x-form-field" style="width: auto;" maxlength="30"/>
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
														<label class="x-form-item-label" style="width: auto;" for="biz_kind" >&nbsp;&nbsp;&nbsp;업종 :</label>
														<div style="padding-left: 90px;" class="x-form-element">
															<input type="text" name="biz_kind" id="biz_kind" autocomplete="off" size="22" class=" x-form-text x-form-field" style="width: auto;" maxlength="30"/>
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
									<div class="x-column-inner" style="width: 100%; margin-top: 0em;">
										<div class=" x-panel x-column" style="width: 100%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label class="x-form-item-label" style="width: auto;" for="est_type_code" >&nbsp;&nbsp;&nbsp;우편번호:</label>
														<div style="padding-left: 107px;" class="x-form-element">
															<table style="width: 360px;" cellspacing="0" border="0" class="x-btn  x-btn-noicon">
																<tr>
																	<td width="20%">
																		<input type="text" name="zipcode1" id="zipcode1" autocomplete="off" size="2" class="x-form-text x-form-field " style="width: auto;" maxlength="3"/>
																		<input type="text" name="zipcode2" id="zipcode2" autocomplete="off" size="2" class=" x-form-text x-form-field" style="width: auto;" maxlength="3"/>
																	</td>
																	<td width="7%">
																		<%-- Button Start--%>
																		<div style="padding-left: 1px;" >
																			<img align="center" id="addrBtn" name="addrBtn" alt="" src="/resource/images/bass_1st/icon_src1.gif" style="cursor: hand;">
																		</div>
																		<%-- Button End--%>
																	</td>
																	<td>
																		<input stype="text" name="addr" id="addr" autocomplete="off" size="47" class=" x-form-text x-form-field" style="width: auto;" maxlength="500"/>
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
									<!-- DETAIL 7_ROW End -->
									
									<!-- DETAIL 8_ROW Start -->
									<div class="x-column-inner" style="width: 100%; margin-top: 0em;">
										<div class=" x-panel x-column" style="width: 100%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label class="x-form-item-label" style="width: auto;" for="addr_detail" >&nbsp;&nbsp;&nbsp;상세주소:</label>
														<div style="padding-left: 107px;" class="x-form-element">
															<input type="text" name="addr_detail" id="addr_detail" autocomplete="off" size="66" class=" x-form-text x-form-field" style="width: auto;" maxlength="500"/>
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
									<div class="x-column-inner" style="width: 100%; margin-top: 0em;">
										<div class=" x-panel x-column" style="width: 50%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label class="x-form-item-label" style="width: auto;" for="telephone" >&nbsp;&nbsp;&nbsp;전화번호 :</label>
														<div style="padding-left: 107px;" class="x-form-element">
															<input type="text" name="telephone" id="telephone" autocomplete="off" size="18" class=" x-form-text x-form-field" style="width: auto;" maxlength="20"/>
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
														<label class="x-form-item-label" style="width: auto;" for="fax" >&nbsp;&nbsp;&nbsp;Fax번호 :</label>
														<div style="padding-left: 90px;" class="x-form-element">
															<input type="text" name="fax" id="fax" autocomplete="off" size="22" class=" x-form-text x-form-field" style="width: auto;" maxlength="20"/>
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
									<div class="x-column-inner" style="width: 100%; margin-top: 0em;">
										<div class=" x-panel x-column" style="width: 50%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label class="x-form-item-label" style="width: auto;" for="custom_level" >&nbsp;&nbsp;&nbsp;거래처등급 :</label>
														<div style="padding-left: 111px;" class="x-form-element">
															<select name="custom_level" id="custom_level" title="담당자등급" style="width: 45%;" type="text" class="x-form-select x-form-field" >
																<option value="">선택하세요</option>
																<c:forEach items="${CUSTOM_LEVEL_CODE}" var="data" varStatus="status">
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
														<label style="padding-rigth: 100px;"  class="x-form-item-label" style="width: auto;" for="use_yn1" ><font color="red">* </font>사용여부:</label>
														<input type="radio" name="use_yn" id="use_yn1" autocomplete="off" class=" x-form-radio x-form-field" value="Y">
													    <label class="x-form-cb-label" for="use_yn2" >Yes</label>
													    <input type="radio" name="use_yn" id="use_yn2" autocomplete="off" class=" x-form-radio x-form-field" value="N">
													    <label class="x-form-cb-label" for="use_yn2" >No</label>
														<div class="x-form-clear-left">
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>
									<!-- DETAIL 10_ROW End -->
									
									<!-- DETAIL 11_ROW Start -->
									<div class="x-column-inner" style="width: 100%; margin-top: 0em;">
										<div class=" x-panel x-column" style="width: auto;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label class="x-form-item-label" style="width: auto;" for="note" >&nbsp;&nbsp;&nbsp;비고 :</label>
														<div style="padding-left: 110px;" class="x-form-element">
															<textarea name="note" id="note" autocomplete="off" style="width: 355px; height: 60px; left: 0px; top: 0px;" class="x-form-textarea x-form-field x-box-item"></textarea>
														</div>
														<div class="x-form-clear-left">
														</div>
													</div>
												</div>
											</div>
										</div>					
									</div>
									<!-- DETAIL 11_ROW End -->
									
									<!-- DETAIL 12_ROW Start -->
									<div class="x-column-inner" style="width: 100%; margin-top: 0.6em;">
										<div class=" x-panel x-column" style="width: 50%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: auto;">
													<div tabindex="-1" class="x-form-item " >
														<label class="x-form-item-label" style="width: auto;" for="final_mod_name" >최종변경자 :</label>
														<div style="padding-left: 107px;" class="x-form-element">
															<input type="text" name="final_mod_name" id="final_mod_name" autocomplete="off" size="18" class=" x-form-text x-form-field" style="width: auto;" readonly>
															<input type="hidden" name="final_mod_id" id="final_mod_id" autocomplete="off" size="18" class=" x-form-text x-form-field" style="width: auto;" readonly>
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
														<label class="x-form-item-label" style="width: auto;" for="final_mod_date" >최종변경일시 :</label>
														<div style="padding-left: 90px;" class="x-form-element">
															<input type="text" name="final_mod_date" id="final_mod_date" autocomplete="off" size="22" class=" x-form-text x-form-field" style="width: auto;" readonly>
														</div>
														<div class="x-form-clear-left">
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>
									<!-- DETAIL 12_ROW End -->
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
					</tr>
				</table>
			</td>
		</tr>
	</table>
</body>

<%@ include file="/WEB-INF/web/jsp/sgis-bottom-inc.jsp" %>