<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="com.signgate.core.web.util.*"%>
<%@ include file="/WEB-INF/web/jsp/common/inc/commonInc.jsp"%>

<link rel="stylesheet" type="text/css"  href="/resource/common/css/common_renew.css" />
<script type="text/javascript" src="/resource/common/js/ajax.js"></script>

<script type="text/javascript"> 
var menu01Dpeth = new Array();
var menu02Dpeth = new Array();
var menu03Dpeth = new Array();
var idx1 = 0;
var idx2 = 0;
var idx3 = 0;

<c:forEach items="${menuAllList}" var="menu" varStatus="i">
	<c:if test="${menu.MENU_THREAD == '1'}">
		menu01Dpeth[idx1] = "${menu.MENU_ID}||${menu.MENU_NM}";
		++idx1;
	</c:if>
	<c:if test="${menu.MENU_THREAD == '2'}">
		menu02Dpeth[idx2] = "${menu.MENU_ID}||${menu.MENU_NM}";
		++idx2;
	</c:if>
	<c:if test="${menu.MENU_THREAD == '3'}">
		menu03Dpeth[idx3] = "${menu.MENU_ID}||${menu.MENU_NM}";
		++idx3
	</c:if>
</c:forEach>



function jf_sbumit(){
	document.vForm.action = "/core/manage/menu/menuUpdateAction.sg";
	document.vForm.submit();
}

function jf_delMenu(gubun){
	if(document.vForm.menu_id.value == ""){
		alert('삭제할 메뉴를 선택하세요');
	}else{
		if(confirm('정말 삭제 하시겠습니까?')){
			document.vForm.action = "/core/manage/menu/menuDeleteAction.sg";
			document.vForm.submit();
		}
	}
}
</script>


<div style="width:70%;">  

	<form name='vForm' method='post'>
	<input type='hidden' id="menu_id" name='menu_id'> 
	<input type='hidden'id="menu_thread" name='menu_thread'>
	 
	
	<table border="0" width="900" height="">
			<tr>
				<td colspan="2"> 
					<div class=" x-panel x-form-label-left" style="width: auto">						
						<div class="x-panel-tl">
							<div class="x-panel-tr">
								<div class="x-panel-tc">
									<div class="x-panel-header x-unselectable" style="-moz-user-select: none;">
										<center><span class="x-panel-header-text">메뉴분류 등록</span></center>
									</div>
								</div>
							</div>
						</div> 
					</div> 
				</td>
			</tr>
	</table>  



<table width="900" border="0" cellpadding="0" cellspacing="0"  id="table_gray" rules="cols" summary="관리자 관리" class="grid">
	<tr>
		<td align='center'>
			<table id="" border="0" class="grid">
			<!-- 권한 에 따른 쓰기기능 제어 시작  -->		
			<c:if test="${writeGrant != '0' }">
				<tr>
					<td><a href="javascript:jf_addMenu('1')">메뉴추가</a></td>
					<td><a href="javascript:jf_delMenu('1')">메뉴삭제</a></td>
					<td><a href="javascript:jf_upMove('1')">위로</a> | <a href="javascript:jf_downMove('1')">아래로</a></td>
				</tr>
			</c:if>	
			<!-- 권한 에 따른 쓰기기능 제어 끝  -->	
				<tr>
					<td colspan='3'>
						<select size=10 name="menu01" style="width:200px;height:200px;" onchange="javascript:twoMenuView(this)"></select>
					</td>
				</tr>
			</table>
		</td>
		<td align='center'>
			<table class="grid">
			<!-- 권한 에 따른 쓰기기능 제어 시작  -->		
			<c:if test="${writeGrant != '0' }">
				<tr>
					<td><a href="javascript:jf_addMenu('2')">메뉴추가</a></td>
					<td><a href="javascript:jf_delMenu('2')">메뉴삭제</a></td>
					<td><a href="javascript:jf_upMove('2')">위로</a> | <a href="javascript:jf_downMove('2')">아래로</a></td>
				</tr>
			</c:if>	
			<!-- 권한 에 따른 쓰기기능 제어 끝  -->		
				<tr>
					<td colspan='3'><select size=10 name="menu02"
						style="width:200px;height:200px;"
						onchange="javascript:thirdMenuView(this)">
					</select></td>
				</tr>
			</table>
		</td>
 
		<td align='center'>
			<table class="grid">
			<!-- 권한 에 따른 쓰기기능 제어 시작  -->		
			<c:if test="${writeGrant != '0' }">
				<tr>
					<td><a href="javascript:jf_addMenu('3')">메뉴추가</a></td>
					<td><a href="javascript:jf_delMenu('3')">메뉴삭제</a></td>
					<td><a href="javascript:jf_upMove('3')">위로</a> | <a href="javascript:jf_downMove('3')">아래로</a></td>
				</tr>
			</c:if>
			<!-- 권한 에 따른 쓰기기능 제어 끝  -->	
				<tr>
					<td colspan='3'><select size=10 name="menu03"
						style="width:200px;height:200px;"
						onchange="javascript:MenuView(this)">
					</select></td>
				</tr>
			</table>
		</td> 
	</tr>
