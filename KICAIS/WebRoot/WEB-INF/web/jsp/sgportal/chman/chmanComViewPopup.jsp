<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%> 
<%@ include file="/WEB-INF/web/jsp/common/inc/commonInc.jsp" %>
<link href="/resource/manage/css/admin_sgf.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" href="/resource/common/css/validator.css" media="screen, projection"/>
<link href="/resource/common/css/common.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="/resource/common/js/validator.js" ></script>
<script type="text/javascript" src="/resource/common/js/mini.js"></script>
<script type="text/javascript" src="/resource/common/js/jquery.sg.js"></script>


<SCRIPT LANGUAGE="JavaScript">
<!-- 
	function getPost(cont, addr, schTxt){	
		postCont = cont;
		g_addr = addr;
		g_schTxt = schTxt;
		var url = "/sgportal/post/searchZipForm.sg";
		window.open(url, "ipinControl", "width=620, height=448, left=250, top=100, scrollbars=yes, resizable=no, menubar=no");
	}
  
	function jf_chmanList(){
		if(document.vForm.beforeViewName.value != ""){
			document.vForm.action = document.vForm.beforeViewName.value + ".sg?";
		}else{
			document.vForm.action = "/sgportal/chman/chmanComList.sg?";
		}
		document.vForm.submit();
	}
  
	function jf_chmanModForm(){  
		 
		if('${pMap.actType}' == "view"){
			document.vForm.actType.value="mod"; 
			document.vForm.action = "/sgportal/chman/chmanComView.sg";
			document.vForm.submit();
		}else{
			var ssn1 = document.vForm.ssn1.value + document.vForm.ssn2.value + document.vForm.ssn3.value;
			var ssn2 = '${companyView.SSN}';
			
			if((ssn1 != ssn2) && document.vForm.ssnCheck.value != '0'){
				alert('사업자등록번호 중복체크를 확인해주세요.');
				return false;
			}
			
			document.vForm.actType.value="mod"; 
			if(Validator.validate(document.vForm)){
				document.vForm.action = "/sgportal/chman/chmanComAction.sg";
				document.vForm.submit();
			}
		}
	}
	
	function ssnChange(){
		document.vForm.ssnCheck.value = "1";
	}
	 
	function jf_chmanInsForm(){
		document.vForm.actType.value="ins";

		if('${pMap.comT}'=="SG"){
			document.vForm.corp_sect_code.value="1";
		}else{
			document.vForm.corp_sect_code.value="2";
		}
		
		if(document.vForm.ssnCheck.value != '0'){
			alert('사업자등록번호 중복체크를 확인해주세요.');
			return false;
		}
		
		if(Validator.validate(document.vForm)){
			document.vForm.action = "/sgportal/chman/chmanComAction.sg?viewName=/sgportal/chman/chmanComViewPopup";
			document.vForm.submit();
		}
	}
 
	 
	function jf_chman_list(){ 
		document.vFormList.action = "/sgportal/chman/chmanComList.sg";
		document.vFormList.submit();
	}
	
	 
	function jf_search(){
		if(document.vFormList.keyword.value == ""){
			alert('검색어를 입력하세요');
			document.vFormList.keyword.focus();
			return;
		}
		document.vFormList.pageNum.value = "1";
		document.vFormList.actType.value = 'view';
		document.vFormList.corp_no.value = document.vForm.corp_no.value; 
		document.vFormList.action = '/sgportal/chman/chmanComView.sg?viewName=/sgportal/chman/chmanComView';
		document.vFormList.submit();
	}
	
	 

	
	 
	 function jf_insert_view(){		 
		document.vFormList.actType.value = 'ins'; 
		document.vFormList.action = "/sgportal/chman/chmanView.sg?viewName=/sgportal/chman/chmanViewPopup";
		document.vFormList.submit();
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
		document.vForm.action = "/sgportal/chman/chmanComView.sg";
		document.vForm.submit(); 
	}  

	function jf_goRows(){
		document.vForm.action = "/sgportal/chman/chmanComView.sg";
		document.vForm.submit();
	}


	function jf_per_del(){
		if(confirm('영구삭제 하겠습니까?')){
		 	document.vForm.actType.value = 'del';
		 	document.vForm.action = "/sgportal/chman/chmanComAction.sg";
		 	document.vForm.submit();
		}
	}


	function jf_use_yn(value){
		var m;
		if(value == 'Y'){
			m = "복구 하겠습니까?";
		}else{
			m = "삭제 하겠습니까?";
		}
		
		if(confirm(m)){
		 	document.vForm.actType.value = 'useYn';
		 	document.vForm.action = "/sgportal/chman/chmanComAction.sg?use_yn="+value;
		 	document.vForm.submit();
		}
	}

	function jf_view(chman_no, chman_nm, chman_sect_code, chman_type_code, chman_hp, grad_code, dept_code, corp_nm){
		opener.jf_view(chman_no, chman_nm, chman_sect_code, chman_type_code, chman_hp, grad_code, dept_code, corp_nm);
		jf_close();
	}

	function jf_close(){
		
		//opener.jf_close();
		this.close();
		
	}

	function chkDupSsn(){
		var f = document.vForm;
		var ssn = f.ssn1.value + f.ssn2.value + f.ssn3.value;

		 
	}
	
	
	var blockClick2 =  false;
	function jf_idCheck() { 
		
		var param = ""; 
		var ssn = document.vForm.ssn1.value + document.vForm.ssn2.value + document.vForm.ssn3.value;
		param = "ssn=" + ssn;

		
		if(CheckBizNo(document.vForm.ssn1, document.vForm.ssn2, document.vForm.ssn3)){		
			if(document.vForm.ssn1.value != "" && document.vForm.ssn2.value != "" && document.vForm.ssn3.value != ""){
				$.ajax({
					url: "/sgportal/chman/ssnCheck.sg",
					type: "POST",
					data: param,
					success: function( xmlResponse ) {
						if($( "Service", xmlResponse ).length == 0){
							document.vForm.ssnCheck.value = "0";
							alert("[" + ssn + "] 옳바른 사업자등록번호 입니다.");
						}else{
							document.vForm.ssnCheck.value = "1";
							alert("["+ssn+"] 이미 등록되어있는 사업자등록번호 입니다.");
						}
					} 
				});
			}else{
		    	alert('사업자등록번호를 입력하세요.');
		    	document.vForm.ssn1.focus();
		    }
		}
	}
	
	 
