<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%> 
<%@ include file="/WEB-INF/web/jsp/common/inc/commonInc.jsp" %>
<script type="text/javascript" src="/resource/common/js/jquery.sg.js"></script>
<script type="text/javascript" src="/resource/common/js/mini.js" ></script>
<SCRIPT LANGUAGE="JavaScript">
<!--
function jf_view(c_tech_sup_app_no){ 
	document.vForm.actType.value = 'view';
	document.vForm.c_tech_sup_app_no.value = c_tech_sup_app_no;  
	document.vForm.action = "/sgportal/cass/techsup/cassTechsupApp.sg";
	document.vForm.submit();
 }
 

  
function f_app_insView(){ 
	document.vForm.actType.value = 'ins';
	document.vForm.action = "/sgportal/cass/techsup/cassTechsupApp.sg";
	document.vForm.submit(); 
} 


function jf_search(){ 
	document.vForm.actType.value = 'list';
	document.vForm.action = "/sgportal/cass/techsup/cassTechSupAppList.sg";
	document.vForm.submit();
}


function jf_goRows(){
	document.vForm.pageNum.value = "1";
	document.vForm.actType.value = 'list';
	document.vForm.action = "/sgportal/cass/techsup/cassTechSupAppList.sg";
	document.vForm.submit();
}

function goRefresh_app(){
	var f = document.vForm;
	f.status_nm.value="";
	f.cl_corp_nm.value="";
	f.src_pjt_nm.value="";
	f.src_prod_nm.value="";
	f.key.value="";
	f.keyword.value="";
	document.vForm.action = "/sgportal/cass/techsup/cassTechSupAppList.sg?actType=list";
	document.vForm.submit();
	
}
//-->
</SCRIPT>
 
