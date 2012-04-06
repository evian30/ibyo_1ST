<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/web/jsp/common/inc/commonInc.jsp" %>

<SCRIPT LANGUAGE="JavaScript">
<!--
function jf_view(board_seq, key, keyword){
	location.href="./boardView.sg?board_id=${boardInfo.BOARD_ID}&board_seq="+board_seq+"&key="+key+"&keyword="+keyword;
}

function jf_search(){
	if(document.vForm.keyword.value == ""){
		alert('검색어를 입력하세요');
		document.vForm.keyword.focus();
		return;
	}
	document.vForm.action = "./boardList.sg";
	document.vForm.submit();
}

function jf_goRows(){
	document.vForm.action = "./boardList.sg";
	document.vForm.submit();
}

function jf_AllCheck(){
	var len = document.vForm.board_seq01.length;
	if(document.vForm.allCheck.checked == true){
		for(var i = 0; i < len; i++){
			document.vForm.board_seq01[i].checked = true;
		}
	}else{
		for(var i = 0; i < len; i++){
			document.vForm.board_seq01[i].checked = false;
		}
	}
}

function jf_delete(){
	
	if(document.vForm.board_seq01 != undefined){
		var len = document.vForm.board_seq01.length;
		var board_seq = "";
		for(var i = 0; i < len; i++){
			if(document.vForm.board_seq01[i].checked){
				board_seq = board_seq +","+document.vForm.board_seq01[i].value;
			}
		}
		
		if(board_seq == ""){
			alert('삭제할 게시물을 선택하세요.');
		}else{
			if(confirm("정말 삭제 하시겠습니까?")){
				document.vForm.board_seq.value = board_seq;
				document.vForm.action = "./boardAllDel.sg";
				document.vForm.submit();
			}
		}	
	}
}

function jf_go(){
	location.href='./boardWrite.sg?board_id=${boardInfo.BOARD_ID}';
}
//-->
</SCRIPT>
<form name='vForm' method='post'>
<input type='hidden' name='board_id' value="${boardInfo.BOARD_ID}">
<input type='hidden' name='board_seq'>
<input type='hidden' name='board_seq01'>


<div id="title_line">
	<div id="title">${boardInfo.BOARD_NM}</div>
	<div id="location">${menuNavi} </div>
</div>	



<table width="100%" height="29" border="0" cellpadding="0" cellspacing="0" background="/resource/images/admin/img/search_bg.gif" summary="검색테이블"  class="grid" rules="cols">
     		<tr>
           		<td  width="10" height="29" ><img src="/resource/images/admin/img/search_left.gif"/></td>
           		<td align="left">
           			<select name='key' class="gray_txt">
					<option value='0' <c:if test="${pMap.key == '0'}">selected</c:if>>전체</option>
					<option value='1' <c:if test="${pMap.key == '1'}">selected</c:if>>제목</option>
					<option value='2' <c:if test="${pMap.key == '2'}">selected</c:if>>내용</option>
					<option value='3' <c:if test="${pMap.key == '3'}">selected</c:if>>글쓴이</option>
			</select>              			
           			<input type='text' name='keyword' value='${pMap.keyword}' class="gray_txt" style="width:300px" alt="검색란" onkeypress="javascript:if(event.keyCode=='13'){jf_search();}"/> 
           			<span class="gray_txt"><input type="button" class="green_txt_b" value="검색" onclick="javascript:jf_search()" style="width:80px;"></span>               			
               	</td>
               	<td align='right'> 목록수 :
			<select name="user_rows" onChange="javascript:jf_goRows()"> 
				<option value='10'>10</option>
				<option value='20' <c:if test="${pMap.user_rows == '20'}">selected</c:if>>20</option>
				<option value='50' <c:if test="${pMap.user_rows == '50'}">selected</c:if>>50</option>
				<option value='100' <c:if test="${pMap.user_rows == '100'}">selected</c:if>>100</option>
				<option value='200' <c:if test="${pMap.user_rows == '200'}">selected</c:if>>200</option>
				<option value='250' <c:if test="${pMap.user_rows == '250'}">selected</c:if>>250</option>
			</select>
		</td>
        <td width="10" background="/resource/images/admin/img/search_right.gif"></td>
    </tr>
