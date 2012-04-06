<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/web/jsp/common/inc/commonInc.jsp" %>
<script src="/resource/common/js/MultiUpload.js"></script>
<script type="text/javascript" src="/resource/common/js/jquery.sg.js"></script>

<style>
.ui-button { margin-left: 0.5px;margin-top: 1px; }
.ui-button-icon-only .ui-button-text { padding: 0em; } 
.ui-autocomplete-input { margin: 0; width:200; margin-top: 0px; }

.ui-autocomplete {
	max-height: 100px;
	overflow-y: auto;
}
/* IE 6 doesn't support max-height
 * we use height instead, but this forces the menu to always be this tall
 */
* html .ui-autocomplete {
	height: 100px;
	width: 100px;
}
</style>

<SCRIPT LANGUAGE="JavaScript">
<!--


$(function() {
	
	$.ajax({
		url: "/sgportal/product/productListXML.sg",
		type: "POST",
		success: function( xmlResponse ) {
			var data = $( "Service", xmlResponse ).map(function() {
				return {
					value: $( "PROD_NM", this ).text(),
					prod_nm: $( "PROD_NM", this ).text(),
					prod_no: $( "PROD_NO", this ).text()
					
				};
			}).get();
			$( "#prod_nm" ).autocomplete({
				source: data,
				minLength: 0,
				select: function( event, ui ) {
					document.vForm.prod_nm.value = ui.item.prod_nm;
					document.vForm.prod_no.value = ui.item.prod_no;
					
				}
			});
		} 
	});
});



function jf_pjtInsProd(){
	if(Validator.validate(document.vForm)){
		if(document.vForm.prod_no.value == ''){
			alert('제품을 선택해주세요.');
			return false;
		}
		oper_code();
		document.vForm.actType.value = 'ins';
		document.vForm.action = "/sgportal/techsup/pjtSupProdAction.sg";
		document.vForm.submit();
	}
}

function jf_pjtModForm(){
	if(Validator.validate(document.vForm)){
		oper_code();
		document.vForm.actType.value = 'mod';
		document.vForm.action = "/sgportal/techsup/pjtSupProdAction.sg";
		document.vForm.submit();
	}
}

function jf_techsupPjtList(){
	document.vForm2.actType.value = 'view';
	document.vForm2.action = "/sgportal/techsup/techsupPjtSupView.sg";
	document.vForm2.submit();
 }

function jf_pjtProdModView(){
	document.vForm2.actType.value = 'mod';
	document.vForm2.action = "/sgportal/techsup/techsupPjtSupView.sg";
	document.vForm2.submit();
}

function jf_srcProd(){
	var param = "viewName=/sgportal/techsup/pjtProdPopup";
	var url = "/sgportal/product/productList.sg?" + param;
	window.open(url, "", "width=620, height=648, left=250, top=50, scrollbars=yes, resizable=no, menubar=no");
} 

function jf_pjtListView(){	
	document.vForm2.actType.value = 'view';
	document.vForm2.action = "/sgportal/techsup/techsupPjtList.sg";
	document.vForm2.submit();
}

function jf_pjtView(){
	var pjt_no = '${pMap.pjt_no}';
	var corp_no = '${pMap.corp_no}';
	var param = "actType=view&corp_no=" + corp_no + "&pjt_no=" + pjt_no;
	var url = "/sgportal/techsup/pjtView.sg?" + param;
	window.open(url, "", "width=620, height=648, left=250, top=50, scrollbars=yes, resizable=no, menubar=no");
}
		
function oper_code(){
	var oc1 = document.vForm.sv_oper_code1.checked;
	var oc2 = document.vForm.sv_oper_code2.checked;
	var oc3 = document.vForm.sv_oper_code3.checked;
	if(oc1 == true) document.vForm.sv_oper_code.value = '1';
	if(oc2 == true)	document.vForm.sv_oper_code.value = '2';
	if(oc3 == true)	document.vForm.sv_oper_code.value = '3';
	if(oc1 == true & oc2 == true) 	document.vForm.sv_oper_code.value = '4';
	if(oc1 == true & oc3 == true) 	document.vForm.sv_oper_code.value = '5';
	if(oc2 == true & oc3 == true) 	document.vForm.sv_oper_code.value = '6';
	if(oc1 == true & oc2 == true & oc3 == true) document.vForm.sv_oper_code.value = '7';
}

