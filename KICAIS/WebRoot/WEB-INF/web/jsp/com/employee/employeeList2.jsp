<%--
  Class Name  : employeeList.jsp
  Description : 사원정보관리
  Modification Information
 
      수정일              수정자                 수정내용
  -------      --------    ---------------------------
  2011. 2. 7.  고기범              최초 생성
  2011. 4. 1.  고기범              스크립트 수정(버튼 Event 및 저장수정)
 
  author   : 고기범
  since    : 2011. 2. 7.
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
var LogCon;

<c:set var="data" value="${fn:split(groups, ',')}" />
<c:forEach items="${data}" var="group" varStatus="i">
	<c:choose>
    	<c:when test="${group == 'G001' || group == 'G002'}">
    		LogCon="";
    	</c:when>
    	<c:otherwise>
    		LogCon="${admin_id}";
    	</c:otherwise>
    </c:choose> 
</c:forEach> 

/***************************************************************************
 * 초기값 설정
 ***************************************************************************/
var	gridHeigth_1st	=	"370";
var	gridWidth_1st  	;
var	gridTitle_1st   =	"사원정보관리"; 
var	render_1st		=	"render_grid_1st";
var pageSize_1st	=	13;
var limit_1st		=	pageSize_1st;
var start_1st		=	0;
var proxyUrl_1st	= "/com/employee/result_1st.sg?Lsrc_emp_num="+LogCon;

/***************************************************************************
 * Grid의 컬럼 설정
 ***************************************************************************/
var userColumns_1st =  [
					{header: "상태",		    width: 100, sortable: true, dataIndex: 'FLAG', 			editor: new Ext.form.TextField({}) , hidden : true},       
					{header: "사번", 		width: 40,  sortable: true, dataIndex: 'EMP_NUM' },
					{header: "비번", 		width: 60,  sortable: true, dataIndex: 'ADMIN_PW', 		hidden : true},
					 
					{header: "주민등록번호",	width: 100, sortable: true, dataIndex: 'SSN', 			editor: new Ext.form.TextField({}) , hidden : true},                  
					{header: "성명", 		width: 40,  sortable: true, dataIndex: 'KOR_NAME' , 	editor: new Ext.form.TextField({})},
					{header: "영어성명", 	width: 50,  sortable: true, dataIndex: 'ENG_NAME' , 	editor: new Ext.form.TextField({}) , hidden : true},                  
					{header: "한자성명",		width: 50,  sortable: true, dataIndex: 'CHN_NAME' , 	editor: new Ext.form.TextField({}) , hidden : true},  
					{header: "부서", 		width: 60,  sortable: true, dataIndex: 'DEPT_NAME' , 	editor: new Ext.form.TextField({}) },
					{header: "부서코드", 	width: 50,  sortable: true, dataIndex: 'DEPT_CODE' , 	editor: new Ext.form.TextField({}) , hidden : true},                  
					{header: "직위",			width: 30,  sortable: true, dataIndex: 'POSTION_NAME' , editor: new Ext.form.TextField({}) },  
					{header: "직위코드",		width: 50,  sortable: true, dataIndex: 'POSTION_CODE' , editor: new Ext.form.TextField({}) , hidden : true},  
					{header: "직책",			width: 50,  sortable: true, dataIndex: 'DUTY_NAME' , 	editor: new Ext.form.TextField({}) },   
					{header: "직책코드",		width: 50,  sortable: true, dataIndex: 'DUTY_CODE' , 	editor: new Ext.form.TextField({}) , hidden : true},   
					{header: "휴대폰", 		width: 60,  sortable: true, dataIndex: 'MOBILE' , 		editor: new Ext.form.TextField({}) },                                                      
					{header: "집전화번호",  	width: 50, 	sortable: true, dataIndex: 'TEL_HOME' , 	editor: new Ext.form.TextField({}) , hidden : true},  
					{header: "사내전화번호",	width: 50,  sortable: true, dataIndex: 'TEL_OFFICE' , 	editor: new Ext.form.TextField({}) , hidden : true},
					{header: "E-MAIL", 		width: 50,  sortable: true, dataIndex: 'EMAIL' ,	 	editor: new Ext.form.TextField({}) , hidden : true},                  
					{header: "우편번호",		width: 50,  sortable: true, dataIndex: 'ZIPCODE' , 		editor: new Ext.form.TextField({}) , hidden : true},  
					{header: "주소", 		width: 50,  sortable: true, dataIndex: 'ADDR' , 		editor: new Ext.form.TextField({}) , hidden : true},                  
					{header: "주소상세",		width: 50,  sortable: true, dataIndex: 'ADDR_DETAIL' , 	editor: new Ext.form.TextField({}) , hidden : true},  
					{header: "사진이미지",	width: 50,  sortable: true, dataIndex: 'PHOTO_IMG' , 	editor: new Ext.form.TextField({}) , hidden : true},
					{header: "사진파일경로",	width: 50,  sortable: true, dataIndex: 'PHOTO_PATH' , 	editor: new Ext.form.TextField({}) , hidden : true},   
					{header: "사용여부", 	width: 50,  sortable: true, dataIndex: 'USE_YN' , 		editor: new Ext.form.TextField({}) },  
					{header: "최종변경자ID",	width: 100, sortable: true, dataIndex: 'FINAL_MOD_ID' , editor: new Ext.form.TextField({}) , hidden : true},  
					{header: "최종변경일시",	width: 50,  sortable: true, dataIndex: 'FINAL_MOD_DATE',editor: new Ext.form.TextField({}) , hidden : true},
					{header: "ID", 			width: 60,  sortable: true, dataIndex: 'ID', 			hidden : true}
					 
];	 

