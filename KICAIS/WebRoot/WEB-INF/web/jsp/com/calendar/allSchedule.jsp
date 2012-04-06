<%--
  Class Name  : allScedule.jsp
  Description : 전체 직원 일정 검색
  Modification Information
 
      수정일              수정자                 수정내용
  -------      --------    ---------------------------
  2011. 04. 21.  여인범              최초 생성
  
 
  author   : 여인범
  since    : 2011. 04. 21.
  version  : 1.0
   
  Copyright (C) 2011 by SG All right reserved.
--%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/web/jsp/common/inc/commonInc.jsp" %>

<script type="text/javascript" src="/resource/common/js/common/common-msg-box.js" ></script> 
<script type="text/javascript" src="/resource/common/js/ajax.js" ></script>
<script type="text/javascript" src="/resource/common/js/grid/grid_1st.js"></script>
<script type="text/javascript">

/***************************************************************************
 * 초기값 설정
 ***************************************************************************/
var	gridHeigth_1st	=	"440";
var	gridWidth_1st  	;
var	gridTitle_1st   =	"전체 일정확인"; 
var	render_1st		=	"render_grid_1st";
var pageSize_1st	=	20;
var limit_1st		=	pageSize_1st;
var start_1st		=	0;
var proxyUrl_1st	= "/com/calendar/all_result_1st.sg";

/***************************************************************************
 * Grid의 컬럼 설정
 ***************************************************************************/
var userColumns_1st =  [
							 {header: "일정관리순번"        	,	    width: 10, sortable: true,  dataIndex:  "SCD_DAY_SEQ"           ,			editor: new Ext.form.TextField({}) , hidden : true}  
							,{header: "일정내용"        		,	    width: 150, sortable: true,  dataIndex:  "SCD_PROC_RES_CONTENT"  ,			editor: new Ext.form.TextField({}) , hidden : false}  
							,{header: "일정구분코드"        	,	    width: 10, sortable: true,  dataIndex:  "SCD_TYPE_CODE"         ,			editor: new Ext.form.TextField({}) , hidden : true}
							,{header: "구분"        			,	    width: 30, sortable: true,  dataIndex:  "SCD_TYPE_CODE_NM"      ,			editor: new Ext.form.TextField({}) , hidden : false}
							
							,{header: "계획수행구분코드"    	,	    width: 10, sortable: true,  dataIndex:  "PROC_TYPE_CODE"        ,			editor: new Ext.form.TextField({}) , hidden : true}
							,{header: "계획수행"    			,	    width: 30, sortable: true,  dataIndex:  "PROC_TYPE_CODE_NM"     ,			editor: new Ext.form.TextField({}) , hidden : true}
							
							,{header: "등록부서"        		,	    width: 10, sortable: true,  dataIndex:  "SCD_DAY_REG_DEPT"      ,			editor: new Ext.form.TextField({}) , hidden : true}  
							,{header: "등록자사원번호"  		,	    width: 10, sortable: true,  dataIndex:  "SCD_DAY_REG_EMP_NUM"   ,			editor: new Ext.form.TextField({}) , hidden : true}
							,{header: "부서"        			,	    width: 60, sortable: true,  dataIndex:  "SCD_DAY_REG_DEPT_NM"   ,			editor: new Ext.form.TextField({}) , hidden : true}  
							,{header: "등록자"  				,	    width: 40, sortable: true,  dataIndex:  "SCD_DAY_REG_EMP_NUM_NM",			editor: new Ext.form.TextField({}) , hidden : false}
							
							,{header: "일정상태값"          	,	    width: 10, sortable: true,  dataIndex:  "STATUS_VAL"            ,			editor: new Ext.form.TextField({}) , hidden : true}
							,{header: "상태"          		,	    width: 40, sortable: true,  dataIndex:  "STATUS_NM"            	,			editor: new Ext.form.TextField({}) , hidden : true}
							
							,{header: "내근/외근구분코드"   	,	    width: 10, sortable: true,  dataIndex:  "WORK_PATTERN_CODE"     ,			editor: new Ext.form.TextField({}) , hidden : true}
							,{header: "내근/외근"			   	,	    width: 50, sortable: true,  dataIndex:  "WORK_PATTERN_CODE_NM"  ,			editor: new Ext.form.TextField({}) , hidden : true}
							
							,{header: "시작일"	         	,	    width: 50, sortable: true,  dataIndex:  "SCD_SDATE"             ,			editor: new Ext.form.TextField({}) , hidden : false}  
							,{header: "종료일"   	      		,	    width: 50, sortable: true,  dataIndex:  "SCD_EDATE"             ,			editor: new Ext.form.TextField({}) , hidden : false}  
							,{header: "시작시간"            	,	    width: 50, sortable: true,  dataIndex:  "SCD_TIME_FROM"         ,			editor: new Ext.form.TextField({}) , hidden : true}  
							,{header: "종료시간"            	,	    width: 50, sortable: true,  dataIndex:  "SCD_TIME_TO"           ,			editor: new Ext.form.TextField({}) , hidden : true}  
							,{header: "총소시간"            	,	    width: 10, sortable: true,  dataIndex:  "SCD_TIME"              ,			editor: new Ext.form.TextField({}) , hidden : true}  
							,{header: "인건비"              	,	    width: 10, sortable: true,  dataIndex:  "LABOR_COST"            ,			editor: new Ext.form.TextField({}) , hidden : true}
							
							,{header: "프로젝트ID"          	,	    width: 10, sortable: true,  dataIndex:  "PJT_ID"                ,			editor: new Ext.form.TextField({}) , hidden : true}
							,{header: "프로젝트"          	,	    width: 100, sortable: true,  dataIndex:  "PJT_NM"                ,			editor: new Ext.form.TextField({}) , hidden : true}
							
							,{header: "타스크그룹코드"      	,	    width: 10, sortable: true,  dataIndex:  "TASK_GROUP_CODE"       ,			editor: new Ext.form.TextField({}) , hidden : true}  
							,{header: "타스크 코드"         	,	    width: 10, sortable: true,  dataIndex:  "TASK_CODE"             ,			editor: new Ext.form.TextField({}) , hidden : true}
							,{header: "타스크그룹"      		,	    width: 70, sortable: true,  dataIndex:  "TASK_GROUP_CODE_NM"    ,			editor: new Ext.form.TextField({}) , hidden : true}  
							,{header: "타스크"         		,	    width: 70, sortable: true,  dataIndex:  "TASK_CODE_NM"          ,			editor: new Ext.form.TextField({}) , hidden : true}
							
							
							,{header: "지출결의서번호"      	,	    width: 10, sortable: true,  dataIndex:  "PAY_NO"                ,			editor: new Ext.form.TextField({}) , hidden : true}  
							,{header: "방문일지번호"        	,	    width: 10, sortable: true,  dataIndex:  "VISIT_REPORT_NO"       ,			editor: new Ext.form.TextField({}) , hidden : true}  
							
							,{header: "비고"                	,	    width: 10, sortable: true,  dataIndex:  "NOTE"                  ,			editor: new Ext.form.TextField({}) , hidden : true}  
							
							,{header: "현재프로젝트상태코드"	,	    width: 10, sortable: true,  dataIndex:  "PJT_STATUS"            ,			editor: new Ext.form.TextField({}) , hidden : true}
							,{header: "PJT상태"				,	    width: 60, sortable: true,  dataIndex:  "PJT_STATUS_NM"         ,			editor: new Ext.form.TextField({}) , hidden : true}
							
							,{header: "최종변경자ID"        	,	    width: 30, sortable: true,  dataIndex:  "FINAL_MOD_ID"          ,			editor: new Ext.form.TextField({}) , hidden : true}  
							,{header: "최종변경일시"        	,	    width: 10, sortable: true,  dataIndex:  "FINAL_MOD_DATE"        ,			editor: new Ext.form.TextField({}) , hidden : true}  
							
							,{header: "최초등록일"          	,	    width: 10, sortable: true,  dataIndex:  "REG_DATE"              ,			editor: new Ext.form.TextField({}) , hidden : true}  
							,{header: "최초등록자"          	,	    width: 10, sortable: true,  dataIndex:  "REG_ID"                ,			editor: new Ext.form.TextField({}) , hidden : true}  
							,{header: ""                   	,	    width: 10, sortable: true,  dataIndex:  "TASK_END_YN"           ,			editor: new Ext.form.TextField({}) , hidden : true}  
							,{header: ""                   	,	    width: 10, sortable: true,  dataIndex:  "TASK_CHK_RES_CODE"     ,			editor: new Ext.form.TextField({}) , hidden : true}
						];	 


