<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/web/jsp/common/inc/commonInc.jsp" %>
 
<% try{ %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>일정상세관리</title> 
<link href="/resource/common/css/common.css" rel="stylesheet" type="text/css"> 
<link rel="stylesheet" type="text/css" href="/resource/common/css/validator.css" media="screen, projection"/>	
<script type="text/javascript" src="/resource/common/js/ajax.js" ></script>
<script type="text/javascript" src="/resource/common/js/validator.js" ></script>
<script type="text/javascript" src="/resource/common/js/mini.js" ></script>
<script type="text/javascript" src="/resource/common/js/SGcommon.js" ></script> 
  
<script type="text/javascript">
<!--
	function js_submit(){
		if(jk_InuptBoxChk("document.vForm.title","제목을 입력해주세요!")) return;
		if(jk_InuptBoxChk("document.vForm.st_date","날짜를 입력해주세요!")) return;
		
		document.vForm.action="scheduleWriteAct.sg";
		document.vForm.submit();

		
	}

	function js_delete(){
				
		if(confirm('정말 삭제 하시겠습니까?')){
			document.location.href =  "./scheduleWriteAct.sg?"+
										"sche_no=${pMap.sche_no}&amp;"+
										"tech_sup_app_no=${pMap.tech_sup_app_no}&amp;"+
										"chman_no=${pMap.chman_no}amp;"+
										"sch_date=${pMap.sch_date}&amp;"+ 
										"chk=delete&amp;"+
										"schWeek=${pMap.sch_date}&amp;"+
										"year=${fn:substring(pMap.sch_date,0,4)}&amp;month=${fn:substring(pMap.sch_date,4,6)}";
		}
	}	
//-->
</script>  
<%--
<script language="JavaScript"> 
<!-- 
function ssin(){ 
	fff=form01.sel01.options.length;
	soin='';

	for(k=1;k<fff;k++){ 
		soin=soin+form01.sel01.options[k].text+'/';
	} 
alert("박스에 올라온 데이터를 모두 변수로 만들어 배열로 분리해 각각 insert하면 편리해요\n"+soin); 
} 
function edit() { 
	aaa=form01.sel01.options.length;
	si=form01.sel05.selectedIndex;
	so=form01.sel05.options[si].text; 

	si1=form01.sel02.selectedIndex; 
	so1=form01.sel02.options[si1].text; 
	si2=form01.sel03.selectedIndex; 
	so2=form01.sel03.options[si2].text; 
	si3=form01.sel04.selectedIndex; 
	so3=form01.sel04.options[si3].text; 
	bbb=so1+so2+so3+'|'+so+'|'+form01.text01.value; 
	ccc=new Option(bbb); 
	form01.sel01.options[aaa]=ccc; 
} 

function del() { 
	ddd=form01.sel01.selectedIndex+1; 

	for(i=0;i<ddd;i++){ 
		if(form01.sel01.options[i].selected) 
		   form01.sel01.options[i]=null; 
		} 
	} 
//--> 
</script> 
--%>
</head>
<body id="popup">
<%--
	
<table align="center" cellpadding="0" cellspacing="0" width="250"> 
<tr> 
	<td> 
	<form name="form01">
<p align="center"> 
	<p><select name="sel01" size="10"> 
	<option>===========내가 좋아하는 것=========== 
	</select></p> 
	<select name="sel02"> 
	<option value="2002">2002</option> 
	<option value="2003">2003</option> 
	<option value="2004">2004</option> 
	<option value="2005">2005</option> 
	<option value="2006">2006</option> 
	</select> 

	<select name="sel03"> 
	<option value="1">1</option> 
	<option value="2">2</option> 
	<option value="3">3</option> 
	<option value="4">4</option> 
	</select> 

	<select name="sel04"> 
	<option value="21">21</option> 
	<option value="22">22</option> 
	<option value="23">23</option> 
	<option value="24">24</option> 
	</select>
 

	<select name="sel05"> 
	<option value="수박">수박</option> 
	<option value="감자">감자</option> 
	<option value="파인애플">파인애플</option> 
	<option value="고구마">고구마</option> 
	</select>
 

	<input type="text" name="text01">
 
	<input type="button" value="입력" onclick="edit()"> 
	<input type="button" value="삭제" onclick="del()"> 
	<input type="button" value="보내기" onclick="ssin()"></p> 
	</form> 
	</td> 
</tr> 
</table>  
 --%>
	<div id="contents">
		 
		<div id="title_line">
			<div id="title">일정상세관리</div>
			<div id="location">기술 지원 &gt; 일정상세관리</div>
		</div>	 
		
		<div id="contents">
							 
			<form name='vForm' method='post'>
			
			<input type="hidden" name="sche_no" value="${pMap.sche_no}" />
			<input type="hidden" name="chman_no"  value="${pMap.chman_no}" />
			<input type="hidden" name="tech_sup_app_no" value="${pMap.tech_sup_app_no}" />
			
			<input type="hidden" name="tech_sup_status_code" id='tech_sup_status_code' value="5" />
			
			<c:choose>
				<c:when test="${!empty schedule.CR_DATE}">
					<input type='hidden' name='chk' value="modify">	
				</c:when>
				<c:otherwise>
					<input type='hidden' name='chk' value="write">
				</c:otherwise>
			</c:choose> 
			
			<input type="hidden" name="sch_time" value="${pMap.sch_time}">
			<input type='hidden' name='admin_id' value="${ADMIN_SESSION.ADMIN_ID}">
					 	
			<input type='hidden' name='year' value="${fn:substring(pMap.sch_date,0,4)}">
			<input type='hidden' name='month' value="${fn:substring(pMap.sch_date,4,6)}">
						 		 
			<input type='hidden' name='schWeek' value="${fn:substring(pMap.sch_date,0,4)}${fn:substring(pMap.sch_date,5,7)}${fn:substring(pMap.sch_date,8,10)}">
			<input type='hidden' name='sch_date' value="${pMap.sch_date}">
			
			
			
			<table border="0" cellpadding="0" cellspacing="0" class="grid"> 
				<tr>
					<th scope="col" id="odd">제목</th>
					<td colspan="3"><input type="text" name="title" id="textfield" class="inputText" size="65" value="${schedule.TITLE}"/></td>
				</tr> 
				<tr> 
					<th scope="col" id="odd">(예정)시작</th>
					<td colspan="3"> 
						<input onclick="calPopup(this, 'mypopup', 0, 20, 'document.vForm.st_date', ''); return false;" type="text" name="st_date"readonly="readonly" 
							<c:choose>
								<c:when test="${!empty pMap.sch_date && empty schedule.ST_DATE}">
									value="${fn:substring(pMap.sch_date,0,4)}-${fn:substring(pMap.sch_date,4,6)}-${fn:substring(pMap.sch_date,6,8)}"
								</c:when> 
								<c:otherwise>
									 <c:if test="${!empty schedule.ST_DATE}">
									 value="${fn:substring(schedule.ST_DATE, 0, 4)}-${fn:substring(schedule.ST_DATE, 4, 6)}-${fn:substring(schedule.ST_DATE, 6, 8)}"
									 </c:if>
								</c:otherwise>
							</c:choose>	
						 size="12" />
	          			<input type="image" src="/resource/images/bass_1st/icon_date.gif"   readonly="readonly"
        					onclick="calPopup(this, 'mypopup', 0, 20, 'document.vForm.st_date', ''); return false;"  align="middle" width="16" height="16" />
						<select name="st_time1"> 
						    <c:forEach var="i" begin="0" end="24">
						    	<option value='<c:if test="${i < 10}">0${i}</c:if><c:if test="${i >= 10}">${i}</c:if>'
						    		<c:choose>
										<c:when test="${!empty schedule.ST_DATE}">
											<c:if test="${fn:substring(schedule.ST_DATE, 8, 10) * 1 == i}">selected="selected"</c:if>
										</c:when>
										<c:otherwise>
											<c:if test="${!empty pMap.sch_time}">
												<c:if test="${fn:substring(pMap.sch_time, 0, 2) * 1 == i}">selected="selected"</c:if>
											</c:if>
										</c:otherwise>
									</c:choose>>
						   			<c:if test="${i < 10}">0${i}</c:if><c:if test="${i >= 10}">${i}</c:if>
						    	</option>
						    </c:forEach>
						</select>   
						<select name="st_time2">
						    <c:forEach var="j" begin="0" end="55" step="5">
						    	<option value='<c:if test="${j < 10}">0${j}</c:if><c:if test="${j >= 10}">${j}</c:if>' 
						    		<c:choose>
										<c:when test="${!empty schedule.ST_DATE}">
											<c:if test="${fn:substring(schedule.ST_DATE, 10, 12) * 1 == i}">selected="selected"</c:if>
										</c:when>
										<c:otherwise>
											<c:if test="${!empty pMap.sch_time}">
												<c:if test="${fn:substring(pMap.sch_time, 2, 4) == j}">selected="selected"</c:if>
											</c:if>
										</c:otherwise>
									</c:choose>>
						    		<c:if test="${j < 10}">0${j}</c:if><c:if test="${j >= 10}">${j}</c:if>
						    	</option>
						    </c:forEach>
						</select>
					</td>
				</tr>
				<tr>
					<th scope="col" id="odd">(예정)종료</th>
					<td colspan="3">	 		
						<input onclick="calPopup(this, 'mypopup', 0, 20, 'document.vForm.end_date', ''); return false;" type="text" name="end_date"readonly="readonly" 
							<c:choose>
								<c:when test="${!empty pMap.sch_date && empty schedule.END_DATE}">
									value="${fn:substring(pMap.sch_date,0,4)}-${fn:substring(pMap.sch_date,4,6)}-${fn:substring(pMap.sch_date,6,8)}"
								</c:when> 
								<c:otherwise>
									  <c:if test="${!empty schedule.ST_DATE}">
									  value="${fn:substring(schedule.END_DATE, 0, 4)}-${fn:substring(schedule.END_DATE, 4, 6)}-${fn:substring(schedule.END_DATE, 6, 8)}"
									  </c:if>
								</c:otherwise>
							</c:choose>	 
							size="12" />
	          			<input type="image" src="/resource/images/bass_1st/icon_date.gif"   readonly="readonly"
        					onclick="calPopup(this, 'mypopup', 0, 20, 'document.vForm.end_date', ''); return false;"  align="middle" width="16" height="16" />
						<select name="end_time1">
						    <c:forEach var="i" begin="0" end="24">
						    	<option value='<c:if test="${i < 10}">0${i}</c:if><c:if test="${i >= 10}">${i}</c:if>'
						    		<c:choose>
										<c:when test="${!empty schedule.END_DATE}">
											<c:if test="${fn:substring(schedule.END_DATE, 8, 10) * 1 == i}">selected="selected"</c:if>
										</c:when>
										<c:otherwise>
											<c:if test="${!empty pMap.sch_time}">
												<c:if test="${fn:substring(pMap.sch_time, 0, 2) * 1 == i}">selected="selected"</c:if>
											</c:if>
										</c:otherwise>
									</c:choose>>
						   			<c:if test="${i < 10}">0${i}</c:if><c:if test="${i >= 10}">${i}</c:if>
						    	</option>
						    </c:forEach>
						</select>   
						<select name="end_time2">
						    <c:forEach var="j" begin="0" end="55" step="5">
						    	<option value='<c:if test="${j < 10}">0${j}</c:if><c:if test="${j >= 10}">${j}</c:if>' 
						    		<c:choose>
										<c:when test="${!empty schedule.END_DATE}">
											<c:if test="${fn:substring(schedule.END_DATE, 10, 12) * 1 == i}">selected="selected"</c:if>
										</c:when>
										<c:otherwise>
											<c:if test="${!empty pMap.sch_time}">	
												<c:if test="${fn:substring(pMap.sch_time, 2, 4) == j}">selected="selected"</c:if>
											</c:if>
										</c:otherwise>
									</c:choose>>
						    		<c:if test="${j < 10}">0${j}</c:if><c:if test="${j >= 10}">${j}</c:if>
						    	</option>
						    </c:forEach>
						</select> 
					</td>
				</tr>
				<%-- 
				<tr>
					<th scope="col" id="odd">분류</th>
					<td>
						<c:if test="${chk=='write'}">
						<!-- <input type="radio" name="sch_type" id="radio" value="1" disabled/> 사건미팅일정</label> -->
							<input type="radio" name="sch_type" id="radio" value="2" checked/> 일반</label>
						</c:if>
						<c:if test="${chk=='modify'}">
							<input type="hidden" name="sch_type" value="${pMap.sch_type }"/>
							<c:if test="${pMap.sch_type==1}">
								사건미팅일정
							</c:if>
							<c:if test="${pMap.sch_type==2}">
								일반
							</c:if>
						</c:if>
					</td>
				</tr>
				--%>
				<tr>
					<th scope="col" id="odd" width="20%">내용</th>
					<td colspan="3"><textarea name="contents" rows="10" id="textfield" onkeyup="jk_ContentsCheck(this,500);">${schedule.CONTENTS}</textarea></td>
				</tr>
				<tr>
					<th scope="col" id="odd">등록자</th>
					<td colspan="3">					
						<c:choose>
							<c:when test="${empty schedule.CR_DATE}">${ADMIN_SESSION.ADMIN_NM}</c:when>
							<c:otherwise>
								${schedule.CHMAN_NM}
							</c:otherwise> 
						</c:choose>  
					</td>
				</tr>
				
				<tr>
					<th scope="col" id="odd" width="20%">등록일</th>
					<td width="40%">					
						<c:set var="today" value="<%=new java.util.Date().toLocaleString() %>" />
						<c:choose>
							<c:when test="${!empty schedule.CR_DATE}">${schedule.CR_DATE}</c:when>
							<c:otherwise>${today}</c:otherwise> 
						</c:choose>  
					</td>
					<th scope="col" id="odd" width="20%">수정일</th>
					<td>					
						<c:choose>
							<c:when test="${!empty schedule.UP_DATE}">${schedule.UP_DATE}</c:when>
							<c:when test="${!empty schedule.CR_DATE && !empty schedule.UP_DATE}">${today}</c:when> 
						</c:choose>  
					</td>
				</tr>
			</table>
			
			<br/> 
			
			<div class="btn">
				<div class="leftbtn">
					<input name="" type="button" value="닫기" class="button02"  onclick="window.close();" /> 
			 	</div>	
			 	<c:if test="${pMap.view!='view'}">		 	
				 	<div class="rightbtn"> 
							<c:if test="${pMap.chk == 'modify'}">
								<c:if test="${schedule.CHMAN_NO == sessionMap.SABUN}">
									<input id="" class="button02" type="button" value="삭제" onClick="javascript:js_delete()"/>
									<input id="" class="button02" type="button" value="저장" name="" onclick="javascript:js_submit()"/>
								</c:if>
							</c:if>
							 
							<c:if test="${pMap.sche_no == '1'}">
							<input id="" class="button02" type="button" value="저장" name="" onclick="javascript:js_submit()"/>
							</c:if>
						
					</div>
				</c:if>
		 	</div>	 	
			<br/> 
			
		</div>
		</form>
		 
	</div>
	<div id="mypopup" style="position: absolute; visibility: hidden; z-index: 0; background-color: #99BDDF;">test</div>
</body>
</html>
<%
}catch(Exception e){
	out.println(e.toString())	;
}
%>