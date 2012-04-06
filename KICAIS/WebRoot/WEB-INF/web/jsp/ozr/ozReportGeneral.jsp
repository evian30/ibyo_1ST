<%--
  Class Name  : ozReport.jsp
  Description : 리포트
  Modification Information
 
      수정일                   수정자                 수정내용
  -------      --------    ---------------------------
  2011. 6. 1   고기범                 수정   
  
  author   : 고기범
  since    : 2011. 6. 1.
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
	
	// 주간업무일지
	Ext.get('DEVDMS_BLReport').on('click', function(e){
		var sURL      = "/ozr/devdmsBlReportPop.sg";
		var dlgWidth  = 296;
		var dlgHeight = 191;
		var winName   = "DEVDMS_BLReport";
		fnOpenPop(sURL, dlgWidth, dlgHeight, winName);
	});
	
	// 연간경비지출
	Ext.get('SDMS_MonthlyAccount').on('click', function(e){
		var param = '?param=&odi=SDMS_MonthlyAccount&ozr=SDMS_MonthlyAccount';	
		var sURL      = "/ozr/ozReportPop.sg"+param;
		var dlgWidth  = 820;
		var dlgHeight = 630;
		var winName   = "SDMS_PeriodAccountMonthly";
		fnOpenPop(sURL, dlgWidth, dlgHeight, winName);
	});
	
	// 월별전체경비지출내역
	Ext.get('SDMS_PeriodAccountMonthly').on('click', function(e){
	 	var param = '?param=&odi=SDMS_PeriodAccount&ozr=SDMS_PeriodAccountMonthly';	
		var sURL      = "/ozr/ozReportPop.sg"+param;
		var dlgWidth  = 820;
		var dlgHeight = 630;
		var winName   = "SDMS_PeriodAccountMonthly";
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
				<!--  -->
				<div tabindex="-1" class="x-form-item " style="padding-left: 10px;">
					<img align="center" src="/resource/images/admin/img/checkbox_on.gif"/>
					<a name="DEVDMS_BLReport" id="DEVDMS_BLReport" style="cursor: hand;" onmouseover="this.style.color='blue'" onmouseout="this.style.color='black'">
					<font size="3" style="text-align: center; font-variant: center; padding-left: 3px;"><b><i>주간업무일지</i></b></font>
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
					<font size="3" style="text-align: center; font-variant: center; padding-left: 3px;"><b><i>경비지출현황</i></b></font>
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
					<a name="SDMS_MonthlyAccount" id="SDMS_MonthlyAccount" style="cursor: hand;" onmouseover="this.style.color='blue'" onmouseout="this.style.color='black'">
					<font size="2" style="text-align: center; font-variant: center; padding-left: 3px;"><b>연간경비지출</b></font>
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
					<a name="SDMS_PeriodAccountMonthly" id="SDMS_PeriodAccountMonthly" style="cursor: hand;" onmouseover="this.style.color='blue'" onmouseout="this.style.color='black'">
					<font size="2" style="text-align: center; font-variant: center; padding-left: 3px;"><b>월별전체경비지출내역</b></font>
					</a>
				</div>
				<!-- SDMS_SalesReport -->
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