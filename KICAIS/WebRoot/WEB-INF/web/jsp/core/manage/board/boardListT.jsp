<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/web/jsp/common/inc/commonInc.jsp" %>

<SCRIPT LANGUAGE="JavaScript">
<!--
function jf_view(board_seq, key, keyword){
	document.vForm.board_seq.value = board_seq;
	document.vForm.key.value = key;
	document.vForm.keyword.value = keyword;
	document.vForm.action = "./boardView.sg";
	document.vForm.submit();
	
	//location.href="./boardView.sg?board_id=${boardInfo.BOARD_ID}&board_seq="+board_seq+"&key="+key+"&keyword="+keyword;
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

	document.vForm.action = "./boardWrite.sg";
	document.vForm.submit();

	//location.href='./boardWrite.sg?board_id=${boardInfo.BOARD_ID}';
}

function b_goRefresh(){  
	document.getElementsByName("key")[0].value="001";
	document.getElementsByName("keyword")[0].value="";
	document.getElementsByName("user_rows")[0].value="10";
	return true;
}

//-->
</SCRIPT>
<c:set var="groups" value="${fn:split(sessionMap.GROUPS, ',')}" />


<form name='vForm' method='post'>
<input type='hidden' name='board_id' id="board_id" value="${boardInfo.BOARD_ID}">
<input type='hidden' name='board_seq' id="board_seq" />
<input type='hidden' name='board_seq01' id="board_seq01" />

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
			> 목록
		</div>
	</div>

<div id="contents">
<!--search시작-->
<b class="rtop"><b class="r1"></b><b class="r2"></b><b class="r3"></b><b class="r4"></b></b> 
<div class="search">
	<select name='key' class="gray_txt">
		<option value='0' <c:if test="${pMap.key == '0'}">selected</c:if>>전체</option>
		<option value='1' <c:if test="${pMap.key == '1'}">selected</c:if>>제목</option>
		<option value='2' <c:if test="${pMap.key == '2'}">selected</c:if>>내용</option>
		<option value='3' <c:if test="${pMap.key == '3'}">selected</c:if>>글쓴이</option>
	</select>    
	
	<input type='text' name='keyword' value='${pMap.keyword}' class="Input_w" style="width:250" alt="검색란" onkeypress="javascript:if(event.keyCode=='13'){jf_search();}"/> 
	<input type="image" src="/resource/images/bass_1st/btn_search.gif" align="absmiddle" style="cursor:hand;pointer;" onclick="jf_search()" />
  	<input type="image" src="/resource/images/bass_1st/btn_refresh.gif" align="absmiddle"  onclick="b_goRefresh();"/>
  	

</div>
<b class="rbottom"><b class="r4"></b><b class="r3"></b><b class="r2"></b><b class="r1"></b></b>
<!--search끝-->
</div>

<div class="rightbtn">
	 <select  name="user_rows" onChange="jf_goRows()"> 
		<option value='10'>10</option>
		<option value='20' <c:if test="${pMap.user_rows == '20'}">selected</c:if>>20</option>
		<option value='50' <c:if test="${pMap.user_rows == '50'}">selected</c:if>>50</option>
		<option value='100' <c:if test="${pMap.user_rows == '100'}">selected</c:if>>100</option>
		<option value='200' <c:if test="${pMap.user_rows == '200'}">selected</c:if>>200</option>
		<option value='250' <c:if test="${pMap.user_rows == '250'}">selected</c:if>>250</option>
	</select>
</div>
						
<div class="btn">						
	<div class="leftbtn">
	</div>
	<div class="rightbtn">
	
		<!-- 권한 에 따른 쓰기기능 제어 시작  -->		
		<c:forEach items="${groups}" var="group" varStatus="i">
			<c:if test="${group == 'G001'}">
				<input type="button" value="삭제" onclick="jf_delete()" class="button02" style="cursor:pointer;" />
			</c:if>
		</c:forEach>
		<!-- 권한 에 따른 쓰기기능 제어 끝  -->	
	</div>
</div>				
					
