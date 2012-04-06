<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/web/jsp/common/inc/commonInc.jsp" %>
<link href="/resource/common/css/common.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" href="/resource/common/css/validator.css" media="screen, projection"/>
<script type="text/javascript" src="/resource/common/js/ajax.js" ></script>
<script type="text/javascript" src="/resource/common/js/validator.js" ></script>
<script type="text/javascript" src="/resource/common/js/jquery.sg.js"></script>

<SCRIPT LANGUAGE="JavaScript">
<!--
 
//-->
</SCRIPT>
 
<form name='vForm' method='post'>
<div id="title_line">
	<div id="title">제품담당자보기</div>
	<div id="location">제품담당자보기  > 지원/개발 담당자 현황표 </div>
</div>

<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr><td height="10"></td></tr> 
	<tr>
		<td>		
			<table width="100%" border="0" cellpadding="0" cellspacing="0"  class="grid" rules="cols" summary="관리자 관리">
					<tr> 
						<th width="20%" scope="col" id="odd" rowspan="2">제품명</th>
						<th width="15%" scope="col" id="odd" colspan="3">1차(지원)</th> 
						<th width="10%" scope="col" id="odd" colspan="3">2차(개발)</th>						
						<th width="10%" scope="col" id="odd" rowspan="2">비고</th>
					</tr>
					<tr> 
						<th width="15%" scope="col" id="odd">팀명</th>
						<th width="10%" scope="col" id="odd">담당자</th>
						<th width="10%" scope="col" id="odd">연락처</th>						
						<th width="10%" scope="col" id="odd">팀명</th>
						<th width="15%" scope="col" id="odd">담당자</th>
						<th width="10%" scope="col" id="odd">연락처</th>			 
					</tr>
					<tr>
						<td>SG Secukit for JAVA</td>
						<td rowspan="12">
							기술서비스팀<br/>
							AxSignGATE는 클라이언트 재설치 조치방법에 한해 지원 가능<br/>
						</td>
						<td rowspan="12">공통</td>
						<td rowspan="12">사내 메신져 접속자</td>
						<td rowspan="9">솔루션개발팀</td>
						<td>박재연 사원</td>
						<td>3248</td>
						<td rowspan="10">솔루션 제품</td>
					</tr>
					<tr>
						<td>SG Secukit for .Net/ASP</td>  
						<td>김일용 대리</td>
						<td>3262</td>
					</tr>
					<tr>
						<td>SG SecuXML for JAVA</td>  
						<td>박재연 사원</td>
						<td>3248</td>
					</tr>
					<tr>
						<td>SG SecuXML for .Net/ASP</td>  
						<td>김일용 대리</td>
						<td>3262</td>
					</tr>
					<tr>
						<td>SG EWS</td>  
						<td>박재연 사원</td>
						<td>3248</td>
					</tr>
					<tr>
						<td>SG SecuTax for JAVA</td>  
						<td>박재연 사원</td>
						<td>3248</td>
					</tr>
					<tr>
						<td>SGIxLinker for JAVA</td>  
						<td>김일용 대리</td>
						<td>3262</td>
					</tr>
					<tr>
						<td>SGIxLinker for .Net/ASP</td>  
						<td>박재연 사원</td>
						<td>3248</td>
					</tr>
					<tr>
						<td>SGIxLinker for .Net/ASP</td>  
						<td>김일용 대리</td>
						<td>3262</td>
					</tr>
					<tr>
						<td>SG RA</td>  
						<td>기술서비스팀</td>
						<td>조기풍 사원</td>
						<td>3172</td>
					</tr>
					<tr>
						<td rowspan="2">AxSignGATE</td>  
						<td rowspan="2">R&D팀</td>
						<td>유명한 사원</td>
						<td>3219</td>
						<td rowspan="2">인증서 발급 모듈</td>
					</tr>
					<tr> 
						<td>최재식 사원</td>
						<td>3145</td> 
					</tr>					 
			</table>
	 	</td>
	 </tr>
	<tr><td height="20"></td></tr>
</table> 

<div class="btn">		 
		<b style="color:red"> * 현장지원은 기술서비스팀에게만 1차 대응요청을 하고 기술서비스팀이 솔루션 또는 R&D팀에게 2차 대응요창을 함</b> 
</div>	

<div class="btn">						
	<div class="leftbtn">
		 
	</div>
	<div class="rightbtn">  
		<input type="button" class="button02" value="닫기" onclick="javascript:self.close();" style="cursor:hand;"> 
	</div>
</div>	
 
 