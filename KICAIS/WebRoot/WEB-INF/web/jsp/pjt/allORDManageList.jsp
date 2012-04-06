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
<script type="text/javascript" src="/resource/common/js/grid/grid_edit_3rd.js"></script>
<script type="text/javascript">
/***************************************************************************
 *  수주기본정보 -- 초기값 설정 
 ***************************************************************************/
var	gridHeigth_1st 	 	= 515; 							// 그리드 전체 높이
var	gridWidth_1st		= 408;							// 그리드 전체 폭
var gridTitle_1st 		= "수주 목록";	  			// 그리드 제목
var	render_1st			= "grid_1st";				// 렌더(화면에 그려질) 할 id 
var	pageSize_1st		= 20;	  						// 그리드 페이지 사이즈	
var	proxyUrl_1st		= "/ord/order/orderInfoManageList.sg";  // 결과 값 페이지
var limit_1st			= pageSize_1st;
var start_1st			= 0;

// 그리드의 페이지 클릭시 검색조건값을 DB로 전송
function fnPagingValue_1st(){
	
	try{
		GridClass_1st.store.setBaseParam('start'		 	  	,start_1st);
	    GridClass_1st.store.setBaseParam('limit'		 	  	,limit_1st);
		
	    GridClass_1st.store.setBaseParam('src_pjt_id'                	    ,'<%=request.getParameter("src_pjt_id")%>');
		GridClass_1st.store.setBaseParam('src_pjt_name'                	    ,'<%=request.getParameter("src_pjt_name")%>');
		  
		GridClass_1st.store.setBaseParam('src_ord_custom_name' 	,'');
		GridClass_1st.store.setBaseParam('src_ord_type_code'  	,''); 
		GridClass_1st.store.setBaseParam('src_ord_id' 		  	,'');
		GridClass_1st.store.setBaseParam('src_ord_name'		  	,'');
		GridClass_1st.store.setBaseParam('src_ord_date_start' 	,'');
		GridClass_1st.store.setBaseParam('src_ord_date_end'   	,'');
	}catch(e){

	}
}
   
// Grid의 컬럼 설정
var userColumns_1st =  [ {header : '상태'                	,width : 60 ,sortable : true , dataIndex : 'FLAG'               ,hidden : true}              
					   , {header : '수주ID'					,width : 110 ,sortable : true , dataIndex : 'ORD_ID' 			}			
					   , {header : '수주일자'					,width : 60 ,sortable : true , dataIndex : 'ORD_DATE' 			,hidden : true}      
					   , {header : '수주구분코드'				,width : 60 ,sortable : true , dataIndex : 'ORD_TYPE_CODE' 		,hidden : true}      
					   , {header : '수주명'					,width : 100 ,sortable : true , dataIndex : 'ORD_NAME' 			}      
					   , {header : '견적ID'					,width : 60 ,sortable : true , dataIndex : 'EST_ID' 			,hidden : true}      
					   , {header : '수주구분'					,width : 80 ,sortable : true , dataIndex : 'ORD_TYPE_NAME' 		}
					   , {header : '버전'					,width : 60 ,sortable : true , dataIndex : 'EST_VERSION' 		,hidden : true}      
					   , {header : '업무구분코드'				,width : 60 ,sortable : true , dataIndex : 'ROLL_TYPE_CODE' 	,hidden : true}			
					   , {header : '프로젝트ID'				,width : 60 ,sortable : true , dataIndex : 'PJT_ID' 			,hidden : true}      
					   , {header : '프로젝트'					,width : 60 ,sortable : true , dataIndex : 'PJT_NAME' 			,hidden : true}
					   , {header : '수주부서코드'				,width : 60 ,sortable : true , dataIndex : 'ORD_DEPT_CODE' 		,hidden : true}      
					   , {header : '수주부서'					,width : 60 ,sortable : true , dataIndex : 'ORD_DEPT_NAME' 		,hidden : true}
					   , {header : '수주담당자번호'			,width : 60 ,sortable : true , dataIndex : 'ORD_EMP_NUM' 		,hidden : true}      
					   , {header : '수주담당자'				,width : 60 ,sortable : true , dataIndex : 'ORD_EMP_NAME' 		,hidden : true}
					   , {header : '수주처코드(거래처)'		,width : 100 ,sortable : true , dataIndex : 'ORD_CUSTOM_CODE' 	,hidden : true} 
					   , {header : '거래처명'					,width : 100 ,sortable : true , dataIndex : 'ORD_CUSTOM_NAME' 	}
					   , {header : '납품처코드'				,width : 60 ,sortable : true , dataIndex : 'DVE_CUSTOM_CODE' 	,hidden : true}      
					   , {header : '납품처'					,width : 60 ,sortable : true , dataIndex : 'DVE_CUSTOM_NAME' 	,hidden : true}
					   , {header : '검수예정일'				,width : 60 ,sortable : true , dataIndex : 'INSPECT_EXP_DATE' 	,hidden : true}      
					   , {header : '납품예정일'				,width : 60 ,sortable : true , dataIndex : 'DELIVERY_EXP_DATE' 	,hidden : true}      
					   , {header : '설치예정일시'				,width : 60 ,sortable : true , dataIndex : 'SET_EXP_DATE' 		,hidden : true}      
					   , {header : '매출예정일'				,width : 60 ,sortable : true , dataIndex : 'SAL_EXP_DATE' 		,hidden : true}      
					   , {header : '결제일'					,width : 60 ,sortable : true , dataIndex : 'ACCOUNT_DATE' 		,hidden : true}      
					   , {header : '수주총액'					,width : 60 ,sortable : true , dataIndex : 'ORD_TOTAL_AMT' 		,hidden : true}      
					   , {header : '할인총액'					,width : 60 ,sortable : true , dataIndex : 'DISCNT_TOTAL_AMT' 	,hidden : true}      
					   , {header : '수주적용총액'				,width : 60 ,sortable : true , dataIndex : 'ORD_APLY_TOTAL_AMT' ,hidden : true}      
					   , {header : '수주적용총세액'			,width : 60 ,sortable : true , dataIndex : 'ORD_APLY_TOTAL_TAX' ,hidden : true}      
					   , {header : '적용업무설명'				,width : 60 ,sortable : true , dataIndex : 'APLY_JOB_DESCRIPT'  ,hidden : true}      
					   , {header : '특이사항'					,width : 60 ,sortable : true , dataIndex : 'SUMMARY' 			,hidden : true}      
					   , {header : '유무상구분코드'			,width : 60 ,sortable : true , dataIndex : 'PAY_FREE_CODE' 		,hidden : true}      
					   , {header : '유지보수기간_From'			,width : 60 ,sortable : true , dataIndex : 'MAINTENANCE_FROM' 	,hidden : true}      
					   , {header : '유지보수기간_To'			,width : 60 ,sortable : true , dataIndex : 'MAINTENANCE_TO' 	,hidden : true}      
					   , {header : '프로젝트기간FROM'			,width : 60 ,sortable : true , dataIndex : 'PJT_DATE_FROM' 		,hidden : true}      
					   , {header : '프로젝트기간To'			,width : 60 ,sortable : true , dataIndex : 'PJT_DATE_TO' 		,hidden : true}      
					   , {header : '세금계산서발행구분'			,width : 60 ,sortable : true , dataIndex : 'TAX_ISSUE_TYPE' 	,hidden : true}      
					   , {header : '세금계산서분할발행회수' 		,width : 60 ,sortable : true , dataIndex : 'TAX_MOD_ISSUE_CNT' 	,hidden : true}      
					   , {header : '진행상태코드'          	,width : 60 ,sortable : true , dataIndex : 'PROC_STATUS_CODE' 	,hidden : true}      
					   , {header : '최종변경자ID'				,width : 60 ,sortable : true , dataIndex : 'FINAL_MOD_ID' 		,hidden : true}      
					   , {header : '최종변경자'				,width : 60 ,sortable : true , dataIndex : 'FINAL_MOD_NAME' 	,hidden : true}
					   , {header : '최종변경일시'				,width : 60 ,sortable : true , dataIndex : 'FINAL_MOD_DATE' 	,hidden : true}      
					   , {header : '최초등록일'				,width : 60 ,sortable : true , dataIndex : 'REG_DATE' 			,hidden : true}      
					   , {header : '최초등록자'				,width : 60 ,sortable : true , dataIndex : 'REG_ID' 			,hidden : true}      
					   , {header : '수주처담당자번호'			,width : 60 ,sortable : true , dataIndex : 'ORD_CUSTOMER_NUM' 	,hidden : true}      
					   , {header : '수주처담당자'				,width : 60 ,sortable : true , dataIndex : 'ORD_CUSTOMER_NAME' 	,hidden : true}
					   , {header : '수주처담당자부서'			,width : 60 ,sortable : true , dataIndex : 'ORD_CUSTOMER_DEPT' 	,hidden : true}
					   , {header : '납품처담당자번호' 			,width : 60 ,sortable : true , dataIndex : 'DVE_CUSTOMER_NUM' 	,hidden : true}
					   , {header : '납품처담당자' 				,width : 60 ,sortable : true , dataIndex : 'DVE_CUSTOMER_NAME' 	,hidden : true}
					   , {header : '업태' 					,width : 60 ,sortable : true , dataIndex : 'BIZ_TYPE' 			,hidden : true}
					   , {header : '업종' 					,width : 60 ,sortable : true , dataIndex : 'BIZ_KIND' 			,hidden : true}
					   ];	 

// 그리드 결과매핑 
var mappingColumns_1st = [ { name : 'FLAG'               ,allowBlank : false }		// 상태                	               
						 , { name : 'ORD_ID' 			 ,allowBlank : false }		// 수주ID					 			
						 , { name : 'ORD_DATE' 			 ,allowBlank : false }		// 수주일자				 			  
						 , { name : 'ORD_TYPE_CODE' 	 ,allowBlank : false }		// 수주구분코드			 		      
						 , { name : 'ORD_NAME' 			 ,allowBlank : false }		// 수주명					 			  
						 , { name : 'EST_ID' 			 ,allowBlank : false }		// 견적ID					 			
						 , { name : 'ORD_TYPE_NAME' 	 ,allowBlank : false }		// 수주구분			 				
						 , { name : 'EST_VERSION' 		 ,allowBlank : false }		// 버전					 				    
						 , { name : 'ROLL_TYPE_CODE' 	 ,allowBlank : false }		// 업무구분코드			 				
						 , { name : 'PJT_ID' 			 ,allowBlank : false }		// 프로젝트ID		
						 , { name : 'PJT_NAME' 			 ,allowBlank : false }		// 프로젝트
						 , { name : 'ORD_DEPT_CODE' 	 ,allowBlank : false }		// 수주부서코드		
						 , { name : 'ORD_DEPT_NAME' 	 ,allowBlank : false }		// 수주부서
						 , { name : 'ORD_EMP_NUM' 		 ,allowBlank : false }		// 수주담당자번호	
						 , { name : 'ORD_EMP_NAME' 		 ,allowBlank : false }		// 수주담당자
						 , { name : 'ORD_CUSTOM_CODE' 	 ,allowBlank : false }		// 수주처코드(거래처)		 
						 , { name : 'ORD_CUSTOM_NAME' 	 ,allowBlank : false }		// 거래처명			 				
						 , { name : 'DVE_CUSTOM_CODE' 	 ,allowBlank : false }		// 납품처코드				 		      
						 , { name : 'DVE_CUSTOM_NAME' 	 ,allowBlank : false }		// 납품처				 				
						 , { name : 'INSPECT_EXP_DATE' 	 ,allowBlank : false }		// 검수예정일				 		      
						 , { name : 'DELIVERY_EXP_DATE'  ,allowBlank : false }		// 납품예정일				 			      
						 , { name : 'SET_EXP_DATE' 		 ,allowBlank : false }		// 설치예정일시			 		    
						 , { name : 'SAL_EXP_DATE' 		 ,allowBlank : false }		// 매출예정일				 		    
						 , { name : 'ACCOUNT_DATE' 		 ,allowBlank : false }		// 결제일					 			    
						 , { name : 'ORD_TOTAL_AMT' 	 ,allowBlank : false }		// 수주총액				 			      
						 , { name : 'DISCNT_TOTAL_AMT' 	 ,allowBlank : false }		// 할인총액				 			      
						 , { name : 'ORD_APLY_TOTAL_AMT' ,allowBlank : false }		// 수주적용총액			 		       
						 , { name : 'ORD_APLY_TOTAL_TAX' ,allowBlank : false }		// 수주적용총세액			 	       
						 , { name : 'APLY_JOB_DESCRIPT'  ,allowBlank : false }		// 적용업무설명			 		       
						 , { name : 'SUMMARY' 			 ,allowBlank : false }		// 특이사항				 			  
						 , { name : 'PAY_FREE_CODE' 	 ,allowBlank : false }		// 유무상구분코드			 	      
						 , { name : 'MAINTENANCE_FROM' 	 ,allowBlank : false }		// 유지보수기간_From		 	      
						 , { name : 'MAINTENANCE_TO' 	 ,allowBlank : false }		// 유지보수기간_To			 	    
						 , { name : 'PJT_DATE_FROM' 	 ,allowBlank : false }		// 프로젝트기간FROM		 	      
						 , { name : 'PJT_DATE_TO' 		 ,allowBlank : false }		// 프로젝트기간To			 	    
						 , { name : 'TAX_ISSUE_TYPE' 	 ,allowBlank : false }		// 세금계산서발행구분		    
						 , { name : 'TAX_MOD_ISSUE_CNT'  ,allowBlank : false }		// 세금계산서분할발행회수	      
						 , { name : 'PROC_STATUS_CODE' 	 ,allowBlank : false }		// 진행상태코드                
						 , { name : 'FINAL_MOD_ID' 		 ,allowBlank : false }		// 최종변경자ID		
						 , { name : 'FINAL_MOD_NAME'	 ,allowBlank : false }		// 최종변경자
						 , { name : 'FINAL_MOD_DATE' 	 ,allowBlank : false }		// 최종변경일시				 	    
						 , { name : 'REG_DATE' 			 ,allowBlank : false }		// 최초등록일					 	  
						 , { name : 'REG_ID' 			 ,allowBlank : false }		// 최초등록자					 	
						 , { name : 'ORD_CUSTOMER_NUM' 	 ,allowBlank : false }		// 수주처담당자번호		 	      
						 , { name : 'ORD_CUSTOMER_NAME'  ,allowBlank : false }		// 수주처담당자	
						 , { name : 'ORD_CUSTOMER_DEPT'  ,allowBlank : false }		// 수주처담당자부서
						 , { name : 'DVE_CUSTOMER_NUM' 	 ,allowBlank : false }		// 납품처담당자번호 		 	
						 , { name : 'DVE_CUSTOMER_NAME'  ,allowBlank : false }		// 납품처담당자 			
						 , { name : 'BIZ_TYPE'  		 ,allowBlank : false }		// 업태
						 , { name : 'BIZ_KIND'  		 ,allowBlank : false }		// 업종
    				 	 ];

