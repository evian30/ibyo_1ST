<%--
  Class Name  : projectCostPop.jsp
  Description : 프로젝트 원가분석
  Modification Information
 
      수정일                   수정자                 수정내용
  -------      --------    ---------------------------
  2011. 5. 27. 고기범                 최초 생성
 
  author   : 고기범
  since    : 2011. 5. 27.
  version  : 1.0
   
  Copyright (C) 2011 by SG All right reserved.
--%>
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
<script type="text/javascript" src="/resource/common/js/sgis-comm-inc.js"></script>
<script type="text/javascript">


/***************************************************************************
 * 설  명 : 화면 초기설정
 ***************************************************************************/
// ExtJS 진입함수
Ext.onReady(function() { 
	
	var toDay = getTimeStamp();	
	toDay = toDay.replaceAll('-','');
	toDay = addDate(toDay, 'M', -3);
	toDay = toDay.substring(0,4)+"-"+toDay.substring(4,6)+"-"+toDay.substring(6,8);
	var fromDay = toDay;
	toDay = getTimeStamp().trim();
	
	// 검색버튼
	Ext.get('searchBtn').on('click', function(e){
<%--		
		var startDate = Ext.get('src_date_from').getValue()  // 검색시작일
		var endDate = Ext.get('src_date_to').getValue()      // 검색종료일
		
		if(startDate.length == 10){
			var check = isValidDate('', startDate); 
			if(!check){
				return false;
			}
		}else{
			if(startDate.length > 0 && startDate != ''){
				Ext.Msg.alert('확인', '유효한 날짜[기간]가 아닙니다.');
				return false;
			}
		}
		
		if(endDate.length == 10){
			var check1 = isValidDate('', endDate);
			if(!check1){
				return false;
			}
		}else{
			if(endDate.length > 0 && endDate != ''){
				Ext.Msg.alert('확인', '유효한 날짜[기간]가 아닙니다.');
				return false;
			}
		}
		
		if(fnCalDate(startDate,endDate,'D') < 0){
			Ext.Msg.alert('확인', '검색시작일이 검색종료일보다 이전입니다.'); 
			return false;
		}else{
		 	fnOzReport(); 
		}
--%>
		fnOzReport();
    });
	
	// 조건해제버튼
	Ext.get('searchClearBtn').on('click', function(e){
        document.searchForm.reset();
    });
	
	// 영업담당자버튼
	Ext.get('empNumBtn').on('click', function(e){
        var param = '';
		fnEmployeePop(param)
    });
	
	// 프로젝트ID 검색버튼
	Ext.get('pjtBtn').on('click', function(e){
        var param = "?fieldName=pjt_id&src_pjt_type_code=";		// 10_영업관리 프로젝트만 검색
		fnPjtPop(param);
    });

<%--
	// 검색시작일자
	var startDate = new Ext.form.DateField({
    	applyTo: 'src_date_from',
		allowBlank: true,
		format:'Y-m-d',
		editable : true,
		value : fromDay
	});
   	
	// 검색종료일자
	var endDate = new Ext.form.DateField({
    	applyTo: 'src_date_to',
		allowBlank: true,
		format:'Y-m-d',
		editable : true,
		value : toDay
	});
--%>	
	//담당자 이름 수정시    
	Ext.get('src_emp_name').on('change', function(e){	
		
		var src_emp_name = Ext.get('src_emp_name').getValue();
		
		if(src_emp_name == "" || src_emp_name.length == 0){
			Ext.get('src_emp_num').set({value: ''} , false);				
		}
	});
	
	//프로젝트명 수정시    
	Ext.get('src_pjt_name').on('change', function(e){	
		
		var src_pjt_name = Ext.get('src_pjt_name').getValue();
		
		if(src_pjt_name == "" || src_pjt_name.length == 0){
			Ext.get('src_pjt_id').set({value: ''} , false);				
		}
	});
});

// 담당자 검색팝업 ****************************************
function fnEmployeePop(param){
	var sURL      = "/com/employee/employeePop.sg"+param;
	var dlgWidth  = 399;
	var dlgHeight = 396;
	var winName   = "담당자";
	fnOpenPop(sURL, dlgWidth, dlgHeight, winName);
}

// 담당자 검색 결과 return Value
function fnEmployeePopValue(records,fileName){
		
	// 전송받은 값이 한건일 경우
    var record = records[0].data;				

    Ext.get('src_emp_num').set({value:fnFixNull(record.EMP_NUM)} , false);
    Ext.get('src_emp_name').set({value:fnFixNull(record.KOR_NAME)} , false);
}

// 프로젝트 **************************************************
function fnPjtPop(param){
	var sURL      = "/pjt/pjtManage/pjtInfoPop.sg"+param;
	var dlgWidth  = 399;
	var dlgHeight = 425;
	var winName   = "project";
	fnOpenPop(sURL, dlgWidth, dlgHeight, winName);
}

function fnPjtPopValue(records, fieldName){
	
	// 전송받은 값이 한건일 경우
    var record = records[0].data;	

	Ext.get('src_pjt_id').set({value:fnFixNull(record.PJT_ID)} , false);
    Ext.get('src_pjt_name').set({value:fnFixNull(record.PJT_NAME)} , false);

}

