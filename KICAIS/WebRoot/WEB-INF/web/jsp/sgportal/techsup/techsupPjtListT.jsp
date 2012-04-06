<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/web/jsp/common/inc/commonInc.jsp" %>
<SCRIPT LANGUAGE="JavaScript">
<!--

function jf_techsupList(){ 
	document.vForm.action = "/sgportal/techsup/pjtList.sg";
	document.vForm.submit();
}
   
function jf_regtechsup(){  
	document.vForm.actType.value="ins"; 
	document.vForm.action = "/sgportal/techsup/techsupView.sg";
	document.vForm.submit(); 
}

function goSupView(tech_sup_no, pjt_no){  
	document.vForm.actType.value="view"; 
	document.vForm.tech_sup_no.value=tech_sup_no;
	document.vForm.pjt_no.value=pjt_no; 
	document.vForm.action = "/sgportal/techsup/techsupView.sg";
	document.vForm.submit(); 
} 

function jf_pjtView(){
	var pjt_no = '${pMap.pjt_no}';
	var corp_no = '${pMap.corp_no}';
	var param = "actType=view&corp_no=" + corp_no + "&pjt_no=" + pjt_no;
	var url = "/sgportal/techsup/pjtView.sg?" + param;
	window.open(url, "", "width=620, height=648, left=250, top=50, scrollbars=yes, resizable=no, menubar=no");
}

function jf_pjt_modify(){
	var pjt_no = '${pMap.pjt_no}';
	var corp_no = '${pMap.corp_no}';
	var param = "actType=mod&corp_no=" + corp_no + "&pjt_no=" + pjt_no;
	var url = "/sgportal/techsup/pjtView.sg?" + param;
	window.open(url, "", "width=620, height=648, left=250, top=50, scrollbars=yes, resizable=no, menubar=no");
}

function jf_techsupPjtList(){
	document.vForm.actType.value = 'view';
	document.vForm.action = "/sgportal/techsup/techsupPjtList.sg";
	document.vForm.submit();
 }


 function jf_pjtProdIns(){
	document.vForm.actType.value = 'ins';
	document.vForm.action = "/sgportal/techsup/techsupPjtSupView.sg";
	document.vForm.submit();

 }

 function jf_pjtProdView(prod_no, pjt_no, prod_seq){
	document.vForm.prod_no.value = prod_no;
	document.vForm.pjt_no.value = pjt_no;
	document.vForm.prod_seq.value = prod_seq;
	document.vForm.actType.value = 'view';
	document.vForm.action = "/sgportal/techsup/techsupPjtSupView.sg";
	document.vForm.submit();
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
		document.vForm.action = "/sgportal/techsup/techsupPjtList.sg";
		document.vForm.submit(); 
	}  

 function jf_dealPjtView(cont_no){
		document.vForm.actType.value = 'view'; 
		document.vForm.cont_no.value = cont_no;
		document.vForm.no.value = cont_no;
		document.vForm.action = "/sgportal/techsup/dealPjtView.sg";
		document.vForm.submit(); 
}


 function jf_delaPjtForm(){  
		document.vForm.actType.value="ins"; 
		if(Validator.validate(document.vForm)){
			document.vForm.action = "/sgportal/techsup/dealPjtView.sg";
			document.vForm.submit();
		}
	}
	 
	
//-->
</SCRIPT>
<c:set var="groups" value="${fn:split(sessionMap.GROUPS, ',')}" />
	
<form name='vForm' method='post'>   
	<input type="hidden" name="sort" id="sort" value="${pMap.sort}" />
	<input type="hidden" name="sortKey" id="sortKey" value="${pMap.sortKey}" /> 
	<input type="hidden" name="actType" id="actType" />
	
	
<c:choose>
	<c:when test="${pMap.actType == 'ins'}">
		<input type="hidden" name="pjt_no" id="pjt_no"  value="${pMap.pjt_no}"/>
	</c:when>
	<c:when test="${pMap.actType == 'mod'}">
		<input type="hidden" name="pjt_no" id="pjt_no"  value="${techsup.PJT_NO}"/>
	</c:when>
	<c:otherwise>
		<input type="hidden" name="pjt_no" id="pjt_no"  value="${techsup.PJT_NO}"/>
	</c:otherwise>