</table>
	
<table width="900" border="0" cellpadding="0" cellspacing="0">	
	<tr>
		<td colspan="3"> 
			<div class=" x-panel x-form-label-left" style="width: auto">						
				<div class="x-panel-tl">
					<div class="x-panel-tr">
						<div class="x-panel-tc">
							<div class="x-panel-header x-unselectable" style="-moz-user-select: none;">
								<center><span class="x-panel-header-text">메뉴상세정보 등록</span></center>
							</div>
						</div>
					</div>
				</div> 
			</div> 
		</td>
	</tr>
</table>
			 
<table width="900" border="0" cellpadding="0" cellspacing="0"  id="table_gray" class="grid"> 
	<tr>
		<td scope="col" id="odd">선택한 메뉴명&nbsp;</td>
		<td><input type='text' id='menu_nm' name='menu_nm' size='40'></td>
	</tr>
	
	<tr>
		<td scope="col" id="odd" width="100">메뉴PATH&nbsp;&nbsp;&nbsp;&nbsp;</td>
		<td><input type='text' id='menu_path' name='menu_path' size='80'></td>
	</tr>

	<tr>
		<td scope="col" id="odd">읽기권한&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
		<td>
		<div id='scriptReader'></div><br/>
		<div id='read_grant'></div>
		</td>
	</tr>
	<tr>
		<td scope="col" id="odd">쓰기권한&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
		<td>
		<div id='scriptWriter'></div><br/>
		<div id='write_grant'></div>
		</td>
	</tr> 
</table> 


<table width="900" border="0" cellpadding="0" cellspacing="0" >
	<tr>	
		<td style="padding-right: 10px">
		<div class="btn">						
			<div class="leftbtn">
				
			</div>
			<div class="rightbtn">
				<!-- 권한 에 따른 쓰기기능 제어 시작  -->		
				<c:if test="${writeGrant != '0' }">
					<table cellspacing="0" class="x-btn  x-btn-noicon" style="width: 50px;">
						<tbody class="x-btn-small x-btn-icon-small-left"> 
							<tr><td class="x-btn-tl"><i>&nbsp;</i></td><td class="x-btn-tc"></td><td class="x-btn-tr"><i>&nbsp;</i></td></tr>
							<tr>
								<td class="x-btn-ml"><i>&nbsp;</i></td>
								<td class="x-btn-mc">
									<em unselectable="on" class="">
										<button type="button" id="searchBtn1"  onclick="javascript:jf_sbumit();" class=" x-btn-text">메뉴저장</button>
									</em>
								</td>
								<td class="x-btn-mr"><i>&nbsp;</i></td>
							</tr>
							<tr><td class="x-btn-bl"><i>&nbsp;</i></td><td class="x-btn-bc"></td><td class="x-btn-br"><i>&nbsp;</i></td></tr>
						</tbody>
					</table>
				</c:if>
				<!-- 권한 에 따른 쓰기기능 제어 시작  --> 
			</div>
		</div>		
		</td>
	</tr>
