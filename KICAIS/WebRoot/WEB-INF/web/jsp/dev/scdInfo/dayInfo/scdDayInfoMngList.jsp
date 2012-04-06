<%--
  Class Name  : scdDayInfoMngList.jsp
  Description : 업무요청정보 관리
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

<%
	String hhmm[] =  new String[48];
	for(double  i=0; i<48; i++) 
	{ 
		String hour = ""; 
		String min = ":00"; 
	
		if((Math.ceil(i/2)) < 10 ) 
		{ 
			hour = "0"+String.valueOf((int)Math.floor(i/2));
		} 
		else 
		{ 
			if(i==19)
			{
				hour = "0"+String.valueOf((int)Math.floor(i/2));
			}else
			{
				hour = String.valueOf((int)Math.floor(i/2));
			} 
		} 
		if(i%2 != 0) 
		{ 
			min = ":30"; 
		} 
		
		hhmm[(int)i]=hour+min;
	} 

	
for(int k = 0; k < hhmm.length; k++) 
{ 
//System.out.println(hhmm[k]); 
} 

%>

<script type="text/javascript" src="/resource/common/js/sgis-comm-inc.js" ></script> 
<script type="text/javascript" src="/resource/common/js/common/common-msg-box.js" ></script> 
<script type="text/javascript" src="/resource/common/js/ajax.js" ></script>
<script type="text/javascript" src="/resource/common/js/grid/grid_1st.js"></script>
<script type="text/javascript" src="/resource/common/js/grid/grid_edit_1st.js"></script>

<script type="text/javascript">

/***************************************************************************
 * 파일관련 변수
 ***************************************************************************/
var delScdExecPrpdSeq ="";
var delScdDaySeq ="";
var filesize = 0;

/***************************************************************************
 * 초기값 설정
 ***************************************************************************/
var	gridHeigth_1st 	 	= 200; 						// 그리드 전체 높이
var	gridWidth_1st		= 1022;						// 그리드 전체 폭
var gridTitle_1st 		= "오늘의 일정";	  	// 그리드 제목
var	render_1st			= "task-grid";	  			// 렌더(화면에 그려질) 할 id 
var	pageSize_1st		= 5;	  					// 그리드 페이지 사이즈	
var	proxyUrl_1st		= "/dev/scdInfo/dayInfo/result.sg";		// 결과 값 페이지
var limit_1st			= pageSize_1st;
var start_1st			= 0;



/***************************************************************************
 * Grid의 컬럼 설정
 ***************************************************************************/
var userColumns_1st =  [   
						   {header: '조회상태' 			, width: 60, sortable:true, dataIndex: 'FLAG'               	,hidden : true}       
						  ,{header: '프로젝트명' 			, width: 60, sortable:true, dataIndex: 'PJT_NAME'             }     
						  ,{header: '제품명' 				, width: 60, sortable:true, dataIndex: 'ITEM_NAME'          }
						  ,{header: '타스크명' 			, width: 60, sortable:true, dataIndex: 'TASK_NAME'         	 	}
						  ,{header: '시작일' 				, width: 60, sortable:true, dataIndex: 'SCD_PLAN_FROM_DATE'  		}						
						  ,{header: '종료일' 				, width: 60, sortable:true, dataIndex: 'SCD_PLAN_TO_DATE'    		}					
						  ,{header: '일정계획순번' 		, width: 60, sortable:true, dataIndex: 'SCD_DAY_SEQ'        ,hidden : true}      
					      ,{header: '일정구분코드' 		, width: 60, sortable:true, dataIndex: 'SCD_TYPE_CODE'      ,hidden : true}                                                    
					      ,{header: '일정구분명' 			, width: 60, sortable:true, dataIndex: 'SCD_TYPE_NAME'        ,hidden : true}        
					      ,{header: '계획수행구분코드' 	, width: 60, sortable:true, dataIndex: 'PROC_TYPE_CODE'     ,hidden : true}                
					      ,{header: '계획수행구분명' 		, width: 60, sortable:true, dataIndex: 'PROC_TYPE_NAME'       ,hidden : true}    
					      ,{header: '일정상태값' 			, width: 60, sortable:true, dataIndex: 'STATUS_VAL'         ,hidden : true}                                                    
					      ,{header: '일정상태명' 			, width: 60, sortable:true, dataIndex: 'STATUS_NAME'          ,hidden : true}        
					      ,{header: '내근/외근구분코드' 	, width: 60, sortable:true, dataIndex: 'WORK_PATTERN_CODE'  ,hidden : true}              
					      ,{header: '내근/외근구분명' 	, width: 60, sortable:true, dataIndex: 'WORK_PATTERN_NAME'    ,hidden : true}   
	                      ,{header: '프로젝트id' 			, width: 60, sortable:true, dataIndex: 'PJT_ID'             ,hidden : true}        
	                      ,{header: '타스크그룹코드' 		, width: 60, sortable:true, dataIndex: 'TASK_GROUP_CODE'    ,hidden : true}       
					      ,{header: '타스크그룹명' 		, width: 60, sortable:true, dataIndex: 'TASK_GROUP_NAME'      ,hidden : true}      
					      ,{header: '타스크코드' 			, width: 60, sortable:true, dataIndex: 'TASK_CODE'          ,hidden : true}        
						  ,{header: '제품코드' 			, width: 60, sortable:true, dataIndex: 'ITEM_CODE'			,hidden : true}			
						  ,{header: '일정별담당자배정 순번' , width: 60, sortable:true, dataIndex: 'SCD_DUTY_SEQ'			,hidden : true}			
  						  ,{header: '타스크완료여부' 		, width: 30, sortable:true, dataIndex: 'TASK_END_YN'        ,hidden : true}
					   ];	 

/***************************************************************************
 * 그리드 결과매핑 
 ***************************************************************************/
var mappingColumns_1st = [   
							  {name: 'FLAG' 		  		, allowBlank: false}			//상태" 				
							 ,{name: 'PJT_NAME' 				, allowBlank: false}			//프로젝트명" 		
							 ,{name: 'ITEM_NAME'			, allowBlank: false} 			//제품명" 			
							 ,{name: 'TASK_NAME'				, allowBlank: false} 			//타스크명" 			
							 ,{name: 'SCD_PLAN_FROM_DATE'			, allowBlank: false} 			 //시작일" 			
							 ,{name: 'SCD_PLAN_TO_DATE'			, allowBlank: false}  			//종료일" 			
							 ,{name: 'SCD_DAY_SEQ'  		, allowBlank: false}  			//일정계획순번" 		
							 ,{name: 'SCD_TYPE_CODE'		, allowBlank: false}  			//일정구분코드" 		
							 ,{name: 'SCD_TYPE_NAME'			, allowBlank: false} 			//일정구분명" 		
							 ,{name: 'PROC_TYPE_CODE'		, allowBlank: false}  			//계획수행구분코드" 	
							 ,{name: 'PROC_TYPE_NAME' 		, allowBlank: false}  			 //계획수행구분명" 	
	                         ,{name: 'STATUS_VAL' 			, allowBlank: false}             //일정상태값" 		
	                         ,{name: 'STATUS_NAME' 			, allowBlank: false}             //일정상태명" 		
	                         ,{name: 'WORK_PATTERN_CODE' 	, allowBlank: false}             //내근/외근구분코드" 
	                         ,{name: 'WORK_PATTERN_NAME' 		, allowBlank: false}             //내근/외근구분명" 	
	                         ,{name: 'PJT_ID' 				, allowBlank: false}             //프로젝트id" 		
	                         ,{name: 'TASK_GROUP_CODE' 		, allowBlank: false}             //타스크그룹코드" 	
	                         ,{name: 'TASK_GROUP_NAME' 		, allowBlank: false}             //타스크그룹명" 		
	                         ,{name: 'TASK_CODE' 			, allowBlank: false}             //타스크코드" 		
	                         ,{name: 'ITEM_CODE' 			, allowBlank: false}             //제품코드" 									  
	                         ,{name: 'SCD_DUTY_SEQ' 		, allowBlank: false}             //일정별담당자배정 순번" 
	                         ,{name: 'TASK_END_YN'  		, allowBlank: false} 			//타스크완료여부" 
	    				 ];
 
