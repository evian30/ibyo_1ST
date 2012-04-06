<!---------------------------------------------------------
 *  jsp설명   : 배치 작업 등록 페이지
 *  @file   : /WEB-INF/web/jsp/core/manage/batch/batchWriteFormT.jsp
 *  @date   : 2009-04-20
 *  @Modified Date : 
 *  @Version  
 *  @Make   : javadori
---------------------------------------------------------->
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/web/jsp/common/inc/commonInc.jsp" %>

<!------------------------------------------------------------------------
 * 레이아웃
-------------------------------------------------------------------------->
<tiles:insertDefinition name="admin" flush="true">
    <tiles:putAttribute name="title" value="batchList" />
	<tiles:putAttribute name="body" value="/WEB-INF/web/jsp/core/manage/batch/batchWriteFormT.jsp" />
</tiles:insertDefinition> 
