<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<div id="title">
	<c:choose>
		<c:when test="${empty pMap.menuNm2 && not empty menuSecond[0].MENU_NM}">
			${menuSecond[0].MENU_NM}
		</c:when>
		<c:when test="${not empty pMap.menuNm2}">
			${pMap.menuNm2}
		</c:when>
		<c:otherwise>
		</c:otherwise> 
	</c:choose> 
</div>
<div id="location">
	<c:if test="${not empty pMap.menuNm1}">
		${pMap.menuNm1} >
	</c:if>
	<c:choose>
		<c:when test="${empty pMap.menuNm2 && not empty menuSecond[0].MENU_NM}">
			${menuSecond[0].MENU_NM}
		</c:when>
		<c:when test="${not empty pMap.menuNm2}">
		 	${pMap.menuNm2}
		</c:when>
		<c:otherwise>
		</c:otherwise> 
	</c:choose> 