/***************************************************************************
 * 그리드 클릭시 Event
 ***************************************************************************/
function fnGridOnClick_1st(store, rowIndex){

	// 일정관리(개인별)정보 검색
	fnEditGridListSearch(store, rowIndex);
	
	//상세정보 셋팅
	fnEdit1stSrchAfterSetDetailForm();
	
	var mytable = document.getElementById("fileview_table");

	var rowLength = mytable.rows.length;

	if(rowLength > 0)
	{
		for (var i=0; i<rowLength; i++) 
		{
			mytable.deleteRow(i);    
		}
	}		
		
		document.getElementById('dynamic_tr').style.display = 'block'; 
		document.getElementById('fileview_tr').style.display = 'none'; 	
	
		// 버튼 disable
	Ext.get('saveBtn').dom.disabled   = false;
	Ext.get('updateBtn').dom.disabled = true;
	
;}   


/***************************************************************************
 * 설  명 : 그리드의 페이지 클릭시 검색조건값을 DB로 전송
 ***************************************************************************/
function fnPagingValue_1st(){
	
	try{
    	GridClass_1st.store.setBaseParam('src_csr_date_from', Ext.get('src_csr_date_from').getValue());
    	GridClass_1st.store.setBaseParam('src_csr_date_to', 	    Ext.get('src_csr_date_to').getValue());

	}catch(e){

	}
}



// ********************************************************************* //
/** 서버스펙 EditGrid - edit_1st Start**/
var	gridHeigth_edit_1st	=	"200";
var	gridWidth_edit_1st  =	1022;
var	gridTitle_edit_1st  =   "일정관리(개인별) 정보"	; 
var	render_edit_1st		=	"scd_day_info_grid";
var keyNm_edit_1st		= 	"SCD_DAY_SEQ";
var pageSize_edit_1st	=	5;
var limit_edit_1st		=	pageSize_edit_1st;
var start_edit_1st		=	0;
var proxyUrl_edit_1st	=	"/dev/scdInfo/dayInfo/scdDayInfoMngList.sg";
var gridRowDeleteYn = "N";
var tbarHidden_edit_1st ="Y"

//에디트그리드 추가
function addNew_edit_1st(){
	
	
}

//에디트그리드 페이징
function fnPagingValue_edit_1st(){	
	
	
	try{
		
		GridClass_edit_1st.store.setBaseParam('start'			,start_edit_1st);
	    GridClass_edit_1st.store.setBaseParam('limit'			,limit_edit_1st);
	    GridClass_edit_1st.store.setBaseParam('src_scd_duty_seq', 	 Ext.get('scd_duty_seq').getValue());

	}catch(e){

	}

}



// 그리드 필드
var	userColumns_edit_1st	= [ 
								{header: '조회상태' 			, width: 60, sortable:true, dataIndex: 'FLAG'               		,hidden : true} 
								,{header:'순번'                    ,width: 60, sortable: true, dataIndex:'SCD_DAY_SEQ'    		    ,hidden : true}                   	                                                     
								,{header:'프로젝트명'              ,width: 60, sortable: true, dataIndex:'PJT_NAME'                    }            	                                                                                             
								,{header:'타스크 명'               ,width: 60, sortable: true, dataIndex:'TASK_CODE_NAME'              }
								,{header:'일정 시작일'             ,width: 60, sortable: true, dataIndex:'SCD_SDATE'            		}			                                                       
								,{header:'일정 시작 시간'          ,width: 60, sortable: true, dataIndex:'SCD_TIME_FROM'             }            	                                                
								,{header:'일정 종료일'             ,width: 60, sortable: true, dataIndex:'SCD_EDATE'            		}				                                                
								,{header:'일정 종료 시간'          ,width: 60, sortable: true, dataIndex:'SCD_TIME_TO'               }                                                               
								,{header:'타스크완료'          ,width: 60, sortable: true, dataIndex:'TASK_END_YN'				,hidden : true}
								,{header:'타스크완료여부'          ,width: 60, sortable: true, dataIndex:'TASK_END_YN_NM'				}			                                                              
								,{header:'일정구분코드'            ,width: 60, sortable: true, dataIndex:'SCD_TYPE_CODE'             ,hidden : true}            	
								,{header:'일정구분명'              ,width: 60, sortable: true, dataIndex:'SCD_TYPE_CODE_NAME'          ,hidden : true}                                                                                                         
								,{header:'계획수행구분코드'        ,width: 60, sortable: true, dataIndex:'PROC_TYPE_CODE'            ,hidden : true}                                                                   
								,{header:'계획수행구분명'          ,width: 60, sortable: true, dataIndex:'PROC_TYPE_CODE_NAME'         ,hidden : true}                                                                                                                                                            
								,{header:'일정등록부서'            ,width: 60, sortable: true, dataIndex:'SCD_DAY_REG_DEPT'          ,hidden : true}                   
								,{header:'일정등록부서명'          ,width: 60, sortable: true, dataIndex:'SCD_DAY_REG_DEPT_NAME'       ,hidden : true}                   
								,{header:'일정등록자사원번호'      ,width: 60, sortable: true, dataIndex:'SCD_DAY_REG_EMP_NUM'       ,hidden : true}                   
								,{header:'일정등록자사원명'        ,width: 60, sortable: true, dataIndex:'SCD_DAY_REG_EMP_NUM_NAME'    ,hidden : true}                   
								,{header:'일정상태값'              ,width: 60, sortable: true, dataIndex:'STATUS_VAL'  				 ,hidden : true}                   
								,{header:'일정상태명'              ,width: 60, sortable: true, dataIndex:'STATUS_NAME'                 ,hidden : true}                                                                                                         
								,{header:'내근/외근구분코드'       ,width: 60, sortable: true, dataIndex:'WORK_PATTERN_CODE'         ,hidden : true}           	       
								,{header:'내근/외근구분명'         ,width: 60, sortable: true, dataIndex:'WORK_PATTERN_CODE_NAME'      ,hidden : true}            	                                                                                                                            
								,{header:'인건비'                  ,width: 60, sortable: true, dataIndex:'LABOR_COST'                ,hidden : true}        	                                                       
								,{header:'프로젝트ID'              ,width: 60, sortable: true, dataIndex:'PJT_ID'                    ,hidden : true}                                                             
								,{header:'타스크그룹코드'          ,width: 60, sortable: true, dataIndex:'TASK_GROUP_CODE'           ,hidden : true}                                                                                                                                                    
								,{header:'타스크그룹명'            ,width: 60, sortable: true, dataIndex:'TASK_GROUP_CODE_NAME'        ,hidden : true}                                                       
								,{header:'타스크 코드'             ,width: 60, sortable: true, dataIndex:'TASK_CODE'                 ,hidden : true}
								,{header:'지출결의서번호'          ,width: 60, sortable: true, dataIndex:'PAY_NO'                    ,hidden : true}                                                                   
								,{header:'방문일지번호'            ,width: 60, sortable: true, dataIndex:'VISIT_REPORT_NO'           ,hidden : true}                                                               
								,{header:'수행결과내용'            ,width: 60, sortable: true, dataIndex:'SCD_PROC_RES_CONTENT'      ,hidden : true}                                                                   
								,{header:'비고'                    ,width: 60, sortable: true, dataIndex:'NOTE'                      ,hidden : true}                                                                   
								,{header:'현재프로젝트상태코드'    ,width: 60, sortable: true, dataIndex:'PJT_STATUS'				 ,hidden : true}			                                                              
								,{header:'현재프로젝트상태명'      ,width: 60, sortable: true, dataIndex:'PJT_STATUS_NAME'             ,hidden : true}            	                                                                             
								,{header:'최종변경자ID'            ,width: 60, sortable: true, dataIndex:'FINAL_MOD_ID'				 ,hidden : true}			                                                              
								,{header:'등록자ID'                ,width: 60, sortable: true, dataIndex:'REG_ID'					 ,hidden : true}				                                                        
								,{header:'최종변경일시'            ,width: 60, sortable: true, dataIndex:'FINAL_MOD_DATE'			 ,hidden : true}				                                                           
								,{header:'등록일시'            	  ,width: 60, sortable: true, dataIndex:'REG_DATE'                   ,hidden : true}            	                                                          
								,{header:'타스크검토결과코드'      ,width: 60, sortable: true, dataIndex:'TASK_CHK_RES_CODE'		 ,hidden : true}
								,{header:'타스크검토결과명'      ,width: 60, sortable: true, dataIndex:'TASK_CHK_RES_NAME'		 ,hidden : true}				                                                       
								,{header:'일정별담당자배정순번'      ,width: 60, sortable: true, dataIndex:'SCD_DUTY_SEQ'		 ,hidden : true}				                                                       
							   ];	

