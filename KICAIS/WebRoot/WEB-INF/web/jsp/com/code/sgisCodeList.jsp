<%--
  Class Name  : sgisCodeList.jsp
  Description : 공통코드관리
  Modification Information
 
      수정일              수정자                 수정내용
  -------      --------    ---------------------------
  2011. 3. .   여인범                 최초 생성
 
  author   : 여인범
  since    : 2011. 3.  .
  version  : 1.0
   
  Copyright (C) 2011 by SG All right reserved.
--%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>

<script type="text/javascript" src="/resource/common/js/grid/grid_1st.js"></script>
<script type="text/javascript">
var	gridHeigth_1st 	 	= 370; 						// 그리드 전체 높이
var	gridWidth_1st		= 490;						// 그리드 전체 폭
var	gridTitle_1st  	= "공통코드 관리"; 
var	render_1st		=	"render_grid_1st";
var pageSize_1st	=	13;
var limit_1st		=	pageSize_1st;
var start_1st		=	0;
var proxyUrl_1st	= 	"/com/sgisCode/result_1st.sg";


// Grid의 컬럼 설정
var userColumns_1st =  [{header:"상태"			, width:   0, sortable: true, dataIndex: 'FLAG' 	  	  , editor: new Ext.form.TextField({}) , hidden : true},
						{header:"그룹코드"		, width: 150, sortable: true, dataIndex: 'GROUP_CODE' 	  , editor: new Ext.form.TextField({}) , hidden : false},
						{header:"코드"			, width:  50, sortable: true, dataIndex: 'COM_CODE'       , editor: new Ext.form.TextField({}) , hidden : false},
						{header:"참조값1"		, width: 100, sortable: true, dataIndex: 'REF_VAL_01'     , editor: new Ext.form.TextField({}) , hidden : true}, 
						{header:"참조명1"		, width: 100, sortable: true, dataIndex: 'REF_NAME_01'    , editor: new Ext.form.TextField({}) , hidden : true}, 
						{header:"참조값2"		, width:  50, sortable: true, dataIndex: 'REF_VAL_02'     , editor: new Ext.form.TextField({}) , hidden : true}, 
						{header:"참조명2"		, width: 100, sortable: true, dataIndex: 'REF_NAME_02'    , editor: new Ext.form.TextField({}) , hidden : true}, 
						{header:"참조값3"		, width:  50, sortable: true, dataIndex: 'REF_VAL_03'     , editor: new Ext.form.TextField({}) , hidden : true}, 
						{header:"참조명3"		, width: 100, sortable: true, dataIndex: 'REF_NAME_03'    , editor: new Ext.form.TextField({}) , hidden : true}, 
						{header:"참조값4"		, width:  50, sortable: true, dataIndex: 'REF_VAL_04'     , editor: new Ext.form.TextField({}) , hidden : true}, 
						{header:"참조명4"		, width:  50, sortable: true, dataIndex: 'REF_NAME_04'    , editor: new Ext.form.TextField({}) , hidden : true}, 
						{header:"참조값5"		, width:  50, sortable: true, dataIndex: 'REF_VAL_05'     , editor: new Ext.form.TextField({}) , hidden : true}, 
						{header:"참조명5"		, width:  50, sortable: true, dataIndex: 'REF_NAME_05'    , editor: new Ext.form.TextField({}) , hidden : true}, 
						{header:"시스템코드여부"	, width:  50, sortable: true, dataIndex: 'SYSTEM_CODE_YN' , editor: new Ext.form.TextField({}) , hidden : false},
						{header:"사용여부"		, width:  50, sortable: true, dataIndex: 'USE_YN'         , editor: new Ext.form.TextField({}) , hidden : false},
						{header:"코드명"			, width: 100, sortable: true, dataIndex: 'COM_CODE_NAME'  , editor: new Ext.form.TextField({}) , hidden : false},
						{header:"최종변경자ID"	, width:  50, sortable: true, dataIndex: 'FINAL_MOD_ID'   , editor: new Ext.form.TextField({}) , hidden : true}, 
						{header:"최종변경일시"	, width: 100, sortable: true, dataIndex: 'FINAL_MOD_DATE' , editor: new Ext.form.TextField({}) , hidden : true}, 
						{header:"정렬번호"		, width:  50, sortable: true, dataIndex: 'SORT_NUM'       , editor: new Ext.form.TextField({}) , hidden : true}  
					];   

