<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%> 
<%@ include file="/WEB-INF/web/jsp/common/inc/commonInc.jsp" %> 

<%@page import="java.util.*"%>

<%@page import="java.text.SimpleDateFormat"%><SCRIPT LANGUAGE="JavaScript">
<!-- 


	function jf_chman_list(){
		document.vForm2.action = "/sgportal/chman/chmanComView.sg";
		document.vForm2.submit();
	}
	 
	 function jf_chman_insert(){
		var comT = '${pMap.comT}';
		if(comT == 'CU'){
			document.vForm2.chman_sect_code.value = '2';
		}else if(comT == 'SG'){
			document.vForm2.chman_sect_code.value = '1';
		}
		
		if(comT == 'SG' && document.vForm2.idcheck.value != '0'){
			alert('아이디 중복체크를 확인해주세요.');
			return false;
		}
		 
		document.vForm2.actType.value = 'ins';
		if(Validator.validate(document.vForm2)){
			document.vForm2.action = "/sgportal/chman/chmanCudAction.sg";
			document.vForm2.submit();
		}
	}
	 
	 function jf_chman_update(){
		document.vForm2.actType.value = 'mod';
		//if(document.vForm2.passwd.value != document.vForm2.passwd2.value){
		//	alert('비밀번호를 확인해주세요!');
		//	return false;
		//}
		if(Validator.validate(document.vForm2)){
			document.vForm2.action = "/sgportal/chman/chmanCudAction.sg";
			document.vForm2.submit();
			
		}
	}
	 
	  function jf_mod_view(){
	 	document.vForm2.actType.value = 'mod';
	 	document.vForm2.action = "/sgportal/chman/chmanView.sg";
	 	document.vForm2.submit();
	 }
	 
	 function jf_view(){
		document.vForm2.actType.value = 'view';
		document.vForm2.action = "/sgportal/chman/chmanView.sg";
		document.vForm2.submit();
	}
	 
	function jf_cancel(){
		document.vForm2.reset(); 
	}
	
	function clickWorkYn(){
		if(document.vForm2.work_yn.checked == true){
			document.vForm2.work_yn.value = 'Y';
		}else{
			document.vForm2.work_yn.value = 'N';
		}
	}

	function jf_chmanList(){ 
		document.vForm2.actType.value="view";
		document.vForm2.pageNum.value = "1";
		document.vForm2.pageSize.value = "10";
		document.vForm2.action = "/sgportal/chman/chmanComView.sg";
		document.vForm2.submit(); 
	}  

	function jf_del(){
		if(confirm('삭제 하겠습니까?')){
		 	document.vForm2.actType.value = 'mod';
		 	document.vForm2.action = "/sgportal/chman/chmanCudAction.sg";
		 	//document.vForm2.submit();
		}
	}

	function jf_per_del(){
		if(confirm('영구삭제 하겠습니까?')){
		 	document.vForm2.actType.value = 'del';
		 	document.vForm2.action = "/sgportal/chman/chmanCudAction.sg";
		 	document.vForm2.submit();
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
		 	document.vForm2.actType.value = 'useYn';
		 	document.vForm2.action = "/sgportal/chman/chmanCudAction.sg?use_yn=" + value;
		 	document.vForm2.submit();
		}
	}

	function jf_pwChage(admin_id){
		var url = '/core/manage/suser/pwChange.sg?admin_id='+admin_id;
		window.open(url, 'pwChage', 'width=300, height=200');
	}





	var blockClick2 =  false;
	function jf_idCheck() {

		if(document.vForm2.id.value != ""){
		    var url="/core/manage/suser/userAjaxIdCheck.sg";
		    queryString = "admin_id="+document.vForm2.id.value;
		
		    if(blockClick2) {
		        //return;
		    }
		
		    blockClick2 = true;
		
		    httpRequest("POST", url, queryString, true, jf_idCheckInfo);
	    }else{
	    	alert('아이디를 입력하세요.');
	    	document.vForm2.id.focus();
	    }
	}


	var jf_idCheckInfo = function() {
		if( ajax.readyState==4 ) {
			if (ajax.status == 200) {
				var idCheck = ajax.responseText;
				var id = idCheck.split("||");
				
				if(id[1] == "0"){
					alert("["+document.vForm2.id.value+"] 아이디는  등록할수있는 아이디 입니다.");
					document.vForm2.idcheck.value = "0";
				}else {
					alert("["+document.vForm2.id.value+"] 아이디는 이미 등록되어있는 아이디 입니다.");
					document.vForm2.id.value="";
					document.vForm2.idcheck.value = "1";
				}
				
				
	            blockClick = false;
			}else{
				blockClick = false;
			}
	 	}
	}
	
	function jf_goRows(){
		document.vForm.actType.value = 'view';
		document.vForm.pageNum.value = "1";
		document.vForm.action = "/sgportal/chman/chmanView.sg";
		document.vForm.submit();
	}
	 

