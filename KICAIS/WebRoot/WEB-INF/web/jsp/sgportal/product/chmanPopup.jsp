<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/web/jsp/common/inc/commonInc.jsp" %>
<link href="/resource/manage/css/admin_sgf.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" href="/resource/common/css/validator.css" media="screen, projection"/>
<script type="text/javascript" src="/resource/common/js/ajax.js" ></script>
<script type="text/javascript" src="/resource/common/js/validator.js" ></script>
<SCRIPT LANGUAGE="JavaScript">
<!--
function jf_chman_list(){
	document.vForm.action = "./chmanList.sg";
	document.vForm.submit();
}

function jf_search(){
	if(document.vForm.keyword.value == ""){
		alert('검색어를 입력하세요');
		document.vForm.keyword.focus();
		return;
	}
	document.vForm.action = '/sgportal/chman/chmanList.sg';
	document.vForm.submit();
}


 function jf_view(chman_no, chman_nm, chman_sect_code, chman_type_code, chman_hp, grad_code, dept_code){
	if('${pMap.srcType}'=="sup"){
		if('${pMap.comT}'=="SG"){
			opener.document.vForm.chman_nm_sg.value = chman_nm + " ("+chman_hp+")";
			opener.document.vForm.chman_no_sg.value = chman_no;
			opener.document.vForm.chman_sect_code_sg.value = chman_sect_code;
		}else{
			opener.document.vForm.chman_nm_cu.value = chman_nm + " ("+chman_hp+")";
			opener.document.vForm.chman_no_cu.value = chman_no;
			opener.document.vForm.chman_sect_code_cu.value = chman_sect_code;
		}
 
	}else{
		if(document.vForm.type.value == "1"){
			opener.document.vForm.chman_no1.value = chman_no;
			opener.document.vForm.chman_nm1.value = chman_nm;
		}else{
			opener.document.vForm.chman_no2.value = chman_no;
			opener.document.vForm.chman_nm2.value = chman_nm;
		}
		opener.document.vForm.chman_sect_code.value = chman_sect_code;
	} 
 
	//opener.document.vForm.chman_type_code.value = chman_type_code;
	window.close();
	//document.vForm.actType.value = 'view';
	//document.vForm.chman_no.value = chman_no;
 	//var param = 'c_chman_no=' + chman_no;
	//document.vForm.action = "./chmanView.sg";
	//document.vForm.submit();
 }

/*
 * 담당자 등록 화면
 */
 function jf_insert_view(){
	 
	document.vForm.actType.value = 'ins';
	document.vForm.action = "./chmanView.sg";
	document.vForm.submit();
}
 



//-->
</SCRIPT>

<form name='vForm' method='post'>
<!-- SG/고객 구분 -->
<input type="hidden" name="comT" id="comT" value="${pMap.comT}" />

<!-- 고객번호 -->
<input type='hidden' name='chman_no' value=''>

<!-- 법인코드 -->
<input type='hidden' name='corp_no' value='${corp.CORP_NO}'>

<!-- 부서코드 -->
<input type='hidden' name='dept_code'>
<!-- 서명이미지코드 -->
<input type='hidden' name='sign_img_no'>
<!-- 담당자타입코드 -->
<input type='hidden' name='chman_type_code'>
<!-- 담당구분코드 -->
<input type='hidden' name='chman_sect_code'>
<!-- 중요도 등급코드 -->
<input type='hidden' name='imptc_grade_code'>

<input type="hidden" name="actType" id="actType" />

<input type='hidden' name='pageNum' value='${pageNavi.startRowNo}'>


<input type="hidden" name="type" value="${pMap.type}"/>

		

<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td align='right'> 목록수 :
			<select name="pageSize" onChange="javascript:jf_chman_list()"> 
				<option value='10'>10</option>
				<option value='20' <c:if test="${pMap.pageSize == '20'}">selected</c:if>>20</option>
				<option value='50' <c:if test="${pMap.pageSize == '50'}">selected</c:if>>50</option>
				<option value='100' <c:if test="${pMap.pageSize == '100'}">selected</c:if>>100</option>
				<option value='200' <c:if test="${pMap.pageSize == '200'}">selected</c:if>>200</option>
				<option value='250' <c:if test="${pMap.pageSize == '250'}">selected</c:if>>250</option>
			</select>
		</td>
	</tr>
	<tr>
		<td>
			<h5> 담당자 정보</<h5>
			<!-- 권한 에 따른 쓰기기능 제어 끝  -->						
			<table width="100%" border="0" cellpadding="0" cellspacing="0"  id="table_gray" rules="cols" summary="관리자 관리">
					<tr>
						<th scope="col" id="odd">담당 업무</td>
						<th scope="col" id="odd">성명</td>
						<th scope="col" id="odd">직급/부서</td> 
						<th scope="col" id="odd">휴대전화</td>
						<th scope="col" id="odd">이메일</td>
					</tr>
					
				<!-- 본문 시작 -->	
					<c:forEach items="${list}" var="chman" varStatus="i">
					<tr>
						<td>
							${chman.CHMAN_TYPE_CODE}
						</td>
						<td>
							<a href="javascript:jf_view('${chman.CHMAN_NO}', '${chman.CHMAN_NM}', '${chman.CHMAN_SECT_CODE}', '${chman.CHMAN_TYPE_CODE}', '${chman.CHMAN_HP}', '${chman.GRADE_CODE}', '${chman.DEPT_CODE}')">${chman.CHMAN_NM}</a>
							
						</td>
						<td>
							${chman.GRADE_CODE} / ${chman.DEPT_CODE}
						</td>
						<td>
							${chman.CHMAN_HP}
						</td>
						<td>
							${chman.CHMAN_EMAIL}
						</td>		
					</tr>
					</c:forEach>			
				
		<!-- 본문 끝 -->	
			</table>
	<tr align="right" valign="middle">
		<!-- 권한 에 따른 쓰기기능 제어 시작  -->		
		<c:if test="${writeGrant != '0' }">
		<td align="right">
  			<!-- 
  			<input type="button" class="button" value="추가" onclick="javascript:jf_insert_view()" style="cursor:hand;">
			 -->
		</td>
		</c:if>
		<!-- 권한 에 따른 쓰기기능 제어 끝  -->
	</tr>
	<tr>
		<td align="center">${pageNavi.pageNavigator}</td>
	</tr>
	<tr>
		<td align="center">
			<br />
			<select name='key' class="gray_txt">
				<option value='001' >성명</option>
			</select>              			
			<input type='text' name='keyword' value='${pMap.keyword}' class="gray_txt" style="width:300px" alt="검색란" onkeypress="javascript:if(event.keyCode=='13'){jf_search();}"/> 
			<span class="gray_txt"><input type="button" class="buttonsc" value="검색" style="cursor:pointer;" onclick="javascript:jf_search()"></span>               			
    	</td>
	</tr>
</table>		
			
			
			
			
			
					
<iframe name="f_chmanList" id="f_chmanList" style="display:none; height:0px; overflow:hidden;" ></iframe> 
</form>