<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/web/jsp/common/inc/commonInc.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<script type="text/javascript">
function goLogin(){
	var fm = document.setupForm;
	fm.action = "/core/manage/suser/userLogin.sg";
	fm.submit();
}
function goSetup(){
	var fm = document.setupForm;
	fm.action = "/core/manage/setup/setup.sg";
	fm.submit();
}
</script>
</head>
<body>
<center>
<form name="setupForm" method="post">
<c:choose>
	<c:when test="${setup == 'seccess'}">
		<input tyype="button" onclick="goLogin()" value="[로그인 화면으로]">
	</c:when>						
	<c:when test="${setup != 'seccess'}">
		<input tyype="button" onclick="goSetup()" value="[재설치]">
	</c:when>
</c:choose>
</form>
</center>
</body>
</html>