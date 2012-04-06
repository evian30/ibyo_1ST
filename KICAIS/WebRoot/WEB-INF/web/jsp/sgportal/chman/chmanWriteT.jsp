<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/web/jsp/common/inc/commonInc.jsp" %>
<SCRIPT LANGUAGE="JavaScript">
<!--

/*
 * 목록
 */
function jf_chman_list(){
	document.vForm.action = "./chmanList.sg";
	document.vForm.submit();
}

/*
 * 저장
 */
 function jf_chman_insert(){
	if(Validator.validate(document.vForm)){
		document.vForm.action = "./chmanCudAction.sg?actType=ins";
		document.vForm.submit();
	}
}
 

//-->
</SCRIPT>
<!--제목과 경로가 들어가는 테이블입니다. -->
<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td width="30%" class="txt_tt">SG 담당자 정보</td>
		<td width="70%" align="right">고객정보 > SG 담당자 정보</td>
	</tr>
</table>
<!--제목과 경로가 들어가는 테이블입니다. -->


<form name='vForm' method='post'>
<!-- 법인코드 -->
<input type='hidden' name='corp_no' value='COR1011022247591'>

<!-- 서명이미지코드 -->
<input type='hidden' name='sign_img_no' value='SI1'>
<!-- 담당자타입코드 -->
<input type='hidden' name='chman_type_code' value='001'>
<!-- 담당구분코드 -->
<input type='hidden' name='chman_sect_code' value='001'>
<!-- 중요도 등급코드 -->
<input type='hidden' name='imptc_grade_code' value='001'>
<!-- 담당자 번호 -->
<input type='hidden' name='chman_no' value=''>


<div style="width:700">
<div>  회사정보</div>
<table width="100%" border="1" cellpadding="1" cellspacing="1" id="fig1_01"> 
	<tr valign="middle">
		<td width="70">
			담당업무
		</td>
		<td width="70">
			<input type='text' name='corp_nm' size=60 maxlength='100' value="">
		</td>
	</tr>
	<tr valign="middle">
		<td width="70">
			사업자등록번호
		</td>
		<td width="70">
			<input type='text' name='ssn' size=60 maxlength='100' value="">
		</td>
	</tr>
	<tr valign="middle">
		<td width="70">
			주소
		</td>
		<td width="70">
			<input type='text' name='addr1' size=60 maxlength='100' value="">
			<input type='text' name='addr2' size=60 maxlength='100' value="">
		</td>
	</tr>	
	<tr valign="middle">
		<td width="70">
			전화번호
		</td>
		<td width="70">
			<input type='text' name='rep_phone' size=60 maxlength='100' value="">
		</td>
	</tr>	
	<tr valign="middle">
		<td width="70">
			팩스번호
		</td>
		<td width="70">
			<input type='text' name='rep_fax' size=60 maxlength='100' value="">
		</td>
	</tr>
</table>
<br />
<br />


<div>  담당자 정보</div>
<table width="100%" border="1" cellpadding="1" cellspacing="1" id="fig1_01">  
	<tr valign="middle" >
		<td width="70">
			비밀번호
		</td>
		<td width="70">
			<input type='password' name='passwd' size=60 maxlength='100' value="">
		</td>
	</tr>
		<tr valign="middle" >
		<td width="70">
			비밀번호 확인
		</td>
		<td width="70">
			<input type='password' name='passwd2' size=60 maxlength='100' value="">
		</td>
	</tr>
	<tr valign="middle" >
		<td width="70">
			담당업무
		</td>
		<td width="70">
			<input type='text' name='chman_sect_nm' size=60 maxlength='100' value="">
		</td>
	</tr>
	<tr valign="middle">
		<td width="70">
			성명
		</td>
		<td width="70">
			<input type='text' name='chman_nm' size=60 maxlength='100' value="">
		</td>
	</tr>
	<tr valign="middle">
		<td width="70">
			직급
		</td>
		<td width="70">
			<input type='text' name='grade_code' size=60 maxlength='100' value="001">
		</td>
	</tr>	
	<tr valign="middle">
		<td width="70">
			부서
		</td>
		<td width="70">
			<input type='text' name='dept_code' size=60 maxlength='100' value="001">
		</td>
	</tr>	
	<tr valign="middle">
		<td width="70">
			휴대전화
		</td>
		<td width="70">
			<input type='text' name='chman_phone' size=60 maxlength='100' value="">
		</td>
	</tr>
	<tr valign="middle">
		<td width="70">
			회사전화
		</td>
		<td width="70">
			<input type='text' name='chman_hp' size=60 maxlength='100' value="">
		</td>
	</tr>
	<tr valign="middle">
		<td width="70">
			메일
		</td>
		<td width="70">
			<input type='text' name='chman_email' size=60 maxlength='100' value="">
		</td>
	</tr>
</table>

<table width="100%">
	<tr align="right">
		<td>
			<input type="button" class="button" value="목록" onclick="javascript:jf_chman_list()" style="cursor:hand;">
			<input type="button" class="button" value="저장" onclick="javascript:jf_chman_insert()" style="cursor:hand;">
		</td>
	</tr>
</table>
</form>