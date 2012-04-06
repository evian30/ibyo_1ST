<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/web/jsp/common/inc/commonInc.jsp" %>

<c:if test="${pMap.fileCommand == 'uploadFaild'}">
	<script>
		alert("Uploadfail");
	</script>	
</c:if>
 
<c:choose>	
	<c:when test="${result == 'true'}">
		<c:choose>
			<c:when test="${pMap.command == 'mod'}">
				<script>
					alert('수정하였습니다.');
					document.location.href = '/sgportal/bassCode/bassCodeList.sg?code_sect=${pMap.code_sect}&code=${pMap.code}&cd_type=deTail';
					</script>	
			</c:when>
			
			<c:when test="${pMap.command == 'ins'}">
				<script>
					alert('저장하였습니다.');
					document.location.href = '/sgportal/bassCode/bassCodeList.sg?code_sect=${pMap.code_sect}&code=${pMap.code}&cd_type=deTail';
					</script>	
			</c:when>
			
			<c:when test="${pMap.command == 'del'}">
				<script>
					alert('삭제 하였습니다.');
					document.location.href = '/sgportal/bassCode/bassCodeList.sg?code_sect=${pMap.code_sect}&code=${pMap.code}&cd_type=deTail';
					</script>	
			</c:when>
		</c:choose>
	</c:when>
	<c:otherwise>
		<c:choose>
			<c:when test="${pMap.command == 'mod'}">
				<script>
					alert('수정실패.');
					document.location.href = '/sgportal/bassCode/bassCodeList.sg?code_sect=${pMap.code_sect}&code=${pMap.code}&cd_type=Group';
					</script>	
			</c:when>
			
			<c:when test="${pMap.command == 'ins'}">
				<script>
					alert('저장실패.');
					document.location.href = '/sgportal/bassCode/bassCodeList.sg?code_sect=${pMap.code_sect}&code=${pMap.code}&cd_type=Group';
					</script>	
			</c:when>
			
			<c:when test="${pMap.command == 'del'}">
				<script>
					alert('삭제실패.');
					document.location.href = '/sgportal/bassCode/bassCodeList.sg?code_sect=${pMap.code_sect}&code=${pMap.code}&cd_type=Group';
					</script>	
			</c:when>
		</c:choose>
	</c:otherwise>
</c:choose>
	
