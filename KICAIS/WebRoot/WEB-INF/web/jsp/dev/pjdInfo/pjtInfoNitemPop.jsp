<%--
  Class Name  : pjtInfoNitemPop.jsp
  Description : 프로젝트조회 팝업
  Modification Information
 
      수정일                수정자                 수정내용
  -------      --------    ---------------------------
  2011. 3. 8.  이준영              최초 생성
 
  author   : 이준영
  since    : 2011. 4. 11.
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
<!-- EXTJS CSS -->
<link rel="stylesheet" type="text/css" href="/resource/common/js/ext3/resources/css/ext-all.css" />
 
<!-- EXTJS SCRIPT  -->
<script type="text/javascript" src="/resource/common/js/ext3/adapter/ext/ext-base.js"></script>
<script type="text/javascript" src="/resource/common/js/ext3/ext-all-debug.js"></script>
<script type="text/javascript" src="/resource/common/js/ext3/src/locale/ext-lang-ko.js" charset="utf-8"></script>

<!-- EXTJS APP SCRIPT -->
<script type="text/javascript" src="/resource/common/js/common/App.js"></script>
<script type="text/javascript" src="/resource/common/js/grid/pop_grid_1st.js"></script>
<%
	String multiSelectYn = request.getParameter("multiSelectYn");	// 여러건 선택가능 여부
%>
<script type="text/javascript">

/***************************************************************************
 * 초기값 설정
 ***************************************************************************/
var	gridHeigth_1st_pop 	 	= 290; 								  // 그리드 전체 높이
var	gridWidth_1st_pop		= 640;								  // 그리드 전체 폭
var gridTitle_1st_pop 		= "프로젝트정보";	  				      // 그리드 제목
var	render_1st_pop			= "user-grid";	        			  // 렌더(화면에 그려질) 할 id 
var	pageSize_1st_pop		= 99999999;	  							  // 그리드 페이지 사이즈	
var	proxyUrl_1st_pop		= "/dev/pjdInfo/pjtInfoNitemPopList.sg"; // 결과 값 페이지
var limit_1st_pop			= pageSize_1st_pop;
var start_1st_pop			= 0;

/***************************************************************************
 * Grid의 컬럼 설정
 ***************************************************************************/
var userColumns_1st_pop =  [
								checkSm
							   ,{header: '조회상태'                 ,width: 60  ,sortable: true ,dataIndex: 'FLAG'                      ,hidden : true}              
							   , {header: '품목코드'               ,width: 60  ,sortable: true ,dataIndex: 'ITEM_CODE'                   ,hidden : true }              
							   , {header: '품목명'          ,width: 120  ,sortable: true ,dataIndex: 'ITEM_NAME'             }
							   , {header: '프로젝트ID'         ,width: 60  ,sortable: true ,dataIndex: 'PJT_ID'             ,hidden : true}               
							   , {header: '프로젝트명'               ,width: 100  ,sortable: true ,dataIndex: 'PJT_NAME'                  }              
							   , {header: '업무요청ID'                 ,width: 65  ,sortable: true ,dataIndex: 'CSR_ID'              }
							   , {header: '업무요청순번'        ,width: 60  ,sortable: true ,dataIndex: 'CSR_INFO_SEQ'             ,hidden : true}
							   , {header: '요청제목'          ,width: 95  ,sortable: true ,dataIndex: 'CSR_TITLE'               }              
							   , {header: '업무요청유형코드'   ,width: 60  ,sortable: true ,dataIndex: 'CSR_TYPE_CODE'         ,hidden : true}              
							   , {header: '업무요청구분명'       ,width: 60  ,sortable: true ,dataIndex: 'CSR_TYPE_NAME'           ,hidden : true}
							   , {header: 'rowspan 수'   ,width: 60  ,sortable: true ,dataIndex: 'ROWCNT'         ,hidden : true}
							   , {header: '제품별 시퀀스'       ,width: 60  ,sortable: true ,dataIndex: 'CNT'           ,hidden : true}
							   , {header: '프로젝트기간 FROM'             ,width: 60  ,sortable: true ,dataIndex: 'PJT_DATE_FROM'            ,hidden : true}
							   , {header: '프로젝트기간 TO'               ,width: 60  ,sortable: true ,dataIndex: 'PJT_DATE_TO'             ,hidden : true}
							   
						   ];	 

