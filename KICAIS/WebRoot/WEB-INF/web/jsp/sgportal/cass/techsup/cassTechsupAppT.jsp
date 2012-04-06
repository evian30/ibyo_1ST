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


function jf_techsupList(){  
		document.vForm2.actType.value = 'view'; 
		document.vForm2.action = "/sgportal/cass/techsup/cassTechSupAppList.sg";
		document.vForm2.submit();
}

function jf_techsupModForm(){  
	if('${pMap.actType}' == "view"){
		document.vForm2.actType.value="mod";
		
		document.vForm2.c_tech_sup_app_no.value='${pMap.c_tech_sup_app_no}';
		
		document.vForm2.action = "/sgportal/cass/techsup/cassTechsupApp.sg";
		document.vForm2.submit();
	}else{ 
		document.vForm.actType.value="mod"; 
		if(Validator.validate(document.vForm)){
			document.vForm.action = "/sgportal/cass/techsup/cassTechsupAction.sg";
			document.vForm.submit();
		}
	}
}
	
function jf_techsupInsForm(){  
	document.vForm.actType.value="ins"; 
	if(Validator.validate(document.vForm)){
		document.vForm.action = "/sgportal/cass/techsup/cassTechsupAction.sg";
		document.vForm.submit();
	}
}

 


function jf_st(obj){  
	document.vForm.actType.value="ins_ST"; 
	document.vForm.action = "/sgportal/cass/techsup/cassTechsupAction.sg";
	document.vForm.submit();
}

 

function jf_del(obj){  
	document.vForm.actType.value="ins_ST"+obj; 
	document.vForm.action = "/sgportal/cass/techsup/cassTechsupAction.sg";
	document.vForm.submit();
}


function jf_srcChman(corp_no, comT){  
	var url = "/sgportal/chman/chmanList.sg?corp_no="+corp_no+"&comT="+comT+"&viewName=/sgportal/techsup/chmanPopup"+"&srcType=prod2";
	window.open(url, "chmanPopup", "width=620, height=648, left=250, top=100, scrollbars=yes, resizable=no, menubar=no");
	
}
	
 

function jf_srcPjt(){
	var param = "comT=CU&viewName=/sgportal/techsup/pjtListPopup&chkPop2=Y";
	var url = "/sgportal/techsup/pjtList.sg?" + param;
	window.open(url, "", "width=800, height=600, left=250, top=50, scrollbars=yes, resizable=no, menubar=no");
}



if('${pMap.actType}' == 'ins' || '${pMap.actType}' == 'mod'){
	$(function() {
		
		$.ajax({
			url: "/sgportal/techsup/pjtListXML.sg",
			type: "POST",
			data: "",
			success: function( xmlResponse ) {
				var data = $( "Service", xmlResponse ).map(function() {
					return {
						value: 
								$( "CORP_NM", this ).text() 
						+ "/" + $( "PJT_NAME", this ).text() 
						+ "/" + $( "CHMAN_NM2", this ).text() 
						,
						pjt_no: $( "PJT_NO", this ).text(),
						pjt_name: $( "PJT_NAME", this ).text(),
	
						corp_nm: $( "CORP_NM", this ).text(),
						chman_nm2: $( "CHMAN_NM2", this ).text()
					};
				}).get();
				$( "#pjt_nm" ).autocomplete({
					source: data,
					minLength: 0,
					select: function( event, ui ) {
						var kc = event.keyCode;
						document.vForm.pjt_no.value = ui.item.pjt_no;
						document.vForm.pjt_nm.value = ui.item.pjt_name;
	
						document.vForm.c_com_nm.value = ui.item.corp_nm;
						document.vForm.c_com_per_nm.value = ui.item.chman_nm2;
			
					}
				});
			} 
		});
	});
}



