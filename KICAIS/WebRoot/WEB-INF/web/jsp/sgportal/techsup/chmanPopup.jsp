<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/web/jsp/common/inc/commonInc.jsp" %>
<link href="/resource/common/css/common.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" href="/resource/common/css/validator.css" media="screen, projection"/>
<script type="text/javascript" src="/resource/common/js/ajax.js" ></script>
<script type="text/javascript" src="/resource/common/js/validator.js" ></script>
<script type="text/javascript" src="/resource/common/js/jquery.sg.js"></script>

<SCRIPT LANGUAGE="JavaScript">
<!--

 
/*
 * 목록
 */
function jf_chman_list(){
	document.vForm.pageNum.value = "1";
	document.vForm.action = "/sgportal/chman/chmanList.sg?viewName=/sgportal/techsup/chmanPopup";
	document.vForm.submit();
}

/*
 * 담당자 검색
 */
function jf_search(){ 
	document.vForm.pageNum.value = "1";
	document.vForm.action = '/sgportal/chman/chmanList.sg?viewName=/sgportal/techsup/chmanPopup';
	document.vForm.submit();
}

/*
 * 담당자 상세 화면
 */
 function jf_view(chman_no, chman_nm, chman_sect_code, chman_type_code, chman_hp, grad_code, dept_code, corp_nm){
	

	if('${pMap.srcType}'=="sup"){
		if('${pMap.comT}'=="SG"){
			opener.document.vForm.chman_nm_sg.value = chman_nm + " / "+dept_code;
			if(chman_no != ""){
				opener.document.vForm.chman_no_sg.value = chman_no;
			}
			if(chman_sect_code != ""){
				opener.document.vForm.chman_sect_code_sg.value = chman_sect_code;
			}
		}else{
			opener.document.vForm.chman_nm_cu.value = corp_nm+" / "+ chman_nm + " / "+dept_code;
			if(chman_no != ""){
				opener.document.vForm.chman_no_cu.value = chman_no;
			}
			if(chman_sect_code != ""){
				opener.document.vForm.chman_sect_code_cu.value = chman_sect_code;
			}
		}
	}else if('${pMap.srcType}'=="prod"){
		opener.document.vForm.addDev_chman_no.value = chman_no;
		opener.document.vForm.addDev_chman_nm.value = chman_nm;
		opener.document.vForm.addGradeCode.value = grad_code;
		opener.document.vForm.addDeptCode.value = dept_code;
		opener.document.vForm.addDevChman_nm.value = chman_nm;


	}else if('${pMap.srcType}'=="prod2"){
		opener.document.vForm.addDev_chman_no.value = chman_no;
		opener.document.vForm.addDev_chman_nm.value = chman_nm + " ["+ grad_code +" / "+dept_code+"]";
		opener.document.vForm.addGradeCode.value = grad_code;
		opener.document.vForm.addDeptCode.value = dept_code;
		opener.document.vForm.addDevChman_nm.value = chman_nm;
		
		
	}else{ 
		if(document.vForm.type.value == "1"){
			opener.document.vForm.chman_no1.value = chman_no;
			opener.document.vForm.chman_nm1.value = corp_nm + "/" + chman_nm ;
		}else{
			opener.document.vForm.chman_no2.value = chman_no;
			opener.document.vForm.chman_nm2.value = corp_nm + "/" + chman_nm ;
		}
		opener.document.vForm.chman_sect_code.value = chman_sect_code;
	} 
	opener.jf_chmanaddRow();
	 
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
	document.vForm.action = "/sgportal/chman/chmanList.sg?viewName=/sgportal/techsup/chmanPopup";
	document.vForm.submit(); 
}  


function jf_corp_insert(){
	var param = "actType=ins&viewName=/sgportal/chman/chmanComViewPopup";
	var url = "/sgportal/chman/chmanComView.sg?" + param;
	window.open(url, "", "width=620, height=420, left=250, top=50, scrollbars=yes, resizable=no, menubar=no");
}

