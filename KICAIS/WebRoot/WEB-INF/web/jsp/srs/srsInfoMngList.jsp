<%--
  Class Name  : srsInfoMngList.jsp
  Description : 기술지원요청 관리
  Modification Information
 
      수정일                   수정자                 수정내용
  -------      --------    ---------------------------
  2011. 4. 01   이준영            최초 생성   

  
  author   : 이준영
  since    : 2011. 4. 01.
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


<script type="text/javascript">
/***************************************************************************
 * 초기값 설정
 ***************************************************************************/
var	gridHeigth_1st 	 	= 300; 						// 그리드 전체 높이
var	gridWidth_1st		= 1022;						// 그리드 전체 폭
var gridTitle_1st 		= "기술지원요청";	  		// 그리드 제목
var	render_1st			= "task-grid";	  			// 렌더(화면에 그려질) 할 id 
var	pageSize_1st		= 20	  						// 그리드 페이지 사이즈	
var	proxyUrl_1st		= "/srs/result.sg?src_srs_emp_gubun="+Ext.get('src_srs_emp_gubun').getValue()		// 결과 값 페이지
var limit_1st			= pageSize_1st;
var start_1st			= 0;




/***************************************************************************
 * Grid의 컬럼 설정
 ***************************************************************************/
var userColumns_1st =  [ {header: '상태',          	  width: 100, sortable: true, dataIndex: 'FLAG', hidden : true}                                                            
						,{header: '업무요청 ID',       width: 100, sortable: true, dataIndex: 'CSR_ID'}                                                          
						,{header: '제목',              width: 100, sortable: true, dataIndex: 'SRS_TITLE'}                                                       
						,{header: '프로젝트 ID',       width: 100, sortable: true, dataIndex: 'PJT_ID'}                                                          
						,{header: '프로젝트 명',       width: 100, sortable: true, dataIndex: 'PJT_NAME', hidden : true}  
						,{header: '엔드유저',          width: 100, sortable: true, dataIndex: 'END_NAME'}                                                        
						,{header: '엔드유저담당자부서',    width: 100, sortable: true, dataIndex: 'ENDUSER_DEPT_NAME', hidden : true}                                                    
						,{header: '엔드유저담당자',    width: 100, sortable: true, dataIndex: 'ENDUSER_NAME', hidden : true}                                                    
						,{header: '엔드유저연락처',    width: 100, sortable: true, dataIndex: 'ENDUSER_TELEPHONE', hidden : true}                                               
						,{header: '거래처',            width: 100, sortable: true, dataIndex: 'CUSTOM_NAME', hidden : true}                                                     
						,{header: '거래처담당자부서',      width: 100, sortable: true, dataIndex: 'CUSTOMER_DEPT_NAME', hidden : true}                                                   
						,{header: '거래처담당자',      width: 100, sortable: true, dataIndex: 'CUSTOMER_NAME', hidden : true}                                                   
						,{header: '거래처연락처',      width: 100, sortable: true, dataIndex: 'CUSTOMER_TELEPHONE', hidden : true}                                              
						,{header: '의뢰자',            width: 100, sortable: true, dataIndex: 'SRS_REQ_EMP', hidden : true}                                                     
						,{header: '의뢰자부서명',      width: 100, sortable: true, dataIndex: 'SRS_REQ_EMP_DEPT_NAME', hidden : true}  
						,{header: '의뢰자',          width: 100, sortable: true, dataIndex: 'SRS_REQ_EMP_NAME'}
						,{header: '1차 승인부서',     width: 100, sortable: true, dataIndex: 'SRS_MGR_DEPT_1', hidden : true}                                                  
						,{header: '1차 승인부서명',    width: 100, sortable: true, dataIndex: 'SRS_MGR_DEPT_NAME_1', hidden : true}                                             
						,{header: '1차 승인자',        width: 100, sortable: true, dataIndex: 'SRS_MGR_1', hidden : true}                                                       
						,{header: '1차 승인자명',        width: 100, sortable: true, dataIndex: 'SRS_MGR_NAME_1', hidden : true}                                                       
						,{header: '1차 지원담당자',    width: 100, sortable: true, dataIndex: 'SUP_EMP_1', hidden : true}                                                       
						,{header: '1차 지원담당자',  width: 100, sortable: true, dataIndex: 'SUP_EMP_NAME_1'}        
						,{header: '2차 승인부서',      width: 100, sortable: true, dataIndex: 'SRS_MGR_DEPT_2', hidden : true}                                                  
						,{header: '2차 승인부서명',    width: 100, sortable: true, dataIndex: 'SRS_MGR_DEPT_NAME_2', hidden : true}                                             
						,{header: '2차 승인자',        width: 100, sortable: true, dataIndex: 'SRS_MGR_2', hidden : true}                                                       
						,{header: '2차 승인자명',        width: 100, sortable: true, dataIndex: 'SRS_MGR_NAME_2', hidden : true}                                                       
						,{header: '2차 지원담당자',    width: 100, sortable: true, dataIndex: 'SUP_EMP_2', hidden : true}                                                       
						,{header: '2차 지원담당자',  width: 100, sortable: true, dataIndex: 'SUP_EMP_NAME_2'}                
						,{header: '지원상태',          width: 100, sortable: true, dataIndex: 'SRS_STATUS', hidden : true}                                                      
						,{header: '지원상태',        width: 100, sortable: true, dataIndex: 'SRS_STATUS_NAME'}                                                 
						,{header: '의뢰요청일',        width: 100, sortable: true, dataIndex: 'SRS_REQ_DATE', hidden : true}                                                   
						,{header: '의뢰승인일',        width: 100, sortable: true, dataIndex: 'SRS_AGR_DATE'}                                                    
						,{header: '기한일',            width: 100, sortable: true, dataIndex: 'TARGET_DATE'}                                                     
						,{header: '희망처리기간 TO',   width: 100, sortable: true, dataIndex: 'PLAN_DATE_TO', hidden : true}                                                    
						,{header: '희망처리시간 TO',   width: 100, sortable: true, dataIndex: 'PLAN_TIME_TO', hidden : true}                                                    
						,{header: '희망처리기간 FROM', width: 100, sortable: true, dataIndex: 'PLAN_DATE_FROM', hidden : true}                                                  
						,{header: '희망처리시간 FROM', width: 100, sortable: true, dataIndex: 'PLAN_TIME_FROM', hidden : true}                                                  
						,{header: '실제처리기간 TO',   width: 100, sortable: true, dataIndex: 'PROC_DATE_TO', hidden : true}                                                    
						,{header: '실제처리시간 TO',   width: 100, sortable: true, dataIndex: 'PROC_TIME_TO', hidden : true}                                                    
						,{header: '실제처리기간 FROM', width: 100, sortable: true, dataIndex: 'PROC_DATE_FROM', hidden : true}                                                  
						,{header: '실제처리시간 FROM', width: 100, sortable: true, dataIndex: 'PROC_TIME_FROM', hidden : true}                                                  
						,{header: '완료일',            width: 100, sortable: true, dataIndex: 'TERMINATE_DATE'}                                                  
						,{header: '방문위치정보',      width: 100, sortable: true, dataIndex: 'VISIT_NAVI', hidden : true}                                                      
						,{header: '방문위치URL',      width: 100, sortable: true, dataIndex: 'VISIT_NAVI_URL', hidden : true}                                                      
						,{header: '의뢰내역',          width: 100, sortable: true, dataIndex: 'SRS_DETAIL', hidden : true}                                                      
						,{header: '처리내역',          width: 100, sortable: true, dataIndex: 'SRS_PROC_DETAIL', hidden : true}                                                 
						,{header: '요청사항',          width: 100, sortable: true, dataIndex: 'REQ_ITEM', hidden : true}                                                        
						,{header: '비고',              width: 100, sortable: true, dataIndex: 'NOTE', hidden : true}                                                            
						,{header: '최종변경자ID',      width: 100, sortable: true, dataIndex: 'FINAL_MOD_ID', hidden : true}                                                    
						,{header: '최종변경일시',      width: 100, sortable: true, dataIndex: 'FINAL_MOD_DATE', hidden : true}            										 
						,{header: '등록자ID',          width: 100, sortable: true, dataIndex: 'REG_ID', hidden : true}                                                          
						,{header: '등록일시',          width: 100, sortable: true, dataIndex: 'REG_DATE', hidden : true}  
						,{header: '기술지원범주',      width: 100, sortable: true, dataIndex: 'SRS_TYPE_CODE', hidden : true}  
					   ];	 

/***************************************************************************
 * 그리드 결과매핑 
 ***************************************************************************/
var mappingColumns_1st = [ 
						   {name: 'FLAG', allowBlank: false}                    //상태          	                                           
							,{name: 'CSR_ID', allowBlank: false}                  //업무요청 ID                                                 
							,{name: 'SRS_TITLE', allowBlank: false}               //제목                                                        
							,{name: 'PJT_ID', allowBlank: false}                  //프로젝트 ID                                                 
							,{name: 'PJT_NAME', allowBlank: false}                  //프로젝트 명  
							,{name: 'END_NAME', allowBlank: false}                //엔드유저                                                    
							,{name: 'ENDUSER_DEPT_NAME', allowBlank: false}            //엔드유저담당자부서                                              
							,{name: 'ENDUSER_NAME', allowBlank: false}            //엔드유저담당자                                              
							,{name: 'ENDUSER_TELEPHONE', allowBlank: false}       //엔드유저연락처                                              
							,{name: 'CUSTOM_NAME', allowBlank: false}             //거래처                                                      
							,{name: 'CUSTOMER_DEPT_NAME', allowBlank: false}      //거래처담당자부서                                                
							,{name: 'CUSTOMER_NAME', allowBlank: false}           //거래처담당자                                                
							,{name: 'CUSTOMER_TELEPHONE', allowBlank: false}      //거래처연락처                                                
							,{name: 'SRS_REQ_EMP', allowBlank: false}             //의뢰자                                                      
							,{name: 'SRS_REQ_EMP_DEPT_NAME', allowBlank: false}             //의뢰자부서명                                                      
							,{name: 'SRS_REQ_EMP_NAME', allowBlank: false}        //의뢰자명            
							,{name: 'SRS_MGR_DEPT_1', allowBlank: false}          //1차 승인부서                                                
							,{name: 'SRS_MGR_DEPT_NAME_1', allowBlank: false}     //1차 승인부서명                                              
							,{name: 'SRS_MGR_1', allowBlank: false}               //1차 승인자                                                  
							,{name: 'SRS_MGR_NAME_1', allowBlank: false}               //1차 승인자명                                                  
							,{name: 'SUP_EMP_1', allowBlank: false}               //1차 지원담당자                                              
							,{name: 'SUP_EMP_NAME_1', allowBlank: false}          //1차 지원담당자명    
							,{name: 'SRS_MGR_DEPT_2', allowBlank: false}          //2차 승인부서                                                
							,{name: 'SRS_MGR_DEPT_NAME_2', allowBlank: false}     //2차 승인부서명                                              
							,{name: 'SRS_MGR_2', allowBlank: false}               //2차 승인자 
							,{name: 'SRS_MGR_NAME_2', allowBlank: false}          //2차 승인자명                                                   
							,{name: 'SUP_EMP_2', allowBlank: false}               //2차 지원담당자                                              
							,{name: 'SUP_EMP_NAME_2', allowBlank: false}          //2차 지원담당자명          
							,{name: 'SRS_STATUS', allowBlank: false}              //지원상태                                                    
							,{name: 'SRS_STATUS_NAME', allowBlank: false}         //지원상태명                                                  
							,{name: 'SRS_REQ_DATE', allowBlank: false}           //의뢰요청일                                                  
							,{name: 'SRS_AGR_DATE', allowBlank: false}            //의뢰승인일                                                  
							,{name: 'TARGET_DATE', allowBlank: false}             //기한일                                                      
							,{name: 'PLAN_DATE_TO', allowBlank: false}            //희망처리기간 TO                                             
							,{name: 'PLAN_TIME_TO', allowBlank: false}            //희망처리시간 TO                                             
							,{name: 'PLAN_DATE_FROM', allowBlank: false}          //희망처리기간 FROM                                           
							,{name: 'PLAN_TIME_FROM', allowBlank: false}          //희망처리시간 FROM                                           
							,{name: 'PROC_DATE_TO', allowBlank: false}            //실제처리기간 TO                                             
							,{name: 'PROC_TIME_TO', allowBlank: false}            //실제처리시간 TO                                             
							,{name: 'PROC_DATE_FROM', allowBlank: false}          //실제처리기간 FROM                                           
							,{name: 'PROC_TIME_FROM', allowBlank: false}          //실제처리시간 FROM                                           
							,{name: 'TERMINATE_DATE', allowBlank: false}          //완료일                                                      
							,{name: 'VISIT_NAVI', allowBlank: false}              //방문위치정보                                                
							,{name: 'VISIT_NAVI_URL', allowBlank: false}          //방문위치URL                                                
							,{name: 'SRS_DETAIL', allowBlank: false}              //의뢰내역                                                    
							,{name: 'SRS_PROC_DETAIL', allowBlank: false}         //처리내역                                                    
							,{name: 'REQ_ITEM', allowBlank: false}                //요청사항                                                    
							,{name: 'NOTE', allowBlank: false}                    //비고                                                        
							,{name: 'FINAL_MOD_ID', allowBlank: false}            //최종변경자ID                                                
							,{name: 'FINAL_MOD_DATE', allowBlank: false}          //최종변경일시          										 
							,{name: 'REG_ID', allowBlank: false}                  //등록자ID                                                    
							,{name: 'REG_DATE', allowBlank: false}                //등록일시  
							,{name: 'SRS_TYPE_CODE', allowBlank: false}                //기술지원범주  
	    				 ];
 
/***************************************************************************
 * 그리드 클릭시 Event
 ***************************************************************************/
