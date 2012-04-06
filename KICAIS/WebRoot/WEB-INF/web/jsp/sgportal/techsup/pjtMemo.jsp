<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/web/jsp/common/inc/commonInc.jsp" %>
<link href="/resource/manage/css/admin_sgf.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" href="/resource/common/css/validator.css" media="screen, projection"/>
<link href="/resource/common/css/common.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="/resource/common/js/validator.js" ></script>
<script type="text/javascript" src="/resource/common/js/mini.js"></script>
<script type="text/javascript" src="/resource/common/js/jquery.sg.js"></script>

<style>
.ui-autocomplete-loading { background: white url('/resource/common/js/jquery/css/images/ui-anim_basic_16x16.gif') right center no-repeat; }

.ui-button { margin-left: 0.5px;margin-top: 1px; }
.ui-button-icon-only .ui-button-text { padding: 0em; } 
.ui-autocomplete-input { margin: 0; width:200; margin-top: -5px; }

.ui-autocomplete {
	max-height: 100px;
	overflow-y: auto;
	
}
/* IE 6 doesn't support max-height
 * we use height instead, but this forces the menu to always be this tall
 */
* 
html .ui-autocomplete {
	height: 100px;
	width: 200px;
}
</style>

<SCRIPT LANGUAGE="JavaScript">
<!--

function jf_memoInsForm(){ 
	 
	if('${sessionMap.SABUN}' != ''){
		document.vForm02.actType.value="ins"; 
		document.vForm02.action = "/sgportal/techsup/memoAction.sg";
		document.vForm02.submit();
	}else{
		alert('담당자 번호(chman_no)가 등록되어 있지 않습니다. \n\n관리자에게 문의 해 주세요');
	}

}

function jf_memoModForm(){
	document.vForm02.actType.value="mod"; 
	document.vForm02.action = "/sgportal/techsup/memoAction.sg";
	document.vForm02.submit();

}




function memoContents(contents, seq){
	$("#btn_modify").attr("style", "display:block");
	$("#content_ins").attr("style", "display:block");
	
	document.vForm02.memoSeq.value = seq;
	document.getElementById("pjt_memo_contents").value = contents;
}

function jf_insForm(){
	document.vForm02.actType.value="insView"; 
	document.vForm02.action = '/sgportal/techsup/techsupMemo.sg';
	document.vForm02.submit();
	
}
  
//-->
</SCRIPT>
 
<form name='vForm02' method='post'>
<input type='hidden' name='pjt_no' id="pjt_no" value='${pMap.pjt_no}' />
<input type='hidden' name='memoSeq' id="memoSeq" />
<input type="hidden" name="actType" id="actType" />


<h3 class="subtitle"> 프로젝트 메모</h3>

 

<c:if test="${pMap.actType == 'view'}">
<table width="100%" border="0" cellpadding="0" cellspacing="0" rules="cols" >
	<tr>
		<td colspan="2"> 
			<div id="dMemo"> 		
				<table width="100%" border="0" cellpadding="0" cellspacing="0" class="grid" rules="cols">
					<tr>
						<th width="70%" scope="col" id="odd">내용</td>
						<th width="15%" scope="col" id="odd">작성자</td>
						<th width="15%" scope="col" id="odd">생성일</td>
					</tr>
					<c:forEach items="${memoList}" var="memo" varStatus="i">
						<tr align="center">
							<td align="left">
								&nbsp;
								<a href="javascript:memoContents('${memo.CONTENTS}', '${memo.SEQ}');">
									${fn:substring(memo.CONTENTS, 0, 28)}<c:if test="${fn:length(memo.CONTENTS) > 28}">...</c:if>
								</a>	
							</td>
							<td>
								${memo.CHMAN_NM}
							</td>
							<td>
								${memo.CR_DATE}
							</td>
						</tr>
					</c:forEach>			
				</table> 
			</div> 
		</td>
	</tr>
	<tr style="display:none" id="content_ins">
		<th width="15%" scope="col" id="odd">내용</th>
		<td width="75%">
			<textarea 
				<c:if test="${list.CHMAN_NO !=  list.LCHMAN_NO}">readonly="readonly"</c:if>
			 id='pjt_memo_contents' name='pjt_memo_contents' title="내용"  style='border:1 solid; border-color:#D4D4D4; width:100%; height:110;'></textarea>
		</td>
	</tr>
</table>

<div class="btn">						
	<div class="leftbtn">
		
	</div>
	
	<div class="rightbtn">
		<input type="button" class="button02" value="등록" onclick="jf_insForm()" style="cursor:hand;">
	</div>
	
	<div class="rightbtn">
		<input id="btn_modify" type="button" class="button02" value="수정" onclick="jf_memoModForm()" style="display:none;cursor:hand;">
	</div>
</div>	

</c:if>


<c:if test="${pMap.actType == 'insView'}">

<table width="100%" border="0" cellpadding="0" cellspacing="0" class="grid" >
	<tr>
		<th width="15%" scope="col" id="odd">내용</th>
		<td>
			<textarea 
				<c:if test="${list.CHMAN_NO !=  list.LCHMAN_NO}">readonly="readonly"</c:if>
			 id='pjt_memo_contents' name='pjt_memo_contents' title="내용"  style='border:1 solid; border-color:#D4D4D4; width:100%; height:120;'></textarea>
		</td>
	</tr>
</table>

<div class="btn">						
	<div class="leftbtn">
		
	</div>
	<div class="rightbtn">
		<input type="button" class="button02" value="저장" onclick="jf_memoInsForm()" style="cursor:hand;">
	</div>
</div>	
</c:if>

</form>



<c:if test="${pMap.command == 'ins'}">
	<script>
		alert('저장 하였습니다.');
		parent.document.IF_PJT_MEMO.location = '/sgportal/techsup/techsupMemo.sg?actType=view&pjt_no=' + '${pMap.pjt_no}';
	</script>	
</c:if>

<c:if test="${pMap.command == 'mod'}">
	<script>
		alert('수정 하였습니다.');
		parent.document.IF_PJT_MEMO.location = '/sgportal/techsup/techsupMemo.sg?actType=view&pjt_no=' + '${pMap.pjt_no}';
	</script>	
</c:if>
