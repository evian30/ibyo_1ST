<%--
  Class Name  : customMemberList.jsp
  Description : 거래처담당자등록
  Modification Information
 
      수정일                   수정자                 수정내용
  -------      --------    ---------------------------
  2011. 3. 15   고기범            최초 생성   
  2011. 3. 24   고기범            스타일 및 공통 JS적용
  
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
var	gridHeigth_1st 	 	= 388; 									// 그리드 전체 높이
var	gridWidth_1st		= 497;									// 그리드 전체 폭
var gridTitle_1st 		= "거래처 담당자 목록";						// 그리드 제목
var	render_1st			= "customMember-grid";	        		// 렌더(화면에 그려질) 할 id 
var	pageSize_1st		= 14;	  								// 그리드 페이지 사이즈	
var	proxyUrl_1st		= "/com/custom/customMemberResult.sg";  // 결과 값 페이지
var limit_1st			= pageSize_1st;
var start_1st			= 0;
 

// 그리드의 페이지 클릭시 검색조건값을 DB로 전송
function fnPagingValue_1st(){
	var sForm = document.searchForm;
	
	try{
		GridClass_1st.store.setBaseParam('start'		 	 ,start_1st);
	    GridClass_1st.store.setBaseParam('limit'		 	 ,limit_1st);
		// GridClass_1st.store.setBaseParam('src_custom_code'   ,Ext.get('src_custom_code').getValue());
    	GridClass_1st.store.setBaseParam('src_biz_num'       ,Ext.get('src_biz_num').getValue());
		GridClass_1st.store.setBaseParam('src_customer_name' ,Ext.get('src_customer_name').getValue());
    	GridClass_1st.store.setBaseParam('div', 'grid_page');
	}catch(e){

	}
}

// Grid의 컬럼 설정
var userColumns_1st =  [ {header: '상태'       	   		 	,width: 50 	,sortable: true ,dataIndex: 'FLAG'			     ,hidden : true }       
				   	   , {header: '거래처코드' 			 	,width: 60	,sortable: true ,dataIndex: 'CUSTOM_CODE'	     ,hidden : true }
				   	   , {header: '거래처구분' 			 	,width: 60  ,sortable: true ,dataIndex: 'CUSTOM_TYPE'	   	 ,hidden : true }
				   	   , {header: '거래처' 					,width: 50  ,sortable: true ,dataIndex: 'CUSTOM_NAME'	   	 ,hidden : false}
				   	   , {header: '사업자번호' 			 	,width: 50  ,sortable: true ,dataIndex: 'BIZ_NUM'		   	 ,hidden : true }
				   	   , {header: '거래처담당자번호' 		,width: 50  ,sortable: true ,dataIndex: 'CUSTOMER_NUM' 	   	 ,hidden : true }
				   	   , {header: '담당자'	 		 		,width: 30  ,sortable: true ,dataIndex: 'CUSTOMER_NAME' 	 ,hidden : false}
				   	   , {header: '거래처담당자부서' 		,width: 50  ,sortable: true ,dataIndex: 'CUSTOMER_DEPT' 	 ,hidden : true }
				   	   , {header: '직위' 				 	,width: 30  ,sortable: true ,dataIndex: 'CUSTOMER_POSITION'  ,hidden : false}
				   	   , {header: '거래처담당자업무구분코드' 	,width: 50  ,sortable: true ,dataIndex: 'CUSTOMER_ROLL_CODE' ,hidden : true }
				   	   , {header: '전화번호' 	 			,width: 50  ,sortable: true ,dataIndex: 'CUSTOMER_TELEPHONE' ,hidden : false}
				   	   , {header: '휴대폰번호' 	 			,width: 50  ,sortable: true ,dataIndex: 'CUSTOMER_MOBILE' 	 ,hidden : false}
	   				   , {header: '거래처담당자내선번호' 	 	,width: 50  ,sortable: true ,dataIndex: 'CUSTOMER_DIRECT' 	 ,hidden : true }
			   		   , {header: 'E-MAIL' 	 				,width: 80  ,sortable: true ,dataIndex: 'CUSTOMER_EMAIL' 	 ,hidden : false}
					   , {header: '거래처담당자등급' 		,width: 50  ,sortable: true ,dataIndex: 'CUSTOMER_LEVEL' 	 ,hidden : true }
				   	   , {header: '거래처담당자메모사항'	 	,width: 50  ,sortable: true ,dataIndex: 'CUSTOMER_NOTICE' 	 ,hidden : true }
				   	   , {header: '비고'					 	,width: 50  ,sortable: true ,dataIndex: 'NOTE' 			   	 ,hidden : true }
				   	   , {header: '사용여부' 				,width: 50  ,sortable: true ,dataIndex: 'USE_YN' 		   	 ,hidden : true }
				   	   , {header: '최종변경자ID' 			,width: 50  ,sortable: true ,dataIndex: 'FINAL_MOD_ID' 	   	 ,hidden : true }
				   	   , {header: '최종변경일시'		 	 	,width: 50  ,sortable: true ,dataIndex: 'FINAL_MOD_DATE'     ,hidden : true }
				   	   , {header: '최종변경자ID' 			,width: 50  ,sortable: true ,dataIndex: 'FINAL_MOD_NAME' 	 ,hidden : true }
				   	   ];	 

