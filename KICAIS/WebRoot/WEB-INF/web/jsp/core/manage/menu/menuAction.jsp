<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/web/jsp/sgis-top-inc.jsp" %> 

<script type="text/javascript" src="/resource/common/js/ajax.js"></script>

<c:if test="${map.command == 'add'}">
	<script>
		alert('${msg:getString("manage.board.msg.insert")}');
		//opener.location.href="/core/manage/menu/menuManage.sg?menu_id=${map.menu_id}&menu_thread=${map.menu_thread}";
		opener.loadUrl("메뉴 관리", '/core/manage/menu/menuManage.sg?menu_id=${map.menu_id}&menu_thread=${map.menu_thread}');
		window.close();
	</script>	
</c:if>


<c:if test="${map.command == 'pos'}">
	<script>
		//location.href="/core/manage/menu/menuManage.sg?menu_id=${map.menu_id}&menu_thread=${map.menu_thread}";
		window.location.href="/sgis/main.sg?actK=menu&menu_id=${map.menu_id}&menu_thread=${map.menu_thread}";
		
	</script>	
</c:if>


<c:if test="${map.command == 'group'}">
	<script>
		//opener.jf_getMenu('${map.menu_id}'); window.close();
		opener.loadUrl("메뉴 관리", '/');
		window.close();
		
	</script>	
</c:if>


<c:if test="${map.command == 'update'}">
	<script>
		alert('${msg:getString("manage.board.msg.update")}'); 
		//location.href="/core/manage/menu/menuManage.sg?command=update&menu_id=${map.menu_id}&menu_thread=${map.menu_thread}";
		//loadUrl("메뉴 관리", '/');
		location.href="/";
	</script>	
</c:if>


<c:if test="${map.command == 'del'}">
	<script>
		alert('${msg:getString("manage.board.msg.delete")}');
		//location.href='/core/manage/menu/menuManage.sg';
		location.href="/";
	</script>	
</c:if>