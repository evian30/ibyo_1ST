<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/web/jsp/common/inc/commonInc.jsp" %>
<SCRIPT LANGUAGE="JavaScript">
<!--
 
function jf_dealPjtList(){   
		document.vForm.action = "/sgportal/techsup/dealPjtList.sg";
		document.vForm.submit(); 
}

function jf_dealPjtView(cont_no){  
		document.vForm.actType.value = 'view'; 
		document.vForm.cont_no.value = cont_no;
		document.vForm.no.value = cont_no;
		document.vForm.action = "/sgportal/techsup/dealPjtView.sg";
		document.vForm.submit(); 
}

function jf_regChmanCom(){  
	document.vForm.actType.value="ins"; 
	document.vForm.action = "/sgportal/chman/chmanComView.sg";
	document.vForm.submit();
}

function jf_delaPjtForm(){  
	document.vForm.actType.value="ins"; 
	if(Validator.validate(document.vForm)){
		document.vForm.action = "/sgportal/techsup/dealPjtView.sg";
		document.vForm.submit();
	}
}


function goSort(sortKey){
	if(document.vForm.sort.value == "") document.vForm.sort.value = "1";
	if(document.vForm.sortKey.value != sortKey || document.vForm.sort.value == "2"){
		document.vForm.sort.value = "1";
	}else{
		document.vForm.sort.value = "2";
	}
	document.vForm.sortKey.value = sortKey;
	
	document.vForm.actType.value="view";
	document.vForm.action = "/sgportal/techsup/dealPjtViewList.sg";
	document.vForm.submit(); 
}  
 

//-->
</SCRIPT> 
 	
<form name='vForm' method='post' > 
	<input type="hidden" name="sort" id="sort" value="${pMap.sort}" />
	<input type="hidden" name="sortKey" id="sortKey" value="${pMap.sortKey}" /> 
 	<input type="hidden" name="actType" id="actType" />  
 	<input type="hidden" name="pjt_no" id="pjt_no" value="${pMap.pjt_no}"/> 
 	<input type="hidden" name="corp_no" id="corp_no" value="${pMap.corp_no}"/> 
 	<input type="hidden" name="cont_no" id="cont_no" value="${pMap.cont_no}"/>
 	<input type="hidden" name="need_corp_no" id="need_corp_no" value="${pMap.need_corp_no}"/> 
 	<input type="hidden" name="no" id="no" value="${pMap.cont_no}"/> 
 	
