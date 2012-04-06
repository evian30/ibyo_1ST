<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/web/jsp/common/inc/commonInc.jsp" %>

<SCRIPT LANGUAGE="JavaScript">
<!--



function jf_techsup(){
	document.vForm.action = "/sgportal/techsup/techsupList.sg";
	document.vForm.submit();
}

function jf_chman_list(){
	document.vForm.action = "/sgportal/techsup/chmanList.sg";
	document.vForm.submit();
}

function jf_search(){
	if(document.vForm.keyword.value == ""){
		alert('검색어를 입력하세요');
		document.vForm.keyword.focus();
		return;
	}
	document.vForm.pageNum.value = "1";
	document.vForm.action = '/sgportal/techsup/chmanList.sg';
	document.vForm.submit();
} 

function jf_view(pjt_no, corp_no){
	
	document.vForm.pageNum.value = "1";
	document.vForm.actType.value = 'view';
	document.vForm.pjt_no.value = pjt_no; 
	document.vForm.corp_no.value = corp_no;
	document.vForm.action = "/sgportal/techsup/techsupPjtList.sg";
	document.vForm.submit();
 }

function jf_insert_view(){
	document.vForm.pageNum.value = "1";
	document.vForm.actType.value = 'ins';
	document.vForm.action = "/sgportal/chman/chmanView.sg";
	document.vForm.submit();
}
 
function jf_pjt_view(){
	var param = "actType=ins&corp_no=" + document.vForm.corp_no.value;
	var url = "/sgportal/techsup/pjtView.sg?" + param;
	window.open(url, "", "width=620, height=648, left=250, top=50, scrollbars=yes, resizable=no, menubar=no");
	
}

function jf_pjt_list(){
	document.vForm.pageNum.value = "1";
	document.vForm.actType.value="list";
	document.vForm.action = "/sgportal/techsup/pjtList.sg";
	document.vForm.submit();
}

function jf_regChmanCom(){  
	document.vForm.actType.value="ins"; 
	document.vForm.corp_no.value=""; 
	
	document.vForm.action = "/sgportal/chman/chmanComView.sg?beforeViewName=/sgportal/techsup/pjtList";
	document.vForm.submit();
}

function jf_sup_list(){ 
	document.vForm.action = "/sgportal/techsup/techsupList.sg";
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
	document.vForm.action = "/sgportal/techsup/pjtList.sg";
	document.vForm.submit(); 
}  


function jf_del(){
	if(confirm('삭제 하겠습니까?')){
	 	document.vForm.actType.value = 'mod';
	 	document.vForm.action = "/sgportal/chman/chmanComAction.sg";
	 	//document.vForm.submit();
	}
}

function jf_per_del(){
	if(confirm('영구삭제 하겠습니까?')){
	 	document.vForm.actType.value = 'del';
	 	document.vForm.action = "/sgportal/chman/chmanComAction.sg";
	 	document.vForm.submit();
	}
}


function jf_use_yn(value){
	var m;
	if(value == 'Y'){
		m = "복구 하겠습니까?";
	}else{
		m = "삭제 하겠습니까?";
	}
	
	if(confirm(m)){
	 	document.vForm.actType.value = 'useYn';
	 	document.vForm.action = "/sgportal/chman/chmanComAction.sg?use_yn=" + value;
	 	document.vForm.submit();
	}
}

function jf_goRows(){
	document.vForm.pageNum.value = "1";
	document.vForm.action = "/sgportal/techsup/pjtList.sg";
	document.vForm.submit();
}

//-->
</SCRIPT>
<c:set var="groups" value="${fn:split(sessionMap.GROUPS, ',')}" />


