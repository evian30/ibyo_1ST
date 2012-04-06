<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%> 
<%@ include file="/WEB-INF/web/jsp/common/inc/commonInc.jsp" %>
<script type="text/javascript" src="/resource/common/js/jquery.sg.js"></script>

<SCRIPT LANGUAGE="JavaScript">
<!--

function f_action(actType){
	if(Validator.validate(document.vForm)){
			document.vForm.actType.value = actType;
			document.vForm.action = "/sgportal/techsup/techsupAppAction.sg";
			document.vForm.submit();
	}
}

function jf_goRows(){
	document.vForm.action = "/sgportal/techsup/techsupAppList.sg?actType=list";
	document.vForm.submit();
}


function f_app_insView(){ 
	document.vForm.action = "/sgportal/techsup/techsupApp.sg?actType=ins";
	document.vForm.submit(); 
}

function f_app_view(value){
	document.vForm.action = '/sgportal/techsup/techsupApp.sg?actType=view&tech_sup_app_no=' + value;
	document.vForm.submit();  
}
 


function jf_search(){
	if(document.vForm.keyword.value == ""){
		//alert('검색어를 입력하세요');
		//document.vForm.keyword.focus();
		//return;
	}
	document.vForm.action = "/sgportal/techsup/techsupAppList.sg?actType=list";
	document.vForm.submit();
}


function goRefresh_app(){
	document.location.href= "/sgportal/techsup/techsupAppList.sg?actType=list"; 	
}
//-->
</SCRIPT>
 
