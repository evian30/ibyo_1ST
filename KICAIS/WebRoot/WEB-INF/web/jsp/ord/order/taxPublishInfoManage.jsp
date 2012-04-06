<%--
  Class Name  : taxPublishInfoManage.jsp
  Description : 세금계산서발행정보
  Modification Information
 
      수정일                   수정자                 수정내용
  -------      --------    ---------------------------
  2011. 6. 2   고기범            최초 생성   

  author   : 고기범
  since    : 2011. 6. 8.
  version  : 1.0
   
  Copyright (C) 2011 by SG All right reserved.
--%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/web/jsp/common/inc/commonInc.jsp" %>
<script type="text/javascript" src="/resource/common/js/sgis-comm-inc.js" ></script> 
<script type="text/javascript" src="/resource/common/js/common/common-msg-box.js" ></script> 
<script type="text/javascript" src="/resource/common/js/ajax.js" ></script>

<script type="text/javascript" src="/resource/common/js/grid/grid_1st.js"></script>
<script type="text/javascript" src="/resource/common/js/grid/grid_edit_1st.js"></script> 
<script type="text/javascript" src="/resource/common/js/grid/grid_edit_3rd.js"></script>
<script type="text/javascript">
/***************************************************************************
 *  세금계산서발행정보 -- 초기값 설정 
 ***************************************************************************/
var	gridHeigth_1st 	 	= 420; 							// 그리드 전체 높이
var	gridWidth_1st		= 408;							// 그리드 전체 폭
var gridTitle_1st 		= "세금계산서 발행정보";	  		// 그리드 제목
var	render_1st			= "grid_1st";					// 렌더(화면에 그려질) 할 id 
var	pageSize_1st		= 23;	  						// 그리드 페이지 사이즈	
var	proxyUrl_1st		= "/ord/order/taxPublishInfoManageList.sg";  // 결과 값 페이지
var limit_1st			= pageSize_1st;
var start_1st			= 0;

// 그리드의 페이지 클릭시 검색조건값을 DB로 전송
function fnPagingValue_1st(){
	
	try{
		GridClass_1st.store.setBaseParam('start'		 	  	,start_1st);
	    GridClass_1st.store.setBaseParam('limit'		 	  	,limit_1st);
		GridClass_1st.store.setBaseParam('src_pjt_id'      	  	,Ext.get('src_pjt_id').getValue());		  	  // 프로젝트ID   
		GridClass_1st.store.setBaseParam('src_pjt_name'    	  	,Ext.get('src_pjt_name').getValue());		  // 프로젝트
		// GridClass_1st.store.setBaseParam('src_ord_custom_code' 	,Ext.get('src_ord_custom_code').getValue());  // 거래처코드  
		GridClass_1st.store.setBaseParam('src_ord_custom_name' 	,Ext.get('src_ord_custom_name').getValue());  // 거래처명
		GridClass_1st.store.setBaseParam('src_ord_type_code'  	,Ext.get('src_ord_type_code').getValue());    // 수주구분 
		GridClass_1st.store.setBaseParam('src_ord_id' 		  	,Ext.get('src_ord_id').getValue());           // 수주ID
		GridClass_1st.store.setBaseParam('src_ord_name'		  	,Ext.get('src_ord_name').getValue());         // 수주명
		GridClass_1st.store.setBaseParam('src_ord_date_start' 	,Ext.get('src_ord_date_start').getValue());   // 수주기간(검색시작일)
		GridClass_1st.store.setBaseParam('src_ord_date_end'   	,Ext.get('src_ord_date_end').getValue());     // 수주기간(검색종료일)
		GridClass_1st.store.setBaseParam('src_unissued' 		,Ext.get('src_unissued').getValue());   		// 계산서미발행
		GridClass_1st.store.setBaseParam('src_issue' 			,Ext.get('src_issue').getValue());   			// 계산서발행
	}catch(e){

	}
}
   
// Grid의 컬럼 설정 
var userColumns_1st =  [ {header : '상태'                	,width :   0 ,sortable : true , dataIndex : 'FLAG'              ,hidden : true}              
					   , {header : '발행상태'				,width :  60 ,sortable : true , dataIndex : 'TAX_PUBLISH' 			}
					   , {header : '수주ID'					,width : 110 ,sortable : true , dataIndex : 'ORD_ID' 			}			
					   , {header : '수주일자'				,width :   0 ,sortable : true , dataIndex : 'ORD_DATE' 			,hidden : true}      
					   , {header : '수주구분코드'			,width :   0 ,sortable : true , dataIndex : 'ORD_TYPE_CODE' 	,hidden : true}      
					   , {header : '수주명'					,width : 140 ,sortable : true , dataIndex : 'ORD_NAME' 			}      
					   , {header : '견적ID'					,width :   0 ,sortable : true , dataIndex : 'EST_ID' 			,hidden : true}      
					   , {header : '수주구분'				,width :   0 ,sortable : true , dataIndex : 'ORD_TYPE_NAME' 	,hidden : true}
					   , {header : '버전'					,width :   0 ,sortable : true , dataIndex : 'EST_VERSION' 		,hidden : true}      
					   , {header : '업무구분코드'			,width :   0 ,sortable : true , dataIndex : 'ROLL_TYPE_CODE' 	,hidden : true}			
					   , {header : '프로젝트ID'				,width :   0 ,sortable : true , dataIndex : 'PJT_ID' 			,hidden : true}      
					   , {header : '프로젝트'				,width :   0 ,sortable : true , dataIndex : 'PJT_NAME' 			,hidden : true}
					   , {header : '수주부서코드'			,width :   0 ,sortable : true , dataIndex : 'ORD_DEPT_CODE' 	,hidden : true}      
					   , {header : '수주부서'				,width :   0 ,sortable : true , dataIndex : 'ORD_DEPT_NAME' 	,hidden : true}
					   , {header : '수주담당자번호'			,width :   0 ,sortable : true , dataIndex : 'ORD_EMP_NUM' 		,hidden : true}      
					   , {header : '수주담당자'				,width :   0 ,sortable : true , dataIndex : 'ORD_EMP_NAME' 		,hidden : true}
					   , {header : '수주처코드(거래처)'		,width :   0 ,sortable : true , dataIndex : 'ORD_CUSTOM_CODE' 	,hidden : true} 
					   , {header : '거래처명'				,width : 108 ,sortable : true , dataIndex : 'ORD_CUSTOM_NAME' 	}
					   , {header : '납품처코드'				,width :   0 ,sortable : true , dataIndex : 'DVE_CUSTOM_CODE' 	,hidden : true}      
					   , {header : '납품처'					,width :   0 ,sortable : true , dataIndex : 'DVE_CUSTOM_NAME' 	,hidden : true}
					   , {header : '검수예정일'				,width :   0 ,sortable : true , dataIndex : 'INSPECT_EXP_DATE' 	,hidden : true}      
					   , {header : '납품예정일'				,width :   0 ,sortable : true , dataIndex : 'DELIVERY_EXP_DATE' ,hidden : true}      
					   , {header : '설치예정일시'			,width :   0 ,sortable : true , dataIndex : 'SET_EXP_DATE' 		,hidden : true}      
					   , {header : '매출예정일'				,width :   0 ,sortable : true , dataIndex : 'SAL_EXP_DATE' 		,hidden : true}      
					   , {header : '결제일'					,width :   0 ,sortable : true , dataIndex : 'ACCOUNT_DATE' 		,hidden : true}      
					   , {header : '수주총액'				,width :   0 ,sortable : true , dataIndex : 'ORD_TOTAL_AMT' 	,hidden : true}      
					   , {header : '할인총액'				,width :   0 ,sortable : true , dataIndex : 'DISCNT_TOTAL_AMT' 	,hidden : true}      
					   , {header : '수주적용총액'			,width :   0 ,sortable : true , dataIndex : 'ORD_APLY_TOTAL_AMT',hidden : true}      
					   , {header : '수주적용총세액'			,width :   0 ,sortable : true , dataIndex : 'ORD_APLY_TOTAL_TAX',hidden : true}      
					   , {header : '적용업무설명'			,width :   0 ,sortable : true , dataIndex : 'APLY_JOB_DESCRIPT' ,hidden : true}      
					   , {header : '특이사항'				,width :   0 ,sortable : true , dataIndex : 'SUMMARY' 			,hidden : true}      
					   , {header : '유무상구분코드'			,width :   0 ,sortable : true , dataIndex : 'PAY_FREE_CODE' 	,hidden : true}      
					   , {header : '유지보수기간_From'		,width :   0 ,sortable : true , dataIndex : 'MAINTENANCE_FROM' 	,hidden : true}      
					   , {header : '유지보수기간_To'			,width :   0 ,sortable : true , dataIndex : 'MAINTENANCE_TO' 	,hidden : true}      
					   , {header : '프로젝트기간FROM'		,width :   0 ,sortable : true , dataIndex : 'PJT_DATE_FROM' 	,hidden : true}      
					   , {header : '프로젝트기간To'			,width :   0 ,sortable : true , dataIndex : 'PJT_DATE_TO' 		,hidden : true}      
					   , {header : '세금계산서발행구분'		,width :   0 ,sortable : true , dataIndex : 'TAX_ISSUE_TYPE' 	,hidden : true}      
					   , {header : '세금계산서분할발행회수' 	,width :   0 ,sortable : true , dataIndex : 'TAX_MOD_ISSUE_CNT' ,hidden : true}      
					   , {header : '진행상태코드'          	,width :   0 ,sortable : true , dataIndex : 'PROC_STATUS_CODE' 	,hidden : true}      
					   , {header : '최종변경자ID'			,width :   0 ,sortable : true , dataIndex : 'FINAL_MOD_ID' 		,hidden : true}      
					   , {header : '최종변경자'				,width :   0 ,sortable : true , dataIndex : 'FINAL_MOD_NAME' 	,hidden : true}
					   , {header : '최종변경일시'			,width :   0 ,sortable : true , dataIndex : 'FINAL_MOD_DATE' 	,hidden : true}      
					   , {header : '최초등록일'				,width :   0 ,sortable : true , dataIndex : 'REG_DATE' 			,hidden : true}      
					   , {header : '최초등록자'				,width :   0 ,sortable : true , dataIndex : 'REG_ID' 			,hidden : true}      
					   , {header : '수주처담당자번호'		,width :   0 ,sortable : true , dataIndex : 'ORD_CUSTOMER_NUM' 	,hidden : true}      
					   , {header : '수주처담당자'			,width :   0 ,sortable : true , dataIndex : 'ORD_CUSTOMER_NAME' ,hidden : true}
					   , {header : '수주처담당자부서'		,width :   0 ,sortable : true , dataIndex : 'ORD_CUSTOMER_DEPT' ,hidden : true}
					   , {header : '납품처담당자번호' 		,width :   0 ,sortable : true , dataIndex : 'DVE_CUSTOMER_NUM' 	,hidden : true}
					   , {header : '납품처담당자' 			,width :   0 ,sortable : true , dataIndex : 'DVE_CUSTOMER_NAME' ,hidden : true}
					   , {header : '업태' 					,width :   0 ,sortable : true , dataIndex : 'BIZ_TYPE' 			,hidden : true}
					   , {header : '업종' 					,width :   0 ,sortable : true , dataIndex : 'BIZ_KIND' 			,hidden : true}
					   , {header : '수정가능여부'   			,width :   0 ,sortable : true , dataIndex : 'MODIFY_YN'        	,hidden : true}
					   , {header : ' 거래처구분'   			,width :   0 ,sortable : true , dataIndex : 'CUSTOM_TYPE'       ,hidden : true}                
					   , {header : ' 개인_사업자구분'   		,width :   0 ,sortable : true , dataIndex : 'PER_BIZ_TYPE'      ,hidden : true}          
					   , {header : ' 사업자번호'   			,width :   0 ,sortable : true , dataIndex : 'BIZ_NUM'        	,hidden : true}                    
					   , {header : ' 대표자명'   			,width :   0 ,sortable : true , dataIndex : 'CEO_NAME'        	,hidden : true}					           
					   , {header : ' 업태'   				,width :   0 ,sortable : true , dataIndex : 'BIZ_TYPE'        	,hidden : true}                        
					   , {header : ' 업종'   				,width :   0 ,sortable : true , dataIndex : 'BIZ_KIND'        	,hidden : true}                        
					   , {header : ' 우편번호'   			,width :   0 ,sortable : true , dataIndex : 'ZIPCODE'        	,hidden : true}                      
					   , {header : ' 주소'   				,width :   0 ,sortable : true , dataIndex : 'ADDR'        		,hidden : true}                            
					   , {header : ' 주소상세'   			,width :   0 ,sortable : true , dataIndex : 'ADDR_DETAIL'       ,hidden : true}                  
					   , {header : ' 전화번호'   			,width :   0 ,sortable : true , dataIndex : 'TELEPHONE'        	,hidden : true}                    
					   , {header : ' 팩스'   				,width :   0 ,sortable : true , dataIndex : 'FAX'        		,hidden : true}                              
					   , {header : ' E-MAIL'   				,width :   0 ,sortable : true , dataIndex : 'EMAIL'        		,hidden : true}                          
					   , {header : ' 전자세금계산서발행여부' 	,width :   0 ,sortable : true , dataIndex : 'ETAX_ISSUE_YN'     ,hidden : true}  
					   , {header : ' 세금계산서 발행완료여부' ,width :   0 ,sortable : true , dataIndex : 'TAX_PUBLISH_YN'    ,hidden : true}
					   ];	 

