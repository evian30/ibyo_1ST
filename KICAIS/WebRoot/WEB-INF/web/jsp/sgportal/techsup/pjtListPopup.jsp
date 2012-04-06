<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/web/jsp/common/inc/commonInc.jsp" %>
<link href="/resource/manage/css/admin_sgf.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" href="/resource/common/css/validator.css" media="screen, projection"/>
<link href="/resource/common/css/common.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="/resource/common/js/validator.js" ></script>
<script type="text/javascript" src="/resource/common/js/mini.js"></script>
<script type="text/javascript" src="/resource/common/js/jquery.sg.js"></script>


<SCRIPT LANGUAGE="JavaScript">
<!--

(function( $ ) {
	$.widget( "ui.combobox", {
		_create: function() {
			var self = this,
				select = this.element.hide(),
				selected = select.children( ":selected" ),
				value = selected.val() ? selected.text() : "";
			var input = $( "<input>" )
				.insertAfter( select )
				.val( value )
				.autocomplete({
					delay: 0,
					minLength: 0,
					source: function( request, response ) {
						var matcher = new RegExp( $.ui.autocomplete.escapeRegex(request.term), "i" );
						response( select.children( "option" ).map(function() {
							var text = $( this ).text();
							if ( this.value && ( !request.term || matcher.test(text) ) )
								return {
									label: text.replace(
										new RegExp(
											"(?![^&;]+;)(?!<[^<>]*)(" +
											$.ui.autocomplete.escapeRegex(request.term) +
											")(?![^<>]*>)(?![^&;]+;)", "gi"
										), "<strong>$1</strong>" ),
									value: text,
									option: this
								};
						}) );
					},
					select: function( event, ui ) {
						ui.item.option.selected = true;
						self._trigger( "selected", event, {
							item: ui.item.option
						});
					},
					change: function( event, ui ) {
						if ( !ui.item ) {
							var matcher = new RegExp( "^" + $.ui.autocomplete.escapeRegex( $(this).val() ) + "$", "i" ),
								valid = false;
							select.children( "option" ).each(function() {
								if ( this.value.match( matcher ) ) {
									this.selected = valid = true;
									return false;
								}
							});
							if ( !valid ) {
								// remove invalid value, as it didn't match anything
								$( this ).val( "" );
								select.val( "" );
								return false;
							}
						}
					}
				})
				.addClass( "ui-widget ui-widget-content ui-corner-left" );

			input.data( "autocomplete" )._renderItem = function( ul, item ) {
				return $( "<li></li>" )
					.data( "item.autocomplete", item )
					.append( "<a>" + item.label + "</a>" )
					.appendTo( ul );
			};

			$( "<button>&nbsp;</button>" )
				.attr( "tabIndex", -1 )
				.attr( "title", "Show All Items" )
				.insertAfter( input )
				.button({
					icons: {
						primary: "ui-icon-triangle-1-s"
					},
					text: false
				})
				.removeClass( "ui-corner-all" )
				.addClass( "ui-corner-right ui-button-icon" )
				.click(function() {
					// close if already visible
					if ( input.autocomplete( "widget" ).is( ":visible" ) ) {
						input.autocomplete( "close" );
						return;
					}

					// pass empty string as value to search for, displaying all results
					input.autocomplete( "search", "" );
					input.focus();
				});
		}
	});
})( jQuery );

$(function() {
	$( "#s_corp_no" ).combobox();
	
});



function jf_techsup(){
	document.vForm.action = "/sgportal/techsup/techsupList.sg";
	document.vForm.submit();
}

function jf_chman_list(){
	document.vForm.action = "/sgportal/techsup/chmanList.sg";
	document.vForm.submit();
}

function jf_search(){
	
	document.vForm.pageNum.value = "1";
	document.vForm.action = '/sgportal/techsup/pjtList.sg?viewName=/sgportal/techsup/pjtListPopup';
	document.vForm.submit();
} 

function jf_view(pjt_no, corp_no){
	document.vForm.pageNum.value = "1";
	document.vForm.actType.value = 'view';
	document.vForm.pjt_no.value = pjt_no; 
	document.vForm.corp_no.value = corp_no;
	document.vForm.action = "/sgportal/techsup/techsupPjtList.sg";
	document.vForm.submit();
 }

function jf_insert_view(){
	document.vForm.pageNum.value = "1";
	document.vForm.actType.value = 'ins';
	document.vForm.action = "/sgportal/chman/chmanView.sg";
	document.vForm.submit();
}
 