</table>	
				
</form>
	
</div>	

<script type="text/javascript"> 
var menu_id = "<%=WebUtil.nullCheck(request.getParameter("menu_id"))%>";
var menu_thread = "<%=WebUtil.nullCheck(request.getParameter("menu_thread"))%>";
var command = "<%=WebUtil.nullCheck(request.getParameter("command"))%>";

for(i = 0; i < menu01Dpeth.length; i++){
	var AddIndex = document.vForm.menu01.length;
	
	var menu = menu01Dpeth[i].split("||");
	
	var option = new Option(menu[1], menu[0]);
	document.vForm.menu01.options[AddIndex]= option;
	
	var data001 = menu_id.substr(0, 3)+"000000";
	
	if(menu[0] == data001){
		document.vForm.menu01.options[AddIndex].selected = true;
	}
}


function twoMenuView(data){

	var delIndex = document.vForm.menu02.length;
	for(i = delIndex; i >=0; i--){
		document.vForm.menu02.remove(i);
	}
	
	delIndex = document.vForm.menu03.length;
	for(i = delIndex; i >=0; i--){
		document.vForm.menu03.remove(i);
	}
	
	

	for(i = 0; i < menu02Dpeth.length; i++){
		var AddIndex = document.vForm.menu02.length;
		var attributte = data.value;
	
		if(attributte.substr(0, 3) == menu02Dpeth[i].substr(0, 3)){
			
			var menu = menu02Dpeth[i].split("||");
			var option = new Option(menu[1], menu[0]);
			document.vForm.menu02.options[AddIndex]= option;
		}
	}
	
	document.getElementById("menu_path").value = "";
	jf_getMenu(data.value);
}

function thirdMenuView(data){
	var delIndex = document.vForm.menu03.length;
	for(i = delIndex; i >=0; i--){
		document.vForm.menu03.remove(i);
	}

	for(i = 0; i < menu03Dpeth.length; i++){
		var AddIndex = document.vForm.menu03.length;
		var attributte = data.value;
		if(attributte.substr(0, 6) == menu03Dpeth[i].substr(0, 6)){
			var menu = menu03Dpeth[i].split("||");
			var option = new Option(menu[1], menu[0]);
			document.vForm.menu03.options[AddIndex]= option;
		}
	}
	
	document.getElementById("menu_path").value = "";
	jf_getMenu(data.value);
}

function MenuView(data){

	document.getElementById("menu_path").value = "";
	jf_getMenu(data.value);
}


function jf_addMenu(menu_thread){
	var menu_id = "";

	if(menu_thread == '2'){
		if(document.vForm.menu01.selectedIndex < 0){
			alert('첫번째 메뉴를 선택하세요');
			document.vForm.menu01.focus();
		}else{
			var data = document.vForm.menu01.options[document.vForm.menu01.selectedIndex].value;
			menu_id = data.substr(0, 3);
			var url = '/core/manage/menu/menuAdd.sg?menu_thread='+menu_thread+"&menu_id="+menu_id;
			window.open(url, 'menuAdd', 'width=350, height=100');
		}
		
	}else if(menu_thread == '3'){
		if(document.vForm.menu02.selectedIndex < 0){
			alert("두번째 메뉴를 선택하세요.");
			document.vForm.menu02.focus();
		}else{
			var data = document.vForm.menu02.options[document.vForm.menu02.selectedIndex].value;
			menu_id = data.substr(0, 6);
			var url = '/core/manage/menu/menuAdd.sg?menu_thread='+menu_thread+"&menu_id="+menu_id;
			window.open(url, 'menuAdd', 'width=350, height=100');
		}
	}else{
		var url = '/core/manage/menu/menuAdd.sg?menu_thread='+menu_thread+"&menu_id="+menu_id;
		window.open(url, 'menuAdd', 'width=350, height=100');
	}

}

