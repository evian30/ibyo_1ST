<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/web/jsp/common/inc/commonInc.jsp" %>
<%@ page import="java.util.*" %>
<script type="text/javascript" src="/resource/common/js/ajax.js"></script>
<link href="/resource/common/css/common.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE="JavaScript">
<!--

var blockClick = false;
var divID = "";
function js_thirdMenuView(id, menu_id, hmenu_id) {
	if(menu_id != ""){
	    var url="/core/manage/menu/menuThirdView.sg";
	    queryString = "menu_id="+menu_id;
	    	
	    	
	    //alert(menu_id.substr(0, 6) +":"+ hmenu_id.substr(0, 6));
	    	
	    if(hmenu_id == ""){
	    	return;
	    } 
	    
	    if(blockClick) {
	        return;
	    }
		divID = id;
	    blockClick = true;

	    httpRequest("POST", url, queryString, true, js_thirdMenu);
    }
}

var js_thirdMenu = function() {
	
	if( ajax.readyState==4 ) {

		if (ajax.status == 200) {

			var html = "";
			var ajaxXml = ajax.responseXML;

			var dataDocument = ajaxXml.getElementsByTagName("MENUINFO");
			if(dataDocument != undefined && typeof(dataDocument) == 'object') {
            	for(var i = 0; i < dataDocument.length; i++) {
                	var menu_id = dataDocument[i].getElementsByTagName('MENU_ID')[0].firstChild.nodeValue;
                    var menu_nm = dataDocument[i].getElementsByTagName('MENU_NM')[0].firstChild.nodeValue;                   
                    
                    var path = dataDocument[i].getElementsByTagName('MENU_PATH')[0].firstChild.nodeValue;
                    if(path != ""){
	                    if(path.indexOf("?") > 0){
	                    	path = path+"&hmenu_id="+menu_id;          
	                    }else{              
	                    	path = path+"?hmenu_id="+menu_id;    
	                    }    
	                    //html += "<table width='100%' border='0' cellpadding='0' cellspacing='0' height='27px' margin='0px 0px 0px 0px'><tr>";
	                    //html += "<td class='left_td' height='27px'><a href="+path+" class='green_txt'>"+menu_nm+"</a></td></tr></table> \n";
	                    html += "<ul><li><a href="+path+" style='cursor:pointer'>"+menu_nm+"</a></li></ul>";
	                }else{
	                    //html += "<table width='100%' border='0' cellpadding='0' cellspacing='0' height='27px' margin='0px 0px 0px 0px'><tr>";
	                    //html += "<td class='left_td' height='27px'><a href='/core/manage/menu/blank.sg?hmenu_id="+menu_id+"' class='green_txt'>"+menu_nm+"</a></td></tr></table> \n";
	                	html += "<ul><li><a href='/core/manage/menu/blank.sg?hmenu_id="+menu_id+"' style='cursor:pointer'>"+menu_nm+"</a></li></ul>";
	               }                           
            	}
            	
            	document.getElementById(divID).innerHTML = html;
        	}
            blockClick = false;
		}else{
			blockClick = false;
		}
 	}
}
var ajaxArray = new Array();





function jf_search(){
	if(document.vFormMain.keyword.value == ""){
		//alert('검색어를 입력하세요');
		//document.vForm.keyword.focus();
		//return;
	}
	document.vFormMain.action = "/sgportal/techsup/techsupAppList.sg?actType=list&hmenu_id=007000000";
	document.vFormMain.submit();
}

function goNew(){
	var f = document.vFormReg; 
	window.location.href=f.goSiteLink.value;
	 
}


