<%--
  Class Name  : scdInfoMngList.jsp
  Description :  프로젝트 일정관리
  Modification Information
 
      수정일                   수정자                 수정내용
  -------      --------    ---------------------------
  2011. 3. 21   이준영            최초 생성   
  
  author   : 이준영
  since    : 2011. 3. 21.
  version  : 1.0
   
  Copyright (C) 2011 by SG All right reserved.
--%>

<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/web/jsp/common/inc/commonInc.jsp" %>
<html>
<head>

<script type="text/javascript" src="/resource/common/js/sgis-comm-inc.js" ></script> 
<script type="text/javascript" src="/resource/common/js/common/common-msg-box.js" ></script> 
<script type="text/javascript" src="/resource/common/js/ajax.js" ></script>
<script type="text/javascript" src="/resource/common/js/grid/grid_1st.js"></script>
<script type="text/javascript" src="/resource/common/js/grid/grid_edit_1st.js"></script>  
<script type="text/javascript" src="/resource/common/js/grid/grid_edit_2nd.js"></script>
<script type="text/javascript">
/***************************************************************************
 *   초기값 설정 
 ***************************************************************************/
var	gridHeigth_1st 	 	= 400; 							// 그리드 전체 높이
var	gridWidth_1st		= 333;							// 그리드 전체 폭
var gridTitle_1st 		= "개발프로젝트";	  			// 그리드 제목
var	render_1st			= "pjt_info_grid";		// 렌더(화면에 그려질) 할 id 
var	pageSize_1st		= 15;	  						// 그리드 페이지 사이즈	
var	proxyUrl_1st		= "/dev/scdInfo/result.sg";  // 결과 값 페이지
var limit_1st			= pageSize_1st;
var start_1st			= 0;

// 그리드의 페이지 클릭시 검색조건값을 DB로 전송
function fnPagingValue_1st(){
	
	try{
		GridClass_1st.store.setBaseParam('start'		 	  ,start_1st);
	    GridClass_1st.store.setBaseParam('limit'		 	  ,limit_1st);

		GridClass_1st.store.setBaseParam('src_pjt_name'		,Ext.get('src_pjt_name').getValue());
		GridClass_1st.store.setBaseParam('src_pjt_date_from'	,Ext.get('src_pjt_date_from').getValue());
		GridClass_1st.store.setBaseParam('src_pjt_date_to'	,Ext.get('src_pjt_date_to').getValue());
		GridClass_1st.store.setBaseParam('pjt_type_code'	,Ext.get('pjt_type_code').getValue());
	}catch(e){

	}
}
   
// Grid의 컬럼 설정
var userColumns_1st =  [ {header: '조회상태'                 ,width: 60  ,sortable: true ,dataIndex: 'FLAG'                     ,hidden : true}              
							, {header: '프로젝트ID'               ,width: 60  ,sortable: true ,dataIndex: 'PJT_ID'                    }              
							, {header: '프로젝트명'               ,width: 60  ,sortable: true ,dataIndex: 'PJT_NAME'             	 }
							, {header: '개발프로젝트순번'         ,width: 60  ,sortable: true ,dataIndex: 'PJT_INFO_SEQ'             ,hidden : true}               
							, {header: '업무요청유형코드'         ,width: 60  ,sortable: true ,dataIndex: 'CSR_TYPE_CODE'      		,hidden : true}              
							, {header: '업무요청ID'               ,width: 60  ,sortable: true ,dataIndex: 'CSR_ID'              		,hidden : true}
							, {header: '업무요청순번'        	 ,width: 60  ,sortable: true ,dataIndex: 'CSR_INFO_SEQ'         		,hidden : true}
							, {header: '영업 프로젝트ID'          ,width: 60  ,sortable: true ,dataIndex: 'SAL_PJT_ID'     			,hidden : true}              
							, {header: '업무요청구분명'   		 ,width: 60  ,sortable: true ,dataIndex: 'CSR_TYPE_NAME'         	,hidden : true}
							, {header: '제품코드'       			 ,width: 60  ,sortable: true ,dataIndex: 'ITEM_CODE'           	  	 ,hidden : true}
							, {header: '제품명'             		 ,width: 60  ,sortable: true ,dataIndex: 'ITEM_NAME'            	 }
							, {header: '진행상태코드'          	 ,width: 60  ,sortable: true ,dataIndex: 'PROC_STATUS_CODE'         ,hidden : true}
							, {header: '진행상태명'         		 ,width: 60  ,sortable: true ,dataIndex: 'PROC_STATUS_NAME'     	 ,hidden : true}
							, {header: '최종변경자ID'   			 ,width: 60  ,sortable: true ,dataIndex: 'FINAL_MOD_ID'         	,hidden : true}              
							, {header: '최종변경일시'       		 ,width: 60  ,sortable: true ,dataIndex: 'FINAL_MOD_DATE'           ,hidden : true}
						];	 


var mappingColumns_1st =  [ {name: 'FLAG'              , allowBlank: false        }    	//'조회상태'             
							, {name: 'PJT_ID'            , allowBlank: false        }        //'프로젝트ID'       
							, {name: 'PJT_NAME'   		, allowBlank: false        }        //'프로젝트명' 
							, {name: 'PJT_INFO_SEQ'     	, allowBlank: false        }        //'개발프로젝트순번'  
							, {name: 'CSR_TYPE_CODE'     , allowBlank: false        }        //'업무요청유형코드'    
							, {name: 'CSR_ID'      		, allowBlank: false        }        //'업무요청ID'   
							, {name: 'CSR_INFO_SEQ'     	, allowBlank: false        }        //'업무요청순번'   
							, {name: 'SAL_PJT_ID'       	, allowBlank: false        }        //'영업 프로젝트ID'  
							, {name: 'CSR_TYPE_NAME' 	, allowBlank: false        }        //'업무요청구분명'  
							, {name: 'ITEM_CODE'   		, allowBlank: false        }        //'제품코드'     
							, {name: 'ITEM_NAME' 		, allowBlank: false        }        //'제품명'      
							, {name: 'PROC_STATUS_CODE'  , allowBlank: false        }        //'진행상태코드'   
							, {name: 'PROC_STATUS_NAME'  , allowBlank: false        }        //'진행상태명'    
							, {name: 'FINAL_MOD_ID'     	, allowBlank: false        }        //'최종변경자ID'  
							, {name: 'FINAL_MOD_DATE'    , allowBlank: false        }        //'최종변경일시'   
						];
 
/***************************************************************************
 * 견적기본정보 --- 그리드 클릭시 Event
 ***************************************************************************/
