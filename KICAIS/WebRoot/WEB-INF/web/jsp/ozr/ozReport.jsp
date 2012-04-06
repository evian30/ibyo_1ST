<%--
  Class Name  : ozReport.jsp
  Description : 리포트
  Modification Information
 
      수정일                   수정자                 수정내용
  -------      --------    ---------------------------
  2011. 5. 27  고기범                 수정   
  
  author   : 고기범
  since    : 2011. 3. 21.
  version  : 1.0
   
  Copyright (C) 2011 by SG All right reserved.
--%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/web/jsp/common/inc/commonInc.jsp" %>
<script type="text/javascript" src="/resource/common/js/sgis-comm-inc.js" ></script> 
<script type="text/javascript" src="/resource/common/js/common/common-msg-box.js" ></script> 
<script type="text/javascript" src="/resource/common/js/ajax.js" ></script>

<script type="text/javascript">

Ext.onReady(function() {
	
	// 영업접대비현황
	Ext.get('SDMS_ReceptionAccountMonthly').on('click', function(e){
		var sURL      = "/ozr/receptionAccountMonthlyPop.sg";
		var dlgWidth  = 296;
		var dlgHeight = 191;
		var winName   = "SDMS_ReceptionAccountMonthly";
		fnOpenPop(sURL, dlgWidth, dlgHeight, winName);
	});
	
	// 프로젝트별 영업비용분석
	Ext.get('ProjectSalesActivity').on('click', function(e){
		var sURL      = "/ozr/projectSalesActivityPop.sg";
		var dlgWidth  = 296;
		var dlgHeight = 191;
		var winName   = "projectSalesActivityPop";
		fnOpenPop(sURL, dlgWidth, dlgHeight, winName);
	});
	
	// 프로젝트 원가분석
	Ext.get('ProjectCost').on('click', function(e){
		var sURL      = "/ozr/projectCostPop.sg?param=ProjectCost";
		var dlgWidth  = 296;
		var dlgHeight = 191;
		var winName   = "projectCostPop";
		fnOpenPop(sURL, dlgWidth, dlgHeight, winName);
	});
	
	// 프로젝트상세비용분석
	Ext.get('AccountDetailByProject').on('click', function(e){
		var sURL      = "/ozr/accountDetailByProjectPop.sg";
		var dlgWidth  = 296;
		var dlgHeight = 191;
		var winName   = "accountDetailByProjectPop";
		fnOpenPop(sURL, dlgWidth, dlgHeight, winName);
	});
	
	// 프로젝트상세이력정보 <----------- 프로젝트 원가분석의 팝업을 호출
	Ext.get('ProjectHistory').on('click', function(e){
		var sURL      = "/ozr/projectCostPop.sg?param=ProjectHistory";
		var dlgWidth  = 296;
		var dlgHeight = 191;
		var winName   = "ProjectHistoryPop";
		fnOpenPop(sURL, dlgWidth, dlgHeight, winName);
	});
	
	// 연도별 매출보고서
	Ext.get('SaleTaskAnalysis').on('click', function(e){
		alert('영업업무분석');
	});
	
	// 전사팀장주간업무보고
	Ext.get('WeeklySalesResult').on('click', function(e){
		var sURL      = "/ozr/weeklySalesResulttPop.sg";
		var dlgWidth  = 296;
		var dlgHeight = 191;
		var winName   = "weeklySalesResulttPop";
		fnOpenPop(sURL, dlgWidth, dlgHeight, winName);
	});
	
	// 매출보고서
	Ext.get('SDMS_SalesReport').on('click', function(e){
		var sURL      = "/ozr/salesReportPop.sg";
		var dlgWidth  = 296;
		var dlgHeight = 191;
		var winName   = "salesReportPop";
		fnOpenPop(sURL, dlgWidth, dlgHeight, winName);
	});
	
	// 수주보고서
	Ext.get('OrderReport').on('click', function(e){
		var sURL      = "/ozr/orderReportPop.sg";
		var dlgWidth  = 296;
		var dlgHeight = 191;
		var winName   = "orderReportPop";
		fnOpenPop(sURL, dlgWidth, dlgHeight, winName);
	});
	
	// 년간영업실적보고서
	Ext.get('NetSalesAmount2009').on('click', function(e){
		var sURL      = "/ozr/netSalesAmount2009Pop.sg";
		var dlgWidth  = 296;
		var dlgHeight = 191;
		var winName   = "netSalesAmount2009Pop";
		fnOpenPop(sURL, dlgWidth, dlgHeight, winName);
	});
	
	// 고객리스트(등급)
	Ext.get('CustomerList').on('click', function(e){
		var sURL      = "/ozr/customerListPop.sg";
		var dlgWidth  = 296;
		var dlgHeight = 191;
		var winName   = "customerListPop";
		fnOpenPop(sURL, dlgWidth, dlgHeight, winName);
	});
	
	// 만기유지보수정보
	Ext.get('MaintenanceInfo_End').on('click', function(e){
		var sURL      = "/ozr/maintenanceInfoPop.sg?param=End";
		var dlgWidth  = 296;
		var dlgHeight = 191;
		var winName   = "maintenanceInfo_EndPop";
		fnOpenPop(sURL, dlgWidth, dlgHeight, winName);
	});
	
	// 정기유지보수상세정보
	Ext.get('MaintenanceInfo_Detail').on('click', function(e){
		var sURL      = "/ozr/maintenanceInfoPop.sg?param=Detail";
		var dlgWidth  = 296;
		var dlgHeight = 191;
		var winName   = "maintenanceInfo_DetailPop";
		fnOpenPop(sURL, dlgWidth, dlgHeight, winName);
	});
	
	// 정기유지보수정보
	Ext.get('MaintenanceInfo_List').on('click', function(e){
		var sURL      = "/ozr/maintenanceInfoPop.sg?param=List";
		var dlgWidth  = 296;
		var dlgHeight = 191;
		var winName   = "maintenanceInfo_ListPop";
		fnOpenPop(sURL, dlgWidth, dlgHeight, winName);
	});
	
}); // endf Ext.onReady