//-->
</SCRIPT>
<c:set var="groups" value="${fn:split(sessionMap.GROUPS, ',')}" />

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
			>
			<c:if test="${pMap.actType == 'view'}">조회</c:if>
			<c:if test="${pMap.actType == 'mod'}">수정</c:if>
			<c:if test="${pMap.actType == 'ins'}">등록</c:if> 
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
	<br /><br />

	<form name='vForm2' method='post'> 
		<input type='hidden' name='corp_no' value='${pMap.corp_no}'/> 
		<input type='hidden' name='sign_img_no' value='SI1'/> 
		<input type='hidden' name='chman_sect_code' /> 
		<input type='hidden' name='imptc_grade_code' /> 
		<input type='hidden' name='chman_no' value='${list.CHMAN_NO}' /> 
		<input type='hidden' name='chman_type' value='CH' /> 
		<input type="hidden" name="actType" id="actType" /> 
		<input type="hidden" name="comT" id="comT" value="${pMap.comT}" />
		<input type="hidden" name="idcheck" id="idcheck" value="${pMap.idcheck}" />
		<input type="hidden" name="pageNum" id="pageNum" value="${pMap.pageNum}"/>
		<input type="hidden" name="pageSize" id="pageSize" value="${pMap.pageSize}"/>

		
	<div class="subtitle">담당자 정보</div>
	<table width="100%" border="0" cellpadding="1" cellspacing="1" class="grid">
		
		<c:if test="${pMap.comT == 'SG'}">
				<c:if test="${pMap.actType == 'view'}">
				<tr>
					<th scope="col" id="odd">* 아이디</td><td>${list.CHMAN_ID }</td>
				</tr>
				</c:if>
				
				<c:if test="${pMap.actType == 'mod'}">
				<tr>
					<th scope="col" id="odd">* 비밀번호</th>
					<td>
					<input type="button" class="buttonsmall06" value="비밀번호변경" style="margin-right:10px;" onclick="javascript:jf_pwChage('${list.CHMAN_ID }')">
					<input type="hidden" name="id" id="id" value="${list.CHMAN_ID}" />
					<input type="hidden" name="passwd" id="passwd" value="${list.PASSWD}" />
					</td>
				</tr>
				</c:if>
				
				<c:if test="${pMap.actType == 'ins'}">
					<tr>
						<th scope="col" id="odd">* 아이디</th><td><input type='text' name='id'>
						
						<input type="button" class="buttonsmall04" value="중복체크" style="margin-right:10px;" onclick="jf_idCheck()"></td>
					</tr>
					<tr>
						<th scope="col" id="odd">* 비밀번호</th><td><input type='passwd' name='passwd'></td>
					</tr>
					<tr>
						<th scope="col" id="odd">* 비밀번호 확인</th><td><input type='passwd01' name='passwd01'></td>
					</tr>
				</c:if>
		</c:if> 
		
		
		<% 
			Date now = new Date(); 
			SimpleDateFormat abc = new SimpleDateFormat("yymmddhhmmss");
			String formatDate = abc.format(now);
			
		%>
		
		<c:if test="${pMap.comT == 'CU'}">
			<input type="hidden" name="id" id="id" value="<%=formatDate %>" /> 
		</c:if>
		
		<tr valign="middle" > 
			<td width="20%" scope="col" id="odd">
				* 담당업무
			</td>
			<td width="80%">
				<c:choose>
					<c:when test="${pMap.actType == 'ins' || pMap.actType == 'mod'}">
						<select class="validate-required-select" name="chman_type_code" id="chman_type_code" title="담당업무 " >
							<option value="">
								선택
							</option>
							<c:forEach items="${c_chman_type_code}" var="tc" varStatus="i">
							<option <c:if test="${tc.CODE == list.CHMAN_TYPE_CODE}"> selected</c:if> value="${tc.CODE}">
								${tc.CODE_NM}
							</option>
							</c:forEach>
					</select>
					</c:when>
					<c:otherwise>
					 	${list.CHMAN_TYPE_CODE_NM}
					</c:otherwise>
				</c:choose> 
			</td>
		</tr>
		<tr valign="middle">
			<td width="20%" scope="col" id="odd">
				* 성명
			</td>
			<td width="80%">
				<c:choose>
					<c:when test="${pMap.actType == 'ins' || pMap.actType == 'mod'}">
						<c:if test="${board.USE_YN == 'N'}"> 
						<STRIKE style="color: red;font-weight: bolder;">
						<input title="성명" type='text' class="required inputTex" name='chman_nm' size=20 maxlength='100' value="${list.CHMAN_NM}">
						</STRIKE>
						</c:if>
						
						<c:if test="${board.USE_YN != 'N'}"> 
						<input title="성명" type='text' class="required inputTex" name='chman_nm' size=20 maxlength='100' value="${list.CHMAN_NM}">
						</c:if>		
					</c:when>
					<c:otherwise>
						${list.CHMAN_NM}
					</c:otherwise>
				</c:choose>
				
			</td>
		</tr>
		<tr valign="middle">
			<td width="20%" scope="col" id="odd">
				직급
			</td>
			<td width="80%">
				<c:choose>
					<c:when test="${pMap.actType == 'ins' || pMap.actType == 'mod'}">
						<select name="grade_code" id="grade_code" title="직급 " >
							<option value="">
								선택
							</option>
							<c:forEach items="${c_grade_code}" var="gc" varStatus="i">
								<option <c:if test="${gc.CODE == list.GRADE_CODE}"> selected</c:if> value="${gc.CODE}">
									${gc.CODE_NM}
								</option>
							</c:forEach>
						</select>	
					</c:when>
					<c:otherwise>
						${list.GRADE_CODE_NM}
					</c:otherwise>
				</c:choose>
	
			</td>
		</tr>	
		<tr valign="middle">
			<td width="20%" scope="col" id="odd">
				부서
			</td>
			<td width="80%">
				<c:choose>
					<c:when test="${pMap.actType == 'ins' || pMap.actType == 'mod'}">
						<select  name="dept_code" id="dept_code" title="부서 " >
							<option value="">
								선택
							</option>
							<c:forEach items="${c_dept_code}" var="dc" varStatus="i">
								<option <c:if test="${dc.CODE == list.DEPT_CODE}"> selected</c:if> value="${dc.CODE}">
									${dc.CODE_NM}
								</option>
							</c:forEach>
						</select>	
					</c:when>
					<c:otherwise>
						${list.DEPT_CODE_NM}
					</c:otherwise>
				</c:choose>
				
			</td>
		</tr>	
		<tr valign="middle">
			<td width="20%" scope="col" id="odd">
				휴대전화
			</td>
			<td width="80%">
				<c:choose>
					<c:when test="${pMap.actType == 'ins' || pMap.actType == 'mod'}">
						<input title="휴대전화" type='text' name='chman_hp' size=60 maxlength='100' value="${list.CHMAN_HP}">
					</c:when>
					<c:otherwise>
						${list.CHMAN_HP}
					</c:otherwise>
				</c:choose>
				
			</td>
		</tr>
		<tr valign="middle">
			<td width="20%" scope="col" id="odd">
				회사전화
			</td>
			<td width="80%">
				<c:choose>
					<c:when test="${pMap.actType == 'ins' || pMap.actType == 'mod'}">
						<input title="회사전화" type='text'  name='chman_phone' size=60 maxlength='100' value="${list.CHMAN_PHONE}">
					</c:when>
					<c:otherwise>
						${list.CHMAN_PHONE}
					</c:otherwise>
				</c:choose>
				
			</td>
		</tr>
		<tr valign="middle">
			<td width="20%" scope="col" id="odd">
				메일
			</td>
			<td width="80%">
				<c:choose>
					<c:when test="${pMap.actType == 'ins' || pMap.actType == 'mod'}">
						<input title="메일" type='text'  name='chman_email' size=60 maxlength='100' value="${list.CHMAN_EMAIL}">
					</c:when>
					<c:otherwise>
						${list.CHMAN_EMAIL}
					</c:otherwise>
				</c:choose>
				
			</td>
		</tr>
		<!-- 
		<tr valign="middle">
			<td width="20%" scope="col" id="odd">
				출근여부
			</td>
			<td width="80%">
				<c:choose>
					<c:when test="${pMap.actType == 'ins'}">
						<input style="cursor:hand;" onclick="clickWorkYn()" checked type="checkbox" name="work_yn" id="work_yn" value="Y">
					</c:when>
					<c:when test="${pMap.actType == 'mod'}">
						<input style="cursor:hand;" onclick="clickWorkYn()" <c:if test="${list.WORK_YN == 'Y'}"> checked</c:if> type="checkbox" name="work_yn" id="work_yn" value="${list.WORK_YN}">
					</c:when>
					<c:otherwise>
						<c:choose>
							<c:when test="${list.WORK_YN == 'Y'}">
								출근
							</c:when>
							<c:otherwise>
								미출근
							</c:otherwise>
						</c:choose>
					</c:otherwise>
				</c:choose>
				
			</td>
		</tr>
		 -->
		<tr valign="middle">
			<td width="20%" scope="col" id="odd">
				메모
			</td>
			<td width="80%">
				<c:choose>
					<c:when test="${pMap.actType == 'ins' || pMap.actType == 'mod'}">
						<textarea id='memo_contents' name='memo_contents' style='border:1 solid; border-color:#D4D4D4; width:100%; height:110;'>${list.MEMO_CONTENTS}</textarea>
					</c:when>
					<c:otherwise>
						${list.MEMO_CONTENTS}
					</c:otherwise>
				</c:choose>
				
			</td>
		</tr>
	</table>



				<div class="btn">
					<div class="leftbtn">
						<input type="button" class="button02" value="목록" onclick="jf_chmanList()">
					</div>
				 	
				 	<div class="rightbtn">
				 		
						<!-- 권한 에 따른 쓰기기능 제어 시작  -->		
						<c:if test="${writeGrant != '0' }">
							<c:if test="${pMap.actType == 'view'}"> 
								<c:forEach items="${groups}" var="group" varStatus="i">
									<c:if test="${group == 'G001'}">
										<input type="button" class="button02" value="수정" onclick="javascript:jf_mod_view()" style="cursor:hand;">
										
										<c:if test="${list.USE_YN == 'Y'}">
											
											<input type="button" class="button02" value="삭제" onclick="jf_use_yn('N')" style="cursor:hand;">
											
										</c:if>
										<c:if test="${list.USE_YN == 'N'}">
											<input type="button" class="button02" value="복구" onclick="jf_use_yn('Y')" style="cursor:hand;">
										</c:if>
										
										<!-- 
										<input type="button" class="button04" value="영구삭제" onclick="jf_per_del()" style="cursor:hand;">
									 -->
									</c:if>
									<!-- 
									<c:if test="${group == 'G002'}">
										
										<input type="button" class="button02" value="수정" onclick="javascript:jf_mod_view()" style="cursor:hand;">
										
										 
										<input type="button" class="button02" value="삭제" onclick="jf_use_yn()" style="cursor:hand;">
										
									</c:if>
									 -->
								</c:forEach>
								
								<c:if test="${pMap.comT=='CU' || sessionMap.SABUN == list.CHMAN_NO}">
									<input type="button" class="button02" value="수정" onclick="javascript:jf_mod_view()" style="cursor:hand;">
								</c:if>
								
							</c:if>
							
							<c:if test="${pMap.actType == 'mod'}">
								<input type="button" class="button02" value="뒤로" onclick="javascript:jf_view()" style="cursor:hand;">
								<input type="button" class="button02" value="수정" onclick="javascript:jf_chman_update()" style="cursor:hand;">
								<input type="button" class="button03" value="초기화" onclick="javascript:jf_cancel()" style="cursor:hand;">
							</c:if>
							
							<c:if test="${pMap.actType == 'ins'}">
								<input type="button" class="button02" value="저장" onclick="jf_chman_insert()" style="cursor:hand;">
							</c:if>
						</c:if>
						
					</div>
			 	</div>	  
