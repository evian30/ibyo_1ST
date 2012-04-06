<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/web/jsp/common/inc/commonInc.jsp" %>
<link href="/resource/manage/css/admin_sgf.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" href="/resource/common/css/validator.css" media="screen, projection"/>
<script type="text/javascript" src="/resource/common/js/ajax.js" ></script>
<script type="text/javascript" src="/resource/common/js/validator.js" ></script>
<link href="/resource/common/css/common.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="/resource/common/js/jquery.sg.js"></script>

<SCRIPT LANGUAGE="JavaScript">
<!--

function goRefresh(){  
	document.vForm.key.value="001";
	document.vForm.keyword.value="";
	document.vForm.pageSize.value="10";
	return true;
}

 
function jf_view(prod_no, prod_nm, ver, prod_type, cnt){
	opener.document.vForm.prod_no.value = prod_no;
	opener.document.vForm.prod_nm.value = prod_nm;
	opener.document.vForm.ver.value = ver;
	opener.document.vForm.prod_type.value = prod_type;
	opener.document.vForm.cnt.value = cnt;
 	window.close();
}
 
function jf_list(){
	var param = "viewName=/sgportal/techsup/pjtProdPopup";
	document.vForm.action = "/sgportal/product/productList.sg?" + param;
	document.vForm.submit();
}
 
function jf_search(){
	if(document.vForm.keyword.value == ""){
		alert('검색어를 입력하세요');
		document.vForm.keyword.focus();
		return;
	}
	document.vForm.action = '/sgportal/product/productList.sg?viewName=/sgportal/techsup/pjtProdPopup';
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

	var param = "viewName=/sgportal/techsup/pjtProdPopup";
	
	document.vForm.actType.value="view";
	document.vForm.action = "/sgportal/product/productList.sg?" + param;
	document.vForm.submit(); 
}  

//-->
</SCRIPT>

<form name='vForm' method='post'>  
<input type="hidden" name="sort" id="sort" value="${pMap.sort}" />
<input type="hidden" name="sortKey" id="sortKey" value="${pMap.sortKey}" /> 
<input type="hidden" name="actType" id="actType" />   

<div id="title_line">
	<div id="title">SG제품 정보</div>
</div>			


<!--search시작-->
<b class="rtop"><b class="r1"></b><b class="r2"></b><b class="r3"></b><b class="r4"></b></b> 
	<div class="search" >
		<select name='key' class="gray_txt">
			<option value='001' <c:if test="${pMap.key == '001'}">selected</c:if>>제품명</option> 
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



<div align="right">	
	목록수 :
	<select name="pageSize" onChange="javascript:jf_list()"> 
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
		<th width="`5%" scope="col" id="odd">
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
		<th width="20%" scope="col" id="odd" onclick="javascript:goSort('PROD_TYPE_CODE_NM')" style="cursor:hand;">
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
		<th width="`5%" scope="col" id="odd" onclick="javascript:goSort('RELEASE_DATE')" style="cursor:hand;">
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
		<c:forEach items="${productList}" var="prod" varStatus="i">
		<tr>
			<td style="padding-left:5px">
				<a href="javascript:jf_view('${prod.PROD_NO}', '${prod.PROD_NM}','${prod.PROD_VER}','${prod.PROD_TYPE_CODE_NM}','${prod.CNT}')">${prod.PROD_NM}</a>
			</td>
			<td style="padding-left:5px">
				${prod.PROD_VER}
			</td>
			<td style="padding-left:5px"> 
		       <c:forEach items="${devChmanList}" var="data2" varStatus="i">
		       		<c:if test="${prod.PROD_NO == data2.PROD_NO}">
		       			${data2.CHMAN_NM}
		       		</c:if>
		       </c:forEach>
			</td>
			<td style="padding-left:5px">
				${prod.PROD_TYPE_CODE_NM}
			</td>
			<td style="padding-left:5px">
				${prod.RELEASE_DATE}
			</td>		
		</tr>
		</c:forEach>			
	
<!-- 본문 끝 -->	
</table>
	
<div class="paging">
	${pageNavi.pageNavigator}
</div>
 
 				
</form>


<form name="goMenu" method="post"> 
</form>