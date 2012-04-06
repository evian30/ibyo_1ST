<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/web/jsp/common/inc/commonInc.jsp" %>
<script type="text/javascript" src="/resource/common/js/validator.js" ></script>
<script src="/resource/common/js/MultiUpload.js"></script>
<script type="text/javascript" src="/resource/common/js/jquery.sg.js"></script>

<style>
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
* html .ui-autocomplete {
	height: 100px;
	width: 100px;
}
</style>

<script type="text/javascript">
<!--

$(function() {
	
	$.ajax({
		url: "/sgportal/chman/xmlChmanList.sg",
		type: "POST",
		data: "comT=1",
		success: function( xmlResponse ) {
			var data = $( "Service", xmlResponse ).map(function() {
				return {
					value: $( "CHMAN_NM", this ).text() + "/" + 
						$( "GRADE_CODE", this ).text() + "/" + $( "DEPT_CODE", this).text(),
					chmanNm: $( "CHMAN_NM", this ).text(),
					chmanNo: $( "CHMAN_NO", this ).text(),
					gradeCode: $( "GRADE_CODE", this).text(),
					deptCode: $( "DEPT_CODE", this).text()
				};
			}).get();
			$( "#addDev_chman_nm" ).autocomplete({
				source: data,
				minLength: 0,
				select: function( event, ui ) {
					var kc = event.keyCode;
					//if(kc != 37 && kc != 38 && kc != 39 && kc != 40){
						document.vForm.addDev_chman_no.value = ui.item.chmanNo;
						document.vForm.addGradeCode.value = ui.item.gradeCode;
						document.vForm.addDeptCode.value = ui.item.deptCode;
						document.vForm.addDevChman_nm.value = ui.item.chmanNm;
					//}
				}
			});
		} 
	});
});





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
	$( "#selOs" ).combobox();
	$( "#reg_origin" ).combobox();
});





function test22(){
	var param = "prod_no=PR5";
	httpRequest("POST", "/sgportal/product/testXml.sg", param, true, callBack22);
	}

	var callBack22 = function() {
		if( ajax.readyState==4 ) {
			if (ajax.status == 200) {
				var ajaxXml = ajax.responseXML;
				var dataDocument = ajaxXml.getElementsByTagName("root");
				alert(dataDocument.length);
				if(dataDocument != undefined && typeof(dataDocument) == 'object') {
	            	for(var i = 0; i < dataDocument.length; i++) {
	            		try{ 
							alert(dataDocument[i].getElementsByTagName('SW_NO')[0].text);
						   /*
						   var message = dataDocument[i].getElementsByTagName('MESSAGE')[0].text;
							 
						   if(message !='')	{
							   alert( message);
						   if('1001'==dataDocument[i].getElementsByTagName('ERRCODE')[0].text)
						       location.href ="http://asp.suninlaw.com/lyps/service/member/editMember.sg";
						   }    					  

	  					   */
	            			  	
	            		}catch(e){
	            			 //reloadEvent();	
	           			 
	           		}
	           	}
	       	}
	           //blockClick = false;
	      }
		}
		
	}

function jf_ins(){
	if(document.vForm.dev_chman_no.value == ''){
		alert('담당자를 선택해주세요.');
		return false;
	}
	
	document.vForm.actType.value="ins"; 
	if(Validator.validate(document.vForm)){
		document.vForm.action = "/sgportal/product/productAction.sg";
		document.vForm.submit();
	}
}

function jf_mod(){
	document.vForm.actType.value="mod"; 
	//if(Validator.validate(document.vForm)){
		document.vForm.action = "/sgportal/product/productAction.sg";
		document.vForm.submit();
	//}
}

function jf_modView(){
	document.vForm2.actType.value="mod"; 
	document.vForm2.action = "/sgportal/product/prodAction.sg";
	document.vForm2.submit();
}

function jf_prodView(){
	document.vForm2.actType.value="view"; 
	document.vForm2.action = "/sgportal/product/prodAction.sg";
	document.vForm2.submit();
}


var Origin = new Array();
<c:forEach items="${swList}" var="list" varStatus="i">
	Origin[${i.index}] = "${list.VALUE}||${list.SW_NO}||${list.CODE}";	 	            
</c:forEach>


