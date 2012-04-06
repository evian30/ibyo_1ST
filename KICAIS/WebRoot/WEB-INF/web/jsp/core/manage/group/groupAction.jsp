<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%> 

<%@ include file="/WEB-INF/web/jsp/sgis-top-inc.jsp" %> 


<script type="text/javascript" src="/resource/common/js/ajax.js"></script>

<c:if test="${command.command == 'add'}">
	<script type="text/javascript">
		alert('${msg:getString("manage.board.msg.insert")}');
		//location.href='/core/manage/group/groupList.sg';
		//loadUrl("그룹사용자 관리", '/');
		location.href="/";
	</script>	
</c:if>


<c:if test="${command.command == 'mod'}">
	<script type="text/javascript">
		alert('${msg:getString("manage.board.msg.update")}');
		//location.href='/core/manage/group/groupList.sg';
		location.href="/";
	</script>	
</c:if>


<c:if test="${command.command == 'del'}">
	<script type="text/javascript">
		alert('${msg:getString("manage.board.msg.delete")}');
		//location.href='/core/manage/group/groupList.sg';
		location.href="/";
	</script>	
</c:if>

<c:if test="${command.command == 'useradd'}">
	<script type="text/javascript">
		alert('${msg:getString("manage.board.msg.insert")}');
		opener.loadUrl("그룹사용자 관리", '/core/manage/group/groupUsersList.sg?group_id=${command.group_id}');
		window.close();
		
	</script>	
</c:if>

<c:if test="${command.command == 'userdel'}">
	<script type="text/javascript">
		alert('${msg:getString("manage.board.msg.delete")}');
		//location.href='/core/manage/group/groupUsersList.sg?group_id=${command.group_id}';
		location.href="/";
		
	</script>	
</c:if>
 
<body id='basicLayoutBody'>


<%@ include file="/WEB-INF/web/jsp/sgis-bottom-inc.jsp" %>