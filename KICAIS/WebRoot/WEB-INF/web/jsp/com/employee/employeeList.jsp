<%--
  Class Name  : employeeList.jsp
  Description : 사원정보관리
  Modification Information
 
      수정일              수정자                 수정내용
  -------      --------    ---------------------------
  2011. 2. 7.  고기범                 최초 생성
 
  author   : 고기범
  since    : 2011. 2. 7.
  version  : 1.0
   
  Copyright (C) 2011 by SG All right reserved.
--%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/web/jsp/sgis-top-inc.jsp" %>

<script type="text/javascript">
/***************************************************************************
 * 초기값 설정
 ***************************************************************************/
var gridTitle  = "사원정보관리";						// 그리드 Title
var gridHeigth = 400; 
var pageSize   = 14;

/***************************************************************************
 * Grid의 컬럼 설정
 ***************************************************************************/
var userColumns =  [
					{header: "상태",		    width: 100, sortable: true, dataIndex: 'FLAG', 			editor: new Ext.form.TextField({}) , hidden : true},       
					{header: "사번", 		width: 40,  sortable: true, dataIndex: 'EMP_NUM' 		editor: new Ext.form.TextField({}) , hidden : false},                                                    
					{header: "주민등록번호",  width: 100, sortable: true, dataIndex: 'SSN', 			editor: new Ext.form.TextField({}) , hidden : true},                  
					{header: "성명", 		width: 40,  sortable: true, dataIndex: 'KOR_NAME' , 	editor: new Ext.form.TextField({}) , hidden : false},
					{header: "영어성명", 		width: 50,  sortable: true, dataIndex: 'ENG_NAME' , 	editor: new Ext.form.TextField({}) , hidden : true},                  
					{header: "한자성명",		width: 50,  sortable: true, dataIndex: 'CHN_NAME' , 	editor: new Ext.form.TextField({}) , hidden : true},  
					{header: "부서", 		width: 50,  sortable: true, dataIndex: 'DEPT_NAME' , 	editor: new Ext.form.TextField({}) , hidden : false},
					{header: "부서코드", 		width: 50,  sortable: true, dataIndex: 'DEPT_CODE' , 	editor: new Ext.form.TextField({}) , hidden : true},                  
					{header: "직위",			width: 30,  sortable: true, dataIndex: 'POSTION_NAME' , editor: new Ext.form.TextField({}) , hidden : false},  
					{header: "직위코드",		width: 50,  sortable: true, dataIndex: 'POSTION_CODE' , editor: new Ext.form.TextField({}) , hidden : true},  
					{header: "직책",			width: 50,  sortable: true, dataIndex: 'DUTY_NAME' , 	editor: new Ext.form.TextField({}) , hidden : false},   
					{header: "직책코드",		width: 50,  sortable: true, dataIndex: 'DUTY_CODE' , 	editor: new Ext.form.TextField({}) , hidden : true},   
					{header: "휴대폰", 		width: 40,  sortable: true, dataIndex: 'MOBILE' , 		editor: new Ext.form.TextField({}) , hidden : true},                                                      
					{header: "집전화번호",  	width: 100, sortable: true, dataIndex: 'TEL_HOME' , 	editor: new Ext.form.TextField({}) , hidden : true},  
					{header: "사내전화번호", 	width: 50,  sortable: true, dataIndex: 'TEL_OFFICE' , 	editor: new Ext.form.TextField({}) , hidden : true},
					{header: "E-MAIL", 		width: 50,  sortable: true, dataIndex: 'EMAIL' ,	 	editor: new Ext.form.TextField({}) , hidden : true},                  
					{header: "우편번호",		width: 50,  sortable: true, dataIndex: 'ZIPCODE' , 		editor: new Ext.form.TextField({}) , hidden : true},  
					{header: "주소", 		width: 50,  sortable: true, dataIndex: 'ADDR' , 		editor: new Ext.form.TextField({}) , hidden : true},                  
					{header: "주소상세",		width: 50,  sortable: true, dataIndex: 'ADDR_DETAIL' , 	editor: new Ext.form.TextField({}) , hidden : true},  
					{header: "사진이미지",	width: 50,  sortable: true, dataIndex: 'PHOTO_IMG' , 	editor: new Ext.form.TextField({}) , hidden : true},
					{header: "사진파일경로",	width: 50,  sortable: true, dataIndex: 'PHOTO_PATH' , 	editor: new Ext.form.TextField({}) , hidden : true},   
					{header: "사용여부", 		width: 50,  sortable: true, dataIndex: 'USE_YN' , 		editor: new Ext.form.TextField({}) , hidden : false},  
					{header: "최종변경자ID", 	width: 100, sortable: true, dataIndex: 'FINAL_MOD_ID' , editor: new Ext.form.TextField({}) , hidden : true},  
					{header: "최종변경일시", 	width: 50,  sortable: true, dataIndex: 'FINAL_MOD_DATE',editor: new Ext.form.TextField({}) , hidden : true}
];	 