/***************************************************************************
 * 그리드 결과매핑 
 ***************************************************************************/
var mappingColumns_1st = [ 
		{name: 'FLAG' 		    , allowBlank: false},     // 상태
		{name: 'EMP_NUM' 		, allowBlank: false},     // 사번       
		{name: 'ADMIN_PW' 		, allowBlank: false},      
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
		{name: 'FINAL_MOD_DATE' , allowBlank: false},     // 최종변경일시
		{name: 'ID' 			, allowBlank: false} 
    ];

/***************************************************************************
 * 그리드 클릭시 Event
 ***************************************************************************/
function fnGridOnClick_1st(store, rowIndex){
	Ext.get('flag').set({value : fnFixNull(store.getAt(rowIndex).data.FLAG) }, false);
	Ext.get('emp_num').set({value : fnFixNull(store.getAt(rowIndex).data.EMP_NUM), readOnly: true }, false);
	Ext.get('id').set({value : fnFixNull(store.getAt(rowIndex).data.EMP_NUM), readOnly: true }, false);
	
	Ext.get('passwd').set({value : fnFixNull(store.getAt(rowIndex).data.ADMIN_PW), readOnly: false }, false);

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
	
	//Ext.get('id').set({value : fnFixNull(store.getAt(rowIndex).data.ID) }, false);
	
	var zipcode = fnFixNull(store.getAt(rowIndex).data.ZIPCODE);
	Ext.get('zipcode1').set({value : zipcode.substring(0,3) }, false);
	Ext.get('zipcode2').set({value : zipcode.substring(3,6) }, false);
	
	Ext.get('addr').set({value : fnFixNull(store.getAt(rowIndex).data.ADDR) }, false);
	Ext.get('addr_detail').set({value : fnFixNull(store.getAt(rowIndex).data.ADDR_DETAIL) }, false);
	
	var useYn =  fnFixNull(store.getAt(rowIndex).data.USE_YN);
	
	var dForm = document.detailForm;
	
	// 사용여부
	if(useYn == 'Y'){
		 dForm.use_yn[0].checked = true;
	}else if(useYn == 'N'){
		 dForm.use_yn[1].checked = true;
	}
	
	Ext.get('saveBtn').dom.disabled    = true;
	Ext.get('updateBtn').dom.disabled  = false;
}   
 
 
/***************************************************************************
 * 설  명 : 검색
************************************************************************** */
function fnSearch(){
	
	Ext.Ajax.request({   
		url: "/com/employee/result_1st.sg"
		,method : 'POST'   
		,success: function(response){
				  	// 조회된 결과값, store명
					handleSuccess(response,GridClass_1st);
				}
		   	// 조회결과 성공시
		,failure: handleFailure   	// 조회결과 실패시  
		,form   : document.searchForm  // 검색 FORM
		,params : {					// 조회조건을 DB로 전송하기위해서 조건값 설정
					limit            : limit_1st
				  , start            : start_1st
				  }				
	});  

}  		

/***************************************************************************
 * 설  명 : 저장버튼 클릭
 ***************************************************************************/