</c:choose>

	<input type="hidden" name="pjt_nm" id="pjt_nm"  value="${techsup.PJT_NAME}"/>
	<input type="hidden" name="prod_no" id="prod_no" value="${pMap.prod_no}"/> 
	<input type="hidden" name="prod_seq" id="prod_seq" value="${pMap.prod_seq}"/> 
	<input type="hidden" name="corp_no" id="corp_no" value="${pMap.corp_no}" />
	<input type="hidden" name="tech_sup_no" id="tech_sup_no" value="${pMap.tech_sup_no}"/> 
 
  	<input type="hidden" name="cont_no" id="cont_no" value="${pMap.cont_no}"/>
 	<input type="hidden" name="need_corp_no" id="need_corp_no" value="${pMap.need_corp_no}"/> 
 	<input type="hidden" name="no" id="no" value="${pMap.cont_no}"/> 

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
			> 고객정보
		</div>
	</div>

 	
				
<!-- 본문 내용 Strar -->
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
					
<div class="btn">						
	<div class="leftbtn">
		<input type="button" class="button02" value="목록" onclick="jf_techsupList();" style="cursor:hand;">
	</div>
	<div class="rightbtn">
		<c:forEach items="${groups}" var="group" varStatus="i">
			<c:if test="${group == 'G001'}">
				<input type="button" class="button06" value="프로젝트 수정" onclick="jf_pjt_modify()" style="cursor:hand;">
			</c:if>
		</c:forEach>
		<c:if test="${techsup.CHMAN_NO == sessionMap.SABUN}">
			<input type="button" class="button06" value="프로젝트 수정" onclick="jf_pjt_modify()" style="cursor:hand;">
		</c:if>
		
	</div>
</div>	
				
<h3 class="subtitle"> 환경 정보</h3>
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="grid" rules="cols">
	<tr>
		<th scope="col" id="odd" onclick="javascript:goSort('SETUP_SV_HOSTNAME')" style="cursor:hand;">
			<c:if test="${pMap.sort == '1'}">
				<c:if test="${pMap.sortKey == 'SETUP_SV_HOSTNAME'}">
					▲ 
				</c:if>
			</c:if>
			<c:if test="${pMap.sort == '2'}">
				<c:if test="${pMap.sortKey == 'SETUP_SV_HOSTNAME'}">
					▼ 
				</c:if>
			</c:if>
		서버명</td>
		<th scope="col" id="odd" onclick="javascript:goSort('SETUP_SV_IP')" style="cursor:hand;">
			<c:if test="${pMap.sort == '1'}">
				<c:if test="${pMap.sortKey == 'SETUP_SV_IP'}">
					▲ 
				</c:if>
			</c:if>
			<c:if test="${pMap.sort == '2'}">
				<c:if test="${pMap.sortKey == 'SETUP_SV_IP'}">
					▼ 
				</c:if>
			</c:if>
		IP주소</td>
		<th scope="col" id="odd" onclick="javascript:goSort('OS')" style="cursor:hand;">
			<c:if test="${pMap.sort == '1'}">
				<c:if test="${pMap.sortKey == 'OS'}">
					▲ 
				</c:if>
			</c:if>
			<c:if test="${pMap.sort == '2'}">
				<c:if test="${pMap.sortKey == 'OS'}">
					▼ 
				</c:if>
			</c:if>
		OS</td> 
		<th scope="col" id="odd" onclick="javascript:goSort('SDK')" style="cursor:hand;">
			<c:if test="${pMap.sort == '1'}">
				<c:if test="${pMap.sortKey == 'SDK'}">
					▲ 
				</c:if>
			</c:if>
			<c:if test="${pMap.sort == '2'}">
				<c:if test="${pMap.sortKey == 'SDK'}">
					▼ 
				</c:if>
			</c:if>
		SDK</td>
		<th scope="col" id="odd" onclick="javascript:goSort('WEB')" style="cursor:hand;">
			<c:if test="${pMap.sort == '1'}">
				<c:if test="${pMap.sortKey == 'WEB'}">
					▲ 
				</c:if>
			</c:if>
			<c:if test="${pMap.sort == '2'}">
				<c:if test="${pMap.sortKey == 'WEB'}">
					▼ 
				</c:if>
			</c:if>
		WEB</td>
		<th scope="col" id="odd" onclick="javascript:goSort('WAS')" style="cursor:hand;">
			<c:if test="${pMap.sort == '1'}">
				<c:if test="${pMap.sortKey == 'WAS'}">
					▲ 
				</c:if>
			</c:if>
			<c:if test="${pMap.sort == '2'}">
				<c:if test="${pMap.sortKey == 'WAS'}">
					▼ 
				</c:if>
			</c:if>
		WAS</td>
		<th scope="col" id="odd" onclick="javascript:goSort('INS_TYPE')" style="cursor:hand;">
			<c:if test="${pMap.sort == '1'}">
				<c:if test="${pMap.sortKey == 'INS_TYPE'}">
					▲ 
				</c:if>
			</c:if>
			<c:if test="${pMap.sort == '2'}">
				<c:if test="${pMap.sortKey == 'INS_TYPE'}">
					▼ 
				</c:if>
			</c:if>
		설치구분</td>
	</tr> 
	<!-- 본문 시작 -->	
		<c:forEach items="${prodList}" var="pjtProd" varStatus="i">
		<tr align="center">
			<!-- <td>${pageNavi.startRowNo - i.index}</td> -->
			<td align="left">
				&nbsp;&nbsp;
				<a href="javascript:jf_pjtProdView('${pjtProd.PROD_NO}', '${pMap.pjt_no}','${pjtProd.PROD_SEQ}')">
					${pjtProd.SETUP_SV_HOSTNAME}
				</a>
			</td>
			<td>${pjtProd.SETUP_SV_IP}</td>
			<td>${pjtProd.OS}</td>
			<td>${pjtProd.SDK}</td>		
			<td>${pjtProd.WEB}</td>	
			<td>${pjtProd.WAS}</td>
			<td>${pjtProd.INS_TYPE}</td>
		</tr>
		</c:forEach>
