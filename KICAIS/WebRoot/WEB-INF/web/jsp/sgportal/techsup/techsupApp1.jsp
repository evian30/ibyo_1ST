<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%> 
<%@ include file="/WEB-INF/web/jsp/common/inc/commonInc.jsp" %>
<script type="text/javascript" src="/resource/common/js/jquery.sg.js"></script>
<link href="/resource/common/css/common.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="/resource/common/js/mini.js" ></script>
<script type="text/javascript" src="/resource/common/js/validator.js" ></script> 
<script src="/resource/common/js/MultiUpload.js"></script>

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
 



if('${pMap.actType}' == 'ins' || '${pMap.actType}' == 'mod'){

$(function() {
	
	$.ajax({
		url: "/sgportal/techsup/pjtListXML.sg",
		type: "POST",
		data: "",
		success: function( xmlResponse ) {
			var data = $( "Service", xmlResponse ).map(function() {
				return {
					value: $( "CORP_NM", this ).text() 
					+ "/" + $( "PJT_NAME", this ).text() 
					+ "/" + $( "CHMAN_NM2", this ).text() 
					,
					pjt_no: $( "PJT_NO", this ).text(),
					pjt_name: $( "PJT_NAME", this ).text()
				};
			}).get();
			$( "#pjt_nm" ).autocomplete({
				source: data,
				minLength: 0,
				select: function( event, ui ) {
					var kc = event.keyCode;
					document.vForm.pjt_no.value = ui.item.pjt_no;
					document.vForm.pjt_nm.value = ui.item.pjt_name;
		
				}
			});
		} 
	});
});

}

function f_action(actType){ 
	
	var len = document.vForm.tech_sup_tran_type_code_id.length;
	var tech_sup_tran_type_code = "";
	for(var i = 0; i < len; i++){
		if(document.vForm.tech_sup_tran_type_code_id[i].checked){
			tech_sup_tran_type_code = tech_sup_tran_type_code +","+document.vForm.tech_sup_tran_type_code_id[i].value;
		}
	}  
	if(tech_sup_tran_type_code.substring(0,1)==','){
		tech_sup_tran_type_code = tech_sup_tran_type_code.replace(',','');
	}  
	 
	 
	if(Validator.validate(document.vForm)){
			if(document.vForm.pjt_no.value == ''){
				alert('프로젝트를 선택해주세요.');
				return false;
			} 
			document.vForm.tech_sup_tran_type_code.value = tech_sup_tran_type_code; 
			document.vForm.st_about_date.value = document.vForm.st_about_date.value.split("-").join("");
			document.vForm.end_about_date.value = document.vForm.end_about_date.value.split("-").join("");
			document.vForm.tech_sup_status_code.value = "1";
			document.vForm.actType.value = actType;
			document.vForm.action = "/sgportal/techsup/techsupAppAction.sg?multipartYn=Y";
			document.vForm.submit();
	}
}

function insView(){
	document.vForm.action = "/sgportal/techsup/techsupApp.sg";
	document.vForm.target = "APP1";
	document.vForm.submit();
	
	//document.getElementById("APP1").style.display="block";
}


function jf_srcPjt(){
	var param = "comT=CU&viewName=/sgportal/techsup/pjtListPopup";
	var url = "/sgportal/techsup/pjtList.sg?" + param;
	window.open(url, "", "width=800, height=600, left=250, top=50, scrollbars=yes, resizable=no, menubar=no");

	
}

