<%--
  Class Name  : pjtManageList.jsp
  Description : 프로젝트관리
  Modification Information
 
      수정일                   수정자                 수정내용
  -------      --------    ---------------------------
  2011. 04. 13   여인범            최초 생성   
  
  author   : 여인범
  since    :  2011. 04. 13.
  version  : 1.0
   
  Copyright (C) 2011 by SG All right reserved.
--%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/web/jsp/common/inc/commonInc.jsp" %>

<script type="text/javascript" src="/resource/common/js/sgis-comm-inc.js" ></script> 
<script type="text/javascript" src="/resource/common/js/common/common-msg-box.js" ></script> 
<script type="text/javascript" src="/resource/common/js/ajax.js" ></script>

<script type="text/javascript" src="/resource/common/js/grid/grid_edit_3rd.js"></script>
<script type="text/javascript" src="/resource/common/js/grid/grid_edit_1st.js"></script> 
<script type="text/javascript" src="/resource/common/js/grid/grid_edit_2nd.js"></script>
<%
	String src_pjt_type_code = request.getParameter("src_pjt_type_code");
%>
<script type="text/javascript">
 

/***************************************************************************
 * 설  명 : 프로젝트 설정 
***************************************************************************/
var	gridHeigth_edit_3rd	= 250;
var	gridWidth_edit_3rd  = 1000	;
var	gridTitle_edit_3rd  = "프로젝트 기본정보"; 
var	render_edit_3rd		= "pjt_grid_3rd";
var keyNm_edit_3rd		= "PJT_ID";
var pageSize_edit_3rd	= 10;
var limit_edit_3rd		= pageSize_edit_3rd;
var start_edit_3rd		= 0;
var proxyUrl_edit_3rd	= "/pjt/pjtManage/result_edit_3rd.sg"; 
var gridRowDeleteYn	    = "";
var tbarHidden_edit_3rd = "Y";
 
// 페이징
function fnPagingValue_edit_3rd(){	
	try{
		GridClass_edit_3rd.store.setBaseParam('start'				,start_edit_3rd);
	    GridClass_edit_3rd.store.setBaseParam('limit'				,limit_edit_3rd); 
	    GridClass_edit_3rd.store.setBaseParam('src_pjt_id'			,Ext.get('src_pjt_id').getValue());		  	// 프로젝트ID  
	    GridClass_edit_3rd.store.setBaseParam('src_pjt_name'		,Ext.get('src_pjt_name').getValue());   		// 프로젝트명
	    GridClass_edit_3rd.store.setBaseParam('src_custom_name'		,Ext.get('src_custom_name').getValue());    	// 거래처명
	    GridClass_edit_3rd.store.setBaseParam('src_pjt_date_from'	,Ext.get('src_pjt_date_from').getValue().replaceAll("-", ""));
	    GridClass_edit_3rd.store.setBaseParam('src_pjt_date_to'		,Ext.get('src_pjt_date_to').getValue().replaceAll("-", ""));
	}catch(e){

	}
}

/** 진행상태 combo box 생성 start**/
var FLOW_STATUS_CODE = new Ext.form.ComboBox({    
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
					['','::선택::']<c:if test="${fn:length(PJT_STATUS_CODE) > 0}">,</c:if>  
					<c:forEach items="${PJT_STATUS_CODE}" var="data" varStatus="status">
						['${data.COM_CODE}', '${data.COM_CODE_NAME}']
						<c:if test="${not status.last}">,</c:if>
					</c:forEach>
				  ]
			})
});
// combo box render
Ext.util.Format.comboRenderer = function(FLOW_STATUS_CODE){    
	return function(value){        
	var record = FLOW_STATUS_CODE.findRecord(FLOW_STATUS_CODE.valueField, value);        
	return record ? record.get(FLOW_STATUS_CODE.displayField) : FLOW_STATUS_CODE.valueNotFoundText;    
}}
/** 진행상태 combo box 생성 end**/


/** 유무상 combo box 생성 start**/
var PAY_FREE_CODE_COM = new Ext.form.ComboBox({    
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
					<c:forEach items="${PAY_FREE_CODE}" var="data" varStatus="status">
						['${data.COM_CODE}', '${data.COM_CODE_NAME}']
						<c:if test="${not status.last}">,</c:if>
					</c:forEach>
					
				  ]
			})
});
// combo box render
Ext.util.Format.comboRenderer = function(PAY_FREE_CODE_COM){    
	return function(value){        
	var record = PAY_FREE_CODE_COM.findRecord(PAY_FREE_CODE_COM.valueField, value);        
	return record ? record.get(PAY_FREE_CODE_COM.displayField) : PAY_FREE_CODE_COM.valueNotFoundText;    
}}
/** 유무상 combo box 생성 end**/

 