function jf_RegType(form){
	var delIndex = document.vForm.reg_origin.length;
	for(i = delIndex; i >=0; i--){
		document.vForm.reg_origin.remove(i);
	}
	//document.getElementById("reg_origin").style.display = "block";
	
	var option = new Option("선택", "");
	document.vForm.reg_origin.options[0]= option;

	for(var i = 0; i < Origin.length; i++){
		var temp = Origin[i].split("||");
		var id = temp[0];
		var nm = temp[1];
		var value = temp[2];
	
		if(form.value== id){
			var option = new Option(value,nm );
			var AddIndex = document.vForm.reg_origin.length;
			document.vForm.reg_origin.options[AddIndex]= option;
		}
	} 
}

function jf_addRow(){

if(${pMap.actType != 'ins'}){
	for(var i=0;i<document.vForm.u_sw_code.length;i++){
		if(document.vForm.u_sw_code[i].value == document.vForm.reg_origin.value){
			alert("이미 등록된 소프트웨어 입니다.");
			return false;
		}
	}
	
}

	for(var i=0;i<document.vForm.sw_code.length;i++){
		if(document.vForm.sw_code[i].value == document.vForm.reg_origin.value){
			alert("이미 등록된 소프트웨어 입니다.");
			return false;
		}
	}




	if(document.vForm.reg_origin.value == ''){
		alert('소프트웨어를 선택해주세요.');
		return false;
	}else{
		var fm =document.vForm;
		var id=fm.sw.options[fm.sw.selectedIndex].value;
		var nm=fm.reg_origin.options[fm.reg_origin.selectedIndex].text;
		var value=fm.reg_origin.options[fm.reg_origin.selectedIndex].value;
		var $table = $("#MainTable");
		var rows =$table.find('tr').get().length;
	
		var template = "<tr id='addMainTable"+rows+"' id='odd'><th scope='col' id='odd'>"+id+"</th>" +
		"<td >"+nm+
		"<input type='hidden' name='sw_code' class='Input_w' style='width:70%' value='"+value+"'></td>" +
		"<td align='center'><a href='javascript:jf_deleteRow(\"addMainTable"+rows+"\");'>[삭제]</a></td></tr>";

		$("#MainTable").append(template);
	}
}


function jf_osaddRow(){
	
	if(${pMap.actType != 'ins'}){
		for(var i=0;i<document.vForm.u_os_no.length;i++){
			if(document.vForm.u_os_no[i].value == document.vForm.selOs.value){
				alert("이미 등록된 운영체제 입니다.");
				return false;
			}
		}
		
	}

		for(var i=0;i<document.vForm.os_no.length;i++){
			if(document.vForm.os_no[i].value == document.vForm.selOs.value){
				alert("이미 등록된 운영체제 입니다.");
				return false;
			}
		}

	
	if(document.vForm.selOs.value == ''){
		alert('운영체제를 선택해주세요.');
		return false;
	}else{
		var fm = document.vForm;
		var so_no = document.vForm.selOs[fm.selOs.selectedIndex].text;
		var code = document.vForm.selOs[fm.selOs.selectedIndex].value;
		
		var $table = $("#osTable");
		var rows =$table.find('tr').get().length;
		 
		var template = "<tr id='osTr"+rows+"' class='addtrOs'>" +
		"<th scope='col' id='odd' class='addtrOs'>" + so_no + "</th>" +
		"<input type='hidden' name='os_no' value='" + code + "' />" +
		"<td align='center'><a href='javascript:jf_osDeleteRow(\"osTr"+rows+"\");'>[삭제]</a></td></tr>";

		$("#osTable").append(template);

		
	}
	
}

function jf_osDeleteRow(id){
	$("#"+id).remove();
	
}

function jf_osDeleteRow2(id, seq){
	var html = '<input type="hidden" name="del_os" value="'+seq+'" />';
	$("#" + id).attr("style", "display:none");
	
	$("#osTable").append(html);
	
}

function jf_chmanaddRow(){ 

if(${pMap.actType != 'ins'}){
	for(var i=0;i<document.vForm.u_dev_chman_no.length;i++){
		if(document.vForm.u_dev_chman_no[i].value == document.vForm.addDev_chman_no.value){
			alert("이미 등록된 개발담당자 입니다.");
			return false;
		}
	}
}

	for(var i=0;i<document.vForm.dev_chman_no.length;i++){
		if(document.vForm.dev_chman_no[i].value == document.vForm.addDev_chman_no.value){
			alert(document.vForm.addDev_chman_nm.value + "님은 이미 등록된 개발담당자 입니다.");	
			return false;
		}
	}


	if(document.vForm.addDev_chman_no.value == ''){
		alert('개발담당자를 선택해주세요.');
		return false;
	}else{
		var fm = document.vForm;
		var no = document.vForm.addDev_chman_no.value;
		var nm = document.vForm.addDevChman_nm.value;
		var gradeCode = document.vForm.addGradeCode.value;
		var deptCode = document.vForm.addDeptCode.value;


		var $table = $("#devChmanTable");
		var rows =$table.find('tr').get().length;
		 
		var template = "<tr id='devChmanTr"+rows+"' class='addtrChman'>" +
		"<th scope='col' id='odd' class='addtrChman'>"+nm+ "</th><td style='padding-left: 10px'>" + gradeCode + " / " + deptCode +
		"<input type='hidden' name='dev_chman_no' value='"+no+"' />" +
		"<input type='hidden' name='dev_chman_nm' class='Input_w' style='width:70%' value='"+nm+"' /></td>" +
		"<td align='center'><a href='javascript:jf_chmanDeleteRow(\"devChmanTr"+rows+"\");'>[삭제]</a></td></tr>";

		$("#devChmanTable").append(template);

		
	}
}