// 결과필드를 매핑
var mappingColumns_1st = [ {name: 'FLAG'	           , allowBlank: false},  //상태
                 		   {name: 'GROUP_CODE'         , allowBlank: false},  //코드                                           
						   {name: 'COM_CODE'           , allowBlank: false},  //그룹코드                                       
						   {name: 'REF_VAL_01'         , allowBlank: false},  //참조값1                                        
						   {name: 'REF_NAME_01'        , allowBlank: false},  //참조명1                                        
						   {name: 'REF_VAL_02'         , allowBlank: false},  //참조값2                                        
						   {name: 'REF_NAME_02'        , allowBlank: false},  //참조명2                                        
						   {name: 'REF_VAL_03'         , allowBlank: false},  //참조값3                                        
						   {name: 'REF_NAME_03'        , allowBlank: false},  //참조명3                                        
						   {name: 'REF_VAL_04'         , allowBlank: false},  //참조값4                                        
						   {name: 'REF_NAME_04'        , allowBlank: false},  //참조명4                                        
						   {name: 'REF_VAL_05'         , allowBlank: false},  //참조값5                                        
						   {name: 'REF_NAME_05'        , allowBlank: false},  //참조명5                                        
						   {name: 'SYSTEM_CODE_YN'     , allowBlank: false},  //시스템코드여부                                 
						   {name: 'USE_YN'             , allowBlank: false},  //사용여부                                       
						   {name: 'COM_CODE_NAME'      , allowBlank: false},  //코드명                                         
						   {name: 'FINAL_MOD_ID'       , allowBlank: false},  //최종변경자ID                                   
						   {name: 'FINAL_MOD_DATE'     , allowBlank: false},  //최종변경일시                                   
						   {name: 'SORT_NUM'           , allowBlank: false}   //정렬번호        
		    			 ];
     
 // 선택된 레코드에서 데이타 가져오기
