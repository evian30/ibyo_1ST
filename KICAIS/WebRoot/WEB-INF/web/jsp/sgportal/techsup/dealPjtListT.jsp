<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/web/jsp/common/inc/commonInc.jsp" %>
<SCRIPT LANGUAGE="JavaScript">
<!--

function jf_search(){
	if(document.vForm.keyword.value == ""){
		alert('검색어를 입력하세요');
		document.vForm.keyword.focus();
		return;
	}
	document.vForm.pageNum.value = "1";
	document.vForm.action = "/sgportal/techsup/dealPjtList.sg";
	document.vForm.submit();
} 

function jf_regDealPjt(){  
	document.vForm.actType.value="ins"; 
	document.vForm.action = "/sgportal/techsup/dealPjtView.sg";
	document.vForm.submit(); 
} 

function jf_regChmanCom(){  
	document.vForm.actType.value="ins"; 
	document.vForm.action = "/sgportal/chman/chmanComView.sg";
	document.vForm.submit();
}

function jf_View(corp_no){ 
	document.vForm.pageNum.value = "1";
	document.vForm.need_corp_no.value=corp_no; 
	document.vForm.corp_no.value=corp_no; 
	document.vForm.actType.value="view"; 
	document.vForm.action = "/sgportal/techsup/dealPjtViewList.sg";
	document.vForm.submit();
}

function goSort(sortKey){
	if(document.vForm.sort.value == "") document.vForm.sort.value = "1";
	if(document.vForm.sortKey.value != sortKey || document.vForm.sort.value == "2"){
		document.vForm.sort.value = "1";
	}else{
		document.vForm.sort.value = "2";
	}
	document.vForm.sortKey.value = sortKey;
	document.vForm.pageNum.value = "1";
	document.vForm.actType.value="view";
	document.vForm.action = "/sgportal/techsup/dealPjtList.sg";
	document.vForm.submit(); 
}  


function jf_goRows(){
	document.vForm.pageNum.value = "1";
	document.vForm.action = "/sgportal/techsup/dealPjtList.sg";
	document.vForm.submit();
}
 
	 
//-->
</SCRIPT>
<form name='vForm' method='post'> 
<input type="hidden" name="sort" id="sort" value="${pMap.sort}" />
<input type="hidden" name="sortKey" id="sortKey" value="${pMap.sortKey}" /> 
<input type="hidden" name="actType" id="actType" /> 
<input type="hidden" name="need_corp_no" id="need_corp_no" />
<input type="hidden" name="corp_no" id="corp_no" />  
<input type='hidden' name='pageNum' id="pageNum" value='${pageNavi.startRowNo}'>
 
<div id="title_line">
	<div id="title">계약정보</div>
	<div id="location">계약정보 > 목록보기 </div>
</div>
  


<!--search시작-->
<b class="rtop"><b class="r1"></b><b class="r2"></b><b class="r3"></b><b class="r4"></b></b> 
	<div class="search" >
		<select name='key' class="gray_txt">
			<option value='001' <c:if test="${pMap.key == '001'}">selected</c:if>>고객사명</option> 
		</select>              			
     		<input type='text' name='keyword' value='${pMap.keyword}' class="gray_txt" style="width:300px" alt="검색란" onkeypress="javascript:if(event.keyCode=='13'){jf_search();}"/>  
		<input type="image" src="/resource/images/bass_1st/btn_search.gif" align="absmiddle" style="cursor:hand;pointer;" onclick="jf_search()" />
		<!--  
		<img src="/resource/images/bass_1st/btn_search_detail.gif" align="absmiddle"> 
		--> 
		<input type="image" src="/resource/images/bass_1st/btn_refresh.gif" align="absmiddle"  onclick="goRefresh();"/>
	</div>
	 
<b class="rbottom"><b class="r4"></b><b class="r3"></b><b class="r2"></b><b class="r1"></b></b>
<!--search끝-->

<h3 class="subtitle"> 고객사정보</h3>
 
<div align="right">	
	목록수 :
	<select name="pageSize" onChange="jf_goRows()"> 
		<option value='10'>10</option>
		<option value='20' <c:if test="${pMap.pageSize == '20'}">selected</c:if>>20</option>
		<option value='50' <c:if test="${pMap.pageSize == '50'}">selected</c:if>>50</option>
		<option value='100' <c:if test="${pMap.pageSize == '100'}">selected</c:if>>100</option>
		<option value='200' <c:if test="${pMap.pageSize == '200'}">selected</c:if>>200</option>
		<option value='250' <c:if test="${pMap.pageSize == '250'}">selected</c:if>>250</option>
	</select>