// 맵핑 필드
var	mappingColumns_edit_1st	= [  
								{name: "FLAG"               		 , type:"string", mapping:"FLAG"                	}  	    
								,{name: "SCD_DAY_SEQ"    		     , type:"string", mapping:"SCD_DAY_SEQ"    		    }	                                                     
								,{name: "PJT_NAME"                     , type:"string", mapping:"PJT_NAME"                  }                                                                                                                                      
								,{name: "TASK_CODE_NAME"               , type:"string", mapping:"TASK_CODE_NAME"            }                                        
								,{name: "SCD_SDATE"            	     , type:"string", mapping:"SCD_SDATE"            	}                                                   
								,{name: "SCD_TIME_FROM"              , type:"string", mapping:"SCD_TIME_FROM"           }                                             
								,{name: "SCD_EDATE"            	     , type:"string", mapping:"SCD_EDATE"            	}                                                
								,{name: "SCD_TIME_TO"                , type:"string", mapping:"SCD_TIME_TO"             }                                            
								,{name: "TASK_END_YN"			     , type:"string", mapping:"TASK_END_YN"			    }                                                      
								,{name: "TASK_END_YN_NM"			     , type:"string", mapping:"TASK_END_YN_NM"			    }                                                      
								,{name: "SCD_TYPE_CODE"              , type:"string", mapping:"SCD_TYPE_CODE"           } 
								,{name: "SCD_TYPE_CODE_NAME"           , type:"string", mapping:"SCD_TYPE_CODE_NAME"        }                                                                                      
								,{name: "PROC_TYPE_CODE"             , type:"string", mapping:"PROC_TYPE_CODE"          }                                                
								,{name: "PROC_TYPE_CODE_NAME"          , type:"string", mapping:"PROC_TYPE_CODE_NAME"       }                                                                                                                                         
								,{name: "SCD_DAY_REG_DEPT"           , type:"string", mapping:"SCD_DAY_REG_DEPT"        } 
								,{name: "SCD_DAY_REG_DEPT_NAME"        , type:"string", mapping:"SCD_DAY_REG_DEPT_NAME"     } 
								,{name: "SCD_DAY_REG_EMP_NUM"        , type:"string", mapping:"SCD_DAY_REG_EMP_NUM"     } 
								,{name: "SCD_DAY_REG_EMP_NUM_NAME"     , type:"string", mapping:"SCD_DAY_REG_EMP_NUM_NAME"  } 
								,{name: "STATUS_VAL"                 , type:"string", mapping:"STATUS_VAL"  			} 
								,{name: "STATUS_NAME"                  , type:"string", mapping:"STATUS_NAME"               }                                                                                      
								,{name: "WORK_PATTERN_CODE"          , type:"string", mapping:"WORK_PATTERN_CODE"       } 
								,{name: "WORK_PATTERN_CODE_NAME"       , type:"string", mapping:"WORK_PATTERN_CODE_NAME"    }                                                                                                                         
								,{name: "LABOR_COST"                 , type:"string", mapping:"LABOR_COST"              }                                                
								,{name: "PJT_ID"                     , type:"string", mapping:"PJT_ID"                  }                                          
								,{name: "TASK_GROUP_CODE"            , type:"string", mapping:"TASK_GROUP_CODE"         }                                                                                                                                 
								,{name: "TASK_GROUP_CODE_NAME"         , type:"string", mapping:"TASK_GROUP_CODE_NAME"      }                                    
								,{name: "TASK_CODE"                  , type:"string", mapping:"TASK_CODE"               }                                                                                                                                     
								,{name: "PAY_NO"                     , type:"string", mapping:"PAY_NO"                  }                                                
								,{name: "VISIT_REPORT_NO"            , type:"string", mapping:"VISIT_REPORT_NO"         }                                            
								,{name: "SCD_PROC_RES_CONTENT"       , type:"string", mapping:"SCD_PROC_RES_CONTENT"    }                                                
								,{name: "NOTE"                       , type:"string", mapping:"NOTE"                    }                                                
								,{name: "PJT_STATUS"				 , type:"string", mapping:"PJT_STATUS"				}                                                      
								,{name: "PJT_STATUS_NAME"              , type:"string", mapping:"PJT_STATUS_NAME"           }                                                                          
								,{name: "FINAL_MOD_ID"			     , type:"string", mapping:"FINAL_MOD_ID"			}                                                      
								,{name: "REG_ID"					 , type:"string", mapping:"REG_ID"					}                                                    
								,{name: "FINAL_MOD_DATE"			 , type:"string", mapping:"FINAL_MOD_DATE"			}                                                       
								,{name: "REG_DATE"                   , type:"string", mapping:"REG_DATE"                }                                                       
								,{name: "TASK_CHK_RES_CODE"		     , type:"string", mapping:"TASK_CHK_RES_CODE"		}                                                       
								,{name: "TASK_CHK_RES_NAME"		     , type:"string", mapping:"TASK_CHK_RES_NAME"		}                                                       
								,{name: "SCD_DUTY_SEQ"		     , type:"string", mapping:"SCD_DUTY_SEQ"		}                                                       
	    				 	  ]; 




/***************************************************************************
 * 설  명 : 에디트 그리드의 CELL을 클릭하였을 경우 이벤트
 ***************************************************************************/
