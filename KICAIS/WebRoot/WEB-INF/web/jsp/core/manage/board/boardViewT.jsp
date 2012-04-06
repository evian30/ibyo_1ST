<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/web/jsp/common/inc/commonInc.jsp" %>
<SCRIPT LANGUAGE="JavaScript">
<!--

function jf_list(board_seq, key, keyword){
	document.vForm.board_seq.value = board_seq;
	document.vForm.key.value = key;
	document.vForm.keyword.value = keyword;
	document.vForm.action = "./boardList.sg";
	document.vForm.submit();
	
	
	//location.href="./boardList.sg?board_id=${boardInfo.BOARD_ID}&board_seq="+board_seq+"&key="+key+"&keyword="+keyword;
}

function jf_replay(board_seq, key, keyword){
	location.href="./boardReplay.sg?board_id=${boardInfo.BOARD_ID}&board_seq="+board_seq+"&key="+key+"&keyword="+keyword;
}

function jf_modForm(board_seq, key, keyword){
	document.vForm.board_seq.value = board_seq;
	document.vForm.key.value = key;
	document.vForm.keyword.value = keyword;
	document.vForm.action = "./boardModify.sg";
	document.vForm.submit();
	
	
	//location.href="./boardModify.sg?board_id=${boardInfo.BOARD_ID}&board_seq="+board_seq+"&key="+key+"&keyword="+keyword;
}

function jf_delete(board_seq, key, keyword){
	if(confirm('정말 삭제 하시겠습니까?')){
		location.href="./boardDel.sg?board_id=${boardInfo.BOARD_ID}&board_seq="+board_seq+"&key="+key+"&keyword="+keyword;
	}
}