function jf_cancel(){
	document.vForm.reset();
}
		
//-->
</SCRIPT>
<c:set var="groups" value="${fn:split(sessionMap.GROUPS, ',')}" />


<form name='vForm2'  method='post'>
	<input type="hidden" name="actType" id="actType" />
	
	<input type="hidden" name="viewName" id="viewName" value=""/> 
	
	<input type="hidden" name="corp_no" id="corp_no" value="${pMap.corp_no}"/> 
	<input type="hidden" name="prod_no" id="prod_no"  value="${pMap.prod_no}"/>
	<input type="hidden" name="pjt_no" id="pjt_no"  value="${pMap.pjt_no}"/>
	<input type="hidden" name="prod_seq" id="prod_seq" value="${pMap.prod_seq}" />
	<input type="hidden" name="tech_sup_no" id="tech_sup_no" value="${pMap.corp_no}"/> 
 	<input type="hidden" name="sv_oper_code" id="sv_oper_code" value="1"/> 
 	<input type="hidden" name="no" id="no" value="${pMap.prod_seq}"/> 
 	<input type="hidden" name="seq" id="seq" value="${prodView.SEQ}"/>
 	

 	
</form>

<form name='vForm' method='post' enctype="multipart/form-data">   
	<input type="hidden" name="corp_no" id="corp_no" value="${pMap.corp_no}"/>
	<input type="hidden" name="actType" id="actType" />
	<input type="hidden" name="prod_no" id="prod_no"  value="${pMap.prod_no}"/>
	<input type="hidden" name="pjt_no" id="pjt_no"  value="${pMap.pjt_no}"/>
	<input type="hidden" name="prod_seq" id="prod_seq" value="${pMap.prod_seq}" />
	<input type="hidden" name="tech_sup_no" id="tech_sup_no" value="${pMap.corp_no}"/> 
 	<input type="hidden" name="sv_oper_code" id="sv_oper_code" value="1"/> 
 	<input type="hidden" name="no" id="no" value="${pMap.prod_seq}"/> 
 	<input type="hidden" name="seq" id="seq" value="${prodView.SEQ}"/> 

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
			> 고객환경  > 
			<c:if test="${pMap.actType == 'view'}">조회</c:if>
			<c:if test="${pMap.actType == 'mod'}">수정</c:if>
			<c:if test="${pMap.actType == 'ins'}">등록</c:if> 
		</div>
	</div>
 	

 	
<h3 class="subtitle"> 회사 정보</h3>
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="grid" rules="cols">
	<tr>
		<th scope="col" id="odd" style="width:20%">고객사정보</th>
		<td> ${corp.CORP_NM}</td>
	</tr>
	<tr>
		<th scope="col" id="odd">중요도</th>
		<td>${corp.IMPTC_GRADE_CODE}</td>
	</tr> 
</table>  
					
<h3 class="subtitle"> 프로젝트 정보</h3>				
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="grid" rules="cols">
	<tr>
		<th scope="col" id="odd" style="width:20%">프로젝트명</th>
		<td>
			<a href="javascript:jf_pjtView();">
				${techsup.PJT_NAME}
			</a>
		</td>
	</tr> 
	<tr>
		<th width="20%" scope="col" id="odd">PM</th>
		<td>${techsup.CHMAN_NM2}</td>
	</tr>
	<tr>
		<th scope="col" id="odd">기간</th>
		<td>${techsup.PJT_ST_DATE} ~ ${techsup.PJT_END_DATE}</td>
	</tr>
	<tr>
		<th scope="col" id="odd">사업구분</th>
		<td>${techsup.WORK_TYPE_CODE_NM}</td>
	</tr>
	<tr>
		<th scope="col" id="odd">비고</th>
		<td>${techsup.PJT_CONTENTS}</td>
	</tr> 
</table>  
				
<h3 class="subtitle"> 고객 환경 정보</h3>		
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="grid" rules="cols">
	<tr>
		<th colspan="2" scope="col" id="odd" style="width:20%">* 서버명</th>
		<td colspan="3" style="width:80%"> 
			<c:choose>
		<c:when test="${pMap.actType == 'ins' || pMap.actType == 'mod'}">
			<input title="서버명" type='text' class="required inputTex" name='setup_sv_hostname' size=60 maxlength='100' 
				value="${prodView.SETUP_SV_HOSTNAME}">
		</c:when>
		<c:otherwise>
		 	${prodView.SETUP_SV_HOSTNAME}
		</c:otherwise>
	</c:choose> 
	</td>