function  fnEdit1stCellClickEvent(grid, rowIndex, columnIndex, e){
	

	var selRecord = grid.selModel.getSelections();

	Ext.get('scd_type_code_name').set({value : fnFixNull(selRecord[0].data.SCD_TYPE_CODE_NAME)}, false);	
	Ext.get('task_chk_res_code').set({value : fnFixNull(selRecord[0].data.TASK_CHK_RES_CODE)}, false);
	Ext.get('task_chk_res_name').set({value : fnFixNull(selRecord[0].data.TASK_CHK_RES_NAME)}, false);
	
	Ext.get('scd_sdate_tmp').set({value : fnFixNull(selRecord[0].data.SCD_SDATE)}, false);
	Ext.get('scd_time_from').set({value : fnFixNull(selRecord[0].data.SCD_TIME_FROM)}, false);
	Ext.get('scd_edate_tmp').set({value : fnFixNull(selRecord[0].data.SCD_EDATE)}, false);
	Ext.get('scd_time_to').set({value : fnFixNull(selRecord[0].data.SCD_TIME_TO)}, false);
	Ext.get('proc_type_code_name').set({value : fnFixNull(selRecord[0].data.PROC_TYPE_CODE_NAME)}, false);
	Ext.get('status_val').set({value : fnFixNull(selRecord[0].data.STATUS_VAL)}, false);
	Ext.get('work_pattern_code').set({value : fnFixNull(selRecord[0].data.WORK_PATTERN_CODE)}, false);
	Ext.get('pjt_id').set({value : fnFixNull(selRecord[0].data.PJT_ID)}, false);
	Ext.get('pjt_name').set({value : fnFixNull(selRecord[0].data.PJT_NAME)}, false);
	Ext.get('task_code_name').set({value : fnFixNull(selRecord[0].data.TASK_CODE_NAME)}, false);
	Ext.get('task_end_yn').set({value : fnFixNull(selRecord[0].data.TASK_END_YN)}, false);
	Ext.get('scd_proc_res_content').set({value : fnFixNull(selRecord[0].data.SCD_PROC_RES_CONTENT)}, false);

	Ext.get('scd_day_seq').set({value : fnFixNull(selRecord[0].data.SCD_DAY_SEQ)}, false);
	Ext.get('scd_type_code').set({value : fnFixNull(selRecord[0].data.SCD_TYPE_CODE)}, false);
	Ext.get('proc_type_code').set({value : fnFixNull(selRecord[0].data.PROC_TYPE_CODE)}, false);
	Ext.get('scd_day_reg_dept').set({value : fnFixNull(selRecord[0].data.SCD_DAY_REG_DEPT)}, false);
	Ext.get('scd_day_reg_emp_num').set({value : fnFixNull(selRecord[0].data.SCD_DAY_REG_EMP_NUM)}, false);
	
	Ext.get('task_group_code').set({value : fnFixNull(selRecord[0].data.TASK_GROUP_CODE)}, false);
	
	Ext.get('task_code').set({value : fnFixNull(selRecord[0].data.TASK_CODE)}, false);

	Ext.get('pjt_status').set({value : fnFixNull(selRecord[0].data.PJT_STATUS)}, false);

	Ext.get('scd_duty_seq').set({value : fnFixNull(selRecord[0].data.SCD_DUTY_SEQ)}, false);
	
	Ext.get('saved_task_end_yn').set({value : fnFixNull(selRecord[0].data.TASK_END_YN)}, false);
	
	Ext.get('note').set({value : fnFixNull(selRecord[0].data.NOTE)}, false);
	
	//파일조회
	 var mytable = document.getElementById("fileview_table");
	 
		Ext.Ajax.request({   
			url: "/dev/scdInfo/dayInfo/fileDel.sg"   
			,success: function(response){						// 조회결과 성공시

						// 조회된 결과값, store명
						var json = Ext.util.JSON.decode(response.responseText);

						var rowLength = mytable.rows.length;

						if(rowLength > 0)
						{
							for (var i=0; i<rowLength; i++) 
							{
								mytable.deleteRow(i);    
							}

						}

						for(var k=0; k < json.afterFileList.length; k++)
						{
							 var newRow = mytable.insertRow();
 							 var newCell_1 = newRow.insertCell();
 							 newCell_1.align = "center"
 							 
 							 var newCell_2 = newRow.insertCell();
 							 newCell_2.align = "left"
 							 newCell_2.width = "10%"
 							 newCell_2.className = "x-btn-mc" 							 
 								
 								newCell_1.innerHTML = "<a href='#' style='cursor:hand; text-decoration:none; color:blue; font-size:9pt;' onClick=\"downLoadFile('"+ json.afterFileList[k].SCD_EXEC_PRPD_SEQ +"');\">"+json.afterFileList[k].PROD_FILE_NAME+"</a>";
 								newCell_2.innerHTML = "<button type='button' id='deleteFileBtn' name='deleteFileBtn' onClick=\"delFile('" + json.afterFileList[k].SCD_EXEC_PRPD_SEQ + "', '" + json.afterFileList[k].SCD_DAY_SEQ + "');\" class='x-btn-text' >삭제</button>";
						}
				
						if(json.afterFileList.length > 0)						
						{
							document.getElementById('dynamic_tr').style.display = 'none'; 
							document.getElementById('fileview_tr').style.display = 'block'; 
						}else
						{
							document.getElementById('dynamic_tr').style.display = 'block'; 
							document.getElementById('fileview_tr').style.display = 'none'; 
						}
						
			          }
			,failure: handleFailure   	    // 조회결과 실패시  
			,params : { 
					   start         : 0
					  ,limit         : 5
					  ,scd_exec_prpd_seq : ''
					  ,scd_day_seq : Ext.get('scd_day_seq').getValue()
					  ,delYn : 'N'
				      } 
		});


		// 버튼 disable
	Ext.get('saveBtn').dom.disabled   = true;
	Ext.get('updateBtn').dom.disabled = false;	
}


/***************************************************************************
 * 설  명 : 에디트 그리드 데이타가 없을때 오늘일정의 데이타를 가져온다.
 ***************************************************************************/
function  fnEdit1stSrchAfterSetDetailForm(){
	
	var dForm = document.detailForm;		// 상세 FORM	
	
	dForm.reset();							// 상세필드 초기화

	 var toDay = getTimeStamp().trim();
	Ext.get('scd_sdate_tmp').set({value:toDay} , false);
	Ext.get('scd_edate_tmp').set({value:toDay} , false);	
	
	var selRecord = GridClass_1st.grid.selModel.getSelections(); 
    
    Ext.get('scd_type_code_name').set({value : fnFixNull(selRecord[0].data.SCD_TYPE_NAME)}, false);			
    
    Ext.get('scd_plan_from_date').set({value : fnFixNull(selRecord[0].data.SCD_PLAN_FROM_DATE)}, false);			
    Ext.get('scd_plan_to_date').set({value : fnFixNull(selRecord[0].data.SCD_PLAN_TO_DATE)}, false);			
	

	//Ext.get('proc_type_code_name').set({value : fnFixNull(selRecord[0].data.PROC_TYPE_NAME)}, false);			//계획수행구분코드명
	
	dForm.proc_type_code_name.value = fnFixNull(selRecord[0].data.PROC_TYPE_NAME);

	
	Ext.get('status_val').set({value : fnFixNull(selRecord[0].data.STATUS_VAL)}, false);
	Ext.get('work_pattern_code').set({value : fnFixNull(selRecord[0].data.WORK_PATTERN_CODE)}, false);
	Ext.get('pjt_id').set({value : fnFixNull(selRecord[0].data.PJT_ID)}, false);
	Ext.get('pjt_name').set({value : fnFixNull(selRecord[0].data.PJT_NAME)}, false);
	Ext.get('task_code_name').set({value : fnFixNull(selRecord[0].data.TASK_NAME)}, false);
	Ext.get('task_end_yn').set({value : fnFixNull(selRecord[0].data.TASK_END_YN)}, false);
	Ext.get('scd_proc_res_content').set({value : ''}, false);

	Ext.get('scd_day_seq').set({value : fnFixNull(selRecord[0].data.SCD_DAY_SEQ)}, false);
	Ext.get('scd_type_code').set({value : fnFixNull(selRecord[0].data.SCD_TYPE_CODE)}, false);
	Ext.get('proc_type_code').set({value : fnFixNull(selRecord[0].data.PROC_TYPE_CODE)}, false);
	Ext.get('scd_day_reg_dept').set({value : ''}, false);
	
	Ext.get('task_group_code').set({value : fnFixNull(selRecord[0].data.TASK_GROUP_CODE)}, false);
	Ext.get('task_code').set({value : fnFixNull(selRecord[0].data.TASK_CODE)}, false);
	Ext.get('task_duty_dept_code').set({value : ''}, false);
	Ext.get('task_duty_emp_num').set({value : ''}, false);
	Ext.get('pjt_status').set({value : fnFixNull(selRecord[0].data.PJT_STATUS)}, false);

	Ext.get('scd_duty_seq').set({value : fnFixNull(selRecord[0].data.SCD_DUTY_SEQ)}, false);
	
	Ext.get('saved_task_end_yn').set({value : fnFixNull(selRecord[0].data.TASK_END_YN)}, false);
	
	
	
	
	// 버튼 disable
	Ext.get('saveBtn').dom.disabled   = false;
	Ext.get('updateBtn').dom.disabled = true;	
		
	
}




