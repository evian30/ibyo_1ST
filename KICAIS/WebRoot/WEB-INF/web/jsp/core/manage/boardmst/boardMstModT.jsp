<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/web/jsp/common/inc/commonInc.jsp" %>
<SCRIPT LANGUAGE="JavaScript">
<!--
function jf_submit(){

	document.vForm.action = "./boardMstUpd.sg";
	document.vForm.submit();
}

function jf_copy(){
	window.clipboardData.setData("Text", document.getElementById("bcopy").innerHTML);
}

function jf_cateAdd(){
	if(document.vForm.faq_nm.value == ""){
		alert('카테고리를 입력하세요.');
		document.vForm.faq_nm.focus();
		return;
	}
	document.vForm.action = "./faqCateAdd.sg";
	document.vForm.submit();
}

function jf_cateMod(){
	if(document.vForm.faq_cd.value == ""){
		alert('수정할 카테고리를 선택하세요.');
		document.vForm.faq_cd.focus();
		return;
	}
	document.vForm.action = "./faqCateMod.sg";
	document.vForm.submit();
}

function jf_cateDel(){
	if(document.vForm.faq_cd.value == ""){
		alert('카테고리를 선택하세요.');
		document.vForm.faq_cd.focus();
		return;
	}
	if(confirm("정말 삭제하시겠습니까?")){
		document.vForm.action = "./faqCateDel.sg";
		document.vForm.submit();
	}
}

function jf_change(form){
	document.vForm.faq_nm.value = form.options[form.selectedIndex].text;
}

function jf_go(){
	location.href='./boardMstList.sg';
}
//-->
</SCRIPT>

<div id="title_line">
	<div id="title">게시판 등록</div>
	<div id="location">${menuNavi} </div>
</div>

<form name='vForm' method='post'>
<input type='hidden' name='board_id' value="${boardInfo.BOARD_ID }">
<input type='hidden' name='board_type' value="${boardInfo.BOARD_TYPE }">


<table width="100%" border="0" cellpadding="0" cellspacing="0"  id="table_gray" summary="관리자 관리" class="grid" rules="cols">
	<tr>
		<th scope="col" id="odd">게시판 이름</th>
		<td><input type='text' name='board_nm' size='50' maxlength='50' value="${boardInfo.BOARD_NM }"></td>
	</tr>

	<tr>
		<th scope="col" id="odd">게시판 주소</th>
		<td>
			<table cellpadding="0" cellspacing="0" border="0">
				<tr>
					<td id='bcopy' width=300>/core/manage/board/boardList.sg?board_id=${boardInfo.BOARD_ID}</td>
					<td> <input type="button" class="buttonsmall04" value="주소복사" onclick="javascript:jf_copy()"></td>
				</tr>
			</table>
		</td>
	</tr>

	<tr>
		<th scope="col" id="odd">게시판 유형</th>
		<td>
			<c:choose>
				<c:when test="${boardInfo.BOARD_TYPE == '001' }">일반 게시판</c:when>
				<c:when test="${boardInfo.BOARD_TYPE == '002' }">Q&A 게시판</c:when>
				<c:when test="${boardInfo.BOARD_TYPE == '003' }">FAQ 게시판</c:when>
			</c:choose>
		</td>
	</tr>

	<tr>
		<th scope="col" id="odd">게시판 테이블</th>
		<td>
			<c:if test="${boardInfo.BOARD_TYPE == '001' }">
				게시판 테이블 : ${boardInfo.BOARD_TABLE} <BR>
				게시판 파일테이블 : ${boardInfo.BOARD_TABLE_FILE} <BR>
				게시판 댓글테이블 : ${boardInfo.BOARD_TABLE_TALK} <BR>
			</c:if>
			
			<c:if test="${boardInfo.BOARD_TYPE == '002' }">
				Q&A 테이블 : ${boardInfo.BOARD_TABLE} <BR>
				Q&A 파일테이블 : ${boardInfo.BOARD_TABLE_FILE} <BR>
			</c:if>
			
			<c:if test="${boardInfo.BOARD_TYPE == '003' }">
				FAQ 테이블 : ${boardInfo.BOARD_TABLE} <BR>
			</c:if>
		</td>
	</tr>
<c:if test="${boardInfo.BOARD_TYPE == '003' }">			
	<tr>
		<th scope="col" id="odd">FAQ 카테고리관리</th>
		<td>
			<table>
				<tr>
					<td>
						<input type="button" class="green_txt_b" value="카테고리 등록" onclick="javascript:jf_cateAdd()">
						<input type="button" class="green_txt_b" value="카테고리 수정" onclick="javascript:jf_cateMod()">
						<input type="button" class="green_txt_b" value="카테고리 삭제" onclick="javascript:jf_cateDel()">
						<BR>
						<input type="text" name='faq_nm' size='25' maxlength='25'>												
					</td>
				</tr>
				<tr>
					<td>
						<select multiple name="faq_cd" style="width:200px;height:200px;" onChange="javascript:jf_change(this)">
						<c:forEach items="${faqCateList}" var="faq">
							<option value='${faq.FAQ_CD }'>${faq.FAQ_NM}</option>
						</c:forEach>									
						</select>							
					</td>
				</tr>
			</table>
		</td>
	</tr>
