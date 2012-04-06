<%--
  Class Name  : calendar.jsp
  Description : 일정관리
  Modification Information
 
      수정일                   수정자                 수정내용
  -------      --------    ---------------------------
  2011. 4. 05   여인범            최초 생성   
  
  author   : 여인범
  since    : 2011. 4. 05.
  version  : 1.0
   
  Copyright (C) 2011 by SG All right reserved.
--%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/web/jsp/common/inc/commonInc.jsp" %>
<html>
<head>
    <title>일정관리</title> 
  <script type="text/javascript"> 
    
    var viewType;
    
    if('<%=request.getParameter("calMon")%>'=='Yes'){
		viewType = 1;
	}else{
		viewType = 2;
	}
    
    
    </script>
    
    <link rel="stylesheet" type="text/css" href="/resource/common/js/ext3/resources/css/ext-all.css" />
    <script type="text/javascript" src="/resource/common/js/ext3/adapter/ext/ext-base.js"></script>
	<script type="text/javascript" src="/resource/common/js/ext3/ext-all-debug.js"></script>
 
    <script type="text/javascript" src="/resource/common/js/common/common-msg-box.js"></script> 
    <script type="text/javascript" src="/resource/common/js/sgis-comm-inc.js"></script> 
      
    <!-- Calendar-specific includes -->
	<link rel="stylesheet" type="text/css" href="/resource/common/js/calendar/resources/css/calendar.css" />
    <script type="text/javascript" src="/resource/common/js/calendar/src/Ext.calendar.js"></script>
    <script type="text/javascript" src="/resource/common/js/calendar/src/templates/DayHeaderTemplate.js"></script>
    <script type="text/javascript" src="/resource/common/js/calendar/src/templates/DayBodyTemplate.js"></script>
    <script type="text/javascript" src="/resource/common/js/calendar/src/templates/DayViewTemplate.js"></script>
    <script type="text/javascript" src="/resource/common/js/calendar/src/templates/BoxLayoutTemplate.js"></script>
    <script type="text/javascript" src="/resource/common/js/calendar/src/templates/MonthViewTemplate.js"></script>
    <script type="text/javascript" src="/resource/common/js/calendar/src/dd/CalendarScrollManager.js"></script>
    <script type="text/javascript" src="/resource/common/js/calendar/src/dd/StatusProxy.js"></script>
    <script type="text/javascript" src="/resource/common/js/calendar/src/dd/CalendarDD.js"></script>
    <script type="text/javascript" src="/resource/common/js/calendar/src/dd/DayViewDD.js"></script>
    <script type="text/javascript" src="/resource/common/js/calendar/src/EventRecord.js"></script>
	<script type="text/javascript" src="/resource/common/js/calendar/src/views/MonthDayDetailView.js"></script>
    
    <script type="text/javascript" src="/resource/common/js/calendar/src/widgets/CalendarPicker.js"></script>
    <script type="text/javascript" src="/resource/common/js/calendar/src/widgets/ProcPicker.js"></script> 
    <script type="text/javascript" src="/resource/common/js/calendar/src/widgets/StatusPicker.js"></script> 
    <script type="text/javascript" src="/resource/common/js/calendar/src/widgets/WorkTypePicker.js"></script>
    <script type="text/javascript" src="/resource/common/js/calendar/src/widgets/TaskGroupPicker.js"></script> 
        
    <script type="text/javascript" src="/resource/common/js/calendar/src/WeekEventRenderer.js"></script>
    <script type="text/javascript" src="/resource/common/js/calendar/src/views/CalendarView.js"></script>
    <script type="text/javascript" src="/resource/common/js/calendar/src/views/MonthView.js"></script>
    <script type="text/javascript" src="/resource/common/js/calendar/src/views/DayHeaderView.js"></script>
    <script type="text/javascript" src="/resource/common/js/calendar/src/views/DayBodyView.js"></script>
    <script type="text/javascript" src="/resource/common/js/calendar/src/views/DayView.js"></script>
    <script type="text/javascript" src="/resource/common/js/calendar/src/views/WeekView.js"></script>
    <script type="text/javascript" src="/resource/common/js/calendar/src/widgets/DateRangeField.js"></script>
    <script type="text/javascript" src="/resource/common/js/calendar/src/widgets/ReminderField.js"></script>
    
    <script type="text/javascript" src="/resource/common/js/calendar/src/EventEditForm.js"></script>
    
    <script type="text/javascript" src="/resource/common/js/calendar/src/EventEditWindow.js"></script>
    <script type="text/javascript" src="/resource/common/js/calendar/src/CalendarPanel.js"></script>
	<script type="text/javascript" src="/resource/common/js/ext3/src/locale/ext-lang-ko.js" charset="utf-8"></script> 
	
    <!-- App -->
    <link rel="stylesheet" type="text/css" href="/resource/common/js/calendar/resources/css/sg-calendar.css" />
    <script type="text/javascript" src="/resource/common/js/calendar/app/app.js"></script>
    