function jf_chmanaddRow(){ 

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


		if(document.vForm.addDev_chman_no.value == ''){
			alert('개발담당자를 선택해주세요.');
			return false;
		}else{
			var fm = document.vForm;
			var no = document.vForm.addDev_chman_no.value;
			var nm = document.vForm.addDevChman_nm.value;
			var gradeCode = document.vForm.addGradeCode.value;
			var deptCode = document.vForm.addDeptCode.value;


			var $table = $("#devChmanTable");
			var rows =$table.find('tr').get().length;
			 
			var template = "<tr id='devChmanTr"+rows+"' class='addtrChman'>" +
			"<th scope='col' id='odd' class='addtrChman'>"+nm+ "</th><td style='padding-left: 10px'>" + gradeCode + " / " + deptCode +
			"<input type='hidden' name='dev_chman_no' value='"+no+"' />" +
			"<input type='hidden' name='dev_chman_nm' class='Input_w' style='width:70%' value='"+nm+"' /></td>" +
			"<td align='center'><a href='javascript:jf_chmanDeleteRow(\"devChmanTr"+rows+"\");'>[삭제]</a></td></tr>";

			$("#devChmanTable").append(template);

			
		}
	}

function jf_srcChman(corp_no, comT){  
	var param = "comT=" + comT + "&corp_no=" + corp_no + "&viewName=/sgportal/techsup/chmanPopup&srcType=prod";
	var url = "/sgportal/chman/chmanList.sg?" + param;
	window.open(url, '', 'width=800, height=500, scrollbars=yes, toolbar=no');
}

function jf_modView(){ 
		parent.document.IF_APP1.location = '/sgportal/techsup/techsupApp1.sg?actType=mod&tech_sup_app_no=${pMap.tech_sup_app_no}'; 
}





function jf_talk(){
	if(document.vFormTalk.contents.value == ""){
		alert('저장할 코멘트 내용을  입력하세요');
		document.vFormTalk.contents.focus();
		return;
	}
	document.vFormTalk.actType.value="ins_talk";
	document.vFormTalk.action = "/sgportal/techsup/supTalkAction.sg";
	document.vFormTalk.submit();
}

function jf_AllCheck(){
	var len = document.vFormTalk.talkseq01.length;
	if(document.vFormTalk.allCheck.checked == true){
		for(var i = 0; i < len; i++){
			document.vFormTalk.talkseq01[i].checked = true;
		}
	}else{
		for(var i = 0; i < len; i++){
			document.vFormTalk.talkseq01[i].checked = false;
		}
	}
}

function jf_talkdelete(seq){ 
	 
		if(confirm("정말 삭제 하시겠습니까?")){
			document.vFormTalk.seq.value = seq;
			document.vFormTalk.actType.value = "del_talk";
			document.vFormTalk.action = "/sgportal/techsup/supTalkAction.sg";
			document.vFormTalk.submit();
		} 
}



//-->
</SCRIPT>
<c:set var="groups" value="${fn:split(sessionMap.GROUPS, ',')}" />


<form name='vForm2'> 
<input type="hidden" name="actType" id="actType" />
<input type="hidden" name="corp_no" id="corp_no" />
<input type="hidden" name="u_dev_chman_no" id="u_dev_chman_no" />
<input type="hidden" name="dev_chman_no" id=dev_chman_no />
<input type="hidden" name="tech_sup_status_code" id=tech_sup_status_code />
<input type="hidden" name="reject_yn" id="reject_yn" value="N" />
<input type="hidden" name="tech_sup_app_no" id="tech_sup_app_no" value="${pMap.tech_sup_app_no}" />

</form>



<form name='vForm' method='post' enctype="multipart/form-data"> 
<input type="hidden" name="actType" id="actType" />
<input type="hidden" name="corp_no" id="corp_no" />
<input type="hidden" name="u_dev_chman_no" id="u_dev_chman_no" />
<input type="hidden" name="dev_chman_no" id=dev_chman_no />
<input type="hidden" name="tech_sup_status_code" id=tech_sup_status_code />
<input type="hidden" name="reject_yn" id="reject_yn" value="N" />
<input type="hidden" name="tech_sup_app_no" id="tech_sup_app_no" value="${pMap.tech_sup_app_no}" />

