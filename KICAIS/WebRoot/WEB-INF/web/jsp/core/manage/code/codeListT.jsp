<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/web/jsp/common/inc/commonInc.jsp" %>

<SCRIPT LANGUAGE="JavaScript">
<!--
function jf_AllCheck(){
	var len = document.vForm.cd_gid01.length;
	if(document.vForm.allCheck.checked == true){
		for(var i = 0; i < len; i++){
			document.vForm.cd_gid01[i].checked = true;
		}
	}else{
		for(var i = 0; i < len; i++){
			document.vForm.cd_gid01[i].checked = false;
		}
	}
}

function jf_delete(){
	
	if(document.vForm.cd_gid01 != undefined){
		var len = document.vForm.cd_gid01.length;
		var cd_gid = "";
		var cd_id = "";
		for(var i = 0; i < len; i++){
			if(document.vForm.cd_gid01[i].checked){
				var arry = document.vForm.cd_gid01[i].value;
				var temp = arry.split("||");
				
				cd_gid = cd_gid +","+temp[0];
				
				cd_id = cd_id +","+temp[1];
				
			}
		}
		
		if(cd_gid == ""){
			alert('삭제할 코드  선택하세요.');
		}else{
			if(confirm("정말 삭제 하시겠습니까?")){
				document.vForm.cd_gid.value = cd_gid;
				document.vForm.cd_id.value = cd_id;
				document.vForm.action = "./codeDelete.sg";
				document.vForm.submit();
			}
		}	
	}
}
function jf_go(){
	location.href='./codeCreate.sg';
}

function jf_search(){
	
	document.vForm.action="./codeList.sg";
	document.vForm.submit();
	
}
//-->
</SCRIPT>
<form name='vForm' method='post'>
<input type='hidden' name='cd_gid'>
<input type='hidden' name='cd_id'>
<input type='hidden' name='cd_gid01'>	

<div id="title_line">
	<div id="title">코드관리</div>
	<div id="location">${menuNavi} </div>
</div>

<!--search시작-->
<b class="rtop"><b class="r1"></b><b class="r2"></b><b class="r3"></b><b class="r4"></b></b> 
	<div class="search" >
		<!--검색들어가는 부분 -->
		<select name='key' class="gray_txt">
		<option value='0' <c:if test="${pMap.key == '0' || pMap.key == ''}">selected</c:if>>전체</option>
		<option value='1' <c:if test="${pMap.key == '1'}">selected</c:if> >그룹코드</option>
		<option value='2' <c:if test="${pMap.key == '2'}">selected</c:if> >그룹명</option>
		<option value='3' <c:if test="${pMap.key == '3'}">selected</c:if> >코드</option>
		<option value='4' <c:if test="${pMap.key == '4'}">selected</c:if> >코드명</option>
		</select>
	    <input type='text' name='keyword' value='${pMap.keyword}' class="gray_txt" size="30px" alt="검색란" onkeypress="javascript:if(event.keyCode=='13'){jf_search();}" /> 
	    <input type="image" src="/resource/images/bass_1st/btn_search.gif" align="absmiddle" style="cursor:hand;pointer;" onclick="jf_search()" />
		<input type="image" src="/resource/images/bass_1st/btn_refresh.gif" align="absmiddle"  onclick="goRefresh();"/>
	</div>
	 
<b class="rbottom"><b class="r4"></b><b class="r3"></b><b class="r2"></b><b class="r1"></b></b>
<!--search끝-->

	
<table width="100%" border="0" cellpadding="0" cellspacing="0"  id="table_gray" class="grid" rules="cols" summary="관리자 관리">
	<tr>
		<th scope="col" id="odd" width='15%'>
			<input type='checkbox' name='allCheck' onclick="javascript:jf_AllCheck()">선택 |<a href="javascript:jf_delete()">삭제</a>
		</th>
		<th scope="col" id="odd">그룹코드</th>
		<th scope="col" id="odd">그룹명</th>
		<th scope="col" id="odd">코드</th>
		<th scope="col" id="odd">코드명</th> 
		<th scope="col" id="odd">사용유무</th>
	</tr>
	<c:forEach items="${codeList}" var="code">
	    <tr>
	    	<td align='center'><input type='checkbox' name='cd_gid01' value='${code.CD_GID}||${code.CD_ID}'></td>
	        <td align='center'><a href="./codeModify.sg?cd_gid=${code.CD_GID}&cd_id=${code.CD_ID}">${code.CD_GID}</a></td>
	        <td align='center'><a href="./codeModify.sg?cd_gid=${code.CD_GID}&cd_id=${code.CD_ID}">${code.CD_GNM}</a></td>
	        <td align='center'><a href="./codeModify.sg?cd_gid=${code.CD_GID}&cd_id=${code.CD_ID}">${code.CD_ID}</a></td>
	        <td align='center'><a href="./codeModify.sg?cd_gid=${code.CD_GID}&cd_id=${code.CD_ID}">${code.CD_NM}</a></td>
	        <td align='center'>${code.CD_YN}</td>
	    </tr>
	</c:forEach>
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
			<input type="button" class="button05" value="코드 만들기" style="margin-right:10px;" onclick="javascript:jf_go()"/>
		</c:if>
		<!-- 권한 에 따른 쓰기기능 제어 시작  -->
	</div>
</div>

</form>