function jf_chmanaddRow(){ 

	if('${pMap.actType}' != 'ins'){
		for(var i=0;i<document.vForm.u_dev_chman_no.length;i++){
			if(document.vForm.u_dev_chman_no[i].value == document.vForm.addDev_chman_no.value){
				alert("이미 등록된 협조담당자 입니다.");
				return false;
			}
		}
	}

		for(var i=0;i<document.vForm.dev_chman_no.length;i++){
			if(document.vForm.dev_chman_no[i].value == document.vForm.addDev_chman_no.value){
				alert("이미 등록된 협조담당자 입니다.");	
				return false;
			}
		}


		if(document.vForm.addDev_chman_no.value == ''){
			alert('협조담당자를 선택해주세요.');
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
			"<th scope='col' id='odd' class='addtrChman'>"+nm+ "</th><td style='padding-left: 10px'> [" + gradeCode + " / " + deptCode +
			"] <input type='hidden' name='dev_chman_no' value='"+no+"' />" +
			"<input type='hidden' name='dev_chman_nm' class='Input_w' style='width:70%' value='"+nm+"' /></td>" +
			"<td align='center'><a href='javascript:jf_chmanDeleteRow(\"devChmanTr"+rows+"\");'>[삭제]</a></td></tr>";

			$("#devChmanTable").append(template);

			document.vForm.addDev_chman_nm.value="";
		}
	}

function jf_chmanDeleteRow(id){
	$("#"+id).remove();
	
}

function jf_chmanDeleteRow2(id, seq){
	var html = '<input type="hidden" name="del_seq" value="'+seq+'" />';
	$("#" + id).attr("style", "display:none");
	
	$("#MainTable").append(html);
	
}


function jf_AllCheck1(){
	var len = document.vForm.talkseq01.length;
	if(document.vForm.allCheck.checked == true){
		for(var i = 0; i < len; i++){
			document.vForm.talkseq01[i].checked = true;
		}
	}else{
		for(var i = 0; i < len; i++){
			document.vForm.talkseq01[i].checked = false;
		}
	}
}

function jf_talkdelete(){
	
	if(document.vForm.talkseq01 != undefined){
		var len = document.vForm.talkseq01.length;
		var talk_seq = "";
		for(var i = 0; i < len; i++){
			if(document.vForm.talkseq01[i].checked){
				talk_seq = talk_seq +","+document.vForm.talkseq01[i].value;
			}
		}
		
		if(talk_seq == ""){
			alert('삭제할 댓글  선택하세요.');
		}else{
			if(confirm("정말 삭제 하시겠습니까?")){
				document.vForm.talk_seq.value = talk_seq;
				document.vForm.action = "./boardTalkDelete.sg";
				document.vForm.submit();
			}
		}	
	}
}

function jf_srcProdChman(){
	var url = "/sgportal/cass/techsup/viewProdSG.sg";
	window.open(url, "", "width=800, height=600, left=250, top=50, scrollbars=yes, resizable=no, menubar=no");
}

function jf_techsupClose(){
	 
	
	if(confirm("완료 처리 하시겠습니까?")){
		document.vForm.actType.value="close_ST";
		document.vForm.action = "/sgportal/cass/techsup/cassTechsupAction.sg";
		document.vForm.submit();
	}
}

function jf_talkdelete(type, c_st_seq){ 
	if(confirm("정말 삭제 하시겠습니까?")){
		document.vForm.c_st_seq.value = c_st_seq;
		document.vForm.actType.value = "del_st"+type;
		document.vForm.action = "/sgportal/cass/techsup/cassTechsupAction.sg";
		document.vForm.submit();
	} 
}
	
//-->
</SCRIPT>
<form name='vForm2' method='post' > 
 	<input type="hidden" name="actType" id="actType" />     
 	<input type="hidden" name="c_tech_sup_app_no" id="c_tech_sup_app_no" value="${pMap.c_tech_sup_app_no}"/>  
 	
