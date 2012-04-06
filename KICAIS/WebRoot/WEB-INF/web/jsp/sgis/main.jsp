<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
 

<%@ include file="/WEB-INF/web/jsp/sgis-top-inc.jsp" %>


<style type="text/css" >
body {}

#wrap {
	position: absolute;
    width: 100%;
    height: 64px;  
	background:url(/resource/images/is_images/top_bg.jpg) ;
}

#top {
    width:1268px;
	height:64px;
	float:left;
	background:url(/resource/images/is_images/top_bgbar.jpg) no-repeat;float:left;
}

#topMenu {
	margin-left:940px;
	padding-top:3px;
}
	
.logo { 
	float:left; 
	display:inline;
}
.logout { 
	padding-left:940px;
	float:left; 
	display:inline;
}
.tab { 
	padding-top:6px;
	padding-left:1020px;
	display:inline;
}
.login_info{
	margin:39px 0 14px 64px;
}

/*init*/
ul {
	margin:6px 0px 0px 0px;
	padding:0px 0px 0px 0px;
}

li {
	list-style-type:none;

}

.menuList1 LI {
	margin:0 0 0 0;
	font-family:Dotum;
	font-size:11px;
	color:#e1ecff;
	float:left;
	padding-left:7px;
	background:url(/resource/images/is_images/bul_toppoint.gif) no-repeat;
}

/**/
a:link {color: #FFF; text-decoration: none;}
a:visited {color: #FFF; text-decoration: none;}
a:active {color: #666; text-decoration: none;}
a:hover {color: #2657d4; text-decoration: none;}

/**/
.menuList1 a:link {color:#e1ecff;}
.menuList1 a:visited {color:#e1ecff;}
.menuList1 a:active {color:#e1ecff;}
.menuList1 a:hover {color:#68eedd;}

/**/
.link_color1 a:link {color:#3661b9;}
.link_color1 a:visited {color:#04acfa;}
.link_color1 a:active {color:#04acfa;}
.link_color1 a:hover {color:#04acfa;}


.imgNone {
	background-image:none !important;
}
.padding_r25 {
	padding-right:25px;
}

#loginInfo {
	margin-left:270px;
	margin-top:32px;
	font-size:12px;
	color:#546075;
}

.font_color_name {
	color:#165dd9;
}

</style>
 
<c:if test="${sessionMap == null}"> 
	<script type="text/javascript">
		//Ext.Msg.alert('확인', '연결시간 초과되었거나 로그인 정보가 없습니다.로그인 페이지로 이동합니다.');
		alert("연결시간 초과되었거나 로그인 정보가 없습니다.\n로그인 페이지로 이동합니다.");
		window.location.href="/core/manage/suser/userLogin.sg";
	</script>
</c:if>

<c:if test="${readGrant == '0' && writeGrant == '0'}"> 
	<script type="text/javascript">
		/**Ext.Msg.alert('확인', '권한이 없습니다 ');**/  
		alert("권한이 없습니다");
		history.back();
	</script>
</c:if>
 
	<body id='basicLayoutBody' style="width:100%">

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
				<ul>
					 <div id="loginInfo" style="width:100%; align:left">
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
				</ul>
			</div>
				
		</div>
		
	</div>
	
	<script>
  Ext.onReady(function() {
    	 
    	
    	if('<%=request.getParameter("actK")%>'=='menu'){
    		//loadUrl("KICA", "/core/manage/menu/menuManage.sg?menu_id=${map.menu_id}&menu_thread=${map.menu_thread}");
    		//loadUrl("KICA", "/");
    	}else{ 
    		loadUrl("${sessionMap.ADMIN_NM}님 개인 일정관리", "/com/calendar/calendarIFR.sg?kica=is&calMon=Yes");
    	}
  });
  </script>



<%@ include file="/WEB-INF/web/jsp/sgis-bottom-inc.jsp" %>