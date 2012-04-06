<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%> 
<%@ include file="/WEB-INF/web/jsp/common/inc/commonInc.jsp" %>
<script type="text/javascript" src="/resource/common/js/jquery.sg.js"></script>
<link href="/resource/common/css/common.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="/resource/common/js/mini.js" ></script>
<script type="text/javascript" src="/resource/common/js/validator.js" ></script> 
<script src="/resource/common/js/MultiUpload.js"></script>

<SCRIPT LANGUAGE="JavaScript">
<!--


 

function jf_techsupModForm(){  
	
	if(Validator.validate(document.vForm)){
		document.vForm.actType.value="mod"; 
		document.vForm.tech_sup_status_code.value = "6";
		document.vForm.st_date.value = document.vForm.st_date.value.split("-").join("");
		document.vForm.end_date.value = document.vForm.end_date.value.split("-").join("");
		document.vForm.action = "/sgportal/techsup/techsupAction.sg?viewName=/sgportal/techsup/techsupApp6&multipartYn=Y";
		document.vForm.submit();
	}
}

function jf_techsupInsForm(){  
	if(Validator.validate(document.vForm)){
		document.vForm.actType.value="ins"; 
		document.vForm.tech_sup_status_code.value = "6";
		document.vForm.st_date.value = document.vForm.st_date.value.split("-").join("");
		document.vForm.end_date.value = document.vForm.end_date.value.split("-").join("");
		var listCount = parent.document.vForm.listCount.value;
		
		document.vForm.action = "/sgportal/techsup/techsupAction.sg?listCount=" + listCount +"&multipartYn=Y";
		document.vForm.submit();
	}
}


function techsupModify(){  
	window.location.href = '/sgportal/techsup/techsupView.sg?actType=mod&tech_sup_no=' 
		+ '${pMap.tech_sup_no}' 
		+ '&tech_sup_app_no=' + '${pMap.tech_sup_app_no}' + '&multipartYn=Y';
	
}



//-->
</SCRIPT>
  
<br/>  
<form name='vForm02' method='post'> 
	<input type="hidden" name="actType" id="actType" /> 
	<input type="hidden" name="tech_sup_no" id="tech_sup_no" value="${pMap.tech_sup_no}" />
	<input type="hidden" name="tech_sup_app_no" id="tech_sup_app_no" value="${pMap.tech_sup_app_no}" /> 
</form>