/***************************************************************************
 * 그리드 결과매핑 
 ***************************************************************************/
var mappingColumns = [ 
		{name: 'FLAG' 		    , allowBlank: false},     // 상태
		{name: 'EMP_NUM' 		, allowBlank: false},     // 사번               
		{name: 'SSN' 			, allowBlank: false},     // 주민등록번호           
		{name: 'KOR_NAME' 		, allowBlank: false},     // 한글성명          
		{name: 'ENG_NAME' 		, allowBlank: false},     // 영어성명          
		{name: 'CHN_NAME' 		, allowBlank: false},     // 한자성명          
		{name: 'DEPT_NAME' 		, allowBlank: false},     // 부서
		{name: 'DEPT_CODE' 		, allowBlank: false},     // 부서코드         
		{name: 'POSTION_NAME' 	, allowBlank: false},     // 직위
		{name: 'POSTION_CODE' 	, allowBlank: false},     // 직위코드         
		{name: 'DUTY_NAME' 		, allowBlank: false},     // 직책
		{name: 'DUTY_CODE' 		, allowBlank: false},     // 직책코드          
		{name: 'MOBILE' 		, allowBlank: false},     // 휴대폰              
		{name: 'TEL_HOME' 		, allowBlank: false},     // 집전화번호        
		{name: 'TEL_OFFICE' 	, allowBlank: false},     // 사내전화번호    
		{name: 'EMAIL' 			, allowBlank: false},     // E-MAIL               
		{name: 'ZIPCODE' 		, allowBlank: false},     // 우편번호           
		{name: 'ADDR' 			, allowBlank: false},     // 주소                  
		{name: 'ADDR_DETAIL' 	, allowBlank: false},     // 주소상세
		{name: 'PHOTO_IMG' 		, allowBlank: false},     // 사진이미지      
		{name: 'PHOTO_PATH' 	, allowBlank: false},     // 사진파일경로    
		{name: 'USE_YN' 		, allowBlank: false},     // 사용여부            
		{name: 'FINAL_MOD_ID' 	, allowBlank: false},     // 최종변경자ID  
		{name: 'FINAL_MOD_DATE' , allowBlank: false}      // 최종변경일시
    ];

/***************************************************************************
 * 그리드 클릭시 Event
 ***************************************************************************/
