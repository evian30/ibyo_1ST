<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%> 
<%@ include file="/WEB-INF/web/jsp/common/inc/commonInc.jsp" %>
<script type="text/javascript" src="/resource/common/js/jquery.sg.js"></script>
<link href="/resource/common/css/common.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="/resource/common/js/mini.js" ></script>
<script type="text/javascript" src="/resource/common/js/validator.js" ></script> 

<SCRIPT LANGUAGE="JavaScript">
<!--



//-->
</SCRIPT>

<form name='vForm' method='post'>
<input type="hidden" name="actType" id="actType" />
<input type="hidden" name="corp_no" id="corp_no" />



	
	<table width="100%" border="0" cellpadding="0" cellspacing="0" class="grid" rules="cols">
		<tr>
			<th scope="col" id="odd" style="width:15%">프로젝트명</th>
			<td style="width:35%">
				${list.PJT_NAME}
			</td>
			<th scope="col" id="odd" style="width:15%">
				PM
			</th>
			<td style="width:35%">
				${list.CHMAN_NM2}
			</td>
		</tr> 
		<tr>
			<th scope="col" id="odd" style="width:15%">
				휴대전화
			</th>
			<td style="width:35%">
				${list.CHMAN_HP}
			</td>
			<th scope="col" id="odd" style="width:15%">전화</th>
			<td style="width:35%">
				${list.CHMAN_PHONE}
			</td>  
		</tr>
		<tr>
			<th scope="col" id="odd" style="width:15%">이메일</th>
			<td style="width:35%" colspan="3">
				${list.CHMAN_EMAIL}
			</td> 
		</tr>  
		<tr>
			<th scope="col" id="odd">기간</th>
			<td>${list.PJT_ST_DATE} ~ ${list.PJT_END_DATE}</td>
			<th scope="col" id="odd">사업구분</th>
			<td>${list.WORK_TYPE_CODE_NM}</td>
		</tr>
		<tr>
			<th scope="col" id="odd">비고</th>
			<td colspan="3">
				<textarea style="width:100%;height:90" name='pjt_contents' readonly="readonly">${list.PJT_CONTENTS}</textarea> 
			</td>
		</tr>  
	</table>
	 
	<div class="btn">						
		<div class="leftbtn">
		</div>
		<div class="rightbtn">  
			<input type="button" class="button06" value="프로젝트수정" 
				onclick="javascript:window.open('/sgportal/techsup/pjtView.sg?actType=mod&corp_no=${list.CL_CORP_NO}&pjt_no=${list.PJT_NO}', '', 'width=620, height=680, left=250, top=50, scrollbars=yes, resizable=no, menubar=no');" style="cursor:hand;">	 
		</div>
	</div>
	   
</form>

<div id="mypopup" style="position: absolute; visibility: hidden; z-index: 0; background-color: #99BDDF;"></div>
