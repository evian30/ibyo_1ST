<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/web/jsp/common/inc/commonInc.jsp" %>
<script>	
	if("${error}" != "error")
	{
		if("${pMap.chk}" == "modify") alert("수정 하였습니다.");	
		else if("${pMap.chk}" == "write")
		{
			if("${blExt}" == "true")
			{
				alert("일정이 존재합니다.");
				
			}		
			else alert("작성 하였습니다.");
		}
		else if("${pMap.chk}" == "delete") alert("삭제 하였습니다.");	
		
	
		if("${blExt}" == "true" && "${pMap.chk}" == "write")
		{
			alert('xxx');
			location.href = "./scheduleWrite.sg?yodate=${pMap.yodate}&amp;yotime=${pMap.yotime}&amp;gubun=week&amp;year=${pMap.year}&amp;year=${pMap.month}";
			opener.document.location = '/sgportal/techsup/techsupApp4.sg?tech_sup_app_no=${pMap.tech_sup_app_no}';
			
		}
		else
		{
			
			if("${pMap.gubun}" == "month"){		
				//opener.document.location.href = "./monthSchedule.sg?year=${pMap.year}&amp;month=${pMap.month}";
				opener.document.location = '/sgportal/techsup/techsupApp4.sg?tech_sup_app_no=${pMap.tech_sup_app_no}';
			}
			else
			{
				//opener.document.location.href = "./weekSchedule.sg?schWeek=${pMap.schWeek}";
				opener.document.location = '/sgportal/techsup/techsupApp4.sg?tech_sup_app_no=${pMap.tech_sup_app_no}';
			}
		
			self.close();	
		}
	}
	else
	{
		alert("처리중 에러발생!");
		//opener.document.location.href = "./monthSchedule.sg?year=${pMap.year}&amp;year=${pMap.month}";
		opener.document.location = '/sgportal/techsup/techsupApp4.sg?tech_sup_app_no=${pMap.tech_sup_app_no}';
		self.close();	
	}
		
</script>