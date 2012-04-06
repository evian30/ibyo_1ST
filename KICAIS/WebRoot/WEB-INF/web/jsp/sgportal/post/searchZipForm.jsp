<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/web/jsp/common/inc/commonInc.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>우편번호  검색</title> 
<link href="/resource/common/css/common.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="/resource/common/js/ajax.js" ></script> 
<script type="text/javascript" src="/resource/common/js/validator.js" ></script> 
<SCRIPT LANGUAGE="JavaScript">
<!--    
    var blockClick = false;

	function getParameter(name) {
	    var rtnval = '';

	    var nowAddress = unescape(location.href);
	    var parameters = (nowAddress.slice(nowAddress.indexOf('?') + 1, nowAddress.length)).split('&');
	
	    for (var i = 0; i < parameters.length; i++) {
	        var varName = parameters[i].split('=')[0];
	        if (varName.toUpperCase() == name.toUpperCase()) {
	            rtnval = parameters[i].split('=')[1];
	            break;
	        }
	    }
	    return rtnval;
	}


    function jsReqSearchZip() {
        var url="/sgportal/post/searchZipAjax.sg";
		if (document.getElementById("search_word").value == null || document.getElementById("search_word").value == "")
		{
			alert("검색어를 입력해주세요.")
			return;
		}
		var message = Validator["required"](document.getElementById("search_word").value, document.getElementById("search_word"));
		
		// 오류가 있으면 메시지를 반환                                                                       
		if(message) {
		    alert("검색어는 "+message);
		    return;
		}

		var search_word = document.getElementById("search_word").value;

		if(search_word.length < 2){
			alert("두 글자 이상 입력하세요");
			return;
		} 

        queryString = "search_word="+search_word;
 
        if(blockClick) {
            return;
        }

        blockClick = true;

        httpRequest("POST", url, queryString, true, jsResSearchZip);
    }

    function jsResSearchZip() {
    	
        if( ajax.readyState==4 ) {
        
            if (ajax.status == 200) {
            
                var ajaxXml = ajax.responseXML;

                if(!ajaxXml.getElementsByTagName("result") ||
                    !ajaxXml.getElementsByTagName("result")[0]) {
                    alert('${msg:getString("common.msg.system-error")}');
                    blockClick = false;
                    return;
                }

                var dataDocument = ajaxXml.getElementsByTagName("POSTLIST")[0].firstChild;

                if(dataDocument != null) {
                    jsCreateOptions(ajaxXml.getElementsByTagName("POST"));
                }else{
                	var html = '<table border="0" cellspacing="0" cellpadding="0" align="center" width="490" class="grid">';  
        			//html +='<caption>우편번호 검색결과</caption><colgroup><col style="width: 70px;" /><col style="width: *" /></colgroup>';
        			html +='<tr><th scope="col">우편번호</th><th scope="col">주소</th></tr>';
        			html += "<tr><td class='C RL' colspan='2'>데이타가 존재하지 않습니다.</td></tr>";
        			document.getElementById("addr").innerHTML = html+'</table>';
                }

                blockClick = false;
            } else {
                blockClick = false;
            }
        }
    }

    function jsCreateOptions(dataDocument) {
        if(dataDocument != undefined && typeof(dataDocument) == 'object') {
			var html = '<table border="0" cellspacing="0" cellpadding="0"  align="center" width="490" class="grid">';  
			//html +='<caption>우편번호 검색결과</caption><colgroup><col style="width: 70px;" /><col style="width: *" /></colgroup>';
			html +='<tr><th scope="col">우편번호</th><th scope="col">주소</th></tr>'; 
			if(dataDocument.length > 0){
	          	for(var i=0; i<dataDocument.length; i++) {
	          		var zip = dataDocument[i].getElementsByTagName('ZIPCODE')[0].firstChild.nodeValue;
	          		var addr = dataDocument[i].getElementsByTagName('ADDR')[0].firstChild.nodeValue;
	          		var addr_basic = dataDocument[i].getElementsByTagName('ADDR_BASIC')[0].firstChild.nodeValue;
	          		html += "<tr><td class='C RL'><a href=\"javascript:jsSelectAddr('"+zip+"', '"+addr_basic+"')\">"+zip.substring(0,3)+'-'+zip.substring(3,6)+"</a></td><td><a href=\"javascript:jsSelectAddr('"+zip+"', '"+addr_basic+"')\">"+addr+"</a></td></tr>";
	          	}
			}else if(dataDocument == null){
				html += "<tr><td class='C RL' colspan='2'>데이타가 존재하지 않습니다.</td></tr>";
			}
            document.getElementById("addr").innerHTML = html+'</table>';
        }
    }

    function jsAddOption(addr, zipcode) {
        var selectBox = document.getElementById("addr");
        selectBox.options[selectBox.length] = new Option(addr, zipcode);
    }

    function jsDelOptions() {
        var selectBox = document.getElementById("addr");

        for( var i=selectBox.options.length-1; i>=0; i--) {
               selectBox.options[i]=null;
        }
    }

    function jsSelectAddr() {
    	
        var selectBox = document.getElementById("addr");
        var addr = selectBox.options[selectBox.selectedIndex].text;
        var zipcode = selectBox.options[selectBox.selectedIndex].value;
        
        opener.setPost(addr, zipcode);
        self.close();
    }

    function jsSelectAddr(zipcode, addr) {
		opener.document.getElementById("addr").value=addr;
		opener.document.getElementById("zipcode1").value=zipcode.substring(0,3);
		opener.document.getElementById("zipcode2").value=zipcode.substring(3,6);
        
        self.close();
    }

    function enterKey(event) {
    	var theEvent = event ? event : window.event;
        var keynum;

        if(theEvent) { // IE
            keynum = theEvent.keyCode;
        } else if(e.which) { // Netscape/Firefox/Opera
            keynum = theEvent.which;
        }

        if(keynum == 13) {
            jsReqSearchZip();
            theEvent.keyCode='';
        } else {
            return;
        }
    }

    function auto_fit_size() {
        window.resizeTo(100, 100);
        var thisX = parseInt(document.body.scrollWidth);
        var thisY = parseInt(document.body.scrollHeight);
        var maxThisX = screen.width - 50;
        var maxThisY = screen.height - 50;
        var marginY = 0;
        //alert(thisX + "===" + thisY);
        //alert("임시 브라우저 확인 : " + navigator.userAgent);
        // 브라우저별 높이 조절. (표준 창 하에서 조절해 주십시오.)
        if (navigator.userAgent.indexOf("MSIE 6") > 0) marginY = 60;        // IE 6.x
        else if(navigator.userAgent.indexOf("MSIE 7") > 0) marginY = 80;    // IE 7.x
        else if(navigator.userAgent.indexOf("MSIE 8") > 0) marginY = 80;    // IE 7.x
        else if(navigator.userAgent.indexOf("Firefox") > 0) marginY = 50;   // FF
        else if(navigator.userAgent.indexOf("Opera") > 0) marginY = 30;     // Opera
        else if(navigator.userAgent.indexOf("Netscape") > 0) marginY = -2;  // Netscape

        if (thisX > maxThisX) {
            window.document.body.scroll = "yes";
            thisX = maxThisX;
        }
        if (thisY > maxThisY - marginY) {
            window.document.body.scroll = "yes";
            thisX += 19;
            thisY = maxThisY - marginY;
        }
        window.resizeTo(thisX+10, thisY+marginY);
    }