<style type="text/css">
/*달력의 범례 표시를 위한 CSS 범례의 수 만 큼 해당 css를 추가 해야 함  - 시작 */
<c:forEach items="${SCD_TYPE_CODE}" var="data" varStatus="status"> 
.ext-color-${status.index+1},
.ext-ie .ext-color-${status.index+1}-ad,
.ext-opera .ext-color-${status.index+1}-ad {
    color: #${data.REF_VAL_01};
}
.ext-cal-day-col .ext-color-${status.index+1},
.ext-dd-drag-proxy .ext-color-${status.index+1},
.ext-color-${status.index+1}-ad,
.ext-color-${status.index+1}-ad .ext-cal-evm,
.ext-color-${status.index+1} .ext-cal-picker-icon,
.ext-color-${status.index+1}-x dl,
.ext-color-${status.index+1}-x .ext-cal-evb {
    background: #${data.REF_VAL_01};
}
.ext-color-${status.index+1}-x .ext-cal-evb,
.ext-color-${status.index+1}-x dl {
    border-color: #29527A;
} 
</c:forEach>
/*달력의 범례 표시를 위한 CSS 범례의 수 만 큼 해당 css를 추가 해야 함  - 종료 */
</style>


<script type="text/javascript"> 
Ext.onReady(App.init, App); 
	/**입력 폼의 콤보 박스의 데이터 가져오기 (공통코드, 부서, 사원, 타스크 등...)**/
	var calendarList = {
    "calendars":[  
       //업무구분
    	<c:forEach items="${SCD_TYPE_CODE}" var="data" varStatus="status"> 
	       <c:if test="${data.COM_CODE != '01'}"> 
		       	 {
		           "cid":"${data.REF_VAL_02}",
		           "title":"${data.COM_CODE_NAME}",
		           "id":"${data.SORT_NUM}"
		         }
		       	 <c:if test="${not status.last}">,</c:if>
       	   </c:if>  
       </c:forEach>
      ], 
       
      "proc":[ 
      //계획/수행코드
       <c:forEach items="${PROC_TYPE_CODE}" var="data" varStatus="status"> 
	       	 { 
	       		"proc_type_code":"${data.COM_CODE}"
	           ,"proc_type_nm":"${data.COM_CODE_NAME}"
	         }
	       	 <c:if test="${not status.last}">,</c:if>
       </c:forEach>
       ],
       
       
       "status":[ 
      //일정상태
       <c:forEach items="${STATUS_VAL}" var="data" varStatus="status"> 
	       	 { 
	       		"status_val":"${data.COM_CODE}"
	           ,"status_nm":"${data.COM_CODE_NAME}"
	         }
	       	 <c:if test="${not status.last}">,</c:if>
       </c:forEach>
       ],
       
       
      "workType":[ 
      //내외근 구분
       <c:forEach items="${WORK_TYPE_CODE}" var="data" varStatus="status"> 
	       	 { 
	       		"work_pattern_code":"${data.COM_CODE}"
	           ,"work_pattern_nm":"${data.COM_CODE_NAME}"
	         }
	       	 <c:if test="${not status.last}">,</c:if>
       </c:forEach>
       ],
       
       
      "taskGroup":[ 
      //타스크그룹
      <c:forEach items="${TASK_GROUP_CODE}" var="data" varStatus="status"> 
	       	 {
	           "task_group_code":"${data.COM_CODE}",
	           "task_group_nm":"${data.COM_CODE_NAME}"
	         }
	       	 <c:if test="${not status.last}">,</c:if>
       </c:forEach>
      ]
       
       
      
}; 

