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
		document.vForm.action = "/sgportal/chman/chmanComList.sg";
		document.vForm.submit();
	}
	
	function jf_goRows(){
		document.vForm.action = "/sgportal/chman/chmanComList.sg";
		document.vForm.submit();
	}
	
	function jf_AllCheck(){
		var len = document.vForm.board_seq01.length;
		if(document.vForm.allCheck.checked == true){
			for(var i = 0; i < len; i++){
				document.vForm.board_seq01[i].checked = true;
			}
		}else{
			for(var i = 0; i < len; i++){
				document.vForm.board_seq01[i].checked = false;
			}
		}
	}
	 
	function jf_regChmanCom(){ 
		document.vForm.actType.value="ins";
		document.vForm.action = "/sgportal/chman/chmanComView.sg";
		document.vForm.submit(); 
	}
	
	function jf_comView(corp_no){ 
		document.vForm.corp_no.value=corp_no;
		document.vForm.actType.value="view";
		if(corp_no=="COR1011022247591"){
			document.vForm.comT.value="SG";	
		}else{
			document.vForm.comT.value="CU";
		}
		
		document.vForm.key.value="";
		document.vForm.keyword.value="";
		document.vForm.action = "/sgportal/chman/chmanComView.sg";
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
		document.vForm.action = "/sgportal/chman/chmanComList.sg";
		document.vForm.submit(); 
	}  
	
//-->
</SCRIPT>
<form name='vForm' method='post'>
	<input type="hidden" name="sort" id="sort" value="${pMap.sort}" />
	<input type="hidden" name="sortKey" id="sortKey" value="${pMap.sortKey}" /> 
	<input type="hidden" name="corp_no" id="corp_no" />
	<input type="hidden" name="actType" id="actType" />
	<input type="hidden" name="comT" id="comT" value="${pMap.comT}" />
	<input type="hidden" name="hmenu_id" id="hmenu_id" value="${pMap.hmenu_id}" />

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
			> 고객사 목록
		</div>
	</div>

	
 	<!--search시작-->
	<b class="rtop"><b class="r1"></b><b class="r2"></b><b class="r3"></b><b class="r4"></b></b> 
		<div class="search" >
			<select name='key' class="gray_txt">
				<option value='001' <c:if test="${pMap.key == '001'}">selected</c:if>>고객사명</option>
				<option value='002' <c:if test="${pMap.key == '002'}">selected</c:if>>주소</option> 
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
 
	<div class="subtitle">
		<c:choose>
			<c:when test="${pMap.comT == 'SG'}">한국정보인증</c:when>
			<c:otherwise>
			 	고객사정보
			</c:otherwise> 
		</c:choose> 
	</div>
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
		<!--input type="button" value="삭제" onclick="javascript:jf_chmanComDelete()" class="green_txt_b" style="width:80px;cursor:pointer;"-->
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
			<th width="30%" style="cursor:hand;" scope="col" id="odd" onclick="javascript:goSort('CORP_NM')">
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
			</td>
			<th width="15%" style="cursor:hand;" scope="col" id="odd" onclick="javascript:goSort('REP_PHONE')">
				<c:if test="${pMap.sort == '1'}">
					<c:if test="${pMap.sortKey == 'REP_PHONE'}">
						▲ 
					</c:if>
				</c:if>
				<c:if test="${pMap.sort == '2'}">
					<c:if test="${pMap.sortKey == 'REP_PHONE'}">
						▼ 
					</c:if>
				</c:if>
				전화번호
			</td>
			<th width="15%" style="cursor:hand;" scope="col" id="odd" onclick="javascript:goSort('REP_FAX')">
				<c:if test="${pMap.sort == '1'}">
					<c:if test="${pMap.sortKey == 'REP_FAX'}">
						▲ 
					</c:if>
				</c:if>
				<c:if test="${pMap.sort == '2'}">
					<c:if test="${pMap.sortKey == 'REP_FAX'}">
						▼ 
					</c:if>
				</c:if>
				팩스번호
			</td> 
			<th width="40%" style="cursor:hand;" scope="col" id="odd" onclick="javascript:goSort('ADDR1')">
				<c:if test="${pMap.sort == '1'}">
					<c:if test="${pMap.sortKey == 'ADDR1'}">
						▲ 
					</c:if>
				</c:if>
				<c:if test="${pMap.sort == '2'}">
					<c:if test="${pMap.sortKey == 'ADDR1'}">
						▼ 
					</c:if>
				</c:if>
				주소
			</td>
		</tr>


	<!-- 본문 시작 -->	
	<c:forEach items="${companyList}" var="board" varStatus="i">
		
	    <tr height="20px">
	    <!-- 권한 에 따른 쓰기기능 제어 시작  -->		
			<c:if test="${writeGrant != '0' }">
	    	<!-- td align='center'><input type='checkbox' name='board_seq01' value='${board.BOARD_SEQ}'></td-->
	    	</c:if>
	    <!-- 권한 에 따른 쓰기기능 제어 끝  -->	
	        <td align='left'>
	        	<c:if test="${board.USE_YN == 'N'}">
		   		&nbsp;&nbsp;
				<STRIKE style="color: red;font-weight: bolder;">
	        	<a href="javascript:jf_comView('${board.CORP_NO}')">
	        		${board.CORP_NM}
	        	</a>
	        	</STRIKE>
	        	</c:if>
	        	
	        	<c:if test="${board.USE_YN == 'Y'}">
	        		&nbsp;&nbsp;
	        		<a href="javascript:jf_comView('${board.CORP_NO}')">
		        		${board.CORP_NM}
		        	</a>
	        	</c:if>
	        	
	        </td>
	        <td align='center'>${board.REP_PHONE}</td>
	        <td align='center'>${board.REP_FAX}</td>
	        <td align='left'>&nbsp;&nbsp;${board.ADDR1} ${board.ADDR2}</td> 
	    </tr>				 
	</c:forEach>
	<!-- 본문 끝 -->	
	</table>	 
			
			
	<div class="btn">
		<div class="leftbtn">
			<!-- 권한 에 따른 쓰기기능 제어 시작  -->		
			<c:if test="${writeGrant != '0' }">
				<c:choose>
					<c:when test="${pMap.comT != 'SG'}">
						<input type="button" class="button05" value="고객사추가" onclick="jf_regChmanCom()" style="cursor:hand;">
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
		</div>
 	</div>	 	
	<br/><br/>
	 	
	<div class="paging">
		${pageNavi.pageNavigator}
	</div> 
		 
</form>