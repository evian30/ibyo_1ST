<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.signgate.core.web.util.*" %>
<%@ include file="/WEB-INF/web/jsp/common/inc/commonInc.jsp" %>
<script type="text/javascript" src="/resource/common/js/ajax.js"></script>

<c:if test="${map.command == 'add'}">
	<script>
		alert('${msg:getString("manage.board.msg.insert")}');
		location.href="./boardMstList.sg";
	</script>	
</c:if>


<c:if test="${map.command == 'mod'}">
	<script>
		alert('${msg:getString("manage.board.msg.update")}');
		location.href="./boardMstList.sg";
	</script>	
</c:if>


<c:if test="${map.command == 'del'}">
	<script>
		alert('${msg:getString("manage.board.msg.delete")}');
		location.href="./boardMstList.sg";
	</script>	
</c:if>


<c:if test="${map.command == 'faqAdd'}">
	<script>
		alert('${msg:getString("manage.board.msg.insert")}');
		location.href="./boardMstMod.sg?board_id=${map.board_id}";
	</script>	
</c:if>

<c:if test="${map.command == 'faqMod'}">
	<script>
		alert('${msg:getString("manage.board.msg.update")}');
		location.href="./boardMstMod.sg?board_id=${map.board_id}";
	</script>	
</c:if>

<c:if test="${map.command == 'faqDel'}">
	<script>
		alert('${msg:getString("manage.board.msg.delete")}');
		location.href="./boardMstMod.sg?board_id=${map.board_id}";
	</script>	
</c:if>