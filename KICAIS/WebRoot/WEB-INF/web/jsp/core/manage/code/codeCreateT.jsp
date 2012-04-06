<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/web/jsp/common/inc/commonInc.jsp" %>
<SCRIPT LANGUAGE="JavaScript">
<!--
function jf_groupMake(){
	window.open('./codeGroupList.sg', 'codeMake', 'width=400, height=400, scrollbars=yes');
}

function jf_submit(){
	if(document.vForm.cd_gid.value == ""){
		alert('코드그룹을 선택하세요');
		document.vForm.cd_gid.focus();
		return;
	}
	
	if(document.vForm.cd_id.value == ""){
		alert('코드입력하세요');
		document.vForm.cd_id.focus();
		return;
	}
	
	if(document.vForm.cd_nm.value == ""){
		alert('코드명 을 입력하세요');
		document.vForm.cd_nm.focus();
		return;
	}
	
	document.vForm.action = "./codeInsert.sg";
	document.vForm.submit();
}

function jf_go(){
	location.href='./codeList.sg';
}
//-->
</SCRIPT>

<form name='vForm' method='post'>

<div id="title_line">
	<div id="title">코드관리</div>
	<div id="location">${menuNavi} </div>
</div>


     	<table width="100%" border="0" cellpadding="0" cellspacing="0"  id="table_gray" class="grid" rules="cols" summary="관리자 관리">
     		<tr>
		<th scope="col" id="odd">코드 그룹</th>
		<td>
			<select name='cd_gid'>
				<option value=''>===선택===</option>
				<c:forEach items="${groupList}" var="group">
					<option value='${group.CD_GID }'>${group.CD_GNM }</option>
				</c:forEach>
			</select> 
			<input type="button" class="buttonsmall06" value="코드그룹 만들기" style="margin-right:10px;" onclick="javascript:jf_groupMake()">
		</td>
	</tr>

	<tr>
		<th scope="col" id="odd">코드</th>
		<td>
			<input type='text' name='cd_id' maxlength='10' size='5'>
		</td>
	</tr>

	<tr>
		<th scope="col" id="odd">코드명</th>
		<td>
			<input type='text' name='cd_nm' maxlength='40' size='40'>
		</td>
	</tr>

	<tr>
		<th scope="col" id="odd">사용여부</th>
		<td>
			<select name='cd_yn'>
				<option value='Y'>Yes</option>
				<option value='N'>No</option>
			</select>
		</td>
	</tr>
	<tr>	
		<th scope="col" id="odd">설명</th>
		<td>
			<textarea name='cd_comment' rows='10' cols='40'></textarea>
		</td>
	</tr>

	<tr>	
		<td colspan='2' align='center'>
	<!-- 권한 에 따른 쓰기기능 제어 시작  -->
	<c:if test="${writeGrant != '0' }">	
		<input type="button" class="button02" value="저장" style="margin-right:10px;" onclick="javascript:jf_submit()">
	</c:if>
		<input type="button" class="button03" value="리스트" style="margin-right:10px;" onclick="javascript:jf_go()">
		</td>
	</tr>
</table>
					
</form>		
