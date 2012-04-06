<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ include file="/WEB-INF/web/jsp/common/inc/commonInc.jsp" %>
<link href="/resource/manage/css/admin_sgf.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="/resource/common/js/ajax.js"></script>
<SCRIPT LANGUAGE="JavaScript">
<!--
function jf_submit(){
	var len = document.vForm.groups.length;
	var group_id = "";
	for(var i = 0; i < len; i++){
		if(document.vForm.groups[i].checked == true){
			group_id = group_id +","+document.vForm.groups[i].value;
		}
	}
	
	document.vForm.group_id.value = group_id;
	document.vForm.action = "./menuGroupAction.sg";
	document.vForm.submit();
}
//-->
</SCRIPT>
<table width="100%"  height="100%" border="0" cellpadding="0" cellspacing="0" class="table_popup">  
	<tr>
		<td align="center" valign="top">
			<table width="90%" height="100%" border="0" cellpadding="0" cellspacing="0">
				<tr valign="middle">
					<td class="txt_tt">권한리스트</td>
				</tr>
				<tr>
					<td height="5" class="line_bg"></td>
				</tr>
				<tr>
					<td align="left" >&nbsp;</td>
				</tr>
				<tr>
					<td>
						<form name='vForm' method='post'>
						<input type='hidden' name='group_id'>
						<input type='hidden' name='groups'>
						<input type='hidden' name='command' value="<%=request.getParameter("command") %>">
						<input type='hidden' name='menu_id' value="<%=request.getParameter("menu_id") %>">
						<table width="100%" border="0" cellpadding="0" cellspacing="0"  id="table_gray" rules="cols" summary="관리자 관리">
							<tr>
								<td align='right'><input type="button" class="button" value="권한적용" onclick="javascript:jf_submit()"/></td>
							</tr>
							<c:forEach items="${groupList}" var="group" varStatus="i">
								<tr><td><input type='checkbox' name='groups' value="${group.GROUP_ID}" <c:if test="${group.MENU_ID != null}">checked</c:if>>${group.GROUP_NM}</td></tr>
							</c:forEach>
							<tr>
								<td align='right'><input type="button" class="button" value="권한적용" onclick="javascript:jf_submit()"/></td>
							</tr>
						</table>
						</form>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>