/***************************************************************************
 * 수주기본정보 --- 그리드 클릭시 Event
 ***************************************************************************/
function fnGridOnClick_1st(store, rowIndex){
	
	fnInitValue();
	
	Ext.get('flag').set({value : fnFixNull(store.getAt(rowIndex).data.FLAG)}, false);								// 상태                	               
	Ext.get('ord_id').set({value : fnFixNull(store.getAt(rowIndex).data.ORD_ID)}, false);							// 수주ID					 			
	Ext.get('ord_date').set({value : fnFixNull(store.getAt(rowIndex).data.ORD_DATE)}, false);						// 수주일자				 			  
	Ext.get('ord_type_code').set({value : fnFixNull(store.getAt(rowIndex).data.ORD_TYPE_CODE)}, false);				// 수주구분코드			 		      
	Ext.get('ord_name').set({value : fnFixNull(store.getAt(rowIndex).data.ORD_NAME)}, false);						// 수주명					 			  
	Ext.get('est_id').set({value : fnFixNull(store.getAt(rowIndex).data.EST_ID)}, false);							// 견적ID					 			
	 				
	Ext.get('est_version').set({value : fnFixNull(store.getAt(rowIndex).data.EST_VERSION)}, false);					// 버전					 				    
	Ext.get('roll_type_code').set({value : fnFixNull(store.getAt(rowIndex).data.ROLL_TYPE_CODE)}, false);			// 업무구분코드			 				
	Ext.get('pjt_id').set({value : fnFixNull(store.getAt(rowIndex).data.PJT_ID)}, false);							// 프로젝트ID				 		
	Ext.get('pjt_name').set({value : fnFixNull(store.getAt(rowIndex).data.PJT_NAME)}, false);						// 프로젝트명
	Ext.get('ord_dept_code').set({value : fnFixNull(store.getAt(rowIndex).data.ORD_DEPT_CODE)}, false);				// 수주부서코드			 		      
	Ext.get('ord_dept_name').set({value : fnFixNull(store.getAt(rowIndex).data.ORD_DEPT_NAME)}, false);				// 수주부서
	Ext.get('ord_emp_num').set({value : fnFixNull(store.getAt(rowIndex).data.ORD_EMP_NUM)}, false);					// 수주담당자번호			 	    
	Ext.get('ord_emp_name').set({value : fnFixNull(store.getAt(rowIndex).data.ORD_EMP_NAME)}, false);					// 수주담당자
	Ext.get('ord_custom_code').set({value : fnFixNull(store.getAt(rowIndex).data.ORD_CUSTOM_CODE)}, false);			// 수주처코드(거래처)		 
	Ext.get('ord_custom_name').set({value : fnFixNull(store.getAt(rowIndex).data.ORD_CUSTOM_NAME)}, false);			// 거래처명			 				
	Ext.get('dve_custom_code').set({value : fnFixNull(store.getAt(rowIndex).data.DVE_CUSTOM_CODE)}, false);			// 납품처코드				 		      
	Ext.get('dve_custom_name').set({value : fnFixNull(store.getAt(rowIndex).data.DVE_CUSTOM_NAME)}, false);			// 납품처				 				
	Ext.get('inspect_exp_date').set({value : fnFixNull(store.getAt(rowIndex).data.INSPECT_EXP_DATE)}, false);		// 검수예정일				 		      
	Ext.get('delivery_exp_date').set({value : fnFixNull(store.getAt(rowIndex).data.DELIVERY_EXP_DATE)}, false);		// 납품예정일				 			      
	Ext.get('set_exp_date').set({value : fnFixNull(store.getAt(rowIndex).data.SET_EXP_DATE)}, false);				// 설치예정일시			 		    
	Ext.get('sal_exp_date').set({value : fnFixNull(store.getAt(rowIndex).data.SAL_EXP_DATE)}, false);				// 매출예정일				 		    
	Ext.get('account_date').set({value : fnFixNull(store.getAt(rowIndex).data.ACCOUNT_DATE)}, false);				// 결제일					 			    
	Ext.get('ord_total_amt').set({value : fnFixNull(MoneyComma(store.getAt(rowIndex).data.ORD_TOTAL_AMT))}, false);				// 수주총액				 			      
	Ext.get('discnt_total_amt').set({value : fnFixNull(MoneyComma(store.getAt(rowIndex).data.DISCNT_TOTAL_AMT))}, false);		// 할인총액				 			      
	Ext.get('ord_aply_total_amt').set({value : fnFixNull(MoneyComma(store.getAt(rowIndex).data.ORD_APLY_TOTAL_AMT))}, false);	// 수주적용총액			 		       
	Ext.get('ord_aply_total_tax').set({value : fnFixNull(MoneyComma(store.getAt(rowIndex).data.ORD_APLY_TOTAL_TAX))}, false);	// 수주적용총세액			 	       
	Ext.get('aply_job_descript').set({value : fnFixNull(store.getAt(rowIndex).data.APLY_JOB_DESCRIPT)}, false);		// 적용업무설명			 		       
	Ext.get('summary').set({value : fnFixNull(store.getAt(rowIndex).data.SUMMARY)}, false);							// 특이사항				 			  
	Ext.get('pay_free_code').set({value : fnFixNull(store.getAt(rowIndex).data.PAY_FREE_CODE)}, false);				// 유무상구분코드			 	      
	Ext.get('maintenance_from').set({value : fnFixNull(store.getAt(rowIndex).data.MAINTENANCE_FROM)}, false);		// 유지보수기간_From		 	      
	Ext.get('maintenance_to').set({value : fnFixNull(store.getAt(rowIndex).data.MAINTENANCE_TO)}, false);			// 유지보수기간_To			 	    
	Ext.get('pjt_date_from').set({value : fnFixNull(store.getAt(rowIndex).data.PJT_DATE_FROM)}, false);				// 프로젝트기간FROM		 	      
	Ext.get('pjt_date_to').set({value : fnFixNull(store.getAt(rowIndex).data.PJT_DATE_TO)}, false);					// 프로젝트기간To			 	    
	Ext.get('tax_issue_type').set({value : fnFixNull(store.getAt(rowIndex).data.TAX_ISSUE_TYPE)}, false);			// 세금계산서발행구분		    
	Ext.get('tax_mod_issue_cnt').set({value : fnFixNull(store.getAt(rowIndex).data.TAX_MOD_ISSUE_CNT)}, false);		// 세금계산서분할발행회수	      
	Ext.get('proc_status_code').set({value : fnFixNull(store.getAt(rowIndex).data.PROC_STATUS_CODE)}, false);		// 진행상태코드                
	Ext.get('final_mod_id').set({value : fnFixNull(store.getAt(rowIndex).data.FINAL_MOD_ID)}, false);				// 최종변경자ID				 	    
	Ext.get('final_mod_name').set({value : fnFixNull(store.getAt(rowIndex).data.FINAL_MOD_NAME)}, false);			// 최종변경자
	Ext.get('final_mod_date').set({value : fnFixNull(store.getAt(rowIndex).data.FINAL_MOD_DATE)}, false);			// 최종변경일시				 	    
	//Ext.get('reg_date').set({value : fnFixNull(store.getAt(rowIndex).data.REG_DATE)}, false);						// 최초등록일					 	  
	//Ext.get('reg_id').set({value : fnFixNull(store.getAt(rowIndex).data.REG_ID)}, false);							// 최초등록자					 	
	Ext.get('ord_customer_num').set({value : fnFixNull(store.getAt(rowIndex).data.ORD_CUSTOMER_NUM)}, false);		// 수주처담당자번호		 	      
	Ext.get('ord_customer_name').set({value : fnFixNull(store.getAt(rowIndex).data.ORD_CUSTOMER_NAME)}, false);		// 수주처담당자	
	Ext.get('ord_customer_dept').set({value : fnFixNull(store.getAt(rowIndex).data.ORD_CUSTOMER_DEPT)}, false);		// 수주처담당자부서
	Ext.get('dve_customer_num').set({value : fnFixNull(store.getAt(rowIndex).data.DVE_CUSTOMER_NUM)}, false);		// 납품처담당자번호 		 	
	Ext.get('dve_customer_name').set({value : fnFixNull(store.getAt(rowIndex).data.DVE_CUSTOMER_NAME)}, false);		// 납품처담당자 				 		
	Ext.get('biz_type').set({value : fnFixNull(store.getAt(rowIndex).data.BIZ_TYPE)}, false);						// 업태
	Ext.get('biz_kind').set({value : fnFixNull(store.getAt(rowIndex).data.BIZ_KIND)}, false);						// 업종
	
	var keyValue1 = fnFixNull(store.getAt(rowIndex).data.ORD_ID);			 // 수주ID
	
	// 버튼 disable
	Ext.get('saveBtn').dom.disabled   = true;
	Ext.get('updateBtn').dom.disabled = false;
	
	Ext.get('roll_type_code').dom.disabled   = true;	// 업무구분
	Ext.get('ord_type_code').dom.disabled   = true;		// 수주구분
	Ext.get('ord_custom_code').dom.disabled   = true;	// 거래처코드
	Ext.get('ord_custom_name').dom.disabled   = true;	// 거래처
	Ext.get('customCodeBtn').dom.disabled   = true;		// 거래처검색버튼
 	Ext.get('estIdBtn').dom.disabled   = true;			// 견적ID검색버튼
	
	fnSearchEdit1st(keyValue1);
	fnSearchEdit2nd(keyValue1);
	fnSearchEdit3rd(keyValue1);

}   

// 수주품목 정보 조회
function fnSearchEdit1st(keyValue1){
	
	Ext.Ajax.request({
		url: "/ord/order/result_edit_1st.sg" 
		,success: function(response){							// 조회결과 성공시
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
				   , ord_id			: keyValue1
				  }				
	}); // end Ext.Ajax.request   
}

// 수주처 시스템사양 정보 조회
function fnSearchEdit2nd(keyValue1){
	
	Ext.Ajax.request({
		url: "/ord/order/result_edit_2nd.sg" 
		,success: function(response){						// 조회결과 성공시
					// 조회된 결과값, store명
					GridClass_edit_2nd.store.commitChanges();
					GridClass_edit_2nd.store.removeAll();
					
					var json = Ext.util.JSON.decode(response.responseText);
					GridClass_edit_2nd.store.loadData(json);
			
		          }
		,failure: handleFailure 
		,params : {
				   // 페이지 		
					 limit			: limit_edit_2nd
				   , start			: start_edit_2nd
				   // 키 value
				   , ord_id			: keyValue1
				  }				
	}); // end Ext.Ajax.request   
}


// 세금계산서 분할 발행정보 조회
function fnSearchEdit3rd(keyValue1){
	
	Ext.Ajax.request({
		url: "/ord/order/result_edit_3rd.sg" 
		,success: function(response){						// 조회결과 성공시
					// 조회된 결과값, store명
					GridClass_edit_3rd.store.commitChanges();
					GridClass_edit_3rd.store.removeAll();
					
					var json = Ext.util.JSON.decode(response.responseText);
					GridClass_edit_3rd.store.loadData(json);
					
		          }
		,failure: handleFailure 
		,params : {
				   // 페이지 		
					 limit			: limit_edit_3rd
				   , start			: start_edit_3rd
				   // 키 value
				   , ord_id			: keyValue1
				  }				
	}); // end Ext.Ajax.request   
}

/***************************************************************************
 * 설  명 : 편집그리드 설정 (수주품목정보)
***************************************************************************/
var	gridHeigth_edit_1st	= 200;
var	gridWidth_edit_1st  = 1000	;
var	gridTitle_edit_1st  = "수주 품목정보"	; 
var	render_edit_1st		= "edit_grid_1st";
var keyNm_edit_1st		= "ORD_INFO_SEQ";
var pageSize_edit_1st	= 4;
var limit_edit_1st		= pageSize_edit_1st;
var start_edit_1st		= 0;
var proxyUrl_edit_1st	= "/ord/order/result_edit_1st.sg";
var gridRowDeleteYn	    = "";

// 행추가
function addNew_edit_1st(){
		
	var est_id = Ext.get('est_id').getValue();
	
	if(est_id == ""){
		Ext.Msg.alert('확인', '기본정보의 견적ID를  조회해주세요'); 
		return false;
	}
	
	var Plant = GridClass_edit_1st.grid.getStore().recordType; 
    var p = new Plant({ 
	        		    FLAG			: 'I' 
	        		  , ORD_ID		    : Ext.get('ord_id').getValue()
	        		  , ITEM_CODE       : '' 
  				   	  , CNT             : 0
				   	  , UNIT_PRICE      : 0
				   	  , AMT             : 0
				   	  , DISCOUNT_RATIO  : 0
		    		  , USE_YN          : 'Y'
		    		  , PAY_FREE_CODE   : ''
		    		  , APLY_UNIT_PRICE : 0 
		    		  , APLY_AMT        : 0
		    		  , APLY_TAX        : 0
    				  }); 
  	GridClass_edit_1st.grid.stopEditing();
	GridClass_edit_1st.store.insert(0, p);
	GridClass_edit_1st.grid.startEditing(0, 0);
}