function fnGridOnClick_1st(store, rowIndex){	
	var f = document.detailForm;

	var flag	       =  fnFixNull(store.getAt(rowIndex).data.FLAG); 
	var com_code       =  fnFixNull(store.getAt(rowIndex).data.COM_CODE);             
	var group_code     =  fnFixNull(store.getAt(rowIndex).data.GROUP_CODE);          
	var ref_val_01     =  fnFixNull(store.getAt(rowIndex).data.REF_VAL_01);          
	var ref_name_01    =  fnFixNull(store.getAt(rowIndex).data.REF_NAME_01);         
	var ref_val_02     =  fnFixNull(store.getAt(rowIndex).data.REF_VAL_02);          
	var ref_name_02    =  fnFixNull(store.getAt(rowIndex).data.REF_NAME_02);         
	var ref_val_03     =  fnFixNull(store.getAt(rowIndex).data.REF_VAL_03);          
	var ref_name_03    =  fnFixNull(store.getAt(rowIndex).data.REF_NAME_03);         
	var ref_val_04     =  fnFixNull(store.getAt(rowIndex).data.REF_VAL_04);          
	var ref_name_04    =  fnFixNull(store.getAt(rowIndex).data.REF_NAME_04);         
	var ref_val_05     =  fnFixNull(store.getAt(rowIndex).data.REF_VAL_05);          
	var ref_name_05    =  fnFixNull(store.getAt(rowIndex).data.REF_NAME_05);         
	var system_code_yn =  fnFixNull(store.getAt(rowIndex).data.SYSTEM_CODE_YN);      
	var use_yn         =  fnFixNull(store.getAt(rowIndex).data.USE_YN);              
	var com_code_name  =  fnFixNull(store.getAt(rowIndex).data.COM_CODE_NAME);       
	var final_mod_id   =  fnFixNull(store.getAt(rowIndex).data.FINAL_MOD_ID);        
	var final_mod_date =  fnFixNull(store.getAt(rowIndex).data.FINAL_MOD_DATE);      
	var sort_num       =  fnFixNull(store.getAt(rowIndex).data.SORT_NUM);    
		
		f.flag.value			=  flag;			//상태 
		f.com_code.value		=  com_code;		//코드           
		f.group_code.value      =  group_code;      //그룹코드       
		f.ref_val_01.value      =  ref_val_01;      //참조값1        
		f.ref_name_01.value     =  ref_name_01;     //참조명1        
		f.ref_val_02.value      =  ref_val_02;      //참조값2        
		f.ref_name_02.value     =  ref_name_02;     //참조명2        
		f.ref_val_03.value      =  ref_val_03;      //참조값3        
		f.ref_name_03.value     =  ref_name_03;     //참조명3        
		f.ref_val_04.value      =  ref_val_04;      //참조값4        
		f.ref_name_04.value     =  ref_name_04;     //참조명4        
		f.ref_val_05.value      =  ref_val_05;      //참조값5        
		f.ref_name_05.value     =  ref_name_05;     //참조명5        
		f.system_code_yn.value  =  system_code_yn;  //시스템코드여부 
		f.com_code_name.value   =  com_code_name;   //코드명         
		f.final_mod_id.value    =  final_mod_id;    //최종변경자ID   
		f.final_mod_date.value  =  final_mod_date;  //최종변경일시   
		f.sort_num.value        =  sort_num;        //정렬번호   
				
	// 사용여부
	if(use_yn == 'Y'){
		 f.use_yn[0].checked = true;
		 f.use_yn.value = "Y";
	}else if(use_yn == 'N'){
		f.use_yn[1].checked = true;
		f.use_yn.value = "N";
	}
	
	// 시스템여부
	if(system_code_yn == 'Y'){
		 f.system_code_yn[0].checked = true;
		 f.system_code_yn.value = "Y";
	}else if(system_code_yn == 'N'){
		f.system_code_yn[1].checked = true;
		f.system_code_yn.value = "N";
	}
	
	Ext.get('saveBtn').dom.disabled    = true;
	Ext.get('updateBtn').dom.disabled  = false; 
	
	
	Ext.get('com_code').dom.disabled  = true; 
	Ext.get('group_code').dom.disabled  = true;
	
}   
 
/***************************************************************************
 * 설  명 : 화면 설정
 ***************************************************************************/
// ExtJS 진입함수
Ext.onReady(function() {
			
	var sForm = document.searchForm;
	//QuickTips 초기화
    //Ext.QuickTips.init();

	//검색하기 버튼 
	Ext.get('searchBtn').on('click', function(){
		fnSearch();
		fnInitValue();
	});
	//조건해제 버튼 -> 검색조건 초기화
	Ext.get('searchClearBtn').on('click', function(){
		sForm.reset();		
	});
	//신규 버튼 -> 상세필드 초기화
	Ext.get('detailClearBtn').on('click', function(){
		fnInitValue();
		Ext.get('com_code').dom.disabled    = false; 
		Ext.get('group_code').dom.disabled  = false;
		Ext.get('flag').set({value : 'I'}, false);  
	});
	 
	
	//수정 버튼 -> 데이터를 server로 전송
	Ext.get('updateBtn').on('click', function(){
		if(Validator.validate(document.detailForm)){  
			Ext.MessageBox.confirm('Confirm', '수정하시겠습니까?', showResult);
		};
	});
	
	//등록 버튼 -> 데이터를 server로 전송
	Ext.get('saveBtn').on('click', function(e){	
		if(Validator.validate(document.detailForm)){
			Ext.MessageBox.confirm('Confirm', '저장하시겠습니까?', showResult);
		};
	});
	
	fnInitValue(); 

});

// 저장, 수정버튼 클릭시 '예','아니오' 
function showResult(btn){
   	if(btn == 'yes'){
   		fnSave();
   	}    	
};