function fnGridOnClick_1st(store, rowIndex){
	
/*
	fnInitValue();
	
	
	var tmpfrom = store.getAt(rowIndex).data.PJT_DATE_FROM.substring(0, 4)+"-"+store.getAt(rowIndex).data.PJT_DATE_FROM.substring(4, 6)+"-"+store.getAt(rowIndex).data.PJT_DATE_FROM.substring(6, 8);
	var tmpto = store.getAt(rowIndex).data.PJT_DATE_TO.substring(0, 4)+"-"+store.getAt(rowIndex).data.PJT_DATE_TO.substring(4, 6)+"-"+store.getAt(rowIndex).data.PJT_DATE_TO.substring(6, 8);

	Ext.get('pjt_date_from').set({value : fnFixNull(store.getAt(rowIndex).data.PJT_DATE_FROM)}, false);				//프로젝트 기간 from
	Ext.get('pjt_date_from_tmp').set({value : fnFixNull(tmpfrom)}, false);			//프로젝트 기간 from
	Ext.get('pjt_date_to').set({value : fnFixNull(store.getAt(rowIndex).data.PJT_DATE_TO)}, false);					//프로젝트 기간 to
	Ext.get('pjt_date_to_tmp').set({value : fnFixNull(tmpto)}, false);				//프로젝트 기간 to
	Ext.get('pjt_reg_date').set({value : fnFixNull(store.getAt(rowIndex).data.PJT_REG_DATE)}, false);				//등록일자
	Ext.get('pjt_reg_date_tmp').set({value : fnFixNull(store.getAt(rowIndex).data.PJT_REG_DATE)}, false);			//등록일자
	Ext.get('pjt_reg_dept_code').set({value : fnFixNull(store.getAt(rowIndex).data.PJT_REG_DEPT_CODE)}, false);			//등록자 부서코드
	Ext.get('pjt_reg_dept_name').set({value : fnFixNull(store.getAt(rowIndex).data.PJT_REG_DEPT_NAME)}, false);			//등록자 부서명
	Ext.get('pjt_reg_emp_num').set({value : fnFixNull(store.getAt(rowIndex).data.PJT_REG_EMP_NUM)}, false);				//등록자사번
	Ext.get('pjt_reg_emp_name').set({value : fnFixNull(store.getAt(rowIndex).data.PJT_REG_EMP_NAME)}, false);			//등록자명
	Ext.get('pjt_own_dept_code').set({value : fnFixNull(store.getAt(rowIndex).data.PJT_OWN_DEPT_CODE)}, false);			//책임자 부서코드
	Ext.get('pjt_own_dept_name').set({value : fnFixNull(store.getAt(rowIndex).data.PJT_OWN_DEPT_NAME)}, false);			//책임자 부서명
	Ext.get('pjt_own_emp_num').set({value : fnFixNull(store.getAt(rowIndex).data.PJT_OWN_EMP_NUM)}, false);			//책임자 사번
	Ext.get('pjt_own_emp_name').set({value : fnFixNull(store.getAt(rowIndex).data.PJT_OWN_EMP_NAME)}, false);			//책임자명
	Ext.get('pjt_id').set({value : fnFixNull(store.getAt(rowIndex).data.PJT_ID)}, false);						//프로젝트ID
	Ext.get('pjt_name').set({value : fnFixNull(store.getAt(rowIndex).data.PJT_NAME)}, false);					//프로젝트명
	Ext.get('roll_type_code').set({value : fnFixNull(store.getAt(rowIndex).data.ROLL_TYPE_CODE)}, false);				//사업구분
	Ext.get('pay_free_code').set({value : fnFixNull(store.getAt(rowIndex).data.PAY_FREE_CODE)}, false);				//유무상구분
	Ext.get('pjt_summary').set({value : fnFixNull(store.getAt(rowIndex).data.PJT_SUMMARY)}, false);					//개요 및 특의사항
	Ext.get('note').set({value : fnFixNull(store.getAt(rowIndex).data.NOTE)}, false);								//비고
	
	Ext.get('proc_status_code_tmp').set({value : fnFixNull(store.getAt(rowIndex).data.PROC_STATUS_CODE)}, false);		//진행상태
	Ext.get('proc_status_code').set({value : fnFixNull(store.getAt(rowIndex).data.PROC_STATUS_CODE)}, false);			//진행상태
	
	
	Ext.get('final_mod_id').set({value : fnFixNull(store.getAt(rowIndex).data.FINAL_MOD_ID)}, false);				//최종변경자ID
	Ext.get('final_mod_date').set({value : fnFixNull(store.getAt(rowIndex).data.FINAL_MOD_DATE)}, false);				//최종변경일시
	Ext.get('reg_id').set({value : fnFixNull(store.getAt(rowIndex).data.REG_ID)}, false);								//최초등록자
	Ext.get('reg_date').set({value : fnFixNull(store.getAt(rowIndex).data.REG_DATE)}, false);						//최초등록일      
*/


	var keyValue1 = fnFixNull(store.getAt(rowIndex).data.PJT_ID);		 // 프로젝트ID

	
	// 버튼 disable
	//Ext.get('saveBtn').dom.disabled   = true;
	//Ext.get('updateBtn').dom.disabled = false;

	
	fnSearchEdit1st(keyValue1);
	
	GridClass_edit_2nd.store.removeAll();

}   

// 타스크정보 조회
function fnSearchEdit1st(keyValue1){
	
	
	Ext.Ajax.request({
		url: "/dev/scdInfo/result_edit_1st.sg" 
		,success: function(response){						// 조회결과 성공시
					// 조회된 결과값, store명
					//handleSuccess(response,GridClass_edit_1st);
					
					GridClass_edit_1st.store.commitChanges();	// 변경된 record를 commit
					GridClass_edit_1st.store.removeAll();		// store자료를 삭제
						
					// 조회된 결과값, store명
					var json = Ext.util.JSON.decode(response.responseText);
										
					GridClass_edit_1st.store.loadData(json);					
					
		          }
		,failure: handleFailure 
		,params : {
				   // 페이지 		
					 limit			: limit_edit_1st
				   , start			: start_edit_1st
				   // 키 value
				   , pjt_id			: keyValue1
				   ,scd_type_code   : Ext.get('scd_type_code').getValue()
				  }				
	}); // end Ext.Ajax.request   
}



// 타스크 담당자 조회
function fnSearchEdit2nd(keyValue2){
	
	Ext.Ajax.request({
		url: "/dev/scdInfo/result_edit_2nd.sg" 
		,success: function(response){						// 조회결과 성공시
					// 조회된 결과값, store명
					//handleSuccess(response,GridClass_edit_2nd);
					
					GridClass_edit_2nd.store.commitChanges();	// 변경된 record를 commit
					GridClass_edit_2nd.store.removeAll();		// store자료를 삭제
						
					// 조회된 결과값, store명
					var json = Ext.util.JSON.decode(response.responseText);
										
					GridClass_edit_2nd.store.loadData(json);							
		          }
		,failure: handleFailure 
		,params : {
				   // 페이지 		
					 limit			: limit_edit_2nd
				   , start			: start_edit_2nd
				   // 키 value
				   , scd_plan_seq			: keyValue2
				  }				
	}); // end Ext.Ajax.request   
}