//-->
</SCRIPT>
<c:set var="groups" value="${fn:split(sessionMap.GROUPS, ',')}" />

	
<form name='vForm' method='post'>  
	<input type="hidden" name="sort" id="sort" value="${pMap.sort}" />
	<input type="hidden" name="sortKey" id="sortKey" value="${pMap.sortKey}" /> 
	<input type="hidden" name="comT" id="comT" value="${pMap.comT}" /> 
	<input type="hidden" name="key" id="key" value="${pMap.key}" />
	<input type="hidden" name="keyword" id="keyword" value="${pMap.keyword}" /> 
	<input type="hidden" name="corp_no" id="corp_no" value="${companyView.CORP_NO}"/>
 	<input type="hidden" name="corp_sect_code" id="corp_sect_code" /> 
 	<input type="hidden" name="actType" id="actType" />
 	<input type="hidden" name="ssnCheck" id="ssnCheck" value="${pMap.ssnCheck}" />
 	
 	
 	<!-- 
 	<input type="hidden" name="hmenu_id" id="hmenu_id" value="${pMap.hmenu_id}" />
 	<input type="hidden" name="beforeViewName" id="beforeViewName" value="${pMap.beforeViewName}" />
 	 -->
 	
	 	<div id="title_line">
			<div id="title">고객 관리</div>
			<div id="location">고객 관리 > 
				<c:choose>
					<c:when test="${pMap.comT == 'SG'}">한국정보인증</c:when>
					<c:otherwise>
					 	고객사정보
					</c:otherwise> 
				</c:choose>  
				<c:choose>
					<c:when test="${pMap.actType == 'view'}">조회</c:when>
					<c:when test="${pMap.actType == 'mod'}">수정</c:when>
					<c:when test="${pMap.actType == 'ins'}">등록</c:when> 
				</c:choose>   
			</div>
		</div>
		
		<div class="subtitle">
			<c:choose>
				<c:when test="${pMap.comT == 'SG'}">한국정보인증</c:when>
				<c:otherwise>
				 	고객사정보
				</c:otherwise> 
			</c:choose>
		</div> 
			 
		<table width="100%" border="0" cellpadding="0" cellspacing="0"  class="grid"> 
			<tr>
				<th scope="col" id="odd" style="width:20%">
					<c:choose>
						<c:when test="${pMap.comT == 'SG'}">한국정보인증</c:when>
						<c:otherwise>
						 	고객사정보
						</c:otherwise> 
					</c:choose>
				</th>
				<td> 
					<c:choose>
						<c:when test="${pMap.actType == 'ins' || pMap.actType == 'mod'}">
							<input type="text" name="corp_nm" id="corp_nm" value="${companyView.CORP_NM}" style="width:350px" title="고객사명" class="required inputText"/> 
						</c:when>
						<c:otherwise>
						 	${companyView.CORP_NM}
						</c:otherwise>
					</c:choose> 
				</td>
			</tr>
			<tr>
				<th scope="col" id="odd">사업자등록번호</th>
				<td>
					<c:choose>
						<c:when test="${pMap.actType == 'ins' || pMap.actType == 'mod'}">
							<input onkeydown="ssnChange()" type="text" name="ssn1" id="ssn1" value="${fn:substring(companyView.SSN ,0,3)}" style="width:50px" maxlength="3"  title="사업자등록번호 첫번째 자리" 
								class="required validate-digits inputText" onkeyup="nextVal(document.vForm.ssn1, document.vForm.ssn2, 3)"/> -
							<input onkeydown="ssnChange()" type="text" name="ssn2" id="ssn2" value="${fn:substring(companyView.SSN ,3,5)}" style="width:50px" maxlength="2"  title="사업자등록번호 두번째 자리" 
								class="required validate-digits inputText" onkeyup="nextVal(document.vForm.ssn2, document.vForm.ssn3, 2)"/> -
							<input onkeydown="ssnChange()" type="text" name="ssn3" id="ssn3" value="${fn:substring(companyView.SSN ,5,10)}" style="width:50px" maxlength="5" title="사업자등록번호 세번째 자리" 
								class="required validate-digits inputText" />
							<%-- 
							<input type="button" class="buttonsmall05" value="중복검색" onclick="javascript:chkDupSsn();" style="cursor:hand;" />
							--%>
						</c:when>
						<c:otherwise>
						 	${fn:substring(companyView.SSN ,0,3)}-${fn:substring(companyView.SSN ,3,5)}-${fn:substring(companyView.SSN ,5,10)}
						</c:otherwise> 
					</c:choose>
					
					<c:if test="${pMap.actType == 'ins' || pMap.actType == 'mod'}">
						<input type="button" class="buttonsmall04" value="중복체크" style="margin-right:10px;" onclick="jf_idCheck()">
					</c:if>
					
					<input type="hidden" name="dupSsn" />
				</td>
			</tr>
			<tr>
				<th scope="col" id="odd">주소</th>
				<td>
					<c:choose>
						<c:when test="${pMap.actType == 'ins' || pMap.actType == 'mod'}">
							<input type="text" name="zipcode1" id="zipcode1" value="${fn:substring(companyView.ZIPCODE ,0,3)}" style="width:50px" maxlength="3" >-
							<input type="text" name="zipcode2" id="zipcode2" value="${fn:substring(companyView.ZIPCODE ,3,7)}" style="width:50px" maxlength="3" /><br/>
							
							<input type="text" name="addr1" id="addr1" value="${companyView.ADDR1}" style="width:300px"  title="주소" />
							
							<input type="button" class="buttonsmall05" value="주소검색" onclick="javascript:getPost(this,'addr1',' ');" style="cursor:hand;">
							<br/>
							
							<input type="text" name="addr2" id="addr2" value="${companyView.ADDR2}" style="width:320px"/>
						</c:when>
						<c:otherwise>
						 	${fn:substring(companyView.ZIPCODE ,0,3)}-${fn:substring(companyView.ZIPCODE ,3,7)}<br/>
						 	${companyView.ADDR1} ${companyView.ADDR2}
						</c:otherwise>
					</c:choose> 
				</td>
			</tr>
			<tr>
				<th scope="col" id="odd">전화번호</th>
				<td>
					<c:choose>
						<c:when test="${pMap.actType == 'ins' || pMap.actType == 'mod'}">
							<input type="text" name="rep_phone" id="rep_phone" value="${companyView.REP_PHONE}" style="width:150px" maxlength="14"  title="전화번호" class="required inputText"/>
						</c:when>
						<c:otherwise>
						 	${companyView.REP_PHONE}
						</c:otherwise>
					</c:choose>
				</td>
			</tr>
			<tr>
				<th scope="col" id="odd">팩스번호</th>
				<td>
					<c:choose>
						<c:when test="${pMap.actType == 'ins' || pMap.actType == 'mod'}">
							<input type="text" name="rep_fax" id="rep_fax" value="${companyView.REP_FAX}" style="width:150px" maxlength="14" />
						</c:when>
						<c:otherwise>
						 	${companyView.REP_FAX}
						</c:otherwise>
					</c:choose>
				</td>
			</tr>
			<tr>
				<th scope="col" id="odd">중요도</th>
				<td>
					<c:choose>
						<c:when test="${pMap.actType == 'ins' || pMap.actType == 'mod'}">
							<select name="imptc_grade_code"> 
								<c:forEach var="i" begin="1" end="10" step="1">
									<option value="${i}" <c:if test="${companyView.IMPTC_GRADE_CODE == i}"> selected="selected" </c:if>>${i}</option> 
								</c:forEach>
							</select>
							  
						</c:when>
						<c:otherwise>
						 	${companyView.IMPTC_GRADE_CODE}
						</c:otherwise>
					</c:choose>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<span style="color:red">* 1 :우선순위 높음  < 2 < 3 < ... < 9 < 10 :우선순위 낮음</span>
				</td>
			</tr> 
		</table> 

		<div class="btn">
			<div class="leftbtn">
				<input type="button" class="button04" value="새로고침" onclick="javascript:window.location.reload();" style="cursor:hand;">
		 	</div>
		 	
		 	<div class="rightbtn">
					
				<!-- 권한 에 따른 쓰기기능 제어 시작  -->		
				<c:if test="${writeGrant != '0' }">
					<c:choose>
						<c:when test="${pMap.actType == 'ins'}">
							<input type="button" class="button02" value="저장" onclick="jf_chmanInsForm()">
							<input type="button" class="button02" value="취소" onclick="jf_close()">
						</c:when>
						<c:otherwise>
							
							<c:forEach items="${groups}" var="group" varStatus="i">
								<c:if test="${group == 'G004'}">
							
							 		<input type="button" class="button02" value="수정" onclick="javascript:jf_chmanModForm()">
									<c:if test="${companyView.USE_YN == 'Y'}">
										<input type="button" class="button02" value="삭제" onclick="jf_use_yn('N')" style="cursor:hand;">
									</c:if>
									<c:if test="${companyView.USE_YN == 'N'}">
										<input type="button" class="button02" value="복구" onclick="jf_use_yn('Y')" style="cursor:hand;">
									</c:if>
									<!-- 
									<input type="button" class="button04" value="영구삭제" onclick="jf_per_del()" style="cursor:hand;">
								 -->
								</c:if>
								<c:if test="${group == 'G002'}">
								</c:if>
							</c:forEach>
							
							
						</c:otherwise> 
					</c:choose>   
				</c:if>
				
			</div>
	 	</div>	 
