<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.signgate.core.web.util.*" %>
<%@ include file="/WEB-INF/web/jsp/common/inc/commonInc.jsp" %>
<link href="/resource/manage/css/admin_sgf.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="/resource/common/js/ajax.js"></script>


<SCRIPT LANGUAGE="JavaScript">
<!--
function jf_AllCheck(){
	var len = document.vForm.users.length;
	if(document.vForm.allCheck.checked == true){
		for(var i = 0; i < len; i++){
			document.vForm.users[i].checked = true;
		}
	}else{
		for(var i = 0; i < len; i++){
			document.vForm.users[i].checked = false;
		}
	}
}

function jf_userAdd(){
	var len = document.vForm.users.length;
	var admin_id = "";
	for(var i = 0; i < len; i++){
		if(document.vForm.users[i].checked){
			admin_id = admin_id +","+document.vForm.users[i].value;
		}
	}
	
	if(admin_id == ""){
		alert('추가할 사용자를 선택하세요');
	}else{
		document.vForm.admin_id.value = admin_id;
		document.vForm.action = "./userGroupIns.sg";
		document.vForm.submit();
	}	
}

function jf_search(){
	if(document.vForm.keyword.value == ""){
		alert('검색어를 입력하세요.');
		document.vForm.keyword.focus();
		return;
	}
	document.vForm.action = "./userList.sg";
	document.vForm.submit();
}
//-->
</SCRIPT>
<link href="/resource/manage/css/admin_sgf.css" rel="stylesheet" type="text/css">
<form name='vForm' method='post'>
<input type='hidden' name='group_id' value='${pMap.group_id}'>
<input type='hidden' name='admin_id'>
<input type='hidden' name='command' value="useradd">
<br/>
<div id="contents">
<!--search시작-->
<b class="rtop"><b class="r1"></b><b class="r2"></b><b class="r3"></b><b class="r4"></b></b> 
<div class="search">
	<select name='key'>
		<option value='0' <c:if test="${pMap.key == '0' || pMap.key == ''}">selected</c:if>>전체</option>
		<option value='1' <c:if test="${pMap.key == '1'}">selected</c:if> >아이디</option>
		<option value='2' <c:if test="${pMap.key == '2'}">selected</c:if>>이름</option>
		<option value='3' <c:if test="${pMap.key == '3'}">selected</c:if>>회사명</option>
	</select>
	<input type='text' name='keyword' value='${pMap.keyword}' class="Input_w" style="width:250" alt="검색란" onkeypress="javascript:if(event.keyCode=='13'){jf_search();}"/> 
	<img src="/resource/images/bass_1st/btn_search.gif"align="absmiddle" onclick="jf_search()">
  	<img src="/resource/images/bass_1st/btn_refresh.gif" align="absmiddle">
 
</div>
<b class="rbottom"><b class="r4"></b><b class="r3"></b><b class="r2"></b><b class="r1"></b></b>
<!--search끝-->
</div>

<br/>						
<table width="100%" border="0" cellpadding="0" cellspacing="0"  id="table_gray" rules="cols" summary="관리자 관리" class="grid" rules="cols">
<!-- 권한 에 따른 쓰기기능 제어 시작  -->
	<c:if test="${writeGrant != '0' }">	
	<tr>
		<td align='center'><a href='javascript:jf_userAdd()'>[추가]</a></td>
		<td colspan='5'>&nbsp;</td>
	</tr>
	</c:if>
	<tr>
		<th scope="col" id="odd">
			<input type='checkbox' name='allCheck' onclick="javascript:jf_AllCheck()">
			<input type='hidden' name='users'>
		</td>
		<th scope="col" id="odd">사번</td>
		<th scope="col" id="odd">아이디</td>
		<th scope="col" id="odd">이름</td>
		<th scope="col" id="odd">회사명</td>
		<th scope="col" id="odd">이메일</td>
	</tr>
	<c:forEach items="${userList}" var="user" varStatus="i">
	<tr <c:if test="${i.index%2==0}"> bgcolor="#fafafa"</c:if>>
		<td align='center'><input type='checkbox' name='users' value='${user.ADMIN_ID}'></td>
		<td align='center' width="50">${user.SABUN}</td>
		<td align='center' width="70">${user.ADMIN_ID}</td>
		<td align='center' width="70">${user.ADMIN_NM}</td>
		<td align='center' width="70">${user.COR_NM}</td>
		<td align='left' style="padding-left: 5px">${user.ADMIN_MAIL}</td>
	</tr>
	</c:forEach>
	<!-- 권한 에 따른 쓰기기능 제어 시작  -->
	<c:if test="${writeGrant != '0' }">	
	<tr>
		<td align='center'><a href='javascript:jf_userAdd()'>[추가]</a></td>
		<td colspan='5'>&nbsp;</td>
	</tr>
	</c:if>
</table>
<br/>
<div class="paging">
	${pageNavi.pageNavigator}
</div>			

</form>