</form>
<br/><br/>

 
<c:if test="${(pMap.actType=='view' || pMap.actType=='mod') && (sessionMap.SABUN == pMap.chman_no || sessionMap.ADMIN_ID=='admin')}">
<form name='vForm' method='post'> 
<input type="hidden" name="sort" id="sort" value="${pMap.sort}" />
<input type="hidden" name="sortKey" id="sortKey" value="${pMap.sortKey}" />
<input type="hidden" name="chman_no" id="chman_no"  value="${pMap.chman_no}"/>
<input type="hidden" name="corp_no" id="corp_no" value="${pMap.corp_no}"/>
<input type="hidden" name="pageNum" id="pageNum"/>
<input type="hidden" name="actType" id="actType"/>


				<h3 class="subtitle"> 로그인 이력</h3>
		
				<div class="btn">						
					<div class="leftbtn">
						<b style="">총 [${login_hisCount}] 회</b>
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
			
			
			
				<table width="100%" border="0" cellpadding="1" cellspacing="1" class="grid"> 
					<tr>
						<th scope="col" id="odd"> 번호</th>
						<th scope="col" id="odd"> 로그인 일시</th>
						<th scope="col" id="odd"> 로그인 IP</th>
					</tr>
					<c:forEach items="${login_his}" var="log" varStatus="i">
						<tr>
							<td width="20%" align="center">${pageNavi.startRowNo - i.index}</td>
							<td width="40%" align="center">${log.LOGIN_DATE}</td>
							<td width="40%" style="padding-left: 10px">${log.LOGIN_IP}</td>
						</tr>
					</c:forEach> 
				</table>

				 
					<div class="paging">
						${pageNavi.pageNavigator}
					</div> 
				