function fnSave(){ 
	 
		Ext.Ajax.request({   
		url: "/com/employee/updateEmployee.sg"   
		,success: function(response){						// 조회결과 성공시
					// 조회된 결과값, store명
					<c:forEach items="${data}" var="group" varStatus="i">
						<c:choose>
					    	<c:when test="${group == 'G001' || group == 'G002'}">
					    		handleSuccess(response,GridClass_1st,'save');
					    	</c:when> 
					    </c:choose> 
					</c:forEach> 
		          }
		,failure: handleFailure   	    // 조회결과 실패시  
		,form   : document.detailForm   // 상세 FORM
		,params : { 
				   // 페이지정보
					limit        	 : limit_1st
			  	  , start       	 : start_1st
			  	  // 검색정보
				  ,	src_dept_name    : Ext.get('src_dept_name').getValue()
				  , src_postion_code : Ext.get('src_postion_code').getValue()
				  , src_kor_name     : Ext.get('src_kor_name').getValue() 
			      } 
		});  
		
	 
	
	fnInitValue();
}  

/***************************************************************************
 * 설  명 : 화면 설정
 ***************************************************************************/
// ExtJS 진입함수
Ext.onReady(function() {
			
	var sForm = document.searchForm; 

	//검색하기 버튼 
	Ext.get('searchBtn').on('click', function(){
		fnSearch();
	});
	//조건해제 버튼 -> 검색조건 초기화
	Ext.get('searchClearBtn').on('click', function(){
		sForm.reset(); 
		fnSearch();
	});

	
	<c:forEach items="${data}" var="group" varStatus="i">	 
		<c:choose>
	    	<c:when test="${group == 'G001' || group == 'G002'}">
	    		//신규 버튼 -> 상세필드 초기화
				Ext.get('detailClearBtn').on('click', function(){
					fnInitValue();
				});
	    	</c:when>
	    </c:choose> 
	</c:forEach>  
	
	
	// 주소검색 버튼
	Ext.get('addrBtn').on('click', function(){
		getPost(this,'addr',' ');
		//loadSearchPanel('test','/sgportal/post/searchZipForm.sg');
		//showSearchPanel('/sgportal/post/searchZipForm.sg');
	});
	
	//수정 버튼 -> 데이터를 server로 전송
	Ext.get('updateBtn').on('click', function(){
		if(fnValidation()){
			if(Ext.get('passwd').getValue() != "" && Ext.get('passwd').getValue() != Ext.get('re_passwd').getValue()){
				Ext.Msg.alert('확인', '비밀번호를 확인해주세요!');
			 	return false;
			}
			  
			Ext.MessageBox.confirm('Confirm', '수정하시겠습니까?', showResult);
		}
	});
	
	//등록 버튼 -> 데이터를 server로 전송
	Ext.get('saveBtn').on('click', function(e){	
		if(fnValidation()){
			Ext.MessageBox.confirm('Confirm', '저장하시겠습니까?', showResult);
		};
	});
	
//	// 아이디 체크
//	Ext.get('overLapCheckBtn').on('click', function(e){	
//		jf_idCheck();
//	});
	
	fnInitValue();

});

