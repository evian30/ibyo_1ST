<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/web/jsp/common/inc/commonInc.jsp" %>
<SCRIPT LANGUAGE="JavaScript">
<!--
function jf_submit(){
	if(document.vForm.cd_gid.value == ""){
		alert("그룹 코드를 입력하세요.");
		document.vForm.cd_gid.focus();
		return;
	}
	
	if(document.vForm.cd_gnm.value == ""){
		alert("그룹  명를 입력하세요.");
		document.vForm.cd_gnm.focus();
		return;
	}
	document.vForm.action = "./codeGroupInsert.sg";
	document.vForm.submit();
}

function jf_go(){
	history.back();
}
//-->
</SCRIPT>
<link href="/resource/manage/css/ipin_admin_1.0.css" rel="stylesheet" type="text/css">
<table width="100%" border="0" cellpadding="0" cellspacing="0" summary="바디테이블">
	<tr>
		<td style="padding-top:30px;padding-bottom:30px;" id="content_title" class="green_txt_b">
		<img src="/resource/images/admin/img/tt_i.jpg"  style="margin:0 15px 0 0;" align="absmiddle"/>코드등록</td>
	</tr>
	<tr>
        <td style="padding-bottom:10;">
<form name='vForm' method='post'>
<input type='hidden' name='command' value='add'>
        	<table width="100%" height="29" border="1" cellpadding="0" cellspacing="0" id="fig1_01" summary="검색테이블" >
        		<tr>
					<th id="list02" width='100'>그룹코드</th>
					<td>
						<input type='text' name='cd_gid' maxlength='10' size='10'>
					</td>
				</tr>
			
				<tr>
					<th id="list02" width='100'>그룹명</th>
					<td>
						<input type='text' name='cd_gnm' maxlength='40' size='30'>
					</td>
				</tr>
				<tr>	
					<td colspan='2' align='center'>
					<input type="button" class="green_txt_b" value="저장" style="margin-right:10px;" onclick="javascript:jf_submit()">
					<input type="button" class="green_txt_b" value="뒤로" style="margin-right:10px;" onclick="javascript:jf_go()">
					</td>
				</tr>
			</table>
</form>
		</td>
	</tr>
</table>