/***************************************************************************
 * 그리드 결과매핑 
 ***************************************************************************/
var mappingColumns_1st_pop = [ 
							  {name: 'FLAG'              , allowBlank: false        }         	//조회상태               
							   , {name: 'ITEM_CODE'            , allowBlank: false        }      //품목코드               
							   , {name: 'ITEM_NAME'     , allowBlank: false        }      //품목명 
							   , {name: 'PJT_ID'     , allowBlank: false        }      			//프로젝트ID          
							   , {name: 'PJT_NAME'          , allowBlank: false        }      	//프로젝트명             
							   , {name: 'CSR_ID'      , allowBlank: false        }      		//업무요청ID        
							   , {name: 'CSR_INFO_SEQ'     , allowBlank: false        }      	//업무요청순번        
							   , {name: 'CSR_TITLE'       , allowBlank: false        }      	//요청제목             
							   , {name: 'CSR_TYPE_CODE' , allowBlank: false        }      	//업무요청유형코드      
							   , {name: 'CSR_TYPE_NAME'   , allowBlank: false        }      	//업무요청구분명       
							   , {name: 'ROWCNT' , allowBlank: false        }      		//rowspan 수   	
							   , {name: 'CNT'   , allowBlank: false        }      		//제품별 시퀀스       
							   , {name: 'PJT_DATE_FROM'    , allowBlank: false        }      //프로젝트기간 FROM   
							   , {name: 'PJT_DATE_TO'     , allowBlank: false        }      //프로젝트기간 TO     
		    				 ];
 
 
/***************************************************************************
 * 그리드 클릭시 Event
 ***************************************************************************/
function fnGridOnClick_1st_pop(store, rowIndex){

	
	
}   

/***************************************************************************
 * 함수명 : fnSearch
 * 설  명 : 검색
***************************************************************************/
function fnSearch(){  	
	

	var sForm = document.searchForm;

	sForm.src_pjt_date_from.value = sForm.src_pjt_date_from_tmp.value.replaceAll('-','');		   	 
	sForm.src_pjt_date_to.value = sForm.src_pjt_date_to_tmp.value.replaceAll('-','');	
		
	
	Ext.Ajax.request({   
		url: "/dev/pjdInfo/pjtInfoNitemPopList.sg"
		,method : 'POST'   
		,success: function(response){						// 조회결과 성공시
					// 조회된 결과값, store명
					handleSuccess(response,GridClass_1st_pop);
		          }
		,failure: handleFailure   		// 조회결과 실패시  
		,form	: document.searchForm
		,params : {						// 조회조건을 DB로 전송하기위해서 조건값 설정
				  start 	    : start_1st_pop
    			, limit         : limit_1st_pop
    			//, src_pjt_name  : Ext.get('src_pjt_name').getValue()
    	        //, src_issue_type_code : Ext.get('src_issue_type_code').getValue()
				  }				
	});  
}  		

/***************************************************************************
 * 설  명 : 화면 초기설정
 ***************************************************************************/
// ExtJS 진입함수
Ext.onReady(function() {
	
	// 검색버튼 클릭
	Ext.get('searchBtn').on('click', function(e){
        fnSearch()	
    });
	
	// 검색버튼 클릭
	Ext.get('searchClearBtn').on('click', function(e){
        document.searchForm.reset();
    });
    
    
	var toDay = getTimeStamp(); 
	 toDay = toDay.replaceAll('-','');
	 toDay = addDate(toDay, 'M', -3);
	 toDay = toDay.substring(0,4)+"-"+toDay.substring(4,6)+"-"+toDay.substring(6,8);
	 var fromDay = toDay;
	 toDay = getTimeStamp().trim();
	 
	     
	// 검색시작일자
	var startDate = new Ext.form.DateField({
    	applyTo: 'src_pjt_date_from_tmp',
		allowBlank: false,
		format:'Y-m-d',
		editable : false,
		value : fromDay
	});
   	
	// 검색종료일자
	var endDate = new Ext.form.DateField({
    	applyTo: 'src_pjt_date_to_tmp',
		allowBlank: false,
		format:'Y-m-d',
		editable : false,
		value : toDay
	});    
	
});