/***************************************************************************
 * 설  명 : 에디트 그리드의 CELL을 수정하였을 경우 이벤트
 ***************************************************************************/
function  fnEdit1stAfterCellEdit(obj){
	var rowCnt = GridClass_edit_1st.store.getCount();  // Grid의 총갯수
	var totalATM = 0;
	var editedRow = obj.row;
	var editedColumn = obj.column;
	var editedValue = obj.value;
	var fieldName = obj.field;
	

}

function fnEdit1stAfterRowDeleteEvent(){
	var rowCnt = GridClass_edit_1st.store.getCount();  // Grid의 총갯수
	var totalATM = 0;
	
}


/** 서버스펙 EditGrid - edit_1st End**/


/***************************************************************************
 * 설  명 : 필드 초기화
 **************************************************************************/
function fnInitValue(){

	var dForm = document.detailForm;		// 상세 FORM	
	
	dForm.reset();							// 상세필드 초기화

	 var toDay = getTimeStamp().trim();
	Ext.get('scd_sdate_tmp').set({value:toDay} , false);
	Ext.get('scd_edate_tmp').set({value:toDay} , false);
	
	

	
	try{
		//GridClass_edit_1st.store.commitChanges();	// 변경된 record를 commit
		//GridClass_edit_1st.store.removeAll();		// store자료를 삭제
		
		var mytable = document.getElementById("fileview_table");

		var rowLength = mytable.rows.length;

		if(rowLength > 0)
		{
			for (var i=0; i<rowLength; i++) 
			{
				mytable.deleteRow(i);    
			}
		}		
		
		document.getElementById('dynamic_tr').style.display = 'block'; 
		document.getElementById('fileview_tr').style.display = 'none'; 		
		

	}catch(e){
		//alert(e.message);
	}
	
	// 버튼 disable
	Ext.get('saveBtn').dom.disabled   = false;
	Ext.get('updateBtn').dom.disabled = true;	
}

/***************************************************************************
 * 설  명 : 검색
 **************************************************************************/
function fnSearch(){  	


	var sForm = document.searchForm;

	sForm.src_csr_date_from.value = sForm.src_csr_date_from_tmp.value.replaceAll('-','');	   	 
	sForm.src_csr_date_to.value = sForm.src_csr_date_to_tmp.value.replaceAll('-','');	


   if(parseInt(sForm.src_csr_date_from.value) > parseInt(sForm.src_csr_date_to.value)) {
       	 Ext.Msg.alert('확인', '시작일이 종료일보다 큽니다.');
       	 return false;
    }

	
	Ext.Ajax.request({   
		url: "/dev/scdInfo/dayInfo/result.sg"
		,method : 'POST'   
		,success: function(response){						// 조회결과 성공시
					// 조회된 결과값, store명
					handleSuccess(response,GridClass_1st);
					
					fnInitValue(); // 상세필드 초기화
		          }
		,failure: handleFailure   	   // 조회결과 실패시  
		,form   : document.searchForm  // 검색 FORM
		,params : {					   // 조회조건을 DB로 전송하기위해서 조건값 설정
					limit          : limit_1st
				  , start          : start_1st
				  }				
	});  
	

}  		


/***************************************************************************
 * 설  명 :일정등록 상세검색
 **************************************************************************/
function fnEditGridListSearch(store, rowIndex){  	
		

	Ext.Ajax.request({   
		url: "/dev/scdInfo/dayInfo/all_result_1st.sg"
		,method : 'POST'   
		,success: function(response){						// 조회결과 성공시
					// 조회된 결과값, store명
					//handleSuccess(response,GridClass_edit_1st);
					var jsoneRspons = Ext.util.JSON.decode(response.responseText);
					
					GridClass_edit_1st.store.commitChanges();	// 변경된 record를 commit
					GridClass_edit_1st.store.removeAll();		// store자료를 삭제
						
					GridClass_edit_1st.store.loadData(jsoneRspons);					

		          }
		,failure: handleFailure   	   // 조회결과 실패시  
		,form   : document.searchForm  // 검색 FORM
		,params : {					   // 조회조건을 DB로 전송하기위해서 조건값 설정
					limit           : limit_edit_1st
				  , start           : start_edit_1st
				  , src_scd_duty_seq : fnFixNull(store.getAt(rowIndex).data.SCD_DUTY_SEQ)	// 일정별담당자배정 순번
				  }				
	});  
	
}


/***************************************************************************
 * 설  명 :일정등록 상세검색
 **************************************************************************/
function fnEditGridListSearch2(srcScdDutySeq){  	
		

	Ext.Ajax.request({   
		url: "/dev/scdInfo/dayInfo/all_result_1st.sg"
		,method : 'POST'   
		,success: function(response){						// 조회결과 성공시
					// 조회된 결과값, store명
					//handleSuccess(response,GridClass_edit_1st);


					var jsoneRspons = Ext.util.JSON.decode(response.responseText);
					
					GridClass_edit_1st.store.commitChanges();	// 변경된 record를 commit
					GridClass_edit_1st.store.removeAll();		// store자료를 삭제
						
					GridClass_edit_1st.store.loadData(jsoneRspons);					

		          }
		,failure: handleFailure   	   // 조회결과 실패시  
		,form   : document.searchForm  // 검색 FORM
		,params : {					   // 조회조건을 DB로 전송하기위해서 조건값 설정
					limit           : limit_edit_1st
				  , start           : start_edit_1st
				  , src_scd_duty_seq : srcScdDutySeq	// 일정별담당자배정 순번
				  }				
	});  
	
}




/***************************************************************************
 * 설  명 : 저장버튼 클릭
 ***************************************************************************/
