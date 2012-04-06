<%--
  Class Name  : pjtStatusHISList.jsp
  Description : 프로젝트 이력조회
  Modification Information
 
      수정일                   수정자                 수정내용
  -------      --------    ---------------------------
  2011. 04. 25   여인범            최초 생성   2
  
  author   : 여인범
  since    :  2011. 04. 25.
  version  : 1.0
   
  Copyright (C) 2011 by SG All right reserved.
--%>
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
<script type="text/javascript" src="/resource/common/js/sgis-comm-inc.js"></script>
<script type="text/javascript" src="/resource/common/js/grid/pop_grid_1st.js"></script>

<%
 	String grd_pjt_id = request.getParameter("grd_pjt_id");
 %> 
 
<script type="text/javascript">
/***************************************************************************
 * 초기값 설정
 ***************************************************************************/
var	gridHeigth_1st_pop 	 	= 300;
var	gridWidth_1st_pop		= 399;
var gridTitle_1st_pop 		= "프로젝트 진행상태 이력조회";
var	render_1st_pop			= "user-grid"; 
var	pageSize_1st_pop		= 10;	
var	proxyUrl_1st_pop		= "/pjt/pjtManage/pjtStatusListHIS.sg";
var limit_1st_pop			= pageSize_1st_pop;
var start_1st_pop			= 0;

/***************************************************************************
 * Grid의 컬럼 설정
 ***************************************************************************/
var userColumns_1st_pop =  [  
								 {header: "순번"            		, width: 100, sortable: true, dataIndex: "PJT_INFO_SEQ"    	, 			editor: new Ext.form.TextField({}) , hidden : true}
								,{header: "등록일자"          	, width: 100, sortable: true, dataIndex: "PJT_REG_DATE"   	, 			editor: new Ext.form.TextField({}) , hidden : true}
								,{header: "프로젝트ID"        	, width: 100, sortable: true, dataIndex: "PJT_ID"		   	, 			editor: new Ext.form.TextField({}) , hidden : true}
								,{header: "프로젝트"          	, width: 100, sortable: true, dataIndex: "PJT_NAME" 	   	, 			editor: new Ext.form.TextField({}) , hidden : false}
								                          
								,{header: "프로젝트진행상태코드" 	, width: 100, sortable: true, dataIndex: "PJT_STATUS_CODE"	, 			editor: new Ext.form.TextField({}) , hidden : true}
								,{header: "진행상태"   			, width: 100, sortable: true, dataIndex: "PJT_STATUS_CODE_NM", 			editor: new Ext.form.TextField({}) , hidden : true}	
								                          
								,{header: "관련업무명"         	, width: 100, sortable: true, dataIndex: "PJT_PROC_NAME"	, 			editor: new Ext.form.TextField({}) , hidden : false}
								,{header: "내용"            		, width: 100, sortable: true, dataIndex: "HIS_COMMENT"   	, 			editor: new Ext.form.TextField({}) , hidden : false}
									                      
								,{header: "사원번호"          	, width: 100, sortable: true, dataIndex: "EMP_NUM"   		, 			editor: new Ext.form.TextField({}) , hidden : true}
								,{header: "처리자"           		, width: 100, sortable: true, dataIndex: "EMP_NUM_NM"   	, 			editor: new Ext.form.TextField({}) , hidden : false}
								                          
								,{header: "시스템등록여부"      	, width: 100, sortable: true, dataIndex: "SYSTEM_REG_YN"	, 			editor: new Ext.form.TextField({}) , hidden : true}
								                          
								,{header: "최종변경자"        	, width: 100, sortable: true, dataIndex: "FINAL_MOD_ID"		, 			editor: new Ext.form.TextField({}) , hidden : false} 
								,{header: "최종변경일"        	, width: 100, sortable: true, dataIndex: "FINAL_MOD_DATE"	, 			editor: new Ext.form.TextField({}) , hidden : false}
								,{header: "최초등록일"         	, width: 100, sortable: true, dataIndex: "REG_DATE" 		, 			editor: new Ext.form.TextField({}) , hidden : true}
								,{header: "최초등록자"         	, width: 100, sortable: true, dataIndex: "REG_ID"	 		, 			editor: new Ext.form.TextField({}) , hidden : true}
						    ];	 
   		   		
         		
/***************************************************************************
 * 그리드 결과매핑 
 ***************************************************************************/
var mappingColumns_1st_pop = [ 
							  	 {name: "PJT_INFO_SEQ"    , allowBlank: false}
								,{name: "PJT_REG_DATE"    , allowBlank: false}
								
								,{name: "PJT_ID"          , allowBlank: false}
								,{name: "PJT_NAME"        , allowBlank: false}
								
								,{name: "PJT_STATUS_CODE"  	, allowBlank: false}
								,{name: "PJT_STATUS_CODE_NM", allowBlank: false}
								
								,{name: "PJT_PROC_NAME"   , allowBlank: false}
								
								,{name: "HIS_COMMENT"     , allowBlank: false}
								
								,{name: "EMP_NUM"         , allowBlank: false}
								,{name: "EMP_NUM_NM"      , allowBlank: false}
								
								,{name: "SYSTEM_REG_YN"   , allowBlank: false}
								
								,{name: "FINAL_MOD_ID"    , allowBlank: false}
								,{name: "FINAL_MOD_DATE"  , allowBlank: false}
								,{name: "REG_DATE"        , allowBlank: false}
								,{name: "REG_ID"          , allowBlank: false}
								
					    	 ];
 
/***************************************************************************
 * 그리드 클릭시 Event
 ***************************************************************************/
function fnGridOnClick_1st_pop(store, rowIndex){

}

/***************************************************************************
 * 설  명 : 화면 초기설정
 ***************************************************************************/
// ExtJS 진입함수
Ext.onReady(function() {
	 
});

/***************************************************************************
 * 설  명 : 그리드의 페이지 클릭시 검색조건값을 DB로 전송
 ***************************************************************************/
function fnPagingValue_1st_pop(){
	 
	try{
		GridClass_1st_pop.store.setBaseParam('start'	  ,start_1st_pop);
    	GridClass_1st_pop.store.setBaseParam('limit'	  ,limit_1st_pop);
    	
    	GridClass_1st_pop.store.setBaseParam('grd_pjt_id' ,'<%=grd_pjt_id%>');
    	 
	}catch(e){

	}
}  


function fnSelectPopUpGridRow1st(){
	 
}
</script>

</head>
<body>
	<table border="0" width="400" height="200"> 
		<tr>
			<!----------------- GRID START ----------------->
			<td width="50%" valign="top">
				<div id="user-grid"></div>
			</td>
			<!----------------- GRID END ----------------->
		</tr>
	</table>
</body>