</form>
</c:if>


<c:choose>	
	<c:when test="${result == 'true'}">
		<c:choose>
			<c:when test="${pMap.command == 'upd'}">
				<script>
					alert('수정 하였습니다.');
					document.vForm.chman_no.value = '${pMap.chman_no}';
					document.vForm.actType.value="view";
					document.vForm.action = "/sgportal/chman/chmanView.sg";
					document.vForm.submit(); 
					</script>	
			</c:when>
			
			<c:when test="${pMap.command == 'ins'}">
				<script>
					alert('저장 하였습니다.');
					document.vForm.actType.value="view";
					document.vForm.action = "/sgportal/chman/chmanComView.sg";
					document.vForm.submit(); 
				</script>	
			</c:when>
			
			<c:when test="${pMap.command == 'del'}">
				<script>
				
					alert('삭제 하였습니다.');
					document.vForm.actType.value="view";
					document.vForm.action = "/sgportal/chman/chmanComView.sg";
					document.vForm.submit(); 
				
				</script>	
			</c:when>
			
			<c:when test="${pMap.command == 'delY'}">
				<script>
					alert('복구 하였습니다.');
					document.vForm.actType.value="view";
					document.vForm.action = "/sgportal/chman/chmanComView.sg";
					document.vForm.submit(); 
					</script>	
			</c:when>
			
		</c:choose>
	</c:when>
	
</c:choose>
