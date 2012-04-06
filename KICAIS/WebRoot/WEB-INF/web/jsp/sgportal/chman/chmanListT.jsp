<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/web/jsp/common/inc/commonInc.jsp" %>

<SCRIPT LANGUAGE="JavaScript">
<!-- 
	function jf_chman_list(){
		document.vForm.pageNum.value = "1";
		document.vForm.action = "/sgportal/chman/chmanList.sg";
		document.vForm.submit();
	} 
	
	function jf_search(){
		if(document.vForm.keyword.value == ""){
			alert('검색어를 입력하세요');
			document.vForm.keyword.focus();
			return;
		}
		
		document.vForm.pageNum.value = "1";
		document.vForm.action = '/sgportal/chman/chmanList.sg';
		document.vForm.submit();
	}
	
	function jf_goRows(){
		document.vForm.pageNum.value = "1";
		document.vForm.action = "/sgportal/chman/chmanList.sg";
		document.vForm.submit();
	}
	
	function jf_view(chman_no, corp_no){
		document.vForm.actType.value = 'view';
		document.vForm.chman_no.value = chman_no;
		document.vForm.corp_no.value = corp_no; 
		document.vForm.key.value="";
		document.vForm.keyword.value="";
		document.vForm.pageNum.value="1";
		document.vForm.pageSize.value="10";
		document.vForm.action = "/sgportal/chman/chmanView.sg";
		document.vForm.submit();
	 }
	  
	function jf_insert_view(){ 
		document.vForm.actType.value = 'ins';
		if('${pMap.corp_no}'!=""){
			document.vForm.action = "/sgportal/chman/chmanView.sg";
		}else{
			alert("고객사 선택 후 담당자를 등록 할 수 있습니다.");
			return;
		}
		document.vForm.submit();
	} 

	function goRefresh1(){  
		document.vForm.key.value="";
		document.vForm.keyword.value="";
		document.vForm.pageNum.value = "1";
		document.vForm.pageSize.value="10";
		document.vForm.action = '/sgportal/chman/chmanList.sg';
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
		document.vForm.pageNum.value = "1";
		document.vForm.actType.value="view";
		document.vForm.action = "/sgportal/chman/chmanList.sg";
		document.vForm.submit(); 
	}  
	
//-->
</SCRIPT>