</tr> 
<tr>
	<th colspan="2" scope="col" id="odd" style="width:20%">* IP주소</th>
	<td colspan="3">
		<c:choose>
		<c:when test="${pMap.actType == 'ins' || pMap.actType == 'mod'}">
			<input title="IP주소" type='text' class="required inputTex" name='setup_sv_ip' size=60 maxlength='100' 
				value="${prodView.SETUP_SV_IP}">
		</c:when>
		<c:otherwise>
		 	${prodView.SETUP_SV_IP}
		</c:otherwise>
	</c:choose> 
	</td>
</tr> 	
<tr>
	<th colspan="2" scope="col" id="odd" style="width:20%">* 제품명</th>
	<td colspan="3"> 
		<c:choose>
		<c:when test="${pMap.actType == 'ins' || pMap.actType == 'mod'}">
			<input type="text" title="제품명" class="required inputTex" name="prod_nm" id="prod_nm" value="${prodView.PROD_NM}"  style="width:200" />
			<input type="button" class="buttonsmall04" value="제품검색" onclick="jf_srcProd(' ${prodView.CORP_NO}', 'CU')" /> <br/>
			<input type="hidden" name="ver" />
			<input type="hidden" name="prod_type" />
			
		</c:when>
		<c:otherwise>
		 	  ${prodView.PROD_NM}
		</c:otherwise>
	</c:choose>
	</td>
</tr>  
<tr>
	<th colspan="2" scope="col" id="odd" style="width:20%">수량</th>
	<td colspan="3"> 
		<c:if test="${pMap.actType == 'ins' || pMap.actType == 'mod'}">
			<input type="text" name="cnt" value="${prodView.CNT}" />
		</c:if>
		<c:if test="${pMap.actType == 'view'}">
			${prodView.CNT}
		</c:if>
	</td>
</tr>
<tr>
	<th colspan="2" scope="col" id="odd" style="width:20%">* OS</th>
	<td style="width:20%">
		<c:choose>
		<c:when test="${pMap.actType == 'ins' || pMap.actType == 'mod'}">
			<select class="validate-required-select" name="setup_os_no" id="setup_os_no" title="OS">
				<option value="">
					선택
				</option>
				<c:forEach items="${osList}" var="tc" varStatus="i">
				<option <c:if test="${tc.OS_NO == prodView.OS_NO}"> selected</c:if> value="${tc.OS_NO}">
					${tc.OS_NM} ${tc.OS_VER}
				</option>
				</c:forEach>
			</select>
			</c:when>
			<c:otherwise>
			 	${prodView.OS}
			</c:otherwise>
		</c:choose> 
	</td>
	<th scope="col" id="odd" style="width:20%">OS 경로</th>
	<td>
		<c:choose>
			<c:when test="${pMap.actType == 'ins' || pMap.actType == 'mod'}">
				<input title=OS 경로" type='text' name='setup_path' size=60 maxlength='100' 
					value="${prodView.SETUP_PATH}">
			</c:when>
			<c:otherwise>
			 	${prodView.SETUP_PATH}
			</c:otherwise>
		</c:choose> 
		</td>
</tr> 
<tr>
	<th colspan="2" scope="col" id="odd" style="width:20%">SDK</th>
	<td>
		<input type="hidden" name="o_sdk" id="o_sdk" value="${prodView.SDK_NO}"/>
		
		<c:choose>
		<c:when test="${pMap.actType == 'ins' || pMap.actType == 'mod'}">
			<select name="sdk" id="sdk" title="SDK" >
				<option value="">
					선택
				</option>
				<c:forEach items="${swList1}" var="tc" varStatus="i">
				<option <c:if test="${tc.SW_NM == prodView.SDK_NM}"> selected</c:if> value="${tc.SW_NO}">
					${tc.SW_NM} - ${tc.SW_VER}
				</option>
				</c:forEach>
			</select>
			
		</c:when>
		<c:otherwise>
		 	${prodView.SDK}
		</c:otherwise>
	</c:choose> 
