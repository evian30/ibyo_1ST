<%--
  Class Name  : pjdInfoMngList.jsp
  Description :  개발프로젝트관리
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
var	gridHeigth_1st 	 	= 362; 							// 그리드 전체 높이
var	gridWidth_1st		= 409;							// 그리드 전체 폭
var gridTitle_1st 		= "개발프로젝트";	  			// 그리드 제목
var	render_1st			= "pjt_info_grid";		// 렌더(화면에 그려질) 할 id 
var	pageSize_1st		= 15;	  						// 그리드 페이지 사이즈	
var	proxyUrl_1st		= "/dev/pjdInfo/result.sg";  // 결과 값 페이지
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
var userColumns_1st =  [ {header: '조회상태'                 ,width: 60  ,sortable: true ,dataIndex: 'FLAG'                      ,hidden : true}              
					   , {header: '프로젝트ID'               ,width: 60  ,sortable: true ,dataIndex: 'PJT_ID'                    }              
					   , {header: '프로젝트구분코드'         ,width: 60  ,sortable: true ,dataIndex: 'PJT_TYPE_CODE'             ,hidden : true}               
					   , {header: '프로젝트명'               ,width: 60  ,sortable: true ,dataIndex: 'PJT_NAME'                  }              
					   , {header: '등록일자'                 ,width: 60  ,sortable: true ,dataIndex: 'PJT_REG_DATE'              ,hidden : true}
					   , {header: '프로젝트FROM'        ,width: 60  ,sortable: true ,dataIndex: 'PJT_DATE_FROM'         }
					   , {header: '프로젝트TO'          ,width: 60  ,sortable: true ,dataIndex: 'PJT_DATE_TO'               }              
					   , {header: '프로젝트담당자부서코드'   ,width: 60  ,sortable: true ,dataIndex: 'PJT_OWN_DEPT_CODE'         ,hidden : true}              
					   , {header: '프로젝트담당자사번'       ,width: 60  ,sortable: true ,dataIndex: 'PJT_OWN_EMP_NUM'           ,hidden : true}
					   , {header: '프로젝트등록자부서코드'   ,width: 60  ,sortable: true ,dataIndex: 'PJT_REG_DEPT_CODE'         ,hidden : true}
					   , {header: '프로젝트등록자사번'       ,width: 60  ,sortable: true ,dataIndex: 'PJT_REG_EMP_NUM'           ,hidden : true}
					   , {header: '업무구분코드'             ,width: 60  ,sortable: true ,dataIndex: 'ROLL_TYPE_CODE'            ,hidden : true}
					   , {header: '수주가능성'               ,width: 60  ,sortable: true ,dataIndex: 'ORDER_POSSBLE'             ,hidden : true}
					   , {header: '유/무상구분코드'          ,width: 60  ,sortable: true ,dataIndex: 'PAY_FREE_CODE'             ,hidden : true}
					   , {header: '수주예정일'               ,width: 60  ,sortable: true ,dataIndex: 'ORDER_EXP_DATE'            ,hidden : true}
					   , {header: '제안(입찰)마감일'         ,width: 60  ,sortable: true ,dataIndex: 'BID_DDAY'                  ,hidden : true}
					   , {header: '진행상태코드'             ,width: 60  ,sortable: true ,dataIndex: 'PROC_STATUS_CODE'          ,hidden : true}
					   , {header: '개요및특이사항'           ,width: 60  ,sortable: true ,dataIndex: 'PJT_SUMMARY'               ,hidden : true}
					   , {header: '예상매출총액'             ,width: 60  ,sortable: true ,dataIndex: 'EXP_SAL_TOTAL_AMT'         ,hidden : true}
					   , {header: '예상매출총세액'           ,width: 60  ,sortable: true ,dataIndex: 'EXP_SAL_TOTAL_TAX'         ,hidden : true}
					   , {header: '비고'                     ,width: 60  ,sortable: true ,dataIndex: 'NOTE'                      ,hidden : true}
					   , {header: '최종변경자ID'             ,width: 60  ,sortable: true ,dataIndex: 'FINAL_MOD_ID'              ,hidden : true}
					   , {header: '최종변경자명'             ,width: 60  ,sortable: true ,dataIndex: 'FINAL_MOD_NAME'              ,hidden : true}
					   , {header: '최종변경일시'             ,width: 60  ,sortable: true ,dataIndex: 'FINAL_MOD_DATE'    		 ,hidden : true}
					   , {header: '프로젝트구분명'           ,width: 60  ,sortable: true ,dataIndex: 'PJT_TYPE_CODE_NAME'          ,hidden : true}
					   , {header: '프로젝트담당자부서명'     ,width: 60  ,sortable: true ,dataIndex: 'PJT_OWN_DEPT_NAME'           ,hidden : true}
					   , {header: '프로젝트담당자명'         ,width: 60  ,sortable: true ,dataIndex: 'PJT_OWN_EMP_NAME'            ,hidden : true}
					   , {header: '프로젝트등록자부서코드'   ,width: 60  ,sortable: true ,dataIndex: 'PJT_REG_DEPT_NAME'           ,hidden : true}
					   , {header: '프로젝트등록자명'         ,width: 60  ,sortable: true ,dataIndex: 'PJT_REG_EMP_NAME'            ,hidden : true}
					   , {header: '유/무상구분명'            ,width: 60  ,sortable: true ,dataIndex: 'PAY_FREE_NAME'               ,hidden : true}
					   , {header: '진행상태명'               ,width: 60  ,sortable: true ,dataIndex: 'PROC_STATUS_NAME'            ,hidden : true}
					   , {header: '업무구분명'               ,width: 60  ,sortable: true ,dataIndex: 'ROLL_TYPE_NAME'              ,hidden : true}
					   , {header: '책임자부서코드'               ,width: 60  ,sortable: true ,dataIndex: 'PJT_OWN_DEPT_CODE'              ,hidden : true}
					   , {header: '책임자부서명'               ,width: 60  ,sortable: true ,dataIndex: 'PJT_OWN_DEPT_NAME'              ,hidden : true}
					   , {header: '책임자사번'               ,width: 60  ,sortable: true ,dataIndex: 'PJT_OWN_EMP_NUM'              ,hidden : true}
					   , {header: '책임자명'               ,width: 60  ,sortable: true ,dataIndex: 'PJT_OWN_EMP_NAME'              ,hidden : true}
					   , {header: '최초등록자 ID'               ,width: 60  ,sortable: true ,dataIndex: 'REG_ID'              ,hidden : true}
					   , {header: '최초등록일'               ,width: 60  ,sortable: true ,dataIndex: 'REG_DATE'              ,hidden : true}
					   ];	 