// 그리드 결과매핑 
var mappingColumns_1st = [ {name: 'FLAG' 		   	   ,allowBlank: false}	// 상태
					     , {name: 'CUSTOM_CODE'	       ,allowBlank: false}  // 거래처코드 			 	  		                                                
					 	 , {name: 'CUSTOM_TYPE'	   	   ,allowBlank: false}  // 거래처구분 			    		                                               
					 	 , {name: 'CUSTOM_NAME'	   	   ,allowBlank: false}  // 거래처명 				    		                                              
					 	 , {name: 'BIZ_NUM'		   	   ,allowBlank: false}  // 사업자번호 			    		                                                
					 	 , {name: 'CUSTOMER_NUM' 	   ,allowBlank: false}  // 거래처담당자번호 		    	                                               
					 	 , {name: 'CUSTOMER_NAME' 	   ,allowBlank: false}  // 당자명 		 		    			                                                
					 	 , {name: 'CUSTOMER_DEPT' 	   ,allowBlank: false}  // 거래처담당자부서 		                                                    
					 	 , {name: 'CUSTOMER_POSITION'  ,allowBlank: false}  // 직위 				    				                                                
					 	 , {name: 'CUSTOMER_ROLL_CODE' ,allowBlank: false}  // 거래처담당자업무구분코드                                                
					 	 , {name: 'CUSTOMER_TELEPHONE' ,allowBlank: false}  // 거래처담당자전화번호 	                                                 
					 	 , {name: 'CUSTOMER_MOBILE'    ,allowBlank: false}  // 거래처담당자휴대폰번호 	                                               
					 	 , {name: 'CUSTOMER_DIRECT'    ,allowBlank: false}  // 거래처담당자내선번호 	                                                 
					 	 , {name: 'CUSTOMER_EMAIL' 	   ,allowBlank: false}  // 거래처담당자E-MAIL 	                                                   
					 	 , {name: 'CUSTOMER_LEVEL' 	   ,allowBlank: false}  // 거래처담당자등급 		                            
					 	 , {name: 'CUSTOMER_NOTICE'    ,allowBlank: false}  // 거래처담당자메모사항	                          
					 	 , {name: 'NOTE' 			   ,allowBlank: false}  // 비고					    			                        
					 	 , {name: 'USE_YN' 		   	   ,allowBlank: false}  // 사용여부 				    		                        
					 	 , {name: 'FINAL_MOD_ID' 	   ,allowBlank: false}  // 최종변경자ID 			    	                        
					 	 , {name: 'FINAL_MOD_DATE'     ,allowBlank: false}  // 최종변경일시
					 	 , {name: 'FINAL_MOD_NAME' 	   ,allowBlank: false}  // 최종변경자ID 
    				 	 ];
 
/***************************************************************************
 * 그리드 클릭시 Event
 ***************************************************************************/