/***************************************************************************
 * 설  명 : 편집그리드 설정 (개발프로젝트관리)
***************************************************************************/
var	gridHeigth_edit_1st	= 400; 	
var	gridWidth_edit_1st  = 333;	
var	gridTitle_edit_1st  = "타스크 정보"	; 
var	render_edit_1st		= "edit_grid_1st";
var keyNm_edit_1st		= "SCD_PLAN_SEQ";
var pageSize_edit_1st	= 999;
var limit_edit_1st		= pageSize_edit_1st;
var start_edit_1st		= 0;
var proxyUrl_edit_1st	= "/dev/scdInfo/result_edit_1st.sg";
var gridRowDeleteYn	    = "Y";
var tbarHidden_edit_1st = "N";

// 행추가
function addNew_edit_1st(){

	var selRecord = GridClass_1st.grid.selModel.getSelections(); // 선택된 프로젝트 기본정보


	var rowTotCnt = GridClass_edit_1st.store.getCount();	//타스크 정보
	
	if(selRecord.length == 0 && rowTotCnt ==0)		
	{
		Ext.Msg.alert('확인', '프로젝트를 선택하십시오');
		return;
	}

	taskInfoPop("multiSelectYn=Y&requestFieldName=multi");

	
	var edit_1st_rowCnt = GridClass_edit_1st.store.getCount()
	
	for(var k=0;  k < edit_1st_rowCnt; k++){	
	
			if(GridClass_edit_1st.grid.selModel.isSelected(k))
			{
				GridClass_edit_1st.grid.selModel.deselectRow(k);			
			}

	}  

	GridClass_edit_2nd.store.commitChanges();	// 변경된 record를 commit
	GridClass_edit_2nd.store.removeAll();		// store자료를 삭제

   
}





/***************************************************************************
 * 설  명 : 삭제버튼 클릭-DB삭제
 ***************************************************************************/
function fnGridDeleteRow(selectedRecord){
	
	var json = "["+Ext.util.JSON.encode(selectedRecord.data)+"]";

	var sForm = document.searchForm;

	sForm.src_pjt_date_from.value = sForm.src_pjt_date_from_tmp.value.replaceAll('-','');		   	 
	sForm.src_pjt_date_to.value = sForm.src_pjt_date_to_tmp.value.replaceAll('-','');	
	
	var rowTotCnt = GridClass_edit_1st.store.getCount();
	
	var selRecord_1st = GridClass_1st.grid.selModel.getSelections();

	
	Ext.Ajax.request({   
		url: "/dev/scdInfo/deleteScdPlanInfo.sg"   
		,success: function(response){						// 조회결과 성공시
					// 조회된 결과값, store명

					//handleSuccess(response,GridClass_edit_1st);

					var jsoneRspons = Ext.util.JSON.decode(response.responseText);
//alert("json-22-searchScdPlanSeq--->"+jsoneRspons.searchScdPlanSeq);

					if(jsoneRspons.success =="false")
					{
						Ext.Msg.alert('확인', jsoneRspons.message);
					}

					GridClass_edit_1st.store.commitChanges();	// 변경된 record를 commit
					GridClass_edit_1st.store.removeAll();		// store자료를 삭제
						
					GridClass_edit_1st.store.loadData(jsoneRspons);		


					if(jsoneRspons.searchScdPlanSeq !="")
					{
						fnSearchEdit2nd(jsoneRspons.searchScdPlanSeq);
					}					
					
		          }
		,failure: handleFailure   	    // 조회결과 실패시  
		,form   : document.searchForm   // 검색 FORM
		,params : { 
					limit          		: limit_edit_1st
				   , start         		: start_edit_1st
				   ,deleteData : json
				   ,pjt_id : selectedRecord.data.PJT_ID
				   ,scd_plan_seq : selectedRecord.data.SCD_PLAN_SEQ
				   ,checkTaskCode :selectedRecord.data.TASK_CODE
				   ,checkPjtId :selectedRecord.data.PJT_ID
				   ,rowTotCnt : rowTotCnt
				   ,pjt_name : selRecord_1st[0].data.PJT_NAME
			      } 
	});
	
	
	fnInitValue(); // 상세필드 초기화
}



// 페이징
function fnPagingValue_edit_1st(){	
	

	try{
		var record = GridClass_edit_1st.grid.selModel.getSelections();
	
		GridClass_edit_1st.store.setBaseParam('start'		,start_edit_1st);
	    GridClass_edit_1st.store.setBaseParam('limit'		,limit_edit_1st);
	    GridClass_edit_1st.store.setBaseParam('pjt_id'		,record[0].data.PJT_ID);
	    GridClass_edit_1st.store.setBaseParam('scd_type_code'		,Ext.get('scd_type_code').getValue());
	    
	    
	}catch(e){

	}
}


 renderDate=function(value,p,record){

  if (value == null || value == undefined) {
   return ;
  } 

  if ( typeof(value) != 'Number' )
  {
     value = String(value)
  }

  if(value.length!=8)
  {
  	Ext.Msg.alert('확인', '정확한 날짜를 입력하십시오');
  	return;
  }

  return Date.parseDate(value.substr(0,4)+"-"+value.substr(4,2)+"-"+value.substr(6,2), "Y-m-d").format('Y-m-d');

  
 
 }


// 그리드 필드
var	userColumns_edit_1st	= [ {header: '조회상태'                 ,width: 60  ,sortable: true ,dataIndex: 'FLAG'                      ,hidden : true}              
							   , {header: '* 순번'             ,width: 50  ,sortable: true ,dataIndex: 'SCD_PLAN_SEQ_TMP'    		 ,		editor: new Ext.form.TextField({ allowBlank : false }), editable:false, renderer: changeBLUE}
							   , {header: '순번'             ,width: 60  ,sortable: true ,dataIndex: 'SCD_PLAN_SEQ'    	 ,hidden : true}
							   , {header: '일정구분코드'             ,width: 60  ,sortable: true ,dataIndex: 'SCD_TYPE_CODE'    	 ,hidden : true}
							   , {header: '타스크 코드'                 ,width: 60  ,sortable: true ,dataIndex: 'TASK_CODE'          ,hidden : true }
							   , {header: '타스크명'                 ,width: 60  ,sortable: true ,dataIndex: 'TASK_NAME'              }
							   , {header: '책임자부서'               ,width: 60  ,sortable: true ,dataIndex: 'SCD_DEPT'        ,hidden : true}      
							   , {header: '책임자 사번'          ,width: 60  ,sortable: true ,dataIndex: 'SCD_REG_EMP_NUM'      ,hidden : true }              
							   , {header: '책임자명'          ,width: 60  ,sortable: true ,dataIndex: 'SCD_REG_EM_NAME'       }              
							   , {header: '계획내용'          ,width: 60  ,sortable: true ,dataIndex: 'SCD_CONTENT'     ,hidden : true}              
							   , {header: '프로젝트ID'         ,width: 60  ,sortable: true ,dataIndex: 'PJT_ID'             ,hidden : true}               
							   , {header: '타스크그룹코드'               ,width: 60  ,sortable: true ,dataIndex: 'TASK_GROUP_CODE',hidden : true }              
							   , {header: '시작일자'             ,width: 60  ,sortable: true ,dataIndex: 'SCD_PLAN_FROM_DATE'    		,renderer:renderDate, editor : new Ext.form.NumberField( { allowBlank : false }) }
							   , {header: '종료일자'               ,width: 60  ,sortable: true ,dataIndex: 'SCD_PLAN_TO_DATE'        ,renderer:renderDate, editor : new Ext.form.NumberField( { allowBlank : false }) }              
							   , {header: '비고'        ,width: 60  ,sortable: true ,dataIndex: 'NOTE'             ,hidden : true}
							   , {header: '최종변경자ID'             ,width: 60  ,sortable: true ,dataIndex: 'FINAL_MOD_ID'              ,hidden : true}
							   , {header: '최종변경일시'             ,width: 60  ,sortable: true ,dataIndex: 'FINAL_MOD_DATE'    		 ,hidden : true}
							   ];	