// 페이징
function fnPagingValue_edit_1st(){	
	try{
		GridClass_edit_1st.store.setBaseParam('start'		,start_edit_1st);
	    GridClass_edit_1st.store.setBaseParam('limit'		,limit_edit_1st);
	    GridClass_edit_1st.store.setBaseParam('ord_id'		,Ext.get('ord_id').getValue());
	}catch(e){

	}
}

// 유무상구분코드 combo box 생성 start
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
	  ['', '선택하세요'],
     <c:forEach items="${PAY_FREE_CODE}" var="data" varStatus="status">
      ['${data.COM_CODE}', '${data.COM_CODE_NAME}']
      <c:if test="${not status.last}">,</c:if>
     </c:forEach>
      ]
   })
});

//combo box render
Ext.util.Format.comboRenderer = function(PAY_FREE_CODE_COMBO){    
 return function(value){        
 var record = PAY_FREE_CODE_COMBO.findRecord(PAY_FREE_CODE_COMBO.valueField, value);        
 return record ? record.get(PAY_FREE_CODE_COMBO.displayField) : PAY_FREE_CODE_COMBO.valueNotFoundText;    
}}
 

// 그리드 필드
var	userColumns_edit_1st	= [ {header: '상태'        ,width: 60,  sortable: true ,dataIndex: 'FLAG'               ,hidden : true}
				  			  ,	{header: "수주ID",		width: 10,	sortable: true,	dataIndex: "ORD_ID",			editor: new Ext.form.TextField({ allowBlank : false }), hidden:true}
		  , {id:'ord_info_seq',  header: "순번",			width: 10,	sortable: true,	dataIndex: "ORD_INFO_SEQ",		editor: new Ext.form.TextField({ allowBlank : false }), hidden:true}
							  , {header: "* 품목코드",	width: 100,	sortable: true,	dataIndex: "ITEM_CODE",			editor: new Ext.form.TextField({ allowBlank : false }),renderer:changeBLUE}
							  , {header: "품목명",		width: 100,	sortable: true,	dataIndex: "ITEM_NAME",			editor: new Ext.form.TextField({ allowBlank : false })}
							  , {header: "수량",			width: 50,	sortable: true,	dataIndex: "CNT",				editor: new Ext.form.NumberField({ allowBlank : false }), align : 'right'}
							  , {header: "총액",			width: 70,	sortable: true,	dataIndex: "UNIT_PRICE",		editor: new Ext.form.NumberField({ allowBlank : false }), editable:false,renderer: "korMoney" , align : 'right'}
							  , {header: "금액",			width: 70,	sortable: true,	dataIndex: "AMT",				editor: new Ext.form.NumberField({ allowBlank : false }), editable:false,renderer: "korMoney" , align : 'right'}
							  , {header: "할인율",		width: 100,	sortable: true,	dataIndex: "DISCOUNT_RATIO",	editor: new Ext.form.NumberField({ allowBlank : false }), align : 'right'}
							  , {header: "유무상구분",	width: 100,	sortable: true,	dataIndex: "PAY_FREE_CODE",		editor: PAY_FREE_CODE_COMBO  ,renderer: Ext.util.Format.comboRenderer(PAY_FREE_CODE_COMBO)}
							  , {header: "적용단가",		width: 100,	sortable: true,	dataIndex: "APLY_UNIT_PRICE",	editor: new Ext.form.NumberField({ allowBlank : false }), editable:false ,renderer: "korMoney" , align : 'right'}
							  , {header: "적용금액",		width: 100,	sortable: true,	dataIndex: "APLY_AMT",			editor: new Ext.form.NumberField({ allowBlank : false }),renderer: "korMoney" , align : 'right'}
							  , {header: "적용세액",		width: 100,	sortable: true,	dataIndex: "APLY_TAX",			editor: new Ext.form.NumberField({ allowBlank : false }), editable:false ,renderer: "korMoney" , align : 'right'}
							  , {header: "비고",			width: 200,	sortable: true,	dataIndex: "NOTE",				editor: new Ext.form.TextField({ allowBlank : false })}
							  , {header: "최종변경자ID",	width: 10,	sortable: true,	dataIndex: "FINAL_MOD_ID",		editor: new Ext.form.TextField({ allowBlank : false }), hidden:true}
							  , {header: "최종변경일시",	width: 10,	sortable: true,	dataIndex: "FINAL_MOD_DATE",	editor: new Ext.form.TextField({ allowBlank : false }), hidden:true}
							  ];

// 맵핑 필드
var	mappingColumns_edit_1st	= [ {name: "FLAG", 			    type:"string", mapping: "FLAG"}
							  , {name: "ORD_ID", 			type:"string", mapping: "ORD_ID"}
							  , {name: "ORD_INFO_SEQ", 		type:"string", mapping: "ORD_INFO_SEQ"}
							  , {name: "ITEM_CODE", 		type:"string", mapping: "ITEM_CODE"}
							  , {name: "ITEM_NAME", 		type:"string", mapping: "ITEM_NAME"}
							  , {name: "CNT", 				type:"string", mapping: "CNT"}
							  , {name: "UNIT_PRICE", 		type:"string", mapping: "UNIT_PRICE"}
							  , {name: "AMT", 				type:"string", mapping: "AMT"}
							  , {name: "DISCOUNT_RATIO",	type:"string", mapping: "DISCOUNT_RATIO"}
							  , {name: "PAY_FREE_CODE", 	type:"string", mapping: "PAY_FREE_CODE"}
							  , {name: "APLY_UNIT_PRICE", 	type:"string", mapping: "APLY_UNIT_PRICE"}
							  , {name: "APLY_AMT", 			type:"string", mapping: "APLY_AMT"}
							  , {name: "APLY_TAX", 			type:"string", mapping: "APLY_TAX"}       
							  , {name: "NOTE", 				type:"string", mapping: "NOTE"}           
							  , {name: "FINAL_MOD_ID", 		type:"string", mapping: "FINAL_MOD_ID"}   
							  , {name: "FINAL_MOD_DATE", 	type:"string", mapping: "FINAL_MOD_DATE"} 
	    				 	  ]; 
 

/***************************************************************************
 * 설  명 : 편집그리드 설정 (수주처 시스템 사양정보)
***************************************************************************/
var	gridHeigth_edit_2nd	= 200;
var	gridWidth_edit_2nd  = 1000	;
var	gridTitle_edit_2nd  = "납품처 시스템 사양정보"	; 
var	render_edit_2nd		= "edit_grid_2nd";
var keyNm_edit_2nd		= "ORD_INFO_SEQ";
var pageSize_edit_2nd	= 4;
var limit_edit_2nd		= pageSize_edit_2nd;
var start_edit_2nd		= 0;
var proxyUrl_edit_2nd	= "/ord/order/result_edit_2nd.sg";
var grid2ndRowDeleteYn  = "";

// 행추가
function addNew_edit_2nd(){
	
	var est_id = Ext.get('est_id').getValue();
	
	if(est_id == ""){
		Ext.Msg.alert('확인', '기본정보의 견적ID를  조회해주세요'); 
		return false;
	}
	
	var Plant = GridClass_edit_2nd.grid.getStore().recordType; 
    var p = new Plant({ 
	        		    FLAG			: 'I' 
	        		  , ORD_ID		    : Ext.get('ord_id').getValue()
		    		  , USE_YN          : 'Y'
		    		  , SPEC_TYPE_CODE  : ''
    				  }); 
  	GridClass_edit_2nd.grid.stopEditing();
	GridClass_edit_2nd.store.insert(0, p);
	GridClass_edit_2nd.grid.startEditing(0, 0);
}

// 페이징
function fnPagingValue_edit_2nd(){	
	try{
		GridClass_edit_2nd.store.setBaseParam('start'		,start_edit_2nd);
	    GridClass_edit_2nd.store.setBaseParam('limit'		,limit_edit_2nd);
	    GridClass_edit_2nd.store.setBaseParam('ord_id'		,Ext.get('ord_id').getValue());
	}catch(e){

	}
}

// 제원구분코드 combo box 생성 start 
var SPEC_TYPE_CODE_COMBO = new Ext.form.ComboBox({    
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
	  ['', ''],
     <c:forEach items="${SPEC_TYPE_CODE}" var="data" varStatus="status">
      ['${data.COM_CODE}', '${data.COM_CODE_NAME}']
      <c:if test="${not status.last}">,</c:if>
     </c:forEach>
      ]
   })
});

//combo box render
Ext.util.Format.comboRenderer = function(SPEC_TYPE_CODE_COMBO){    
 return function(value){        
 var record = SPEC_TYPE_CODE_COMBO.findRecord(SPEC_TYPE_CODE_COMBO.valueField, value);        
 return record ? record.get(SPEC_TYPE_CODE_COMBO.displayField) : SPEC_TYPE_CODE_COMBO.valueNotFoundText;    
}}

// 그리드 필드
var	userColumns_edit_2nd	= [ {header: '상태'        ,width: 70,  sortable: true ,dataIndex: 'FLAG'               ,hidden : true} 
							  , {header: "수주ID",		width: 100,	sortable: true,	dataIndex: "ORD_ID",		editor: new Ext.form.TextField({ allowBlank : false }) , hidden:true}
							  , {header: "순번",			width: 10,	sortable: true,	dataIndex: "ORD_INFO_SEQ",	editor: new Ext.form.TextField({ allowBlank : false }) , hidden:true}
							  , {header: "제원구분코드",	width: 100,	sortable: true,	dataIndex: "SPEC_TYPE_CODE",editor: SPEC_TYPE_CODE_COMBO  ,renderer: Ext.util.Format.comboRenderer(SPEC_TYPE_CODE_COMBO) }
							  , {header: "제원설명",		width: 100,	sortable: true,	dataIndex: "SPEC_INTRO",	editor: new Ext.form.TextField({ allowBlank : false }) }
							  , {header: "제원수량",		width: 100,	sortable: true,	dataIndex: "SPEC_CNT",		editor: new Ext.form.TextField({ allowBlank : false }) , align : 'right'}
							  , {header: "제원용량",		width: 100,	sortable: true,	dataIndex: "SPEC_VOL",		editor: new Ext.form.TextField({ allowBlank : false }) }
							  , {header: "비고",			width: 200,	sortable: true,	dataIndex: "NOTE",			editor: new Ext.form.TextField({ allowBlank : false }) }
							  , {header: "최종변경자ID",	width: 10,	sortable: true,	dataIndex: "FINAL_MOD_ID",	editor: new Ext.form.TextField({ allowBlank : false }) , hidden:true}
							  , {header: "최종변경일시",	width: 10,	sortable: true,	dataIndex: "FINAL_MOD_DATE",editor: new Ext.form.TextField({ allowBlank : false }) , hidden:true}
							  ];

// 맵핑 필드
var	mappingColumns_edit_2nd	= [ {name: "FLAG", 		    type:"string", mapping: "FLAG"}
							  , {name: "ORD_ID", 		type:"string", mapping: "ORD_ID"}			// 수주ID      
							  , {name: "ORD_INFO_SEQ", 	type:"string", mapping: "ORD_INFO_SEQ"}		// 순번        
							  , {name: "SPEC_TYPE_CODE",type:"string", mapping: "SPEC_TYPE_CODE"}	// 제원구분코드
							  , {name: "SPEC_INTRO", 	type:"string", mapping: "SPEC_INTRO"}		// 제원설명    
							  , {name: "SPEC_CNT", 		type:"string", mapping: "SPEC_CNT"}			// 제원수량    
							  , {name: "SPEC_VOL", 		type:"string", mapping: "SPEC_VOL"}			// 제원용량    
							  , {name: "NOTE", 			type:"string", mapping: "NOTE"}				// 비고        
							  , {name: "FINAL_MOD_ID", 	type:"string", mapping: "FINAL_MOD_ID"}		// 최종변경자ID
							  , {name: "FINAL_MOD_DATE",type:"string", mapping: "FINAL_MOD_DATE"}	// 최종변경일시
	    				 	  ]; 


/***************************************************************************
 * 설  명 : 편집그리드 설정 (세금계산서 분할 발행정보)
***************************************************************************/
var	gridHeigth_edit_3rd	= 150;
var	gridWidth_edit_3rd  = 1000	;
var	gridTitle_edit_3rd  = "세금계산서 분할 발행정보"	; 
var	render_edit_3rd		= "edit_grid_3rd";
var keyNm_edit_3rd		= "ORD_INFO_SEQ";
var pageSize_edit_3rd	= 4;
var limit_edit_3rd		= pageSize_edit_3rd;
var start_edit_3rd		= 0;
var proxyUrl_edit_3rd	= "/ord/order/result_edit_3rd.sg";
var grid3rdRowDeleteYn  = "";

// 행추가
function addNew_edit_3rd(){
	
	var est_id = Ext.get('est_id').getValue();
	
	if(est_id == ""){
		Ext.Msg.alert('확인', '기본정보의 견적ID를  조회해주세요'); 
		return false;
	}
	
	var Plant = GridClass_edit_3rd.grid.getStore().recordType;
    var p = new Plant({ 
	        		    FLAG			: 'I' 
	        		  , PUR_SAL_ID		: Ext.get('ord_id').getValue()
	        		  , CUSTOM_CODE     : Ext.get('ord_custom_code').getValue()
	        		  , CNT				: ''
	        		  , UNIT_PRICE		: ''
	        		  , AMT				: ''
	        		  , TAX				: ''
	        		  , ITEM_CODE       : ''
    				  });
  	GridClass_edit_3rd.grid.stopEditing();
	GridClass_edit_3rd.store.insert(0, p);
	GridClass_edit_3rd.grid.startEditing(0, 0);
}