var mappingColumns_1st =  [ 
							 {name: 'FLAG'              , allowBlank: false        }     //조회상태'                          
						   , {name: 'PJT_ID'            , allowBlank: false        }     //프로젝트ID'                        
						   , {name: 'PJT_TYPE_CODE'     , allowBlank: false        }     //프로젝트구분코드'                   
						   , {name: 'PJT_NAME'          , allowBlank: false        }     //프로젝트명'                        
						   , {name: 'PJT_REG_DATE'      , allowBlank: false        }     //등록일자'                 
						   , {name: 'PJT_DATE_FROM'     , allowBlank: false        }     //프로젝트기간 FROM'        
						   , {name: 'PJT_DATE_TO'       , allowBlank: false        }     //프로젝트기간 TO'                   
						   , {name: 'PJT_OWN_DEPT_CODE' , allowBlank: false        }     //프로젝트담당자부서코드'            
						   , {name: 'PJT_OWN_EMP_NUM'   , allowBlank: false        }     //프로젝트담당자사번'       
						   , {name: 'PJT_REG_DEPT_CODE' , allowBlank: false        }     //프로젝트등록자부서코드'   
						   , {name: 'PJT_REG_EMP_NUM'   , allowBlank: false        }     //프로젝트등록자사번'       
						   , {name: 'ROLL_TYPE_CODE'    , allowBlank: false        }     //업무구분코드'             
						   , {name: 'ORDER_POSSBLE'     , allowBlank: false        }     //수주가능성'               
						   , {name: 'PAY_FREE_CODE'     , allowBlank: false        }     //유/무상구분코드'          
						   , {name: 'ORDER_EXP_DATE'    , allowBlank: false        }     //수주예정일'               
						   , {name: 'BID_DDAY'          , allowBlank: false        }     //제안(입찰)마감일'         
						   , {name: 'PROC_STATUS_CODE'  , allowBlank: false        }     //진행상태코드'             
						   , {name: 'PJT_SUMMARY'       , allowBlank: false        }     //개요및특이사항'           
						   , {name: 'EXP_SAL_TOTAL_AMT' , allowBlank: false        }     //예상매출총액'             
						   , {name: 'EXP_SAL_TOTAL_TAX' , allowBlank: false        }     //예상매출총세액'           
						   , {name: 'NOTE'              , allowBlank: false        }     //비고'                     
						   , {name: 'FINAL_MOD_ID'      , allowBlank: false        }     //최종변경자ID'   
						   , {name: 'FINAL_MOD_NAME'      , allowBlank: false        }     //최종변경자명'   
						   , {name: 'FINAL_MOD_DATE'    , allowBlank: false		   }     //최종변경일시'             
						   , {name: 'PJT_TYPE_CODE_NAME'  , allowBlank: false        }     //프로젝트구분명'           
						   , {name: 'PJT_OWN_DEPT_NAME'   , allowBlank: false        }     //프로젝트담당자부서명'     
						   , {name: 'PJT_OWN_EMP_NAME'    , allowBlank: false        }     //프로젝트담당자명'         
						   , {name: 'PJT_REG_DEPT_NAME'   , allowBlank: false        }     //프로젝트등록자부서코드'   
						   , {name: 'PJT_REG_EMP_NAME'    , allowBlank: false        }     //프로젝트등록자명'         
						   , {name: 'PAY_FREE_NAME'       , allowBlank: false        }     //유/무상구분명'            
						   , {name: 'PROC_STATUS_NAME'    , allowBlank: false        }     //진행상태명'               
						   , {name: 'ROLL_TYPE_NAME'      , allowBlank: false        }     //업무구분명'    
						   , {name: 'PJT_OWN_DEPT_CODE' , allowBlank: false        }     //책임자부서코드'               
						   , {name: 'PJT_OWN_DEPT_NAME' , allowBlank: false        }     //책임자부서명'               
						   , {name: 'PJT_OWN_EMP_NUM'   , allowBlank: false        }     //책임자사번'               
						   , {name: 'PJT_OWN_EMP_NAME'  , allowBlank: false        }     //책임자명'               
						   , {name: 'REG_ID'      , allowBlank: false        }     //최초등록자 ID'               
						   , {name: 'REG_DATE'      , allowBlank: false        }     //최초등록일'               
    				 	 ];
 
/***************************************************************************
 * 견적기본정보 --- 그리드 클릭시 Event
 ***************************************************************************/
function fnGridOnClick_1st(store, rowIndex){
	

	fnInitValue();
	
	var tmpfrom = store.getAt(rowIndex).data.PJT_DATE_FROM.substring(0, 4)+"-"+store.getAt(rowIndex).data.PJT_DATE_FROM.substring(4, 6)+"-"+store.getAt(rowIndex).data.PJT_DATE_FROM.substring(6, 8);
	var tmpto = store.getAt(rowIndex).data.PJT_DATE_TO.substring(0, 4)+"-"+store.getAt(rowIndex).data.PJT_DATE_TO.substring(4, 6)+"-"+store.getAt(rowIndex).data.PJT_DATE_TO.substring(6, 8);

	Ext.get('pjt_date_from').set({value : fnFixNull(store.getAt(rowIndex).data.PJT_DATE_FROM)}, false);				//프로젝트 기간 from
	Ext.get('pjt_date_from_tmp').set({value : fnFixNull(store.getAt(rowIndex).data.PJT_DATE_FROM)}, false);			//프로젝트 기간 from
	Ext.get('pjt_date_to').set({value : fnFixNull(store.getAt(rowIndex).data.PJT_DATE_TO)}, false);					//프로젝트 기간 to
	Ext.get('pjt_date_to_tmp').set({value : fnFixNull(store.getAt(rowIndex).data.PJT_DATE_TO)}, false);				//프로젝트 기간 to
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
	Ext.get('final_mod_name').set({value : fnFixNull(store.getAt(rowIndex).data.FINAL_MOD_NAME)}, false);				//최종변경자명
	
	Ext.get('final_mod_date').set({value : fnFixNull(store.getAt(rowIndex).data.FINAL_MOD_DATE)}, false);				//최종변경일시
	Ext.get('reg_id').set({value : fnFixNull(store.getAt(rowIndex).data.REG_ID)}, false);								//최초등록자
	Ext.get('reg_date').set({value : fnFixNull(store.getAt(rowIndex).data.REG_DATE)}, false);						//최초등록일      

	var keyValue1 = fnFixNull(store.getAt(rowIndex).data.PJT_ID);		 // 프로젝트ID

	fnSearchEdit1st(keyValue1);
	fnSearchEdit2nd(keyValue1);

	
	// 버튼 disable
	Ext.get('saveBtn').dom.disabled   = true;
	Ext.get('updateBtn').dom.disabled = false;
	Ext.get('deleteBtn').dom.disabled = false;

}   

// 개발프로젝트관리 조회
function fnSearchEdit1st(keyValue1){
	
	Ext.Ajax.request({
		url: "/dev/pjdInfo/result_edit_1st.sg" 
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
				   , pjt_type_code	: '22'
				  }				
	}); // end Ext.Ajax.request   
}

// 개발프로젝트장비관리 조회
function fnSearchEdit2nd(keyValue1){
	
	Ext.Ajax.request({
		url: "/dev/pjdInfo/result_edit_2nd.sg" 
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
				   , pjt_id			: keyValue1
				   , pjt_type_code	: '22'
				  }				
	}); // end Ext.Ajax.request   
}


/***************************************************************************
 * 설  명 : 편집그리드 설정 (개발프로젝트관리)
***************************************************************************/
var	gridHeigth_edit_1st	= 200;
var	gridWidth_edit_1st  = 1022	;
var	gridTitle_edit_1st  = "프로젝트 상세정보"	; 
var	render_edit_1st		= "edit_grid_1st";
var keyNm_edit_1st		= "PJT_INFO_SEQ";
var pageSize_edit_1st	= 99999999;
var limit_edit_1st		= pageSize_edit_1st;
var start_edit_1st		= 0;
var proxyUrl_edit_1st	= "/dev/pjdInfo/result_edit_1st.sg";
var gridRowDeleteYn	    = "Y";
var tbarHidden_edit_1st ="N";

// 행추가
function addNew_edit_1st(){

	if(Ext.get('pjt_name').getValue() == '')
	{
		Ext.Msg.alert('확인', '프로젝트를 선택하십시오');
		return;
	}


	var rowTotCnt = GridClass_edit_1st.store.getCount();
	var dupChk =0;
	
	for(var k=0;  k < rowTotCnt; k++){	//기존 데이타 전체 검색

		var recodeAt = GridClass_edit_1st.store.getAt(k);
		var data = recodeAt.data.ITEM_CODE;       //기존 데이타
	 		
		if(data !='')	 
		{
			dupChk++;	
		}
	}
	
	if(dupChk >0)
	{
		Ext.Msg.alert('확인', '이미 제품이 선택되어 있습니다.');	
		return;
	}
	

	pjtInfoNitemPop();
}



// 그리드 행삭제
function fnEdit1stBeforeRowDeleteEvent(){

/*
	var rowTotCnt = GridClass_edit_1st.store.getCount();

	for(var k=0;  k < rowTotCnt; k++){	//기존 데이타 전체 검색

		var recodeAt = GridClass_edit_1st.store.getAt(k);
		
		recodeAt.set('FLAG', 'D');
	
		//GridClass_edit_1st.store.removeAt(k);
	}
	GridClass_edit_1st.store.removeAll();
	GridClass_edit_1st.store.commitChanges();	// 변경된 record를 commit
*/


	var delRecord = GridClass_edit_1st.grid.selModel.getSelections();
	delRecord[0].set('FLAG', 'D');						//상태


}




/***************************************************************************
 * 설  명 : 삭제버튼 클릭-DB삭제
 ***************************************************************************/