<form name='vForm' method='post'>
<input type="hidden" name="sortKey" id="sortKey" value="${pMap.sortKey}" /> 
<input type="hidden" name="sort" id="sort" value="${pMap.sort}" />

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
			> 목록보기
		</div>
	</div>

  	
	<!--search시작-->
	<b class="rtop"><b class="r1"></b><b class="r2"></b><b class="r3"></b><b class="r4"></b></b> 
		<div class="search" style="height:0px"> 
			<table class="grid02" style="width:100%" align="center">
				<tr>
					<th style="width:16%" id="odd">기술지원 진행상태</th>
					<td style="padding-left:10px">
						<select name="status_nm" id="status_nm" title="진행상태" onchange="jf_search();" style="width:250px">
							<option value="">진행상태</option>
							<c:forEach items="${STATUS}" var="type" varStatus="i">
							<option value="${type.CODE_NM}" <c:if test="${type.CODE_NM == pMap.status_nm}"> selected="selected"</c:if>>
								code:(${type.CODE})&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${type.CODE_NM}
							</option>
							</c:forEach>
						</select>
					</td>
					<th style="width:16%" id="odd">고객사명</th>
					<td style="padding-left:10px">
						<input type='text' name='cl_corp_nm' value='${pMap.cl_corp_nm}' class="gray_txt" style="width:250px" title="고객사명" />  
					</td> 
				</tr>
				<tr>
					<th style="width:16%" id="odd">프로젝트명</th> 
					<td style="padding-left:10px">
						<input type='text' name='src_pjt_nm' value='${pMap.src_pjt_nm}' class="gray_txt" style="width:250px" title="프로젝트명" />  
					</td> 
					<th style="width:16%" id="odd">제품명</th> 
					<td style="padding-left:10px">
						<input type='text' name='src_prod_nm' value='${pMap.src_prod_nm}' class="gray_txt" style="width:250px" title="제품명" />  
					</td> 
				</tr>
				<tr>
					<th style="width:16%" id="odd">기술요청 제목</th> 
					<td style="padding-left:10px">
						<input type='text' name='src_title' value='${pMap.src_src_title}' class="gray_txt" style="width:250px" title="기술요청 제목" />  
					</td> 
					<th style="width:16%" id="odd">기술요청 내용</th> 
					<td style="padding-left:10px">
						<input type='text' name='src_contents' value='${pMap.src_contents}' class="gray_txt" style="width:250px" title="기술요청 내용" />  
					</td> 
				</tr>
			 <%-- <fmt:formatDate value="<%=new java.util.Date()%>" pattern="yyyy-MM-dd" /> --%>
				<tr>
					<th style="width:16%" id="odd">요청일</th> 
					<td style="padding-left:10px" colspan="3">
						<input title="요청일" onclick="calPopup(this, 'mypopup', 0, 20, 'document.vForm.src_app_s', ''); return false;" type="text"
						name="src_app_s" readonly="readonly"   style="width:100px" value="${pMap.src_app_s}" />
			          	<input type="image" src="/resource/images/admin/img/ic_calendar.gif"   readonly="readonly"
	         				onclick="calPopup(this, 'mypopup', 0, 20, 'document.vForm.src_app_s', ''); return false;"  align="middle" width="16" height="16" /> ~
	         			 
	         			<input title="요청일" onclick="calPopup(this, 'mypopup', 0, 20, 'document.vForm.src_app_e', ''); return false;" type="text"
						name="src_app_e" readonly="readonly"  style="width:100px" value="${pMap.src_app_e}" />
			          	<input type="image" src="/resource/images/admin/img/ic_calendar.gif"   readonly="readonly"
	         				onclick="calPopup(this, 'mypopup', 0, 20, 'document.vForm.src_app_e', ''); return false;"  align="middle" width="16" height="16" />
					</td> 
					 
				</tr>
				 			
				<tr>
					<th style="width:16%" id="odd">담당자</th> 
					<td colspan="3" style="padding-left:10px">
						<select name='key' class="gray_txt" style="width:100px">
							<option value='' <c:if test="${pMap.key == ''}">selected</c:if>>선택</option>	
							<option value='006' <c:if test="${pMap.key == '006'}">selected</c:if>>고객사</option>		
							<option value='001' <c:if test="${pMap.key == '001'}">selected</c:if>>SG담당자</option>
							<option value='002' <c:if test="${pMap.key == '002'}">selected</c:if>>고객담당자</option>
							<option value='003' <c:if test="${pMap.key == '003'}">selected</c:if>>제목</option>
							<option value='004' <c:if test="${pMap.key == '004'}">selected</c:if>>계약명</option>
							<option value='005' <c:if test="${pMap.key == '005'}">selected</c:if>>제품명</option>		
						</select>
				     	<input type='text' name='keyword' value='${pMap.keyword}' class="gray_txt" style="width:300px" alt="담당자" />  
						<input type="image" src="/resource/images/bass_1st/btn_search.gif" align="absmiddle" style="cursor:hand;pointer;" onclick="jf_search()" />  
						<input type="image" src="/resource/images/bass_1st/btn_refresh.gif" align="absmiddle"  onclick="goRefresh_app();"/>
					</td>  
				</tr>  
			</table>
				
		</div>
	<b class="rbottom"><b class="r4"></b><b class="r3"></b><b class="r2"></b><b class="r1"></b></b>
	<!--search끝-->
	
	
	
	<table width="100%" > 
		<tr bgcolor="#e0e0e0" >
			<td style="padding-left: 10px"> 
				<c:if test="${writeGrant != '0' }">
					 <input type="button" class="button06" value="기술지원 요청등록" onclick="f_app_insView()" style="cursor:hand;">
					&nbsp;&nbsp;&nbsp;
					 <span style="color:red">
					 * 기술지원 요청을 하려면 좌측의 버튼을 클릭해 주세요.  
					 </span>
				</c:if>  
			</td> 
		</tr>	
	</table> 
		
		
		 

	<h3 class="subtitle"> 기술지원 요청 목록</h3>
	
	<div class="btn">						
		<div class="leftbtn">
			<b style="">총 [${listCnt}] 건</b>
		</div>
		<div class="rightbtn">
			목록수 :
			<select name="pageSize" onChange="jf_goRows()"> 
				<option value='5' <c:if test="${pMap.pageSize == '5'}">selected</c:if>>5</option>
				<option value='10' <c:if test="${pMap.pageSize == '10'}">selected</c:if>>10</option>
				<option value='20' <c:if test="${pMap.pageSize == '20'}">selected</c:if>>20</option>
				<option value='50' <c:if test="${pMap.pageSize == '50'}">selected</c:if>>50</option>
				<option value='100' <c:if test="${pMap.pageSize == '100'}">selected</c:if>>100</option>
				<option value='200' <c:if test="${pMap.pageSize == '200'}">selected</c:if>>200</option>
				<option value='250' <c:if test="${pMap.pageSize == '250'}">selected</c:if>>250</option>
			</select>
		</div>
	</div>	 