// 그리드 필드
var	userColumns_edit_3rd	= [ 
	
							  {header: '진행상태'				,width: 60  ,sortable: true ,dataIndex:'PROC_STATUS_NM'     ,editor: new Ext.form.TextField({ allowBlank : false }) ,editable:false, hidden : true} 
							, {header: '* 진행상태'			,width: 70  ,sortable: true ,dataIndex:'PROC_STATUS_CODE'   ,editor: FLOW_STATUS_CODE  ,renderer: Ext.util.Format.comboRenderer(FLOW_STATUS_CODE)}
							, {header: '* 이슈등록'			,width: 50  ,sortable: true ,dataIndex:'REG_ISSUE'   		,editable:false,  renderer: changeBLUE}
							  
							, {header: '프로젝트ID'  			,width: 80 	,sortable: true ,dataIndex:'PJT_ID'             ,editor: new Ext.form.TextField({ allowBlank : false }) ,editable:false}
							, {header: '프로젝트명'  			,width: 100 ,sortable: true ,dataIndex:'PJT_NAME'           ,editor: new Ext.form.TextField({ allowBlank : false }) ,editable:false}
							, {header: '기간 FROM'			,width: 50  ,sortable: true ,dataIndex:'PJT_DATE_FROM'      ,editor: new Ext.form.TextField({ allowBlank : false }) ,hidden : true, editable:false}                    
							, {header: '기간 TO'				,width: 50  ,sortable: true ,dataIndex:'PJT_DATE_TO'        ,editor: new Ext.form.TextField({ allowBlank : false }) ,hidden : true, editable:false} 
														
							, {header: '프로젝트구분코드'  	,width: 60  ,sortable: true ,dataIndex:'PJT_TYPE_CODE'      ,editor: new Ext.form.TextField({ allowBlank : false }) ,hidden : true ,editable:false}
							, {header: '구분'  				,width: 60  ,sortable: true ,dataIndex:'PJT_TYPE_CODE_NM'  	,editor: new Ext.form.TextField({ allowBlank : false }) ,hidden : true ,editable:false}
							
							, {header: '유/무상' 				,width: 35  ,sortable: true ,dataIndex:'PAY_FREE_CODE'      ,editor: PAY_FREE_CODE_COM  ,renderer: Ext.util.Format.comboRenderer(PAY_FREE_CODE_COM) ,editable:false}
							
							, {header: '예상매출총액'			,width: 60  ,sortable: true ,dataIndex:'EXP_SAL_TOTAL_AMT'  ,editor: new Ext.form.TextField({ allowBlank : false }) ,editable:false, renderer: korMoneyChangeRED, align:'right'}
							
							, {header: '개요및특이사항'		,width: 200 ,sortable: true ,dataIndex:'PJT_SUMMARY'        ,editor: new Ext.form.TextField({ allowBlank : false }) ,editable:false}
							
							, {header: '담당자부서코드'		,width: 60  ,sortable: true ,dataIndex:'PJT_OWN_DEPT_CODE'  ,editor: new Ext.form.TextField({ allowBlank : false }) ,hidden : true ,editable:false}
							, {header: '담당자부서명'			,width: 60  ,sortable: true ,dataIndex:'PJT_OWN_DEPT_NM'   	,editor: new Ext.form.TextField({ allowBlank : false }) ,editable:false}
							
							, {header: '담당자사번'			,width: 60  ,sortable: true ,dataIndex:'PJT_OWN_EMP_NUM'    ,editor: new Ext.form.TextField({ allowBlank : false }) ,hidden : true ,editable:false}
							, {header: '담당자'				,width: 40  ,sortable: true ,dataIndex:'PJT_OWN_EMP_NM'     ,editor: new Ext.form.TextField({ allowBlank : false }) ,editable:false}
							
							, {header: '상태'                ,width: 60  ,sortable: true ,dataIndex:'FLAG'               ,editor: new Ext.form.TextField({ allowBlank : false }) ,hidden : true ,editable:false}
							, {header: '등록일자'				,width: 60  ,sortable: true ,dataIndex:'PJT_REG_DATE'       ,editor: new Ext.form.TextField({ allowBlank : false }) ,hidden : true ,editable:false}     
							, {header: '프로젝트등록자부서코드'	,width: 60  ,sortable: true ,dataIndex:'PJT_REG_DEPT_CODE'  ,editor: new Ext.form.TextField({ allowBlank : false }) ,hidden : true ,editable:false}
							, {header: '프로젝트등록자부서'	    ,width: 60  ,sortable: true ,dataIndex:'PJT_REG_DEPT_NM'    ,editor: new Ext.form.TextField({ allowBlank : false }) ,hidden : true ,editable:false}
							, {header: '프로젝트등록자사번'		,width: 60  ,sortable: true ,dataIndex:'PJT_REG_EMP_NUM'    ,editor: new Ext.form.TextField({ allowBlank : false }) ,hidden : true ,editable:false} 
							, {header: '프로젝트등록자'		,width: 60  ,sortable: true ,dataIndex:'PJT_REG_EMP_NM'     ,editor: new Ext.form.TextField({ allowBlank : false }) ,hidden : true ,editable:false} 
							, {header: '업무구분코드'			,width: 60  ,sortable: true ,dataIndex:'ROLL_TYPE_CODE'     ,editor: new Ext.form.TextField({ allowBlank : false }) ,hidden : true ,editable:false}
							, {header: '업무구분'				,width: 60  ,sortable: true ,dataIndex:'ROLL_TYPE_NM'       ,editor: new Ext.form.TextField({ allowBlank : false }) ,hidden : true ,editable:false}
							, {header: '수주가능성'			,width: 60  ,sortable: true ,dataIndex:'ORDER_POSSBLE'      ,editor: new Ext.form.TextField({ allowBlank : false }) ,hidden : true ,editable:false}                    
							, {header: '수주예정일'			,width: 60  ,sortable: true ,dataIndex:'ORDER_EXP_DATE'     ,editor: new Ext.form.TextField({ allowBlank : false }) ,hidden : true ,editable:false}                    
							, {header: '제안(입찰)마감일'		,width: 60  ,sortable: true ,dataIndex:'BID_DDAY'           ,editor: new Ext.form.TextField({ allowBlank : false }) ,hidden : true ,editable:false}                    
							, {header: '예상매출총세액'		,width: 60  ,sortable: true ,dataIndex:'EXP_SAL_TOTAL_TAX'  ,editor: new Ext.form.TextField({ allowBlank : false }) ,hidden : true ,editable:false}                    
							, {header: '비고'				,width: 60 	,sortable: true ,dataIndex:'NOTE'               ,editor: new Ext.form.TextField({ allowBlank : false }) ,hidden : true ,editable:false}                    
							, {header: '최종변경자ID'			,width: 60  ,sortable: true ,dataInDEX:'FINAL_MOD_ID'       ,editor: new Ext.form.TextField({ allowBlank : false }) ,hidden : true ,editable:false}                    
							, {header: '최종변경일시'			,width: 60  ,sortable: true ,dataIndex:'FINAL_MOD_DATE'     ,editor: new Ext.form.TextField({ allowBlank : false }) ,hidden : true ,editable:false}                    
							, {header: '최초등록일'			,width: 60  ,sortable: true ,dataIndex:'REG_DATE'           ,editor: new Ext.form.TextField({ allowBlank : false }) ,hidden : true ,editable:false}                    
							, {header: '최초등록자'			,width: 60  ,sortable: true ,dataIndex:'REG_ID'             ,editor: new Ext.form.TextField({ allowBlank : false }) ,hidden : true ,editable:false} 
								
						];