function jf_up(form, menu_thread){
	if(form.selectedIndex > 0){
		var step01 = form.selectedIndex
		var name01 = form.options[step01].text;
		var code01 = form.options[step01].value;
		
		var step02 = form.selectedIndex - 1;
		var name02 = form.options[step02].text;
		var code02 = form.options[step02].value;
		
		var option01 = new Option(name01, code01);
		form.options[step01 - 1]= option01;
		form.options[step01 - 1].selected = true;
		var menu_id = form.options[step01 - 1].value;

		var option02 = new Option(name02, code02);
		form.options[step02 + 1]= option02;
		
		var menu_str = "";
		for(var i = 0; i < form.length; i++){
			menu_str = menu_str +"/"+form[i].value;
		}
		jf_postionReload(menu_str, menu_id, menu_thread);
	}
}

function jf_down(form, menu_thread){
	if(form.selectedIndex < form.length-1){
			var step01 = form.selectedIndex
			var name01 = form.options[step01].text;
			var code01 = form.options[step01].value;
			
			var step02 = form.selectedIndex + 1;
			var name02 = form.options[step02].text;
			var code02 = form.options[step02].value;
			
			var option01 = new Option(name01, code01);
			form.options[step01 + 1]= option01;
			form.options[step01 + 1].selected = true;
			var menu_id = form.options[step01 + 1].value;
	
			var option02 = new Option(name02, code02);
			form.options[step02 - 1]= option02;
			
			
			var menu_str = "";
			for(var i = 0; i < form.length; i++){
				menu_str = menu_str +"/"+form[i].value;
			}
			jf_postionReload(menu_str, menu_id, menu_thread);
		}
}

function jf_upMove(gubun){
	if(gubun == "1"){
		jf_up(document.vForm.menu01, '1');
	}else if(gubun == "2"){
		jf_up(document.vForm.menu02, '2');
	}else if(gubun == "3"){
		jf_up(document.vForm.menu03, '3');
	}
}
function jf_downMove(gubun){
	if(gubun == "1"){
		jf_down(document.vForm.menu01, '1');
	}else if(gubun == "2"){
		jf_down(document.vForm.menu02, '2');
	}else if(gubun == "3"){
		jf_down(document.vForm.menu03, '3');
	}

}

function jf_postionReload(menu_str, menu_id, menu_thread){
	location.href = "/core/manage/menu/menuPositionAction.sg?menu_str="+menu_str+"&menu_thread="+menu_thread+"&menu_id="+menu_id;
	//loadUrl("메뉴 관리", "/");
}

var blockClick = false;

function jf_getMenu(menu_id) {
	if(menu_id != ""){
	    var url="/core/manage/menu/menuInfoAction.sg";
	    queryString = "menu_id="+menu_id;
	
	    if(blockClick) {
	        return;
	    }
	
	    blockClick = true;
	
	    httpRequest("POST", url, queryString, true, jf_getMenuInfo);
    }else{
    	try{
	    	var temp = document.vForm.menu01.options[0].value;
	    	if(temp != ''){
				var url="/core/manage/menu/menuInfoAction.sg";
			    queryString = "menu_id="+document.vForm.menu01.options[0].value;
			 
				document.vForm.menu01.options[0].selected = true;
				 
			    if(blockClick) {
			        return;
			    }
			   
			    blockClick = true;
			 
			    httpRequest("POST", url, queryString, true, jf_getMenuInfo);
		    }
		}catch(e){
			//alert('메뉴를 등록하세요!!');
			
		}
    }
}

