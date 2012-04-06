<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/web/jsp/common/inc/commonInc.jsp" %>
<link href="/resource/manage/css/admin_sgf.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" href="/resource/common/css/validator.css" media="screen, projection"/>
<link href="/resource/common/css/common.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="/resource/common/js/validator.js" ></script>
<script type="text/javascript" src="/resource/common/js/mini.js"></script>
<script type="text/javascript" src="/resource/common/js/jquery.sg.js"></script>

<style>
.ui-button { margin-left: 0.5px;margin-top: 1px; }
.ui-button-icon-only .ui-button-text { padding: 0em; } 
.ui-autocomplete-input { margin: 0; width:200; margin-top: 0px; text-align: left;}

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
	text-align: left;
}  
</style>

<SCRIPT LANGUAGE="JavaScript">
<!--

/*
$(function() {
	if(${pMap.actType == 'view'}){
		$.ajax({
			url: "/sgportal/techsup/pjtMemoListXML.sg",
			type: "POST",
			data: "pjt_no=" + document.vForm.pjt_no.value ,
			success: function( xmlResponse ) {
				var html = "";
				$( "Service", xmlResponse ).map(function() {
					html += ''
						
						 + '<a onclick="p_click()" style="cursor:pointer; line-height: 20px;">'
						 		+ $( "CHMAN_NO", this ).text() 
						 		+ $( "GRADE_CODE", this ).text() + '&nbsp;'
						 		+ $( "DEPT_CODE", this ).text() + '&nbsp;'
						 		+ '</a> <br/>'
						 + '';

			
					<table width="100%" border="0" cellpadding="0" cellspacing="0" class="grid" rules="cols">
					<tr>
						<th scope="col" id="odd">담당자</td>
						<th scope="col" id="odd">생성일</td>
					</tr>
					<c:forEach items="${memo}" var="memo" varStatus="i">
					<tr align="center">
						<td>
							<a href="javascript:memoContents('${memo.CONTENTS}', '${memo.SEQ}');">${memo.CHMAN_NM}</a>	
						</td>
						<td>
							${memo.CR_DATE}
						</td>
					</tr>
					</c:forEach>			
				</table>
					
					
				})

				document.getElementById("dMemo").innerHTML = html;
			} 
		});
	}
	
});

*/

$(function() {
	
	$.ajax({
		url: "/sgportal/chman/xmlChmanList.sg",
		type: "POST",
		data: "comT=1",
		success: function( xmlResponse ) {
			var data = $( "Service", xmlResponse ).map(function() {
				return {
					value: $( "CORP_NM", this ).text() + "/" + 
						$( "CHMAN_NM", this ).text(),
					chmanNm: $( "CHMAN_NM", this ).text(),
					chmanNo: $( "CHMAN_NO", this ).text(),
					gradeCode: $( "GRADE_CODE", this).text(),
					deptCode: $( "DEPT_CODE", this).text()
				};
			}).get();
			$( "#chman_nm1" ).autocomplete({
				source: data,
				minLength: 0,
				select: function( event, ui ) {
					document.vForm.chman_no1.value = ui.item.chmanNo;
				}
			});
		} 
	});
});

$(function() {
	
	$.ajax({
		url: "/sgportal/chman/xmlChmanList.sg",
		type: "POST",
		data: "comT=2&corp_no=" + document.vForm.corp_no.value,
		success: function( xmlResponse ) {
			var data = $( "Service", xmlResponse ).map(function() {
				return {
					value: $( "CORP_NM", this ).text() + "/" + 
						$( "CHMAN_NM", this ).text(),
					chmanNm: $( "CHMAN_NM", this ).text(),
					chmanNo: $( "CHMAN_NO", this ).text(),
					gradeCode: $( "GRADE_CODE", this).text(),
					deptCode: $( "DEPT_CODE", this).text()
				};
			}).get();
			$( "#chman_nm2" ).autocomplete({
				source: data,
				minLength: 0,
				select: function( event, ui ) {
					document.vForm.chman_no2.value = ui.item.chmanNo;
				}
			});
		} 
	});
});


function jf_pjtInsForm(){ 
	document.vForm.actType.value="ins"; 
	if(Validator.validate(document.vForm)){
 
		if(document.vForm.chman_no2.value==""){
			alert("프로젝트 담당자를 선택해 주세요");
			jf_chman_popup('2');
			return false;
		}
		
		document.vForm.action = "/sgportal/techsup/pjtComAction.sg";
		document.vForm.submit();
	} 
}

function jf_pjtDel(){
	document.vForm.actType.value="del"; 
	document.vForm.action = "/sgportal/techsup/pjtComAction.sg";
	document.vForm.submit();
	
}

