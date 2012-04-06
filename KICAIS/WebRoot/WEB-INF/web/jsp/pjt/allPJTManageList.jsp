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

<!-- KICA VALIDATION SCRIPT -->
<script type="text/javascript" src="/resource/common/js/validator.js"></script>

<!-- KICA COMMON SCRIPT -->
<script type="text/javascript" src="/resource/common/js/sgis-comm-inc.js"></script> 

<script type="text/javascript" src="/resource/common/js/common/common-msg-box.js" ></script> 

<script type="text/javascript" src="/resource/common/js/ajax.js" ></script>
<script type="text/javascript" src="/resource/common/js/grid/grid_1st.js"></script>
<script type="text/javascript" src="/resource/common/js/grid/grid_edit_1st.js"></script> 
<script type="text/javascript" src="/resource/common/js/grid/grid_edit_2nd.js"></script>
<script type="text/javascript">
 
/***************************************************************************
 *  프로젝트정보 -- 초기값 설정 
 ***************************************************************************/
var	gridHeigth_1st 	 	= 407; 								// 그리드 전체 높이
var	gridWidth_1st		= 400;								// 그리드 전체 폭
var gridTitle_1st 		= "프로젝트 목록"; 					// 그리드 제목
var	render_1st			= "pjt_grid";						// 렌더(화면에 그려질) 할 id 
var	pageSize_1st		= 15;	  							// 그리드 페이지 사이즈	
var	proxyUrl_1st		= "/pjt/pjtManage/result_1st.sg";  	// 결과 값 페이지
var limit_1st			= pageSize_1st;
var start_1st			= 0;

var re_PJT_ID			="";

// 그리드의 페이지 클릭시 검색조건값을 DB로 전송
function fnPagingValue_1st(){
	
	try{
		GridClass_1st.store.setBaseParam('start'		 	  			,start_1st);
	    GridClass_1st.store.setBaseParam('limit'		 	  			,limit_1st);	    
	    GridClass_1st.store.setBaseParam('src_pjt_type_code'         	,'<%=request.getParameter("src_pjt_type_code")%>'); 
		GridClass_1st.store.setBaseParam('pjt_id'                	    ,Ext.get('pjt_id').getValue());
		 
		GridClass_1st.store.setBaseParam('src_pjt_id'                	    ,'<%=request.getParameter("src_pjt_id")%>');
		GridClass_1st.store.setBaseParam('src_pjt_name'                	    ,'<%=request.getParameter("src_pjt_name")%>');
		
		
	}catch(e){

	}
}
 
		
// Grid의 컬럼 설정
var userColumns_1st =  [ 	  {header: '상태'                ,width: 60  ,sortable: true ,dataIndex:'FLAG'              ,hidden : true}
							, {header: '프로젝트ID'  			,width: 60  ,sortable: true ,dataIndex:'PJT_ID'              }
							, {header: '프로젝트구분코드'  	,width: 60  ,sortable: true ,dataIndex:'PJT_TYPE_CODE'      ,hidden : true}                                  
							, {header: '프로젝트명'  			,width: 60  ,sortable: true ,dataIndex:'PJT_NAME'            }                    
							, {header: '등록일자'				,width: 60  ,sortable: true ,dataIndex:'PJT_REG_DATE'       ,hidden : true}                                  
							, {header: '프로젝트기간 FROM'		,width: 60  ,sortable: true ,dataIndex:'PJT_DATE_FROM'      ,hidden : true}                    
							, {header: '프로젝트기간 TO'		,width: 60  ,sortable: true ,dataIndex:'PJT_DATE_TO'        ,hidden : true}                    
							, {header: '프로젝트담당자부서코드'	,width: 60  ,sortable: true ,dataIndex:'PJT_OWN_DEPT_CODE'  ,hidden : true}
							, {header: '프로젝트담당자부서명'	,width: 60  ,sortable: true ,dataIndex:'PJT_OWN_DEPT_NM'   	,hidden : true}
							
							, {header: '프로젝트담당자사번'		,width: 60  ,sortable: true ,dataIndex:'PJT_OWN_EMP_NUM'    ,hidden : true}
							, {header: '프로젝트담당자'		,width: 60  ,sortable: true ,dataIndex:'PJT_OWN_EMP_NM'     ,hidden : true}
							
							, {header: '프로젝트등록자부서코드'	,width: 60  ,sortable: true ,dataIndex:'PJT_REG_DEPT_CODE'  ,hidden : true}
							, {header: '프로젝트등록자부서'	    ,width: 60  ,sortable: true ,dataIndex:'PJT_REG_DEPT_NM'    ,hidden : true}
							
							, {header: '프로젝트등록자사번'		,width: 60  ,sortable: true ,dataIndex:'PJT_REG_EMP_NUM'    ,hidden : true} 
							, {header: '프로젝트등록자'		,width: 60  ,sortable: true ,dataIndex:'PJT_REG_EMP_NM'     ,hidden : true} 
							
							, {header: '업무구분코드'			,width: 60  ,sortable: true ,dataIndex:'ROLL_TYPE_CODE'     ,hidden : true}
							, {header: '업무구분'				,width: 60  ,sortable: true ,dataIndex:'ROLL_TYPE_NM'       ,hidden : true}
							
							, {header: '수주가능성'			,width: 60  ,sortable: true ,dataIndex:'ORDER_POSSBLE'      ,hidden : true}                    
							, {header: '유/무상구분코드' 		,width: 60  ,sortable: true ,dataIndex:'PAY_FREE_CODE'      ,hidden : true}                    
							, {header: '수주예정일'			,width: 60  ,sortable: true ,dataIndex:'ORDER_EXP_DATE'     ,hidden : true}                    
							, {header: '제안(입찰)마감일'		,width: 60  ,sortable: true ,dataIndex:'BID_DDAY'           ,hidden : true}                    
							, {header: '진행상태코드'			,width: 60  ,sortable: true ,dataIndex:'PROC_STATUS_CODE'   ,hidden : true}   
							, {header: '진행상태'				,width: 60  ,sortable: true ,dataIndex:'PROC_STATUS_NM'      }   
							
							, {header: '개요및특이사항'		,width: 60  ,sortable: true ,dataIndex:'PJT_SUMMARY'        ,hidden : true}                    
							, {header: '예상매출총액'			,width: 60  ,sortable: true ,dataIndex:'EXP_SAL_TOTAL_AMT'  ,hidden : true}                    
							, {header: '예상매출총세액'		,width: 60  ,sortable: true ,dataIndex:'EXP_SAL_TOTAL_TAX'  ,hidden : true}                    
							, {header: '비고'				,width: 60 	,sortable: true ,dataIndex:'NOTE'               ,hidden : true}                    
							, {header: '최종변경자ID'			,width: 60  ,sortable: true ,dataInDEX:'FINAL_MOD_ID'       ,hidden : true}                    
							, {header: '최종변경일시'			,width: 60  ,sortable: true ,dataIndex:'FINAL_MOD_DATE'     ,hidden : true}                    
							, {header: '최초등록일'			,width: 60  ,sortable: true ,dataIndex:'REG_DATE'           ,hidden : true}                    
							, {header: '최초등록자'			,width: 60  ,sortable: true ,dataIndex:'REG_ID'             ,hidden : true}                       
												   
					   ];	 

