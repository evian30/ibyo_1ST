<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/web/jsp/common/inc/commonInc.jsp" %>

<SCRIPT LANGUAGE="JavaScript">
<!--
function jf_submit(){

	if(document.vForm.bname.value == ""){
		alert('게시판 이름을 입려하세요..');
		document.vForm.bname.focus();
		return;
	}

	document.vForm.command.value = "add";
	document.vForm.action='boardMst/boardMstController.sg';
	document.vForm.submit();
}

//-->
</SCRIPT>

<div id="title_line">
	<div id="title">년도별  통계</div>
	<div id="location">${menuNavi} </div>
</div>

<table width="100%" border="0" cellpadding="0" cellspacing="0"  id="table_gray" class="grid" rules="cols" summary="관리자 관리">
	
	<c:forEach items="${totalList}" var="tList">
	<tr>
		<td width='80'>${tList.TDATE}</td>
		<td width='80' align='right'>${tList.CNT}</td>
		<td width='400'><img src='/resource/manage/board/img/i_jook.gif' width='${tList.CNT * 100 / pMap.TOTAL}%' height='3'></td>
	</tr>
	</c:forEach>
</table>
					