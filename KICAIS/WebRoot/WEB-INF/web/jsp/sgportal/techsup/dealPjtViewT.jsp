<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<%@ include file="/WEB-INF/web/jsp/common/inc/commonInc.jsp" %>
<script src="/resource/common/js/MultiUpload.js"></script>
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
if('${pMap.actType}' == 'ins' || '${pMap.actType}' == 'mod'){

	$(function() {
		
		$.ajax({
			url: "/sgportal/techsup/pjtListXML.sg",
			type: "POST",
			data: "",
			success: function( xmlResponse ) {
				var data = $( "Service", xmlResponse ).map(function() {
					return {
						value: $( "PJT_NAME", this ).text() ,
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




$(function() {
	
	$.ajax({
		url: "/sgportal/chman/xmlChmanList.sg",
		type: "POST",
		data: "comT=1",
		success: function( xmlResponse ) {
			var data = $( "Service", xmlResponse ).map(function() {
				return {
					value: $( "CHMAN_NM", this ).text() + "/" + 
						$( "GRADE_CODE", this ).text() + "/" + $( "DEPT_CODE", this).text(),
					chmanNm: $( "CHMAN_NM", this ).text(),
					chmanNo: $( "CHMAN_NO", this ).text(),
					gradeCode: $( "GRADE_CODE", this).text(),
					deptCode: $( "DEPT_CODE", this).text()
				};
			}).get();
			$( "#chman_nm_sg" ).autocomplete({
				source: data,
				minLength: 0,
				select: function( event, ui ) {
					document.vForm.chman_no_sg.value = ui.item.chmanNo;
				}
			});
		} 
	});
});

$(function() {
	
	$.ajax({
		url: "/sgportal/chman/xmlChmanList.sg",
		type: "POST",
		data: "comT=2&corp_no=" + '${corp.CORP_NO}',
		success: function( xmlResponse ) {
			var data = $( "Service", xmlResponse ).map(function() {
				return {
					value: $( "CHMAN_NM", this ).text() + "/" + 
						$( "GRADE_CODE", this ).text() + "/" + $( "DEPT_CODE", this).text(),
					chmanNm: $( "CHMAN_NM", this ).text(),
					chmanNo: $( "CHMAN_NO", this ).text(),
					gradeCode: $( "GRADE_CODE", this).text(),
					deptCode: $( "DEPT_CODE", this).text()
				};
			}).get();
			$( "#chman_nm_cu" ).autocomplete({
				source: data,
				minLength: 0,
				select: function( event, ui ) {
					document.vForm.chman_no_cu.value = ui.item.chmanNo;
				}
			});
		} 
	});
});


$(function() {
	
	$.ajax({
		url: "/sgportal/product/productListXML.sg",
		type: "POST",
		success: function( xmlResponse ) {
			var data = $( "Service", xmlResponse ).map(function() {
				return {
					value: $( "PROD_NM", this ).text(),
					prod_nm: $( "PROD_NM", this ).text(),
					prod_no: $( "PROD_NO", this ).text(),
					prod_ver: $( "PROD_VER", this ).text(),
					prod_type: $( "PROD_TYPE_CODE_NM", this ).text()
					 
					
					
				};
			}).get();
			$( "#prod_nm" ).autocomplete({
				source: data,
				minLength: 0,
				select: function( event, ui ) {
					document.vForm.prod_nm.value = ui.item.prod_nm;
					document.vForm.prod_no.value = ui.item.prod_no;
					document.vForm.ver.value = ui.item.prod_ver;
					document.vForm.prod_type.value = ui.item.prod_type;
					
					
				}
			});
		} 
	});
});

function jf_techsupList(){
	document.vForm2.pageNum.value = "1";
	document.vForm2.actType.value = 'view';
	document.vForm2.action = "/sgportal/techsup/techsupPjtList.sg";
	document.vForm2.submit();
}

function jf_techsupModForm(){   
	if('${pMap.actType}' == "view"){
		document.vForm2.actType.value="mod"; 
		document.vForm2.action = "/sgportal/techsup/dealPjtView.sg";
		document.vForm2.submit();
	}else{ 
		document.vForm.cont_date.value = document.vForm.cont_date.value.split("-").join("");
		document.vForm.st_date.value = document.vForm.st_date.value.split("-").join("");
		document.vForm.end_date.value = document.vForm.end_date.value.split("-").join("");
		document.vForm.actType.value="mod"; 
		if(Validator.validate(document.vForm)){
			document.vForm.action = "/sgportal/techsup/dealPjtAction.sg";
			document.vForm.submit();
		}
	}
}

function jf_techsupInsForm(){  
	if(document.vForm.chman_no_sg.value == ''){
		alert('SG담당자를 선택해주세요.');
		return false;
	}
	if(document.vForm.chman_no_cu.value == ''){
		alert('고객담당자를 선택해주세요.');
		return false;
	}
	if(document.vForm.prod_no.value == ''){
		alert('제품을 선택해주세요.');
		return false;
	}
	
	
	
	document.vForm.actType.value="ins"; 
	if(Validator.validate(document.vForm)){
		document.vForm.cont_date.value = document.vForm.cont_date.value.split("-").join("");
		document.vForm.st_date.value = document.vForm.st_date.value.split("-").join("");
		document.vForm.end_date.value = document.vForm.end_date.value.split("-").join("");
		document.vForm.action = "/sgportal/techsup/dealPjtAction.sg";
		document.vForm.submit();
	}
}

function jf_srcChman(corp_no, comT){  
	var realCom="";
	if(comT=='CU' ){
		realCom='${pMap.corp_no}';
	} 
	
	var url = "/sgportal/chman/chmanList.sg?corp_no="+corp_no+"&comT="+comT+"&viewName=/sgportal/techsup/chmanPopup"+"&srcType=sup";
	window.open(url, "chmanPopup", "width=620, height=560, left=250, top=100, scrollbars=yes, resizable=no, menubar=no");
	
}

function jf_srcProd(){
	var param = "viewName=/sgportal/techsup/pjtProdPopup";
	var url = "/sgportal/product/productList.sg?" + param;
	window.open(url, "", "width=620, height=448, left=250, top=50, scrollbars=yes, resizable=no, menubar=no");
	//var param = "";
	//var url = "/sgportal/techsup/techsupPjtProdList.sg?" + param;
	//window.open(url, '', 'width=800, height=500, scrollbars=yes, toolbar=no');
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
	 	document.vForm.action = "/sgportal/techsup/dealPjtAction.sg?use_yn=" + value;
	 	document.vForm.submit();
	}
}

function jf_per_del(){
	if(confirm('영구삭제 하겠습니까?')){
	 	document.vForm.actType.value = 'del';
	 	document.vForm.action = "/sgportal/techsup/dealPjtAction.sg";
	 	//document.vForm.submit();
	}
}

function jf_srcPjt(){
	var param = "comT=CU&viewName=/sgportal/techsup/pjtListPopup&corp_no=${pMap.corp_no}";
	var url = "/sgportal/techsup/pjtList.sg?" + param;
	window.open(url, "", "width=620, height=648, left=250, top=50, scrollbars=yes, resizable=no, menubar=no");

	
}

	
//-->
</SCRIPT>
<c:set var="groups" value="${fn:split(sessionMap.GROUPS, ',')}" />



<form name='vForm2' method='post' > 
 	<input type="hidden" name="actType" id="actType" />   
 	<input type="hidden" name="pjt_no" id="pjt_no" value="${pMap.pjt_no}" /> 
 	<input type="hidden" name="need_corp_no" id="need_corp_no" value="${pMap.corp_no}"/>  
 	<input type="hidden" name="corp_no" id="corp_no" value="${pMap.corp_no}" /> 
 	<input type="hidden" name="cont_no" id="cont_no" value="${pMap.cont_no}" /> 
 	<input type='hidden' name='pageNum' id="pageNum" value='${pageNavi.startRowNo}' />  
 	<input type="hidden" name="sup_corp_no" id="corp_no" value="COR1011022247591" /> 
 	


</form>

 	
<form name='vForm' method='post' enctype="multipart/form-data"> 
 	<input type="hidden" name="actType" id="actType" />  
 	<input type="hidden" name="pjt_no" id="pjt_no" value="${pMap.pjt_no}"/> 
 	<input type="hidden" name="corp_no" id="corp_no" value="${pMap.corp_no}"/> 
 	<input type="hidden" name="need_corp_no" id="need_corp_no" value="${pMap.corp_no}"/>  
 	<input type="hidden" name="cont_no" id="cont_no" value="${pMap.cont_no}"/>  
 	<input type="hidden" name="no" id="no" value="${pMap.cont_no}"/>
 	<input type="hidden" name="sup_corp_no" id="corp_no" value="COR1011022247591" /> 
 	

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
			> 계약정보  > 
			<c:if test="${pMap.actType == 'view'}">조회</c:if>
			<c:if test="${pMap.actType == 'mod'}">수정</c:if>
			<c:if test="${pMap.actType == 'ins'}">등록</c:if>  
		</div>
	</div>

 	
<h3 class="subtitle">  고객사 정보</h3>
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="grid" rules="cols">
	<tr valign="middle">
		<td width="20%" scope="col" id="odd">
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
			${corp.SSN}
		</td>
	</tr>
	<tr valign="middle">
		<td scope="col" id="odd">
			주소
		</td>
		<td>
			${corp.ADDR1} <br />
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
					
					
<h3 class="subtitle">  계약 정보</h3>
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="grid" rules="cols">
	 
	<tr>
		<th scope="col" id="odd" style="width:20%">계약구분</th>
		<td>  
			<c:choose>
				<c:when test="${pMap.actType == 'ins' || pMap.actType == 'mod'}"> 
					<select class="validate-required-select" name="cont_type_code" id="cont_type_code" title="계약구분">
						<option value="">
							선택
						</option>
						<c:forEach items="${cont_type_code}" var="type" varStatus="i">
						<option <c:if test="${type.CODE == deal.CONT_TYPE_CODE}"> selected="selected"</c:if> value="${type.CODE}">
							${type.CODE_NM}
						</option>
						</c:forEach>
					</select> 
				</c:when>
				<c:otherwise>
				 	<select name="cont_type_code" id="cont_type_code" disabled="disabled">
						<option value=""></option>
						<c:forEach items="${cont_type_code}" var="type" varStatus="i">
						<option <c:if test="${type.CODE == deal.CONT_TYPE_CODE}"> selected="selected"</c:if> value="${type.CODE}">
							${type.CODE_NM}
						</option>
						</c:forEach>
					</select>
				</c:otherwise>
			</c:choose> 
			
		</td>
	</tr>  

	<tr>
		<th scope="col" id="odd" style="width:20%">프로젝트</th>
		<td> 
			<c:choose>
				<c:when test="${pMap.actType == 'ins'}">
					<input type="text" title="프로젝트명" class="Input_w required inputTex" name="pjt_nm" id="pjt_nm" value="${pMap.pjt_nm}"  style="width:200" />
					<input type="button" class="buttonsmall06" value="프로젝트검색" onclick="jf_srcPjt()" /> <br/>
					<!-- 
					<input type="hidden" name="pjt_no" value="${deal.PJT_NO}" />
					 -->
					<input type="hidden" name="prod_type" />
					
				</c:when>
				<c:when test="${pMap.actType == 'mod'}">
					<input type="text" title="프로젝트명" class="Input_w required inputTex" name="pjt_nm" id="pjt_nm" value="${deal.PJT_NM}"  style="width:200" />
					<input type="button" class="buttonsmall06" value="프로젝트검색" onclick="jf_srcPjt()" /> <br/>
					<!-- 
					<input type="hidden" name="pjt_no" value="${deal.PJT_NO}" />
					 -->
					<input type="hidden" name="prod_type" />
					
				</c:when>
				<c:otherwise>
				 	  ${deal.PJT_NM}
				</c:otherwise>
			</c:choose>
		</td>
	</tr> 

	<tr>
		<th scope="col" id="odd" style="width:20%">SG담당자</th>
		<td> 
			<c:choose>
				<c:when test="${pMap.actType == 'ins' || pMap.actType == 'mod'}"> 
					<input type="text" name="chman_nm_sg" id="chman_nm_sg" value="${deal.SG}"   style="width:200" />&nbsp;&nbsp;
					<input type="button" class="buttonsmall05" value="담당자검색" onclick="jf_srcChman('COR1011022247591', 'SG')" /> 
				</c:when>
				<c:otherwise>
				 	 ${deal.SG}
				</c:otherwise>
			</c:choose> 
		</td>
	</tr>  
	<input type="hidden" name="chman_no_sg" id="chman_no_sg" value="${deal.SG_NO}" />
	<input type="hidden" name="chman_sect_code_sg" id="chman_sect_code_sg" value="1" />
	
	<tr>
		<th scope="col" id="odd" style="width:20%">고객담당자</th>
		<td> 
			<c:choose>
				<c:when test="${pMap.actType == 'ins' || pMap.actType == 'mod'}"> 
					<input type="text" name="chman_nm_cu" id="chman_nm_cu" value="${deal.CU}"  style="width:200" />&nbsp;&nbsp;
					<input type="button" class="buttonsmall05" value="담당자검색" onclick="jf_srcChman('', 'CU')" /> 
				</c:when>
				<c:otherwise>
				 	 ${deal.CU}
				</c:otherwise>
			</c:choose> 
		</td>
	</tr>  
	<input type="hidden" name="chman_no_cu" id="chman_no_cu" value="${deal.CU_NO}"/>
	<input type="hidden" name="chman_sect_code_cu" id="chman_sect_code_cu" value="2"/>
	
	<tr>
		<th scope="col" id="odd" style="width:20%">제품명</th>
		<td> 
			<c:choose>
				<c:when test="${pMap.actType == 'ins' || pMap.actType == 'mod'}">
					제품명:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" name="prod_nm" id="prod_nm" value="${deal.PROD_NM}"  style="width:200"/>&nbsp;&nbsp;
					<input type="button" class="buttonsmall05" value="제품검색" onclick="jf_srcProd(' ${deal.CORP_NO}', 'CU')" /> 
					<br/>
					버전:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" name="ver" id="ver" value="${deal.PROD_VER}"  style="width:200"  readonly="readonly"/>&nbsp;&nbsp;<br/>
					유형:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" name="prod_type" id="prod_type" value="${deal.PROD_TYPE}"  style="width:200"  readonly="readonly"/>&nbsp;&nbsp;<br/>
					COPY수:&nbsp;&nbsp;&nbsp;<input type="text" name="cnt" id="cnt" value="${deal.CNT}"  style="width:30" />&nbsp;&nbsp;<br/> 
				</c:when>
				<c:otherwise>
				 	제품명:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${deal.PROD_NM}<br/> 
				 	버전:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${deal.PROD_VER}<br/>
				 	유형:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${deal.PROD_TYPE}<br/>
				 	COPY수:&nbsp;&nbsp;&nbsp;${deal.CNT}
				</c:otherwise>
			</c:choose> 
		</td>
	</tr>  
	<!-- 제품 일련번호  -->
		<input type="hidden" name="prod_no" id="prod_no" value="${deal.PROD_NO}"/>  
		<input type="hidden" name="seq" id="seq" value="1"/>   
	<!-- 	  
	<tr>
		<th scope="col" id="odd" style="width:20%">제품수량</th>
		<td> 
			<c:choose>
				<c:when test="${pMap.actType == 'ins' || pMap.actType == 'mod'}">
					<input name="prod_cnt" id="prod_cnt" type="text" class="inputText date" value="${deal.CNT}" maxlength="2"/> 
				</c:when>
				<c:otherwise>
				 	 ${deal.CNT}
				</c:otherwise>
			</c:choose> 
		</td>
	</tr>
	 -->   
	<tr>
		<th scope="col" id="odd" style="width:20%">계약일</th>
		<td> 
			<c:choose>
				<c:when test="${pMap.actType == 'ins' || pMap.actType == 'mod'}">
					<input name="cont_date" id="cont_date" type="text" class="inputText date" value="${fn:substring(deal.CONT_DATE,0,10)}" readonly="readonly"/>
    									<input type="image" src="/resource/images/admin/img/ic_calendar.gif" 
    									onclick="javascript:calPopup(this, 'mypopup', 0, 20, 'document.vForm.cont_date', ''); return false;"  
    									align="middle" width="16" height="16" /> 
				</c:when>
				<c:otherwise>
				 	 ${deal.CONT_DATE}
				</c:otherwise>
			</c:choose> 
		</td>
	</tr>  
	<tr>
		<th scope="col" id="odd" style="width:20%">유지보수기간</th>
		<td> 
			<c:choose> 
				<c:when test="${pMap.actType == 'ins' || pMap.actType == 'mod'}">
	    		    시작일:&nbsp;&nbsp;<input name="st_date" id="st_date" type="text" class="inputText date"  <c:if test="${!empty deal.ST_DATE}">value="${fn:substring(deal.ST_DATE, 0, 4)}-${fn:substring(deal.ST_DATE, 4, 6)}-${fn:substring(deal.ST_DATE, 6, 8)}"</c:if> readonly="readonly"/>
						<input type="image" src="/resource/images/admin/img/ic_calendar.gif" 
						onclick="javascript:calPopup(this, 'mypopup', 0, 20, 'document.vForm.st_date', ''); return false;"  
						align="middle" width="16" height="16" /> 
						<br/>
				   종료일:&nbsp;&nbsp;<input name="end_date" id="end_date" type="text" class="inputText date" <c:if test="${!empty deal.END_DATE}">value="${fn:substring(deal.END_DATE, 0, 4)}-${fn:substring(deal.END_DATE, 4, 6)}-${fn:substring(deal.END_DATE, 6, 8)}"</c:if> readonly="readonly"/>
						<input type="image" src="/resource/images/admin/img/ic_calendar.gif" 
						onclick="javascript:calPopup(this, 'mypopup', 0, 20, 'document.vForm.end_date', ''); return false;"  
						align="middle" width="16" height="16" />
				</c:when>
				<c:otherwise>
				 	 시작일:&nbsp;&nbsp;${fn:substring(deal.ST_DATE, 0, 4)}-${fn:substring(deal.ST_DATE, 4, 6)}-${fn:substring(deal.ST_DATE, 6, 8)}
				 	 <br/>
				 	 종료일:&nbsp;&nbsp;${fn:substring(deal.END_DATE, 0, 4)}-${fn:substring(deal.END_DATE, 4, 6)}-${fn:substring(deal.END_DATE, 6, 8)}
				</c:otherwise>
			</c:choose> 
		</td>
	</tr> 
	<!-- 첨부 파일 S -->
	<c:choose>
		<c:when test="${fn:length(fileView) > 0}">
			<tr>
				<th scope="col" id="odd">첨부파일</th>
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
				<th scope="col" id="odd">첨부파일</th>
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
		<th scope="col" id="odd" style="width:20%">비고</th>
		<td>   
			<c:choose>
				<c:when test="${pMap.actType == 'ins' || pMap.actType == 'mod'}">
					<textarea name="cont_contents" id="cont_contents" style="width:500;height:80">${deal.CONT_CONTENTS}</textarea> 
				</c:when>
				<c:otherwise>
				 	  ${deal.CONT_CONTENTS}
				</c:otherwise>
			</c:choose> 
		</td>
	</tr>
	</table> 
	
	

<div class="btn">						
	<div class="leftbtn">
		<input type="button" class="button02" value="목록" onclick="jf_techsupList()">
	</div>
	<div class="rightbtn">
		<!-- 권한 에 따른 쓰기기능 제어 시작  -->		
		<c:if test="${writeGrant != '0' }">
			<c:choose>
				<c:when test="${pMap.actType == 'ins'}">
					<input type="button" class="button02" value="저장" onclick="jf_techsupInsForm()">
				</c:when>
				<c:otherwise>
				 	<input type="button" class="button02" value="수정" onclick="jf_techsupModForm()">
				
				</c:otherwise> 
			</c:choose>   
		</c:if>
			
		<c:if test="${pMap.actType == 'view'}">
			<c:forEach items="${groups}" var="group" varStatus="i">
				<c:if test="${group == 'G001'}">
					<c:if test="${deal.USE_YN == 'Y'}">
						<!-- 
						<input type="button" class="button02" value="삭제" onclick="jf_del('N')" style="cursor:hand;">
						
							<input type="button" class="button04" value="영구삭제" onclick="jf_per_del()" style="cursor:hand;">
						 -->
					</c:if>
					<c:if test="${deal.USE_YN == 'N'}">
						<input type="button" class="button02" value="복구" onclick="jf_del('Y')" style="cursor:hand;">
					</c:if>
				</c:if>
				<c:if test="${group == 'G002'}">
					<c:if test="${deal.CHMAN_NO ==  deal.LCHMAN_NO}">
						<!-- 
						<input type="button" class="button02" value="삭제" onclick="jf_del()" style="cursor:hand;">
						 -->
					</c:if>
				</c:if>
			</c:forEach>
		</c:if>
	</div>
</div>	



</form>
<div id="mypopup" style="position: absolute; visibility: hidden; z-index: 0; background-color: #99BDDF;"></div>