function fnValidation(){
	
	var emp_num = Ext.get('emp_num').getValue();			// 사번
	var passwd = Ext.get('passwd').getValue();				// 비밀번호
	var ssn1 = Ext.get('ssn1').getValue();					// 주민번호
	var ssn2 = Ext.get('ssn2').getValue();					// 주민번호
	var kor_name = Ext.get('kor_name').getValue();			// 한글이름
	var dept_code = Ext.get('dept_code').getValue();		// 부서
	var postion_code = Ext.get('postion_code').getValue();	// 직위
	var duty_code = Ext.get('duty_code').getValue();		// 직책
	var email = Ext.get('email').getValue();				// 이메일
	
	var emp_num_len = getByteLength(emp_num);				// 사번
	var passwd_len = getByteLength(passwd);					// 비밀번호
	var email_len = getByteLength(email);					// 이메일
	
	if(emp_num.length == 0 || emp_num == ""){
		Ext.Msg.alert('확인', '사번을 입력해주세요.')
		return false;
	}
	
	if(emp_num_len > 10){
		Ext.Msg.alert('확인', '사번은 (한글 5자, 영문 10자)까지 입력가능합니다.')
		return false;
	}
	
	if(passwd.length == 0 || passwd == ""){
		Ext.Msg.alert('확인', '비밀번호를 입력해주세요.')
		return false;
	}
	
	if(passwd_len > 20){
		Ext.Msg.alert('확인', '비밀번호는 (한글 10자, 영문 20자)까지 입력가능합니다.')
		return false;
	}
/*	
	if(ssn1.length == 0 || ssn1 == ""){
		Ext.Msg.alert('확인', '주민번호를 입력해주세요.')
		return false;
	}else if(ssn1.length < 6){
		Ext.Msg.alert('확인', '주민번호를 확인해주세요.')
		return false;
	}
	
	if(ssn2.length == 0 || ssn2 == ""){
		Ext.Msg.alert('확인', '주민번호를 입력해주세요.')
		return false;
	}else if(ssn2.length < 7){
		Ext.Msg.alert('확인', '주민번호를 확인해주세요.')
		return false;
	}
*/	
	if(kor_name.length == 0 || kor_name == ""){
		Ext.Msg.alert('확인', '한글이름을 입력해주세요.')
		return false;
	}
	
	if(dept_code.length == 0 || dept_code == ""){
		Ext.Msg.alert('확인', '부서를 선택해주세요.')
		return false;
	}
	
	if(postion_code.length == 0 || postion_code == ""){
		Ext.Msg.alert('확인', '직위를 선택해주세요.')
		return false;
	}
	
	if(duty_code.length == 0 || duty_code == ""){
		Ext.Msg.alert('확인', '직책을 선택해주세요.')
		return false;
	}

	if(email.length > 0){

		if(!isEmail(email)){
			Ext.Msg.alert('확인', '이메일형식이 틀립니다.')
			return false;
		}
				
		if(email_len > 50){
			Ext.Msg.alert('확인', '이메일은 (한글 25자, 영문 50자)까지 입력가능합니다.')
			return false;
		}
	}
	
	
	
	return true;
}

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
	
	Ext.get('emp_num').set({readOnly: null}, false);
	Ext.get('saveBtn').dom.disabled    	  = false;
	Ext.get('updateBtn').dom.disabled  	  = true;
	
	dForm.use_yn[0].checked = true; 
	
}
	
/***************************************************************************
 * 설  명 : 그리드의 페이지 클릭시 검색조건값을 DB로 전송
 ***************************************************************************/
function fnPagingValue_1st(){
	try{
    	GridClass_1st.store.setBaseParam('src_dept_name', 	 Ext.get('src_dept_name').getValue());
    	GridClass_1st.store.setBaseParam('src_postion_code', Ext.get('src_postion_code').getValue());
    	GridClass_1st.store.setBaseParam('src_kor_name',     Ext.get('src_kor_name').getValue());
		GridClass_1st.store.setBaseParam('start', 			 start_1st);
		GridClass_1st.store.setBaseParam('limit', 			 limit_1st);
		GridClass_1st.store.setBaseParam('Lsrc_emp_num', 	 Lsrc_emp_num);
	}catch(e){

	}
}


function jf_pwChage(admin_id){
	var url = '/core/manage/suser/pwChange.sg?'+admin_id;
	window.open(url, 'pwChage', 'width=300, height=200');
}



	var blockClick2 =  false;
	function jf_idCheck() {

		if(document.detailForm.id.value != ""){
		    var url="/core/manage/suser/userAjaxIdCheck.sg";
		    queryString = "admin_id="+document.detailForm.id.value;
		
		    if(blockClick2) {
		        //return;
		    }
		
		    blockClick2 = true;
		
		    httpRequest("POST", url, queryString, true, jf_idCheckInfo);
	    }else{

	    	Ext.Msg.alert('아이디 확인', '로그인 아이디를 입력하세요');  
	    	document.detailForm.id.focus();
	    }
	}

var jf_idCheckInfo = function() {
		if( ajax.readyState==4 ) {
			if (ajax.status == 200) {
				var idCheck = ajax.responseText;
				var id = idCheck.split("||");
				
				if(id[1] == "0"){
					Ext.Msg.alert('확인', "["+document.detailForm.id.value+"] 아이디는  등록할수있는 아이디 입니다.");  
					document.detailForm.idcheck.value = "0";
				}else {
					Ext.Msg.alert('확인', "["+document.detailForm.id.value+"] 아이디는 이미 등록되어있는 아이디 입니다."); 
					document.detailForm.id.value="";
					document.detailForm.idcheck.value = "1";
				}
				
				
	            blockClick = false;
			}else{
				blockClick = false;
			}
	 	}
	}