function showSearchPanel(targetUrl){
	searchPanel.toggleCollapse();
	searchPanel.removeAll();
	searchPanel.load({
		url: targetUrl,
		scripts:true
	});
}



/***************************************************************************
 * 설  명 : 필드 초기화
 **************************************************************************/
function fnInitValue(){
	var dForm = document.detailForm;	// 상세 FORM	
	dForm.reset();						// 상세필드 초기화 
	 
	Ext.get('saveBtn').dom.disabled    	  = false;
	Ext.get('updateBtn').dom.disabled  	  = true;
	 
	document.detailForm.use_yn[0].checked = true;	
	document.detailForm.system_code_yn[1].checked = true;
	
	document.detailForm.final_mod_id.value="${admin_nm}";
	document.detailForm.final_mod_date.value=getTimeStamp().trim();
		
}


/***************************************************************************
 * 함수명 : fnSearch
 * 설  명 : 검색
***************************************************************************/
 
function fnSearch(){  	
	Ext.Ajax.request({   
		url: "/com/sgisCode/result_1st.sg"
		,method : 'POST'   
		,success: function(response){
			var json = Ext.util.JSON.decode(response.responseText);
			this.GridClass_1st.store.loadData(json)
		}
		,failure: handleFailure   	   // 조회결과 실패시  
		,form   : document.searchForm  // 검색 FORM
		,params : {					   // 조회조건을 DB로 전송하기위해서 조건값 설정
					limit          : limit_1st
				  , start          : start_1st
				  }				
	});  
	fnInitValue(); // 상세필드 초기화
}  	
	 
/***************************************************************************
 * 함수명 : 저장
 * 설  명 : 저장버튼 클릭시 호출
 * 인  자 : 
 * 리  턴 : 
 -------------------------------------------------------------------------
 사용법: buttons의 handler에 fnSave를 넣어준다.
 사용예:	,handler	: fnSave
 -------------------------------------------------------------------------
 참  조: 
***************************************************************************/
function fnSave(){  	
		var dForm=document.detailForm;
		
		if(dForm.group_code.value==""){
			SGAlert("확인", "그룹코드를 입력 해 주세요");
			dForm.group_code.focus();
	    	return false;
		}
		if(dForm.com_code.value==""){
			SGAlert("확인", "코드를 입력 해 주세요");
			dForm.com_code.focus();
	    	return false;
		}
		if(dForm.com_code_name.value==""){
			SGAlert("확인", "코드명을  입력 해 주세요");
			dForm.com_code_name.focus();
	    	return false;
		}
	
		Ext.get('group_code').dom.disabled	= false;
		Ext.get('com_code').dom.disabled  	= false;
	
		Ext.Ajax.request({   
		url: "/com/sgisCode/actionSgisCode.sg"   
		,success: function(response){
				handleSuccess(response,GridClass_1st,'save');
				
				//var json = Ext.util.JSON.decode(response.responseText);
				//this.GridClass_1st.store.loadData(json)
			}   	    
		,failure: handleFailure   	    // 조회결과 실패시  
		,form   : dForm   				// 상세 FORM
		,params : { 
				  
					limit        	: limit_1st
			  	  , start       	: start_1st 
				  // 검색조건
				  , src_group_code  : Ext.get('src_group_code').getValue()	
				  , src_com_code 	: Ext.get('src_com_code').getValue()
				  
			      } 
		});  
		 
	fnInitValue();
}



 

//페이징 버튼 이동 시 검색 조건 파람에 담기
function fnPagingValue_1st(){
	
	var form = document.searchForm;	
	try{
    	GridClass_1st.store.setBaseParam('src_group_code', form.src_group_code.value);
    	GridClass_1st.store.setBaseParam('src_com_code', form.src_com_code.value);
    	GridClass_1st.store.setBaseParam('srcKoreanYn', 'exit');										//검색 value 한글 처리를 위한 필수 변수
	}catch(e){ 
		return false;
	}
	
}
 
</script>
<!-- 그리드 속성에 따라 다음의 JS 인클루드  -->



