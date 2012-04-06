<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%> 
<%@ include file="/WEB-INF/web/jsp/common/inc/commonInc.jsp" %>
<script type="text/javascript" src="/resource/common/js/jquery.sg.js"></script>
<link href="/resource/common/css/common.css" rel="stylesheet" type="text/css">

<style>
.ui-button { margin-left: 0.5px;margin-top: 1px; }
.ui-button-icon-only .ui-button-text { padding: 0em; } 
.ui-autocomplete-input { margin: 0;  margin-top: 0px; }

.ui-autocomplete {
	max-height: 100px;
	overflow-y: auto;
}
/* IE 6 doesn't support max-height
 * we use height instead, but this forces the menu to always be this tall
 */
* html .ui-autocomplete {
	height: 70px;
	width: 100px;
}
</style>

<script type="text/javascript" src="/resource/common/js/mini.js" ></script>
<script type="text/javascript" src="/resource/common/js/validator.js" ></script> 

<SCRIPT LANGUAGE="JavaScript">
<!--


function jf_chmanaddRow(){ 
	if(document.vForm.addDev_chman_no.value == ''){
		alert('개발담당자를 선택해주세요.');
		return false;
	}
	
	if(${pMap.actType != 'ins'}){
		for(var i=0;i<document.vForm.u_dev_chman_no.length;i++){
			if(document.vForm.u_dev_chman_no[i].value == document.vForm.addDev_chman_no.value){
				alert("이미 등록된 개발담당자 입니다.");
				return false;
			}
		}
	}

		for(var i=0;i<document.vForm.dev_chman_no.length;i++){
			if(document.vForm.dev_chman_no[i].value == document.vForm.addDev_chman_no.value){
				alert(document.vForm.addDev_chman_nm.value + "님은 이미 등록된 개발담당자 입니다.");	
				return false;
			}
		}


		
			
		
		var fm = document.vForm;
		var no = document.vForm.addDev_chman_no.value;
		var nm = document.vForm.addDevChman_nm.value;
		var gradeCode = document.vForm.addGradeCode.value;
		var deptCode = document.vForm.addDeptCode.value;


		var $table = $("#devChmanTable");
		var rows =$table.find('tr').get().length;
		var template = "<tr id='devChmanTr"+rows+"' class='addtrChman'>" +
		"<th scope='col' id='odd' class='addtrChman'colspan='2'>"+nm+ ""  +
		"<input type='hidden' name='dev_chman_no' value='"+no+"' />" +
		"<input type='hidden' name='dev_chman_nm' class='Input_w' style='width:75%' value='"+nm+"' /></th>" +
		"<td align='center' width='25%'><a href='javascript:jf_chmanDeleteRow(\"devChmanTr"+rows+"\");'>삭제</a></td></tr>";

		$("#devChmanTable").append(template);

		document.vForm.addDevChman_nm.value = "";
		document.vForm.addDev_chman_nm.value = "";
		document.vForm.addDev_chman_no.value = "";
		
		
		 parent.getReSize('IF_APP4');
}

function jf_chmanDeleteRow(id){
	$("#"+id).remove();
	parent.getReSize('IF_APP4');
}

$(function() {
	
	$.ajax({
		url: "/sgportal/chman/xmlChmanList.sg",
		type: "POST",
		data: "comT=1&group_id=G003",
		success: function( xmlResponse ) {
			var data = $( "Service", xmlResponse ).map(function() {
				return {
					value: $( "CHMAN_NM", this ).text(),
					chmanNm: $( "CHMAN_NM", this ).text(),
					chmanNo: $( "CHMAN_NO", this ).text(),
					gradeCode: $( "GRADE_CODE", this).text(),
					deptCode: $( "DEPT_CODE", this).text()
				};
			}).get();
			$( "#addDev_chman_nm" ).autocomplete({
				source: data,
				minLength: 0,
				select: function( event, ui ) {
					var kc = event.keyCode;
					//if(kc != 37 && kc != 38 && kc != 39 && kc != 40){
						document.vForm.addDev_chman_no.value = ui.item.chmanNo;
						document.vForm.addGradeCode.value = ui.item.gradeCode;
						document.vForm.addDeptCode.value = ui.item.deptCode;
						document.vForm.addDevChman_nm.value = ui.item.chmanNm;
					//}
				}
			});
		} 
	});
});