function fnGridDeleteRow(selectedRecord){
	
	var json = "["+Ext.util.JSON.encode(selectedRecord.data)+"]";

	var sForm = document.searchForm;
	
	var dForm = document.detailForm;

	sForm.src_pjt_date_from.value = sForm.src_pjt_date_from_tmp.value.replaceAll('-','');		   	 
	sForm.src_pjt_date_to.value = sForm.src_pjt_date_to_tmp.value.replaceAll('-','');	
	
	
    if(dForm.proc_status_code.value !="" && dForm.proc_status_code.value != 'G10' )
    {
    	var msgTmp ="";
    	if(dForm.proc_status_code.value == "G00")
    	{	
    		msgTmp ="프로잭트가 DROP 상태입니다.";
    	}
    	
    	if(dForm.proc_status_code.value == "G20")
    	{	
    		msgTmp ="프로젝트 일정계획이 등록되었습니다.";
    	}
    	
    	if(dForm.proc_status_code.value == "G00")
    	{	
    		msgTmp ="프로젝트가 진행중입니다.";
    	}
    	
    	if(dForm.proc_status_code.value == "G00")
    	{	
    		msgTmp ="프로젝트가 완료되었습니다.";
    	}
    	
    
    	Ext.Msg.alert('확인', msgTmp);
    	return;
    } 	
	

    var rowCnt = GridClass_edit_1st.store.getCount();  // Grid의 총갯수
    
    var csrPatternItemJson = "[";
	    for(i = 0 ; i < rowCnt ; i++){
	    	var record = GridClass_edit_1st.store.getAt(i);
	    	
	    	if(record.data.FLAG != 'D')	    
			{

		      csrPatternItemJson += Ext.util.JSON.encode(record.data);				
		      if (i < (rowCnt-1)) {
		        csrPatternItemJson += ",";
		      }
		    }
	    }
    	csrPatternItemJson += "]"      
    
    
    
	Ext.Ajax.request({   
		url: "/dev/pjdInfo/deletePjdDevInfo.sg"   
		,success: function(response){						// 조회결과 성공시
					// 조회된 결과값, store명
					var json = Ext.util.JSON.decode(response.responseText);
					//handleSuccess(response,GridClass_edit_1st);
					
					GridClass_edit_1st.store.commitChanges();	// 변경된 record를 commit
					GridClass_edit_1st.store.removeAll();		// store자료를 삭제

										
					GridClass_edit_1st.store.loadData(json);		
					
		          }
		,failure: handleFailure   	    // 조회결과 실패시  
		,form   : document.searchForm   // 검색 FORM
		,params : { 
					limit          		: limit_edit_1st
				   , start         		: start_edit_1st
				   ,deleteData : json
				   ,pjt_id : selectedRecord.data.PJT_ID
				   , csrPatternItem : csrPatternItemJson
			      } 
	});
	
	
	//fnInitValue(); // 상세필드 초기화
}



// 페이징
function fnPagingValue_edit_1st(){	
	try{
		GridClass_edit_1st.store.setBaseParam('start'		,start_edit_1st);
	    GridClass_edit_1st.store.setBaseParam('limit'		,limit_edit_1st);
	    GridClass_edit_1st.store.setBaseParam('pjt_id'		,Ext.get('pjt_id').getValue());
		GridClass_edit_1st.store.setBaseParam('pjt_type_code'	,Ext.get('pjt_type_code').getValue());
	}catch(e){

	}
}

// 그리드 필드
var	userColumns_edit_1st	= [ {header: '조회상태'                 ,width: 60  ,sortable: true ,dataIndex: 'FLAG'                      ,hidden : true}              
							   , {header: '업무요청구분명'             ,width: 60  ,sortable: true ,dataIndex: 'CSR_TYPE_NAME'    		 ,hidden : true}
							   , {header: '제품코드'             ,width: 60  ,sortable: true ,dataIndex: 'ITEM_CODE'    	 }
							   , {header: '제품명'             ,width: 60  ,sortable: true ,dataIndex: 'ITEM_NAME'    		 }
							   , {header: '프로젝트ID'               ,width: 60  ,sortable: true ,dataIndex: 'PJT_ID'        ,hidden : true}              
							   , {header: '프로젝트명'               ,width: 60  ,sortable: true ,dataIndex: 'PJT_NAME'        ,hidden : true}      
							   , {header: '영업프로젝트ID'          ,width: 60  ,sortable: true ,dataIndex: 'SAL_PJT_ID'       }              
							   , {header: '영업프로젝트명'          ,width: 60  ,sortable: true ,dataIndex: 'SAL_PJT_NAME'     }              
							   , {header: '순번'         ,width: 60  ,sortable: true ,dataIndex: 'PJT_INFO_SEQ'             ,hidden : true}               
							   , {header: '업무요청유형코드'               ,width: 60  ,sortable: true ,dataIndex: 'CSR_TYPE_CODE',hidden : true }              
							   , {header: '업무요청ID'                 ,width: 60  ,sortable: true ,dataIndex: 'CSR_ID'              }
							   , {header: '업무요청순번'        ,width: 60  ,sortable: true ,dataIndex: 'CSR_INFO_SEQ'             ,hidden : true}
							   , {header: '최종변경자ID'             ,width: 60  ,sortable: true ,dataIndex: 'FINAL_MOD_ID'              ,hidden : true}
							   , {header: '최종변경일시'             ,width: 60  ,sortable: true ,dataIndex: 'FINAL_MOD_DATE'    		 ,hidden : true}
							   ];	

// 맵핑 필드
var	mappingColumns_edit_1st	= [  
							    {name: "FLAG", 		type:"string", mapping: "FLAG"}
							  , {name: "CSR_TYPE_NAME", 			type:"string", mapping: "CSR_TYPE_NAME"}
							  , {name: "ITEM_CODE", 			type:"string", mapping: "ITEM_CODE"}
							  , {name: "ITEM_NAME", 			type:"string", mapping: "ITEM_NAME"}
							  , {name: "PJT_ID", 			type:"string", mapping: "PJT_ID"}
							  , {name: "PJT_NAME", 			type:"string", mapping: "PJT_NAME"}
							  , {name: "SAL_PJT_ID", 		type:"string", mapping: "SAL_PJT_ID"}
							  , {name: "SAL_PJT_NAME", 		type:"string", mapping: "SAL_PJT_NAME"}
							  , {name: "PJT_INFO_SEQ", 		type:"string", mapping: "PJT_INFO_SEQ"}
							  , {name: "CSR_TYPE_CODE", 		type:"string", mapping: "CSR_TYPE_CODE"}
							  , {name: "CSR_ID", 		type:"string", mapping: "CSR_ID"}
							  , {name: "CSR_INFO_SEQ", 				type:"string", mapping: "CSR_INFO_SEQ"}
							  , {name: "FINAL_MOD_ID", 		type:"string", mapping: "FINAL_MOD_ID"}   
							  , {name: "FINAL_MOD_DATE", 	type:"string", mapping: "FINAL_MOD_DATE"} 
	    				 	  ]; 
 

/***************************************************************************
 * 설  명 : 편집그리드 설정 (개발프로젝트장비정보)
***************************************************************************/
var	gridHeigth_edit_2nd	= 200;
var	gridWidth_edit_2nd  = 1022	;
var	gridTitle_edit_2nd  = "개발장비관리"	; 
var	render_edit_2nd		= "edit_grid_2nd";
var keyNm_edit_2nd		= "PJT_INFO_SEQ";
var pageSize_edit_2nd	= 4;
var limit_edit_2nd		= pageSize_edit_2nd;
var start_edit_2nd		= 0;
var proxyUrl_edit_2nd	= "/dev/pjdInfo/result_edit_2nd.sg";
var grid2ndRowDeleteYn  = "Y";
var tbarHidden_edit_1st ="N";

// 행추가
function addNew_edit_2nd(){


	if(Ext.get('pjt_name').getValue() == '')
	{
		Ext.Msg.alert('확인', '프로젝트를 선택하십시오');
		return;
	}
	

	fnEquipPop();

	
	
}

// 그리드 행삭제
function fnEdit2ndBeforeRowDeleteEvent(){

	var delRecord = GridClass_edit_2nd.grid.selModel.getSelections();
		delRecord[0].set('FLAG', 'D');						//상태

}



/***************************************************************************
 * 설  명 : 삭제버튼 클릭-DB삭제
 ***************************************************************************/