<c:forEach items="${list}" var="data" varStatus="i">
	<table width="100%" border="0" cellpadding="0" cellspacing="0"  class="grid"> 		
		<tr>
			
			<td style="padding:5px;width:3%" rowspan="3"  id="odd">${pageNavi.startRowNo - i.index}</td>
			
			
			<td id="odd" style="width:7%">요청번호</td>
			<td  style="padding-left:5px;width:10%;" align="center">
				<a href="javascript:f_app_view('${data.TECH_SUP_APP_NO}')">
					<%--<b style="color:blue">${fn:substring(data.TECH_SUP_APP_NO, 0, 3)}-${fn:substring(data.TECH_SUP_APP_NO, 3, 13)}-${fn:substring(data.TECH_SUP_APP_NO, 13, 16)}</b>--%>
					<b style="color:gray">${data.TECH_SUP_APP_NO}</b>
				</a> 
			</td>
			
			<td id="odd">기술지원 요청 정보</td> 
			
			<td  id="odd" style="padding-left:5px;width:8%">프로젝트명</td>
			<td style="padding-left:5px;width:12%">${data.PJT_NAME}</td>
			
			<td  id="odd">고객사</td>
			<td>${data.CL_CORP_NM}(${data.PJT_CHMAN_NM})</td>			
			
			<td  id="odd" style="padding-left:5px;width:7%">요청등록</td>
			<td style="padding-left:5px;width:10%">${data.CR_DATE}</td>
		</tr>
		 
		<tr>
			<td  id="odd">진행상태</td>
			<td align="center"><b style="color:red">${data.TECH_SUP_STATUS_CODE_NM}</b></td>
			
			<td>  
				[제목]: 
				<a href="javascript:f_app_view('${data.TECH_SUP_APP_NO}')"> 
					${fn:substring(data.APP_TITLE, 0, 30)} 
				</a> 
			</td>
			
			<td  id="odd">제품</td>
			<td align="center">
				<c:choose>
					<c:when test="${data.PROD_NM != ' ()'}">
						${data.PROD_NM}
					</c:when>
					<c:otherwise>-</c:otherwise>
				</c:choose> 
			</td>
			
			<td  id="odd" style="padding-left:5px;width:7%">고객담당</td>
			<td align="center" style="padding-left:5px;width:10%">
				<c:choose>
					<c:when test="${!empty data.APP_NM}">
						${data.APP_NM}
					</c:when>
					<c:otherwise>-</c:otherwise>
				</c:choose>  
			</td>			
			
			<td rowspan="2"  id="odd">지원예정기간</td>
			<td rowspan="2">
				<c:if test="${data.ABOUT_DATE1 != '--'}"> ${data.ABOUT_DATE1}</c:if>
				<c:if test="${data.ABOUT_DATE2 != '--'}"><br/>~ ${data.ABOUT_DATE2}</c:if>
			</td>
		</tr>
		<tr>
			<td  id="odd">지원이력 횟수</td>
			<td align="center">${data.TECH_SUP_APP_CNT}</td>
			
			<td> 
				<a href="javascript:f_app_view('${data.TECH_SUP_APP_NO}')"> 
					[내용]: 
					${fn:substring(data.CONTENTS, 0, 28)}<c:if test="${fn:length(data.CONTENTS) > 28}">...</c:if>
				</a> 
			</td>
			 
			<td  id="odd">요청작성</td>
			<td align="center">${data.CHMAN_NM}</td>
			
			<td  id="odd">지원담당</td>
			<td align="center">
				<c:choose>
					<c:when test="${!empty data.TECH_SUP_APP_NM1}">
						${data.TECH_SUP_APP_NM1}
					</c:when>
					<c:otherwise>-</c:otherwise>
				</c:choose>  
			</td>
		</tr>
	</table>		
</c:forEach> 
	<div class="paging">
		${pageNavi.pageNavigator}
	</div> 
</form>

<div class="btn">						
	<div class="leftbtn">
		<!-- 권한 에 따른 쓰기기능 제어 시작  -->		
		<c:if test="${writeGrant != '0' }">
			 
		</c:if>
	</div>
	<div class="rightbtn">
		<!-- 권한 에 따른 쓰기기능 제어 시작  -->		
		<c:if test="${writeGrant != '0' }"> 
			<input type="button" class="button06" value="기술지원 요청" onclick="f_app_insView()" style="cursor:hand;">  
		</c:if>
		<!-- 권한 에 따른 쓰기기능 제어 시작  -->
	</div>
</div>	
 

<br/><br/>

<div id="mypopup" style="position: absolute; visibility: hidden; z-index: 0; background-color: #99BDDF;"></div> 