// 맵핑 필드
var	mappingColumns_edit_3rd	= [  
							      		  {name: 'FLAG'		 	  	 , allowBlank: false  , type: 'string', mapping: 'FLAG'		 	  	 }
										, {name: 'START'		 	 , allowBlank: false  , type: 'string', mapping: 'START'		 	 }
										, {name: 'LIMIT'		 	 , allowBlank: false  , type: 'string', mapping: 'LIMIT'		 	 }
										, {name: 'PJT_ID'            , allowBlank: false  , type: 'string', mapping: 'PJT_ID'            } 
										, {name: 'PJT_TYPE_CODE'     , allowBlank: false  , type: 'string', mapping: 'PJT_TYPE_CODE'     }
										, {name: 'PJT_TYPE_CODE_NM'	 , allowBlank: false  , type: 'string', mapping: 'PJT_TYPE_CODE_NM'  }
										, {name: 'PJT_NAME'          , allowBlank: false  , type: 'string', mapping: 'PJT_NAME'          }
										, {name: 'PJT_REG_DATE'      , allowBlank: false  , type: 'string', mapping: 'PJT_REG_DATE'      }
										, {name: 'PJT_DATE_FROM'     , allowBlank: false  , type: 'string', mapping: 'PJT_DATE_FROM'     }
										, {name: 'PJT_DATE_TO'       , allowBlank: false  , type: 'string', mapping: 'PJT_DATE_TO'       }
										, {name: 'PJT_OWN_DEPT_CODE' , allowBlank: false  , type: 'string', mapping: 'PJT_OWN_DEPT_CODE' }
										, {name: 'PJT_OWN_DEPT_NM'   , allowBlank: false  , type: 'string', mapping: 'PJT_OWN_DEPT_NM'   }
										, {name: 'PJT_OWN_EMP_NUM'   , allowBlank: false  , type: 'string', mapping: 'PJT_OWN_EMP_NUM'   }
										, {name: 'PJT_OWN_EMP_NM'    , allowBlank: false  , type: 'string', mapping: 'PJT_OWN_EMP_NM'    }
										, {name: 'PJT_REG_DEPT_CODE' , allowBlank: false  , type: 'string', mapping: 'PJT_REG_DEPT_CODE' }
										, {name: 'PJT_REG_DEPT_NM'   , allowBlank: false  , type: 'string', mapping: 'PJT_REG_DEPT_NM'   }
										, {name: 'PJT_REG_EMP_NUM'   , allowBlank: false  , type: 'string', mapping: 'PJT_REG_EMP_NUM'   }
										, {name: 'PJT_REG_EMP_NM'    , allowBlank: false  , type: 'string', mapping: 'PJT_REG_EMP_NM'    }
										, {name: 'ROLL_TYPE_CODE'    , allowBlank: false  , type: 'string', mapping: 'ROLL_TYPE_CODE'    }
										, {name: 'ROLL_TYPE_NM'      , allowBlank: false  , type: 'string', mapping: 'ROLL_TYPE_NM'      }
										, {name: 'ORDER_POSSBLE'     , allowBlank: false  , type: 'string', mapping: 'ORDER_POSSBLE'     }
										, {name: 'PAY_FREE_CODE'     , allowBlank: false  , type: 'string', mapping: 'PAY_FREE_CODE'     }
										, {name: 'ORDER_EXP_DATE'    , allowBlank: false  , type: 'string', mapping: 'ORDER_EXP_DATE'    }
										, {name: 'BID_DDAY'          , allowBlank: false  , type: 'string', mapping: 'BID_DDAY'          }
										, {name: 'PROC_STATUS_CODE'  , allowBlank: false  , type: 'string', mapping: 'PROC_STATUS_CODE'  }
										, {name: 'PROC_STATUS_NM'    , allowBlank: false  , type: 'string', mapping: 'PROC_STATUS_NM'    }
										, {name: 'PJT_SUMMARY'       , allowBlank: false  , type: 'string', mapping: 'PJT_SUMMARY'       }
										, {name: 'EXP_SAL_TOTAL_AMT' , allowBlank: false  , type: 'string', mapping: 'EXP_SAL_TOTAL_AMT' }
										, {name: 'EXP_SAL_TOTAL_TAX' , allowBlank: false  , type: 'string', mapping: 'EXP_SAL_TOTAL_TAX' }
										, {name: 'NOTE'              , allowBlank: false  , type: 'string', mapping: 'NOTE'              }
										, {name: 'FINAL_MOD_ID'      , allowBlank: false  , type: 'string', mapping: 'FINAL_MOD_ID'      }
										, {name: 'FINAL_MOD_DATE'    , allowBlank: false  , type: 'string', mapping: 'FINAL_MOD_DATE'    }
										, {name: 'REG_DATE'          , allowBlank: false  , type: 'string', mapping: 'REG_DATE'          }
										, {name: 'REG_ID'            , allowBlank: false  , type: 'string', mapping: 'REG_ID'            }
										, {name: 'REG_ISSUE'         , allowBlank: false  , type: 'string', mapping: 'REG_ISSUE'         }
										
	 
	    				 	  ]; 

/***************************************************************************
 * 프로젝트정보 --- 그리드 클릭시 Event
 ***************************************************************************/
