<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/web/jsp/common/inc/commonInc.jsp" %>
<script src="/resource/common/js/MultiUpload.js"></script>
<SCRIPT LANGUAGE="JavaScript">
<!--
function init() {
	TextEditor.document.onmousedown = new Function("TextEditorEvent()");
	iText = TextEditor;
	iText.document.open();
	iText.document.write(document.vForm.content.value);
	iText.document.close();
	iText.document.body.style.fontSize = "8pt";
	iText.document.designMode = "On";
	TextEditView.style.display="inline";
	bLoad = true;
}

function changeToSource(){
    if(vForm.html.checked) {
        vForm.TextView.style.display = 'none';
        TextMode.style.display = 'inline';
        TextMenuView.style.display = 'inline';
    	TextEditView.style.display = 'inline';
        TextEditor.document.body.innerHTML = vForm.TextView.value;
    } else {
    	TextEditView.style.display = 'none';
        TextMode.style.display = 'none';
        TextMenuView.style.display = 'none';
        vForm.TextView.style.display = 'inline';
        vForm.TextView.value = TextEditor.document.body.innerHTML;
    }
}


function TextEditorEvent(){
	if (TextEditor.event.button == 2){
		var oSource = TextEditor.event.srcElement ;
		if (!oSource.isTextEdit)
			oSource = TextEditor.event.srcElement.parentTextEdit;

			var strValue = TextEditor.event.srcElement.tagName; //선택된 부분의 태그 종류
			if ((strValue == "IMG" || strValue == "HR") && oSource != null) {

				var oTextRange = oSource.createTextRange();
			}

			var selectedRange = TextEditor.document.selection.createRange();
			var edValue = selectedRange.htmlText;

		var strX = TextEditor.event.x;
		var strY = TextEditor.event.y+180;

		if (strValue == "IMG")
			strH = "180px";
		else if (strValue == "HR" || strValue == "TABLE")
			strH = "135px";
		else
			strH = "340px";

		var strParam = "dialogLeft:" + strX + ";dialogTop:" + strY + ";"
		strParam = strParam + "center:no;dialogWidth:150px; dialogHeight:" + strH + ";status:0;scroll:0; help:0;unadorned:yes;"
	}
}

function ButtonUp(param) {
	param.style.border="1px outset";
	param.style.background="#D4D4D4";
}

function ButtonOut(param) {
	param.style.border="";
	param.style.background="";

}
function MenuOver(param) {
	param.style.fontColor="white";
	param.style.backgroundColor="navy";
}

function MenuOut(param) {
	param.style.fontcolor="white";
	param.style.backgroundColor="#C0C0C0";
}


function block_style(o, cmd) {
	var ed=TextEditor.document.selection.createRange();
	ed.execCommand(cmd, false, o.value);
}


function SelectionCommand(Btn, cmd) {
	TextEditor.focus();
	var EdRange=TextEditor.document.selection.createRange();
	EdRange.execCommand(cmd);
}


function ChFontColor(param,cmd){
	var ed
	ed = TextEditor.document.selection.createRange();
	ed.execCommand(cmd, false, param);
}

function BgColor(cmd){
	TextEditor.document.body.bgColor = cmd;
	document.vForm.bg_color.value = cmd;
}	

function jf_submit(){

	if(document.vForm.faq_cd.value == ""){
		alert('카테고리를 선택하세요.');
		document.vForm.faq_cd.focus();
		return;
	}
	
	if(document.vForm.faq_title.value == ""){
		alert('제목이 없습니다');
		document.vForm.faq_title.focus();
		return;
	}
	
	document.vForm.faq_contents.value = TextEditor.document.body.innerHTML;
	
	if(document.vForm.faq_contents.value == ""){
		alert('내용이 없습니다');
		return;
	}

	
	document.vForm.action="./boardUpd.sg";
	document.vForm.submit();
}

function jf_go(){
	location.href='./boardList.sg?board_id=${boardInfo.BOARD_ID}';
}
//-->
</SCRIPT>

<div id="title_line">
	<div id="title">${boardInfo.BOARD_NM}</div>
	<div id="location">${menuNavi} </div>
