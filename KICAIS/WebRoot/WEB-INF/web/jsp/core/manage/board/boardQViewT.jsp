<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/web/jsp/common/inc/commonInc.jsp" %>
<SCRIPT LANGUAGE="JavaScript">
<!--
function jf_list(board_seq, key, keyword){
	location.href="./boardList.sg?board_id=${boardInfo.BOARD_ID}&board_seq="+board_seq+"&key="+key+"&keyword="+keyword;
}

function jf_modForm(board_seq, key, keyword){
	location.href="./boardModify.sg?board_id=${boardInfo.BOARD_ID}&board_seq="+board_seq+"&key="+key+"&keyword="+keyword;
}

function jf_delete(board_seq, key, keyword){
	if(confirm('정말 삭제 하시겠습니까?')){
		location.href="./boardDel.sg?board_id=${boardInfo.BOARD_ID}&board_seq="+board_seq+"&key="+key+"&keyword="+keyword;
	}
}

function jf_talk(){
	if(document.vForm.tcontents.value == ""){
		alert('댓글을  입력하세요');
		document.vForm.tcontents.focus();
		return;
	}
	document.vForm.action = "./boardTalkIns.sg?board_id=${boardInfo.BOARD_ID}";
	document.vForm.submit();
}

function jf_answer(){
	if(document.vForm.answer_contents.value == ""){
		alert('답변글을   입력하세요');
		document.vForm.answer_contents.focus();
		return;
	}
	document.vForm.action = "./boardAnsWerIns.sg";
	document.vForm.submit();
}

var blockClick = false;

function jf_blind() {

	var blind = "";
	
	if(document.getElementById("blind").checked == true){
		blind = "Y";
	}else{
		blind = "N";
	}
	
    var url="./boardSecret.sg";
    queryString = "board_id=${boardView.board_id}&board_seq=${boardView.board_seq}&blind="+blind;

    if(blockClick) {
        return;
    }

    blockClick = true;

    httpRequest("POST", url, queryString, true, jf_blindChange);
    
}

var jf_blindChange = function() {
	if( ajax.readyState==4 ) {
		if (ajax.status == 200) {
			var ajaxXml = ajax.responseXML;
			var rvl = "";
			var dataDocument = ajaxXml.getElementsByTagName("BOARDINFO");
			if(dataDocument != undefined && typeof(dataDocument) == 'object') {
            	for(var i = 0; i < dataDocument.length; i++) {
                	rvl = dataDocument[i].getElementsByTagName('DATA')[0].firstChild.nodeValue;             
            	}
        	}
        	
        	if(rvl == "true"){
        		alert("성공적으로 반영했습니다.");
        	}
			
            blockClick = false;
		}else{
			blockClick = false;
		}
 	}
}
//-->
</SCRIPT>
<form name='vForm' method='post'>
<input type='hidden' name='qna_writenm' id='qna_writenm' value="${sessionMap.ADMIN_NM }">
<input type='hidden' name='qna_writeid' id='qna_writeid' value="${sessionMap.ADMIN_ID }">
<input type='hidden' name='board_id' id='board_id' value="${boardInfo.BOARD_ID }">
<input type='hidden' name='board_seq' id='board_seq' value="${boardView.board_seq }">

<div id="title_line">
	<div id="title">${boardInfo.BOARD_NM}</div>
	<div id="location">${menuNavi} </div>
</div>


<table width="100%" border="0" cellpadding="0" cellspacing="0" class="grid" rules="cols">
	<tr>
		<th scope="col" id="odd" width="100px">이름</td>
		<td>${boardView.qna_writenm }</td>
	</tr>
	<tr>
		<th scope="col" id="odd">이메일</td>
		<td>${boardView.qna_mail }</td>
	</tr>
	<tr>
		<th scope="col" id="odd">첨부파일</td>
		<td>
			<c:forEach items="${boardFileList}" var="file" varStatus="i">
			<a href="/download.ddo?fid=board&board_id=${boardView.board_id }&board_seq=${boardView.board_seq }&fseq=${file.FSEQ}">${file.FILENM2 }</a> &nbsp
			</c:forEach>
		</td>
	</tr>
	<tr>
		<th scope="col" id="odd">제목</td>
		<td >
			${boardView.qna_title }
			<br><input type="checkbox" name='blind' onclick="javascript:jf_blind()" <c:if test="${boardView.blind_yn == 'Y'}">checked</c:if> >
			<b>블라인드처리[본인에게만 제목이 보입니다]</b>
		</td>
	</tr>
	<tr>
		<th scope="col" id="odd">내22용</td>
		<td ><str:replace replace="\n" with="<br>" newlineToken="\n">${boardView.qna_contents}</str:replace></td>
	</tr>
	<tr>
		<th scope="col" id="odd">답변</td>
		<td >
			<textarea name="answer_contents" cols="80" rows="5" >${boardView.answer_replay}</textarea>
		</td>
	</tr>
	<tr>
		<td colspan='2' align='center'>
		<!-- 권한 에 따른 쓰기기능 제어 시작  -->		
		<c:if test="${writeGrant != '0' }">
			<input type="button" class="button" value="답변글 저장" style="margin-right:10px;" onclick="javascript:jf_answer()">
			<input type="button" class="button" value="수정" style="margin-right:10px;" onclick="javascript:jf_modForm('${boardView.board_seq}', '${pMap.key}', '${pMap.keyword}')">
			<input type="button" class="button" value="삭제" style="margin-right:10px;" onclick="javascript:jf_delete('${boardView.board_seq}', '${pMap.key}', '${pMap.keyword}')">
		</c:if>
			<input type="button" class="button" value="리스트" style="margin-right:10px;" onclick="javascript:jf_list('${boardView.board_seq}', '${pMap.key}', '${pMap.keyword}')">						
		</td>
	</tr>
</table>

<div class="btn">						
	<div class="leftbtn">
		
	</div>
	<div class="rightbtn">
		<!-- 권한 에 따른 쓰기기능 제어 시작  -->		
		<c:if test="${writeGrant != '0' }">
			<input type="button" class="button05" value="답변글 저장" style="margin-right:10px;" onclick="javascript:jf_answer()">
			<input type="button" class="button02" value="수정" style="margin-right:10px;" onclick="javascript:jf_modForm('${boardView.board_seq}', '${pMap.key}', '${pMap.keyword}')">
			<input type="button" class="button02" value="삭제" style="margin-right:10px;" onclick="javascript:jf_delete('${boardView.board_seq}', '${pMap.key}', '${pMap.keyword}')">
		</c:if>
			<input type="button" class="button03" value="리스트" style="margin-right:10px;" onclick="javascript:jf_list('${boardView.board_seq}', '${pMap.key}', '${pMap.keyword}')">						
		
		<!-- 권한 에 따른 쓰기기능 제어 끝  -->	
	</div>
</div>	


</form>