function jf_srcChman(corp_no, comT){  
	var param = "comT=" + comT + "&corp_no=" + corp_no + "&viewName=/sgportal/techsup/chmanPopup&srcType=prod&group_id=G003";
	var url = "/sgportal/chman/chmanList.sg?" + param;
	window.open(url, "", "width=800, height=500, left=250, top=50, scrollbars=yes, resizable=no, menubar=no");
	
}


function jf_schedule(tech_sup_app_no, sche_no, view){
	var param = "tech_sup_app_no=" + tech_sup_app_no + "&sche_no=1&view="+view;
	var url = "/sgportal/schedule/scheduleWrite.sg?" + param;
	window.open(url, "", "width=800, height=500, left=250, top=50, scrollbars=yes, resizable=no, menubar=no");
	
}

function jf_techsupAppAction(){
	if(document.vForm.dev_chman_no.length == null && document.vForm.u_dev_chman_no.length == null){
		alert('담당자를 추가해주세요.');
		return false;
	}
	if(confirm('배정 하시겠습니까?')) {
		var param = "";
		if('${fn:length(tech_sup_chman)}' > 0){
			param = "matchY=Y";
		}else{
			param = "matchY=N";
		}
		document.vForm.actType.value = 'status2';
		document.vForm.tech_sup_status_code.value = "2";
		document.vForm.action = "/sgportal/techsup/techsupAppAction.sg?" + param;
		document.vForm.submit();
	}
}


function f_status1(){
    if(confirm('요청 하시겠습니까?')) {
        document.vForm.actType.value = "ins";
        document.vForm.tech_sup_status_code.value = "1";
		document.vForm.action = "/sgportal/techsup/techsupAppStatusAction.sg";
		document.vForm.submit();
    }
}

function f_status3(){
    if(confirm('접수 하시겠습니까?')) {
        document.vForm.actType.value = "ins";
        document.vForm.tech_sup_status_code.value = "3";
		document.vForm.action = "/sgportal/techsup/techsupAppStatusAction.sg";
		document.vForm.submit();
    }
}

function status4Reject(){
	$( "#dialog-rejectContents" ).dialog({
		height: 170,
		width: 290,
		modal: true
	});
	var html = '<div id="d_reject_contents"><textarea name="dr_reject_contents" id="dr_reject_contents" title="반려내용" style="width:265;height:70"></textarea> '
	 		 + '<br /><div align="center"><input type="button" class="buttonsmall02" value="반려" onclick="f_status4()" /></div>';
	document.getElementById("dialog-rejectContents").innerHTML = html;
}

function f_status4(){
	if(dr_reject_contents.value == ''){
		alert('반려 사유를 입력하세요.');
		return false;
	}
	
    if(confirm('반려 하시겠습니까?')) {
    	document.vForm.reject_contents.value = dr_reject_contents.value;
        document.vForm.actType.value = "ins";
        document.vForm.tech_sup_status_code.value = "4";
        document.vForm.reject_yn.value = "Y";
		document.vForm.action = "/sgportal/techsup/techsupAppStatusAction.sg";
		document.vForm.submit();
    }

    $("#d_reject_contents" ).remove();
}

function f_status7(){
    if(confirm('검토요청 하시겠습니까?')) {
        document.vForm.actType.value = "ins";
        document.vForm.tech_sup_status_code.value = "7";
		document.vForm.action = "/sgportal/techsup/techsupAppStatusAction.sg";
		document.vForm.submit();
    }
}

function f_status8(value){
	if(confirm('승인 하시겠습니까?')) {


		 document.vForm.actType.value = "ins";
	      document.vForm.tech_sup_status_code.value = "8"; 
	        
		$( "#dialog-rejectContents" ).dialog({
			height: 170,
			modal: true
		});
		var html = '<div id="d_reject_contents"><textarea name="dr_reject_contents" id="dr_reject_contents" title="내용" style="width:100%;height:80"></textarea> '
		 		 + '<br /><div align="right"><input type="button" class="buttonsmall02" value="저장" onclick="f_status9(\'8\')" /></div>';
		document.getElementById("dialog-rejectContents").innerHTML = html;

        
    }
}

function status9Reject(){
	$( "#dialog-rejectContents" ).dialog({
		height: 170,
		modal: true
	});
	var html = '<div id="d_reject_contents"><textarea name="dr_reject_contents" id="dr_reject_contents" title="반려내용" style="width:100%;height:80"></textarea> '
	 		 + '<br /><div align="right"><input type="button" class="buttonsmall02" value="저장" onclick="f_status9(\'9\')" /></div>';
	document.getElementById("dialog-rejectContents").innerHTML = html;
}