</form>  
 
	
<form name='vForm' method='post' enctype="multipart/form-data"> 
	
	<input type="hidden" name="dev_chman_no" id=dev_chman_no />
	<input type="hidden" name="u_dev_chman_no" id="u_dev_chman_no" />

	<input type="hidden" name="actType" id="actType" />  
 	<input type="hidden" name="del_seq" id="del_seq" />
 	
 	<input type="hidden" name="pjt_no" id="pjt_no" value="${getCass.C_PJT_NO}" /> 
 	
 	<c:choose>
 		<c:when test="${pMap.actType == 'ins'}"> 
			<input type="hidden" name="c_tech_sup_app_no" id="c_tech_sup_app_no" value="${appID}"/>
			<input type="hidden" name="c_tech_sup_app" id="c_tech_sup_app" value="${appID}"/>   
		</c:when>
		<c:otherwise>
		 	<input type="hidden" name="c_tech_sup_app_no" id="c_tech_sup_app_no" value="${pMap.c_tech_sup_app_no}"/>
		 	<input type="hidden" name="c_tech_sup_app" id="c_tech_sup_app" value="${pMap.c_tech_sup_app_no}"/>
		 	<input type="hidden" name="c_pjt_no" id="c_pjt_no" value="${getCass.C_PJT_NO}" /> 
		</c:otherwise> 
 	</c:choose>
 	 
 
 	
<div id="title_line">
	<div id="title">장애처리</div>
	<div id="location"> 장애처리 >
		<c:choose>
			<c:when test="${pMap.actType == 'view'}">조회</c:when>
			<c:when test="${pMap.actType == 'mod'}">수정</c:when>
			<c:when test="${pMap.actType == 'ins'}">등록</c:when> 
		</c:choose> 
	</div>
</div>

 
<h3 class="subtitle"> 
	장애처리 ID
	<c:choose>
		<c:when test="${pMap.actType == 'ins'}"> 
			<b style="color:RED">${fn:substring(appID, 0, 3)}-${fn:substring(appID, 3, 16)}</b>  
		</c:when>
		<c:otherwise>
		 	 
		</c:otherwise>
	</c:choose>
</h3>