var jf_getMenuInfo = function() {
	if( ajax.readyState==4 ) {
		if (ajax.status == 200) {
			var ajaxXml = ajax.responseXML;

			var dataDocument = ajaxXml.getElementsByTagName("MENUINFO");
			if(dataDocument != undefined && typeof(dataDocument) == 'object') {
            	for(var i = 0; i < dataDocument.length; i++) {
            		
                	document.getElementById("menu_id").value = dataDocument[i].getElementsByTagName('MENU_ID')[0].firstChild.nodeValue;
                    document.getElementById("menu_nm").value = dataDocument[i].getElementsByTagName('MENU_NM')[0].firstChild.nodeValue;
                    document.getElementById("menu_thread").value = dataDocument[i].getElementsByTagName('MENU_THREAD')[0].firstChild.nodeValue;
                    
                    var path = dataDocument[i].getElementsByTagName('MENU_PATH')[0].firstChild.nodeValue;
                    path = (path == 'null')?"":path;
                                      
                    
                    if(path != ""){                    
                    	document.getElementById("menu_path").value = path;
                    }
                    
                    var read = dataDocument[i].getElementsByTagName('MENU_READNM')[0].firstChild.nodeValue;
                    var write = dataDocument[i].getElementsByTagName('MENU_WRITENM')[0].firstChild.nodeValue;
                    
                    document.getElementById("read_grant").innerHTML = read;
                    document.getElementById("write_grant").innerHTML = write;
                    document.getElementById("scriptReader").innerHTML = "<b><a href=\"javascript:jf_grant('r', '"+document.getElementById("menu_id").value+"')\">[읽기권한]</a></b>";
					document.getElementById("scriptWriter").innerHTML = "<b><a href=\"javascript:jf_grant('w', '"+document.getElementById("menu_id").value+"')\">[쓰기권한]</a></b>";
            	}
        	}
			
            blockClick = false;
		}else{
			blockClick = false;
		}
 	}
}


function twoMenuViewFront(menu_id){
	for(i = 0; i < menu02Dpeth.length; i++){
		var AddIndex = document.vForm.menu02.length;
		
		if(menu_id.substr(0, 3) == menu02Dpeth[i].substr(0, 3)){
			
			var menu = menu02Dpeth[i].split("||");
			var option = new Option(menu[1], menu[0]);
			document.vForm.menu02.options[AddIndex]= option;
			
			var data001 = menu_id.substr(0, 6)+"000";
	
			if(menu[0] == data001){
				document.vForm.menu02.options[AddIndex].selected = true;
			}
			
		}
	}
}


function thirdMenuViewFront(menu_id){

	for(i = 0; i < menu03Dpeth.length; i++){
		var AddIndex = document.vForm.menu03.length;

		if(menu_id.substr(0, 6) == menu03Dpeth[i].substr(0, 6)){
			var menu = menu03Dpeth[i].split("||");
			var option = new Option(menu[1], menu[0]);
			document.vForm.menu03.options[AddIndex]= option;
	
			if(menu[0] == menu_id){
				document.vForm.menu03.options[AddIndex].selected = true;
			}
		}
	}
}


if(menu_id != "" && menu_thread != ""){
	if(menu_thread == "2"){
		twoMenuViewFront(menu_id);
	}else if(menu_thread == "3"){
		twoMenuViewFront(menu_id);
		thirdMenuViewFront(menu_id);
	}
}


function jf_grant(command, menu_id){
	var url = '/core/manage/menu/groupList.sg?command='+command+"&menu_id="+menu_id;
	window.open(url, '', 'width=400, height=300, scrollbars=yes');
}

function trim(str){
	var i,j = 0;
	var objstr;
	for(i=0; i< str.length; i++){
		if(str.charAt(i) == ' ') j=j + 1;
		else break;
	}
	str = str.substring(j, str.length - j + 1);
 
	i,j = 0;
	for(i = str.length-1;i>=0; i--){
		if(str.charAt(i) == ' ') j=j + 1;
		else break;
	}
	return str.substring(0, str.length - j);
}
jf_getMenu(menu_id);


</script>