function fnSave(){  	

	var sForm = document.searchForm;	// 검색 FORM
	var dForm = document.detailForm;	// 상세 FORM


	// 변경된 Gride의 record
	var records = GridClass_edit_1st.store.getModifiedRecords();	  	// 변경된 record의 자료를 json형식으로
	var modifyLen = records.length;
    
	dForm.scd_sdate.value = dForm.scd_sdate_tmp.value.replaceAll('-','');		   	 
	dForm.scd_edate.value = dForm.scd_edate_tmp.value.replaceAll('-','');	
    
	var scd_time_from = dForm.scd_time_from.value.replaceAll(':','');		
	var scd_time_to = dForm.scd_time_to.value.replaceAll(':','');		







    if(dForm.task_code.value == ""){
       	 Ext.Msg.alert('확인', '타스크를 선택하십시오.');
       	 return false;
    }


	var toDay = getTimeStamp(); 
	toDay = toDay.replaceAll('-','');
	
	var scdPlanToDate = (Ext.get('scd_plan_to_date').getValue()).replaceAll('-','');
	

	if(dForm.task_chk_res_code.value !='30')
	{
	    if(parseInt(toDay) > parseInt(scdPlanToDate)) {
	       	 Ext.Msg.alert('확인', '종료일이 지났습니다.'); 
	       	 return false;
	    }	
	}
  

    if(scd_time_from =="0000") {
       	 Ext.Msg.alert('확인', '시작일시를 입력하십시오.');
       	 return false;
    }
    
    if(scd_time_to =="0000") {
       	 Ext.Msg.alert('확인', '종료일시를 입력하십시오.');
       	 return false;
    }
            
    
    if(parseInt(scd_time_from) > parseInt(scd_time_to)) {
       	 Ext.Msg.alert('확인', '시작일이 종료일보다 큽니다.');
       	 return false;
    }
        
    
    
    if(dForm.saved_task_end_yn.value == "Y"){
       	 Ext.Msg.alert('확인', '타스크가 완료되었습니다.');
       	 return false;
    }
    
//alert("11-uploaddata_0-->"+dForm.uploaddata_0.value);
//alert("filesize-->["+filesize+"]-::-["+dForm.task_end_yn.value+"]"); 	
	
    if(dForm.task_end_yn.value == 'Y' ) {
       	
       	var mytable = document.getElementById("fileview_table");

		var rowLength = mytable.rows.length;

		if(rowLength == 0 && dForm.uploaddata_0.value == '')
		{
       	 Ext.Msg.alert('확인', '타스크완료시 산출물을 등록하십시오.');
       	 return false;
		}		

    }	
	
	var selRecord  = GridClass_1st.grid.selModel.getSelections();
	
	var selRecord_edit_1st  = GridClass_edit_1st.grid.selModel.getSelections();	
	
	var srchScdDutySeq = Ext.get('scd_duty_seq').getValue();

//alert("--modifyLen---"+modifyLen);
	    var cnt = GridClass_edit_1st.store.getCount();		// Grid의 총갯수
	     
		Ext.Ajax.request({   
			url: "/dev/scdInfo/dayInfo/actionSchedule.sg"   
			,success: function(response){						// 조회결과 성공시
						// 조회된 결과값, store명

						var json = Ext.util.JSON.decode(response.responseText);

						if(json.success =="false")						
						{
							Ext.Msg.alert('확인', json.message);
							fnInitValue();
							return;
						}						

						if(json.task_end_yn_cnt > 0)						
						{
							Ext.Msg.alert('확인', '이미 타스크가 완료되었습니다.')
							return;
						}
				
						handleSuccess(response,GridClass_1st,'save');
											
						fnEditGridListSearch2(srchScdDutySeq);
			          }
			,failure: handleFailure   	    // 조회결과 실패시  
			,form   : document.detailForm   // 상세 FORM
			,params : { 
					   limit          : limit_1st
					  , start          : start_1st
					  ,src_csr_date_from : sForm.src_csr_date_from.value
					  ,src_csr_date_to : sForm.src_csr_date_to.value	
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
		
		Ext.get('src_csr_date_from_tmp').set({value : fromDay}, false);				//프로젝트 기간 from
		Ext.get('src_csr_date_to_tmp').set({value:toDay} , false);      
		
	});	
		
/*			
	//신규 버튼 -> 상세필드 초기화
	Ext.get('detailClearBtn').on('click', function(e){
		fnInitValue();		   
	});		
*/	
			
	//등록 버튼 -> 데이터를 server로 전송
	Ext.get('saveBtn').on('click', function(e){	
		if(Validator.validate(dForm)){
			
			Ext.MessageBox.confirm('Confirm', '등록하시겠습니까?', showResult);
		};
	});

	
	//수정 버튼 -> 데이터를 server로 전송

	Ext.get('updateBtn').on('click', function(e){	
		if(Validator.validate(dForm)){
			Ext.MessageBox.confirm('Confirm', '수정하시겠습니까?', showResult);
		};	
	});

	

	
	// 조회일정기간 from
	var srFrmdt = new Ext.form.DateField({
	    	applyTo: 'src_csr_date_from_tmp',
			allowBlank: false,
			format:'Y-m-d',
			editable : true,
			value : fromDay
	});
	
	Ext.get('src_csr_date_from_tmp').on('change', function(e){	
		
		var val = Ext.get('src_csr_date_from_tmp').getValue();
		var reVal = fnGridDateCheck(val);
		
		Ext.get('src_csr_date_from_tmp').set({value:reVal} , false);
	});
	
	

	// 조회일정기간 to
	var srTomdt = new Ext.form.DateField({
	    	applyTo: 'src_csr_date_to_tmp',
			allowBlank: false,
			format:'Y-m-d',
			editable : true,
			value : toDay
	});
	
	Ext.get('src_csr_date_to_tmp').on('change', function(e){	
		
		var val = Ext.get('src_csr_date_to_tmp').getValue();
		var reVal = fnGridDateCheck(val);
		
		Ext.get('src_csr_date_to_tmp').set({value:reVal} , false);
	});
	
		


/*	 
	// 기간 from
	var sdatedt = new Ext.form.DateField({
	    	applyTo: 'scd_sdate_tmp',
			allowBlank: false,
			format:'Y-m-d',
			editable : false,
			value : toDay
	});
	
	
	// 기간 to
	var edatedt = new Ext.form.DateField({
	    	applyTo: 'scd_edate_tmp',
			allowBlank: false,
			format:'Y-m-d',
			editable : false,
			value : toDay
	});
*/		
	
    fnInitValue();
});

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
  var sFeatures = "titlebar=no, scrollbars=yes,location=no ,menubar=no, resizable=yes, status=yes, width="+dlgWidth+",height="+dlgHeight+",left="+xPos+", top="+yPos;
  window.open(sURL,winName, sFeatures);
}



/***************************************************************************
 * 설  명 : 파일다운로드
 ***************************************************************************/
function downLoadFile(scdExecPrpdSeq){  	

	var dForm = document.detailForm;	// 상세 FORM
	
	dForm.action="/download.ddo?fid=scdInfofile&scd_exec_prpd_seq="+scdExecPrpdSeq;
    
    dForm.submit();
 
}  	



/***************************************************************************
 * 설  명 : 파일삭제
 ***************************************************************************/
function delFile(scdExecPrpdSeq, scdDaySeq){  	

	delScdExecPrpdSeq = scdExecPrpdSeq;	//일정수행산출물순번
	delScdDaySeq = scdDaySeq;	//일정관리순번
	
	Ext.MessageBox.confirm('Confirm', '삭제하시겠습니까?', delFile2);
 
} 