function f_status9(status){
	if(dr_reject_contents.value == ''){
		alert('비고를 입력하세요.');
		return false;
	}
	
    if(confirm('처리 하시겠습니까?')) {
    	document.vForm.reject_contents.value = dr_reject_contents.value;
        document.vForm.actType.value = "ins";
        document.vForm.tech_sup_status_code.value = status;
		document.vForm.action = "/sgportal/techsup/techsupAppStatusAction.sg";
		document.vForm.submit();
    }

    $("#d_reject_contents" ).remove();
}



function f_status10(){
    if(confirm('요청보류 하시겠습니까?')) {
        document.vForm.actType.value = "ins";
        document.vForm.tech_sup_status_code.value = "10";
		document.vForm.action = "/sgportal/techsup/techsupAppStatusAction.sg";
		document.vForm.submit();
    }
}




function jf_chmanDeleteRow2(id, seq){
	
	var html = '<input type="hidden" name="del_seq" value="'+seq+'" />';
	$("#" + id).attr("style", "display:none");
	
	$("#devChmanTable").append(html);
	
	parent.getReSize('IF_APP4');
}




//-->
</SCRIPT>
<c:set var="groups" value="${fn:split(sessionMap.GROUPS, ',')}" />

<div id="dialog-rejectContents" title="내용">
</div>

