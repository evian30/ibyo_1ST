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
			<c:when test="${pMap.command == 'upd'}">
				<script>
					alert('수정하였습니다.');
					
					callBack('/sgportal/chman/chmanComView.sg?comT=${pMap.comT}&hmenu_id=${pMap.hmenu_id}&actType=view&corp_no=${pMap.corp_no}')
					//document.location.href = '/sgportal/chman/chmanComView.sg?comT=${pMap.comT}&hmenu_id=${pMap.hmenu_id}&actType=view&corp_no=${pMap.corp_no}';
				</script>	
			</c:when>
			
			<c:when test="${pMap.command == 'ins'}">
				<script>
					alert('저장하였습니다.'); 
					if('${pMap.returnType}'=='techsup'){
						callBack('/sgportal/techsup/techsupList.sg?hmenu_id=${pMap.hmenu_id}');
						//document.location.href = '/sgportal/techsup/techsupList.sg?hmenu_id=${pMap.hmenu_id}';
					}else{
						callBack('/sgportal/chman/chmanComList.sg?comT=${pMap.comT}&hmenu_id=${pMap.hmenu_id}');
						//document.location.href = '/sgportal/chman/chmanComList.sg?comT=${pMap.comT}&hmenu_id=${pMap.hmenu_id}';
					}
					
				</script>	
			</c:when>
			
			<c:when test="${pMap.command == 'del'}">
				<script>
					alert('삭제 하였습니다.');
					
					callBack('/sgportal/techsup/techsupList.sg');
					//document.location.href = '/sgportal/techsup/techsupList.sg';
				</script>	
			</c:when>
			
			<c:when test="${pMap.command == 'delY'}">
				<script>
					alert('복구 하였습니다.');
					callBack('/sgportal/techsup/techsupList.sg');
					//document.location.href = '/sgportal/techsup/techsupList.sg';
				</script>	
			</c:when>
		</c:choose>
	</c:when>
	<c:otherwise>
		<c:choose>
			<c:when test="${pMap.command == 'upd'}">
				<script>
					alert('수정실패.');
					callBack('/sgportal/chman/chmanComList.sg?comT=${pMap.comT}&hmenu_id=${pMap.hmenu_id}');
					</script>	
			</c:when>
			
			<c:when test="${pMap.command == 'ins'}">
				<script>
					alert('저장실패.');
					callBack('/sgportal/chman/chmanComList.sg?comT=${pMap.comT}&hmenu_id=${pMap.hmenu_id}');
					</script>	
			</c:when>
			
			<c:when test="${pMap.command == 'del'}">
				<script>
					alert('삭제실패.');
					callBack('/sgportal/chman/chmanComList.sg?comT=${pMap.comT}&hmenu_id=${pMap.hmenu_id}');
					</script>	
			</c:when>
		</c:choose>
	</c:otherwise>
</c:choose>
	