// 그리드 결과매핑 
var mappingColumns_1st = [ { name : 'FLAG'               ,allowBlank : true }		// 상태       
					 	 , { name : 'TAX_PUBLISH' 		 ,allowBlank : true }		// 발생상태
						 , { name : 'ORD_ID' 			 ,allowBlank : true }		// 수주ID					 			
						 , { name : 'ORD_DATE' 			 ,allowBlank : true }		// 수주일자				 			  
						 , { name : 'ORD_TYPE_CODE' 	 ,allowBlank : true }		// 수주구분코드			 		      
						 , { name : 'ORD_NAME' 			 ,allowBlank : true }		// 수주명					 			  
						 , { name : 'EST_ID' 			 ,allowBlank : true }		// 견적ID					 			
						 , { name : 'ORD_TYPE_NAME' 	 ,allowBlank : true }		// 수주구분			 				
						 , { name : 'EST_VERSION' 		 ,allowBlank : true }		// 버전					 				    
						 , { name : 'ROLL_TYPE_CODE' 	 ,allowBlank : true }		// 업무구분코드			 				
						 , { name : 'PJT_ID' 			 ,allowBlank : true }		// 프로젝트ID		
						 , { name : 'PJT_NAME' 			 ,allowBlank : true }		// 프로젝트
						 , { name : 'ORD_DEPT_CODE' 	 ,allowBlank : true }		// 수주부서코드		
						 , { name : 'ORD_DEPT_NAME' 	 ,allowBlank : true }		// 수주부서
						 , { name : 'ORD_EMP_NUM' 		 ,allowBlank : true }		// 수주담당자번호	
						 , { name : 'ORD_EMP_NAME' 		 ,allowBlank : true }		// 수주담당자
						 , { name : 'ORD_CUSTOM_CODE' 	 ,allowBlank : true }		// 수주처코드(거래처)		 
						 , { name : 'ORD_CUSTOM_NAME' 	 ,allowBlank : true }		// 거래처명			 				
						 , { name : 'DVE_CUSTOM_CODE' 	 ,allowBlank : true }		// 납품처코드				 		      
						 , { name : 'DVE_CUSTOM_NAME' 	 ,allowBlank : true }		// 납품처				 				
						 , { name : 'INSPECT_EXP_DATE' 	 ,allowBlank : true }		// 검수예정일				 		      
						 , { name : 'DELIVERY_EXP_DATE'  ,allowBlank : true }		// 납품예정일				 			      
						 , { name : 'SET_EXP_DATE' 		 ,allowBlank : true }		// 설치예정일시			 		    
						 , { name : 'SAL_EXP_DATE' 		 ,allowBlank : true }		// 매출예정일				 		    
						 , { name : 'ACCOUNT_DATE' 		 ,allowBlank : true }		// 결제일					 			    
						 , { name : 'ORD_TOTAL_AMT' 	 ,allowBlank : true }		// 수주총액				 			      
						 , { name : 'DISCNT_TOTAL_AMT' 	 ,allowBlank : true }		// 할인총액				 			      
						 , { name : 'ORD_APLY_TOTAL_AMT' ,allowBlank : true }		// 수주적용총액			 		       
						 , { name : 'ORD_APLY_TOTAL_TAX' ,allowBlank : true }		// 수주적용총세액			 	       
						 , { name : 'APLY_JOB_DESCRIPT'  ,allowBlank : true }		// 적용업무설명			 		       
						 , { name : 'SUMMARY' 			 ,allowBlank : true }		// 특이사항				 			  
						 , { name : 'PAY_FREE_CODE' 	 ,allowBlank : true }		// 유무상구분코드			 	      
						 , { name : 'MAINTENANCE_FROM' 	 ,allowBlank : true }		// 유지보수기간_From		 	      
						 , { name : 'MAINTENANCE_TO' 	 ,allowBlank : true }		// 유지보수기간_To			 	    
						 , { name : 'PJT_DATE_FROM' 	 ,allowBlank : true }		// 프로젝트기간FROM		 	      
						 , { name : 'PJT_DATE_TO' 		 ,allowBlank : true }		// 프로젝트기간To			 	    
						 , { name : 'TAX_ISSUE_TYPE' 	 ,allowBlank : true }		// 세금계산서발행구분		    
						 , { name : 'TAX_MOD_ISSUE_CNT'  ,allowBlank : true }		// 세금계산서분할발행회수	      
						 , { name : 'PROC_STATUS_CODE' 	 ,allowBlank : true }		// 진행상태코드                
						 , { name : 'FINAL_MOD_ID' 		 ,allowBlank : true }		// 최종변경자ID		
						 , { name : 'FINAL_MOD_NAME'	 ,allowBlank : true }		// 최종변경자
						 , { name : 'FINAL_MOD_DATE' 	 ,allowBlank : true }		// 최종변경일시				 	    
						 , { name : 'REG_DATE' 			 ,allowBlank : true }		// 최초등록일					 	  
						 , { name : 'REG_ID' 			 ,allowBlank : true }		// 최초등록자					 	
						 , { name : 'ORD_CUSTOMER_NUM' 	 ,allowBlank : true }		// 수주처담당자번호		 	      
						 , { name : 'ORD_CUSTOMER_NAME'  ,allowBlank : true }		// 수주처담당자	
						 , { name : 'ORD_CUSTOMER_DEPT'  ,allowBlank : true }		// 수주처담당자부서
						 , { name : 'DVE_CUSTOMER_NUM' 	 ,allowBlank : true }		// 납품처담당자번호 		 	
						 , { name : 'DVE_CUSTOMER_NAME'  ,allowBlank : true }		// 납품처담당자 			
						 , { name : 'BIZ_TYPE'  		 ,allowBlank : true }		// 업태
						 , { name : 'CUSTOM_TYPE'  		 ,allowBlank : true }		// 거래처구분             
						 , { name : 'PER_BIZ_TYPE'  	 ,allowBlank : true }		// 개인_사업자구분        
						 , { name : 'BIZ_NUM'  		 	 ,allowBlank : true }		// 사업자번호             
						 , { name : 'CEO_NAME'  		 ,allowBlank : true }		// 대표자명               
						 , { name : 'BIZ_TYPE'  		 ,allowBlank : true }		// 업태                   
						 , { name : 'BIZ_KIND'  		 ,allowBlank : true }		// 업종                   
						 , { name : 'ZIPCODE'  		 	 ,allowBlank : true }		// 우편번호               			 
						 , { name : 'ADDR'  			 ,allowBlank : true }		// 주소                   
						 , { name : 'ADDR_DETAIL'  		 ,allowBlank : true }		// 주소상세               
						 , { name : 'TELEPHONE'  		 ,allowBlank : true }		// 전화번호               
						 , { name : 'FAX'  		 		 ,allowBlank : true }		// 팩스                   
						 , { name : 'EMAIL'  		 	 ,allowBlank : true }		// E-MAIL                 
						 , { name : 'ETAX_ISSUE_YN'  	 ,allowBlank : true }		// 전자세금계산서발행여부 
						 , { name : 'TAX_PUBLISH_YN'  	 ,allowBlank : true }		// 세금계산서 발행완료여부
    				 	 ];

/***************************************************************************
 * 세금계산서발행정보 --- 그리드 클릭시 Event
 ***************************************************************************/