<input type="hidden" name="tech_sup_tran_type_code" id="tech_sup_tran_type_code" />
	
	
		 
	<table width="100%" border="0" cellpadding="0" cellspacing="0"  class="grid"> 		
		<tr> 
			<th scope="col" id="odd">
				* 프로젝트 
			</th>
			<td colspan="3">
			<c:choose>
				<c:when test="${pMap.actType == 'ins' || pMap.actType == 'mod'}">
					<input type="text" title="프로젝트명" class="Input_w required inputTex" style="width:300"
						name="pjt_nm" id="pjt_nm" value="${techsupApp.PJT_NM}" />
					<input type="button" class="buttonsmall06" value="프로젝트검색" onclick="jf_srcPjt()" /> <br/>
					<input type="hidden" name="pjt_no" value="${techsupApp.PJT_NO}" />
					<input type="hidden" name="prod_type" />
					
				</c:when>
				<c:otherwise>
				 	  ${techsupApp.PJT_NM}
				</c:otherwise>
			</c:choose>
			</td>
		</tr>
		
		<c:set var="t_s_t_t_c" value="${fn:split(techsupApp.TECH_SUP_TRAN_TYPE_CODE, ',')}" />
		<tr>
			<th scope="col" id="odd">* 지원방법</th>
			<td colspan="3">  
				<c:choose>
					<c:when test="${pMap.actType == 'ins' || pMap.actType == 'mod'}"> 
						<c:forEach items="${tech_sup_tran_type_code}" var="tran" varStatus="i">
							<input  class="validate-one-required" type="checkbox" name="tech_sup_tran_type_code_id" id="tran_result${tran.CODE}" value="${tran.CODE}"  
								title="지원방법" class="required inputText"
								<c:forEach items="${t_s_t_t_c}" var="t_s_t_t_c_value" varStatus="k">
									<c:if test="${t_s_t_t_c_value == tran.CODE}">checked="checked"</c:if>
								</c:forEach>
							/>
							<label for="tran_result${tran.CODE}">${tran.CODE_NM}</label> &nbsp;&nbsp;
						</c:forEach> 
					</c:when>
					<c:otherwise>
						<c:forEach items="${tech_sup_tran_type_code}" var="tran" varStatus="i"> 
								<c:forEach items="${t_s_t_t_c}" var="t_s_t_t_c_value" varStatus="k">
									<c:if test="${t_s_t_t_c_value == tran.CODE}">
										${tran.CODE_NM}&nbsp;&nbsp;
									</c:if> 
								</c:forEach> 
						</c:forEach>  
					</c:otherwise>
				</c:choose>
			</td>
		</tr>
		<tr>
		<th scope="col" id="odd">* 지원종류</th>
			<td colspan="3">  
				<c:choose>
					<c:when test="${pMap.actType == 'ins' || pMap.actType == 'mod'}"> 
						<select class="validate-required-select" name="tech_sup_type_code" id="tech_sup_type_code" title="지원종류 "  style="width:170px">
							<option value="">선택</option>
							<c:forEach items="${tech_sup_type_code}" var="tran_type" varStatus="i">
							<option <c:if test="${tran_type.CODE == techsupApp.TECH_SUP_TYPE_CODE}"> selected</c:if> value="${tran_type.CODE}">
								${tran_type.CODE_NM}
							</option>
							</c:forEach>
						</select>  
						
					</c:when>
					<c:otherwise>
					 	 ${techsupApp.SUP_TYPE}
					</c:otherwise>
				</c:choose> 
			</td>
		</tr>
		
		<c:if test="${pMap.actType == 'view'}">
		<tr>
			<th scope="col" id="odd">
				고객사 
			</th>
			<td colspan="3">
				 ${techsupApp.CL_CORP_NM}
			</td> 
		</tr> 
		</c:if>
		<tr>
			<th scope="col" id="odd">
				요청서 작성자 
			</th>
			<td colspan="3"> 
				 <c:choose>
					<c:when test="${empty techsupApp.CR_DATE}">${ADMIN_SESSION.ADMIN_NM}</c:when>
					<c:otherwise>
						${techsupApp.SG_CHMAN_NM} ( ${techsupApp.DEPT_CODE_NM} )
					</c:otherwise> 
				</c:choose>   
			</td>
			<!-- 
			<th scope="col" id="odd">
				고객 담당자 
			</th>
			<td>
				<c:if test="${pMap.actType == 'ins' || pMap.actType == 'mod'}">
					<input class="Input_w" title="요청자" size="20" type='text' name='app_nm' value="${techsupApp.APP_NM}" />
				</c:if>
				<c:if test="${pMap.actType == 'view'}">
					${techsupApp.APP_NM}
				</c:if>
			</td>
		   -->
		</tr>
		<tr>
			<th scope="col" id="odd">
				* 지원 접수일
			</th>
			<td colspan="3">
				<c:if test="${pMap.actType == 'ins' || pMap.actType == 'mod'}">
					<input title="지원접수일" onclick="calPopup(this, 'mypopup', 0, 20, 'document.vForm.app_rec_date', ''); return false;" type="text"
						name="app_rec_date" readonly="readonly"  class="Input_w required inputTex" 
						<c:choose>
							<c:when test="${pMap.actType == 'ins'}">value="<fmt:formatDate value="<%=new java.util.Date()%>" pattern="yyyy-MM-dd" />"</c:when>
							<c:otherwise> value="${techsupApp.APP_REC_DATE}"</c:otherwise>
						</c:choose>
						/>
		          	<input type="image" src="/resource/images/admin/img/ic_calendar.gif"   readonly="readonly" value="${techsupApp.APP_REC_DATE}"
         				onclick="calPopup(this, 'mypopup', 0, 20, 'document.vForm.app_rec_date', ''); return false;"  align="middle" width="16" height="16" />
         		</c:if>
				<c:if test="${pMap.actType == 'view'}">
					${techsupApp.APP_REC_DATE}
				</c:if>
			</td> 
			<!-- 
			<th scope="col" id="odd" style="width:15%;">
				고객 이메일
			</th>
			<td style="width:35%;">
				<c:if test="${pMap.actType == 'ins' || pMap.actType == 'mod'}">
					<input class="Input_w" title="요청자 이메일" size="20" type='text' name='app_email' value="${techsupApp.APP_EMAIL}"  />
				</c:if>
				<c:if test="${pMap.actType == 'view'}">
					${techsupApp.APP_EMAIL}
				</c:if>
			</td>
			-->
		</tr>
		
		<tr>
			<th scope="col" id="odd"  style="width:15%;">
				* 지원예정기간
			</th>
			<td colspan="3">
				<c:if test="${pMap.actType == 'ins' || pMap.actType == 'mod'}">
					<input size="12" title="지원예정기간" onclick="calPopup(this, 'mypopup', 0, 20, 'document.vForm.st_about_date', ''); return false;" type="text" value="${techsupApp.ST_ABOUT_DATE}" name="st_about_date" class="Input_w required inputTex" readonly="readonly">
		          	<input type="image" src="/resource/images/admin/img/ic_calendar.gif"   readonly="readonly" value="${techsupApp.ST_ABOUT_DATE}"
         				onclick="calPopup(this, 'mypopup', 0, 20, 'document.vForm.st_about_date', ''); return false;"  align="middle" width="16" height="16" />
         		&nbsp; - &nbsp;
         			<input size="12" title="지원예정기간" onclick="calPopup(this, 'mypopup', 0, 20, 'document.vForm.end_about_date', ''); return false;" type="text" value="${techsupApp.END_ABOUT_DATE}" name="end_about_date" class="Input_w required inputTex" readonly="readonly">
		          	<input type="image" src="/resource/images/admin/img/ic_calendar.gif"   readonly="readonly" value="${techsupApp.END_ABOUT_DATE}"
         				onclick="calPopup(this, 'mypopup', 0, 20, 'document.vForm.end_about_date', ''); return false;"  align="middle" width="16" height="16" />
         			
         		</c:if>
         		<c:if test="${pMap.actType == 'view'}">
					${techsupApp.ST_ABOUT_DATE} ~ ${techsupApp.END_ABOUT_DATE}
				</c:if>
			</td>
			<!--
			<th scope="col" id="odd" style="width:15%;">
				고객 전화 
			</th>
			<td style="width:35%;">
				<c:if test="${pMap.actType == 'ins' || pMap.actType == 'mod'}">
					<input class="Input_w" title="요청자 전화" size="20" type='text' name='app_hp' value="${techsupApp.APP_HP}"  />
				</c:if>
				<c:if test="${pMap.actType == 'view'}">
					${techsupApp.APP_HP}
				</c:if>
			</td>
			-->
		</tr>
		<tr>
			<th scope="col" id="odd">
				* 제목 
			</th>
			<td colspan="3">
				<c:if test="${pMap.actType == 'ins' || pMap.actType == 'mod'}">
					<input title="제목" type='text' name='app_title' value="${techsupApp.APP_TITLE}" class="Input_w required inputTex"  style="width:100%"/>
				</c:if>
				<c:if test="${pMap.actType == 'view'}">
					${techsupApp.APP_TITLE}
				</c:if>
			</td> 
		</tr>
		
	    <tr>
          <th id="odd" scope="col">첨부파일
	      <td colspan="3">
	      	  <c:choose>
	      	  	<c:when test="${pMap.actType == 'view'}">
					<c:if test="${fn:length(fileView) > 0 }">
		      	  		<table width="85%" id="devChmanTable" border="0" class="grid02">
		      	  			<tr>
		      	  				<th scope="col" id="odd" >파일명</th>
		      	  				<th scope="col" id="odd" width="12%" >파일사이즈</th>	 
		      	  				<th scope="col" id="odd" width="20%">등록일</th> 
		      	  				<th scope="col" id="odd" width="15%">등록자</th> 	  			
		      	  			</tr>
							<c:forEach items="${fileView}" var="file" varStatus="i">
			      	  			<tr>
			      	  				<td style="padding-left: 7px">
			      	  					<a href="/download.ddo?fid=addfile&add_file_no_key=${file.ADD_FILE_NO}&no_key=${file.NO}">${file.FILE_REAL_NM}</a> 
			      	  				</td>
			      	  				<td align="right">${file.FILE_SIZE} byts</td>
			      	  				<td align="center">${file.CR_DATE }</td>
			      	  				<td align="center">${file.CHMAN_NM }</td>
			      	  			</tr>
							</c:forEach>
						</table> 
					</c:if> 
					 
				</c:when>
				<c:when test="${pMap.actType == 'mod'}">
					<c:if test="${fn:length(fileView) > 0 }">
					<table width="85%" id="devChmanTable" border="0" class="grid02">
	      	  			<tr>
	      	  				<th scope="col" id="odd" >파일명</th>
	      	  				<th scope="col" id="odd" width="12%">파일사이즈</th>
	      	  				<th scope="col" id="odd" width="15%">삭제여부</th>	
	      	  				<th scope="col" id="odd" width="20%">등록일</th> 
	      	  				<th scope="col" id="odd" width="13%">등록자</th> 	  			
	      	  			</tr>
							<c:forEach items="${fileView}" var="file" varStatus="i"> 
								<tr>
									<td style="padding-left: 7px">
										<a href="/download.ddo?fid=addfile&add_file_no_key=${file.ADD_FILE_NO}&no_key=${file.NO}">${file.FILE_REAL_NM}</a> 
									</td>  
			      	  				<td align="right">${file.FILE_SIZE} byts</td>
			      	  				<td width="15%">
			      	  					<input type="checkbox" name="del_chk${i.index+1}" id="del_chk${ㅑ.index+1}" value="${file.ADD_FILE_NO}"> 
			      	  					<label for="del_chk${i.index+1}">[파일삭제]</label>
			      	  				</td>
			      	  				<td align="center">${file.CR_DATE}</td>
			      	  				<td align="center">${file.CHMAN_NM}</td> 
		      	  				</tr> 
							</c:forEach>
					</table>
					</c:if>
					<br />
	      	  		 <div id='uploadData' style="overflow:hidden;position:relative;top:-5px;left:0;filter:alpha(opacity=0);">
					  	&nbsp;&nbsp;
					  	<input type=file name='upload' id='upload_data0' onchange=fnMUpload(this) style="width:0;cursor:pointer">
					 </div>
					 <div id=uploadView></div>
	      	  	</c:when>
	      	  	<c:when test="${pMap.actType == 'ins'}">
	      	  		 <div id='uploadData' style="overflow:hidden;position:relative;top:-5px;left:0;filter:alpha(opacity=0);">
					  	<input type=file name='upload' id='upload_data0' onchange=fnMUpload(this) style="width:0;cursor:pointer">
					 </div>
					 <div id=uploadView></div>
	      	  	</c:when>
	      	  	<c:otherwise>
	      	  	
	      	  	</c:otherwise>
	      	  </c:choose>
	      </td>
								
        </tr>
		
		
		
		<tr>
			<th scope="col" id="odd">
				* 내용 
			</th>
			<td style="height:70;width:60%" colspan="2" w>
				<c:if test="${pMap.actType == 'ins' || pMap.actType == 'mod'}">
					<textarea title="내용" style="width:100%;height:120" name='contents'>${techsupApp.CONTENTS}</textarea> 
				</c:if>
				<c:if test="${pMap.actType == 'view'}">
					<textarea style="width:100%;height:120" name='contents' readonly="readonly">${techsupApp.CONTENTS}</textarea>
				</c:if>
			</td>
			<td style="padding-left: 15px">
				내용은 다음과 같이 입력 해 주세요<br/>
				1. 인증체계 고도화 모듈 설치<br/>
			    2. 기존인증서와 신규인증서간의 상호연동 테스트<br/>
			    3. 설치된 모듈의 적용서비스에서의 안정성 테스트
			</td>
		</tr>
		
		<tr>
			<th scope="col" id="odd">
				비고 
			</th>
			<td style="height:70" colspan="2">
				<c:if test="${pMap.actType == 'ins' || pMap.actType == 'mod'}">
					<c:choose>
						<c:when test="${empty techsupApp.APP_CONTENTS}">
							<textarea title="비고" style="width:100%;height:90" name='app_contents'></textarea>
						</c:when>
						<c:otherwise>
							<textarea style="width:100%;height:90" name='app_contents'>${techsupApp.APP_CONTENTS}</textarea>
						</c:otherwise>						
					</c:choose>
					
					
				</c:if>
				<c:if test="${pMap.actType == 'view'}">
					<textarea style="width:100%;height:120" name='app_contents' readonly="readonly">${techsupApp.APP_CONTENTS}</textarea>
				</c:if>
			</td>
			<td style="padding-left: 15px">
				비고는 다음과 같이 입력 해 주세요<br/> 
			    1. 설치확인서<br/>
			    2. 검수확인서<br/>
			    3. 테스트확인서
			</td>
		</tr>
		
		<c:if test="${pMap.actType == 'view'}">
		<tr>
			<th scope="col" id="odd" style="width:15%">
				등록일
			</th>
			<td style="width:35%;">
				<c:set var="today" value="<%=new java.util.Date().toLocaleString() %>" />
				<c:choose>
					<c:when test="${!empty techsupApp.CR_DATE}">${techsupApp.CR_DATE}</c:when>
					<c:otherwise>${today}</c:otherwise> 
				</c:choose>   
			</td>
			<th scope="col" id="odd" style="width:15%">
				수정일
			</th>
			<td style="width:35%;">
				<c:choose>
					<c:when test="${!empty techsupApp.UP_DATE}">${techsupApp.UP_DATE}</c:when>
					<c:when test="${!empty techsupApp.CR_DATE && !empty techsupApp.UP_DATE}">${today}</c:when> 
				</c:choose>   
			</td>
		</tr>
		</c:if> 