<body>
	<table border="0" width="1000" height="200">
		<tr>
			<td colspan="2">
				<!----------------- SEARCH START	 ----------------->
				<div class=" x-panel x-form-label-left" style="width: auto">
				<!----------------- SEARCH START	 ----------------->
					<form name="searchForm" id="searchForm" method="post" >
						<div class="x-panel-tl">
						<div class="x-panel-tr">
							<div class="x-panel-tc">
								<div class="x-panel-header x-unselectable" style="-moz-user-select: none;">
									<center><span class="x-panel-header-text">공통코드 조회</span></center>
								</div>
							</div>
						</div>
					</div>
						<div class="x-panel-bwrap" >
						<div class="x-panel-ml">
							<div class="x-panel-mr">
								<div class="x-panel-mc" >
						<table border="0" width="100%"  style="font-size: 12px">
							<tr>
								<td width="43%"><div tabindex="-1" class="x-form-item " >
									<div tabindex="-1" class="x-form-item " >
										<label class="x-form-item-label" style="width: auto;" for="src_group_code" >그룹코드:</label>
										<div style="padding-left: 30px;" class="x-form-element">
											<input type="text" name="src_group_code" id="src_group_code" autocomplete="off" size="25" class=" x-form-text x-form-field" style="width: auto;">
										</div>
									</div>
								</td>
								<td  width="43%"><div tabindex="-1" class="x-form-item " >
									<div tabindex="-1" class="x-form-item " >
										<label class="x-form-item-label" style="width: auto;" for="src_com_code" >코드:</label>
										<div style="padding-left: 30px;" class="x-form-element">
											<input type="text" name="src_com_code" id="src_com_code" autocomplete="off" size="25" class=" x-form-text x-form-field" style="width: auto;">
										</div>
									</div>
								</td>
								<td colspan="2"></td>
								<td align="right">
									<div tabindex="-1" class="x-form-item " >
										<table cellspacing="0" class="x-btn  x-btn-noicon" style="width: 50px;">
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
									</div>
								</td>
								<td>
									<div tabindex="-1" class="x-form-item " >
										<table cellspacing="0" class="x-btn  x-btn-noicon" style="width: width: 50px;;">
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
									</div>
								</td>
							</tr>
						</table>
						</div>
						</div>
						</div>
						</div>
					</form>
				</div>
				<!----------------- SEARCH END	 ----------------->
			</td>
		</tr>
		<tr>
			<!----------------- GRID START ----------------->
			<td width="40%" valign="top">
				<div id="render_grid_1st"></div>
			</td>
			<!----------------- GRID END ----------------->
			<!----------------- DETAIL START ----------------->
			<td width="60%" valign="top">
				<div class=" x-panel x-form-label-left" style="width:100%;">
				
					<div class="x-panel-tl">
						<div class="x-panel-tr">
							<div class="x-panel-tc">
								<div class="x-panel-header x-unselectable" style="-moz-user-select: none;">
									<center><span class="x-panel-header-text">공통코드 상세내용</span></center>
								</div>
							</div>
						</div>
					</div>
					<div class="x-panel-bwrap" >
						<div class="x-panel-ml">
							<div class="x-panel-mr">
								<div class="x-panel-mc" >
									<form name="detailForm" id='detailForm'  method="POST" class="x-panel-body x-form" style="padding: 5px 5px 0pt; width: 480px; height: 340px;">
						 			<input type="hidden" id="flag" name="flag"/>
					 <table border="0" width="100%" style="font-size: 12px" >
						<tr>
							<td colspan="4" align="right">
								<!-- 신규 버튼 시작 -->
								<div tabindex="-1" class="x-form-item " >
									<table cellspacing="0" class="x-btn  x-btn-noicon" style="width: 75px;">
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
							</td>
						</tr>
						<tr>
							<td>
<!-- 컬럼 시작 -->
<div class="x-column-inner" style="width: 100%;">

