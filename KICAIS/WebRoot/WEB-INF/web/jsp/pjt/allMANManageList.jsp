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
var	gridHeigth_1st 	 	= 263; 								// 그리드 전체 높이
var	gridWidth_1st		= 400;								// 그리드 전체 폭
var gridTitle_1st 		= "유지보수 목록"; 					// 그리드 제목
var	render_1st			= "man_grid";						// 렌더(화면에 그려질) 할 id 
var	pageSize_1st		= 15;	  							// 그리드 페이지 사이즈	
var	proxyUrl_1st		= "/man/management/result_1st.sg";  // 결과 값 페이지
var limit_1st			= pageSize_1st;
var start_1st			= 0;
var re_MAN_ID			="";

// 그리드의 페이지 클릭시 검색조건값을 DB로 전송
function fnPagingValue_1st(){
	
	try{
		GridClass_1st.store.setBaseParam('start'		 	  			,start_1st);
	    GridClass_1st.store.setBaseParam('limit'		 	  			,limit_1st);	     
		GridClass_1st.store.setBaseParam('man_id'                	    ,Ext.get('man_id').getValue());
		
		GridClass_1st.store.setBaseParam('src_pjt_id'                	    ,'<%=request.getParameter("src_pjt_id")%>');
		GridClass_1st.store.setBaseParam('src_pjt_name'                	    ,'<%=request.getParameter("src_pjt_name")%>');
	}catch(e){

	}
}
 
		
// Grid의 컬럼 설정
var userColumns_1st =  [ 	  	 
								 {header: '상태'               	,width: 60  ,sortable: true ,dataIndex:'FLAG'               ,hidden : true}         
								,{header: "유지보수ID"           	,width: 120  ,sortable: true ,dataIndex:"MAN_ID"             ,hidden : false}
								
								,{header: "프로젝트ID"           	,width: 60  ,sortable: true ,dataIndex:"PJT_ID"             ,hidden : true}
								,{header: "프로젝트"           	,width: 120 ,sortable: true ,dataIndex:"PJT_NAME"           ,hidden : false}
								
								,{header: "매출ID"            	,width: 60  ,sortable: true ,dataIndex:"SAL_ID"             ,hidden : true}
								,{header: "매출"            		,width: 100 ,sortable: true ,dataIndex:"SAL_NAME"           ,hidden : true}
								
								,{header: "유지보수등록부서코드" 	,width: 60  ,sortable: true ,dataIndex:"SAL_DEPT_CODE"      ,hidden : true}
								,{header: "등록자부서" 			,width: 70  ,sortable: true ,dataIndex:"SAL_DEPT_NAME"      ,hidden : true}
								
								,{header: "유지보수등록사원번호" 	,width: 60  ,sortable: true ,dataIndex:"SAL_EMP_NUM"        ,hidden : true}
								,{header: "등록자" 				,width: 70  ,sortable: true ,dataIndex:"SAL_EMP_NAME"       ,hidden : true}
								
								,{header: "거래처코드"           	,width: 60  ,sortable: true ,dataIndex:"CUSTOM_CODE"        ,hidden : true}
								,{header: "거래처"           		,width: 75  ,sortable: true ,dataIndex:"CUSTOM_NAME"        ,hidden : false}
								
								,{header: "거래처담당자번호"     	,width: 60  ,sortable: true ,dataIndex:"COSTOMER_NUM"       ,hidden : true}
								,{header: "거래처담당자"     		,width: 75  ,sortable: true ,dataIndex:"COSTOMER_NAME"      ,hidden : false}
								
								,{header: "유무상구분코드"       	,width: 60  ,sortable: true ,dataIndex:"PAY_FREE_TYPE_CODE" ,hidden : true}
								,{header: "유무상구분"       		,width: 60  ,sortable: true ,dataIndex:"PAY_FREE_TYPE_NAME" ,hidden : true}
								
								,{header: "유지보수기간_From"    	,width: 60  ,sortable: true ,dataIndex:"MAINTENANCE_FROM"   ,hidden : true}
								,{header: "유지보수기간_To"      	,width: 60  ,sortable: true ,dataIndex:"MAINTENANCE_TO"     ,hidden : true}
								
								,{header: "유지보수금액"         	,width: 60  ,sortable: true ,dataIndex:"MAINTENANCE_AMT"    ,hidden : true}
								,{header: "유지보수세액"         	,width: 60  ,sortable: true ,dataIndex:"MAINTENANCE_TAX"    ,hidden : true}
								
								,{header: "진행상태코드"         	,width: 80 ,sortable: true ,dataIndex:"PROC_STATUS_CODE"   ,hidden : true}
								,{header: "진행상태"         		,width: 80  ,sortable: true ,dataIndex:"PROC_STATUS_NAME"   ,hidden : true}
								
								,{header: "비고"                 ,width: 60  ,sortable: true ,dataIndex:"NOTE"               ,hidden : true}
								
								,{header: "최종변경자ID"         	,width: 60  ,sortable: true ,dataIndex:"FINAL_MOD_ID"       ,hidden : true}
								,{header: "최종변경일시"         	,width: 60  ,sortable: true ,dataIndex:"FINAL_MOD_DATE"     ,hidden : true}
								,{header: "최초등록일"           	,width: 60  ,sortable: true ,dataIndex:"REG_DATE"           ,hidden : true}
								,{header: "최초등록자"           	,width: 60  ,sortable: true ,dataIndex:"REG_ID"             ,hidden : true}
					   ];	 