</form> 	 

		<form name='vFormTalk' method='post'>  
		<input type='hidden' name='tech_sup_app_no' value="${pMap.tech_sup_app_no}">
		<input type='hidden' name='actType'>
		<input type='hidden' name='seq'>  	 
	 
 		<tr>
			<th scope="col" id="odd">코멘트</td>
			<td colspan='3'>  
				
				<table class="grid02" width="99%" border="0">				
					<tr>
						<td colspan='4'>
							<c:if test="${pMap.actType == 'view'}">  
							<textarea name='contents' style="width:87%;height:55"></textarea>
							&nbsp;&nbsp;
							<input name="button4222" type="button" class="buttonsmall05" onClick="javascript:jf_talk();" align="absmiddle" value="코멘트저장"/>
							</c:if>
						</td>							
					</tr>
					 
					
					<!-- 댓글 리스트 시작 -->
					<c:forEach items="${talkList}" var="talk" varStatus="i">
					<tr> 
						<td width='13%' align="center"><b style="color:#0080C0"> ${talk.CHMAN_NM}</b></td>
						
						<td  style='padding-left:10px'><str:replace replace="\n" with="<br>" newlineToken="\n">${talk.CONTENTS}</str:replace> </td>	
						<td width='14%' align="center">${fn:substring(talk.CR_DATE, 0, 16)}</td>
						<td width='15%'>
							&nbsp;&nbsp;&nbsp;&nbsp;
							<c:if test="${talk.CHMAN_NO == sessionMap.SABUN ||  sessionMap.ADMIN_ID == 'admin'}">  
								<input name="button4222" type="button" class="buttonsmall02" onClick="javascript:jf_talkdelete('${talk.SEQ}');" align="absmiddle" value="삭제" /> 
							</c:if>
						</td>			
					</tr>
					</c:forEach>
					<!-- 댓글 리스트 끝 -->
				</table>
				
			</td>
		</tr>  
	 
		</form>
		
	</table>
	
	<div class="btn">						
		<div class="leftbtn">
		</div>
		<div class="rightbtn">
			<c:if test="${status2.REJECT_YN != 'N'}">
			<c:if test="${writeGrant != '0' }">
				<c:if test="${pMap.actType == 'view'}"> 
					<c:forEach items="${groups}" var="group" varStatus="i">
						<c:if test="${group == 'G004'}">
							<input type="button" class="button02" value="수정" onclick="jf_modView()" style="cursor:hand;" />
							<c:if test="${techsupApp.USE_YN == 'Y'}">
								<!--  
								<input type="button" class="button02" value="삭제" onclick="jf_use_yn('N')" style="cursor:hand;" />
							-->
							</c:if>
							<c:if test="${techsupApp.USE_YN == 'N'}">
								<input type="button" class="button02" value="복구" onclick="jf_use_yn('Y')" style="cursor:hand;">
							</c:if>
						</c:if>
					</c:forEach>
					
					<c:if test="${techsupApp.CHMAN_NO == sessionMap.SABUN}">
						<!-- 
						<input type="button" class="button02" value="삭제" onclick="jf_use_yn('N')" style="cursor:hand;" />
						 -->
						<input type="button" class="button02" value="수정" onclick="jf_modView()" style="cursor:hand;" /> 
					</c:if>  
					
				</c:if>
				
				<c:if test="${pMap.actType == 'ins'}">
                    <input type="button" class="button02" value="저장" onclick="f_action('ins')" style="cursor:hand;"> 
				</c:if>
				
				<c:if test="${pMap.actType == 'mod' && (techsupApp.CHMAN_NO == sessionMap.SABUN) }">
                    <input type="button" class="button02" value="수정" onclick="f_action('mod')" style="cursor:hand;"> 
				</c:if>
			</c:if> 
			</c:if>
		</div>
	</div>	 


<div id="mypopup" style="position: absolute; visibility: hidden; z-index: 0; background-color: #99BDDF;"></div>


