<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/web/jsp/common/inc/commonInc.jsp" %>
<SCRIPT LANGUAGE="JavaScript">
<!--
function jf_submit(){
	if(document.vForm.board_nm.value == ""){
		alert('게시판 이름을 입력하세요.');
		document.vForm.board_nm.focus();
		return;
	}

	if(document.vForm.btype[0].checked == true){
		document.vForm.board_type.value = "001";
	}else if(document.vForm.btype[1].checked == true){
		document.vForm.board_type.value = "002";
	}else if(document.vForm.btype[2].checked == true){
		document.vForm.board_type.value = "003";
		
		alert('FAQ 게시판은 카데고리 설정을 하셔야합니다.\n 게시판 수정사항으로 가셔서 카테고리를 만들어주세요.');
	}

	document.vForm.action = "./boardMstIns.sg";
	document.vForm.submit();
}


function jf_boardType(type){
	if(type == "001"){
		document.vForm.btype[0].checked = true;
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
		document.vForm.btype[1].checked = true;
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
		document.vForm.btype[2].checked = true;
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

function jf_go(){
	location.href='./boardMstList.sg';
}
//-->
</SCRIPT>
<table width="100%" border="0" cellpadding="0" cellspacing="0">  
	<tr>
		<td align="center" valign="top">
			<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
				<tr valign="middle">
					<td>
						<!--제목과 경로가 들어가는 테이블입니다. -->
							<table width="100%" border="0" cellpadding="0" cellspacing="0">
								<tr>
									<td width="20%" class="txt_tt">게시판 등록 </td>
									<td width="80%" align="right">${menuNavi}</td>
								</tr>
							</table>
						<!--제목과 경로가 들어가는 테이블입니다. -->
					</td>
				</tr> 
				<tr>
					<td height="5" colspan="2" class="line_bg"></td>
				</tr>
				<tr>
					<td colspan="2" align="left" height="40px">&nbsp;</td>
				</tr>
				
				<tr>
					<td colspan="2" >
<form name='vForm' method='post'>
<input type='hidden' name='board_type'>
						<table width="100%" border="0" cellpadding="0" cellspacing="0"  class="grid" rules="cols" summary="관리자 관리">
							<tr>
								<th scope="col" id="odd">게시판 이름</th>
								<td><input type='text' name='board_nm' size=50 maxlength='50'></td>
							</tr>
				
							<tr>
								<th scope="col" id="odd">게시판 유형</th>
								<td>
									<input type='radio' name='btype' onClick="javascript:jf_boardType('001')" checked> 일반게시판
									<input type='radio' name='btype' onClick="javascript:jf_boardType('002')" > QnA게시판
									<input type='radio' name='btype' onClick="javascript:jf_boardType('003')" > FAQ게시판  	
								</td>
							</tr>
				
							<tr>
								<th scope="col" id="odd">게시판 사용여부</th>
								<td>
									<select name='board_use'>
										<option value='Y'>Yes</option>
										<option value='N'>No</option>
									</select>
								</td>
							</tr>
				
							<tr>
								<th scope="col" id="odd">1:1 사용여부</th>
								<td>
									<select name='secret'>
										<option value='Y'>Yes</option>
										<option value='N'>No</option>
									</select>
								</td>
							</tr>
				
							<tr>																	
								<th scope="col" id="odd">답변글 사용여부</th>
								<td>
									<select name='reply_yn'>
										<option value='Y'>Yes</option>
										<option value='N'>No</option>
									</select>
								</td>
							</tr>
				
							<tr>
								<th scope="col" id="odd">댓글 사용여부</th>
								<td>
									<select name='talk_yn'>
										<option value='Y'>Yes</option>
										<option value='N'>No</option>
									</select>
								</td>
							</tr>
				
							<tr>
								<th scope="col" id="odd">첨부파일  사용여부</th>
								<td>
									<select name='file_yn'>
										<option value='Y'>Yes</option>
										<option value='N'>No</option>
									</select>
								</td>
							</tr>
				
							<tr>
								<th scope="col" id="odd">공지사항  사용여부</th>
								<td>
									<select name='notice_yn'>
										<option value='Y'>Yes</option>
										<option value='N'>No</option>
									</select>
								</td>
							</tr>
				
							<tr>
								<th scope="col" id="odd">관리자만 글쓰기권한</th>
								<td>
									<select name='awriteyn'>
										<option value='Y'>Yes</option>
										<option value='N'>No</option>
									</select>
								</td>
										
								
							</tr>
						</table>
</form>							
					</td>
				</tr>
				<tr align="center" valign="middle">
					<td colspan='2' align='center'>
					<!-- 권한 에 따른 쓰기기능 제어 시작  -->		
					<c:if test="${writeGrant != '0' }">
					<input type="button" class="button" value="게시판 만들기" onclick="javascript:jf_submit()">
					</c:if>
					<input type="button" class="button" value="리스트" onclick="javascript:jf_go()">
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>

<!-- 일반 게시판 체크 -->
<script>jf_boardType('001')</script>