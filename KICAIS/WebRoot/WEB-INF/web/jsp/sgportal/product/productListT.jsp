<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/web/jsp/common/inc/commonInc.jsp" %>
<script type="text/javascript">
<!--

function goRefresh(){  
	document.vForm.key.value="001";
	document.vForm.keyword.value="";
	document.vForm.pageSize.value="10";
	return true;
}



function prodView(prod_no){
	document.vForm.prod_no.value = prod_no;
	document.vForm.actType.value = "view";
	document.vForm.action = "./prodAction.sg";
	document.vForm.submit();
}

function jf_insView(){
	document.vForm.actType.value = "ins";
	document.vForm.action = "./productAdd.sg";
	document.vForm.submit();
}


function jf_search(){
	document.vForm.key.value = document.getElementById('slkey').value;
	document.vForm.keyword.value = document.getElementById('ipkeyword').value;
	
	if(document.vForm.keyword.value == ""){
		alert('검색어를 입력하세요');
		document.getElementById('ipkeyword').focus();
		return;
	}
	document.vForm.pageNum.value = "1";
	document.vForm.action = "/sgportal/product/productList.sg";
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
	document.vForm.action = "/sgportal/product/productList.sg";
	document.vForm.submit(); 
}  

function jf_goRows(){
	document.vForm.pageNum.value = "1";
	document.vForm.action = "/sgportal/product/productList.sg";
	document.vForm.submit();
}

//-->
</script>

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
			
		</div>
	</div>


<!--search시작-->
<b class="rtop"><b class="r1"></b><b class="r2"></b><b class="r3"></b><b class="r4"></b></b> 
	<div class="search">
		<select name='slkey' id="slkey" class="gray_txt">
			<option value='001' <c:if test="${pMap.key == '001'}">selected</c:if>>제품명</option> 
		</select>              			
     	<input type='text' id="ipkeyword" name='ipkeyword' value='${pMap.keyword}' class="gray_txt" style="width:300px" alt="검색란" onkeypress="javascript:if(event.keyCode=='13'){jf_search();}"/>  
		<input type="image" src="/resource/images/bass_1st/btn_search.gif" align="absmiddle" style="cursor:hand;pointer;" onclick="jf_search()" />
		<!--  
		<img src="/resource/images/bass_1st/btn_search_detail.gif" align="absmiddle"> 
		--> 
		<input type="image" src="/resource/images/bass_1st/btn_refresh.gif" align="absmiddle"  onclick="goRefresh();"/>
		
	</div>
<b class="rbottom"><b class="r4"></b><b class="r3"></b><b class="r2"></b><b class="r1"></b></b>
<!--search끝-->


<form name='vForm' method='post'> 
<input type="hidden" name="sort" id="sort" value="${pMap.sort}" />
<input type="hidden" name="sortKey" id="sortKey" value="${pMap.sortKey}" /> 
<input type="hidden" name="actType" id="actType" />  
<input type="hidden" name="prod_no" id="prod_no" />  
<input type='hidden' name='pageNum' value='${pageNavi.startRowNo}'>
<input type="hidden" name="keyword" id="keyword" value='${pMap.keyword}' />  
<input type="hidden" name="key" id=key />  



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
	<tr>
		<th width="40%" scope="col" id="odd" onclick="javascript:goSort('PROD_NM')" style="cursor:hand;">
			<c:if test="${pMap.sort == '1'}">
				<c:if test="${pMap.sortKey == 'PROD_NM'}">
					▲ 
				</c:if>
			</c:if>
			<c:if test="${pMap.sort == '2'}">
				<c:if test="${pMap.sortKey == 'PROD_NM'}">
					▼ 
				</c:if>
			</c:if>
			제품명
		</th>
		<th width="10%" scope="col" id="odd" onclick="javascript:goSort('PROD_VER')" style="cursor:hand;">
			<c:if test="${pMap.sort == '1'}">
				<c:if test="${pMap.sortKey == 'PROD_VER'}">
					▲ 
				</c:if>
			</c:if>
			<c:if test="${pMap.sort == '2'}">
				<c:if test="${pMap.sortKey == 'PROD_VER'}">
					▼ 
				</c:if>
			</c:if>
			버전
		</th>
		<th width="20%" scope="col" id="odd">
			<!-- 
			<c:if test="${pMap.sort == '1'}">
				<c:if test="${pMap.sortKey == 'CHMAN_NM'}">
					▲ 
				</c:if>
			</c:if>
			<c:if test="${pMap.sort == '2'}">
				<c:if test="${pMap.sortKey == 'CHMAN_NM'}">
					▼ 
				</c:if>
			</c:if>
			 -->
			개발담당자
		</th>
		<th width="15%" scope="col" id="odd" onclick="javascript:goSort('PROD_TYPE_CODE_NM')" style="cursor:hand;">
			<c:if test="${pMap.sort == '1'}">
				<c:if test="${pMap.sortKey == 'PROD_TYPE_CODE_NM'}">
					▲ 
				</c:if>
			</c:if>
			<c:if test="${pMap.sort == '2'}">
				<c:if test="${pMap.sortKey == 'PROD_TYPE_CODE_NM'}">
					▼ 
				</c:if>
			</c:if>
			제품유형
		</th> 
		<th width="15%" scope="col" id="odd" onclick="javascript:goSort('RELEASE_DATE')" style="cursor:hand;">
			<c:if test="${pMap.sort == '1'}">
				<c:if test="${pMap.sortKey == 'RELEASE_DATE'}">
					▲ 
				</c:if>
			</c:if>
			<c:if test="${pMap.sort == '2'}">
				<c:if test="${pMap.sortKey == 'RELEASE_DATE'}">
					▼ 
				</c:if>
			</c:if>
			출시일
		</th>
		</tr>
		<!-- 본문 시작 -->	
	<c:forEach items="${productList}" var="data" varStatus="i">
		<tr height="20px" align="center">
	   	<td align='left'>
	   	<c:if test="${data.USE_YN == 'N'}">
	   		&nbsp;&nbsp;
			<STRIKE style="color: red;font-weight: bolder;">
			
				<a href="javascript:prodView('${data.PROD_NO}')" style="color: c0c0c0;">
		   			${data.PROD_NM}
		   		</a>
		   	
			</STRIKE>
		</c:if>
		
		<c:if test="${data.USE_YN != 'N'}">
			<strong>
			&nbsp;&nbsp;
	   		<a href="javascript:prodView('${data.PROD_NO}')">
	   			${data.PROD_NM}
	   		</a>
	   		</strong>
		</c:if>
	   	
	   	
	   	</td>
	       <td align='center'>${data.PROD_VER}</td>
	       <td align='center'>&nbsp;&nbsp;&nbsp;
	       <!-- ${data.CHMAN_NM} -->
	       <c:forEach items="${devChmanList}" var="data2" varStatus="i">
	       		<c:if test="${data.PROD_NO == data2.PROD_NO}">
	       			${data2.CHMAN_NM}
	       		</c:if>
	       </c:forEach>
	       </td> 
	       <td align='center'>&nbsp;&nbsp;&nbsp;${data.PROD_TYPE_CODE_NM}</td> 
	       <td align='center'>&nbsp;&nbsp;&nbsp;${data.RELEASE_DATE}</td> 
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
				<input type="button" class="button02" value="추가" onclick="jf_insView()" style="cursor:hand;">
			</c:if>
		<!-- 권한 에 따른 쓰기기능 제어 시작  -->	
	</div>
</div>			
			
</form>