function jf_chmanDeleteRow(id){
	$("#"+id).remove();
	
}

function jf_chmanDeleteRow2(id, seq){
	var html = '<input type="hidden" name="del_seq" value="'+seq+'" />';
	$("#" + id).attr("style", "display:none");
	
	$("#MainTable").append(html);
	
}

function jf_deleteRow(obj){
	$("#"+obj).remove();
}

function jf_deleteRow2(id, sw_no){
	var html = '<input type="hidden" name="del_sw" value="'+sw_no+'" />';
	
	//$("#" + id).remove();
	$("#" + id).attr("style", "display:none");
	
	$("#MainTable").append(html);
}

function jf_srcChman(corp_no, comT){  
	var param = "comT=" + comT + "&corp_no=" + corp_no + "&viewName=/sgportal/techsup/chmanPopup&srcType=prod";
	var url = "/sgportal/chman/chmanList.sg?" + param;
	window.open(url, "", "width=800, height=500, left=250, top=50, scrollbars=yes, resizable=no, menubar=no");
}

function jf_cancel(){
	$(".trSw").attr("style", "display:block");
	$(".addtrSw").remove();
	$(".addtrChman").remove();
	
	document.vForm.del_seq.value = "";
	document.vForm.reset();
}

function jf_list(){
	document.vForm2.actType.value="list"; 
	document.vForm2.prod_no.value = "";
	document.vForm2.action = "/sgportal/product/productList.sg";
	document.vForm2.submit();
}



function jf_del(){
	if(confirm('삭제 하겠습니까?')){
	 	document.vForm.actType.value = 'mod';
	 	document.vForm.action = "/sgportal/product/productAction.sg";
	 	//document.vForm.submit();
	}
}

function jf_per_del(){
	if(confirm('영구삭제 하겠습니까?')){
	 	document.vForm.actType.value = 'del';
	 	document.vForm.action = "/sgportal/product/productAction.sg";
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
	 	document.vForm.action = "/sgportal/product/productAction.sg?use_yn=" + value;
	 	document.vForm.submit();
	}
}

	
//-->
</script>
<c:set var="groups" value="${fn:split(sessionMap.GROUPS, ',')}" />

<form name='vForm2' method='post'>
<input type="hidden" name="actType" id="actType" />  
<input type="hidden" name="prod_no" id="prod_no" value="${pMap.prod_no}" />
<input type="hidden" name="prod_seq" id="prod_seq"  />
<input type="hidden" name="sw_code" id=sw_code />
<input type="hidden" name="del_sw" id="del_sw" />
<input type="hidden" name="del_seq" id="del_seq" />
<input type="hidden" name="dev_chman_no" id=dev_chman_no />
<input type="hidden" name="os_no" id="os_no" />
<input type="hidden" name="del_os" id="del_os" />

</form>


<form name='vForm' method='post' enctype="multipart/form-data"> 
<input type="hidden" name="actType" id="actType" />  
<input type="hidden" name="prod_no" id="prod_no" value="${pMap.prod_no}" />
<input type="hidden" name="prod_seq" id="prod_seq" value="${pMap.prod_seq}" />
<input type="hidden" name="sw_code" id=sw_code />
<input type="hidden" name="del_sw" id="del_sw" />
<input type="hidden" name="del_seq" id="del_seq" />
<input type="hidden" name="dev_chman_no" id=dev_chman_no />
<input type="hidden" name="os_no" id="os_no" />
<input type="hidden" name="del_os" id="del_os" />

<input type="hidden" name="u_dev_chman_no" id="u_dev_chman_no" />
<input type="hidden" name="u_sw_code" id="u_sw_code" />
<input type="hidden" name="u_os_no" id="u_os_no" />


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
			> 
			<c:if test="${pMap.actType == 'view'}">조회</c:if>
			<c:if test="${pMap.actType == 'mod'}">수정</c:if>
			<c:if test="${pMap.actType == 'ins'}">등록</c:if> 
		</div>
	</div>



