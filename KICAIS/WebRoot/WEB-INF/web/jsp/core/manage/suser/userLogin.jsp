<%@ page contentType="text/html;charset=utf-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/web/jsp/common/inc/commonInc.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>KICA InformationSystem</title>
<style type="text/css" >

#wrap {
	position: absolute;
    top: 20%;
    left: 40%;
    width: 320px;
    height: 480px;
    align: center 
}
#login_t {
    width:320px;
	height:253px;
}
#login_m{
	width:320px;
	height:91px;
	background:url(/resource/images/is_images/bg_login_mid.jpg) no-repeat;float:left;
	font-size: 12px;
}
#idinfo{
    padding-top:24px;
	padding-left:90px;
	}
#login_f{
	width:320px;
	height:136px;
	float:left;
	padding-bottom:0px;
}
		
.search_input {
    height:15px;
	font-family:dotum;
	font-size:12px;
	color:#4f4f4f;
}

</style>

<!-- EXTJS CSS -->
<link rel="stylesheet" type="text/css" href="/resource/common/js/ext3/resources/css/ext-all.css" />
 
<!-- EXTJS SCRIPT  -->
<script type="text/javascript" src="/resource/common/js/ext3/adapter/ext/ext-base.js"></script>
<script type="text/javascript" src="/resource/common/js/ext3/ext-all-debug.js"></script>
<script type="text/javascript" src="/resource/common/js/ext3/src/locale/ext-lang-ko.js" charset="utf-8"></script>

<SCRIPT LANGUAGE="JavaScript">
<!--
function jf_Login(frm){
	if(frm.admin_id.value == ""){
		Ext.Msg.alert('ID확인', '로그인 아이디를 입력하세요.');  
		frm.admin_id.focus();
		return false;
	}
	
	if(frm.admin_pw.value == ""){
		Ext.Msg.alert('패스워드확인', '로그인 패스워드를 입력하세요.');
		frm.admin_pw.focus();
		return false;
	}
	
	return true;
}
//-->
</SCRIPT>
</head>

<body>
	<!-- wrap start -->
	<div id="wrap">
		<div id="login_t">
			<img src="/resource/images/is_images/bg_login_top.jpg" alt="로긴탑배경" />
		</div>
		<div id="login_m">
			<div id="idinfo">
				<!-- 아이디 비번 시작 --> 
				<table border="0" cellspacing="0" cellpadding="0">
					<form name='vForm' method="post" action="./userLoginAction.sg" onSubmit="return jf_Login(this);">
					<tr>
						<td width="105"><span class="l">
						<input name="admin_id" type="text" class="search_input" size="14" tabindex="1"/>
						</span></td>
						<td width="54" rowspan="2"><input type="image" src="/resource/images/is_images/btn_login.gif"  tabindex="3" border=0 alt="로그인버튼"/></td>
					</tr>
					<tr>
						<td><span class="l">
						<input name="admin_pw" type="password" class="search_input" size="14" tabindex="2"/>
						</span></td>
					</tr>
					</form>
					<tr>
						<td height="20"  colspan="2">&nbsp;</td>
					</tr>
				</table> 
				<!-- 아이디 비번 끝 -->
			</div>
		</div>
		<div id="login_f">
			<img src="/resource/images/is_images/bg_login_bottom.jpg" alt="로긴푸터" />
		</div>
	</div>
	<!-- wrap end -->
</body>
</html>