function fnGridOnClick_1st(store, rowIndex){

	var dForm = document.detailForm;	 // 상세 FORM	
	
	/***** 선택된 레코드에서 데이타 가져오기 *****/
	Ext.get('flag').set({value : fnFixNull(store.getAt(rowIndex).data.FLAG)}							, false); // 상태  
	Ext.get('custom_code').set({value : fnFixNull(store.getAt(rowIndex).data.CUSTOM_CODE)}				, false); // 거래처코드
	Ext.get('custom_type').set({value : fnFixNull(store.getAt(rowIndex).data.CUSTOM_TYPE)}				, false); // 거래처구분 			    		
	Ext.get('custom_name').set({value : fnFixNull(store.getAt(rowIndex).data.CUSTOM_NAME)}				, false); // 거래처명 				    		
	Ext.get('biz_num').set({value : fnFixNull(store.getAt(rowIndex).data.BIZ_NUM)}						, false); // 사업자번호 			    		
	Ext.get('customer_num').set({value : fnFixNull(store.getAt(rowIndex).data.CUSTOMER_NUM)}			, false); // 거래처담당자번호 		    
	Ext.get('customer_name').set({value : fnFixNull(store.getAt(rowIndex).data.CUSTOMER_NAME)}			, false); // 당자명 		 		    			
	Ext.get('customer_dept').set({value : fnFixNull(store.getAt(rowIndex).data.CUSTOMER_DEPT)}			, false); // 거래처담당자부서 		    
	Ext.get('customer_position').set({value : fnFixNull(store.getAt(rowIndex).data.CUSTOMER_POSITION)}  , false); // 직위 				    				
	Ext.get('customer_roll_code').set({value : fnFixNull(store.getAt(rowIndex).data.CUSTOMER_ROLL_CODE)}, false); // 거래처담당자업무구분코드 
	Ext.get('customer_telephone').set({value : fnFixNull(store.getAt(rowIndex).data.CUSTOMER_TELEPHONE)}, false); // 거래처담당자전화번호 	  
	Ext.get('customer_mobile').set({value : fnFixNull(store.getAt(rowIndex).data.CUSTOMER_MOBILE)}	    , false); // 거래처담당자휴대폰번호 	
	Ext.get('customer_direct').set({value : fnFixNull(store.getAt(rowIndex).data.CUSTOMER_DIRECT)}		, false); // 거래처담당자내선번호 	  
	Ext.get('customer_email').set({value : fnFixNull(store.getAt(rowIndex).data.CUSTOMER_EMAIL)}		, false); // 거래처담당자E-MAIL 	    
	Ext.get('customer_level').set({value : fnFixNull(store.getAt(rowIndex).data.CUSTOMER_LEVEL)}	    , false); // 거래처담당자등급 		    
	Ext.get('customer_notice').set({value : fnFixNull(store.getAt(rowIndex).data.CUSTOMER_NOTICE)}		, false); // 거래처담당자메모사항	    
	Ext.get('note').set({value : fnFixNull(store.getAt(rowIndex).data.NOTE)}							, false); // 비고					    			  
	Ext.get('final_mod_id').set({value : fnFixNull(store.getAt(rowIndex).data.FINAL_MOD_ID)}			, false); // 최종변경자ID 			    	
	Ext.get('final_mod_date').set({value : fnFixNull(store.getAt(rowIndex).data.FINAL_MOD_DATE)}		, false); // 최종변경일시		 	    	  
	
	var useYn = fnFixNull(store.getAt(rowIndex).data.USE_YN);	// 사용여부
	
	// 사용여부
	if(useYn == 'Y'){
		 dForm.use_yn[0].checked = true;
	}else if(useYn == 'N'){
		 dForm.use_yn[1].checked = true;
	}
	
	/***** 필드 비활성화 *****/
	//dForm.customer_num.disabled = true;	// 거래처담당자번호
	
	Ext.get('saveBtn').dom.disabled    = true;
	Ext.get('updateBtn').dom.disabled  = false;
	Ext.get('custom_btn').dom.disabled = true;
	
}   

