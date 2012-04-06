<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/web/jsp/common/inc/commonInc.jsp" %>

<SCRIPT LANGUAGE="JavaScript">
<!--
function jf_submit(){

	if(document.vForm.bname.value == ""){
		alert('게시판 이름을 입려하세요..');
		document.vForm.bname.focus();
		return;
	}

	document.vForm.command.value = "add";
	document.vForm.action='boardMst/boardMstController.sg';
	document.vForm.submit();
}

function jf_modSubmit(){

	if(document.vForm.bname.value == ""){
		alert('게시판 이름을 입려하세요..');
		document.vForm.bname.focus();
		return;
	}
	
	document.vForm.command.value = "mod";
	document.vForm.action='boardMst/boardMstController.sg';
	document.vForm.submit();
}


function jf_delete(board_id){
	if(confirm('게시판을 삭제 하시겠습니까?\n\r게시판을 삭제하더라도 게시판은 테이블은 남아있습니다.')){
		location.href ='./boardMstDel.sg?board_id='+board_id;
	}
}

function jf_go(){
	location.href='./boardMstCreate.sg';
}
//-->
</SCRIPT>

<div id="title_line">
	<div id="title">게시판 관리</div>
	<div id="location">${menuNavi} </div>
</div>

<table width="100%" border="0" cellpadding="0" cellspacing="0"  id="table_gray" rules="cols" summary="관리자 관리" class="grid" rules="cols">
	<thead>
		<tr>
		<th scope="col" id="odd">게시판 이름</th>
		<th scope="col" id="odd">사용여부</th>
		<th scope="col" id="odd">테이블명</th>
		<th scope="col" id="odd">생성일</th> 
		<th scope="col" id="odd">게시판 수정</th>
		<th scope="col" id="odd">게시판 삭제</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${boardMstList}" var="bml">
    	<tr id="list03">
	        <td align='center'>${bml.BOARD_NM}</td>
	        <td align='center'>${bml.BOARD_USE}</td>
	        <td align='center'>${bml.BOARD_TABLE}</td>
	        <td align='center'>${bml.REG_DT}</td>
	        <td align='center'>
			<!-- 권한 에 따른 쓰기기능 제어 시작  -->		
			<c:choose>
				<c:when test="${writeGrant != '0' }">	        
					<a href='./boardMstMod.sg?board_id=${bml.BOARD_ID}'>[수정]</a>
				</c:when>
				<c:otherwise>&nbsp;</c:otherwise>
			</c:choose>
			<!-- 권한 에 따른 쓰기기능 제어 끝  -->				        	
	        </td>
	        <td align='center'>
			<!-- 권한 에 따른 쓰기기능 제어 시작  -->		
			<c:choose>
				<c:when test="${writeGrant != '0' }">				        
					<a href="javascript:jf_delete('${bml.BOARD_ID}')">[삭제]</a>
				</c:when>
				<c:otherwise>&nbsp;</c:otherwise>
			</c:choose>
			<!-- 권한 에 따른 쓰기기능 제어 끝  -->					        	
	        </td>
    	</tr>
		</c:forEach>
	</tbody>
</table>


<div class="btn">						
	<div class="leftbtn">
		
	</div>
	<div class="rightbtn">
		<!-- 권한 에 따른 쓰기기능 제어 시작  -->		
		<c:if test="${writeGrant != '0' }">
			<td colspan="2" >
				<input type="button" class="button06" value="게시판 만들기" onclick="javascript:jf_go()"/>
			</td>
		</c:if>
		<!-- 권한 에 따른 쓰기기능 제어 끝  -->	
	</div>
</div>
					