function fnGridOnClick(rowIndex){
	/***** 선택된 레코드에서 데이타 가져오기 *****/
	/***** 그리드에 선택된 값을 상세 필드에 설정 *****/
	
	Ext.get('flag').set({value : fnFixNull(store.getAt(rowIndex).data.FLAG) }, false);
	Ext.get('emp_num').set({value : fnFixNull(store.getAt(rowIndex).data.EMP_NUM), readOnly: true }, false);

	var ssn = 	fnFixNull(store.getAt(rowIndex).data.SSN);
	Ext.get('ssn1').set({value : ssn.substring(0,6) }, false);
	Ext.get('ssn2').set({value : ssn.substring(6,13) }, false);
	Ext.get('kor_name').set({value : fnFixNull(store.getAt(rowIndex).data.KOR_NAME) }, false);
	Ext.get('eng_name').set({value : fnFixNull(store.getAt(rowIndex).data.ENG_NAME) }, false);
	Ext.get('chn_name').set({value : fnFixNull(store.getAt(rowIndex).data.CHN_NAME) }, false);
	Ext.get('dept_code').set({value : fnFixNull(store.getAt(rowIndex).data.DEPT_CODE) }, false);
	Ext.get('postion_code').set({value : fnFixNull(store.getAt(rowIndex).data.POSTION_CODE) }, false);
	Ext.get('duty_code').set({value : fnFixNull(store.getAt(rowIndex).data.DUTY_CODE) }, false);
	Ext.get('mobile').set({value : fnFixNull(store.getAt(rowIndex).data.MOBILE) }, false);
	Ext.get('tel_home').set({value : fnFixNull(store.getAt(rowIndex).data.TEL_HOME) }, false);
	Ext.get('tel_office').set({value : fnFixNull(store.getAt(rowIndex).data.TEL_OFFICE) }, false);
	Ext.get('email').set({value : fnFixNull(store.getAt(rowIndex).data.EMAIL) }, false);
	
	var zipcode = fnFixNull(store.getAt(rowIndex).data.ZIPCODE);
	Ext.get('zipcode1').set({value : zipcode.substring(0,3) }, false);
	Ext.get('zipcode2').set({value : zipcode.substring(3,6) }, false);
	
	Ext.get('addr').set({value : fnFixNull(store.getAt(rowIndex).data.ADDR) }, false);
	Ext.get('addr_detail').set({value : fnFixNull(store.getAt(rowIndex).data.ADDR_DETAIL) }, false);
	
	var useYn =  fnFixNull(store.getAt(rowIndex).data.USE_YN);
	var use_yn1 = Ext.get('use_yn1');
	var use_yn2 = Ext.get('use_yn2');
	if(useYn == 'Y'){
		 use_yn1.set({checked : true }, false);
	}else if(useYn == 'N'){
		use_yn2.set({checked : true }, false);
	}
	
	var saveBtn = Ext.get('saveBtn');		// 등록버튼 비활성화
	saveBtn.set({ disabled: true}, false);
	
	var updateBtn = Ext.get('updateBtn');	// 수정버튼 활성화
	updateBtn.set({disabled:null}, false);
}   
 
/***************************************************************************
 * Event 및 필드 validation 설정
 ***************************************************************************/
/*
$(document).ready(function(){

	//검색하기 버튼 
	$('#searchBtn').click(function(){
		fnSearch();
		fnInitValue();
	});	
		
	//조건해제 버튼 -> 검색조건 초기화
	$('#searchClearBtn').click(function(){
		document.searchForm.reset();
	});	
			
	//신규 버튼 -> 상세필드 초기화
	$('#detailClearBtn').click(function(){
		fnInitValue();
	});		
			
	//등록 버튼 -> 데이터를 server로 전송
	$('#saveBtn').click(function(){
		if(Validator.validate(document.detailForm)){
			fnSave('저장');
			fnInitValue();
		};
	});
	
	//수정 버튼 -> 데이터를 server로 전송
	$('#updateBtn').click(function(){
		if(Validator.validate(document.detailForm)){
			fnSave('수정');
			fnInitValue();
		};
	});
	
	// 주소검색 버튼
	$('#addrBtn').click(function(){
		getPost(this,'addr',' ');
	});
	
	// 주민등록번호1
	$('#ssn1').numeric();					// 영문과 숫자중 숫자만 받는다.
	$('#ssn1').css("ime-mode","disabled");	// 한글입력을 받지않는다.
	
	// 주민등록번호1
	$('#ssn2').numeric();					// 영문과 숫자중 숫자만 받는다.
	$('#ssn2').css("ime-mode","disabled");	// 한글입력을 받지않는다.
	
	// 우편번호1
	$('#zipcode1').numeric();					// 영문과 숫자중 숫자만 받는다.
	$('#zipcode1').css("ime-mode","disabled");	// 한글입력을 받지않는다.
	
	// 우편번호2
	$('#zipcode2').numeric();					// 영문과 숫자중 숫자만 받는다.
	$('#zipcode2').css("ime-mode","disabled");	// 한글입력을 받지않는다.
	
 });
*/
/***************************************************************************
 * 설  명 : 검색
************************************************************************** */
function fnSearch(){  	
	
	
	
	Ext.Ajax.request({   
		url: "/com/employee/result.sg"
		,method : 'POST'   
		,success: handleSuccess   	// 조회결과 성공시
		,failure: handleFailure   	// 조회결과 실패시  
		,params : {					// 조회조건을 DB로 전송하기위해서 조건값 설정
					limit            : limit
				  , start            : start
				  ,	src_dept_name    : Ext.get('dept_name').getValue()//sForm.dept_name.value
				  , src_postion_code : Ext.get('searchPostion_code').getValue()//sForm.postion_code.value
				  , src_kor_name     : Ext.get('searchKor_name').getValue()//sForm.searchKor_name.value
				  }				
	});  

}  		