/***************************************************************************
 * 설  명 : 필드 초기화
 **************************************************************************/
function fnInitValue(){

	var dForm = document.detailForm;	 		// 상세 FORM	
	var toDay = getTimeStamp().trim();
	
	dForm.reset();						 		// 상세필드 초기화
	//dForm.customer_num.disabled 	   = false; // 거래처담당자번호
	Ext.get('saveBtn').dom.disabled    = false;
	Ext.get('updateBtn').dom.disabled  = true;
	Ext.get('custom_btn').dom.disabled = false;
	dForm.use_yn[0].checked = true;
	
	Ext.get('final_mod_date').set({value : toDay}, false);   
	Ext.get('final_mod_name').set({value : '${admin_nm}'}, false);
}

/***************************************************************************
 * 설  명 : 검색
 **************************************************************************/
function fnSearch(){  	
	
	Ext.Ajax.request({   
		url: "/com/custom/customMemberResult.sg"
		,method : 'POST'   
		,success: function(response){						// 조회결과 성공시
					// 조회된 결과값, store명
					handleSuccess(response,GridClass_1st);
		          }   							
		,failure: handleFailure   	   						// 조회결과 실패시  
		,form   : document.searchForm  						// 검색 FORM
		,params : {					   						// 조회조건을 DB로 전송하기위해서 조건값 설정
					limit          : limit_1st
				  , start          : start_1st
				  }				
	});  
	
	fnInitValue(); // 상세필드 초기화
}  		

/***************************************************************************
 * 설  명 : 저장버튼 클릭
 ***************************************************************************/