// 팝업
function fnOpenPop(sURL, dlgWidth, dlgHeight, winName){
  var xPos=(window.screen.width) ? (window.screen.width-dlgWidth)/2 : 0;
  var yPos=(window.screen.height) ? (window.screen.height-dlgHeight)/2 : 0;
  var sFeatures = "titlebar=no, scrollbars=no,location=no ,menubar=no, resizable=no, status=yes, width="+dlgWidth+",height="+dlgHeight+",left="+xPos+", top="+yPos;
  window.open(sURL,winName, sFeatures);
}
</script>

</head>
<body class=" ext-gecko ext-gecko3">
	<table border="0" width="1000px">
		<tr>
			<td>
				<div tabindex="-1" class="x-form-item " style="padding-left: 5px;">
				</div>
			</td>
		</tr>
		<tr>
			<td>
				<!-- SDMS_ReceptionAccountMonthly -->
				<div tabindex="-1" class="x-form-item " style="padding-left: 10px;">
					<img align="center" src="/resource/images/admin/img/checkbox_on.gif"/>
					<a name="SDMS_ReceptionAccountMonthly" id="SDMS_ReceptionAccountMonthly" style="cursor: hand;" onmouseover="this.style.color='blue'" onmouseout="this.style.color='black'">
					<font size="3" style="text-align: center; font-variant: center; padding-left: 3px;"><b><i>영업접대비 현황</i></b></font>
					</a>
				</div>
				<!-- SDMS_ReceptionAccountMonthly -->
			</td>
		</tr>
		<tr height="3px">
			<td>
			</td>
		</tr>
		<tr>
			<td>
				<!-- ProjectSalesActivity -->
				<div tabindex="-1" class="x-form-item " style="padding-left: 10px;">
					<img align="center" src="/resource/images/admin/img/checkbox_on.gif"/>
					<a name="ProjectSalesActivity" id="ProjectSalesActivity" style="cursor: hand;" onmouseover="this.style.color='blue'" onmouseout="this.style.color='black'">
					<font size="3" style="text-align: center; font-variant: center; padding-left: 3px;"><b><i>프로젝트별 영업비용분석</i></b></font>
					</a>
				</div>
				<!-- ProjectSalesActivity -->
			</td>
		</tr>
		<tr height="3px">
			<td>
			</td>
		</tr>
		<tr>
			<td>
				<!-- ProjectCost -->
				<div tabindex="-1" class="x-form-item " style="padding-left: 10px;">
					<img align="center" src="/resource/images/admin/img/checkbox_on.gif"/>
					<font size="3" style="text-align: center; font-variant: center; padding-left: 3px;"><b><i>프로젝트 원가분석</i></b></font>
				</div>
				<!-- ProjectCost -->
			</td>
		</tr>
		<tr>
			<td>
				<!-- ProjectCost -->
				<div tabindex="-1" class="x-form-item " style="padding-left: 30px;">
					<img align="center" src="/resource/images/admin/img/blue_b.gif"/>
					<a name="ProjectCost" id="ProjectCost" style="cursor: hand;" onmouseover="this.style.color='blue'" onmouseout="this.style.color='black'">
					<font size="2" style="text-align: center; font-variant: center; padding-left: 3px;"><b>프로젝트 원가분석</b></font>
					</a>
				</div>
				<!-- ProjectCost -->
			</td>
		</tr>
		<tr>
			<td>
				<!-- ProjectCost -->
				<div tabindex="-1" class="x-form-item " style="padding-left: 30px;">
					<img align="center" src="/resource/images/admin/img/blue_b.gif"/>
					<a name="AccountDetailByProject" id="AccountDetailByProject" style="cursor: hand;" onmouseover="this.style.color='blue'" onmouseout="this.style.color='black'">
					<font size="2" style="text-align: center; font-variant: center; padding-left: 3px;"><b>프로젝트 상세비용분석</b></font>
					</a>
				</div>
				<!-- ProjectCost -->
			</td>
		</tr>
		<tr>
			<td>
				<!-- ProjectCost -->
				<div tabindex="-1" class="x-form-item " style="padding-left: 30px;">
					<img align="center" src="/resource/images/admin/img/blue_b.gif"/>
					<a name="ProjectHistory" id="ProjectHistory" style="cursor: hand;" onmouseover="this.style.color='blue'" onmouseout="this.style.color='black'">
					<font size="2" style="text-align: center; font-variant: center; padding-left: 3px;"><b>프로젝트 상세이력정보</b></font>
					</a>
				</div>
				<!-- ProjectCost -->
			</td>
		</tr>
		<tr height="3px">
			<td>
			</td>
		</tr>
		<tr>
			<td>
				<!--  -->
				<div tabindex="-1" class="x-form-item " style="padding-left: 10px;">
					<img align="center" src="/resource/images/admin/img/checkbox_on.gif"/>
					<a name="SaleTaskAnalysis" id="SaleTaskAnalysis" style="cursor: hand;" onmouseover="this.style.color='blue'" onmouseout="this.style.color='black'">
					<font size="3" style="text-align: center; font-variant: center; padding-left: 3px;"><b><i>영업업무분석</i></b></font>
					</a>
				</div>
				<!--  -->
			</td>
		</tr>
		<tr height="3px">
			<td>
			</td>
		</tr>
		<tr>
			<td>
				<!-- SalesReport -->
				<div tabindex="-1" class="x-form-item " style="padding-left: 10px;">
					<img align="center" src="/resource/images/admin/img/checkbox_on.gif"/>