</td>
<th scope="col" id="odd">SDK 경로</th>
<td>
	<c:choose>
		<c:when test="${pMap.actType == 'ins' || pMap.actType == 'mod'}">
			<input title="SDK 경로" type='text' name='sdk_path' size=60 maxlength='100' 
				value="${prodView.SDK_PATH}">
		</c:when>
		<c:otherwise>
		 	${prodView.SDK_PATH}
		</c:otherwise>
	</c:choose> 
	</td>
</tr> 
<tr>
	<th colspan="2" scope="col" id="odd" style="width:20%">WEB</th>
	<td>
		<input type="hidden" name="o_web" id="o_web" value="${prodView.WEB_NO}"/>
		<c:choose>
		<c:when test="${pMap.actType == 'ins' || pMap.actType == 'mod'}">
			<select name="web" id="web" title="WEB " >
				<option value="">
					선택
				</option>
				<c:forEach items="${swList2}" var="tc" varStatus="i">
				<option <c:if test="${tc.SW_NM == prodView.WEB_NM}"> selected</c:if> value="${tc.SW_NO}">
					${tc.SW_NM} ${tc.SW_VER}
				</option>
				</c:forEach>
			</select>
		</c:when>
		<c:otherwise>
		 	${prodView.WEB}
		</c:otherwise>
	</c:choose> 
</td>
<th scope="col" id="odd">WEB 경로</th>
<td>
	<c:choose>
		<c:when test="${pMap.actType == 'ins' || pMap.actType == 'mod'}">
			<input title="WEB 경로" type='text' name='web_path' size=60 maxlength='100' 
				value="${prodView.WEB_PATH}">
		</c:when>
		<c:otherwise>
		 	${prodView.WEB_PATH}
		</c:otherwise>
	</c:choose> 
	</td>
</tr> 
<tr>
	<th colspan="2" scope="col" id="odd" style="width:20%">WAS</th>
	<td>
		<input type="hidden" name="o_was" id="o_was" value="${prodView.WAS_NO}"/>
		<c:choose>
		<c:when test="${pMap.actType == 'ins' || pMap.actType == 'mod'}">
			<select name="was" id="was" title="WAS " >
				<option value="">
					선택
				</option>
				<c:forEach items="${swList3}" var="tc" varStatus="i">
				<option <c:if test="${tc.SW_NM == prodView.WAS_NM}"> selected</c:if> value="${tc.SW_NO}">
					${tc.SW_NM} ${tc.SW_VER}
				</option>
				</c:forEach>
			</select>
		</c:when>
		<c:otherwise>
		 	${prodView.WAS}
		</c:otherwise>
	</c:choose> 
</td>
<th scope="col" id="odd">WAS 경로</th>
<td>
	<c:choose>
		<c:when test="${pMap.actType == 'ins' || pMap.actType == 'mod'}">
			<input title="WEB 경로" type='text' name='was_path' size=60 maxlength='100' 
				value="${prodView.WAS_PATH}">
		</c:when>
		<c:otherwise>
		 	${prodView.WAS_PATH}
		</c:otherwise>
	</c:choose> 
	</td>
</tr> 	
<tr>
	<th rowspan="4" scope="col" id="odd">설치경로</th>
	<th scope="col" id="odd" style="width:20%">Cab</th>
	<td colspan="3">
		<input name="o_cab" type="hidden" value="${prodView.CAB_PATH}" />
		<c:choose>
		<c:when test="${pMap.actType == 'ins' || pMap.actType == 'mod'}">
			<input title="Cab" type='text' name='cab' size=60 maxlength='100' 
				value="${prodView.CAB_PATH}">
		</c:when>
		<c:otherwise>
		 	${prodView.CAB_PATH}
		</c:otherwise>
	</c:choose> 
	</td>
</tr> 
<tr>
	<th scope="col" id="odd" style="width:20%">Lib</th>
	<td colspan="3">
		<input name="o_lib" type="hidden" value="${prodView.LIB_PATH}" />
		<c:choose>
		<c:when test="${pMap.actType == 'ins' || pMap.actType == 'mod'}">
			<input title="Lib" type='text' name='lib' size=60 maxlength='100' 
				value="${prodView.LIB_PATH}">
		</c:when>
		<c:otherwise>
		 	${prodView.LIB_PATH}
		</c:otherwise>
	</c:choose> 
	</td>