function fnGridDeleteRow2nd(selectedRecord){

	var json = "["+Ext.util.JSON.encode(selectedRecord.data)+"]";

	var sForm = document.searchForm;

	sForm.src_pjt_date_from.value = sForm.src_pjt_date_from_tmp.value.replaceAll('-','');		   	 
	sForm.src_pjt_date_to.value = sForm.src_pjt_date_to_tmp.value.replaceAll('-','');	
	
	
	var dForm = document.detailForm;
	
//alert("-dForm.proc_status_code.value-->"+dForm.proc_status_code.value)
    if(dForm.proc_status_code.value !="" && dForm.proc_status_code.value != 'G10' )
    {
    	var msgTmp ="";
    	if(dForm.proc_status_code.value == "G00")
    	{	
    		msgTmp ="프로잭트가 DROP 상태입니다.";
    	}
    	
    	if(dForm.proc_status_code.value == "G20")
    	{	
    		msgTmp ="프로젝트 일정계획이 등록되었습니다.";
    	}
    	
    	if(dForm.proc_status_code.value == "G00")
    	{	
    		msgTmp ="프로젝트가 진행중입니다.";
    	}
    	
    	if(dForm.proc_status_code.value == "G00")
    	{	
    		msgTmp ="프로젝트가 완료되었습니다.";
    	}
    	
    
    	Ext.Msg.alert('확인', msgTmp);
    	return;
    } 	
	
	
	Ext.Ajax.request({   
		url: "/dev/pjdInfo/deletePjdEquipInfo.sg"   
		,success: function(response){						// 조회결과 성공시
					// 조회된 결과값, store명
					//handleSuccess(response,GridClass_edit_2nd);
					
					var json = Ext.util.JSON.decode(response.responseText);
					//handleSuccess(response,GridClass_edit_2nd);
					
					GridClass_edit_2nd.store.commitChanges();	// 변경된 record를 commit
					GridClass_edit_2nd.store.removeAll();		// store자료를 삭제
						
					// 조회된 결과값, store명
					var json = Ext.util.JSON.decode(response.responseText);
										
					GridClass_edit_2nd.store.loadData(json);					
					
		          }
		,failure: handleFailure   	    // 조회결과 실패시  
		,form   : document.searchForm   // 검색 FORM
		,params : { 
					limit          		: limit_edit_2nd
				   , start         		: start_edit_2nd
				   ,deleteData : json
				   ,pjt_id : selectedRecord.data.PJT_ID
			      } 
	});
	
	
	//fnInitValue(); // 상세필드 초기화

}



// 페이징
function fnPagingValue_edit_2nd(){	
	try{
		GridClass_edit_2nd.store.setBaseParam('start'		,start_edit_2nd);
	    GridClass_edit_2nd.store.setBaseParam('limit'		,limit_edit_2nd);
	    GridClass_edit_2nd.store.setBaseParam('pjt_id'		,Ext.get('pjt_id').getValue());
		GridClass_edit_2nd.store.setBaseParam('pjt_type_code'	,Ext.get('pjt_type_code').getValue());
	}catch(e){

	}
}


/** 장비구분코드 combo box 생성 start **/
var EQUIP_TYPE_CODE_COMBO = new Ext.form.ComboBox({    
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
     <c:forEach items="${EQUIP_TYPE_CODE}" var="data" varStatus="status">
      ['${data.COM_CODE}', '${data.COM_CODE_NAME}']
      <c:if test="${not status.last}">,</c:if>
     </c:forEach>
      ]
   })
});

//combo box render
Ext.util.Format.comboRenderer = function(EQUIP_TYPE_CODE_COMBO){    
 return function(value){        
 var record = EQUIP_TYPE_CODE_COMBO.findRecord(EQUIP_TYPE_CODE_COMBO.valueField, value);        
 return record ? record.get(EQUIP_TYPE_CODE_COMBO.displayField) : EQUIP_TYPE_CODE_COMBO.valueNotFoundText;    
}}




// 그리드 필드
var	userColumns_edit_2nd	= [ 
								{header: "조회상태"                 ,width: 60  ,sortable: true ,dataIndex: "FLAG"                      ,hidden : true}              
							  , {header: "순번",			width: 10,	sortable: true,	dataIndex: "PJT_INFO_SEQ"	 ,hidden : true}
							  , {header: "프로젝트ID",		width: 50,	sortable: true,	dataIndex: "PJT_ID"		 }
							  , {header: "프로젝트명",		width: 50,	sortable: true,	dataIndex: "PJT_NAME"	 }
							  , {header: "장비코드",		width: 30,	sortable: true,	dataIndex: "ITEM_CODE" }
							  , {header: "장비코드명",		width: 50,	sortable: true,	dataIndex: "ITEM_NAME" }
							  , {header: "장비구분",		width: 30,	sortable: true,	dataIndex: "EQUIP_TYPE_CODE" , editor: EQUIP_TYPE_CODE_COMBO  , editor: EQUIP_TYPE_CODE_COMBO  ,renderer: Ext.util.Format.comboRenderer(EQUIP_TYPE_CODE_COMBO)  }
							  , {header: "장비정보",		width: 50,	sortable: true,	dataIndex: "EQUIP_DETAIL",	editor: new Ext.form.TextField({ allowBlank : false }) }
							  , {header: "비고",			width: 50,	sortable: true,	dataIndex: "NOTE",		editor: new Ext.form.TextField({ allowBlank : false }) }
							  , {header: "장비구분코드",	width: 10,	sortable: true,	dataIndex: "EQUIP_TYPE_CODE",		editor: new Ext.form.TextField({ allowBlank : false }) ,hidden : true}
							  , {header: "최종변경자ID",	width: 10,	sortable: true,	dataIndex: "FINAL_MOD_ID",	editor: new Ext.form.TextField({ allowBlank : false }) ,hidden : true}
							  , {header: "최종변경일시",	width: 10,	sortable: true,	dataIndex: "FINAL_MOD_DATE",editor: new Ext.form.TextField({ allowBlank : false }) ,hidden : true}
							  ];

// 맵핑 필드
var	mappingColumns_edit_2nd	= [ 
								{name: "FLAG", 		type:"string", mapping: "FLAG"}						// 조회상태
							  , {name: "PJT_INFO_SEQ", 	type:"string", mapping: "PJT_INFO_SEQ"}			// 순번        
							  , {name: "PJT_ID", 		type:"string", mapping: "PJT_ID"}				// 프로젝트ID      
							  , {name: "PJT_NAME", 		type:"string", mapping: "PJT_NAME"}				// 프로젝트명      
							  , {name: "ITEM_CODE", 		type:"string", mapping: "ITEM_CODE"}		// 품목코드  
							  , {name: "ITEM_NAME", 			type:"string", mapping: "ITEM_NAME"}			// 품목코드명  	
							  , {name: "EQUIP_TYPE_CODE",type:"string", mapping: "EQUIP_TYPE_CODE"}		// 장비구분
							  , {name: "EQUIP_DETAIL", 	type:"string", mapping: "EQUIP_DETAIL"}			// 장비정보    
							  , {name: "NOTE", 			type:"string", mapping: "NOTE"}					// 비고        
							  , {name: "EQUIP_TYPE_NAME", 			type:"string", mapping: "EQUIP_TYPE_NAME"}		// 장비구분명        
							  , {name: "FINAL_MOD_ID", 	type:"string", mapping: "FINAL_MOD_ID"}			// 최종변경자ID
							  , {name: "FINAL_MOD_DATE",type:"string", mapping: "FINAL_MOD_DATE"}		// 최종변경일시
	    				 	  ]; 

/***************************************************************************
 * 설  명 : 필드 초기화
 **************************************************************************/
function fnInitValue(){

	var dForm = document.detailForm;		// 상세 FORM	
	dForm.reset();							// 상세필드 초기화
	
	// 버튼 초기화
	Ext.get('saveBtn').dom.disabled    	   = false;
	Ext.get('updateBtn').dom.disabled  	   = true;
	Ext.get('deleteBtn').dom.disabled  	   = true;

	
	try{
		GridClass_edit_1st.store.commitChanges();	// 변경된 record를 commit
		GridClass_edit_1st.store.removeAll();		// store자료를 삭제
		GridClass_edit_2nd.store.commitChanges();
		GridClass_edit_2nd.store.removeAll();
	}catch(e){
		
	}
	
	 Ext.get('pjt_reg_emp_num').set({value : '${sabun}'}, false);  
	 Ext.get('pjt_reg_dept_code').set({value : '${dept_code}'}, false);  
	 Ext.get('pjt_reg_dept_name').set({value : '${dept_nm}'}, false);  
	 Ext.get('pjt_reg_emp_name').set({value : '${admin_nm}'}, false);  	
	 
	 Ext.get('pjt_reg_date_tmp').set({value : getToDay(0)}, false);  	
	 
	 
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
		aExt.Msg.alert('확인', '프로젝트 종료일을 선택하세요');
		return;
	}

	if(fnCalDate(sForm.src_pjt_date_from.value,sForm.src_pjt_date_to.value,'D') < 0){
	  Ext.Msg.alert('확인', '검색시작일이 검색종료일보다 이전입니다.'); 
	  return;
	}


	// 변경된 상세정보 Grid의 record 
	var records = GridClass_edit_1st.store.getModifiedRecords();	  
	// 변경된 record의 자료를 json형식으로
    var edit1stJson = "[";
	    for (var i = 0; i < records.length; i++) {
	      edit1stJson += Ext.util.JSON.encode(records[i].data);				
	      if (i < (records.length-1)) {
	        edit1stJson += ",";
	      }
	    }
    	edit1stJson += "]"
    	
	// 변경된 개발장비정보 Grid의 record
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
		url: "/dev/pjdInfo/result.sg"
		,method : 'POST'   
		,success: function(response){						// 조회결과 성공시
					// 조회된 결과값, store명
					handleSuccess(response,GridClass_1st);
		          }
		,failure: handleFailure   	   // 조회결과 실패시  
		,form   : document.detailForm  // 검색 FORM
		,params : {					   // 조회조건을 DB로 전송하기위해서 조건값 설정
					limit          : limit_1st
				  , start          : start_1st
				  , edit1stData		   : edit1stJson 		// 프로젝트 상세(제품)정보
  				  , edit2ndData        : edit2ndJson		// 프로젝트 장비정보
				  // 검색정보
			  	  , src_pjt_name   	   : Ext.get('src_pjt_name').getValue()		  		// 프로젝트명  
			  	  , src_pjt_date_from    : Ext.get('src_pjt_date_from').getValue()    	//  프로젝트 시작일 
			  	  , src_pjt_date_to    : Ext.get('src_pjt_date_to').getValue()    		// 프로젝트 종료일
				  }				
	});  
	
}  		

