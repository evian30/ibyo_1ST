<%--
  Class Name  : deptDetail.jsp
  Description : 부서정보상세
  Modification Information
 
      수정일                   수정자                 수정내용
  -------      --------    ---------------------------
  2011. 2. 8.     고기범                 최초 생성
 
  author   : 고기범
  since    : 2011. 2. 8.
  version  : 1.0
   
  Copyright (C) 2011 by SG All right reserved.
--%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/web/jsp/common/inc/commonInc.jsp" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>품목정보상세</title>
<link rel="stylesheet" type="text/css" href="/resource/common/js/ext3/resources/css/ext-all.css" />
<link rel="stylesheet" type="text/css" href="/resource/common/css/sample/RowEditor.css" />
<link rel="stylesheet" type="text/css" href="/resource/common/css/sample/restful.css" />
<script type="text/javascript">
// ComboBox 에 값을 DB로 부터 조회해와서 selectBox에 Setting
var comboData1 = [
				  <c:forEach items="${COM_CODE}" var="data" varStatus="status">
				  	'${data.COM_CODE}'
					<c:if test="${not status.last}">,</c:if>	
				  </c:forEach>
				 ] ;				 
var searchBtnHidden = true;		// 검색버튼 hidden 처리여부
var resetBtnHidden = true;		// 조건해제버튼 hidden 처리여부	

alert(comboData1);

/*  
 * Ajax리스트 처리결과 및 메시지 처리 
 */ 
function handleSuccess(response) {   
 
	// 조회된 결과를 Grid에 설정
	var json = Ext.util.JSON.decode(response.responseText);   
	store.loadData(json);

	// 메세지
//	Ext.MessageBox.show({   
//		title: "",   
//		msg: "검색된 자료가 없습니다.",   
//		buttons: Ext.MessageBox.OK,   
//		icon: Ext.MessageBox.INFO   
//	}); 
}   

/*  
 * Ajax리스트 처리 실패처리
 */  
function handleFailure(response) {   
  Ext.MessageBox.show({   
    title: "에러",   
    msg: "에러가 발생하였습니다.",   
    buttons: Ext.MessageBox.OK,   
    icon: Ext.MessageBox.ERROR   
  });   
}  

var userForm;

function fnForm(){

	userForm = new Ext.form.FormPanel({
	    renderTo: 'user-form'
	    ,iconCls: 'silk-user'
	    ,frame: true
	    ,labelAlign: 'right'
	    ,title: '품목관리'
	    ,frame: true
	    ,width: 500
	    ,defaultType: 'textfield'
	    ,defaults: {
	        anchor: '100%'
	    }
	    // private A pointer to the currently loaded record
	    ,record : null
		,items : [
	              {fieldLabel: '품목구분코드'	, name: 'item_type_code', allowBlank: false}
	             ,{fieldLabel: '품목코드'		, name: 'item_code'  	, allowBlank: false}
	             ,{fieldLabel: '품목명'		, name: 'item_name' 	, allowBlank: false}
	             ,{fieldLabel: '규격'		, name: 'standard'     	, allowBlank: false 
	              ,xtype:'combo' , store : comboData1, editable: false, emptyText:'선택하세요', triggerAction: 'all'}
	             ]
	    ,buttons :[{
		            text: '검색하기'
		            ,iconCls: 'icon-save'
		            ,handler: fnSearch
		            ,scope: this
		            ,hidden : searchBtnHidden
		           }
		           ,{
		            text: '조건해제'
		            ,hidden : resetBtnHidden
		            ,handler: function(btn, ev){
		                		this.getForm().reset();
		            		  }
		            ,scope: this
		            }
		           ]
	});
}

function fnSearch(){  	
	Ext.Ajax.request({   
		url: "/com/item/result.sg",   
		success: handleSuccess,   // 조회결과 성공시
		failure: handleFailure,   // 조회결과 실패시  
		// 조회조건을 DB로 전송하기위해서 조건값 설정
		params: { 
				dept_name   : Ext.get('item_type_code').getValue()	// 품목구분코드
				,item_code  : Ext.get('item_code').getValue()		// 품목코드
				,dept_level : Ext.get('item_name').getValue()		// 품목명
				,use_yn     : Ext.get('use_yn').getValue()			// 사용여부
				}
	});  
}  			

function fnInit(){
	// ExtJS 진입함수
	// onReady함수가 불려질때 실행되길 바라는 메소드 function을 첫번째 인자로 받고
	// 범위 object를 두번째 인자로
	// standard addListener Option들을 포함한 object를 세번째 인자로 받는다.
	// onReady함수는 document가 준비가 된 때에 불려진다고 하는데,
	// 이것은 이미지들이 불려지기 전, 그리고 onload 가 수행되기 전이라고 한다.
	Ext.onReady(function() {
		// QuickTips 초기화
//	    Ext.QuickTips.init();
	    
	    // Create a typical GridPanel with RowEditor plugin
	    fnForm();
	});
		
	// 상세조회 결과값	
	var itemTypeCode = "${RESULT.ITEM_TYPE_CODE}";	// 품목구분코드
	var itemCode = "${RESULT.ITEM_CODE}";			// 품목코드
	var itemName = "${RESULT.ITEM_NAME}";			// 품목명
	
//	alert("${RESULT}");
	
	// 상세조회값 설정
	userForm.getForm().setValues({item_type_code:itemTypeCode	// 품목구분코드
	 							  ,item_code:itemCode			// 품목코드
	 							  ,item_name:itemName			// 품목명
	 							  });
	
}   
</script>
<script type="text/javascript" src="/resource/common/js/ext3/adapter/ext/ext-base.js"></script>
<script type="text/javascript" src="/resource/common/js/ext3/ext-all-debug.js"></script>
<script type="text/javascript" src="/resource/common/js/ext3/src/locale/ext-lang-ko.js" charset="utf-8"></script>
<script type="text/javascript" src="/resource/common/js/common/App.js"></script>
<!-- form, grid 를 설정 _ 순서를 변경하면 에러가 남 
스크립트 파일은 읽어 오는 순서대로 dependency가 적용 -->
<!--<script type="text/javascript" src="/resource/common/js/com/restful.js"></script>-->
<!--<script type="text/javascript" src="/resource/common/js/com/UserForm.js"></script>-->

</head>
<body onload="fnInit()">
	<div class="container" style="width:500px">
		<div id="user-form"></div>
	</div>
</body>
</html>
