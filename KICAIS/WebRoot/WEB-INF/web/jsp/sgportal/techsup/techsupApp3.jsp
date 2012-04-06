<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%> 
<%@ include file="/WEB-INF/web/jsp/common/inc/commonInc.jsp" %>
<script type="text/javascript" src="/resource/common/js/jquery.sg.js"></script>
<link href="/resource/common/css/common.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="/resource/common/js/mini.js" ></script>
<script type="text/javascript" src="/resource/common/js/validator.js" ></script> 

<SCRIPT LANGUAGE="JavaScript">
<!--



//-->
</SCRIPT>
<c:set var="groups" value="${fn:split(sessionMap.GROUPS, ',')}" />



<form name='vForm' method='post'>
<input type="hidden" name="actType" id="actType" />
<input type="hidden" name="corp_no" id="corp_no" />



<c:if test="${fn:length(deal) == 0}">
	<b style="color:red">
		&nbsp;계약 정보가 없습니다.
		&nbsp;  
		<input type="button" class="buttonsmall04" value="계약등록"  onclick="javascript:window.open('/sgportal/techsup/techsupPjtList.sg?corp_no=${techsupApp.CL_CORP_NO}&pjt_no=${pMap.pjt_no}', '','' )" />  
	</b>
</c:if>

<c:if test="${fn:length(deal) > 0}">
														
	<table width="100%" border="0" cellpadding="0" cellspacing="0" class="grid" rules="cols">
	 
	<tr>
		<th scope="col" id="odd" style="width:15%">계약구분</th>
		<td>  
			${deal.CONT_TYPE_CODE_NM}
			
		</td>
		<th scope="col" id="odd" style="width:15%">프로젝트</th>
		<td> 
			<c:choose>
				<c:when test="${pMap.actType == 'ins' || pMap.actType == 'mod'}">
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
		<th scope="col" id="odd" style="width:15%">SG담당자</th>
		<td> 
			<c:choose>
				<c:when test="${pMap.actType == 'ins' || pMap.actType == 'mod'}"> 
					<input type="text" name="chman_nm_sg" id="chman_nm_sg" value="${deal.SG}"   style="width:200" />&nbsp;&nbsp;
					<input type="button" class="buttonsmall05" value="담당자검색" onclick="javascript:jf_srcChman('COR1011022247591', 'SG')" /> 
				</c:when>
				<c:otherwise>
				 	 ${deal.SG}
				</c:otherwise>
			</c:choose> 
			<input type="hidden" name="chman_no_sg" id="chman_no_sg" value="${deal.SG_NO}" />
			<input type="hidden" name="chman_sect_code_sg" id="chman_sect_code_sg" value="1" />
		</td>
		<th scope="col" id="odd" style="width:15%">고객담당자</th>
		<td> 
			<c:choose>
				<c:when test="${pMap.actType == 'ins' || pMap.actType == 'mod'}"> 
					<input type="text" name="chman_nm_cu" id="chman_nm_cu" value="${deal.CU}"  style="width:200" />&nbsp;&nbsp;
					<input type="button" class="buttonsmall05" value="담당자검색" onclick="javascript:jf_srcChman('${deal.CORP_NO}', 'CU')" /> 
				</c:when>
				<c:otherwise>
				 	 ${deal.CU}
				</c:otherwise>
			</c:choose> 
			<input type="hidden" name="chman_no_cu" id="chman_no_cu" value="${deal.CU_NO}"/>
			<input type="hidden" name="chman_sect_code_cu" id="chman_sect_code_cu" value="2"/>
		</td>
	</tr>  
	<tr>
		<th scope="col" id="odd" style="width:15%">제품명</th>
		<td colspan="3"> 
			<c:choose>
				<c:when test="${pMap.actType == 'ins' || pMap.actType == 'mod'}">
					제품명:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" name="prod_nm" id="prod_nm" value="${deal.PROD_NM}"  style="width:200"/>&nbsp;&nbsp;
					<input type="button" class="buttonsmall05" value="제품검색" onclick="javascript:jf_srcProd(' ${deal.CORP_NO}', 'CU')" /> 
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
		<th scope="col" id="odd" style="width:15%">제품수량</th>
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
		<th scope="col" id="odd" style="width:15%">계약일</th>
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
		<th scope="col" id="odd" style="width:15%">유지보수기간</th>
		<td> 
			<c:choose>
				<c:when test="${pMap.actType == 'ins' || pMap.actType == 'mod'}">
	    		    시작일:&nbsp;&nbsp;<input name="st_date" id="st_date" type="text" class="inputText date" value="${deal.ST_DATE}" readonly="readonly"/>
						<input type="image" src="/resource/images/admin/img/ic_calendar.gif" 
						onclick="javascript:calPopup(this, 'mypopup', 0, 20, 'document.vForm.st_date', ''); return false;"  
						align="middle" width="16" height="16" /> 
						<br/>
				   종료일:&nbsp;&nbsp;<input name="end_date" id="end_date" type="text" class="inputText date" value="${deal.END_DATE}" readonly="readonly"/>
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
		<th scope="col" id="odd" style="width:15%">비고</th>
		<td colspan="3">   
			<c:choose>
				<c:when test="${pMap.actType == 'ins' || pMap.actType == 'mod'}">
					<textarea name="cont_contents" id="cont_contents" style="width:500;height:80">${deal.CONT_CONTENTS}</textarea> 
				</c:when>
				<c:otherwise>
					<textarea style="width:100%;height:90" name='cont_contents' readonly="readonly">${deal.CONT_CONTENTS}</textarea>
				</c:otherwise>
			</c:choose> 
		</td>
		 
	</tr>
	</table> 
</c:if>
	 
	
</form>

<div id="mypopup" style="position: absolute; visibility: hidden; z-index: 0; background-color: #99BDDF;"></div>
