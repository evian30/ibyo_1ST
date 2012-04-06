<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/web/jsp/common/inc/commonInc.jsp" %>
 
<tiles:insertDefinition name="admin" flush="true">
    <tiles:putAttribute name="title" value="weekSchedule" />
	<tiles:putAttribute name="body" value="/WEB-INF/web/jsp/sgportal/schedule/weekScheduleT.jsp" />
</tiles:insertDefinition> 