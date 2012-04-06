<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/web/jsp/common/inc/commonInc.jsp" %>

<c:if test="${pMap.fileCommand == 'uploadFaild'}">
	<script>
		
	</script>	
</c:if>


<script>

function callBack(url){
	document.vForm.action = url;
	document.vForm.submit(); 
}

</script>

<form name='vForm' method='post'>  
 	
</form>

<c:choose>	
	<c:when test="${result == 'true'}">
		<c:choose>
			<c:when test="${pMap.command == 'update'}">
				<script>
					alert('수정하였습니다.');
					callBack('/sgportal/cass/techsup/cassTechsupApp.sg?hmenu_id=010000000&actType=view&c_tech_sup_app_no=${pMap.c_tech_sup_app_no}');
				</script>	
			</c:when>
			
			<c:when test="${pMap.command == 'insert_st1' || pMap.command == 'insert_st2' || pMap.command == 'insert_st3' || pMap.command == 'insert_st'}">
				<script>
					alert('내용을 저장하였습니다.');
					callBack('/sgportal/cass/techsup/cassTechsupApp.sg?hmenu_id=010000000&actType=view&c_tech_sup_app_no=${pMap.c_tech_sup_app_no}');
				</script>	
			</c:when>
			
			
			<c:when test="${pMap.command == 'insert'}">
				<script>
					alert('저장하였습니다.');
					callBack('/sgportal/cass/techsup/cassTechSupAppList.sg?actType=list');
				</script>	
			</c:when>
			
			<c:when test="${pMap.command == 'finish'}">
				<script>
					alert('완료 처리 하였습니다.');
					callBack('/sgportal/cass/techsup/cassTechsupApp.sg?hmenu_id=010000000&actType=view&c_tech_sup_app_no=${pMap.c_tech_sup_app_no}');
				</script>	
			</c:when>
			
			<c:when test="${pMap.command == 'delete_st'}">
				<script>
					alert('삭제 하였습니다.');
					callBack('/sgportal/cass/techsup/cassTechsupApp.sg?hmenu_id=010000000&actType=view&c_tech_sup_app_no=${pMap.c_tech_sup_app_no}');
				</script>	
			</c:when>
		</c:choose>
	</c:when>
	<c:otherwise>
		<c:choose>
			<c:when test="${pMap.command == 'update'}">
				<script>
					alert('수정실패.');
					parent.reloadEvent();
				</script>	
			</c:when>
			
			<c:when test="${pMap.command == 'insert'}">
				<script>
					alert('저장실패.');
					parent.reloadEvent();
				</script>	
			</c:when>
			
			<c:when test="${pMap.command == 'delete'}">
				<script>
					alert('삭제실패.');
					parent.reloadEvent();
				</script>	
			</c:when>
		</c:choose>
	</c:otherwise>
</c:choose>
	