</form>
<br/><br/><br/><br/>
<c:choose>
	<c:when test="${pMap.actType != 'ins'}">
 
			<form name="vFormList" method="post">
				<input type="hidden" name="comT" id="comT" value="${pMap.comT}" />
				<input type='hidden' name='chman_no' />
				<input type='hidden' name='corp_no' value='${companyView.CORP_NO}' />
				<input type='hidden' name='dept_code' />
				<input type='hidden' name='sign_img_no' />
				<input type='hidden' name='chman_type_code' />
				<input type='hidden' name='chman_sect_code' />
				<input type='hidden' name='imptc_grade_code' /> 
				<input type="hidden" name="actType" id="actType" />
				<input type='hidden' name='pageNum' value='${pageNavi.startRowNo}'>
				<input type="hidden" name="ssnCheck" id="ssnCheck" value="${pMap.ssnCheck}" />
				
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
						<input type="image" src="/resource/images/bass_1st/btn_refresh.gif" align="absmiddle"  onclick="goRefresh();"/>
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
				
				<table width="100%" border="0" cellpadding="0" cellspacing="0"  class="grid">
					<tr>
						<th width="10%" style="cursor:hand;" scope="col" id="odd" onclick="javascript:goSort('CHMAN_TYPE_CODE')">
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
						</td>
						<th width="10%" style="cursor:hand;" scope="col" id="odd" onclick="javascript:goSort('CHMAN_NM')">
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
						</td>
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
						</td> 
						<th width="15%" style="cursor:hand;" scope="col" id="odd" onclick="javascript:goSort('CHMAN_HP')">
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
						</td>
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
						</td>
					</tr>
					
					<!-- 본문 시작 -->	
					<c:forEach items="${list}" var="chman" varStatus="i">
					<tr>
						<td align="center">
							${chman.CHMAN_TYPE_CODE}
						</td>
						<td align="center">
							<c:if test="${chman.USE_YN == 'N'}">
					   		&nbsp;&nbsp;
							<STRIKE style="color: red;font-weight: bolder;">
								<a href="javascript:jf_view('${chman.CHMAN_NO}', '${chman.CHMAN_NM}', '${chman.CHMAN_SECT_CODE}', '${chman.CHMAN_TYPE_CODE}', '${chman.CHMAN_HP}', '${chman.GRADE_CODE}', '${chman.DEPT_CODE}', '${chman.CORP_NM}')">${chman.CHMAN_NM}</a>
							
							</STRIKE>
							</c:if>
							<c:if test="${chman.USE_YN != 'N'}">
					   		&nbsp;&nbsp;
					   			<a href="javascript:jf_view('${chman.CHMAN_NO}', '${chman.CHMAN_NM}', '${chman.CHMAN_SECT_CODE}', '${chman.CHMAN_TYPE_CODE}', '${chman.CHMAN_HP}', '${chman.GRADE_CODE}', '${chman.DEPT_CODE}', '${chman.CORP_NM}')">${chman.CHMAN_NM}</a>
							
					   		</c:if>
							
							
						</td>
						<td>
							&nbsp;&nbsp;${chman.GRADE_CODE} / ${chman.DEPT_CODE}
						</td>
						<td>
							&nbsp;&nbsp;${chman.CHMAN_HP}
						</td>
						<td>
							&nbsp;&nbsp;${chman.CHMAN_EMAIL}
						</td>		
					</tr>
					</c:forEach> 
					<!-- 본문 끝 -->	
				</table>
				
				
				<div class="btn">
					<div class="leftbtn">
						<!-- 권한 에 따른 쓰기기능 제어 시작  -->		
						<c:if test="${writeGrant != '0' }">
							<input type="button" class="button05" value="담당자 추가" onclick="jf_insert_view()" style="cursor:hand;">
						</c:if>
						<!-- 권한 에 따른 쓰기기능 제어 시작  -->
				 	</div>
				 	
				 	<div class="rightbtn">
						<!-- 권한 에 따른 쓰기기능 제어 시작  -->		
						<c:if test="${writeGrant != '0' }">
							 
						</c:if>
						<!-- 권한 에 따른 쓰기기능 제어 시작  -->
						<input type="button" class="button02" value="목록" onclick="javascript:jf_chmanList()">
					</div>
			 	</div>	 	
				<br/><br/>
				 	
				<div class="paging">
					${pageNavi.pageNavigator}
				</div> 	 
								
			<iframe name="f_chmanList" id="f_chmanList" style="display:none; height:0px; overflow:hidden;" ></iframe>
		</form>	  
					 
			 
	</c:when>
</c:choose>


<c:if test="${pMap.command == 'ins'}">
	<script>
		alert('저장 하였습니다.');
		/*
		opener.jf_chman_list();
		this.close();
		*/
		
		document.vForm.corp_no.value = '${pMap.corp_no}';
		document.vForm.actType.value="view";
		document.vForm.action = "/sgportal/chman/chmanComView.sg?viewName=/sgportal/chman/chmanComViewPopup";
		document.vForm.submit();
		
	</script>	
</c:if>

<c:if test="${pMap.command == 'mod'}">
	<script>
		alert('수정 하였습니다.');
		document.vForm.corp_no.value = '${pMap.corp_no}';
		document.vForm.actType.value="view";
		document.vForm.action = "/sgportal/chman/chmanComView.sg";
		document.vForm.submit();
	</script>	
</c:if>
 