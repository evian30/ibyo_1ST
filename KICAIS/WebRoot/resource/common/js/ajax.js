/**
 *
 * 사용법:
 * 
    var blockClick = false;

    function jsReqSampleList() {
        var url="/sample/sampleList.sg";
        queryString = "menu_seq_n="+menu_seq_n;

        if(blockClick) {
            return;
        }

        blockClick = true;

        httpRequest("POST", url, queryString, true, jsResSampleList);
    }

    var jsResSampleList = function() {
	    if( ajax.readyState==4 ) {
	        if (ajax.status == 200) {
		        var ajaxXml = ajax.responseXML;

		        if(!ajaxXml.getElementsByTagName("result") ||
		            !ajaxXml.getElementsByTagName("result")[0]) {
		            alert('$msg.getString("common.msg.system-error")');
                    blockClick = false;
		            return;
		        }

		        var dataDocument = ajaxXml.getElementsByTagName("result")[0].firstChild;

		        if(dataDocument != null) {
		            jsAddContentList(ajaxXml.getElementsByTagName("SAMPLELIST"));
		        }

                blockClick = false;
	        } else {
	            ...
                blockClick = false;
	        }
	    }
    }
 *  
 *              
 */


var ajax;

/**
 * XMLHttpRequest오브젝트 생성.
 */
function createHttpRequest() {
    if(window.ActiveXObject) {
        try {
            return new ActiveXObject("Msxml2.XMLHTTP");
        }catch(e) {
            try {
                return new ActiveXObject("Microsoft.XMLHTTP");
            }catch(e2) {
                return null;
            }
        }
    }else if(window.XMLHttpRequest){
        return new XMLHttpRequest();
    }else{
        return null;
    }
}


function httpRequest(reqType,url,queryString,asynch,handleResponse) {

    ajax = createHttpRequest();    

    queryString = uriEncode(queryString);

    if(reqType.toUpperCase() == 'GET') {
        url += queryString
    }

    // ActiveXObject 초기화에 실패했다면 request는 여전히 null 상태 
    if (ajax) {
        ajax.onreadystatechange = handleResponse;
        ajax.open(reqType,url,asynch);
        /* POST 요청을 위해 Content-Type 헤더 지정 */
        setEncHeader(ajax)
        ajax.send(queryString);

    } else {
        alert("Your browser does not permit the use of all " + "of this application's features!");
    }

    //URI 인코딩
    function setEncHeader(oj) {
    
        var contentTypeUrlenc = 'application/x-www-form-urlencoded; charset=UTF-8';
        if(!window.opera) {
            oj.setRequestHeader('Content-Type',contentTypeUrlenc);
        } else {
            if((typeof oj.setRequestHeader) == 'function')
                oj.setRequestHeader('Content-Type',contentTypeUrlenc);
        }
        return oj;
    }
    
    //URL 인코딩.
    function uriEncode(data) {
    
        if(data!="") {
            var encdata = '';
            var datas = data.split('&');

            for(i=0;i<datas.length;i++) {
                var dataq = datas[i].split('=');
                encdata += '&'+encodeURIComponent(dataq[0])+'='+encodeURIComponent(dataq[1]);
            }
        } else {
            encdata = "";
        }

        return encdata;
    }
}