// 페이징
function fnPagingValue_edit_3rd(){	
	try{
		GridClass_edit_3rd.store.setBaseParam('start'		,start_edit_3rd);
	    GridClass_edit_3rd.store.setBaseParam('limit'		,limit_edit_3rd);
	    GridClass_edit_3rd.store.setBaseParam('ord_id'		,Ext.get('ord_id').getValue());
	}catch(e){

	}
}

// 그리드 필드 PREPARE_DATE
var	userColumns_edit_3rd	= [ {header: "상태"            , width: 80  ,sortable: true, dataIndex: "FLAG"               ,hidden : true}              
					          , {header: "매입매출구분코드",	width: 100,	sortable: true,	dataIndex: "PUR_SAL_TYPE_CODE",	editor: new Ext.form.TextField({ allowBlank : false })}	
							  , {header: "세금계산서ID",		width: 100,	sortable: true,	dataIndex: "TAX_ID",			editor: new Ext.form.TextField({ allowBlank : false })}
							  , {header: "매(입)출ID_수주ID", width: 100,	sortable: true,	dataIndex: "PUR_SAL_ID",		editor: new Ext.form.TextField({ allowBlank : false })}
							  , {header: "거래처코드",		width: 100,	sortable: true,	dataIndex: "CUSTOM_CODE",		editor: new Ext.form.TextField({ allowBlank : false })}
							  , {header: "순번",				width: 50,	sortable: true,	dataIndex: "TAX_INFO_SEQ",		editor: new Ext.form.TextField({ allowBlank : false })}
							  , {header: "작성일자",		    width: 50,	sortable: true,	dataIndex: "PREPARE_DATE",		editor: new Ext.form.TextField({ allowBlank : false })}
							  , {header: "품목코드",			width: 100,	sortable: true,	dataIndex: "ITEM_CODE",			editor: new Ext.form.TextField({ allowBlank : false }),renderer:changeBLUE}
							  , {header: "품목명",			width: 100,	sortable: true,	dataIndex: "ITEM_NAME",			editor: new Ext.form.TextField({ allowBlank : false })}
							  , {header: "규격",				width: 50,	sortable: true,	dataIndex: "STANDARD",			editor: new Ext.form.TextField({ allowBlank : false })}
							  , {header: "단위",				width: 50,	sortable: true,	dataIndex: "UNIT",				editor: new Ext.form.TextField({ allowBlank : false })}
							  , {header: "수량",				width: 50,	sortable: true,	dataIndex: "CNT",				editor: new Ext.form.TextField({ allowBlank : false }),align : 'right'}
							  , {header: "단가",				width: 70,	sortable: true,	dataIndex: "UNIT_PRICE",		editor: new Ext.form.TextField({ allowBlank : false }),renderer: "korMoney" , align : 'right'}
							  , {header: "금액",				width: 70,	sortable: true,	dataIndex: "AMT",				editor: new Ext.form.TextField({ allowBlank : false }),renderer: "korMoney" , align : 'right'}
							  , {header: "세액",				width: 70,	sortable: true,	dataIndex: "TAX",				editor: new Ext.form.TextField({ allowBlank : false }),renderer: "korMoney" , align : 'right'}
							  , {header: "비고",				width: 100,	sortable: true,	dataIndex: "NOTE",				editor: new Ext.form.TextField({ allowBlank : false })}
							  , {header: "최종변경자ID",		width: 10,	sortable: true,	dataIndex: "FINAL_MOD_ID",		editor: new Ext.form.TextField({ allowBlank : false }), hidden:true}
							  , {header: "최종변경일시",		width: 10,	sortable: true,	dataIndex: "FINAL_MOD_DATE",	editor: new Ext.form.TextField({ allowBlank : false }), hidden:true}
							  , {header: "최초등록일",		width: 10,	sortable: true,	dataIndex: "REG_DATE",			editor: new Ext.form.TextField({ allowBlank : false }), hidden:true}
							  , {header: "최초등록자",		width: 10,	sortable: true,	dataIndex: "REG_ID",			editor: new Ext.form.TextField({ allowBlank : false }), hidden:true}
							  ];

// 맵핑 필드
var	mappingColumns_edit_3rd	= [ {name: "FLAG" 				, type:"string" , mapping: "FLAG"}				// 상태 
							  , {name: "PUR_SAL_TYPE_CODE"  , type:"string" , mapping: "PUR_SAL_TYPE_CODE"}	// 매입매출구분코드 
							  , {name: "TAX_ID" 			, type:"string" , mapping: "TAX_ID"}			// 세금계산서ID     
							  , {name: "PUR_SAL_ID" 		, type:"string" , mapping: "PUR_SAL_ID"}		// 매(입)출ID_수주ID
							  , {name: "CUSTOM_CODE" 		, type:"string" , mapping: "CUSTOM_CODE"}		// 거래처코드       
							  , {name: "TAX_INFO_SEQ" 		, type:"string" , mapping: "TAX_INFO_SEQ"}		// 순번  
							  , {name: "PREPARE_DATE" 		, type:"string" , mapping: "PREPARE_DATE"}		// 작성일자
							  , {name: "ITEM_CODE" 			, type:"string" , mapping: "ITEM_CODE"}			// 품목코드         
							  , {name: "ITEM_NAME" 			, type:"string" , mapping: "ITEM_NAME"}			// 품목명           
							  , {name: "STANDARD" 			, type:"string" , mapping: "STANDARD"}			// 규격             
							  , {name: "UNIT" 				, type:"string" , mapping: "UNIT"}				// 단위             
							  , {name: "CNT" 				, type:"string" , mapping: "CNT"}				// 수량             
							  , {name: "UNIT_PRICE" 		, type:"string" , mapping: "UNIT_PRICE"}		// 단가             
							  , {name: "AMT" 				, type:"string" , mapping: "AMT"}				// 금액             
							  , {name: "TAX" 				, type:"string" , mapping: "TAX"}				// 세액             
							  , {name: "NOTE" 				, type:"string" , mapping: "NOTE"}				// 비고             
							  , {name: "FINAL_MOD_ID" 		, type:"string" , mapping: "FINAL_MOD_ID"}		// 최종변경자ID     
							  , {name: "FINAL_MOD_DATE" 	, type:"string" , mapping: "FINAL_MOD_DATE"}	// 최종변경일시     
							  , {name: "REG_DATE" 			, type:"string" , mapping: "REG_DATE"}			// 최초등록일       
							  , {name: "REG_ID" 			, type:"string" , mapping: "REG_ID"}			// 최초등록자       
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
	Ext.get('proc_status_code').dom.disabled = true;
	Ext.get('proc_status_code').set({value : 'C10'}, false);	// 'C10 : 수주등록'   
	
	Ext.get('est_id').dom.disabled  	   = true;		// 견적Id
	Ext.get('est_version').dom.disabled    = true;		// 버전
	Ext.get('pjt_id').dom.disabled  	   = true;		// 프로젝트id
	Ext.get('pjt_name').dom.disabled  	   = true;		// 프로젝트명
	
	Ext.get('roll_type_code').dom.disabled  = false;	// 업무구분
    Ext.get('ord_type_code').dom.disabled   = false;	// 수주구분
    Ext.get('ord_custom_code').dom.disabled = false;	// 거래처코드
    Ext.get('ord_custom_name').dom.disabled = false;	// 거래처
    Ext.get('customCodeBtn').dom.disabled   = false;	// 거래처검색버튼
    Ext.get('estIdBtn').dom.disabled        = false;	// 견적ID검색버튼
    
    // 수주담당자, 수주부서 설정
	Ext.get('ord_emp_num').set({value : '${admin_id}'}, false);  
	Ext.get('ord_dept_code').set({value : '${dept_code}'}, false);  
	Ext.get('ord_dept_name').set({value : '${dept_nm}'}, false);  
	Ext.get('ord_emp_name').set({value : '${admin_nm}'}, false);  
	
	Ext.get('ord_id').set({value : Ext.get('new_ord_id').getValue()}, false);
	
    Ext.get('final_mod_id').set({value : '${admin_id}'}, false);
    Ext.get('final_mod_name').set({value : '${admin_nm}'}, false);
	Ext.get('final_mod_date').set({value : getTimeStamp().trim()}, false);
	
	try{
		GridClass_edit_1st.store.commitChanges();	// 변경된 record를 commit
		GridClass_edit_1st.store.removeAll();		// store자료를 삭제
		GridClass_edit_2nd.store.commitChanges();
		GridClass_edit_2nd.store.removeAll();
		GridClass_edit_3rd.store.commitChanges();
		GridClass_edit_3rd.store.removeAll();
	}catch(e){
		
	}
}
 
/***************************************************************************
 * 설  명 : 저장버튼 클릭
 ***************************************************************************/