function jf_pjtModForm(){
	document.vForm.actType.value="mod"; 
	if(Validator.validate(document.vForm)){
		document.vForm.action = "/sgportal/techsup/pjtComAction.sg";
		document.vForm.submit();
	}
}

function jf_pjtMoView(){
	document.vForm.actType.value = "mod";
	document.vForm.action = "./pjtView.sg";
	document.vForm.submit();
	
}

function jf_cancel(){
	document.vForm.reset();
}

function jf_chman_popup(sect){
	var comT = "";
	var corp_no = "";
	var corp_sect_code = '${techsup.CORP_SECT_CODE}';
	var param = "";
	if(sect == '1' || corp_sect_code == '1'){
		comT = "SG";
		corp_no = "COR1011022247591";
		param = "comT=" + comT 
			+ "&corp_no=" + corp_no 
			+ "&viewName=/sgportal/techsup/chmanPopup&type=" + sect;
			//+ "&group_id=G003";
	}else{
		comT = "CU";
		corp_no = document.vForm.corp_no.value;
		param = "comT=" + comT 
			+ "&corp_no=" + corp_no 
			+ "&viewName=/sgportal/techsup/chmanPopup&type=" + sect;
	}
	
	var url = "/sgportal/chman/chmanList.sg?" + param;
	window.open(url, "", "width=800, height=600, left=250, top=50, scrollbars=yes, resizable=no, menubar=no");
	
}

function memoContents(contents, seq){
	document.vForm.memoActType.value = 'mod';
	document.vForm.memoSeq.value = seq;
	document.getElementById("pjt_memo_contents").value = contents;
}

function jf_memoAdd(){
	document.vForm.pjt_memo_contents.focus();
	document.vForm.memoActType.value = 'ins';
	document.getElementById("pjt_memo_contents").value = "";
}



function jf_del(value){
	var m;
	if(value == 'Y'){
		m = "복구 하겠습니까?";
	}else{
		m = "삭제 하겠습니까?";
	}
	
	if(confirm(m)){
	 	document.vForm.actType.value = 'useYn';
	 	document.vForm.action = "/sgportal/techsup/pjtComAction.sg?use_yn=" + value;
	 	document.vForm.submit();
	}
}

function jf_per_del(){
	if(confirm('영구삭제 하겠습니까?')){
	 	document.vForm.actType.value = 'del';
	 	document.vForm.action = "/sgportal/techsup/pjtComAction.sg";
	 	document.vForm.submit();
	}
}

$(function() {
	if('${pMap.actType}' != 'ins'){
		document.IF_PJT_MEMO.location = '/sgportal/techsup/techsupMemo.sg?actType=view&pjt_no=' + '${list.PJT_NO}';
	}
});


function calcHeightMemo(){  
	var the_height_memo= document.getElementById('IF_PJT_MEMO').contentWindow.document.body.scrollHeight+100;
	document.getElementById('IF_PJT_MEMO').height= the_height_memo;
}

//-->
</SCRIPT>
<c:set var="groups" value="${fn:split(sessionMap.GROUPS, ',')}" />


<c:if test="${pMap.command == 'ins'}">
	<script>
		alert('저장 하였습니다.');
		opener.jf_pjt_list();
		window.close();
		</script>	
</c:if>

<c:if test="${pMap.command == 'mod'}">
	<script>
		alert('수정 하였습니다.');
		opener.jf_techsupPjtList();
		window.close();
		</script>	
</c:if>

<div id="title_line">
	<div id="title">프로젝트 등록</div>
	<div id="location">프로젝트 등록 </div>
</div>
<c:if test="${!empty techsup.CORP_NM}">
<h3 class="subtitle"> 고객사 정보</h3>
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="grid" rules="cols">
	<tr valign="middle">
		<td width="20%" scope="col" id="odd">
			고객사명
		</td>
		<td width="80%">
			${techsup.CORP_NM}
		</td>
	</tr>
	<tr valign="middle">
		<td width="20%" scope="col" id="odd">
			중요도
		</td>
		<td>
			${techsup.IMPTC_GRADE_CODE}
		</td>
	</tr>
</table>
<br />
</c:if>
<form name='vForm' method='post'>
<input type='hidden' name='pjt_no' id="pjt_no" value='${list.PJT_NO}'>
<input type="hidden" name="actType" id="actType" />
<input type="hidden" name="pjt_status" id="pjt_status" value="1"/>
<input type="hidden" name="corp_no" id="corp_no" value="${techsup.CORP_NO}"/>
<input type="hidden" name="chman_no1" id="chman_no1" 
	<c:if test="${pMap.actType == 'mod'}">value="${list.CHMAN_NO1}"</c:if> 
	<c:if test="${pMap.actType == 'ins'}">value="${pMap.chman_no}"</c:if>
	/>
