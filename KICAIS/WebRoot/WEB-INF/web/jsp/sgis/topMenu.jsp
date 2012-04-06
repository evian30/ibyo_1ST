<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
 

<%@ include file="/WEB-INF/web/jsp/sgis-top-inc.jsp" %>



 
	<body id='basicLayoutBody'>

	<div id="wrap">
		<div id="top"> 
			<div id="topMenu">
				<ul class="menuList1">
					<li class="imgNone link_color1 padding_r25"><a href="/core/manage/suser/userLogOut.sg"><span  style="font-weight:bold">로그아웃</span></a></li>
					<div> 
						<li><a href="/sgis/main.sg"><span style="font-weight:bold">홈</span></a>&nbsp;&nbsp;&nbsp;&nbsp;</li>
						<!--<li><a href="#none"><span>메뉴전체보기</span></a></li>  
						--><li><span  style="font-weight:bold;cursor:pointer;" onclick="javascript:loadUrl('개인 정보변경', '/com/employee/employeeList2.sg');">개인 정보변경</span></li>
					</div>
				</ul> 
			</div>
			<div id="loginInfo">
				<!-- ${sessionMap.COR_NM} -->&nbsp;&nbsp; 
				<c:if test="${dept_nm != ''}">
				<b>[${dept_nm}]</b>
				</c:if>
				&nbsp;&nbsp; <span class="font_color_name" style="font-weight:bold">${sessionMap.ADMIN_NM}</span> 
				<c:choose>
					<c:when test="${degree_BUSINESS != '' && degree_RND == ''}">
						${degree_BUSINESS} 
					</c:when>
					<c:when test="${degree_RND != ''}">
						${degree_RND} 
					</c:when>
				</c:choose>
				님 로그인 하셨습니다.
			</div>	
		</div>
		 
	</div>	



<%@ include file="/WEB-INF/web/jsp/sgis-bottom-inc.jsp" %>