</tr> 						
<tr>
	<th scope="col" id="odd" style="width:20%">Config</th>
	<td colspan="3">
		<input name="o_config" type="hidden" value="${prodView.CONFIG_PATH}" />
		<c:choose>
		<c:when test="${pMap.actType == 'ins' || pMap.actType == 'mod'}">
			<input title="Config" type='text' name='config' size=60 maxlength='100' 
				value="${prodView.CONFIG_PATH}">
		</c:when>
		<c:otherwise>
		 	${prodView.CONFIG_PATH}
		</c:otherwise>
	</c:choose> 
	</td>
</tr> 		
<tr>
	<th scope="col" id="odd" style="width:20%">인증서</th>
	<td colspan="3">
		<input name="o_certification" type="hidden" value="${prodView.CERTIFICATION_PATH}" />
		<c:choose>
		<c:when test="${pMap.actType == 'ins' || pMap.actType == 'mod'}">
			<input title="인증서" type='text' name='certification' size=60 maxlength='100' 
				value="${prodView.CERTIFICATION_PATH}">
		</c:when>
		<c:otherwise>
		 	${prodView.CERTIFICATION_PATH}
		</c:otherwise>
	</c:choose> 
	</td>
</tr> 
<tr>
	<th colspan="2" scope="col" id="odd" style="width:20%">설치구분</th>
	<td colspan="3">
		<c:choose>
		<c:when test="${pMap.actType == 'ins' || pMap.actType == 'mod'}">
			<input type='checkbox' name='sv_oper_code1' <c:if test="${pMap.actType == 'ins'}">checked</c:if>
				<c:if test="${prodView.SV_OPER_CODE == '1' || prodView.SV_OPER_CODE == '4' ||prodView.SV_OPER_CODE == '5' || prodView.SV_OPER_CODE == '7' }">checked</c:if>>개발
			<input type='checkbox' name='sv_oper_code2'  
				<c:if test="${prodView.SV_OPER_CODE == '2' || prodView.SV_OPER_CODE == '4' || prodView.SV_OPER_CODE == '6' || prodView.SV_OPER_CODE == '7'}">checked</c:if>>테스트
			<input type='checkbox' name='sv_oper_code3'  
				<c:if test="${prodView.SV_OPER_CODE == '3' || prodView.SV_OPER_CODE == '5' || prodView.SV_OPER_CODE == '6' || prodView.SV_OPER_CODE == '7'}">checked</c:if>>운영
		</c:when>
		<c:otherwise>
		 	${prodView.SV_OPER_CODE_NM}
		</c:otherwise>
	</c:choose> 
	</td>
</tr> 
<tr>
	<th colspan="2" scope="col" id="odd" style="width:20%">업무프로세스</th>
	<td colspan="3">
		<c:choose>
		<c:when test="${pMap.actType == 'ins' || pMap.actType == 'mod'}">
			<select name="prod_use_code" id="prod_use_code" title="업무프로세스 " >
				<option value="">
					선택
				</option>
				<c:forEach items="${prod_use_code}" var="tc" varStatus="i">
				<option <c:if test="${tc.CODE == prodView.PROD_USE_CODE}"> selected</c:if> value="${tc.CODE}">
					${tc.CODE_NM}
				</option>
				</c:forEach>
			</select>
		</c:when>
		<c:otherwise>
		 	${prodView.PROD_USE_CODE_NM}
		</c:otherwise>
	</c:choose> 
	</td>								

</tr> 
<tr>
	<th colspan="2" scope="col" id="odd" style="width:20%">로그경로</th>
	<td colspan="3">
		<input name="o_log_path" type="hidden" value="${prodView.LOG_PATH}" />
		<c:choose>
		<c:when test="${pMap.actType == 'ins' || pMap.actType == 'mod'}">
			<input title="로그경로" type='text' name='log_path' size=60 maxlength='100' 
				value="${prodView.LOG_PATH}">
		</c:when>
		<c:otherwise>
		 	${prodView.LOG_PATH}
		</c:otherwise>
	</c:choose> 
	</td>
</tr> 