/***************************************************************************
 * 그리드 결과매핑 
 ***************************************************************************/
var mappingColumns_1st = [ 
							{name:"SCD_DAY_SEQ"          , allowBlank: false},
							{name:"SCD_TYPE_CODE"        , allowBlank: false},
							{name:"SCD_TYPE_CODE_NM"     , allowBlank: false},
							
							{name:"PROC_TYPE_CODE"       , allowBlank: false},
							{name:"PROC_TYPE_CODE_NM"    , allowBlank: false},
							
							{name:"SCD_DAY_REG_DEPT"     , allowBlank: false},
							{name:"SCD_DAY_REG_DEPT_NM"  , allowBlank: false},
							
							{name:"SCD_DAY_REG_EMP_NUM"   , allowBlank: false},
							{name:"SCD_DAY_REG_EMP_NUM_NM", allowBlank: false},
							
							{name:"STATUS_VAL"           , allowBlank: false},
							{name:"STATUS_NM"            , allowBlank: false},
							
							{name:"WORK_PATTERN_CODE"    , allowBlank: false},
							{name:"WORK_PATTERN_CODE_NM" , allowBlank: false},
							
							{name:"SCD_SDATE"            , allowBlank: false},
							{name:"SCD_TIME_FROM"        , allowBlank: false},
							{name:"SCD_TIME_TO"          , allowBlank: false},
							{name:"SCD_TIME"             , allowBlank: false},
							{name:"LABOR_COST"           , allowBlank: false},
							
							{name:"PJT_ID"               , allowBlank: false},
							{name:"PJT_NM"               , allowBlank: false},
							
							{name:"TASK_GROUP_CODE"      , allowBlank: false},
							{name:"TASK_GROUP_CODE_NM"   , allowBlank: false},
							
							{name:"TASK_CODE"            , allowBlank: false},
							{name:"TASK_CODE_NM"         , allowBlank: false},
							
							{name:"PAY_NO"               , allowBlank: false},
							{name:"VISIT_REPORT_NO"      , allowBlank: false},
							{name:"SCD_PROC_RES_CONTENT" , allowBlank: false},
							{name:"NOTE"                 , allowBlank: false},
							
							{name:"PJT_STATUS"           , allowBlank: false},
							{name:"PJT_STATUS_NM"        , allowBlank: false},
							
							{name:"FINAL_MOD_ID"         , allowBlank: false},
							{name:"FINAL_MOD_DATE"       , allowBlank: false},
							{name:"SCD_EDATE"            , allowBlank: false},
							{name:"REG_DATE"             , allowBlank: false},
							{name:"REG_ID"               , allowBlank: false},
							{name:"TASK_END_YN"          , allowBlank: false},
							{name:"TASK_CHK_RES_CODE"    , allowBlank: false} 
		 
   						 ];                         
                              
