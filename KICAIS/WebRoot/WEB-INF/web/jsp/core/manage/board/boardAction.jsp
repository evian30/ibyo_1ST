<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.signgate.core.web.util.*" %>
<%@ include file="/WEB-INF/web/jsp/common/inc/commonInc.jsp" %>
<script type="text/javascript" src="/resource/common/js/ajax.js"></script>


<script>

function callBack(url){
	document.vForm.action = url;
	document.vForm.submit(); 
}

</script>

<form name='vForm' method='post'>  
 	
</form>

<c:if test="${pMap.command == 'add'}">
	<script>
		alert('${msg:getString("manage.board.msg.insert")}');
		callBack("./boardList.sg?board_id=${pMap.board_id}");
	</script>	
</c:if>


<c:if test="${pMap.command == 'mod'}">
	<script>
		alert('${msg:getString("manage.board.msg.update")}');
		callBack("./boardModify.sg?board_id=${pMap.board_id}&board_seq=${pMap.board_seq}");
	</script>	
</c:if>


<c:if test="${pMap.command == 'del'}">
	<script>
		alert('${msg:getString("manage.board.msg.delete")}');
		callBack("./boardList.sg?board_id=${pMap.board_id}");
	</script>	
</c:if>


<c:if test="${pMap.command == 'uploadFaild'}">
	<script>
		alert('${pMap.msg}');
		callBack("./boardList.sg?board_id=${pMap.board_id}");
	</script>	
</c:if>

<c:if test="${pMap.command == 'talk_add'}">
	<script>
		alert('${msg:getString("manage.board.msg.insert")}');
		callBack("./boardView.sg?board_id=${pMap.board_id}&board_seq=${pMap.board_seq}");
	</script>	
</c:if>

<c:if test="${pMap.command == 'talkDelete'}">
	<script>
		alert('${msg:getString("manage.board.msg.delete")}');
		callBack("./boardView.sg?board_id=${pMap.board_id}&board_seq=${pMap.board_seq}");
	</script>	
</c:if>

<c:if test="${pMap.command == 'fileDel'}">
	<script>
		alert('${msg:getString("manage.board.msg.delete")}');
		callBack("./boardModify.sg?board_id=${pMap.board_id}&board_seq=${pMap.board_seq}");
	</script>	
</c:if>


<c:if test="${pMap.command == 'passwdfaild'}">
	<script>
		alert('${msg:getString("manage.board.msg.passwd")}');
		callBack("./boardList.sg?board_id=${pMap.board_id}");
	</script>	
</c:if>