function fnGridOnClick_1st(store, rowIndex){

	var dForm = document.detailForm;		// 상세 FORM
	
	/***** 선택된 레코드에서 데이타 가져오기 *****/
	Ext.get('flag_detailForm').set({value : fnFixNull(store.getAt(rowIndex).data.FLAG)}, false);	
	
	Ext.get('csr_id').set({value : fnFixNull(store.getAt(rowIndex).data.CSR_ID)}, false);							//	업무요청 ID 
	Ext.get('srs_type_code').set({value : fnFixNull(store.getAt(rowIndex).data.SRS_TYPE_CODE)}, false);				//	기술지원범주  
	                                                                                                        		
	Ext.get('pjt_id').set({value : fnFixNull(store.getAt(rowIndex).data.PJT_ID)}, false);							//	프로젝트 ID 
	Ext.get('srs_title').set({value : fnFixNull(store.getAt(rowIndex).data.SRS_TITLE)}, false);						//	제목  
	                                                                                                        		
	                                                                                                        		
	Ext.get('srs_req_emp').set({value : fnFixNull(store.getAt(rowIndex).data.SRS_REQ_EMP)}, false);					//	의뢰자  
	                                                                                                        		
	Ext.get('sup_emp_1').set({value : fnFixNull(store.getAt(rowIndex).data.SUP_EMP_1)}, false);						//	1차 지원담당자
	                                                                                                				
	Ext.get('srs_mgr_2').set({value : fnFixNull(store.getAt(rowIndex).data.SRS_MGR_2)}, false);						//	2차 승인자  
	Ext.get('sup_emp_2').set({value : fnFixNull(store.getAt(rowIndex).data.SUP_EMP_2)}, false);						//	2차 지원담당자
	

	Ext.get('pjt_name').set({value : fnFixNull(store.getAt(rowIndex).data.PJT_NAME)}, false);                     			//프로젝트 명       		                             
	Ext.get('end_name').set({value : fnFixNull(store.getAt(rowIndex).data.END_NAME)}, false);                     			//엔드유저          		                           
	Ext.get('enduser_dept_name').set({value : fnFixNull(store.getAt(rowIndex).data.ENDUSER_DEPT_NAME)}, false);         	//엔드유저담당자부서    	                                
	Ext.get('enduser_name').set({value : fnFixNull(store.getAt(rowIndex).data.ENDUSER_NAME)}, false);                 		//엔드유저담당자    		                           
	Ext.get('enduser_telephone').set({value : fnFixNull(store.getAt(rowIndex).data.ENDUSER_TELEPHONE)}, false);         	//엔드유저연락처    		                           
	Ext.get('custom_name').set({value : fnFixNull(store.getAt(rowIndex).data.CUSTOM_NAME)}, false);                  		//거래처            		                           
	Ext.get('customer_dept_name').set({value : fnFixNull(store.getAt(rowIndex).data.CUSTOMER_DEPT_NAME)}, false);       	//거래처담당자부서      	                                
	Ext.get('customer_name').set({value : fnFixNull(store.getAt(rowIndex).data.CUSTOMER_NAME)}, false);                		//거래처담당자      		                           
	Ext.get('customer_telephone').set({value : fnFixNull(store.getAt(rowIndex).data.CUSTOMER_TELEPHONE)}, false);       	//거래처연락처      		                           
	Ext.get('srs_req_emp_dept_name').set({value : fnFixNull(store.getAt(rowIndex).data.SRS_REQ_EMP_DEPT_NAME)}, false); 	//의뢰자부서명      		
	Ext.get('srs_req_emp_name').set({value : fnFixNull(store.getAt(rowIndex).data.SRS_REQ_EMP_NAME)}, false);             	//의뢰자명          		
	Ext.get('srs_mgr_dept_1').set({value : fnFixNull(store.getAt(rowIndex).data.SRS_MGR_DEPT_1)}, false);               	//1차 승인부서     		                           
	Ext.get('srs_mgr_dept_name_1').set({value : fnFixNull(store.getAt(rowIndex).data.SRS_MGR_DEPT_NAME_1)}, false);         //1차 승인부서명    		                           
	Ext.get('srs_mgr_1').set({value : fnFixNull(store.getAt(rowIndex).data.SRS_MGR_1)}, false);                    			//1차 승인자        		                           
	Ext.get('srs_mgr_name_1').set({value : fnFixNull(store.getAt(rowIndex).data.SRS_MGR_NAME_1)}, false);               	//1차 승인자명        	                                
	Ext.get('sup_emp_name_1').set({value : fnFixNull(store.getAt(rowIndex).data.SUP_EMP_NAME_1)}, false);               	//1차 지원담당자명  		
	Ext.get('srs_mgr_dept_2').set({value : fnFixNull(store.getAt(rowIndex).data.SRS_MGR_DEPT_2)}, false);               	//2차 승인부서      		                           

	Ext.get('srs_mgr_name_2').set({value : fnFixNull(store.getAt(rowIndex).data.SRS_MGR_NAME_2)}, false);               	//2차 승인자명        	                                
	Ext.get('sup_emp_name_2').set({value : fnFixNull(store.getAt(rowIndex).data.SUP_EMP_NAME_2)}, false);               	//2차 지원담당자명  		
	
	Ext.get('srs_status').set({value : fnFixNull(store.getAt(rowIndex).data.SRS_STATUS)}, false);                   		//지원상태          		                           
	Ext.get('saved_srs_status').set({value : fnFixNull(store.getAt(rowIndex).data.SRS_STATUS)}, false);                   		      		                           


	Ext.get('srs_req_date').set({value : fnFixNull(store.getAt(rowIndex).data.SRS_REQ_DATE)}, false);                 		//의뢰요청일        		                           
	Ext.get('srs_agr_date').set({value : fnFixNull(store.getAt(rowIndex).data.SRS_AGR_DATE)}, false);                 		//의뢰승인일        		                           

	Ext.get('target_date').set({value : fnFixNull(store.getAt(rowIndex).data.TARGET_DATE)}, false);                  		//기한일            		                           
	Ext.get('plan_date_to').set({value : fnFixNull(store.getAt(rowIndex).data.PLAN_DATE_TO)}, false);                 		//희망처리기간 TO   		                           
	Ext.get('plan_time_to').set({value : fnFixNull(store.getAt(rowIndex).data.PLAN_TIME_TO)}, false);                 		//희망처리시간 TO   		                           
	Ext.get('plan_date_from').set({value : fnFixNull(store.getAt(rowIndex).data.PLAN_DATE_FROM)}, false);               	//희망처리기간 FROM 		                           
	Ext.get('plan_time_from').set({value : fnFixNull(store.getAt(rowIndex).data.PLAN_TIME_FROM)}, false);              		//희망처리시간 FROM 		                           
	Ext.get('proc_date_to').set({value : fnFixNull(store.getAt(rowIndex).data.PROC_DATE_TO)}, false);                 		//실제처리기간 TO   		                           
	Ext.get('proc_time_to').set({value : fnFixNull(store.getAt(rowIndex).data.PROC_TIME_TO)}, false);                 		//실제처리시간 TO   		                           
	Ext.get('proc_date_from').set({value : fnFixNull(store.getAt(rowIndex).data.PROC_DATE_FROM)}, false);               	//실제처리기간 FROM 		                           
	Ext.get('proc_time_from').set({value : fnFixNull(store.getAt(rowIndex).data.PROC_TIME_FROM)}, false);               	//실제처리시간 FROM 		                           
	Ext.get('terminate_date').set({value : fnFixNull(store.getAt(rowIndex).data.TERMINATE_DATE)}, false);               	//완료일            		                           
	Ext.get('visit_navi').set({value : fnFixNull(store.getAt(rowIndex).data.VISIT_NAVI)}, false);                   		//방문위치정보      		                           
	Ext.get('visit_navi_url').set({value : fnFixNull(store.getAt(rowIndex).data.VISIT_NAVI_URL)}, false);                   //방문위치URL      		                           
	
	Ext.get('srs_detail').set({value : fnFixNull(store.getAt(rowIndex).data.SRS_DETAIL)}, false);                   		//의뢰내역          		                           
	Ext.get('srs_proc_detail').set({value : fnFixNull(store.getAt(rowIndex).data.SRS_PROC_DETAIL)}, false);              	//처리내역    
	
	
	
	//요청항목
	var savedReqItemTmp = fnFixNull(store.getAt(rowIndex).data.REQ_ITEM);
	var savedReqItem = savedReqItemTmp.split("^");	

	for( var i = 0; i < dForm.req_item.length ; i++)		//초기화
	{ 		
   		dForm.req_item[i].checked = false;	
	} 

		
	for( var k = 0; k < savedReqItem.length ; k++)
	{ 
	
	 	for( var i = 0; i < dForm.req_item.length ; i++)
	 	{ 		

			   if(savedReqItem[k] == dForm.req_item[i].value)	
			   {
	           		dForm.req_item[i].checked = true;	
	           }
	    } 
	}	 		
	
	
	if(Ext.get('srs_mgr_2').getValue() !='')		//2차 지원담당이 존재할경우
	{	
		Ext.get('div_srs_mgr_dept_2').show();
		
		Ext.get('checkSrsMgrDept2').dom.checked = true;		

		
	}else
	{
		Ext.get('div_srs_mgr_dept_2').setStyle({'visibility':'hidden'}); 
		
		Ext.get('checkSrsMgrDept2').dom.checked = false;
	}	
	
	
	Ext.get('saveBtn').dom.disabled   = true;
	Ext.get('updateBtn').dom.disabled = false;	
	
;}   


/***************************************************************************
 * 설  명 : 그리드의 페이지 클릭시 검색조건값을 DB로 전송
 ***************************************************************************/
function fnPagingValue_1st(){
	var sForm = document.searchForm;
	
	try{
    	GridClass_1st.store.setBaseParam('src_pjt_id', 			Ext.get('src_pjt_id').getValue());
    	GridClass_1st.store.setBaseParam('src_end_name', 		Ext.get('src_end_name').getValue());
    	GridClass_1st.store.setBaseParam('src_srs_req_emp', 	Ext.get('src_srs_req_emp').getValue());
    	GridClass_1st.store.setBaseParam('src_sup_emp',     	Ext.get('src_sup_emp').getValue());    	
    	GridClass_1st.store.setBaseParam('src_srs_status',  	Ext.get('src_srs_status').getValue());
    	GridClass_1st.store.setBaseParam('src_srs_dept_code',   Ext.get('src_srs_dept_code').getValue());
    	GridClass_1st.store.setBaseParam('src_srs_date_from',   Ext.get('src_srs_date_from_tmp').getValue().replaceAll("-", ""));
    	GridClass_1st.store.setBaseParam('src_srs_date_to',     Ext.get('src_srs_date_to_tmp').getValue().replaceAll("-", ""));
    	
	}catch(e){

	}
}


/***************************************************************************
 * 설  명 : 필드 초기화
 **************************************************************************/