<!-- 첨부 파일 S -->
<c:choose>
<c:when test="${fileView != null}">
	<tr>
		<th colspan="2" scope="col" id="odd">첨부파일</th>
		<td colspan='3'>
			<c:forEach items="${fileView}" var="file" varStatus="i">
			<a href="/download.ddo?fid=addfile&add_file_no_key=${file.ADD_FILE_NO}&no_key=${file.NO}">${file.FILE_REAL_NM}</a> 
			
			<c:choose>
				<c:when test="${pMap.actType == 'ins' || pMap.actType == 'mod'}">
					<input type="checkbox" name="del_chk${i.index+1}" id="del_chk${i.index+1}" value="${file.ADD_FILE_NO}">
					<label for="del_chk${i.index+1}">[파일삭제]</label>
				</c:when>
			</c:choose><br/>
			</c:forEach>
		</td>
	</tr>  
</c:when> 
</c:choose> 

<c:choose>
<c:when test="${pMap.actType == 'ins' || pMap.actType == 'mod'}">
	<tr>
		<th colspan="2" scope="col" id="odd">첨부파일</th>
		<td colspan='3'>
			<div id='uploadData' style="overflow:hidden;position:relative;top:-5px;left:0;filter:alpha(opacity=0);">
			<input type=file name='upload' id='upload_data0' onchange=fnMUpload(this) style="width:0;cursor:pointer">
			</div>
			<div id=uploadView></div>
		</td>
	</tr>
</c:when>
</c:choose>
<!-- 첨부 파일 E -->
 
<tr>
	<th colspan="2" scope="col" id="odd" style="width:20%">비고</th>
	<td colspan="3">
		<c:choose>
		<c:when test="${pMap.actType == 'ins' || pMap.actType == 'mod'}">
			<textarea id='pjt_contents' name='prod_use_etc' style='border:1 solid; border-color:#D4D4D4; width:100%; height:110;'>${prodView.PROD_USE_ETC}</textarea>
		</c:when>
		<c:otherwise>
		 	${prodView.PROD_USE_ETC}
		</c:otherwise>
	</c:choose> 
		</td>
	</tr> 
							
</table>  
			
<div class="btn">						
	<div class="leftbtn">
		<input type="button" class="button02" value="목록" onclick="jf_pjtListView()" style="cursor:hand;">
	</div>
	<div class="rightbtn">
		<!-- 권한 에 따른 쓰기기능 제어 시작  -->		
		<c:if test="${writeGrant != '0' }">
			<c:if test="${pMap.actType == 'view'}">
				<c:forEach items="${groups}" var="group" varStatus="i">
					<c:if test="${group == 'G001'}">
						<input type="button" class="button02" value="수정" onclick="jf_pjtProdModView()" style="cursor:hand;">
					</c:if>
				</c:forEach>
				<c:if test="${prodView.CHMAN_NO == sessionMap.SABUN}">
					<input type="button" class="button02" value="수정" onclick="jf_pjtProdModView()" style="cursor:hand;">
				</c:if>
			<!-- input type="button" class="button02" value="삭제" onclick="jf_pjtDel()" style="cursor:hand;"> -->
			</c:if>
			<c:if test="${pMap.actType == 'mod'}">
			<input type="button" class="button02" value="수정" onclick="jf_pjtModForm()" style="cursor:hand;">
			<input type="button" class="button03" value="초기화" onclick="jf_cancel()" style="cursor:hand;">
			</c:if>
			
			<c:if test="${pMap.actType == 'ins'}">
			<input type="button" class="button02" value="추가" onclick="jf_pjtInsProd()" style="cursor:hand;">
			<input type="button" class="button03" value="초기화" onclick="jf_cancel()" style="cursor:hand;">
			</c:if>
		</c:if>
	</div>
</div>	
</form>

<div id="mypopup" style="position: absolute; visibility: hidden; z-index: 0; background-color: #99BDDF;"></div>
			
<c:choose>	
	<c:when test="${result == 'true'}">
		<c:choose>
			<c:when test="${pMap.command == 'mod'}">
				<script>
					alert('수정 하였습니다.');
					document.vForm2.actType.value = 'view';
					document.vForm2.action = "/sgportal/techsup/techsupPjtList.sg";
					document.vForm2.submit();
				</script>	
			</c:when>
			<c:when test="${pMap.command == 'ins'}">
				<script>
					alert('저장 하였습니다.');
					document.vForm2.actType.value = 'view';
					document.vForm2.action = "/sgportal/techsup/techsupPjtList.sg";
					document.vForm2.submit();
				</script>	
			</c:when>
			<c:when test="${pMap.command == 'del'}">
				<script>
					
				</script>	
			</c:when>
		</c:choose>
	</c:when>
	
</c:choose>
			
	
		
	