// 그리드 결과매핑 
var mappingColumns_1st = [   {name: 'FLAG'		 	  	  , allowBlank: false}
							,{name: "MAN_ID"              , allowBlank: false}
							
							,{name: "PJT_ID"              , allowBlank: false}
							,{name: "PJT_NAME"            , allowBlank: false}
							
							,{name: "SAL_ID"              , allowBlank: false}
							,{name: "SAL_NAME"            , allowBlank: false}
							
							,{name: "SAL_DEPT_CODE"       , allowBlank: false}
							,{name: "SAL_DEPT_NAME"       , allowBlank: false}
							
							,{name: "SAL_EMP_NUM"         , allowBlank: false}
							,{name: "SAL_EMP_NAME"        , allowBlank: false}
							
							,{name: "CUSTOM_CODE"         , allowBlank: false}
							,{name: "CUSTOM_NAME"         , allowBlank: false}
							
							,{name: "COSTOMER_NUM"        , allowBlank: false}
							,{name: "COSTOMER_NAME"       , allowBlank: false}
							
							,{name: "PAY_FREE_TYPE_CODE"  , allowBlank: false}
							,{name: "PAY_FREE_TYPE_NAME"  , allowBlank: false}
							
							,{name: "MAINTENANCE_FROM"    , allowBlank: false}
							,{name: "MAINTENANCE_TO"      , allowBlank: false}
							,{name: "MAINTENANCE_AMT"     , allowBlank: false}
							,{name: "MAINTENANCE_TAX"     , allowBlank: false}
							
							,{name: "PROC_STATUS_CODE"    , allowBlank: false}
							,{name: "PROC_STATUS_NAME"    , allowBlank: false}
							
							,{name: "NOTE"                , allowBlank: false}
							
							,{name: "FINAL_MOD_ID"        , allowBlank: false}
							,{name: "FINAL_MOD_DATE"      , allowBlank: false}
							,{name: "REG_DATE"            , allowBlank: false}
							,{name: "REG_ID"              , allowBlank: false}
    				 	 ];
 
/***************************************************************************
 * 프로젝트정보 --- 그리드 클릭시 Event
 ***************************************************************************/
function fnGridOnClick_1st(store, rowIndex){
	
	fnInitValue();
	
	Ext.get("flag"		 	  	  ).set({value : fnFixNull(store.getAt(rowIndex).data.FLAG		 	  	)}, false);
	Ext.get("man_id"              ).set({value : fnFixNull(store.getAt(rowIndex).data.MAN_ID            )}, false);
	
	Ext.get("pjt_id"              ).set({value : fnFixNull(store.getAt(rowIndex).data.PJT_ID            )}, false);
	Ext.get("pjt_name"            ).set({value : fnFixNull(store.getAt(rowIndex).data.PJT_NAME          )}, false);
	
	//Ext.get("sal_id"              ).set({value : fnFixNull(store.getAt(rowIndex).data.SAL_ID            )}, false);
	//Ext.get("sal_name"            ).set({value : fnFixNull(store.getAt(rowIndex).data.SAL_NAME          )}, false);
	
	Ext.get("sal_dept_code"       ).set({value : fnFixNull(store.getAt(rowIndex).data.SAL_DEPT_CODE     )}, false);
	Ext.get("sal_dept_name"       ).set({value : fnFixNull(store.getAt(rowIndex).data.SAL_DEPT_NAME     )}, false);
	Ext.get("sal_emp_num"         ).set({value : fnFixNull(store.getAt(rowIndex).data.SAL_EMP_NUM       )}, false);
	Ext.get("sal_emp_name"        ).set({value : fnFixNull(store.getAt(rowIndex).data.SAL_EMP_NAME      )}, false);
	
	Ext.get("custom_code"         ).set({value : fnFixNull(store.getAt(rowIndex).data.CUSTOM_CODE       )}, false);
	Ext.get("custom_name"         ).set({value : fnFixNull(store.getAt(rowIndex).data.CUSTOM_NAME       )}, false);
	Ext.get("costomer_num"        ).set({value : fnFixNull(store.getAt(rowIndex).data.COSTOMER_NUM      )}, false);
	Ext.get("costomer_name"       ).set({value : fnFixNull(store.getAt(rowIndex).data.COSTOMER_NAME     )}, false);
	
	Ext.get("pay_free_type_code"  ).set({value : fnFixNull(store.getAt(rowIndex).data.PAY_FREE_TYPE_CODE)}, false); 
	
	Ext.get("maintenance_from"    ).set({value : fnFixNull(store.getAt(rowIndex).data.MAINTENANCE_FROM  )}, false);
	Ext.get("maintenance_to"      ).set({value : fnFixNull(store.getAt(rowIndex).data.MAINTENANCE_TO    )}, false);
	
	Ext.get("maintenance_amt"     ).set({value : fnFixNull(MoneyComma(store.getAt(rowIndex).data.MAINTENANCE_AMT  ))}, false); 
	
	Ext.get("proc_status_code"    ).set({value : fnFixNull(store.getAt(rowIndex).data.PROC_STATUS_CODE  )}, false); 
	
	Ext.get("note"                ).set({value : fnFixNull(store.getAt(rowIndex).data.NOTE              )}, false);
	
	Ext.get("final_mod_id"        ).set({value : fnFixNull(store.getAt(rowIndex).data.FINAL_MOD_ID      )}, false);
	Ext.get("final_mod_date"      ).set({value : fnFixNull(store.getAt(rowIndex).data.FINAL_MOD_DATE    )}, false);
	
 
	
	// 버튼 disable
	Ext.get('saveBtn').dom.disabled   = true;
	Ext.get('updateBtn').dom.disabled = false;
			 
	var keyValue1 = fnFixNull(store.getAt(rowIndex).data.MAN_ID);			 
	
	fnSearchEdit1st(keyValue1,'', '');
	fnSearchEdit2nd(keyValue1,'', '');	
}   

function fnSearchEdit1st(keyValue1,keyValue2,value3){
	
	Ext.Ajax.request({
		url: "/man/management/result_edit_1st.sg" 
		,success: function(response){
					GridClass_edit_1st.store.commitChanges();
					GridClass_edit_1st.store.removeAll();
						
					var json = Ext.util.JSON.decode(response.responseText);
					GridClass_edit_1st.store.loadData(json);
					
					if(value3 != '' && value3 != 'undefined'){
		
						var rowCnt1st = GridClass_edit_1st.store.getCount();
						
						for(i = 0 ; i < rowCnt1st ; i++){
							var record1 = GridClass_edit_1st.store.getAt(i);
							record1.set('FLAG', 'I');
							record1.set('MAN_ID', value3);						
						}
					}
		          }
		,failure: handleFailure 
		,params : {
					 limit			: limit_edit_1st
				   , start			: start_edit_1st
				   , man_id			: keyValue1
				  }				
	});   
}