// 맵핑 필드
var	mappingColumns_edit_1st	= [  
							    {name: "FLAG", 		type:"string", mapping: "FLAG"}
							  , {name: "SCD_PLAN_SEQ_TMP", 			type:"string", mapping: "RNUM"}
							  , {name: "SCD_PLAN_SEQ", 			type:"string", mapping: "SCD_PLAN_SEQ"}
							  , {name: "SCD_TYPE_CODE", 			type:"string", mapping: "SCD_TYPE_CODE"}
							  , {name: "TASK_CODE", 				type:"string", mapping: "TASK_CODE"}
							  , {name: "TASK_NAME", 				type:"string", mapping: "TASK_NAME"}
							  , {name: "SCD_DEPT", 			type:"string", mapping: "SCD_DEPT"}
							  , {name: "SCD_REG_EMP_NUM", 		type:"string", mapping: "SCD_REG_EMP_NUM"}
							  , {name: "SCD_REG_EM_NAME", 		type:"string", mapping: "SCD_REG_EM_NAME"}
							  , {name: "SCD_CONTENT", 		type:"string", mapping: "SCD_CONTENT"}
							  , {name: "PJT_ID", 		type:"string", mapping: "PJT_ID"}
							  , {name: "TASK_GROUP_CODE", 		type:"string", mapping: "TASK_GROUP_CODE"}
							  , {name: "SCD_PLAN_FROM_DATE", 			type:"string", mapping: "SCD_PLAN_FROM_DATE"}
							  , {name: "SCD_PLAN_TO_DATE", 			type:"string", mapping: "SCD_PLAN_TO_DATE"}
							  , {name: "NOTE", 		type:"string", mapping: "NOTE"}   
							  , {name: "FINAL_MOD_ID", 		type:"string", mapping: "FINAL_MOD_ID"}   
							  , {name: "FINAL_MOD_DATE", 	type:"string", mapping: "FINAL_MOD_DATE"} 
	    				 	  ]; 
 

/***************************************************************************
 * 설  명 : 편집그리드 설정 (개발프로젝트장비정보)
***************************************************************************/
var	gridHeigth_edit_2nd	= 400; 	
var	gridWidth_edit_2nd  = 333;	
var	gridTitle_edit_2nd  = "타스크 담당자 정보"	; 
var	render_edit_2nd		= "edit_grid_2nd";
var keyNm_edit_2nd		= "SCD_DUTY_SEQ";
var pageSize_edit_2nd	= 999;
var limit_edit_2nd		= pageSize_edit_2nd;
var start_edit_2nd		= 0;
var proxyUrl_edit_2nd	= "/dev/scdInfo/result_edit_2nd.sg";
var grid2ndRowDeleteYn  = "Y";
var tbarHidden_edit_2nd ="N";

// 행추가
function addNew_edit_2nd(){


	var selRecord = GridClass_edit_1st.grid.selModel.getSelections();
	
	if(selRecord.length == 0 )		
	{
		Ext.Msg.alert('확인', '타스크를 선택하십시오');
		return;
	}else
	{
		var checkCode = selRecord[0].data.TASK_CODE;
	    var selScdPlanSeq = selRecord[0].data.SCD_PLAN_SEQ;			//선택한 타스크 정보그리드의 키	
	
		if(checkCode == '')
		{
			Ext.Msg.alert('확인', '타스크를 선택하십시오');
			return;
		}else
		{
			var Plant = GridClass_edit_2nd.grid.getStore().recordType; 
		    var p = new Plant({ FLAG 			: 'I' 
							  , SCD_PLAN_SEQ 	: selScdPlanSeq
							  , DEPT_CODE		: ''
							  , DEPT_NAME		: ''
							  , EMP_NUM         : ''
							  , EMP_NAME        : ''
							  , SCD_PLAN_FROM_DATE : getToDay(0)
							  , SCD_PLAN_TO_DATE   : getToDay(0)
							  , NOTE        : ''
							  , TASK_CODE    :selRecord[0].data.TASK_CODE
				    		 }); 
		  	GridClass_edit_2nd.grid.stopEditing();
			GridClass_edit_2nd.store.insert(0, p);
			GridClass_edit_2nd.grid.startEditing(0, 0);		
		
		}	
	}
	
}


/***************************************************************************
 * 설  명 : 삭제버튼 클릭-DB삭제
 ***************************************************************************/
function fnGridDeleteRow2nd(selectedRecord){

	var json = "["+Ext.util.JSON.encode(selectedRecord.data)+"]";

	var sForm = document.searchForm;

	sForm.src_pjt_date_from.value = sForm.src_pjt_date_from_tmp.value.replaceAll('-','');		   	 
	sForm.src_pjt_date_to.value = sForm.src_pjt_date_to_tmp.value.replaceAll('-','');	
	
	var selRecord = GridClass_edit_1st.grid.selModel.getSelections();
	

	Ext.Ajax.request({   
		url: "/dev/scdInfo/deleteScdDutyAssign.sg"   
		,success: function(response){						// 조회결과 성공시
					// 조회된 결과값, store명
					handleSuccess(response,GridClass_edit_2nd);
					var jsoneRspons = Ext.util.JSON.decode(response.responseText);
					

					if(jsoneRspons.success == "false")
					{
						Ext.Msg.alert('확인', jsoneRspons.message);
					}					

					if(jsoneRspons.searchPjtId !="")
					{
						fnSearchEdit1st(jsoneRspons.searchPjtId);
					}					
					
		          }
		,failure: handleFailure   	    // 조회결과 실패시  
		,form   : document.searchForm   // 검색 FORM
		,params : { 
					limit          		: limit_edit_2nd
				   , start         		: start_edit_2nd
				   ,deleteData : json
				   ,searchPjtId : selRecord[0].data.PJT_ID
				   ,searchScdPlanSeq : selRecord[0].data.SCD_PLAN_SEQ
				   ,checkPjtId : selRecord[0].data.PJT_ID
				   ,checkTaskCode : selectedRecord.data.TASK_CODE
				   ,checkRegEmpNum : selectedRecord.data.EMP_NUM 
			      } 
	});
	
	
	fnInitValue(); // 상세필드 초기화

}