/***************************************************************************
 * 설  명 : 저장버튼 클릭
 ***************************************************************************/
function fnSave(str){  	
	
	if(confirm(str+"하시겠습니까?")){
	
		//var dForm = document.detailForm;	// 상세 FORM
		//var sForm = document.searchForm;	// 검색 FORM
		 
		Ext.Ajax.request({   
			url: "/com/employee/updateEmployee.sg"   
			,success: handleSuccess   	// 조회결과 성공시
			,failure: handleFailure   	// 조회결과 실패시  
			,form   : document.detailForm
			,method : 'POST'
			,params : {					// 조회조건을 DB로 전송하기위해서 조건값 설정
					  // 페이지정보
						limit        	 : limit
				  	  , start       	 : start
				  	  // 검색정보
					  ,	src_dept_name    : Ext.get('dept_name').getValue()//sForm.dept_name.value
					  , src_postion_code : Ext.get('searchPostion_code').getValue()//sForm.postion_code.value
					  , src_kor_name     : Ext.get('searchKor_name').getValue()//sForm.searchKor_name.value
					  }  		
		});  
	}
}  

/***************************************************************************
 * 설  명 : 화면 설정
 ***************************************************************************/
function fnInit(){
	
	// ExtJS 진입함수
	Ext.onReady(function() {
		// QuickTips 초기화
	    //Ext.QuickTips.init();
	    fnGrid();		// 그리드 Panel 생성
		//검색하기 버튼 
		Ext.get('searchBtn').on('click', function(){
			fnSearch();
			fnInitValue();
		});
		//조건해제 버튼 -> 검색조건 초기화
		Ext.get('searchClearBtn').on('click', function(){
			var formElement = Ext.get('searchForm').query("input[@type=text]");
			Ext.each(formElement, function() {
				this.value="";
			});
		});
		//신규 버튼 -> 상세필드 초기화
		Ext.get('detailClearBtn').on('click', function(){
			fnInitValue();
		});
		
		// 주소검색 버튼
		Ext.get('addrBtn').on('click', function(){
			getPost(this,'addr',' ');
		});
		
		
		//수정 버튼 -> 데이터를 server로 전송
		Ext.get('updateBtn').on('click', function(){
			if(Validator.validate(document.detailForm)){
				fnSave('수정');
				fnInitValue();
			};
		});
	
	});
	
	//fnInitValue();      // 버튼 초기화
}

/***************************************************************************
 * 설  명 : 필드 초기화
 **************************************************************************/
function fnInitValue(){
	//var dForm = document.detailForm;	// 상세 FORM	
	//dForm.reset();						// 상세필드 초기화
	//this.form.reset();

	//폼 리셋은 다시 확인해야함
	var formElement = Ext.get('detailForm').query("input[@type=text]");
	Ext.each(formElement, function() {
		this.value='';
	});
	
	
	
	Ext.get('detailForm').clean();
	Ext.get('emp_num').set({readOnly: null}, false);
	Ext.get('saveBtn').set({disabled: null}, false);
	Ext.get('updateBtn').set({disabled: true}, false);
	
}
	