function fnSearchEdit2nd(keyValue1,keyValue2,value3){
	
	Ext.Ajax.request({
		url: "/man/management/result_edit_2nd.sg" 
		,success: function(response){		 
					GridClass_edit_2nd.store.commitChanges();
					GridClass_edit_2nd.store.removeAll();
					
					var json = Ext.util.JSON.decode(response.responseText);
					GridClass_edit_2nd.store.loadData(json);
			
					if(value3 != '' && value3 != 'undefined'){
						
						var rowCnt2nd = GridClass_edit_1st.store.getCount();
					
						for(j = 0 ; j < rowCnt2nd ; j++){
							var record2 = GridClass_edit_2nd.store.getAt(j);
							record2.set('FLAG', 'I');
							record2.set('MAN_ID', value3);						
						}
					}
		          }
		,failure: handleFailure 
		,params : {
				     limit			: limit_edit_2nd
				   , start			: start_edit_2nd
				  
				   , man_id			: keyValue1
				  }				
	});
}

/***************************************************************************
 * 설  명 : 프로젝트 설정 
***************************************************************************/
var	gridHeigth_edit_1st	= 150;
var	gridWidth_edit_1st  = 1000	;
var	gridTitle_edit_1st  = "유지보수 관련 프로젝트정보"	; 
var	render_edit_1st		= "edit_grid_1st";
var keyNm_edit_1st		= "MAN_INFO_SEQ";
var pageSize_edit_1st	= 4;
var limit_edit_1st		= pageSize_edit_1st;
var start_edit_1st		= 0;
var proxyUrl_edit_1st	= "/man/management/result_edit_1st.sg"; 
var gridRowDeleteYn	    = "";
var tbarHidden_edit_1st = "";

// 행추가
function addNew_edit_1st(){
			
	var Plant = GridClass_edit_1st.grid.getStore().recordType; 
    var p = new Plant({ 
	        		     FLAG					: 'I' 
	        		  	,MAN_ID		    		: Ext.get('man_id').getValue()
	        		  	,PJT_ID					: ''
	        		  	,FINAL_MOD_ID	: '${admin_nm}'
						,FINAL_MOD_DATE	: getTimeStamp().trim()
    				  }); 
    
    if(document.detailForm.man_id.value!=""){
	  	GridClass_edit_1st.grid.stopEditing();
		GridClass_edit_1st.store.insert(0, p);
		GridClass_edit_1st.grid.startEditing(0, 0);
	}else{
		Ext.Msg.alert('확인', '유지보수를 먼저 선택 해 주세요'); 
	}
}

// 페이징
function fnPagingValue_edit_1st(){	
	try{
		GridClass_edit_1st.store.setBaseParam('start'		,start_edit_1st);
	    GridClass_edit_1st.store.setBaseParam('limit'		,limit_edit_1st);
	    GridClass_edit_1st.store.setBaseParam('man_id'		,Ext.get('man_id').getValue());
	}catch(e){

	}
} 
 
// 그리드 필드
var	userColumns_edit_1st	= [  
								 {header: "flag"       	,	width: 10,	sortable: true,	dataIndex: "FLAG"     		  ,editor: new Ext.form.TextField({ allowBlank : false }), hidden:true, editable:false}
								,{header: "순번"		   	,	width: 10,	sortable: true,	dataIndex: "MAN_INFO_SEQ"     ,editor: new Ext.form.TextField({ allowBlank : false }), hidden:true, editable:false}
								,{header: "유지보수ID"  	,	width: 100,	sortable: true,	dataIndex: "MAN_ID"           ,editor: new Ext.form.TextField({ allowBlank : false }), hidden:false}
								
								,{header: "* 프로젝트ID" 	,	width: 100,	sortable: true,	dataIndex: "PJT_ID"           ,editor: new Ext.form.TextField({ allowBlank : false }), hidden:false, editable:false , renderer:changeBLUE}
								,{header: "* 프로젝트"  	,	width: 100,	sortable: true,	dataIndex: "PJT_NAME"         ,editor: new Ext.form.TextField({ allowBlank : false }), hidden:false, editable:false , renderer:changeBLUE}
								
								,{header: "최종변경자ID"	,	width: 70,	sortable: true,	dataIndex: "FINAL_MOD_ID"     ,editor: new Ext.form.TextField({ allowBlank : false }), hidden:false, editable:false}
								,{header: "최종변경일시"	,	width: 70,	sortable: true,	dataIndex: "FINAL_MOD_DATE"   ,editor: new Ext.form.TextField({ allowBlank : false }), hidden:false, editable:false}
								,{header: "최초등록일"  	,	width: 70,	sortable: true,	dataIndex: "REG_DATE"         ,editor: new Ext.form.TextField({ allowBlank : false }), hidden:true, editable:false}
								,{header: "최초등록자"  	,	width: 70,	sortable: true,	dataIndex: "REG_ID"           ,editor: new Ext.form.TextField({ allowBlank : false }), hidden:true, editable:false}
								
							  ];

// 맵핑 필드
var	mappingColumns_edit_1st	= [  
							     {name: "FLAG"       	 , type:"string", mapping: "FLAG" 		   }
							    ,{name: "MAN_INFO_SEQ"   , type:"string", mapping: "MAN_INFO_SEQ"  }
								,{name: "MAN_ID"         , type:"string", mapping: "MAN_ID"        }
								,{name: "PJT_ID"         , type:"string", mapping: "PJT_ID"        }
								,{name: "PJT_NAME"       , type:"string", mapping: "PJT_NAME"      }
								
								,{name: "FINAL_MOD_ID"   , type:"string", mapping: "FINAL_MOD_ID"  }
								,{name: "FINAL_MOD_DATE" , type:"string", mapping: "FINAL_MOD_DATE"}
								,{name: "REG_DATE"       , type:"string", mapping: "REG_DATE"      }
								,{name: "REG_ID"         , type:"string", mapping: "REG_ID"        }
	    				 	  ]; 
 



