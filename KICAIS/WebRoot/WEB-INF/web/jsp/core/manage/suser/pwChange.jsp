<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.signgate.core.web.util.*" %>
<%@ include file="/WEB-INF/web/jsp/common/inc/commonInc.jsp" %>
<script type="text/javascript" src="/resource/common/js/ajax.js"></script>
<SCRIPT LANGUAGE="JavaScript">
<!--
function jf_submit(){
	
	if(document.vForm.admin_pw.value == ""){
		alert('패스워드를  입력하세요.');
		document.vForm.admin_pw.focus();
		return;
	}
	
	if(document.vForm.admin_pw.value != document.vForm.admin_pw01.value){
		alert('패스워드가 일치하지 않습니다..');
		document.vForm.admin_pw.focus();
		return;
	}
	
	document.vForm.action = "./userPwUps.sg";
	document.vForm.submit();
	
	opener.document.vForm.passwd.value = document.vForm.admin_pw.value;
	
}
//-->
</SCRIPT>
<link href="/resource/manage/css/admin_sgf.css" rel="stylesheet" type="text/css">
<form name='vForm' method='post'>
<input type='hidden' name='command' value="pwMod">
<input type='hidden' name='admin_id' value="${map.admin_id }">
<table width="100%" border="0" cellpadding="0" cellspacing="0">  
	<tr>
		<td align="center" valign="top">
			<table width="90%" height="100%" border="0" cellpadding="0" cellspacing="0">
				<tr valign="middle">
					<td>
						
					</td>
				</tr> 
				<tr>
					<td colspan="2" align="left" height="40px">&nbsp;</td>
				</tr>
				
				<tr>
					<td colspan="2" >	
						<table width="100%" border="0" cellpadding="0" cellspacing="0"  id="table_gray" rules="cols" summary="관리자 관리">
							
							<tr>
								<th scope="col" id="odd">패스워드</td><td><input type='password' name='admin_pw'></td>
							</tr>
							<tr>
								<th scope="col" id="odd">패스워드 확인</td><td><input type='password' name='admin_pw01'></td>
							</tr>
						
							<tr>
								<td align='center' colspan='2'>
									<input type="button" class="button" value="변경" style="margin-right:10px;" onclick="javascript:jf_submit()">
									<input type="button" class="button" value="닫기" style="margin-right:10px;" onclick="javascript:window.close()">
									
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
</form>