/***************************************************************************
 * 설  명 : 그리드의 페이지 클릭시 검색조건값을 DB로 전송
 ***************************************************************************/
function fnPagingValue(){
	var sForm = document.searchForm;
	
	try{
    	store.setBaseParam('src_dept_name', Ext.get(dept_name).getValue());
    	store.setBaseParam('src_postion_code', Ext.get(searchPostion_code).getValue());
    	store.setBaseParam('src_kor_name',     Ext.get(searchKor_name).getValue());
    	store.setBaseParam('div', 'grid_page');
	}catch(e){

	}
}

</script>
<!-- 그리드 속성에 따라 다음의 JS 인클루드  -->
<script type="text/javascript" src="/resource/common/js/GridType_one.js"></script>
<!-- <script type="text/javascript" src="/resource/common/js/GridType_two.js"></script> -->
<!-- <script type="text/javascript" src="/resource/common/js/GridType_three.js"></script> -->
<!-- <script type="text/javascript" src="/resource/common/js/GridType_four.js"></script> -->

</head>
<body onload="fnInit()">
	<table border="0" width="900" height="200">
		<tr>
			<td colspan="2">
				<div class=" x-panel x-form-label-left" style="width: auto">
				<!----------------- SEARCH START	 ----------------->
					<form name="searchForm" id="searchForm" method="post" enctype="multipart/form-data">
						<div class="x-panel-tl">
						<div class="x-panel-tr">
							<div class="x-panel-tc">
								<div class="x-panel-header x-unselectable" style="-moz-user-select: none;">
									<center><span class="x-panel-header-text">사원 정보 검색</span></center>
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
								<td width="33%"><div tabindex="-1" class="x-form-item " >
									<div tabindex="-1" class="x-form-item " >
										<label class="x-form-item-label" style="width: auto;" for="dept_name" >부서명:</label>
										<div style="padding-left: 30px;" class="x-form-element">
											<input type="text" name="dept_name" id="dept_name" autocomplete="off" size="20" class=" x-form-text x-form-field" style="width: auto;">
										</div>
									</div>
								</td>
								
								<td width="33%"><div tabindex="-1" class="x-form-item " >
									<div tabindex="-1" class="x-form-item " >
										<label class="x-form-item-label" style="width: auto;" for="searchPostion_code" >직위:</label>
											<div style="padding-left: 80px;" class="x-form-element">
												<select name="dept_name" id="searchPostion_code" title="부서명" style="width: 100px;" type="text" class=" x-form-select x-form-field" >
													<option value="">전체</option>
													<c:forEach items="${POSITION_CODE}" var="data" varStatus="status">
													<option value="${data.COM_CODE}"><c:out value="${data.COM_CODE_NAME}"/></option>
													</c:forEach>
												</select>
											</div>
									</div>
								</td>
								<td width="33%"><div tabindex="-1" class="x-form-item " >
									<div tabindex="-1" class="x-form-item " >
										<label class="x-form-item-label" style="width: auto;" for="searchKor_name" >사원명:</label>
										<div style="padding-left: 30px;" class="x-form-element">
											<input type="text" name="searchKor_name" id="searchKor_name" autocomplete="off" size="5" class=" x-form-text x-form-field" style="width: auto;">
										</div>
									</div>
								</td>
								<!--
								<td width="20%">부서명</td>
								<td width="10%"><input type="text" id="dept_name" name="dept_name" style="width:100px"/></td>
								-->
								<!--
								<td width="20%">직위</td>
								<td width="20%">
									<select id="searchPostion_code" name="searchPostion_code" style="width:100px">
										<option value="">전체</option>
										<c:forEach items="${POSITION_CODE}" var="data" varStatus="status">
										<option value="${data.COM_CODE}"><c:out value="${data.COM_CODE_NAME}"/></option>
										</c:forEach>
									</select>
								</td>
								-->
								<!--
								<td width="20%">사원명</td>
								<td width="10%"><input type="text" id="searchKor_name" name="searchKor_name" style="width:100px"/></td>
								-->
							</tr>
							<tr align="right">
								<td colspan='3'>
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
								<td colspan='3'>
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
								<!--
								<td colspan="2">
									<input type="button" id="searchBtn" name="searchBtn" value="검색하기"/>
									<input type="button" id="searchClearBtn" name="searchClearBtn" value="조건해제"/>
								</td>
								-->
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
			<td width="100%" valign="top">
				<div id="user-grid"></div>
			</td>
			<!----------------- GRID END ----------------->
			<!----------------- DETAIL START ----------------->
			<td width="50%" valign="top">
				<div class=" x-panel x-form-label-left" style="width:100%;">
					<div class="x-panel-tl">
						<div class="x-panel-tr">
							<div class="x-panel-tc">
								<div class="x-panel-header x-unselectable" style="-moz-user-select: none;">
									<span class="x-panel-header-text">사원정보 상세등록</span>
								</div>
							</div>
						</div>
					</div>
					<div class="x-panel-bwrap" >
						<div class="x-panel-ml">
							<div class="x-panel-mr">
								<div class="x-panel-mc" >
									<!-- 폼 시작 -->
									<form id="detailForm" name="detailForm" method="POST" class="x-panel-body x-form" enctype="multipart/form-data" style="padding: 5px 5px 0pt; width: 480px; height: 
									365px;">

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

