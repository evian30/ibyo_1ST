<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.signgate.core.web.util.*" %>
<%@ include file="/WEB-INF/web/jsp/common/inc/commonInc.jsp" %>
<script type="text/javascript" src="/resource/common/js/ajax.js"></script>


<SCRIPT LANGUAGE="JavaScript">
<!--

//-->
</SCRIPT>
<link href="/resource/manage/css/admin_sgf.css" rel="stylesheet" type="text/css">
<form name='vForm' method='post'>

<br/><br/>
<table width="100%" border="0" cellpadding="0" cellspacing="0"  id="table_gray" rules="cols" class="grid" summary="관리자 관리">
	<tr>
		<th scope="col" id="odd">메뉴명</td>
		<th scope="col" id="odd">읽기권한</td>
		<th scope="col" id="odd">쓰기권한</td>
	</tr>
	<c:forEach items="${menuList}" var="menu" varStatus="i">
	<tr>
		<td align='' style="padding-left: 10">${menu.MENU_NM}</td>
		<td align='center'><c:if test="${menu.R == 'R'}">읽기권한</c:if></td>
		<td align='center'><c:if test="${menu.W == 'W'}">쓰기권한</c:if></td>
	</tr>
	</c:forEach>
</table>

<div class="btn">						
	<div class="leftbtn">
		
	</div>
	<div class="rightbtn">
		<input type="button" class="button02" value="닫기" onclick="javascript:window.close()">
	</div>
</div>
			
</form>