<form name='vForm' method='post'>
<input type="hidden" name="actType" id="actType" />
<input type="hidden" name="corp_no" id="corp_no" />
<input type="hidden" name="u_dev_chman_no" id="u_dev_chman_no" />
<input type="hidden" name="dev_chman_no" id=dev_chman_no />
<input type="hidden" name="tech_sup_status_code" id='tech_sup_status_code' />
<input type="hidden" name="tech_sup_app_no" id='tech_sup_app_no' value="${techsupApp.TECH_SUP_APP_NO}" />
<input type="hidden" name="reject_yn" id="reject_yn" value="N" />
<input type="hidden" name="del_seq" id="del_seq" />
<input type='hidden' name='reject_contents' id='reject_contents' value="">
<input type='hidden' name='statsSeq9' id='statsSeq9'  value="${status9.SEQ}">
<input type='hidden' name='statsSeq3' id='statsSeq3'  value="${status3.SEQ}">
<input type='hidden' name='statsSeq4' id='statsSeq4'  value="${status4.SEQ}">




	
		
														
	<table width="100%" border="0" cellpadding="0" cellspacing="0" id="tb_view">
		<tr valign="top">
			
			<!-- 요청 start -->
			<td style="width:15%">
			<table width="100%" border="0" cellpadding="0" cellspacing="0" class="grid"
				<c:if test="${status1.REJECT_YN == 'N'}">
					style="background-color:dcdcdc;" 
				</c:if>
				>
				<tr height="10%" >
					<th scope="col" id="odd">
						요청 
					   	<c:forEach items="${totHis}" var="his" varStatus="g">
					   		<c:if test="${g.index == '1'}">
					   			<c:set var="last_his" value="${his.TECH_SUP_STATUS_CODE}" />
					   		</c:if>
					   		 
					   		<c:if test="${g.index == '0'}"> 
					   			<c:if test="${his.TECH_SUP_STATUS_CODE == '10'}"> 
					   				<input type="button" class="buttonsmall03" value="재요청" onclick="f_status1()" /> 
					   			</c:if>
					   			<c:if test="${his.TECH_SUP_STATUS_CODE != '10'}">
					   				<input type="button" class="buttonsmall04" value="요청보류" onclick="f_status10()" />
					   			</c:if>					   		
					   		</c:if>
					   	</c:forEach>
					</th>
				</tr>
				<tr>
					<td style="height:110px;padding-left:3px" align="center">
						<c:if test="${status1.REJECT_YN == 'N'}">
						<table  width="100%" border="0" cellpadding="0" cellspacing="0" class="grid02">
													 
							<tr>
								<th id="odd"  style="width:35%">요청일</th>
								<td>${status1.CR_DATE}</td>
							</tr>
							<tr>
								<th id="odd"  style="width:35%">요청<br/>작성</th>
								<td>${techsupApp.SG_CHMAN_NM}<br/>${techsupApp.DEPT_CODE_NM}</td>
							</tr>
							 
							
						</table> 
						</c:if>
					</td>
				</tr>
			</table>
			</td> 
			
			
			<!-- 배정 start -->
			<td style="width:4%;padding-top:70px" align="center"><img src="/resource/images/admin/img/db_arrow_right_i.gif" /></td>
			<td width="15%">
			<table width="100%" border="0" cellpadding="0" cellspacing="0"  class="grid"
				<c:forEach items="${groups}" var="group" varStatus="i">
					<c:if test="${status2.REJECT_YN == 'N' && group == 'G004'}">
						style="background-color:dcdcdc;" 
					</c:if>
					<c:if test="${status3.REJECT_YN == 'N' && group != 'G004'}">
						style="background-color:dcdcdc;" 
					</c:if>
				</c:forEach>
			>
				<tr>
					<th scope="col" id="odd">
						배정
						<c:forEach items="${groups}" var="group" varStatus="i">
							<c:if test="${group == 'G004'}">
								<c:if test="${(status1.REJECT_YN == 'N' && status2.REJECT_YN != 'N') ||
								   (status4.REJECT_YN == 'Y')}">
									<input type="button" class="buttonsmall02" value="배정" onclick="jf_techsupAppAction()" />
								</c:if>
							</c:if>
							<c:if test="${group == 'G003'}">
								<c:if test="${status1.REJECT_YN == 'N' && status2.REJECT_YN == 'N'
									 && status3.REJECT_YN != 'N' && status4.REJECT_YN != 'Y'}">
									<c:forEach items="${tech_sup_chman}" var="sw" varStatus="i">
										<c:if test="${sw.CHMAN_NM == sessionMap.ADMIN_NM}">
											<input type="button" class="buttonsmall02" value="접수" onclick="f_status3()" />
											<input type="button" class="buttonsmall02" value="반려" onclick="status4Reject()" />
										</c:if>
									</c:forEach>
								</c:if>
							</c:if>
						</c:forEach>
					</th>
				</tr> 
			 
				<tr>
					<td style="height:110px;padding-left:3px" align="center">
						<table width="100%" id="devChmanTable" border="0" cellpadding="0" cellspacing="0" class="grid02"
							<c:if test="${status2.REJECT_YN == 'N'}">
								style="background-color:dcdcdc;" 
							</c:if>
						>
						
						<c:forEach items="${groups}" var="group" varStatus="i">
							<c:if test="${group == 'G004'}">
								<c:if test="${(status1.REJECT_YN == 'N' && status2.REJECT_YN != 'N') ||
									(status4.REJECT_YN == 'Y' && status3.REJECT_YN != 'N')}">
						      		<tr>
						      			<td colspan="2" id="odd">
						      					<input type="hidden" name="addDevChman_nm" class="Input_w" readonly="readonly" value="" />
										      	<input type="hidden" name="addDev_chman_no" class="Input_w" readonly="readonly" value="" />
										      	<input type="hidden" name="addGradeCode" class="Input_w" readonly="readonly" value="" />
										      	<input type="hidden" name="addDeptCode" class="Input_w" readonly="readonly" value="" />
										      	<input type="text"  name="addDev_chman_nm" id="addDev_chman_nm" class="Input_w required inputTex" value="" size='10' onkeypress="javascript:if(event.keyCode=='13'){jf_chmanaddRow(); return false;}"/>
										      	<input type="button" class="buttonsmall02" value="검색" onclick="jf_srcChman('COR1011022247591', 'SG')" /> 
								      	</td>
									    <td align="center" style='width:25%'>
									    	<p onclick="jf_chmanaddRow()">
								        		<strong style="cursor:pointer">추가</strong>
								        	</p>
								        </td>
									 </tr>
									 
									</c:if>
								</c:if>
							</c:forEach> 
						
						
						<c:if test="${status4.REJECT_YN == 'Y'}">
				      		<tr>
				      			<td colspan="3">
				      				<b style="color:red">
				      					${status4.REJECT_CONTENTS}
				      				</b>
				      			</td>
							   
							 </tr>
						</c:if>
							
						<c:forEach items="${tech_sup_chman}" var="sw" varStatus="i">
						<tr id="devChmanTr${i.index+1}">
							
								<td colspan="2"  bgcolor="FFFFFF" align="left" style="align:left;padding-left: 5px"> 
									<c:if test="${sw.MATCH_YN == 'Y'}">
										담당 : ${sw.CHMAN_NM}&nbsp;${sw.GRADE_CODE} 
									<input type='hidden' name='u_dev_chman_no' value="${sw.CHMAN_NO}">
									</c:if> 
									<c:if test="${sw.MATCH_YN == 'N'}">
										책임 : ${sw.CHMAN_NM}&nbsp;${sw.GRADE_CODE} 
									</c:if> 
								</td> 
							
							<c:forEach items="${groups}" var="group" varStatus="i">
								<c:if test="${group == 'G004'}">
									<c:if test="${sw.MATCH_YN == 'Y' ||
										(status4.REJECT_YN == 'N' && status3.REJECT_YN != 'N')
										}">
										<!-- 
										<td style="padding-left: 10px">
											${sw.GRADE_CODE} / 
											${sw.DEPT_CODE} 
											<input type='hidden' name='u_dev_chman_no' value="${sw.CHMAN_NO}">
										</td>
										 -->
										<c:if test="${(sw.MATCH_YN == 'Y' && status2.REJECT_YN != 'N') ||
											status4.REJECT_YN == 'Y'}">
										<td align="center">
											<p onclick="jf_chmanDeleteRow2('devChmanTr${i.index+1}', '${sw.CHMAN_NO}')">
											 <span style="cursor:pointer"><b>삭제</b></span>
											</p>
										</td>
										</c:if>
									</c:if>
								</c:if>
							</c:forEach>
						</tr>
						</c:forEach> 
						 
						 </table> 
					</td>
				</tr>
			</table>
			</td>
			
			
			<!-- 일정관리 start -->
			<td style="width:4%;padding-top:70px" align="center"><img src="/resource/images/admin/img/db_arrow_right_i.gif" /></td>
			<td width="15%"> 
			<table width="100%" border="0" cellpadding="0" cellspacing="0"  class="grid"
				<c:if test="${status5.REJECT_YN == 'N'}">
					style="background-color:dcdcdc;" 
				</c:if>
			>
				<tr>
					<th scope="col" id="odd">
						일정
						<c:forEach items="${groups}" var="group" varStatus="i">
							<c:if test="${group == 'G003'}">
								<c:if test="${status5.REJECT_YN != 'N' && status3.REJECT_YN == 'N'}">
									<c:forEach items="${tech_sup_chman}" var="sw" varStatus="i">
										<c:if test="${sw.CHMAN_NM == sessionMap.ADMIN_NM && sw.MATCH_YN == 'Y'}">
											<input type="button" class="buttonsmall02" value="등록" onclick="jf_schedule('${techsupApp.TECH_SUP_APP_NO}', '1', '')" /> 
										</c:if>
									</c:forEach>
								</c:if>
								<c:if test="${status5.REJECT_YN == 'N' && status6.REJECT_YN != 'N'}">
									<c:forEach items="${tech_sup_chman}" var="sw" varStatus="i">
										<c:if test="${sw.CHMAN_NM == sessionMap.ADMIN_NM && sw.MATCH_YN == 'Y'}">
											<input type="button" class="buttonsmall02" value="수정" onclick="jf_schedule('${techsupApp.TECH_SUP_APP_NO}', '1', '')" />
										</c:if>
									</c:forEach>
								</c:if>
							</c:if>
						</c:forEach>
					</th>
				</tr>
				
				
				<tr>
					<td style="height:110px;padding-left:3px" align="center">
						
						<c:if test="${status5.REJECT_YN == 'N'}">
						<table  width="100%" border="0" cellpadding="0" cellspacing="0" class="grid02">
							<tr>
								<th id="odd" style="width:35%">등록일</th>
								<td>${fn:substring(status5.CR_DATE, 0, 10)}</td>
							</tr>
							<tr>
								<th id="odd" style="width:35%">등록자</th>
								<td>${schedule.CHMAN_NM}
									<%-- 
										(시작:${fn:substring(schedule.ST_DATE,4,6)}-${fn:substring(schedule.ST_DATE,6,8)})
									--%>
								</td>
							</tr> 
							<tr>
								<th id="odd">제목</th>
								<td>
									<span onclick="jf_schedule('${techsupApp.TECH_SUP_APP_NO}', '', 'view')" style="cursor:hand">
									${schedule.TITLE}
									</span>
								</td>
							</tr>
						</table> 
						</c:if>
						
					</td> 
				</tr>
				
				
			</table>
			</td>
			
			
			
			<!-- 수행 start -->
			<td style="width:4%;padding-top:70px" align="center"><img src="/resource/images/admin/img/db_arrow_right_i.gif" /></td>
			<td width="15%">
			<table width="100%" border="0" cellpadding="0" cellspacing="0"  class="grid"
				<c:if test="${status6.REJECT_YN == 'N' && status9.REJECT_YN != 'N'}">
					style="background-color:dcdcdc;" 
				</c:if>
			>
				<tr>
					<th scope="col" id="odd">
						수행 
						<!--input type="button" class="buttonsmall06" value="수행일지등록" onclick="" /-->
					</th>
				</tr>
				<tr>
					<td style="height:110px;padding-left:3px" align="center">
						
						<c:if test="${status6.REJECT_YN == 'N'}">
						<table  width="100%" border="0" cellpadding="0" cellspacing="0" class="grid02">
							<tr>
								<th id="odd" style="width:35%">최초</th>
								<td>${fn:substring(status6.CR_DATE, 0, 10)}</td>
							</tr>
							<tr>
								<th id="odd">수행<br/>횟수</th>
								<td>${techsupApp.TECH_SUP_APP_CNT} 회</td>
							</tr> 
						</table> 
						</c:if>
						
					</td> 
				</tr> 
			</table>
			</td>	
			
			
			
			<!-- 검토 start -->
			<td style="width:4%;padding-top:70px" align="center"><img src="/resource/images/admin/img/db_arrow_right_i.gif" /></td>
			<td width="15%">
			<table width="100%" border="0" cellpadding="0" cellspacing="0"  class="grid"
				<c:if test="${status8.REJECT_YN == 'N'}">
					style="background-color:dcdcdc;" 
				</c:if>
			>
				<tr>
					<th scope="col" id="odd">
						완료
						<c:forEach items="${groups}" var="group" varStatus="i">
							<c:if test="${group == 'G004'}">
								<c:if test="${status8.REJECT_YN != 'N' && status7.REJECT_YN == 'N'
									&& status9.REJECT_YN != 'N'}">
									<input type="button" class="buttonsmall02" value="승인" onclick="f_status8()" />
									<input type="button" class="buttonsmall02" value="반려" onclick="status9Reject()" />
								</c:if>
							</c:if>
							<c:if test="${group == 'G003'}">
								<c:if test="${status7.REJECT_YN != 'N' && status6.REJECT_YN == 'N'}">
									<c:forEach items="${tech_sup_chman}" var="sw" varStatus="i">
										<c:if test="${sw.CHMAN_NM == sessionMap.ADMIN_NM}">
											<input type="button" class="buttonsmall04" value="검토요청" onclick="f_status7()" />
										</c:if>
									</c:forEach>
								</c:if>
								<c:if test="${status9.REJECT_YN == 'N'}">
									<c:forEach items="${tech_sup_chman}" var="sw" varStatus="i">
										<c:if test="${sw.CHMAN_NM == sessionMap.ADMIN_NM}">
											<input type="button" class="buttonsmall04" value="검토요청" onclick="f_status7()" />
										</c:if>
									</c:forEach>
								</c:if>
							</c:if>
						</c:forEach>
						 
					</th>
				</tr> 
				<tr>
					<td style="height:110px;padding-left:3px" align="center">
						<c:if test="${status7.REJECT_YN == 'N' && status8.REJECT_YN != 'N' && status9.REJECT_YN != 'N'}">
							<b style="color:red">검토 대기중</b>
						</c:if>
						<c:if test="${status7.REJECT_YN == 'N' && status8.REJECT_YN != 'N' && status9.REJECT_YN == 'N'}">
							<b>반려 : </b>
							<b style="color:red">
								${status9.REJECT_CONTENTS}
							</b>
						</c:if>
						
						<c:if test="${status8.REJECT_YN == 'N'}">
						<table  width="100%" border="0" cellpadding="0" cellspacing="0" class="grid02">
							<tr>
								<th id="odd" style="width:35%">날짜</th>
								<td>${status8.CR_DATE}</td>
							</tr>
						 
							<tr>
								<th id="odd">내용</th>
								<td>${status8.REJECT_CONTENTS}</td>
							</tr>
						</table> 
						</c:if>
						
					</td> 
				</tr> 
			</table>
			</td>
		</tr>
	</table> 
	
</form>

<div id="mypopup" style="position: absolute; visibility: hidden; z-index: 0; background-color: #99BDDF;"></div>