//-->
</SCRIPT>

	<%-- 
		if(request.getRequestURI().indexOf("core") > 0 
			|| request.getRequestURI().indexOf("bassCode") > 0
			|| request.getRequestURI().indexOf("chman") > 0
		){ 
	--%> 
	 
	<% if(request.getRequestURI().indexOf("main") > 0 ||  request.getRequestURI().indexOf("myPage") > 0){ %>
			<!--left 시작 -->
			<div id="left2">
				<form name='vFormMain' method='post'>
				<div>
					<div class="main_box_t"></div>				
					<div class="main_box_c">
					   <img src="/resource/images/bass_1st/main_box_search.gif"><br/>
	                   <select name="status_nm" id="status_nm" title="진행상태" style="width:100; margin:5 0 5 0;">
							<option value="">진행상태</option>
							<c:forEach items="${STATUS}" var="type" varStatus="i">
							<option value="${type.CODE_NM}" <c:if test="${type.CODE_NM == pMap.status_nm}"> selected="selected"</c:if>>
								${type.CODE_NM}(${type.CODE})
							</option>
							</c:forEach>
						</select> 
						&nbsp;
						<select name='key' class="gray_txt" style="width:90; margin:5 0 5 0;">
							<option value='006' <c:if test="${pMap.key == '006'}">selected</c:if>>고객사</option>		
							<option value='001' <c:if test="${pMap.key == '001'}">selected</c:if>>SG담당자</option>
							<option value='002' <c:if test="${pMap.key == '002'}">selected</c:if>>고객담당자</option>
							<option value='003' <c:if test="${pMap.key == '003'}">selected</c:if>>제목</option>
							<option value='004' <c:if test="${pMap.key == '004'}">selected</c:if>>계약명</option>
							<option value='005' <c:if test="${pMap.key == '005'}">selected</c:if>>제품명</option>				
						</select>  
				     	<input type='text' name='keyword' value='${pMap.keyword}' class="Input_w " style="width:160px; margin:0 0 5 0;" alt="검색란" onkeypress="javascript:if(event.keyCode=='13'){jf_search();}"/>  
						<input type="image" src="/resource/images/bass_1st/btn_go.gif" align="absmiddle" style="cursor:hand;pointer;" onclick="jf_search()" /><br/> 
					</div>	
					<div class="main_box_b"></div>
				</div>
				</form>
				
				<form name='vFormReg' method='post'>
				<div>
					<div class="main_box_t"></div>				
					<div class="main_box_c">
					  <select style="width:200" name="goSiteLink" onchange="goNew();">
	                    <option value="">::::신규등록할 항목 선택::::</option>
	                    <option  <% if(request.getRequestURI().indexOf("techsupApp") > 0 ){ out.println("selected='selected'"); }%> value="/sgportal/techsup/techsupApp.sg?actType=ins&hmenu_id=007000000">기술지원요청등록</option>
	                    <option  <% if(request.getRequestURI().indexOf("techsupApp") > 0 ){ out.println("selected='selected'"); }%> value="/sgportal/chman/chmanComView.sg?comT=CU&actType=ins&hmenu_id=002003000">고객사등록</option>
	                    <option  <% if(request.getRequestURI().indexOf("techsupApp") > 0 ){ out.println("selected='selected'"); }%> value="/sgportal/product/productAdd.sg?actType=ins&hmenu_id=009003002">SG제품등록</option>
	                    <option  <% if(request.getRequestURI().indexOf("techsupApp") > 0 ){ out.println("selected='selected'"); }%> value="/sgportal/techsup/techsupList.sg?hmenu_id=002005000">프로젝트정보등록</option>
	                    <option  <% if(request.getRequestURI().indexOf("techsupApp") > 0 ){ out.println("selected='selected'"); }%> value="/sgportal/techsup/techsupList.sg?hmenu_id=002005000">계약정보등록</option>	                    
	                  </select>
					</div>
					<div class="main_box_b"></div>
				</div>
				</form>
				
				<div>
					<div class="main_box_t"></div>				
					<div class="main_box_c">
						 
					    <span class="txt_maininfo" style="cursor:pointer" onclick="javascript:window.location.href='/sgportal/techsup/techsupAppList.sg?actType=list&hmenu_id=007000000'"><img src="/resource/images/bass_1st/main_box_arrow.gif" align="absmiddle">
						지원요청 : ${techSupAppCntMain} 건</span><br>
						<span class="txt_maininfo" style="cursor:pointer" onclick="javascript:window.location.href='/sgportal/chman/chmanComList.sg?comT=CU&hmenu_id=002000000'"><img src="/resource/images/bass_1st/main_box_arrow.gif"  align="absmiddle">
						고객등록 : ${companyCnt} 건</span><br>  
						<span class="txt_maininfo" style="cursor:pointer" onclick="javascript:window.location.href='/sgportal/techsup/techsupList.sg?hmenu_id=002005000'"><img src="/resource/images/bass_1st/main_box_arrow.gif" align="absmiddle">
						프로젝트 : ${pjtSupBiz} 건</span><br>
						<span class="txt_maininfo" style="cursor:pointer" onclick="javascript:window.location.href='/sgportal/techsup/dealPjtList.sg?hmenu_id=002005000'"><img src="/resource/images/bass_1st/main_box_arrow.gif" align="absmiddle">
						계&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;약 : ${dealSupBiz} 건 </span><br/>
						<span class="txt_maininfo" style="cursor:pointer" onclick="javascript:window.location.href='/sgportal/product/productList.sg?hmenu_id=009003000'"><img src="/resource/images/bass_1st/main_box_arrow.gif"  align="absmiddle">
						제품등록 : ${prodTotCnt} 건</span>
					</div> 
					<div class="main_box_b"></div>
				</div>
				<div>
					<div class="main_box_t"></div>				
					<div class="main_box_c"> 
						<span onclick="javascript:window.location.href='/sgportal/techsup/techsupAppList.sg?actType=list&hmenu_id=007000000'" style="cursor:pointer" >
						<img src="/resource/images/bass_1st/bt_next.gif" align="absmiddle"> 
							<c:choose>
								<c:when test="${sessionMap.GROUPS == 'G006' || sessionMap.GROUPS == 'G005'}"><b style="color:#804040">요청한</b></c:when>
								<c:otherwise><b style="color:#804040">수행 중</b></c:otherwise>
							</c:choose>							
							 기술지원 <b style="color:gray">[총: ${techSupAppCnt} 건]</b>
						</span>  
						<c:forEach var="i" begin="0" end="3">
						<ul>				
							<li><span class="txt_maininfo"><img src="/resource/images/bass_1st/main_icondot2.gif" align="absmiddle"> 
							고객사명: </span><span style="cursor:pointer;font-weight:bold" onclick="javascript:window.location.href='/sgportal/techsup/techsupApp.sg?actType=view&tech_sup_app_no=${techSupApp[i].TECH_SUP_APP_NO}&hmenu_id=007000000'">${techSupApp[i].CL_CORP_NM}</span></li>
							<li><span class="txt_maininfo"><img src="/resource/images/bass_1st/main_icondot2.gif" align="absmiddle"> 
							지원요청: </span>${fn:substring(techSupApp[i].APP_TITLE, 0, 10)}<c:if test="${fn:length(techSupApp[i].APP_TITLE) > 10 }">...</c:if></li> 
							<li><span class="txt_maininfo"><img src="/resource/images/bass_1st/main_icondot2.gif" align="absmiddle"> 
							요청일시: </span>${techSupApp[i].APP_REC_DATE} </li>
							<li><span class="txt_maininfo"><img src="/resource/images/bass_1st/main_icondot2.gif" align="absmiddle"> 
							프로젝트: </span>${fn:substring(techSupApp[i].PJT_NAME, 0, 10)}<c:if test="${fn:length(techSupApp[i].PJT_NAME) > 10 }">...</c:if></li> 
							<li><span class="txt_maininfo"><img src="/resource/images/bass_1st/main_icondot2.gif" align="absmiddle"> 
							계약제품: </span> 
								<c:if test="${techSupApp[i].PROD_NM  != ' ()' }">
									${fn:substring(techSupApp[i].PROD_NM, 0, 10)}<c:if test="${fn:length(techSupApp[i].PROD_NM) > 10 }">...</c:if>
								</c:if>
							</li>
						</ul>
							<c:if test="${i < 3}">
								<img src="/resource/images/bass_1st/main_box_line.gif" align="absmiddle"><br>				
							</c:if>
						</c:forEach> 
						
					</div>
					<div class="main_box_b"></div> 
				</div>
											
			</div>
			<!--left끝 --> 			
	
	<%}else{ %>
	 		<!--left 시작 -->
			<div id="left"> 
				<div id="subNavi">    	
					<c:forEach items="${menuFirst}" var="menuF" varStatus="i">
						<str:substring start="0" end="3" var="t1">${menuF.MENU_ID}</str:substring>
						<str:substring start="0" end="3" var="t2">${sessionMap.hmenu_id}</str:substring> 
						<c:choose> 
							<c:when test="${t1 == t2}">  
								<h2>${menuF.MENU_NM}</h2>
							</c:when>
						</c:choose>
					</c:forEach>
					
					<ul> 
						<c:forEach items="${menuSecond}" var="menu" varStatus="i">
							<li> 
								<c:choose>
									<c:when test="${menu.MENU_PATH != null && menu.MENU_PATH != ''}">
										<str:countMatches substring="?" var='sr'>${menu.MENU_PATH}</str:countMatches>
							    		<c:choose>
											<c:when test="${sr > 0 }"><a href="${menu.MENU_PATH}&hmenu_id=${menu.MENU_ID}" class="lmenu_txt_b">${menu.MENU_NM}</a></c:when>						
											<c:when test="${sr <= 0 }"><a href="${menu.MENU_PATH}?hmenu_id=${menu.MENU_ID}" class="lmenu_txt_b">${menu.MENU_NM}</a></c:when>
										</c:choose>
									</c:when>
									<c:otherwise><a href="/core/manage/menu/blank.sg?hmenu_id=${menu.MENU_ID}" class="green_txt">${menu.MENU_NM}</a></c:otherwise>
								</c:choose>	 
							</li>						 
							  	
						  	<span id="menu-${i.index}" style="padding:0px 0px 0px 0px;">
				    			<script>
				    					ajaxArray[${i.index}] = "menu-${i.index}||${menu.MENU_ID}||${sessionMap.hmenu_id}";
				    			</script>
			    			</span> 
				    			 
			    		</c:forEach>	
				    </ul>
				</div>							
			</div>
			<!--left끝 -->  
	<%} %> 
 
<script>
var objRun = setInterval("action()", 90); 

function forceStop(){
	clearInterval(objRun);
}

function action(){
	//js_thirdMenuView('menu-${i.index}', '${menu.MENU_ID}', '${sessionMap.hmenu_id}');
	if(!blockClick && ajaxArray.length > 0){
		var data = ajaxArray.shift();
		var temp = data.split("||");
		
		js_thirdMenuView(temp[0], temp[1], temp[2]);
		
		if(ajaxArray.length <= 0){
			forceStop();
		}
	}
}
</script>

