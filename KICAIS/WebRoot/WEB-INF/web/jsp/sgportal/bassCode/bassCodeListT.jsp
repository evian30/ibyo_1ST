<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%> 
<%@ include file="/WEB-INF/web/jsp/common/inc/commonInc.jsp" %> 
<SCRIPT LANGUAGE="JavaScript">
<!--

	function jf_search(){
		if(document.vForm.keyword.value == ""){
			alert('검색어를 입력하세요');
			document.vForm.keyword.focus();
			return;
		}
		document.vForm.action = "/sgportal/bassCode/bassCodeList.sg";
		document.vForm.submit();
	} 
 
	  
	function BassCodeView(code_sect, code){ 
		document.vForm.code_sect.value=code_sect; 
		document.vForm.code.value=code;  
		
		document.vForm.actType.value="view";
		document.vForm.cd_type.value="deTail"; 
		document.vForm.action = "/sgportal/bassCode/bassCodeList.sg";
		document.vForm.submit();
	}

	function jf_goRows(obj){ 
		var partType;
		if(partType=="" || obj == "Group"){
			partType="Group";
		}else{
			partType='${pMap.cd_type}';
		}
		
		document.vForm.cd_type.value=partType;

		
		document.vForm.action = "/sgportal/bassCode/bassCodeList.sg";
		document.vForm.submit();
	}
	

	function regBassCode(){  
		document.vForm.insFrom.value="yesForm";
		document.vForm.action = "/sgportal/bassCode/bassCodeList.sg";
		document.vForm.submit(); 
	}

	function regBassCodeAction(){ 

		if('${pMap.code}' == ""){
			document.vForm2.actType.value="ins";
		}else{
			document.vForm2.actType.value="mod";
		}

		if(Validator.validate(document.vForm2)){
			document.vForm2.action = "/sgportal/bassCode/bassCodeAction.sg";  
			document.vForm2.submit();  
		}
	}

	function goRefresh1(){  
		document.vForm.key.value="";
		document.vForm.keyword.value="";
		document.vForm.pageSize.value="10";
		document.vForm.action = "/sgportal/bassCode/bassCodeList.sg";
		document.vForm.submit(); 
	}
	
	 
//-->
</SCRIPT>
<form name='vForm' method='post'> 
	<input type="hidden" name="actType" id="actType"  value="${pMap.actType}"/> 
	<input type="hidden" name="code_sect" id="code_sect" value="${pMap.code_sect}"/>
	<input type="hidden" name="cd_type" id="cd_type"  value="${pMap.cd_type}"/>
	<input type="hidden" name="code" id="code" />  
	<input type="hidden" name="insFrom" id="insFrom"  />	
   	
   	<div id="title_line">
		<div id="title">공통관리기능</div>
		<div id="location">공통관리기능 > BASS 코드관리</div>
	</div>
	
 	<!--search시작-->
	<b class="rtop"><b class="r1"></b><b class="r2"></b><b class="r3"></b><b class="r4"></b></b> 
		<div class="search" >
			<select name='key' class="gray_txt">
				<option value='001' <c:if test="${pMap.key == '001'}">selected</c:if>>코드</option>
				<option value='002' <c:if test="${pMap.key == '002'}">selected</c:if>>코드명</option>
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
 
	<h3 class="subtitle"> BASS코드정보</h3>

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
	 
	 
	 
	<!-- 권한 에 따른 쓰기기능 제어 시작  -->		
	<c:if test="${writeGrant != '0' }">        	       	
		<!--input type="button" value="삭제" onclick="javascript:jf_techsupDelete()" class="green_txt_b" style="width:80px;cursor:pointer;"-->
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
			<th scope="col" id="odd" style="width:10%">번호</td>
			<th scope="col" id="odd">그룹코드</td>
			
			<c:if test="${pMap.cd_type == 'deTail' }">       
				<th scope="col" id="odd">상세코드</td> 
				<th scope="col" id="odd">코드명</td> 
				
				<th scope="col" id="odd">코드설명</td>
				<th scope="col" id="odd">사용여부</td> 
			</c:if>
		</tr>


	<!-- 본문 시작 -->	
	<c:forEach items="${bassCodeList}" var="data" varStatus="i">
	 
	    <tr height="20px">
	    <!-- 권한 에 따른 쓰기기능 제어 시작  -->		
			<c:if test="${writeGrant != '0' }">
	    	<!-- td align='center'><input type='checkbox' name='board_seq01' value='${board.BOARD_SEQ}'></td-->
	    	</c:if>
	    <!-- 권한 에 따른 쓰기기능 제어 끝  -->	
	    	<td align='center'>${pageNavi.startRowNo - i.index}</td>  
	        <td align='left' >&nbsp;&nbsp;&nbsp;
	    		<a href="javascript:BassCodeView('${data.CODE_SECT}', '${data.CODE}')">${data.CODE_SECT}</a>
	    	</td>
	      
	        <c:if test="${pMap.cd_type == 'deTail' }">
		        <td align='left'>${data.CODE}</td>
		        <td align='left' width="25%">&nbsp;&nbsp;&nbsp;${data.CODE_NM}</td>
		        
		        
		        <td align='left' width="25%">&nbsp;&nbsp;&nbsp;${data.CODE_DETAIL}</td>
		        <td align='left'>&nbsp;&nbsp;&nbsp;
		        	<c:if test="${data.USE_YN=='Y'}">
		        		예
		        	</c:if> 
		        	<c:if test="${data.USE_YN=='N'}">
		        		아니오
		        	</c:if>
		        </td> 
	        </c:if>
	    </tr>				 
	</c:forEach>
	<!-- 본문 끝 -->	
	</table>		
	
	<div class="btn">
		<div class="leftbtn">
			<!-- 권한 에 따른 쓰기기능 제어 시작  -->		
			<c:if test="${writeGrant != '0' }">
				 
			</c:if>
			<!-- 권한 에 따른 쓰기기능 제어 시작  -->
	 	</div>
	 	
	 	<div class="rightbtn">
			<!-- 권한 에 따른 쓰기기능 제어 시작  -->		
			<c:if test="${writeGrant != '0' }">
				  <input type="button" class="button04" value="코드추가" onclick="javascript:regBassCode();" style="cursor:hand;">
				  <c:if test="${pMap.cd_type == 'deTail' }"> 
				  	<input type="button" class="button04" value="그룹목록" onclick="javascript:jf_goRows('Group');" style="cursor:hand;">
				  </c:if>
			</c:if>
			<!-- 권한 에 따른 쓰기기능 제어 시작  -->
		</div>
 	</div>	 	
	<br/><br/>
	 	
	<div class="paging">
		${pageNavi.pageNavigator}
	</div> 