function fnEdit3rdCellClickEvent(grid, rowIndex, columnIndex, e){ 
	
	var keyValue1 = fnFixNull(GridClass_edit_3rd.store.data.items[rowIndex].data.PJT_ID);		
	fnSearchEdit1st(keyValue1,'', '');									//거래처정보
	fnSearchEdit2nd(keyValue1,'', '');									//품목정보
	
	
	var record = GridClass_edit_3rd.grid.selModel.getSelected();  
	var src_pjt_id 		= record.data.PJT_ID; 
	var src_pjt_name 	= record.data.PJT_NAME;  
	
	if(columnIndex == '2'){
		fnIssuePopUp("?popUp_YN=Y&src_pjt_id="+src_pjt_id);
	}
	
	
	
}  


// 거래처정보
function fnSearchEdit1st(keyValue1,keyValue2,value3){
	
	Ext.Ajax.request({
		url: "/pjt/pjtManage/result_edit_1st.sg" 
		,success: function(response){											// 조회결과 성공시
					GridClass_edit_1st.store.commitChanges();					// 변경된 record를 commit
					GridClass_edit_1st.store.removeAll();						// store자료를 삭제
						
					// 조회된 결과값, store명
					var json = Ext.util.JSON.decode(response.responseText);
					GridClass_edit_1st.store.loadData(json);
					
					if(value3 != '' && value3 != 'undefined'){
		
						var rowCnt1st = GridClass_edit_1st.store.getCount();  	// Grid의 총갯수
						
						for(i = 0 ; i < rowCnt1st ; i++){
							var record1 = GridClass_edit_1st.store.getAt(i);
							record1.set('FLAG', 'I');
							record1.set('PJT_ID', value3);						
						} // end for	
					}
		          }
		,failure: handleFailure 
		,params : {
				   // 페이지 		
					 limit			: limit_edit_1st
				   , start			: start_edit_1st
				   // 키 value
				   , pjt_id			: keyValue1
				  }				
	});   
}

// 품목정보
function fnSearchEdit2nd(keyValue1,keyValue2,value3){
	
	Ext.Ajax.request({
		url: "/pjt/pjtManage/result_edit_2nd.sg" 
		,success: function(response){											// 조회결과 성공시
					// 조회된 결과값, store명
					GridClass_edit_2nd.store.commitChanges();
					GridClass_edit_2nd.store.removeAll();
					
					var json = Ext.util.JSON.decode(response.responseText);
					GridClass_edit_2nd.store.loadData(json);
			
					if(value3 != '' && value3 != 'undefined'){
						
						var rowCnt2nd = GridClass_edit_2nd.store.getCount();  // Grid의 총갯수
					
						for(j = 0 ; j < rowCnt2nd ; j++){
							var record2 = GridClass_edit_2nd.store.getAt(j);
							record2.set('FLAG', 'I');
							record2.set('PJT_ID', value3);						
						} // end for
					}
		          }
		,failure: handleFailure 
		,params : {
				   // 페이지 		
					 limit			: limit_edit_2nd
				   , start			: start_edit_2nd
				   // 키 value
				   , pjt_id			: keyValue1
				  }				
	}); // end Ext.Ajax.request
}

/***************************************************************************
 * 설  명 : 거래처 설정 
***************************************************************************/
var	gridHeigth_edit_1st	= 150;
var	gridWidth_edit_1st  = 1000	;
var	gridTitle_edit_1st  = "프로젝트 거래처정보"	; 
var	render_edit_1st		= "edit_grid_1st";
var keyNm_edit_1st		= "PJT_INFO_SEQ";
var pageSize_edit_1st	= 4;
var limit_edit_1st		= pageSize_edit_1st;
var start_edit_1st		= 0;
var proxyUrl_edit_1st	= "/pjt/pjtManage/result_edit_1st.sg"; 
var gridRowDeleteYn	    = "";
var tbarHidden_edit_1st = "Y";
   
// 페이징
function fnPagingValue_edit_1st(){	
	try{
		GridClass_edit_1st.store.setBaseParam('start'		,start_edit_1st);
	    GridClass_edit_1st.store.setBaseParam('limit'		,limit_edit_1st);
	    GridClass_edit_1st.store.setBaseParam('pjt_id'		,Ext.get('pjt_id').getValue()); 
	    
	}catch(e){

	}
}


// 거래처 유형 combo box 생성
var combo = new Ext.form.ComboBox({    
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
					<c:forEach items="${COM_CUSTOM_PATTERN_NM}" var="data" varStatus="status">
						['${data.COM_CODE}', '${data.COM_CODE_NAME}']
						<c:if test="${not status.last}">,</c:if>
					</c:forEach>
				  ]
			})
});

// 거래처 유형 combo box render
Ext.util.Format.comboRenderer = function(combo){    
	return function(value){        
	var record = combo.findRecord(combo.valueField, value);        
	return record ? record.get(combo.displayField) : combo.valueNotFoundText;    
}}

/**당사와계약여부 combo box 생성 start **/
var CONSTRACT_YN_COMBO = new Ext.form.ComboBox({    
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
					['Y', 'Y'],
					['N', 'N']
				  ]
			})
});
//combo box render
Ext.util.Format.comboRenderer = function(CONSTRACT_YN_COMBO){    
	return function(value){        
	var record = CONSTRACT_YN_COMBO.findRecord(CONSTRACT_YN_COMBO.valueField, value);        
	return record ? record.get(CONSTRACT_YN_COMBO.displayField) : CONSTRACT_YN_COMBO.valueNotFoundText;    
}}
/**당사와계약여부 combo box 생성 end **/


/**거래처 유형 combo box 생성 start **/ 
var COM_CUSTOM_PATTERN_NM_COMBO = new Ext.form.ComboBox({    
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
					<c:forEach items="${COM_CUSTOM_PATTERN_NM}" var="data" varStatus="status">
						['${data.COM_CODE}', '${data.COM_CODE_NAME}']
						<c:if test="${not status.last}">,</c:if>
					</c:forEach>
				  ]
			})
});