function jf_chman_insert(){
	var corp_no = document.vForm.corp_no.value;
	var viewName = "/sgportal/chman/chmanViewPopup";
	if(corp_no == ""){
		viewName = "/sgportal/chman/chmanViewPopup2";
	}

	var param = "actType=ins&viewName=" + viewName + "&corp_no=" + corp_no + "&comT=" + document.vForm.comT.value;
	var url = "/sgportal/chman/chmanView.sg?" + param;
	window.open(url, "", "width=620, height=420, left=250, top=50, scrollbars=yes, resizable=no, menubar=no");
}

function jf_close(){
	this.close();
}


//-->
</SCRIPT>
 
<form name='vForm' method='post'>
<input type="hidden" name="sort" id="sort" value="${pMap.sort}" />
<input type="hidden" name="sortKey" id="sortKey" value="${pMap.sortKey}" />
<input type="hidden" name="comT" id="comT" value="${pMap.comT}" />
<input type='hidden' name='chman_no' value=''>
<input type='hidden' name='corp_no' value='${corp.CORP_NO}'>
<input type='hidden' name='dept_code'>
<input type='hidden' name='sign_img_no'>
<input type='hidden' name='chman_type_code'>
<input type='hidden' name='chman_sect_code'>
<input type='hidden' name='imptc_grade_code'>
<input type="hidden" name="actType" id="actType" />
<input type='hidden' name='pageNum' value='${pageNavi.startRowNo}'>
<input type="hidden" name="type" value="${pMap.type}"/>

<input type="hidden" name="srcType" value="${pMap.srcType}"/> 
<div id="title_line">
	<div id="title">
		<c:if test="${pMap.comT == 'CU'}">
			고객 담당자정보
		</c:if>
		<c:if test="${pMap.comT == 'SG'}">
			SG 담당자정보
		</c:if>
	</div>
	<div id="location">담당자정보 > 목록보기 </div>
</div>

<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr><td height="10"></td></tr>
	<tr>
		<td align='right'> 목록수 :
			<select name="pageSize" onChange="jf_chman_list()"> 
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
			
			<!-- 권한 에 따른 쓰기기능 제어 끝  -->						
			<table width="100%" border="0" cellpadding="0" cellspacing="0"  class="grid" rules="cols" summary="관리자 관리">