// 그리드 결과매핑 
var mappingColumns_1st = [     {name: 'FLAG'		 	  , allowBlank: false}
							 , {name: 'START'		 	  , allowBlank: false}
							 , {name: 'LIMIT'		 	  , allowBlank: false}
							 , {name: 'PJT_ID'            , allowBlank: false} 
							 , {name: 'PJT_TYPE_CODE'     , allowBlank: false}
							 , {name: 'PJT_NAME'          , allowBlank: false}
							 , {name: 'PJT_REG_DATE'      , allowBlank: false}
							 , {name: 'PJT_DATE_FROM'     , allowBlank: false}
							 , {name: 'PJT_DATE_TO'       , allowBlank: false}
							 
							 , {name: 'PJT_OWN_DEPT_CODE' , allowBlank: false}
							 , {name: 'PJT_OWN_DEPT_NM'   , allowBlank: false}
							 
							 , {name: 'PJT_OWN_EMP_NUM'   , allowBlank: false}
							 , {name: 'PJT_OWN_EMP_NM'    , allowBlank: false}
							 
							 , {name: 'PJT_REG_DEPT_CODE' , allowBlank: false}
							 , {name: 'PJT_REG_DEPT_NM'   , allowBlank: false}
							 
							 , {name: 'PJT_REG_EMP_NUM'   , allowBlank: false}
							 , {name: 'PJT_REG_EMP_NM'    , allowBlank: false}
							 
							 , {name: 'ROLL_TYPE_CODE'    , allowBlank: false}
							 , {name: 'ROLL_TYPE_NM'      , allowBlank: false}
							 
							 , {name: 'ORDER_POSSBLE'     , allowBlank: false}
							 , {name: 'PAY_FREE_CODE'     , allowBlank: false}
							 , {name: 'ORDER_EXP_DATE'    , allowBlank: false}
							 , {name: 'BID_DDAY'          , allowBlank: false}
							 
							 , {name: 'PROC_STATUS_CODE'  , allowBlank: false}
							 , {name: 'PROC_STATUS_NM'  , allowBlank: false}
							 
							 , {name: 'PJT_SUMMARY'       , allowBlank: false}
							 , {name: 'EXP_SAL_TOTAL_AMT' , allowBlank: false}
							 , {name: 'EXP_SAL_TOTAL_TAX' , allowBlank: false}
							 , {name: 'NOTE'              , allowBlank: false}
							 , {name: 'FINAL_MOD_ID'      , allowBlank: false}
							 , {name: 'FINAL_MOD_DATE'    , allowBlank: false}
							 , {name: 'REG_DATE'          , allowBlank: false}
							 , {name: 'REG_ID'            , allowBlank: false}    
    				 	 ];
 
/***************************************************************************
 * 프로젝트정보 --- 그리드 클릭시 Event
 ***************************************************************************/