// 거래처 유형 COM_CUSTOM_PATTERN_NM_COMBO box render
Ext.util.Format.comboRenderer = function(COM_CUSTOM_PATTERN_NM_COMBO){    
	return function(value){        
	var record = COM_CUSTOM_PATTERN_NM_COMBO.findRecord(COM_CUSTOM_PATTERN_NM_COMBO.valueField, value);        
	return record ? record.get(COM_CUSTOM_PATTERN_NM_COMBO.displayField) : COM_CUSTOM_PATTERN_NM_COMBO.valueNotFoundText;    
}}
/**거래처 유형 combo box 생성 end **/ 

// 그리드 필드
var	userColumns_edit_1st	= [  
			 {id: "pjt_info_seq", header: "순번"            		,	width: 10,	sortable: true,	dataIndex: "PJT_INFO_SEQ"       ,		editor: new Ext.form.TextField({ allowBlank : false }), hidden:true, editable:false}
								,{header: "등록일자"        		,	width: 10,	sortable: true,	dataIndex: "PJT_REG_DATE"       ,		editor: new Ext.form.TextField({ allowBlank : false }), hidden:true, editable:false}
								,{header: "프로젝트ID"      		,	width: 80,	sortable: true,	dataIndex: "PJT_ID"             ,		editor: new Ext.form.TextField({ allowBlank : false }), editable:false, hidden:true}
								,{header: "거래처유형"      		,	width: 50,	sortable: true,	dataIndex: "CUSTOM_PATTERN_CODE",       editor: COM_CUSTOM_PATTERN_NM_COMBO  ,renderer: Ext.util.Format.comboRenderer(COM_CUSTOM_PATTERN_NM_COMBO), editable:false} 
								,{header: "거래처유형코드"      	,	width: 10,	sortable: true,	dataIndex: "CUSTOM_PATTERN_NM"  ,		editor: new Ext.form.TextField({ allowBlank : false }), hidden:true, editable:false}
								
								,{header: "거래처코드"      		,	width: 10,	sortable: true,	dataIndex: "CUSTOM_CODE"        ,		editor: new Ext.form.TextField({ allowBlank : false }), hidden:true, editable:false}
								,{header: "거래처명"      		,	width: 100,	sortable: true,	dataIndex: "CUSTOM_NAME"        ,		editor: new Ext.form.TextField({ allowBlank : false }), editable:false}
								
								,{header: "거래처담당자번호"		,	width: 10,	sortable: true,	dataIndex: "COSTOMER_NUM"       ,		editor: new Ext.form.TextField({ allowBlank : false }), hidden:true, editable:false}
								,{header: "거래처담당자명"			,	width: 100,	sortable: true,	dataIndex: "COSTOMER_NAME"      ,		editor: new Ext.form.TextField({ allowBlank : false }), editable:false}
								
								,{header: "* 계약여부"			,	width: 50,	sortable: true, dataIndex: 'CONSTRACT_YN'		,       editor: CONSTRACT_YN_COMBO  ,renderer: Ext.util.Format.comboRenderer(CONSTRACT_YN_COMBO)}
								,{header: "비고"            		,	width: 200,	sortable: true,	dataIndex: "NOTE"               ,		editor: new Ext.form.TextField({ allowBlank : false }), editable:false}
								
								,{header: "최종변경자"    		,	width: 50,	sortable: true,	dataIndex: "FINAL_MOD_ID"       ,		editor: new Ext.form.TextField({ allowBlank : false }), editable:false}
								,{header: "최종변경일"    		,	width: 50,	sortable: true,	dataIndex: "FINAL_MOD_DATE"     ,		editor: new Ext.form.TextField({ allowBlank : false }), editable:false}
								,{header: "최초등록일"      		,	width: 10,	sortable: true,	dataIndex: "REG_DATE"           ,		editor: new Ext.form.TextField({ allowBlank : false }), hidden:true, editable:false}
								,{header: "최초등록자ID"      	,	width: 10,	sortable: true,	dataIndex: "REG_ID"             ,		editor: new Ext.form.TextField({ allowBlank : false }), hidden:true, editable:false}
							  ];

// 맵핑 필드
var	mappingColumns_edit_1st	= [  
							     {name: "PJT_INFO_SEQ"       , 		type:"string", mapping: "PJT_INFO_SEQ"       }
								,{name: "PJT_REG_DATE"       , 		type:"string", mapping: "PJT_REG_DATE"       }
								,{name: "PJT_ID"             , 		type:"string", mapping: "PJT_ID"             }
								,{name: "CUSTOM_PATTERN_CODE", 		type:"string", mapping: "CUSTOM_PATTERN_CODE"}
								,{name: "CUSTOM_PATTERN_NM"  , 		type:"string", mapping: "CUSTOM_PATTERN_NM"	 }
								
								,{name: "CUSTOM_CODE"        , 		type:"string", mapping: "CUSTOM_CODE"        }
								,{name: "CUSTOM_NAME"     	 , 		type:"string", mapping: "CUSTOM_NAME"  	     }
								
								,{name: "COSTOMER_NUM"       , 		type:"string", mapping: "COSTOMER_NUM"       }
								,{name: "COSTOMER_NAME"      , 		type:"string", mapping: "COSTOMER_NAME"      }
								
								,{name: "CONSTRACT_YN"       , 		type:"string", mapping: "CONSTRACT_YN"       }
								,{name: "NOTE"               , 		type:"string", mapping: "NOTE"               }
							
								,{name: "FINAL_MOD_ID"       , 		type:"string", mapping: "FINAL_MOD_ID"       }
								,{name: "FINAL_MOD_DATE"     , 		type:"string", mapping: "FINAL_MOD_DATE"     }
								,{name: "REG_DATE"           , 		type:"string", mapping: "REG_DATE"           }
								,{name: "REG_ID"             , 		type:"string", mapping: "REG_ID"             }
	    				 	  ]; 
 