function jf_pjt_view(){
	var param = "actType=ins&corp_no=${pMap.corp_no}";
	var url = "/sgportal/techsup/pjtView.sg?" + param;
	window.open(url, "", "width=620, height=410, left=250, top=50, scrollbars=yes, resizable=no, menubar=no");
	
}

function jf_pjt_list(){
	document.vForm.pageNum.value = "1";
	document.vForm.actType.value="list";
	document.vForm.action = "/sgportal/techsup/pjtList.sg?viewName=/sgportal/techsup/pjtListPopup";
	document.vForm.submit();
}

function jf_regChmanCom(){  
	document.vForm.actType.value="ins"; 
	document.vForm.corp_no.value=""; 
	
	document.vForm.action = "/sgportal/chman/chmanComView.sg";
	document.vForm.submit();
}

function jf_sup_list(){ 
	document.vForm.action = "/sgportal/techsup/techsupList.sg";
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
	document.vForm.pageNum.value = "1";
	document.vForm.actType.value="view";
	document.vForm.action = "/sgportal/techsup/pjtList.sg?viewName=/sgportal/techsup/pjtListPopup";
	document.vForm.submit(); 
}  


function jf_del(){
	if(confirm('삭제 하겠습니까?')){
	 	document.vForm.actType.value = 'mod';
	 	document.vForm.action = "/sgportal/chman/chmanComAction.sg";
	 	//document.vForm.submit();
	}
}

function jf_per_del(){
	if(confirm('영구삭제 하겠습니까?')){
	 	document.vForm.actType.value = 'del';
	 	document.vForm.action = "/sgportal/chman/chmanComAction.sg";
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
	 	document.vForm.action = "/sgportal/chman/chmanComAction.sg?use_yn=" + value;
	 	document.vForm.submit();
	}
}



function jf_pjt(pjt_no, pjt_nm, corp_nm, chman_nm){
	
	opener.document.vForm.pjt_no.value = pjt_no;
	opener.document.vForm.pjt_nm.value = corp_nm + "/" + pjt_nm + "/" + chman_nm;

	if('${pMap.chkPop2}'=="Y"){
		opener.document.vForm.c_com_nm.value = corp_nm;
		opener.document.vForm.c_com_per_nm.value = chman_nm;
	} 
	
	this.close();
}
  
//-->
</SCRIPT>
<c:set var="groups" value="${fn:split(sessionMap.GROUPS, ',')}" />

<form name='vForm' method='post'> 
	<input type='hidden' name='pjt_no' value="${pMap.pjt_no}"/>
	<input type='hidden' name='prod_no' value="${pMap.prod_no}"/>
	<input type='hidden' name='tech_sup_no' value="${pMap.tech_sup_no}"/>
	<input type='hidden' name='cont_no' value="${pMap.cont_no}"/>
	
	<input type="hidden" name="sort" id="sort" value="${pMap.sort}" />
	<input type="hidden" name="sortKey" id="sortKey" value="${pMap.sortKey}" /> 
	<input type="hidden" name="comT" id="comT" value="${pMap.comT}" /> 
	<input type='hidden' name='chman_no' /> 
	<input type='hidden' name='corp_no' value='${pMap.corp_no}' />
	
	<input type='hidden' name='dept_code' />
	<input type='hidden' name='sign_img_no' />
	<input type='hidden' name='chman_sect_code' />
	<input type='hidden' name='imptc_grade_code' />
	<input type="hidden" name="actType" id="actType" />
	<input type='hidden' name='pageNum' value='${pageNavi.startRowNo}'>
		
	<div id="title_line">
		<div id="title">프로젝트 목록</div>
		<div id="location"></div>
	</div>
	 

<br />

<div class="btn">
	<div class="leftbtn">
		
	</div>
 	
 	<div class="rightbtn">
		<!-- 권한 에 따른 쓰기기능 제어 시작  -->		
		<c:forEach items="${groups}" var="group" varStatus="i">
			<c:if test="${group == 'G001'}">
				<c:if test="${corp.USE_YN == 'Y'}">
					<input type="button" class="button02" value="삭제" onclick="jf_use_yn('N')" style="cursor:hand;">
				</c:if>
				<c:if test="${corp.USE_YN == 'N'}">
					<input type="button" class="button02" value="복구" onclick="jf_use_yn('Y')" style="cursor:hand;">
				</c:if>
				<!-- 
				<input type="button" class="button04" value="영구삭제" onclick="jf_per_del()" style="cursor:hand;">
			 -->
			</c:if>
			<c:if test="${group == 'G002'}">
				<!-- <input type="button" class="button02" value="삭제" onclick="jf_del()" style="cursor:hand;"> -->
			</c:if>
		</c:forEach>
	</div>
</div>	  