<table width="100%" border="0" cellpadding="0" cellspacing="0" class="grid" rules="cols" id="MainTable">
	<tr>
		<th scope="col" id="odd" style="width:20%">장애 분류/카테고리</th>
		<td colspan="3">  
			<c:choose>
				<c:when test="${pMap.actType == 'ins' || pMap.actType == 'mod'}"> <!--  class="validate-required-select"  -->
					 
					<select name="c_cate_id" id="c_cate_id" title="장애 분류/카테고리"  style="width:170px">
						<option value="">선택</option>
						<c:forEach items="${cass_cate_id}" var="cate" varStatus="i">
						<option <c:if test="${cate.CODE == getCass.C_CATE_ID}"> selected=="selected"</c:if> value="${cate.CODE}">
							${cate.CODE_NM}
						</option>
						</c:forEach>
					</select>
					 
					<input type="text" title="직접입력" size="27" name="c_cate_nm" id="c_cate_nm" value="${getCass.C_CATE_NM}" />
				</c:when>
				<c:otherwise>
				 	
				 	
				 	<c:choose>
						<c:when test="${!empty getCass.C_CATE_ID }">${getCass.CATE_NM }</c:when>
						<c:when test="${!empty getCass.C_CATE_NM }">${getCass.C_CATE_NM }</c:when> 
					</c:choose>
				 	
				</c:otherwise>
			</c:choose> 
			
		</td>
	</tr> 
 
	<tr> 
		<th scope="col" id="odd">
			프로젝트 
		</th>
		<td colspan="3">
		<c:choose>
			<c:when test="${pMap.actType == 'ins' || pMap.actType == 'mod'}">
				<input type="text" title="프로젝트명" style="width:85%" name="pjt_nm" id="pjt_nm" value="${getCass.PJT_NM}"  readonly="readonly" onclick="jf_srcPjt()" />
				&nbsp;
				<input type="button" class="buttonsmall04" value="프로젝트" onclick="jf_srcPjt()" /> <br/>
				 
				<input type="hidden" name="prod_type" />				
			</c:when>
			<c:otherwise>
			 	  ${getCass.PJT_NM}
			</c:otherwise>
		</c:choose>
		</td>
	</tr>
	
	<tr>
		<th scope="col" id="odd" width="15%">
			고객사 
		</th>
		<td width="35%"> 
			 <c:choose>
				<c:when test="${pMap.actType == 'ins' || pMap.actType == 'mod'}">
					<input class="Input_w required inputTex"  title="고객사" size="27" type='text' name='c_com_nm' value="${getCass.C_COM_NM}" />
				</c:when>
				<c:otherwise>
					${getCass.C_COM_NM}
				</c:otherwise> 
			</c:choose>   
		</td> 
		<th scope="col" id="odd" width="15%">
			고객명 
		</th>
		<td> 
			<c:choose>
				<c:when test="${pMap.actType == 'ins' || pMap.actType == 'mod'}">
					<input class="Input_w required inputTex"  title="고객명" size="27" type='text' name='c_com_per_nm' value="${getCass.C_COM_PER_NM}" />
				</c:when>
				<c:otherwise>
					${getCass.C_COM_PER_NM}
				</c:otherwise> 
			</c:choose>  
		</td> 
	</tr>
	<tr>
		<th scope="col" id="odd">
			고객연락처 
		</th>
		<td colspan="3"> 
			 <c:choose>
				<c:when test="${pMap.actType == 'ins' || pMap.actType == 'mod'}">
					<input class="Input_w" title="고객연락처" size="27" type='text' name='c_com_per_tel' value="${getCass.C_COM_PER_TEL}" />
				</c:when>
				<c:otherwise>
					${getCass.C_COM_PER_TEL}
				</c:otherwise> 
			</c:choose>   
		</td>  
	</tr>
 
	<tr>
		<th scope="col" id="odd">
			* 제목 
		</th>
		<td colspan="3"> 
			 <c:choose>
				<c:when test="${pMap.actType == 'ins' || pMap.actType == 'mod'}">
					<input class="Input_w required inputTex"  title="제목" style="width:85%" type='text' name='c_tech_sup_title' value="${getCass.C_TECH_SUP_TITLE}" />
				</c:when>
				<c:otherwise>
					${getCass.C_TECH_SUP_TITLE}
				</c:otherwise>
			</c:choose>   
		</td>  
	</tr>
	
	
	<tr>
		<th scope="col" id="odd">* 현상</td>
		<td colspan='3'> 
			<table class="grid02" width="99%" border="0">				
				
				<c:if test="${pMap.actType != 'mod'}">
				<tr>
					<td colspan='4'>
						<textarea name='c_st1_content' style="width:86%;height:100"></textarea>
						&nbsp;&nbsp;
						<c:if test="${!empty getCass.C_TECH_SUP_APP_NO}">
							<input name="button4222" type="button" class="buttonsmall04" onClick="javascript:jf_st('1');" align="absmiddle" value="현상저장"/>
						</c:if>
					</td>							
				</tr>
				</c:if>
				
				<c:if test="${fn:length(getST1) > 0}"> 
				<!-- 리스트 시작 -->
				<c:forEach items="${getST1}" var="st1" varStatus="i">
				<tr>
					<td width='15%' align="center"><b style="color:#0080C0"> ${st1.CHMAN_NM}</b></td>
					<td  style='padding-left:10px'><str:replace replace="\n" with="<br>" newlineToken="\n">${st1.C_ST1_CONTENT}</str:replace> </td>	
					<td width='15%' align="center">${fn:substring(st1.CR_DATE, 0, 16)}</td>					
					<td width='15%'>
						<c:forEach items="${getHis}" var="his" varStatus="l">
							<c:choose>
								<c:when test="${his.C_TECH_SUP_PR_ID != '7' && fn:length(getHis) == his.ROWNUM }">
									&nbsp;&nbsp;&nbsp;&nbsp;
									<c:if test="${st1.CHMAN_NO == sessionMap.SABUN ||  sessionMap.ADMIN_ID == 'admin'}">
										<input name="button4222" type="button" class="buttonsmall02" onClick="javascript:jf_talkdelete('1', '${st1.C_ST1_SEQ}');" align="absmiddle" value="삭제" /> 
									</c:if>
								</c:when>
							</c:choose>
				 		</c:forEach> 
					</td>			
				</tr>
				</c:forEach>
				<!-- 리스트 끝 -->
				</c:if>
			</table> 
		</td>
	</tr>
	

	<input type="hidden" name="c_st_seq" />
	<tr>
		<th scope="col" id="odd"> 원인</td>
		<td colspan='3'> 
			<table class="grid02" width="99%" border="0">				
				<c:if test="${pMap.actType != 'mod'}">
				<tr>
					<td colspan='4'>
						<textarea name='c_st2_content' style="width:86%;height:100"></textarea>
						&nbsp;&nbsp;
						<c:if test="${!empty getCass.C_TECH_SUP_APP_NO}">
							<input name="button4222" type="button" class="buttonsmall04" onClick="javascript:jf_st('2');" align="absmiddle" value="원인저장"/>
						</c:if>
					</td>							
				</tr> 
				</c:if>
				<c:if test="${fn:length(getST2) > 0}">
				<!-- 리스트 시작 -->
				<c:forEach items="${getST2}" var="st2" varStatus="j">
				<tr>
					<td width='15%' align="center"><b style="color:#0080C0"> ${st2.CHMAN_NM} </b></td>
					<td  style='padding-left:10px'><str:replace replace="\n" with="<br>" newlineToken="\n">${st2.C_ST2_CONTENT}</str:replace> </td>	
					<td width='15%' align="center">${fn:substring(st2.CR_DATE, 0, 16)}</td>
					<td width='15%'>
						<c:forEach items="${getHis}" var="his" varStatus="l">
							<c:choose>
								<c:when test="${his.C_TECH_SUP_PR_ID != '7' && fn:length(getHis) == his.ROWNUM }">
									&nbsp;&nbsp;&nbsp;&nbsp;
									<c:if test="${st2.CHMAN_NO == sessionMap.SABUN ||  sessionMap.ADMIN_ID == 'admin'}">
										<input name="button4222" type="button" class="buttonsmall02" onClick="javascript:jf_talkdelete('2', '${st2.C_ST2_SEQ}');" align="absmiddle" value="삭제" />
									</c:if>
								</c:when>
							</c:choose>
				 		</c:forEach> 
					</td>						
				</tr>
				</c:forEach>
				<!-- 리스트 끝 -->
				</c:if>
			</table> 
		</td>
	</tr>
	 
	
	<tr>
		<th scope="col" id="odd"> 조치</td>
		<td colspan='3'> 
			<table class="grid02" width="99%" border="0">				
				<c:if test="${pMap.actType != 'mod'}">
				<tr>
					<td colspan='4'>
						<textarea name='c_st3_content' style="width:86%;height:100"></textarea>
						&nbsp;&nbsp;
						<c:if test="${!empty getCass.C_TECH_SUP_APP_NO}">
							<input name="button4222" type="button" class="buttonsmall04" onClick="javascript:jf_st('3');" align="absmiddle" value="조치저장"/>
						</c:if>
					</td>							
				</tr> 
				</c:if>
				<c:if test="${fn:length(getST3) > 0}">				
				<!-- 리스트 시작 -->
				<c:forEach items="${getST3}" var="st3" varStatus="k">
				<tr>
					<td width='15%' align="center"><b style="color:#0080C0"> ${st3.CHMAN_NM} </b></td>
					<td  style='padding-left:10px'><str:replace replace="\n" with="<br>" newlineToken="\n">${st3.C_ST3_CONTENT}</str:replace> </td>	
					<td width='15%' align="center">${fn:substring(st3.CR_DATE, 0, 16)}</td>
					<td width='15%'>
						<c:forEach items="${getHis}" var="his" varStatus="l">
							<c:choose>
								<c:when test="${his.C_TECH_SUP_PR_ID != '7' && fn:length(getHis) == his.ROWNUM }">
									&nbsp;&nbsp;&nbsp;&nbsp;
									<c:if test="${st3.CHMAN_NO == sessionMap.SABUN ||  sessionMap.ADMIN_ID == 'admin'}">
										<input name="button4222" type="button" class="buttonsmall02" onClick="javascript:jf_talkdelete('3', '${st3.C_ST3_SEQ}');" align="absmiddle" value="삭제" />
									</c:if>
								</c:when>
							</c:choose>
				 		</c:forEach> 
					</td>
				</tr>
				</c:forEach>
				<!-- 리스트 끝 -->
				</c:if>
			</table> 
		</td>
	</tr>
	
	
	
	 
	<!-- 첨부 파일 S -->
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
			      	  					<a href="/download.ddo?fid=cassfile&add_file_no_key=${file.ADD_FILE_NO}&no_key=${file.NO}">${file.SAVEFILENAME}</a>
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
										<a href="/download.ddo?fid=cassfile&add_file_no_key=${file.ADD_FILE_NO}&no_key=${file.NO}">${file.SAVEFILENAME}</a>
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
	<!-- 첨부 파일 E -->
	 
	
	
	 <tr>
          <td id="odd" scope="col">협조담당자</td>
	      <td style="padding-left: 3px" colspan="3">
	      	<table width="85%" id="devChmanTable" border="0" class="grid02">
	      		<c:if test="${pMap.actType == 'ins' || pMap.actType == 'mod'}">
	      		<tr>
	      			<td colspan="2">
	      				<input type="hidden" name="addDevChman_nm" />
				      	<input type="hidden" name="addDev_chman_no" />
				      	<input type="hidden" name="addGradeCode" />
				      	<input type="hidden" name="addDeptCode" />
				      	<input type="text" style="width:65%" name="addDev_chman_nm" id="addDev_chman_nm" class="Input_w" readonly="readonly"/>
				      	&nbsp;&nbsp;&nbsp;
				      	<input type="button" class="buttonsmall05" value="담당자검색" onclick="jf_srcChman('COR1011022247591', 'SG')" />
				      	<input type="button" class="buttonsmall06" value="제품담당보기" onclick="jf_srcProdChman()" /> 
			      	</td>
				    <td style="width:15%" align="center">
				    	<p onclick="jf_chmanaddRow()">
			        		<strong style="cursor:pointer">추가</strong>
			        	</p>
			        		
				    </td>
				 </tr>
				 </c:if>
								 	
				
					<c:forEach items="${getCorp}" var="sw" varStatus="i">
					<tr id="devChmanTr${i.index+1}" >
						<c:if test="${pMap.actType == 'view'}">
							<th scope="col" id="odd">
								${sw.CHMAN_NM}
							</th>
							<td style="padding-left: 10px">
								[ ${sw.GRADE_CODE} / ${sw.DEPT_CODE}]
								<input type='hidden' name='u_dev_chman_no' value="${sw.C_CORP_CHMAN_NO}">
							</td>
						</c:if>
						
						<c:if test="${pMap.actType == 'mod'}">
							<th scope="col" id="odd">
								${sw.CHMAN_NM}
							</th>
							<td style="padding-left: 10px">
								[${sw.GRADE_CODE} / ${sw.DEPT_CODE}]
								<input type='hidden' name='u_dev_chman_no' value="${sw.C_CORP_CHMAN_NO}">
							</td>
						<td align="center">
							 <p onclick="jf_chmanDeleteRow2('devChmanTr${i.index+1}', '${sw.C_TECH_SUP_CORP_SEQ}')">
							 <span style="cursor:pointer"><b>[삭제]</b></span>
							 </p>
						</td>
						</c:if>
					</tr>
					</c:forEach>
				
				 
			 </table>
	      	
	      </td>
        </tr>
	
	
	 	 
				 
	<tr>
		<th scope="col" id="odd">
			비고 
		</th>
		<td colspan="3"> 
			 <c:choose>
				<c:when test="${pMap.actType == 'ins' || pMap.actType == 'mod'}">
					<input class="Input_w"  title="비고" style="width:85%" type='text' name='c_etc' value="${getCass.C_ETC}" />
				</c:when>
				<c:otherwise>
					${getCass.C_ETC}
				</c:otherwise>
			</c:choose>   
		</td>  
	</tr>
	<tr>
		<th scope="col" id="odd">
			작성자 
		</th>
		<td colspan="3"> 
			 <c:choose>
				<c:when test="${pMap.actType == 'ins' || pMap.actType == 'mod'}">
					${sessionMap.ADMIN_NM}
				</c:when>
				<c:otherwise>
					${getCass.C_SG_CHMAN_NM}
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
			<c:choose>
				<c:when test="${pMap.actType == 'ins'}">
					<input type="button" class="button02" value="저장" onclick="javascript:jf_techsupInsForm()">
				</c:when>
				<c:otherwise> 
					<c:if test="${!empty pMap.c_tech_sup_app_no }">
						<c:forEach items="${getHis}" var="his" varStatus="l">
							<c:choose>
								<c:when test="${his.C_TECH_SUP_PR_ID != '7' && fn:length(getST3) > 0 && fn:length(getHis) == his.ROWNUM }">
									<input type="button" class="button02" value="완료" onclick="javascript:jf_techsupClose()">
								</c:when>
							</c:choose>
				 		</c:forEach> 
					</c:if> 
				 	<input type="button" class="button02" value="수정" onclick="javascript:jf_techsupModForm()"> 
				</c:otherwise> 
			</c:choose> 
		</c:if> 
		
		<input type="button" class="button02" value="목록" onclick="javascript:jf_techsupList()">
	</div>
