<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/web/jsp/common/inc/commonInc.jsp" %>
<SCRIPT LANGUAGE="JavaScript">
<!--
function jf_groupMake(){
	window.open('./codeGroupList.sg', 'codeMake', 'width=300, height=400, scrollbars=yes');
}

function jf_submit(){
	
	if(document.vForm.cd_nm.value == ""){
		alert('코드명 을 입력하세요');
		document.vForm.cd_nm.focus();
		return;
	}
	
	document.vForm.action = "./codeUpdate.sg";
	document.vForm.submit();
}

function jf_go(){
	location.href='codeList.sg';
}

//-->
</SCRIPT>
<form name='vForm' method='post'>
<input type='hidden' name='cd_gid' value='${codeInfo.CD_GID}'>
<input type='hidden' name='cd_id' value='${codeInfo.CD_ID}'>

<div id="title_line">
	<div id="title">코드관리</div>
	<div id="location">${menuNavi} </div>
</div>


<table width="100%" border="0" cellpadding="0" cellspacing="0"  id="table_gray" class="grid" rules="cols" summary="관리자 관리">
	<tr>
		<th scope="col" id="odd">코드 그룹</th>
		<td>${codeInfo.CD_GNM }</td>
	</tr>
	
	<tr>
		<th scope="col" id="odd">코드</th>
		<td>${codeInfo.CD_ID }</td>
	</tr>
	
	<tr>
		<th scope="col" id="odd">코드명</th>
		<td>
			<input type='text' name='cd_nm' maxlength='40' size='40' value='${codeInfo.CD_NM }'>
		</td>
	</tr>
	
	<tr>
		<th scope="col" id="odd">사용여부</th>
		<td>
			<select name='cd_yn'>
				<option value='Y' <c:if test="${codeInfo.CD_YN == 'Y' }">checked</c:if> >Yes</option>
				<option value='N' <c:if test="${codeInfo.CD_YN == 'N' }">checked</c:if> >No</option>
			</select>
		</td>
	</tr>
	
	<tr>	
		<th scope="col" id="odd">설명</th>
		<td>
			<textarea name='cd_comment' rows='10' cols='40'>${codeInfo.CD_COMMENT }</textarea>
		</td>
	</tr>
	
</table>

<div class="btn">						
	<div class="leftbtn">
		
	</div>
	<div class="rightbtn">
		<!-- 권한 에 따른 쓰기기능 제어 시작  -->
		<c:if test="${writeGrant != '0' }">	
			<input type="button" class="button02" value="수정" style="margin-right:10px;" onclick="javascript:jf_submit()">
		</c:if>
		<input type="button" class="button03" value="리스트" style="margin-right:10px;" onclick="javascript:jf_go()">
	</div>
</div>
					
</form>		