function fnSave(divValue){  	

	// 변경된 수주 품목정보 Grid의 record 
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
    	
	// 변경된 납품처 시스템 사양정보 Grid의 record
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
    	
    // 변경된 세금계산서 분할 발행정보 Grid의 record
	var record3 = GridClass_edit_3rd.store.getModifiedRecords();	  
	// 변경된 record의 자료를 json형식으로
    var edit3rdJson = "[";
	    for (var i = 0; i < record3.length; i++) {
	    	
	      var custom_code = record3[i].data.CUSTOM_CODE;
	      var pur_sal_id = record3[i].data.PUR_SAL_ID;
	    	
	      if(custom_code == ''){
	    	  record3[i].set('CUSTOM_CODE',Ext.get('ord_custom_code').getValue());
	      }	
	    	
	      if(pur_sal_id == ''){
	    	  record3[i].set('PUR_SAL_ID',Ext.get('ord_id').getValue());
	      }
	    	
	      edit3rdJson += Ext.util.JSON.encode(record3[i].data);				
	      if (i < (record3.length-1)) {
	        edit3rdJson += ",";
	      }
	    }
    	edit3rdJson += "]"
 	
    	Ext.get('roll_type_code').dom.disabled   = false;	// 업무구분
		Ext.get('ord_type_code').dom.disabled   = false;	// 수주구분
		Ext.get('ord_custom_code').dom.disabled   = false;	// 거래처코드
		Ext.get('ord_custom_name').dom.disabled   = false;	// 거래처
		
	Ext.Ajax.request({   
		url: "/ord/order/saveOrderInfoManage.sg"   
		,success: function(response){						// 조회결과 성공시
					// 조회된 결과값, store명
					handleSuccess(response,GridClass_1st,'save');
		          } 
		,failure: handleFailure   	    // 조회결과 실패시  
		,form   : document.detailForm	// 상세 FORM	
		,params : {					    // 조회조건을 DB로 전송하기위해서 조건값 설정
				  // 페이지정보
					limit_1st          	: limit_1st
			  	  , start_1st          	: start_1st
			  	  , edit1stData		   	: edit1stJson 		// 수주품목정보
  				  , edit2ndData        	: edit2ndJson		// 납품처시스템 사양정보
  				  , edit3rdData        	: edit3rdJson		// 세금계산서 분할 발행정보
  				  
  				  // disable처리된 필드값
  				  , ord_id			   	: Ext.get('ord_id').getValue()		  	  	// 수주ID  
				  , proc_status_code    : Ext.get('proc_status_code').getValue()	// 진행상태
				  , est_version         : Ext.get('est_version').getValue()	  		// 버전
				  , est_id				: Ext.get('est_id').getValue()	  			// 견적ID
				  , pjt_id   			: Ext.get('pjt_id').getValue()	  			// 프로젝트ID
				  , ord_total_amt   	: Ext.get('ord_total_amt').getValue()	  	// 수주총액  
	  			  , discnt_total_amt   	: Ext.get('discnt_total_amt').getValue()	// 할인총액  
	  			  , ord_aply_total_amt 	: Ext.get('ord_aply_total_amt').getValue()	// 적용총액  
	  			  , ord_aply_total_tax 	: Ext.get('ord_aply_total_tax').getValue()	// 적용총세액
				  // 검색정보
			  	  
				 
				  
				  , src_pjt_id   	   	: '<%=request.getParameter("src_pjt_id")%>'
			  	  , src_pjt_name   	   	: '<%=request.getParameter("src_pjt_name")%>'
			  	    
			  	  , src_ord_custom_name : '' 
			  	  , src_ord_type_code  	: '' 
			  	  , src_ord_id         	: ''
			  	  , src_ord_name       	: ''
			  	  , src_ord_date_start 	: ''
			  	  , src_ord_date_end   	: ''
			  	  , saveDiv			    : divValue								    // 등록(save), 수정(update)구분
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
	
	var toDay = getTimeStamp();	
	toDay = toDay.replaceAll('-','');
	toDay = addDate(toDay, 'M', -3);
	toDay = toDay.substring(0,4)+"-"+toDay.substring(4,6)+"-"+toDay.substring(6,8);
	var fromDay = toDay;
	toDay = getTimeStamp().trim();
	 
  	
	//신규 버튼 -> 상세필드 초기화
	Ext.get('detailClearBtn').on('click', function(e){
		fnInitValue();		   
	});		
	
	/*	 
	// 수주기간_검색시작일자
	var startDate = new Ext.form.DateField({
    	applyTo: 'src_ord_date_start',
		allowBlank: false,
		format:'Y-m-d',
		editable : false,
		value : fromDay
	});
   	
	// 수주기간_검색종료일자
	var endDate = new Ext.form.DateField({
    	applyTo: 'src_ord_date_end',
		allowBlank: false,
		format:'Y-m-d',
		editable : false,
		value : toDay
	});
	
	// 수주일자
	var est_date = new Ext.form.DateField({
    	applyTo: 'ord_date',
		allowBlank: false,
		format:'Y-m-d',
		editable : false
	});
		
	// 검수에정일
	var pjt_date_from = new Ext.form.DateField({
    	applyTo: 'inspect_exp_date',
		allowBlank: false,
		format:'Y-m-d',
		editable : false
	});
	
	// 납품예정일
	var delivery_exp_date = new Ext.form.DateField({
    	applyTo: 'delivery_exp_date',
		allowBlank: false,
		format:'Y-m-d',
		editable : false
	});
	
	// 설치예정일
	var pjt_date_to = new Ext.form.DateField({
    	applyTo: 'set_exp_date',
		allowBlank: false,
		format:'Y-m-d',
		editable : false
	});
	
	// 매출예정일
	var pjt_date_to = new Ext.form.DateField({
    	applyTo: 'sal_exp_date',
		allowBlank: false,
		format:'Y-m-d',
		editable : false
	});
	*/
	
	// 수주담당자검색 버튼
   	// 여러건을 팝업으로 부터 전송 받을경우 param뒤에 &multiSelectYn=Y 를 추가 
	Ext.get('ordEmpNumBtn').on('click', function(e){
		var param = '';
		fnEmployeePop(param);
	});
	
	// 수주담당자 
	Ext.get('ord_emp_name').on('change', function(e){
		
		ord_emp_name = Ext.get('ord_emp_name').getValue();
		
		if(ord_emp_name.length == 0 || ord_emp_name == ""){
			Ext.get('ord_emp_num').set({value : ''}, false);
			Ext.get('ord_dept_name').set({value : ''}, false);
			Ext.get('ord_dept_code').set({value : ''}, false);
		}
		
	});
	
	// 견적ID 검색
	// 여러건을 팝업으로 부터 전송 받을경우 param뒤에 &multiSelectYn=Y 를 추가 
	Ext.get('estIdBtn').on('click', function(e){
		var param = '';
		fnEstIdPop(param);
	});
	
	// 거래처버튼
   	Ext.get('customCodeBtn').on('click', function(e){
		var param = '';
		fnCostomerPop(param)
	});
	
	//거래처 이름 수정시
	Ext.get('ord_custom_name').on('change', function(e){	
		var ord_custom_name = Ext.get('ord_custom_name').getValue();
		if(ord_custom_name == ""){
			Ext.get('ord_custom_code').set({value: ''} , false);				
		}
	});
	
	// 거래처담당자검색 버튼
   	// 여러건을 팝업으로 부터 전송 받을경우 param뒤에 &multiSelectYn=Y 를 추가 
	Ext.get('costomerNumBtn').on('click', function(e){
		var param = '';
		fnCostomerPop(param)
	});
	
	// 거래처담당자 
	Ext.get('ord_customer_name').on('change', function(e){
		
		ord_customer_name = Ext.get('ord_customer_name').getValue();
		
		if(ord_customer_name.length == 0 || ord_customer_name == ""){
			Ext.get('ord_customer_num').set({value : ''}, false);
			Ext.get('ord_customer_dept').set({value : ''}, false);
		}
		
	});
	
	/*
	// 결제일
	var account_date = new Ext.form.DateField({
    	applyTo: 'account_date',
		allowBlank: false,
		format:'Y-m-d',
		editable : false
	});
	
	
	// 유지보수기간(시작일)
	var maintenance_from = new Ext.form.DateField({
    	applyTo: 'maintenance_from',
		allowBlank: false,
		format:'Y-m-d',
		editable : false
	});
	
	// 유지보수기간(종료일)
	var maintenance_to = new Ext.form.DateField({
    	applyTo: 'maintenance_to',
		allowBlank: false,
		format:'Y-m-d',
		editable : false
	});
	*/
	
/*   	
   	// 프로젝트 검색팝업
   	Ext.get('pjtIdBtn').on('click', function(e){
		param = "?fieldName=pjt_id";
		fnPjtPop(param);
	});
*/	
			
	//저장 버튼 -> 데이터를 server로 전송
	Ext.get('saveBtn').on('click', function(e){	
		if(fnValidation()){
			Ext.MessageBox.confirm('Confirm', '저장하시겠습니까?', showResultSave);
		};
	});
	
	//수정 버튼 -> 데이터를 server로 전송
	Ext.get('updateBtn').on('click', function(e){	
		if(fnValidation()){
			Ext.MessageBox.confirm('Confirm', '수정하시겠습니까?', showResultUpdate);
		};	
	});
	
	// 세금계산서 계산
	Ext.get('taxBtn').on('click', function(e){	
		
		var tax_issue_type = Ext.get('tax_issue_type').getValue();
		var tax_mod_issue_cnt = Ext.get('tax_mod_issue_cnt').getValue();
		var ord_total_amt = Ext.get('ord_total_amt').getValue();
		var flag = Ext.get('flag').getValue();
		
		if(ord_total_amt == '' || ord_total_amt == 0){
			Ext.Msg.alert('확인', '수주총액이 0 입니다.');
			return false;
		}
		
		if(tax_issue_type == ''){
			Ext.Msg.alert('확인', '세금계산서발행구분을 선택하세요.');
			return false;
		}else if(tax_issue_type == '20'){
			if(tax_mod_issue_cnt == 0 || tax_mod_issue_cnt == ''){
				Ext.Msg.alert('확인', '세금계산서분할횟수를 입력하세요.');
				return false;
			}
		}
		if(flag == 'R'){
			Ext.MessageBox.confirm('Confirm', '세금계산서 정보를 변경하시겠습니까?', changeTax);
		}else{
			changeTax('yes');
		}
	});
	
	// 세금계산서발행구분
	//Ext.get('tax_issue_type').on('change', function(e){	
	//	Ext.MessageBox.confirm('Confirm', '세금계산서 정보를 변경하시겠습니까?', changeTax);
	//});
	
	// 세금계산서분할횟수
	//Ext.get('tax_mod_issue_cnt').on('change', function(e){	
	//	Ext.MessageBox.confirm('Confirm', '세금계산서 정보를 변경하시겠습니까?', changeTax);
	//});
	
	Ext.get('final_mod_id').dom.disabled    = true;
	Ext.get('final_mod_name').dom.disabled    = true;
	Ext.get('final_mod_date').dom.disabled  = true;
	Ext.get('ord_id').dom.disabled  		= true;
	
	Ext.get('ord_total_amt').dom.disabled  	   = true;	// 수주총액
	Ext.get('discnt_total_amt').dom.disabled   = true;  // 할인총액
	Ext.get('ord_aply_total_amt').dom.disabled = true;  // 적용총액
	Ext.get('ord_aply_total_tax').dom.disabled = true;  // 적용총세액
	
	Ext.get('new_ord_id').set({value : '${new_ord_id}'}, false);

	fnInitValue();
	
}); // end Ext.onReady

// 저장, 수정버튼 클릭시 '예','아니오' 
function showResultSave(btn){
   	if(btn == 'yes'){
   		fnSave('save');
   	}    	
};

function showResultUpdate(btn){
   	if(btn == 'yes'){
   		fnSave('update');
   	}    	
};

// 세금계산서 정보 변경
function changeTax(btn){
	if(btn == 'yes'){

		GridClass_edit_3rd.store.commitChanges();
		GridClass_edit_3rd.store.removeAll();
		
		// 이전에 저장된 세금계산서 정보를 삭제하위 위한값 설정
		Ext.get('taxDeleteYn').set({value : 'Y'}, false);   	
		
		var Plant = GridClass_edit_3rd.grid.getStore().recordType; 
 		var p ;
		var tax_issue_type = Ext.get('tax_issue_type').getValue();
		var tax_mod_issue_cnt = Ext.get('tax_mod_issue_cnt').getValue();
 
	    var today = new Date();	
	    var todayYMD =
	    leadingZeros(today.getFullYear(), 4) + '-' + leadingZeros(today.getMonth() + 1, 2) + '-' + leadingZeros(today.getDate(), 2) + ' ' ;
	
		var toDay = todayYMD;

		// 일괄발행
		if(tax_issue_type == '10'){
			// toDay = toDay.substring(0,4)+"-"+toDay.substring(4,6)+"-"+toDay.substring(6,8);
			   p = new Plant({ 
	        		    FLAG			: 'I' 
	        		  , PUR_SAL_ID		: Ext.get('ord_id').getValue()
		    		  , CUSTOM_CODE     : Ext.get('ord_custom_code').getValue()
		    		  , ITEM_CODE       : ''
		    		  , ITEM_NAME		: ''
		    		  , UNIT			: ''
		    		  , CNT 			: '1'
		    		  , PREPARE_DATE    : toDay
		    		  , UNIT_PRICE		: (Ext.get('ord_aply_total_amt').getValue()).replaceAll(',','')
		    		  , AMT				: (Ext.get('ord_aply_total_amt').getValue()).replaceAll(',','')
		    		  , TAX				: (Ext.get('ord_aply_total_tax').getValue()).replaceAll(',','')
    				  }); 
			   GridClass_edit_3rd.grid.stopEditing();
			   GridClass_edit_3rd.store.insert(0, p);
			
		// 분할발행	
		}else if(tax_issue_type == '20'){
			if(tax_mod_issue_cnt == 0 || tax_mod_issue_cnt == ''){
				alert("분할횟수를 입력하숑");
				return false;
			}else{
				
				// 단가(초기값)
				var ord_aply_total_amt = Ext.get('ord_aply_total_amt').getValue();
				    ord_aply_total_amt = parseInt(ord_aply_total_amt.replaceAll(',',''));
				var amt = parseInt(parseInt(ord_aply_total_amt) / parseInt(tax_mod_issue_cnt));
				var totAmt = 0;
				var taxAmt = 0;
								
				for(i=0 ; i< tax_mod_issue_cnt ; i++){
					
					// 작성일자 설정
					toDay = todayYMD;
					toDay = toDay.replaceAll('-','');
					toDay = addDate(toDay, 'M', i);
					toDay = toDay.substring(0,4)+"-"+toDay.substring(4,6)+"-"+toDay.substring(6,8);

					// 단가 계산
                    totAmt += amt;
			
					// 마지막 단가에 나머지 값을 넣어주기
                    if(i == tax_mod_issue_cnt-1){
                    	amt = amt + (ord_aply_total_amt - totAmt);
                    }
					
					// 세액계산
					taxAmt = parseInt(Math.floor(amt*0.1));
    
					p = new Plant({ 
	        		    FLAG			: 'I'  
	        		  , PUR_SAL_ID		: Ext.get('ord_id').getValue()
		    		  , CUSTOM_CODE     : Ext.get('ord_custom_code').getValue()
		    		  , ITEM_CODE       : ''
		    		  , ITEM_NAME		: ''
		    		  , UNIT			: ''
		    		  , CNT 			: '1'
		    		  , PREPARE_DATE    : toDay
		    		  , UNIT_PRICE		: amt
		    		  , AMT				: amt
		    		  , TAX				: taxAmt
    				  }); 
					   GridClass_edit_3rd.grid.stopEditing();
					   GridClass_edit_3rd.store.insert(i, p);

				} // end for
				
			}// end else
		}else{
			
		}
		
		GridClass_edit_3rd.grid.startEditing(0, 0);
		
   	}
}

/***************************************************************************
 * 설  명 : 그리드의 페이지 클릭시 검색조건값을 DB로 전송
 ***************************************************************************/
// 수주 Rev 팝업 ********************************************
function fnEstimateInfoRev(param){
	var sURL      = "/est/estimate/estimateInfoManageRevPop.sg"+param;
	var dlgWidth  = 399;
	var dlgHeight = 414;
	var winName   = "estimate";
	fnOpenPop(sURL, dlgWidth, dlgHeight, winName);
} 

function fnEstimateInfoManagePopValue(records){
	
	// 전송받은 값이 한건일 경우
    var record = records[0].data;				
    
    Ext.get('flag').set({value : 'I'}, false);   													// 상태                               
	Ext.get('ord_id').set({value : fnFixNull(record.EST_ID)}, false);   							// 수주ID               
	Ext.get('est_version').set({value : fnFixNull(record.FINAL)}, false);   						// 버전                   
	Ext.get('proc_status_code').set({value : fnFixNull(record.PROC_STATUS_CODE)}, false);   		// 진행상태코드         
	Ext.get('est_type_code').set({value : fnFixNull(record.EST_TYPE_CODE)}, false);   				// 수주구분             
	Ext.get('custom_name').set({value : fnFixNull(record.CUSTOM_NAME)}, false);   					// 거래처코드           
	Ext.get('est_date').set({value : fnFixNull(record.EST_DATE)}, false);   						// 수주일자             
	Ext.get('roll_type_code').set({value : fnFixNull(record.ROLL_TYPE_CODE)}, false);   			// 업무구분코드         
	Ext.get('pjt_id').set({value : fnFixNull(record.PJT_ID)}, false);   							// 프로젝트ID           
	Ext.get('est_name').set({value : fnFixNull(record.EST_NAME)}, false);   						// 수주명               
	Ext.get('est_dept_code').set({value : fnFixNull(record.EST_DEPT_CODE)}, false);   				// 수주부서코드        
	Ext.get('est_emp_num').set({value : fnFixNull(record.EST_EMP_NUM)}, false);   					// 수주담당자사번       
	Ext.get('custom_code').set({value : fnFixNull(record.CUSTOM_CODE)}, false);   					// 거래처코드           
	Ext.get('costomer_num').set({value : fnFixNull(record.COSTOMER_NUM)}, false);   				// 거래처담당자번호     
	Ext.get('est_valid_type_code').set({value : fnFixNull(record.EST_VALID_TYPE_CODE)}, false);   	// 수주유효기간구분코드 
	Ext.get('delivery_exp_date').set(  {value : fnFixNull(record.DELIVERY_EXP_DATE)}, false);   	// 납품예정일           
	//Ext.get('delivery_custom_code').set({value : fnFixNull(record.DELIVERY_CUSTOM_CODE)}, false); // 납품처코드           
	Ext.get('pay_conditon').set({value : fnFixNull(record.PAY_CONDITON)}, false);   				// 지불조건             
	Ext.get('est_total_amt').set({value : fnFixNull(MoneyComma(record.EST_TOTAL_AMT))}, false);   				// 수주총액             
	Ext.get('discnt_total_amt').set({value : fnFixNull(MoneyComma(record.DISCNT_TOTAL_AMT))}, false);   		// 할인총액             
	Ext.get('est_aply_total_amt').set({value : fnFixNull(MoneyComma(record.EST_APLY_TOTAL_AMT))}, false);   	// 수주적용총액         
	Ext.get('est_aply_total_tax').set({value : fnFixNull(MoneyComma(record.EST_APLY_TOTAL_TAX))}, false);   	// 수주적용총세액       
	Ext.get('pjt_date_from').set({value : fnFixNull(record.PJT_DATE_FROM)}, false);   				// 프로젝트기간 FROM    
	Ext.get('pjt_date_to').set({value : fnFixNull(record.PJT_DATE_TO)}, false);   					// 구축기간 To          
	Ext.get('ref_desc').set({value : fnFixNull(record.REF_DESC)}, false);   						// 침고시항             
	Ext.get('final_mod_id').set({value : ''}, false);   											// 최종변경자ID         
	Ext.get('final_mod_date').set({value : ''}, false);  	 										// 최종변경일시         
    
	var keyValue1 = fnFixNull(record.EST_VERSION);		 // 버전
	var keyValue2 = fnFixNull(record.EST_ID);		     // 수주ID
	var value3 = fnFixNull(record.FINAL);
	
	fnSearchEdit1st(keyValue1);
	fnSearchEdit2nd(keyValue1);
	
}
 
// 프로젝트 **************************************************
function fnPjtPop(param){
	var sURL      = "/dev/pjdInfo/pjtInfoPop.sg"+param;
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
    }
}

// 견적ID  **************************************************
function fnEstIdPop(param){
	var sURL      = "/est/estimate/estimatePop.sg"+param;
	var dlgWidth  = 399;
	var dlgHeight = 444;
	var winName   = "project";
	fnOpenPop(sURL, dlgWidth, dlgHeight, winName);
}

function fnEstIdPopValue(records, fieldName){
	
	// 전송받은 값이 한건일 경우
    var record = records[0].data;	
	
	  var estId = record.EST_ID;
      var estVersion = record.EST_VERSION;
	
	  Ext.get('est_id').set({value:fnFixNull(record.EST_ID)} , false);							// 견적Id
	  Ext.get('est_version').set({value:fnFixNull(record.EST_VERSION)} , false);				// 버전
	  Ext.get('roll_type_code').set({value: fnFixNull(record.ROLL_TYPE_CODE)} , false);			// 업무구분
	  Ext.get('pjt_id').set({value:fnFixNull(record.PJT_ID)} , false);							// 프로젝트id
	  Ext.get('pjt_name').set({value:fnFixNull(record.PJT_NAME)} , false);						// 프로젝트명
	  Ext.get('ord_name').set({value:fnFixNull(record.PJT_NAME)+'_수주'} , false);				// 수주명
	  Ext.get('pjt_date_from').set({value:fnFixNull(record.PJT_DATE_FROM)} , false);			// 프로젝트기간FROM
	  Ext.get('pjt_date_to').set({value:fnFixNull(record.PJT_DATE_TO)} , false);				// 프로젝트기간TO
	  Ext.get('dve_custom_code').set({value:fnFixNull(record.DELIVERY_CUSTOM_CODE)} , false);	// 납품처코드
	  Ext.get('ord_custom_code').set({value:fnFixNull(record.CUSTOM_CODE)} , false);			// 수주처코드
	  Ext.get('ord_custom_name').set({value:fnFixNull(record.CUSTOM_NAME)} , false);			// 수주처
	  Ext.get('ord_customer_num').set({value:fnFixNull(record.COSTOMER_NUM)} , false);			// 거래처담당자번호
	  Ext.get('ord_customer_name').set({value:fnFixNull(record.COSTOMER_NAME)} , false);		// 거래처담당자
	  Ext.get('ord_customer_dept').set({value:fnFixNull(record.COSTOMER_DEPT)} , false);		// 거래처담당자부서
	  Ext.get('ord_type_code').set({value:fnFixNull(record.EST_TYPE_CODE)} , false);			// 수주구분
	  Ext.get('ord_total_amt').set({value:fnFixNull(MoneyComma(record.EST_TOTAL_AMT))} , false);			// 수주총액
	  Ext.get('discnt_total_amt').set({value:fnFixNull(MoneyComma(record.DISCNT_TOTAL_AMT))} , false);		// 할인총액
	  Ext.get('ord_aply_total_amt').set({value:fnFixNull(MoneyComma(record.EST_APLY_TOTAL_AMT))} , false);	// 적용총액
	  Ext.get('ord_aply_total_tax').set({value:fnFixNull(MoneyComma(record.EST_APLY_TOTAL_TAX))} , false);	// 적용총세액
	  
	  Ext.get('roll_type_code').dom.disabled   = true;	// 업무구분
	  Ext.get('ord_type_code').dom.disabled   = true;	// 수주구분
	  Ext.get('ord_custom_code').dom.disabled   = true;	// 거래처코드
	  Ext.get('ord_custom_name').dom.disabled   = true;	// 거래처
	  Ext.get('customCodeBtn').dom.disabled   = true;	// 거래처검색버튼
	  
	  fnEstItemSearch(estId, estVersion);
	  fnEstSpecSearch(estId, estVersion);
}

// 견적품목 정보 조회
function fnEstItemSearch(estId,estVersion){
	
	Ext.Ajax.request({
		url: "/est/estimate/result_edit_1st.sg" 
		,success: function(response){							// 조회결과 성공시
					GridClass_edit_1st.store.commitChanges();	// 변경된 record를 commit
					GridClass_edit_1st.store.removeAll();		// store자료를 삭제
						
					// 조회된 결과값, store명
					var json = Ext.util.JSON.decode(response.responseText);
					GridClass_edit_1st.store.loadData(json);
					
					var rowCnt1st = GridClass_edit_1st.store.getCount();  // Grid의 총갯수
					
					if(rowCnt1st > 0){
						for(i = 0 ; i < rowCnt1st ; i++){
							var record1 = GridClass_edit_1st.store.getAt(i);
							record1.set('FLAG', 'I');
						} // end for	
					}
		          }
		,failure: handleFailure 
		,params : {
				   // 페이지 		
					 limit			: limit_edit_1st
				   , start			: start_edit_1st
				   // 키 value
				   , est_version	: estVersion
				   , est_id			: estId
				  }				
	}); // end Ext.Ajax.request   
}

// 수주처 시스템사양 정보 조회
function fnEstSpecSearch(estId,estVersion){
	
	Ext.Ajax.request({
		url: "/est/estimate/result_edit_2nd.sg" 
		,success: function(response){						// 조회결과 성공시
					// 조회된 결과값, store명
					GridClass_edit_2nd.store.commitChanges();
					GridClass_edit_2nd.store.removeAll();
					
					var json = Ext.util.JSON.decode(response.responseText);
					GridClass_edit_2nd.store.loadData(json);
						
					var rowCnt2nd = GridClass_edit_2nd.store.getCount();  // Grid의 총갯수
				
					if(rowCnt2nd > 0){
						for(j = 0 ; j < rowCnt2nd ; j++){
							var record2 = GridClass_edit_2nd.store.getAt(j);
							record2.set('FLAG', 'I');
						} // end for
					}
		          }
		,failure: handleFailure 
		,params : {
				   // 페이지 		
					 limit			: limit_edit_2nd
				   , start			: start_edit_2nd
				   // 키 value
				   , est_version	: estVersion
				   , est_id			: estId
				  }				
	}); // end Ext.Ajax.request   
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

// 거래처담당자 검색 결과 return Value
function fnCostomerPopValue(records){
		
	// 전송받은 값이 한건일 경우
    var record = records[0].data;				

    Ext.get('ord_customer_name').set({value:fnFixNull(record.CUSTOMER_NAME)} , false);
    Ext.get('ord_customer_num').set({value:fnFixNull(record.CUSTOMER_NUM)} , false);
    Ext.get('ord_customer_dept').set({value:fnFixNull(record.CUSTOMER_DEPT)} , false);
    Ext.get('ord_custom_name').set({value:fnFixNull(record.CUSTOM_NAME)} , false);
    Ext.get('ord_custom_code').set({value:fnFixNull(record.CUSTOM_CODE)} , false);
   
}

// 수주담당자 검색팝업 ****************************************
function fnEmployeePop(param){
	var sURL      = "/com/employee/employeePop.sg"+param;
	var dlgWidth  = 399;
	var dlgHeight = 396;
	var winName   = "담당자";
	fnOpenPop(sURL, dlgWidth, dlgHeight, winName);
}

// 수주담당자 검색 결과 return Value
function fnEmployeePopValue(records,fileName){
		
	// 전송받은 값이 한건일 경우
    var record = records[0].data;				

    Ext.get('ord_emp_num').set({value:fnFixNull(record.EMP_NUM)} , false);
    Ext.get('ord_emp_name').set({value:fnFixNull(record.KOR_NAME)} , false);
    Ext.get('ord_dept_code').set({value:fnFixNull(record.DEPT_CODE)} , false);
    Ext.get('ord_dept_name').set({value:fnFixNull(record.DEPT_NAME)} , false);
	
	// 전송 받은 값이 여러건일 경우
	/*
    var popGrid1stJson = "[";
    for (var i = 0; i < records.length; i++) {
      popGrid1stJson += Ext.util.JSON.encode(records[i].data);				
      if (i < (records.length-1)) {
        popGrid1stJson += ",";
      }
    }
   	popGrid1stJson += "]"
	*/    	
}

// 품목 팝업 ****************************************
function fnItemPop(param){
	var sURL      = "/com/item/itemSearchPop.sg"+param;
	var dlgWidth  = 399;
	var dlgHeight = 396;
	var winName   = "item";
	fnOpenPop(sURL, dlgWidth, dlgHeight, winName);
}

function fnItemSearchPopValue(records, grid_name){
	
	// popUp에서 선택된 아이템 코드값
	var item_code = records[0].data.ITEM_CODE;
	var item_name = records[0].data.ITEM_NAME;
	var unit_price_01 = records[0].data.UNIT_PRICE_01;
	
	if(grid_name == 'GridClass_edit_1st'){
		// 선택된 row
		var record = GridClass_edit_1st.grid.selModel.getSelected(); 
		// 값을 설정
		record.set('ITEM_CODE', item_code);			// 품목코드
		record.set('ITEM_NAME', item_name);			// 품목명
		record.set('UNIT_PRICE', unit_price_01);	// 단가
		
		fnEdit1stAfterRowDeleteEvent();
	}else if(grid_name == 'GridClass_edit_3rd'){
		// 선택된 row
		var record = GridClass_edit_3rd.grid.selModel.getSelected(); 
		// 값을 설정
		record.set('ITEM_CODE', item_code);			// 품목코드
		record.set('ITEM_NAME', item_name);			// 품목명
	}
}

// 팝업
function fnOpenPop(sURL, dlgWidth, dlgHeight, winName){
  var xPos=(window.screen.width) ? (window.screen.width-dlgWidth)/2 : 0;
  var yPos=(window.screen.height) ? (window.screen.height-dlgHeight)/2 : 0;
  var sFeatures = "titlebar=no, scrollbars=no,location=no ,menubar=no, resizable=no, status=yes, width="+dlgWidth+",height="+dlgHeight+",left="+xPos+", top="+yPos;
  window.open(sURL,winName, sFeatures);
}
	
/***************************************************************************
 * 설  명 : 에디트 그리드의 CELL을 클릭하였을 경우 이벤트
 ***************************************************************************/
function  fnEdit1stCellClickEvent(grid, rowIndex, columnIndex, e){
	//품목 코드 팝업
	if(columnIndex == '3'){	
		param = "?grid_name=GridClass_edit_1st";
		fnItemPop(param);
		//var temp= GridClass_edit_1st.store;
		//var gridName = "GridClass_edit_1st";
		//var grid_name = "grid_name=" + gridName;
		//var grid_row = "grid_row=" + rowIndex;
		//var grid_fieldName = "grid_fieldName=" + 'ITEM_CODE';
		//var param = "?"+grid_name +'&'+ grid_row +'&'+ grid_fieldName;
		//fnCustomPop(param);
	}
}
/***************************************************************************
 * 설  명 : 에디트 그리드의 CELL을 수정하였을 경우 이벤트
 ***************************************************************************/
function  fnEdit1stAfterCellEdit(obj){
	var editedRow = obj.row;
	var editedColumn = obj.column;
	var editedValue = obj.value;
	var fieldName = obj.field;
	
	// 해당 컬럼의 값이 변경 되었을 경우
	if( fieldName == 'CNT' || fieldName == 'UNIT_PRICE' 
	 || fieldName == 'DISCOUNT_RATIO' || fieldName == 'PAY_FREE_CODE' 
	 || fieldName == 'APLY_AMT'){
		fnCalculateItemAmt(fieldName);
	}// end if
}

// 추가된 행이 삭제 되었을 때
function fnEdit1stAfterRowDeleteEvent(){
		fnCalculateItemAmt('');
}

// 수주 품목정보 금액 계산
function fnCalculateItemAmt(fieldName){
	
	var rowCnt = GridClass_edit_1st.store.getCount();  // Grid의 총갯수
	var estTotalAmt = 0;		// 수주총액
	var discntTotalAmt = 0 ; 	// 할인총액
	var estAplyTotalAmt = 0;    // 수주적용총액
	var estAplyTotalTax = 0;	// 수주적용총세액
	
	if( rowCnt > 0){
		//row 숫자만큼 돌면서 수량*단가를 가져옴
		for(i = 0 ; i < rowCnt ; i++){
				
			var record = GridClass_edit_1st.store.getAt(i);
			var discount_ratio = parseFloat(GridClass_edit_1st.store.data.items[i].data.DISCOUNT_RATIO)/100 ;   // 할인율
			var pay_free_code = GridClass_edit_1st.store.data.items[i].data.PAY_FREE_CODE;						// 유무상구분
			var aply_amt = parseFloat(GridClass_edit_1st.store.data.items[i].data.APLY_AMT) ;   				// 할인율
			
			//alert('1 : '+aply_amt);
			
			// 금액 = 수량 * 단가
			var rowAMT = parseInt(GridClass_edit_1st.store.data.items[i].data.CNT) * parseInt(GridClass_edit_1st.store.data.items[i].data.UNIT_PRICE);
			
			// 적용금액이 변경되면
			if(fieldName == 'APLY_AMT'){
				discount_ratio = 1 - (aply_amt  / rowAMT  ) ;
			//	alert('2 : '+discount_ratio);
			//	alert('3 : '+Math.round(discount_ratio*100));
				record.set('DISCOUNT_RATIO', fnIsNaN(Math.round(discount_ratio*1000)/10));	// 할인율
			}
			
			// 적용 금액 = 금액  - (금액 * 할인율)
			var discountAMT = parseInt(rowAMT - ( rowAMT * discount_ratio ));
			// 적용단가 = 적용금액 / 수량
			var aplyUnitPrice = parseInt(discountAMT / parseInt(GridClass_edit_1st.store.data.items[i].data.CNT));
			// 적용세액 = 적용금액 * 0.1
			var aplyTaxAMT = parseInt(discountAMT * 0.1); 
			
			// 유무상구분이 (0:무상)일 경우
			if(pay_free_code == '0'){
				discountAMT = 0;		// 적용금액
				aplyUnitPrice  = 0;		// 적용단가
				aplyTaxAMT = 0;			// 적용세액
			}
		
			record.set('AMT', fnIsNaN(rowAMT));						// 금액
			record.set('APLY_AMT', fnIsNaN(discountAMT));			// 적용금액
			record.set('APLY_TAX', fnIsNaN(aplyTaxAMT));			// 적용세액
			record.set('APLY_UNIT_PRICE', fnIsNaN(aplyUnitPrice));	// 적용단가
			
			estTotalAmt += fnIsNaN(parseInt(rowAMT));   // 수주총액
			estAplyTotalAmt += fnIsNaN(discountAMT);    // 수주적용총액
			estAplyTotalTax += fnIsNaN(aplyTaxAMT);		// 수주적용총세액
	
		} // end for	
		
	// 할인총액 = 수주총액 - 수주적용총액
	discntTotalAmt = estTotalAmt - estAplyTotalAmt;
	
	// 수주총액
	Ext.get('ord_total_amt').set({value:MoneyComma(estTotalAmt)});
	// 할인총액
	Ext.get('discnt_total_amt').set({value:MoneyComma(discntTotalAmt)});
	// 수주적용총액
	Ext.get('ord_aply_total_amt').set({value: MoneyComma(estAplyTotalAmt)});
	// 수주적용총세액
	Ext.get('ord_aply_total_tax').set({value:MoneyComma(estAplyTotalTax)});
			
	} // end if
}

function fnValidation(){
	
	
	var ord_type_code = Ext.get('ord_type_code').getValue();		// 수주구분
	var ord_date = Ext.get('ord_type_code').getValue();				// 수주일자
	var ord_name = Ext.get('ord_name').getValue();					// 수주명
	var roll_type_code = Ext.get('roll_type_code').getValue();		// 업무구분
	var ord_emp_num =Ext.get('ord_emp_num').getValue();				// 수주담당자
	var est_id = Ext.get('est_id').getValue();						// 견적ID
	var ord_custom_code = Ext.get('ord_custom_code').getValue();    // 거래처코드
	var maintenance_from = Ext.get('maintenance_from').getValue();  // 유지보수기간_From
	var maintenance_to = Ext.get('maintenance_to').getValue();    	// 유지보수기간_To
	
	//alert(ord_type_code.length);
	
	if(ord_type_code == '' || ord_type_code.length == 0){
		Ext.Msg.alert('확인', '수주구분을 선택해주세요');
		return false;
	}
	
	if(ord_date == '' || ord_date.length == 0){
		Ext.Msg.alert('확인', '수주일자를 입력해주세요');
		return false;
	}
	
	if(ord_name == '' || ord_name.length == 0){
		Ext.Msg.alert('확인', '수주명을 입력해주세요');
		return false;
	}
	
	if(roll_type_code == '' || roll_type_code.length == 0){
		Ext.Msg.alert('확인', '업무구분을 선택해주세요');
		return false;
	}
	
	if(ord_emp_num == '' || ord_emp_num.length == 0){
		Ext.Msg.alert('확인', '수주담당자를 입력해주세요');
		return false;
	}
	
	if(est_id == '' || est_id.length == 0){
		Ext.Msg.alert('확인', '수주ID를 입력해주세요');
		return false;
	}
	
	if(ord_custom_code == '' || ord_custom_code.length == 0){
		Ext.Msg.alert('확인', '거래처를 입력해주세요');
		return false;
	}
	
	if(maintenance_from.length > 0 && maintenance_to.length > 0){
		if(fnCalDate(maintenance_from,maintenance_to,'D') < 0){
			Ext.Msg.alert('확인', '유지보수기간시작일이 유지보수종료일보다 이전입니다.'); 
			return false;
		}
	}
	
	var rowCnt = GridClass_edit_1st.store.getCount();  // Grid의 총갯수
	
	//row 숫자만큼 돌면서 품목코드 입력확인
	for(i = 0 ; i < rowCnt ; i++){
		var record = GridClass_edit_1st.store.getAt(i);
		var item_code = record.data.ITEM_CODE;
		if(item_code ==''){
			Ext.Msg.alert('확인', '견적 정보관리의 ['+(i+1)+']번째행의 품목코드를 입력해주세요')
			return false;
		}
	}
	
	// 거래처 정보확인
	var taxCnt = GridClass_edit_3rd.store.getCount();  // Grid의 총갯수
	
	if(taxCnt > 0){
		var biz_type = Ext.get('biz_type').getValue();		// 업태
		var biz_kind = Ext.get('biz_kind').getValue();		// 업종
		
		if(biz_type == '' || biz_type.length == 0){
			Ext.Msg.alert('확인', '거래처의 업태정보가 없습니다.\n 거래처정보를 확인해 주세요.'); 
			return false;
		}
		
		if(biz_kind == '' || biz_kind.length == 0){
			Ext.Msg.alert('확인', '거래처의 업종정보가 없습니다.\n 거래처정보를 확인해 주세요.'); 
			return false;
		}
	}
	
	
	return true;
}

/***************************************************************************
 * 설  명 : 에디트 그리드의 CELL을 클릭하였을 경우 이벤트
 ***************************************************************************/
function  fnEdit3rdCellClickEvent(grid, rowIndex, columnIndex, e){
	//거래처 코드 팝업
	if(columnIndex == '2'){			
		 
	}
	//품목 코드 팝업
	if(columnIndex == '7'){
		param = "?grid_name=GridClass_edit_3rd";
		fnItemPop(param);
	}
}
</script>

</head>
<body class=" ext-gecko ext-gecko3">
	<input type="hidden" id="new_ord_id" name="new_ord_id"/>
	<input type="hidden" id="biz_type" name="biz_type"/>
	<input type="hidden" id="biz_kind" name="biz_kind"/>
	<table border="0" width="1000" height="200">
		<tr>
			<!----------------- 수주기본정보 GRID START ----------------->
			<td width="40%" valign="top">
				<div id="grid_1st" style="margin-top: 0em;"></div>
			</td>
			<!----------------- 수주기본정보 GRID END ----------------->
			<td width="60%" valign="top">
				<div class=" x-panel x-form-label-left" style="margin-top: 0em; width: 100%;"><%-- 0em <- 1em으로 수정하면 상위 공백 --%>
					<!----------------- SEARCH Hearder Start	 ----------------->
					<div class="x-panel-tl">
						<div class="x-panel-tr">
							<div class="x-panel-tc">
								<div class="x-panel-header x-unselectable" style="-moz-user-select: none;">
									<span class="x-panel-header-text">수주 기본정보</span>
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
									<form id="detailForm" name="detailForm" method="POST" class="x-panel-body x-form" style="padding: 0px 0px 0pt; width: 580px;">
									<input type="hidden" id="flag" name="flag"/>
									<input type="hidden" id="taxDeleteYn" name="taxDeleteYn"/>
									<!-- 1_ROW Start -->
									<div class="x-column-inner" style="width: 100%; margin-top: 0em;">
										<div class=" x-panel x-column" style="width: 100%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 94%;">
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
														<label class="x-form-item-label" style="width: auto;" for="ord_type_code" ><font color="red">* </font>수주구분:</label>
														<div style="padding-left: 80px;" class="x-form-element">
															<select name="ord_type_code" id="ord_type_code" title="수주구분" style="width: 165;" type="text" class=" x-form-select x-form-field" >
																<option value="">선택하세요</option>
																<c:forEach items="${EST_TYPE_CODE}" var="data" varStatus="status">
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
														<label class="x-form-item-label" style="width: auto;" for="ord_date" ><font color="red">* </font>수주일자:</label>
														<div style="padding-left: 90px;" class="x-form-element">
															<input type="text" name="ord_date" id="ord_date" autocomplete="off" size="28" class=" x-form-text x-form-field" style="width: auto;"
															onFocus="restoreDateString(this, this.value)" onKeydown="_chkKeyPressNumPoint(this)" onblur="isValidDate(this, this.value)" />
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
														<label class="x-form-item-label" style="width: auto;" for="ord_id" >수주ID:</label>
														<div style="padding-left: 80px;" class="x-form-element">
															<input type="text" name="ord_id" id="ord_id" autocomplete="off" size="28" class=" x-form-text x-form-field" style="width: auto;">
<%--															<input type="text" name="est_version" id="est_version" autocomplete="off" size="3" class=" x-form-text x-form-field" style="width: auto;">--%>
<%--															<select name="est_version" id="est_version" title="버전" style="width: 28%;" type="text" class=" x-form-text x-form-field" >--%>
<%--																<option value="">선택하세요</option>--%>
<%--																<c:forEach items="${EST_VERSION}" var="data" varStatus="status">--%>
<%--																	<option value="${data.COM_CODE}"><c:out value="${data.COM_CODE_NAME}"/></option>--%>
<%--																</c:forEach>--%>
<%--															</select>--%>
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
														<label class="x-form-item-label" style="width: auto;" for="ord_name" ><font color="red">* </font>수주명:</label>
														<div style="padding-left: 90px;" class="x-form-element">
															<input type="text" name="ord_name" id="ord_name" autocomplete="off" size="28" class=" x-form-text x-form-field" style="width: auto;">
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
														<label class="x-form-item-label" style="width: auto;" for="roll_type_code" ><font color="red">* </font>업무구분:</label>
														<div style="padding-left: 80px;" class="x-form-element">
															<select name="roll_type_code" id="roll_type_code" title="업무구분" style="width: 165;" type="text" class=" x-form-select x-form-field" >
																<option value="">선택하세요</option>
																<c:forEach items="${ROLL_TYPE_CODE}" var="data" varStatus="status">
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
										<div class=" x-panel x-column" style="width: 50%;" >
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label class="x-form-item-label" style="width: auto;" for="ord_emp_name" ><font color="red">* </font>수주담당자:</label>
														<div style="padding-left: 90px;" class="x-form-element">
															<table style="width: 165px;" cellspacing="0" class="x-btn  x-btn-noicon">
																<tr>
																	<td>
																		<input type="hidden" name="ord_emp_num" id="ord_emp_num" autocomplete="off" size="6" class=" x-form-text x-form-field" style="width: auto;">
																		<input type="hidden" name="ord_dept_code" id="ord_dept_code" autocomplete="off" size="6" class=" x-form-text x-form-field" style="width: auto;">
																		<input type="text" name="ord_dept_name" id="ord_dept_name" autocomplete="off" size="9" class=" x-form-text x-form-field" style="width: auto;">
																		<input type="text" name="ord_emp_name" id="ord_emp_name" autocomplete="off" size="6" class=" x-form-text x-form-field" style="width: auto;">
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
																							<button type="button" id="ordEmpNumBtn" class=" x-btn-text">검색</button>
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
										<div class=" x-panel x-column" style="width: 50%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label class="x-form-item-label" style="width: auto;" for="custom_code" ><font color="red">* </font>견적ID:</label>
														<div style="padding-left: 80px;" class="x-form-element">
															<table style="width: 165px;" cellspacing="0" class="x-btn  x-btn-noicon">
																<tr>
																	<td>
																		<input type="text" name="est_id" id="est_id" autocomplete="off" size="15" class=" x-form-text x-form-field" style="width: auto;">
																		<input type="text" name="est_version" id="est_version" autocomplete="off" size="1" class=" x-form-text x-form-field" style="width: auto;">
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
																							<button type="button" id="estIdBtn" class=" x-btn-text">검색</button>
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
														<label class="x-form-item-label" style="width: auto;" for="pjt_id" >프로젝트ID:</label>
														<div style="padding-left: 90px;" class="x-form-element">
															<table style="width:165px;" cellspacing="0" class="x-btn  x-btn-noicon">
																<tr>
																	<td>
																		<input type="text" name="pjt_id" id="pjt_id" autocomplete="off" size="11" class=" x-form-text x-form-field" style="width: auto;">
																		<input type="text" name="pjt_name" id="pjt_name" autocomplete="off" size="11" class=" x-form-text x-form-field" style="width: auto;">
																		<input type="hidden" name="pjt_date_from" id="pjt_date_from" autocomplete="off" size="9" class=" x-form-text x-form-field" style="width: auto;">		
																		<input type="hidden" name="pjt_date_to" id="pjt_date_to" autocomplete="off" size="9" class=" x-form-text x-form-field" style="width: auto;">		
																	</td>
<%--																	<td>--%>
<%--																		 Button Start--%>
<%--																		<table cellspacing="0" class="x-btn  x-btn-noicon" style="width: 20px;" align="right">--%>
<%--																			<tbody class="x-btn-small x-btn-icon-small-left">--%>
<%--																				<tr>--%>
<%--																					<td class="x-btn-tl">--%>
<%--																						<i>&nbsp;</i>--%>
<%--																					</td>--%>
<%--																					<td class="x-btn-tc">--%>
<%--																					</td>--%>
<%--																					<td class="x-btn-tr">--%>
<%--																						<i>&nbsp;</i>--%>
<%--																					</td>--%>
<%--																				</tr>--%>
<%--																				<tr>--%>
<%--																					<td class="x-btn-ml">--%>
<%--																						<i>&nbsp;</i>--%>
<%--																					</td>--%>
<%--																					<td class="x-btn-mc">--%>
<%--																						<em unselectable="on" class="">--%>
<%--																							<button type="button" id="pjtIdBtn" class=" x-btn-text">검색</button>--%>
<%--																						</em>--%>
<%--																					</td>--%>
<%--																					<td class="x-btn-mr">--%>
<%--																						<i>&nbsp;</i>--%>
<%--																					</td>--%>
<%--																				</tr>--%>
<%--																				<tr>--%>
<%--																					<td class="x-btn-bl">--%>
<%--																						<i>&nbsp;</i>--%>
<%--																					</td>--%>
<%--																					<td class="x-btn-bc">--%>
<%--																					</td>--%>
<%--																					<td class="x-btn-br">--%>
<%--																						<i>&nbsp;</i>--%>
<%--																					</td>--%>
<%--																				</tr>--%>
<%--																			</tbody>--%>
<%--																		</table>--%>
<%--																		 Button End--%>
<%--																	</td>--%>
																
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
														<label class="x-form-item-label" style="width: auto;" for="ord_custom_code" ><font color="red">* </font>거래처:</label>
														<div style="padding-left: 80px;" class="x-form-element">
															<table style="width: 165px;" cellspacing="0" class="x-btn  x-btn-noicon">
																<tr>
																	<td>
																		<input type="hidden" name="ord_custom_code" id="ord_custom_code" autocomplete="off" size="10" class=" x-form-text x-form-field" style="width: auto;">
																		<input type="text" name="ord_custom_name" id="ord_custom_name" autocomplete="off" size="22" class=" x-form-text x-form-field" style="width: auto;">
																		<input type="hidden" name="dve_custom_code" id="dve_custom_code" autocomplete="off" size="10" class=" x-form-text x-form-field" style="width: auto;">
																		<input type="hidden" name="dve_custom_name" id="dve_custom_name" autocomplete="off" size="12" class=" x-form-text x-form-field" style="width: auto;">
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
																							<button type="button" id="customCodeBtn" class=" x-btn-text">검색</button>
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
														<label class="x-form-item-label" style="width: auto;" for="ord_customer_name" >거래처담당자:</label>
														<div style="padding-left: 90px;" class="x-form-element">
															<table style="width: 165px;" cellspacing="0" class="x-btn  x-btn-noicon">
																<tr>
																	<td>
																		<input type="text" name="ord_customer_dept" id="ord_customer_dept" autocomplete="off" size="9" class=" x-form-text x-form-field" style="width: auto;">
																		<input type="text" name="ord_customer_name" id="ord_customer_name" autocomplete="off" size="7" class=" x-form-text x-form-field" style="width: auto;">
																		<input type="hidden" name="ord_customer_num" id="ord_customer_num" autocomplete="off" size="10" class=" x-form-text x-form-field" style="width: auto;">	
																		<input type="hidden" name="dve_customer_num" id="dve_customer_num" autocomplete="off" size="10" class=" x-form-text x-form-field" style="width: auto;">
																		<input type="hidden" name="dve_customer_name" id="dve_customer_name" autocomplete="off" size="13" class=" x-form-text x-form-field" style="width: auto;">
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
																							<button type="button" id="costomerNumBtn" class=" x-btn-text">검색</button>
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
									<!-- 6_ROW End -->

									<!-- 7_ROW Start -->
									<div class="x-column-inner" style="width: 100%;">
										<div class=" x-panel x-column" style="width: 50%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label class="x-form-item-label" style="width: auto;" for="inspect_exp_date" >검수예정일:</label>
														<div style="padding-left: 80px;" class="x-form-element">
															<input type="text" name="inspect_exp_date" id="inspect_exp_date" autocomplete="off" size="28" class=" x-form-text x-form-field" style="width: auto;">
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
														<label class="x-form-item-label" style="width: auto;" for="delivery_exp_date" >납품예정일:</label>
														<div style="padding-left: 90px;" class="x-form-element">
															<input type="text" name="delivery_exp_date" id="delivery_exp_date" autocomplete="off" size="28" class=" x-form-text x-form-field" style="width: auto;">
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
										<div class=" x-panel x-column" style="width: 50%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label class="x-form-item-label" style="width: auto;" for="set_exp_date" >설치예정일:</label>
														<div style="padding-left: 80px;" class="x-form-element">
															<input type="text" name="set_exp_date" id="set_exp_date" autocomplete="off" size="28" class=" x-form-text x-form-field" style="width: auto;">
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
														<label class="x-form-item-label" style="width: auto;" for="sal_exp_date" >매출예정일:</label>
														<div style="padding-left: 90px;" class="x-form-element">
															<input type="text" name="sal_exp_date" id="sal_exp_date" autocomplete="off" size="28" class=" x-form-text x-form-field" style="width: auto;">
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
														<label class="x-form-item-label" style="width: auto;" for="account_date" >결제일:</label>
														<div style="padding-left: 80px;" class="x-form-element">
															<input type="text" name="account_date" id="account_date" autocomplete="off" size="28" class=" x-form-text x-form-field" style="width: auto;"
															onFocus="restoreDateString(this, this.value)" onKeydown="_chkKeyPressNumPoint(this)" onblur="isValidDate(this, this.value)" />
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
														<label class="x-form-item-label" style="width: auto;" for="ord_total_amt" >수주총액:</label>
														<div style="padding-left: 80px;" class="x-form-element">
															<input type="text" name="ord_total_amt" id="ord_total_amt" autocomplete="off" size="28" class=" x-form-text x-form-field" style="width: auto; text-align:right; IME-MODE:disabled;" 
															onkeyPress="return _chkKeyPressNumOnly(this)" onBlur="_numFormat(this, Math.round(this.value));" onfocus="_removeComma(this, this.value)" />
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
														<label class="x-form-item-label" style="width: auto;" for="discnt_total_amt" >할인총액:</label>
														<div style="padding-left: 90px;" class="x-form-element">
															<input type="text" name="discnt_total_amt" id="discnt_total_amt" autocomplete="off" size="28" class=" x-form-text x-form-field" style="width: auto; text-align:right; IME-MODE:disabled;" onkeyPress="return _chkKeyPressNumOnly(this)" onBlur="_numFormat(this, Math.round(this.value));" onfocus="_removeComma(this, this.value)">
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
														<label class="x-form-item-label" style="width: auto;" for="ord_aply_total_amt" >수주적용총액:</label>
														<div style="padding-left: 80px;" class="x-form-element">
															<input type="text" name="ord_aply_total_amt" id="ord_aply_total_amt" autocomplete="off" size="28" class=" x-form-text x-form-field" style="width: auto; text-align:right; IME-MODE:disabled;" onkeyPress="return _chkKeyPressNumOnly(this)" onBlur="_numFormat(this, Math.round(this.value));" onfocus="_removeComma(this, this.value)">
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
														<label class="x-form-item-label" style="width: auto;" for="ord_aply_total_tax" >수주적용총세액:</label>
														<div style="padding-left: 80px;" class="x-form-element">
															<input type="text" name="ord_aply_total_tax" id="ord_aply_total_tax" autocomplete="off" size="28" class=" x-form-text x-form-field" style="width: auto; text-align:right; IME-MODE:disabled;" onkeyPress="return _chkKeyPressNumOnly(this)" onBlur="_numFormat(this, Math.round(this.value));" onfocus="_removeComma(this, this.value)">
														</div>
														<div class="x-form-clear-left">
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>
									<!-- 11_ROW End -->
									
									<!-- 12_ROW Start -->
									<div class="x-column-inner" style="width: 100%;">
										<div class=" x-panel x-column" style="width: 50%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label class="x-form-item-label" style="width: auto;" for="tax_issue_type" >세금계산서발행구분:</label>
														<div style="padding-left: 80px;" class="x-form-element">
															<select name="tax_issue_type" id="tax_issue_type" style="width: 130px;" type="text" class=" x-form-select x-form-field" >
																<option value="">선택하세요</option>
																<c:forEach items="${TAX_ISSUE_TYPE_CODE}" var="data" varStatus="status">
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
														<label class="x-form-item-label" style="width: auto;" for="tax_mod_issue_cnt" >세금계산서분할횟수</label>
														<div style="padding-left: 80px;" class="x-form-element">
															<table style="width: 140px;" cellspacing="0" class="x-btn  x-btn-noicon">
																<tr>
																	<td>
																		<input type="text" name="tax_mod_issue_cnt" id="tax_mod_issue_cnt" autocomplete="off" size="15" class=" x-form-text x-form-field" style="width: auto;">
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
																							<button type="button" id="taxBtn" class=" x-btn-text">계산</button>
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
									<!-- 12_ROW End -->
									
									<!-- 13_ROW Start -->
									<div class="x-column-inner" style="width: 100%;">
										<div class=" x-panel x-column" style="width: 50%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label class="x-form-item-label" style="width: auto;" for="pay_free_code" >유지보수구분:</label>
														<div style="padding-left: 80px;" class="x-form-element">
															<select name="pay_free_code" id="pay_free_code" style="width: 165;" type="text" class=" x-form-select x-form-field" >
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
														<label class="x-form-item-label" style="width: auto;" for="maintenance_from" >유지보수기간</label>
														<div style="padding-left: 90px;" class="x-form-element">
															<table>
																<tr>
																	<td>
																		<input type="text" name="maintenance_from" id="maintenance_from" autocomplete="off" size="10" class=" x-form-text x-form-field" style="width: auto;"
																		onFocus="restoreDateString(this, this.value)" onKeydown="_chkKeyPressNumPoint(this)" onblur="isValidDate(this, this.value)" />		
																	</td>
																	<td>
																		~
																	</td>
																	<td>
																		<input type="text" name="maintenance_to" id="maintenance_to" autocomplete="off" size="9" class=" x-form-text x-form-field" style="width: auto;"
																		onFocus="restoreDateString(this, this.value)" onKeydown="_chkKeyPressNumPoint(this)" onblur="isValidDate(this, this.value)" />		
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
									<!-- 13_ROW End -->
									
									<!-- 14_ROW Start -->
									<div class="x-column-inner" style="width: 100%;">
										<div class=" x-panel x-column" style="width: 100%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label class="x-form-item-label" style="width: auto;" for="aply_job_descript" >적용업무설명:</label>
														<div style="padding-left: 80px;" class="x-form-element">
															<textarea name="aply_job_descript" id="aply_job_descript" autocomplete="off" class=" x-form-text x-form-field" style="width:460; height:60px"></textarea>
														</div>
														<div class="x-form-clear-left">
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>
									<!-- 14_ROW End -->
									
									<!-- 15_ROW Start -->
									<div class="x-column-inner" style="width: 100%;">
										<div class=" x-panel x-column" style="width: 100%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label class="x-form-item-label" style="width: auto;" for="summary" >특이사항:</label>
														<div style="padding-left: 80px;" class="x-form-element">
															<textarea name="summary" id="summary" autocomplete="off" class=" x-form-text x-form-field" style="width:460; height:60px"></textarea>
														</div>
														<div class="x-form-clear-left">
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>
									<!-- 15_ROW End -->
									
									<!-- 16_ROW Start -->
									<div class="x-column-inner" style="width: 100%;">
										<div class=" x-panel x-column" style="width: 50%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label class="x-form-item-label" style="width: auto;" for="proc_status_code" >진행상태:</label>
														<div style="padding-left: 80px;" class="x-form-element">
															<select name="proc_status_code" id="proc_status_code" title="진행상태코드" style="width: 165;" type="text" class=" x-form-select x-form-field" >
																<option value="">선택하세요</option>
																<c:forEach items="${FLOW_STATUS_CODE}" var="data" varStatus="status">
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
									<!-- 16_ROW End -->
									
									<!-- 17_ROW Start -->
									<div class="x-column-inner" style="width: 100%;">
										<div class=" x-panel x-column" style="width: 50%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label class="x-form-item-label" style="width: auto;" for="final_mod_name" >최종변경자:</label>
														<div style="padding-left: 80px;" class="x-form-element">
															<input type="text" name="final_mod_name" id="final_mod_name" autocomplete="off" size="28" class=" x-form-text x-form-field" style="width: auto;">
															<input type="hidden" name="final_mod_id" id="final_mod_id" autocomplete="off" size="35" class=" x-form-text x-form-field" style="width: auto;">
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
															<input type="text" name="final_mod_date" id="final_mod_date" autocomplete="off" size="28" class=" x-form-text x-form-field" style="width: auto;">
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>
									<!-- 17_ROW End -->
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
			<!----------------- 납품처 시스템사양 정보 GRID START ----------------->
			<td width="100%" valign="top" colspan="2">
				<div id="edit_grid_3rd" style="margin-top: 0em;"></div>
			</td>
			<!----------------- 납품처 시스템사양 정보 GRID END ----------------->
		</tr>
		<tr>
			<!----------------- 수주 품목정보 GRID START ----------------->
			<td width="100%" valign="top" colspan="2">
				<div id="edit_grid_1st" style="margin-top: 0em;"></div>
			</td>
			<!----------------- 수주 품목정보 GRID END ----------------->
		</tr>
		<tr>
			<!----------------- 납품처 시스템사양 정보 GRID START ----------------->
			<td width="100%" valign="top" colspan="2">
				<div id="edit_grid_2nd" style="margin-top: 0em;"></div>
			</td>
			<!----------------- 납품처 시스템사양 정보 GRID END ----------------->
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