function delFile2(btn){  	

	
	if(btn != 'yes'){
		delScdExecPrpdSeq = "";
   		return;
   	} 	
	


	 var mytable = document.getElementById("fileview_table");
	 

		Ext.Ajax.request({   
			url: "/dev/scdInfo/dayInfo/fileDel.sg"   
			,success: function(response){						// 조회결과 성공시

						// 조회된 결과값, store명
						var json = Ext.util.JSON.decode(response.responseText);

/*
						for(var i = document.detailForm.elements['deleteFileBtn'].length - 1; i >= 0; i--)
						{				
								mytable.deleteRow(i);
						}
*/						

						for(var k=0; k < json.afterFileList.length; k++)
						{
							 var newRow = mytable.insertRow();
 							 var newCell_1 = newRow.insertCell();
 							 newCell_1.align = "center"
 							 
 							 var newCell_2 = newRow.insertCell();
 							 newCell_2.align = "left"
 							 newCell_2.width = "10%"
 							 newCell_2.className = "x-btn-mc" 							 
 								
 								newCell_1.innerHTML = "<a href='#' style='cursor:hand; text-decoration:none; color:blue; font-size:9pt;' onClick=\"downLoadFile('"+ json.afterFileList[k].SCD_EXEC_PRPD_SEQ +"');\">"+json.afterFileList[k].PROD_FILE_NAME+"</a>";
 								newCell_2.innerHTML = "<button type='button' id='deleteFileBtn' name='deleteFileBtn' onClick=\"delFile('" + json.afterFileList[k].SCD_EXEC_PRPD_SEQ + "', '" + json.afterFileList[k].SCD_DAY_SEQ + "');\" class='x-btn-text' >삭제</button>";
						}						

			          }
			,failure: handleFailure   	    // 조회결과 실패시  
			,params : { 
					   start         : 0
					  ,limit         : 5
					  ,scd_exec_prpd_seq : delScdExecPrpdSeq
					  ,scd_day_seq : delScdDaySeq
					  ,delYn :'Y'
				      } 
		});

		document.getElementById('dynamic_tr').style.display = 'block'; 
		document.getElementById('fileview_tr').style.display = 'none';     
 
}



function getFileSize(path)
{
	 var maxSize = 5000000; //5M
	 var img = new Image();
	 img.dynsrc = path;
	 filesize = img.fileSize;
	 
	 //alert(filesize); 
	 /*
	 if(filesize > maxSize) {
	 	alert("파일용량이 초과되었습니다.");
	 }
	 */
}

</script>