/***************************************************************************
 * 설  명 : 편집그리드 설정 (품목정보)
***************************************************************************/
var	gridHeigth_edit_2nd	= 150;
var	gridWidth_edit_2nd  = 1000	;
var	gridTitle_edit_2nd  = "프로젝트 매출 품목정보"; 
var	render_edit_2nd		= "edit_grid_2nd";
var keyNm_edit_2nd		= "PJT_INFO_SEQ";
var pageSize_edit_2nd	= 4;
var limit_edit_2nd		= pageSize_edit_2nd;
var start_edit_2nd		= 0;
var proxyUrl_edit_2nd	= "/pjt/pjtManage/result_edit_2nd.sg"; 
var grid2ndRowDeleteYn  = ""; 
var tbarHidden_edit_2nd = "Y";
 

// 페이징
function fnPagingValue_edit_2nd(){	
	try{
		GridClass_edit_2nd.store.setBaseParam('start'		,start_edit_2nd);
	    GridClass_edit_2nd.store.setBaseParam('limit'		,limit_edit_2nd);
	    GridClass_edit_2nd.store.setBaseParam('pjt_id'		,Ext.get('pjt_id').getValue());
	}catch(e){

	}
}


// 그리드 필드 
var	userColumns_edit_2nd	= [  {header: "순번"     		,	width: 10,	sortable: true,	dataIndex: "PJT_INFO_SEQ"		,	editor: new Ext.form.TextField({ allowBlank : false }) , hidden:true, editable:false}
								,{header: "등록일자"   		,	width: 10,	sortable: true,	dataIndex: "PJT_REG_DATE"		,	editor: new Ext.form.TextField({ allowBlank : false }) , hidden:true, editable:false}
								,{header: "프로젝트ID" 		,	width: 100,	sortable: true,	dataIndex: "PJT_ID"      		,	editor: new Ext.form.TextField({ allowBlank : false }) , hidden:true, editable:false}
								
								,{header: "품목코드"   		,	width: 10,	sortable: true,	dataIndex: "ITEM_CODE"   		,	editor: new Ext.form.TextField({ allowBlank : false }) , hidden:true, editable:false}
								,{header: "품목"   			,	width: 150,	sortable: true,	dataIndex: "ITEM_NAME"   		,	editor: new Ext.form.TextField({ allowBlank : false }) , editable:false}
								
								,{header: "CPU 수"  			,	width: 40,	sortable: true,	dataIndex: "CPU_CNT"      		,	editor: new Ext.form.TextField({ allowBlank : false }) , editable:false}
								,{header: "CORE 수" 			,	width: 40,	sortable: true,	dataIndex: "CORE_CNT"    		,	editor: new Ext.form.TextField({ allowBlank : false }) , editable:false}
								,{header: "수량"     		,	width: 40,	sortable: true,	dataIndex: "CNT"         		,	editor: new Ext.form.TextField({ allowBlank : false }) , editable:false}
								,{header: "단가"     		,	width: 50,	sortable: true,	dataIndex: "UNIT_PRICE"  		,	editor: new Ext.form.TextField({ allowBlank : false }) , editable:false, renderer: korMoneyChangeRED, align:'right'}	
								,{header: "금액"     		,	width: 50,	sortable: true,	dataIndex: "AMT"         		,	editor: new Ext.form.TextField({ allowBlank : false }) , editable:false, renderer: korMoneyChangeRED, align:'right'}	
								,{header: "세액"     		,	width: 50,	sortable: true,	dataIndex: "TAX"         		,	editor: new Ext.form.TextField({ allowBlank : false }) , editable:false, renderer: korMoneyChangeRED, align:'right'}	
								,{header: "비고"     		,	width: 100,	sortable: true,	dataIndex: "NOTE"        		,	editor: new Ext.form.TextField({ allowBlank : false }) , editable:false}	
								,{header: "최종변경자"  		,	width: 50,	sortable: true,	dataIndex: "FINAL_MOD_ID"   	,	editor: new Ext.form.TextField({ allowBlank : false }) , editable:false}
								,{header: "최종변경일"   		,	width: 50,	sortable: true,	dataIndex: "FINAL_MOD_DATE" 	,	editor: new Ext.form.TextField({ allowBlank : false }) , editable:false}
								,{header: "최초등록일"    	,	width: 50,	sortable: true,	dataIndex: "REG_DATE"       	,	editor: new Ext.form.TextField({ allowBlank : false }) , hidden:true, editable:false}
								,{header: "최초등록자"    	,	width: 50,	sortable: true,	dataIndex: "REG_ID"         	,	editor: new Ext.form.TextField({ allowBlank : false }) , hidden:true, editable:false}
								  
							  ];

// 맵핑 필드
var	mappingColumns_edit_2nd	= [ 	 
									 {name: "PJT_INFO_SEQ"	 , 	type:"string", mapping: "PJT_INFO_SEQ"	 }
									,{name: "PJT_REG_DATE"	 , 	type:"string", mapping: "PJT_REG_DATE"	 }
									,{name: "PJT_ID"      	 , 	type:"string", mapping: "PJT_ID"      	 }
									,{name: "ITEM_CODE"   	 , 	type:"string", mapping: "ITEM_CODE"   	 }
									,{name: "ITEM_NAME"   	 , 	type:"string", mapping: "ITEM_NAME"   	 }
									
									,{name: "CPU_CNT"    	 , 	type:"string", mapping: "CPU_CNT"    	 }
									,{name: "CORE_CNT"   	 , 	type:"string", mapping: "CORE_CNT"   	 }
									,{name: "CNT"         	 , 	type:"string", mapping: "CNT"         	 }
									,{name: "UNIT_PRICE"  	 , 	type:"string", mapping: "UNIT_PRICE"  	 }
									,{name: "AMT"         	 , 	type:"string", mapping: "AMT"         	 }
									,{name: "TAX"         	 , 	type:"string", mapping: "TAX"         	 }
									,{name: "NOTE"        	 , 	type:"string", mapping: "NOTE"        	 }
									,{name: "FINAL_MOD_ID"   , 	type:"string", mapping: "FINAL_MOD_ID"   }
									,{name: "FINAL_MOD_DATE" , 	type:"string", mapping: "FINAL_MOD_DATE" }
									,{name: "REG_DATE"       , 	type:"string", mapping: "REG_DATE"       }
									,{name: "REG_ID"         ,  type:"string", mapping: "REG_ID"         }
									
	    				 	  ]; 