// 페이징
function fnPagingValue_edit_2nd(){	
	try{
		var record = GridClass_edit_2nd.grid.selModel.getSelections();
		
		GridClass_edit_2nd.store.setBaseParam('start'		,start_edit_2nd);
	    GridClass_edit_2nd.store.setBaseParam('limit'		,limit_edit_2nd);
	    GridClass_edit_2nd.store.setBaseParam('scd_plan_seq' ,record[0].data.SCD_PLAN_SEQ);
	}catch(e){

	}
}




// 그리드 필드 
var	userColumns_edit_2nd	= [ 
								{header: "조회상태"                 ,width: 60  ,sortable: true ,dataIndex: "FLAG"                      ,hidden : true}              
							  , {header: "일정계획순번",			width: 10,	sortable: true,	dataIndex: "SCD_PLAN_SEQ"	 ,hidden : true}
							  , {header: "* 순번",		width: 40,	sortable: true,	dataIndex: "SCD_DUTY_SEQ_TMP"		 }
							  , {header: "순번",		width: 40,	sortable: true,	dataIndex: "SCD_DUTY_SEQ"	,hidden : true	 }
							  , {header: "담당부서코드",	width: 50,	sortable: true,	dataIndex: "DEPT_CODE"	 ,hidden : true}
							  , {header: "담당부서명",		width: 50,	sortable: true,	dataIndex: "DEPT_NAME"	 ,hidden : true}
							  , {header: "담당자사번",		width: 60,	sortable: true,	dataIndex: "EMP_NUM" ,hidden : true}
							  , {header: "담당자명",		width: 60,	sortable: true,	dataIndex: "EMP_NAME" , renderer: changeBLUE}
							  , {header: "시작일자",		width: 60,	sortable: true,	dataIndex: "SCD_PLAN_FROM_DATE" ,renderer:renderDate, editor : new Ext.form.NumberField( { allowBlank : false }) }
							  , {header: "종료일자",		width: 60,	sortable: true,	dataIndex: "SCD_PLAN_TO_DATE"  ,renderer:renderDate, editor : new Ext.form.NumberField( { allowBlank : false }) }
							  , {header: "비고",		width: 50,	sortable: true,	dataIndex: "NOTE",	editor: new Ext.form.TextField({ allowBlank : false }) ,hidden : true}
							  , {header: "최종변경자ID",	width: 10,	sortable: true,	dataIndex: "FINAL_MOD_ID",	editor: new Ext.form.TextField({ allowBlank : false }) ,hidden : true}
							  , {header: "최종변경일시",	width: 10,	sortable: true,	dataIndex: "FINAL_MOD_DATE",editor: new Ext.form.TextField({ allowBlank : false }) ,hidden : true}
							  , {header: "타스크 코드",	width: 10,	sortable: true,	dataIndex: "TASK_CODE", hidden : true}
							  ];

// 맵핑 필드
var	mappingColumns_edit_2nd	= [ 
								{name: "FLAG", 		type:"string", mapping: "FLAG"}						// 조회상태"      
							  , {name: "SCD_PLAN_SEQ", 	type:"string", mapping: "SCD_PLAN_SEQ"}									// 일정계획순번",	 
							  , {name: "SCD_DUTY_SEQ_TMP", 		type:"string", mapping: "SCD_DUTY_SEQ_TMP"}								// 순번",		   
							  , {name: "SCD_DUTY_SEQ", 		type:"string", mapping: "SCD_DUTY_SEQ"}								// 순번",		   
							  , {name: "DEPT_CODE", 		type:"string", mapping: "DEPT_CODE"}								// 담당부서코드",	  
							  , {name: "DEPT_NAME", 		type:"string", mapping: "DEPT_NAME"}								// 담당부서명",	  
							  , {name: "EMP_NUM", 		type:"string", mapping: "EMP_NUM"}								// 담당자사번",	
							  , {name: "EMP_NAME", 		type:"string", mapping: "EMP_NAME"}								// 담당자명",	
							  , {name: "SCD_PLAN_FROM_DATE", 			type:"string", mapping: "SCD_PLAN_FROM_DATE"}							// 계획시작일자",	
							  , {name: "SCD_PLAN_TO_DATE",type:"string", mapping: "SCD_PLAN_TO_DATE"}									// 계획종료일자",	
							  , {name: "NOTE", 	type:"string", mapping: "NOTE"}									// 비고",		
							  , {name: "FINAL_MOD_ID", 	type:"string", mapping: "FINAL_MOD_ID"}			// 최종변경자ID",	
							  , {name: "FINAL_MOD_DATE",type:"string", mapping: "FINAL_MOD_DATE"}		// 최종변경일시
							  , {name: "TASK_CODE",type:"string", mapping: "TASK_CODE"}					// 타스크 코드
	    				 	  ]; 

/***************************************************************************
 * 설  명 : 필드 초기화
 **************************************************************************/
function fnInitValue(){

/*
	
	// 버튼 초기화
	Ext.get('saveBtn').dom.disabled    	   = false;
	Ext.get('updateBtn').dom.disabled  	   = true;
*/

	
	try{
		GridClass_edit_1st.store.commitChanges();	// 변경된 record를 commit
		GridClass_edit_1st.store.removeAll();		// store자료를 삭제
		GridClass_edit_2nd.store.commitChanges();
		GridClass_edit_2nd.store.removeAll();
	}catch(e){

	}
}

/***************************************************************************
 * 설  명 : 검색
 **************************************************************************/
function fnSearch(){  	

	var sForm = document.searchForm;

	sForm.src_pjt_date_from.value = sForm.src_pjt_date_from_tmp.value.replaceAll('-','');		   	 
	sForm.src_pjt_date_to.value = sForm.src_pjt_date_to_tmp.value.replaceAll('-','');	


	if(Ext.get('src_pjt_date_from').getValue() =='')
	{
		Ext.Msg.alert('확인', '프로젝트 시작일을 선택하세요');
		return;
	}
	if(Ext.get('src_pjt_date_to').getValue() =='')
	{
		Ext.Msg.alert('확인', '프로젝트 종료일을 선택하세요');
		return;
	}


	Ext.Ajax.request({   
		url: "/dev/scdInfo/result.sg"
		,method : 'POST'   
		,success: function(response){						// 조회결과 성공시
					// 조회된 결과값, store명
					handleSuccess(response,GridClass_1st);
		          }
		,failure: handleFailure   	   // 조회결과 실패시  
		,form   : document.searchForm // 검색 FORM
		,params : {					   // 조회조건을 DB로 전송하기위해서 조건값 설정
					limit          : limit_1st
				  , start          : start_1st
				  // 검색정보
				  }				
	});  

	
	fnInitValue();
	
}  		

/***************************************************************************
 * 설  명 : 저장버튼 클릭
 ***************************************************************************/