<!-- 첫번째 컬럼 시작 -->
<div class=" x-panel x-column" style="width: 50%;">
	<div class="x-panel-bwrap" >
		<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
			<div tabindex="-1" class="x-form-item " >
				<label class="x-form-item-label" style="width: auto;" for="group_code" ><font color="red">* </font>그룹코드:</label>
				<div style="padding-left: 80px;" class="x-form-element">
					<input type="text" name="group_code" id="group_code" autocomplete="off" size="25" class=" x-form-text x-form-field" style="width: auto;">
				</div>
				<div class="x-form-clear-left">
				</div>
			</div>
			<div tabindex="-1" class="x-form-item " >
				<label class="x-form-item-label" style="width: auto;" for="com_code_name" ><font color="red">* </font>코드명:</label>
				<div style="padding-left: 80px;;" class="x-form-element">
					<input type="text" name="com_code_name" id="com_code_name" autocomplete="off" size="25" class=" x-form-text x-form-field" style="auto;">
				</div>
				<div class="x-form-clear-left">
				</div>
			</div>
			<div tabindex="-1" class="x-form-item " >
				<label class="x-form-item-label" style="width: auto;" for="ref_val_01" >&nbsp;&nbsp;&nbsp;참조값1:</label>
				<div style="padding-left: 80px;;" class="x-form-element">
					<input type="text" name="ref_val_01" id="ref_val_01" autocomplete="off" size="25" class=" x-form-text x-form-field" style="auto;">
				</div>
				<div class="x-form-clear-left">
				</div>
			</div>
			<div tabindex="-1" class="x-form-item " >
				<label class="x-form-item-label" style="width: auto;" for="ref_val_02" >&nbsp;&nbsp;&nbsp;참조값2:</label>
				<div style="padding-left: 80px;;" class="x-form-element">
					<input type="text" name="ref_val_02" id="ref_val_02" autocomplete="off" size="25" class=" x-form-text x-form-field" style="auto;">
				</div>
				<div class="x-form-clear-left">
				</div>
			</div>
			<div tabindex="-1" class="x-form-item " >
				<label class="x-form-item-label" style="width: auto;" for="ref_val_03" >&nbsp;&nbsp;&nbsp;참조값3:</label>
				<div style="padding-left: 80px;;" class="x-form-element">
					<input type="text" name="ref_val_03" id="ref_val_03" autocomplete="off" size="25" class=" x-form-text x-form-field" style="auto;">
				</div>
				<div class="x-form-clear-left">
				</div>
			</div>
			<div tabindex="-1" class="x-form-item " >
				<label class="x-form-item-label" style="width: auto;" for="ref_val_04" >&nbsp;&nbsp;&nbsp;참조값4:</label>
				<div style="padding-left: 80px;;" class="x-form-element">
					<input type="text" name="ref_val_04" id="ref_val_04" autocomplete="off" size="25" class=" x-form-text x-form-field" style="auto;">
				</div>
				<div class="x-form-clear-left">
				</div>
			</div>
			<div tabindex="-1" class="x-form-item " >
				<label class="x-form-item-label" style="width: auto;" for="ref_val_05" >&nbsp;&nbsp;&nbsp;참조값5:</label>
				<div style="padding-left: 80px;;" class="x-form-element">
					<input type="text" name="ref_val_05" id="ref_val_05" autocomplete="off" size="25" class=" x-form-text x-form-field" style="auto;">
				</div>
				<div class="x-form-clear-left">
				</div>
			</div>
			<div tabindex="-1" class="x-form-item " >
				<!-- 라디오 버튼 필드 시작 -->
				<div tabindex="-1" class="x-form-item ">
					<label class="x-form-item-label" style="width: 80px;"><font color="red">* </font>시스템여부:</label>
					<div style="padding-left: 10px;" class="x-form-element">
						<div class=" x-form-radio-group x-column-layout-ct x-form-field" style="width: 70px;">
							<div class="x-column-inner" style="width: 70px;">
								
				<!-- 첫번째 라디오 버튼-->	
								<div class=" x-column" style="width: 70px;">
									<div tabindex="-1" class="x-form-item  x-hide-label" >
											<div class="x-form-check-wrap" style="width: 70px;">
												<input type="radio" name="system_code_yn" id="system_code_yn1" autocomplete="off" class=" x-form-radio x-form-field" value="Y">
												<label class="x-form-cb-label" for="use_yn1" >예</label>
											</div>
										<div class="x-form-clear-left">
										</div>
									</div>
								</div>
				<!-- 두번번째 라디오 버튼-->
								<div class=" x-column" style="width: 100px;">
									<div tabindex="-1" class="x-form-item  x-hide-label" >
										
											<div class="x-form-check-wrap" style="width: 100px;">
												<input type="radio" name="system_code_yn" id="system_code_yn2" autocomplete="off" class=" x-form-radio x-form-field" value="N">
												<label class="x-form-cb-label" for="use_yn2" >아니오</label>
											</div>
										
										<div class="x-form-clear-left">
										</div>
									</div>
								</div>
								
								<div class="x-clear" ></div>
							</div>
						</div>
					</div>
					<div class="x-form-clear-left">
					</div>
				</div>
				<!-- 라디오 버튼 필드 끝 -->
			</div>
			<div tabindex="-1" class="x-form-item " >
				<label class="x-form-item-label" style="width: auto;" for="final_mod_id" >최종변경자:</label>
				<div style="padding-left: 80px;;" class="x-form-element">
					<input type="text" name="final_mod_id" id="final_mod_id" autocomplete="off" size="25" class=" x-form-text x-form-field" style="auto;" readonly="readonly">
				</div>
				<div class="x-form-clear-left">
				</div>
			</div>
		</div>
	</div>
