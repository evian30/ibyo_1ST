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
function jf_year(form){
	location.href="./boardMstTotal.sg?command=month&yeardate="+form.value;
}
//-->
</SCRIPT>

<div id="title_line">
	<div id="title">월별  통계</div>
	<div id="location">${menuNavi} </div>
</div>

<form name='vForm' method='post'>
<table width="100%" border="0" cellpadding="0" cellspacing="0"  id="table_gray" class="grid" rules="cols" summary="관리자 관리">
	<tr>
		<td width=60>통계조건</td>
		<td>
		<select name='year' onchange="javascript:jf_year(this)">
			<option value='2009' <c:if test="${pMap.yeardate == '2009'}">selected</c:if>>2009</option>
			<option value='2010' <c:if test="${pMap.yeardate == '2010'}">selected</c:if>>2010</option>
			<option value='2011' <c:if test="${pMap.yeardate == '2011'}">selected</c:if>>2011</option>
			<option value='2012' <c:if test="${pMap.yeardate == '2012'}">selected</c:if>>2012</option>
			<option value='2013' <c:if test="${pMap.yeardate == '2013'}">selected</c:if>>2013</option>
		</select> 년
		</td>
	</tr>
</table>
</form>
<table width="100%" border="0" cellpadding="0" cellspacing="0"  id="table_gray" rules="cols" class="grid" summary="관리자 관리">
	
	<c:forEach items="${totalList}" var="tList">
	<tr>
		<td width='80'>${tList.TDATE}</td>
		<td width='80' align='right'>${tList.CNT}</td>
		<td width='400'><img src='/resource/manage/board/img/i_jook.gif' width='${tList.CNT * 100 / pMap.TOTAL}%' height='3'></td>
	</tr>
	</c:forEach>
</table>
					