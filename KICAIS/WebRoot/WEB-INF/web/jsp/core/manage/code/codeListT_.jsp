<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/web/jsp/common/inc/commonInc.jsp" %>

<SCRIPT LANGUAGE="JavaScript">
<!--
function jf_AllCheck(){
	var len = document.vForm.cd_gid01.length;
	if(document.vForm.allCheck.checked == true){
		for(var i = 0; i < len; i++){
			document.vForm.cd_gid01[i].checked = true;
		}
	}else{
		for(var i = 0; i < len; i++){
			document.vForm.cd_gid01[i].checked = false;
		}
	}
}

function jf_delete(){
	
	if(document.vForm.cd_gid01 != undefined){
		var len = document.vForm.cd_gid01.length;
		var cd_gid = "";
		var cd_id = "";
		for(var i = 0; i < len; i++){
			if(document.vForm.cd_gid01[i].checked){
				var arry = document.vForm.cd_gid01[i].value;
				var temp = arry.split("||");
				
				cd_gid = cd_gid +","+temp[0];
				
				cd_id = cd_id +","+temp[1];
				
			}
		}
		
		if(cd_gid == ""){
			alert('삭제할 코드  선택하세요.');
		}else{
			if(confirm("정말 삭제 하시겠습니까?")){
				document.vForm.cd_gid.value = cd_gid;
				document.vForm.cd_id.value = cd_id;
				document.vForm.action = "./codeDelete.sg";
				document.vForm.submit();
			}
		}	
	}
}
function jf_go(){
	location.href='./codeCreate.sg';
}
//-->
</SCRIPT>
<link href="../css/ipin_admin_1.0.css" rel="stylesheet" type="text/css"> 
<table width="100%" border="0" cellpadding="0" cellspacing="0" summary="바디테이블">
	<tr>
		<td style="padding-top:30px;padding-bottom:30px;" id="content_title" class="green_txt_b"><img src="/resource/images/admin/img/tt_i.jpg"  style="margin:0 15px 0 0;" align="absmiddle"/>코드 관리</td>
	</tr>
	
	<tr>
		<td style="padding-top:10px;padding-bottom:10px;">
<form name='vForm' method='post'>
<input type='hidden' name='cd_gid'>
<input type='hidden' name='cd_id'>
<input type='hidden' name='cd_gid01'>	
			<table width="100%" border="1" cellpadding="1" cellspacing="1" bordercolor="#CCCCCC" bgcolor="#333399" id="fig3_7">
				<tr>
					<th id="fig3_7" align='center' width='10%'>
						<input type='checkbox' name='allCheck' onclick="javascript:jf_AllCheck()">전체선택 |<a href="javascript:jf_delete()">삭제</a>
					</th>
					<th align='center' width='10%'>그룹코드</th>
					<th align='center' width='10%'>그룹명</th>
					<th align='center' width='10%'>코드</th>
					<th align='center' width='10%'>코드명</th> 
					<th align='center' width='10%'>사용유무</th>
				</tr>
				<c:forEach items="${codeList}" var="code">
				    <tr>
			    	  <td align='center' bgcolor="#CCCCCC"><input type='checkbox' name='cd_gid01' value='${code.CD_GID}||${code.CD_ID}'></td>
				        <td align='center' bgcolor="#CCCCCC"><a href="./codeModify.sg?cd_gid=${code.CD_GID}&cd_id=${code.CD_ID}">${code.CD_GID}</a></td>
				        <td align='center' bgcolor="#CCCCCC"><a href="./codeModify.sg?cd_gid=${code.CD_GID}&cd_id=${code.CD_ID}">${code.CD_GNM}</a></td>
				        <td align='center' bgcolor="#CCCCCC"><a href="./codeModify.sg?cd_gid=${code.CD_GID}&cd_id=${code.CD_ID}">${code.CD_ID}</a></td>
				        <td align='center' bgcolor="#CCCCCC"><a href="./codeModify.sg?cd_gid=${code.CD_GID}&cd_id=${code.CD_ID}">${code.CD_NM}</a></td>
				        <td align='center' bgcolor="#CCCCCC">${code.CD_YN}</td>
				    </tr>
				</c:forEach>
		</table>
</form>			
		</td>
	</tr>
	<tr>
		<td align="right">
			<input type="button" class="green_txt_b" value="코드 만들기" style="margin-right:10px;" onclick="javascript:jf_go()"/>
		</td>
	</tr>
	<tr>
		<td align="center">${pageNavi.pageNavigator}</td>
	</tr>
</table>