<input type="hidden" name="chman_no2" id="chman_no2" value="${list.CHMAN_NO2}"/>

<input type="hidden" name="chman_sect_code" id="chman_sect_code"/>
<input type="hidden" name="memoActType" id="memoActType" value=""/>
<input type="hidden" name="memoSeq" id="memoSeq" value=""/>

<input type="hidden" name="viewName" id="viewName" value="${pMap.viewName}"/> 

<h3 class="subtitle"> 프로젝트 정보</h3>
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="grid" rules="cols">
	<tr valign="middle" >
		<td width="20%" scope="col" id="odd">
			프로젝트명
		</td>
		<td width="80%">
			<c:choose>
				<c:when test="${pMap.actType == 'ins' || pMap.actType == 'mod'}">
					<input title="프로젝트명" type='text' class="required inputTex" name='pjt_name' size=60 maxlength='100' value="${list.PJT_NAME}">
				</c:when>
				<c:otherwise>
				 	${list.PJT_NAME}
				</c:otherwise>
			</c:choose> 
		</td>
	</tr>
	
	<tr valign="left">
		<td width="20%" scope="col" id="odd">
			프로젝트 담당자
		</td>
		<td width="80%">
			<c:choose>
				<c:when test="${pMap.actType == 'ins' || pMap.actType == 'mod'}">
					<input style="width:300" title="프로젝트 담당자" type='text' class="required inputTex" name='chman_nm2' id="chman_nm2" maxlength='100' 
						value="${list.CHMAN_NM2}"
						>
					<input type="button" class="buttonsmall05" value="담당자 검색" onclick="javascript:jf_chman_popup('2')" style="cursor:hand;">
				</c:when>
				<c:otherwise>
					${list.CHMAN_NM2}
				</c:otherwise>
			</c:choose>
		</td>
	</tr>
	
	
	<tr valign="middle">
		<td width="20%" scope="col" id="odd">
			기간
		</td>
		<td width="80%">
			<c:choose>
				<c:when test="${pMap.actType == 'ins' || pMap.actType == 'mod'}">
					시작 : 
					<input name="pjt_st_date" id="pjt_st_date" type="text" class="inputText date" value="${list.PJT_ST_DATE}"
					onclick="calPopup(this, 'mypopup', 0, 20, 'document.vForm.pjt_st_date', ''); return false;"  />
					<input type="image" src="/resource/images/admin/img/ic_calendar.gif" readonly="readonly"
					onclick="calPopup(this, 'mypopup', 0, 20, 'document.vForm.pjt_st_date', ''); return false;"  
					align="middle" width="16" height="16" />  
					<br />
					종료 : 
					<input name="pjt_end_date" id="pjt_end_date" type="text" class="inputText date" value="${list.PJT_END_DATE}"
					onclick="javascript:calPopup(this, 'mypopup', 0, 20, 'document.vForm.pjt_end_date', ''); return false;"  />
					<input type="image" src="/resource/images/admin/img/ic_calendar.gif" readonly="readonly"
					onclick="javascript:calPopup(this, 'mypopup', 0, 20, 'document.vForm.pjt_end_date', ''); return false;"  
					align="middle" width="16" height="16" />  
				</c:when>
				<c:otherwise>
					${list.PJT_ST_DATE} ~ ${list.PJT_END_DATE}
				</c:otherwise>
			</c:choose>
		</td>
	</tr>	
	<tr>
		<td width="20%" scope="col" id="odd">
			사업구분
		</td>
		<td>
			<c:choose>
				<c:when test="${pMap.actType == 'ins' || pMap.actType == 'mod'}">
					<select class="validate-required-select" name="work_type_code" id="work_type_code" title="담당업무 " >
						<option value="">
							선택
						</option>
						<c:forEach items="${code_work}" var="code" varStatus="i">
						<option <c:if test="${code.CODE == list.WORK_TYPE_CODE}"> selected</c:if> value="${code.CODE}">
							${code.CODE_NM}
						</option>
						</c:forEach>
				</select>
				</c:when>
				<c:otherwise>
				 	${list.WORK_TYPE_CODE_NM}
				</c:otherwise>
			</c:choose> 
		</td>
	</tr>
	<tr valign="left">
		<td width="20%" scope="col" id="odd">
			SG 담당자
		</td>
		<td width="80%">
			<c:choose>
				<c:when test="${pMap.actType == 'ins' || pMap.actType == 'mod'}">
					<input style="width:300" title="SG 담당자" type='text' class="required inputTex" name='chman_nm1' id="chman_nm1" maxlength='100' 
						<c:if test="${pMap.actType == 'ins'}">value="${pMap.cor_nm}/${pMap.admin_nm}"</c:if> 
						<c:if test="${pMap.actType == 'mod'}">value="${list.CHMAN_NM1}"</c:if> 
						>
					<input type="button" class="buttonsmall05" value="담당자 검색" onclick="jf_chman_popup('1')" style="cursor:hand;">
				</c:when>
				<c:otherwise>
					${list.CHMAN_NM1}
				</c:otherwise>
			</c:choose>
			
		</td>
	</tr>
	<tr valign="middle" align="left">
		<td width="20%" scope="col" id="odd">
			비고
		</td>
		<td width="80%">
			<c:choose>
				<c:when test="${pMap.actType == 'mod'}">
					<textarea id='pjt_contents' name='pjt_contents' style='border:1 solid; border-color:#D4D4D4; width:100%; height:110;'>${list.PJT_CONTENTS}</textarea>
					
				</c:when>
				<c:when test="${pMap.actType == 'ins'}">
					<textarea id='pjt_contents' name='pjt_contents' style='border:1 solid; border-color:#D4D4D4; width:100%; height:110;'></textarea>
				</c:when>
				<c:when test="${pMap.actType == 'view'}">
					${list.PJT_CONTENTS}
				</c:when>				
				<c:otherwise>
					
				</c:otherwise>
			</c:choose>
		</td>
	</tr>	