/***************************************************************************
 * 설  명 : 필드 초기화
 **************************************************************************/
function fnInitValue(){
  
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
	
	fnInitValue();
	
	Ext.Ajax.request({   
		url: "/pjt/pjtManage/result_edit_3rd.sg"
		,method : 'POST'   
		,success: function(response){						// 조회결과 성공시
					handleSuccess(response,GridClass_edit_3rd);
				 }   							
		,failure: handleFailure   	   						// 조회결과 실패시  
		,params : {					   						// 조회조건을 DB로 전송하기위해서 조건값 설정
						limit              : limit_edit_3rd
					  , start              : start_edit_3rd
					  , src_pjt_id   	   : Ext.get('src_pjt_id').getValue()		  	// 프로젝트ID   
				  	  , src_pjt_name       : Ext.get('src_pjt_name').getValue()    		// 프로젝트명
				  	  , src_custom_name    : Ext.get('src_custom_name').getValue()    	// 거래처명
				  	  , src_pjt_date_from  : Ext.get('src_pjt_date_from').getValue().replaceAll("-", "")
				  	  , src_pjt_date_to    : Ext.get('src_pjt_date_to').getValue().replaceAll("-", "")
				      , src_pjt_type_code  : Ext.get('src_pjt_type_code').getValue()
				      
				      
				  }				
	});  
	
} 

/***************************************************************************
 * 설  명 : 저장버튼 클릭
 ***************************************************************************/