/***************************************************************************
 * 설  명 : 그리드의 페이지 클릭시 검색조건값을 DB로 전송
 ***************************************************************************/
function fnPagingValue_1st_pop(){
	var sForm = document.searchForm;
	
	try{
		GridClass_1st_pop.store.setBaseParam('start'		  ,start_1st_pop);
    	GridClass_1st_pop.store.setBaseParam('limit'		  ,limit_1st_pop);
    	
    	
    	//GridClass_1st_pop.store.setBaseParam('src_pjt_type_code'	  ,Ext.get('src_pjt_type_code').getValue());
    	GridClass_1st_pop.store.setBaseParam('src_pjt_name'	  ,Ext.get('src_pjt_name').getValue());
    	
		GridClass_1st_pop.store.setBaseParam('src_pjt_date_from' ,Ext.get('src_pjt_date_from').getValue()); 	// 프로젝트기간(검색시작일
		GridClass_1st_pop.store.setBaseParam('src_pjt_date_to'   ,Ext.get('src_pjt_date_to').getValue());    	 // 프로젝트기간(검색종료일)        	
    	
	}catch(e){

	}
}

function fnSelectPopUpGridRow1st(){
	
	//선택된 그리드의 
	var records = GridClass_1st_pop.grid.selModel.getSelections(); 
	var multiSelectYn = '<%=multiSelectYn%>';
	
	//alert(records.length +" : "+multiSelectYn);
	
	if(records.length == 0){
		Ext.Msg.alert('확인', '선택된 자료가 없습니다.');
		return false;
	}else if(records.length > 1 && (multiSelectYn != 'Y' || multiSelectYn == 'null')){
		Ext.Msg.alert('확인', '1행 이상 선택할수 없습니다.');
		return false;
	}else{	
		window.opener.fnPjtNitemPopValue(records);		//부모창으로 함수호출
		window.close();
	}
}



function fnCheckRowSelectChangePop(SelectionModel){


}


var checkCode ="";

// 행이 선택된 행
function fnRowSelectPop1st(SelectionModel,rowIndex, record){


//alert("-111-rowIndex--"+rowIndex+"-ITEM_CODE--"+record.data.ITEM_CODE)
//alert("--isSelected---"+GridClass_1st_pop.grid.selModel.isSelected(0));
//alert("--checkCode--"+checkCode+"--record.data.ITEM_CODE-"+record.data.ITEM_CODE+"--rowIndex--"+rowIndex);	
		var selectedCnt =0;    
		
	 	for(i=0 ; i < rowTotCnt ; i++){
			if(GridClass_1st_pop.grid.selModel.isSelected(i))
			{
				selectedCnt++;
			}
	 	}

			if(checkCode !="" && checkCode != record.data.ITEM_CODE)
			{
				alert("동일품목만 선택가능합니다.");
				GridClass_1st_pop.grid.selModel.deselectRow(rowIndex);
			}else
			{
			
				var rowTotCnt = GridClass_1st_pop.store.getCount();
	//alert("--rowTotCnt--"+rowTotCnt);
			   	 
			   	checkCode = record.data.ITEM_CODE;
			
			 	for(i=0 ; i < rowTotCnt ; i++)
			 	{
			 		var recodeAt = GridClass_1st_pop.store.getAt(i);
			 		var data = recodeAt.data.ITEM_CODE;
					
					if(checkCode == data)
					{
	//alert("-11-checkCode--"+checkCode+"--data--"+data);
						if(!GridClass_1st_pop.grid.selModel.isSelected(i))
						{
							GridClass_1st_pop.grid.selModel.selectRow(i,true);
						}
					}
					
			 	}		
		 	}

}


