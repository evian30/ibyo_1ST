<%--
  Class Name  : /pjt/allPJTManagement.jsp
  Description : 프로젝트관리(통합)
  Modification Information
 
      수정일                   수정자                 수정내용
  -------      --------    ---------------------------
  2011. 05. 01   여인범            최초 생성   
  
  author   : 여인범
  since    :  2011. 05. 01.
  version  : 1.0
   
  Copyright (C) 2011 by SG All right reserved.
--%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/web/jsp/common/inc/commonInc.jsp" %>

<script type="text/javascript" src="/resource/common/js/sgis-comm-inc.js" ></script> 
<script type="text/javascript" src="/resource/common/js/common/common-msg-box.js" ></script> 
<script type="text/javascript" src="/resource/common/js/ajax.js" ></script> 
  
<script type="text/javascript">
 

/***************************************************************************
 * 설  명 : 검색
 **************************************************************************/
function fnSearch(){
	
	var allParam  =	  "?totMng=all"+ 
		           	   "&src_pjt_type_code=10"+ 
		           	   "&start_1st=0"+ 
		           	   "&limit_1st=15"+ 
		           	   "&src_pjt_id="+document.searchForm.src_pjt_id.value+ 
		           	   "&src_pjt_name="+document.searchForm.src_pjt_name.value;
	
	//프로젝트 정보
	document.getElementById('ifrPjt').src ='/pjt/pjtManage/pjtManageList.sg'+allParam;
	
	//견적정보
	document.getElementById('ifrEst').src ='/est/estimate/estimateInfoManage.sg'+allParam;
	
	//수주
	document.getElementById('ifrOrd').src ='/ord/order/orderInfoManage.sg'+allParam;
	
	//구매 
	document.getElementById('ifrPur').src ='/pur/purManager.sg'+allParam;
 
	
	//매출
	document.getElementById('ifrSal').src ='/sal/sale/saleInfoManage.sg'+allParam;
	
	//유지보수
	document.getElementById('ifrMan').src ='/man/management/managementList.sg'+allParam;
	
} 

/***************************************************************************
 * 설  명 : 화면 설정
 ***************************************************************************/
// ExtJS 진입함수
Ext.onReady(function() {
 	 
    // 검색버튼 클릭
	Ext.get('searchBtn').on('click', function(e){ 
			fnSearch(); 
    });
    
   	//조건해제 버튼 -> 검색조건 초기화
   	Ext.get('searchClearBtn').on('click', function(e){
        document.searchForm.reset();
        fnSearch(); 
    }); 
   	 
   	fnSearch();
   	/*
	// 검색시작일자
	var src_pjt_date_from = new Ext.form.DateField({
    	applyTo: 'src_pjt_date_from',
		allowBlank: false,
		format:'Y-m-d',
		editable : false
	});
   	
	// 검색종료일자
	var src_pjt_date_to = new Ext.form.DateField({
    	applyTo: 'src_pjt_date_to',
		allowBlank: false,
		format:'Y-m-d',
		editable : false
	}); 
	 */
	
}); 
  



Ext.onReady(function(){ 
	
    var tabs = new Ext.TabPanel({ 
        plain: true, 
    	renderTo: 'allProjectMng',
        width:1000,
        activeTab: 0,
        frame:false,
        enableTabScroll: true,
        defaults:{autoHeight: true},
        resizeTabs: true,
        
        items:[
	            {
	            	title: '프로젝트'
	              , contentEl:'allPjtInfo'
	              , layout:'fit'	 
	            },
	            {
	            	title: '견적'
	              , contentEl:'allEstInfo' 
	              , layout:'fit'	  
	            },
	            {
	            	title: '수주'
	              , contentEl:'allOrdInfo' 
	              , layout:'fit'	  
	            },
	            {
	            	title: '구매'
	              , contentEl:'allPurInfo' 
	              , layout:'fit'
	              , hidden: true
	            },
	            {
	            	title: '매출'
	              , contentEl:'allSalInfo' 
	              , layout:'fit'	  
	            },
	            {
	            	title: '유지보수'
	              , contentEl:'allManInfo' 
	              , layout:'fit'	  
	            }
	            
            
        ]
         
        
    });  
});
 
</script>

</head>
<body class=" ext-gecko ext-gecko3">
	<table border="0" width="1000" height="200">
		<tr>
			<td colspan="2">
				<form name="searchForm" id="searchForm">
				<!----------------- SEARCH Hearder Start	 ----------------->
				<div id="ext-comp-1002" class=" x-panel x-form-label-left" style="margin-top: 0.0em;"><%-- 0em <- 1em으로 수정하면 상위 공백 --%>
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
										<td width="5%">&nbsp;</td> 
										<td width="40%">
											<div tabindex="-1" class="x-form-item " >
												<label class="x-form-item-label" style="width: auto;" for="src_pjt_name" >프로젝트명 :</label>
												<div style="padding-left: 0px;" class="x-form-element">
													<input type="text" name="src_pjt_name" id="src_pjt_name" autocomplete="off" size="40" class=" x-form-text x-form-field" style="width: auto;" />
												</div>
											</div>
										</td>
										<td width="10%">&nbsp;</td> 
										
										<!-- 
										<td width="30%" align="left">
											<div tabindex="-1" class="x-form-item " >
												<label class="x-form-item-label" style="width: auto;" for="src_custom_name" >거래처명 :</label>
												<div style="padding-left: 61px;" class="x-form-element">
													<input type="text" name="src_custom_name" id="src_custom_name" autocomplete="off" size="18" class=" x-form-text x-form-field" style="width: auto;"/>
												</div>
											</div>
										</td>
										 -->
										 
										<td>
											<table width="100%" border="0">
												<tr>
													<td align="right" width="80%">
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
													<td align="right">
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
									<%-- 1 Row End --%> 
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
				<div id="pjt_grid_3rd" style="margin-top: 0.0em;"></div>
			</td>
			<!----------------- 기본정보 GRID END ----------------->			  
		</tr>
	   
		<tr>
			<td colspan="2">
				 <div id="allProjectMng"  style="margin-top: 0.0em;">
			        <div id="allPjtInfo" class="x-hide-display">
			            <iframe id="ifrPjt" name="ifrPjt" src="" style="width:1050; height:900;overflow:hidden;" frameborder="0"></iframe>
			        </div>
			        <div id="allEstInfo" class="x-hide-display">
			            <iframe id="ifrEst" name="ifrEst" src="" style="width:1100; height:1000;overflow:hidden;" frameborder="0"></iframe>
			        </div>
			        <div id="allOrdInfo" class="x-hide-display">
			            <iframe id="ifrOrd" name="ifrOrd" src="" style="width:1100; height:1000;overflow:hidden;" frameborder="0"></iframe>
			        </div>
			        <div id="allPurInfo" class="x-hide-display">
			            <iframe id="ifrPur" name="ifrPur" src="" style="width:1100; height:1000;overflow:hidden;" frameborder="0"></iframe>
			        </div>
			        <div id="allSalInfo" class="x-hide-display">
			            <iframe id="ifrSal" name="ifrSal" src="" style="width:1100; height:1000;overflow:hidden;" frameborder="0"></iframe>
			        </div>
			        <div id="allManInfo" class="x-hide-display">
			            <iframe id="ifrMan" name="ifrMan" src="" style="width:1100; height:1000;overflow:hidden;" frameborder="0"></iframe>
			        </div>
			    </div> 
			
			</td>
		
		
		</tr>
		 
	</table>
</body>

<%@ include file="/WEB-INF/web/jsp/sgis-bottom-inc.jsp" %>