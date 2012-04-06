<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.signgate.core.web.util.*" %>
<%@ include file="/WEB-INF/web/jsp/common/inc/commonInc.jsp" %>
<script type="text/javascript" src="/resource/common/js/ajax.js"></script>
<SCRIPT LANGUAGE="JavaScript">
<!--
function jf_submit(){
	document.vForm.action = "./userUps.sg";
	document.vForm.submit();
}


function jf_delete(admin_id){
	if(confirm('정말 삭제하시겠습니까?')){
		location.href="./userDel.sg?command=del&admin_id="+admin_id;
	}
}

function jf_pwChage(admin_id){
	var url = './pwChange.sg?admin_id='+admin_id;
	window.open(url, 'pwChage', 'width=300, height=200');
}
function jf_go(){
	location.href="./userList.sg";
}
//-->
</SCRIPT>

<form name='vForm' method='post'>
<input type='hidden' name='command' value="mod">
<input type='hidden' name='admin_id' value="${userInfo.ADMIN_ID }">
<input type='hidden' name='cor_number' value="${userInfo.COR_NUMBER}">
<input type='hidden' name='cor_regnumber' value='${userInfo.COR_REGNUMBER }'>

<div id="title_line">
	<div id="title">관리자 기본정보</div>
	<div id="location">${menuNavi} </div>
</div>

<table width="100%" border="0" cellpadding="0" cellspacing="0"  id="table_gray" rules="cols" summary="관리자 관리" class="grid" rules="cols">
	<tr>
		<th scope="col" id="odd">아이디</td><td>${userInfo.ADMIN_ID }</td>
	</tr>
	<tr>
		<th scope="col" id="odd">패스워드</td>
		<td>
		<input type="button" class="buttonsmall06" value="패스워드변경" style="margin-right:10px;" onclick="javascript:jf_pwChage('${userInfo.ADMIN_ID }')">
		</td>
	</tr>
	
	<tr>
		<th scope="col" id="odd">기업명</td><td><input type='text' name="cor_nm" value='${userInfo.COR_NM}'></td>
	</tr>
	
	<tr>
		<th scope="col" id="odd">사번</td><td><input type='text' name='sabun' value='${userInfo.SABUN }'></td>
	</tr>
	
	<tr>
		<th scope="col" id="odd">이름</td><td><input type='text' name='admin_nm' value='${userInfo.ADMIN_NM }'></td>
	</tr>
	
	<tr>
		<th scope="col" id="odd">부서</td><td><input type='text' name='dept' value='${userInfo.DEPT }'></td>
	</tr>
	
	<tr>
		<th scope="col" id="odd">이메일</td><td><input type='text' name='admin_mail' size='50' value='${userInfo.ADMIN_MAIL }'></td>
	</tr>
	
	<tr>
		<th scope="col" id="odd">전화번호</td><td><input type='text' name='tel' value='${userInfo.TEL }'></td>
	</tr>
	
</table>

<div class="btn">						
	<div class="leftbtn">
		
	</div>
	<div class="rightbtn">
		<!-- 권한 에 따른 쓰기기능 제어 시작  -->		
		<c:if test="${writeGrant != '0' }">
			<input type="button" class="button02" value="수정" style="margin-right:10px;" onclick="javascript:jf_submit()">
			<input type="button" class="button02" value="삭제" style="margin-right:10px;" onclick="javascript:jf_delete('${userInfo.ADMIN_ID }')">
		</c:if>	
		<!-- 권한 에 따른 쓰기기능 제어 끝  -->		
			<input type="button" class="button03" value="리스트" style="margin-right:10px;" onclick="javascript:jf_go()">

	</div>
</div>	

</form>