<!-- 일반 InputText 시작 -->
<div tabindex="-1" class="x-form-item " >
	<label class="x-form-item-label" style="width: auto;" for="emp_num" >사번:</label>
	<div style="padding-left: 80px;" class="x-form-element">
		<input type="text" name="emp_num" id="emp_num" autocomplete="off" size="5" class=" x-form-text x-form-field" style="width: auto;">
	</div>
	<div class="x-form-clear-left"></div>
</div>
<input type="hidden" id="flag" name="flag"/>
<!-- 일반 InputText 끝 -->

<!-- 컬럼 시작 -->
<div class="x-column-inner" style="width: 100%;">

<!-- 첫번째 컬럼 시작 -->
<div class=" x-panel x-column" style="width: 50%;">
	<div class="x-panel-bwrap" >
		<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
			<div tabindex="-1" class="x-form-item " >
				<label class="x-form-item-label" style="width: auto;" for="ssn1" >주민번호:</label>
				<div style="padding-left: 80px;" class="x-form-element">
					<input type="text" name="ssn1" id="ssn1" autocomplete="off" size="7" class=" x-form-text x-form-field" style="width: auto;"> -
					<input type="text" name="ssn2" id="ssn2" autocomplete="off" size="7" class=" x-form-text x-form-field" style="width: auto;">
				</div>
				<div class="x-form-clear-left">
				</div>
			</div>
			<div tabindex="-1" class="x-form-item " >
				<label class="x-form-item-label" style="width: auto;" for="eng_name" >영문이름:</label>
				<div style="padding-left: 80px;;" class="x-form-element">
					<input type="text" name="eng_name" id="eng_name" autocomplete="off" size="21" class=" x-form-text x-form-field" style="auto;">
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
				<label class="x-form-item-label" style="width: auto;" for="kor_name" >한글이름:</label>
				<div style="padding-left: 80px;" class="x-form-element">
					<input type="text" name="kor_name" id="kor_name" autocomplete="off" size="22" class=" x-form-text x-form-field" style="width: auto;">
				</div>
				<div class="x-form-clear-left">
				</div>
			</div>
			<div tabindex="-1" class="x-form-item ">
				<label class="x-form-item-label" style="width: auto;" for="chn_name" >한자이름:</label>
				<div style="padding-left: 80px;" class="x-form-element">
					<input type="text" name="chn_name" id="chn_name" autocomplete="off" size="22" class=" x-form-text x-form-field" style="width: auto;">
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