</div>


<form name='vForm' method='post' enctype="multipart/form-data">
<input type='hidden' name='faq_writeid' value="${sessionMap.ADMIN_ID }">
<input type='hidden' name='faq_writenm' value="${sessionMap.ADMIN_ID }">
<input type='hidden' name='board_id' value="${boardInfo.BOARD_ID }">
<input type='hidden' name='board_seq' value="${boardView.board_seq }">
<input type='hidden' name='noticeyn' value="N">
						
						
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="grid" rules="cols">
	<tr>
		<th scope="col" id="odd">카테고리선택</th>
		<td>
			<select name='faq_cd'>
				<option value=''>=========선택========</option>
				<c:forEach items="${faqcdList}" var="faqcd" varStatus="i">
					<option value=${faqcd.FAQ_CD } <c:if test="${boardView.faq_cd ==  faqcd.FAQ_CD}">SELECTED</c:if>>${faqcd.FAQ_NM}</option>
				</c:forEach>
			</select>
		</td>
	</tr>
	<tr>
		<th scope="col" id="odd">제목</td><td colspan='3'><input type='text' name='faq_title' size='100' value='${boardView.faq_title }'></td>
	</tr>
	<tr>
		<th scope="col" id="odd">내용</td>
		<td colspan='3'>
			<textarea name="faq_contents" cols="120" rows="15" style='display:none'></textarea>
			<!-- EDITE 시작-->
							<table width='100%'>
								<tr>
									<td>
										<table width='100%' cellpadding='0' cellspacing='0' height='0'>
											<tr>
												<td  align='left' bgcolor='#86A5FF'>
												
