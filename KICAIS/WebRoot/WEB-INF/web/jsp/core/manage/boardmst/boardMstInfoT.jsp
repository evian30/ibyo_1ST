<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/web/jsp/common/inc/commonInc.jsp" %>
<SCRIPT LANGUAGE="JavaScript">
<!--
function jf_change(form){
	location.href='./boardMstInfo.sg?bid='+form.value;
}


function jf_submit(){

	
	if(document.vForm.btype01[0].checked == true){
		document.vForm.btype.value = "0";
	}else if(document.vForm.btype01[1].checked == true){
		document.vForm.btype.value = "1";
	}

	document.vForm.action='./boardMstController.sg';
	document.vForm.submit();
}
//-->
</SCRIPT>
<form name='vForm' method='post'>
<input type='hidden' name='bid' value='${bInfo.BID}'>
<input type='hidden' name='command' value='modInfo'>
<input type='hidden' name='btype'>
<table width='100%'>
	<tr>
		<td>게시판 이름</td>
		<td>
			<select name='bname' onChange="javascript:jf_change(this)">
				<c:forEach items="${boardMstList}" var="bml">
				    <option value='${bml.BID}' <c:if test="${bml.BID == bInfo.BID}">selected</c:if> >${bml.BNAME}</option>
				</c:forEach>
			</select>
		</td>
	</tr>
	<tr>
		<td>게시판 주소</td>
		<td>http://<%=request.getLocalAddr()%>/board/boardList.sg?bid=${bInfo.BID}</td>
	</tr> 
	<tr>
		<td>게시판 사용유무</td>
		<td>
			<select name='buse'>
				<option value='Y' <c:if test="${bInfo.BUSE == 'Y'}">selected</c:if>>YES</option>
				<option value='N' <c:if test="${bInfo.BUSE == 'N'}">selected</c:if>>NO</option>
			</select>
		</td>
	</tr>   
	<tr>
		<td>게시판 유형</td>
		<td>
		       목록형<input type='radio' name='btype01' <c:if test="${bInfo.BTYPE == '0'}">checked</c:if>> 
		       방명록형<input type='radio' name='btype01' <c:if test="${bInfo.BTYPE == '1'}">checked</c:if>>
	    </td>
	</tr>
	
	<tr>
		<td>답변글 사용 유무</td>
		<td>
			<select name='breply_yn'>
				<option value='Y' <c:if test="${bInfo.BREPLY_YN == 'Y'}">selected</c:if>>YES</option>
				<option value='N' <c:if test="${bInfo.BREPLY_YN == 'N'}">selected</c:if>>NO</option>
			</select>
		</td>
	</tr>
	
	<tr>
		<td>댓글  사용 유무</td>
		<td>
			<select name='btalk_yn'>
				<option value='Y' <c:if test="${bInfo.BTALK_YN == 'Y'}">selected</c:if>>YES</option>
				<option value='N' <c:if test="${bInfo.BTALK_YN == 'N'}">selected</c:if>>NO</option>
			</select>
		</td>
	</tr>
	
	<tr>
		<td>첨부파일  사용 유무</td>
		<td>
			<select name='bfile_yn'>
				<option value='Y' <c:if test="${bInfo.BFILE_YN == 'Y'}">selected</c:if>>YES</option>
				<option value='N' <c:if test="${bInfo.BFILE_YN == 'N'}">selected</c:if>>NO</option>
			</select>
		</td>
	</tr>
	<tr>
		<td colspan='2' align=right>
			<table>
				<tr>
					<td>
					<!-- 권한 에 따른 쓰기기능 제어 시작  -->		
					<c:if test="${writeGrant != '0' }">
					<a href='javascript:jf_submit()'>[수정]</a>
					</c:if>
					<a href='./boardMstList.sg'>[목록]</a>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
</form>
