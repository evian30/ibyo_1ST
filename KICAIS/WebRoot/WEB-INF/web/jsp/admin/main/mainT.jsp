<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
 <form name='vForm100' method='post'>
	<input type="hidden" name="logSave" id="logSave"  /> 
 </form>
 
<%@ include file="/WEB-INF/web/jsp/common/inc/commonInc.jsp" %> 

<script language="javascript">
function goSaveLog(){ 
	document.vForm100.logSave.value="1stSave";
	document.vForm100.action = "/sgis/main.sg";
	document.vForm100.submit(); 
}	
goSaveLog();
</script>
 
 
 