<a href="javascript:SelectionCommand(this,'Cut');"><img src='/resource/images/edit/02.gif' alt='잘라내기(Ctrl + X)' border='0'></a>
<a href="javascript:SelectionCommand(this,'Copy');"><img src='/resource/images/edit/03.gif' alt='복사(Ctrl + C)' border='0'></a>
<a href="javascript:SelectionCommand(this,'Paste');"><img src='/resource/images/edit/04.gif' alt='붙여넣기(Ctrl + V)' border='0'></a><img src='/resource/images/edit/line.gif'>
<A href="javascript:SelectionCommand(this,'Bold');"><img src='/resource/images/edit/05.gif' alt='볼드체(Ctrl + B)' border='0'></a>
<a href="javascript:SelectionCommand(this,'Italic');"><img src='/resource/images/edit/06.gif' alt='이탤릭체(Ctrl + I)' border='0'></a>
<a href="javascript:SelectionCommand(this,'Underline');"><img src='/resource/images/edit/07.gif' alt='밑줄(Ctrl + U)' border='0'></a><img src='/resource/images/edit/line.gif'>
<a href="javascript:SelectionCommand(this,'JustifyLeft');"><img src='/resource/images/edit/08.gif' alt='좌측정렬' border='0'></a>
<a href="javascript:SelectionCommand(this,'JustifyCenter');"><img src='/resource/images/edit/09.gif' alt='가운데정렬' border='0'></a>
<a href="javascript:SelectionCommand(this,'JustifyRight');"><img src='/resource/images/edit/10.gif' alt='우측정렬' border='0'></a>			
<img src='/resource/images/edit/line.gif'>
<a href="javascript:SelectionCommand(this,'Indent');"><img src='/resource/images/edit/14.gif' alt='들여쓰기 늘임' border='0'></a>
<a href="javascript:SelectionCommand(this,'Outdent');"><img src='/resource/images/edit/13.gif' alt='들여쓰기 줄임' border='0'></a>			
<img src='/resource/images/edit/line.gif'>
<a href="javascript:SelectionCommand(this,'InsertOrderedList');"><img src='/resource/images/edit/11.gif' alt='번호있는 목록' border='0'></a>
<a href="javascript:SelectionCommand(this,'InsertUnOrderedList');"><img src='/resource/images/edit/12.gif' alt='번호없는 목록' border='0'></a>
<img src='/resource/images/edit/line.gif'>

												</td>
											</tr>
										</table>
									</td>
								</tr>
								<tr>
									<td>			
										<table width='100%' cellpadding='0' cellspacing='0'>
											<tr>
												<td align='left'>
													<select class='solid' onchange="block_style(this, 'fontName')" onblur='this.selectedIndex=0;TextEditor.focus();'>
													<option value>글꼴
													<option value>------------
													<option value='굴림'>굴림
													<option value='궁서'>궁서
													<option value='돋움'>돋움
													<option value='바탕'>바탕
													<option value='Arial'>Arial
													<option value='Arial Black'>Arial Black
													<option value='Courier New'>Courier New
													<option value='Impact'>Impact
													<option value='Verdana'>Verdana
													<option value='Webdings'>Webdings
													<option value='Wingdings'>Wingdings
													</select>&nbsp;&nbsp;
													<select class='solid' onchange="block_style(this, 'FontSize')" onblur='this.selectedIndex=0;'>
													<option value>크기
													<option value='1'>1
													<option value='2'>2
													<option value='3'>3
													<option value='4'>4
													<option value='5'>5
													<option value='6'>6
													<option value='7'>7
													</select>&nbsp;&nbsp;						
													<select class='solid' onchange="ChFontColor(this.value,'ForeColor')" onblur='this.selectedIndex=0;'>
													<option value>글자색
													<option value>기본색
													<option value='white'>흰색
													<option value='gray'>회색
													<option value='#ffff90'>연한노랑
													<option value='#ffffcf'>베이지
													<option value='#cf9000'>황토색
													<option value='maroon'>적갈색
													<option value='#ff9000'>주황색
													<option value='red'>빨간색
													<option value='#9090ff'>연보라색
													<option value='#902fcf'>보라색
													<option value='#cfffff'>옅은하늘색
													<option value='0099cc'>옅은파란색
													<option value='#6666FF'>파란색
													<option value='#2fff2f'>연두색
													<option value='green'>녹색
													<option value='black'>검정색
													</select>&nbsp;&nbsp;						
													<select class='solid' onchange="ChFontColor(this.value,'BackColor')" onblur='this.selectedIndex=0;'>
													<option value>글자배경색
													<option value>기본색
													<option value='black'>검정색
													<option value='green'>녹색
													<option value='#2fff2f'>연두색
													<option value='#6666FF'>파란색
													<option value='0099cc'>옅은파란색
													<option value='#cfffff'>옅은하늘색
													<option value='#902fcf'>보라색
													<option value='#9090ff'>연보라색
													<option value='red'>빨간색
													<option value='#ff9000'>주황색
													<option value='maroon'>적갈색
													<option value='#cf9000'>황토색
													<option value='#ffffcf'>베이지
													<option value='#ffff90'>연한노랑
													<option value='gray'>회색
													<option value='white'>흰색
													</select>&nbsp;&nbsp;
												</td>																	
											</tr>
										</table>
									</td>
								</tr>
								<tr>
									<td height=200 valign=top>
									<textarea id='contentID' style='display:none' name='content'>${boardView.faq_contents}</textarea>									
								<font id='TextEditView' style='width: 100%; height: 100%;display: inline;'>
								<iframe id='TextEditor' name="editFrame" marginwidth='0' marginheight='0' style='width:100%; height:404px;'></iframe>
								</font>
								<textarea id='TextView' style='border:1 solid; border-color:#D4D4D4; width:480; height:310; display:none;'></textarea>
								</td>
							</tR>							
						</table>
						<!-- EDITER 끝. -->
		</td>
	</tr>
	
</table>

<div class="btn">						
	<div class="leftbtn">
		
	</div>
	<div class="rightbtn">
		<input type="button" class="button02" value="수정" style="margin-right:10px;" onclick="javascript:jf_submit()">
			<input type="button" class="button04" value="목록으로" style="margin-right:10px;" onclick="javascript:jf_go()">
	</div>
</div>	
					
</form>		
<SCRIPT LANGUAGE="JavaScript">
init();
top.document.body.scrollTop = 1;
</SCRIPT>