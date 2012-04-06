<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.signgate.core.web.util.*" %>
<%@ include file="/WEB-INF/web/jsp/common/inc/commonInc.jsp" %>
<script type="text/javascript" src="/resource/common/js/ajax.js"></script>

<c:if test="${command.command == 'add'}">
	<script>
		alert('${msg:getString("manage.board.msg.insert")}');
		location.href='./userList.sg';
	</script>	
</c:if>


<c:if test="${command.command == 'mod'}">
	<script>
		alert('${msg:getString("manage.board.msg.update")}');
		location.href='./userModForm.sg?admin_id=${command.admin_id}';
	</script>	
</c:if>


<c:if test="${command.command == 'del'}">
	<script>
		alert('${msg:getString("manage.board.msg.delete")}');
		location.href='./userList.sg';
	</script>	
</c:if>


<c:if test="${command.command == 'pwMod'}">
	<script>
		alert('${msg:getString("manage.board.msg.update")}');
		window.close();
	</script>	
</c:if>