//일정 추가 폼에 매핑되는 VALUE 값들
var today = new Date().clearTime();

var eventList = {
    "evts": [
    <c:forEach items="${ScheduleList}" var="data" varStatus="status">
      {
	     	"id"					:"${status.index+1}"
		    ,"cid"					:"${data.SCD_TYPE_CODE}"
		    ,"title"				:"${data.SCD_PROC_RES_CONTENT}"
		    
		    ,"start"				:today.add(Date.DAY, ${data.SCD_SDATE}).add(Date.HOUR, ${fn:substring(data.SCD_TIME_FROM, 0, 2)}).add(Date.MINUTE, ${fn:substring(data.SCD_TIME_FROM, 3,5)})
		    ,"end"					:today.add(Date.DAY, ${data.SCD_EDATE}).add(Date.HOUR, ${fn:substring(data.SCD_TIME_TO, 0, 2)}).add(Date.MINUTE, ${fn:substring(data.SCD_TIME_TO, 3, 5)})
		    
		    ,"ad"					:
		    	<c:choose>
			    	<c:when test="${data.SCD_TYPE_CODE=='01' || data.SCD_TIME_TO=='00:00:00'}">
		    			true
		    		</c:when>
			    	<c:when test="${data.SCD_TYPE_CODE!='01' && data.SCD_TIME_TO!='00:00:00'}">
		    			false
		    		</c:when>
		    	</c:choose>
		    ,"n"					:true
		       
			,"scd_day_seq"			:"${data.SCD_DAY_SEQ}"
			,"scd_type_code"		:"${data.SCD_TYPE_CODE}"
			,"scd_type_nm"			:"${data.SCD_TYPE_NM}"
			
			,"proc_type_code"		:"${data.PROC_TYPE_CODE}"
			,"proc_type_nm"			:"${data.PROC_TYPE_NM}"
			
			,"scd_day_reg_dept"		:"${data.SCD_DAY_REG_DEPT}"
			,"scd_day_reg_emp_num"	:"${data.SCD_DAY_REG_EMP_NUM}"
			,"status_val"			:"${data.STATUS_VAL}"
			,"status_nm"			:"${data.STATUS_nm}"
			
			,"work_pattern_code"	:"${data.WORK_PATTERN_CODE}"
			,"work_pattern_nm"		:"${data.WORK_PATTERN_NM}"
			
			,"scd_date"				:"${data.SCD_DATE}"
			,"scd_time_from"		:"${data.SCD_TIME_FROM}"
			,"scd_time_to"			:"${data.SCD_TIME_TO}"
			,"scd_time"				:"${data.SCD_TIME}"
			,"labor_cost"			:"${data.LABOR_COST}"
			,"pjt_id"				:"${data.PJT_ID}"
			,"pjt_nm"				:"${data.PJT_NM}"
			,"task_group_code"		:"${data.TASK_GROUP_CODE}"
			,"task_code"			:"${data.TASK_CODE}"
			
			,"task_group_nm"		:"${data.TASK_GROUP_NM}"
			,"task_nm"				:"${data.TASK_NM}"
			
			,"pay_no"				:"${data.PAY_NO}"
			,"visit_report_no"		:"${data.VISIT_REPORT_NO}"
			
			,"scd_proc_res_content"	:"${data.SCD_PROC_RES_CONTENT}"
			
			/***,"note"					:"${data.NOTE}"**/
			,"pjt_status"			:"${data.PJT_STATUS}"
			                         
			,"final_mod_id"			:"${data.FINAL_MOD_ID}"
			,"final_mod_date"		:"${data.FINAL_MOD_DATE}"
			,"reg_id"				:"${data.REG_NM}"
			,"reg_date"				:"${data.REG_DATE}"
				
      }
      <c:if test="${not status.last}">,</c:if>     
    </c:forEach> 
	    
    ]
};  



