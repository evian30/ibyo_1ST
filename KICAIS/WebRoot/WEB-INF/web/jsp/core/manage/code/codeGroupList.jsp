<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/web/jsp/common/inc/commonInc.jsp" %>

<SCRIPT LANGUAGE="JavaScript">
<!--
function jf_AllCheck(){
	var len = document.vForm.cd_gid01.length;
	if(document.vForm.allCheck.checked == true){
		for(var i = 0; i < len; i++){
			document.vForm.cd_gid01[i].checked = true;
		}
	}else{
		for(var i = 0; i < len; i++){
			document.vForm.cd_gid01[i].checked = false;
		}
	}
}

function jf_delete(){
	
	if(document.vForm.cd_gid01 != undefined){
		var len = document.vForm.cd_gid01.length;
		var cd_gid = "";
		for(var i = 0; i < len; i++){
			if(document.vForm.cd_gid01[i].checked){
				cd_gid = cd_gid +","+document.vForm.cd_gid01[i].value;
			}
		}
		
		if(cd_gid == ""){
			alert('삭제할 그룹을  선택하세요.');
		}else{
			if(confirm("정말 삭제 하시겠습니까?\n\r그룹에 포함되어있는 모든 코드가 삭제됩니다.")){
				document.vForm.cd_gid.value = cd_gid;
				document.vForm.action = "./codeGroupDelete.sg";
				document.vForm.submit();
			}
		}	
	}
}

function jf_go(){
	location.href='./codeGroupCreate.sg';
}
//-->
</SCRIPT>
<link href="/resource/manage/css/ipin_admin_1.0.css" rel="stylesheet" type="text/css">

<form name='vForm' method='post'>
<input type='hidden' name='cd_gid'>
<input type='hidden' name='cd_gid01'>
<table width="100%" border="0" cellpadding="0" cellspacing="0" summary="바디테이블">
	<tr>
		<td style="padding-top:10px;padding-bottom:30px;" id="content_title" class="green_txt_b">
		<img src="/resource/images/admin/img/tt_i.jpg"  style="margin:0 15px 0 0;" align="absmiddle"/>코드그룹리스트</td>
	</tr>
	<tr>
		<td style="padding-top:10px;padding-bottom:10px;">
			<table width="100%" border="" cellpadding="1" cellspacing="1" id="fig1_01">
				<tr>
				<!-- 권한 에 따른 쓰기기능 제어 시작  -->		
				<c:if test="${writeGrant != '0' }">
					<th id="list02" align='center' width='10%'>
						<input type='checkbox' name='allCheck' onclick="javascript:jf_AllCheck()">전체선택 |
						<a href="javascript:jf_delete()">삭제</a>
					</td>
				</c:if>
				<!-- 권한 에 따른 쓰기기능 제어 끝  -->	
					<th id="list02" align='center' width='5%'>그룹코드</td>
					<th id="list02" align='center' width='26%'>그룹명</td>
				</tr>
	

<!-- 본문 시작 -->	
				<c:forEach items="${groupList}" var="code">
				<tr>
					<td align='center'><input type='checkbox' name='cd_gid01' value='${code.CD_GID}'></td>
					<td align='center'><a href="./codeGroupMod.sg?cd_gid=${code.CD_GID}">${code.CD_GID}</a></td>
					<td align='center'><a href="./codeGroupMod.sg?cd_gid=${code.CD_GID}">${code.CD_GNM}</a></td>
				</tr>
				</c:forEach>
<!-- 본문 끝 -->	
			</table>		
		</td>
	</tr>
	<tr>
		<td align="right">
		<!-- 권한 에 따른 쓰기기능 제어 시작  -->
		<c:if test="${writeGrant != '0' }">	
			<input type="button" class="green_txt_b" value="그룹 만들기" style="margin-right:10px;" onclick="javascript:jf_go()">
		</c:if>
		</td>
	</tr>
</table>
</form>