</c:if>			
	<tr>
		<th scope="col" id="odd">게시판 사용여부</th>
		<td>
			<select name='board_use'>
				<option value='Y' <c:if test="${boardInfo.BOARD_USE == 'Y' }">selected</c:if>>Yes</option>
				<option value='N' <c:if test="${boardInfo.BOARD_USE == 'N' }">selected</c:if>>No</option>
			</select>
		</td>
	</tr>

	<tr>
		<th scope="col" id="odd">1:1 사용여부</th>
		<td>
			<select name='secret'>
				<option value='Y' <c:if test="${boardInfo.SECRET == 'Y' }">selected</c:if>>Yes</option>
				<option value='N' <c:if test="${boardInfo.SECRET == 'N' }">selected</c:if>>No</option>
			</select>
		</td>
	</tr>
	
	<tr>
		<th scope="col" id="odd">답변글 사용여부</th>
		<td>
			<select name='reply_yn'>
				<option value='Y' <c:if test="${boardInfo.REPLY_YN == 'Y' }">selected</c:if>>Yes</option>
				<option value='N' <c:if test="${boardInfo.REPLY_YN == 'N' }">selected</c:if>>No</option>
			</select>
		</td>
	</tr>
	
	<tr>
		<th scope="col" id="odd">댓글 사용여부</th>
		<td>
			<select name='talk_yn'>
				<option value='Y' <c:if test="${boardInfo.TALK_YN == 'Y' }">selected</c:if>>Yes</option>
				<option value='N' <c:if test="${boardInfo.TALK_YN == 'N' }">selected</c:if>>No</option>
			</select>
		</td>
	</tr>
	
	<tr>
		<th scope="col" id="odd">첨부파일  사용여부</th>
		<td>
			<select name='file_yn'>
				<option value='Y' <c:if test="${boardInfo.FILE_YN == 'Y' }">selected</c:if>>Yes</option>
				<option value='N' <c:if test="${boardInfo.FILE_YN == 'N' }">selected</c:if>>No</option>
			</select>
		</td>
	</tr>
	
	<tr>
		<th scope="col" id="odd">공지사항  사용여부</th>
		<td>
			<select name='notice_yn'>
				<option value='Y' <c:if test="${boardInfo.NOTICE_YN == 'Y' }">selected</c:if>>Yes</option>
				<option value='N' <c:if test="${boardInfo.NOTICE_YN == 'N' }">selected</c:if>>No</option>
			</select>
		</td>
	</tr>
	
	<tr>
		<th scope="col" id="odd">관리자만 글쓰기권한</th>
		<td>
			<select name='awriteyn'>
				<option value='Y' <c:if test="${boardInfo.AWRITEYN == 'Y' }">selected</c:if>>Yes</option>
				<option value='N' <c:if test="${boardInfo.AWRITEYN == 'N' }">selected</c:if>>No</option>
			</select>
		</td>
	</tr>
</table>
</form>			

<div class="btn">						
	<div class="leftbtn">
		
	</div>
	<div class="rightbtn">
		<!-- 권한 에 따른 쓰기기능 제어 시작  -->		
		<c:if test="${writeGrant != '0' }">
			<input type="button" class="button02" value="수정" onclick="javascript:jf_submit()">
		</c:if>
			<input type="button" class="button03" value="리스트" onclick="javascript:jf_go()">
	</div>
</div>
	

<SCRIPT>
function jf_boardType(type){
	if(type == "001"){
		document.vForm.reply_yn.value = 'Y';
		document.vForm.reply_yn.disabled = false;
		
		document.vForm.talk_yn.value = 'Y';
		document.vForm.talk_yn.disabled = false;
		
		document.vForm.file_yn.value = 'Y';
		document.vForm.file_yn.disabled = false;
		
		document.vForm.notice_yn.value = 'Y';
		document.vForm.notice_yn.disabled = false;
		
		document.vForm.secret.value = 'N';
		document.vForm.secret.disabled = true;
	}else if(type == "002"){
		document.vForm.reply_yn.value = 'N';
		document.vForm.reply_yn.disabled = true;
		
		document.vForm.talk_yn.value = 'N';
		document.vForm.talk_yn.disabled = true;
		
		document.vForm.file_yn.value = 'Y';
		document.vForm.file_yn.disabled = false;
		
		document.vForm.notice_yn.value = 'N';
		document.vForm.notice_yn.disabled = true;
		
		document.vForm.secret.value = 'Y';
		document.vForm.secret.disabled = false;
	}else if(type == "003"){
		document.vForm.reply_yn.value = 'N';
		document.vForm.reply_yn.disabled = true;
		
		document.vForm.talk_yn.value = 'N';
		document.vForm.talk_yn.disabled = true;
		
		document.vForm.file_yn.value = 'N';
		document.vForm.file_yn.disabled = true;
		
		document.vForm.notice_yn.value = 'N';
		document.vForm.notice_yn.disabled = true;
		
		document.vForm.secret.value = 'N';
		document.vForm.secret.disabled = true;
		
		document.vForm.awriteyn.value = 'Y'
		document.vForm.awriteyn.disabled = true;
	}
}
jf_boardType('${boardInfo.BOARD_TYPE}');
</SCRIPT>