function fnInitValue(){
	var dForm = document.detailForm;		// 상세 FORM	
	
	dForm.reset();							// 상세필드 초기화
		
	 var toDay = getTimeStamp(); 
	 toDay = toDay.replaceAll('-','');
	 toDay = addDate(toDay, 'M', -3);
	 toDay = toDay.substring(0,4)+"-"+toDay.substring(4,6)+"-"+toDay.substring(6,8);
	 var fromDay = toDay;
	 toDay = getTimeStamp().trim();
	 
	 Ext.get('src_srs_date_from_tmp').set({value:fromDay} , false);
	 Ext.get('src_srs_date_to_tmp').set({value:toDay} , false);
	 
	 if(Ext.get('srs_req_date').getValue() =='')		//의뢰요청일
	 {
	 	 Ext.get('srs_req_date').set({value:toDay} , false);
	 }

	 if(Ext.get('csr_id').getValue() =='')		
	 {
	 	 Ext.get('srs_req_emp_dept_name').set({value:"${EMPINFO[0].DEPT_NAME}"} , false);	//의뢰부서명
	 	 Ext.get('srs_req_emp').set({value:"${EMPINFO[0].EMP_NUM}"} , false);	//의뢰자
	 	 Ext.get('srs_req_emp_name').set({value:"${EMPINFO[0].KOR_NAME}"} , false);	//의뢰자명
	 }
		
	Ext.get('div_srs_mgr_dept_2').setStyle({'visibility':'hidden'}); 
	Ext.get('srs_mgr_dept_2').set({value:''} , false);
	Ext.get('srs_mgr_name_2').set({value:''} , false);
	Ext.get('sup_emp_2').set({value:''} , false);
	Ext.get('sup_emp_name_2').set({value:''} , false);
	
	
	disableFormElements(dForm);
	
	Ext.get('srs_proc_detail').dom.disabled   = false;			//처리내역
	Ext.get('csr_id').dom.disabled   = false;					//csr_id
	Ext.get('srs_req_emp').dom.disabled   = false;				//의뢰부서
	Ext.get('srs_req_emp').dom.disabled   = false;				//의뢰자
	Ext.get('srs_req_date').dom.disabled   = false;				//의뢰요청일
	
	Ext.get('srs_mgr_dept_name_1').dom.disabled   = false;		//1차 지원부서
	Ext.get('srs_mgr_name_1').dom.disabled   = false;			//1차 팀장
	Ext.get('srs_mgr_dept_1').dom.disabled   = false;		
	Ext.get('srs_mgr_1').dom.disabled   = false;			
	
	Ext.get('visit_navi').dom.disabled   = false;				//방문위치 URL
	Ext.get('visit_navi_url').dom.disabled   = false;			//방문위치 URL
	
	Ext.get('terminate_date').dom.disabled   = false;			//완료일	
	
	Ext.get('srs_status').dom.disabled   = false;			//상태	
	
		
	 if(Ext.get('src_srs_emp_gubun').getValue() =='AA')		//의뢰자
	 {
	 	
	 	//Ext.get('pjt_btn').dom.disabled   = false;		//프로젝트
	 	Ext.get("pjt_btn").show();	    
	 	
	 	Ext.get('pjt_id').dom.disabled   = false;		//프로젝트
	 	Ext.get('pjt_name').dom.disabled   = false;		//프로젝트
	 	
	 	Ext.get('srs_title').dom.disabled   = false;		//제목
	 	
	 	//Ext.get('end_name_btn').dom.disabled   = false;				//엔드유저담당
	 	Ext.get("end_name_btn").show();	
	 	
	 	Ext.get('enduser_name').dom.disabled   = false;				
	 	Ext.get('enduser_dept_name').dom.disabled   = false;		
	 	Ext.get('end_name').dom.disabled   = false;					
	 	Ext.get('enduser_telephone').dom.disabled   = false;		
	 	
	 	//Ext.get('custom_name_btn').dom.disabled   = false;		//거래처 담당자
	 	Ext.get("custom_name_btn").show();	
	 	
	 	Ext.get('customer_name').dom.disabled   = false;			
	 	Ext.get('customer_dept_name').dom.disabled   = false;		
	 	Ext.get('custom_name').dom.disabled   = false;				
	 	Ext.get('customer_telephone').dom.disabled   = false;		
	 	
	 	Ext.get('custom_same_yn').dom.disabled   = false;		
	 	
	 	
	 	//Ext.get('visit_navi_btn').dom.disabled   = false;		//방문위치정보
	 	Ext.get("visit_navi_btn").show();	
	 	
	 	Ext.get('srs_detail').dom.disabled   = false;			//외뢰내역
	 	Ext.get('srs_type_code').dom.disabled   = false;		//기술지원범주
	 	Ext.get('srs_status').dom.disabled   = false;			//상태
	 	
	 	Ext.get('target_date').dom.disabled   = false;			//기한일
	 	
	 	Ext.get('plan_date_from').dom.disabled   = false;		//희망처리기간
	 	Ext.get('plan_time_from').dom.disabled   = false;	
	 	Ext.get('plan_date_to').dom.disabled   = false;		
	 	Ext.get('plan_time_to').dom.disabled   = false;		
	 	
	 	
	 	
 	   for( var i = 0; i < dForm.req_item.length ; i++){ 		//요청항목
            dForm.req_item[i].disabled = false; 
       } 
	 
		
		//font 색상
		Ext.get('font_end_name').dom.color="#FF0000";
		Ext.get('font_custom_name').dom.color="#FF0000";
		Ext.get('font_visit_navi').dom.color="#FF0000";
		Ext.get('font_srs_detail').dom.color="#FF0000";

	 	
	 }else if(Ext.get('src_srs_emp_gubun').getValue() =='BB')		//1차팀장
	 {
	 	Ext.get('srs_type_code').dom.disabled   = false;			//기술지원범주	
	 	
	 	Ext.get('target_date').dom.disabled   = false;			//기한일
	 	Ext.get('plan_date_from').dom.disabled   = false;		//희망처리기간
	 	Ext.get('plan_time_from').dom.disabled   = false;	
	 	Ext.get('plan_date_to').dom.disabled   = false;		
	 	Ext.get('plan_time_to').dom.disabled   = false;		
	 
	 	//Ext.get('sup_emp_btn_1').dom.disabled   = false;			//1차 지원담당
	 	Ext.get("sup_emp_btn_1").show();
	 	
	 	Ext.get('sup_emp_name_1').dom.disabled   = false;
	 	Ext.get('sup_emp_1').dom.disabled   = false;
	 	
	 	Ext.get('checkSrsMgrDept2').dom.disabled   = false;			// 이관
	 	
	 	Ext.get('checkSrsMgrDept2').dom.disabled   = false;			//2차지원 이관
	 	
	 	Ext.get('srs_mgr_2').dom.disabled   = false;				//2차 지원담당
	 	Ext.get('sup_emp_2').dom.disabled   = false;
	 	Ext.get('srs_mgr_dept_2').dom.disabled   = false;
	 	Ext.get('srs_mgr_name_2').dom.disabled   = false;
	 	Ext.get('sup_emp_name_2').dom.disabled   = false;
	 	
	 	Ext.get('srs_proc_detail').dom.disabled   = false;			//처리내역

	
		//font 색상
		Ext.get('font_srs_type_code').dom.color="#FF0000";
		Ext.get('font_target_date').dom.color="#FF0000";
		Ext.get('font_plan_date_from').dom.color="#FF0000";
		Ext.get('font_sup_emp_name_1').dom.color="#FF0000";
		
		Ext.get('font_srs_mgr_dept_2').dom.color="#FF0000";
		Ext.get('font_srs_mgr_name_2').dom.color="#FF0000";
		Ext.get('font_sup_emp_name_2').dom.color="#FF0000";
	 		
	 }else if(Ext.get('src_srs_emp_gubun').getValue() =='CC')		//1차팀원
	 {
	 	Ext.get('proc_date_from').dom.disabled   = false;			//실제처리기간
	 	Ext.get('proc_time_from').dom.disabled   = false;	
	 	Ext.get('proc_date_to').dom.disabled   = false;		
	 	Ext.get('proc_time_to').dom.disabled   = false;		
	 	
	 	Ext.get('srs_proc_detail').dom.disabled   = false;			//처리내역
	 	
		Ext.get('font_proc_date_from').dom.color="#FF0000";
		Ext.get('font_srs_proc_detail').dom.color="#FF0000";

	 	
	 }else if(Ext.get('src_srs_emp_gubun').getValue() =='DD')		//2차팀장
	 {
	 	Ext.get('srs_type_code').dom.disabled   = false;			//기술지원범주	
	 	
	 	Ext.get('target_date').dom.disabled   = false;			//기한일
	 	Ext.get('plan_date_from').dom.disabled   = false;		//희망처리기간
	 	Ext.get('plan_time_from').dom.disabled   = false;	
	 	Ext.get('plan_date_to').dom.disabled   = false;		
	 	Ext.get('plan_time_to').dom.disabled   = false;		
	 	

	 	Ext.get('div_srs_mgr_dept_2').show();
	 	Ext.get('srs_mgr_2').dom.disabled   = false;				//2차 지원담당
	 	Ext.get('sup_emp_2').dom.disabled   = false;
	 	Ext.get('srs_mgr_dept_2').dom.disabled   = false;
	 	Ext.get('srs_mgr_name_2').dom.disabled   = false;
	 	Ext.get('sup_emp_name_2').dom.disabled   = false;
	 	//Ext.get('sup_emp_btn_2').dom.disabled   = false;
	 
	Ext.get("sup_emp_btn_2").show(); 
	 	
	 	Ext.get('srs_proc_detail').dom.disabled   = false;			//처리내역
	 	
	 	
	 	//font 색상
		Ext.get('font_srs_type_code').dom.color="#FF0000";
		Ext.get('font_target_date').dom.color="#FF0000";
		Ext.get('font_plan_date_from').dom.color="#FF0000";
		Ext.get('font_sup_emp_name_1').dom.color="#FF0000";
		
		Ext.get('font_srs_mgr_dept_2').dom.color="#FF0000";
		Ext.get('font_srs_mgr_name_2').dom.color="#FF0000";
		Ext.get('font_sup_emp_name_2').dom.color="#FF0000";
	 	
	 }else if(Ext.get('src_srs_emp_gubun').getValue() =='EE')		//2차팀원
	 {
	 	
	 	Ext.get('proc_date_from').dom.disabled   = false;			//실제처리기간
	 	Ext.get('proc_time_from').dom.disabled   = false;	
	 	Ext.get('proc_date_to').dom.disabled   = false;		
	 	Ext.get('proc_time_to').dom.disabled   = false;		
	 	
	 	
	 	Ext.get('srs_proc_detail').dom.disabled   = false;			//처리내역
	 	
	 	Ext.get('font_proc_date_from').dom.color="#FF0000";
		Ext.get('font_srs_proc_detail').dom.color="#FF0000";
	 	
	 }else if(Ext.get('src_srs_emp_gubun').getValue() =='ZZ')		//대표이사,임원
	 {
	 	enableFormElements(dForm);		//해제
	 }
	
	
	
	Ext.get('custom_same_yn').dom.checked = false;
	Ext.get('checkSrsMgrDept2').dom.checked = false;
	
	Ext.get('detailClearBtn').dom.disabled   = false;
	Ext.get('saveBtn').dom.disabled   = false;
	Ext.get('updateBtn').dom.disabled = true;
	

}

/***************************************************************************
 * 설  명 : 검색
 **************************************************************************/
function fnSearch(){  	


	var sForm = document.searchForm;

	sForm.src_srs_date_from.value = sForm.src_srs_date_from_tmp.value.replace(/-/g,"");		   	 
	sForm.src_srs_date_to.value = sForm.src_srs_date_to_tmp.value.replace(/-/g,"");	


	if(fnCalDate(sForm.src_srs_date_from_tmp.value,sForm.src_srs_date_to_tmp.value,'D') < 0){
	  Ext.Msg.alert('확인', '검색시작일이 검색종료일보다 이전입니다.'); 
	  return;
	}
 
	
	Ext.Ajax.request({   
		url: "/srs/result.sg"
		,method : 'POST'   
		,success: function(response){						// 조회결과 성공시
					// 조회된 결과값, store명
					//handleSuccess(response,GridClass_1st);
					
					GridClass_1st.store.commitChanges();	// 변경된 record를 commit
					GridClass_1st.store.removeAll();		// store자료를 삭제
						
					// 조회된 결과값, store명
					var json = Ext.util.JSON.decode(response.responseText);
										
					GridClass_1st.store.loadData(json);					
					
		          }
		,failure: handleFailure   	   // 조회결과 실패시  
		,form   : document.searchForm  // 검색 FORM
		,params : {					   // 조회조건을 DB로 전송하기위해서 조건값 설정
					limit          : limit_1st
				  , start          : start_1st
				  }				
	});  
	
	fnInitValue(); // 상세필드 초기화
}  		




/***************************************************************************
 * 설  명 : 저장버튼 클릭
 ***************************************************************************/