<form name='vForm' method='post'> 
<input type="hidden" name="sort" id="sort" value="${pMap.sort}" />
<input type="hidden" name="sortKey" id="sortKey" value="${pMap.sortKey}" /> 
<input type="hidden" name="comT" id="comT" value="${pMap.comT}" />
<input type='hidden' name='chman_no' />
<input type='hidden' name='corp_no' value='${pMap.corp_no}' />
<input type='hidden' name='dept_code' />
<input type='hidden' name='sign_img_no' />
<input type='hidden' name='chman_type_code' />
<input type='hidden' name='chman_sect_code' />
<input type='hidden' name='imptc_grade_code' />
<input type="hidden" name="actType" id="actType" />
<input type='hidden' name='pageNum' value='${pageNavi.startRowNo}'>

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
			> 담당자 목록
		</div>
	</div>

	  
	<c:if test="${pMap.comT == 'SG'}"> 
		<div class="subtitle">한국정보인증</div>
		<table width="100%" border="0" cellpadding="0" cellspacing="0" class="grid"> 
			<tr>
				<th scope="col" id="odd" style="width:20%">
					<c:choose>
							<c:when test="${pMap.comT == 'SG'}">한국정보인증</c:when>
							<c:otherwise>
							 	고객사정보
							</c:otherwise> 
					</c:choose>
				</th>
				<td> ${corp.CORP_NM}</td>
			</tr>
			<tr>
				<th width="20%" scope="col" id="odd">사업자등록번호</th>
				<td>${fn:substring(corp.SSN ,0,3)}-${fn:substring(corp.SSN ,3,5)}-${fn:substring(corp.SSN ,5,10)}</td>
			</tr>
			<tr>
				<th scope="col" id="odd">주소</th>
				<td>${fn:substring(corp.ZIPCODE ,0,3)}-${fn:substring(corp.ZIPCODE ,3,7)}<br/>${corp.ADDR1} ${corp.ADDR2}</td>
			</tr>
			<tr>
				<th scope="col" id="odd">전화번호</th>
				<td>${corp.REP_PHONE}</td>
			</tr>
			<tr>
				<th scope="col" id="odd">팩스번호</th>
				<td>${corp.REP_FAX}</td>
			</tr>
			<tr>
				<th scope="col" id="odd">중요도</th>
				<td>${corp.IMPTC_GRADE_CODE}</td>
			</tr> 
		</table> 
	</c:if>
	<br /><br />
			
		
	<!--search시작-->
	<b class="rtop"><b class="r1"></b><b class="r2"></b><b class="r3"></b><b class="r4"></b></b> 
		<div class="search" >
			<select name='key' class="gray_txt">
				<option value='001' <c:if test="${pMap.key == '001'}">selected</c:if>>이름</option> 
			</select>              			
      		<input type='text' name='keyword' value='${pMap.keyword}' class="gray_txt" style="width:300px" alt="검색란" onkeypress="javascript:if(event.keyCode=='13'){jf_search();}"/>  
			<input type="image" src="/resource/images/bass_1st/btn_search.gif" align="absmiddle" style="cursor:hand;pointer;" onclick="jf_search()" />
			<!--  
			<img src="/resource/images/bass_1st/btn_search_detail.gif" align="absmiddle"> 
			--> 
			<input type="image" src="/resource/images/bass_1st/btn_refresh.gif" align="absmiddle"  onclick="goRefresh1();"/>
		</div>
		 
	<b class="rbottom"><b class="r4"></b><b class="r3"></b><b class="r2"></b><b class="r1"></b></b>
	<!--search끝-->
	
	
								
	<div class="subtitle">담당자 정보</div>
	<div align="right">	
		목록수 :
		<select name="pageSize" onChange="jf_goRows()"> 
			<option value='10'>10</option>
			<option value='20' <c:if test="${pMap.pageSize == '20'}">selected</c:if>>20</option>
			<option value='50' <c:if test="${pMap.pageSize == '50'}">selected</c:if>>50</option>
			<option value='100' <c:if test="${pMap.pageSize == '100'}">selected</c:if>>100</option>
			<option value='200' <c:if test="${pMap.pageSize == '200'}">selected</c:if>>200</option>
			<option value='250' <c:if test="${pMap.pageSize == '250'}">selected</c:if>>250</option>
		 </select>
  	</div>
	   
	<!-- 권한 에 따른 쓰기기능 제어 끝  -->						
	<table width="100%" border="0" cellpadding="0" cellspacing="0"  class="grid">
					<tr>
						<c:if test="${pMap.comT!='SG'}">
						<th width="20%" style="cursor:hand;" scope="col" id="odd" onclick="javascript:goSort('CORP_NM')">
							<c:if test="${pMap.sort == '1'}">
								<c:if test="${pMap.sortKey == 'CORP_NM'}">
									▲ 
								</c:if>
							</c:if>
							<c:if test="${pMap.sort == '2'}">
								<c:if test="${pMap.sortKey == 'CORP_NM'}">
									▼ 
								</c:if>
							</c:if>
							
							고객사
						</th>
						</c:if>
						<th width="15%" style="cursor:hand;" scope="col" id="odd" onclick="javascript:goSort('CHMAN_TYPE_CODE')">
							<c:if test="${pMap.sort == '1'}">
								<c:if test="${pMap.sortKey == 'CHMAN_TYPE_CODE'}">
									▲ 
								</c:if>
							</c:if>
							<c:if test="${pMap.sort == '2'}">
								<c:if test="${pMap.sortKey == 'CHMAN_TYPE_CODE'}">
									▼ 
								</c:if>
							</c:if>
							
							담당 업무
						</th>
						<th width="15%" style="cursor:hand;" scope="col" id="odd" onclick="javascript:goSort('CHMAN_NM')">
							<c:if test="${pMap.sort == '1'}">
								<c:if test="${pMap.sortKey == 'CHMAN_NM'}">
									▲ 
								</c:if>
							</c:if>
							<c:if test="${pMap.sort == '2'}">
								<c:if test="${pMap.sortKey == 'CHMAN_NM'}">
									▼ 
								</c:if>
							</c:if>
							성명
						</th>
						
						<c:if test="${pMap.comT == 'CU'}"> 
							<th  width="15%" scope="col" style="cursor:hand;" id="odd" onclick="javascript:goSort('CORP_NM')">
								<c:if test="${pMap.sort == '1'}">
									<c:if test="${pMap.sortKey == 'CORP_NM'}">
										▲ 
									</c:if>
								</c:if>
								<c:if test="${pMap.sort == '2'}">
									<c:if test="${pMap.sortKey == 'CORP_NM'}">
										▼ 
									</c:if>
								</c:if>
								고객사명
							</th>  
						</c:if>
						
						
						<th scope="col" style="cursor:hand;" id="odd" onclick="javascript:goSort('GRADE_CODE')">
							<c:if test="${pMap.sort == '1'}">
								<c:if test="${pMap.sortKey == 'GRADE_CODE'}">
									▲ 
								</c:if>
							</c:if>
							<c:if test="${pMap.sort == '2'}">
								<c:if test="${pMap.sortKey == 'GRADE_CODE'}">
									▼ 
								</c:if>
							</c:if>
							직급/부서
						</th> 
						<th width="8%" style="cursor:hand;" scope="col" id="odd" onclick="javascript:goSort('CHMAN_HP')">
							<c:if test="${pMap.sort == '1'}">
								<c:if test="${pMap.sortKey == 'CHMAN_HP'}">
									▲ 
								</c:if>
							</c:if>
							<c:if test="${pMap.sort == '2'}">
								<c:if test="${pMap.sortKey == 'CHMAN_HP'}">
									▼ 
								</c:if>
							</c:if>
							휴대전화
						</th>
						<c:if test="${sessionMap.ADMIN_ID=='admin'}">
						<th width="10%"  scope="col" id="odd">							 
							로그인횟수
						</th>
						</c:if>
					<!-- 
						<th width="15%" style="cursor:hand;" scope="col" id="odd" onclick="javascript:goSort('CHMAN_EMAIL')">
							<c:if test="${pMap.sort == '1'}">
								<c:if test="${pMap.sortKey == 'CHMAN_EMAIL'}">
									▲ 
								</c:if>
							</c:if>
							<c:if test="${pMap.sort == '2'}">
								<c:if test="${pMap.sortKey == 'CHMAN_EMAIL'}">
									▼ 
								</c:if>
							</c:if>
							이메일
						</th>
					</tr>
					 -->
		
		<!-- 본문 시작 -->	
		<c:forEach items="${list}" var="chman" varStatus="i">
		<tr>
			<c:if test="${pMap.comT!='SG'}">
			<td width="20%" align="center">
				${chman.CORP_NM}
			</td>
			</c:if>
			
			<td width="10%" align="center">
				${chman.CHMAN_TYPE_CODE}
			</td>
			
			<td width="10%" align="center">
				<c:if test="${chman.USE_YN == 'N'}">
			   		&nbsp;&nbsp;
					<STRIKE style="color: red;font-weight: bolder;">
						<a href="javascript:jf_view('${chman.CHMAN_NO}', '${chman.CORP_NO}')">${chman.CHMAN_NM}</a> 
					</STRIKE>
				</c:if>
				<c:if test="${chman.USE_YN == 'Y'}">
			   		&nbsp;&nbsp;
					<a href="javascript:jf_view('${chman.CHMAN_NO}', '${chman.CORP_NO}')">${chman.CHMAN_NM}</a> 
				</c:if>
			</td>
			
			<c:if test="${pMap.comT == 'CU'}">
				<td width="10%" align="center">
					<a href="javascript:jf_view('${chman.CHMAN_NO}', '${chman.CORP_NO}')">${chman.CORP_NM}</a> 
				</td>
			</c:if>
			
			<td width="20%" align="left">
				&nbsp;&nbsp;${chman.GRADE_CODE} / ${chman.DEPT_CODE}
			</td>
			<td width="15%" align="center">
				${chman.CHMAN_HP}
			</td>
			<c:if test="${sessionMap.ADMIN_ID=='admin'}">
			<td width="8%" align="center">
				<c:choose>
					<c:when test="${empty chman.LOGINCNT}">0</c:when>
					<c:otherwise><b>${chman.LOGINCNT}</b></c:otherwise>
				</c:choose>
			</td>
			</c:if>
			<!-- 
			<td width="15%" align="left">
				&nbsp;&nbsp;${chman.CHMAN_EMAIL}
			</td>	
			 -->	
		</tr>
		</c:forEach>
		<!-- 본문 끝 -->	
	</table>
			
	<div class="btn">
		<div class="leftbtn">
			<!-- 권한 에 따른 쓰기기능 제어 시작  -->		
			<c:if test="${writeGrant != '0' }">
				<c:choose>
					<c:when test="${pMap.corp_no != null}">	
						<input type="button" class="button05" value="담당자 추가" onclick="javascript:jf_insert_view()" style="cursor:hand;" />
					</c:when>
				</c:choose>
			</c:if>
			<!-- 권한 에 따른 쓰기기능 제어 시작  -->
	 	</div>
	 	
	 	<div class="rightbtn">
			<!-- 권한 에 따른 쓰기기능 제어 시작  -->		
			<c:if test="${writeGrant != '0' }">
				 
			</c:if>
			<!-- 권한 에 따른 쓰기기능 제어 시작  -->
			<!--  input type="button" class="button02" value="목록" onclick="javascript:jf_chmanList()" -->
		</div>
 	</div>	 	
	<br/><br/>
	 	
	<div class="paging">
		${pageNavi.pageNavigator}
	</div> 	 		
	
	<br/><br/>
		 		
	<iframe name="f_chmanList" id="f_chmanList" style="display:none; height:0px; overflow:hidden;" />


</form>