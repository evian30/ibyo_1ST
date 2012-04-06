<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/web/jsp/common/inc/commonInc.jsp" %>


<c:if test="${sessionMap == null}"> <script>alert('연결시간 초과되었거나 로그인 정보가 없습니다.\n\n로그인 페이지로 이동합니다.'); location.href="/core/manage/suser/userLogin.sg";</script></c:if>
<c:if test="${readGrant == '0' && writeGrant == '0'}"> 
	<script>  alert('권한이 없습니다 .'); history.back();</script>
</c:if>
<!--header시작-->
	<div id="header">
		<div id="logobg">
			<div id="logo">
				<a href="/sgportal/main/myPage.sg">
					<img src="/resource/images/bass_1st/top_logo.gif"> 
				</a>
				<img src="/resource/images/bass_1st/logo_sys.gif">
				<script language="JavaScript1.2"> 
					var message="TASS - 테스트용 확인 페이지" // 원하는 메세지 
					var neonbasecolor="gray" 			// 기본글자 색상 
					var neontextcolor="blue" 			// 네온글자 색상 
					var flashspeed=100  				// 스피드를 조절 할 수 있습니다 
					
					var n=0 
					if (document.all){ 
					document.write('<font face=\"Arial Black\" color="'+neonbasecolor+'">') 
					for (m=0;m<message.length;m++) 
					document.write('<span style="font-weight:bold;align=middle" id="neonlight">'+message.charAt(m)+'</span>') 
					document.write('</font>') 
					
					var tempref=document.all.neonlight 
					} 
					else 
					document.write(message) 
					
					function neon(){ 
					if (n==0){ 
					for (m=0;m<message.length;m++) 
					tempref[m].style.color=neonbasecolor 
					} 
					
					tempref[n].style.color=neontextcolor 
					
					if (n<tempref.length-1) 
					n++ 
					else{ 
					n=0 
					clearInterval(flashing) 
					setTimeout("beginneon()",1500) 
					return 
					} 
					} 
					
					function beginneon(){ 
					if (document.all) 
					flashing=setInterval("neon()",flashspeed) 
					} 
					beginneon() 
					
					
					
					
					
				</script> 
				
			</div>
			<div id="logininfo">
				<span class="txt_login">${sessionMap.ADMIN_NM}</span> 로그인하셨습니다.&nbsp;&nbsp;
				<input type="button" class="buttonsmall04" value="로그아웃" onclick="javascript:window.location.href='/core/manage/suser/userLogOut.sg';" />
				<c:if test="${fn:substring(sessionMap.SABUN, 0, 2) == 'CH'}">
				<input type="button" class="buttonsmall06" value="회원정보수정" onclick="javascript:window.location.href='/sgportal/chman/chmanView.sg?actType=mod&comT=SG&corp_no=COR1011022247591&chman_no=${sessionMap.SABUN}&hmenu_id=002000000';" />
				</c:if>
			 
			</div> 
		</div>	
		
		<div id="topnavi">
			<div id="topnavi_f"></div>	
				<ul>
					<c:forEach items="${menuFirst}" var="menu" varStatus="i">
						<str:substring start="0" end="3" var="t1">${menu.MENU_ID}</str:substring>
						<str:substring start="0" end="3" var="t2">${sessionMap.hmenu_id}</str:substring>
						<str:length var='len'>${menu.MENU_NM}</str:length>
						<c:if test="${len < 6}">
							<str:length var='len'>aaaaaa</str:length>
						</c:if>									
						<c:choose> 
							<c:when test="${t1 == t2}">  
								<!--메뉴 오버시 -->
								<!--메뉴 들어가는 부분입니다. -->
								<li class="menuOn">
									<c:choose>
										<c:when test="${menu.MENU_PATH != null}">
											<str:countMatches substring="?" var='sr'>${menu.MENU_PATH}</str:countMatches>
											<c:choose>
												<c:when test="${sr > 0 }"><a href="${menu.MENU_PATH}&hmenu_id=${menu.MENU_ID}" style="cursor:pointer">${menu.MENU_NM}</a></c:when>						
												<c:when test="${sr <= 0 }"><a href="${menu.MENU_PATH}?hmenu_id=${menu.MENU_ID}" style="cursor:pointer">${menu.MENU_NM}</a></c:when>
											</c:choose> 
										</c:when>
										<c:otherwise>
											<a href="/core/manage/menu/blank.sg?hmenu_id=${menu.MENU_ID}">${menu.MENU_NM}</a>
										</c:otherwise>
									</c:choose>	 
								</li>  
								<!--메뉴 오버시 끝 -->
							</c:when>
							<c:otherwise>
								<!--메뉴 시 -->
								<li>
							    	<c:choose>
										<c:when test="${menu.MENU_PATH != null}">
											<str:countMatches substring="?" var='sr'>${menu.MENU_PATH}</str:countMatches>
								    		<c:choose>
												<c:when test="${sr > 0 }"><a href="${menu.MENU_PATH}&hmenu_id=${menu.MENU_ID}" style="cursor:pointer">${menu.MENU_NM}</a></c:when>						
												<c:when test="${sr <= 0 }"><a href="${menu.MENU_PATH}?hmenu_id=${menu.MENU_ID}" style="cursor:pointer">${menu.MENU_NM}</a></c:when>
											</c:choose>
										</c:when>
										<c:otherwise>
											<a href="/core/manage/menu/blank.sg?hmenu_id=${menu.MENU_ID}">${menu.MENU_NM}</a>
										</c:otherwise>
									</c:choose>	
						    	</li> 
								<!--메뉴 시 끝 -->
							</c:otherwise>
						</c:choose>
					</c:forEach> 
		  		</ul>
			<div id="topnavi_b"></div>	
 	  </div>	
	</div>
<!--header끝-->	
 
<form name="goMenu" method="post">
	
</form>

<iframe name='dummy' id='dummy' style='display:none; height:0px; overflow:hidden;' ></iframe>


<input type="hidden" name="menuNm" id="menuNm" value="${menu.MENU_NM}" />