<tr>					
						
						<c:if test="${pMap.comT=='CU'}">
						<th width="20%" style="cursor:hand;" scope="col" id="odd" onclick="javascript:goSort('CORP_NM')">
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
						고객사
						</th>
						</c:if>
						<th width="17%" style="cursor:hand;" scope="col" id="odd" onclick="javascript:goSort('CHMAN_TYPE_CODE')">
							<c:if test="${pMap.sort == '1'}">
								<c:if test="${pMap.sortKey == 'CHMAN_TYPE_CODE'}">
									▲ 
								</c:if>
							</c:if>
							<c:if test="${pMap.sort == '2'}">
								<c:if test="${pMap.sortKey == 'CHMAN_TYPE_CODE'}">
									▼ 
								</c:if>
							</c:if>
							
							담당 업무
						</th>
						<th width="15%" style="cursor:hand;" scope="col" id="odd" onclick="javascript:goSort('CHMAN_NM')">
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
							성명
						</th>
						<th scope="col" style="cursor:hand;" id="odd" onclick="javascript:goSort('GRADE_CODE')">
							<c:if test="${pMap.sort == '1'}">
								<c:if test="${pMap.sortKey == 'GRADE_CODE'}">
									▲ 
								</c:if>
							</c:if>
							<c:if test="${pMap.sort == '2'}">
								<c:if test="${pMap.sortKey == 'GRADE_CODE'}">
									▼ 
								</c:if>
							</c:if>
							직급/부서
						</th> 
						<th width="20%" style="cursor:hand;" scope="col" id="odd" onclick="javascript:goSort('CHMAN_HP')">
							<c:if test="${pMap.sort == '1'}">
								<c:if test="${pMap.sortKey == 'CHMAN_HP'}">
									▲ 
								</c:if>
							</c:if>
							<c:if test="${pMap.sort == '2'}">
								<c:if test="${pMap.sortKey == 'CHMAN_HP'}">
									▼ 
								</c:if>
							</c:if>
							휴대전화
						</th>
						<!-- 
						<th width="15%" style="cursor:hand;" scope="col" id="odd" onclick="javascript:goSort('CHMAN_EMAIL')">
							<c:if test="${pMap.sort == '1'}">
								<c:if test="${pMap.sortKey == 'CHMAN_EMAIL'}">
									▲ 
								</c:if>
							</c:if>
							<c:if test="${pMap.sort == '2'}">
								<c:if test="${pMap.sortKey == 'CHMAN_EMAIL'}">
									▼ 
								</c:if>
							</c:if>
							이메일
						</th>
						-->
					</tr>
					
				<!-- 본문 시작 -->	
					<c:forEach items="${list}" var="chman" varStatus="i">
					<tr>
						<c:if test="${pMap.comT=='CU'}">
						<td style="padding-left:5px">
							${chman.CORP_NM}
						</td>
						</c:if>
						<td style="padding-left:5px">
							${chman.CHMAN_TYPE_CODE}
						</td>
						<td style="padding-left:5px">
							<a href="javascript:jf_view('${chman.CHMAN_NO}', '${chman.CHMAN_NM}', '${chman.CHMAN_SECT_CODE}', '${chman.CHMAN_TYPE_CODE}', '${chman.CHMAN_HP}', '${chman.GRADE_CODE}', '${chman.DEPT_CODE}', '${chman.CORP_NM}')">${chman.CHMAN_NM}</a>
							
						</td>
						<td style="padding-left:5px">
							${chman.GRADE_CODE} / ${chman.DEPT_CODE}
						</td>
						<td style="padding-left:5px">
							${chman.CHMAN_HP}
						</td>
						<!-- 
						<td style="padding-left:5px">
							${chman.CHMAN_EMAIL}
						</td>	
						 -->	
					</tr>
					</c:forEach>			
				
		<!-- 본문 끝 -->	
			</table>
	 
	<tr><td height="20"></td></tr>
	<tr>
		<td align="center">${pageNavi.pageNavigator}</td>
	</tr>
	<tr><td height="20"></td></tr>
	 
	<tr><td height="20"></td></tr>
</table> 

<b class="rtop"><b class="r1"></b><b class="r2"></b><b class="r3"></b><b class="r4"></b></b> 
	<div class="search" style="height:0px" align="center"> 
	<select name='key' class="gray_txt"> 
			<option value='001' <c:if test="${pMap.key=='001'}">selected="selected"</c:if>>성명</option>
			<option value='002' <c:if test="${pMap.key=='002'}">selected="selected"</c:if>>고객사</option>
		</select>              			
		<input type='text' name='keyword' value='${pMap.keyword}' class="gray_txt" style="width:300px" alt="검색란" onkeypress="javascript:if(event.keyCode=='13'){jf_search();}"> 
		<input type="image" src="/resource/images/bass_1st/btn_search.gif" align="absmiddle" style="cursor:hand;pointer;" onclick="jf_search()" />    
	</div>
<b class="rbottom"><b class="r4"></b><b class="r3"></b><b class="r2"></b><b class="r1"></b></b>
<c:if test="${pMap.srcType != 'prod2'}">
<table width="100%">
<tr>
	<td align="left">
		<input type="button" class="button04" value="새로고침" onclick="javascript:window.location.reload();" style="cursor:hand;">
	</td>
	<td align="right">
		<c:if test="${pMap.group_id != 'G003'}">
			<input type="button" class="button05" value="고객사 등록" onclick="jf_corp_insert()" style="cursor:hand;"> 
			<input type="button" class="button05" value="담당자 등록" onclick="jf_chman_insert()" style="cursor:hand;">
		</c:if>
	</td> 
</tr>
</table>
</c:if>			
<iframe name="f_chmanList" id="f_chmanList" style="display:none; height:0px; overflow:hidden;" ></iframe> 
</form>



<form name="goMenu" method="post">

</form>