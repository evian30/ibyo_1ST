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
	document.vForm.action ="./boardMstTotal.sg?command=day";
	document.vForm.submit();
}

function jf_month(form){
	document.vForm.action = "./boardMstTotal.sg?command=day";
	document.vForm.submit();
}
//-->
</SCRIPT>

<div id="title_line">
	<div id="title">일별  통계</div>
	<div id="location">${menuNavi} </div>
</div>

<form name='vForm' method='post'>
<table width="100%" border="0" cellpadding="0" cellspacing="0"  id="table_gray" summary="관리자 관리"  class="grid" rules="cols">
	<tr>
		<td width=60>통계조건</td>
		<td>
		<select name='year' onchange="javascript:jf_year(this)">
			<option value='2009' <c:if test="${pMap.year == '2009'}">selected</c:if>>2009</option>
			<option value='2010' <c:if test="${pMap.year == '2010'}">selected</c:if>>2010</option>
			<option value='2011' <c:if test="${pMap.year == '2011'}">selected</c:if>>2011</option>
			<option value='2012' <c:if test="${pMap.year == '2012'}">selected</c:if>>2012</option>
			<option value='2013' <c:if test="${pMap.year == '2013'}">selected</c:if>>2013</option>
		</select> 년
		
		<select name='month' onchange="javascript:jf_month(this)">
			<option value='01' <c:if test="${pMap.month == '01'}">selected</c:if>>01</option>
			<option value='02' <c:if test="${pMap.month == '02'}">selected</c:if>>02</option>
			<option value='03' <c:if test="${pMap.month == '03'}">selected</c:if>>03</option>
			<option value='04' <c:if test="${pMap.month == '04'}">selected</c:if>>04</option>
			<option value='05' <c:if test="${pMap.month == '05'}">selected</c:if>>05</option>
			<option value='06' <c:if test="${pMap.month == '06'}">selected</c:if>>06</option>
			<option value='07' <c:if test="${pMap.month == '07'}">selected</c:if>>07</option>
			<option value='08' <c:if test="${pMap.month == '08'}">selected</c:if>>08</option>
			<option value='09' <c:if test="${pMap.month == '09'}">selected</c:if>>09</option>
			<option value='10' <c:if test="${pMap.month == '10'}">selected</c:if>>10</option>
			<option value='11' <c:if test="${pMap.month == '11'}">selected</c:if>>11</option>
			<option value='12' <c:if test="${pMap.month == '12'}">selected</c:if>>12</option>
		</select> 월
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
					