</table> 
					
<div class="btn">						
	<div class="leftbtn">
		
	</div>
	<div class="rightbtn">
		<!-- 권한 에 따른 쓰기기능 제어 시작  -->		
		<c:if test="${writeGrant != '0' }">
			<input type="button" value="삭제" onclick="javascript:jf_delete()" class="button02" style="width:80px;cursor:pointer;">
		</c:if>
		<!-- 권한 에 따른 쓰기기능 제어 끝  -->		
	</div>
</div>	

			
					
<table width="100%" border="0" cellpadding="0" cellspacing="0"  id="table_gray" rules="cols" summary="관리자 관리">
	<tr align="center">
	<!-- 권한 에 따른 쓰기기능 제어 시작  -->		
	<c:if test="${writeGrant != '0' }">
		<th scope="col" id="odd" width='10%'>
			<input type='checkbox' name='allCheck' onclick="javascript:jf_AllCheck()"/>선택
		</th>
	</c:if>
	<!-- 권한 에 따른 쓰기기능 제어 끝  -->	
		<th scope="col" id="odd">번호</th>
		<th scope="col" id="odd" width=50%>제목</th>
		<th scope="col" id="odd">작성자</th> 
		<th scope="col" id="odd">등록일</th>
		<th scope="col" id="odd">답변</th>
	</tr>

<!-- 본문 시작 -->	
	<c:forEach items="${boardList}" var="board" varStatus="i">
	    <tr>
	    <!-- 권한 에 따른 쓰기기능 제어 시작  -->		
		<c:if test="${writeGrant != '0' }">
	    	<td align='center'><input type='checkbox' name='board_seq01' value='${board.BOARD_SEQ}'></td>
	    </c:if>
		<!-- 권한 에 따른 쓰기기능 제어 끝  -->
	        <td align='center'>${pageNavi.startRowNo - i.index}</td>
	        <td align='left'>&nbsp;
	        	<a href="javascript:jf_view('${board.BOARD_SEQ}', '${pMap.key}', '${pMap.keyword}')">
	        	${board.QNA_TITLE}
	        	<c:if test="${board.FCNT > 0 }"><img src="/resource/manage/board/img/icon_file_down.gif" border='0'></c:if>
	        	<c:if test="${board.SECRET_YN == 'Y'}">[비공개]</c:if>
	        	<c:if test="${board.BLIND_YN == 'Y'}">[블라인드처리]</c:if>
	        	</a>
	        </td>
	        <td align='center'>${board.QNA_WRITENM}</td>
	        <td align='center'>${board.REG_DT}</td>
	        <td align='center'>		        	
	        	<c:choose>
					<c:when test="${board.ANSWER_DT == null || board.ANSWER_DT == ''}">답변대기</c:when>						
					<c:when test="${board.ANSWER_DT != null}">답변완료</c:when>
				</c:choose> 
	        </td>		       
	    </tr>
	</c:forEach>
<!-- 본문 끝 -->	
</table>		

<div class="paging">
	${pageNavi.pageNavigator}
</div>	

<div class="btn">						
	<div class="leftbtn">
		
	</div>
	<div class="rightbtn">
		<!-- 권한 에 따른 쓰기기능 제어 시작  -->		
		<c:if test="${writeGrant != '0' }">
			<td align="right">
				<input type="button" class="button03" value="글쓰기" style="margin-right:10px;" onclick="javascript:jf_go()">
			</td>
			</c:if>
		<!-- 권한 에 따른 쓰기기능 제어 끝  -->
	</div>
</div>	
			
</form>