function fnSave(){  	

	var sForm = document.searchForm;	// 검색 FORM
	sForm.src_srs_date_from.value = sForm.src_srs_date_from_tmp.value.replace(/-/g,"");		   	 
	sForm.src_srs_date_to.value = sForm.src_srs_date_to_tmp.value.replace(/-/g,"");	
	
	var dForm = document.detailForm;	// 상세 FORM
	
	
	var req_item_str ="";
	
    for (var i = 0; i < dForm.req_item.length; i++) 
    {
      if(dForm.req_item[i].checked == true){
      	req_item_str += dForm.req_item[i].value;
      	
	      if (i < (dForm.req_item.length-1)) {
	        req_item_str += "^";
	      }
	  }
    }
   		
   
	 if(Ext.get('src_srs_emp_gubun').getValue() =='AA')		//의뢰자면
	 {   
		   	 if(Ext.get('srs_title').getValue() =='')		
			 {
			 	Ext.Msg.alert('확인', '제목을 입력하십시오.');
				return false;
			 }
		   		
		   	 if(Ext.get('pjt_id').getValue() =='')		
			 {
			 	Ext.Msg.alert('확인', '프로젝트를 선택하십시오.');
				return false;
			 }   
		   
		   	 if(Ext.get('end_name').getValue() =='')		
			 {
			 	Ext.Msg.alert('확인', '앤드유저를 선택하십시오.');
				return false;
			 }  
		   	  
		   	 if(Ext.get('custom_name').getValue() =='')		
			 {
			 	Ext.Msg.alert('확인', '거래처를 선택하십시오.');
				return false;
			 }  
			 
		   	 /*
			 if(Ext.get('visit_navi_url').getValue() =='')		
			 {
			 	Ext.Msg.alert('확인', '방문위치 정보를 입력하십시오.');
				return false;
			 }  
			 */
			 
			 if(Ext.get('srs_detail').getValue() == '')		 
			 {
			 	Ext.Msg.alert('확인', '의뢰내역을 입력하십시오.');
				return false;
			 }
			 
			 if(req_item_str.length  == 0 )		
			 {
			 	Ext.Msg.alert('확인', '요청항목을 선택하십시오.');
				return false;
			 }
			 
			 			 
   	 }else
   	 {
   	 	if(Ext.get('csr_id').getValue() =='')		
	 	{
	 		Ext.Msg.alert('확인', '기술지원요청을 선택하십시오.');
			return false;
	 	}
   	 
   	 }



	 if(Ext.get('srs_status').getValue() =='')		 
	 {
	 	Ext.Msg.alert('확인', '상태를 선택하십시오.')
		return false;
	 }else
	 {
	 
	 	if(Ext.get('saved_srs_status').getValue() == '50')		 
		{
		 	Ext.Msg.alert('확인', '이미 팀장확인이 완료되었습니다.');
			return false;
		}	 
	 
	 	if(Ext.get('saved_srs_status').getValue() != '60' && Ext.get('saved_srs_status').getValue() != '70')		
	 	{
	   		if(parseInt(Ext.get('saved_srs_status').getValue()) > parseInt(Ext.get('srs_status').getValue()))		
		 	{
		 		Ext.Msg.alert('확인', '이전상태로 변경이 불가합니다.');
				return false;
		 	}
		}	 		 
	 
	 	if(Ext.get('src_srs_emp_gubun').getValue() =='AA')		//의뢰자
	 	{
			 
	 		 if(Ext.get('saved_srs_status').getValue() !=='' && Ext.get('saved_srs_status').getValue() !='10')		 
			 {
			 	Ext.Msg.alert('확인', '이미 지원승인 되었습니다.');
				return false;
			 }
	 	}
	 	
	 	if(Ext.get('src_srs_emp_gubun').getValue() =='BB')		//1차팀장
	 	{
	 	
	 		 if(Ext.get('srs_type_code').getValue() =='')		 
			 {
			 	Ext.Msg.alert('확인', '기술지원범주를 선택하십시오.');
				return false;
			 }

	 	
	 		 if(Ext.get('saved_srs_status').getValue() == '10' && Ext.get('srs_status').getValue() == '10')		 
			 {
			 	
			 		Ext.Msg.alert('확인', '상태를 변경하십시오.');
					return false;
			 }

			 if(Ext.get('saved_srs_status').getValue() == '10')		 
			 {
			 	if(Ext.get('srs_status').getValue() == '30' || Ext.get('srs_status').getValue() == '40' || Ext.get('srs_status').getValue() == '50')
			 	{
			 		Ext.Msg.alert('확인', '지원승인 상태로 변경하십시오.');
					return false;
				}
			 }
			 
			 if(Ext.get('saved_srs_status').getValue() == '40' && Ext.get('srs_status').getValue() == '40')		 
			 {
			 		Ext.Msg.alert('확인', '상태를 변경하십시오.');
					return false;
			 }			 
			 
			 
			 if(Ext.get('saved_srs_status').getValue() == '40' && Ext.get('srs_status').getValue() == '70' )		 
			 {
			 	Ext.Msg.alert('확인', '이관상태로 변경할수 없습니다.');
				return false;
			 }
			 
			 if(Ext.get('srs_mgr_name_2').getValue() !='' && Ext.get('saved_srs_status').getValue() == '10' && Ext.get('srs_status').getValue() != '70' )		   
			 {
			 	Ext.Msg.alert('확인', '이관상태로 변경하십시오.');
				return false;
			 }
			 
			 if(Ext.get('target_date').getValue() =='')		
			 {
			 	Ext.Msg.alert('확인', '기한일을 입력하십시오.');
				return false;
			 }
			 
			 
			 //희망처리기간 FROM
	   		 var plan_date_from_tmp = dForm.plan_date_from.value.replaceAll('-','');
	   		 //희망처리기간 TO
	   		 var plan_date_to_tmp = dForm.plan_date_to.value.replaceAll('-','');
	   		
	   		 var plan_time_from_tmp = (dForm.plan_time_from.value.replace(/:/g,"")).replace(/--/g,"");
	   		 var plan_time_to_tmp = (dForm.plan_time_to.value.replace(/:/g,"")).replace(/--/g,"");
		 
		 
		 	 if(plan_date_from_tmp == ''&& plan_date_to_tmp == ''&& plan_time_from_tmp == ''&& plan_time_to_tmp == '')		 
			 {
			 	Ext.Msg.alert('확인', '희망처리기간을 입력하십시오.');
				return false;
			 }else if(parseInt(plan_date_from_tmp) > parseInt(plan_date_to_tmp)) 
			 {
				Ext.Msg.alert('확인', '시작일이 종료일보다 큽니다.');
				return false;
			 }			 
			 

			 if(Ext.get('checkSrsMgrDept2').dom.checked == true)
			 {
			 	if(Ext.get('srs_mgr_name_2').getValue() == '')		 
			 	 {
			 		Ext.Msg.alert('확인', '2차 지원부서를 선택하십시오.');
					return false;
			 	 }
			 }else
			 {
				 if(Ext.get('sup_emp_name_1').getValue() == '')		 
			 	 {
			 		Ext.Msg.alert('확인', '1차 지원담당을 선택하십시오.');
					return false;
			 	 }
			 }
	 	}
	 	
		if(Ext.get('src_srs_emp_gubun').getValue() =='DD')		//2차팀장
	 	{
	 		 
	 		 if(Ext.get('saved_srs_status').getValue() == '10' && Ext.get('srs_status').getValue() == '10')		 
			 {
			 	
			 		Ext.Msg.alert('확인', '상태를 변경하십시오.');
					return false;
			 }		 
			 
			 if(Ext.get('saved_srs_status').getValue() == '70' && Ext.get('srs_status').getValue() == '70')		 
			 {
			 	
			 		Ext.Msg.alert('확인', '지원승인 상태로 변경하십시오.');
					return false;
			 }
			 
			 if(Ext.get('saved_srs_status').getValue() == '10')		 
			 {
			 	if(Ext.get('srs_status').getValue() == '30' || Ext.get('srs_status').getValue() == '40' || Ext.get('srs_status').getValue() == '50')
			 	{
			 		Ext.Msg.alert('확인', '지원승인 상태로 변경하십시오.');
					return false;
				}
			 }
			 
			 if(Ext.get('saved_srs_status').getValue() == '40' && Ext.get('srs_status').getValue() == '40')		 
			 {
			 		Ext.Msg.alert('확인', '상태를 변경하십시오.');
					return false;
			 }
			 
			 if(Ext.get('saved_srs_status').getValue() == '40' && Ext.get('srs_status').getValue() == '70' )	
			 {
			 	Ext.Msg.alert('확인', '이관상태로 변경할수 없습니다.');
				return false;
			 }
			 
			 if(Ext.get('target_date').getValue() =='')		
			 {
			 	Ext.Msg.alert('확인', '기한일을 입력하십시오.');
				return false;
			 }
			 
			 //희망처리기간 FROM
	   		 var plan_date_from_tmp = dForm.plan_date_from.value.replaceAll('-','');
	   		 //희망처리기간 TO
	   		 var plan_date_to_tmp = dForm.plan_date_to.value.replaceAll('-','');
	   		
	   		 var plan_time_from_tmp = (dForm.plan_time_from.value.replace(/:/g,"")).replace(/--/g,"");
	   		 var plan_time_to_tmp = (dForm.plan_time_to.value.replace(/:/g,"")).replace(/--/g,"");
		 
		 
		 	 if(plan_date_from_tmp == '' || plan_date_to_tmp == '' )		 
			 {
			 	Ext.Msg.alert('확인', '희망처리기간을 입력하십시오.');
				return false;
			 }else if(parseInt(plan_date_from_tmp) > parseInt(plan_date_to_tmp)) 
			 {
				Ext.Msg.alert('확인', '시작일이 종료일보다 큽니다.');
				return false;
			 }	
			 
			 
			 if(Ext.get('sup_emp_name_2').getValue() == '')		 
			 {
			 	Ext.Msg.alert('확인', '2차 지원담당을 선택하십시오.');
				return false;
			 }			 
	 	}	 	
	 	
	    if(Ext.get('src_srs_emp_gubun').getValue() == 'CC' || Ext.get('src_srs_emp_gubun').getValue() == 'EE')		//팀원
	    {   
			
		 	if(Ext.get('saved_srs_status').getValue() == '20' )		 
			{
			 	if(Ext.get('srs_status').getValue() != '30' && Ext.get('srs_status').getValue() != '40')
			 	{
			 		Ext.Msg.alert('확인', '팀원지원중 또는 팀원지원완료 상태로 변경하십시오.');
					return false;
				}
			}
			
			if(Ext.get('srs_status').getValue() == '50' || Ext.get('srs_status').getValue() == '60' || Ext.get('srs_status').getValue() == '70')
			{
				Ext.Msg.alert('확인', '상태변경 권한이 없습니다.');
				return false;
			}		 	 
		 	 
		 	 //실제처리기간 FROM
	   		 var proc_date_from_tmp = dForm.proc_date_from.value.replaceAll('-','');
	   		 //실제처리기간 TO
	   		 var proc_date_to_tmp = dForm.proc_date_to.value.replaceAll('-','');
	   		
	   		 var proc_time_from_tmp = (dForm.proc_time_from.value.replace(/:/g,"")).replace(/--/g,"");
	   		 var proc_time_to_tmp = (dForm.proc_time_to.value.replace(/:/g,"")).replace(/--/g,"");
		 
		 
		 	 if(proc_date_from_tmp == '' || proc_date_to_tmp == '' || proc_time_from_tmp == '' || proc_time_to_tmp == '')		 
			 {
			 	Ext.Msg.alert('확인', '실제처리기간을 입력하십시오.');
				return false;
			 }else if(parseInt(proc_date_from_tmp) > parseInt(proc_date_to_tmp)) 
			 {
				Ext.Msg.alert('확인', '시작일이 종료일보다 큽니다.');
				return false;
			 }
		 	 if(Ext.get('srs_proc_detail').getValue() == '')		 
			 {
			 	Ext.Msg.alert('확인', '처리내역을 입력하십시오.');
				return false;
			 }
		 	
	    } 
	 		 	
	 }//else

		//의뢰승인일
   		dForm.srs_agr_date.value = dForm.srs_agr_date.value.replaceAll('-','');
		
		//의뢰요청일
   		dForm.srs_req_date.value = dForm.srs_req_date.value.replaceAll('-','');
   		
   		//기한일
   		dForm.target_date.value = dForm.target_date.value.replaceAll('-','');
   		

   		//희망처리기간 FROM
   		dForm.plan_date_from.value = dForm.plan_date_from.value.replaceAll('-','');   		
   		//희망처리기간 TO
   		dForm.plan_date_to.value = dForm.plan_date_to.value.replaceAll('-','');
   		
  		
   		//실제처리기간 FROM
   		dForm.proc_date_from.value = dForm.proc_date_from.value.replaceAll('-','');   		
   		//실제처리기간 TO
   		dForm.proc_date_to.value = dForm.proc_date_to.value.replaceAll('-','');   		
   		
	    
		Ext.Ajax.request({   
			url: "/srs/actionSrsInfoMng.sg"   
			,success: function(response){						// 조회결과 성공시
						// 조회된 결과값, store명
						//alert(response.responseText);
						
						handleSuccess(response,GridClass_1st,'save');
						
						// 조회된 결과값, store명
						var json = Ext.util.JSON.decode(response.responseText);

			          }
			,failure: handleFailure   	    // 조회결과 실패시  
			,form   : document.detailForm   // 상세 FORM
			,params : { 
					   limit          : limit_1st
					  ,start          : start_1st
					  ,req_item_str : req_item_str
					  ,src_srs_emp_gubun: Ext.get('src_srs_emp_gubun').getValue() 
					  ,src_srs_emp_duty_code: Ext.get('src_srs_emp_duty_code').getValue() 
					  ,src_srs_date_from: Ext.get('src_srs_date_from').getValue() 
					  ,src_srs_date_to: Ext.get('src_srs_date_to').getValue() 
				      } 
		});  
		
		fnInitValue(); // 상세필드 초기화

}  		



/***************************************************************************
 * 설  명 : 삭제버튼 클릭
 ***************************************************************************/
function fnGridDeleteRow(selectedRecord){
	
	
}




/***************************************************************************
 * 설  명 : 화면 설정
 ***************************************************************************/
// ExtJS 진입함수
Ext.onReady(function() {

	var dForm = document.detailForm;
	var sForm = document.searchForm;

	var toDay = getTimeStamp(); 
 	toDay = toDay.replaceAll('-','');
 	toDay = addDate(toDay, 'M', -3);
 	toDay = toDay.substring(0,4)+"-"+toDay.substring(4,6)+"-"+toDay.substring(6,8);
 	var fromDay = toDay;
 	toDay = getTimeStamp().trim();


	//검색하기 버튼 
	Ext.get('searchBtn').on('click', function(e){
		fnSearch()
	});	
	
		
	//조건해제 버튼 -> 검색조건 초기화
	Ext.get('searchClearBtn').on('click', function(e){
		sForm.reset();
	 
	 	Ext.get('src_srs_date_from_tmp').set({value:fromDay} , false);
	 	Ext.get('src_srs_date_to_tmp').set({value:toDay} , false);

	});	
			
			
	//신규 버튼 -> 상세필드 초기화
	Ext.get('detailClearBtn').on('click', function(e){
		fnInitValue();		   
	});		
	
			
	//등록 버튼 -> 데이터를 server로 전송
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
	

	//신규 버튼 -> 상세필드 초기화
	Ext.get('detailClearBtn').on('click', function(e){
		fnInitValue();		   
	});	

	
	// 프로젝트 검색팝업
   	Ext.get('src_pjt_btn').on('click', function(e){
   		
			param = "?fieldName=src_pjt_id&src_pjt_type_code=10";		// 10_영업관리 프로젝트만 검색
			fnPjtPop(param);
   	
   	});
   	
   	
   	// 프로젝트 폼팝업
   	Ext.get('pjt_btn').on('click', function(e){
   		
			param = "?fieldName=pjt_id&src_pjt_type_code=10";		// 10_영업관리 프로젝트만 검색
			fnPjtPop(param);
   	
   	});


   	// 의뢰자 검색팝업
   	Ext.get('src_srs_req_emp_btn').on('click', function(e){
   		
			fnEmployeePop('src_srs_req_emp_name');
   	
   	});


   	// 지원담당 검색팝업
   	Ext.get('src_sup_emp_btn').on('click', function(e){
   		
			fnEmployeePop('src_sup_emp_name');
   	
   	});

	
	// 지원부서 검색팝업
   	Ext.get('deptSearchBtn').on('click', function(e){
   		
			fnDeptPop();
   	
   	});




   	// 1차 지원담당 폼팝업
   	Ext.get('sup_emp_btn_1').on('click', function(e){
   		
			fnEmployeePop('sup_emp_name_1');
   	
   	});


   	// 2차 지원담당 폼팝업
   	Ext.get('sup_emp_btn_2').on('click', function(e){
   		
			fnEmployeePop('sup_emp_name_2');
   	
   	});
   	
   	
   	
	// 거래처검색 폼팝업
   	Ext.get('custom_name_btn').on('click', function(e){
		fnCostomerPop('custom_name')
	});
   	

	// 앤드유저검색 폼팝업
   	Ext.get('end_name_btn').on('click', function(e){
		fnCostomerPop('end_name')
	});   	


	// 방문위치정보 검색 폼팝업
   	Ext.get('visit_navi_btn').on('click', function(e){
		fnVisitNaviPop()
	});



	// 검색일자기간 from
	var src_srs_date_from_tmp_dt = new Ext.form.DateField({
	    	applyTo: 'src_srs_date_from_tmp',
			allowBlank: false,
			format:'Y-m-d',
			editable : true,
			value : fromDay
	});
	

	// 검색일자기간 to
	var src_srs_date_to_tmp_dt = new Ext.form.DateField({
	    	applyTo: 'src_srs_date_to_tmp',
			allowBlank: false,
			format:'Y-m-d',
			editable : true,
			value : toDay
	});



	// 희망처리기간 from
	var plan_date_from_dt = new Ext.form.DateField({
	    	applyTo: 'plan_date_from',
			allowBlank: false,
			format:'Y-m-d',
			editable : true,
			value : toDay
	});
	
	
	// 희망처리기간 to
	var plan_date_to_dt = new Ext.form.DateField({
	    	applyTo: 'plan_date_to',
			allowBlank: false,
			format:'Y-m-d',
			editable : true,
			value : toDay
	});
		


	// 실제처리기간 from
	var proc_date_from_dt = new Ext.form.DateField({
	    	applyTo: 'proc_date_from',
			allowBlank: false,
			format:'Y-m-d',
			editable : true,
			value : toDay
	});
	
	
	// 실제처리기간 to
	var proc_date_to_dt = new Ext.form.DateField({
	    	applyTo: 'proc_date_to',
			allowBlank: false,
			format:'Y-m-d',
			editable : true,
			value : toDay
	});


	//기한일
	var target_date_dt = new Ext.form.DateField({
	    	applyTo: 'target_date',
			allowBlank: false,
			format:'Y-m-d',
			editable : true,
			value : toDay
	});


	Ext.get('srs_mgr_dept_2').on('change', function(e){
		
		var	srs_mgr_dept_2 = Ext.get('srs_mgr_dept_2').getValue();	// 2차 지원부서
		
		
		Ext.Ajax.request({   
				url		 : "/srs/selectTeamLeader.sg"
				,method  : 'POST'   
				,success : function(response){						// 조회결과 성공시
							// 조회된 결과값, store명
							var json = Ext.util.JSON.decode(response.responseText);

							if(json.data_1st.length > 0){
								Ext.get('srs_mgr_2').set({value : json.data_1st[0].EMP_NUM}, false);
								Ext.get('srs_mgr_name_2').set({value : json.data_1st[0].KOR_NAME}, false);
							}
													
				          }   							
				,failure: handleFailure   	   						// 조회결과 실패시  
				,params : {					   						// 조회조건을 DB로 전송하기위해서 조건값 설정
					 		dept_code    		: srs_mgr_dept_2		  	// 프로젝트ID  
						  }				
			}); // End Ext.Ajax  
   		
	}); // End Ext.get


	 fnInitValue();
  	
}); // end Ext.onReady