/***************************************************************************
 * 설  명 : 편집그리드 설정 (품목정보)
***************************************************************************/
var	gridHeigth_edit_2nd	= 150;
var	gridWidth_edit_2nd  = 1000	;
var	gridTitle_edit_2nd  = "유지보수 품목정보"; 
var	render_edit_2nd		= "edit_grid_2nd";
var keyNm_edit_2nd		= "MAN_INFO_SEQ";
var pageSize_edit_2nd	= 4;
var limit_edit_2nd		= pageSize_edit_2nd;
var start_edit_2nd		= 0;
var proxyUrl_edit_2nd	= "/man/management/result_edit_2nd.sg"; 
var grid2ndRowDeleteYn  = ""; 
var tbarHidden_edit_2nd = "";
 
var PAY_FREE_CODE_COMBO = new Ext.form.ComboBox({    
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
 
Ext.util.Format.comboRenderer = function(PAY_FREE_CODE_COMBO){    
	return function(value){        
	var record = PAY_FREE_CODE_COMBO.findRecord(PAY_FREE_CODE_COMBO.valueField, value);        
	return record ? record.get(PAY_FREE_CODE_COMBO.displayField) : PAY_FREE_CODE_COMBO.valueNotFoundText;    
}}


function addNew_edit_2nd(){
	var Plant = GridClass_edit_2nd.grid.getStore().recordType; 
    var p = new Plant({ 
	        		     FLAG				: 'I' 					  
						,MAN_ID				:Ext.get('man_id').getValue()	
						,ITEM_CODE          :''
						,STANDARD           :''
						,UNIT               :''
						,CNT                :'0'
						,UNIT_PRICE         :'0'
						,AMT                :'0'
						,DISCOUNT_RATIO     :'0'
						
						,PAY_FREE_CODE      :'Y'
						
						,APLY_UNIT_PRICE    :''
						,APLY_AMT           :''
						,APLY_TAX           :''
						,NOTE               :''
						
						,FINAL_MOD_ID		: '${admin_nm}'
						,FINAL_MOD_DATE		: getTimeStamp().trim()
						
    				  }); 
    if(document.detailForm.man_id.value!=""){
	  	GridClass_edit_2nd.grid.stopEditing();
		GridClass_edit_2nd.store.insert(0, p);
		GridClass_edit_2nd.grid.startEditing(0, 0);
	}else{
		Ext.Msg.alert('확인', '유지보수를 먼저 선택 해 주세요'); 
	}    
    
}

// 페이징
function fnPagingValue_edit_2nd(){	
	try{
		GridClass_edit_2nd.store.setBaseParam('start'		,start_edit_2nd);
	    GridClass_edit_2nd.store.setBaseParam('limit'		,limit_edit_2nd);
	    GridClass_edit_2nd.store.setBaseParam('man_id'		,Ext.get('pjt_id').getValue());
	}catch(e){

	}
}


// 그리드 필드 
var	userColumns_edit_2nd	= [  
								 {header: "flag"       	,	width: 10,	sortable: true,	dataIndex: "FLAG"     		  ,editor: new Ext.form.TextField({ allowBlank : false }), hidden:true, editable:false}							
								,{header:"순번"         	,	width: 10,	sortable: true,	dataIndex: "MAN_INFO_SEQ"      ,editor: new Ext.form.TextField({ allowBlank : false }), hidden:true, editable:false}
								,{header:"유지보수ID"   	,	width: 100,	sortable: true,	dataIndex: "MAN_ID"            ,editor: new Ext.form.TextField({ allowBlank : false }), hidden:false, editable:false}
								
								,{header:"품목코드"     	,	width: 100,	sortable: true,	dataIndex: "ITEM_CODE"         ,editor: new Ext.form.TextField({ allowBlank : false }), hidden:true, editable:false , renderer:changeBLUE}
								,{header:"* 품목"   	  	,	width: 150,	sortable: true,	dataIndex: "ITEM_NAME"         ,editor: new Ext.form.TextField({ allowBlank : false }), hidden:false, editable:false , renderer:changeBLUE}
								
								,{header:"규격"         	,	width: 70,	sortable: true,	dataIndex: "STANDARD"          ,editor: new Ext.form.TextField({ allowBlank : false }), hidden:false}
								,{header:"단위"         	,	width: 70,	sortable: true,	dataIndex: "UNIT"              ,editor: new Ext.form.TextField({ allowBlank : false }), hidden:false}
								,{header:"* 수량"        ,	width: 70,	sortable: true,	dataIndex: "CNT"               ,editor: new Ext.form.TextField({ allowBlank : false }), hidden:false}
								,{header:"단가"         	,	width: 70,	sortable: true,	dataIndex: "UNIT_PRICE"        ,editor: new Ext.form.TextField({ allowBlank : false }), hidden:false, editable:false , renderer:"korMoney"}
								,{header:"금액"         	,	width: 70,	sortable: true,	dataIndex: "AMT"               ,editor: new Ext.form.TextField({ allowBlank : false }), hidden:false, renderer:"korMoney" }
								,{header:"* 할인율%"   	,	width: 80,	sortable: true,	dataIndex: "DISCOUNT_RATIO"    ,editor: new Ext.form.TextField({ allowBlank : false }), hidden:false}
								
								,{header:"* 유무상"   	,	width: 70,	sortable: true,	dataIndex: "PAY_FREE_CODE"     ,editor: PAY_FREE_CODE_COMBO  ,renderer: Ext.util.Format.comboRenderer(PAY_FREE_CODE_COMBO)}
								,{header:"유무상분"   	,	width: 10,	sortable: true,	dataIndex: "PAY_FREE_NAME"     ,editor: new Ext.form.TextField({ allowBlank : false }), hidden:true, editable:false}
								
								,{header:"적용단가"     	,	width: 70,	sortable: true,	dataIndex: "APLY_UNIT_PRICE"   ,editor: new Ext.form.TextField({ allowBlank : false }), hidden:false, editable:false , renderer: korMoneyChangeRED, align:'right'}
								,{header:"적용금액"     	,	width: 70,	sortable: true,	dataIndex: "APLY_AMT"          ,editor: new Ext.form.TextField({ allowBlank : false }), hidden:false, editable:false , renderer: korMoneyChangeRED, align:'right'}
								,{header:"적용세액"     	,	width: 70,	sortable: true,	dataIndex: "APLY_TAX"          ,editor: new Ext.form.TextField({ allowBlank : false }), hidden:false, editable:false , renderer: korMoneyChangeRED, align:'right'}
								
								,{header:"비고"         	,	width: 250,	sortable: true,	dataIndex: "NOTE"              ,editor: new Ext.form.TextField({ allowBlank : false }), hidden:false}
								
								,{header:"최종변경자" 	,	width: 50,	sortable: true,	dataIndex: "FINAL_MOD_ID"      ,editor: new Ext.form.TextField({ allowBlank : false }), hidden:true, editable:false}
								,{header:"최종변경일" 	,	width: 50,	sortable: true,	dataIndex: "FINAL_MOD_DATE"    ,editor: new Ext.form.TextField({ allowBlank : false }), hidden:true, editable:false}
								,{header:"최초등록일"   	,	width: 10,	sortable: true,	dataIndex: "REG_DATE"          ,editor: new Ext.form.TextField({ allowBlank : false }), hidden:true, editable:false}
								,{header:"최초등록자"   	,	width: 10,	sortable: true,	dataIndex: "REG_ID"            ,editor: new Ext.form.TextField({ allowBlank : false }), hidden:true, editable:false}
							  ];

// 맵핑 필드
var	mappingColumns_edit_2nd	= [ 	 
								 {name: "FLAG"       	 	 ,  type:"string", mapping: "FLAG" 		   		 }
							    ,{name: "MAN_INFO_SEQ"   	 , 	type:"string", mapping: "MAN_INFO_SEQ"   	 }
								,{name: "MAN_ID"         	 , 	type:"string", mapping: "MAN_ID"         	 }
								,{name: "ITEM_CODE"      	 , 	type:"string", mapping: "ITEM_CODE"      	 }
								,{name: "ITEM_NAME"      	 , 	type:"string", mapping: "ITEM_NAME"      	 }
								,{name: "STANDARD"       	 , 	type:"string", mapping: "STANDARD"       	 }
								,{name: "UNIT"           	 , 	type:"string", mapping: "UNIT"           	 }
								,{name: "CNT"            	 , 	type:"string", mapping: "CNT"            	 }
								,{name: "UNIT_PRICE"     	 , 	type:"string", mapping: "UNIT_PRICE"     	 }
								,{name: "AMT"            	 , 	type:"string", mapping: "AMT"            	 }
								,{name: "DISCOUNT_RATIO" 	 , 	type:"int"	, mapping: "DISCOUNT_RATIO" 	 }
								,{name: "PAY_FREE_CODE"  	 , 	type:"string", mapping: "PAY_FREE_CODE"  	 }
								,{name: "PAY_FREE_NAME"  	 , 	type:"string", mapping: "PAY_FREE_NAME"  	 }
								,{name: "APLY_UNIT_PRICE"	 , 	type:"string", mapping: "APLY_UNIT_PRICE"	 }
								,{name: "APLY_AMT"       	 , 	type:"string", mapping: "APLY_AMT"       	 }
								,{name: "APLY_TAX"       	 , 	type:"string", mapping: "APLY_TAX"       	 }
								,{name: "NOTE"           	 , 	type:"string", mapping: "NOTE"           	 }
								,{name: "FINAL_MOD_ID"   	 , 	type:"string", mapping: "FINAL_MOD_ID"   	 }
								,{name: "FINAL_MOD_DATE" 	 , 	type:"string", mapping: "FINAL_MOD_DATE" 	 }
								,{name: "REG_DATE"       	 , 	type:"string", mapping: "REG_DATE"       	 }
								,{name: "REG_ID"         	 , 	type:"string", mapping: "REG_ID"         	 }

	    				 	  ]; 

/***************************************************************************
 * 설  명 : 필드 초기화
 **************************************************************************/
function fnInitValue(obj){
   
	
	var dForm = document.detailForm;		// 상세 FORM	
	dForm.reset();							// 상세필드 초기화
	 
	
	dForm.sal_emp_num.value 	= "${sabun}";
	dForm.sal_emp_name.value 	= "${admin_nm}";
	
	dForm.sal_dept_code.value 	= "${dept_code}";
	dForm.sal_dept_name.value 	= "${dept_nm}";
	
	dForm.man_id.value			= "${new_man_id}";
	
	dForm.final_mod_id.value 	= "${admin_nm}";
	dForm.final_mod_date.value	= getTimeStamp().trim();
	
	dForm.proc_status_code.value 	= "10";
	
	if(dForm.man_id.value == "" && obj==null){
		dForm.man_id.value="${new_man_id}";
	}else if(dForm.man_id.value == "" && obj=='newManID'){
		dForm.man_id.value = re_MAN_ID;
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
 				
	var records = GridClass_edit_1st.store.getModifiedRecords();	
    var edit1stJson = "[";
	    for (var i = 0; i < records.length; i++) {
	    	
	    	if(records[i].data.PJT_ID == ""){
	    		SGAlert("[관련 프로젝트]", [i+1]+"번째 행의 [프로젝트]를 선택 입력 해 주세요");
	    		return false;
	    	}
	    	
	      edit1stJson += Ext.util.JSON.encode(records[i].data);				
	      if (i < (records.length-1)) {
	        edit1stJson += ",";
	      }
	    }
    	edit1stJson += "]"
    
	var record2 = GridClass_edit_2nd.store.getModifiedRecords();	
    var edit2ndJson = "[";
	    for (var i = 0; i < record2.length; i++) {
	    	
	       if(record2[i].data.ITEM_CODE == ""){
	    		SGAlert("[품목정보]", [i+1]+"번째 행의 [품목]을 선택 입력 해 주세요");
	    		return false;
	    	}
	        if(record2[i].data.DISCOUNT_RATE == ""){
	    		SGAlert("[품목정보]", [i+1]+"번째 행의 [할인율]을 입력 해 주세요");
	    		return false;
	    	} 
	        if(record2[i].data.PAY_FREE_CODE == ""){
	    		SGAlert("[품목정보]", [i+1]+"번째 행의 [유무상구분 코드]를 선택 해 주세요");
	    		return false;
	    	} 
	    	
	    	
	      edit2ndJson += Ext.util.JSON.encode(record2[i].data);				
	      if (i < (record2.length-1)) {
	        edit2ndJson += ",";
	      }
	    }
    	edit2ndJson += "]"
 	
	Ext.Ajax.request({   
		url: "/man/management/actionManagement.sg?ManType=base"
		,success: function(response){	
					handleSuccess(response,GridClass_1st,'save');
					var json = Ext.util.JSON.decode(response.responseText);
					document.detailForm.man_id.value=json.new_man_id;
					re_MAN_ID = json.new_man_id;
		          } 
		,failure: handleFailure  
		,form   : document.detailForm	
		,params : {
					limit          		: limit_1st
			  	  , start          		: start_1st
			  	  , man_id        	    : Ext.get('man_id').getValue()
			  	  
			  	  , edit1stData		    : edit1stJson
  				  , edit2ndData         : edit2ndJson 
			  	  
			  	  , src_pjt_id   	   : '<%=request.getParameter("src_pjt_id")%>'		  // 프로젝트ID   
			  	  , src_pjt_name   	   : '<%=request.getParameter("src_pjt_name")%>'	  // 프로젝트명
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
   	
   //프로젝트 
	Ext.get('pjtBtn').on('click', function(e){ 
		var param = '?fieldName=pjt_id&src_pjt_type_code=10';
		fnPjtPop(param)
	}); 
   	
   //거래처 담당자
   	Ext.get('customBtn').on('click', function(e){
		var param = '?fieldCode=custom_code&fieldName=custom_name';
		param = param + '&form=detailForm';
		fnCostomerPop(param)
	});
   
   	// 담당자검색 버튼 
	Ext.get('regEmpNumBtn').on('click', function(e){
		var param = '';
		fnEmployeePop(param)
	}); 
   
			
   	//신규 버튼 -> 상세필드 초기화
	Ext.get('detailClearBtn').on('click', function(e){
		fnInitValue('newManID');		   
	});		
   	
  //저장 버튼 -> 데이터를 server로 전송
	Ext.get('saveBtn').on('click', function(e){	 

	   if(Ext.get('pay_free_type_code').getValue() == ""){
        	 SGAlert("확인", "유/무상구분코드를 선택해 주세요");
        	 return false;
      }
	   if(Ext.get('custom_code').getValue() == ""){
        	 SGAlert("확인", "버튼을 클릭하여 담당자를 선택 입력 해 주세요");
        	 return false;
       }
        if(Ext.get('maintenance_from').getValue() == ""){
        	 SGAlert("확인", "버튼을 클릭하여  시작일을 선택 입력 해 주세요");
        	 return false;
       }
        if(Ext.get('maintenance_to').getValue() == ""){
        	 SGAlert("확인", "버튼을 클릭하여 종료일을 선택 입력 해 주세요");
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
	var maintenance_from = new Ext.form.DateField({
    	applyTo: 'maintenance_from',
		allowBlank: false,
		format:'Y-m-d',
		editable : false
	});
	
	var maintenance_to = new Ext.form.DateField({
    	applyTo: 'maintenance_to',
		allowBlank: false,
		format:'Y-m-d',
		editable : false
	});
	*/
	
	Ext.get('final_mod_id').dom.disabled    = true;
	Ext.get('final_mod_date').dom.disabled  = true;
	
	Ext.get('man_id').dom.disabled  = true;
	      
	fnInitValue();
}); 

 
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
	var sURL      = "/pjt/pjtManage/pjtInfoPop.sg"+param;
	var dlgWidth  = 399;
	var dlgHeight = 444;
	var winName   = "project";
	fnOpenPop(sURL, dlgWidth, dlgHeight, winName);
}

function fnPjtPopValue(records, fieldName){ 
    
   	if(fieldName=="pjt_id"){
   		var record = records[0].data;
   		
    	Ext.get('pjt_id').set({value:fnFixNull(record.PJT_ID)} , false);
   		Ext.get('pjt_name').set({value:fnFixNull(record.PJT_NAME)} , false);
   	}else{
   		var record = GridClass_edit_1st.grid.selModel.getSelected(); 

		var pjt_id = records[0].data.PJT_ID;
		var pjt_name = records[0].data.PJT_NAME;
	
		record.set('PJT_ID', pjt_id);
		record.set('PJT_NAME', pjt_name); 
	}
}
 
  
// 담당자, 등록자 검색팝업 ****************************************
function fnEmployeePop(param){
	var sURL      = "/com/employee/employeePop.sg"+param;
	var dlgWidth  = 399;
	var dlgHeight = 396;
	var winName   = "등록자";
	fnOpenPop(sURL, dlgWidth, dlgHeight, winName);
}
 
  
// 등록자 검색 결과 return Value
function fnEmployeePopValue(records, obj){
	var record = records[0].data 
	Ext.get('sal_emp_num').set({value:fnFixNull(record.EMP_NUM)} , false);
    Ext.get('sal_emp_name').set({value:fnFixNull(record.KOR_NAME)} , false);
    Ext.get('sal_dept_code').set({value:fnFixNull(record.DEPT_CODE)} , false);
    Ext.get('sal_dept_name').set({value:fnFixNull(record.DEPT_NAME)} , false);	 
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
	var record = records[0].data;
 	
	Ext.get('costomer_num').set({value:fnFixNull(record.CUSTOMER_NUM)} , false);
    Ext.get('costomer_name').set({value:fnFixNull(record.CUSTOMER_NAME)} , false);
    Ext.get('custom_code').set({value:fnFixNull(record.CUSTOM_CODE)} , false);
    Ext.get('custom_name').set({value:fnFixNull(record.CUSTOM_NAME)} , false);	 	 
	 
}

/***************************************************************************
 * 설  명 : 에디트 그리드의 CELL을 클릭하였을 경우 이벤트
 ***************************************************************************/
function  fnEdit1stCellClickEvent(grid, rowIndex, columnIndex, e){	
	if(columnIndex == '3' || columnIndex == '4'){
	 	param = "?fieldName=edit1_pjt_id&src_pjt_type_code=10";
		fnPjtPop(param);
	}
} 


	
function fnEdit2ndCellClickEvent(grid, rowIndex, columnIndex, e){
	//품목 코드 팝업
	if(columnIndex == '4'){
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
	var standard   = records[0].data.STANDARD;
	var unit	   = records[0].data.UNIT;
	
	record.set('ITEM_CODE', item_code);
	record.set('ITEM_NAME', item_name);
	record.set('UNIT_PRICE', unit_price);
	record.set('STANDARD', standard);
	record.set('UNIT', unit);
	 
	var rowAMT = parseInt(record.data.CNT) * parseInt(record.data.UNIT_PRICE); 
	var aplyTaxAMT = rowAMT * 0.1; 
	record.set('AMT', parseInt(rowAMT));
	record.set('TAX', aplyTaxAMT);
	
}


/***************************************************************************
 * 설  명 : 에디트 그리드의 CELL을 수정하였을 경우 이벤트
 ***************************************************************************/
function  fnEdit2ndAfterCellEdit(obj){
	
	var fieldName = obj.field;
	var editedRow = obj.row;
	var record = GridClass_edit_2nd.grid.selModel.getSelected();
	
	if( fieldName == 'CNT' ||  fieldName == 'DISCOUNT_RATIO'){
		var rowAMT = parseInt(record.data.CNT) * parseInt(record.data.UNIT_PRICE);
		var aplyTaxAMT = rowAMT * 0.1;
		record.set('AMT', parseInt(rowAMT)-parseInt(aplyTaxAMT));
		record.set('TAX', aplyTaxAMT); 
		
		var applyAmt = parseInt(record.data.UNIT_PRICE) - ((parseInt(record.data.DISCOUNT_RATIO)/100) * parseInt(record.data.UNIT_PRICE));
		var applyAmtTot = parseInt(record.data.CNT) * applyAmt;
		var applyAmtTax =applyAmtTot * 0.1;
		 
		record.set('APLY_UNIT_PRICE', applyAmt);
		record.set('APLY_AMT'       , parseInt(applyAmtTot)-parseInt(applyAmtTax));
		record.set('APLY_TAX'       , applyAmtTax);
	}
	
	 
	
	
} 
</script>

</head>
<body class=" ext-gecko ext-gecko3">
	<table border="0" width="1000" height="200"> 	
		<tr>
			<!----------------- 기본정보 GRID START ----------------->
			<td width="40%" valign="top">
				<div id="man_grid" style="margin-top: 0em;"></div>
			</td>
			<!----------------- 기본정보 GRID END ----------------->
			<td width="60%" valign="top">
				<div class=" x-panel x-form-label-left" style="margin-top: 0em; width: 100%;"><%-- 0em <- 1em으로 수정하면 상위 공백 --%>
					<!----------------- SEARCH Hearder Start	 ----------------->
					<div class="x-panel-tl">
						<div class="x-panel-tr">
							<div class="x-panel-tc">
								<div class="x-panel-header x-unselectable" style="-moz-user-select: none;">
									<span class="x-panel-header-text">유지보수 기본정보</span>
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
									<form id="detailForm" name="detailForm" method="POST" class="x-panel-body x-form" style="padding: 1px 30px 0pt; width: 580px;">
									<input type="hidden" id="flag" name="flag"/>
									<!-- 1_ROW Start -->
									<div class="x-column-inner" style="width: 100%; margin-top: 0em;">
										<div class=" x-panel x-column" style="width: 97%;">
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
														<label class="x-form-item-label" style="width: auto;" for="man_id" ><font color="red">* </font>유지보수ID:</label>
														<div style="padding-left: 80px;" class="x-form-element">
															<input type="text" name="man_id" id="man_id" autocomplete="off" size="28" class=" x-form-text x-form-field" style="width: auto;">
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
										<div class=" x-panel x-column" style="width: 50%;" >
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label class="x-form-item-label" style="width: auto;" for="pjt_id" ><font color="red">* </font>프로젝트ID:</label>
														<div style="padding-left: 80px;" class="x-form-element">
															<table style="width: 165px;" cellspacing="0" class="x-btn  x-btn-noicon">
																<tr>
																	<td>
																		<input type="text" name="pjt_id" id="pjt_id" autocomplete="off" size="21" class=" x-form-text x-form-field" style="width: auto;" readonly="readonly" />
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
																							<button type="button" id="pjtBtn" class=" x-btn-text">검색</button>
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
														<label class="x-form-item-label" style="width: auto;" for="pjt_name" ><font color="red">* </font>프로젝트명:</label>
														<div style="padding-left: 80px;" class="x-form-element">
															<input type="text" name="pjt_name" id="pjt_name" autocomplete="off" size="28" class=" x-form-text x-form-field" style="width: auto;" readonly="readonly">
														</div>
														<div class="x-form-clear-left">
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>
									<!-- 3_ROW End -->
									
									 <%--
									<!-- 4_ROW Start -->
									<div class="x-column-inner" style="width: 100%;"> 
										<div class=" x-panel x-column" style="width: 50%;" >
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label class="x-form-item-label" style="width: auto;" for="sal_id" ><font color="red"> </font>매출ID:</label>
														<div style="padding-left: 80px;" class="x-form-element">
															<input type="text" name="sal_id" id="sal_id" autocomplete="off" size="21" class=" x-form-text x-form-field" style="width: auto;" readonly="readonly">
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
														<label class="x-form-item-label" style="width: auto;" for="sal_name" ><font color="red"> </font>매출명:</label>
														<div style="padding-left: 80px;" class="x-form-element">
															<input type="text" name="sal_name" id="sal_name" autocomplete="off" size="28" class=" x-form-text x-form-field" style="width: auto;" readonly="readonly">
														</div>
														<div class="x-form-clear-left">
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>
									<!-- 4_ROW End -->
									  --%>
									 

									<!-- 5_ROW Start -->
									<div class="x-column-inner" style="width: 100%;"> 
										<div class=" x-panel x-column" style="width: 50%;" >
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label class="x-form-item-label" style="width: auto;" for="pjt_reg_emp_num" ><font color="red">* </font>거래처:</label>
														<div style="padding-left: 80px;" class="x-form-element">
															<table style="width: 165px;" cellspacing="0" class="x-btn  x-btn-noicon">
																<tr>
																	<td>
																		<input type="hidden" name="costomer_num" id="costomer_num" autocomplete="off" size="7" class=" x-form-text x-form-field" style="width: auto;">
																		<input type="text" name="costomer_name" id="costomer_name" autocomplete="off" size="7" class=" x-form-text x-form-field" style="width: auto;">
																		<input type="hidden" name="custom_code" id="custom_code" autocomplete="off" size="7" class=" x-form-text x-form-field" style="width: auto;">
																		<input type="text" name="custom_name" id="custom_name" autocomplete="off" size="8" class=" x-form-text x-form-field" style="width: auto;">
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
																							<button type="button" id="customBtn" class=" x-btn-text">검색</button>
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
										<div class=" x-panel x-column" style="width: 50%;" >
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label class="x-form-item-label" style="width: auto;" for="pjt_reg_emp_num" ><font color="red">* </font>등록자:</label>
														<div style="padding-left: 80px;" class="x-form-element">
															<table style="width: 165px;" cellspacing="0" class="x-btn  x-btn-noicon">
																<tr>
																	<td>
																		<input type="hidden" name="sal_emp_num" id="sal_emp_num" autocomplete="off" size="7" class=" x-form-text x-form-field" style="width: auto;">
																		<input type="text" name="sal_emp_name" id="sal_emp_name" autocomplete="off" size="7" class=" x-form-text x-form-field" style="width: auto;">
																		<input type="hidden" name="sal_dept_code" id="sal_dept_code" autocomplete="off" size="8" class=" x-form-text x-form-field" style="width: auto;">
																		<input type="text" name="sal_dept_name" id="sal_dept_name" autocomplete="off" size="8" class=" x-form-text x-form-field" style="width: auto;">
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
									<!-- 5_ROW End -->

									<!-- 6_ROW Start -->
									<div class="x-column-inner" style="width: 100%;">
										<div class=" x-panel x-column" style="width: 50%;" >
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label class="x-form-item-label" style="width: auto;" for="pay_free_type_code" ><font color="red">* </font>유무상구분:</label>
														<div style="padding-left: 80px;" class="x-form-element">
															<select name="pay_free_type_code" id="pay_free_type_code" title="유무상구분" style="width: 164" type="text" class=" x-form-select x-form-field" >
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
										<div class=" x-panel x-column" style="width: 50%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label class="x-form-item-label" style="width: auto;" for="pjt_date_from" ><font color="red">* </font>기간:</label>
														<div style="padding-left: 77px;" class="x-form-element">
															<table>
																<tr>
																	<td>
																		<input type="text" name="maintenance_from" id="maintenance_from" autocomplete="off" size="9" class=" x-form-text x-form-field" style="width: auto;"
																		onFocus="restoreDateString(this, this.value)" onKeydown="_chkKeyPressNumPoint(this)" onblur="isValidDate(this, this.value)"/> 		
																	</td>
																	<td>&nbsp;~&nbsp;</td>
																	<td>
																		<input type="text" name="maintenance_to" id="maintenance_to" autocomplete="off" size="9" class=" x-form-text x-form-field" style="width: auto;"
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
									<!-- 6_ROW End -->
  

									<!-- 7_ROW Start -->
									<div class="x-column-inner" style="width: 100%;"> 
										<div class=" x-panel x-column" style="width: 50%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label class="x-form-item-label" style="width: auto;" for="maintenance_amt" >예상매출총액:</label>
														<div style="padding-left: 80px;" class="x-form-element">
															<input type="text" name="maintenance_amt" id="maintenance_amt" autocomplete="off" size="28" class=" x-form-text x-form-field" style="width: auto;" style="IME-MODE:disabled;text-align:right" onkeyPress="return _chkKeyPressNumOnly(this)" onBlur="_numFormat(this, Math.round(this.value));" onfocus="_removeComma(this, this.value)">
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
														<label class="x-form-item-label" style="width: auto;" for="note" >비고:</label>
														<div style="padding-left: 80px;" class="x-form-element">
															<textarea name="note" id="note" autocomplete="off" class=" x-form-text x-form-field" style="width:420; height:60px"></textarea>
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
														<label class="x-form-item-label" style="width: auto;" for="proc_status_code" >진행상태:</label>
														<div style="padding-left: 80px;" class="x-form-element">
															<select name="proc_status_code" id="proc_status_code" title="진행상태코드" style="width: 164"  class=" x-form-select x-form-field" 
															readonly="readonly" style='background-color:#f0f0f0' onFocus='this.initialSelect = this.selectedIndex;'onChange='this.selectedIndex = this.initialSelect;'>
																<option value="">선택하세요</option>
																<c:forEach items="${MAN_STATUS_CODE}" var="data" varStatus="status">
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
									<!-- 9_ROW End -->
  									
									<!-- 10_ROW Start -->
									<div class="x-column-inner" style="width: 100%;">
										<div class=" x-panel x-column" style="width: 50%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label class="x-form-item-label" style="width: auto;" for="final_mod_id" >최종변경자ID:</label>
														<div style="padding-left: 80px;" class="x-form-element">
															<input type="text" name="final_mod_id" id="final_mod_id" autocomplete="off" size="28" class=" x-form-text x-form-field" style="width: auto;">
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
														<div style="padding-left: 80px;" class="x-form-element">
															<input type="text" name="final_mod_date" id="final_mod_date" autocomplete="off" size="28" class=" x-form-text x-form-field" style="width: auto;">
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>
									<!-- 10_ROW End -->
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
			<!----------------- 프로젝트 GRID START ----------------->
			<td width="100%" valign="top" colspan="2">
				<div id="edit_grid_1st" style="margin-top: 0em;"></div>
			</td>
			<!----------------- 프로젝트 GRID END ----------------->
		</tr>
		<tr height="10"></tr>
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