function fnSave(){  	
 
																					// 변경된 견적 품목정보 Grid의 record 
	var records3 = GridClass_edit_3rd.store.getModifiedRecords();	  
	// 변경된 record의 자료를 json형식으로
    var edit3rdJson = "[";
	    for (var i = 0; i < records3.length; i++) {
	      edit3rdJson += Ext.util.JSON.encode(records3[i].data);				
	      if (i < (records3.length-1)) {
	        edit3rdJson += ",";
	      }
	    }
    	edit3rdJson += "]"
    
	
	// 변경된 납품처 시스템 사양정보 Grid의 record
	var record1 = GridClass_edit_1st.store.getModifiedRecords();	  
	// 변경된 record의 자료를 json형식으로
    var edit1stJson = "[";
	    for (var i = 0; i < record1.length; i++) {
	      edit1stJson += Ext.util.JSON.encode(record1[i].data);				
	      if (i < (record1.length-1)) {
	        edit1stJson += ",";
	      }
	    }
    	edit1stJson += "]"
 	
	Ext.Ajax.request({   
		url: "/pjt/pjtManage/actionPjtManage.sg?pjtManType=status"   
		,success: function(response){						// 조회결과 성공시
					// 조회된 결과값, store명
					handleSuccess(response,GridClass_edit_3rd,'save');
		          } 
		,failure: handleFailure   	    // 조회결과 실패시  
		,form   : document.detailForm	// 상세 FORM	
		,params : {					    // 조회조건을 DB로 전송하기위해서 조건값 설정
				  // 페이지정보
					limit          		: limit_edit_3rd
			  	  , start          		: start_edit_3rd
			  	  , edit3rdData		    : edit3rdJson
  				  , edit1stData         : edit1stJson
				  , src_pjt_id   	    : Ext.get('src_pjt_id').getValue()		  	// 프로젝트ID   
				  , src_pjt_name        : Ext.get('src_pjt_name').getValue()   		// 프로젝트명
			  	  , src_custom_name     : Ext.get('src_custom_name').getValue()    	// 거래처명
			  	  , src_pjt_date_from   : Ext.get('src_pjt_date_from').getValue().replaceAll("-", "")
				  , src_pjt_date_to     : Ext.get('src_pjt_date_to').getValue().replaceAll("-", "")    
				  , src_pjt_type_code   : '<%=src_pjt_type_code%>'
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
	 
	var toDay = getTimeStamp();	
	toDay = toDay.replaceAll('-','');
	toDay = addDate(toDay, 'M', -3);
	toDay = toDay.substring(0,4)+"-"+toDay.substring(4,6)+"-"+toDay.substring(6,8);
	var fromDay = toDay;
	toDay = getTimeStamp().trim();
	
    // 검색버튼 클릭
	Ext.get('searchBtn').on('click', function(e){
        if(Validator.validate(sForm)){
			fnSearch();
		}	
    });
    
   	//조건해제 버튼 -> 검색조건 초기화
   	Ext.get('searchClearBtn').on('click', function(e){
        sForm.reset();	
    });
   	
   	
    //저장 버튼 -> 데이터를 server로 전송
	Ext.get('saveBtn').on('click', function(e){	 
	   Ext.MessageBox.confirm('Confirm', '저장하시겠습니까?', showResult);
		
	});
	  
	
	// 검색시작일자
	var src_pjt_date_from = new Ext.form.DateField({
    	applyTo: 'src_pjt_date_from',
		allowBlank: false,
		format:'Y-m-d',
		editable : false,
		value : fromDay
		
	});
   	
	// 검색종료일자
	var src_pjt_date_to = new Ext.form.DateField({
    	applyTo: 'src_pjt_date_to',
		allowBlank: false,
		format:'Y-m-d',
		editable : false,
		value : toDay
	}); 
	fnInitValue();
	
}); // end Ext.onReady

// 저장, 수정버튼 클릭시 '예','아니오' 
function showResult(btn){
   	if(btn == 'yes'){
   		fnSave();
   	}    	
};
	
  


function fnIssuePopUp(param){
	var sURL      = "/pjt/pjtIssue/pjtIssueList.sg"+param;
	var dlgWidth  = 1000;
	var dlgHeight = 250;
	var winName   = "이슈등록";
	fnOpenPop(sURL, dlgWidth, dlgHeight, winName);
}

function fnOpenPop(sURL, dlgWidth, dlgHeight, winName){
  var xPos=(window.screen.width) ? (window.screen.width-dlgWidth)/2 : 0;
  var yPos=(window.screen.height) ? (window.screen.height-dlgHeight)/2 : 0;
  var sFeatures = "titlebar=no, scrollbars=no,location=no ,menubar=no, resizable=no, status=yes, width="+dlgWidth+",height="+dlgHeight+",left="+xPos+", top="+yPos;
  window.open(sURL,winName, sFeatures);
}

 
</script>

</head>
<body class=" ext-gecko ext-gecko3">
	<table border="0" width="1000" height="200">
		<tr>
			<td colspan="2">
				<form name="searchForm" id="searchForm">
				<!----------------- SEARCH Hearder Start	 ----------------->
				<div id="ext-comp-1002" class=" x-panel x-form-label-left" style="margin-top: 0.4em;"><%-- 0em <- 1em으로 수정하면 상위 공백 --%>
					<div class="x-panel-tl">
						<div class="x-panel-tr">
							<div class="x-panel-tc">
								<div id="ext-gen4" class="x-panel-header x-unselectable" style="-moz-user-select: none;">
									<span id="ext-gen8" class="x-panel-header-text">프로젝트정보  검색</span>
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
										<td width="25%">
											<div tabindex="-1" class="x-form-item " >
												<label class="x-form-item-label" style="width: auto;" for="src_pjt_id" >프로젝트ID :</label>
												<div style="padding-left: 0px;" class="x-form-element">
													<input type="text" name="src_pjt_id" id="src_pjt_id" autocomplete="off" size="22" class=" x-form-text x-form-field" style="width: auto;" />
												</div>
											</div>
										</td>
										<td width="10%">&nbsp;</td> 
										<td width="25%">
											<div tabindex="-1" class="x-form-item " >
												<label class="x-form-item-label" style="width: auto;" for="src_pjt_name" >프로젝트명 :</label>
												<div style="padding-left: 0px;" class="x-form-element">
													<input type="text" name="src_pjt_name" id="src_pjt_name" autocomplete="off" size="22" class=" x-form-text x-form-field" style="width: auto;" />
												</div>
											</div>
										</td>
										<td width="10%">&nbsp;</td> 
										<td width="30%" align="left">
											<div tabindex="-1" class="x-form-item " >
												<label class="x-form-item-label" style="width: auto;" for="src_custom_name" >거래처명 :</label>
												<div style="padding-left: 61px;" class="x-form-element">
													<input type="text" name="src_custom_name" id="src_custom_name" autocomplete="off" size="18" class=" x-form-text x-form-field" style="width: auto;"/>
												</div>
											</div>
										</td> 
										
									</tr>
									<%-- 1 Row End --%>
									<tr>
										<td align="">
											<div tabindex="-1" class="x-form-item " >
												<label class="x-form-item-label" style="width: auto;" for="src_pjt_date_from" ><font color="red"> </font>사업구분 :</label>
												<div style="padding-left: 70px;" class="x-form-element">
													<table>
														<tr>
															<td>
																<select name="src_pjt_type_code" id="src_pjt_type_code" title="사업구분" style="width: 135px;" type="text" class=" x-form-select x-form-field" />
																	<option value="">선택하세요</option>
																	<c:forEach items="${PJT_TYPE_CODE}" var="data" varStatus="status">
																		<c:if test="${data.COM_CODE=='10' || data.COM_CODE=='20'}">	
																			<option value="${data.COM_CODE}" <c:if test="${data.COM_CODE == pMap.src_pjt_type_code}">selected='selected'</c:if> ><c:out value="${data.COM_CODE_NAME}"/></option>
																		</c:if>
																	</c:forEach>
																</select>
															</td> 
														</tr>
													</table>
												</div>
											</div>
										</td>
										<td width="10%">&nbsp;</td> 
										<td colspan="3" align="">
											<div tabindex="-1" class="x-form-item " >
												<label class="x-form-item-label" style="width: auto;" for="src_pjt_date_from" ><font color="red"> </font>기간 :</label>
												<div style="padding-left: 70px;" class="x-form-element">
													<table>
														<tr>
															<td>
																<input type="text" name="src_pjt_date_from" id="src_pjt_date_from" autocomplete="off" size="14" style="width: auto;">		
															</td>
															<td>
																 &nbsp;&nbsp;~&nbsp;&nbsp; 
															</td>
															<td>
																<input type="text" name="src_pjt_date_to" id="src_pjt_date_to" autocomplete="off" size="14" style="width: auto;">		
															</td>
														</tr>
													</table>
												</div>
											</div>
										</td>
									</tr>
									<%-- 3 Row 버튼 Start --%>
									<tr align="right">
										<td colspan="5" style="padding-right: 30">
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
			<!----------------- 기본정보 GRID START ----------------->
			<td width="100%" valign="top" colspan="2">
				<div id="pjt_grid_3rd" style="margin-top: 0.4em;"></div>
			</td>
			<!----------------- 기본정보 GRID END ----------------->			  
		</tr>
		<tr>
			<!----------------- 거래처정보 GRID START ----------------->
			<td width="100%" valign="top" colspan="2">
				<div id="edit_grid_1st" style="margin-top: 0.4em;"></div>
			</td>
			<!----------------- 거래처정보 GRID END ----------------->
		</tr>
		<tr height="10"></tr>
		<tr>
			<!----------------- 품목 정보 GRID START ----------------->
			<td width="100%" valign="top" colspan="2">
				<div id="edit_grid_2nd" style="margin-top: 0.4em;"></div>
			</td>
			<!----------------- 품목 정보 GRID END ----------------->
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
				</table>
			</td>
		</tr>
	</table>
</body>

<%@ include file="/WEB-INF/web/jsp/sgis-bottom-inc.jsp" %>