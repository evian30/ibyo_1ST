<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%> 
<%@ include file="/WEB-INF/web/jsp/common/inc/commonInc.jsp" %> 

<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%><link href="/resource/manage/css/admin_sgf.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" href="/resource/common/css/validator.css" media="screen, projection"/>
<link href="/resource/common/css/common.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="/resource/common/js/validator.js" ></script>
<script type="text/javascript" src="/resource/common/js/mini.js"></script>
<script type="text/javascript" src="/resource/common/js/jquery.sg.js"></script>
<script type="text/javascript" src="/resource/common/js/ajax.js"></script>

<SCRIPT LANGUAGE="JavaScript">
<!-- 


	function jf_chman_list(){
		document.vForm.action = "/sgportal/chman/chmanComView.sg";
		document.vForm.submit();
	}
	 
	 function jf_chman_insert(){
		var comT = '${pMap.comT}';
		
		if(comT == 'SG'){
			document.vForm.chman_sect_code.value = '1'; 
		}else{
			document.vForm.chman_sect_code.value = '2';
		}
		 
		 document.vForm.actType.value = 'ins';
		if(Validator.validate(document.vForm)){
			document.vForm.action = "/sgportal/chman/chmanCudAction.sg?viewName=/sgportal/chman/chmanComViewPopup";
			document.vForm.submit();
		}
	}
	 
	 function jf_chman_update(){
		document.vForm.actType.value = 'mod';
		//if(document.vForm.passwd.value != document.vForm.passwd2.value){
		//	alert('비밀번호를 확인해주세요!');
		//	return false;
		//}
		if(Validator.validate(document.vForm)){
			document.vForm.action = "/sgportal/chman/chmanCudAction.sg";
			document.vForm.submit();
			
		}
	}
	 
	  function jf_mod_view(){
	 	document.vForm.actType.value = 'mod';
	 	document.vForm.action = "/sgportal/chman/chmanView.sg";
	 	document.vForm.submit();
	 }
	 
	 function jf_view(){
		document.vForm.actType.value = 'view';
		document.vForm.action = "/sgportal/chman/chmanView.sg";
		document.vForm.submit();
	}
	 
	function jf_cancel(){
		document.vForm.reset(); 
	}
	
	function clickWorkYn(){
		if(document.vForm.work_yn.checked == true){
			document.vForm.work_yn.value = 'Y';
		}else{
			document.vForm.work_yn.value = 'N';
		}
	}

	function jf_chmanList(){ 
		document.vForm.actType.value="view";
		document.vForm.action = "/sgportal/chman/chmanComView.sg";
		document.vForm.submit(); 
	}  

	function jf_del(){
		if(confirm('삭제 하겠습니까?')){
		 	document.vForm.actType.value = 'mod';
		 	document.vForm.action = "/sgportal/chman/chmanCudAction.sg";
		 	//document.vForm.submit();
		}
	}

	function jf_per_del(){
		if(confirm('영구삭제 하겠습니까?')){
		 	document.vForm.actType.value = 'del';
		 	document.vForm.action = "/sgportal/chman/chmanCudAction.sg";
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
		 	document.vForm.action = "/sgportal/chman/chmanCudAction.sg?use_yn=" + value;
		 	document.vForm.submit();
		}
	}

	function jf_pwChage(admin_id){
		var url = '/core/manage/suser/pwChange.sg?admin_id='+admin_id;
		window.open(url, 'pwChage', 'width=300, height=200');
	}





	var blockClick2 =  false;
	function jf_idCheck() {

		if(document.vForm.id.value != ""){
		    var url="/core/manage/suser/userAjaxIdCheck.sg";
		    queryString = "admin_id="+document.vForm.id.value;
		
		    if(blockClick2) {
		        //return;
		    }
		
		    blockClick2 = true;
		    
		    httpRequest("POST", url, queryString, true, jf_idCheckInfo);
	    }else{
	    	alert('아이디를 입력하세요.');
	    	document.vForm.id.focus();
	    }
	}


	var jf_idCheckInfo = function() {
		if( ajax.readyState==4 ) {
			if (ajax.status == 200) {
				var idCheck = ajax.responseText;
				var id = idCheck.split("||");
				
				if(id[1] == "0"){
					alert("["+document.vForm.id.value+"] 아이디는  등록할수있는 아이디 입니다.");
					document.vForm.idcheck.value = "0";
				}else {
					alert("["+document.vForm.id.value+"] 아이디는 이미 등록되어있는 아이디 입니다.");
					document.vForm.id.value="";
					document.vForm.idcheck.value = "1";
				}
				
				
	            blockClick = false;
			}else{
				blockClick = false;
			}
	 	}
	}

	function jf_close(){
		this.close();
		
	}