/***************************************************************************
 * 설  명 : 저장버튼 클릭
 ***************************************************************************/
function fnSave(){  	

	var sForm = document.searchForm;
	sForm.src_pjt_date_from.value = sForm.src_pjt_date_from_tmp.value.replaceAll('-','');		   	 
	sForm.src_pjt_date_to.value = sForm.src_pjt_date_to_tmp.value.replaceAll('-','');	

	var dForm = document.detailForm;		// 상세 FORM	
	dForm.pjt_date_from.value = dForm.pjt_date_from_tmp.value.replaceAll('-','');		   	 
	dForm.pjt_date_to.value = dForm.pjt_date_to_tmp.value.replaceAll('-','');	
	dForm.pjt_reg_date.value = dForm.pjt_reg_date_tmp.value.replaceAll('-','');	


	// 변경된 프로젝트 상세(제품)정보 Grid의 record 
	var records = GridClass_edit_1st.store.getModifiedRecords();	

	var rowTotCnt = GridClass_edit_1st.store.getCount();
	var itemTotChk =0;

    if(dForm.pjt_name.value == '')
    {
    	Ext.Msg.alert('확인', '프로젝트명을 선택하십시오.');
    	return;
    }


    if(dForm.proc_status_code.value !="" && dForm.proc_status_code.value != 'G10' )
    {
    	var msgTmp ="";
    	if(dForm.proc_status_code.value == "G00")
    	{	
    		msgTmp ="프로잭트가 DROP 상태입니다.";
    	}
    	
    	if(dForm.proc_status_code.value == "G20")
    	{	
    		msgTmp ="프로젝트 일정계획이 등록되었습니다.";
    	}
    	
    	if(dForm.proc_status_code.value == "G00")
    	{	
    		msgTmp ="프로젝트가 진행중입니다.";
    	}
    	
    	if(dForm.proc_status_code.value == "G00")
    	{	
    		msgTmp ="프로젝트가 완료되었습니다.";
    	}
    	
    
    	Ext.Msg.alert('확인', msgTmp);
    	return;
    }


    if(dForm.roll_type_code.value == '')
    {
    	Ext.Msg.alert('확인', '사업구분을 선택하십시오.');
    	return;
    }
    
    if(dForm.pay_free_code.value == '')
    {
    	Ext.Msg.alert('확인', '유무상구분을 선택하십시오.');
    	return;
    }    
    
    if(dForm.pjt_reg_date_tmp.value == '')
    {
    	Ext.Msg.alert('확인', '등록일자를 선택하십시오.');
    	return;
    } 
    
    if(dForm.pjt_reg_emp_name.value == '')
    {
    	Ext.Msg.alert('확인', '프로젝트 등록자를 선택하십시오.');
    	return;
    }         

    if(dForm.pjt_date_from.value == '')
    {
    	Ext.Msg.alert('확인', '프로젝트 시작일을 선택하십시오.');
    	return;
    }  
    
    if(dForm.pjt_date_to.value == '')
    {
    	Ext.Msg.alert('확인', '프로젝트 종료일을 선택하십시오.');
    	return;
    }      

	if(fnCalDate(dForm.pjt_date_from.value,dForm.pjt_date_to.value,'D') < 0){
	  Ext.Msg.alert('확인', '프로젝트 시작일이 종료일보다 이전입니다.'); 
	  return;
	}

	for(var k=0;  k < rowTotCnt; k++){	//기존 데이타 전체 검색

		var recodeAt = GridClass_edit_1st.store.getAt(k);
		var data = recodeAt.data.ITEM_CODE;       //기존 데이타
	 		
		if(data =='')	 
		{
			itemTotChk++;	
		}
	}
	
	if(itemTotChk >0 || rowTotCnt ==0)
	{
		Ext.Msg.alert('확인', '선택된 제품이 없습니다.');	
		return;
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
	
	// 변경된 record의 자료를 json형식으로
    var edit2ndJson = "[";
	    for (var i = 0; i < record2.length; i++) {

//alert(record2[i].data.EQUIP_TYPE_NAME+"---22--"+record2[i].data.EQUIP_TYPE_CODE);			
	      if(record2[i].data.FLAG != 'D')
	      {
		      edit2ndJson += Ext.util.JSON.encode(record2[i].data);				
		      if (i < (record2.length-1)) {
		        edit2ndJson += ",";
		      }
		  }
	    }
    	edit2ndJson += "]"

	
	var reSrchDtlValue ="";
	Ext.Ajax.request({   
		url: "/dev/pjdInfo/actionPjtInfoMng.sg"   
		,success: function(response){						// 조회결과 성공시
					// 조회된 결과값, store명
					//alert(response.responseText);
					
					handleSuccess(response,GridClass_1st,'save');
					
						
					// 조회된 결과값, store명
					var json = Ext.util.JSON.decode(response.responseText);
	
					
					reSrchDtlValue = json.data_1st[0].PJT_ID;
					
					
					if( Ext.get('pjt_id').getValue() !="")
					{
						reSrchDtlValue = Ext.get('pjt_id').getValue();
					}
				

					//fnSearchEdit1st(reSrchDtlValue);
					//fnSearchEdit2nd(reSrchDtlValue);					
					
		          } 
		,failure: handleFailure   	    // 조회결과 실패시  
		,form   : document.detailForm	// 상세 FORM	
		,params : {					    // 조회조건을 DB로 전송하기위해서 조건값 설정
				  // 페이지정보
					limit          : limit_1st
			  	  , start          : start_1st
			  	  , edit1stData		   : edit1stJson 		// 프로젝트 상세(제품)정보
  				  , edit2ndData        : edit2ndJson		// 프로젝트 장비정보
				  // 검색정보
			  	  , src_pjt_date_from : Ext.get('pjt_date_from').getValue() 
			  	  , src_pjt_date_to   : Ext.get('pjt_date_to').getValue() 
			  	  , pjdInfoYn : "Y"				//사용유무 
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
	var dForm = document.detailForm;
	
	dForm.pjt_id.value="자동생성";	

	var toDay = getTimeStamp(); 
	 toDay = toDay.replaceAll('-','');
	 toDay = addDate(toDay, 'M', -3);
	 toDay = toDay.substring(0,4)+"-"+toDay.substring(4,6)+"-"+toDay.substring(6,8);
	 var fromDay = toDay;
	 toDay = getTimeStamp().trim();
	 	
	
    // 검색버튼 클릭
	Ext.get('searchBtn').on('click', function(e){
        if(Validator.validate(sForm)){
			fnSearch()
			// GridClass_2nd.store.reload()
		}	
    });
    
   	//조건해제 버튼 -> 검색조건 초기화
   	Ext.get('searchClearBtn').on('click', function(e){
        sForm.reset();	
        
        Ext.get('src_pjt_date_from_tmp').set({value:fromDay} , false);
		Ext.get('src_pjt_date_to_tmp').set({value:toDay} , false);
        
    });
   	
   	
/*    	   	
   	// 담당자검색 버튼
   	// 여러건을 팝업으로 부터 전송 받을경우 param뒤에 &multiSelectYn=Y 를 추가 
	Ext.get('pjtRegNumBtn').on('click', function(e){
		var param = '';
		fnEmployeePop('pjtRegNumBtn')
	});
*/

   	// 책임자검색 버튼
   	// 여러건을 팝업으로 부터 전송 받을경우 param뒤에 &multiSelectYn=Y 를 추가 
	Ext.get('pjtRespnNumBtn').on('click', function(e){
		var param = '';
		fnEmployeePop('pjtRespnNumBtn')
	});

			
   	//신규 버튼 -> 상세필드 초기화
	Ext.get('detailClearBtn').on('click', function(e){
		fnInitValue();		   
	});		
   	
			
	//저장 버튼 -> 데이터를 server로 전송
	Ext.get('saveBtn').on('click', function(e){	
		if(Validator.validate(dForm)){
			Ext.MessageBox.confirm('Confirm', '저장하시겠습니까?', showResult);
		};
	});
	
	//수정 버튼 -> 데이터를 server로 전송
	Ext.get('updateBtn').on('click', function(e){	
		if(Validator.validate(dForm)){
			Ext.MessageBox.confirm('Confirm', '수정하시겠습니까?', showResult);
		};	
	});
   	
   	
   	//삭제
	Ext.get('deleteBtn').on('click', function(e){	
		Ext.MessageBox.confirm('Confirm', '삭제하시겠습니까?', fnDelete);

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
	// 프로젝트 등록일자
	var pjt_reg_date_tmp = new Ext.form.DateField({
    	applyTo: 'pjt_reg_date_tmp',
		allowBlank: false,
		format:'Y-m-d',
		editable : false,
		value : toDay
	});
*/

	// 등록 프로젝트 시작일자
	var startDate = new Ext.form.DateField({
    	applyTo: 'pjt_date_from_tmp',
		allowBlank: false,
		format:'Y-m-d',
		editable : true,
		value : toDay
	});
	
	Ext.get('pjt_date_from_tmp').on('change', function(e){	
		
		var val = Ext.get('pjt_date_from_tmp').getValue();
		var reVal = fnGridDateCheck(val);
		
		Ext.get('pjt_date_from_tmp').set({value:reVal} , false);
	});
	
   	
	// 등록 프로젝트 종료일자
	var endDate = new Ext.form.DateField({
    	applyTo: 'pjt_date_to_tmp',
		allowBlank: false,
		format:'Y-m-d',
		editable : true,
		value : toDay
	});
	
	Ext.get('pjt_date_to_tmp').on('change', function(e){	
		
		var val = Ext.get('pjt_date_to_tmp').getValue();
		var reVal = fnGridDateCheck(val);
		
		Ext.get('pjt_date_to_tmp').set({value:reVal} , false);
	});
	
   	

	
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
	var dlgWidth  = 399;
	var dlgHeight = 364;
	var winName   = "custom";
	fnOpenPop(sURL, dlgWidth, dlgHeight, winName);
}


/***************************************************************************
 * 설  명 : 담당자검색
 ***************************************************************************/
function fnEmployeePop(param){
	var sURL      = "/com/employee/employeePop.sg?requestFieldName="+param;
	var dlgWidth  = 399;
	var dlgHeight = 396;
	if(param ='pjtRegNumBtn')
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

	if(fieldName =='pjtRegNumBtn')
	{
	    Ext.get('pjt_reg_emp_num').set({value:record.EMP_NUM} , false);
	    Ext.get('pjt_reg_emp_name').set({value:record.KOR_NAME} , false);
	    Ext.get('pjt_reg_dept_code').set({value:record.DEPT_CODE} , false);
	    Ext.get('pjt_reg_dept_name').set({value:record.DEPT_NAME} , false);
	}else
	{
		Ext.get('pjt_own_emp_num').set({value:record.EMP_NUM} , false);
    	Ext.get('pjt_own_emp_name').set({value:record.KOR_NAME} , false);
    	Ext.get('pjt_own_dept_code').set({value:record.DEPT_CODE} , false);
    	Ext.get('pjt_own_dept_name').set({value:record.DEPT_NAME} , false);
	}

}



/***************************************************************************
 * 설  명 : 제품검색
 ***************************************************************************/
function pjtInfoNitemPop(){

	var sURL      = "/dev/pjdInfo/pjtInfoNitemPop.sg?multiSelectYn=Y";
	var dlgWidth  = 650;
	var dlgHeight = 390;
	var winName   = "pjt";
	fnOpenPop(sURL, dlgWidth, dlgHeight, winName);
}


/***************************************************************************
 * 설  명 : 프로젝트색 결과 반영
 ***************************************************************************/
function fnPjtNitemPopValue(records){
		

	var dupChk =0;
	var alertMsg ="";
	
	var rowTotCnt = GridClass_edit_1st.store.getCount();
    var oldData ="";
    
    
    
	for (var i = 0; i < records.length; i++) {
		
//alert("---dupChk--222-"+dupChk+"--records[i].data.PJT_ID-"+records[i].data.PJT_ID)	

			var Plant = GridClass_edit_1st.grid.getStore().recordType; 
		    var p = new Plant({ 
			        		    FLAG			: 'I' 
			        		  , ITEM_CODE	    : records[i].data.ITEM_CODE
						   	  , ITEM_NAME	    : records[i].data.ITEM_NAME
				    		  , SAL_PJT_ID      : records[i].data.PJT_ID == null ? "" :  records[i].data.PJT_ID
				    		  , SAL_PJT_NAME    : records[i].data.PJT_NAME == null ? "" : records[i].data.PJT_NAME
				    		  , CSR_ID          : records[i].data.CSR_ID
				    		  , CSR_INFO_SEQ    : records[i].data.CSR_INFO_SEQ
		    				  }); 
		  	GridClass_edit_1st.grid.stopEditing();
			GridClass_edit_1st.store.insert(0, p);
			GridClass_edit_1st.grid.startEditing(0, 0);
	}
}


/***************************************************************************
 * 설  명 : EDIT GRID에서 품목 CELL을 클릭하였을 경우 아이템 검색 팝업
 ***************************************************************************/
function fnEquipPop(param){
 var sURL      = "/com/item/itemEquipSearchPop.sg?"+param;
 
 var dlgWidth  = 399;
 var dlgHeight = 370;
 var winName   = "item";
 fnOpenPop(sURL, dlgWidth, dlgHeight, winName);
}



/***************************************************************************
 * 설  명 : 아이템 검색 팝업에서 선택한 그리드의 값을 받아 처리하는 함수
 ***************************************************************************/
function fnEquipSearchPopValue(records){

	var record = records[0].data;
	
	var parentsRecord = GridClass_edit_2nd.grid.selModel.getSelected();


	var Plant = GridClass_edit_2nd.grid.getStore().recordType; 
    var p = new Plant({ 
	        		    FLAG			: 'I' 
	        		  , PJT_ID		    : Ext.get('pjt_id').getValue()
	        		  , PJT_NAME		: Ext.get('pjt_name').getValue()
	        		  , ITEM_CODE		: record.ITEM_CODE
	        		  , ITEM_NAME		: record.ITEM_NAME
    				  }); 

  	GridClass_edit_2nd.grid.stopEditing();
	GridClass_edit_2nd.store.insert(0, p);
	GridClass_edit_2nd.grid.startEditing(0, 0);

}



/***************************************************************************
 * 설  명 : 에디트 그리드의 CELL을 클릭하였을 경우 이벤트
 ***************************************************************************/
function  fnEdit1stCellClickEvent(grid, rowIndex, columnIndex, e){


}


/***************************************************************************
 * 설  명 : 에디트 그리드의 CELL을 수정하였을 경우 이벤트
 ***************************************************************************/
function  fnEdit1stAfterCellEdit(obj){


}

function fnEdit1stAfterRowDeleteEvent(){


}




/***************************************************************************
 * 설  명 : 에디트 그리드의 CELL을 클릭하였을 경우 이벤트
 ***************************************************************************/
function  fnEdit2ndCellClickEvent(grid, rowIndex, columnIndex, e){

}



// 팝업
function fnOpenPop(sURL, dlgWidth, dlgHeight, winName){
  var xPos=(window.screen.width) ? (window.screen.width-dlgWidth)/2 : 0;
  var yPos=(window.screen.height) ? (window.screen.height-dlgHeight)/2 : 0;
  var sFeatures = "titlebar=no, scrollbars=no,location=no ,menubar=no, resizable=no, status=yes, width="+dlgWidth+",height="+dlgHeight+",left="+xPos+", top="+yPos;

  window.open(sURL,winName, sFeatures);
}


/***************************************************************************
 * 설  명 : 삭제버튼 클릭
 ***************************************************************************/
function fnDelete(btn){  	

   	if(btn != 'yes'){
   		return;
   	} 

	var sForm = document.searchForm;	// 검색 FORM
	var dForm = document.detailForm;	// 상세 FORM
	
	sForm.src_pjt_date_from.value = sForm.src_pjt_date_from_tmp.value.replaceAll('-','');		   	 
	sForm.src_pjt_date_to.value = sForm.src_pjt_date_to_tmp.value.replaceAll('-','');	
	
	// 변경된 Gride의 record
	var records = GridClass_1st.grid.selModel.getSelections(); 
	var modifyLen = records.length;

    if(dForm.pjt_id.value == "")
    {
    	Ext.Msg.alert('확인', '개발프로젝트를 선택하십시오.')
		return false;
    }    
    

    if(dForm.proc_status_code.value !="" && dForm.proc_status_code.value != 'G10' )
    {
    	var msgTmp ="";
    	if(dForm.proc_status_code.value == "G00")
    	{	
    		msgTmp ="프로잭트가 DROP 상태입니다.";
    	}
    	
    	if(dForm.proc_status_code.value == "G20")
    	{	
    		msgTmp ="프로젝트 일정계획이 등록되었습니다.";
    	}
    	
    	if(dForm.proc_status_code.value == "G00")
    	{	
    		msgTmp ="프로젝트가 진행중입니다.";
    	}
    	
    	if(dForm.proc_status_code.value == "G00")
    	{	
    		msgTmp ="프로젝트가 완료되었습니다.";
    	}
    	
    
    	Ext.Msg.alert('확인', msgTmp);
    	return;
    }    
    
    
    var rowCnt = GridClass_edit_1st.store.getCount();  // Grid의 총갯수
    
    var csrPatternItemJson = "[";
	    for(i = 0 ; i < rowCnt ; i++){
	    	var record = GridClass_edit_1st.store.getAt(i);
	    	
	    	if(record.data.FLAG != 'D')	    
			{

		      csrPatternItemJson += Ext.util.JSON.encode(record.data);				
		      if (i < (rowCnt-1)) {
		        csrPatternItemJson += ",";
		      }
		    }
	    }
    	csrPatternItemJson += "]"    
    
    
    
//alert("--csrPatternItemJson--"+csrPatternItemJson);	     
	    
		Ext.Ajax.request({   
			url: "/dev/pjdInfo/actionPjtInfoMng.sg"   
			,success: function(response){						// 조회결과 성공시
						// 조회된 결과값, store명
						//alert(response.responseText);
						//handleSuccess(response,GridClass_1st);
						
						GridClass_1st.store.commitChanges();	// 변경된 record를 commit
						GridClass_1st.store.removeAll();		// store자료를 삭제
						
						// 조회된 결과값, store명
						var json = Ext.util.JSON.decode(response.responseText);
						GridClass_1st.store.loadData(json);							
						
			          }
			,failure: handleFailure   	    // 조회결과 실패시  
			,form   : document.detailForm   // 상세 FORM
			,params : { 
					   limit          : limit_1st
					  	, start          : start_1st
			  	  		, src_pjt_date_from : Ext.get('src_pjt_date_from').getValue() 
			  	  		, src_pjt_date_to   : Ext.get('src_pjt_date_to').getValue() 
					  	, pjdInfoYn : "N"	
					  	, csrPatternItem : csrPatternItemJson
				      } 
		});  
		
		fnInitValue(); // 상세필드 초기화


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
     
    return ("" + year+"-"+ month+"-"+ day)

}





/**********************************************
    * 함수명 : jk_ContentsCheck
    * 기   능 : textarea 글자수 확인
***********************************************/
function jk_ContentsCheck(lee,CT_max) {

	 var ls_str     = lee.value;
	 var li_str_len = ls_str.length; // 글자수

	 var li_max      = CT_max;  // 제한할 글자수
	 var i           = 0;   // for문에 사용
	 var li_byte     = 0;   // 한글이면 2 그 외엔 1을 더함
	 var li_len      = 0;   // substring하기 위해서 사용
	 var ls_one_char = "";   // 한글자씩 검사
	 var ls_str2     = "";   // 글자수 초과시 제한수 글자까지만 출력

	 for ( i = 0 ; i < li_str_len ; i ++ ) {
	 ls_one_char = ls_str.charAt(i);  // 한글자추출

	 if ( escape(ls_one_char).length > 4 ) { // 한글이면 2를 더한다.
	  li_byte += 2;
	 } else {    // 그밗의 경우는 1을 더한다.
	  li_byte++;
	 }

	 // 전체 크기가 li_max를 넘지않으면
	 if(li_byte <= li_max){
		  li_len = i + 1;
		  //InnerHtml('txtLen',li_byte);
	 }	 

	}
	  
	if ( li_byte > li_max ) { // 전체길이를 초과하면
	     alert( li_max + " 글자까지만 입력이 가능합니다.");
	     ls_str2 = ls_str.substr(0, li_len);
	     lee.value = ls_str2;
	}

	lee.focus();   

}


</script>

</head>
<body class="ext-gecko ext-gecko3">
	<table border="0" width="1000" height="200">
		<tr>
			<td colspan="2">
				<form name="searchForm" id="searchForm">
				<input type="hidden" id="src_pjt_date_from" name="src_pjt_date_from"  />		
				<input type="hidden" id="src_pjt_date_to" name="src_pjt_date_to"  />			
				<input type="hidden" id="pjt_type_code" name="pjt_type_code"  value="22"/>	<!-- 프로젝트구분코드 -->
				
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
											<div tabindex="-1" class="x-form-item " >
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
																<input type="text" name="src_pjt_date_to_tmp" id="src_pjt_date_to_tmp" autocomplete="off" size="10" style="width: auto;">		
															</td>
														</tr>
													</table>
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
			<td width="40%" valign="top">
				<div id="pjt_info_grid" style="margin-top: 0.4em;"></div>
			</td>
			
			
			<!----------------- 프로젝트기본정보 GRID END ----------------->
			<td width="60%" valign="top">
				<div class=" x-panel x-form-label-left" style="margin-top: 0.4em; width: 100%;"><%-- 0em <- 1em으로 수정하면 상위 공백 --%>
					<!----------------- SEARCH Hearder Start	 ----------------->
					<div class="x-panel-tl">
						<div class="x-panel-tr">
							<div class="x-panel-tc">
								<div class="x-panel-header x-unselectable" style="-moz-user-select: none;">
									<span class="x-panel-header-text">프로젝트 기본정보</span>
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
									<form id="detailForm" name="detailForm" method="POST" class="x-panel-body x-form" style="padding: 1px 1px 0pt; width: 600px;">
										<input type="hidden" id="pjt_date_from" name="pjt_date_from"  />				<!-- 프로젝트 기간 from -->
										<input type="hidden" id="pjt_date_to" name="pjt_date_to"  />					<!-- 프로젝트 기간 to -->
										<input type="hidden" id="pjt_reg_date" name="pjt_reg_date"  />					<!-- 등록일자 -->
										
										<input type="hidden" id="pjt_reg_dept_code" name="pjt_reg_dept_code"  />		<!-- 등록자 부서코드 -->
										<input type="hidden" id="pjt_reg_emp_num" name="pjt_reg_emp_num"  />			<!-- 등록자사번 -->
										
										<input type="hidden" id="pjt_own_dept_code" name="pjt_own_dept_code"  />		<!-- 책임자 부서코드 -->
										<input type="hidden" id="pjt_own_emp_num" name="pjt_own_emp_num"  />		<!-- 책임자 사번 -->
										
										<input type="hidden" id="pjt_type_code" name="pjt_type_code"  value="22"/>		<!-- 프로젝트구분코드 -->
										
										<input type="hidden" id="reg_id" name="reg_id"  />								<!-- 최초등록자 -->
										<input type="hidden" id="reg_date" name="reg_date"  >					<!-- 최초등록일-->
										
										<input type="hidden" id="proc_status_code" name="proc_status_code"  >					<!-- 진행상태-->
										
										<input type="hidden" id="final_mod_id" name="final_mod_id"  >					
										
									
				
									<input type="hidden" id="flag" name="flag"/>
									<!-- 1_ROW Start -->
									<div class="x-column-inner" style="width: 100%; margin-top: 0.2em;">
										<div class=" x-panel x-column" style="width: 100%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
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
												</div>
											</div>
										</div>
									<!-- 1_ROW End -->


									<!-- 2_ROW Start -->
									<div class="x-column-inner" style="width: 100%; margin-top: 0.2em;">
										<div class=" x-panel x-column" style="width: 50%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label class="x-form-item-label" style="width: 90px;" for="pjt_id" ><font color="red">* </font>프로젝트ID:</label>
														<div style="padding-left: 80px;" class="x-form-element">
															<input type="text" name="pjt_id" id="pjt_id" autocomplete="off" size="35" class=" x-form-text x-form-field" style="width: auto;" readonly="true">
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
														<label class="x-form-item-label" style="width: 90px;" for="pjt_name" ><font color="red">* </font>프로젝트명:</label>
														<div style="padding-left: 80px;" class="x-form-element">
															<input type="text" name="pjt_name" id="pjt_name" autocomplete="off" size="19" class=" x-form-text x-form-field" style="width: 200px;" maxlength="20" >
														</div>
														<div class="x-form-clear-left">
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>
									<!-- 2_ROW End -->

									<!-- 3_ROW Start -->
									<div class="x-column-inner" style="width: 100%; margin-top: 0.2em;">
										<div class=" x-panel x-column" style="width: 50%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label class="x-form-item-label" style="width: 90px;" for="roll_type_code" ><font color="red">* </font>사업구분:</label>
														<div style="padding-left: 80px;" class="x-form-element">
															<select name="roll_type_code" id="roll_type_code" title="사업구분" style="width: 67%;" type="text" class=" x-form-select x-form-field" >
																<option value="">선택하세요</option>
																<c:forEach items="${ROLL_TYPE_CODE}" var="data" varStatus="status">
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
														<label class="x-form-item-label" style="width: 90px;" for="pay_free_code" ><font color="red">* </font>유무상구분:</label>
														<div style="padding-left: 90px;" class="x-form-element">
															<select name="pay_free_code" id="pay_free_code" title="유무상구분" style="width: 67%;" type="text" class=" x-form-select x-form-field" >
																<option value="">선택하세요</option>
																<c:forEach items="${PAY_FREE_CODE}" var="data" varStatus="status">
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
									<!-- 3_ROW End -->
									
									<!-- 4_ROW Start -->
									<div class="x-column-inner" style="width: 100%;">
										<div class=" x-panel x-column" style="width: 50%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label class="x-form-item-label" style="width: 90px;" for="pjt_reg_date_tmp" ><font color="red">* </font>등록일자:</label>
														<div style="padding-left: 90px;" class="x-form-element">
															<input type="text" name="pjt_reg_date_tmp" id="pjt_reg_date_tmp" autocomplete="off" size="35" class=" x-form-text x-form-field" style="width: auto;"readOnly >
														</div>
														<div class="x-form-clear-left">
														</div>
													</div>
												</div>
											</div>
										</div>
										<div class=" x-panel x-column" style="width: 50%;" >
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label class="x-form-item-label" style="width: 105px;" for="pjt_reg_dept_name" ><font color="red">* </font>프로젝트등록자:</label>
														<div style="padding-left: 80px;" class="x-form-element">
															<table style="width: 190px;" border="0" cellspacing="0" class="x-btn  x-btn-noicon">
																<tr>
																	<td>
																		<input type="text" name="pjt_reg_dept_name" id="pjt_reg_dept_name" autocomplete="off" size="16" class=" x-form-text x-form-field" style="width: auto;" readOnly >
																		<input type="text" name="pjt_reg_emp_name" id="pjt_reg_emp_name" autocomplete="off" size="10" class=" x-form-text x-form-field" style="width: auto;" readOnly >
																	</td>
																	<!--
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
																							<button type="button" id="pjtRegNumBtn" class=" x-btn-text">검색</button>
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
																	-->
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
									<!-- 4_ROW End -->		
									
									<!-- 5_ROW Start -->
									<div class="x-column-inner" style="width: 100%;">
										<div class=" x-panel x-column" style="width: 50%;" >
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label class="x-form-item-label" style="width: 105px;" for="pjt_own_dept_name" ><font color="red">* </font>프로젝트책임자:</label>
														<div style="padding-left: 50px;" class="x-form-element">
															<table style="width: 185px;" border="0" cellspacing="0" class="x-btn  x-btn-noicon">
																<tr>
																	<td>
																		<input type="text" name="pjt_own_dept_name" id="pjt_own_dept_name" autocomplete="off" size="12" class=" x-form-text x-form-field" style="width: auto;">
																		<input type="text" name="pjt_own_emp_name" id="pjt_own_emp_name" autocomplete="off" size="9" class=" x-form-text x-form-field" style="width: auto;">

																	</td>
																	<td valign="top">
																		<%-- Button Start--%>
																			<div style="padding-left: 0px;" >
																				<img align="center" id="pjtRespnNumBtn" name="pjtRespnNumBtn" alt="" src="/resource/images/bass_1st/icon_src1.gif" style="cursor: hand;">
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
														<label class="x-form-item-label" style="width: 90px;" for="pjt_date_from_tmp" ><font color="red">* </font>프로젝트기간:</label>
															<table>
																<tr>
																	<td>
																		<input type="text" name="pjt_date_from_tmp" id="pjt_date_from_tmp" autocomplete="off" size="10" class=" x-form-text x-form-field" style="width: auto;" >		
																	</td>
																	<td>
																		~
																	</td>
																	<td>
																		<input type="text" name="pjt_date_to_tmp" id="pjt_date_to_tmp" autocomplete="off" size="10" class=" x-form-text x-form-field" style="width: auto;" >		
																	</td>
																</tr>
															</table>

														<div class="x-form-clear-left">
														</div>
													</div>
												</div>
											</div>
										</div>										
									</div>
									<!-- 5_ROW End -->		
									
									<!-- 6_ROW Start -->
									<div class="x-column-inner" style="width: 100%;">
										<div class=" x-panel x-column" style="width: 95%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label class="x-form-item-label" style="width: 90px;" for="pjt_summary" >개요 <br/>및 특의사항:</label>
														<div style="padding-left: 80px;" class="x-form-element">
															<textarea name="pjt_summary" id="pjt_summary" autocomplete="off" class=" x-form-text x-form-field" style="width:100%; height:60px" onkeyup="jk_ContentsCheck(this,500);"></textarea>
														</div>
														<div class="x-form-clear-left">
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>
									<!-- 6_ROW End -->
									
									<!-- 7_ROW Start -->
									<div class="x-column-inner" style="width: 100%;">
										<div class=" x-panel x-column" style="width: 95%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label class="x-form-item-label" style="width: 90px;" for="note" >비고:</label>
														<div style="padding-left: 80px;" class="x-form-element">
															<textarea name="note" id="note" autocomplete="off" class=" x-form-text x-form-field" style="width:100%; height:60px" onkeyup="jk_ContentsCheck(this,200);"></textarea>
														</div>
														<div class="x-form-clear-left">
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>
									<!-- 7_ROW End -->									
									
									<!-- 8_ROW Start -->
									<div class="x-column-inner" style="width: 100%;">
										<div class=" x-panel x-column" style="width: 100%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label class="x-form-item-label" style="width: auto;" for="proc_status_code_tmp" >진행상태:</label>
														<div style="padding-left: 90px;" class="x-form-element">
															
															<select name="proc_status_code_tmp" id="proc_status_code_tmp" title="진행상태" style="width: 33%;" type="text" class=" x-form-select x-form-field" disabled = true>
																<option value="">선택하세요</option>
																<c:forEach items="${FLOW_STATUS_CODE}" var="data" varStatus="status">
																	<c:if test="${fn:indexOf(data.COM_CODE, 'G')>-1}">
																		<option value="${data.COM_CODE}" <c:if test="${data.COM_CODE == 'G10'}">selected</c:if>><c:out value="${data.COM_CODE_NAME}"/></option>
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
									</div>
									<!-- 8_ROW End -->
									
									<!-- 9_ROW Start -->
									<div class="x-column-inner" style="width: 100%;">
										<div class=" x-panel x-column" style="width: 50%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label class="x-form-item-label" style="width: auto;" for="final_mod_name" >최종변경자명:</label>
														<div style="padding-left: 90px;" class="x-form-element"> 
															<input type="text" name="final_mod_name" id="final_mod_name" autocomplete="off" size="35" class=" x-form-text x-form-field" style="width: auto;" readonly="true">
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
															<input type="text" name="final_mod_date" id="final_mod_date" autocomplete="off" size="35" class=" x-form-text x-form-field" style="width: auto;" readonly="true">
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>
									<!-- 9_ROW End -->									
																							

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
			<!----------------- 프로젝트 상세(제품)정보 GRID START ----------------->
			<td width="100%" valign="top" colspan="2">
				<div id="edit_grid_1st" style="margin-top: 0.4em;"></div>
			</td>
			<!----------------- 프로젝트 상세(제품)정보  GRID END ----------------->
		</tr>
		<tr>
			<!----------------- 프로젝트 장비 정보 GRID START ----------------->
			<td width="100%" valign="top" colspan="2">
				<div id="edit_grid_2nd" style="margin-top: 0.4em;"></div>
			</td>
			<!----------------- 프로젝트 장비 정보 GRID END ----------------->
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

						<td width="1">
						</td>
						<td>
						<%-- 삭제 버튼 Start --%>
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
											<button type="button" id="deleteBtn" name="deleteBtn" class=" x-btn-text">삭제</button>
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
						<%-- 삭제 버튼 End --%>
						</td>				

					</tr>
				</table>
			</td>
		</tr>
	</table>
</body>

</html>