<form name='vForm' method='post'> 
	<input type='hidden' name='pjt_no' value="${pMap.pjt_no}"/>
	<input type='hidden' name='prod_no' value="${pMap.prod_no}"/>
	<input type='hidden' name='tech_sup_no' value="${pMap.tech_sup_no}"/>
	<input type='hidden' name='cont_no' value="${pMap.cont_no}"/>
	<input type="hidden" name="sort" id="sort" value="${pMap.sort}" />
	<input type="hidden" name="sortKey" id="sortKey" value="${pMap.sortKey}" /> 
	<input type="hidden" name="comT" id="comT" value="${pMap.comT}" /> 
	<input type='hidden' name='chman_no' /> 
	<input type='hidden' name='corp_no' value='${pMap.corp_no}' />
	<input type='hidden' name='need_corp_no' value='${pMap.corp_no}' />
	<input type='hidden' name='dept_code' />
	<input type='hidden' name='sign_img_no' />
	<input type='hidden' name='chman_sect_code' />
	<input type='hidden' name='imptc_grade_code' />
	<input type="hidden" name="actType" id="actType" />
	<input type='hidden' name='pageNum' value='${pageNavi.startRowNo}'>

	<div id="title_line">
		<div id="title">
			<c:out value="${fn:split(menuNavi, '>')[0]}"></c:out>
		</div>
		<div id="location">
			${menuNavi}
			> 
			프로젝트 목록
		</div>
	</div>
	 
	<div class="subtitle">고객지원 이력 정보</div>

  	<table width="100%" border="0" cellpadding="0" cellspacing="0" class="grid" rules="cols">
	<tr valign="middle">
		<td width="20%" id="odd" scope="col">
			담당업무
		</td>
		<td width="80%">
			${corp.CORP_NM}
		</td>
	</tr>
	<tr valign="middle">
		<td scope="col" id="odd">
			사업자등록번호
		</td>
		<td>
			<c:if test="${!empty corp.SSN}">
			${fn:substring(corp.SSN,0,3)}-${fn:substring(corp.SSN,3,5)}-${fn:substring(corp.SSN,5,10)}
			</c:if>
		</td>
	</tr>
	<tr valign="middle">
		<td scope="col" id="odd">
			주소
		</td>
		<td>
			<c:if test="${!empty corp.ZIPCODE}">
				${fn:substring(corp.ZIPCODE, 0, 3)}-${fn:substring(corp.ZIPCODE, 3, 6)} <br />
			</c:if>
			${corp.ADDR1} 
			${corp.ADDR2}
		</td>
	</tr>	
	<tr valign="middle">
		<td scope="col" id="odd">
			전화번호
		</td>
		<td width="100">
			${corp.REP_PHONE}
		</td>
	</tr>	
	<tr valign="middle">
		<td scope="col" id="odd">
			팩스번호
		</td>
		<td>
			${corp.REP_FAX}
		</td>
	</tr>
</table>
<br />

<div class="btn">
	<div class="leftbtn">
		
	</div>
 	
 	<div class="rightbtn">
		<!-- 권한 에 따른 쓰기기능 제어 시작  -->		
		<c:forEach items="${groups}" var="group" varStatus="i">
			<c:if test="${group == 'G001'}">
				<c:if test="${corp.USE_YN == 'Y'}">
					<input type="button" class="button02" value="삭제" onclick="jf_use_yn('N')" style="cursor:hand;">
				</c:if>
				<c:if test="${corp.USE_YN == 'N'}">
					<input type="button" class="button02" value="복구" onclick="jf_use_yn('Y')" style="cursor:hand;">
				</c:if>
				<!-- 
				<input type="button" class="button04" value="영구삭제" onclick="jf_per_del()" style="cursor:hand;">
			 -->
			</c:if>
			<c:if test="${group == 'G002'}">
				<!-- <input type="button" class="button02" value="삭제" onclick="jf_del()" style="cursor:hand;"> -->
			</c:if>
		</c:forEach>
	</div>
</div>	  

<br />
		
	
<h3 class="subtitle"> 프로젝트 정보</h3>

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

