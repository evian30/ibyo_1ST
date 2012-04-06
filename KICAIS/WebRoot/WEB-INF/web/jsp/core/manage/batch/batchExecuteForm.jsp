<!---------------------------------------------------------
 *  jsp설명   : 배치 작업 리스트 
 *  @file   : /WEB-INF/web/jsp/core/manage/batch/batchExecuteT.jsp
 *  @date   : 2009-04-24
 *  @Modified Date : 
 *  @Version  
 *  @Make   : javadori
---------------------------------------------------------->
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/web/jsp/common/inc/commonInc.jsp" %>

<!------------------------------------------------------------------------
 * 레이아웃
-------------------------------------------------------------------------->
<tiles:insertDefinition name="popup" flush="true">
    <tiles:putAttribute name="title" value="batchExecuteForm" />
	<tiles:putAttribute name="body" value="/WEB-INF/web/jsp/core/manage/batch/batchExecuteFormT.jsp" />
</tiles:insertDefinition> 
