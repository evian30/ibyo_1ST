<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/web/jsp/common/inc/commonInc.jsp" %>
<script src="/resource/common/js/MultiUpload.js"></script>
<SCRIPT LANGUAGE="JavaScript">
<!--


function jf_submit(){

	if(document.vForm.qna_title.value == ""){
		alert('제목이 없습니다');
		document.vForm.qna_title.focus();
		return;
	}
	
	if(document.vForm.qna_password.value == ""){
		alert('패스워드를 입력하세요..');
		document.vForm.qna_password.focus();
		return;
	}
	
	if(document.vForm.qna_contents.value == ""){
		alert('내용이 없습니다');
		document.vForm.qna_contents.focus();
		return;
	}

	if(document.vForm.secret01[0].checked == true){
		document.vForm.secret.value = 'N';
	}else if(document.vForm.secret01[1].checked == true){
		document.vForm.secret.value = 'Y';
	}
	
	document.vForm.action="./boardIns.sg";
	document.vForm.submit();
}

function jf_go(){
	location.href="./boardList.sg?board_id=${boardInfo.BOARD_ID}";
}
//-->
</SCRIPT>

<div id="title_line">
	<div id="title">${boardInfo.BOARD_NM}</div>
	<div id="location">${menuNavi} </div>
</div>


<form name='vForm' method='post' enctype="multipart/form-data">
<input type='hidden' name='qna_writeid' value="${sessionMap.ADMIN_ID }">
<input type='hidden' name='board_id' value="${boardInfo.BOARD_ID }">
<input type='hidden' name='noticeyn' value="N">
<input type='hidden' name='secret'>


<table width="100%" border="0" cellpadding="0" cellspacing="0"  id="table_gray" rules="cols" summary="관리자 관리" class="grid" rules="cols">
	<tr>
		<th scope="col" id="odd" width="100px">이름</td>
		<td><input type='text' size='25' maxlength='25' name='qna_writenm' value="${sessionMap.ADMIN_NM }"></td>
		<th scope="col" id="odd" width="100px">이메일</td>
		<td><input type='text' size='50' maxlength='50' name='qna_mail' value="${sessionMap.ADMIN_MAIL }"></td>
	</tr>
	<tr>
		<th scope="col" id="odd">공개여부</td>
		<td colspan='3'>
			<input type="radio" name="secret01" checked> 공개 
			<input type="radio" name="secret01"> 비공개
		</td>
	</tr>
	<tr>
		<th scope="col" id="odd">패스워드</td>
		<td colspan='3'>
			<input type="password" name="qna_password" size='20' maxlength='20'>
		</td>
	</tr>
	<tr>
		<th scope="col" id="odd">제목</td>
		<td colspan='3'><input type='text' name='qna_title' size='100' maxlength='100'></td>
	</tr>
	<tr>
		<th scope="col" id="odd">내용</td>
		<td colspan='3'>
			<textarea name="qna_contents" cols="80" rows="5" ></textarea>
		</td>
	</tr>
	<tr>
		<th scope="col" id="odd">답변</td>
		<td colspan='3'>
			<textarea name="answer_contents" cols="80" rows="5" ></textarea>
		</td>
	</tr>
	<c:if test="${boardInfo.FILE_YN == 'Y'}">
	<tr>
		<th scope="col" id="odd">첨부파일</td>
		<td colspan='3'>
			<div id='uploadData' style="overflow:hidden;position:relative;top:-5px;left:0;filter:alpha(opacity=0);">
			<input type=file name='upload' id='upload_data0' onchange=fnMUpload(this) style="width:0;cursor:pointer">
			</div>
			<div id=uploadView></div>
		</td>
	</tr>
	</c:if>
	
</table>
	
<div class="btn">						
	<div class="leftbtn">
		
	</div>
	<div class="rightbtn">
		<!-- 권한 에 따른 쓰기기능 제어 시작  -->		
		<c:if test="${writeGrant != '0' }">							
		<input type="button" class="button02" value="저장" onclick="javascript:jf_submit()">
		</c:if>
		<input type="button" class="button03" value="리스트" onclick="javascript:jf_go()">		
	</div>
</div>	
				
</form>