</head>
<body>
	<table border="0" width="1000" height="200">
		<tr>
			<td colspan="2">
				<form name="searchForm">
				<input type="hidden" id="src_csr_date_from" name="src_csr_date_from"  />
				<input type="hidden" id="src_csr_date_to" name="src_csr_date_to"  />
				<input type="hidden" id="src_csr_dept_code" name="src_csr_dept_code"  />				<!-- 부서코드-->
				
				<!----------------- SEARCH Hearder Start	 ----------------->
				<div id="ext-comp-1002" class="x-panel x-form-label-left" style="margin-top: 0.4em;"><%-- 0em <- 1em으로 수정하면 상위 공백 --%>
					<div class="x-panel-tl">
						<div class="x-panel-tr">
							<div class="x-panel-tc">
								<div id="ext-gen4" class="x-panel-header x-unselectable" style="-moz-user-select: none;">
									<span id="ext-gen8" class="x-panel-header-text">업무요청정보 검색</span>
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
										
										<td width="18px">
											<div tabindex="-1" class="x-form-item " >
												<label class="x-form-item-label"  for="src_csr_date_from_tmp" >기간 :</label>
											</div>
										</td>										


										<td width="103px" align="left">
											<div tabindex="-1" class="x-form-item " >
													<table border="0" width="100%" >
														<tr>
															<td align="center">
																<input type="text" name="src_csr_date_from_tmp" id="src_csr_date_from_tmp"  style="width:80px; " >
															</td>
															<td align="left">~</td>
														    <td align="center">
																<input type="text" name="src_csr_date_to_tmp" id="src_csr_date_to_tmp"  style="width:80px;" >
															</td>
														</tr>
													</table>
											</div>
										</td>

									
									<%-- 1 Row End --%>
									<%-- 2 Row 버튼 Start --%>
									<tr align="right">
										<td colspan="5">
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
			<td width="100%" valign="top">
				<div id="task-grid" style="margin-top: 0.4em;"></div> <!----------------- 그리드명을 동일하게 설정 ----------------->		
			</td>
		
		</tr>
		
		<tr>
			<td width="100%" valign="top" colspan="2">
				<div id="scd_day_info_grid" style="margin-top: 0.4em;"></div> <!----------------- 그리드명을 동일하게 설정 ----------------->
			</td>
		</tr>
		
	  <tr>
			<!------------------------------ GRID END ------------------------------------>
			<td width="100%" valign="top">
				<div class="x-panel x-form-label-left" style="margin-top: 0.4em; width: 100%;"><%-- 0em <- 1em으로 수정하면 상위 공백 --%>
					<!----------------- SEARCH Hearder Start	 ----------------->
					<div class="x-panel-tl">
						<div class="x-panel-tr">
							<div class="x-panel-tc">
								<div class="x-panel-header x-unselectable" style="-moz-user-select: none;">
									<span class="x-panel-header-text">업무요청 기본정보</span><!----------------- 이름변경 ----------------->		
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

									<form id="detailForm" name="detailForm" method="POST" enctype="multipart/form-data" class="x-panel-body x-form" style="padding: 1px 1px 0pt; ">
								
									<input type="hidden" id="flag" name="flag"/>
									<input type="hidden" id="scd_day_seq" name="scd_day_seq"/>
									
									<input type="hidden" id="scd_plan_from_date" name="scd_plan_from_date"/>
									<input type="hidden" id="scd_plan_to_date" name="scd_plan_to_date"/>
									
									<input type="hidden" id="scd_type_code" name="scd_type_code"/>
									<input type="hidden" id="proc_type_code" name="proc_type_code"/>
									<input type="hidden" id="scd_day_reg_dept" name="scd_day_reg_dept"/>
									<input type="hidden" id="scd_day_reg_emp_num" name="scd_day_reg_emp_num"/>
									
									<input type="hidden" id="task_group_code" name="task_group_code"/>
									<input type="hidden" id="task_code" name="task_code"/>
									
									<input type="hidden" id="task_duty_dept_code" name="task_duty_dept_code"/>
									<input type="hidden" id="task_duty_emp_num" name="task_duty_emp_num"/>
									<input type="hidden" id="pjt_status" name="pjt_status"/>
									<input type="hidden" id="task_chk_res_code" name="task_chk_res_code"/>
									<input type="hidden" id="scd_duty_seq" name="scd_duty_seq"/>
									
									<input type="hidden" id="scd_sdate" name="scd_sdate"/>
									<input type="hidden" id="scd_edate" name="scd_edate"/>
									
									<input type="hidden" id="saved_task_end_yn" name="saved_task_end_yn"/>
									
									<input type="hidden" id="status_val" name="status_val"/>
									
	
									<!-- 2_ROW Start -->
									<div class="x-column-inner" style="width: 100%; margin-top: 0.2em;">
										<div class=" x-panel x-column" style="width: 50%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label class="x-form-item-label" style="width: 105px;" for="scd_type_code_name" ><font color="red">* </font>업무구분:</label>
														<div style="padding-left: 80px;" class="x-form-element">
															<input type="text" name="scd_type_code_name" id="scd_type_code_name" autocomplete="off" size="19" class=" x-form-text x-form-field" style="width: auto;" readonly="true">
														</div>
														<div class="x-form-clear-left">
														</div>
													</div>
												</div>
											</div>
										</div>
										
										<div class="x-panel x-column" style="width: 14%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label class="x-form-item-label" style="width: 50px;" for="scd_sdate_tmp" ><font color="red">* </font>일시 :</label>
															<input type="text" name="scd_sdate_tmp" id="scd_sdate_tmp" autocomplete="off" size="11" class=" x-form-text x-form-field" style="width: auto;" readOnly >
													</div>
												</div>
											</div>
										</div>
										
										<div class="x-panel x-column" style="width: 7%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item" >
													<select name="scd_time_from" id="scd_time_from" title="시작시간" style="width: 58px;" type="text" class=" x-form-select x-form-field" >
															<c:forEach var="list" items="<%= hhmm %>">
																<option value="${list}"><c:out value="${list}"/></option>
															</c:forEach>
													</select>
													</div>
												</div>
											</div>
										</div>
																
										<div class="x-panel x-column" style="width: 9%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
															<input type="text" name="scd_edate_tmp" id="scd_edate_tmp" autocomplete="off" size="11" class=" x-form-text x-form-field" style="width: auto;" readOnly >
													</div>
												</div>
											</div>
										</div>	
										
										<div class="x-panel x-column" style="width: 6%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<select name="scd_time_to" id="scd_time_to" title="종료시간" style="width: 58px;" type="text" class=" x-form-select x-form-field" >
															<c:forEach var="list" items="<%= hhmm %>">
																<option value="${list}"><c:out value="${list}"/></option>
															</c:forEach>														
														</select>
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
														<label class="x-form-item-label" style="width: 105px;" for="proc_type_code_name" ><font color="red">* </font>계획/수행구분:</label>
														<div style="padding-left: 80px;" class="x-form-element">
															<input type="text" name="proc_type_code_name" id="date-range" autocomplete="off" size="19" class=" x-form-text x-form-field" style="width: auto;" readonly="true">
														</div>
														<div class="x-form-clear-left">
														</div>
													</div>
												</div>
											</div>
										</div>
										
										<div class="x-panel x-column" style="width: 50%;" >
											
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label class="x-form-item-label" style="width: 70px;" for="task_chk_res_name" >&nbsp;&nbsp;&nbsp;검토결과:</label>
															<div style="padding-left: 90px;" class="x-form-element">
																<table style="width: 250px;" cellspacing="0" class="x-btn  x-btn-noicon">
																	<tr>
																		<td>
																			<input type="text" name="task_chk_res_name" id="task_chk_res_name" autocomplete="off" size="10" class=" x-form-text x-form-field" style="width: auto;" readOnly >
																			<input type="text" name="note" id="note" autocomplete="off" size="30" class=" x-form-text x-form-field" style="width: auto;" readOnly >
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
									<!-- 3_ROW End -->
									
									<!-- 4_ROW Start -->
									<div class="x-column-inner" style="width: 100%;">
										<div class=" x-panel x-column" style="width: 50%;">
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label class="x-form-item-label" style="width: 105px;" for="work_pattern_code" ><font color="red">* </font>내근/외근구분:</label>
														<div style="padding-left: 90px;" class="x-form-element">
															<select name="work_pattern_code" id="work_pattern_code" title="내근/외근구분" style="width: 110px;" type="text" class=" x-form-select x-form-field" >
																<option value="">선택하세요</option>
																<c:forEach items="${WORK_TYPE_CODE}" var="data" varStatus="status">
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
										<div class="x-panel x-column" style="width: 50%;" >
											<div class="x-panel-bwrap" >
												<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
													<div tabindex="-1" class="x-form-item " >
														<label class="x-form-item-label" style="width: 70px;" for="pjt_id" ><font color="red">* </font>프로젝트:</label>
														<div style="padding-left: 90px;" class="x-form-element">
															<table style="width: 250px;" cellspacing="0" class="x-btn  x-btn-noicon">
																<tr>
																	<td>
																		<input type="text" name="pjt_id" id="pjt_id" autocomplete="off" size="20" class=" x-form-text x-form-field" style="width: auto;" readOnly >
																		<input type="text" name="pjt_name" id="pjt_name" autocomplete="off" size="19" class=" x-form-text x-form-field" style="width: auto;" readOnly >
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
															<label class="x-form-item-label" style="width: 105px;" for="task_code_name" ><font color="red">* </font>타스크:</label>
															<div style="padding-left: 90px;" class="x-form-element">
																<table style="width: 150px;" cellspacing="0" class="x-btn  x-btn-noicon">
																	<tr>
																		<td>
																			<input type="text" name="task_code_name" id="task_code_name" autocomplete="off" size="19" class=" x-form-text x-form-field" style="width: auto;" readonly="true">
	
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
											
											<div class="x-panel x-column" style="width: 50%;">
												<div class="x-panel-bwrap" >
													<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
														<div tabindex="-1" class="x-form-item " >
															<label class="x-form-item-label" style="width: 110px;" for="task_end_yn" ><font color="red">* </font>타스크 완료여부:</label>
																<select name="task_end_yn" id="task_end_yn" title="타스크 완료여부" style="width: 110px;" type="text" class=" x-form-select x-form-field" >
																	<option value="Y" selected >완료</option>
																	<option value="N">미완료</option>
																</select>
														</div>
													</div>
												</div>
											</div>										
										</div>
										<!-- 5_ROW End -->		
										
										<!-- 6_ROW Start -->
										<div class="x-column-inner" style="width: 100%;">
											<div class=" x-panel x-column" style="width: 100%;">
												<div class="x-panel-bwrap" >
													<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
														<div tabindex="-1" class="x-form-item " >
															<label class="x-form-item-label" style="width: 105px;" for="scd_proc_res_content" >&nbsp;&nbsp;&nbsp;업무내용:</label>
															<div style="padding-left: 80px;" class="x-form-element">
																<input type="text" name="scd_proc_res_content" id="scd_proc_res_content" autocomplete="off" size="80" class=" x-form-text x-form-field"  maxlength="500" >
															</div>
															<div class="x-form-clear-left">
															</div>
														</div>
													</div>
												</div>
											</div>
										</div>
										<!-- 6_ROW End -->
										<!--7_ROW Start -->
										
										<div class="x-column-inner" style="width: 100%;">
											<div class=" x-panel x-column" style="width: 100%;">
												<div class="x-panel-bwrap" >
													<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
														<div tabindex="-1" class="x-form-item " >
															<label class="x-form-item-label" style="width: 105px;" for="scd_proc_res_content" ><font color="red">* </font>첨부파일:</label>
																<div style="padding-left: 80px;" class="x-form-element">
																	<table border="0"  cellspacing="0" class="x-btn  x-btn-noicon" style="width: 255px;" align="left">
																		<tbody class="x-btn-small x-btn-icon-small-left">
																			<!--
																			<tr>
																				<td width="5%">
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
																										<button type="button" id="addfieldBtn" name="addfieldBtn"  class=" x-btn-text">추가</button>
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
																				
																				<td width="95%">
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
																										<button type="button" id="delfieldBtn" name="delfieldBtn" class=" x-btn-text">삭제</button>
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
																		-->
																		    <tr align="left" height="25" id="fileview_tr" style="display:none"> 
																			     <td >
																					<table width="100%" cellpadding=0 cellspacing=0 id="fileview_table" >
																					</table>
																				 </td>
																		    </tr>
																		     																			
																		    <tr align="center" height="25" id="dynamic_tr"> 
																		    	<td>
																			     	<table width="100%" cellpadding=0 cellspacing=0 id="dynamic_table" border="0">
																						<tr>
																							<td>
																							    <!-- <input type=checkbox id=checkList name=checkList value="0" size=40 > -->
																									<input type=file name='uploaddata_0' id='uploaddata_0' size=60  >
																								<!--	<input type=file name='uploaddata_1' id='uploaddata_1' size=40  >-->
																							</td>
																						</tr>
																					</table>
																		     	</td>
																		    </tr>													
																		</tbody>
																	</table>
																</div>
																<div class="x-form-clear-left">
																</div>
														</div>
													</div>
												</div>
											</div>
										</div>
		
										<!-- 7_ROW End -->		
   									<iframe name="fileFrame" id="fileFrame" style="display:none; position:absolute; left:0; top:0; width:0; height:0" FrameBorder="0"></iframe>																		
									</form>

								</div>
							</div>
						</div>
					</div>
				</div>
				<!----------------- DETAIL Field End	 ----------------->
			</td>

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
					</tr>
				</table>
			</td>
		</tr>
	</table>
</body>

</html>