//-->
</SCRIPT>
<c:set var="groups" value="${fn:split(sessionMap.GROUPS, ',')}" />


	<div id="title_line">
		<div id="title">고객 관리</div>
		<div id="location">고객 관리 > 
			<c:choose>
				<c:when test="${pMap.comT == 'SG'}">한국정보인증</c:when>
				<c:otherwise>
				 	고객사정보
				</c:otherwise> 
			</c:choose> 
			 > 담당자 정보
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

	<form name='vForm' method='post'> 
		<input type='hidden' name='corp_no' value='${pMap.corp_no}'/> 
		<input type='hidden' name='sign_img_no' value='SI1'/> 
		<input type='hidden' name='chman_sect_code' /> 
		<input type='hidden' name='imptc_grade_code' /> 
		<input type='hidden' name='chman_no' value='${list.CHMAN_NO}' /> 
		<input type='hidden' name='chman_type' value='CH' /> 
		<input type="hidden" name="actType" id="actType" /> 
		<input type="hidden" name="comT" id="comT" value="${pMap.comT}" />
		
		<input type="hidden" name="idcheck" id="idcheck" value="${pMap.idcheck}" />
		
	
	<div class="subtitle">담당자 정보</div>
	<table width="100%" border="0" cellpadding="1" cellspacing="1" class="grid">
		<c:if test="${pMap.actType == 'view'}">
		<tr>
			<th scope="col" id="odd">* 아이디</td><td>${list.CHMAN_ID }</td>
		</tr>
		</c:if>
		
		<c:if test="${pMap.actType == 'mod'}">
		<tr>
			<th scope="col" id="odd">* 패스워드</td>
			<td>
			<input type="button" class="buttonsmall06" value="패스워드변경" style="margin-right:10px;" onclick="javascript:jf_pwChage('${list.CHMAN_ID }')">
			<input type="hidden" name="id" id="id" value="${list.CHMAN_ID}" />
			<input type="hidden" name="passwd" id="passwd" value="${list.PASSWD}" />
			</td>
		</tr>
		</c:if>
		
		<c:if test="${pMap.comT == 'SG'}">
			<c:if test="${pMap.actType == 'ins'}">
				<tr>
					<th scope="col" id="odd">* 아이디</td><td><input type='text' name='id'>
					
					<input type="button" class="buttonsmall06" value="아이디 중복체크" style="margin-right:10px;" onclick="jf_idCheck()"></td>
				</tr>
				<tr>
					<th scope="col" id="odd">* 패스워드</td><td><input type='passwd' name='passwd'></td>
				</tr>
				<tr>
					<th scope="col" id="odd">* 패스워드 확인</td><td><input type='passwd01' name=''passwd01''></td>
				</tr>
			</c:if>
		</c:if>
		 
		 <% 
			Date now = new Date(); 
			SimpleDateFormat abc = new SimpleDateFormat("yymmddhhmmss");
			String formatDate = abc.format(now);
			
		%>
		
		<c:if test="${pMap.comT != 'SG'}">
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
						<input title="성명" type='text' class="required inputTex" name='chman_nm' size=40 maxlength='100' value="${list.CHMAN_NM}">
						</STRIKE>
						</c:if>
						
						<c:if test="${board.USE_YN != 'N'}">
				   		 
						<input title="성명" type='text' class="required inputTex" name='chman_nm' size=40 maxlength='100' value="${list.CHMAN_NM}">
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
						<select  name="grade_code" id="grade_code" title="직급 " >
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
						<input title="휴대전화" type='text'   name='chman_hp' size=60 maxlength='100' value="${list.CHMAN_HP}">
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
						<input title="회사전화" type='text' class="required inputTex" name='chman_phone' size=60 maxlength='100' value="${list.CHMAN_PHONE}">
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
									<c:if test="${group == 'G002'}">
										<input type="button" class="button02" value="수정" onclick="javascript:jf_mod_view()" style="cursor:hand;">
										<input type="button" class="button02" value="삭제" onclick="jf_use_yn()" style="cursor:hand;">
									</c:if>
								</c:forEach>
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