//-->
</SCRIPT>
</head>
<body onload="document.getElementById('search_word').focus();">
	<div id="title_line">
		<div id="title">우편번호검색</div>
		<div id="location">우편번호검색 </div>
	</div>
	 	 
	<table width="620" border="0" cellpadding="0" cellspacing="0" class="grid" >
		<tr height="60">
			<td colspan="2" align="center">
				<p class="h5_add">입력할 지역의 동이나 읍/면의 이름을 빈칸없이 입력한 후 [찾아보기]버튼을 누르세요<br /> 
				보기: 서초동, 청담동 or 서초, 청담</p>
			</td>
		</tr>
		<tr>
			<th scope="col" id="odd" style="width:25%">읍/면/동 이름</th>
			<td> 
				  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				  <input type="text" id="search_word" name="search_word" title="읍/면/동" onkeypress="javascript:enterKey(event);" class="base w200" style="ime-mode:active;"/>
				  <input type="button" class="button02" value="검색" onclick="jsReqSearchZip();return false;">
			</td>
		</tr>
		 
		<tr>
			<td colspan="2"><br/>
			 	<div class="postResult" id="addr">
			</td>
		</tr> 
	</table> 
				 
	<div class="btn">						
		<div class="leftbtn">
		</div>
		<div class="rightbtn">
			<input type="button" class="button02" value="닫기" onclick="javascript:window.close()" />
		</div>
	</div>	 
 
</body>
</html>