<table width="100%" border="0" cellpadding="0" cellspacing="0" class="grid" rules="cols">
	    <tr>
                   <td colspan="2" id="odd" scope="col">제품명</td>
                   <td>
                   <c:choose>
			<c:when test="${pMap.actType == 'ins' || pMap.actType == 'mod'}">
				&nbsp;
				<input title="제품명" type='text' class="Input_w required inputTex" name='prod_nm' size="100%" maxlength='100' value="${productView.PROD_NM}">
			</c:when>
			<c:otherwise>
			 	&nbsp;&nbsp;${productView.PROD_NM}
			</c:otherwise>
		  </c:choose> 
           	</td>
        </tr>
	    <tr>
            <td width="20%" colspan="2" id="odd" scope="col">버전</td>
            <td>
            <c:choose>
			<c:when test="${pMap.actType == 'ins' || pMap.actType == 'mod'}">
				&nbsp;&nbsp;<input title="버전" type='text' class="Input_w required inputTex" name='prod_ver' size="10%" maxlength='100' value="${productView.PROD_VER}">
			</c:when>
			<c:otherwise>
			 	&nbsp;&nbsp;${productView.PROD_VER}
			</c:otherwise>
		  </c:choose> 
	      </td>
	    </tr>
	    <tr>
          <td colspan="2" id="odd" scope="col">출시일</td>
	      <td>
	      	 <c:choose>
				<c:when test="${pMap.actType == 'ins' || pMap.actType == 'mod'}">
					 &nbsp;
					 <input type="text" value="${productView.RELEASE_DATE}" name="release_date" class="Input_w" readonly="readonly">
		          	 <input type="image" src="/resource/images/admin/img/ic_calendar.gif"   readonly="readonly" value="${productView.RELEASE_DATE}"
         								onclick="calPopup(this, 'mypopup', 0, 20, 'document.vForm.release_date', ''); return false;"  align="middle" width="16" height="16" />
         				
				</c:when>
				<c:otherwise>
				 	&nbsp;&nbsp;${productView.RELEASE_DATE}
				</c:otherwise>
			  </c:choose> 
	      	 
	      	</td>
        </tr>
	    <tr>
          <td colspan="2" id="odd" scope="col">개발담당자</td>
	      <td style="padding-left: 10px">
	      	<table width="70%" id="devChmanTable" border="0" class="grid02">
	      		<c:if test="${pMap.actType == 'ins' || pMap.actType == 'mod'}">
	      		<tr>
	      			<td colspan="2">
	      				<input type="hidden" name="addDevChman_nm" class="Input_w" readonly="readonly" value="" />
				      	<input type="hidden" name="addDev_chman_no" class="Input_w" readonly="readonly" value="" />
				      	<input type="hidden" name="addGradeCode" class="Input_w" readonly="readonly" value="" />
				      	<input type="hidden" name="addDeptCode" class="Input_w" readonly="readonly" value="" />
				      	<input type="text" width="450" name="addDev_chman_nm" id="addDev_chman_nm" class="Input_w" value="" />
				      	<input type="button" class="buttonsmall05" value="담당자검색" onclick="jf_srcChman('COR1011022247591', 'SG')" /> 
			      	</td>
				    <td style="width:15%" align="center">
				    	<p onclick="jf_chmanaddRow()">
			        		<strong style="cursor:pointer">추가</strong>
			        	</p>
			        		
				    </td>
				 </tr>
				 </c:if>
								 	
				
					<c:forEach items="${productDevChman}" var="sw" varStatus="i">
					<tr id="devChmanTr${i.index+1}" >
						<c:if test="${pMap.actType == 'view'}">
							<th scope="col" id="odd" colspan="2">
								[ ${sw.CHMAN_NM} ] &nbsp;&nbsp;&nbsp; 
							 
								${sw.GRADE_CODE} / 
								${sw.DEPT_CODE} 
								<input type='hidden' name='u_dev_chman_no' value="${sw.CHMAN_NO}">
							</th>
						</c:if>
						
						<c:if test="${pMap.actType == 'mod'}">
							<th scope="col" id="odd" colspan="2">
								[ ${sw.CHMAN_NM} ] &nbsp;&nbsp;&nbsp;
							
							 
								${sw.GRADE_CODE} / 
								${sw.DEPT_CODE} 
								<input type='hidden' name='u_dev_chman_no' value="${sw.CHMAN_NO}">
							</th>
						<td align="center">
							 <p onclick="jf_chmanDeleteRow2('devChmanTr${i.index+1}', '${sw.SEQ}')">
							 <span style="cursor:pointer"><b>[삭제]</b></span>
							 </p>
						</td>
						</c:if>
					</tr>
					</c:forEach>
				
				 
			 </table>
	      	
	      </td>
        </tr>
	    <tr>
          <td colspan="2" id="odd" scope="col">제품유형</td>
	      <td>
	      	<c:choose>
	      		<c:when test="${pMap.actType == 'ins' || pMap.actType == 'mod'}">
	      			&nbsp;&nbsp;
	      			<input <c:if test="${pMap.actType == 'ins'}">checked="checked"</c:if> class="validate-one-required" type="radio" name="prod_type_code" id="prod_type_code" value="1"  <c:if test="${productView.PROD_TYPE_CODE == '1'}"> checked="checked" </c:if>   />
					<label for="tran_type1">서버 </label> &nbsp;&nbsp;
					
					<input  class="validate-one-required" type="radio" name="prod_type_code" id="prod_type_code" value="2"  <c:if test="${productView.PROD_TYPE_CODE == '2'}"> checked="checked" </c:if>   />
					<label for="tran_type2">클라이언트</label> &nbsp;&nbsp; 

	      		</c:when>
	      		<c:otherwise>
	      			&nbsp;&nbsp;${productView.PROD_TYPE_CODE_NM}
	      		</c:otherwise>
	      	</c:choose>
	      </td>
        </tr>
       
	    <tr>
          <td colspan="2" id="odd" scope="col">메뉴얼 / 브로셔
	      <td>
	      	  <c:choose>
	      	  	<c:when test="${pMap.actType == 'view'}">
					<c:forEach items="${fileView}" var="file" varStatus="i">
	      	  			&nbsp;&nbsp;
	      	  			<a href="/download.ddo?fid=addfile&add_file_no_key=${file.ADD_FILE_NO}&no_key=${file.NO}">${file.FILE_REAL_NM}</a> 
						<br />
					</c:forEach>
				</c:when>
				<c:when test="${pMap.actType == 'mod'}">
					<c:forEach items="${fileView}" var="file" varStatus="i">
						&nbsp;&nbsp;
						<a href="/download.ddo?fid=addfile&add_file_no_key=${file.ADD_FILE_NO}&no_key=${file.NO}">${file.FILE_REAL_NM}</a> 
						<input type="checkbox" name="del_chk${i.index+1}" id="del_chk${i.index+1}" value="${file.ADD_FILE_NO}">
						<label for="del_chk${i.index+1}">[파일삭제]</label><br />
					</c:forEach>
					 <br /><br />
	      	  		 <div id='uploadData' style="overflow:hidden;position:relative;top:-5px;left:0;filter:alpha(opacity=0);">
					  	&nbsp;&nbsp;
					  	<input type=file name='upload' id='upload_data0' onchange=fnMUpload(this) style="width:0;cursor:pointer">
					 </div>
					 <div id=uploadView></div>
	      	  	</c:when>
	      	  	<c:when test="${pMap.actType == 'ins'}">
	      	  		 <div id='uploadData' style="overflow:hidden;position:relative;top:-5px;left:0;filter:alpha(opacity=0);">
					  	<input type=file name='upload' id='upload_data0' onchange=fnMUpload(this) style="width:0;cursor:pointer">
					 </div>
					 <div id=uploadView></div>
	      	  	</c:when>
	      	  	<c:otherwise>
	      	  	
	      	  	</c:otherwise>
	      	  </c:choose>
	      </td>
								
        </tr>
	    <tr>
          <td rowspan="3" id="odd" scope="col">권장사양</td>
	      <td scope="col" id="odd">하드웨어</td>
	      <td style="padding-left: 10px">
	      		<c:choose>
		      	  	<c:when test="${pMap.actType == 'ins' || pMap.actType == 'mod'}">
		      	  		<table width="70%" border="0" cellpadding="0" cellspacing="0" class="grid02">
							<tr>
								<th scope="col" id="odd" width="20%" align="left">CPU</th>
								<td>
									<input size="50%" type="text" name="recmd_cpu" class="Input_w " value="${productView.RECMD_CPU}" />
								</td> 
							</tr>
							<tr>
								<th scope="col" id="odd" width="20%" align="left">기본 메모리</th>
								<td>
									<input size="50%" type="text" name="recmd_mem" class="Input_w " value="${productView.RECMD_MEM}" />
								</td> 
							</tr> 
							<tr>
								<th scope="col" id="odd" width="20%" align="left">최소 저장공간</th>
								<td>
									<input size="50%" type="text" name="recmd_disk" class="Input_w " value="${productView.RECMD_DISK}" />
								</td> 
							</tr>  
							<tr>
								<th scope="col" id="odd" width="20%" align="left">NIC</th>
								<td>
									<input size="50%" type="text" name="recmd_nic" class="Input_w " value="${productView.RECMD_NIC}" />
								</td> 
							</tr>   
						</table> 
		      	  	</c:when>
		      	  	<c:otherwise>
		      	  		<table width="70%" border="0" cellpadding="0" cellspacing="0" class="grid02">
							<tr>
								<th scope="col" id="odd" width="20%" align="left">CPU</th>
								<td style="padding-left: 10px">
									${productView.RECMD_CPU}
								</td> 
							</tr>
							<tr>
								<th scope="col" id="odd" width="20%" align="left">기본 메모리</th>
								<td style="padding-left: 10px">
									${productView.RECMD_MEM}
								</td> 
							</tr> 
							<tr>
								<th scope="col" id="odd" width="20%" align="left">최소 저장공간</th>
								<td style="padding-left: 10px">
									${productView.RECMD_DISK}
								</td> 
							</tr>  
							<tr>
								<th scope="col" id="odd" width="20%" align="left">NIC</th>
								<td style="padding-left: 10px">
									${productView.RECMD_NIC}
								</td> 
							</tr>   
						</table>
		      	  	</c:otherwise>
		      	  </c:choose>
	      		
	     </td>
        </tr>
	    <tr>
          <td id="odd" scope="col">운영체제</td>
	      <td style="padding-left: 10px">
	      	<table width="70%" id="osTable" border="0" class="grid02">
		       <c:if test="${pMap.actType == 'ins' || pMap.actType == 'mod'}">
		       <tr>
		       <td>
					<select  name="selOs" id="selOs" title="운영체제 " >
						<option value="">
							선택
						</option>
						<c:forEach items="${osList}" var="code" varStatus="i">
						<option <c:if test="${code.CODE == productView.OS_NO}"> selected</c:if> value="${code.CODE}">
							${code.VALUE}
						</option>
						</c:forEach>
					  </select>
				</td>
				<td align="center" style="width:15%">
			    	<p onclick="jf_osaddRow()">
		        		<strong style="cursor:pointer">추가</strong>
		        	</p>	
			    </td>
				</tr>
	      	  	</c:if>
	      	  
	      	  	
	      	  	<c:forEach items="${productOs}" var="sw" varStatus="i"> 
	      	  		<tr id="osTr${i.index+1}">
						<c:if test="${pMap.actType == 'view'}">
							<th scope="col" id="odd">
								${sw.OS_NM}  ${sw.OS_VER} (${sw.OS_MANUFACT})
								<input type='hidden' name='u_os_no' value="${sw.OS_NO}">
							</th>
						</c:if>
						
						<c:if test="${pMap.actType == 'mod'}">
							<th scope="col" id="odd">
								${sw.OS_NM}  ${sw.OS_VER} (${sw.OS_MANUFACT})
								<input type='hidden' name='u_os_no' value="${sw.OS_NO}">
							</th>
							
						<td align="center">
							 <p onclick="jf_osDeleteRow2('osTr${i.index+1}', '${sw.SEQ}')">
							 <span style="cursor:pointer"><b>[삭제]</b></span>
							 </p>
						</td>
						</c:if>
					</tr>
					</c:forEach>
	      	  
	      	  </table>
			</td>
	    </tr>
	    
	    <!-- 소프트웨어 -->
	    <tr>
          <td id="odd" scope="col">소프트웨어</td>
	      <td style="padding-left: 10px">  
	      <table  width="70%" border="0" cellpadding="0" cellspacing="0"  class="grid02" id="MainTable">
		      <tr>
			    
	      		<c:choose>
		      	  	<c:when test="${pMap.actType == 'ins' || pMap.actType == 'mod'}">
		      	  		<td>
		      	  		<select class="" name="sw" id="sw" onchange="jf_RegType(this);" title="소프트웨어 " >
							<option value="">선택</option>
							<c:forEach items="${swNameList}" var="code" varStatus="i">
								<option <c:if test="${code.CODE == list.WORK_TYPE_CODE}"> selected</c:if> value="${code.CODE}">${code.VALUE}</option>
							</c:forEach>
						</select>
						</td>
		      	  	</c:when>
		      	  	
		      	  	<c:otherwise> 
		      	  		<c:forEach items="${productSw}" var="sw" varStatus="i">  
							<th scope="col" id="odd" width="20%" align="left">${sw.SW_CODE_NM}</th>
		      	  			<td style="padding-left: 10px">${sw.SW_NM}</td>
		      	  			<td style="padding-left: 10px">${sw.SW_VER}</td> 
		      	  		</tr>
		      	  		</c:forEach>
		      	  	</c:otherwise>
		      	  </c:choose>
			       
			      
			      <c:if test="${pMap.actType == 'ins' || pMap.actType == 'mod'}">
				      <td>
				      	<c:choose>
				      	  	<c:when test="${pMap.actType == 'ins' || pMap.actType == 'mod'}">
				      	  		<select name="reg_origin" id="reg_origin" title="소프트 웨어" style="display: none;"
									></select>	
				      	  	</c:when>
				      	  	<c:otherwise>
				      	  		
				      	  	</c:otherwise>
				      	  </c:choose>
				     </td>
					 <td style="width:15%" align="center">
					 	<c:if test="${pMap.actType == 'ins' || pMap.actType == 'mod'}">
				        	<p onclick="jf_addRow()">
				        		<strong style="cursor:pointer">추가</strong>
				        	</p>	
				        </c:if>
					 </td>
				 </c:if>
		      </tr>
			<c:if test="${pMap.actType == 'mod'}">
			<c:forEach items="${productSw}" var="sw" varStatus="i">
			<tr id="MainTable${i.index+1}">
				<th scope="col" id="odd"  width="20%">${sw.SW_CODE_NM}</th>
				<!-- [MainTable${i.index+1}]  -->
				<td>
					${sw.SW_NM} / 버젼 ${sw.SW_VER}
					<input type='hidden' name='u_sw_code' class='Input_w' style='width:70%' 
						value="${sw.SW_NO}"></td>
				<td align="center">
					<p onclick="jf_deleteRow2('MainTable${i.index+1}', '${sw.SW_NO}')">
						<span style="cursor:pointer"><b>[삭제]</b></span>
					</p>
				</td>
			</tr>
			</c:forEach>
			</c:if>
		  </table>
	      </td>
	    </tr>
	    
	    
	    <tr>
                   <td rowspan="2" id="odd" scope="col">제품소개</td>
	      <td id="odd" scope="col">소개</td>
	      <td>
	      	<c:choose>
	      	  	<c:when test="${pMap.actType == 'ins' || pMap.actType == 'mod'}">
	      	  		 &nbsp;
	      	  		 <input value="${productView.PROD_INTRO}"
	      	  		 	type="text" name="prod_intro" class="Input_w " style="width:70%" />
	      	  	</c:when>
	      	  	<c:otherwise>
	      	  		&nbsp;&nbsp;${productView.PROD_INTRO}
	      	  	</c:otherwise>
	      	  </c:choose>
	      </td>
        </tr>
        
	    <tr>
          <td id="odd" scope="col">기능</td>
	      <td>
	      	<c:choose>
	      	  	<c:when test="${pMap.actType == 'ins' || pMap.actType == 'mod'}">
	      	  		 &nbsp;
	      	  		 <input value="${productView.PROD_ABLE}"
	      	  		 	type="text" name="prod_able" class="Input_w " style="width:70%" />
	      	  	</c:when>
	      	  	<c:otherwise>
	      	  		&nbsp;&nbsp;${productView.PROD_ABLE}
	      	  	</c:otherwise>
	      	  </c:choose>
	     </td>
        </tr>
	   <!-- 
	    <tr>
          <td colspan="2" id="odd" scope="col">브로셔</td>
	      <td>
				<c:choose>
	      	  	<c:when test="${pMap.actType == 'view'}">
					<c:forEach items="${fileView}" var="file" varStatus="i">
	      	  			<a href="/download.ddo?fid=addfile&add_file_no_key=${file.ADD_FILE_NO}&no_key=${file.NO}">${file.FILE_REAL_NM}</a> 
						<br />
					</c:forEach>
				</c:when>
				<c:when test="${pMap.actType == 'mod'}">
					<c:forEach items="${fileView}" var="file" varStatus="i">
						<a href="/download.ddo?fid=addfile&add_file_no_key=${file.ADD_FILE_NO}&no_key=${file.NO}">${file.FILE_REAL_NM}</a> 
						<input type="checkbox" name="del_chk${i.index+1}" id="del_chk${i.index+1}" value="${file.ADD_FILE_NO}">
						<label for="del_chk${i.index+1}">[파일삭제]</label><br />
					</c:forEach>
					 <br /><br />
	      	  		 <div id='uploadData' style="overflow:hidden;position:relative;top:-5px;left:0;filter:alpha(opacity=0);">
					  	<input type=file name='upload' id='upload_data0' onchange=fnMUpload(this) style="width:0;cursor:pointer">
					 </div>
					 <div id=uploadView></div>
	      	  	</c:when>
	      	  	<c:when test="${pMap.actType == 'ins'}">
	      	  		 <div id='uploadData' style="overflow:hidden;position:relative;top:-5px;left:0;filter:alpha(opacity=0);">
					  	<input type=file name='upload' id='upload_data0' onchange=fnMUpload(this) style="width:0;cursor:pointer">
					 </div>
					 <div id=uploadView></div>
	      	  	</c:when>
	      	  	<c:otherwise>
	      	  	
	      	  	</c:otherwise>
	      	  </c:choose>
	      	
		  </td>
	  	</tr>
	  	 -->
	  	
	    <tr>
          <td colspan="2" id="odd" scope="col">기능 변경 사항 </td>
	      <td>
	      	<c:choose>
	      	  	<c:when test="${pMap.actType == 'ins' || pMap.actType == 'mod'}">
	      	  		 &nbsp;
	      	  		 <textarea name="prod_mod_contents" rows="5" style="width:70%">${productView.PROD_MOD_CONTENTS}</textarea>
			    </c:when>
	      	  	<c:otherwise>
	      	  		&nbsp;&nbsp;${productView.PROD_MOD_CONTENTS}
	      	  	</c:otherwise>
	      	  </c:choose>
		      
		   </td>
        </tr>

        </table>
        </td>
	</tr>
