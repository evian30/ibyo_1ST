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
					prod_no: $( "PROD_NO", this ).text(),
					prod_ver: $( "PROD_VER", this ).text(),
					prod_type: $( "PROD_TYPE_CODE_NM", this ).text(),
					cnt: $( "CNT", this ).text()
					 
					
					
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
					document.vForm.cnt.value = ui.item.cnt;
					
				}
			});
		} 
	});
});

alert('techsupview')
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
		data: "comT=2",
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



function jf_techsupList(){  
		document.vForm2.actType.value = 'view'; 
		document.vForm2.action = "/sgportal/techsup/techsupPjtList.sg";
		document.vForm2.submit();
}

function jf_techsupModForm(){  
	if('${pMap.actType}' == "view"){
		document.vForm2.actType.value="mod"; 
		document.vForm2.action = "/sgportal/techsup/techsupView.sg";
		document.vForm2.submit();
	}else{ 
		document.vForm.actType.value="mod";
		document.vForm.tech_sup_no.value="${techsupView.TECH_SUP_NO}";  
		if(Validator.validate(document.vForm)){
			document.vForm.action = "/sgportal/techsup/techsupAction.sg";
			document.vForm.submit();
		}
	}
}
	
function jf_techsupInsForm(){  
	document.vForm.actType.value="ins"; 
	if(Validator.validate(document.vForm)){
		document.vForm.action = "/sgportal/techsup/techsupAction.sg";
		document.vForm.submit();
	}
}

function jf_srcChman(corp_no, comT){  
	var url = "/sgportal/chman/chmanList.sg?corp_no="+corp_no+"&comT="+comT+"&viewName=/sgportal/techsup/chmanPopup"+"&srcType=sup";
	window.open(url, "chmanPopup", "width=620, height=448, left=250, top=100, scrollbars=yes, resizable=no, menubar=no");
	
}
	
function jf_srcProd(pjt_no){

	var param = "?pjt_no="+pjt_no;
	var url = "/sgportal/techsup/techsupPjtProdList.sg" + param;
	window.open(url, '', 'width=800, height=500, scrollbars=yes, toolbar=no');
} 
	
//-->
</SCRIPT>
<form name='vForm2' method='post' > 
 	<input type="hidden" name="actType" id="actType" />   
 	<input type="hidden" name="pjt_no" id="pjt_no" value="${pMap.pjt_no}"/> 
 	<input type="hidden" name="corp_no" id="corp_no" value="${pMap.corp_no}"/> 
 	<input type="hidden" name="tech_sup_no" id="tech_sup_no" value="${pMap.tech_sup_no}"/>  
</form>  
 
	
<form name='vForm' method='post' enctype="multipart/form-data">  
	<input type="hidden" name="actType" id="actType" />  
 	<input type="hidden" name="pjt_no" id="pjt_no" value="${pMap.pjt_no}"/> 
 	<input type="hidden" name="corp_no" id="corp_no" value="${pMap.corp_no}"/> 
 	<input type="hidden" name="tech_sup_no" id="tech_sup_no" value="${pMap.tech_sup_no}"/> 
 	<input type="hidden" name="no" id="no" value="${pMap.tech_sup_no}"/> 
 	<input type='hidden' name='page' value='${pMap.page}' />
 	
<div id="title_line">
	<div id="title">지원정보</div>
	<div id="location">
		지원정보  > 
		<c:choose>
			<c:when test="${pMap.actType == 'view'}">조회</c:when>
			<c:when test="${pMap.actType == 'mod'}">수정</c:when>
			<c:when test="${pMap.actType == 'ins'}">등록</c:when> 
		</c:choose> 
	</div>
</div>