<br />
		
	
<h3 class="subtitle"> 프로젝트 정보</h3> 

	<div class="btn">
		<div class="leftbtn">
			 
		</div>
		<div class="rightbtn"> 
			목록수 :
			<select name="pageSize" onChange="jf_pjt_list()"> 
				<option value='10'>10</option>
				<option value='20' <c:if test="${pMap.pageSize == '20'}">selected</c:if>>20</option>
				<option value='50' <c:if test="${pMap.pageSize == '50'}">selected</c:if>>50</option>
				<option value='100' <c:if test="${pMap.pageSize == '100'}">selected</c:if>>100</option>
				<option value='200' <c:if test="${pMap.pageSize == '200'}">selected</c:if>>200</option>
				<option value='250' <c:if test="${pMap.pageSize == '250'}">selected</c:if>>250</option>
			</select>
		</div>
	</div>	 
	  
<!-- 권한 에 따른 쓰기기능 제어 끝  -->						
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="grid" rules="cols">
	<tr>
 		<!-- 
		<th scope="col" id="odd">
			번호
		</td>
		 -->
		 <th scope="col" id="odd" onclick="javascript:goSort('CORP_NM')" style="cursor:hand;">
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
		<th scope="col" id="odd" onclick="javascript:goSort('PJT_STATUS')" style="cursor:hand;">
			<c:if test="${pMap.sort == '1'}">
				<c:if test="${pMap.sortKey == 'PJT_STATUS'}">
					▲ 
				</c:if>
			</c:if>
			<c:if test="${pMap.sort == '2'}">
				<c:if test="${pMap.sortKey == 'PJT_STATUS'}">
					▼ 
				</c:if>
			</c:if>
		프로젝트상태
		</td>
		
		
		<th scope="col" id="odd" onclick="javascript:goSort('WORK_TYPE_CODE_NM')" style="cursor:hand;">
			<c:if test="${pMap.sort == '1'}">
				<c:if test="${pMap.sortKey == 'WORK_TYPE_CODE_NM'}">
					▲ 
				</c:if>
			</c:if>
			<c:if test="${pMap.sort == '2'}">
				<c:if test="${pMap.sortKey == 'WORK_TYPE_CODE_NM'}">
					▼ 
				</c:if>
			</c:if>
		사업구분
		</td> 
		
		<th scope="col" id="odd" onclick="javascript:goSort('PJT_NAME')" style="cursor:hand;">
			<c:if test="${pMap.sort == '1'}">
				<c:if test="${pMap.sortKey == 'PJT_NAME'}">
					▲ 
				</c:if>
			</c:if>
			<c:if test="${pMap.sort == '2'}">
				<c:if test="${pMap.sortKey == 'PJT_NAME'}">
					▼ 
				</c:if>
			</c:if>
		프로젝트명
		</td>
		<th scope="col" id="odd" onclick="javascript:goSort('CHMAN_NM1')" style="cursor:hand;">
			<c:if test="${pMap.sort == '1'}">
				<c:if test="${pMap.sortKey == 'CHMAN_NM1'}">
					▲ 
				</c:if>
			</c:if>
			<c:if test="${pMap.sort == '2'}">
				<c:if test="${pMap.sortKey == 'CHMAN_NM1'}">
					▼ 
				</c:if>
			</c:if>
		PM
		</td>
		<th scope="col" id="odd" onclick="javascript:goSort('CHMAN_NM2')" style="cursor:hand;">
			<c:if test="${pMap.sort == '1'}">
				<c:if test="${pMap.sortKey == 'CHMAN_NM2'}">
					▲ 
				</c:if>
			</c:if>
			<c:if test="${pMap.sort == '2'}">
				<c:if test="${pMap.sortKey == 'CHMAN_NM2'}">
					▼ 
				</c:if>
			</c:if>
		SG 담당자
		</td>
		<th scope="col" id="odd" onclick="javascript:goSort('CR_DATE')" style="cursor:hand;">
			<c:if test="${pMap.sort == '1'}">
				<c:if test="${pMap.sortKey == 'CR_DATE'}">
					▲ 
				</c:if>
			</c:if>
			<c:if test="${pMap.sort == '2'}">
				<c:if test="${pMap.sortKey == 'CR_DATE'}">
					▼ 
				</c:if>
			</c:if>
		접수일
		</td>
	</tr>
	<!-- 본문 시작 -->	
	<c:forEach items="${pjt}" var="chman" varStatus="i">
	<tr align="center">
		<!-- 
		<td>
			${pageNavi.startRowNo - i.index}
		</td>
		-->
		 
		<td width="15%">
			<a href="javascript:jf_pjt('${chman.PJT_NO}', 
						'${chman.PJT_NAME}', 
						'${chman.CORP_NM}', 
						'${chman.CHMAN_NM2}'
						)">
			${chman.CORP_NM}</a>
		</td>
		<td width="12%">
		<a href="javascript:jf_pjt('${chman.PJT_NO}', 
						'${chman.PJT_NAME}', 
						'${chman.CORP_NM}', 
						'${chman.CHMAN_NM2}'
						)">
			${chman.PJT_STATUS}</a>
		</td>
		
		<td width="15%">
		<a href="javascript:jf_pjt('${chman.PJT_NO}', 
						'${chman.PJT_NAME}', 
						'${chman.CORP_NM}', 
						'${chman.CHMAN_NM2}'
						)">
			${chman.WORK_TYPE_CODE_NM}</a>
		</td>
		 
		<td align="left">
			<c:if test="${chman.USE_YN == 'N'}">
		   		&nbsp;&nbsp;
				<STRIKE style="color: red;font-weight: bolder;">
					<a href="javascript:jf_pjt('${chman.PJT_NO}', 
						'${chman.PJT_NAME}', 
						'${chman.CORP_NM}', 
						'${chman.CHMAN_NM2}'
						)">${chman.PJT_NAME}</a>
				</STRIKE>
			</c:if>
			<c:if test="${chman.USE_YN != 'N'}">
		   		&nbsp;&nbsp;
				<a href="javascript:jf_pjt('${chman.PJT_NO}', 
						'${chman.PJT_NAME}', 
						'${chman.CORP_NM}', 
						'${chman.CHMAN_NM2}'
						)">${chman.PJT_NAME}</a>
			</c:if>
			
		</td>
		<td width="10%">
		<a href="javascript:jf_pjt('${chman.PJT_NO}', 
						'${chman.PJT_NAME}', 
						'${chman.CORP_NM}', 
						'${chman.CHMAN_NM2}'
						)">
			${chman.CHMAN_NM2}</a>
		</td>		
		<td width="10%">
		<a href="javascript:jf_pjt('${chman.PJT_NO}', 
						'${chman.PJT_NAME}', 
						'${chman.CORP_NM}', 
						'${chman.CHMAN_NM2}'
						)">
			${chman.CHMAN_NM1}</a>
		</td>	
		<td width="10%">
		<a href="javascript:jf_pjt('${chman.PJT_NO}', 
						'${chman.PJT_NAME}', 
						'${chman.CORP_NM}', 
						'${chman.CHMAN_NM2}'
						)">
			${chman.CR_DATE}</a>
		</td>
	</tr>
	</c:forEach>			
		<!-- 본문 끝 -->	