// 행이 선택안된 행
function fnRowdeSelectPop1st(SelectionModel,rowIndex, record){

	var rowTotCnt = GridClass_1st_pop.store.getCount();
	var selectedCnt =0;    
	
//alert("--record.data.ITEM_CODE--"+record.data.ITEM_CODE+"-rowTotCnt-"+rowTotCnt+"--selectedCnt--"+selectedCnt);     
	 	for(i=0 ; i < rowTotCnt ; i++){
	 		var recodeAt = GridClass_1st_pop.store.getAt(i);
	 		var data = recodeAt.data.ITEM_CODE;
	 				
			if(GridClass_1st_pop.grid.selModel.isSelected(i))
			{
	
					if(record.data.ITEM_CODE == data)
					{
						GridClass_1st_pop.grid.selModel.deselectRow(i); 
					}
			}
	 	}

	 	for(i=0 ; i < rowTotCnt ; i++)
	 	{
			if(GridClass_1st_pop.grid.selModel.isSelected(i))
			{
				selectedCnt++;
			}
	 	}
	 	    
		if(selectedCnt == 0)	//선택된것이 없으면 초기화
		{ 	
	 		checkCode ="";
	 	}
}





</script>

</head>
<body>
	<table border="0" width="400" height="200">
		<tr>
			<td colspan="2">
			
			<form name="searchForm" id="searchForm">
				<input type="hidden" id="src_pjt_date_from" name="src_pjt_date_from"  />
				<input type="hidden" id="src_pjt_date_to" name="src_pjt_date_to"  />
				
				<!----------------- SEARCH Hearder Start	 ----------------->
				<div id="ext-comp-1002" class=" x-panel x-form-label-left"><%-- 0em <- 1em으로 수정하면 상위 공백 --%>
					<div class="x-panel-tl">
						<div class="x-panel-tr">
							<div class="x-panel-tc">
								<div id="ext-gen4" class="x-panel-header x-unselectable" style="-moz-user-select: none;">
									
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
						    		<!--	
						    		<tr>
									
										<td width="20%">
											<div tabindex="-1" class="x-form-item " >
												<label class="x-form-item-label" style="width: auto;" for="src_pjt_type_code">구분코드 :</label>
												<div style="padding-left: 30px;" class="x-form-element">
													<select name="src_pjt_type_code" id="src_pjt_type_code" style="width: 60%;" type="text" class=" x-form-select x-form-field" >
														<option value="">전체</option>
														<c:forEach items="${PJT_TYPE_CODE}" var="data" varStatus="status">
														<option value="${data.COM_CODE}"><c:out value="${data.COM_CODE_NAME}"/></option>
														</c:forEach>
													</select>
												</div>
											</div>
										</td>
										<td width="20%">
											<div tabindex="-1" class="x-form-item " >
												<label class="x-form-item-label" style="width: auto;" for="src_pjt_name" >프로젝트명 :</label>
												<div style="padding-left: 80px;" class="x-form-element">
													<input type="text" name="src_pjt_name" id="src_pjt_name" autocomplete="off" size="15" class="x-form-text x-form-field" style="width: auto;">
												</div>
											</div>
										</td>										
									</tr>
									-->
									<tr>
										<td width="20%">
											<div tabindex="-1" class="x-form-item " >
												<label class="x-form-item-label" style="width: auto;" for="src_pjt_name" >프로젝트명 :</label>
												<div style="padding-left: 80px;" class="x-form-element">
													<input type="text" name="src_pjt_name" id="src_pjt_name" autocomplete="off" size="15" class="x-form-text x-form-field" style="width: auto;">
												</div>
											</div>
										</td>									
										<td width="40%" colspan="2">
											<div tabindex="-1" class="x-form-item " >
												<label class="x-form-item-label" style="width: auto;" for="src_pjt_date_from_tmp" >프로젝트기간 :</label>
												<div style="padding-left: 30px;" >
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
											</div>
										</td>
										
									</tr>
									<%-- 1 Row End --%>
									
									<%-- 2 Row 버튼 Start --%>
									<tr align="right">
										<td colspan="3">
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
				<!------------------ footer Start -------------------------->
				<div id="" class="x-panel-bl x-panel-nofooter">
					<div class="x-panel-br">
						<div class="x-panel-bc">
						</div>
					</div>
				</div>
				<!----------------- footer End  ---------------------------->
				<!----------------- SEARCH Field End ----------------------->
				</form>
			</td>
		</tr>
		<tr>
			<!----------------- GRID START ----------------->
			<td width="50%" valign="top">
				<div id="user-grid"></div>
			</td>
			<!----------------- GRID END ----------------->
		</tr>
	</table>
</body>

</html>