<table width="100%" border="0" cellpadding="0" cellspacing="0" class="grid" rules="cols">
	<tr>
		<th scope="col" id="odd" style="width:20%">처리결과</th>
		<td>  
			<c:choose>
				<c:when test="${pMap.actType == 'ins' || pMap.actType == 'mod'}"> 
					<c:forEach items="${tech_sup_result_code}" var="tran_type" varStatus="i">
						<input class="validate-one-required" type="radio" name="tech_sup_result_code" id="tran_type_result${tran_type.CODE}" value="${tran_type.CODE}"  <c:if test="${tran_type.CODE == techsupView.TECH_SUP_RESULT_CODE}"> checked="checked" </c:if>  title="" class="required inputText"/>
						<label for="tran_type_result${tran_type.CODE}">${tran_type.CODE_NM}</label> &nbsp;&nbsp;
					</c:forEach>  
				</c:when>
				<c:otherwise>
				 	 ${techsupView.RESULT}
				</c:otherwise>
			</c:choose> 
			
		</td>
	</tr> 
	<tr>
		<th scope="col" id="odd" style="width:20%">지원유형</th>
		<td> 
			<c:choose>
				<c:when test="${pMap.actType == 'ins' || pMap.actType == 'mod'}"> 
					<c:forEach items="${tech_sup_tran_type_code}" var="tran" varStatus="i">
						<input  class="validate-one-required" type="radio" name="tech_sup_tran_type_code" id="tran_result${tran.CODE}" value="${tran.CODE}"  <c:if test="${tran.CODE == techsupView.TECH_SUP_TRAN_TYPE_CODE}"> checked="checked" </c:if>  title="" class="required inputText"/>
						<label for="tran_result${tran.CODE}">${tran.CODE_NM}</label> &nbsp;&nbsp;
					</c:forEach>   
				</c:when>
				<c:otherwise>
				 	 ${techsupView.METHOD}
				</c:otherwise>
			</c:choose>  
		</td>
	</tr>
	<tr>
		<th scope="col" id="odd" style="width:20%">SG담당자</th>
		<td> 
			<c:choose>
				<c:when test="${pMap.actType == 'ins' || pMap.actType == 'mod'}"> 
					<input type="text" name="chman_nm_sg" id="chman_nm_sg" value="${techsupView.SG}"   style="width:200"/>&nbsp;&nbsp;
					<input type="button" class="buttonsmall05" value="담당자검색" onclick="javascript:jf_srcChman('COR1011022247591', 'SG')" /> 
				</c:when>
				<c:otherwise>
				 	 ${techsupView.SG}
				</c:otherwise>
			</c:choose> 
		</td>
	</tr>  
	<input type="hidden" name="chman_no_sg" id="chman_no_sg" value="${techsupView.SG_NO}" />
	<input type="hidden" name="chman_sect_code_sg" id="chman_sect_code_sg" value="1" />
	
	<tr>
		<th scope="col" id="odd" style="width:20%">고객담당자</th>
		<td> 
			<c:choose>
				<c:when test="${pMap.actType == 'ins' || pMap.actType == 'mod'}"> 
					<input type="text" name="chman_nm_cu" id="chman_nm_cu" value="${techsupView.CU}"  style="width:200" />&nbsp;&nbsp;
					<input type="button" class="buttonsmall05" value="담당자검색" onclick="javascript:jf_srcChman('${pMap.corp_no}', 'CU')" /> 
				</c:when>
				<c:otherwise>
				 	 ${techsupView.CU}
				</c:otherwise>
			</c:choose> 
		</td>
	</tr>  
	<input type="hidden" name="chman_no_cu" id="chman_no_cu" value="${techsupView.CU_NO}"/>
	<input type="hidden" name="chman_sect_code_cu" id="chman_sect_code_cu" value="2"/>
	
	<tr>
		<th scope="col" id="odd" style="width:20%">제품명</th>
		<td> 
			<c:choose>
				<c:when test="${pMap.actType == 'ins' || pMap.actType == 'mod'}">
					제품명:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" name="prod_nm" id="prod_nm" value="${techsupView.PROD_NM}"  style="width:200" />&nbsp;&nbsp;
					<input type="button" class="buttonsmall04" value="제품검색" onclick="javascript:jf_srcProd('${pMap.pjt_no}')" /> 
					<br/>
					버전:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" name="ver" id="ver" value="${techsupView.VER}"  style="width:200"  readonly="readonly"/>&nbsp;&nbsp;<br/>
					유형:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" name="prod_type" id="prod_type" value="${techsupView.PROD_TYPE}"  style="width:200"  readonly="readonly"/>&nbsp;&nbsp;<br/>
					COPY수:&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" name="cnt" id="cnt" value="${techsupView.CNT}"  style="width:30"  readonly="readonly"/>&nbsp;&nbsp;<br/> 
				</c:when>
				<c:otherwise>
				 	제품명:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${techsupView.PROD_NM}<br/> 
				 	버전:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${techsupView.VER}<br/>
				 	유형:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${techsupView.PROD_TYPE}<br/>
				 	COPY수:&nbsp;&nbsp;&nbsp;&nbsp;${techsupView.CNT}
				</c:otherwise>
			</c:choose> 
		</td>
	</tr>  
	<!-- 제품 일련번호  -->
		<input type="hidden" name="prod_no" id="prod_no" value="${techsupView.PROD_NO}"/>  
		<input type="hidden" name="seq" id="seq" value="1"/>  
	 
	<tr>
		<th scope="col" id="odd" style="width:20%">지원접수일</th>
		<td> 
			<c:choose>
				<c:when test="${pMap.actType == 'ins' || pMap.actType == 'mod'}">
					<input name="receipt_date" id="receipt_date" type="text" class="inputText date" value="${fn:substring(techsupView.APP_DATE,0,10)}" readonly="readonly"/>
    									<input type="image" src="/resource/images/admin/img/ic_calendar.gif" 
    									onclick="javascript:calPopup(this, 'mypopup', 0, 20, 'document.vForm.receipt_date', ''); return false;"  
    									align="middle" width="16" height="16" />
    									<%-- 
    									&nbsp;&nbsp;&nbsp;
    									<input type="text" name="receipt_date1" id="receipt_date1" value="" maxlength="2" style="width:30"/>:
    									<input type="text" name="receipt_date2" id="receipt_date2" value="" maxlength="2" style="width:30"/> 
    									--%>
				</c:when>
				<c:otherwise>
				 	 ${techsupView.APP_DATE}
				</c:otherwise>
			</c:choose> 
		</td>
	</tr>  
	<tr>
		<th scope="col" id="odd" style="width:20%">지원시작일</th>
		<td> 
			<c:choose>
				<c:when test="${pMap.actType == 'ins' || pMap.actType == 'mod'}">
					<input name="st_date" id="st_date" type="text" class="inputText date" value="${fn:substring(techsupView.ST_DATE,0,10)}" readonly="readonly"/>
    									<input type="image" src="/resource/images/admin/img/ic_calendar.gif" 
    									onclick="javascript:calPopup(this, 'mypopup', 0, 20, 'document.vForm.st_date', ''); return false;"  
    									align="middle" width="16" height="16" />
    									<%-- 
    									&nbsp;&nbsp;&nbsp;
    									<input type="text" name="st_date1" id="st_date1" value="" maxlength="2" style="width:30"/>:
    									<input type="text" name="st_date2" id="st_date2" value="" maxlength="2" style="width:30"/>
    									--%>  
				</c:when>
				<c:otherwise>
				 	 ${techsupView.ST_DATE}
				</c:otherwise>
			</c:choose> 
		</td>
	</tr>
	<tr>
		<th scope="col" id="odd" style="width:20%">지원종료일</th>
		<td> 
			<c:choose>
				<c:when test="${pMap.actType == 'ins' || pMap.actType == 'mod'}">
					<input name="end_date" id="end_date" type="text" class="inputText date" value="${fn:substring(techsupView.END_DATE,0,10)}" readonly="readonly"/>
    									<input type="image" src="/resource/images/admin/img/ic_calendar.gif" 
    									onclick="javascript:calPopup(this, 'mypopup', 0, 20, 'document.vForm.end_date', ''); return false;"  
    									align="middle" width="16" height="16" />
    									<%-- 
    									&nbsp;&nbsp;&nbsp;
    									<input type="text" name="end_date1" id="end_date1" value="" maxlength="2" style="width:30"/>:
    									<input type="text" name="end_date2" id="end_date2" value="" maxlength="2" style="width:30"/> 
    									--%> 
				</c:when>
				<c:otherwise>
				 	 ${techsupView.END_DATE}
				</c:otherwise>
			</c:choose> 
		</td>
	</tr> 
	<tr>
		<th scope="col" id="odd" style="width:20%">재방문일</th>
		<td> 
			<c:choose>
				<c:when test="${pMap.actType == 'ins' || pMap.actType == 'mod'}">
					<input name="revisit_exp_date" id="revisit_exp_date" type="text" class="inputText date" value="${fn:substring(techsupView.REVISIT_DATE,0,10)}"  readonly="readonly"/>
    									<input type="image" src="/resource/images/admin/img/ic_calendar.gif"
    									onclick="javascript:calPopup(this, 'mypopup', 0, 20, 'document.vForm.revisit_exp_date', ''); return false;"  
    									align="middle" width="16" height="16" /> 
    									<%-- 
    									&nbsp;&nbsp;&nbsp;
    									<input type="text" name="revisit_exp_date1" id="revisit_exp_date1" value="" maxlength="2" style="width:30"/>:
    									<input type="text" name="revisit_exp_date2" id="revisit_exp_date2" value="" maxlength="2" style="width:30"/>
    									--%> 
				</c:when>
				<c:otherwise>
				 	 ${techsupView.REVISIT_DATE}
				</c:otherwise>
			</c:choose> 
		</td>
	</tr> 
	<tr>
		<th scope="col" id="odd" style="width:20%">방문위치</th>
		<td> 
			<c:choose>
				<c:when test="${pMap.actType == 'ins' || pMap.actType == 'mod'}">
					<input type="text" name="loc" id="loc" value="${techsupView.LOC}"   style="width:500" />&nbsp;&nbsp;
				</c:when>
				<c:otherwise>
				 	 ${techsupView.LOC}
				</c:otherwise>
			</c:choose> 
		</td>
	</tr> 
	<tr>
		<th scope="col" id="odd" style="width:20%">지원종류</th>
		<td>   
			<c:choose>
				<c:when test="${pMap.actType == 'ins' || pMap.actType == 'mod'}">
				 
					<select class="validate-required-select" name="tech_sup_type_code" id="tech_sup_type_code" title="지원종류 " >
						<option value="">선택</option>
						<c:forEach items="${tech_sup_type_code}" var="tran_type" varStatus="i">
						<option <c:if test="${tran_type.CODE == techsupView.TECH_SUP_TYPE_CODE}"> selected</c:if> value="${tran_type.CODE}">
							${tran_type.CODE_NM}
						</option>
						</c:forEach>
					</select>  
					
				</c:when>
				<c:otherwise>
				 	 ${techsupView.SUP_KIND}
				</c:otherwise>
			</c:choose> 
			 
		</td>
	</tr> 
	<tr>
		<th scope="col" id="odd" style="width:20%">요청사항</th>
		<td>   
			<c:choose>
				<c:when test="${pMap.actType == 'ins' || pMap.actType == 'mod'}">
					<textarea name="customer_demand" id="customer_demand" style="width:500;height:80">${techsupView.CUSTOMER_DEMAND}</textarea> 
				</c:when>
				<c:otherwise>
				 	 ${techsupView.CUSTOMER_DEMAND}
				</c:otherwise>
			</c:choose> 
		</td>
	</tr> 
	<tr>
		<th scope="col" id="odd" style="width:20%">지원내역</th>
		<td>   
			<c:choose>
				<c:when test="${pMap.actType == 'ins' || pMap.actType == 'mod'}">
					<textarea name="customer_sup_contents" id="customer_sup_contents" style="width:500;height:80">${techsupView.CUSTOMER_SUP_CONTENTS}</textarea>
				</c:when>
				<c:otherwise>
				 	 ${techsupView.CUSTOMER_SUP_CONTENTS}
				</c:otherwise>
			</c:choose> 
		</td>
	</tr> 
	<tr>
		<th scope="col" id="odd" style="width:20%">지원소요시간</th>
		<td>   
			<c:choose>
				<c:when test="${pMap.actType == 'ins' || pMap.actType == 'mod'}">
					<input name="tech_sup_nec_time" id="tech_sup_nec_time" type="text" class="inputText date" value="${techsupView.TECH_SUP_NEC_TIME}" style="width:50"/> 
				</c:when>
				<c:otherwise>
				 	 ${techsupView.DUET}
				</c:otherwise>
			</c:choose> 
		</td>
	</tr> 
	<tr>
		<th scope="col" id="odd" style="width:20%">지원형태</th>
		<td>   
			<c:choose>
				<c:when test="${pMap.actType == 'ins' || pMap.actType == 'mod'}">
				 
					<input  class="validate-one-required" type="radio" name="pay_yn" id="pay_y" value="Y"  <c:if test="${techsupView.PAY_YN == 'Y'}"> checked="checked" </c:if>   />
					<label for="tran_type1">유상</label> &nbsp;&nbsp;
					
					<input  class="validate-one-required" type="radio" name="pay_yn" id="pay_n" value="N"  <c:if test="${techsupView.PAY_YN == 'N'}"> checked="checked" </c:if>   />
					<label for="tran_type2">무상</label> &nbsp;&nbsp;
					
					<input  class="validate-one-required" type="radio" name="pay_yn" id="pay_a" value="A"  checked="checked" <c:if test="${techsupView.PAY_YN == 'A'}"> checked="checked" </c:if>   />
					<label for="tran_type2">기타</label> &nbsp;&nbsp; 
					
				</c:when>
				<c:otherwise>
					<c:choose>
						<c:when test="${techsupView.PAY_NM != 'A'}"> ${techsupView.PAY_NM}</c:when>
						<c:otherwise>기타</c:otherwise>
					</c:choose> 
				</c:otherwise>
			</c:choose>  
			
		</td>
	</tr> 
	<tr>
		<th scope="col" id="odd" style="width:20%">비고</th>
		<td>   
			<c:choose>
				<c:when test="${pMap.actType == 'ins' || pMap.actType == 'mod'}">
					<textarea name="tran_result" id="tran_result" style="width:500;height:80">${techsupView.TRAN_RESULT}</textarea> 
				</c:when>
				<c:otherwise>
				 	  ${techsupView.TRAN_RESULT}
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
				 	<input type="button" class="button02" value="수정" onclick="javascript:jf_techsupModForm()">
				</c:otherwise> 
			</c:choose>   
		</c:if>
		<input type="button" class="button02" value="목록" onclick="javascript:jf_techsupList()">
	</div>
</div>
			
</form>
<div id="mypopup" style="position: absolute; visibility: hidden; z-index: 0; background-color: #99BDDF;"></div>