</table>
</form>

<div class="btn">						
	<div class="leftbtn">
		<input type="button" class="button02" value="목록" onclick="jf_list()" style="cursor:hand;" />
	</div>
	<div class="rightbtn">
		<!-- 권한 에 따른 쓰기기능 제어 시작  -->		
			<c:if test="${writeGrant != '0' }">
				<c:if test="${pMap.actType == 'view'}">
					<c:forEach items="${groups}" var="group" varStatus="i">
						<c:if test="${group == 'G001'}">
							<input type="button" class="button02" value="수정" onclick="jf_modView()" style="cursor:hand;" />
							<c:if test="${productView.USE_YN == 'Y'}">
								<input type="button" class="button02" value="삭제" onclick="jf_use_yn('N')" style="cursor:hand;">
								<!-- 
								<input type="button" class="button04" value="영구삭제" onclick="jf_per_del()" style="cursor:hand;">
							 -->
							</c:if>
							<c:if test="${productView.USE_YN == 'N'}">
								<input type="button" class="button02" value="복구" onclick="jf_use_yn('Y')" style="cursor:hand;">
							</c:if>
						</c:if>
						<c:if test="${group != 'G001'}"> 
								<input type="button" class="button02" value="수정" onclick="jf_modView()" style="cursor:hand;" />
							<c:if test="${productView.CHMAN_NO ==  productView.LCHMAN_NO}">	
								<c:if test="${productView.USE_YN == 'Y'}">
									<input type="button" class="button02" value="삭제" onclick="jf_use_yn('N')" style="cursor:hand;">
								</c:if>
								<c:if test="${productView.USE_YN == 'N'}">
									<input type="button" class="button02" value="복구" onclick="jf_use_yn('Y')" style="cursor:hand;">
								</c:if> 
							</c:if>
						</c:if>
					</c:forEach>
				</c:if>
				<c:if test="${pMap.actType == 'ins'}">
                          <input type="button" class="button02" value="추가" onclick="jf_ins()" style="cursor:hand;">
					<input type="button" class="button03" value="초기화" onclick="jf_cancel()" style="cursor:hand;">
				</c:if>
				<c:if test="${pMap.actType == 'mod'}">
                          <input type="button" class="button02" value="뒤로" onclick="jf_prodView()" style="cursor:hand;">
					<input type="button" class="button02" value="수정" onclick="jf_mod()" style="cursor:hand;">
					<input type="button" class="button03" value="초기화" onclick="jf_cancel()" style="cursor:hand;">
				</c:if>
			</c:if>
		<!-- 권한 에 따른 쓰기기능 제어 시작  -->	
	</div>
</div>	

<!-- 
<input type="button" class="button03" value="test" onclick="test22()" style="cursor:hand;">
 -->

<div id="mypopup" style="position: absolute; visibility: hidden; z-index: 0; background-color: #99BDDF;"></div>