// 저장, 수정버튼 클릭시 '예','아니오' 
function showResult(btn){
   	if(btn == 'yes'){
   		fnSave();
   	}    	
};


/***************************************************************************
 * 설  명 : 부서검색 
 ***************************************************************************/
function fnDeptPop(param){
	var sURL      = "/com/dept/deptPop.sg?requestFieldName="+param;
	 var dlgWidth  = 417;
	 var dlgHeight = 360;
	 var winName   = "부서";
	 fnOpenPop(sURL, dlgWidth, dlgHeight, winName);
}


/***************************************************************************
 * 설  명 : 부서검색 결과 반영
 ***************************************************************************/
function fnDeptPopValue(records, fieldName){
		
	// 전송받은 값이 한건일 경우
    var record = records[0].data;				

   	Ext.get('src_srs_dept_code').set({value:record.DEPT_CODE} , false);
   	Ext.get('src_srs_dept_name').set({value:record.DEPT_NAME} , false);


}



/***************************************************************************
 * 설  명 : 프로젝트검색
 ***************************************************************************/
function fnPjtPop(param){
	var sURL      = "/pjt/pjtManage/pjtInfoPop.sg"+param;
	var dlgWidth  = 420;
	var dlgHeight = 430;
	var winName   = "project";
	fnOpenPop(sURL, dlgWidth, dlgHeight, winName);
}


function fnPjtPopValue(records, fieldName){
	var record = records[0].data;	
				
	if(fieldName == 'src_pjt_id')
	{ 
		Ext.get('src_pjt_id').set({value:fnFixNull(record.PJT_ID)} , false);
	    Ext.get('src_pjt_name').set({value:fnFixNull(record.PJT_NAME)} , false);
    }else
    {
    	Ext.get('pjt_id').set({value:fnFixNull(record.PJT_ID)} , false);
	    Ext.get('pjt_name').set({value:fnFixNull(record.PJT_NAME)} , false);
	    
	    
	    Ext.get('custom_name').set({value:fnFixNull(record.CUSTOM_NAME)} , false);
	    
	    Ext.get('customer_dept_name').set({value:fnFixNull(record.CUSTOMER_DEPT_NAME)} , false);
	    
	    Ext.get('customer_name').set({value:fnFixNull(record.CUSTOMER_NAME)} , false);
	    
	    Ext.get('customer_telephone').set({value:fnFixNull(record.CUSTOMER_TELEPHONE)} , false);
    }
}



/***************************************************************************
 * 설  명 : 담당자검색
 ***************************************************************************/
function fnEmployeePop(param){

	var dlgWidth  = 420;
	var dlgHeight = 400;
	var winName ="";
    var sURL ="";
	if(param =='src_srs_req_emp_name')					//의뢰자
	{
		winName   = "emp_1";
	}else if(param =='src_sup_emp_name')			//지원담당
	{
		winName   = "emp_2";
	}else if(param =='sup_emp_name_1')				//1차지원담당
	{
		winName   = "emp_3";
		param += "&requestDeptCode="+Ext.get('srs_mgr_dept_1').getValue();
	}else											//2차지원담
	{
		winName   = "emp_4";

		if(Ext.get('srs_mgr_dept_2').getValue() == '')
		{
			Ext.Msg.alert('확인', '2차 지원부서를 선택하십시오');
			return;
		}
		param += "&requestDeptCode="+Ext.get('srs_mgr_dept_2').getValue();
	}

	sURL = "/com/employee/employeePop.sg?requestFieldName="+param;
	fnOpenPop(sURL, dlgWidth, dlgHeight, winName);
}



/***************************************************************************
 * 설  명 : 담당자검색 결과 반영
 ***************************************************************************/
function fnEmployeePopValue(records, fieldName){
		
	// 전송받은 값이 한건일 경우
    var record = records[0].data;				

	if(fieldName =='src_srs_req_emp_name')		//조회 의뢰자 
	{
		Ext.get('src_srs_req_emp').set({value:record.EMP_NUM} , false);
		Ext.get('src_srs_req_emp_name').set({value:record.KOR_NAME} , false);

	}else if(fieldName =='src_sup_emp_name')	//조회 지원담당
	{
		Ext.get('src_sup_emp').set({value:record.EMP_NUM} , false);
		Ext.get('src_sup_emp_name').set({value:record.KOR_NAME} , false);
	}else if(fieldName =='sup_emp_name_1')	//1차지원
	{
		Ext.get('sup_emp_1').set({value:record.EMP_NUM} , false);
		Ext.get('sup_emp_name_1').set({value:record.KOR_NAME} , false);
	}
	else if(fieldName =='sup_emp_name_2')	//2차지원
	{
		Ext.get('sup_emp_2').set({value:record.EMP_NUM} , false);
		Ext.get('sup_emp_name_2').set({value:record.KOR_NAME} , false);

	}

}



/***************************************************************************
 * 설  명 : 거래처담당자 검색팝업 
 ***************************************************************************/
function fnCostomerPop(param){
	var sURL      = "/com/custom/customMemberPop.sg?requestFieldName="+param;
	var dlgWidth  = 418;
	var dlgHeight = 406;
	var winName   = "";

	if(param ='end_name')
	{
		winName   = "end_name";
	}else if(param ='custom_name')
	{
		winName   = "custom_name";
	}

	fnOpenPop(sURL, dlgWidth, dlgHeight, winName);
}

// 거래처담당자 검색 결과 return Value
function fnCostomerPopValue(records, fieldName){
		
	// 전송받은 값이 한건일 경우
    var record = records[0].data;		
	
	if(fieldName =='end_name')		//앤드유저
	{
		Ext.get('enduser_name').set({value:fnFixNull(record.CUSTOMER_NAME)} , false);
		Ext.get('enduser_dept_name').set({value:fnFixNull(record.CUSTOMER_DEPT)} , false);
		Ext.get('end_name').set({value:fnFixNull(record.CUSTOM_NAME)} , false);				
		Ext.get('enduser_telephone').set({value:fnFixNull(record.CUSTOMER_TELEPHONE)} , false);

	}else if(fieldName =='custom_name')	//거래처
	{
		Ext.get('customer_name').set({value:fnFixNull(record.CUSTOMER_NAME)} , false);
		Ext.get('customer_dept_name').set({value:fnFixNull(record.CUSTOMER_DEPT)} , false);
		Ext.get('custom_name').set({value:fnFixNull(record.CUSTOM_NAME)} , false);				
		Ext.get('customer_telephone').set({value:fnFixNull(record.CUSTOMER_TELEPHONE)} , false);
	}
}




/***************************************************************************
 * 설  명 : 방문위치 검색팝업 
 ***************************************************************************/
function fnVisitNaviPop(){
	var sURL      = "/srs/visitNaviPop.sg?requestFieldName="+Ext.get('visit_navi').getValue();
	var dlgWidth  = 515;
	var dlgHeight = 295;
	var winName   = "Navi";


	fnOpenPop(sURL, dlgWidth, dlgHeight, winName);
}

// 방문위치 검색 결과 return Value
function fnVisitNaviPopValue(input_visit_navi, input_visit_navi_url){
		
	Ext.get('visit_navi').set({value:fnFixNull(input_visit_navi)} , false);
	Ext.get('visit_navi_url').set({value:fnFixNull(input_visit_navi_url)} , false);
		

}



// 팝업
function fnOpenPop(sURL, dlgWidth, dlgHeight, winName){
  var xPos=(window.screen.width) ? (window.screen.width-dlgWidth)/2 : 0;
  var yPos=(window.screen.height) ? (window.screen.height-dlgHeight)/2 : 0;
  var sFeatures = "titlebar=no, scrollbars=yes,location=no ,menubar=no, resizable=yes, status=yes, width="+dlgWidth+",height="+dlgHeight+",left="+xPos+", top="+yPos;
  window.open(sURL,winName, sFeatures);
}


// 그리드 행삭제
function fnEdit1stBeforeRowDeleteEvent(){

}