</div>
<!-- 첫번째 컬럼 끝 -->
<!-- 두번째 컬럼 시작 -->
<div class=" x-panel x-column" style="width: 50%;">
	<div class="x-panel-bwrap" >
		<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
			<div tabindex="-1" class="x-form-item " >
				<label class="x-form-item-label" style="width: auto;" for="com_code" ><font color="red">&nbsp;&nbsp;* </font>코드:</label>
				<div style="padding-left: 80px;" class="x-form-element">
					<input type="text" name="com_code" id="com_code" autocomplete="off" size="25" class=" x-form-text x-form-field" style="width: auto;">
				</div>
				<div class="x-form-clear-left">
				</div>
			</div>
			<div tabindex="-1" class="x-form-item ">
				<label class="x-form-item-label" style="width: auto;" for="sort_num" >&nbsp;&nbsp;&nbsp;정렬순서:</label>
				<div style="padding-left: 80px;" class="x-form-element">
					<input type="text" name="sort_num" id="sort_num" autocomplete="off" size="25" class=" x-form-text x-form-field" style="width: auto;">
				</div>
				<div class="x-form-clear-left">
				</div>
			</div>
			<div tabindex="-1" class="x-form-item ">
				<label class="x-form-item-label" style="width: auto;" for="ref_name_01" >&nbsp;&nbsp;&nbsp;참조명1:</label>
				<div style="padding-left: 80px;" class="x-form-element">
					<input type="text" name="ref_name_01" id="ref_name_01" autocomplete="off" size="25" class=" x-form-text x-form-field" style="width: auto;">
				</div>
				<div class="x-form-clear-left">
				</div>
			</div>
			<div tabindex="-1" class="x-form-item ">
				<label class="x-form-item-label" style="width: auto;" for="ref_name_02" >&nbsp;&nbsp;&nbsp;참조명2:</label>
				<div style="padding-left: 80px;" class="x-form-element">
					<input type="text" name="ref_name_02" id="ref_name_02" autocomplete="off" size="25" class=" x-form-text x-form-field" style="width: auto;">
				</div>
				<div class="x-form-clear-left">
				</div>
			</div>
			<div tabindex="-1" class="x-form-item ">
				<label class="x-form-item-label" style="width: auto;" for="ref_name_03" >&nbsp;&nbsp;&nbsp;참조명3:</label>
				<div style="padding-left: 80px;" class="x-form-element">
					<input type="text" name="ref_name_03" id="ref_name_03" autocomplete="off" size="25" class=" x-form-text x-form-field" style="width: auto;">
				</div>
				<div class="x-form-clear-left">
				</div>
			</div>
			<div tabindex="-1" class="x-form-item ">
				<label class="x-form-item-label" style="width: auto;" for="ref_name_04" >&nbsp;&nbsp;&nbsp;참조명4:</label>
				<div style="padding-left: 80px;" class="x-form-element">
					<input type="text" name="ref_name_04" id="ref_name_04" autocomplete="off" size="25" class=" x-form-text x-form-field" style="width: auto;">
				</div>
				<div class="x-form-clear-left">
				</div>
			</div>
			<div tabindex="-1" class="x-form-item ">
				<label class="x-form-item-label" style="width: auto;" for="ref_name_05" >&nbsp;&nbsp;&nbsp;참조명5:</label>
				<div style="padding-left: 80px;" class="x-form-element">
					<input type="text" name="ref_name_05" id="ref_name_05" autocomplete="off" size="25" class=" x-form-text x-form-field" style="width: auto;">
				</div>
				<div class="x-form-clear-left">
				</div>
			</div>
			<div tabindex="-1" class="x-form-item ">
				<!-- 라디오 버튼 필드 시작 -->
				<div tabindex="-1" class="x-form-item ">
					<label class="x-form-item-label" style="width: 80px;"><font color="red">* </font>사용여부:</label>
					<div style="padding-left: 10px;" class="x-form-element">
						<div class=" x-form-radio-group x-column-layout-ct x-form-field" style="width: 70px;">
							<div class="x-column-inner" style="width: 70px;">
								
				<!-- 첫번째 라디오 버튼-->	
								<div class=" x-column" style="width: 70px;">
									<div tabindex="-1" class="x-form-item  x-hide-label" >
											<div class="x-form-check-wrap" style="width: 70px;">
												<input type="radio" name="use_yn" id="use_yn1" autocomplete="off" class=" x-form-radio x-form-field" value="Y">
												<label class="x-form-cb-label" for="use_yn1" >예</label>
											</div>
										<div class="x-form-clear-left">
										</div>
									</div>
								</div>
				<!-- 두번번째 라디오 버튼-->
								<div class=" x-column" style="width: 100px;">
									<div tabindex="-1" class="x-form-item  x-hide-label" >
										
											<div class="x-form-check-wrap" style="width: 100px;">
												<input type="radio" name="use_yn" id="use_yn2" autocomplete="off" class=" x-form-radio x-form-field" value="N">
												<label class="x-form-cb-label" for="use_yn2" >아니오</label>
											</div>
										
										<div class="x-form-clear-left">
										</div>
									</div>
								</div>
								
								<div class="x-clear" ></div>
							</div>
						</div>
					</div>
					<div class="x-form-clear-left">
					</div>
				</div>
				<!-- 라디오 버튼 필드 끝 -->
			</div>
			<div tabindex="-1" class="x-form-item ">
				<label class="x-form-item-label" style="width: auto;" for="final_mod_date" >최종변경일자:</label>
				<div style="padding-left: 80px;" class="x-form-element">
					<input type="text" name="final_mod_date" id="final_mod_date" autocomplete="off" size="25" class=" x-form-text x-form-field" style="width: auto;" readonly="readonly">
				</div>
				<div class="x-form-clear-left">
				</div>
			</div>
		</div>
	</div>
</div>
<!-- 두번째 컬럼 끝 -->
</div>
<!-- 컬럼 끝 -->
</td>
</tr>
					</table>				
				</form>
				</div>
				</div>
				</div>
				</div>
			</td>
			<!----------------- DETAIL END ----------------->
		</tr>
		<tr>
			<td colspan="2" align="center">
				<input type="button" id="saveBtn" name="saveBtn" value="등록" />
				<input type="button" id="updateBtn" name="updateBtn" value="수정" />
			</td>
		</tr>
	</table>
	
	
<%@ include file="/WEB-INF/web/jsp/sgis-bottom-inc.jsp" %>