function jf_talk(){
	if(document.vForm.talk_contents.value == ""){
		alert('댓글을  입력하세요');
		document.vForm.talk_contents.focus();
		return;
	}
	document.vForm.action = "./boardTalkIns.sg";
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

function jf_AllCheck(){
	var len = document.vForm.talkseq01.length;
	if(document.vForm.allCheck.checked == true){
		for(var i = 0; i < len; i++){
			document.vForm.talkseq01[i].checked = true;
		}
	}else{
		for(var i = 0; i < len; i++){
			document.vForm.talkseq01[i].checked = false;
		}
	}
}

function jf_talkdelete(){
	
	if(document.vForm.talkseq01 != undefined){
		var len = document.vForm.talkseq01.length;
		var talk_seq = "";
		for(var i = 0; i < len; i++){
			if(document.vForm.talkseq01[i].checked){
				talk_seq = talk_seq +","+document.vForm.talkseq01[i].value;
			}
		}
		
		if(talk_seq == ""){
			alert('삭제할 댓글  선택하세요.');
		}else{
			if(confirm("정말 삭제 하시겠습니까?")){
				document.vForm.talk_seq.value = talk_seq;
				document.vForm.action = "./boardTalkDelete.sg";
				document.vForm.submit();
			}
		}	
	}
}
//-->
</SCRIPT>

<c:set var="groups" value="${fn:split(sessionMap.GROUPS, ',')}" />

	<div id="title_line">
		<div id="title">
			<c:choose>
        		<c:when test="${empty fn:split(menuNavi, '>')[1]}">
        			${menuSecond[0].MENU_NM}
        		</c:when>
        		<c:otherwise>
        			${fn:split(menuNavi, '>')[1]}
        		</c:otherwise>
        	</c:choose>
        </div>
		<div id="location">
			<c:choose>
        		<c:when test="${empty fn:split(menuNavi, '>')[1]}">
        			${menuNavi}
        			>
        			${menuSecond[0].MENU_NM}
        		</c:when>
        		<c:otherwise>
        			${menuNavi}
        		</c:otherwise>
        	</c:choose>
			> 조회
		</div>
	</div>

<table width="100%" border="0" cellpadding="0" cellspacing="0" class="grid" rules="cols">
	<tr>
		<th scope="col" id="odd" width="100px">이름</td><td>${boardView.board_write }</th>
	</tr>
	<tr>
		<th scope="col" id="odd">이메일</td><td>${boardView.board_mail }</th>
	</tr>
	<tr>
		<th scope="col" id="odd">첨부파일</td>
		<td colspan='3'>
			<c:forEach items="${boardFileList}" var="file" varStatus="i">
			<a href="/download.ddo?fid=board&board_id=${boardView.board_id }&board_seq=${boardView.board_seq }&fseq=${file.FILE_SEQ}">${file.FILENM2 }</a> &nbsp
			</c:forEach>
		</td>
	</tr>
	<tr>
		<th scope="col" id="odd">제목</td>
		<td colspan='3'>
			${boardView.board_title } 
			<c:if test="${boardView.write_id == sessionMap.ADMIN_ID}">
				<br><input type="checkbox" name='blind' onclick="javascript:jf_blind()" <c:if test="${boardView.blind_yn == 'Y'}">checked</c:if> >
				<b>블라인드처리[본인에게만 제목이 보입니다]</b>
			</c:if>
		</td>
	</tr>
	<tr>
		<th scope="col" id="odd">내용</td>
		<td colspan='3' style="height:150"  style='padding-left:15px'>${boardView.board_contents}</td>
	</tr>
	<c:if test="${boardInfo.TALK_YN == 'Y'}">
	<tr>
		<th scope="col" id="odd">댓글</td>
		<td colspan='3'>
			<form name='vForm' method='post'>
			<input type='hidden' name='board_id' value="${boardInfo.BOARD_ID}">
			<input type='hidden' name='board_seq' value="${boardView.board_seq}">
			<input type='hidden' name='talk_write' value="${sessionMap.ADMIN_NM}">
			<input type='hidden' name='talk_writeid' value="${sessionMap.ADMIN_ID}">
			<input type='hidden' name='talk_seq'>
			<input type='hidden' name='talkseq01'>
			<input type='hidden' name='key'>
			<input type='hidden' name='keyword'>
			
			
			<table class="grid02" width="100%" border="0">				
				<tr>
					<td colspan='4'>
						<textarea name='talk_contents' style="width:45%;height:55"></textarea>
						&nbsp;&nbsp;
						<input name="button4222" type="button" class="buttonsmall04" onClick="javascript:jf_talk();" align="absmiddle" value="댓글저장"/>
					</td>							
				</tr>
				<c:if test="${fn:length(boardTalkList) > 0}">
				<tr>
					<th style="width:50px" align='center'>
						<c:forEach items="${groups}" var="group" varStatus="i">
							<c:if test="${group == 'G001'}">
								<input type='checkbox' name='allCheck' id="allCheck" onclick="javascript:jf_AllCheck()"><label for="allCheck">전체</label>
							</c:if>
						</c:forEach>
					</th>
					<th colspan="3" style='padding-left:10px'> 
						<input name="button4222" type="button" class="buttonsmall04" onClick="javascript:jf_talkdelete();" value="선택삭제"/>
					</th> 
				</tr>
				</c:if>
				
				<!-- 댓글 리스트 시작 -->
				<c:forEach items="${boardTalkList}" var="talk" varStatus="i">
				<tr>
					<td style="width:50px" align='center'>
						<c:forEach items="${groups}" var="group" varStatus="i">
							<c:if test="${group == 'G001'}">
								<input type='checkbox' name='talkseq01' value='${talk.talk_seq }'>
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							</c:if>
							<c:if test="${group != 'G001' && group != 'G004'}">
								<c:if test="${talk.talk_writeid == sessionMap.ADMIN_ID}">
									<input type='checkbox' name='talkseq01' value='${talk.talk_seq }'>
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								</c:if>
							</c:if>
						</c:forEach>  
					
					</td>
					<td width='10%' align="center"><b style="color:#0080C0"> ${talk.talk_write} </b></td>
					
					<td  style='padding-left:10px'><str:replace replace="\n" with="<br>" newlineToken="\n">${talk.talk_contents}</str:replace> </td>	
					<td width='13%' align="center">${fn:substring(talk.reg_dt, 0, 16)}</td>					
				</tr>
				</c:forEach>
				<!-- 댓글 리스트 끝 -->
			</table>
			</form>
		</td>
	</tr>
	</c:if>
	<tr>
		<th scope="col" id="odd">이전글</td>
		<td colspan='3'><a href="./boardView.sg?board_id=${boardAhead.BOARD_ID}&board_seq=${boardAhead.BOARD_SEQ}">${boardAhead.BOARD_TITLE}</a></td>
	</tr>
	<tr>
		<th scope="col" id="odd">다음글</td>
		<td colspan='3'><a href="./boardView.sg?board_id=${boardNext.BOARD_ID}&board_seq=${boardNext.BOARD_SEQ}">${boardNext.BOARD_TITLE}</a></td>
	</tr>
</table>	

<div class="btn">						
	<div class="leftbtn">
		
	</div> 
	<div class="rightbtn">
		<!-- 권한 에 따른 쓰기기능 제어 시작  -->		
		<c:if test="${writeGrant != '0' }">        	       	
			<c:forEach items="${groups}" var="group" varStatus="i">  
					<c:if test="${boardView.write_id == sessionMap.ADMIN_ID || sessionMap.ADMIN_ID == 'admin'}">
						<input type="button" class="button02" value="수정" onclick="jf_modForm('${boardView.board_seq}', '${pMap.key}', '${pMap.keyword}')">
						<input type="button" class="button02" value="삭제" onclick="jf_delete('${boardView.board_seq}', '${pMap.key}', '${pMap.keyword}')">
					</c:if> 
			</c:forEach>
			
			<c:if test="${boardInfo.REPLY_YN == 'Y' }">
				<input type="button" class="button03" value="답변글" onclick="jf_replay('${boardView.board_seq}', '${pMap.key}', '${pMap.keyword}')">
			</c:if>
			
			<input type="button" class="button02" value="목록" onclick="jf_list('${boardView.board_seq}', '${pMap.key}', '${pMap.keyword}')">
			
		</c:if>	 
		<!-- 권한 에 따른 쓰기기능 제어 끝  -->	
	</div>
</div>	

					