<%--					<a name="SalesReport" id="SalesReport" style="cursor: hand;">--%>
					<font size="3" style="text-align: center; font-variant: center; padding-left: 3px;"><b><i>연도별 매출보고서</i></b></font>
<%--					</a>--%>
				</div>
				<!-- SalesReport -->
			</td>
		</tr>
		<tr>
			<td>
				<!-- SalesReport -->
				<div tabindex="-1" class="x-form-item " style="padding-left: 30px;">
					<img align="center" src="/resource/images/admin/img/blue_b.gif"/>
					<a name="WeeklySalesResult" id="WeeklySalesResult" style="cursor: hand;" onmouseover="this.style.color='blue'" onmouseout="this.style.color='black'">
					<font size="2" style="text-align: center; font-variant: center; padding-left: 3px;"><b>전사팀장주간업무보고</b></font>
					</a>
				</div>
				<!-- WeeklySalesResult -->
			</td>
		</tr>
		<tr>
			<td>
				<!-- SDMS_SalesReport -->
				<div tabindex="-1" class="x-form-item " style="padding-left: 30px;">
					<img align="center" src="/resource/images/admin/img/blue_b.gif"/>
					<a name="SDMS_SalesReport" id="SDMS_SalesReport" style="cursor: hand;" onmouseover="this.style.color='blue'" onmouseout="this.style.color='black'">
					<font size="2" style="text-align: center; font-variant: center; padding-left: 3px;"><b>매출보고서</b></font>
					</a>
				</div>
				<!-- SDMS_SalesReport -->
			</td>
		</tr>
		<tr>
			<td>
				<!-- OrderReport -->
				<div tabindex="-1" class="x-form-item " style="padding-left: 30px;">
					<img align="center" src="/resource/images/admin/img/blue_b.gif"/>
					<a name="OrderReport" id="OrderReport" style="cursor: hand;" onmouseover="this.style.color='blue'" onmouseout="this.style.color='black'">
					<font size="2" style="text-align: center; font-variant: center; padding-left: 3px;"><b>수주보고서</b></font>
					</a>
				</div>
				<!-- OrderReport -->
			</td>
		</tr>
		<tr>
			<td>
				<!-- NetSalesAmount2009 -->
				<div tabindex="-1" class="x-form-item " style="padding-left: 30px;">
					<img align="center" src="/resource/images/admin/img/blue_b.gif"/>
					<a name="NetSalesAmount2009" id="NetSalesAmount2009" style="cursor: hand;" onmouseover="this.style.color='blue'" onmouseout="this.style.color='black'">
					<font size="2" style="text-align: center; font-variant: center; padding-left: 3px;"><b>년간영업실적보고서</b></font>
					</a>
				</div>
				<!-- NetSalesAmount2009 -->
			</td>
		</tr>
		<tr height="3px">
			<td>
			</td>
		</tr>
		<tr>
			<td>
				<!-- CustomerList -->
				<div tabindex="-1" class="x-form-item " style="padding-left: 10px;">
					<img align="center" src="/resource/images/admin/img/checkbox_on.gif"/>
					<a name="CustomerList" id="CustomerList" style="cursor: hand;" onmouseover="this.style.color='blue'" onmouseout="this.style.color='black'">
					<font size="3" style="text-align: center; font-variant: center; padding-left: 3px;"><b><i>고객리스트(등급)</i></b></font>
					</a>
				</div>
				<!-- CustomerList -->
			</td>
		</tr>
				<tr>
			<td>
				<!-- ProjectCost -->
				<div tabindex="-1" class="x-form-item " style="padding-left: 10px;">
					<img align="center" src="/resource/images/admin/img/checkbox_on.gif"/>
					<font size="3" style="text-align: center; font-variant: center; padding-left: 3px;"><b><i>유지보수정보</i></b></font>
				</div>
				<!-- ProjectCost -->
			</td>
		</tr>
		<tr>
			<td>
				<!-- ProjectCost -->
				<div tabindex="-1" class="x-form-item " style="padding-left: 30px;">
					<img align="center" src="/resource/images/admin/img/blue_b.gif"/>
					<a name="MaintenanceInfo_End" id="MaintenanceInfo_End" style="cursor: hand;" onmouseover="this.style.color='blue'" onmouseout="this.style.color='black'">
					<font size="2" style="text-align: center; font-variant: center; padding-left: 3px;"><b>만기유지보수정보</b></font>
					</a>
				</div>
				<!-- ProjectCost -->
			</td>
		</tr>
		<tr>
			<td>
				<!-- ProjectCost -->
				<div tabindex="-1" class="x-form-item " style="padding-left: 30px;">
					<img align="center" src="/resource/images/admin/img/blue_b.gif"/>
					<a name="MaintenanceInfo_Detail" id="MaintenanceInfo_Detail" style="cursor: hand;" onmouseover="this.style.color='blue'" onmouseout="this.style.color='black'">
					<font size="2" style="text-align: center; font-variant: center; padding-left: 3px;"><b>정기유지보수 상세정보</b></font>
					</a>
				</div>
				<!-- ProjectCost -->
			</td>
		</tr>
		<tr>
			<td>
				<!-- ProjectCost -->
				<div tabindex="-1" class="x-form-item " style="padding-left: 30px;">
					<img align="center" src="/resource/images/admin/img/blue_b.gif"/>
					<a name="MaintenanceInfo_List" id="MaintenanceInfo_List" style="cursor: hand;" onmouseover="this.style.color='blue'" onmouseout="this.style.color='black'">
					<font size="2" style="text-align: center; font-variant: center; padding-left: 3px;"><b>정기유지보수 정보</b></font>
					</a>
				</div>
				<!-- ProjectCost -->
			</td>
		</tr>
	</table>
</body>

<%@ include file="/WEB-INF/web/jsp/sgis-bottom-inc.jsp" %>