<form name='vForm' method='post' enctype="multipart/form-data"> 
<input type="hidden" name="actType" id="actType" />
<input type="hidden" name="corp_no" id="corp_no" />
<input type="hidden" name="tech_sup_status_code" id=tech_sup_status_code />
<input type="hidden" name="tech_sup_no" id="tech_sup_no" value="${pMap.tech_sup_no}" />
<input type="hidden" name="tech_sup_app_no" id="tech_sup_app_no" value="${pMap.tech_sup_app_no}" />
<input type="hidden" name="reject_yn" id="reject_yn" value="N" />


	<div class="subtitle">
		기술지원이력 입력
	</div> 
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="grid" rules="cols">
	<c:if test="${pMap.actType != 'ins' && pMap.actType != 'mod'}"> 
	<tr>
		<th scope="col" id="odd">기술지원번호</th>
		<td colspan="3">  
			<c:choose>
				<c:when test="${pMap.actType == 'ins' || pMap.actType == 'mod'}"> 
					<input title="처리결과" type="text" value="${techsupView.TECH_SUP_NO}"  />&nbsp;&nbsp;
				</c:when>
				<c:otherwise>
				 	 ${techsupView.TECH_SUP_NO}
				</c:otherwise>
			</c:choose> 
		</td>
	</tr> 
	</c:if>
	
	<tr>
		<th scope="col" id="odd"  style="width:15%">* 기술지원일</th>
		<td  style="width:35%">  
			<c:choose>
				<c:when test="${pMap.actType == 'ins' || pMap.actType == 'mod'}"> 
					<input size="12" title="기술지원일" class="Input_w required inputTex" onclick="calPopup(this, 'mypopup', 0, 20, 'document.vForm.st_date', ''); return false;" type="text" value="${techsupView.ST_DATE}" name="st_date" readonly="readonly">
		          	<input type="image" src="/resource/images/admin/img/ic_calendar.gif"   readonly="readonly" value="${techsupApp.ST_DATE}"
         				onclick="calPopup(this, 'mypopup', 0, 20, 'document.vForm.st_date', ''); return false;"  align="middle" width="16" height="16" />
         			&nbsp;
         			-
         			&nbsp;
         			<input size="12" title="기술지원일" class="Input_w required inputTex" onclick="calPopup(this, 'mypopup', 0, 20, 'document.vForm.end_date', ''); return false;" type="text" value="${techsupView.END_DATE}" name="end_date" readonly="readonly">
		          	<input type="image" src="/resource/images/admin/img/ic_calendar.gif"   readonly="readonly" value="${techsupApp.END_DATE}"
         				onclick="calPopup(this, 'mypopup', 0, 20, 'document.vForm.end_date', ''); return false;"  align="middle" width="16" height="16" />
         			
         		
         		</c:when>
				<c:otherwise>
				 	 ${techsupView.ST_DATE} ~  ${techsupView.END_DATE}
				</c:otherwise>
			</c:choose> 
		</td>
		<th scope="col" id="odd"  style="width:15%">* 기술지원소요시간</th>
		<td style="width:35%">  
			<c:choose>
				<c:when test="${pMap.actType == 'ins' || pMap.actType == 'mod'}"> 
					<input class="Input_w required inputTex" title="기술지원소요시간" type="text" name="tech_sup_nec_time" id="tech_sup_nec_time" value="${techsupView.TECH_SUP_NEC_TIME}"  />&nbsp;&nbsp;
				</c:when>
				<c:otherwise>
				 	 ${techsupView.TECH_SUP_NEC_TIME}
				</c:otherwise>
			</c:choose> 
			시간
		</td>
	</tr> 
	<tr>
		<th scope="col" id="odd">기술지원방문지</th>
		<td>  
			<c:choose>
				<c:when test="${pMap.actType == 'ins' || pMap.actType == 'mod'}"> 
					<input class="Input_w required inputTex" title="기술지원방문지" type="text" name="loc" id="loc" value="${techsupView.LOC}"  />&nbsp;&nbsp;
				</c:when>
				<c:otherwise>
				 	 ${techsupView.LOC}
				</c:otherwise>
			</c:choose> 
		</td>
		<th scope="col" id="odd">방문지 연락처</th>
		<td>  
			<c:choose>
				<c:when test="${pMap.actType == 'ins' || pMap.actType == 'mod'}"> 
					<input class="Input_w required inputTex" title="기술지원 방문지연락처" type="text" name="tech_sup_phone" id="tech_sup_phone" value="${techsupView.TECH_SUP_PHONE}"  />&nbsp;&nbsp;
				</c:when>
				<c:otherwise>
				 	 ${techsupView.TECH_SUP_PHONE}
				</c:otherwise>
			</c:choose> 
		</td>
	</tr>
	<tr>
		<th scope="col" id="odd">* 기술지원 유형</th>
		<td colspan="3">  
			<c:choose>
				<c:when test="${pMap.actType == 'ins' || pMap.actType == 'mod'}">  
					<!--<input class="Input_w required inputTex" title="기술지원 유형" type="text" name="tech_sup_tran_type_code" id="tech_sup_tran_type_code" value="${techsupView.TECH_SUP_TRAN_TYPE_CODE}"  />&nbsp;&nbsp;-->
					<c:forEach items="${tech_sup_tran_type_code}" var="tran" varStatus="i">
						<input  class="validate-one-required" type="radio" name="tech_sup_tran_type_code" id="tran_result${tran.CODE}" value="${tran.CODE}"  <c:if test="${tran.CODE == techsupView.TECH_SUP_TRAN_TYPE_CODE}"> checked="checked" </c:if>  title="" class="required inputText"/>
						<label for="tran_result${tran.CODE}">${tran.CODE_NM}</label> &nbsp;&nbsp;
					</c:forEach> 
				</c:when>
				<c:otherwise>
				 	 ${techsupView.SUP_METHOD}
				</c:otherwise>
			</c:choose> 
		</td>
	</tr>
	<tr>	
		<th scope="col" id="odd">* 처리결과</th>
		<td colspan="3">  
			<c:choose>
				<c:when test="${pMap.actType == 'ins' || pMap.actType == 'mod'}"> 
					<c:forEach items="${tech_sup_result_code}" var="tran_type" varStatus="i">
						<input class="validate-one-required" type="radio" name="tech_sup_result_code" id="tran_type_result${tran_type.CODE}" value="${tran_type.CODE}"  <c:if test="${tran_type.CODE == techsupView.TECH_SUP_RESULT_CODE}"> checked="checked" </c:if>  title="" class="required inputText"/>
						<label for="tran_type_result${tran_type.CODE}">${tran_type.CODE_NM}</label> &nbsp;&nbsp;
					</c:forEach>  
				</c:when>
				<c:otherwise>
				 	 ${techsupView.SUP_RESULT}
				</c:otherwise>
			</c:choose> 
		</td>
	</tr>
	<tr>
		<th scope="col" id="odd">* 지원종류</th>
		<td>  
			<c:choose>
				<c:when test="${pMap.actType == 'ins' || pMap.actType == 'mod'}"> 
					<select class="validate-required-select" name="tech_sup_type_code" id="tech_sup_type_code" title="지원종류 "  style="width:170px">
						<option value="">선택</option>
						<c:forEach items="${tech_sup_type_code}" var="tran_type" varStatus="i">
						<option <c:if test="${tran_type.CODE == techsupView.TECH_SUP_TYPE_CODE}"> selected</c:if> value="${tran_type.CODE}">
							${tran_type.CODE_NM}
						</option>
						</c:forEach>
					</select>  
					
				</c:when>
				<c:otherwise>
				 	 ${techsupView.SUP_TYPE}
				</c:otherwise>
			</c:choose> 
		</td>
		<th scope="col" id="odd">기술지원 IP</th>
		<td>  
			<c:choose>
				<c:when test="${pMap.actType == 'ins' || pMap.actType == 'mod'}"> 
					<input title="기술지원 IP" type="text" name="tech_sup_ip_addr" id="tech_sup_ip_addr" value="${techsupView.TECH_SUP_IP_ADDR}"  />&nbsp;&nbsp;
				</c:when>
				<c:otherwise>
				 	 ${techsupView.TECH_SUP_IP_ADDR}
				</c:otherwise>
			</c:choose> 
		</td>
	</tr>
	<tr>
		<th scope="col" id="odd">* 고객요청내용</th>
		<td colspan="3">  
			<c:choose>
				<c:when test="${pMap.actType == 'ins' || pMap.actType == 'mod'}"> 
					<textarea title="고객요청 내용" id='customer_demand' name='customer_demand' style='border:1 solid; border-color:#D4D4D4; width:85%; height:70;'>${techsupView.CUSTOMER_DEMAND}</textarea>
				</c:when>
				<c:otherwise>
					<textarea title="고객요청 내용" id='customer_demand' name='customer_demand' style='border:1 solid; border-color:#D4D4D4; width:85%; height:70;' readonly="readonly">${techsupView.CUSTOMER_DEMAND}</textarea>
				</c:otherwise>
			</c:choose> 
		</td>
		 
	</tr>
	<tr>
		<th scope="col" id="odd">* 기술지원처리 내용</th>
		<td colspan="3">  
			<c:choose>
				<c:when test="${pMap.actType == 'ins' || pMap.actType == 'mod'}"> 
					<textarea title="기술지원처리 내용" id='customer_sup_contents' name='customer_sup_contents' style='border:1 solid; border-color:#D4D4D4; width:85%; height:70;'>${techsupView.CUSTOMER_SUP_CONTENTS}</textarea>
				</c:when>
				<c:otherwise>
				 	 <textarea title="기술지원처리 내용" id='customer_sup_contents' name='customer_sup_contents' style='border:1 solid; border-color:#D4D4D4; width:85%; height:70;' readonly="readonly">${techsupView.CUSTOMER_SUP_CONTENTS}</textarea>
				</c:otherwise>
			</c:choose> 
		</td>
		 
	</tr>
	<tr>
		<th scope="col" id="odd">* 유상/무상 여부</th>
		<td>  
			<c:choose>
				<c:when test="${pMap.actType == 'ins' || pMap.actType == 'mod'}">
				 	<input  class="validate-one-required" type="radio" name="pay_yn" id="pay_y" value="Y"  <c:if test="${techsupView.PAY_YN == 'Y'}"> checked="checked" </c:if>   />
					<label for="tran_type1">유상</label> &nbsp;&nbsp;
					
					<input  class="validate-one-required" type="radio" name="pay_yn" id="pay_n" value="N"  <c:if test="${techsupView.PAY_YN == 'N'}"> checked="checked" </c:if>   />
					<label for="tran_type2">무상</label> &nbsp;&nbsp;
					
					 <input  class="validate-one-required" type="radio" name="pay_yn" id="pay_n" value="A"  <c:if test="${techsupView.PAY_YN == 'A'}"> checked="checked" </c:if>   />
					<label for="tran_type2">기타</label> &nbsp;&nbsp;
				</c:when>
				<c:otherwise>
				 	 ${techsupView.PAY_YN_NM}
				</c:otherwise>
			</c:choose>  
		</td>
		<th scope="col" id="odd">유상 시 가격</th>
		<td>  
			<c:choose>
				<c:when test="${pMap.actType == 'ins' || pMap.actType == 'mod'}"> 
					<input title="유상 시 가격" type="text" name="payprice" id="payprice" value="${techsupView.PAYPRICE}"  />&nbsp;&nbsp;
				</c:when>
				<c:otherwise>
				 	 ${techsupView.PAYPRICE}
				</c:otherwise>
			</c:choose> 
		</td>
	</tr>
	<tr>
		<th scope="col" id="odd">재방문일</th>
		<td colspan="3">  
			<c:choose>
				<c:when test="${pMap.actType == 'ins' || pMap.actType == 'mod'}"> 
					<input onclick="calPopup(this, 'mypopup', -100, -200, 'document.vForm.revisit_exp_date', ''); return false;" type="text" value="${techsupView.REVISIT_EXP_DATE}" name="revisit_exp_date" readonly="readonly">
		          	<input type="image" src="/resource/images/admin/img/ic_calendar.gif"   readonly="readonly" value="${techsupView.REVISIT_EXP_DATE}"
         				onclick="calPopup(this, 'mypopup', -100, -200, 'document.vForm.revisit_exp_date', ''); return false;"  align="middle" width="16" height="16" />
         		</c:when>
				<c:otherwise>
				 	 ${techsupView.REVISIT_EXP_DATE}
				</c:otherwise>
			</c:choose> 
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
	
	
	
	
	<c:if test="${pMap.actType != 'ins' && pMap.actType != 'mod'}"> 
	<tr>
		<th scope="col" id="odd">작성자</th>
		<td colspan="3">  
			<c:choose>
				<c:when test="${empty techsupView.SG}">${ADMIN_SESSION.ADMIN_NM}</c:when>
				<c:otherwise>
					${techsupView.SG}
				</c:otherwise> 
			</c:choose>  
		</td> 
	</tr> 
	<tr>
		<th scope="col" id="odd">등록일</th>
		<td>  
			<c:choose>
				<c:when test="${pMap.actType == 'ins' || pMap.actType == 'mod'}"> 
					<input title="등록일" type="text" name="cr_date" id="cr_date" value="${techsupView.CR_DATE}"  />&nbsp;&nbsp;
				</c:when>
				<c:otherwise>
				 	 ${techsupView.CR_DATE}
				</c:otherwise>
			</c:choose> 
		</td>
		<th scope="col" id="odd">수정일</th>
		<td>  
			<c:choose>
				<c:when test="${pMap.actType == 'ins' || pMap.actType == 'mod'}"> 
					<input title="수정일" type="text" name="up_date" id="up_date" value="${techsupView.UP_DATE}" />&nbsp;&nbsp;
				</c:when>
				<c:otherwise>
				 	 ${techsupView.UP_DATE}
				</c:otherwise>
			</c:choose> 
		</td>
	</tr>
	</c:if>