</div>
				
																		
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="grid" rules="cols">
	<tr align="center">
	<!-- 권한 에 따른 쓰기기능 제어 시작  -->		
	<c:if test="${writeGrant != '0' }">
		<!-- th scope="col" id="odd" width='13%'>
			<input type='checkbox' name='allCheck' onclick="jf_AllCheck()">선택
		</td-->
	</c:if>
	<!-- 권한 에 따른 쓰기기능 제어 끝  -->	
		<th width="10%" scope="col" id="odd" style="width:10%">번호</td>
		<th width="20%" scope="col" id="odd" onclick="javascript:goSort('CORP_NM')" style="cursor:hand;">
			<c:if test="${pMap.sort == '1'}">
				<c:if test="${pMap.sortKey == 'CORP_NM'}">
					▲ 
				</c:if>
			</c:if>
			<c:if test="${pMap.sort == '2'}">
				<c:if test="${pMap.sortKey == 'CORP_NM'}">
					▼ 
				</c:if>
			</c:if>
			고객사명
		</td>
		<th width="15%" scope="col" id="odd" onclick="javascript:goSort('REP_PHONE')" style="cursor:hand;">
			<c:if test="${pMap.sort == '1'}">
				<c:if test="${pMap.sortKey == 'REP_PHONE'}">
					▲ 
				</c:if>
			</c:if>
			<c:if test="${pMap.sort == '2'}">
				<c:if test="${pMap.sortKey == 'REP_PHONE'}">
					▼ 
				</c:if>
			</c:if>
			대표전화
		</td> 
		<th width="15%" scope="col" id="odd" onclick="javascript:goSort('REP_FAX')" style="cursor:hand;">
			<c:if test="${pMap.sort == '1'}">
				<c:if test="${pMap.sortKey == 'REP_FAX'}">
					▲ 
				</c:if>
			</c:if>
			<c:if test="${pMap.sort == '2'}">
				<c:if test="${pMap.sortKey == 'REP_FAX'}">
					▼ 
				</c:if>
			</c:if>
			팩스번호
		</td>
		<th width="40%" scope="col" id="odd" onclick="javascript:goSort('ADDR')" style="cursor:hand;">
			<c:if test="${pMap.sort == '1'}">
				<c:if test="${pMap.sortKey == 'ADDR'}">
					▲ 
				</c:if>
			</c:if>
			<c:if test="${pMap.sort == '2'}">
				<c:if test="${pMap.sortKey == 'ADDR'}">
					▼ 
				</c:if>
			</c:if>
			주소
		</td> 
	</tr>


<!-- 본문 시작 -->	
<c:forEach items="${list}" var="data" varStatus="i">
 
    <tr height="20px">
    <!-- 권한 에 따른 쓰기기능 제어 시작  -->		
		<c:if test="${writeGrant != '0' }">
    	<!-- td align='center'><input type='checkbox' name='board_seq01' value='${board.BOARD_SEQ}'></td-->
    	</c:if>
    <!-- 권한 에 따른 쓰기기능 제어 끝  -->	
    	<td align='center'>${pageNavi.startRowNo - i.index}</td>  
        <td align='left'>
        	<c:if test="${data.USE_YN == 'N'}">
		   		&nbsp;&nbsp;
				<STRIKE style="color: red;font-weight: bolder;">
	    			<a href="javascript:jf_View('${data.CORP_NO}')">${data.CORP_NM}</a>
    			</STRIKE>
    		</c:if>
    		<c:if test="${data.USE_YN != 'N'}">
    			&nbsp;&nbsp;<a href="javascript:jf_View('${data.CORP_NO}')">${data.CORP_NM}</a>
    		</c:if>
    		
    	</td>
        <td align='center'>${data.REP_PHONE}</td>
        <td align='center'>${data.REP_FAX}</td>
        <td align='left'>&nbsp;&nbsp;&nbsp;${data.ADDR}</td> 
    </tr>				 
</c:forEach>
<!-- 본문 끝 -->	
</table>		

<div class="paging">
	${pageNavi.pageNavigator}
</div>						
<div class="btn">						
	<div class="leftbtn">
		<!-- 권한 에 따른 쓰기기능 제어 시작  -->		
		<c:if test="${writeGrant != '0' }">
			<input type="button" class="button05" value="고객사추가" onclick="jf_regChmanCom()" style="cursor:hand;">
		</c:if>
	</div>
	<div class="rightbtn">
		<!-- 권한 에 따른 쓰기기능 제어 시작  -->		
		<c:if test="${writeGrant != '0' }"> 
			  
		</c:if>
		<!-- 권한 에 따른 쓰기기능 제어 시작  -->
	</div>
</div>	

				
</form>