function moveDataToEndUser(obj){
	
	if(obj.checked == true){
		
		Ext.get('end_name').set({value:fnFixNull(Ext.get('custom_name').getValue())} , false);
		Ext.get('enduser_dept_name').set({value:fnFixNull(Ext.get('customer_dept_name').getValue())} , false);
		Ext.get('enduser_name').set({value:fnFixNull(Ext.get('customer_name').getValue())} , false);				
		Ext.get('enduser_telephone').set({value:fnFixNull(Ext.get('customer_telephone').getValue())} , false);
		
	}else{
		Ext.get('end_name').set({value:''} , false);	
		Ext.get('enduser_dept_name').set({value:''} , false);
		Ext.get('enduser_name').set({value:''} , false);
		Ext.get('enduser_telephone').set({value:''} , false);
		
	}
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
	 var li_len      = 0;   // substring기 위해서 사용
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



function chkTime(obj) {
  var input = (obj.value.replace(/:/g,"")).replace(/--/g,"");
  var inputHours = input.substr(0,2);
  var inputMinutes = input.substr(2,2);
 
  if(input.length !=4)
  {
  	Ext.Msg.alert('확인',"유효한 시분이 아닙니다. 다시 입력해 주십시요.\n\n예)0101");
  	obj.value = "--:--";
  }else
  {
  	
	  var resultTime = new Date(0,0,0, inputHours, inputMinutes);
	  if ( resultTime.getHours() != inputHours || resultTime.getMinutes() != inputMinutes ) 
	  {
	    Ext.Msg.alert('확인',"유효한 시분이 아닙니다. 다시 입력해 주십시요.\n\n예)0101");
	    obj.value =  "--:--";
	  } else {
	    obj.value = inputHours + ":" + inputMinutes;
	  }
  }
}






function showSrsMgrDept2(obj){

	if(obj.checked == true)
	{
		Ext.get('div_srs_mgr_dept_2').show();

		Ext.get('custom_same_yn').dom.checked = true;	
			
		Ext.get('srs_status').set({value:'70'} , false);
	}else
	{
		Ext.get('div_srs_mgr_dept_2').setStyle({'visibility':'hidden'}); 
		
		Ext.get('srs_mgr_dept_2').set({value:''} , false);
		Ext.get('srs_mgr_name_2').set({value:''} , false);
		Ext.get('sup_emp_2').set({value:''} , false);
		Ext.get('sup_emp_name_2').set({value:''} , false);
		
		Ext.get('custom_same_yn').dom.checked = false;
		
		Ext.get('srs_status').set({value:Ext.get('saved_srs_status').getValue()} , false);

	}
}



function disableFormElements(form){ 
            var c = form.elements; 

            if(!c.length) return; 
            for( var i = 0; i < c.length ; i++){ 
               if(c[i].type != 'hidden')
               {
               	c[i].disabled = true; 
               }
            } 
            
        Ext.get("pjt_btn").hide();    
		Ext.get("end_name_btn").hide();	
		Ext.get("custom_name_btn").hide();
		Ext.get("visit_navi_btn").hide();
		Ext.get("sup_emp_btn_1").hide();
		Ext.get("sup_emp_btn_2").hide();            
} 
 
function enableFormElements(form){ 
            var c = form.elements; 
            if(!c.length) return; 
            for( var i = 0; i < c.length ; i++){ 
                        c[i].disabled = false; 
            } 
            
        Ext.get("pjt_btn").show();
		Ext.get("end_name_btn").show();	
		Ext.get("custom_name_btn").show();
		Ext.get("visit_navi_btn").show();
		Ext.get("sup_emp_btn_1").show();
		Ext.get("sup_emp_btn_2").show();  	    
} 


function openNaviUrl(){ 

	var dForm = document.detailForm;

	if(Ext.get('visit_navi_url').getValue() =='')
	{
		return;
	}
	
	var sURL      = Ext.get('visit_navi_url').getValue();
		
	var dlgWidth  = 1200;
	var dlgHeight = 760;

	var winName   = "Search";

    fnOpenPop(sURL, dlgWidth, dlgHeight, winName);
} 


function getCheckedRadioVal(obj) {

    if (obj.length > 1) {
        for (var inx = 0; inx < obj.length; inx++) {

            if (obj[inx].checked) return obj[inx].value;
        }
    } else {
        if (obj.checked) return obj[inx].value;
    }
    
     return "";
}


	


</script>



</head>
<body>

	<table border="0" width="1000" height="200"  id="idPrint" >	
		<tr>
			<td colspan="2">

				<form name="searchForm">
								
				<input type="hidden" id="src_pjt_id" name="src_pjt_id"  />						<%-- 프로젝트 --%>	
				
				<input type="hidden" id="src_srs_date_from" name="src_srs_date_from"  />
				<input type="hidden" id="src_srs_date_to" name="src_srs_date_to"  />
				<input type="hidden" id="src_srs_dept_code" name="src_srs_dept_code"  />		<%--지원부서코드 --%>		
				
				<input type="hidden" id="src_srs_req_emp" name="src_srs_req_emp"  />			<%--의뢰자 --%>		
				
				<input type="hidden" id="src_sup_emp" name="src_sup_emp"  />			<%--지원담당 --%>		
				
				
					
				<input type="hidden" id="src_srs_emp_gubun" name="src_srs_emp_gubun"  value=${SRSEMPGUBUN} >							<%--권한 구분값--%>
				<input type="hidden" id="src_srs_emp_duty_code" name="src_srs_emp_duty_code"  value="${EMPINFO[0].DUTY_CODE}" />	<%--로그인정보의 직책코드--%>			
				
				<!----------------- SEARCH Hearder Start	 ----------------->
				<div id="ext-comp-1002" class=" x-panel x-form-label-left" style="margin-top: 0.4em;"><%-- 0em <- 1em으로 수정하면 상위 공백 --%>
					<div class="x-panel-tl">
						<div class="x-panel-tr">
							<div class="x-panel-tc">
								<div id="ext-gen4" class="x-panel-header x-unselectable" style="-moz-user-select: none;">
									<span id="ext-gen8" class="x-panel-header-text">기술지원요청정보 검색</span>
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
						    		
										<td width="185px">
											<div tabindex="-1" class="x-form-item " >
												<label class="x-form-item-label" style="width: auto;" for="src_pjt_name" >프로젝트 :</label>
												<div style="padding-left: 0px;" class="x-form-element">
													<input type="text" name="src_pjt_name" id="src_pjt_name" autocomplete="off" size="19" class=" x-form-text x-form-field" style="width: auto;" readOnly />	
												</div>
											</div>
										</td>
									
										<td width="40px" >
											<div tabindex="-1" class="x-form-item " >
												<div style="padding-left: 0px;" class="x-form-element">
												 	<%-- Button Start--%>
												 		<div style="padding-left: 0px;" >
															<img align="center" id="src_pjt_btn" name="src_pjt_btn" alt="" src="/resource/images/bass_1st/icon_src1.gif" style="cursor: hand;">
														</div>
													<%-- Button End--%>
												</div>
											</div>
										</td>						    		
						   
										<td width="185px">
											<div tabindex="-1" class="x-form-item ">
												<label class="x-form-item-label" style="width: auto;" for="src_end_name" >엔드유저 :</label>
												<div style="padding-left: 0px;" class="x-form-element">
													<input type="text" name="src_end_name" id="src_end_name" autocomplete="off" size="19" class=" x-form-text x-form-field" style="width: auto;">		
												</div>
											</div>
										</td>
														
										<td width="170px" colspan="2">
											<div tabindex="-1" class="x-form-item " >
												<label class="x-form-item-label" style="width: auto;" for="src_srs_req_emp_name" >의뢰자 :</label>
												<div style="padding-left: 0px;" class="x-form-element">
													<input type="text" name="src_srs_req_emp_name" id="src_srs_req_emp_name" autocomplete="off" size="19" class=" x-form-text x-form-field" style="width: auto;">		
												</div>
											</div>
										</td>
										
										<td width="40px">
											<div tabindex="-1" class="x-form-item " >
												<div style="padding-left: 0px;" class="x-form-element">
													<%-- Button Start--%>
														<div style="padding-left: 0px;" >
															<img align="center" id="src_srs_req_emp_btn" name="src_srs_req_emp_btn" alt="" src="/resource/images/bass_1st/icon_src1.gif" style="cursor: hand;">
														</div>
													<%-- Button End--%>
													
												</div>
											</div>
										</td>
										
										<td width="185px">
											<div tabindex="-1" class="x-form-item " >
												<label class="x-form-item-label" style="width: auto;" for="src_sup_emp_name" >지원담당 :</label>
												<div style="padding-left: 0px;" class="x-form-element">
													<input type="text" name="src_sup_emp_name" id="src_sup_emp_name" autocomplete="off" size="19" class=" x-form-text x-form-field" style="width: auto;">		
												</div>
											</div>
										</td>
										<td width="150px">
											<div tabindex="-1" class="x-form-item " >
												<div style="padding-left: 0px;" class="x-form-element">
													
													<%-- Button Start--%>
														<div style="padding-left: 0px;" >
															<img align="center" id="src_sup_emp_btn" name="src_sup_emp_btn" alt="" src="/resource/images/bass_1st/icon_src1.gif" style="cursor: hand;">
														</div>
													<%-- Button End--%>
													
											</div>
											</div>
										</td>
									</tr>
									<%-- 1 Row End --%>

									<%-- 2 Row Start --%>
										
									<tr>
										<td width="180px">
											<div tabindex="-1" class="x-form-item " >
												<label class="x-form-item-label" style="width: auto;" for="src_srs_status">상태 :</label>
												<div style="padding-left: 60px;" class="x-form-element">
													<select name="src_srs_status" id="src_srs_status" style="width: 90px;" type="text" class=" x-form-select x-form-field" >
														<option value="">전체</option>
														<c:forEach items="${SRS_STATUS_CODE}" var="data" varStatus="status">
														<option value="${data.COM_CODE}"><c:out value="${data.COM_CODE_NAME}"/></option>
														</c:forEach>
													</select>
												</div>
											</div>
										</td>
									
										<td width="385px" colspan="4">
											<table>
												<tr>
													<td>
														<div tabindex="-1" class="x-form-item " >
															<label class="x-form-item-label" style="width: auto;" for="src_srs_dept_name" >지원부서 :</label>
															<div style="padding-left: 0px;" class="x-form-element">
																<input type="text" name="src_srs_dept_name" id="src_srs_dept_name" autocomplete="off" size="15" class="x-form-text x-form-field" style="width: auto;">
															</div>
														</div>		
													</td>
													<td>
													<div tabindex="-1" class="x-form-item " >
														
														<%-- Button Start--%>
														<div style="padding-left: 0px;" >
															<img align="center" id="deptSearchBtn" name="deptSearchBtn" alt="" src="/resource/images/bass_1st/icon_src1.gif" style="cursor: hand;">
														</div>
														<%-- Button End--%>
													
														</div>
													</td>
												</tr>
											</table>
										</td> 

										<td width="300px" colspan="3">
											<table border="0">
												<tr>
													<td colspan="2">
														<div tabindex="-1" class="x-form-item " >
															<label class="x-form-item-label" style="width: auto;" for="src_srs_date_from_tmp">요청일</label>
														</div>
													</td>
													<td>
														<div tabindex="-1" class="x-form-item " >
															<table border="0">
																<tr>
																	<td align="center">
																		<input type="text" name="src_srs_date_from_tmp" id="src_srs_date_from_tmp"  style="width:80px;" onFocus="restoreDateString(this, this.value)" onKeydown="_chkKeyPressNumPoint(this)" onblur="isValidDate(this, this.value)">
																	</td>
																	<td align="left">~</td>
																    <td align="center">
																		<input type="text" name="src_srs_date_to_tmp" id="src_srs_date_to_tmp"  style="width:80px;" onFocus="restoreDateString(this, this.value)" onKeydown="_chkKeyPressNumPoint(this)" onblur="isValidDate(this, this.value)">
																	</td>
																</tr>
															</table>
														</div>
													</td>
												</tr>
											</table>
										</td>
									
									</tr>
									<%-- 2 Row End --%>

									<%-- 3 Row 버튼 Start --%>
									<tr align="right">
										<td colspan="8">
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
			<!------------------------------ GRID START ---------------------------------->
			<td  valign="top" colspan="2">
				<div id="task-grid" style="margin-top: 0.4em;"></div> <!----------------- 그리드명을 동일하게 설정 ----------------->		
			</td>
			<!------------------------------ GRID END ------------------------------------>		
		
		</tr>
		
		
		<tr>
			<!-- 폼 시작 -->
			<form id="detailForm" name="detailForm" method="POST" class="x-panel-body x-form" style="padding: 1px 1px 0pt; width: 480px;">
			
			<input type="hidden" id="duty_code" name="duty_code"  value="${EMPINFO[0].DUTY_CODE}" />	<%--로그인정보의 직책코드--%>	
			<input type="hidden" id="flag_detailForm" name="flag_detailForm" style="width:80px" />
			
			<input type="hidden" id="pjt_id" name="pjt_id"  />
			
			<input type="hidden" id="srs_req_emp" name="srs_req_emp"  />									<!-- 의뢰자 -->

			<input type="hidden" name="srs_mgr_1" id="srs_mgr_1" value="${TEAMLEADER_1[0].EMP_NUM}">				<!--- 1차지원 기술지원팀장-->
			<input type="hidden" name="srs_mgr_dept_1" id="srs_mgr_dept_1"  value="${TEAMLEADER_1[0].DEPT_CODE}">
			<input type="hidden" name="sup_emp_1" id="sup_emp_1" >											<!-- 1차 지원담당-->
			
			<input type="hidden" name="srs_mgr_2" id="srs_mgr_2" >
			<input type="hidden" name="sup_emp_2" id="sup_emp_2" >				<!-- 지원담당_2-->

			<input type="hidden" name="saved_srs_status" id="saved_srs_status" >		<!-- 상태-->
			<input type="hidden" name="srs_agr_date" id="srs_agr_date" >		<!-- 의뢰승인일-->
			
			
			<input type="hidden" name="visit_navi_url" id="visit_navi_url" >		
			
			<td  valign="top">
				<div class=" x-panel x-form-label-left" style="margin-top: 0.4em; width: 870px;"><%-- 0em <- 1em으로 수정하면 상위 공백 --%>
					<!----------------- SEARCH Hearder Start	 ----------------->
					<div class="x-panel-tl">
						<div class="x-panel-tr">
							<div class="x-panel-tc">
								<div class="x-panel-header x-unselectable" style="-moz-user-select: none;">
									<span class="x-panel-header-text">기술지원 기본정보</span><!----------------- 이름변경 ----------------->		
								</div>
							</div>
						</div>
					</div>
					<!----------------- SEARCH Hearder End	 ----------------->
					<div class="x-panel-bwrap" >
						<div class="x-panel-ml">
							<div class="x-panel-mr">
								<div class="x-panel-mc" >
									
									
									<!-- DETAIL 1_ROW Start -->
									<div class="x-column-inner" style="width: 100%;">
										<!-- 신규 버튼 시작 -->
										<div tabindex="-1" class="x-form-item" >
											<table  cellspacing="0" class="x-btn  x-btn-noicon" style="width: 75px;" align="right">
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

								
									<!-- DETAIL 2_ROW Start -->
									<div class="x-column-inner" style="width: 100%; margin-top: 0.2em;">
										<div class=" x-panel x-column" style="width: 50%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label style="padding-rigth: 100px;"  class="x-form-item-label" style="width: auto;" for="spec" ><font id="fontCol" color="red">* </font>업무요청ID :</label>
														<div style="padding-left: 100px;" class="x-form-element">
															<input type="text" name="csr_id" id="csr_id" autocomplete="off" size="50" class=" x-form-text x-form-field" style="width: auto;" readonly="true">
														</div>
													</div>
												</div>
											</div>
										</div>
										
										<div class=" x-panel x-column" style="width: 50%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label class="x-form-item-label " style="width: auto;" for="srs_type_code" ><font id="font_srs_type_code" color="gray">* </font>기술지원범주 :</label>
														<div style="padding-left: 100px;" class="x-form-element">
															
															<select name="srs_type_code" id="srs_type_code" style="width: 29%;" type="text" class=" x-form-select x-form-field" >
																<option value="">전체</option>
																<c:forEach items="${SRS_TYPE_CODE}" var="data" varStatus="status">
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
									<!-- DETAIL 2_ROW End -->
									
									<!-- DETAIL 3_ROW Start -->
									<div class="x-column-inner" style="width: 100%; margin-top: 0.2em;">
										<div class=" x-panel x-column" style="width: 50%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label style="padding-rigth: 100px;"  class="x-form-item-label" style="width: auto;" for="srs_title" ><font color="red">* </font>제목 :</label>
														<div style="padding-left: 100px;" class="x-form-element">
															<input type="text" name="srs_title" id="srs_title" autocomplete="off" size="50" class=" x-form-text x-form-field" style="width: auto;" maxlength="20">
														</div>
													</div>
												</div>
											</div>
										</div>
										
										<div class=" x-panel x-column" style="width: 50%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label class="x-form-item-label " style="width: auto;" for="srs_status" ><font color="red">* </font>상태 :</label>
														<div style="padding-left: 100px;" class="x-form-element">
															
															
															<c:choose>
													            <c:when test="${SRSEMPGUBUN == 'AA'}">
																	<select name="srs_status" id="srs_status" style="width: 29%;" type="text" class=" x-form-select x-form-field" readonly="readonly" style='background-color:#f0f0f0' onFocus='this.initialSelect = this.selectedIndex;'onChange='this.selectedIndex = this.initialSelect;'>
																		<option value="">전체</option>
																		<c:forEach items="${SRS_STATUS_CODE}" var="data" varStatus="status">
																			<option value="${data.COM_CODE}" <c:if test="${data.COM_CODE == '10'}">selected</c:if> ><c:out value="${data.COM_CODE_NAME}"/></option>
																		</c:forEach>
																	</select>	
													            </c:when>
													            <c:when test="${SRSEMPGUBUN == 'CC' || SRSEMPGUBUN == 'EE'}">
																	<select name="srs_status" id="srs_status" style="width: 29%;" type="text" class=" x-form-select x-form-field" >
																		<option value="">전체</option>
																		<c:forEach items="${SRS_STATUS_CODE}" var="data" varStatus="status">
																			<c:if test="${data.COM_CODE >= '20'}">
																				<option value="${data.COM_CODE}"  ><c:out value="${data.COM_CODE_NAME}"/></option>
																			</c:if> 
																		</c:forEach>
																	</select>	
													            </c:when>
													            <c:otherwise>
																	<select name="srs_status" id="srs_status" style="width: 29%;" type="text" class=" x-form-select x-form-field" >
																		<option value="">전체</option>
																		<c:forEach items="${SRS_STATUS_CODE}" var="data" varStatus="status">
																				<option value="${data.COM_CODE}"  ><c:out value="${data.COM_CODE_NAME}"/></option>
																		</c:forEach>
																	</select>	
													            </c:otherwise>
													        </c:choose>															
														
															
														</div>
														<div class="x-form-clear-left">
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>
									<!-- DETAIL 3_ROW End -->
								
									<!-- DETAIL 4_ROW Start -->
									<div class="x-column-inner" style="width: 100%; margin-top: 0.2em;">
										<div class=" x-panel x-column" style="width: 50%;" >
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label class="x-form-item-label" style="width: auto;" for="pjt_name" ><font color="red">* </font>프로젝트ID:</label>
														<div style="padding-left: 100px;" class="x-form-element">
															<table style="width:200px;" cellspacing="0" class="x-btn  x-btn-noicon">
																<tr>
																	<td>
																		<input type="text" name="pjt_name" id="pjt_name" autocomplete="off" size="50" class=" x-form-text x-form-field" style="width: auto;" maxlength="15" readonly="true">
																	</td>
																	<td valign="top">
																		<%-- Button Start--%>
																			<div style="padding-left: 0px;" >
																				<img align="center" id="pjt_btn" name="pjt_btn" alt="" src="/resource/images/bass_1st/icon_src1.gif" style="cursor: hand;">
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
														<label style="padding-rigth: 100px;"  class="x-form-item-label" style="width: auto;" for="srs_req_emp_dept_name" color="gray"><font color="red">* </font>의뢰부서 :</label>
														
														<div style="padding-left: 100px;" class="x-form-element">
															<input type="text" name="srs_req_emp_dept_name" id="srs_req_emp_dept_name" autocomplete="off" size="50" class=" x-form-text x-form-field" style="width: auto;" readonly="true">	
														</div>
														
													</div>
												</div>
											</div>
										</div>
										
									</div>
									<!-- DETAIL 4_ROW End -->
								
									<!-- DETAIL 5_ROW Start -->
									<div class="x-column-inner" style="width: 100%; margin-top: 0em;">
										<div class=" x-panel x-column" style="width: 50%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label style="padding-rigth: 100px;"  class="x-form-item-label" style="width: auto;" for="custom_name" ><font id="font_custom_name"  color="gray">* </font>거래처 :</label>
														<div style="padding-left: 100px;" class="x-form-element">
															<table>
																<tr>
																	<td>
																		<input type="text" name="custom_name" id="custom_name" autocomplete="off" size="27" class=" x-form-text x-form-field" style="width: auto;" readonly="true">	
																	</td>
																	<td>
																		<input type="checkbox" name="custom_same_yn" id="custom_same_yn" value="" autocomplete="off" class=" x-form-checkbox x-form-field" onclick="javascript:moveDataToEndUser(this)">
																		
																	</td>
																	<td >
																		<div tabindex="-1" class="x-form-item " >
																		<label style="padding-rigth: 5px; text-align:center"  class="x-form-item-label" style="width: auto;" for="spec" >엔드유저 동일</label>
																		</div>
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
														<label style="padding-rigth: 100px;"  class="x-form-item-label" style="width: auto;" for="srs_req_emp_name" ><font color="red">* </font>의뢰자 :</label>
														<div style="padding-left: 100px;" class="x-form-element">
															<input type="text" name="srs_req_emp_name" id="srs_req_emp_name" autocomplete="off" size="50" class=" x-form-text x-form-field" style="width: auto;" readonly="true">
														</div>
													</div>
												</div>
											</div>
										</div>
														
									</div>
									<!-- DETAIL 5_ROW End -->				
				
									<!-- 6_ROW Start -->
									<div class="x-column-inner" style="width: 100%;">
										<div class=" x-panel x-column" style="width: 50%;" >
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label class="x-form-item-label" style="width: auto;" for="customer_name" >거래처담당자:</label>
														<div style="padding-left: 100px;" class="x-form-element">
															<table style="width: 200px;" cellspacing="0" class="x-btn  x-btn-noicon">
																<tr>
																	<td>
																		<input type="text" name="customer_dept_name" id="customer_dept_name" autocomplete="off" size="13" class=" x-form-text x-form-field" style="width: auto;" readonly="true">
																		<input type="text" name="customer_name" id="customer_name" autocomplete="off" size="8" class=" x-form-text x-form-field" style="width: auto;" readonly="true">
																	</td>
																	<td>
																		<%-- Button Start--%>
																			<div style="padding-left: 0px;" >
																				<img align="center" id="custom_name_btn" name="custom_name_btn" alt="" src="/resource/images/bass_1st/icon_src1.gif" style="cursor: hand;">
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
														<label class="x-form-item-label" style="width: auto;" for="srs_req_date" ><font color="red">* </font>의뢰요청일:</label>
														<div style="padding-left: 100px;" class="x-form-element">
														   <input type="text" name="srs_req_date" id="srs_req_date" autocomplete="off" size="30" class=" x-form-text x-form-field" style="width: auto;" readonly="true"/>
														</div>
														<div class="x-form-clear-left">
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>
									<!-- 6_ROW End -->

				
									
									
									<!-- DETAIL 7_ROW Start -->
									<div class="x-column-inner" style="width: 100%; margin-top: 0em;">
										<div class=" x-panel x-column" style="width: 50%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label style="padding-rigth: 100px;"  class="x-form-item-label" style="width: auto;" for="customer_telephone" >거래처연락처 :</label>
														<div style="padding-left: 100px;" class="x-form-element">
															<input type="text" name="customer_telephone" id="customer_telephone" autocomplete="off" size="50" class=" x-form-text x-form-field" style="width: auto;" >
														</div>
													</div>
												</div>
											</div>
										</div>
										
										<div class=" x-panel x-column" style="width: 50%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label style="padding-rigth: 100px;"  class="x-form-item-label" style="width: auto;" for="target_date" ><font id="font_target_date" color="gray">* </font>기한일 :</label>
														<div style="padding-left: 100px;" class="x-form-element">
															<input type="text" name="target_date" id="target_date" autocomplete="off" size="30" class=" x-form-text x-form-field" style="width: auto;"
																		onFocus="restoreDateString(this, this.value)" onKeydown="_chkKeyPressNumPoint(this)" onblur="isValidDate(this, this.value)"/>
														</div>
													</div>
												</div>
											</div>
										</div> 		
									</div>
									<!-- DETAIL 7_ROW End -->
									
									
									<!-- DETAIL 8_ROW Start -->
									<div class="x-column-inner" style="width: 100%; margin-top: 0em;">
										<div class=" x-panel x-column" style="width: 50%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label style="padding-rigth: 100px;"  class="x-form-item-label" style="width: auto;" for="end_name" ><font id="font_end_name"  color="gray">* </font>엔드유저 :</label>
														<div style="padding-left: 100px;" class="x-form-element">
															<input type="text" name="end_name" id="end_name" autocomplete="off" size="50" class=" x-form-text x-form-field" style="width: auto;" readonly="true">
														</div>
													</div>
												</div>
											</div>
										</div>										
										
										<div class=" x-panel x-column" style="width: 50%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label style="padding-rigth: 100px;"  class="x-form-item-label" style="width: auto;" for="plan_date_from" ><font id="font_plan_date_from" color="gray">* </font>희망처리기간 :</label>
														<div style="padding-left: 100px;" class="x-form-element">
															<table>
																<tr>
																	<td width="100px">
																		<input type="text" name="plan_date_from" id="plan_date_from" autocomplete="off" size="10" class=" x-form-text x-form-field" style="width: auto;"
																		onFocus="restoreDateString(this, this.value)" onKeydown="_chkKeyPressNumPoint(this)" onblur="isValidDate(this, this.value)"/>
																	</td>
																	<td width="50px" style="vertical-align:top">
																		<input type="text" name="plan_time_from" id="plan_time_from" autocomplete="off"  onclick="this.value='';" onKeydown="_chkKeyPressNumPoint(this)" onchange="chkTime(this)" size="5" maxlength="4" class="x-form-text x-form-field" style="width: auto; text-align:center;" value="--:--"/> 		
																	</td>
																	<td width="10px" style="vertical-align:top">~</td>
																	<td width="100px" >
																		<input type="text" name="plan_date_to" id="plan_date_to" autocomplete="off" size="10" class=" x-form-text x-form-field" style="width: auto;"
																		onFocus="restoreDateString(this, this.value)" onKeydown="_chkKeyPressNumPoint(this)" onblur="isValidDate(this, this.value)"/>
																	</td>
																	<td width="50px" style="vertical-align:top">
																		<input type="text" name="plan_time_to" id="plan_time_to" autocomplete="off"  onclick="this.value='';" onKeydown="_chkKeyPressNumPoint(this)" onchange="chkTime(this)" size="5" maxlength="4" class="x-form-text x-form-field" style="width: auto; text-align:center;" value="--:--"/> 		
																	</td>
																</tr> 
															</table>
														</div>
													</div>
												</div>
											</div>
										</div> 		
									</div>
									<!-- DETAIL 8_ROW End -->
									
									<!-- 9_ROW Start -->
									<div class="x-column-inner" style="width: 100%;">
										<div class=" x-panel x-column" style="width: 50%;" >
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label class="x-form-item-label" style="width: auto;" for="enduser_name" >앤드유저담당:</label>
														<div style="padding-left: 100px;" class="x-form-element">
															<table style="width: 200px;" cellspacing="0" class="x-btn  x-btn-noicon">
																<tr>
																	<td>
																		<input type="text" name="enduser_dept_name" id="enduser_dept_name" autocomplete="off" size="13" class=" x-form-text x-form-field" style="width: auto;" readonly="true">
																		<input type="text" name="enduser_name" id="enduser_name" autocomplete="off" size="8" class=" x-form-text x-form-field" style="width: auto;" readonly="true">
																	</td>
																	<td>
																		<%-- Button Start--%>
																			<div style="padding-left: 0px;" >
																				<img align="center" id="end_name_btn" name="end_name_btn" alt="" src="/resource/images/bass_1st/icon_src1.gif" style="cursor: hand;">
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
														<label class="x-form-item-label" style="width: auto;" for="proc_date_from" ><font id="font_proc_date_from" color="gray">* </font>실제처리기간:</label>
														<div style="padding-left: 100px;" class="x-form-element">
															
															<table>
																<tr>
																	<td width="100px">
																		<input type="text" name="proc_date_from" id="proc_date_from" autocomplete="off" size="10" class=" x-form-text x-form-field" style="width: auto;"
																		onFocus="restoreDateString(this, this.value)" onKeydown="_chkKeyPressNumPoint(this)" onblur="isValidDate(this, this.value)"/>
																	</td>
																	<td width="50px" style="vertical-align:top">
																		<input type="text" name="proc_time_from" id="proc_time_from" autocomplete="off"  onclick="this.value='';" onKeydown="_chkKeyPressNumPoint(this)" onchange="chkTime(this)" size="5" maxlength="4" class="x-form-text x-form-field" style="width: auto; text-align:center;" value="--:--"/> 		
																	</td>
																	<td width="10px" style="vertical-align:top">~</td>
																	<td width="100px" >
																		<input type="text" name="proc_date_to" id="proc_date_to" autocomplete="off" size="10" class=" x-form-text x-form-field" style="width: auto;"
																		onFocus="restoreDateString(this, this.value)" onKeydown="_chkKeyPressNumPoint(this)" onblur="isValidDate(this, this.value)"/>
																	</td>
																	<td width="50px" style="vertical-align:top">
																		<input type="text" name="proc_time_to" id="proc_time_to" autocomplete="off"  onclick="this.value='';" onKeydown="_chkKeyPressNumPoint(this)" onchange="chkTime(this)" size="5" maxlength="4" class="x-form-text x-form-field" style="width: auto; text-align:center;" value="--:--"/> 		
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
									<!-- 9_ROW End -->
									
									<!-- DETAIL 10_ROW Start -->
									<div class="x-column-inner" style="width: 100%; margin-top: 0em;">
										<div class=" x-panel x-column" style="width: 50%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label style="padding-rigth: 100px;"  class="x-form-item-label" style="width: auto;" for="enduser_telephone" >엔드유저 연락처 :</label>
														<div style="padding-left: 83px;" class="x-form-element">
															<input type="text" name="enduser_telephone" id="enduser_telephone" autocomplete="off" size="50" class=" x-form-text x-form-field" style="width: auto;" >
														</div>
													</div>
												</div>
											</div>
										</div> 
										
										<div class=" x-panel x-column" style="width: 50%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label style="padding-rigth: 100px;"  class="x-form-item-label" style="width: auto;" for="terminate_date" >완료일 :</label>
														<div style="padding-left: 100px;" class="x-form-element">
															<input type="text" name="terminate_date" id="terminate_date" autocomplete="off" size="30" class=" x-form-text x-form-field" style="width: auto;" readonly="true">
														</div>
													</div>
												</div>
											</div>
										</div>
														
									</div>
									<!-- DETAIL 10_ROW End -->
									
									
									<!-- DETAIL 11_ROW Start -->
									<div class="x-column-inner" style="width: 100%; margin-top: 0em;">
										<div class=" x-panel x-column" style="width: 50%;" >
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label class="x-form-item-label" style="width: auto;" for="visit_navi" ><font id="font_visit_navi" color="gray"> </font>방문위치 정보:</label>
														<div style="padding-left: 100px;" class="x-form-element">
															<table style="width: 270px;" cellspacing="0" class="x-btn  x-btn-noicon">
																<tr>
																	<td >
																		<input type="text" name="visit_navi" id="visit_navi" autocomplete="off" size="50" class=" x-form-text x-form-field" style="width: auto;" readOnly  onclick="javascript:openNaviUrl();">
																	</td>
																	<td>
																		<%-- Button Start--%>
																			<div style="padding-left: 0px;" >
																				<img align="center" id="visit_navi_btn" name="visit_navi_btn" alt="" src="/resource/images/bass_1st/icon_src1.gif" style="cursor: hand;">
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
										
										<!--
										<div class=" x-panel x-column" style="width: 50%;" >
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label class="x-form-item-label" style="width: auto;" for="visit_navi" >방문위치 URL:</label>
														<div style="padding-left: 100px;" class="x-form-element">
															<table style="width: 270px;" cellspacing="0" class="x-btn  x-btn-noicon">
																<tr>
																	<td >
																		<input type="text" name="visit_navi_url" id="visit_navi_url" autocomplete="off" size="55" class=" x-form-text x-form-field" style="width: auto; cursor:hand;" readOnly  onclick="javascript:openNaviUrl();">
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
										-->
										
																			
														
									</div>
									<!-- DETAIL 11_ROW End -->
									
																		
									<!-- DETAIL 13_ROW Start -->
									<div class="x-column-inner" style="width: 100%; margin-top: 0em;">
										
										<div class=" x-panel x-column" style="width: 50%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 95%;">
													<div tabindex="-1" class="x-form-item " >
														<label style="padding-rigth: 100px;"  class="x-form-item-label" style="width: auto;" for="srs_detail" ><font id="font_srs_detail" color="gray">* </font>의뢰내역 :</label>
														<div style="padding-left: 100px;" class="x-form-element">
															<textarea name="srs_detail" id="srs_detail" autocomplete="off" class=" x-form-text x-form-field" style="width:100%; height:130px" onkeyup="jk_ContentsCheck(this,400);"></textarea>
														</div>
													</div>
												</div>
											</div>
										</div>
										
										
										
										
										<div class=" x-panel x-column" style="width: 50%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label style="padding-rigth: 100px;"  class="x-form-item-label" style="width: auto;" for="srs_mgr_dept_name_1" ><font color="red">* </font>1차 지원부서 :</label>
														<div style="padding-left: 100px;" class="x-form-element">
															<input type="text" name="srs_mgr_dept_name_1" id="srs_mgr_dept_name_1" autocomplete="off" size="50" class=" x-form-text x-form-field" style="width: auto;" readonly="true" value="${TEAMLEADER_1[0].DEPT_NAME}">
														</div>
													</div>
													
													<div tabindex="-1" class="x-form-item " >
														<label style="padding-rigth: 100px;"  class="x-form-item-label" style="width: auto;" for="srs_mgr_name_1" ><font color="red">* </font>1차 팀장 :</label>
														<div style="padding-left: 100px;" class="x-form-element">
															<table>
																<tr>
																	<td>
																		<input type="text" name="srs_mgr_name_1" id="srs_mgr_name_1" autocomplete="off" size="30" class=" x-form-text x-form-field" style="width: auto;" readonly="true"  value="${TEAMLEADER_1[0].KOR_NAME}">
																	</td>
																	<td>
																		<input type="checkbox" name="checkSrsMgrDept2" id="checkSrsMgrDept2" value="" autocomplete="off" class=" x-form-checkbox x-form-field" onclick="javascript:showSrsMgrDept2(this);">
																		
																	</td>
																	<td>
																		<div tabindex="-1" class="x-form-item " >
																		<label style="padding-rigth: 5px;"  class="x-form-item-label" style="width: auto;" for="spec" >2차지원 이관</label>
																		</div>
																	</td>
																</tr> 
															</table>
															
															
														</div>
													</div>
													
													<div tabindex="-1" class="x-form-item " >
														<label class="x-form-item-label" style="width: auto;" for="sup_emp_name_1" ><font id="font_sup_emp_name_1" color="gray">* </font>1차 지원담당:</label>
														<div style="padding-left: 100px;" class="x-form-element">
															<table style="width: 130px;" cellspacing="0" class="x-btn  x-btn-noicon">
																<tr>
																	<td>
																		<input type="text" name="sup_emp_name_1" id="sup_emp_name_1" autocomplete="off" size="30" class=" x-form-text x-form-field" style="width: auto;" readonly="true" >
																	</td>
																	<td>
																		<%-- Button Start--%>
																			<div style="padding-left: 0px;" >
																				<img align="center" id="sup_emp_btn_1" name="sup_emp_btn_1" alt="" src="/resource/images/bass_1st/icon_src1.gif" style="cursor: hand;">
																			</div>
																		<%-- Button End--%>
																		
																	</td>
																</tr>
															</table>
														</div>
													</div>
												</div>
											</div>
										</div>	
														
									</div>
									<!-- DETAIL 13_ROW End -->						
									
									<!-- DETAIL 14_ROW Start -->
									<div class="x-column-inner" style="width: 100%; margin-top: 0em;">

										
										
										<div class=" x-panel x-column" style="width: 50%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 95%;">
													<div tabindex="-1" class="x-form-item " >
														<label style="padding-rigth: 100px;"  class="x-form-item-label" style="width: auto;" for="srs_proc_detail" ><font id="font_srs_proc_detail" color="gray">* </font>처리내역 :</label>
														<div style="padding-left: 100px;" class="x-form-element">
															<textarea name="srs_proc_detail" id="srs_proc_detail" autocomplete="off" class=" x-form-text x-form-field" style="width:100%; height:100px" onkeyup="jk_ContentsCheck(this,400);"></textarea>
														</div>
													</div>
												</div>
											</div>
										</div>
										
										
										<div class=" x-panel x-column" style="width: 50%;" id="div_srs_mgr_dept_2">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label style="padding-rigth: 100px;"  class="x-form-item-label" style="width: auto;" for="srs_mgr_dept_2" ><font id="font_srs_mgr_dept_2" color="gray">* </font>2차 지원부서 :</label>
														<div style="padding-left: 100px;" class="x-form-element">
															<select name="srs_mgr_dept_2" id="srs_mgr_dept_2" style="width: 100px;" type="text" class=" x-form-select x-form-field" >
																<option value="">전체</option>
																<c:forEach items="${SRSMGRDEPT2}" var="data" >
																	<option value="${data.DEPT_CODE}"><c:out value="${data.DEPT_NAME}"/></option>
																</c:forEach>
															</select>
														</div>
													</div>
													
													<div tabindex="-1" class="x-form-item " >
														<label style="padding-rigth: 100px;"  class="x-form-item-label" style="width: auto;" for="srs_mgr_name_2" ><font id="font_srs_mgr_name_2" color="gray">* </font>2차 팀장 :</label>
														<div style="padding-left: 100px;" class="x-form-element">
															<input type="text" name="srs_mgr_name_2" id="srs_mgr_name_2" autocomplete="off" size="30" class=" x-form-text x-form-field" style="width: auto;" readonly="true" >
														</div>
													</div>
													
													<div tabindex="-1" class="x-form-item " >
														<label class="x-form-item-label" style="width: auto;" for="sup_emp_name_2" ><font id="font_sup_emp_name_2" color="gray">* </font>2차 지원담당:</label>
														<div style="padding-left: 100px;" class="x-form-element">
															<table style="width: 130px;" cellspacing="0" class="x-btn  x-btn-noicon">
																<tr>
																	<td>
																		<input type="text" name="sup_emp_name_2" id="supEmp_name_2" autocomplete="off" size="30" class=" x-form-text x-form-field" style="width: auto;" readonly="true" >
																	</td>
																	<td>
																		<%-- Button Start--%>
																			<div style="padding-left: 0px;" >
																				<img align="center" id="sup_emp_btn_2" name="sup_emp_btn_2" alt="" src="/resource/images/bass_1st/icon_src1.gif" style="cursor: hand;">
																			</div>
																		<%-- Button End--%>
																		
																	</td>
																</tr>
															</table>
														</div>
													</div>
												</div>
											</div>
										</div>
														
									</div>
									<!-- DETAIL 14_ROW End -->									
									
									
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

			<td valign="top">
				<div class=" x-panel x-form-label-left" style="margin-top: 0.4em; width: 150px;"><%-- 0em <- 1em으로 수정하면 상위 공백 --%>
					<!----------------- SEARCH Hearder Start	 ----------------->
					<div class="x-panel-tl">
						<div class="x-panel-tr">
							<div class="x-panel-tc">
								<div class="x-panel-header x-unselectable" style="-moz-user-select: none;">
									<span class="x-panel-header-text">요청항목</span>	
								</div>
							</div>
						</div>
					</div>
					<!----------------- SEARCH Hearder End	 ----------------->
					<div class="x-panel-bwrap" >
						<div class="x-panel-ml">
							<div class="x-panel-mr">
								<div class="x-panel-mc" >
									
									<!-- DETAIL 1_ROW Start -->
									<div class="x-column-inner" style="width: 100%; margin-top: 0.2em;">
										<div class=" x-panel x-column" style="width: 100%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
														<input type="checkbox" name="req_item" id="req_item" value="1" autocomplete="off" class=" x-form-checkbox x-form-field" >
														<label class="x-form-item-label" style="width: auto;" for="" >선설치</label>

												</div>
											</div>
										</div>					
									</div>
									<!-- DETAIL 1_ROW End -->
								
									<!-- DETAIL 2_ROW Start -->
									<div class="x-column-inner" style="width: 100%; margin-top: 0.2em;">
										<div class=" x-panel x-column" style="width: 100%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
														<input type="checkbox" name="req_item" id="req_item" value="2" autocomplete="off" class=" x-form-checkbox x-form-field" >
														<label class="x-form-item-label" style="width: auto;" for="" >정식설치</label>
												</div>
											</div>
										</div>					
									</div>
									<!-- DETAIL 2_ROW End -->
									
									<!-- DETAIL 3_ROW Start -->
									<div class="x-column-inner" style="width: 100%; margin-top: 0.2em;">
										<div class=" x-panel x-column" style="width: 100%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
														<input type="checkbox" name="req_item" id="req_item" value="3" autocomplete="off" class=" x-form-checkbox x-form-field" >
														<label class="x-form-item-label" style="width: auto;" for="" >이전/재설치</label>
												</div>
											</div>
										</div>					
									</div>
									<!-- DETAIL 3_ROW End -->
									
									<!-- DETAIL 4_ROW Start -->
									<div class="x-column-inner" style="width: 100%; margin-top: 0.2em;">
										<div class=" x-panel x-column" style="width: 100%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
														<input type="checkbox" name="req_item" id="req_item" value="4" autocomplete="off" class=" x-form-checkbox x-form-field" >
														<label class="x-form-item-label" style="width: auto;" for="" >패치</label>
												</div>
											</div>
										</div>					
									</div>
									<!-- DETAIL 4_ROW End -->
									
									
									<!-- DETAIL 5_ROW Start -->
									<div class="x-column-inner" style="width: 100%; margin-top: 0.2em;">
										<div class=" x-panel x-column" style="width: 100%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
														<input type="checkbox" name="req_item" id="req_item" value="5" autocomplete="off" class=" x-form-checkbox x-form-field" >
														<label class="x-form-item-label" style="width: auto;" for="" >업그레이드</label>
												</div>
											</div>
										</div>					
									</div>
									<!-- DETAIL 5_ROW End -->
									
									<!-- DETAIL 6_ROW Start -->
									<div class="x-column-inner" style="width: 100%; margin-top: 0.2em;">
										<div class=" x-panel x-column" style="width: 100%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
														<input type="checkbox" name="req_item" id="req_item" value="6" autocomplete="off" class=" x-form-checkbox x-form-field" >
														<label class="x-form-item-label" style="width: auto;" for="" >장애지원</label>
												</div>
											</div>
										</div>					
									</div>
									<!-- DETAIL 6_ROW End -->
									
									<!-- DETAIL 7_ROW Start -->
									<div class="x-column-inner" style="width: 100%; margin-top: 0.2em;">
										<div class=" x-panel x-column" style="width: 100%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
														<input type="checkbox" name="req_item" id="req_item" value="7" autocomplete="off" class=" x-form-checkbox x-form-field" >
														<label class="x-form-item-label" style="width: auto;" for="" >개발가이드</label>
												</div>
											</div>
										</div>					
									</div>
									<!-- DETAIL 7_ROW End -->
									
									<!-- DETAIL 8_ROW Start -->
									<div class="x-column-inner" style="width: 100%; margin-top: 0.2em;">
										<div class=" x-panel x-column" style="width: 100%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
														<input type="checkbox" name="req_item" id="req_item" value="8" autocomplete="off" class=" x-form-checkbox x-form-field" >
														<label class="x-form-item-label" style="width: auto;" for="" >샘플폼개발</label>
												</div>
											</div>
										</div>					
									</div>
									<!-- DETAIL 8_ROW End -->
									
									<!-- DETAIL 9_ROW Start -->
									<div class="x-column-inner" style="width: 100%; margin-top: 0.2em;">
										<div class=" x-panel x-column" style="width: 100%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
														<input align="left" type="checkbox" name="req_item" id="req_item" value="9" autocomplete="off" class=" x-form-checkbox x-form-field" >
														<label class="x-form-item-label" style="width: auto;" for="" >매뉴얼/교재작성</label>
												</div>
											</div>
										</div>					
									</div>
									<!-- DETAIL 9_ROW End -->
									
									<!-- DETAIL 10_ROW Start -->
									<div class="x-column-inner" style="width: 100%; margin-top: 0.2em;">
										<div class=" x-panel x-column" style="width: 100%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
														<input type="checkbox" name="req_item" id="req_item" value="10" autocomplete="off" class=" x-form-checkbox x-form-field" >
														<label class="x-form-item-label" style="width: auto;" for="" >기술자료작성</label>
												</div>
											</div>
										</div>					
									</div>
									<!-- DETAIL 10_ROW End -->
									
									<!-- DETAIL 11_ROW Start -->
									<div class="x-column-inner" style="width: 100%; margin-top: 0.2em;">
										<div class=" x-panel x-column" style="width: 100%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
														<input type="checkbox" name="req_item" id="req_item" value="11" autocomplete="off" class=" x-form-checkbox x-form-field" >
														<label class="x-form-item-label" style="width: auto;" for="" >유지보수/점검</label>
												</div>
											</div>
										</div>					
									</div>
									<!-- DETAIL 11_ROW End -->
									
									<!-- DETAIL 12_ROW Start -->
									<div class="x-column-inner" style="width: 100%; margin-top: 0.2em;">
										<div class=" x-panel x-column" style="width: 100%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
														<input type="checkbox" name="req_item" id="req_item" value="12" autocomplete="off" class=" x-form-checkbox x-form-field" >
														<label class="x-form-item-label" style="width: auto;" for="" >BMT</label>
												</div>
											</div>
										</div>					
									</div>
									<!-- DETAIL 12_ROW End -->
									
									<!-- DETAIL 13_ROW Start -->
									<div class="x-column-inner" style="width: 100%; margin-top: 0.2em;">
										<div class=" x-panel x-column" style="width: 100%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
														<input type="checkbox" name="req_item" id="req_item" value="13" autocomplete="off" class=" x-form-checkbox x-form-field" >
														<label class="x-form-item-label" style="width: auto;" for="" >업무협의</label>
												</div>
											</div>
										</div>					
									</div>
									<!-- DETAIL 13_ROW End -->
									
									<!-- DETAIL 14_ROW Start -->
									<div class="x-column-inner" style="width: 100%; margin-top: 0.2em;">
										<div class=" x-panel x-column" style="width: 100%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
														<input type="checkbox" name="req_item" id="req_item" value="14" autocomplete="off" class=" x-form-checkbox x-form-field" >
														<label class="x-form-item-label" style="width: auto;" for="" >기타</label>
												</div>
											</div>
										</div>					
									</div>
									<!-- DETAIL 14_ROW End -->
									
									
									<!-- DETAIL 14_ROW Start -->
									<div class="x-column-inner" style="width: 100%; margin-top: 0.2em;">
										<div class=" x-panel x-column" style="width: 100%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="height:237px ; width: 100%;">
												</div>
											</div>
										</div>					
									</div>
									<!-- DETAIL 14_ROW End -->									
									
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

			</form>
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
						</td>
						
						
						<!--
							<td width="1">
							</td>
							<td>
							<%-- 출력 버튼 Start --%>
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
												<button type="button" id="updateBtn" name="updateBtn" class=" x-btn-text"  onclick="printArea();">출력</button>
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
							<%-- 출력 버튼 End --%>
							</td>
						-->
					</tr>
				</table>
			</td>
		</tr>
	</table>
	<iframe name="jobFrame" style="display:none" frameborder=0></iframe>
</body>

</html>