/***************************************************************************
 * 그리드 클릭시 Event
 ***************************************************************************/
function fnGridOnClick_1st(store, rowIndex){
	 	
	var dForm = document.detailForm;
	
	Ext.get("scd_day_seq"         ).set({value : fnFixNull(store.getAt(rowIndex).data.SCD_DAY_SEQ         ) }, false);
	
	Ext.get("scd_type_code"       ).set({value : fnFixNull(store.getAt(rowIndex).data.SCD_TYPE_CODE       ) }, false); 
	
	Ext.get("proc_type_code"      ).set({value : fnFixNull(store.getAt(rowIndex).data.PROC_TYPE_CODE      ) }, false);
	Ext.get("scd_day_reg_dept"    ).set({value : fnFixNull(store.getAt(rowIndex).data.SCD_DAY_REG_DEPT    ) }, false);
	Ext.get("scd_day_reg_emp_num" ).set({value : fnFixNull(store.getAt(rowIndex).data.SCD_DAY_REG_EMP_NUM ) }, false);
	Ext.get("scd_day_reg_emp_num_nm" ).set({value : fnFixNull(store.getAt(rowIndex).data.SCD_DAY_REG_EMP_NUM_NM ) }, false);
	
	Ext.get("scd_day_reg_dept_nm"    ).set({value : fnFixNull(store.getAt(rowIndex).data.SCD_DAY_REG_DEPT_NM    ) }, false);
	Ext.get("scd_day_reg_emp_num_nm" ).set({value : fnFixNull(store.getAt(rowIndex).data.SCD_DAY_REG_EMP_NUM_NM ) }, false);
	
	Ext.get("status_val"          ).set({value : fnFixNull(store.getAt(rowIndex).data.STATUS_VAL          ) }, false);
	Ext.get("work_pattern_code"   ).set({value : fnFixNull(store.getAt(rowIndex).data.WORK_PATTERN_CODE   ) }, false);
	Ext.get("scd_sdate"           ).set({value : fnFixNull(store.getAt(rowIndex).data.SCD_SDATE           ) }, false);
	Ext.get("scd_time_from"       ).set({value : fnFixNull(store.getAt(rowIndex).data.SCD_TIME_FROM       ) }, false);
	Ext.get("scd_time_to"         ).set({value : fnFixNull(store.getAt(rowIndex).data.SCD_TIME_TO         ) }, false);
	Ext.get("scd_time"            ).set({value : fnFixNull(store.getAt(rowIndex).data.SCD_TIME            ) }, false);
	Ext.get("labor_cost"          ).set({value : fnFixNull(MoneyComma(store.getAt(rowIndex).data.LABOR_COST))}, false);
	Ext.get("pjt_id"              ).set({value : fnFixNull(store.getAt(rowIndex).data.PJT_ID              ) }, false);
	Ext.get("pjt_nm"              ).set({value : fnFixNull(store.getAt(rowIndex).data.PJT_NM              ) }, false);
	
	Ext.get("task_group_code"     ).set({value : fnFixNull(store.getAt(rowIndex).data.TASK_GROUP_CODE     ) }, false);  
	
	Ext.get("task_code"           ).set({value : fnFixNull(store.getAt(rowIndex).data.TASK_CODE           ) }, false);
	Ext.get("pay_no"              ).set({value : fnFixNull(store.getAt(rowIndex).data.PAY_NO              ) }, false);
	Ext.get("visit_report_no"     ).set({value : fnFixNull(store.getAt(rowIndex).data.VISIT_REPORT_NO     ) }, false);
	Ext.get("scd_proc_res_content").set({value : fnFixNull(store.getAt(rowIndex).data.SCD_PROC_RES_CONTENT) }, false);
	Ext.get("note"                ).set({value : fnFixNull(store.getAt(rowIndex).data.NOTE                ) }, false);
	Ext.get("pjt_status"          ).set({value : fnFixNull(store.getAt(rowIndex).data.PJT_STATUS          ) }, false);
	Ext.get("final_mod_id"        ).set({value : fnFixNull(store.getAt(rowIndex).data.FINAL_MOD_ID        ) }, false);
	Ext.get("final_mod_date"      ).set({value : fnFixNull(store.getAt(rowIndex).data.FINAL_MOD_DATE      ) }, false);
	Ext.get("scd_edate"           ).set({value : fnFixNull(store.getAt(rowIndex).data.SCD_EDATE           ) }, false);
	
	//Ext.get("task_end_yn"         ).set({value : fnFixNull(store.getAt(rowIndex).data.TASK_END_YN         ) }, false);
	//Ext.get("task_chk_res_code"   ).set({value : fnFixNull(store.getAt(rowIndex).data.TASK_CHK_RES_CODE   ) }, false);
	
	Ext.get('saveBtn').dom.disabled    = true;
	Ext.get('updateBtn').dom.disabled  = false;
}   
 
 
/***************************************************************************
 * 설  명 : 검색
************************************************************************** */
function fnSearch(){
	
	Ext.Ajax.request({   
		url: "/com/calendar/all_result_1st.sg"
		,method : 'POST'   
		,success: function(response){
				  	handleSuccess(response,GridClass_1st);
				}
		,failure: handleFailure  
		 
		,params : {
						limit            : limit_1st
					  , start            : start_1st
					  
					  ,	src_dept_name    : Ext.get('src_dept_name').getValue()
					  , src_postion_code : Ext.get('src_postion_code').getValue()
					  , src_kor_name     : Ext.get('src_kor_name').getValue()
					  , src_pjt_name     : Ext.get('src_pjt_name').getValue()
					  , src_pjt_id	     : Ext.get('src_pjt_id').getValue()
					  , src_scd_time_from: Ext.get('src_scd_time_from').getValue()
					  , src_scd_time_to  : Ext.get('src_scd_time_to').getValue()
				  }				
	});  

}  		