function fnGridOnClick_1st(store, rowIndex){
	
	fnInitValue();

	Ext.get('flag').set({value : fnFixNull(store.getAt(rowIndex).data.FLAG)}, false);								// 상태                	               
	Ext.get('ord_id').set({value : fnFixNull(store.getAt(rowIndex).data.ORD_ID)}, false);							// 수주ID					 			
	Ext.get('ord_date').set({value : fnFixNull(store.getAt(rowIndex).data.ORD_DATE)}, false);						// 수주일자				 			  
	Ext.get('ord_type_code').set({value : fnFixNull(store.getAt(rowIndex).data.ORD_TYPE_CODE)}, false);				// 수주구분코드			 		      
	Ext.get('ord_name').set({value : fnFixNull(store.getAt(rowIndex).data.ORD_NAME)}, false);						// 수주명					 			  
	Ext.get('pjt_id').set({value : fnFixNull(store.getAt(rowIndex).data.PJT_ID)}, false);							// 프로젝트ID				 		
	Ext.get('pjt_name').set({value : fnFixNull(store.getAt(rowIndex).data.PJT_NAME)}, false);						// 프로젝트명
	Ext.get('ord_custom_code').set({value : fnFixNull(store.getAt(rowIndex).data.ORD_CUSTOM_CODE)}, false);			// 수주처코드(거래처)		 
	Ext.get('ord_custom_name').set({value : fnFixNull(store.getAt(rowIndex).data.ORD_CUSTOM_NAME)}, false);			// 거래처명			 				
	Ext.get('dve_custom_code').set({value : fnFixNull(store.getAt(rowIndex).data.DVE_CUSTOM_CODE)}, false);			// 납품처코드				 		      
	Ext.get('dve_custom_name').set({value : fnFixNull(store.getAt(rowIndex).data.DVE_CUSTOM_NAME)}, false);			// 납품처
					 	
	Ext.get('ord_customer_num').set({value : fnFixNull(store.getAt(rowIndex).data.ORD_CUSTOMER_NUM)}, false);		// 수주처담당자번호		 	      
	Ext.get('ord_customer_name').set({value : fnFixNull(store.getAt(rowIndex).data.ORD_CUSTOMER_NAME)}, false);		// 수주처담당자	
	Ext.get('ord_customer_dept').set({value : fnFixNull(store.getAt(rowIndex).data.ORD_CUSTOMER_DEPT)}, false);		// 수주처담당자부서
	Ext.get('dve_customer_num').set({value : fnFixNull(store.getAt(rowIndex).data.DVE_CUSTOMER_NUM)}, false);		// 납품처담당자번호 		 	
	Ext.get('dve_customer_name').set({value : fnFixNull(store.getAt(rowIndex).data.DVE_CUSTOMER_NAME)}, false);		// 납품처담당자 	
	
	Ext.get('ord_total_amt').set({value : fnFixNull(MoneyComma(store.getAt(rowIndex).data.ORD_TOTAL_AMT))}, false);				// 수주총액				 			      
	Ext.get('discnt_total_amt').set({value : fnFixNull(MoneyComma(store.getAt(rowIndex).data.DISCNT_TOTAL_AMT))}, false);		// 할인총액				 			      
	Ext.get('ord_aply_total_amt').set({value : fnFixNull(MoneyComma(store.getAt(rowIndex).data.ORD_APLY_TOTAL_AMT))}, false);	// 수주적용총액			 		       
	Ext.get('ord_aply_total_tax').set({value : fnFixNull(MoneyComma(store.getAt(rowIndex).data.ORD_APLY_TOTAL_TAX))}, false);	// 수주적용총세액			 	       
	Ext.get('tax_issue_type').set({value : fnFixNull(store.getAt(rowIndex).data.TAX_ISSUE_TYPE)}, false);			// 세금계산서발행구분		    
	Ext.get('tax_mod_issue_cnt').set({value : fnFixNull(store.getAt(rowIndex).data.TAX_MOD_ISSUE_CNT)}, false);		// 세금계산서분할발행회수	      

	Ext.get('custom_type').set({value : fnFixNull(store.getAt(rowIndex).data.CUSTOM_TYPE)}, false);			// 거래처구분                
	Ext.get('per_biz_type').set({value : fnFixNull(store.getAt(rowIndex).data.PER_BIZ_TYPE)}, false);		// 개인_사업자구분           
	Ext.get('biz_num').set({value : fnFixNull(store.getAt(rowIndex).data.BIZ_NUM)}, false);					// 사업자번호                    
	Ext.get('ceo_name').set({value : fnFixNull(store.getAt(rowIndex).data.CEO_NAME)}, false);				// 대표자명                      
	Ext.get('biz_type').set({value : fnFixNull(store.getAt(rowIndex).data.BIZ_TYPE)}, false);				// 업태                          
	Ext.get('biz_kind').set({value : fnFixNull(store.getAt(rowIndex).data.BIZ_KIND)}, false);				// 업종                          
	//Ext.get('zipcode').set({value : fnFixNull(store.getAt(rowIndex).data.ZIPCODE)}, false);					// 우편번호                      
	Ext.get('addr').set({value : fnFixNull(store.getAt(rowIndex).data.ADDR)}, false);						// 주소                              
	Ext.get('addr_detail').set({value : fnFixNull(store.getAt(rowIndex).data.ADDR_DETAIL)}, false);			// 주소상세                  
	Ext.get('telephone').set({value : fnFixNull(store.getAt(rowIndex).data.TELEPHONE)}, false);				// 전화번호                    
	Ext.get('fax').set({value : fnFixNull(store.getAt(rowIndex).data.FAX)}, false);							// 팩스                              
	Ext.get('email').set({value : fnFixNull(store.getAt(rowIndex).data.EMAIL)}, false);						// E-MAIL                          
	
	var dForm = document.detailForm;	// 상세 FORM	
	var keyValue1 = fnFixNull(store.getAt(rowIndex).data.ORD_ID);			 // 수주ID
	var keyValue2 = fnFixNull(store.getAt(rowIndex).data.ORD_TYPE_CODE);	 // 수주구분
	var keyValue3 = fnFixNull(store.getAt(rowIndex).data.PJT_ID);			 // 프로젝트ID
	var modify_yn = fnFixNull(store.getAt(rowIndex).data.MODIFY_YN);		 // 수정가능여부
	var etaxIssueYn  = fnFixNull(store.getAt(rowIndex).data.ETAX_ISSUE_YN);	 // 전자세금계산서발행여부
	var zipcode      = fnFixNull(store.getAt(rowIndex).data.ZIPCODE);		 // 우편번호 
	var tax_publish = fnFixNull(store.getAt(rowIndex).data.TAX_PUBLISH);	 // 세금계산서 발행상태
	
	dForm.zipcode1.value       = zipcode.substring(0,3); 	// 우편번호
	dForm.zipcode2.value       = zipcode.substring(3,6); 	// 우편번호
	
	// 전자세금계산서발행여부
	if(etaxIssueYn == 'Y'){
		 dForm.etax_issue_yn[0].checked = true;
	}else if(etaxIssueYn == 'N'){
		 dForm.etax_issue_yn[1].checked = true;
	}
	
	// 세금계산서 발행상태
	if(tax_publish == '완료'){	// 완료
		Ext.get('updateBtn').dom.disabled = true;
	}else if(tax_publish == '미완료'){
		Ext.get('updateBtn').dom.disabled = false;
	}
	
	// 버튼 disable
	Ext.get('ord_type_code').dom.disabled   = true;		// 수주구분
	Ext.get('ord_custom_code').dom.disabled   = true;	// 거래처코드
	Ext.get('ord_custom_name').dom.disabled   = true;	// 거래처
	
 	// 견적상태가 (B90 : 견적확정)또는 프로젝트가 드롭(99:DROP)되면
	// 해당견적은 더이상 수정을 할수 없도록 변경
	if(modify_yn == 'N'){
		Ext.get('updateBtn').dom.disabled = true;	
	}
 	
	fnSearchEdit1st(keyValue1);		// 수주품목정보 조회
	fnSearchEdit3rd(keyValue1);		// 세금계산서 조회
	
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
var	gridWidth_edit_1st  = 1022	;
var	gridTitle_edit_1st  = "수주 품목정보"	; 
var	render_edit_1st		= "edit_grid_1st";
var keyNm_edit_1st		= "ORD_INFO_SEQ";
var pageSize_edit_1st	= 4;
var limit_edit_1st		= pageSize_edit_1st;
var start_edit_1st		= 0;
var proxyUrl_edit_1st	= "/ord/order/result_edit_1st.sg";
var gridRowDeleteYn	    = "";
var tbarHidden_edit_1st = "Y";

// 행추가
function addNew_edit_1st(){
/*		
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
*/
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
	  ['', ' '],
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
var	userColumns_edit_1st	= [ {header: '상태',			width:   0,  sortable: true ,dataIndex: 'FLAG'               ,hidden : true}
				  			  ,	{header: "수주ID",		width:   0,	sortable: true,	dataIndex: "ORD_ID",			/*editor: new Ext.form.TextField({ allowBlank : true })*/hidden:true}
		  , {id:'ord_info_seq',  header: "순번",			width:   0,	sortable: true,	dataIndex: "ORD_INFO_SEQ",		/*editor: new Ext.form.TextField({ allowBlank : true }),*/ hidden:true}
							  , {header: "품목코드"	,	width:   0,	sortable: true,	dataIndex: "ITEM_CODE"/*,			editor: new Ext.form.TextField({ allowBlank : true }),renderer:changeBLUE*/,hidden:true}
							  , {header: "품목명",		width: 235,	sortable: true,	dataIndex: "ITEM_NAME"/*,			editor: new Ext.form.TextField({ allowBlank : true })*/}
							  , {header: "수량",			width:  40,	sortable: true,	dataIndex: "CNT",				/*editor: new Ext.form.NumberField({ allowBlank : true }),*/ align : 'right'}
							  , {header: "총액",			width:  90,	sortable: true,	dataIndex: "UNIT_PRICE",		/*editor: new Ext.form.NumberField({ allowBlank : true }), editable:false,*/renderer: "korMoney" , align : 'right'}
							  , {header: "금액",			width:  90,	sortable: true,	dataIndex: "AMT",				/*editor: new Ext.form.NumberField({ allowBlank : true }), editable:false,*/renderer: "korMoney" , align : 'right'}
							  , {header: "할인율",		width:  50,	sortable: true,	dataIndex: "DISCOUNT_RATIO",	/*editor: new Ext.form.NumberField({ allowBlank : true }),*/ align : 'right'}
							  , {header: "유무상구분",	width:  75,	sortable: true,	dataIndex: "PAY_FREE_CODE",		/*editor: PAY_FREE_CODE_COMBO  ,*/renderer: Ext.util.Format.comboRenderer(PAY_FREE_CODE_COMBO)}
							  , {header: "적용단가",		width:  90,	sortable: true,	dataIndex: "APLY_UNIT_PRICE",	/*editor: new Ext.form.NumberField({ allowBlank : true }), editable:false ,*/renderer: "korMoney" , align : 'right'}
							  , {header: "적용금액",		width:  90,	sortable: true,	dataIndex: "APLY_AMT",			/*editor: new Ext.form.NumberField({ allowBlank : true }),*/renderer: "korMoney" , align : 'right'}
							  , {header: "적용세액",		width:  90,	sortable: true,	dataIndex: "APLY_TAX",			/*editor: new Ext.form.NumberField({ allowBlank : true }), editable:false ,*/renderer: "korMoney" , align : 'right'}
							  , {header: "비고",			width: 150,	sortable: true,	dataIndex: "NOTE"/*,				editor: new Ext.form.TextField({ allowBlank : true })*/}
							  , {header: "최종변경자ID",	width:  0,	sortable: true,	dataIndex: "FINAL_MOD_ID",		/*editor: new Ext.form.TextField({ allowBlank : true }),*/ hidden:true}
							  , {header: "최종변경일시",	width:  0,	sortable: true,	dataIndex: "FINAL_MOD_DATE",	/*editor: new Ext.form.TextField({ allowBlank : true }),*/ hidden:true}
							  , {header: "규격",			width:  0,	sortable: true,	dataIndex: "STANDARD",			/*editor: new Ext.form.TextField({ allowBlank : true }),*/ hidden:true}
							  , {header: "단위",			width:  0,	sortable: true,	dataIndex: "UNIT",				/*editor: new Ext.form.TextField({ allowBlank : true }),*/ hidden:true}
							  
							  
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
							  , {name: "STANDARD", 			type:"string", mapping: "STANDARD"} 
							  , {name: "UNIT", 				type:"string", mapping: "UNIT"} 
	    				 	  ]; 
 

/***************************************************************************
 * 설  명 : 편집그리드 설정 (세금계산서 분할 발행정보)
***************************************************************************/
var	gridHeigth_edit_3rd	= 200;
var	gridWidth_edit_3rd  = 1022	;
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
	
	var est_id = Ext.get('ord_id').getValue();
	
	if(est_id == ""){
		Ext.Msg.alert('확인', '상세정보를  조회해주세요'); 
		return false;
	}
	
	var Plant = GridClass_edit_3rd.grid.getStore().recordType;
    var p = new Plant({ 
	        		    FLAG			: 'I' 
	        		  , PUR_ORD_ID		: Ext.get('ord_id').getValue()
	        		  , CUSTOM_CODE     : Ext.get('ord_custom_code').getValue()
	        		  , CUSTOM_NAME     : Ext.get('ord_custom_name').getValue()
	        		  , CNT				: ''
	        		  , UNIT_PRICE		: ''
	        		  , AMT				: ''
	        		  , TAX				: ''
	        		  , ITEM_CODE       : ''
	        		  , SALE_REGISTER	: 'Y'
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
var	userColumns_edit_3rd	= [ {header: "상태"            	,width:  0  ,sortable: true, dataIndex: "FLAG"               	,hidden : true}              
					          , {header: "매입매출구분코드"	,width:  0,	sortable: true,	dataIndex: "PUR_SAL_TYPE_CODE"	,hidden : true}	
							  , {header: "세금계산서ID",		width:  0,	sortable: true,	dataIndex: "TAX_ID"				,hidden : true}
							  , {header: "매(입)출ID_수주ID",width:  0,	sortable: true,	dataIndex: "PUR_ORD_ID"			,hidden : true}
							  , {header: "거래처코드",		width:  0,	sortable: true,	dataIndex: "CUSTOM_CODE"		,hidden : true}
							  , {header: "거래처",			width: 130,	sortable: true,	dataIndex: "CUSTOM_NAME"		}
							  , {header: "순번",				width:  40,	sortable: true,	dataIndex: "TAX_INFO_SEQ",		hidden : true  ,editor: new Ext.form.TextField({ allowBlank : true })}
							  , {header: "계산서발행일",   width:  90,	sortable: true,	dataIndex: "PREPARE_DATE",		editor: new Ext.form.TextField({ allowBlank : true })}
							  , {header: "입금예정일",     width:  90,	sortable: true,	dataIndex: "SAL_EXP_DATE",		editor: new Ext.form.TextField({ allowBlank : true })}
							  , {header: "품목코드",			width: 110,	sortable: true,	dataIndex: "ITEM_CODE",			renderer:changeBLUE}
							  , {header: "품목명",			width: 145,	sortable: true,	dataIndex: "ITEM_NAME",			editor: new Ext.form.TextField({ allowBlank : true })}
							  , {header: "규격",				width: 50,	sortable: true,	dataIndex: "STANDARD",			editor: new Ext.form.TextField({ allowBlank : true })}
							  , {header: "단위",				width: 50,	sortable: true,	dataIndex: "UNIT",				editor: new Ext.form.TextField({ allowBlank : true })}
							  , {header: "수량",				width: 50,	sortable: true,	dataIndex: "CNT",				editor: new Ext.form.NumberField({ allowBlank : true }),align : 'right'}
							  , {header: "단가",				width: 85,	sortable: true,	dataIndex: "UNIT_PRICE",		editor: new Ext.form.NumberField({ allowBlank : true }),renderer: "korMoney" , align : 'right'}
							  , {header: "금액",				width: 85,	sortable: true,	dataIndex: "AMT",				editor: new Ext.form.NumberField({ allowBlank : true }),renderer: "korMoney" , align : 'right'}
							  , {header: "세액",				width: 85,	sortable: true,	dataIndex: "TAX",				editor: new Ext.form.NumberField({ allowBlank : true }),renderer: "korMoney" , align : 'right'}
							  , {header: "비고",				width: 100,	sortable: true,	dataIndex: "NOTE",				editor: new Ext.form.TextField({ allowBlank : true }), hidden:true}
							  , {header: "ERP세금계산서 번호",width: 100,	sortable: true,	dataIndex: "ERP_TAX_NO",		editor: new Ext.form.TextField({ allowBlank : true })}
							  , {header: "매출등록",			 width: 70,	sortable: true,	dataIndex: "SALE_REGISTER",		renderer: saleRegister , align : 'center'}
							  , {header: "최종변경자ID",		 width:  0,	sortable: true,	dataIndex: "FINAL_MOD_ID",		editor: new Ext.form.TextField({ allowBlank : true }), hidden:true}
							  , {header: "최종변경일시",		width:  0,	sortable: true,	dataIndex: "FINAL_MOD_DATE",	editor: new Ext.form.TextField({ allowBlank : true }), hidden:true}
							  , {header: "최초등록일",		width:  0,	sortable: true,	dataIndex: "REG_DATE",			editor: new Ext.form.TextField({ allowBlank : true }), hidden:true}
							  , {header: "최초등록자",		width:  0,	sortable: true,	dataIndex: "REG_ID",			editor: new Ext.form.TextField({ allowBlank : true }), hidden:true}
							  ];

// 맵핑 필드
var	mappingColumns_edit_3rd	= [ {name: "FLAG" 				, type:"string" , mapping: "FLAG"}				// 상태 
							  , {name: "PUR_SAL_TYPE_CODE"  , type:"string" , mapping: "PUR_SAL_TYPE_CODE"}	// 매입매출구분코드 
							  , {name: "TAX_ID" 			, type:"string" , mapping: "TAX_ID"}			// 세금계산서ID     
							  , {name: "PUR_ORD_ID" 		, type:"string" , mapping: "PUR_ORD_ID"}		// 매(입)출ID_수주ID
							  , {name: "CUSTOM_CODE" 		, type:"string" , mapping: "CUSTOM_CODE"}		// 거래처코드       
							  , {name: "CUSTOM_NAME" 		, type:"string" , mapping: "CUSTOM_NAME"}		// 거래처
							  , {name: "TAX_INFO_SEQ" 		, type:"string" , mapping: "TAX_INFO_SEQ"}		// 순번  
							  , {name: "PREPARE_DATE" 		, type:"string" , mapping: "PREPARE_DATE"}		// 작성일자
							  , {name: "SAL_EXP_DATE" 		, type:"string" , mapping: "SAL_EXP_DATE"}		// 입금예정일자
							  , {name: "ITEM_CODE" 			, type:"string" , mapping: "ITEM_CODE"}			// 품목코드         
							  , {name: "ITEM_NAME" 			, type:"string" , mapping: "ITEM_NAME"}			// 품목명           
							  , {name: "STANDARD" 			, type:"string" , mapping: "STANDARD"}			// 규격             
							  , {name: "UNIT" 				, type:"string" , mapping: "UNIT"}				// 단위             
							  , {name: "CNT" 				, type:"string" , mapping: "CNT"}				// 수량             
							  , {name: "UNIT_PRICE" 		, type:"string" , mapping: "UNIT_PRICE"}		// 단가             
							  , {name: "AMT" 				, type:"string" , mapping: "AMT"}				// 금액             
							  , {name: "TAX" 				, type:"string" , mapping: "TAX"}				// 세액             
							  , {name: "NOTE" 				, type:"string" , mapping: "NOTE"}				// 비고             
							  , {name: "ERP_TAX_NO" 		, type:"string" , mapping: "ERP_TAX_NO"}		// ERP세금계산서 번호 
							  , {name: "SALE_REGISTER" 		, type:"string" , mapping: "SALE_REGISTER"}		// 매출등록
							  , {name: "FINAL_MOD_ID" 		, type:"string" , mapping: "FINAL_MOD_ID"}		// 최종변경자ID     
							  , {name: "FINAL_MOD_DATE" 	, type:"string" , mapping: "FINAL_MOD_DATE"}	// 최종변경일시     
							  , {name: "REG_DATE" 			, type:"string" , mapping: "REG_DATE"}			// 최초등록일       
							  , {name: "REG_ID" 			, type:"string" , mapping: "REG_ID"}			// 최초등록자       
	    				 	  ]; 

// 매출등록 컬럼에 저장버튼이미지 넣기
function saleRegister(val){
		
		if(val==null || val==""){
			val="";
		}
        
		if(val == 'Y'){
	    	return '<img align="center" src="/resource/images/edit/Save.GIF" style="cursor: hand;">';
	    }else{
	    	return '';
	    }
		
	    return val;
	}
/***************************************************************************
 * 설  명 : 필드 초기화
 **************************************************************************/
function fnInitValue(){

	var dForm = document.detailForm;		// 상세 FORM	
	dForm.reset();							// 상세필드 초기화
	
	// 버튼 초기화
	Ext.get('updateBtn').dom.disabled  	   	   = true;
	
	Ext.get('pjt_id').dom.disabled  	   	   = true;	// 프로젝트id
	Ext.get('pjt_name').dom.disabled  	   	   = true;	// 프로젝트명
	
    Ext.get('ord_custom_code').dom.disabled    = true;	// 거래처코드
    Ext.get('ord_custom_name').dom.disabled    = true;	// 거래처
    
    Ext.get('ord_id').dom.disabled  		   = true;	// 수주ID
	Ext.get('ord_name').dom.disabled  		   = true;	// 수주명
	Ext.get('ord_type_code').dom.disabled  	   = true;	// 수주구분
	Ext.get('ord_date').dom.disabled  		   = true;	// 수주일자
	Ext.get('ord_total_amt').dom.disabled  	   = true;	// 수주총액
	Ext.get('discnt_total_amt').dom.disabled   = true;  // 할인총액
	Ext.get('ord_aply_total_amt').dom.disabled = true;  // 적용총액
	Ext.get('ord_aply_total_tax').dom.disabled = true;  // 적용총세액
	Ext.get('ord_customer_dept').dom.disabled  = true;  
	Ext.get('ord_customer_name').dom.disabled  = true;  
	
	Ext.get('tax_issue_type').dom.disabled = true;  	// 세금계산서발행구분
	Ext.get('custom_type').dom.disabled = true;  		// 거래처구분
	Ext.get('tax_mod_issue_cnt').dom.disabled = true;  	// 세금계산서분할발행횟수
	
	dForm.etax_issue_yn[0].checked = true;
	
	try{
		GridClass_edit_1st.store.commitChanges();	// 변경된 record를 commit
		GridClass_edit_1st.store.removeAll();		// store자료를 삭제
		GridClass_edit_3rd.store.commitChanges();
		GridClass_edit_3rd.store.removeAll();
	}catch(e){
		
	}
	
}

/***************************************************************************
 * 설  명 : 검색
 **************************************************************************/
function fnSearch(){  	
	
	Ext.Ajax.request({   
		url: "/ord/order/taxPublishInfoManageList.sg"
		,method : 'POST'   
		,success: function(response){						// 조회결과 성공시
					// 조회된 결과값, store명
					handleSuccess(response,GridClass_1st);
					//var json = Ext.util.JSON.decode(response.responseText);
					//this.GridClass_1st.store.loadData(json)
					//alert(json.success);
		          }   							
		,failure: handleFailure   	   						// 조회결과 실패시  
		,params : {					   						// 조회조건을 DB로 전송하기위해서 조건값 설정
					limit              	: limit_1st
				  , start              	: start_1st
				  , src_pjt_id   	   	: Ext.get('src_pjt_id').getValue()		  	// 프로젝트ID   
				  , src_pjt_name   	   	: Ext.get('src_pjt_name').getValue()		// 프로젝트명
			  	  // , src_ord_custom_code : Ext.get('src_ord_custom_code').getValue() // 거래처코드  
			  	  , src_ord_custom_name : Ext.get('src_ord_custom_name').getValue() // 거래처명
			  	  , src_ord_type_code  	: Ext.get('src_ord_type_code').getValue()   // 수주구분 
			  	  , src_ord_id         	: Ext.get('src_ord_id').getValue()          // 수주ID
			  	  , src_ord_name       	: Ext.get('src_ord_name').getValue()        // 수주명
			  	  , src_ord_date_start 	: Ext.get('src_ord_date_start').getValue()  // 수주기간(검색시작일)
			  	  , src_ord_date_end   	: Ext.get('src_ord_date_end').getValue()    // 수주기간(검색종료일)
			  	  , src_unissued 		: Ext.get('src_unissued').getValue()   		// 계산서미발행
				  , src_issue 			: Ext.get('src_issue').getValue()  			// 계산서발행
			  	  
				  }				
	});  
	
	fnInitValue();
}  		

/***************************************************************************
 * 설  명 : 저장버튼 클릭
 ***************************************************************************/
function fnSave(divValue){  	

    // 변경된 세금계산서 분할 발행정보 Grid의 record
	var record3 = GridClass_edit_3rd.store.getModifiedRecords();	  
	// 변경된 record의 자료를 json형식으로
    var edit3rdJson = "[";
	    for (var i = 0; i < record3.length; i++) {
	    	
	      var custom_code = record3[i].data.CUSTOM_CODE;
	      var pur_ord_id = record3[i].data.PUR_ORD_ID;
	    	
	      if(custom_code == ''){
	    	  record3[i].set('CUSTOM_CODE',Ext.get('ord_custom_code').getValue());
	      }	
	    	
	      if(pur_ord_id == ''){
	    	  record3[i].set('PUR_ORD_ID',Ext.get('ord_id').getValue());
	      }
	    	
	      edit3rdJson += Ext.util.JSON.encode(record3[i].data);				
	      if (i < (record3.length-1)) {
	        edit3rdJson += ",";
	      }
	    }
    	edit3rdJson += "]"
		
	Ext.Ajax.request({   
		url: "/ord/order/saveTaxPublishInfoManage.sg"   
		,success: function(response){						// 조회결과 성공시
					// 조회된 결과값, store명
					handleSuccess(response,GridClass_1st);
		          } 
		,failure: handleFailure   	    // 조회결과 실패시  
		,form   : document.detailForm	// 상세 FORM	
		,params : {					    // 조회조건을 DB로 전송하기위해서 조건값 설정
				  // 페이지정보
					limit_1st          	: limit_1st
			  	  , start_1st          	: start_1st
  				  , edit3rdData        	: edit3rdJson		// 세금계산서 분할 발행정보
  				  // disable처리된 필드값
  				  , ord_id			   	: Ext.get('ord_id').getValue()		  	  	// 수주ID  
  				  , tax_issue_type      : Ext.get('tax_issue_type').getValue()		// 세금계산서 발행구분
  				  , tax_mod_issue_cnt	: Ext.get('tax_mod_issue_cnt').getValue()	// 세금계산서분할발행회수
  				  , custom_code			: Ext.get('ord_custom_code').getValue()		// 거래처코드
  				  , custom_type			: Ext.get('custom_type').getValue()  		// 거래처구분
				  // 검색정보
			  	  , src_pjt_id   	   	: Ext.get('src_pjt_id').getValue()		  	// 프로젝트ID 
			  	  , src_pjt_name   	   	: Ext.get('src_pjt_name').getValue()		// 프로젝트명
			  	  // , src_ord_custom_code : Ext.get('src_ord_custom_code').getValue() // 거래처코드  
			  	  , src_ord_custom_name : Ext.get('src_ord_custom_name').getValue() // 거래처명
			  	  , src_ord_type_code  	: Ext.get('src_ord_type_code').getValue()  	// 수주구분 
			  	  , src_ord_id         	: Ext.get('src_ord_id').getValue()         	// 수주ID
			  	  , src_ord_name       	: Ext.get('src_ord_name').getValue()        // 수주명
			  	  , src_ord_date_start 	: Ext.get('src_ord_date_start').getValue() 	// 수주기간(검색시작일)
			  	  , src_ord_date_end   	: Ext.get('src_ord_date_end').getValue()   	// 수주기간(검색종료일)
			  	  , src_unissued        : Ext.get('src_unissued').getValue()   		// 계산서미발행
				  , src_issue           : Ext.get('src_issue').getValue()  			// 계산서발행
			  	  , saveDiv			    : divValue								    // 등록(save), 수정(update)구분
				  }  		
	});  

	fnInitValue();
}  		

/***************************************************************************
 * 설  명 : 매출등록
 ***************************************************************************/
function fnSaveSaleRegister(record){  	
	
	// 변경된 세금계산서 분할 발행정보 Grid의 record
	// 변경된 record의 자료를 json형식으로
    var edit3rdJson = "[";
	    edit3rdJson += Ext.util.JSON.encode(record.data);				
	    edit3rdJson += "]";

	Ext.Ajax.request({   
		url: "/ord/order/saveSaleRegister.sg"   
		,success: function(response){						// 조회결과 성공시
					// 조회된 결과값, store명
					handleSuccess(response,GridClass_1st);
		          } 
		,failure: handleFailure   	    // 조회결과 실패시  
		,form   : document.detailForm	// 상세 FORM	
		,params : {					    // 조회조건을 DB로 전송하기위해서 조건값 설정
				  // 페이지정보
					limit_1st          	: limit_1st
			  	  , start_1st          	: start_1st
  				  , edit3rdData        	: edit3rdJson		// 세금계산서 분할 발행정보
  				  // disable처리된 필드값
  				  , ord_id			   	: Ext.get('ord_id').getValue()		  	  	// 수주ID  
  				  , custom_type			: Ext.get('custom_type').getValue()  		// 거래처구분
				  // 검색정보
			  	  , src_pjt_id   	   	: Ext.get('src_pjt_id').getValue()		  	// 프로젝트ID 
			  	  , src_pjt_name   	   	: Ext.get('src_pjt_name').getValue()		// 프로젝트명
			  	  // , src_ord_custom_code : Ext.get('src_ord_custom_code').getValue() // 거래처코드  
			  	  , src_ord_custom_name : Ext.get('src_ord_custom_name').getValue() // 거래처명
			  	  , src_ord_type_code  	: Ext.get('src_ord_type_code').getValue()  	// 수주구분 
			  	  , src_ord_id         	: Ext.get('src_ord_id').getValue()         	// 수주ID
			  	  , src_ord_name       	: Ext.get('src_ord_name').getValue()        // 수주명
			  	  , src_ord_date_start 	: Ext.get('src_ord_date_start').getValue() 	// 수주기간(검색시작일)
			  	  , src_ord_date_end   	: Ext.get('src_ord_date_end').getValue()   	// 수주기간(검색종료일)
				  , src_unissued        : Ext.get('src_unissued').getValue()   		// 계산서미발행
				  , src_issue           : Ext.get('src_issue').getValue()  			// 계산서발행
				 
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
<%--	
	var day = getTimeStamp();	
	var fromDay = day.replaceAll('-','');
	fromDay = addDate(fromDay, 'M', -3);
	fromDay = fromDay.substring(0,4)+"-"+fromDay.substring(4,6)+"-"+fromDay.substring(6,8);
	var toDay = day.replaceAll('-','');
	toDay = addDate(toDay, 'M', 3);
	toDay = toDay.substring(0,4)+"-"+toDay.substring(4,6)+"-"+toDay.substring(6,8);
--%>	
    // 검색버튼 클릭
	Ext.get('searchBtn').on('click', function(e){
<%--       
		var startDate = Ext.get('src_ord_date_start').getValue()  // 검색시작일
		var endDate = Ext.get('src_ord_date_end').getValue()      // 검색종료일
	  
		if(fnCalDate(startDate,endDate,'D') < 0){
			Ext.Msg.alert('확인', '검색시작일이 검색종료일보다 이전입니다.'); 
		}else{
			
			// GridClass_2nd.store.reload()
		}	
 --%>		
 	fnSearch()
 
    });
    
   	//조건해제 버튼 -> 검색조건 초기화
   	Ext.get('searchClearBtn').on('click', function(e){
        sForm.reset();
        
        Ext.get('src_unissued').set({value:'Y'} , false);
        Ext.get('src_issue').set({value:'N'} , false);
        //Ext.get('src_ord_date_start').set({value : fromDay }, false);
	    //Ext.get('src_ord_date_end').set({value : toDay }, false);
	    
	    fnSearch();
    });
   	
   	// 프로젝트 검색팝업
   	//Ext.get('src_pjt_id_btn').on('click', function(e){
	//	param = "?fieldName=src_pjt_id";
	//	fnPjtPop(param);
	//});
<%--   
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
--%>	
	// 수주구분 
   	Ext.get('ord_type_code').on('change', function(e){
   		var ord_type_code = Ext.get('ord_type_code').getValue();	// 수주구분
   	});
	
/*   	
   	// 프로젝트 검색팝업
   	Ext.get('pjtIdBtn').on('click', function(e){
		param = "?fieldName=pjt_id";
		fnPjtPop(param);
	});
*/	
	
	//저장 버튼 -> 데이터를 server로 전송
	Ext.get('updateBtn').on('click', function(e){	
		if(fnValidation()){
			Ext.MessageBox.confirm('Confirm', '저장하시겠습니까?', showResultUpdate);
		};	
	});
	
	// 세금계산서발행구분
	//Ext.get('tax_issue_type').on('change', function(e){	
	//	Ext.MessageBox.confirm('Confirm', '세금계산서 정보를 변경하시겠습니까?', changeTax);
	//});
	
	// 세금계산서분할횟수
	//Ext.get('tax_mod_issue_cnt').on('change', function(e){	
	//	Ext.MessageBox.confirm('Confirm', '세금계산서 정보를 변경하시겠습니까?', changeTax);
	//});
	
	// 미발행
   	Ext.get('src_unissued').on('click', function(e){
        var checkValue = Ext.get('src_unissued').dom.checked ;
        
        if(checkValue){
        	Ext.get('src_unissued').set({value:'Y'} , false);
        }else{
        	Ext.get('src_unissued').set({value:'N'} , false);
        }
        
    });
	
	// 발행
   	Ext.get('src_issue').on('click', function(e){
        var checkValue = Ext.get('src_issue').dom.checked ;
        
        if(checkValue){
        	Ext.get('src_issue').set({value:'Y'} , false);
        }else{
        	Ext.get('src_issue').set({value:'N'} , false);
        }
        
    });
	
	fnInitValue();
	
}); // end Ext.onReady

function showResultUpdate(btn){
   	if(btn == 'yes'){
   		fnSave('update');
   	}    	
};

// 세금계산서 정보 변경
function changeTax(btn){
	if(btn == 'yes'){
/*
		GridClass_edit_3rd.store.commitChanges();
		GridClass_edit_3rd.store.removeAll();
		
		// 이전에 저장된 세금계산서 정보를 삭제하위 위한값 설정
		Ext.get('taxDeleteYn').set({value : 'Y'}, false);   	
		
		var Plant = GridClass_edit_3rd.grid.getStore().recordType; 
 		var p ;
		var tax_issue_type = Ext.get('tax_issue_type').getValue();
		var ord_type_code = Ext.get('ORD_TYPE_CODE').getValue();
		var tax_mod_issue_cnt = Ext.get('tax_mod_issue_cnt').getValue();
	//	var nowDay = new Date();
	//	var year = nowDay.getFullYear();
	//	var month = nowDay.getMonth()+1;
	//	var day = nowDay.getDate();
	//	if (("" + month).length == 1) { month = "0" + month; }
    //	if (("" + day).length   == 1) { day   = "0" + day;   }
	//	var toDay = year+month+day;
	    var today = new Date();	
	    var todayYMD =
	    leadingZeros(today.getFullYear(), 4) + '-' + leadingZeros(today.getMonth() + 1, 2) + '-' + leadingZeros(today.getDate(), 2) + ' ' ;
	
		var toDay = todayYMD;

		// 일괄발행
		if(tax_issue_type == '10'){
			// toDay = toDay.substring(0,4)+"-"+toDay.substring(4,6)+"-"+toDay.substring(6,8);
			  
			if(ord_type_code == '10'){ // 프로젝트
				
				var rowCnt = GridClass_edit_1st.store.getCount();  // Grid의 총갯수 
				var record = GridClass_edit_1st.store.getAt(i);
				
				for(i = 0 ; i < rowCnt ; i++){
					p = new Plant({ 
	        		    FLAG			: 'I' 
	        		  , PUR_ORD_ID		: Ext.get('ord_id').getValue()
		    		  , CUSTOM_CODE     : Ext.get('ord_custom_code').getValue()
		    		  , CUSTOM_NAME     : Ext.get('ord_custom_name').getValue()
		    		  , ITEM_CODE       : GridClass_edit_1st.store.data.items[i].data.ITEM_CODE
		    		  , ITEM_NAME		: GridClass_edit_1st.store.data.items[i].data.ITEM_NAME
		    		  , STANDARD		: GridClass_edit_1st.store.data.items[i].data.STANDARD
		    		  , UNIT			: GridClass_edit_1st.store.data.items[i].data.UNIT
		    		  , CNT 			: GridClass_edit_1st.store.data.items[i].data.CNT
		    		  , PREPARE_DATE    : toDay
		    		  , UNIT_PRICE		: GridClass_edit_1st.store.data.items[i].data.APLY_UNIT_PRICE
		    		  , AMT				: GridClass_edit_1st.store.data.items[i].data.APLY_AMT
		    		  , TAX				: GridClass_edit_1st.store.data.items[i].data.APLY_TAX
    				  }); 
				   GridClass_edit_3rd.grid.stopEditing();
				   GridClass_edit_3rd.store.insert(i, p);
				}
				
				
				
				
				
			}else if(ord_type_code == '20'){ // 유지보수
			   p = new Plant({ 
	        		    FLAG			: 'I' 
	        		  , PUR_ORD_ID		: Ext.get('ord_id').getValue()
		    		  , CUSTOM_CODE     : Ext.get('ord_custom_code').getValue()
		    		  , CUSTOM_NAME     : Ext.get('ord_custom_name').getValue()
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
			}
			
		// 분할발행	
		}else if(tax_issue_type == '20'){
			if(tax_mod_issue_cnt == 0 || tax_mod_issue_cnt == ''){
				Ext.Msg.alert('확인', '분할횟수를 입력해주세요.')
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
	        		  , PUR_ORD_ID		: Ext.get('ord_id').getValue()
		    		  , CUSTOM_CODE     : Ext.get('ord_custom_code').getValue()
		    		  , CUSTOM_NAME     : Ext.get('ord_custom_name').getValue()
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
		 */ 
   	}
 	
}

/***************************************************************************
 * 설  명 : 그리드의 페이지 클릭시 검색조건값을 DB로 전송
 ***************************************************************************/
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
    }else if(fieldName == 'src_pjt_id'){
    	Ext.get('src_pjt_id').set({value:fnFixNull(record.PJT_ID)} , false);
	   // Ext.get('src_pjt_name').set({value:fnFixNull(record.PJT_NAME)} , false);
    }
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
							record1.set('ORD_ID', Ext.get('ord_id').getValue());
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

<%--    Ext.get('ord_customer_name').set({value:fnFixNull(record.CUSTOMER_NAME)} , false);--%>
<%--    Ext.get('ord_customer_num').set({value:fnFixNull(record.CUSTOMER_NUM)} , false);--%>
<%--    Ext.get('ord_customer_dept').set({value:fnFixNull(record.CUSTOMER_DEPT)} , false);--%>
<%--    Ext.get('ord_custom_name').set({value:fnFixNull(record.CUSTOM_NAME)} , false);--%>
<%--    Ext.get('ord_custom_code').set({value:fnFixNull(record.CUSTOM_CODE)} , false);--%>
   
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

//    Ext.get('ord_emp_num').set({value:fnFixNull(record.EMP_NUM)} , false);
//    Ext.get('ord_emp_name').set({value:fnFixNull(record.KOR_NAME)} , false);
//    Ext.get('ord_dept_code').set({value:fnFixNull(record.DEPT_CODE)} , false);
//    Ext.get('ord_dept_name').set({value:fnFixNull(record.DEPT_NAME)} , false);
	
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
	var unit = records[0].data.UNIT;
	var standard = records[0].data.STANDARD;
	
	if(grid_name == 'GridClass_edit_1st'){
		// 선택된 row
		var record = GridClass_edit_1st.grid.selModel.getSelected(); 
		// 값을 설정
		//record.set('ITEM_CODE', item_code);			// 품목코드
		//record.set('ITEM_NAME', item_name);			// 품목명
		//record.set('UNIT_PRICE', unit_price_01);	// 단가
		
		fnEdit1stAfterRowDeleteEvent();
	}else if(grid_name == 'GridClass_edit_3rd'){
		// 선택된 row
		var record = GridClass_edit_3rd.grid.selModel.getSelected(); 
		// 값을 설정
		record.set('ITEM_CODE', item_code);			// 품목코드
		record.set('ITEM_NAME', item_name);			// 품목명
		record.set('UNIT_PRICE', unit_price_01);	// 단가
		record.set('UNIT', unit);					// 단위
		record.set('STANDARD', standard);			// 규격
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
}
/***************************************************************************
 * 설  명 : 에디트 그리드의 CELL을 수정하였을 경우 이벤트
 ***************************************************************************/
function  fnEdit1stAfterCellEdit(obj){
}

// 추가된 행이 삭제 되었을 때
function fnEdit1stAfterRowDeleteEvent(){
}

// 수주 품목정보 금액 계산
function fnCalculateItemAmt(fieldName){
}

function fnValidation(){
	
	
	var ord_custom_code = Ext.get('ord_custom_code').getValue();    	// 거래처코드
	var custom_type = Ext.get('custom_type').getValue();				// 거래처구분
	var per_biz_type = Ext.get('per_biz_type').getValue(); 				// 개인/사업자구분
	var biz_num = Ext.get('biz_num').getValue(); 						// 사업자번호 
	var ord_aply_total_amt = Ext.get('ord_aply_total_amt').getValue();	// 수주적용총액
	ord_aply_total_amt = ord_aply_total_amt.replaceAll(',','');
	var taxAmt = 0;
	
	if(ord_custom_code == '' || ord_custom_code.length == 0){
		Ext.Msg.alert('확인', '거래처를 입력해주세요');
		return false;
	}
	
	if(custom_type.length == 0 || custom_type == ""){
		Ext.Msg.alert('확인', '거래처구분을 선택해주세요.')
		return false;
	}
	
	if(per_biz_type.length == 0 || per_biz_type == ""){
		Ext.Msg.alert('확인', '개인/사업자구분을 선택해주세요.')
		return false;
	}
	
	if(biz_num.length == 0 || biz_num == ""){
		Ext.Msg.alert('확인', '사업자번호를 입력해주세요.')
		return false;
	}else if(biz_num.length < 10){
		Ext.Msg.alert('확인', '사업자번호는 10자리입니다.')
		return false;
	}else if(biz_num.length == 10){
		if(!isValidBizNo('',biz_num)){
			return false;
		}
	}
	
	var rowCnt = GridClass_edit_1st.store.getCount();  // Grid의 총갯수
	
	// 거래처 정보확인
	var taxCnt = GridClass_edit_3rd.store.getCount();  // Grid의 총갯수
	
	if(taxCnt == 0){
		Ext.Msg.alert('확인', '세금계산서  분할 발행정보를 입력해주세요.'); 
		return false;
	}else if(taxCnt == 1){
		Ext.get('tax_issue_type').set({value : "10"}, false);			// 세금계산서발행구분(일괄발행)		    
		Ext.get('tax_mod_issue_cnt').set({value : taxCnt}, false);		// 세금계산서분할발행회수	    
	}else if(taxCnt > 1){
		Ext.get('tax_issue_type').set({value : "20"}, false);			// 세금계산서발행구분(분할발행)		    
		Ext.get('tax_mod_issue_cnt').set({value : taxCnt}, false);		// 세금계산서분할발행회수	    
	}
	
	for(j = 0 ; j < taxCnt ; j++){
		var record = GridClass_edit_3rd.store.getAt(j);
		var amt = record.data.AMT;
		var prepare_date = record.data.PREPARE_DATE;
		var sal_exp_date = record.data.SAL_EXP_DATE;
		var item_code = record.data.ITEM_CODE;
		var amt = record.data.AMT; 
		taxAmt = parseInt(taxAmt) + parseInt(amt);
		
		
		if(prepare_date == undefined || prepare_date == ""){
			Ext.Msg.alert('확인', '[세금계산서 분할 발행정보]의 '+(j+1)+'번째행의 작성일자를 입력해주세요.'); 
			return false;
		}
		
		if(sal_exp_date == undefined || sal_exp_date == ""){
			Ext.Msg.alert('확인', '[세금계산서 분할 발행정보]의 '+(j+1)+'번째행의 입금예정일자를 입력해주세요.'); 
			return false;
		}
		
		if(item_code == undefined || item_code == ""){
			Ext.Msg.alert('확인', '[세금계산서 분할 발행정보]의 '+(j+1)+'번째행의 품목코드를 입력해주세요.'); 
			return false;
		}
		
		if(amt == undefined || amt == ""){
			Ext.Msg.alert('확인', '[세금계산서 분할 발행정보]의 '+(j+1)+'번째행의 금액이 0입니다. 금액을 입력해주세요.'); 
			return false;
		}
	}
		
	if(taxAmt > ord_aply_total_amt){
		Ext.Msg.alert('확인', '세금계산서 발행금액이 수주적용총액보다 '+(taxAmt-ord_aply_total_amt)+'원 많습니다.'); 
		return false;
	}

	return true;
}

/***************************************************************************
 * 설  명 : 에디트 그리드의 CELL을 클릭하였을 경우 이벤트
 ***************************************************************************/
function  fnEdit3rdCellClickEvent(grid, rowIndex, columnIndex, e){
	
	var record = GridClass_edit_3rd.store.getAt(rowIndex);
	var sale_register = record.data.SALE_REGISTER;
	
	if(sale_register == 'Y'){
		GridClass_edit_3rd.grid.colModel.setEditable(columnIndex, true);
	
		//품목 코드 팝업
		if(columnIndex == '9'){
			param = "?grid_name=GridClass_edit_3rd";
			fnItemPop(param);
		// 매출등록 클릭
		}else if(columnIndex == '19'){
			
			
			var erp_tax_no = record.data.ERP_TAX_NO;
			
			
			if(sale_register == 'Y'){
				if(erp_tax_no == undefined || erp_tax_no == ''){
					Ext.Msg.alert('확인', 'ERP세금계산서번호를 입력해주세요.'); 
					return false;
				}else{
					Ext.MessageBox.confirm('Confirm', '매출등록된 계산서는 수정이 불가능합니다. 매출등록하시겠습니까?', function(val){
						if(val == 'yes'){
					   		fnSaveSaleRegister(record);
					   	}
					});
					
				}
			}
		}
	// 매출등록이 되면 수정불가	
	}else{
		GridClass_edit_3rd.grid.colModel.setEditable(columnIndex, false);
	}
	
}

// 그리드 값이 변경되었을때
function  fnEdit3rdAfterCellEdit(obj){
	var editedRow = obj.row;
	var editedColumn = obj.column;
	var editedValue = obj.value;
	var fieldName = obj.field;
	
	var record 		= GridClass_edit_3rd.store.getAt(editedRow);
	var cnt 		= fnIsNaN(parseInt(record.data.CNT)) ;   		// 수량
	var unit_price  = fnIsNaN(parseInt(record.data.UNIT_PRICE));	// 단가
	var amt 		= fnIsNaN(parseInt(record.data.AMT)) ;   		// 금액
	var tax			= 0;		
	
	// 해당 컬럼의 값이 변경 되었을 경우
	if( fieldName == 'CNT' || fieldName == 'UNIT_PRICE'){
		amt = cnt * unit_price;
		tax = parseInt(amt * 0.1);
		record.set('AMT', fnIsNaN(amt));						// 금액
		record.set('TAX', fnIsNaN(tax));						// 세액
	}
	
	if( fieldName == 'AMT'){
		unit_price = parseInt(amt / cnt);	
		tax = parseInt(amt * 0.1);
		
		record.set('UNIT_PRICE', fnIsNaN(unit_price));			// 단가
		record.set('TAX', fnIsNaN(tax));						// 세액
	}
	
	if( fieldName == 'PREPARE_DATE' || fieldName == 'SAL_EXP_DATE'){

		var record = GridClass_edit_3rd.store.getAt(editedRow);
		
		val = fnGridDateCheck(editedValue);
		record.set(fieldName, val);						
		
	}

}

// 행을  삭제하기전 이벤트
function fnEdit3rdRowValueSelectCheckDelete(){
	var records = GridClass_edit_3rd.grid.selModel.getSelections(); 
	var sale_register = records[0].data.SALE_REGISTER;
	
	if(sale_register == 'N'){
		Ext.Msg.alert('확인', '매출등록된 계산서는 삭제할수 없습니다.'); 
		return false;
	}
	
	return true;
}

// 추가된 행이 삭제 되었을 때
function fnEdit3rdAfterRowDeleteEvent(){
	var records = GridClass_edit_3rd.grid.selModel.getSelections(); 
	
	records[0].set('FLAG','D');
}

// 세금계산서 금액 계산
function fnCalculateTaxAmt(){
	
	//var record = GridClass_edit_3rd.grid.selModel.getSelected(); 
	//var cnt = record.data.CNT;
	
	var rowCnt = GridClass_edit_3rd.store.getCount();  // Grid의 총갯수
	var cnt = 0;			// 수량
	var unit_price = 0 ; 	// 단가
	var amt = 0;    		// 금액
	
	if( rowCnt > 0){
		//row 숫자만큼 돌면서 수량*단가를 가져옴
		for(i = 0 ; i < rowCnt ; i++){
				
			var record 		= GridClass_edit_1st.store.getAt(i);
			var cnt 		= parseInt(GridClass_edit_1st.store.data.items[i].data.CNT) ;   // 할인율
			var unit_price  = parseInt(GridClass_edit_1st.store.data.items[i].data.UNIT_PRICE);						// 유무상구분
			var amt 		= parseFloat(GridClass_edit_1st.store.data.items[i].data.APLY_AMT) ;   				// 할인율
			
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
			
			record.set('AMT', fnIsNaN(rowAMT));						// 금액
			record.set('APLY_AMT', fnIsNaN(discountAMT));			// 적용금액
			record.set('APLY_TAX', fnIsNaN(aplyTaxAMT));			// 적용세액
			record.set('APLY_UNIT_PRICE', fnIsNaN(aplyUnitPrice));	// 적용단가
			
	
		} // end for	
		
			
	} // end if
	
}

// 새로 추가된 행을 삭제 하면
function fnEdit1stBeforeRowDeleteEvent(){
	var records = GridClass_edit_1st.grid.selModel.getSelections(); 
	
	records[0].set('FLAG','D');
}

</script>

</head>
<body class=" ext-gecko ext-gecko3">
	<table border="0" width="1000" height="200">
		<tr>
			<td colspan="2">
				<form name="searchForm" id="searchForm">
				<!----------------- SEARCH Hearder Start	 ----------------->
				<div id="ext-comp-1002" class=" x-panel x-form-label-left" style="margin-top: 0em;"><%-- 0em <- 1em으로 수정하면 상위 공백 --%>
					<div class="x-panel-tl">
						<div class="x-panel-tr">
							<div class="x-panel-tc">
								<div id="ext-gen4" class="x-panel-header x-unselectable" style="-moz-user-select: none;">
									<span id="ext-gen8" class="x-panel-header-text">세금계산서 발행정보검색</span>
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
								<table width="100%">
						    		<%-- 1 Row Start --%>
						    		<tr>
										<td width="21%">
											<div tabindex="-1" class="x-form-item " >
												<label class="x-form-item-label" style="width: auto;" for="src_pjt_id" >프로젝트ID :</label>
												<div style="padding-left: 0px;" class="x-form-element">
													<input type="text" name="src_pjt_id" id="src_pjt_id" autocomplete="off" size="19" class=" x-form-text x-form-field" style="width: auto;">
												</div>
											</div>
										</td>
										<td width="21%">
											<div tabindex="-1" class="x-form-item " >
												<label class="x-form-item-label" style="width: auto;" for="src_pjt_name" >프로젝트명 :</label>
												<div style="padding-left: 0px;" class="x-form-element">
													<input type="text" name="src_pjt_name" id="src_pjt_name" autocomplete="off" size="19" class=" x-form-text x-form-field" style="width: auto;">
												</div>
											</div>
										</td>
								
										<td width="19%">
											<div tabindex="-1" class="x-form-item " >
												<label class="x-form-item-label" style="width: auto;" for="src_ord_custom_name" >거래처명 :</label>
												<div style="padding-left: 61px;" class="x-form-element">
													<input type="text" name="src_ord_custom_name" id="src_ord_custom_name" autocomplete="off" size="20" class=" x-form-text x-form-field" style="width: auto;">		
												</div>
											</div>
										</td>
										<td width="8%" valign="center">
											<div tabindex="-1" class="x-form-item " >
												<div style="padding-left: 0px;" class="x-form-element">
													<%-- 검색 버튼 Start --%>
													<img align="center" id="src_custom_btn" name="src_custom_btn" alt="" src="/resource/images/bass_1st/icon_src1.gif" style="cursor: hand;">
													<%-- 검색 버튼 End	--%>
												</div>
											</div>
										</td>
										<td width="3%">
											<div style="padding-left: 0px;" class="x-form-element">
												<input type="hidden" name="src_ord_custom_code" id="src_ord_custom_code" autocomplete="off" size="20" class=" x-form-text x-form-field" style="width: auto;">
											</div>
										</td>
								
										<td width="28%">
											<div tabindex="-1" class="x-form-item " >
												<label class="x-form-item-label" style="width: auto;" for="src_ord_type_code" ></label>
												<div style="padding-left: 30px;" class="x-form-element">
													<input type="hidden" id="src_ord_type_code" name="src_ord_type_code"/>
<%--													<select name="src_ord_type_code" id="src_ord_type_code" title="수주구분" style="width: 100px;" type="text" class=" x-form-select x-form-field" >--%>
<%--														<option value="">전체</option>--%>
<%--														<c:forEach items="${EST_TYPE_CODE}" var="data" varStatus="status">--%>
<%--														<option value="${data.COM_CODE}"><c:out value="${data.COM_CODE_NAME}"/></option>--%>
<%--														</c:forEach>--%>
<%--													</select>--%>
												</div>
											</div>
										</td>
									</tr>
									<%-- 1 Row End --%>
									<%-- 2 Row Start --%>
									<tr>
										<td width="20%">
											<div tabindex="-1" class="x-form-item " >
												<label class="x-form-item-label" style="width: auto;" for="src_ord_id">수주ID :</label>
												<div style="padding-left: 70px;" class="x-form-element">
													<input type="text" name="src_ord_id" id="src_ord_id" autocomplete="off" size="19" class=" x-form-text x-form-field" style="width: auto;">
												</div>
											</div>
										</td>
										<td width="2%">
											<div tabindex="-1" class="x-form-item " >
												<label class="x-form-item-label" style="width: auto;" for="src_ord_name">수주명 :</label>
												<div style="padding-left: 70px;" class="x-form-element">
													<input type="text" name="src_ord_name" id="src_ord_name" autocomplete="off" size="19" class=" x-form-text x-form-field" style="width: auto;">
												</div>
											</div>
										</td>
										<td colspan="3">
											<div tabindex="-1" class="x-form-item " >
												<label class="x-form-item-label" style="width: auto;" for="src_ord_date_start" >세금계산서 발행 :</label>
												<div style="padding-left: 30px;" class="x-form-element">
													<table>
														<input type="hidden" name="src_ord_date_start" id="src_ord_date_start" autocomplete="off" size="10" style="width: auto;">
														<input type="hidden" name="src_ord_date_end" id="src_ord_date_end" autocomplete="off" size="10" style="width: auto;">
														<tr>
															<td>
																<div tabindex="-1" class="x-form-item " >
																	<div style="padding-left: 0px;" class="x-form-element">
																		<input type="checkbox" id="src_issue" name="src_issue" value="N"/>
																	</div>
																</div>
															</td>
															<td>
																<div tabindex="-1" class="x-form-item " >
																	<label class="x-form-item-label" style="width: auto;" for="src_issue" >완료</label>
																</div>																																				
															</td>
															<td>
																<div tabindex="-1" class="x-form-item " >
																	<div style="padding-left: 0px;" class="x-form-element">
																		<input type="checkbox" id="src_unissued" name="src_unissued" checked="checked" value="Y"/>
																</div>
																	</div>		
															</td>
															<td>
																<div tabindex="-1" class="x-form-item " >
																	<label class="x-form-item-label" style="width: auto;" for="src_unissued" >미완료</label>
																</div>			
															</td>
														</tr>
													</table>
												</div>
											</div>
										</td>
										<td align="right">
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
									<%-- 2 Row End --%>
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
			<!----------------- 세금계산서발행정보 GRID START ----------------->
			<td width="40%" valign="top">
				<div id="grid_1st" style="margin-top: 0em;"></div>
			</td>
			<!----------------- 세금계산서발행정보 GRID END ----------------->
			<td width="60%" valign="top">
				<div class=" x-panel x-form-label-left" style="margin-top: 0em; width: 100%;"><%-- 0em <- 1em으로 수정하면 상위 공백 --%>
					<!----------------- SEARCH Hearder Start	 ----------------->
					<div class="x-panel-tl">
						<div class="x-panel-tr">
							<div class="x-panel-tc">
								<div class="x-panel-header x-unselectable" style="-moz-user-select: none;">
									<span class="x-panel-header-text">세금계산서 발행 상세정보</span>
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
									<form id="detailForm" name="detailForm" method="POST" class="x-panel-body x-form" style="padding: 0px 0px 0pt; width: 600px;">
									<input type="hidden" id="flag" name="flag"/>
									<input type="hidden" id="taxDeleteYn" name="taxDeleteYn"/>
									
									<!-- 2_ROW Start -->
									<div class="x-column-inner" style="width: 100%; margin-top: 0.2em;">
										<div class=" x-panel x-column" style="width: 50%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label class="x-form-item-label" style="width: auto;" for="ord_type_code" >프로젝트ID:</label>
														<div style="padding-left: 80px;" class="x-form-element">
															<input type="text" name="pjt_id" id="pjt_id" autocomplete="off" size="35" class=" x-form-text x-form-field" style="width: auto; text-align:left; IME-MODE:disabled;" onkeyPress="return _chkKeyPressNumOnly(this)" onBlur="_numFormat(this, Math.round(this.value));" onfocus="_removeComma(this, this.value)">
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
														<label class="x-form-item-label" style="width: auto;" for="ord_date" >프로젝트명:</label>
														<div style="padding-left: 90px;" class="x-form-element">
															<input type="text" name="pjt_name" id="pjt_name" autocomplete="off" size="35" class=" x-form-text x-form-field" style="width: auto;">
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
															<input type="text" name="ord_id" id="ord_id" autocomplete="off" size="35" class=" x-form-text x-form-field" style="width: auto;">
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
														<label class="x-form-item-label" style="width: auto;" for="ord_name" >수주명:</label>
														<div style="padding-left: 90px;" class="x-form-element">
															<input type="text" name="ord_name" id="ord_name" autocomplete="off" size="35" class=" x-form-text x-form-field" style="width: auto;">
														</div>
														<div class="x-form-clear-left">
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>
									<!-- 3_ROW End -->
									
									<!-- 2_ROW Start -->
									<div class="x-column-inner" style="width: 100%; margin-top: 0.2em;">
										<div class=" x-panel x-column" style="width: 50%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label class="x-form-item-label" style="width: auto;" for="ord_type_code" >수주구분:</label>
														<div style="padding-left: 80px;" class="x-form-element">
															<select name="ord_type_code" id="ord_type_code" title="수주구분" style="width: 65%;" type="text" class=" x-form-select x-form-field" >
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
														<label class="x-form-item-label" style="width: auto;" for="ord_date" >수주일자:</label>
														<div style="padding-left: 90px;" class="x-form-element">
															<input type="text" name="ord_date" id="ord_date" autocomplete="off" size="35" class=" x-form-text x-form-field" style="width: auto; text-align:right;">
														</div>
														<div class="x-form-clear-left">
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>
									<!-- 2_ROW End -->
									
									<!-- 10_ROW Start -->
									<div class="x-column-inner" style="width: 100%;">
										<div class=" x-panel x-column" style="width: 50%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label class="x-form-item-label" style="width: auto;" for="ord_total_amt" >수주총액:</label>
														<div style="padding-left: 80px;" class="x-form-element">
															<input type="text" name="ord_total_amt" id="ord_total_amt" autocomplete="off" size="35" class=" x-form-text x-form-field" style="width: auto; text-align:right; IME-MODE:disabled;" onkeyPress="return _chkKeyPressNumOnly(this)" onBlur="_numFormat(this, Math.round(this.value));" onfocus="_removeComma(this, this.value)">
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
															<input type="text" name="discnt_total_amt" id="discnt_total_amt" autocomplete="off" size="35" class=" x-form-text x-form-field" style="width: auto; text-align:right; IME-MODE:disabled;" onkeyPress="return _chkKeyPressNumOnly(this)" onBlur="_numFormat(this, Math.round(this.value));" onfocus="_removeComma(this, this.value)">
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
															<input type="text" name="ord_aply_total_amt" id="ord_aply_total_amt" autocomplete="off" size="35" class=" x-form-text x-form-field" style="width: auto; text-align:right; IME-MODE:disabled;" onkeyPress="return _chkKeyPressNumOnly(this)" onBlur="_numFormat(this, Math.round(this.value));" onfocus="_removeComma(this, this.value)">
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
															<input type="text" name="ord_aply_total_tax" id="ord_aply_total_tax" autocomplete="off" size="35" class=" x-form-text x-form-field" style="width: auto; text-align:right; IME-MODE:disabled;" onkeyPress="return _chkKeyPressNumOnly(this)" onBlur="_numFormat(this, Math.round(this.value));" onfocus="_removeComma(this, this.value)">
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
															<select name="tax_issue_type" id="tax_issue_type" style="width: 160px;" type="text" class=" x-form-select x-form-field" >
																<option value="">※ 자동계산됩니다 ※</option>
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
														<label class="x-form-item-label" style="width: auto;" for="tax_mod_issue_cnt" >세금계산서분할횟수:</label>
														<div style="padding-left: 77px;" class="x-form-element">
															<input type="text" name="tax_mod_issue_cnt" id="tax_mod_issue_cnt" autocomplete="off" size="30" class=" x-form-text x-form-field" style="width: auto; text-align: rigth;">
														</div>
														<div class="x-form-clear-left">
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>
									<!-- 12_ROW End -->
									
									
									<!-- 11_ROW Start -->
									<div class="x-column-inner" style="width: 100%;">
										<div class=" x-panel x-column" style="width: 50%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label class="x-form-item-label" style="width: auto;" for="ord_aply_total_amt" >거래처:</label>
														<div style="padding-left: 80px;" class="x-form-element">
															<input type="hidden" name="ord_custom_code" id="ord_custom_code" autocomplete="off" size="10" class=" x-form-text x-form-field" style="width: auto;">
															<input type="text" name="ord_custom_name" id="ord_custom_name" autocomplete="off" size="35" class=" x-form-text x-form-field" style="width: auto;">
															<input type="hidden" name="dve_custom_code" id="dve_custom_code" autocomplete="off" size="10" class=" x-form-text x-form-field" style="width: auto;">
															<input type="hidden" name="dve_custom_name" id="dve_custom_name" autocomplete="off" size="12" class=" x-form-text x-form-field" style="width: auto;">
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
														<label class="x-form-item-label" style="width: auto;" for="ord_aply_total_tax" >거래처담당자:</label>
														<div style="padding-left: 90px;" class="x-form-element">
															<input type="text" name="ord_customer_dept" id="ord_customer_dept" autocomplete="off" size="20" class=" x-form-text x-form-field" style="width: auto;">
															<input type="text" name="ord_customer_name" id="ord_customer_name" autocomplete="off" size="10" class=" x-form-text x-form-field" style="width: auto;">
															<input type="hidden" name="ord_customer_num" id="ord_customer_num" autocomplete="off" size="10" class=" x-form-text x-form-field" style="width: auto;">	
															<input type="hidden" name="dve_customer_num" id="dve_customer_num" autocomplete="off" size="10" class=" x-form-text x-form-field" style="width: auto;">
															<input type="hidden" name="dve_customer_name" id="dve_customer_name" autocomplete="off" size="13" class=" x-form-text x-form-field" style="width: auto;">
														</div>
														<div class="x-form-clear-left">
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>
									<!-- 11_ROW End -->
									
									<!-- DETAIL 2_ROW Start -->
									<div class="x-column-inner" style="width: 100%; margin-top: 0.2em;">
										<div class=" x-panel x-column" style="width: 50%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label class="x-form-item-label" style="width: auto;" for="custom_type" ><font color="red">* </font>거래처구분 :</label>
														<div style="padding-left: 111px;" class="x-form-element">
															<select name="custom_type" id="custom_type" title="거래처구분" style="width:165px;" type="text" class="x-form-select x-form-field" >
																<option value="">선택하세요</option>
																<c:forEach items="${CUSTOM_TYPE}" var="data" varStatus="status">
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
														<label class="x-form-item-label" style="width: auto;" for="est_date" ><font color="red">* </font>사업자번호:</label>
														<div style="padding-left: 90px;" class="x-form-element">
															<input type="text" name="biz_num" id="biz_num" autocomplete="off" size="35" class=" x-form-text x-form-field" style="width: auto;" maxlength="10" onkeyPress="return _chkKeyPressNumOnly(this)" onBlur="_removeComma(this, this.value)" onfocus="_removeComma(this, this.value)">
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
									<div class="x-column-inner" style="width: 100%; margin-top: 0em;">
										<div class=" x-panel x-column" style="width: 50%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label class="x-form-item-label" style="width: auto;" for="per_biz_type" ><font color="red">* </font>개인/사업자구분 :</label>
														<div style="padding-left: 107px;" class="x-form-element">
															<select name="per_biz_type" id="per_biz_type" style="width:165px;" type="text" class="x-form-select x-form-field" >
																<option value="">선택하세요</option>
																<c:forEach items="${PER_BIZ_TYPE_CODE}" var="data" varStatus="status">
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
										<div class="x-panel-bwrap" >
											<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
												<div tabindex="-1" class="x-form-item " >
													<label style="padding-rigth: 100px;"  class="x-form-item-label" style="width: auto;" for="use_yn1" ><font color="red">* </font>전자세금계산서:</label>
													<input type="radio" name="etax_issue_yn" id="etax_issue_yn1" autocomplete="off" class=" x-form-radio x-form-field" value="Y">
												    <label class="x-form-cb-label" for="etax_issue_yn1" >발행</label>
												    <input type="radio" name="etax_issue_yn" id="etax_issue_yn2" autocomplete="off" class=" x-form-radio x-form-field" value="N">
												    <label class="x-form-cb-label" for="etax_issue_yn2" >미발행</label>
													<div class="x-form-clear-left">
													</div>
												</div>
											</div>
										</div>
									</div>
									<!-- DETAIL 3_ROW End -->
									
									<!-- DETAIL 5_ROW Start -->
									<div class="x-column-inner" style="width: 100%; margin-top: 0em;">
										<div class=" x-panel x-column" style="width: 50%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label class="x-form-item-label" style="width: auto;" for="ceo_name" >&nbsp;&nbsp;&nbsp;대표자명 :</label>
														<div style="padding-left: 107px;" class="x-form-element">
															<input type="text" name="ceo_name" id="ceo_name" autocomplete="off" size="29" class=" x-form-text x-form-field" style="width: auto;" maxlength="20"/>
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
														<label class="x-form-item-label" style="width: auto;" for="email" >&nbsp;&nbsp;&nbsp;대표 E-mail :</label>
														<div style="padding-left: 90px;" class="x-form-element">
															<input type="text" name="email" id="email" autocomplete="off" size="35" class=" x-form-text x-form-field" style="width: auto;" maxlength="30"/>
														</div>
														<div class="x-form-clear-left">
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>
									<!-- DETAIL 5_ROW End -->
									
									<!-- DETAIL 6_ROW Start -->
									<div class="x-column-inner" style="width: 100%; margin-top: 0em;">
										<div class=" x-panel x-column" style="width: 50%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label class="x-form-item-label" style="width: auto;" for="biz_type" >&nbsp;&nbsp;&nbsp;업태 :</label>
														<div style="padding-left: 107px;" class="x-form-element">
															<input type="text" name="biz_type" id="biz_type" autocomplete="off" size="29" class=" x-form-text x-form-field" style="width: auto;" maxlength="30"/>
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
														<label class="x-form-item-label" style="width: auto;" for="biz_kind" >&nbsp;&nbsp;&nbsp;업종 :</label>
														<div style="padding-left: 90px;" class="x-form-element">
															<input type="text" name="biz_kind" id="biz_kind" autocomplete="off" size="35" class=" x-form-text x-form-field" style="width: auto;" maxlength="30"/>
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
									<div class="x-column-inner" style="width: 100%; margin-top: 0em;">
										<div class=" x-panel x-column" style="width: 100%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label class="x-form-item-label" style="width: auto;" for="est_type_code" >&nbsp;&nbsp;&nbsp;우편번호:</label>
														<div style="padding-left: 107px;" class="x-form-element">
															<table style="width: 480px;" cellspacing="0" border="0" class="x-btn  x-btn-noicon">
																<tr>
																	<td width="20%">
																		<input type="text" name="zipcode1" id="zipcode1" autocomplete="off" size="2" class="x-form-text x-form-field " style="width: auto;" maxlength="3"/>
																		<input type="text" name="zipcode2" id="zipcode2" autocomplete="off" size="2" class=" x-form-text x-form-field" style="width: auto;" maxlength="3"/>
																	</td>
																	<td width="7%">
																		<%-- Button Start--%>
																		<div style="padding-left: 1px;" >
																			<img align="center" id="addrBtn" name="addrBtn" alt="" src="/resource/images/bass_1st/icon_src1.gif" style="cursor: hand;">
																		</div>
																		<%-- Button End--%>
																	</td>
																	<td>
																		<input stype="text" name="addr" id="addr" autocomplete="off" class=" x-form-text x-form-field" style="width: 385px;" maxlength="500"/>
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
									<!-- DETAIL 7_ROW End -->
									
									<!-- DETAIL 8_ROW Start -->
									<div class="x-column-inner" style="width: 100%; margin-top: 0em;">
										<div class=" x-panel x-column" style="width: 100%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label class="x-form-item-label" style="width: auto;" for="addr_detail" >&nbsp;&nbsp;&nbsp;상세주소:</label>
														<div style="padding-left: 107px;" class="x-form-element">
															<input type="text" name="addr_detail" id="addr_detail" autocomplete="off" class=" x-form-text x-form-field" style="width: 480px;" maxlength="500"/>
														</div>
														<div class="x-form-clear-left">
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>
									<!-- DETAIL 8_ROW End -->
									
									<!-- DETAIL 9_ROW Start -->
									<div class="x-column-inner" style="width: 100%; margin-top: 0em;">
										<div class=" x-panel x-column" style="width: 50%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label class="x-form-item-label" style="width: auto;" for="telephone" >&nbsp;&nbsp;&nbsp;전화번호 :</label>
														<div style="padding-left: 107px;" class="x-form-element">
															<input type="text" name="telephone" id="telephone" autocomplete="off" size="29" class=" x-form-text x-form-field" style="width: auto;" maxlength="20"/>
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
														<label class="x-form-item-label" style="width: auto;" for="fax" >&nbsp;&nbsp;&nbsp;Fax번호 :</label>
														<div style="padding-left: 90px;" class="x-form-element">
															<input type="text" name="fax" id="fax" autocomplete="off" size="35" class=" x-form-text x-form-field" style="width: auto;" maxlength="20"/>
														</div>
														<div class="x-form-clear-left">
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>
									<!-- DETAIL 9_ROW End -->
									
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
			<!----------------- 세금계산서 분할 발행정보 GRID START ----------------->
			<td width="100%" valign="top" colspan="2">
				<div id="edit_grid_3rd" style="margin-top: 0em;"></div>
			</td>
			<!----------------- 세금계산서 분할 발행정보 GRID END ----------------->
		</tr>
		<tr>
			<!----------------- 수주 품목정보 GRID START ----------------->
			<td width="100%" valign="top" colspan="2">
				<div id="edit_grid_1st" style="margin-top: 0em;"></div>
			</td>
			<!----------------- 수주 품목정보 GRID END ----------------->
		</tr>
		<tr>
			<td colspan="2" align="center" height="35">
				<table>
					<tr>
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
											<button type="button" id="updateBtn" name="updateBtn" class=" x-btn-text">저장</button>
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