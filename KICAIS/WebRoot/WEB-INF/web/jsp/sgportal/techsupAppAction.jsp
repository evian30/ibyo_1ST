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
			
			<c:when test="${pMap.command == 'ins_talk'}">
				<script>
					alert('저장 하였습니다.');
					document.location.href = '/sgportal/techsup/techsupApp1.sg?actType=view&tech_sup_app_no=${pMap.tech_sup_app_no}';
					</script>	
			</c:when>
			<c:when test="${pMap.command == 'del_talk'}">
				<script>
					alert('삭제 하였습니다.'); 
					document.location.href = '/sgportal/techsup/techsupApp1.sg?actType=view&tech_sup_app_no=${pMap.tech_sup_app_no}';
					</script>	
			</c:when>
		
		
		
			<c:when test="${pMap.command == 'upd'}">
				<script>
					alert('수정하였습니다.');
					//document.location.href = '/sgportal/chman/chmanList.sg';
					</script>	
			</c:when>
			<c:when test="${pMap.command == 'del'}">
				<script>
					alert('삭제 하였습니다.');
					parent.reloadEvent();
					</script>	
			</c:when>
			<c:when test="${pMap.command == 'ins'}">
				<script>
					alert('저장 하였습니다.');
					
					parent.document.location.href = '/sgportal/techsup/techsupApp.sg?actType=list';
					</script>	
			</c:when>
			<c:when test="${pMap.command == 'appIns'}">
				<script>
					alert('저장 하였습니다.');
					
					//callBack('/sgportal/techsup/techsupApp.sg?actType=view&tech_sup_app_no=${pMap.tech_sup_app_no}');
					
					parent.document.location.href = '/sgportal/techsup/techsupApp.sg?actType=view&tech_sup_app_no=${pMap.tech_sup_app_no}';
					
					//parent.document.location.href = '/sgportal/techsup/techsupAppList.sg?actType=list';
					</script>	
			</c:when>
			<c:when test="${pMap.command == 'appMod'}">
				<script>
					alert('수정 하였습니다.');
					parent.document.location.href = '/sgportal/techsup/techsupAppList.sg?actType=list';
					</script>	
			</c:when>
			<c:when test="${pMap.command == 'status2'}">
				<script>
					alert('배정이 완료되었습니다.');
					parent.f_app_status('${pMap.tech_sup_app_no}');
					</script>	
			</c:when>
			<c:when test="${pMap.command == 'status3'}">
				<script>
					alert('일정이 완료되었습니다.');
					parent.f_app_status('${pMap.tech_sup_app_no}');
				</script>	
			</c:when>
			<c:when test="${pMap.command == 'ins_status1'}">
				<script>
					alert('요청 하였습니다.');
					parent.parent.f_app_status('${pMap.tech_sup_app_no}');
				</script>	
			</c:when>
			<c:when test="${pMap.command == 'ins_status3'}">
				<script>
					alert('접수 하였습니다.');
					parent.parent.f_app_status('${pMap.tech_sup_app_no}');
				</script>	
			</c:when>
			<c:when test="${pMap.command == 'ins_status4'}">
				<script>
					alert('반려 하였습니다.');
					parent.parent.f_app_status('${pMap.tech_sup_app_no}');
				</script>	
			</c:when>
			<c:when test="${pMap.command == 'ins_status9'}">
				<script>
					alert('반려 하였습니다.');
					parent.parent.f_app_status('${pMap.tech_sup_app_no}');
				</script>	
			</c:when>
			<c:when test="${pMap.command == 'ins_status6'}">
				<script>
					alert('저장 하였습니다.');
					parent.parent.f_app_tech_sup('${pMap.tech_sup_app_no}');
					parent.parent.f_app_status('${pMap.tech_sup_app_no}');
				</script>	
			</c:when>
			<c:when test="${pMap.command == 'mod_status6'}">
				<script>
					alert('수정 하였습니다.');
					parent.parent.f_app_tech_sup('${pMap.tech_sup_app_no}');
					parent.parent.f_app_status('${pMap.tech_sup_app_no}');
				</script>	
			</c:when>
			<c:when test="${pMap.command == 'ins_status7'}">
				<script>
					alert('검토요청을 하였습니다.');
					parent.parent.f_app_tech_sup('${pMap.tech_sup_app_no}');
					parent.parent.f_app_status('${pMap.tech_sup_app_no}');
				</script>	
			</c:when>
			<c:when test="${pMap.command == 'ins_status8'}">
				<script>
					alert('승인이 완료되었습니다.');
					parent.parent.f_app_tech_sup('${pMap.tech_sup_app_no}');
					parent.parent.f_app_status('${pMap.tech_sup_app_no}');
				</script>
			</c:when>
			<c:when test="${pMap.command == 'ins_status10'}">
				<script>
					alert('요청보류 되었습니다.');
					parent.parent.f_app_tech_sup('${pMap.tech_sup_app_no}');
					parent.parent.f_app_status('${pMap.tech_sup_app_no}');
				</script>	
			</c:when>	
		</c:choose>
	</c:when>
	<c:otherwise>
		<c:choose>
			<c:when test="${pMap.command == 'upd'}">
				<script>
					alert('수정실패.');
					parent.reloadEvent();
					</script>	
			</c:when>
			
			<c:when test="${pMap.command == 'ins'}">
				<script>
					alert('저장실패.');
					parent.reloadEvent();
					</script>	
			</c:when>
			
			<c:when test="${pMap.command == 'del'}">
				<script>
					alert('삭제실패.');
					parent.reloadEvent();
					</script>	
			</c:when>
		</c:choose>
	</c:otherwise>
</c:choose>
	
