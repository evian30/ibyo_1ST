<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.signgate.core.web.util.*" %>
<%@ include file="/WEB-INF/web/jsp/common/inc/commonInc.jsp" %>
<script type="text/javascript" src="/resource/common/js/ajax.js"></script>

<c:if test="${pMap.command == 'add'}">
	<script>
		alert('${msg:getString("manage.board.msg.insert")}');
		opener.location.reload();
		location.href="./codeGroupList.sg";
	</script>	
</c:if>

<c:if test="${pMap.command == 'mod'}">
	<script>
		alert('${msg:getString("manage.board.msg.update")}');
		opener.location.reload();
		location.href="./codeGroupList.sg";
	</script>
</c:if>

<c:if test="${pMap.command == 'del'}">
	<script>
		alert('${msg:getString("manage.board.msg.delete")}');
		opener.location.reload();
		location.href="./codeGroupList.sg";
	</script>
</c:if>


<c:if test="${pMap.command == 'codeAdd'}">
	<script>
		alert('${msg:getString("manage.board.msg.insert")}');
		location.href="./codeList.sg";
	</script>	
</c:if>

<c:if test="${pMap.command == 'codeMod'}">
	<script>
		alert('${msg:getString("manage.board.msg.update")}');
		location.href="./codeList.sg";
	</script>
</c:if>


<c:if test="${pMap.command == 'codeDel'}">
	<script>
		alert('${msg:getString("manage.board.msg.delete")}');
		location.href="./codeList.sg";
	</script>
</c:if>