<form name='vForm' method='post'> 
<input type="hidden" name="actType" id="actType" /> 
<input type='hidden' name='c_tech_sup_app_no'>
<input type='hidden' name='pageNum'>
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
					<th style="width:16%" id="odd">카테고리</th>
					<td style="padding-left:10px">
						<select name="src_cate_id" id="src_cate_id" title="장애 분류/카테고리"  style="width:150px">
							<option value="">선택</option>
							<c:forEach items="${cass_cate_id}" var="cass_id" varStatus="p"> ${cass_id }
								<option <c:if test="${cass_id.CODE == pMap.src_cate_id}"> selected</c:if> value="${cass_id.CODE}">
									${cass_id.CODE_NM}
								</option>
							</c:forEach>
						</select> 
						 
						 <input type='text' name='src_cate_nm' value='${pMap.src_cate_nm}' class="gray_txt" style="width:93px" title="카테고리" />  
					</td>
					<th style="width:16%" id="odd">진행상태</th>
					<td style="padding-left:10px">
						<select name="src_status" style="width:250px">
							<option value="">진행상태</option>
							<option value="001" <c:if test="${pMap.src_status == '001'}">selected="selected"</c:if>>현상등록</option>
							<option value="002" <c:if test="${pMap.src_status == '002'}">selected="selected"</c:if>>원인등록</option>
							<option value="003" <c:if test="${pMap.src_status == '0033'}">selected="selected"</c:if>>조치내용</option> 
						</select> 
					</td> 
				</tr>
				<tr>
					<th style="width:16%" id="odd">장애처리 ID</th> 
					<td style="padding-left:10px">
						TSA<input type='text' name='src_tech_sup_id' value='${pMap.src_tech_sup_id}' class="gray_txt" style="width:227px" title="장애처리 ID" />  
					</td> 
					<th style="width:16%" id="odd">원인/현상</th> 
					<td style="padding-left:10px">
						<input type='text' name='src_st_con' value='${pMap.src_st_con}' class="gray_txt" style="width:250px" title="원인/현상" />  
					</td> 
				</tr>
				<tr>
					<th style="width:16%" id="odd">등록자</th> 
					<td style="padding-left:10px">
						<input type='text' name='src_chman_nm' value='${pMap.src_chman_nm}' class="gray_txt" style="width:250px" title="등록자" />  
					</td> 
					<th style="width:16%" id="odd">해결방안</th> 
					<td style="padding-left:10px">
						<input type='text' name='src_st3_con' value='${pMap.src_st3_con}' class="gray_txt" style="width:250px" title="해결방안" />  
					</td> 
				</tr>
				
				<tr>
					<th style="width:16%" id="odd">접수일</th> 
					<td style="padding-left:10px">
							<input title="접수일" onclick="calPopup(this, 'mypopup', 0, 20, 'document.vForm.st_cr_date', ''); return false;" type="text" style="width:95px"
						name="st_cr_date" readonly="readonly"   value="${pMap.st_cr_date}"/>
							<input type="image" src="/resource/images/admin/img/ic_calendar.gif"   readonly="readonly" value="${pMap.st_cr_date}"
         				onclick="calPopup(this, 'mypopup', 0, 20, 'document.vForm.st_cr_date', ''); return false;"  align="middle" width="16" height="16" /> ~
         				
         				
         				
         					<input title="접수일" onclick="calPopup(this, 'mypopup', 0, 20, 'document.vForm.ed_cr_date', ''); return false;" type="text" style="width:95px"
						name="ed_cr_date" readonly="readonly"   value="${pMap.ed_cr_date}"/>
							<input type="image" src="/resource/images/admin/img/ic_calendar.gif"   readonly="readonly" value="${pMap.ed_cr_date}"
         				onclick="calPopup(this, 'mypopup', 0, 20, 'document.vForm.ed_cr_date', ''); return false;"  align="middle" width="16" height="16" /> 
						
						
					</td> 
					<th style="width:16%" id="odd">제목</th> 
					<td style="padding-left:10px">
						<input type='text' name='src_title' value='${pMap.src_title}' class="gray_txt" style="width:250px" title="제목" /> 
						<input type="image" src="/resource/images/bass_1st/btn_search.gif" align="absmiddle" style="cursor:hand;pointer;" onclick="jf_search()" />  
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
					 <input type="button" class="button04" value="장애접수" onclick="f_app_insView()" style="cursor:hand;">
					&nbsp;&nbsp;&nbsp;
					 <span style="color:red">
					 * 장애접수를 하려면 좌측의 버튼을 클릭해 주세요.  
					 </span>
				</c:if>  
			</td> 
		</tr>	
	</table> 
		
		
		 

	<h3 class="subtitle"> 장애접수 목록</h3>
	
	<div class="btn">						
		<div class="leftbtn">
			<b style="">총 [${getCassCount}] 건</b>
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



	<table width="100%" border="0" cellpadding="0" cellspacing="0"  class="grid"> 		
		<tr>
			<th scope="col" id="odd">장애접수 ID</th>
			<th scope="col" id="odd">고객사</th>
			<th scope="col" id="odd">고객담당자</th>
			<th scope="col" id="odd">카테고리</th>
			<th scope="col" id="odd">제목</th>
			<th scope="col" id="odd">접수일</th>
			<th scope="col" id="odd">현장지원자</th> 
			<th scope="col" id="odd">진행상황</th> 
		</tr>
		<c:forEach items="${getCassList}" var="data" varStatus="i">
			<tr> 
				<td width="15%" align="center">
					<a href="javascript:jf_view('${data.C_TECH_SUP_APP_NO}')">
						${fn:substring(data.C_TECH_SUP_APP_NO, 0, 3)}-${fn:substring(data.C_TECH_SUP_APP_NO, 3, 16)}
					</a>
				</td>
				<td width="15%" style="padding-left: 5px">${data.C_COM_NM}</td>
				<td width="10%" style="padding-left: 5px">${data.C_COM_PER_NM}</td>
				<td width="15%" style="padding-left: 5px">
					<c:choose>
						<c:when test="${!empty data.C_CATE_ID }">${data.CATE_NM }</c:when>
						<c:when test="${!empty data.C_CATE_NM }">${data.C_CATE_NM }</c:when> 
					</c:choose>
				</td>
				<td style="padding-left: 5px">${data.C_TECH_SUP_TITLE}</td>
				<td width="13%" align="center">${data.CR_DATE}</td>
				<td width="10%" align="center">${data.C_SG_CHMAN_NM}</td> 
				<td width="8%" align="center">
					<c:choose>
						<c:when test="${data.C_TECH_SUP_PR_ID=='1'}"> 마스터 저장 </c:when>
						<c:when test="${data.C_TECH_SUP_PR_ID=='2'}"> 현상저장 </c:when>
						<c:when test="${data.C_TECH_SUP_PR_ID=='3'}"> 원인저장 </c:when>
						<c:when test="${data.C_TECH_SUP_PR_ID=='4'}"> 조치내용 </c:when>
						<c:when test="${data.C_TECH_SUP_PR_ID=='5'}"> 마스터 수정 </c:when>
						<c:when test="${data.C_TECH_SUP_PR_ID=='6'}"> 협조자등록 </c:when>
						<c:when test="${data.C_TECH_SUP_PR_ID=='7'}"> 처리완료 </c:when>
					</c:choose>
				</td> 
			</tr>
		</c:forEach>
	</table>
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
			<input type="button" class="button04" value="장애접수" onclick="f_app_insView()" style="cursor:hand;">  
		</c:if>
		<!-- 권한 에 따른 쓰기기능 제어 시작  -->
	</div>
</div>	
 

<br/><br/>

<div id="mypopup" style="position: absolute; visibility: hidden; z-index: 0; background-color: #99BDDF;"></div> 