<!-- 권한 에 따른 쓰기기능 제어 끝  -->						
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="grid" rules="cols">
	<tr>
		<th scope="col" id="odd">
			
		지원번호
		</td>
		<th scope="col" id="odd" onclick="javascript:goSort('PJT_STATUS')" style="cursor:hand;">
			<c:if test="${pMap.sort == '1'}">
				<c:if test="${pMap.sortKey == 'PJT_STATUS'}">
					▲ 
				</c:if>
			</c:if>
			<c:if test="${pMap.sort == '2'}">
				<c:if test="${pMap.sortKey == 'PJT_STATUS'}">
					▼ 
				</c:if>
			</c:if>
		프로젝트상태
		</td>
		<th scope="col" id="odd" onclick="javascript:goSort('WORK_TYPE_CODE_NM')" style="cursor:hand;">
			<c:if test="${pMap.sort == '1'}">
				<c:if test="${pMap.sortKey == 'WORK_TYPE_CODE_NM'}">
					▲ 
				</c:if>
			</c:if>
			<c:if test="${pMap.sort == '2'}">
				<c:if test="${pMap.sortKey == 'WORK_TYPE_CODE_NM'}">
					▼ 
				</c:if>
			</c:if>
		사업구분
		</td> 
		<th scope="col" id="odd" onclick="javascript:goSort('PJT_NAME')" style="cursor:hand;">
			<c:if test="${pMap.sort == '1'}">
				<c:if test="${pMap.sortKey == 'PJT_NAME'}">
					▲ 
				</c:if>
			</c:if>
			<c:if test="${pMap.sort == '2'}">
				<c:if test="${pMap.sortKey == 'PJT_NAME'}">
					▼ 
				</c:if>
			</c:if>
		프로젝트명
		</td>
		<th scope="col" id="odd" onclick="javascript:goSort('CHMAN_NM1')" style="cursor:hand;">
			<c:if test="${pMap.sort == '1'}">
				<c:if test="${pMap.sortKey == 'CHMAN_NM1'}">
					▲ 
				</c:if>
			</c:if>
			<c:if test="${pMap.sort == '2'}">
				<c:if test="${pMap.sortKey == 'CHMAN_NM1'}">
					▼ 
				</c:if>
			</c:if>
		프로젝트 담당자
		</td>
		<th scope="col" id="odd" onclick="javascript:goSort('CHMAN_NM2')" style="cursor:hand;">
			<c:if test="${pMap.sort == '1'}">
				<c:if test="${pMap.sortKey == 'CHMAN_NM2'}">
					▲ 
				</c:if>
			</c:if>
			<c:if test="${pMap.sort == '2'}">
				<c:if test="${pMap.sortKey == 'CHMAN_NM2'}">
					▼ 
				</c:if>
			</c:if>
		SG 담당자
		</td>
		<th scope="col" id="odd" onclick="javascript:goSort('CR_DATE')" style="cursor:hand;">
			<c:if test="${pMap.sort == '1'}">
				<c:if test="${pMap.sortKey == 'CR_DATE'}">
					▲ 
				</c:if>
			</c:if>
			<c:if test="${pMap.sort == '2'}">
				<c:if test="${pMap.sortKey == 'CR_DATE'}">
					▼ 
				</c:if>
			</c:if>
		접수일
		</td>
	</tr>
	<!-- 본문 시작 -->	
	<c:forEach items="${pjt}" var="chman" varStatus="i">
	<tr align="center">
		<td>
			${pageNavi.startRowNo - i.index}
		</td>
		<td>
			${chman.PJT_STATUS}
		</td>
		<td>
			${chman.WORK_TYPE_CODE_NM}
		</td>
		<td align="left">
			<c:if test="${chman.USE_YN == 'N'}">
		   		&nbsp;&nbsp;
				<STRIKE style="color: red;font-weight: bolder;">
					<a href="javascript:jf_view('${chman.PJT_NO}', '${chman.CORP_NO}')">${chman.PJT_NAME}</a>
				</STRIKE>
			</c:if>
			<c:if test="${chman.USE_YN != 'N'}">
		   		&nbsp;&nbsp;
				<a href="javascript:jf_view('${chman.PJT_NO}', '${chman.CORP_NO}')">${chman.PJT_NAME}</a>
			</c:if>
			
		</td> 
		<td>
			${chman.CHMAN_NM2}
		</td>	
		<td>
			${chman.CHMAN_NM1}
		</td>
		<td>
			${chman.CR_DATE}
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
		<input type="button" value="목록" class="button02" onClick="jf_sup_list();"/>
		<!-- 권한 에 따른 쓰기기능 제어 시작 		
		<c:if test="${writeGrant != '0' }">
		<input type="button" value="고객사추가" class="button06" onClick="jf_regChmanCom();"/>
		</c:if>
		 -->
	</div>
	<div class="rightbtn">
		<!-- 권한 에 따른 쓰기기능 제어 시작  -->		
		<c:if test="${writeGrant != '0' }">
		<input type="button"  value="프로젝트 추가" class="button06" onClick="jf_pjt_view();" />
		</c:if>
	</div>
</div>	
	
<iframe name="f_chmanList" id="f_chmanList" style="display:none; height:0px; overflow:hidden;" ></iframe>

</form>