/***************************************************************************
 * 설  명 : 저장버튼 클릭
 ***************************************************************************/
function fnSave(){  	
	
	Ext.Ajax.request({   
		url: "/com/calendar/actionAllSchedule.sg"   
		,success: function(response){
					handleSuccess(response,GridClass_1st,'save');
		          }
		,failure: handleFailure  
		,form   : document.detailForm
		,params : { 
				  
					limit        	 : limit_1st
			  	  , start       	 : start_1st
			  	  
				  ,	src_dept_name    : Ext.get('src_dept_name').getValue()
				  , src_postion_code : Ext.get('src_postion_code').getValue()
				  , src_kor_name     : Ext.get('src_kor_name').getValue()
				  , src_pjt_name     : Ext.get('src_pjt_name').getValue()
				  , src_pjt_id	     : Ext.get('src_pjt_id').getValue()
				  , src_scd_time_from: Ext.get('src_scd_time_from').getValue()
				  , src_scd_time_to  : Ext.get('src_scd_time_to').getValue()
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
	});
	 
	
   	 // 프로젝트 검색팝업
   	Ext.get('src_pjt_id_btn').on('click', function(e){
		param = "?fieldName=src_pjt_id";
		fnPjtPop(param);
	});
   	 
   	Ext.get('pjt_id_btn').on('click', function(e){
		param = "?fieldName=pjt_id";
		fnPjtPop(param);
	});
   	
   	 Ext.get('regEmpNumBtn').on('click', function(e){
		var param = '';
		fnEmployeePop(param)
	}); 
   	
	
 	
	//신규 버튼 -> 상세필드 초기화
	Ext.get('detailClearBtn').on('click', function(){
		fnInitValue();
	});
	
	
	//수정 버튼 -> 데이터를 server로 전송
	Ext.get('updateBtn').on('click', function(){ 
		Ext.MessageBox.confirm('Confirm', '수정하시겠습니까?', showResult); 
	});
	
	//등록 버튼 -> 데이터를 server로 전송
	Ext.get('saveBtn').on('click', function(e){	
		
		if(Ext.get('scd_type_code').getValue() == ""){
			SGAlert("[일정 상세정보]", "[일정구분코드]를 입력 해 주세요");
			return false;
		}
		if(Ext.get('proc_type_code').getValue() == ""){
			SGAlert("[일정 상세정보]", "[계획수행 구분 코드]를 입력 해 주세요");
			return false;
		}
		if(Ext.get('scd_day_reg_dept').getValue() == ""){
			SGAlert("[일정 상세정보]", "[일정등록 부서]를 입력 해 주세요");
			return false;
		}
		if(Ext.get('scd_day_reg_emp_num').getValue() == ""){
			SGAlert("[일정 상세정보]", "[일정 등록자]를 입력 해 주세요");
			return false;
		}
		if(Ext.get('status_val').getValue() == ""){
			SGAlert("[일정 상세정보]", "[일정 상태값]을 입력 해 주세요");
			return false;
		}
		if(Ext.get('work_pattern_code').getValue() == ""){
			SGAlert("[일정 상세정보]", "[내근/외근 구분 코드]를 입력 해 주세요");
			return false;
		}
		if(Ext.get('scd_sdate').getValue() == ""){
			SGAlert("[일정 상세정보]", "[일정 시작일]을 입력 해 주세요");
			return false;
		}
		if(Ext.get('scd_edate').getValue() == ""){
			SGAlert("[일정 상세정보]", "[일정 종료일]을 입력 해 주세요");
			return false;
		}
		if(Ext.get('scd_proc_res_content').getValue() == ""){
			SGAlert("[일정 상세정보]", "[일정 내용]을 입력 해 주세요");
			return false;
		}	
		
		Ext.MessageBox.confirm('Confirm', '저장하시겠습니까?', showResult);
	});
 
	
	// 검색시작일자
	var src_scd_time_from = new Ext.form.DateField({
    	applyTo: 'src_scd_time_from',
		allowBlank: false,
		format:'Y-m-d',
		editable : false
	});
   	
	// 검색종료일자
	var src_scd_time_to = new Ext.form.DateField({
    	applyTo: 'src_scd_time_to',
		allowBlank: false,
		format:'Y-m-d',
		editable : false
	});
	
	
	// 시작일자
	var scd_sdate = new Ext.form.DateField({
    	applyTo: 'scd_sdate',
		allowBlank: false,
		format:'Y-m-d',
		editable : false
	});
   	
	// 종료일자
	var scd_edate = new Ext.form.DateField({
    	applyTo: 'scd_edate',
		allowBlank: false,
		format:'Y-m-d',
		editable : false
	});
	
	
	fnInitValue();
	
	Ext.get('final_mod_id').dom.disabled    = true;
	Ext.get('final_mod_date').dom.disabled  = true;

});