</table>
				
<div class="btn">						
	<div class="leftbtn">
		
	</div>
	<div class="rightbtn">
		<!-- 권한 에 따른 쓰기기능 제어 시작  -->		
		<c:if test="${writeGrant != '0' }">
			<input type="button" class="button06" value="고객환경 추가" onclick="jf_pjtProdIns()" style="cursor:hand;">
		</c:if>
	</div>
</div>				
	


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
					 
				 

			
	<div class="btn">						
		<div class="leftbtn">
			<!-- 
			<input type="button" class="button02" value="목록" onclick="javascript:jf_dealPjtList()" style="cursor:hand;">
			<input type="button" class="button05" value="고객사추가" onclick="javascript:jf_regChmanCom()" style="cursor:hand;">
			 -->
		</div>
		<div class="rightbtn">
			<!-- 권한 에 따른 쓰기기능 제어 시작  -->		
			<c:if test="${writeGrant != '0' }"> 
				<input type="button" class="button04" value="계약추가" onclick="jf_delaPjtForm();" style="cursor:hand;">  
			</c:if>
			<!-- 권한 에 따른 쓰기기능 제어 시작  -->
		</div>
	</div>		

	

<%-- 				
<h3 class="subtitle"> 지원 정보</h3>
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="grid" rules="cols">
	<tr>
		<th scope="col" id="odd">지원번호</td>
		<th scope="col" id="odd">처리결과</td>
		<th scope="col" id="odd">구분</td> 
		<th scope="col" id="odd">처리유형</td>
		<th scope="col" id="odd">고객담당자</td>
		<th scope="col" id="odd">SG담당자</td>
		<th scope="col" id="odd">접수일</td>
	</tr> 

<!-- 본문 시작 -->
<c:forEach items="${supList}" var="data" varStatus="i"> 
	<tr align="center">
		<td><a href="javascript:goSupView('${data.TECH_SUP_NO}','${data.PJT_NO}');">${pageNavi.startRowNo - i.index}</a></td> 
		<td><a href="javascript:goSupView('${data.TECH_SUP_NO}','${data.PJT_NO}');">${data.SUP_RESULT}</a></td>
		<td><a href="javascript:goSupView('${data.TECH_SUP_NO}','${data.PJT_NO}');">${data.SUP_TYPE}</a></td> 
		<td><a href="javascript:goSupView('${data.TECH_SUP_NO}','${data.PJT_NO}');">${data.SUP_METHOD}</a></td> 
		<td>${data.SG}</td>
		<td>${data.CU}</td>
		<td>${data.SUP_DATE}</td>
	</tr>
</c:forEach>
</table>
	
<div class="paging">
	${pageNavi.pageNavigator}
</div>
	
<div class="btn">						
	<div class="leftbtn">
		<!-- 권한 에 따른 쓰기기능 제어 시작  -->		
		<c:if test="${writeGrant != '0' }">
			<input type="button" class="button02" value="목록" onclick="jf_techsupList();" style="cursor:hand;">&nbsp;&nbsp;
			<input type="button" class="button06" value="프로젝트 수정" onclick="jf_pjt_modify()" style="cursor:hand;">&nbsp;&nbsp;
		</c:if>
	</div>
	<div class="rightbtn">
		<c:if test="${writeGrant != '0' }"> 
			<input type="button" class="button06" value="지원이력추가" onclick="jf_regtechsup()" style="cursor:hand;">
		</c:if>
	</div>
</div>				
--%>						
</form>

<div id="mypopup" style="position: absolute; visibility: hidden; z-index: 0; background-color: #99BDDF;"></div>