</form>	 
<br/><br/>

<form name='vForm2' method='post'> 
  <input type="hidden" name="actType" id="actType"   /> 
  <input type="hidden" name="cd_type" id="cd_type"  />	
  <input type="hidden" name="insFrom" id="insFrom"  />	
	
	<c:if test="${(pMap.code != null && pMap.code != '') || pMap.insFrom == 'yesForm'}"> 
	 	<div class="subtitle">담당자 정보</div> 
		<table width="100%" border="0" cellpadding="0" cellspacing="0"  class="grid"> 
			<tr>
				<th scope="col" id="odd" style="width:15%">그룹코드</th>
				<td  style="width:20%">   
					<c:choose>
						<c:when test="${bassCodeView.CODE_SECT == null}">
							<input type="text" name="code_sect" id="code_sect" value=""  title="그룹코드" class="required inputText" size="30"/>	
						</c:when>
						<c:otherwise>
							${bassCodeView.CODE_SECT}
							<input type="hidden" name="code_sect" id="code_sect" value="${bassCodeView.CODE_SECT}" />	
						</c:otherwise>
					</c:choose> 						</td>
				<th scope="col" id="odd" style="width:15%">상세코드</th>
				<td style="width:15%">   
					<c:choose>
						<c:when test="${bassCodeView.CODE == null}">
							<input type="text" name="code" id="code" value="${bassCodeView.CODE}"  title="상세코드" class="required inputText" size="30"/>	
						</c:when>
						<c:otherwise>
							${bassCodeView.CODE}
							<input type="hidden" name="code" id="code" value="${bassCodeView.CODE}" />
						</c:otherwise>
					</c:choose>  
				</td>
				<th scope="col" id="odd" style="width:15%">코드명</th>
				<td>   
					<input type="text" name="code_nm" id="code_nm" value="${bassCodeView.CODE_NM}"  title="코드명" class="required inputText" size="30"/> 
				</td>
			</tr> 
			<tr>
				<th scope="col" id="odd" style="width:15%">코드설명</th>
				<td  style="width:20%">   
					<input type="text" name="code_detail" id="code_detail" value="${bassCodeView.CODE_DETAIL}"  title="코드설명" class="inputText" size="50"/> 
				</td>
				<th scope="col" id="odd" style="width:15%">사용유무</th>
				<td colspan="3">   
					<input type="radio" name="use_yn" id="use_y" value="Y"  <c:if test="${bassCodeView.USE_YN == 'Y'}"> checked="checked" </c:if> /> 
					<label for="use_y">예</label>
					<input type="radio" name="use_yn" id="use_n" value="N"  <c:if test="${bassCodeView.USE_YN == 'N'}"> checked="checked" </c:if> /> 
					<label for="use_n">아니오</label> 
				</td>
			</tr>  
		</table> 
		
		<div class="btn">
			<div class="leftbtn">
				<!-- 권한 에 따른 쓰기기능 제어 시작  -->		
				<c:if test="${writeGrant != '0' }">
					 
				</c:if>
				<!-- 권한 에 따른 쓰기기능 제어 시작  -->
		 	</div>
		 	
		 	<div class="rightbtn">
				<!-- 권한 에 따른 쓰기기능 제어 시작  -->		
				<c:if test="${writeGrant != '0' }">
					<input type="button" class="button02" value="저장" onclick="javascript:regBassCodeAction();" style="cursor:hand;">
				</c:if>
				<!-- 권한 에 따른 쓰기기능 제어 시작  -->
			</div>
	 	</div>	 	
		<br/><br/>	 
	</c:if>
</form>

<br/><br/>