// 저장, 수정버튼 클릭시 '예','아니오' 
function showResult(btn){
   	if(btn == 'yes'){
   		fnSave();
   	}    	
};
 

/***************************************************************************
 * 설  명 : 필드 초기화
 **************************************************************************/
function fnInitValue(){
	var dForm = document.detailForm;
	var sForm = document.searchForm;
	
	sForm.reset();
	dForm.reset(); 
	
	dForm.scd_day_reg_emp_num.value 	= "${sabun}";
	dForm.scd_day_reg_emp_num_nm.value	= "${admin_nm}";
	
	dForm.scd_day_reg_dept.value 		= "${dept_code}";
	dForm.scd_day_reg_dept_nm.value 	= "${dept_nm}";
	  
	dForm.final_mod_id.value 		= "${admin_nm}";
	dForm.final_mod_date.value		= getTimeStamp().trim();  
	
	Ext.get('saveBtn').dom.disabled    	  = false;
	Ext.get('updateBtn').dom.disabled  	  = true;
	
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
		
		GridClass_1st.store.setBaseParam('src_pjt_name', 	 Ext.get('src_pjt_name').getValue());
		GridClass_1st.store.setBaseParam('src_pjt_id', 		 Ext.get('src_pjt_id').getValue());
		GridClass_1st.store.setBaseParam('src_scd_time_from',Ext.get('src_scd_time_from').getValue());
		GridClass_1st.store.setBaseParam('src_scd_time_to',  Ext.get('src_scd_time_to').getValue());
	}catch(e){

	}
} 


function fnOpenPop(sURL, dlgWidth, dlgHeight, winName){
  var xPos=(window.screen.width) ? (window.screen.width-dlgWidth)/2 : 0;
  var yPos=(window.screen.height) ? (window.screen.height-dlgHeight)/2 : 0;
  var sFeatures = "titlebar=no, scrollbars=no,location=no ,menubar=no, resizable=no, status=yes, width="+dlgWidth+",height="+dlgHeight+",left="+xPos+", top="+yPos;
  window.open(sURL,winName, sFeatures);
}


// 담당자, 등록자 검색팝업 ****************************************
function fnEmployeePop(param){ 
	var sURL      = "/com/employee/employeePop.sg"+param;
	var dlgWidth  = 399;
	var dlgHeight = 396; 
	var winName  = "등록자";
	fnOpenPop(sURL, dlgWidth, dlgHeight, winName);
}
 
  
// 담당자, 등록자 검색 결과 return Value
function fnEmployeePopValue(records, obj){
	var record = records[0].data;	
		Ext.get('scd_day_reg_emp_num').set({value:fnFixNull(record.EMP_NUM)} , false);
	    Ext.get('scd_day_reg_emp_num_nm').set({value:fnFixNull(record.KOR_NAME)} , false);
	    Ext.get('scd_day_reg_dept').set({value:fnFixNull(record.DEPT_CODE)} , false);
	    Ext.get('scd_day_reg_dept_nm').set({value:fnFixNull(record.DEPT_NAME)} , false);  
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
    var record = records[0].data;
	if(fieldName=="src_pjt_id"){
		Ext.get('src_pjt_id').set({value:fnFixNull(record.PJT_ID)} , false);
    	Ext.get('src_pjt_name').set({value:fnFixNull(record.PJT_NAME)} , false);
	}else{
		Ext.get('pjt_id').set({value:fnFixNull(record.PJT_ID)} , false);
    	Ext.get('pjt_nm').set({value:fnFixNull(record.PJT_NAME)} , false);
	}
   	
}
</script>