var calendarListMapping = [
	
	
 
		    
						     {name:'CalendarId'				, mapping:'cid'					 , type: 'int'}
						    ,{name:'EventId'				, mapping:'id'					 , type: 'string'}
						    ,{name:'Title'					, mapping:'title'				 , type: 'string'}
						    ,{name:'StartDate'				, mapping:'start'				 , type: 'string'}
						    ,{name:'EndDate'				, mapping:'end'					 , type: 'string'}						    
						     
						    ,{name:"scd_day_seq"			, mapping:"scd_day_seq"			 , type:"string"}
							
						    ,{name:"scd_type_code"			, mapping:"scd_type_code"		 , type:"string"}
							,{name:"scd_type_nm"			, mapping:"scd_type_nm"		 	 , type:"string"}
							
							,{name:"proc_type_code"			, mapping:"proc_type_code"		 , type:"string"}
							,{name:"proc_type_nm"			, mapping:"proc_type_nm"		 , type:"string"}
							
							,{name:"scd_day_reg_dept"		, mapping:"scd_day_reg_dept"	 , type:"string"}
							,{name:"scd_day_reg_emp_num"    , mapping:"scd_day_reg_emp_num"  , type:"string"}
							,{name:"status_val"				, mapping:"status_val"			 , type:"string"}
							,{name:"status_nm"				, mapping:"status_nm"			 , type:"string"}
							
							,{name:"work_pattern_code"	    , mapping:"work_pattern_code"	 , type:"string"}
							,{name:"work_pattern_nm"	    , mapping:"work_pattern_nm"	 	 , type:"string"}
							
							,{name:"scd_date"				, mapping:"scd_date"			 , type:"string"}
							,{name:"scd_time_from"			, mapping:"scd_time_from"		 , type:"string"}
							,{name:"scd_time_to"			, mapping:"scd_time_to"			 , type:"string"}
							,{name:"scd_time"				, mapping:"scd_time"			 , type:"string"}
							,{name:"labor_cost"				, mapping:"labor_cost"			 , type:"int"}
							,{name:"pjt_id"					, mapping:"pjt_id"				 , type:"string"}
							,{name:"pjt_nm"					, mapping:"pjt_nm"				 , type:"string"}
							,{name:"task_group_code"		, mapping:"task_group_code"		 , type:"string"}
							,{name:"task_code"				, mapping:"task_code"			 , type:"string"}
							
							,{name:"task_group_nm"			, mapping:"task_group_nm"		 , type:"string"}
							,{name:"task_nm"				, mapping:"task_nm"			 	 , type:"string"}
														
							,{name:"pay_no"					, mapping:"pay_no"				 , type:"string"}
							,{name:"visit_report_no"		, mapping:"visit_report_no"		 , type:"string"}
							,{name:"scd_proc_res_content"   , mapping:"scd_proc_res_content" , type:"string"}
							,{name:"note"					, mapping:"note"				 , type:"string"}
							,{name:"pjt_status"				, mapping:"pjt_status"			 , type:"string"}
							,{name:"final_mod_id"			, mapping:"final_mod_id"		 , type:"string"}
							,{name:"final_mod_date"			, mapping:"final_mod_date"		 , type:"string"}
							,{name:"reg_id"					, mapping:"reg_id"		 		 , type:"string"}
							,{name:"reg_date"				, mapping:"reg_date"		 	 , type:"string"}
						     
						 ]; 
</script>
	
</head>
<body> 
    <div style="display:none;">
    <div id="app-header-content">
        
        <div id="app-logo">
            <div class="logo-top">&nbsp;</div>
            <div id="logo-body">&nbsp;</div>
            <div class="logo-bottom">&nbsp;</div>
        </div>
        <h1>KICA IS 개인별 일정 캘린더</h1>
        
        <span id="app-msg" class="x-hidden"></span>
    </div>
    </div>
</body>
<script>
	/* 
    var updateLogoDt = function(){
        document.getElementById('logo-body').innerHTML = new Date().getDate();
    }
    updateLogoDt();
    setInterval(updateLogoDt, 1000);
    */
</script>
</html>