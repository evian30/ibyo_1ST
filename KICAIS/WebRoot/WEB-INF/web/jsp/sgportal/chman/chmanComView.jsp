<!---------------------------------------------------------
 *  jsp설명 : 
 *  @file   : 
 *  @date   : 
 *  @Modified Date : 
 *  @Version  
 *  @Make   : 
---------------------------------------------------------->
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/web/jsp/common/inc/commonInc.jsp" %>

<!------------------------------------------------------------------------
 * 레이아웃
-------------------------------------------------------------------------->
<tiles:insertDefinition name="admin" flush="true">
    <tiles:putAttribute name="title" value="chmanComView" />
	<tiles:putAttribute name="body" value="/WEB-INF/web/jsp/sgportal/chman/chmanComViewT.jsp" />
</tiles:insertDefinition> 