function fnGridOnClick_1st(store, rowIndex){
	
	fnInitValue('');
	Ext.get('flag'             ).set({value : fnFixNull(store.getAt(rowIndex).data.FLAG           	)}, false);
	Ext.get('pjt_id'           ).set({value : fnFixNull(store.getAt(rowIndex).data.PJT_ID           )}, false);
	Ext.get('pjt_type_code'    ).set({value : fnFixNull(store.getAt(rowIndex).data.PJT_TYPE_CODE    )}, false);
	Ext.get('pjt_name'         ).set({value : fnFixNull(store.getAt(rowIndex).data.PJT_NAME         )}, false);
	Ext.get('pjt_reg_date'     ).set({value : fnFixNull(store.getAt(rowIndex).data.PJT_REG_DATE     )}, false);
	Ext.get('pjt_date_from'    ).set({value : fnFixNull(store.getAt(rowIndex).data.PJT_DATE_FROM    )}, false);
	Ext.get('pjt_date_to'      ).set({value : fnFixNull(store.getAt(rowIndex).data.PJT_DATE_TO      )}, false);
	
	Ext.get('pjt_own_dept_code').set({value : fnFixNull(store.getAt(rowIndex).data.PJT_OWN_DEPT_CODE)}, false);
	Ext.get('pjt_own_dept_nm').set({value : fnFixNull(store.getAt(rowIndex).data.PJT_OWN_DEPT_NM)}, false);
	
	Ext.get('pjt_own_emp_num'  ).set({value : fnFixNull(store.getAt(rowIndex).data.PJT_OWN_EMP_NUM  )}, false);
	Ext.get('pjt_own_emp_nm'  ).set({value : fnFixNull(store.getAt(rowIndex).data.PJT_OWN_EMP_NM  )}, false);
	
	Ext.get('pjt_reg_dept_code').set({value : fnFixNull(store.getAt(rowIndex).data.PJT_REG_DEPT_CODE)}, false);
	Ext.get('pjt_reg_dept_nm').set({value : fnFixNull(store.getAt(rowIndex).data.PJT_REG_DEPT_NM)}, false);
	
	Ext.get('pjt_reg_emp_num'  ).set({value : fnFixNull(store.getAt(rowIndex).data.PJT_REG_EMP_NUM  )}, false);
	Ext.get('pjt_reg_emp_nm'  ).set({value : fnFixNull(store.getAt(rowIndex).data.PJT_REG_EMP_NM  )}, false);
	
	//Ext.get('roll_type_code'   ).set({value : fnFixNull(store.getAt(rowIndex).data.ROLL_TYPE_CODE   )}, false);
	Ext.get('order_possble'    ).set({value : fnFixNull(store.getAt(rowIndex).data.ORDER_POSSBLE    )}, false);
	Ext.get('pay_free_code'    ).set({value : fnFixNull(store.getAt(rowIndex).data.PAY_FREE_CODE    )}, false);
	Ext.get('order_exp_date'   ).set({value : fnFixNull(store.getAt(rowIndex).data.ORDER_EXP_DATE   )}, false);
	Ext.get('bid_dday'         ).set({value : fnFixNull(store.getAt(rowIndex).data.BID_DDAY         )}, false);
	Ext.get('proc_status_code' ).set({value : fnFixNull(store.getAt(rowIndex).data.PROC_STATUS_CODE )}, false);
	Ext.get('pjt_summary'      ).set({value : fnFixNull(store.getAt(rowIndex).data.PJT_SUMMARY      )}, false);
	Ext.get('exp_sal_total_amt').set({value : fnFixNull(MoneyComma(store.getAt(rowIndex).data.EXP_SAL_TOTAL_AMT))}, false);
	//Ext.get('exp_sal_total_tax').set({value : fnFixNull(store.getAt(rowIndex).data.EXP_SAL_TOTAL_TAX)}, false);
	Ext.get('note'             ).set({value : fnFixNull(store.getAt(rowIndex).data.NOTE             )}, false);
	Ext.get('final_mod_id'     ).set({value : fnFixNull(store.getAt(rowIndex).data.FINAL_MOD_ID     )}, false);
	
	Ext.get('final_mod_date'   ).set({value : fnFixNull(store.getAt(rowIndex).data.FINAL_MOD_DATE   )}, false);
	//Ext.get('reg_date'         ).set({value : fnFixNull(store.getAt(rowIndex).data.REG_DATE         )}, false);
	//Ext.get('reg_id'           ).set({value : fnFixNull(store.getAt(rowIndex).data.REG_ID           )}, false);
 
	
	// 버튼 disable
	Ext.get('saveBtn').dom.disabled   = true;
	Ext.get('updateBtn').dom.disabled = false;
			 
	var keyValue1 = fnFixNull(store.getAt(rowIndex).data.PJT_ID);			 
	
	fnSearchEdit1st(keyValue1,'', '');									//거래처정보
	fnSearchEdit2nd(keyValue1,'', '');									//품목정보
	
	
	parent.document.searchForm.src_pjt_id.value=fnFixNull(store.getAt(rowIndex).data.PJT_ID);
	parent.document.searchForm.src_pjt_name.value=fnFixNull(store.getAt(rowIndex).data.PJT_NAME);
	
	
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
var	gridHeigth_edit_1st	= 200;
var	gridWidth_edit_1st  = 1000	;
var	gridTitle_edit_1st  = "프로젝트 거래처정보"	; 
var	render_edit_1st		= "edit_grid_1st";
var keyNm_edit_1st		= "PJT_INFO_SEQ";
var pageSize_edit_1st	= 4;
var limit_edit_1st		= pageSize_edit_1st;
var start_edit_1st		= 0;
var proxyUrl_edit_1st	= "/pjt/pjtManage/result_edit_1st.sg"; 
var gridRowDeleteYn	    = "";
var tbarHidden_edit_1st = "";

// 행추가
function addNew_edit_1st(){
			
	var Plant = GridClass_edit_1st.grid.getStore().recordType; 
    var p = new Plant({ 
	        		     FLAG					: 'I' 
	        		  	,PJT_ID		    		: Ext.get('pjt_id').getValue()
				   	  	,PJT_REG_DATE			: getTimeStamp().trim()
						,CUSTOM_PATTERN_CODE	: ''
						,CUSTOM_CODE			: ''
						,COSTOMER_NUM			: ''
						,CONSTRACT_YN			: 'N'
						,NOTE					: ''
						,FINAL_MOD_ID	: '${admin_nm}'
						,FINAL_MOD_DATE	: getTimeStamp().trim()
    				  }); 
    if(document.detailForm.pjt_id.value!=""){
	  	GridClass_edit_1st.grid.stopEditing();
		GridClass_edit_1st.store.insert(0, p);
		GridClass_edit_1st.grid.startEditing(0, 0);
	}else{
		Ext.Msg.alert('확인', '프로젝트를 먼저 선택 해 주세요'); 
	}
}

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

// 그리드 필드
var	userColumns_edit_1st	= [  {header: "flag"           		,	width: 10,	sortable: true,	dataIndex: "FLAG"       		,		editor: new Ext.form.TextField({ allowBlank : false }), hidden:true, editable:false}	
		   , {id: "pjt_info_seq", header: "순번"            		,	width: 10,	sortable: true,	dataIndex: "PJT_INFO_SEQ"       ,		editor: new Ext.form.TextField({ allowBlank : false }), hidden:true, editable:false}
								,{header: "등록일자"        		,	width: 10,	sortable: true,	dataIndex: "PJT_REG_DATE"       ,		editor: new Ext.form.TextField({ allowBlank : false }), hidden:true, editable:false}
								,{header: "프로젝트ID"      		,	width: 50,	sortable: true,	dataIndex: "PJT_ID"             ,		editor: new Ext.form.TextField({ allowBlank : false }), hidden:true, editable:false}
								,{header: "* 거래처유형"      	,	width: 50,	sortable: true,	dataIndex: "CUSTOM_PATTERN_CODE",       editor: combo  ,renderer: Ext.util.Format.comboRenderer(combo) } 
								,{header: "거래처유형코드"      	,	width: 50,	sortable: true,	dataIndex: "CUSTOM_PATTERN_NM"  ,		editor: new Ext.form.TextField({ allowBlank : false }), hidden:true}
								
								,{header: "거래처코드"      		,	width: 50,	sortable: true,	dataIndex: "CUSTOM_CODE"        ,		editor: new Ext.form.TextField({ allowBlank : false }), hidden:true}
								,{header: "* 거래처명"      		,	width: 50,	sortable: true,	dataIndex: "CUSTOM_NAME"        ,		editor: new Ext.form.TextField({ allowBlank : false }), editable:false, renderer: changeBLUE}
								
								,{header: "거래처담당자번호"		,	width: 50,	sortable: true,	dataIndex: "COSTOMER_NUM"       ,		editor: new Ext.form.TextField({ allowBlank : false }), hidden:true}
								,{header: "* 거래처담당자명"		,	width: 50,	sortable: true,	dataIndex: "COSTOMER_NAME"      ,		editor: new Ext.form.TextField({ allowBlank : false }), editable:false, renderer: changeBLUE}
								
								,{header: "당사와계약여부"			,	width: 50,	sortable: true, dataIndex: 'CONSTRACT_YN'		, 		editor: CONSTRACT_YN_COMBO  ,renderer: Ext.util.Format.comboRenderer(CONSTRACT_YN_COMBO)}
								,{header: "비고"            		,	width: 100,	sortable: true,	dataIndex: "NOTE"               ,		editor: new Ext.form.TextField({ allowBlank : false })}
								
								,{header: "최종변경자"    		,	width: 50,	sortable: true,	dataIndex: "FINAL_MOD_ID"       ,		editor: new Ext.form.TextField({ allowBlank : false }), editable:false}
								,{header: "최종변경일"    		,	width: 50,	sortable: true,	dataIndex: "FINAL_MOD_DATE"     ,		editor: new Ext.form.TextField({ allowBlank : false }), editable:false}
								,{header: "최초등록일"      		,	width: 50,	sortable: true,	dataIndex: "REG_DATE"           ,		editor: new Ext.form.TextField({ allowBlank : false }), hidden:true, editable:false}
								,{header: "최초등록자"      		,	width: 510,	sortable: true,	dataIndex: "REG_ID"             ,		editor: new Ext.form.TextField({ allowBlank : false }), hidden:true, editable:false}
								
							  ];

// 맵핑 필드
var	mappingColumns_edit_1st	= [  {name: "FLAG"       		 , 		type:"string", mapping: "FLAG"       		 }
							    ,{name: "PJT_INFO_SEQ"       , 		type:"string", mapping: "PJT_INFO_SEQ"       }
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
var	gridHeigth_edit_2nd	= 200;
var	gridWidth_edit_2nd  = 1000	;
var	gridTitle_edit_2nd  = "프로젝트 매출 품목정보"; 
var	render_edit_2nd		= "edit_grid_2nd";
var keyNm_edit_2nd		= "PJT_INFO_SEQ";
var pageSize_edit_2nd	= 4;
var limit_edit_2nd		= pageSize_edit_2nd;
var start_edit_2nd		= 0;
var proxyUrl_edit_2nd	= "/pjt/pjtManage/result_edit_2nd.sg"; 
var grid2ndRowDeleteYn  = ""; 
var tbarHidden_edit_2nd = "";

// 행추가
function addNew_edit_2nd(){
	var Plant = GridClass_edit_2nd.grid.getStore().recordType; 
    var p = new Plant({ 
	        		     FLAG			: 'I' 
	        		    ,PJT_REG_DATE	: getTimeStamp().trim()
						,PJT_ID			: Ext.get('pjt_id').getValue()
						,ITEM_CODE		: ''
						,CPU_CNT		: '0'
						,CORE_CNT		: '0'
						,CNT			: '0'
						,UNIT_PRICE		: ''
						,AMT			: ''
						,TAX			: ''
						,NOTE			: ''
						,FINAL_MOD_ID	: '${admin_nm}'
						,FINAL_MOD_DATE	: getTimeStamp().trim()
    				  }); 
    if(document.detailForm.pjt_id.value!=""){
	  	GridClass_edit_2nd.grid.stopEditing();
		GridClass_edit_2nd.store.insert(0, p);
		GridClass_edit_2nd.grid.startEditing(0, 0);
	}else{
		Ext.Msg.alert('확인', '프로젝트를 먼저 선택 해 주세요'); 
	}
    
    
}

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
var	userColumns_edit_2nd	= [  {header: "flag"           		,	width: 10,	sortable: true,	dataIndex: "FLAG"       		,		editor: new Ext.form.TextField({ allowBlank : false }), hidden:true, editable:false}
								,{header: "순번"     		,	width: 10,	sortable: true,	dataIndex: "PJT_INFO_SEQ"		,	editor: new Ext.form.TextField({ allowBlank : false }) , hidden:true}
								,{header: "등록일자"   		,	width: 10,	sortable: true,	dataIndex: "PJT_REG_DATE"		,	editor: new Ext.form.TextField({ allowBlank : false }) , hidden:true, editable:false}
								,{header: "프로젝트ID" 		,	width: 60,	sortable: true,	dataIndex: "PJT_ID"      		,	editor: new Ext.form.TextField({ allowBlank : false }) , hidden:true, editable:false}
								
								,{header: "품목코드"   		,	width: 10,	sortable: true,	dataIndex: "ITEM_CODE"   		,	editor: new Ext.form.TextField({ allowBlank : false }) , hidden:true}
								,{header: "* 품목"   		,	width: 100,	sortable: true,	dataIndex: "ITEM_NAME"   			,	editor: new Ext.form.TextField({ allowBlank : false }) , editable:false, renderer: changeBLUE}
								
								,{header: "CPU수"  			,	width: 25,	sortable: true,	dataIndex: "CPU_CNT"      		,	editor: new Ext.form.TextField({ allowBlank : false }) }
								,{header: "CORE수" 			,	width: 25,	sortable: true,	dataIndex: "CORE_CNT"    		,	editor: new Ext.form.TextField({ allowBlank : false }) }
								,{header: "수량"     		,	width: 25,	sortable: true,	dataIndex: "CNT"         		,	editor: new Ext.form.TextField({ allowBlank : false }) }
								,{header: "단가"     		,	width: 40,	sortable: true,	dataIndex: "UNIT_PRICE"  		,	editor: new Ext.form.TextField({ allowBlank : false }) , editable:false, renderer: korMoneyChangeRED, align:'right'}	
								,{header: "금액"     		,	width: 40,	sortable: true,	dataIndex: "AMT"         		,	editor: new Ext.form.TextField({ allowBlank : false }) , editable:false, renderer: korMoneyChangeRED, align:'right'}	
								,{header: "세액"     		,	width: 40,	sortable: true,	dataIndex: "TAX"         		,	editor: new Ext.form.TextField({ allowBlank : false }) , editable:false, renderer: korMoneyChangeRED, align:'right'}	
								,{header: "비고"     		,	width: 100,	sortable: true,	dataIndex: "NOTE"        		,	editor: new Ext.form.TextField({ allowBlank : false }) }	
								,{header: "최종변경자"  		,	width: 50,	sortable: true,	dataIndex: "FINAL_MOD_ID"   	,	editor: new Ext.form.TextField({ allowBlank : false }) ,  editable:false}
								,{header: "최종변경일"   		,	width: 50,	sortable: true,	dataIndex: "FINAL_MOD_DATE" 	,	editor: new Ext.form.TextField({ allowBlank : false }) ,  editable:false}
								,{header: "최초등록일"    	,	width: 50,	sortable: true,	dataIndex: "REG_DATE"       	,	editor: new Ext.form.TextField({ allowBlank : false }) , hidden:true, editable:false}
								,{header: "최초등록자"    	,	width: 50,	sortable: true,	dataIndex: "REG_ID"         	,	editor: new Ext.form.TextField({ allowBlank : false }) , hidden:true, editable:false}
								  
							  ];

// 맵핑 필드
var	mappingColumns_edit_2nd	= [ 	 
									 {name: "FLAG"     		 , 	type:"string", mapping: "FLAG"       	 }
									,{name: "PJT_INFO_SEQ"	 , 	type:"string", mapping: "PJT_INFO_SEQ"	 }
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
function fnInitValue(obj){
   
	
	var dForm = document.detailForm;		// 상세 FORM	
	dForm.reset();							// 상세필드 초기화
	
	dForm.pjt_reg_emp_num.value 	= "${sabun}";
	dForm.pjt_reg_emp_nm.value 		= "${admin_nm}";
	dForm.pjt_reg_dept_code.value 	= "${dept_code}";
	dForm.pjt_reg_dept_nm.value 	= "${dept_nm}";
	dForm.pjt_id.value				= "${new_pjt_id}";
	dForm.pjt_reg_date.value		= getTimeStamp().trim();
	
	dForm.final_mod_id.value 		= "${admin_nm}";
	dForm.final_mod_date.value		= getTimeStamp().trim();
	
	dForm.pjt_type_code.value 		= "10";
	dForm.proc_status_code.value 	= "10";
	
	if(dForm.pjt_id.value == "" && obj==null){
		dForm.pjt_id.value="${new_pjt_id}";
	}else if(dForm.pjt_id.value == "" && obj=='newPjtID'){
		dForm.pjt_id.value = re_PJT_ID;
	}
 
		
	// 버튼 초기화
	Ext.get('saveBtn').dom.disabled    	   		= false;
	Ext.get('updateBtn').dom.disabled  	   		= true;
 	
	try{
		GridClass_edit_1st.store.commitChanges();	// 변경된 record를 commit
		GridClass_edit_1st.store.removeAll();		// store자료를 삭제
		GridClass_edit_2nd.store.commitChanges();
		GridClass_edit_2nd.store.removeAll();
	}catch(e){
		
	}
	
	
} 
 


/***************************************************************************
 * 설  명 : 저장버튼 클릭
 ***************************************************************************/
function fnSave(){  	
 
																					// 변경된 견적 품목정보 Grid의 record 
	var records = GridClass_edit_1st.store.getModifiedRecords();	  
	// 변경된 record의 자료를 json형식으로
    var edit1stJson = "[";
	    for (var i = 0; i < records.length; i++) {
	    	
	    		
	    	if(records[i].data.CUSTOM_PATTERN_CODE == ""){
	    		SGAlert("[프로젝트 거래처 정보]", [i+1]+"번째 행의 [거래처유형]을 선택 입력 해 주세요");
	    		return false;
	    	} 
	    	if(records[i].data.CUSTOM_CODE == ""){
	    		SGAlert("[프로젝트 거래처 정보]", [i+1]+"번째 행의 [거래처]를 선택 입력 해 주세요");
	    		return false;
	    	}
	    	if(records[i].data.COSTOMER_NUM == ""){
	    		SGAlert("[프로젝트 거래처 정보]", [i+1]+"번째 행의 [거래처 담당자]를 입력 해 주세요");
	    		return false;
	    	}  
	    	
	      edit1stJson += Ext.util.JSON.encode(records[i].data);				
	      if (i < (records.length-1)) {
	        edit1stJson += ",";
	      }
	    }
    	edit1stJson += "]"
    
	// 변경된 납품처 시스템 사양정보 Grid의 record
	var record2 = GridClass_edit_2nd.store.getModifiedRecords();	  
	// 변경된 record의 자료를 json형식으로
    var edit2ndJson = "[";
	    for (var i = 0; i < record2.length; i++) {
	    	
	    	if(record2[i].data.ITEM_CODE == ""){
	    		SGAlert("[프로젝트 매출 품목 정보]", [i+1]+"번째 행의 [품목]을 선택  입력 해 주세요");
	    		return false;
	    	} 
	    	
	    	
	      edit2ndJson += Ext.util.JSON.encode(record2[i].data);				
	      if (i < (record2.length-1)) {
	        edit2ndJson += ",";
	      }
	    }
    	edit2ndJson += "]"
 	
	Ext.Ajax.request({   
		url: "/pjt/pjtManage/actionPjtManage.sg?pjtManType=base&src_pjt_type_code=10"
		,success: function(response){						// 조회결과 성공시
					// 조회된 결과값, store명
					handleSuccess(response,GridClass_1st,'save');
					var json = Ext.util.JSON.decode(response.responseText);
					document.detailForm.pjt_id.value=json.new_pjt_id;
					re_PJT_ID = json.new_pjt_id;
		          } 
		,failure: handleFailure   	    // 조회결과 실패시  
		,form   : document.detailForm	// 상세 FORM	
		,params : {					    // 조회조건을 DB로 전송하기위해서 조건값 설정
				  // 페이지정보
					limit          		: limit_1st
			  	  , start          		: start_1st
			  	  , pjt_id        	    : Ext.get('pjt_id').getValue()
			  	  
			  	  , edit1stData		    : edit1stJson
  				  , edit2ndData         : edit2ndJson 
				  }  		
	});  

	fnInitValue();
}  		

/***************************************************************************
 * 설  명 : 화면 설정
 ***************************************************************************/
// ExtJS 진입함수
Ext.onReady(function() {

	 
	var dForm = document.detailForm;
	
     
   	// 담당자검색 버튼
   	// 여러건을 팝업으로 부터 전송 받을경우 param뒤에 &multiSelectYn=Y 를 추가 
	Ext.get('regEmpNumBtn').on('click', function(e){
		var param = '?requestFieldName=reg';
		fnEmployeePop(param)
	}); 
   	
   	//담당자 팝업 
   	Ext.get('ownEmpNumBtn').on('click', function(e){
		var param = '?requestFieldName=own';
		fnEmployeePop(param)
	}); 
			
   	//신규 버튼 -> 상세필드 초기화
	Ext.get('detailClearBtn').on('click', function(e){ 
	
		fnInitValue('newPjtID');		   
	});		
   	
  //저장 버튼 -> 데이터를 server로 전송
	Ext.get('saveBtn').on('click', function(e){	
		
	  if(Ext.get('pjt_name').getValue() == ""){
	      SGAlert("[프로젝트 기본정보]", "프로젝트명을 입력 해 주세요");
	      return false;
      }
	  if(Ext.get('pjt_type_code').getValue() == ""){
        	 SGAlert("[프로젝트 기본정보]", "사업구분을 선택해 주세요");
        	 return false;
      }
	   if(Ext.get('pay_free_code').getValue() == ""){
        	 SGAlert("[프로젝트 기본정보]", "유/무상구분코드를 선택해 주세요");
        	 return false;
      }
	   if(Ext.get('pjt_own_dept_code').getValue() == ""){
        	 SGAlert("[프로젝트 기본정보]", "버튼을 클릭하여 담당자를 선택 입력 해 주세요");
        	 return false;
       }
        if(Ext.get('pjt_date_from').getValue() == ""){
        	 SGAlert("[프로젝트 기본정보]", "버튼을 클릭하여 프로젝트시작일을 선택 입력 해 주세요");
        	 return false;
       }
        if(Ext.get('pjt_date_to').getValue() == ""){
        	 SGAlert("[프로젝트 기본정보]", "버튼을 클릭하여 프로젝트종료일을 선택 입력 해 주세요");
        	 return false;
       } 
	   
	   Ext.MessageBox.confirm('Confirm', '저장하시겠습니까?', showResult);
		
	});
	
	//수정 버튼 -> 데이터를 server로 전송
	Ext.get('updateBtn').on('click', function(e){	
		if(Validator.validate(dForm)){
			Ext.MessageBox.confirm('Confirm', '수정하시겠습니까?', showResult);
		};	
	});
	
	
	/*
		// 프로젝트 시작
	var pjt_date_from = new Ext.form.DateField({
    	applyTo: 'pjt_date_from',
		allowBlank: false,
		format:'Y-m-d',
		editable : false
	});
	
	// 프로젝트 종료
	var pjt_date_to = new Ext.form.DateField({
    	applyTo: 'pjt_date_to',
		allowBlank: false,
		format:'Y-m-d',
		editable : false
	});
	
	// 등록일자
	var pjt_reg_date = new Ext.form.DateField({
    	applyTo: 'pjt_reg_date',
		allowBlank: false,
		format:'Y-m-d',
		editable : false
	});
   	
	// 수주예정일
	var order_exp_date = new Ext.form.DateField({
    	applyTo: 'order_exp_date',
		allowBlank: false,
		format:'Y-m-d',
		editable : false
	});
	
	// 제안(입찰)마감일
	var bid_dday = new Ext.form.DateField({
    	applyTo: 'bid_dday',
		allowBlank: false,
		format:'Y-m-d',
		editable : false
	});
	*/
  
	Ext.get('final_mod_id').dom.disabled    = true;
	Ext.get('final_mod_date').dom.disabled  = true;
	
	Ext.get('pjt_id').dom.disabled  = true;
	
   	      
	fnInitValue();
	
}); // end Ext.onReady

// 저장, 수정버튼 클릭시 '예','아니오' 
function showResult(btn){
   	if(btn == 'yes'){
   		fnSave();
   	}    	
};
	
 
// 팝업
function fnOpenPop(sURL, dlgWidth, dlgHeight, winName){
  var xPos=(window.screen.width) ? (window.screen.width-dlgWidth)/2 : 0;
  var yPos=(window.screen.height) ? (window.screen.height-dlgHeight)/2 : 0;
  var sFeatures = "titlebar=no, scrollbars=no,location=no ,menubar=no, resizable=no, status=yes, width="+dlgWidth+",height="+dlgHeight+",left="+xPos+", top="+yPos;
  window.open(sURL,winName, sFeatures);
}


// 프로젝트 **************************************************
function fnPjtPop(param){
	var sURL      = "/pjt/pjtManage/pjtInfoPop.sg?fieldName=src_pjt_id&pjt_type_code=10";
	var dlgWidth  = 399;
	var dlgHeight = 444;
	var winName   = "project";
	fnOpenPop(sURL, dlgWidth, dlgHeight, winName);
}

function fnPjtPopValue(records, fieldName){
	
	// 전송받은 값이 한건일 경우
    var record = records[0].data;	
	
	if(fieldName == 'pjt_id'){
	    Ext.get('pjt_id').set({value:fnFixNull(record.PJT_ID)} , false);
	    Ext.get('pjt_name').set({value:fnFixNull(record.PJT_NAME)} , false);
    }else if(fieldName == 'src_pjt_id'){
    	Ext.get('src_pjt_id').set({value:fnFixNull(record.PJT_ID)} , false);
	    Ext.get('src_pjt_name').set({value:fnFixNull(record.PJT_NAME)} , false);
    }
}


// 담당자, 등록자 검색팝업 ****************************************
function fnEmployeePop(param){
	
	var sURL      = "/com/employee/employeePop.sg"+param;
	var dlgWidth  = 399;
	var dlgHeight = 396;
	
	var winName;
	
	if(param=="?requestFieldName=own"){
		winName  = "담당자";
	}else{
		winName  = "등록자";
	}
	fnOpenPop(sURL, dlgWidth, dlgHeight, winName);
}
 
  
// 담당자, 등록자 검색 결과 return Value
function fnEmployeePopValue(records, obj){
	var record = records[0].data;	
	if(obj=="reg"){
		Ext.get('pjt_reg_emp_num').set({value:fnFixNull(record.EMP_NUM)} , false);
	    Ext.get('pjt_reg_emp_nm').set({value:fnFixNull(record.KOR_NAME)} , false);
	    Ext.get('pjt_reg_dept_code').set({value:fnFixNull(record.DEPT_CODE)} , false);
	    Ext.get('pjt_reg_dept_nm').set({value:fnFixNull(record.DEPT_NAME)} , false);
	}else{
		Ext.get('pjt_own_emp_num').set({value:fnFixNull(record.EMP_NUM)} , false);
	    Ext.get('pjt_own_emp_nm').set({value:fnFixNull(record.KOR_NAME)} , false);
	    Ext.get('pjt_own_dept_code').set({value:fnFixNull(record.DEPT_CODE)} , false);
	    Ext.get('pjt_own_dept_nm').set({value:fnFixNull(record.DEPT_NAME)} , false);
	}
} 
 
/***************************************************************************
 * 설  명 : 에디트 그리드의 CELL을 클릭하였을 경우 이벤트
 ***************************************************************************/
function  fnEdit1stCellClickEvent(grid, rowIndex, columnIndex, e){
	 
	//거래처 담당자
	if(columnIndex == '7' || columnIndex == '9'){
	 	param = "";
		fnCostomerPop(param);;
	}
} 

// 거래처 **************************************************
function fnCustomPop(param){
	var sURL      = "/com/custom/customPop.sg"+param;
	var dlgWidth  = 399;
	var dlgHeight = 364;
	var winName   = "custom";
	fnOpenPop(sURL, dlgWidth, dlgHeight, winName);
}


// 거래처담당자 검색팝업 *************************************
function fnCostomerPop(param){
	var sURL      = "/com/custom/customMemberPop.sg"+param;
	var dlgWidth  = 399;
	var dlgHeight = 396;
	var winName   = "customer";
	fnOpenPop(sURL, dlgWidth, dlgHeight, winName);
}

// 거래처담당자 결과 *************************************
function fnCostomerPopValue(records){ 
	var record = GridClass_edit_1st.grid.selModel.getSelected(); 

	var costomer_name = records[0].data.CUSTOMER_NAME;
	var costomer_num = records[0].data.CUSTOMER_NUM;
	
	record.set('COSTOMER_NAME', costomer_name);
	record.set('COSTOMER_NUM', costomer_num); 
}


	
function fnEdit2ndCellClickEvent(grid, rowIndex, columnIndex, e){
	//품목 코드 팝업
	if(columnIndex == '5'){
	 	param = "";
		fnItemPop(param);
	}
} 


// 품목 팝업 ****************************************
function fnItemPop(param){
	var sURL      = "/com/item/itemSearchPop.sg"+param;
	var dlgWidth  = 399;
	var dlgHeight = 396;
	var winName   = "item";
	fnOpenPop(sURL, dlgWidth, dlgHeight, winName);
}

function fnItemSearchPopValue(records){
	var record = GridClass_edit_2nd.grid.selModel.getSelected(); 
	
	var item_code  = records[0].data.ITEM_CODE;
	var item_name  = records[0].data.ITEM_NAME;
	var unit_price = records[0].data.UNIT_PRICE_01;
	
	record.set('ITEM_CODE', item_code);
	record.set('ITEM_NAME', item_name);
	record.set('UNIT_PRICE', unit_price);
	 
	var rowAMT = parseInt(record.data.CNT) * parseInt(record.data.UNIT_PRICE); 
	var aplyTaxAMT = rowAMT * 0.1; 
	record.set('AMT', parseInt(rowAMT)-parseInt(aplyTaxAMT));
	record.set('TAX', aplyTaxAMT);
	
}


/***************************************************************************
 * 설  명 : 에디트 그리드의 CELL을 수정하였을 경우 이벤트
 ***************************************************************************/
function  fnEdit2ndAfterCellEdit(obj){
	// 해당 컬럼의 값이 변경 되었을 경우
	var fieldName = obj.field;
	var editedRow = obj.row;
	var record = GridClass_edit_2nd.grid.selModel.getSelected();
	
	if( fieldName == 'CNT' ){
		// 금액 = 수량 * 단가
		var rowAMT = parseInt(record.data.CNT) * parseInt(record.data.UNIT_PRICE);
		// 적용세액 = 금액 * 0.1
		var aplyTaxAMT = rowAMT * 0.1; 
		record.set('AMT', parseInt(rowAMT));			// 금액
		record.set('TAX', aplyTaxAMT);					// 세액 
		
	}// end if
	
	
} 
</script>

</head>
<body class=" ext-gecko ext-gecko3">
	<table border="0" width="1000" height="200"> 
		<tr>
			<!----------------- 기본정보 GRID START ----------------->
			<td width="40%" valign="top">
				<div id="pjt_grid" style="margin-top: 0em;"></div><%-- 0em <- 1em으로 수정하면 상위 공백 --%>
			</td>
			<!----------------- 기본정보 GRID END ----------------->
			<td width="60%" valign="top">
				<div class=" x-panel x-form-label-left" style="margin-top: 0em; width: 100%;"><%-- 0em <- 1em으로 수정하면 상위 공백 --%>
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
									<form id="detailForm" name="detailForm" method="POST" class="x-panel-body x-form" style="padding: 1px 1px 0pt; width: 550px;">
									<input type="hidden" id="flag" name="flag"/>
									<!-- 1_ROW Start -->
									<div class="x-column-inner" style="width: 100%; margin-top: 0em;">
										<div class=" x-panel x-column" style="width: 98%;">
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
									</div>
									<!-- 1_ROW End -->


									<!-- 2_ROW Start -->
									<div class="x-column-inner" style="width: 100%; margin-top: 0em;">
										<div class=" x-panel x-column" style="width: 50%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label class="x-form-item-label" style="width: auto;" for="pjt_id" ><font color="red">* </font>프로젝트ID:</label>
														<div style="padding-left: 80px;" class="x-form-element">
															<input type="text" name="pjt_id" id="pjt_id" autocomplete="off" size="30" class=" x-form-text x-form-field" style="width: auto;">
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
														<label class="x-form-item-label" style="width: auto;" for="pjt_name" ><font color="red">* </font>프로젝트명:</label>
														<div style="padding-left: 90px;" class="x-form-element">
															<input type="text" name="pjt_name" id="pjt_name" autocomplete="off" size="30" class=" x-form-text x-form-field" style="width: auto;">
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
									<div class="x-column-inner" style="width: 100%;">
										<div class=" x-panel x-column" style="width: 50%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label class="x-form-item-label" style="width: auto;" for="pjt_type_code" ><font color="red">* </font>사업구분:</label>
														<div style="padding-left: 80px;" class="x-form-element">
															<select name="pjt_type_code" id="pjt_type_code" title="사업구분" style="width: 175px;" type="text" class=" x-form-select x-form-field">
																<option value="">선택하세요</option>
																<c:forEach items="${PJT_TYPE_CODE}" var="data" varStatus="status">
																	<c:if test="${data.COM_CODE=='10' || data.COM_CODE=='20' || data.COM_CODE=='99'}">	
																		<option value="${data.COM_CODE}"><c:out value="${data.COM_CODE_NAME}"/></option>
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
														<label class="x-form-item-label" style="width: auto;" for="pay_free_code" ><font color="red">* </font>유무상구분:</label>
														<div style="padding-left: 90px;" class="x-form-element">
															<select name="pay_free_code" id="pay_free_code" title="유무상구분" style="width: 175px" type="text" class=" x-form-select x-form-field" >
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
														<label class="x-form-item-label" style="width: auto;" for="pjt_reg_date" ><font color="red">* </font>등록일자:</label>
														<div style="padding-left: 80px;" class="x-form-element">
															<input type="text" name="pjt_reg_date" id="pjt_reg_date" autocomplete="off" size="30" class=" x-form-text x-form-field" style="width: auto;">
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
														<label class="x-form-item-label" style="width: auto;" for="pjt_reg_emp_num" ><font color="red">* </font>등록자:</label>
														<div style="padding-left: 90px;" class="x-form-element">
															<table style="width: 175px;" cellspacing="0" class="x-btn  x-btn-noicon">
																<tr>
																	<td>
																		<input type="hidden" name="pjt_reg_emp_num" id="pjt_reg_emp_num" autocomplete="off" size="6" class=" x-form-text x-form-field" style="width: auto;">
																		<input type="text" name="pjt_reg_dept_nm" id="pjt_reg_dept_nm" autocomplete="off" size="11" class=" x-form-text x-form-field" style="width: auto;">
																		<input type="text" name="pjt_reg_emp_nm" id="pjt_reg_emp_nm" autocomplete="off" size="6" class=" x-form-text x-form-field" style="width: auto;">
																		<input type="hidden" name="pjt_reg_dept_code" id="pjt_reg_dept_code" autocomplete="off" size="6" class=" x-form-text x-form-field" style="width: auto;">
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
																							<button type="button" id="regEmpNumBtn" class=" x-btn-text">검색</button>
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
														<label class="x-form-item-label" style="width: auto;" for="pjt_own_emp_num" ><font color="red">* </font>담당자:</label>
														<div style="padding-left: 80px;" class="x-form-element">
															<table style="width: 175px;" cellspacing="0" class="x-btn  x-btn-noicon">
																<tr>
																	<td>
																		<input type="hidden" name="pjt_own_emp_num" id="pjt_own_emp_num" autocomplete="off" size="7" class=" x-form-text x-form-field" style="width: auto;">
																		<input type="text" name="pjt_own_dept_nm" id="pjt_own_dept_nm" autocomplete="off" size="11" class=" x-form-text x-form-field" style="width: auto;">
																		<input type="text" name="pjt_own_emp_nm" id="pjt_own_emp_nm" autocomplete="off" size="6" class=" x-form-text x-form-field" style="width: auto;">
																		<input type="hidden" name="pjt_own_dept_code" id="pjt_own_dept_code" autocomplete="off" size="7" class=" x-form-text x-form-field" style="width: auto;">
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
																							<button type="button" id="ownEmpNumBtn" class=" x-btn-text">검색</button>
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
														<label class="x-form-item-label" style="width: auto;" for="pjt_date_from" ><font color="red">* </font>프로젝트기간:</label>
														<div style="padding-left: 68px;" class="x-form-element">
															<table>
																<tr>
																	<td>
																		<input type="text" name="pjt_date_from" id="pjt_date_from" autocomplete="off" size="9" class=" x-form-text x-form-field" style="width: auto;" 
																		onFocus="restoreDateString(this, this.value)" onKeydown="_chkKeyPressNumPoint(this)" onblur="isValidDate(this, this.value)"/> 		
																	</td>
																	<td>&nbsp;&nbsp;~&nbsp;&nbsp;</td>
																	<td>
																		<input type="text" name="pjt_date_to" id="pjt_date_to" autocomplete="off" size="9" class=" x-form-text x-form-field" style="width: auto;"
																		onFocus="restoreDateString(this, this.value)" onKeydown="_chkKeyPressNumPoint(this)" onblur="isValidDate(this, this.value)"/>		
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
									<!-- 5_ROW End -->
 

									<!-- 6_ROW Start -->
									<div class="x-column-inner" style="width: 100%;">
										<div class=" x-panel x-column" style="width: 50%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label class="x-form-item-label" style="width: auto;" for=order_possble ><font color="red"> </font>수주가능성:</label>
														<div style="padding-left: 80px;" class="x-form-element">
															<input type="text" name="order_possble" id="order_possble" autocomplete="off" size="30" class=" x-form-text x-form-field" style="width: auto;">
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
														<label class="x-form-item-label" style="width: auto;" for="order_exp_date" >수주예정일:</label>
														<div style="padding-left: 90px;" class="x-form-element">
															<input type="text" name="order_exp_date" id="order_exp_date" autocomplete="off" size="30" class=" x-form-text x-form-field" style="width: auto;"
															onFocus="restoreDateString(this, this.value)" onKeydown="_chkKeyPressNumPoint(this)" onblur="isValidDate(this, this.value)"/>
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
										<div class=" x-panel x-column" style="width: 50%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label class="x-form-item-label" style="width: auto;" for=bid_dday ><font color="red"> </font>제안/입찰 마감일:</label>
														<div style="padding-left: 80px;" class="x-form-element">
															<input type="text" name="bid_dday" id="bid_dday" autocomplete="off" size="26" class=" x-form-text x-form-field" style="width: auto;" 
															onFocus="restoreDateString(this, this.value)" onKeydown="_chkKeyPressNumPoint(this)" onblur="isValidDate(this, this.value)"/>
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
														<label class="x-form-item-label" style="width: auto;" for="exp_sal_total_amt" >예상매출총액:</label>
														<div style="padding-left: 90px;" class="x-form-element">
															<input type="text" name="exp_sal_total_amt" id="exp_sal_total_amt" autocomplete="off" size="30" class=" x-form-text x-form-field" style="width: auto;" style="IME-MODE:disabled;text-align:right" onkeyPress="return _chkKeyPressNumOnly(this)" onBlur="_numFormat(this, Math.round(this.value));" onfocus="_removeComma(this, this.value)">
														</div>
														<div class="x-form-clear-left">
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>
									<!-- 7_ROW End -->
									
									<!-- 9_ROW Start -->
									<div class="x-column-inner" style="width: 100%;">
										<div class=" x-panel x-column" style="width: 100%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label class="x-form-item-label" style="width: auto;" for="pjt_summary" >개요 및<br/> 특이사항:</label>
														<div style="padding-left: 80px;" class="x-form-element">
															<textarea name="pjt_summary" id="pjt_summary" autocomplete="off" class=" x-form-text x-form-field" style="width:460; height:60px"></textarea>
														</div>
														<div class="x-form-clear-left">
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>
									<!-- 9_ROW End -->
									
									<!-- 10_ROW Start -->
									<div class="x-column-inner" style="width: 100%;">
										<div class=" x-panel x-column" style="width: 100%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label class="x-form-item-label" style="width: auto;" for="note" >비고:</label>
														<div style="padding-left: 80px;" class="x-form-element">
															<textarea name="note" id="note" autocomplete="off" class=" x-form-text x-form-field" style="width:460; height:60px"></textarea>
														</div>
														<div class="x-form-clear-left">
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>
									<!-- 10_ROW End -->
									
									<!-- 11_ROW Start -->
									<div class="x-column-inner" style="width: 100%;">
										<div class=" x-panel x-column" style="width: 50%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label class="x-form-item-label" style="width: auto;" for="proc_status_code" >진행상태:</label>
														<div style="padding-left: 80px;" class="x-form-element">
															<select name="proc_status_code" id="proc_status_code" title="진행상태코드" style="width: 175px;" type="text" class=" x-form-select x-form-field" 
															readonly="readonly" style='background-color:#f0f0f0' onFocus='this.initialSelect = this.selectedIndex;'onChange='this.selectedIndex = this.initialSelect;'>
																<option value="">선택하세요</option>
																<c:forEach items="${PJT_STATUS_CODE}" var="data" varStatus="status">
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
<%--														<label class="x-form-item-label" style="width: auto;" for="est_decision_yn" >확정여부:</label>--%>
<%--														<div style="padding-left: 80px;" class="x-form-element">--%>
<%--															<select name="est_decision_yn" id="est_decision_yn" title="확정여부" style="width: 58%;" type="text" class=" x-form-select x-form-field" >--%>
<%--																<option value="">선택하세요</option>--%>
<%--																<c:forEach items="${YESNO_CODE}" var="data" varStatus="status">--%>
<%--																	<option value="${data.COM_CODE}"><c:out value="${data.COM_CODE_NAME}"/></option>--%>
<%--																</c:forEach>--%>
<%--															</select>--%>
<%--														</div>--%>
<%--														<div class="x-form-clear-left">--%>
<%--														</div>--%>
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
														<div style="padding-left: 80px;" class="x-form-element">
															<input type="text" name="final_mod_id" id="final_mod_id" autocomplete="off" size="30" class=" x-form-text x-form-field" style="width: auto;">
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
															<input type="text" name="final_mod_date" id="final_mod_date" autocomplete="off" size="30" class=" x-form-text x-form-field" style="width: auto;">
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
		<tr>
			<!----------------- 거래처정보 GRID START ----------------->
			<td width="100%" valign="top" colspan="2">
				<div id="edit_grid_1st" style="margin-top: 0em;"></div>
			</td>
			<!----------------- 거래처정보 GRID END ----------------->
		</tr>
		<tr>
			<!----------------- 품목 정보 GRID START ----------------->
			<td width="100%" valign="top" colspan="2">
				<div id="edit_grid_2nd" style="margin-top: 0em;"></div>
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
						<td width="1">
						</td>
						<td>
						<%-- 수정 버튼 Start  
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
						 수정 버튼 End --%>
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
</body>

<%@ include file="/WEB-INF/web/jsp/sgis-bottom-inc.jsp" %>