<!-- 콤보박스 시작 -->
<div tabindex="-1" class="x-form-item " >
	<label class="x-form-item-label" style="width: auto;" for="ext-comp-1002" >부서코드:</label>
		<div style="padding-left: 80px;" class="x-form-element">
			<select name="dept_code" id="dept_code" title="부서코드" style="width: 29%;" type="text" class=" x-form-select x-form-field" >
						<option value="">선택하세요</option>
					<c:forEach items="${DEPT_CODE}" var="data" varStatus="status">
						<option value="${data.COM_CODE}"><c:out value="${data.COM_CODE_NAME}"/></option>
					</c:forEach>
			</select>
		</div>
</div>
<!-- 콤보박스 끝 -->


<!-- 컬럼 시작 -->
<div class="x-column-inner" style="width: 100%;">
	
<!-- 첫번째 컬럼 시작 -->
<div class=" x-panel x-column" style="width: 50%;">
	<div class="x-panel-bwrap" >
		<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
			<!-- 직위 코드 콤보박스 Left 1 -->
			<div tabindex="-1" class="x-form-item " >
				<label class="x-form-item-label" style="width: 75px;" for="ext-comp-1002" >직위코드:</label>
					<div style="padding-left: 80px;" class="x-form-element">
						<select name="postion_code" id="postion_code" title="직위코드" style="width: 58%;" type="text" class=" x-form-select x-form-field" >
									<option value="">선택하세요</option>
									<c:forEach items="${POSITION_CODE}" var="data" varStatus="status">
									<option value="${data.COM_CODE}"><c:out value="${data.COM_CODE_NAME}"/></option>
									</c:forEach>
						</select>
					</div>
			</div>
			
			<!-- 집전화 Left 2 -->
			<div tabindex="-1" class="x-form-item " >
				<label class="x-form-item-label" style="width: 75px;" for="tel_home" >집전화:</label>
				<div style="padding-left: 80px;" class="x-form-element">
					<input type="text" name="tel_home" id="tel_home" autocomplete="off" size="21" class=" x-form-text x-form-field" style="width:auto;">
				</div>
				<div class="x-form-clear-left"></div>
			</div>
			
			<!-- 내선번호 Left 3 -->
			<div tabindex="-1" class="x-form-item " >
				<label class="x-form-item-label" style="width: 75px;" for="tel_office" >내선번호:</label>
				<div style="padding-left: 80px;" class="x-form-element">
					<input type="text" name="tel_office" id="tel_office" autocomplete="off" size="21" class=" x-form-text x-form-field" style="width:auto;">
				</div>
				<div class="x-form-clear-left"></div>
			</div>
			
		</div>
	</div>
</div>
<!-- 첫번째 컬럼 끝 -->
<!-- 두번째 컬럼 시작 -->
<div class=" x-panel x-column" style="width: 50%;">
	<div class="x-panel-bwrap" >
		<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
			
			<!-- 직책 코드 콤보박스 Right 1 -->
			<div tabindex="-1" class="x-form-item " >
				<label class="x-form-item-label" style="width: 75px;" for="duty_code" >직책코드:</label>
					<div style="padding-left: 80px;" class="x-form-element">
						<select name="duty_code" id="duty_code" title="직책코드" style="width: 58%;" type="text" class=" x-form-select x-form-field" >
									<option value="">선택하세요</option>
								<c:forEach items="${DEPT_CODE}" var="data" varStatus="status">
									<option value="${data.COM_CODE}"><c:out value="${data.COM_CODE_NAME}"/></option>
								</c:forEach>
						</select>
					</div>
			</div>
			
			<!-- 휴대전화 Right 2 -->
			<div tabindex="-1" class="x-form-item " >
				<label class="x-form-item-label" style="width: 75px;" for="mobile" >휴대전화:</label>
				<div style="padding-left: 80px;" class="x-form-element">
					<input type="text" name="mobile" id="mobile" autocomplete="off" size="22" class=" x-form-text x-form-field" style="width:auto;">
				</div>
				<div class="x-form-clear-left"></div>
			</div>
			
			<!-- 이메일 Right 3 -->
			<div tabindex="-1" class="x-form-item " >
				<label class="x-form-item-label" style="width: 75px;" for="email" >사번:</label>
				<div style="padding-left: 80px;" class="x-form-element">
					<input type="text" name="email" id="email" autocomplete="off" size="22" class=" x-form-text x-form-field" style="width:auto;">
				</div>
				<div class="x-form-clear-left"></div>
			</div>
			
		</div>
	</div>