</table> 


	
</form>

<div class="btn">						
	<div class="leftbtn">
		<!-- 권한 에 따른 쓰기기능 제어 시작  -->		
		<c:if test="${writeGrant != '0' }">
			 
		</c:if>
	</div>
	<div class="rightbtn">
		<c:if test="${pMap.actType == 'ins'}"> 
			<input type="button" class="button02" value="저장" onclick="jf_techsupInsForm()" style="cursor:hand;">  
		</c:if>
		<c:if test="${pMap.actType == 'mod' && sessionMap.SABUN == techsupView.CHMAN_NO}"> 
			<input type="button" class="button02" value="저장" onclick="jf_techsupModForm()" style="cursor:hand;">  
		</c:if>
		<c:if test="${pMap.actType == 'view' && sessionMap.SABUN == techsupView.CHMAN_NO }"> 
			<input type="button" class="button02" value="수정" onclick="techsupModify()" style="cursor:hand;">  
		</c:if>
		<input type="button" class="button02" value="닫기" onclick="javascript:window.close();" style="cursor:hand;">
	</div>
</div>

	<div style="width:100%">
	    <div id="D_APP6" style="display:none;"> 
	    	<iframe scrolling="no" width="100%" height="510" scrolling='auto' frameborder="0" id="IF_APP6" name="IF_APP6" style="margin-bottom: 8px;"></iframe>
	    </div>
	    <br class="clear" /> 
    </div>
<div id="mypopup" style="position: absolute; visibility: hidden; z-index: 0; background-color: #99BDDF;"></div>


<c:if test="${pMap.command == 'mod_status6'}">
	<script>
		alert('수정 하였습니다.');
		//opener.document.vForm.corp_no.value = '${pMap.corp_no}';
		document.vForm02.actType.value="view";
		document.vForm02.action = "/sgportal/techsup/techsupView.sg";
		document.vForm02.submit();

		</script>	
</c:if>