<div id="title_line">
	<div id="title">지원관리</div>
	<div id="location">계약정보  > 
		<c:choose>
			<c:when test="${pMap.actType == 'view'}">조회</c:when>
			<c:when test="${pMap.actType == 'mod'}">수정</c:when>
			<c:when test="${pMap.actType == 'ins'}">등록</c:when> 
		</c:choose>  
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
	<br/><br/>
 
	
	
	<h3 class="subtitle">계약정보</h3>		 
	<!-- 권한 에 따른 쓰기기능 제어 시작  -->		
	<c:if test="${writeGrant != '0' }">        	       	
		<!--input type="button" value="삭제" onclick="javascript:jf_dealPjtDelete()" class="green_txt_b" style="width:80px;cursor:pointer;"-->
	</c:if>	
	<!-- 권한 에 따른 쓰기기능 제어 끝  -->															
	<table width="100%" border="0" cellpadding="0" cellspacing="0"  class="grid">
		<tr align="center">
		<!-- 권한 에 따른 쓰기기능 제어 시작  -->		
		<c:if test="${writeGrant != '0' }">
			<!-- th scope="col" id="odd" width='13%'>
				<input type='checkbox' name='allCheck' onclick="javascript:jf_AllCheck()">선택
			</td-->
		</c:if>
		<!-- 권한 에 따른 쓰기기능 제어 끝  -->	
			<th scope="col" id="odd" style="width:10%" style="cursor:hand;" onclick="javascript:goSort('CONT_NO')">
				<c:if test="${pMap.sort == '1'}">
					<c:if test="${pMap.sortKey == 'CONT_NO'}">
						▲ 
					</c:if>
				</c:if>
				<c:if test="${pMap.sort == '2'}">
					<c:if test="${pMap.sortKey == 'CONT_NO'}">
						▼ 
					</c:if>
				</c:if>
				계약번호
			</td>
			<th style="width:10%" scope="col" id="odd" style="cursor:hand;" onclick="javascript:goSort('SG')">
				<c:if test="${pMap.sort == '1'}">
					<c:if test="${pMap.sortKey == 'SG'}">
						▲ 
					</c:if>
				</c:if>
				<c:if test="${pMap.sort == '2'}">
					<c:if test="${pMap.sortKey == 'SG'}">
						▼ 
					</c:if>
				</c:if>
				SG담당자
			</td>
			<th style="width:10%" scope="col" id="odd" style="cursor:hand;" onclick="javascript:goSort('CU')">
				<c:if test="${pMap.sort == '1'}">
					<c:if test="${pMap.sortKey == 'CU'}">
						▲ 
					</c:if>
				</c:if>
				<c:if test="${pMap.sort == '2'}">
					<c:if test="${pMap.sortKey == 'CU'}">
						▼ 
					</c:if>
				</c:if>
				업체담당자
			</td>
			<th style="width:50%" scope="col" id="odd" style="cursor:hand;" onclick="javascript:goSort('PROD_NM')">
				<c:if test="${pMap.sort == '1'}">
					<c:if test="${pMap.sortKey == 'PROD_NM'}">
						▲ 
					</c:if>
				</c:if>
				<c:if test="${pMap.sort == '2'}">
					<c:if test="${pMap.sortKey == 'PROD_NM'}">
						▼ 
					</c:if>
				</c:if>
				계약제품
			</td> 
			<th style="width:10%" scope="col" id="odd" style="cursor:hand;" onclick="javascript:goSort('PROD_VER')">
				<c:if test="${pMap.sort == '1'}">
					<c:if test="${pMap.sortKey == 'PROD_VER'}">
						▲ 
					</c:if>
				</c:if>
				<c:if test="${pMap.sort == '2'}">
					<c:if test="${pMap.sortKey == 'PROD_VER'}">
						▼ 
					</c:if>
				</c:if>
				제품버전
			</td>
			<th style="width:10%" scope="col" id="odd" style="cursor:hand;" onclick="javascript:goSort('CONT_DATE')">
				<c:if test="${pMap.sort == '1'}">
					<c:if test="${pMap.sortKey == 'CONT_DATE'}">
						▲ 
					</c:if>
				</c:if>
				<c:if test="${pMap.sort == '2'}">
					<c:if test="${pMap.sortKey == 'CONT_DATE'}">
						▼ 
					</c:if>
				</c:if>
				계약일
			</td> 
		</tr>


	<!-- 본문 시작 -->	
	<c:forEach items="${dealList}" var="data" varStatus="i">
	    <tr height="20px">
	    <!-- 권한 에 따른 쓰기기능 제어 시작  -->		
			<c:if test="${writeGrant != '0' }">
	    	<!-- td align='center'><input type='checkbox' name='board_seq01' value='${board.BOARD_SEQ}'></td-->
	    	</c:if>
	    <!-- 권한 에 따른 쓰기기능 제어 끝  -->	
	    	<td align='center'>
	    		<!--${pageNavi.startRowNo - i.index}-->
	    		${data.CONT_NO}
	    	</td>  
	    	<td align='center'>${data.SG}</td>
	        <td align='center'>${data.CU}</td>
	        <td align='center'>
	        	<c:if test="${data.USE_YN == 'N'}">
			   		&nbsp;&nbsp;
					<STRIKE style="color: red;font-weight: bolder;">
	        			<a href="javascript:jf_dealPjtView('${data.CONT_NO}')">${data.PROD_NM}</a>
	        		</STRIKE>
	        	</c:if>
	        	<c:if test="${data.USE_YN != 'N'}">
			   		&nbsp;&nbsp;<a href="javascript:jf_dealPjtView('${data.CONT_NO}')">${data.PROD_NM}</a>
			   	</c:if>
	        </td>
	        <td align='center'>${data.PROD_VER}</td> 
	        <td align='center'>${data.CONT_DATE}</td> 
	    </tr>				 
	</c:forEach>
	<!-- 본문 끝 -->	
	</table>		
					 
				 
 

	<div class="paging">
		${pageNavi.pageNavigator}
	</div>
			
	<div class="btn">						
		<div class="leftbtn">
			<input type="button" class="button02" value="목록" onclick="javascript:jf_dealPjtList()" style="cursor:hand;">
			<input type="button" class="button05" value="고객사추가" onclick="javascript:jf_regChmanCom()" style="cursor:hand;">
		</div>
		<div class="rightbtn">
			<!-- 권한 에 따른 쓰기기능 제어 시작  -->		
			<c:if test="${writeGrant != '0' }"> 
				<input type="button" class="button04" value="계약추가" onclick="jf_delaPjtForm();" style="cursor:hand;">  
			</c:if>
			<!-- 권한 에 따른 쓰기기능 제어 시작  -->
		</div>
	</div>		
		
		
</form>

<div id="mypopup" style="position: absolute; visibility: hidden; z-index: 0; background-color: #99BDDF;"></div>