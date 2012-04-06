<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/web/jsp/common/inc/commonInc.jsp" %>

<SCRIPT LANGUAGE="JavaScript">
<!--

var old_id = "";;
function jf_view(id){

	if(old_id != ""){
		document.getElementById(old_id).style.display = "none";
	}
	if(old_id != id){
		document.getElementById(id).style.display = "block";
		old_id = id;
	}else{
		old_id = "";;
	}
}

function jf_search(){
	if(document.vForm.keyword.value == ""){
		alert('검색어를 입력하세요');
		document.vForm.keyword.focus();
		return;
	}
	document.vForm.action = "./boardList.sg?board_id=${boardInfo.BOARD_ID}";
	document.vForm.submit();
}

function jf_goRows(){
	document.vForm.action = "./boardList.sg?board_id=${boardInfo.BOARD_ID}";
	document.vForm.submit();
}

function jf_changeCode(){
	document.vForm.action = "./boardList.sg";
	document.vForm.submit();
}

function jf_modForm(board_seq, key, keyword){
	location.href="./boardModify.sg?board_id=${boardInfo.BOARD_ID}&board_seq="+board_seq+"&key="+key+"&keyword="+keyword;
}

function jf_delete(board_seq, key, keyword){
	if(confirm('정말 삭제 하시겠습니까?')){
		location.href="./boardDel.sg?board_id=${boardInfo.BOARD_ID}&board_seq="+board_seq+"&key="+key+"&keyword="+keyword;
	}
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

<c:set var="groups" value="${fn:split(sessionMap.GROUPS, ',')}" />


<form name='vForm' method='post'>
<input type='hidden' name='board_id' value="${boardInfo.BOARD_ID}">
<input type='hidden' name='board_seq'>
<input type='hidden' name='board_seq01'>

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
    <select name='faq_cd' onChange="javascript:jf_changeCode()" class="gray_txt">
		<option value=''>FAQ 카테고리</option>
			<c:forEach items="${faqcdList}" var="faqcd" varStatus="i">
				<option value='${faqcd.FAQ_CD}'  <c:if test="${pMap.faq_cd == faqcd.FAQ_CD}">selected</c:if> >${faqcd.FAQ_NM}
				</option>
			</c:forEach>
	</select>
	<select name='key' class="gray_txt">
		<option value='0' <c:if test="${pMap.key == '0'}">selected</c:if>>전체</option>
		<option value='1' <c:if test="${pMap.key == '1'}">selected</c:if>>제목</option>
		<option value='2' <c:if test="${pMap.key == '2'}">selected</c:if>>내용</option>
		<option value='3' <c:if test="${pMap.key == '3'}">selected</c:if>>글쓴이</option>
	</select>    
	
	<input type='text' name='keyword' value='${pMap.keyword}' class="Input_w" style="width:250" alt="검색란" onkeypress="javascript:if(event.keyCode=='13'){jf_search();}"/> 
	<img src="/resource/images/bass_1st/btn_search.gif"align="absmiddle" onclick="jf_search()">
  	<img src="/resource/images/bass_1st/btn_refresh.gif" align="absmiddle">
  	

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
					
					
<table width="100%" border="0" cellpadding="0" cellspacing="0"  id="table_gray" rules="cols" summary="관리자 관리" class="grid" rules="cols">
	<tr align="center">
	<!-- 권한 에 따른 쓰기기능 제어 시작  -->		
	<c:if test="${writeGrant != '0' }">
		<th scope="col" id="odd">
			<input type='checkbox' name='allCheck' onclick="javascript:jf_AllCheck()">선택
		</th>
	</c:if>
	<!-- 권한 에 따른 쓰기기능 제어 끝  -->
		<th scope="col" id="odd">번호</th>
		<th scope="col" id="odd">구분</th>
		<th scope="col" id="odd" width='70%'>제목</th> 					
	</tr>
	
<!-- 본문 시작 -->	
	<c:forEach items="${boardList}" var="board" varStatus="i">
	    <tr>
	    <!-- 권한 에 따른 쓰기기능 제어 시작  -->		
		<c:if test="${writeGrant != '0' }">
	    	<td align='center'><input type='checkbox' name='board_seq01' value='${board.board_seq}'></td>
	    </c:if>
		<!-- 권한 에 따른 쓰기기능 제어 끝  -->
	        <td align='center'>${pageNavi.startRowNo - i.index}</td>
	        <td align='center'>${board.faq_nm}</td>
	        <td align='left'>
	        	<a href="javascript:jf_view('DIV${board.board_seq}')">${board.faq_title}</a>
		        	<div ID='DIV${board.board_seq}' style='display:none'>
				        		${board.faq_contents}
	        	<c:forEach items="${groups}" var="group" varStatus="i">
					<c:if test="${group == 'G001'}">
			        		<br>
			        		<a href="javascript:jf_modForm('${board.board_seq}', '${pMap.key}', '${pMap.keyword}')">[수정]</a>
			        		<!--<a href="javascript:jf_delete('${board.board_seq}', '${pMap.key}', '${pMap.keyword}')">[삭제]</a> -->
			        </c:if>
	        	</c:forEach>
	        	</div>
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