function fnSave(){  	

	var dForm = document.detailForm;	// 상세 FORM

	// 거래처구분, 거래처코드값이 넘어갈수 있도록 disable 해제
	dForm.customer_num.disabled = false; 

	Ext.Ajax.request({   
		url: "/com/custom/updateCustomMember.sg"   
		,success: function(response){						// 조회결과 성공시
					// 조회된 결과값, store명
					handleSuccess(response,GridClass_1st,'save');
		          } 
		,failure: handleFailure   	    // 조회결과 실패시  
		,form   : document.detailForm   // 상세 FORM
		,params : {					    // 조회조건을 DB로 전송하기위해서 조건값 설정
				  // 페이지정보
					limit_1st             : limit_1st
			  	  , start_1st             : start_1st
				  // 검색정보
			  	  //, src_custom_code   : Ext.get('src_custom_code').getValue()	// 거래처코드
			  	  , src_biz_num       : Ext.get('src_biz_num').getValue()// 사업자번호
			  	  , src_customer_name : Ext.get('src_customer_name').getValue()	// 담당자명
			  	  // disable된 컬럼의 자료
			  	  , custom_code  	  : Ext.get('custom_code').getValue()		// 거래처코드
			  	  , custom_name  	  : Ext.get('custom_name').getValue()		// 거래처명
			  	  , custom_type  	  : Ext.get('custom_type').getValue()		// 거래처구분
			  	  , biz_num  	      : Ext.get('biz_num').getValue()		  	// 사업자번호
			  	  , customer_num      : Ext.get('customer_num').getValue()		// 거래처담당자번호
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
				Ext.MessageBox.confirm('Confirm', '저장하시겠습니까?', showResult, 'a');
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
		
		// 거래처검색 버튼(검색)
		Ext.get('src_custom_btn').on('click', function(e){
			
			var param = '?fieldCode=src_custom_code&fieldName=src_custom_name';
			param = param + '&form=searchForm';
			fnCustomPop(param)
		});
		
		// 거래처검색 버튼(상세)
		Ext.get('custom_btn').on('click', function(e){
			
			var param = '?fieldCode=custom_code&fieldName=custom_name';
			param = param + '&customType=custom_type&bizNum=biz_num';
			param = param + '&form=detailForm';
			fnCustomPop(param);
		});
		
		Ext.get('custom_code').dom.disabled = true;
		Ext.get('custom_name').dom.disabled = true;
		Ext.get('custom_type').dom.disabled = true;
		Ext.get('biz_num').dom.disabled = true;
		Ext.get('customer_num').dom.disabled = true;
		
<%--		custom_type.set({disabled:null}, false);--%>
<%--		custom_name.set({disabled:null}, false);--%>
<%--		biz_num.set({disabled:null}, false);--%>
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
function fnCustomPop(param){
	var sURL      = "/com/custom/customPop.sg"+param;
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
	
function fnValidation(){
	
	var custom_code = Ext.get('custom_code').getValue();		// 거래처코드
	var custom_name = Ext.get('custom_name').getValue(); 		// 거래처명
	var custom_type = Ext.get('custom_type').getValue(); 		// 거래처구분
	var biz_num = Ext.get('biz_num').getValue();				// 사업자번호
	var customer_num = Ext.get('customer_num').getValue(); 		// 담당자번호
	var customer_name = Ext.get('customer_name').getValue();	// 담당자명
	var customer_name_len = getByteLength(customer_name);
	var customer_dept_len = getByteLength(Ext.get('customer_dept').getValue());	// 부서
	var customer_position_len = getByteLength(Ext.get('customer_position').getValue());	// 직위
	//var customer_mobile_len = getByteLength(Ext.get('customer_mobile').getValue());	// 핸드폰번호
	//var customer_telephone_len = getByteLength(Ext.get('customer_telephone').getValue());	// 전화번호
	//var customer_direct_len = getByteLength(Ext.get('customer_direct').getValue());	// 내선번호
	var customer_email_len = getByteLength(Ext.get('customer_email').getValue());	// E-Mail
	var customer_notice_len = getByteLength(Ext.get('customer_notice').getValue());	// 메모사항
	var note_len = getByteLength(Ext.get('note').getValue());	// 비고
	
	if(custom_code.length == 0 || custom_code == ""){
		Ext.Msg.alert('확인', '거래처코드를 조회해주세요.')
		return false;
	}
	
	if(custom_name.length == 0 || custom_name == ""){
		Ext.Msg.alert('확인', '거래처명을 입력해주세요.')
		return false;
	}
	
	if(custom_type.length == 0 || custom_type == ""){
		Ext.Msg.alert('확인', '거래처구분을 선택해주세요.')
		return false;
	}
	
	if(biz_num.length == 0 || biz_num == ""){
		Ext.Msg.alert('확인', '사업자번호를 입력해주세요.')
		return false;
	}
	
	// isValidBizNo(, this.value)
	
//	if(customer_num.length == 0 || customer_num == ""){
//		Ext.Msg.alert('확인', '담당자번호를 입력해주세요.')
//		return false;
//	}
	
	if(customer_name.length == 0 || customer_name == ""){
		Ext.Msg.alert('확인', '담당자명을 입력해주세요.')
		return false;
	}
	
	if(customer_name_len > 20){
		Ext.Msg.alert('확인', '담당자명은 한글 10자까지 입력가능합니다.')
		return false;
	}
	
	if(customer_dept_len > 30){
		Ext.Msg.alert('확인', '부서는 한글 15자까지 입력가능합니다.')
		return false;
	}
	
	if(customer_position_len > 30){
		Ext.Msg.alert('확인', '직위는 한글 15자까지 입력가능합니다.')
		return false;
	}
	
	if(customer_email_len > 30){
		Ext.Msg.alert('확인', 'E-Mail은 영문30자까지 입력가능합니다.')
		return false;
	}
	
	if(customer_notice_len > 1000){
		Ext.Msg.alert('확인', '메모사항은 한글500자까지 입력가능합니다.')
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
									<span id="ext-gen8" class="x-panel-header-text">거래처담당자 검색</span>
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
								<table border="0" width="100%"  style="font-size: 12px">
						    		<%-- 1 Row Start --%>
						    		<tr>
						    			<td width="15%">
											<div tabindex="-1" class="x-form-item " >
												<label class="x-form-item-label" style="width: auto; padding-left: 2px;" for="src_custom_name" >거래처 :</label>
												<div style="padding-left: 0px;" class="x-form-element">
													<input type="text" name="src_custom_name" id="src_custom_name" autocomplete="off" size="20" class=" x-form-text x-form-field" style="width: auto;">
												</div>
											</div>
										</td>
										<td width="2%">
											<div tabindex="-1" class="x-form-item " >
												<div style="padding-left: 0px;" class="x-form-element">
												
													<%-- 검색 버튼 Start --%>
													<table border="0" cellspacing="0" class="x-btn  x-btn-noicon" style="width: 30px;">
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
																		<button type="button" id="src_custom_btn" name="src_custom_btn" class="x-btn-text">검색</button>
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
													<%-- 검색 버튼 End	--%>
												
												</div>
											</div>
										</td>
										<td width="5%">
											<div tabindex="-1" class="x-form-item " >
												<div style="padding-left: 2px; " class="x-form-element">
													<input type="hidden" name="src_custom_code" id="src_custom_code" autocomplete="off" size="11" class=" x-form-text x-form-field" style="width: auto;">
												</div>
											</div>
										</td>
						    		
										<td width="24%">
											<div tabindex="-1" class="x-form-item " >
												<label class="x-form-item-label" style="width: auto;" for="src_pjt_id" >사업자번호 :</label>
												<div style="padding-left: 30px;" class="x-form-element">
													<input type="text" name="src_biz_num" id="src_biz_num" autocomplete="off" size="20" class=" x-form-text x-form-field" style="width: auto;">
												</div>
											</div>
										</td>
								
										<td width="20%">
											<div tabindex="-1" class="x-form-item " >
												<label class="x-form-item-label" style="width: auto;" for="src_est_type_code" >담당자명 :</label>
												<div style="padding-left: 30px;" class="x-form-element">
													<input type="text" name="src_customer_name" id="src_customer_name" autocomplete="off" size="20" class=" x-form-text x-form-field" style="width: auto;">
												</div>
											</div>
										</td>
										
										<td  width="14%" align="right">
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
			<td width="40%" valign="top">
				<div id="customMember-grid" style="margin-top: 0em;"></div><%-- 0em <- 1em으로 수정하면 상위 공백 --%>
			</td>
			<!------------------------------ GRID END ------------------------------------>
			<td width="60%" valign="top">
				<div class=" x-panel x-form-label-left" style="margin-top: 0em; width: 100%;"><%-- 0em <- 1em으로 수정하면 상위 공백 --%>
					<!----------------- SEARCH Hearder Start	 ----------------->
					<div class="x-panel-tl">
						<div class="x-panel-tr">
							<div class="x-panel-tc">
								<div class="x-panel-header x-unselectable" style="-moz-user-select: none;">
									<span class="x-panel-header-text">거래처 담당자 정보</span>
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
														<label class="x-form-item-label" style="width: auto;" for="est_type_code" ><font color="red">* </font>거래처코드:</label>
														<div style="padding-left: 107px;" class="x-form-element">
															<table style="width: 110px;" border="0" cellspacing="0" class="x-btn  x-btn-noicon">
																<tr>
																	<td>
																		<input type="text" name="custom_code" id="custom_code" title="거래처코드" autocomplete="off" size="13" class="x-form-text x-form-field " style="width: auto;">
																		<input type="hidden" name="flag" id="flag" autocomplete="off" size="1" class=" x-form-text x-form-field" style="width: auto;">
																	</td>
																	<td>
																		<%-- Button Start--%>
																		<div style="padding-left: 1px;" >
																			<img align="center" id="custom_btn" name="custom_btn" alt="" src="/resource/images/bass_1st/icon_src1.gif" style="cursor: hand;">
																		</div>
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
														<label class="x-form-item-label" style="width: auto;" for="est_date" ><font color="red">* </font>거래처명 :</label>
														<div style="padding-left: 91px;" class="x-form-element">
															<input type="text" name="custom_name" id="custom_name" autocomplete="off" size="22" class=" x-form-text x-form-field" style="width: auto;">
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
									<div class="x-column-inner" style="width: 100%; margin-top: 0.2em;">
										<div class=" x-panel x-column" style="width: 50%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label class="x-form-item-label" style="width: auto;" for="est_type_code" ><font color="red">* </font>거래처구분 :</label>
														<div style="padding-left: 107px;" class="x-form-element">
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
														<label class="x-form-item-label" style="width: auto;" for="est_date" ><font color="red">* </font>사업자번호:</label>
														<div style="padding-left: 91px;" class="x-form-element">
															<input type="text" name="biz_num" id="biz_num" autocomplete="off" size="22" class=" x-form-text x-form-field" style="width: auto;" onBlur="isValidBizNo(this, this.value)"/>
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
									<div class="x-column-inner" style="width: 100%; margin-top: 0.2em;">
										<div class=" x-panel x-column" style="width: 50%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label class="x-form-item-label" style="width: auto;" for="customer_num" >&nbsp;&nbsp;&nbsp;거래처담당자번호 :</label>
														<div style="padding-left: 80px;" class="x-form-element">
															<input type="text" name="customer_num" id="customer_num" autocomplete="off" size="15" class=" x-form-text x-form-field" style="width: auto;">
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
														<label class="x-form-item-label" style="width: auto;" for="customer_name" ><font color="red">* </font>거래처담당자명:</label>
														<div style="padding-left: 80px;" class="x-form-element">
															<input type="text" name="customer_name" id="customer_name" autocomplete="off" size="20" class=" x-form-text x-form-field" style="width: auto;">
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
									<div class="x-column-inner" style="width: 100%; margin-top: 0.2em;">
										<div class=" x-panel x-column" style="width: 50%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label class="x-form-item-label" style="width: auto;" for="customer_dept" >&nbsp;&nbsp;&nbsp;부서 :</label>
														<div style="padding-left: 107px;" class="x-form-element">
															<input type="text" name="customer_dept" id="customer_dept" autocomplete="off" size="17" class=" x-form-text x-form-field" style="width: auto;">
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
														<label class="x-form-item-label" style="width: auto;" for="customer_position" >&nbsp;&nbsp;&nbsp;직위 :</label>
														<div style="padding-left: 91px;" class="x-form-element">
															<input type="text" name="customer_position" id="customer_position" autocomplete="off" size="22" class=" x-form-text x-form-field" style="width: auto;">
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
									<div class="x-column-inner" style="width: 100%; margin-top: 0.2em;">
										<div class=" x-panel x-column" style="width: 50%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label class="x-form-item-label" style="width: auto;" for="customer_roll_code" >&nbsp;&nbsp;&nbsp;업무구분 :</label>
														<div style="padding-left: 80px;" class="x-form-element">
															<div style="padding-left: 27px;" class="x-form-element">
																<select name="customer_roll_code" id="customer_roll_code" title="업무구분" style="width: 44%;" type="text" class="x-form-select x-form-field" >
																	<option value="">전체</option>
																	<c:forEach items="${CUSTOMER_ROLL_CODE}" var="data" varStatus="status">
																	<option value="${data.COM_CODE}"><c:out value="${data.COM_CODE_NAME}"/></option>
																	</c:forEach>
																</select>
															</div>
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
														<label class="x-form-item-label" style="width: auto;" for="customer_mobile" >&nbsp;&nbsp;&nbsp;핸드폰번호 :</label>
														<div style="padding-left: 91px;" class="x-form-element">
															<input type="text" name="customer_mobile" id="customer_mobile" autocomplete="off" size="22" class=" x-form-text x-form-field" style="width: auto;">
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
									<div class="x-column-inner" style="width: 100%; margin-top: 0.2em;">
										<div class=" x-panel x-column" style="width: 50%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label class="x-form-item-label" style="width: auto;" for="customer_telephone" >&nbsp;&nbsp;&nbsp;전화번호 :</label>
														<div style="padding-left: 80px;" class="x-form-element">
															<input type="text" name="customer_telephone" id="customer_telephone" autocomplete="off" size="22" class=" x-form-text x-form-field" style="width: auto;">
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
														<label class="x-form-item-label" style="width: auto;" for="customer_direct" >&nbsp;&nbsp;&nbsp;내선번호 :</label>
														<div style="padding-left: 91px;" class="x-form-element">
															<input type="text" name="customer_direct" id="customer_direct" autocomplete="off" size="22" class=" x-form-text x-form-field" style="width: auto;">
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
									<div class="x-column-inner" style="width: 100%; margin-top: 0.2em;">
										<div class=" x-panel x-column" style="width: 50%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label class="x-form-item-label" style="width: auto;" for="est_date" >&nbsp;&nbsp;&nbsp;E-Mail:</label>
														<div style="padding-left: 80px;" class="x-form-element">
															<input type="text" name="customer_email" id="customer_email" autocomplete="off" size="22" class=" x-form-text x-form-field" style="width: auto;">
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
														<label class="x-form-item-label" style="width: auto;" for="customer_level" >&nbsp;&nbsp;&nbsp;담당자등급 :</label>
														<div style="padding-left: 91px;" class="x-form-element">
															<select name="customer_level" id="customer_level" title="담당자등급" style="width: 55%;" type="text" class="x-form-select x-form-field" >
																<option value="">전체</option>
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
									</div>
									<!-- DETAIL 8_ROW End -->
									
									<!-- DETAIL 9_ROW Start -->
									<div class="x-column-inner" style="width: 100%; margin-top: 0.2em;">
										<div class=" x-panel x-column" style="width: 100%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label class="x-form-item-label" style="width: auto;" for="customer_notice" >&nbsp;&nbsp;&nbsp;메모사항 :</label>
														<div style="padding-left: 83px;" class="x-form-element">
															<textarea name="customer_notice" id="customer_notice" autocomplete="off" style="width: 382px; height: 40px; left: 0px; top: 0px;" class="x-form-textarea x-form-field x-box-item"></textarea>
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
									<div class="x-column-inner" style="width: 100%; margin-top: 0.2em;">
										<div class=" x-panel x-column" style="width: 100%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label class="x-form-item-label" style="width: auto;" for="note" >&nbsp;&nbsp;&nbsp;비고 :</label>
														<div style="padding-left: 83px;" class="x-form-element">
															<textarea name="note" id="note" autocomplete="off" style="width: 382px; height: 40px; left: 0px; top: 0px;" class="x-form-textarea x-form-field x-box-item"></textarea>
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
									<div class="x-column-inner" style="width: 100%; margin-top: 0.2em;">
										<div class=" x-panel x-column" style="width: 100%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label style="padding-rigth: 100px;"  class="x-form-item-label" style="width: auto;" for="use_yn1" ><font color="red">* </font>사용여부:</label>
														<div style="padding-left: 83px;" class="x-form-element">
															<input type="radio" name="use_yn" id="use_yn1" autocomplete="off" class=" x-form-radio x-form-field" value="Y">
														    <label class="x-form-cb-label" for="use_yn2" >Yes</label>
														    <input type="radio" name="use_yn" id="use_yn2" autocomplete="off" class=" x-form-radio x-form-field" value="N">
														    <label class="x-form-cb-label" for="use_yn2" >No</label>
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
									<div class="x-column-inner" style="width: 100%; margin-top: 0.2em;  height: 34px;">
										<div class=" x-panel x-column" style="width: 50%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label class="x-form-item-label" style="width: auto;" for="final_mod_name" >&nbsp;&nbsp;&nbsp;최종변경자 :</label>
														<div style="padding-left: 80px;" class="x-form-element">
														    <input type="text" name="final_mod_name" id="final_mod_name" autocomplete="off" size="22" class=" x-form-text x-form-field" style="width: auto;" readonly>
															<input type="hidden" name="final_mod_id" id="final_mod_id" autocomplete="off" size="22" class=" x-form-text x-form-field" style="width: auto;" readonly>
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
														<label class="x-form-item-label" style="width: auto;" for="final_mod_date" >&nbsp;&nbsp;&nbsp;최종변경일시 :</label>
														<div style="padding-left: 91px;" class="x-form-element">
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