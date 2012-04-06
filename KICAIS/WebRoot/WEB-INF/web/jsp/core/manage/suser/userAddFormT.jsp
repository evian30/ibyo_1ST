<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.signgate.core.web.util.*" %>
<%@ include file="/WEB-INF/web/jsp/common/inc/commonInc.jsp" %>
<script type="text/javascript" src="/resource/common/js/ajax.js"></script>
<SCRIPT LANGUAGE="JavaScript">
<!--
function jf_submit(){
	if(document.vForm.admin_id.value == ""){
		alert('아이디를  입력하세요.');
		document.vForm.admin_id.focus();
		return;
	}
	
	if(document.vForm.idcheck.value == "1"){
		alert('아이디중복 체크를 하세요.');
		return;
	}
	
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
	
	if(document.vForm.cor_nm.value == ""){
		alert('기업명을 입력하세요');
		document.vForm.cor_nm.focus();
		return;
	}
	if(document.vForm.sabun.value == ""){
		alert('사번을 입력하세요..');
		document.vForm.sabun.focus();
		return;
	}
	if(document.vForm.admin_nm.value == ""){
		alert('이름을 입력하세요..');
		document.vForm.admin_nm.focus();
		return;
	}
	if(document.vForm.dept.value == ""){
		alert('부서을 입력하세요..');
		document.vForm.dept.focus();
		return;
	}
	if(document.vForm.admin_mail.value == ""){
		alert('이메일을 입력하세요..');
		document.vForm.admin_mail.focus();
		return;
	}
	if(document.vForm.tel.value == ""){
		alert('전화번호를 입력하세요..');
		document.vForm.tel.focus();
		return;
	}
	
	
	document.vForm.action = "./userIns.sg";
	document.vForm.submit();
}

var blockClick =  false;
function jf_idCheck() {

	if(document.vForm.admin_id.value != ""){
	    var url="./userAjaxIdCheck.sg";
	    queryString = "admin_id="+document.vForm.admin_id.value;
	
	    if(blockClick) {
	        return;
	    }
	
	    blockClick = true;
	
	    httpRequest("POST", url, queryString, true, jf_idCheckInfo);
    }else{
    	alert('아이디를 입력하세요.');
    	document.vForm.admin_id.focus();
    }
}

var jf_idCheckInfo = function() {
	if( ajax.readyState==4 ) {
		if (ajax.status == 200) {
			var idCheck = ajax.responseText;
			var id = idCheck.split("||");
			
			if(id[1] == "0"){
				alert("["+document.vForm.admin_id.value+"] 아이디는  등록할수있는 아이디 입니다.");
				document.vForm.idcheck.value = "0";
			}else {
				alert("["+document.vForm.admin_id.value+"] 아이디는 이미 등록되어있는 아이디 입니다.");
				document.vForm.admin_id.value="";
				document.vForm.idcheck.value = "1";
			}
			
			
            blockClick = false;
		}else{
			blockClick = false;
		}
 	}
}

function jf_go(){
	location.href="./userList.sg";
}
//-->
</SCRIPT>

<form name='vForm' method='post'>
<input type='hidden' name='command' value="add">
<input type='hidden' name='idcheck' value = "0">
<input type='hidden' name='cor_number'>
<input type='hidden' name='cor_regnumber'>

<div id="title_line">
	<div id="title">관리자 등록</div>
	<div id="location">${menuNavi} </div>
</div>

<table width="100%" border="0" cellpadding="0" cellspacing="0"  id="table_gray" rules="cols" summary="관리자 관리" class="grid" rules="cols">
	<tr>
		<th scope="col" id="odd">아이디</td><td><input type='text' name='admin_id'>
		
		<input type="button" class="buttonsmall06" value="아이디 중복체크" style="margin-right:10px;" onclick="javascript:jf_idCheck()"></td>
	</tr>
	<tr>
		<th scope="col" id="odd">패스워드</td><td><input type='password' name='admin_pw'></td>
	</tr>
	<tr>
		<th scope="col" id="odd">패스워드 확인</td><td><input type='password' name='admin_pw01'></td>
	</tr>
	
	<tr>
		<th scope="col" id="odd">기업명</td><td><input type='text' name=cor_nm></td>
	</tr>
	
	<tr>
		<th scope="col" id="odd">사번</td><td><input type='text' name='sabun'></td>
	</tr>
	
	<tr>
		<th scope="col" id="odd">이름</td><td><input type='text' name='admin_nm'></td>
	</tr>
	
	<tr>
		<th scope="col" id="odd">부서</td><td><input type='text' name='dept'></td>
	</tr>
	
	<tr>
		<th scope="col" id="odd">이메일</td><td><input type='text' name='admin_mail'></td>
	</tr>
	
	<tr>
		<th scope="col" id="odd">전화번호</td><td><input type='text' name='tel'></td>
	</tr>
	
</table>

<div class="btn">						
	<div class="leftbtn">
		
	</div>
	<div class="rightbtn">
		<!-- 권한 에 따른 쓰기기능 제어 시작  -->		
			<c:if test="${writeGrant != '0' }">
			<input type="button" class="button02" value="저장" style="margin-right:10px;" onclick="javascript:jf_submit()">
			</c:if>	
		<!-- 권한 에 따른 쓰기기능 제어 끝  -->	
			<input type="button" class="button03" value="리스트" style="margin-right:10px;" onclick="javascript:jf_go()">
	</div>
</div>
		
</form>