</table>

<div class="paging">
	${pageNavi.pageNavigator}
</div>
<br/>
  
	<b class="rtop"><b class="r1"></b><b class="r2"></b><b class="r3"></b><b class="r4"></b></b> 
		<div class="search"> 
			<table> 
			<tr>
				<td align="center"> 
					<select name='key' class="gray_txt">
						<option value='001' <c:if test="${pMap.key == '001'}">selected</c:if>>고객사명</option>
						<option value='002' <c:if test="${pMap.key == '002'}">selected</c:if>>프로젝트명</option>
						<option value='003' <c:if test="${pMap.key == '003'}">selected</c:if>>담당자</option> 
					</select>              			
					<input enter="jf_search()" type='text' name='keyword' value='${pMap.keyword}' class="gray_txt" style="width:300px" alt="검색란" onkeypress="javascript:if(event.keyCode=='13'){jf_search();}"/> 
					<span class="gray_txt"><input type="button" class="buttonsc" value="검색" style="cursor:pointer;" onclick="jf_search()"></span> 
		    	</td>
			</tr> 
			</table>	
		</div>	
	<b class="rbottom"><b class="r4"></b><b class="r3"></b><b class="r2"></b><b class="r1"></b></b> 
	
<div class="btn">						
	<div class="leftbtn">
		<input type="button" class="button04" value="새로고침" onclick="javascript:window.location.reload();" style="cursor:hand;">
	</div>
	<div class="rightbtn">
		<!-- 권한 에 따른 쓰기기능 제어 시작  -->		
		<c:if test="${writeGrant != '0' }">
		<input type="button"  value="프로젝트 추가" class="button06" onClick="jf_pjt_view();" />
		</c:if>
	</div>
</div>	


	
<iframe name="f_chmanList" id="f_chmanList" style="display:none; height:0px; overflow:hidden;" ></iframe>

</form>


<form name="goMenu" method="post"> 
</form>