</table>


<div class="btn">						
	<div class="leftbtn">
		
	</div>
	<div class="rightbtn">
	
		<!-- 권한 에 따른 쓰기기능 제어 시작  -->		
		<c:if test="${writeGrant != '0' }">
			<c:if test="${pMap.actType == 'view'}">
			<!-- 권한 에 따른 쓰기기능 제어 시작  -->		
				<c:forEach items="${groups}" var="group" varStatus="i">
					<c:if test="${group == 'G001'}">
						<input type="button" class="button03" value="수정" onclick="javascript:jf_pjtMoView()" style="cursor:hand;">
						<c:if test="${list.USE_YN == 'Y'}">
							<input type="button" class="button02" value="삭제" onclick="jf_del('N')" style="cursor:hand;">
						</c:if>
						<c:if test="${list.USE_YN == 'N'}">
							<input type="button" class="button02" value="복구" onclick="jf_del('Y')" style="cursor:hand;">
						</c:if>
						<!-- 
						<input type="button" class="button04" value="영구삭제" onclick="jf_per_del()" style="cursor:hand;">
					 -->
					</c:if>
					<c:if test="${group == 'G002'}">
						<c:if test="${list.CHMAN_NO ==  list.LCHMAN_NO}">
							<input type="button" class="button03" value="수정" onclick="javascript:jf_pjtMoView()" style="cursor:hand;">
							<input type="button" class="button02" value="삭제" onclick="jf_del()" style="cursor:hand;">
						</c:if>
					</c:if>
				</c:forEach>
			</c:if>
			<c:if test="${pMap.actType == 'mod'}">
			<input type="button" class="button02" value="수정" onclick="jf_pjtModForm()" style="cursor:hand;">
			<input type="button" class="button03" value="초기화" onclick="jf_cancel()" style="cursor:hand;">
			</c:if>
			<c:if test="${pMap.actType == 'ins'}">
			<input type="button" class="button02" value="등록" onclick="jf_pjtInsForm()" style="cursor:hand;">
			<input type="button" class="button03" value="초기화" onclick="jf_cancel()" style="cursor:hand;">
			</c:if>
		</c:if>
	</div>
</div>	

<br />

    <div style="width:100%">
	    <div id="D_PJT_MEMO" > 
	    	<iframe onLoad="calcHeightMemo()" scrolling="no" width="610" height="1" scrolling='auto' frameborder="0" id="IF_PJT_MEMO" name="IF_PJT_MEMO" style="margin-bottom: 8px;"></iframe>
	    </div>
	    <br class="clear" /> 
    </div> 


</form>

<c:if test="${pMap.command == 'del'}">
	<script>
		alert('삭제 하였습니다.');
		opener.document.vForm.corp_no.value = '${pMap.corp_no}';
		opener.document.vForm.actType.value="list";
		opener.document.vForm.action = "/sgportal/techsup/pjtList.sg";
		opener.document.vForm.submit();
		
		window.close();
		</script>	
</c:if>

<c:if test="${pMap.command == 'delY'}">
	<script>
		alert('복구 하였습니다.');
		opener.document.vForm.corp_no.value = '${pMap.corp_no}';
		opener.document.vForm.actType.value="list";
		opener.document.vForm.action = "/sgportal/techsup/pjtList.sg";
		opener.document.vForm.submit();
		
		window.close();
		</script>	
</c:if>

<div id="mypopup" style="position: absolute; visibility: hidden; z-index: 0; background-color: #99BDDF;"></div>