function fnSave(){  	

	var sForm = document.searchForm;
	sForm.src_pjt_date_from.value = sForm.src_pjt_date_from_tmp.value.replaceAll('-','');		   	 
	sForm.src_pjt_date_to.value = sForm.src_pjt_date_to_tmp.value.replaceAll('-','');	

	var selRecord = GridClass_edit_1st.grid.selModel.getSelections();

	var selRecord_1st = GridClass_1st.grid.selModel.getSelections();


	// 변경된 프로젝트 상세(제품)정보 Grid의 record 
	var records = GridClass_edit_1st.store.getModifiedRecords();	
	var rowTotCnt = GridClass_edit_1st.store.getCount();

	if(rowTotCnt == 0){
	   Ext.Msg.alert('확인', '타스크 정보를 선택하십시오.'); 
	   return;
	}	



	for(var k=0;  k < records.length; k++){	//기존 데이타 전체 검색
		
		var recodeAt = records[k];
		
		if(recodeAt.data.FLAG != 'D')
		{
			var data_from = recodeAt.data.SCD_PLAN_FROM_DATE;       //기존 데이타
			var data_to = recodeAt.data.SCD_PLAN_TO_DATE;       //기존 데이타
		 	
	//alert("-data_from-->"+data_from+":--data_to-->:"+data_to);	
			
			if( parseInt(data_from) > parseInt(data_to))
			{	
				 Ext.Msg.alert('확인', '시작일이 종료일보다 이전입니다.'); 
				return;
			}
		}
	
	}
	

	  
	// 변경된 record의 자료를 json형식으로
    var edit1stJson = "[";
	    for (var i = 0; i < records.length; i++) {
	      
	     if(records[i].data.FLAG != 'D')
	      { 
		      edit1stJson += Ext.util.JSON.encode(records[i].data);				
		      if (i < (records.length-1)) {
		        edit1stJson += ",";
		      }
		  }
	    }
    	edit1stJson += "]"
    	
    	
	// 변경된 프로젝트 장비정보 Grid의 record
	var record2 = GridClass_edit_2nd.store.getModifiedRecords();	  
	var rowTotCnt2 = GridClass_edit_2nd.store.getCount();

	
	if(rowTotCnt2 == 0)
	{
		Ext.Msg.alert('확인', '담당자가 없는 타스크가 있습니다.'); 
		return;
	}

	if(selRecord.length > rowTotCnt2)
	{
		Ext.Msg.alert('확인', '담당자가 없는 타스크가 있습니다.'); 
		return;
	}

	
	for(var k=0;  k < record2.length; k++){	//기존 데이타 전체 검색

		var recodeAt = record2[k];
		
		if(recodeAt.data.FLAG != 'D')
		{
			var data_from = recodeAt.data.SCD_PLAN_FROM_DATE;       //기존 데이타
			var data_to = recodeAt.data.SCD_PLAN_TO_DATE;       //기존 데이타
		 	
			
			if( parseInt(data_from) > parseInt(data_to))
			{	
				 Ext.Msg.alert('확인', '시작일이 종료일보다 이전입니다.'); 
				return;
			}
		}
				
	}	
	
	
	var regEmpNnumChk =0;
	// 변경된 record의 자료를 json형식으로
    var edit2ndJson = "[";
	    for (var i = 0; i < record2.length; i++) {
		    
		    if(record2[i].data.FLAG != 'D')
	      	{
				if(record2[i].data.EMP_NUM =="")
				{
					regEmpNnumChk ++;
				}

		      edit2ndJson += Ext.util.JSON.encode(record2[i].data);				
		      if (i < (record2.length-1)) {
		        edit2ndJson += ",";
		      }
		    }
	    }
    	edit2ndJson += "]"
    	
	if(rowTotCnt2 == 0)    	//타스크만 있을때 
	{
		regEmpNnumChk ++;
	}
    	

	if(regEmpNnumChk >0 )
	{
		Ext.Msg.alert('확인', '타스크 담당자를 선택하십시오');
		return;
	}
	
	

	Ext.Ajax.request({   
		url: "/dev/scdInfo/actionScdInfoMng.sg"   
		,success: function(response){						// 조회결과 성공시
					// 조회된 결과값, store명
					
					handleSuccess(response,GridClass_1st,'save');
					var json = Ext.util.JSON.decode(response.responseText);

					if(json.searchPjtId !="")
					{
						fnSearchEdit1st(json.searchPjtId);
					}

					if(json.searchScdPlanSeq !="")
					{
						//fnSearchEdit2nd(json.searchScdPlanSeq);
					}

		          } 
		,failure: handleFailure   	    // 조회결과 실패시  
		,form   : document.searchForm	// 상세 FORM	
		,params : {					    // 조회조건을 DB로 전송하기위해서 조건값 설정
				  // 페이지정보
					limit          : limit_1st
			  	  , start          : start_1st
			  	  , edit1stData		   : edit1stJson 		// 타스크 정보
  				  , edit2ndData        : edit2ndJson		// 타스크 담당자 정보
  				  , selTaskCode        : selRecord[0].data.TASK_CODE		// 선택된 타스크 정보의 타스크 코드
  				  ,search_scd_type_code:  Ext.get('scd_type_code').getValue() 
  				  ,search_pjt_id 	   :selRecord[0].data.PJT_ID	
				  // 검색정보
			  	  //, src_pjt_name   	   : Ext.get('src_pjt_name').getValue()		  // 프로젝트명
			  	  //, src_pjt_date_from : Ext.get('src_pjt_date_from').getValue() // 프로젝트기간기간(검색시작일)
			  	  //, src_pjt_date_to   : Ext.get('src_pjt_date_to').getValue() // 프로젝트기간(검색종료일)
			  	  ,pjt_name : selRecord_1st[0].data.PJT_NAME
			  	  ,rowTotCnt : rowTotCnt
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
	//var dForm = document.detailForm;
	
    // 검색버튼 클릭
	Ext.get('searchBtn').on('click', function(e){
        if(Validator.validate(sForm)){
			fnSearch()
		}	
    });

	var toDay = getTimeStamp(); 
	 toDay = toDay.replaceAll('-','');
	 toDay = addDate(toDay, 'M', -3);
	 toDay = toDay.substring(0,4)+"-"+toDay.substring(4,6)+"-"+toDay.substring(6,8);
	 var fromDay = toDay;
	 toDay = getTimeStamp().trim();

    
   	//조건해제 버튼 -> 검색조건 초기화
   	Ext.get('searchClearBtn').on('click', function(e){
        sForm.reset();
	
		Ext.get('src_pjt_date_from_tmp').set({value : fromDay}, false);				//프로젝트 기간 from
		Ext.get('src_pjt_date_to_tmp').set({value:toDay} , false);        	
    });
   	
   	
	//저장 버튼 -> 데이터를 server로 전송
	Ext.get('saveBtn').on('click', function(e){	
		if(Validator.validate(sForm)){
			Ext.MessageBox.confirm('Confirm', '저장하시겠습니까?', showResult);
		};
	});
	   	

   	
	// 검색시작일자
	var startDate = new Ext.form.DateField({
    	applyTo: 'src_pjt_date_from_tmp',
		allowBlank: false,
		format:'Y-m-d',
		editable : true,
		value : fromDay
	});
	
	Ext.get('src_pjt_date_from_tmp').on('change', function(e){	
		
		var val = Ext.get('src_pjt_date_from_tmp').getValue();
		var reVal = fnGridDateCheck(val);
		
		Ext.get('src_pjt_date_from_tmp').set({value:reVal} , false);
	});
	
   	
	// 검색종료일자
	var endDate = new Ext.form.DateField({
    	applyTo: 'src_pjt_date_to_tmp',
		allowBlank: false,
		format:'Y-m-d',
		editable : true,
		value : toDay
	});
	
	Ext.get('src_pjt_date_to_tmp').on('change', function(e){	
		
		var val = Ext.get('src_pjt_date_to_tmp').getValue();
		var reVal = fnGridDateCheck(val);
		
		Ext.get('src_pjt_date_to_tmp').set({value:reVal} , false);
	});   	



   	
/*
			
   	//신규 버튼 -> 상세필드 초기화
	Ext.get('detailClearBtn').on('click', function(e){
		fnInitValue();		   
	});		

	
	//수정 버튼 -> 데이터를 server로 전송
	Ext.get('updateBtn').on('click', function(e){	
		if(Validator.validate(sForm)){
			Ext.MessageBox.confirm('Confirm', '수정하시겠습니까?', showResult);
		};	
	});
   	
*/
	
	fnInitValue();
	
}); // end Ext.onReady

// 저장, 수정버튼 클릭시 '예','아니오' 
function showResult(btn){
   	if(btn == 'yes'){
   		fnSave();
   	}    	
};
	


/***************************************************************************
 * 설  명 : 담당자검색
 ***************************************************************************/
function fnEmployeePop(param){
	var sURL      = "/com/employee/employeePop.sg?requestFieldName="+param;
	var dlgWidth  = 399;
	var dlgHeight = 396;
	if(param ='regNumBtn')
	{
		var winName   = "emp";
	}else
	{
		var winName   = "regemp";
	}
	
	fnOpenPop(sURL, dlgWidth, dlgHeight, winName);
}


/***************************************************************************
 * 설  명 : 담당자검색 결과 반영
 ***************************************************************************/
function fnEmployeePopValue(records, fieldName){
		
	// 전송받은 값이 한건일 경우
    var record = records[0].data;				
	var parentsRecord ="";

	if(fieldName =='regNumBtn')	//담당자
	{
		var selRecord = GridClass_edit_1st.grid.selModel.getSelections();
		var selScdPlanSeq = selRecord[0].data.SCD_PLAN_SEQ;			//선택한 타스크 정보그리드의 키
//alert("--selScdPlanSeq--["+selScdPlanSeq+"]");			
		
		parentsRecord = GridClass_edit_2nd.grid.selModel.getSelected();
		parentsRecord.set('SCD_PLAN_SEQ', fnFixNull(selScdPlanSeq));
		
		parentsRecord.set('EMP_NUM', fnFixNull(record.EMP_NUM));
		parentsRecord.set('EMP_NAME', fnFixNull(record.KOR_NAME));
		parentsRecord.set('DEPT_CODE', fnFixNull(record.DEPT_CODE));
		parentsRecord.set('DEPT_NAME', fnFixNull(record.DEPT_NAME));


	}else// 책임자
	{
		parentsRecord = GridClass_edit_1st.grid.selModel.getSelected();
		parentsRecord.set('SCD_REG_EMP_NUM', fnFixNull(record.EMP_NUM));
		parentsRecord.set('SCD_REG_EM_NAME', fnFixNull(record.KOR_NAME));
		parentsRecord.set('SCD_DEPT', fnFixNull(record.DEPT_CODE));
		
	}

}



/***************************************************************************
 * 설  명 : 에디트 그리드의 CELL을 클릭하였을 경우 이벤트
 ***************************************************************************/
function  fnEdit1stCellClickEvent(grid, rowIndex, columnIndex, e){

	var record = grid.selModel.getSelections();

	var scd_plan_seq = record[0].get('SCD_PLAN_SEQ');		//일정계획순번


	//타스크 담당자 정보조회
	if(columnIndex == '1' ){
		fnSearchEdit2nd(scd_plan_seq);
	}	
	

		
	//타스크 정보 팝업
	if(columnIndex == '5' ){
		
		var selRecord = GridClass_1st.grid.selModel.getSelections();
		
		var rowTotCnt = GridClass_edit_1st.store.getCount();
		
		if(selRecord.length == 0 && rowTotCnt ==0)		
		{
			Ext.Msg.alert('확인', '프로젝트를 선택하십시오');
			return;
		}		
			
		
		taskInfoPop("multiSelectYn=Y&requestFieldName=single");
	}	

		
	//책임자  팝업
	if(columnIndex == '7' || columnIndex == '8'){
		fnEmployeePop('respnNumBtn');
	}	
	
}




/***************************************************************************
 * 설  명 : 에디트 그리드의 CELL을 클릭하였을 경우 이벤트
 ***************************************************************************/
function  fnEdit2ndCellClickEvent(grid, rowIndex, columnIndex, e){
//alert("셀선택-rowIndex-"+rowIndex+"--columnIndex--"+columnIndex);

	//타스크 담당자 정보 조회
	if(columnIndex == '6' || columnIndex == '7'){
		fnEmployeePop('regNumBtn');
	}


}



/***************************************************************************
 * 설  명 : 타스크검색
 ***************************************************************************/
function taskInfoPop(param){

	var sURL      = "/com/task/taskInfoPop.sg?"+param;
	var dlgWidth  = 399;
	var dlgHeight = 396;
	var winName   = "task";

	fnOpenPop(sURL, dlgWidth, dlgHeight, winName);
}


/***************************************************************************
 * 설  명 : 타스크검색 결과 반영
 ***************************************************************************/
function fnTaskPopValue(records,fieldName){
	
	var selRecord = GridClass_1st.grid.selModel.getSelections();  //프로젝트 기본정보
	var selPjtId = "";
	
	if(selRecord.length ==0 )
	{
		selRecord = GridClass_edit_1st.store.getAt(0);   //타스크 정보
		selPjtId = selRecord.data.PJT_ID;
	}else
	{
		 selPjtId = selRecord[0].data.PJT_ID;
	}
	


	var parentsRecord ="";

	if(fieldName =="multi")
	{

		// 전송 받은 값이 여러건일 경우
		for (var i = 0; i < records.length; i++) {
			
	//alert("--data.TASK_CODE->"+records[i].data.TASK_CODE+"--selPjtId-->"+selPjtId);
	
				var Plant = GridClass_edit_1st.grid.getStore().recordType; 

			    var p = new Plant({ 
									FLAG 			: 'I' 
							 	  , SCD_TYPE_CODE 	: Ext.get('scd_type_code').getValue() 
								  , TASK_CODE 		: records[i].data.TASK_CODE
								  , TASK_NAME 		: records[i].data.TASK_NAME
								  , SCD_DEPT 			: ''
								  , SCD_REG_EMP_NUM 	: ''
								  , SCD_REG_EM_NAME 	: ''
								  , SCD_CONTENT 		: ''
								  , PJT_ID 			    :selPjtId
								  , TASK_GROUP_CODE 	: records[i].data.TASK_GROUP_CODE				    		  
								  , SCD_PLAN_FROM_DATE 	: getToDay(0)
								  , SCD_PLAN_TO_DATE 	: getToDay(0)	
								  , NOTE 	: ''	
			    				  }); 
			  	GridClass_edit_1st.grid.stopEditing();
				GridClass_edit_1st.store.insert(0, p);
				GridClass_edit_1st.grid.startEditing(0, 0);
		}	
		

	}else
	{
		var record = records[0].data;
		
		parentsRecord = GridClass_edit_1st.grid.selModel.getSelected();
		parentsRecord.set('TASK_CODE', fnFixNull(record.TASK_CODE));
		parentsRecord.set('TASK_NAME', fnFixNull(record.TASK_NAME));
	
	}
}


// 팝업
function fnOpenPop(sURL, dlgWidth, dlgHeight, winName){
  var xPos=(window.screen.width) ? (window.screen.width-dlgWidth)/2 : 0;
  var yPos=(window.screen.height) ? (window.screen.height-dlgHeight)/2 : 0;
  var sFeatures = "titlebar=no, scrollbars=no,location=no ,menubar=no, resizable=no, status=yes, width="+dlgWidth+",height="+dlgHeight+",left="+xPos+", top="+yPos;

  window.open(sURL,winName, sFeatures);
}


//오늘날짜
function getToDay(preMonth)
{

    var date = new Date();

    var year  = date.getFullYear();
    var month = (date.getMonth()-preMonth) + 1; // 1월=0,12월=11이므로 1 더함
    var day   = date.getDate();

    if (("" + month).length == 1) { month = "0" + month; }
    if (("" + day).length   == 1) { day   = "0" + day;   }
     
    return ("" + year + month + day)

}

// 그리드 행삭제
function fnEdit1stBeforeRowDeleteEvent(){

	var delRecord = GridClass_edit_1st.grid.selModel.getSelections();
	delRecord[0].set('FLAG', 'D');						//상태
}



// 그리드 행삭제
function fnEdit2ndBeforeRowDeleteEvent(){

	var delRecord = GridClass_edit_2nd.grid.selModel.getSelections();
	delRecord[0].set('FLAG', 'D');						//상태
}


    
</script>

</head>
<body class=" ext-gecko ext-gecko3">
	<table border="0" width="1000" height="200">
		<tr>
			<td colspan="3">
				<form name="searchForm" id="searchForm">
				<input type="hidden" id="src_pjt_date_from" name="src_pjt_date_from"  />		
				<input type="hidden" id="src_pjt_date_to" name="src_pjt_date_to"  />			
				<input type="hidden" id="pjt_type_code" name="pjt_type_code"  value="22"/>	<!-- 프로젝트구분코드 -->
				<input type="hidden" id="scd_type_code" name="scd_type_code"  value="DEV"/>	<!-- 일정구분코드 SCD_TYPE_CODE : 영업-SAL, 개발-DEV -->
				
				<!----------------- SEARCH Hearder Start	 ----------------->
				<div id="ext-comp-1002" class=" x-panel x-form-label-left" style="margin-top: 0.4em;"><%-- 0em <- 1em으로 수정하면 상위 공백 --%>
					<div class="x-panel-tl">
						<div class="x-panel-tr">
							<div class="x-panel-tc">
								<div id="ext-gen4" class="x-panel-header x-unselectable" style="-moz-user-select: none;">
									<span id="ext-gen8" class="x-panel-header-text">개발프로젝트 검색</span>
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
								<table border="0">
						    		<%-- 1 Row Start --%>
						    		<tr>
										<td width="13%">
											<div tabindex="-1" class="x-form-item" >
												<label class="x-form-item-label" style="width: auto;" for="src_pjt_name" >프로젝트명 :</label>
												<div style="padding-left: 0px;" class="x-form-element">
													<input type="text" name="src_pjt_name" id="src_pjt_name" autocomplete="off" size="19" class=" x-form-text x-form-field" style="width: auto;">
												</div>
											</div>
										</td>
								
										<td width="20%">
											<div tabindex="-1" class="x-form-item " >
												<label class="x-form-item-label" style="width: auto;" for="src_pjt_date_from_tmp" ><font color="red">* </font>프로젝트기간 :</label>
													<table>
														<tr>
															<td>
																<input type="text" name="src_pjt_date_from_tmp" id="src_pjt_date_from_tmp" autocomplete="off" size="10" style="width: auto;">		
															</td>
															<td>
																~
															</td>
															<td>
																<input type="text" name="src_pjt_date_to_tmp" id="src_pjt_date_to_tmp" autocomplete="off" size="10" style="width: auto;" >		
															</td>
														</tr>
													</table>
											</div>
										</td>
										
										<td width="30%">
											<div tabindex="-1" class="x-form-item " >
												<label class="x-form-item-label" style="width: auto;" for="src_proc_status_code">진행상태 :</label>
												<div style="padding-left: 30px;" class="x-form-element">
													<select name="src_proc_status_code" id="src_proc_status_code" style="width: 29%;" type="text" class=" x-form-select x-form-field" >
														<option value="">선택하세요</option>
																<c:forEach items="${FLOW_STATUS_CODE}" var="data" varStatus="status">
																	<c:if test="${fn:indexOf(data.COM_CODE, 'G')>-1}">
																		<option value="${data.COM_CODE}" <c:if test="${data.COM_CODE == 'G10'}">selected</c:if>><c:out value="${data.COM_CODE_NAME}"/></option>
																	</c:if>
																</c:forEach>
													</select>
												</div>
											</div>
										</td>
										
									</tr>
									<%-- 1 Row End --%>

									<%-- 3 Row 버튼 Start --%>
									<tr align="right">
										<td colspan="6">
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
									<%-- 3 Row 버튼 End --%>
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
			<!----------------- 프로젝트기본정보 GRID START ----------------->
			<td width="30%" valign="top">
				<div id="pjt_info_grid" style="margin-top: 0.4em;"></div>
			</td>

			<td width="35%" valign="top">
				<div id="edit_grid_1st" style="margin-top: 0.4em;"></div>
			</td>
			
			<td width="35%" valign="top">
				<div id="edit_grid_2nd" style="margin-top: 0.4em;"></div>
			</td>			
		</tr>

		<tr>
			<td colspan="3" align="center" height="35">
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
											<button type="button" id="saveBtn" name="saveBtn" class="x-btn-text">등록</button>
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
		
					
					</tr>
				</table>
			</td>
		</tr>
	</table>
</body>

</html>