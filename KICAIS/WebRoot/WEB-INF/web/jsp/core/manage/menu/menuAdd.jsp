<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ include file="/WEB-INF/web/jsp/common/inc/commonInc.jsp" %>
<HTML>
<HEAD>
<TITLE>메뉴추가</TITLE>

<link rel="stylesheet" type="text/css"  href="/resource/common/css/common_renew.css" />
<link rel="stylesheet" type="text/css"  href="/resource/common/css/ext-all.css" />
<SCRIPT LANGUAGE="JavaScript">
<!--
function jf_submit(){
	if(document.vForm.menu_nm.value == ""){
		alert('메뉴명을 입력하세요');
		document.vForm.menu_nm.focus();
		return false;
	}
	return true;
	
}
//-->
</SCRIPT>
</HEAD>
<BODY>
	<br/>
	<div class=" x-panel x-form-label-left" style="width: auto">						
		<div class="x-panel-tl">
		<div class="x-panel-tr">
			<div class="x-panel-tc">
				<div class="x-panel-header x-unselectable" style="-moz-user-select: none;">
					<center><span class="x-panel-header-text">신규메뉴 추가</span></center>
				</div>
			</div>
		</div>
	</div>
	<br/>
	<form name='vForm' method='post' action="/core/manage/menu/menuNameAddAction.sg" onsubmit="return jf_submit();">
	<input type='hidden' name='menu_id' value="<%=request.getParameter("menu_id")%>">
	<input type='hidden' name='menu_thread' value="<%=request.getParameter("menu_thread")%>">
		<table width='100%' border='0'>
			<tr>
				<td align='right'><input type='text' name='menu_nm' style="ime-mode:active"></td>
				<td><input type="submit" class="button" value="메뉴 저장" /></td>
			</tr>
		</table>
	</form>
</BODY>
<script>
	document.vForm.menu_nm.focus();
</script>
</HTML>