// 팝업
function fnOpenPop(sURL, dlgWidth, dlgHeight, winName){
  var xPos=(window.screen.width) ? (window.screen.width-dlgWidth)/2 : 0;
  var yPos=(window.screen.height) ? (window.screen.height-dlgHeight)/2 : 0;
  var sFeatures = "titlebar=no, scrollbars=no,location=no ,menubar=no, resizable=no, status=yes, width="+dlgWidth+",height="+dlgHeight+",left="+xPos+", top="+yPos;
  window.open(sURL,winName, sFeatures);
}

function fnOzReport(){
	
 	var pjt_id	= Ext.get('src_pjt_id').getValue()	// 프로젝트  
 	var param = '?param=PJT_ID='+pjt_id;
	var gubun = '<%= request.getParameter("param")%>';
 	
 	if(gubun == 'ProjectCost'){					// 프로젝트 원가분석
 		param = param+'&odi=ProjectCost&ozr=ProjectCost';
 	}else if(gubun == 'ProjectHistory'){		// 프로젝트상세이력정보
 		param = param+'&odi=ProjectHistory&ozr=ProjectHistory';	
 	}
 	
	var sURL      = "/ozr/ozReportPop.sg"+param;
	var dlgWidth  = 820;
	var dlgHeight = 630;
	var winName   = "ProjectCost";
	fnOpenPop(sURL, dlgWidth, dlgHeight, winName);
}
</script>

</head>
<body>
	<table border="0" width="300" height="195">
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
									<%if("ProjectCost".equals(request.getParameter("param").toString())){%>
										프로젝트별 원가분석
									<%}else if("ProjectHistory".equals(request.getParameter("param").toString())){ %>
										프로젝트상세 이력정보
									<%} %>
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
										<td width="100%" colspan="2">
											<div tabindex="-1" class="x-form-item " >
												<div style="padding-left: 10px;" >
													<label class="x-form-item-label" style="width: auto;" for="src_date_from" >
													<img align="center" src="/resource/images/admin/img/images/lb_arrow_right_i.gif"/>
													프로젝트
													</label>
												</div>
											</div>
										</td>
									</tr>
									<%-- 1 Row Start --%>
									
									<%-- 1 Row Start --%>
									<tr>
										<td width="100%" colspan="2">
											<div tabindex="-1" class="x-form-item " >
												<div style="padding-left: 9px;" >
													<%-- 날짜검색 조건이 있다면 사용할것 Start --%>
													<input type="hidden" name="src_date_from" id="src_date_from" autocomplete="off" size="10" style="width: auto;" maxlength="10">		
													<input type="hidden" name="src_date_to" id="src_date_to" autocomplete="off" size="10" style="width: auto;" maxlength="10">
													<%-- 날짜검색 조건이 있다면 사용할것 End --%>
													<table>
														<tr>
															<td>
																<input type="hidden" name="src_pjt_id" id="src_pjt_num" autocomplete="off" size="10" style="width: auto;">		
																<input type="text" name="src_pjt_name" id="src_pjt_name" autocomplete="off" size="30" style="width: auto;">
															</td>
															<td valign="center">
																<%-- 검색하기버튼 Start --%>
																	<div style="padding-left: 1px;" >
																		<input type="hidden" id="empNumBtn"/>	<%-- 사용자 검색조건 추가시 사용하면 됨 --%>
																		<img align="center" id="pjtBtn" name="pjtBtn" alt="" src="/resource/images/bass_1st/icon_src1.gif" style="cursor: hand;">
																	</div>

																<%-- 검색하기버튼 End	--%>
															</td>
														</tr>
													</table>
												</div>
											</div>
										</td>
									</tr>
									<%-- 1 Row Start --%>
									
									<%-- 1 Row Start --%>
									<tr>
										<td width="100%" colspan="2">
											<div tabindex="-1" class="x-form-item " >
												<div style="padding-left: 10px;" >
<%--													<label class="x-form-item-label" style="width: auto;" for="src_date_from" >--%>
<%--													<img align="center" src="/resource/images/admin/img/images/lb_arrow_right_i.gif"/>--%>
<%--													영업담당자--%>
<%--													</label>--%>
												</div>
											</div>
										</td>
									</tr>
									<%-- 1 Row Start --%>
									
									<%-- 1 Row Start --%>
									<tr>
										<td width="100%" colspan="2">
											<div tabindex="-1" class="x-form-item " >
												<div style="padding-left: 9px; height:52px;" >
													<table>
														<tr>
															<td>
																<input type="hidden" name="src_emp_num" id="src_emp_num" autocomplete="off" size="10" style="width: auto;">		
																<input type="hidden" name="src_emp_name" id="src_emp_name" autocomplete="off" size="10" style="width: auto;">
															</td>
															<td valign="center">
																<%-- 검색하기버튼 Start --%>
																	<div style="padding-left: 1px;" >
																		<input type="hidden" id="empNumBtn"/>	
<%--																		<img align="center" id="empNumBtn" name="empNumBtn" alt="" src="/resource/images/bass_1st/icon_src1.gif">--%>
																	</div>
																<%-- 검색하기버튼 End	--%>
															</td>
														</tr>
													</table>
												</div>
											</div>
										</td>
									</tr>
									<%-- 1 Row Start --%>
									
									<%-- 2 Row 버튼 Start --%>
									<tr align="center">
										<td colspan="2">
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
																		<button type="button" id="searchBtn" class=" x-btn-text">REPORT</button>
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
	</table>
</body>

<%@ include file="/WEB-INF/web/jsp/sgis-bottom-inc.jsp" %>