<body>
	<table border="0" width="1000" height="200">
		<tr>
			<td colspan="2">
				<form name="searchForm">
				<!----------------- SEARCH Hearder Start	 ----------------->
				<div id="ext-comp-1002" class=" x-panel x-form-label-left" style="margin-top: 0.4em;"><%-- 0em <- 1em으로 수정하면 상위 공백 --%>
					<div class="x-panel-tl">
						<div class="x-panel-tr">
							<div class="x-panel-tc">
								<div id="ext-gen4" class="x-panel-header x-unselectable" style="-moz-user-select: none;">
									<span id="ext-gen8" class="x-panel-header-text">전체일정 검색</span>
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
										<td width="22%" colspan="2">
											<div tabindex="-1" class="x-form-item " >
												<label class="x-form-item-label" style="width: auto;" for="src_dept_name">부서명 :</label>
												<div style="padding-left: 70px;" class="x-form-element">
													<input type="text" name="src_dept_name" id="src_dept_name" autocomplete="off" size="18" class="x-form-text x-form-field" style="width: auto;">													
												</div>
											</div>
										</td>
										
										<td  width="20%">
											<div tabindex="-1" class="x-form-item " >
												<label class="x-form-item-label" style="width: auto;" for="src_postion_code" >직위 :</label>
												<div style="padding-left: 30px;" class="x-form-element">
													<select name="src_postion_code" id="src_postion_code" style="width: 85;" type="text" class=" x-form-select x-form-field" >
														<option value="">전체</option>
														<c:forEach items="${POSITION_CODE}" var="data" varStatus="status">
														<option value="${data.COM_CODE}"><c:out value="${data.COM_CODE_NAME}"/></option>
														</c:forEach>
													</select>
												</div>
											</div>
										</td>
										
										<td width="20%">
											<div tabindex="-1" class="x-form-item " >
												<label class="x-form-item-label" style="width: auto;" for="src_kor_name" >사원명 :</label>
												<div style="padding-left: 72px;" class="x-form-element">
													<input type="text" name="src_kor_name" id="src_kor_name" autocomplete="off" size="15" class="x-form-text x-form-field" style="width: auto;">
												</div>
											</div>
										</td>
									</tr>
									<tr>
										<td width="17%">
											<div tabindex="-1" class="x-form-item " >
												<label class="x-form-item-label" style="width: auto;" for="src_pjt_id" >프로젝트ID :</label>
												<div style="padding-left: 0px;" class="x-form-element">
													<input type="text" name="src_pjt_id" id="src_pjt_id" autocomplete="off" size="18" class=" x-form-text x-form-field" style="width: auto;" />
												</div>
											</div>
										</td>
										<td width="5%" align="center">
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
																		<button type="button" id="src_pjt_id_btn" name="src_pjt_id_btn" class="x-btn-text">검색</button>
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
												<div style="padding-left: 0px;" class="x-form-element">
													<input type="text" name="src_pjt_name" id="src_pjt_name" autocomplete="off" size="20" class=" x-form-text x-form-field" style="width: auto;" />
												</div>
											</div>
										</td>
										
										<td width="40%" colspan="2" align="left">
											 <div tabindex="-1" class="x-form-item " >
												<label class="x-form-item-label" style="width: auto;" for="src_scd_time_from" ><font color="red">* </font>일정기간 :</label>
												<div style="padding-left: 30px;" class="x-form-element">
													<table>
														<tr>
															<td>
																<input type="text" name="src_scd_time_from" id="src_scd_time_from" autocomplete="off" size="12" style="width: auto;">		
															</td>
															<td>
																&nbsp;&nbsp;&nbsp;~&nbsp;&nbsp;&nbsp;
															</td>
															<td>
																<input type="text" name="src_scd_time_to" id="src_scd_time_to" autocomplete="off" size="12" style="width: auto;">		
															</td>
														</tr>
													</table>
												</div>
											</div>
										 
										</td> 
									</tr>
								 
								 
									<%-- 2 Row 버튼 Start --%>
									<tr align="right">
										<td colspan="7">
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
			<!------------------------------ GRID START ---------------------------------->
			<td width="50%" valign="top">
				<div id="render_grid_1st" style="margin-top: 0.4em;"></div> <!----------------- 그리드명을 동일하게 설정 ----------------->		
			</td>
			<!------------------------------ GRID END ------------------------------------>
			<td width="50%" valign="top">
				<div class=" x-panel x-form-label-left" style="margin-top: 0.4em; width: 100%;"><%-- 0em <- 1em으로 수정하면 상위 공백 --%>
					<!----------------- SEARCH Hearder Start	 ----------------->
					<div class="x-panel-tl">
						<div class="x-panel-tr">
							<div class="x-panel-tc">
								<div class="x-panel-header x-unselectable" style="-moz-user-select: none;">
									<span class="x-panel-header-text">일정 상세정보</span><!----------------- 이름변경 ----------------->		
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
									<form id="detailForm" name="detailForm" method="POST" class="x-panel-body x-form" style="padding: 1px 1px 0pt; width: 500px;">
									<input type="hidden" id="flag" name="flag"/>
									<input type="hidden" id="scd_day_seq" name="scd_day_seq"/>
									
									<%-- 
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
									  --%>
									  
									<div class="x-column-inner" style="width: 100%;">
										<div class=" x-panel x-column" style="width: 100%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label class="x-form-item-label" style="width: auto;" for="scd_proc_res_content" ><font color="red">* </font>내용:</label>
														<div style="padding-left: 85px;" class="x-form-element">
															<input type="text" name="scd_proc_res_content" id="scd_proc_res_content" autocomplete="off" class=" x-form-text x-form-field" style="width:375;">
														</div>
														<div class="x-form-clear-left">
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>  
									  
									  
									<input type="hidden" id="detailClearBtn"/>
									<!-- DETAIL 2_ROW Start -->
									<div class="x-column-inner" style="width: 100%; margin-top: 0.2em;">
										<div class=" x-panel x-column" style="width: 50%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label class="x-form-item-label" style="width: auto;" for="scd_type_code"><font color="red">* </font>일정구분: </label>
														<div style="padding-left: 85px;" class="x-form-element">
															<select name="scd_type_code" id="scd_type_code" title="일정구분" style="width: 122px;" type="text" class="x-form-select x-form-field">
																<option value="">선택하세요</option>
																<c:forEach items="${SCD_TYPE_CODE}" var="data" varStatus="status">
																<c:if test="${data.COM_CODE!='01'}">
																<option value="${fn:trim(data.COM_CODE)}"><c:out value="${data.COM_CODE_NAME}"/></option>
																</c:if>
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
														<label class="x-form-item-label" style="width: auto;" for="proc_type_code" ><font color="red"> </font>계획수행 :</label>
														<div style="padding-left: 85px;" class="x-form-element">
															<select name="proc_type_code" id="proc_type_code" title="일정구분" style="width: 122px;" type="text" class="x-form-select x-form-field">
																<option value="">선택하세요</option>
																<c:forEach items="${PROC_TYPE_CODE}" var="data" varStatus="status">
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
									<!-- DETAIL 2_ROW End -->
								
									<!-- DETAIL 3_ROW Start -->
									<div class="x-column-inner" style="width: 100%; margin-top: 0.2em;">
										<div class=" x-panel x-column" style="width: 50%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label class="x-form-item-label" style="width: auto;" for="scd_day_reg_emp_num_nm" ><font color="red">* </font>등록자 :</label>
														<div style="padding-left: 85px;" class="x-form-element">
															<table style="width: 120px;" cellspacing="0" class="x-btn  x-btn-noicon">
																<tr>
																	<td>
																		<input type="text" readonly="readonly" name="scd_day_reg_emp_num_nm" id="scd_day_reg_emp_num_nm" autocomplete="off" size="15" class=" x-form-text x-form-field" style="width: auto;">
																		<input type="hidden" name="scd_day_reg_emp_num" id="scd_day_reg_emp_num" >
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
																							<button type="button" id="regEmpNumBtn" class=" x-btn-text">||</button>
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
													</div>
												</div>
											</div>
										</div>
										<div class=" x-panel x-column" style="width: 50%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label class="x-form-item-label" style="width: auto;" for="scd_day_reg_dept" ><font color="red">* </font>등록자부서 :</label>
														<div style="padding-left: 85px;" class="x-form-element">
															<input readonly="readonly" type="text" name="scd_day_reg_dept_nm" id="scd_day_reg_dept_nm" autocomplete="off" size="20" class="x-form-text x-form-field " style="width: auto;">
															<input type="hidden" name="scd_day_reg_dept" id="scd_day_reg_dept">
														</div>
														<div class="x-form-clear-left">
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>
									<!-- DETAIL 3_ROW End -->
									
									<!-- DETAIL 5_ROW Start -->
									<div class="x-column-inner" style="width: 100%; margin-top: 0.2em;">
										<div class=" x-panel x-column" style="width: 50%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label class="x-form-item-label" style="width: auto;" for="scd_sdate" ><font color="red">* </font>일정 시작일 :</label>
														<div style="padding-left: 85px;" class="x-form-element">
															<input type="text" name="scd_sdate" id="scd_sdate" autocomplete="off" size="16" class="x-form-text x-form-field " style="width: auto;">
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
														<label class="x-form-item-label" style="width: auto;" for="scd_time_from" ><font color="red"> </font>시작시간 :</label>
														<div style="padding-left: 85px;" class="x-form-element">
															<input type="text" name="scd_time_from" id="scd_time_from" autocomplete="off" size="7" class=" x-form-text x-form-field" style="width: auto;"> ex 08:40:00
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
														<label class="x-form-item-label" style="width: auto;" for="scd_edate" ><font color="red">* </font>일정 종료일 :</label>
														<div style="padding-left: 85px;" class="x-form-element">
															<input type="text" name="scd_edate" id="scd_edate" autocomplete="off" size="16" class="x-form-text x-form-field " style="width: auto;">
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
														<label class="x-form-item-label" style="width: auto;" for="scd_time_to" ><font color="red"> </font>종료시간 :</label>
														<div style="padding-left: 85px;" class="x-form-element">
															<input type="text" name="scd_time_to" id="scd_time_to" autocomplete="off" size="7" class=" x-form-text x-form-field" style="width: auto;"> ex 18:30:00
														</div>	
													</div>
												</div>
											</div>
										</div>
									</div>
									<!-- DETAIL 6_ROW End -->
									
									<!-- DETAIL 4_ROW Start -->
									<div class="x-column-inner" style="width: 100%; margin-top: 0.2em;">
										<div class=" x-panel x-column" style="width: 50%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label class="x-form-item-label" style="width: auto;" for="status_val" ><font color="red"> </font>일정상태값 :</label>
														<div style="padding-left: 85px;" class="x-form-element">
															<select name="status_val" id="status_val" title="일정상태값" style="width: 122px;" type="text" class="x-form-select x-form-field">
																<option value="">선택하세요</option>
																<c:forEach items="${STATUS_VAL}" var="data" varStatus="status">
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
										<div class=" x-panel x-column" style="width: 50%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label class="x-form-item-label" style="width: auto;" for="work_pattern_code" ><font color="red"> </font>내근/외근 :</label>
														<div style="padding-left: 85px;" class="x-form-element"> 
															<select name="work_pattern_code" id="work_pattern_code" title="내근/외근" style="width: 122px;" type="text" class="x-form-select x-form-field">
																<option value="">선택하세요</option>
																<c:forEach items="${WORK_TYPE_CODE}" var="data" varStatus="status">
																<option value="${fn:trim(data.COM_CODE)}"><c:out value="${data.COM_CODE_NAME}"/></option>
																</c:forEach>
															</select>
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>
									<!-- DETAIL 4_ROW End -->
									
									
									
									<div class="x-column-inner" style="width: 100%;">
										<div class=" x-panel x-column" style="width: 50%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label class="x-form-item-label" style="width: auto;" for="scd_time" ><font color="red"> </font>소요시간:</label>
														<div style="padding-left: 85px;" class="x-form-element">
															<input type="text" name="scd_time" id="scd_time" autocomplete="off" size="20" class=" x-form-text x-form-field" style="width: auto;"> 
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
														<label class="x-form-item-label" style="width: auto;" for="labor_cost" ><font color="red"> </font>인건비 :</label>
														<div style="padding-left: 85px;" class="x-form-element">
															<input type="text" name="labor_cost" id="labor_cost" autocomplete="off" size="20" class=" x-form-text x-form-field" style="width: auto;" style="IME-MODE:disabled;text-align:right" onkeyPress="return _chkKeyPressNumOnly(this)" onBlur="_numFormat(this, Math.round(this.value));" onfocus="_removeComma(this, this.value)">
														</div>
														<div class="x-form-clear-left">
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>
									
									
									<!-- DETAIL 7_ROW Start -->
									<div class="x-column-inner" style="width: 100%; margin-top: 0.2em;">
										<div class=" x-panel x-column" style="width: 50%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label class="x-form-item-label" style="width: auto;" for="pjt_id" >프로젝트ID :</label>
														<div style="padding-left: 85px;" class="x-form-element">
															<table style="width: 120px;" cellspacing="0" class="x-btn  x-btn-noicon">
																<tr>
																	<td>
																		<input type="text" readonly="readonly" name="pjt_id" id="pjt_id" autocomplete="off" size="15" class=" x-form-text x-form-field" style="width: auto;">
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
																							<button type="button" id="pjt_id_btn" class=" x-btn-text">||</button>
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
													</div>
												</div>
											</div>
										</div>
										<div class=" x-panel x-column" style="width: 50%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label class="x-form-item-label" style="width: auto;" for="pjt_nm" ><font color="red"> </font>프로젝트명 :</label>
														<div style="padding-left: 85px;" class="x-form-element">
															<input readonly="readonly" type="text" name="pjt_nm" id="pjt_nm" autocomplete="off" size="20" class=" x-form-text x-form-field" style="width: auto;">
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
														<label class="x-form-item-label" style="width: auto;" for="task_group_code" >타스크그룹 :</label>
														<div style="padding-left: 85px;" class="x-form-element">
															<select name="task_group_code" id="task_group_code" title="타스크그룹" style="width: 122px;" type="text" class="x-form-select x-form-field">
																<option value="">선택하세요</option>
																<c:forEach items="${TASK_GROUP_CODE}" var="data" varStatus="status">
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
										<div class=" x-panel x-column" style="width: 50%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label class="x-form-item-label" style="width: auto;" for="task_code_nm" >타스크 :</label>
														<div style="padding-left: 85px;" class="x-form-element">
															<input type="text" name="task_code_nm" id="task_code_nm" autocomplete="off" size="20" class=" x-form-text x-form-field" style="width: auto;">
															<input type="hidden" name="task_code" id="task_code" >
														</div>	
													</div>
												</div>
											</div>
										</div>
									</div>
									<!-- DETAIL 8_ROW End -->
									
									<!-- DETAIL 9_ROW Start -->
									<div class="x-column-inner" style="width: 100%; margin-top: 0.2em;">
										<div class=" x-panel x-column" style="width: 50%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label class="x-form-item-label" style="width: auto;" for="pay_no" >지결서번호 :</label>
														<div style="padding-left: 85px;" class="x-form-element">
															<input type="text" name="pay_no" id="pay_no" autocomplete="off" size="20" class="x-form-text x-form-field " style="width: auto;">
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
														<label class="x-form-item-label" style="width: auto;" for="visit_report_no" >방문일지번호 :</label>
														<div style="padding-left: 85px;" class="x-form-element">
															<input type="text" name="visit_report_no" id="visit_report_no" autocomplete="off" size="20" class=" x-form-text x-form-field" style="width: auto;">
														</div>	
													</div>
												</div>
											</div>
										</div>
									</div>
									<!-- DETAIL 9_ROW End -->
									
									
									
									
									<div class="x-column-inner" style="width: 100%;">
										<div class=" x-panel x-column" style="width: 100%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label class="x-form-item-label" style="width: auto;" for="note" >비고:</label>
														<div style="padding-left: 85px;" class="x-form-element">
															<textarea name="note" id="note" autocomplete="off" class=" x-form-text x-form-field" style="width:375; height:60px"></textarea>
														</div>
														<div class="x-form-clear-left">
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>
									
									
									<!-- 11_ROW Start -->
									<div class="x-column-inner" style="width: 100%;">
										<div class=" x-panel x-column" style="width: 50%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label class="x-form-item-label" style="width: auto;" for="pjt_status" >진행상태:</label>
														<div style="padding-left: 85px;" class="x-form-element">
															<select name="pjt_status" id="pjt_status" title="진행상태코드" style="width: 122px;" class=" x-form-select x-form-field">
																<option value="">선택하세요</option>
																<c:forEach items="${PJT_STATUS}" var="data" varStatus="status">
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
 													 
													</div>
												</div>
											</div>
										</div>
									</div>
									<!-- 11_ROW End -->
									
									<!-- 13_ROW Start -->
									<div class="x-column-inner" style="width: 100%;">
										<div class=" x-panel x-column" style="width: 50%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label class="x-form-item-label" style="width: auto;" for="final_mod_id" >최종변경자ID:</label>
														<div style="padding-left: 85px;" class="x-form-element">
															<input type="text" name="final_mod_id" id="final_mod_id" autocomplete="off" size="20" class=" x-form-text x-form-field" style="width: auto;">
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
														<label class="x-form-item-label" style="width: auto;" for="final_mod_date" >최종변경일시:</label>
														<div style="padding-left: 90px;" class="x-form-element">
															<input type="text" name="final_mod_date" id="final_mod_date" autocomplete="off" size="20" class=" x-form-text x-form-field" style="width: auto;">
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
		<%-- 
		<tr>
			<td colspan="2" align="center" height="35">
				<table>
					<tr>
						<td>
						 
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
						 
						</td>
						<td width="1">
						</td>
						<td>
						 
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
						 
						</td>
					</tr> 
				</table>
			</td>
		</tr>
	 --%>
	 <input type="hidden" id="updateBtn" name="updateBtn"/>
	 <input type="hidden" id="saveBtn" name="saveBtn"/>
	</table>
</body>

<%@ include file="/WEB-INF/web/jsp/sgis-bottom-inc.jsp" %>