</script>

<body>
	<table border="0" width="1000" height="200">
<c:forEach items="${data}" var="group" varStatus="i">
	<c:choose>
   		<c:when test="${group == 'G001' || group == 'G002'}">

			<tr>
				<td colspan="2">
					<form name="searchForm">
					<!----------------- SEARCH Hearder Start	 ----------------->
					<div id="ext-comp-1002" class=" x-panel x-form-label-left" style="margin-top: 0em;"><%-- 0em <- 1em으로 수정하면 상위 공백 --%>
						<div class="x-panel-tl">
							<div class="x-panel-tr">
								<div class="x-panel-tc">
									<div id="ext-gen4" class="x-panel-header x-unselectable" style="-moz-user-select: none;">
										<span id="ext-gen8" class="x-panel-header-text">사원정보 검색</span>
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
											<td width="27%">
												<div tabindex="-1" class="x-form-item " >
													<label class="x-form-item-label" style="width: auto;" for="src_dept_name">부서명 :</label>
													<div style="padding-left: 30px;" class="x-form-element">
														<input type="text" name="src_dept_name" id="src_dept_name" autocomplete="off" size="15" class="x-form-text x-form-field" style="width: auto;">													
													</div>
												</div>
											</td>
											
											<td colspan="3" width="27%">
												<div tabindex="-1" class="x-form-item " >
													<label class="x-form-item-label" style="width: auto;" for="src_postion_code" >직위 :</label>
													<div style="padding-left: 30px;" class="x-form-element">
														<select name="src_postion_code" id="src_postion_code" style="width: 35%;" type="text" class=" x-form-select x-form-field" >
															<option value="">전체</option>
															<c:forEach items="${POSITION_CODE}" var="data" varStatus="status">
															<option value="${data.COM_CODE}"><c:out value="${data.COM_CODE_NAME}"/></option>
															</c:forEach>
														</select>
													</div>
												</div>
											</td>
											
											<td width="27%">
												<div tabindex="-1" class="x-form-item " >
													<label class="x-form-item-label" style="width: auto;" for="src_kor_name" >사원명 :</label>
													<div style="padding-left: 80px;" class="x-form-element">
														<input type="text" name="src_kor_name" id="src_kor_name" autocomplete="off" size="15" class="x-form-text x-form-field" style="width: auto;">
													</div>
												</div>
											</td>
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
		</c:when>
    	<c:otherwise>
    		 <input type="hidden" name="src_dept_name" id="src_dept_name" />
    		 <input type="hidden" name="src_postion_code" id="src_postion_code" />
    		 <input type="hidden" name="src_kor_name" id="src_kor_name" />
    		 <input type="hidden" name="searchBtn" id="searchBtn" /> 
    		 <input type="hidden" name="searchClearBtn" id="searchClearBtn" />  
    	</c:otherwise>
    </c:choose> 