<!-- 권한 에 따른 쓰기기능 제어 끝  -->															
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="grid" rules="cols">
	<tr align="center">
	<!-- 권한 에 따른 쓰기기능 제어 시작  -->		
	<c:if test="${writeGrant != '0' }">
		<c:forEach items="${groups}" var="group" varStatus="i">
			<c:if test="${group == 'G001'}">	
				<th scope="col" id="odd" width='13%'>
					<input type='checkbox' name='allCheck' onclick="jf_AllCheck()">선택
				</td>
			</c:if>
		</c:forEach>
	</c:if>
	<!-- 권한 에 따른 쓰기기능 제어 끝  -->	
		<th scope="col" id="odd">번호</td>
		<th scope="col" id="odd">제목</td>
		<th scope="col" id="odd">작성자</td> 
		<th scope="col" id="odd">조회수</td>
		<th scope="col" id="odd">날짜</td>
	</tr>

<!-- 공지사항 시작 -->		
<c:if test="${boardInfo.NOTICE_YN == 'Y'}">
<c:forEach items="${boardNoticeList}" var="noticeList" varStatus="i">
	<tr bgcolor='#d2d2d2'>
	<!-- 권한 에 따른 쓰기기능 제어 시작  -->		
		<c:if test="${writeGrant != '0' }">
			<c:forEach items="${groups}" var="group" varStatus="i">
				<c:if test="${group == 'G001'}">	
					<td align='center'>&nbsp</td>
				</c:if>
			</c:forEach>
		</c:if>
	<!-- 권한 에 따른 쓰기기능 제어 끝  -->	
        <td align='center'>[공지]</td>
        <td align='left'>&nbsp; 
        	<a href="javascript:jf_view('${noticeList.BOARD_SEQ}', '${pMap.key}', '${pMap.keyword}')">
			${sgstr:getByteCut(noticeList.BOARD_TITLE, 60)}
        	<c:if test="${noticeList.CNT > 0 }">(${noticeList.CNT})</c:if>
        	<c:if test="${noticeList.FCNT > 0 }"><img src="/resource/manage/board/img/icon_file_down.gif" border='0'></c:if>
        	</a>
        </td>
        <td align='center'>${noticeList.BOARD_WRITE}</td>
        <td align='center'>${noticeList.READ_CNT}</td>
        <td align='center'>${noticeList.REG_DT}</td>
    </tr>
</c:forEach>
</c:if>		
<!-- 공지사항 끝 -->	
<!-- 본문 시작 -->	
<c:forEach items="${boardList}" var="board" varStatus="i">
	
    <tr height="20px">
    <!-- 권한 에 따른 쓰기기능 제어 시작  -->		
		<c:if test="${writeGrant != '0' }">
			<c:forEach items="${groups}" var="group" varStatus="j">
				<c:if test="${group == 'G001'}">
    				<td align='center'><input type='checkbox' name='board_seq01' value='${board.BOARD_SEQ}'></td>
    			</c:if>
    		</c:forEach>
    	</c:if>
    <!-- 권한 에 따른 쓰기기능 제어 끝  -->	
        <td align='center'>${pageNavi.startRowNo - i.index}</td>
        <td align='left'>&nbsp;
        	<c:if test="${fn:length(board.THREAD) > 1}">
        		&nbsp;<img src="/resource/images/bass_1st/icon_re.gif">
        	</c:if>  
        	<a href="javascript:jf_view('${board.BOARD_SEQ}', '${pMap.key}', '${pMap.keyword}')">
        	${sgstr:getByteCut(board.BOARD_TITLE, 60)}
        	<c:if test="${board.CNT > 0 }">(${board.CNT})&nbsp;</c:if>
        	<c:if test="${board.FCNT > 0 }"><img src="/resource/manage/board/img/icon_file_down.gif" border='0' alt='첨부파일'>&nbsp;</c:if>
        	<c:if test="${board.SECRET_YN == 'Y'}"><img src="/resource/manage/board/img/lock_i.gif" border='0' alt='비공개' width="15px">&nbsp;</c:if>
        	<c:if test="${board.BLIND_YN == 'Y'}"><img src="/resource/manage/board/img/prohibition_i.gif" border='0' alt='블라이드' width="15px">&nbsp;</c:if>
        	</a>
        </td>
        <td align='center'>${board.BOARD_WRITE}</td>
        <td align='center'>
        	<c:choose>
        		<c:when test="${board.READ_CNT != null && board.READ_CNT != ''}">
        		${board.READ_CNT}
        		</c:when>
        		<c:otherwise>0</c:otherwise>
        	</c:choose>
        </td>
        <td align='center'>${board.REG_DT}</td>
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
			<input type="button" class="button03" value="글쓰기" onclick="jf_go()" style="cursor:hand;">
		</c:if>	
		<!-- 권한 에 따른 쓰기기능 제어 끝  -->	
	</div>
</div>	
					
			
					
</form>