</div>
<!-- 두번째 컬럼 끝 -->

</div>
<!-- 컬럼 끝 -->

<!-- 자택 주소 시작 -->
<div tabindex="-1" class="x-form-item " id="ext-gen28">
	<label class="x-form-item-label" style="width: 75px;" for="ext-comp-1005">자택주소:</label>
	<div style="padding-left: 80px;" class="x-form-element">
<table cellspacing="0" class="x-table-layout">
	<tbody>
		<tr>
			<td>
				<input type="text" name="zipcode1" id="zipcode1" autocomplete="off" size="20" class=" x-form-text x-form-field" style="width: 45px;"> -
				<input type="text" name="zipcode2" id="zipcode2" autocomplete="off" size="20" class=" x-form-text x-form-field" style="width: 45px;">
			</td>
			<td>
				<i>&nbsp;</i>
			</td>
			<td class="x-table-layout-cell" >
					<table cellspacing="0" class="x-btn  x-btn-noicon" style="width: auto;">
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
										<button type="button" class=" x-btn-text" id='addrBtn' name='addrBtn'>주소찾기</button>
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
			</td>
			<td>
				<i>&nbsp;</i>
			</td>
			<td>
				<input type="text" name="addr" id="addr" autocomplete="off" size="20" class=" x-form-text x-form-field" style="width:auto;">
			</td>
		</tr>
		<tr>
			
			<td colspan="5">
				<input type="text" name="addr_detail" id="addr_detail"size="20" class=" x-form-text x-form-field" style="width:315px;">
			</td>
		</tr>
	</tbody>
</table>
		
	</div>
	<div class="x-form-clear-left"></div>
</div>
<!-- 자택 주소 끝 -->

<!-- 사용 여부 시작 -->
<!-- 라디오 버튼 필드 시작 -->
<div tabindex="-1" class="x-form-item ">
	<label class="x-form-item-label" style="width: 110px;" for="ext-comp-1026" >사용여부:</label>
	<div style="padding-left: 115px;" id="x-form-el-ext-comp-1026" class="x-form-element">
		<div class=" x-form-radio-group x-column-layout-ct x-form-field" style="width: 431px;">
			<div class="x-column-inner" style="width: 431px;">
				
<!-- 첫번째 라디오 버튼-->	
				<div class=" x-column" style="width: 86px;">
					<div tabindex="-1" class="x-form-item  x-hide-label" >
						<label class="x-form-item-label" style="width: 100px;" for="ext-comp-1037" ></label>
						<div style="padding-left: 105px;" id="x-form-el-ext-comp-1037" class="x-form-element">
							<div class="x-form-check-wrap" style="width: 86px;">
								<input type="radio" name="use_yn" id="use_yn1" autocomplete="off" class=" x-form-radio x-form-field" value="Y">
								<label class="x-form-cb-label" for="use_yn1" >Yes</label>
							</div>
						</div>
						<div class="x-form-clear-left">
						</div>
					</div>
				</div>
<!-- 두번번째 라디오 버튼-->
				<div class=" x-column" style="width: 86px;">
					<div tabindex="-1" class="x-form-item  x-hide-label" >
						<label class="x-form-item-label" style="width: 100px;" for="ext-comp-1039" ></label>
						<div style="padding-left: 105px;" id="x-form-el-ext-comp-1039" class="x-form-element">
							<div class="x-form-check-wrap" style="width: 86px;">
								<input type="radio" name="use_yn" id="use_yn2" autocomplete="off" class=" x-form-radio x-form-field" value="N">
								<label class="x-form-cb-label" for="use_yn2" >No</label>
							</div>
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
<!-- 사용 여부 끝 -->
									
								</div>
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
		</form>
	</table>
</body>
	<div id="user-detail"></div>

<%@ include file="/WEB-INF/web/jsp/sgis-bottom-inc.jsp" %>