</c:forEach> 
		
		
		<tr>
			<!------------------------------ GRID START ---------------------------------->
			<td width="50%" valign="top">
				<div id="render_grid_1st" style="margin-top: 0em;"></div><%-- 0em <- 1em으로 수정하면 상위 공백 --%><!----------------- 그리드명을 동일하게 설정 ----------------->		
			</td>
			<!------------------------------ GRID END ------------------------------------>
			<td width="50%" valign="top">
				<div class=" x-panel x-form-label-left" style="margin-top: 0em; width: 100%;"><%-- 0em <- 1em으로 수정하면 상위 공백 --%>
					<!----------------- SEARCH Hearder Start	 ----------------->
					<div class="x-panel-tl">
						<div class="x-panel-tr">
							<div class="x-panel-tc">
								<div class="x-panel-header x-unselectable" style="-moz-user-select: none;">
									<span class="x-panel-header-text">사원 상세정보</span><!----------------- 이름변경 ----------------->		
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
									<input type="hidden" id="flag" name="flag"/>
									<input type="hidden" id="id" name="id"/>
									<c:set var="data" value="${fn:split(groups, ',')}" />
									<c:forEach items="${data}" var="group" varStatus="i">
										<c:choose>
									    	<c:when test="${group == 'G001' || group == 'G002'}">
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
									    	</c:when>
									    </c:choose> 
									</c:forEach> 
									

									<!-- DETAIL 2_ROW Start -->
									<div class="x-column-inner" style="width: 100%; margin-top: 0em;">
										<div class=" x-panel x-column" style="width: 50%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label class="x-form-item-label" style="width: auto;" for="emp_num"><font color="red">* </font>사번(ID) :</label>
														<div style="padding-left: 85px;" class="x-form-element">
															<input type="text" name="emp_num" id="emp_num" autocomplete="off" size="20" class=" x-form-text x-form-field" style="width: auto;" maxlength="10">
														</div>
														<div class="x-form-clear-left">
														</div>
													</div>
												</div>
											</div>
										</div>
										<%--
										<div class=" x-panel x-column" style="width: 50%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label class="x-form-item-label" style="width: auto;" for="id" >로그인ID :</label>
														<div style="padding-left: 85px;" class="x-form-element">
															<table style="width: 132px;" cellspacing="0" class="x-btn  x-btn-noicon" border="0">
																<tr>
																	<td>
																		<input type="text" name="id" id="id" autocomplete="off" size="14" class="x-form-text x-form-field " style="width: auto;">
																		<input type="hidden" name="idcheck" id="idcheck" value="${pMap.idcheck}" />
																	</td>
																	<td>
																		 
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
																							<button type="button" id="overLapCheckBtn" name="overLapCheckBtn" class=" x-btn-text">체크</button>
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
																</tr>
															</table>
														</div>
														<div class="x-form-clear-left">
														</div>
													</div>
												</div>
											</div>
										</div>
										 --%>
									</div>
									<!-- DETAIL 2_ROW End -->
								
									<!-- DETAIL 3_ROW Start -->
									<div class="x-column-inner" style="width: 100%; margin-top: 0.1em;">
										<div class=" x-panel x-column" style="width: 50%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label class="x-form-item-label" style="width: auto;" for="passwd" ><font color="red">* </font>비밀번호 :</label>
														<div style="padding-left: 85px;" class="x-form-element">
															<input type="password" name="passwd" id="passwd" autocomplete="off" size="20" class="x-form-text x-form-field " style="width: auto;" maxlength="20">
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
														<label style="padding-rigth: 100px;"  class="x-form-item-label" style="width: auto;" for="re_passwd" >비밀번호확인 :</label>
														<div style="padding-left: 85px;" class="x-form-element">
															<input type="password" name="re_passwd" id="re_passwd" autocomplete="off" size="22" class=" x-form-text x-form-field" style="width: auto;" maxlength="20">
														</div>	
													</div>
												</div>
											</div>
										</div>
									</div>
									<!-- DETAIL 3_ROW End -->
									
									<!-- DETAIL 4_ROW Start -->
									<div class="x-column-inner" style="width: 100%; margin-top: 0.1em;">
										<div class=" x-panel x-column" style="width: 50%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label class="x-form-item-label" style="width: auto;" for="ssn1" >&nbsp;&nbsp;&nbsp;주민번호 :</label>
														<div style="padding-left: 85px;" class="x-form-element">
																<input type="text" name="ssn1" id="ssn1" autocomplete="off" size="6" class=" x-form-text x-form-field" style="width: auto;" maxlength="6" style="IME-MODE:disabled;" onkeyPress="return _chkKeyPressNumOnly(this)" onBlur="_removeComma(this, this.value)" onfocus="_removeComma(this, this.value)"/> -
																<input type="text" name="ssn2" id="ssn2" autocomplete="off" size="7" class=" x-form-text x-form-field" style="width: auto;" maxlength="7" style="IME-MODE:disabled;" onkeyPress="return _chkKeyPressNumOnly(this)" onBlur="_removeComma(this, this.value)" onfocus="_removeComma(this, this.value)"/>
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
														<label style="padding-rigth: 120px;"  class="x-form-item-label" style="width: auto;" for="kor_name" ><font color="red">* </font>한글이름 :</label>
														<div style="padding-left: 85px;" class="x-form-element">
															<input type="text" name="kor_name" id="kor_name" autocomplete="off" size="22" class=" x-form-text x-form-field" style="width: auto; ime-mode:active;" maxlength="20"/>
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>
									<!-- DETAIL 4_ROW End -->
									
									<!-- DETAIL 5_ROW Start -->
									<div class="x-column-inner" style="width: 100%; margin-top: 0.1em;">
										<div class=" x-panel x-column" style="width: 50%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label class="x-form-item-label" style="width: auto;" for="eng_name" >&nbsp;&nbsp;&nbsp;영문이름 :</label>
														<div style="padding-left: 85px;" class="x-form-element">
															<input type="text" name="eng_name" id="eng_name" autocomplete="off" size="20" class="x-form-text x-form-field " style="width: auto; ime-mode:inactive;" maxlength="30"/>
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
														<label style="padding-rigth: 100px;"  class="x-form-item-label" style="width: auto;" for="chn_name" >&nbsp;&nbsp;&nbsp;한자이름 :</label>
														<div style="padding-left: 85px;" class="x-form-element">
															<input type="text" name="chn_name" id="chn_name" autocomplete="off" size="22" class=" x-form-text x-form-field" style="width: auto;" maxlength="30/">
														</div>	
													</div>
												</div>
											</div>
										</div>
									</div>
									<!-- DETAIL 5_ROW End -->
									
									<!-- DETAIL 6_ROW Start -->
									<div class="x-column-inner" style="width: 100%; margin-top: 0.1em;">
										<div class=" x-panel x-column" style="width: 100%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label class="x-form-item-label" style="width: auto;" for="dept_code" ><font color="red">* </font>부서 :</label>
														<div style="padding-left: 85px;" class="x-form-element">
															<select name="dept_code" id="dept_code" title="부서코드" style="width: 122px;" type="text" class="x-form-select x-form-field" >
																<option value="">선택하세요</option>
																<c:forEach items="${DEPT_CODE}" var="data" varStatus="status">
																<option value="${fn:trim(data.COM_CODE)}"><c:out value="${data.COM_CODE_NAME}"/></option>
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
									<!-- DETAIL 6_ROW End -->
									
									<!-- DETAIL 7_ROW Start -->
									<div class="x-column-inner" style="width: 100%; margin-top: 0.1em;">
										<div class=" x-panel x-column" style="width: 50%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label class="x-form-item-label" style="width: auto;" for="postion_code" ><font color="red">* </font>직위 :</label>
														<div style="padding-left: 85px;" class="x-form-element">
															<select name="postion_code" id="postion_code" title="직위코드" style="width: 122px;" type="text" class="x-form-select x-form-field" >
																<option value="">선택하세요</option>
																<c:forEach items="${POSITION_CODE}" var="data" varStatus="status">
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
														<label class="x-form-item-label" style="width: auto;" for="duty_code" ><font color="red">* </font>직책 :</label>
														<div style="padding-left: 85px;" class="x-form-element">
															<select name="duty_code" id="duty_code" title="직책코드" style="width: 131px;" type="text" class="x-form-select x-form-field" >
																<option value="">선택하세요</option>
																<c:forEach items="${DUTY_CODE}" var="data" varStatus="status">
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
									<!-- DETAIL 7_ROW End -->
									
									<!-- DETAIL 8_ROW Start -->
									<div class="x-column-inner" style="width: 100%; margin-top: 0.1em;">
										<div class=" x-panel x-column" style="width: 50%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label class="x-form-item-label" style="width: auto;" for="tel_home" >&nbsp;&nbsp;&nbsp;집전화 :</label>
														<div style="padding-left: 85px;" class="x-form-element">
															<input type="text" name="tel_home" id="tel_home" autocomplete="off" size="20" class="x-form-text x-form-field " style="width: auto;" maxlength="20" style="IME-MODE:disabled;" onkeyPress="return _chkKeyPressNumOnly(this)" onBlur="_removeComma(this, this.value)" onfocus="_removeComma(this, this.value)"/>
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
														<label style="padding-rigth: 100px;"  class="x-form-item-label" style="width: auto;" for="mobile" >&nbsp;&nbsp;&nbsp;휴대전화 :</label>
														<div style="padding-left: 85px;" class="x-form-element">
															<input type="text" name="mobile" id="mobile" autocomplete="off" size="22" class=" x-form-text x-form-field" style="width: auto;" maxlength="20" style="IME-MODE:disabled;" onkeyPress="return _chkKeyPressNumOnly(this)" onBlur="_removeComma(this, this.value)" onfocus="_removeComma(this, this.value)"/>
														</div>	
													</div>
												</div>
											</div>
										</div>
									</div>
									<!-- DETAIL 8_ROW End -->
									
									<!-- DETAIL 9_ROW Start -->
									<div class="x-column-inner" style="width: 100%; margin-top: 0.1em;">
										<div class=" x-panel x-column" style="width: 50%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label class="x-form-item-label" style="width: auto;" for="tel_office" >&nbsp;&nbsp;&nbsp;내선번호 :</label>
														<div style="padding-left: 85px;" class="x-form-element">
															<input type="text" name="tel_office" id="tel_office" autocomplete="off" size="20" class="x-form-text x-form-field " style="width: auto;" maxlength="20" style="IME-MODE:disabled;" onkeyPress="return _chkKeyPressNumOnly(this)" onBlur="_removeComma(this, this.value)" onfocus="_removeComma(this, this.value)"/>
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
														<label style="padding-rigth: 100px;"  class="x-form-item-label" style="width: auto;" for="email" >&nbsp;&nbsp;&nbsp;이메일 :</label>
														<div style="padding-left: 85px;" class="x-form-element">
															<input type="text" name="email" id="email" autocomplete="off" size="22" class=" x-form-text x-form-field" style="width: auto;" maxlength="30"/>
														</div>	
													</div>
												</div>
											</div>
										</div>
									</div>
									<!-- DETAIL 9_ROW End -->
									
									<!-- DETAIL 10_ROW Start -->
									<div class="x-column-inner" style="width: 100%; margin-top: 0.1em;">
										<div class=" x-panel x-column" style="width: 100%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label class="x-form-item-label" style="width: auto;" for="eng_name" >&nbsp;&nbsp;&nbsp;자택주소 :</label>
														<div style="padding-left: 85px;" class="x-form-element">
															<table style="width: 390px;" cellspacing="0" class="x-btn  x-btn-noicon" border="0">
																<tr>
																	<td width="105">
																		<input type="text" name="zipcode1" id="zipcode1" autocomplete="off" size="20" class=" x-form-text x-form-field" style="width: 45px;" maxlength="3" style="IME-MODE:disabled;text-align:right" onkeyPress="return _chkKeyPressNumOnly(this)" onBlur="_removeComma(this, this.value)" onfocus="_removeComma(this, this.value)"> -
																		<input type="text" name="zipcode2" id="zipcode2" autocomplete="off" size="20" class=" x-form-text x-form-field" style="width: 45px;" maxlength="3" style="IME-MODE:disabled;text-align:right" onkeyPress="return _chkKeyPressNumOnly(this)" onBlur="_removeComma(this, this.value)" onfocus="_removeComma(this, this.value)">
																	</td>
																	<td width="10">
																		<%-- Button Start--%>
																		<div style="padding-left: 1px;" >
																			<img align="center" id="addrBtn" name="addrBtn" alt="" src="/resource/images/bass_1st/icon_src1.gif" style="cursor: hand;">
																		</div>
																		<%-- Button End--%>
																	</td>
																	<td>
																		<div style="padding-left: 5px;" class="x-form-element">
																			<input type="text" name="addr" id="addr" autocomplete="off" class=" x-form-text x-form-field" style="width: 241px;" maxlength="500">
																		</div>
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
									<!-- DETAIL 10_ROW End -->
									
									<!-- DETAIL 11_ROW Start -->
									<div class="x-column-inner" style="width: 100%; margin-top: 0.1em;">
										<div class=" x-panel x-column" style="width: 100%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label class="x-form-item-label" style="width: auto;" for="" ></label>
														<div style="padding-left: 85px;" class="x-form-element">
															<input type="text" name="addr_detail" id="addr_detail" autocomplete="off" size="70" class="x-form-text x-form-field " style="width: auto;" maxlength="500">
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
									<div class="x-column-inner" style="width: 100%; margin-top: 0.1em;">
										<div class=" x-panel x-column" style="width: 100%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label style="padding-rigth: 100px;"  class="x-form-item-label" style="width: auto;" for="use_yn1" ><font color="red">* </font>사용여부 :</label>
														<div style="padding-left: 85px;" class="x-form-element">
															<input type="radio" name="use_yn" id="use_yn1" autocomplete="off" class=" x-form-radio x-form-field" value="Y" >
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
					</tr>
				</table>
			</td>
		</tr>
	</table>
</body>

<%@ include file="/WEB-INF/web/jsp/sgis-bottom-inc.jsp" %>