</div>
			
</form>
<div id="mypopup" style="position: absolute; visibility: hidden; z-index: 0; background-color: #99BDDF;"></div>




<h3 class="subtitle"> 장애처리 등록 이력 </h3>

<table width="100%" border="0" cellpadding="0" cellspacing="0" class="grid02">
	<tr>
		<th align="center"  id="odd">순번</th>
		<th align="center"  id="odd">등록 이력</th>
		<th align="center"  id="odd">등록자</th>
		<th align="center"  id="odd">부서/직책</th>
		<th align="center"  id="odd">처리일시</th>
	</tr>
	<c:forEach items="${getHis}" var="his" varStatus="l">
	<tr> 
		<td align="center" style="padding-left: 10px" width="10%">${l.index + 1}</td>
		<td style="padding-left: 10px" width="30%">
			<b>
			<c:choose>
				<c:when test="${his.C_TECH_SUP_PR_ID=='1'}"> 마스터 저장 </c:when>
				<c:when test="${his.C_TECH_SUP_PR_ID=='2'}"> 현상저장 </c:when>
				<c:when test="${his.C_TECH_SUP_PR_ID=='3'}"> 원인저장 </c:when>
				<c:when test="${his.C_TECH_SUP_PR_ID=='4'}"> 조치내용 </c:when>
				<c:when test="${his.C_TECH_SUP_PR_ID=='5'}"> 마스터 수정 </c:when>
				<c:when test="${his.C_TECH_SUP_PR_ID=='6'}"> 협조자등록 </c:when>
				<c:when test="${his.C_TECH_SUP_PR_ID=='7'}"> 처리완료 </c:when>
			</c:choose>
			</b>
		</td>
		<td align="center" width="20%">${his.CHMAN_NM}</td>
		<td align="center" width="20%" >${his.DEPT_CODE} / ${his.GRADE_CODE} </td>
		<td  align="center" width="20%">${his.CR_DATE}</td> 
	</tr>
	</c:forEach>	
</table>
<br/><br/>






