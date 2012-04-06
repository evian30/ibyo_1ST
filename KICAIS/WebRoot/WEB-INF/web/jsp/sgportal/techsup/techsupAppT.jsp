<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%> 
<%@ include file="/WEB-INF/web/jsp/common/inc/commonInc.jsp" %>
<script type="text/javascript" src="/resource/common/js/jquery.sg.js"></script>

<SCRIPT LANGUAGE="JavaScript">
<!--


function getDocHeight(doc)
{
  var docHt = 0, sh, oh;
  if (doc.height)
  {
    docHt = doc.height;
  }
  else if (doc.body)
  {
    if (doc.body.scrollHeight) docHt = sh = doc.body.scrollHeight;
    if (doc.body.offsetHeight) docHt = oh = doc.body.offsetHeight;
    if (sh && oh) docHt = Math.max(sh, oh);
  }
  return docHt;
}

function getReSize(name)
{
  var iframeWin = window.frames[name];

  var iframeEl = window.document.getElementById? window.document.getElementById(name): document.all? document.all[name]: null;

  if ( iframeEl && iframeWin )
  {
    var docHt = getDocHeight(iframeWin.document);

    if (docHt != iframeEl.style.height) iframeEl.style.height = docHt + 'px';
  }
  else
  { // firefox
    var docHt = window.document.getElementById(name).contentDocument.height;
    window.document.getElementById(name).style.height = docHt + 'px';
  }
}



	function f_action(actType){
		if(Validator.validate(document.vForm)){
				document.vForm.actType.value = actType;
				document.vForm.action = "/sgportal/techsup/techsupAppAction.sg";
				document.vForm.submit();
		}
		
	}
	
	function f_app_insView(){
		document.IF_APP1.location = '/sgportal/techsup/techsupApp1.sg?actType=ins';
		$("#D_APP1").css({"display":"block"});
	}
	 
	function f_app_view(value){
		document.IF_APP1.location = '/sgportal/techsup/techsupApp1.sg?actType=view&tech_sup_app_no=' + value;
		$("#D_APP1").css({"display":"block"});
	}
	
	function f_app_pjtView(pjt_no){
		document.IF_APP2.location = '/sgportal/techsup/techsupApp2.sg?actType=view&pjt_no=' + pjt_no;
		$("#D_APP2").css({"display":"block"});
	}
	
	function f_app_dealPjtView(corp_no){																	//작업미완료로 인해 호출 불가 (계약정보 메뉴의 계약 등록 시 프로젝트 정보 입력 할 수 있는 프로그램이 선행 되어야 함 2010.10.27- 11:40 by ibyo )																
		var pjt_no = '${techsupApp.PJT_NO}';
		document.IF_APP3.location = '/sgportal/techsup/techsupApp3.sg?actType=view&corp_no=COR1011022247591&pjt_no=' + pjt_no + '&tech_sup_app_no=${techsupApp.TECH_SUP_APP_NO}';
		$("#D_APP3").css({"display":"block"});
	}
	
	function f_app_status(tech_sup_app_no){
		document.IF_APP4.location = '/sgportal/techsup/techsupApp4.sg?tech_sup_app_no=' + tech_sup_app_no;
		$("#D_APP4").css({"display":"block"});
	}

	function f_app_tech_sup(tech_sup_app_no){
		document.IF_APP5.location = '/sgportal/techsup/techsupApp5.sg?tech_sup_app_no=' + tech_sup_app_no;
		$("#D_APP5").css({"display":"block"});
	}


	function f_app_tech_sw_setup(pjt_no){
		document.IF_APP7.location = '/sgportal/techsup/techsupApp7.sg?actType=view&pjt_no=' + pjt_no + '&tech_sup_app_no=${techsupApp.TECH_SUP_APP_NO}';
		$("#D_APP7").css({"display":"block"});
	}


$(function() {
	if('${pMap.actType}' == 'view'){
		f_app_view('${techsupApp.TECH_SUP_APP_NO}');
		f_app_pjtView('${techsupApp.PJT_NO}');
		f_app_dealPjtView('${techsupApp.CORP_NO}');
		f_app_status('${techsupApp.TECH_SUP_APP_NO}');
		f_app_tech_sup('${techsupApp.TECH_SUP_APP_NO}');
		f_app_tech_sw_setup('${techsupApp.PJT_NO}');
		
	}else if('${pMap.actType}' == 'ins'){
		f_app_insView();
	} 
});

  
function jf_view(id, img){
	var ds = 'none';
	
	if($('#D_APP'+id).css('display') == 'block'){
		ds = 'none';
		img.src = '/resource/images/admin/img/arrow_down_i.gif';
		img.title = '펴기';
	}else{
		ds = 'block';
		img.src = '/resource/images/admin/img/arrow_up_i.gif';
		img.title = '접기';
	}
	
	$('#D_APP'+id).attr("style", "display:" + ds);
	
	
}

//-->
</SCRIPT>

<form name='vFormIfr' method='post'>
<input type="hidden" name="actType" id="actType" />

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
			<c:if test="${pMap.actType=='view'}">
			> 보기 
			</c:if>
			<c:if test="${pMap.actType!='view'}">
			> 등록
			</c:if>
		</div>
	</div>

	

	<div style="width:100%">
		<div class="subtitle">
			진행이력  
				<p align="right">
					<img align="top" title="접기" style="cursor:pointer;" onclick="jf_view('4', this)" src="/resource/images/admin/img/arrow_up_i.gif" />
				</p>
		</div> 
		
	    <div id="D_APP4" style="display:none;"> 
	    	<iframe scrolling="no" width="100%" height="1" onLoad="getReSize('IF_APP4');"  scrolling='auto' frameborder="0" id="IF_APP4" name="IF_APP4" style="margin-bottom: 8px;"></iframe>
	    </div>
	    <br class="clear" /> 
    </div> 
 
 
	<div style="width:100%">
		<div class="subtitle"> 
    		요청사항
			<p align="right">
				<img align="top" title="접기" style="cursor:pointer;" onclick="jf_view('1', this)" src="/resource/images/admin/img/arrow_up_i.gif" />
			</p>
    	</div> 
	
	    <div id="D_APP1" style="display:none;"> 
	    	<iframe scrolling="no" width="100%" height="1" onLoad="getReSize('IF_APP1');" scrolling='auto' frameborder="0" id="IF_APP1" name="IF_APP1" style="margin-bottom: 8px;"></iframe>
	    </div>
	    <br class="clear" /> 
    </div> 

	<div style="width:100%">
		<div class="subtitle">
			프로젝트정보
			<p align="right">
				<img align="top" title="접기" style="cursor:pointer;" onclick="jf_view('2', this)" src="/resource/images/admin/img/arrow_up_i.gif" />
			</p>
		</div> 
	
	    <div id="D_APP2" style="display:none;"> 
	    	<iframe scrolling="no" width="100%" height="1" onLoad="getReSize('IF_APP2');"  scrolling='auto' frameborder="0" id="IF_APP2" name="IF_APP2" style="margin-bottom: 8px;"></iframe>
	    </div>
	    <br class="clear" /> 
    </div> 

	<div style="width:100%">
		<div class="subtitle">
			계약정보
			<p align="right">
				<img align="top" title="접기" style="cursor:pointer;" onclick="jf_view('3', this)" src="/resource/images/admin/img/arrow_up_i.gif" />
			</p>
		</div> 

	    <div id="D_APP3" style="display:none;"> 
	    	<iframe scrolling="no" width="100%" height="1" onLoad="getReSize('IF_APP3')"  scrolling='auto' frameborder="0" id="IF_APP3" name="IF_APP3" style="margin-bottom: 8px;"></iframe>
	    </div>
	    <br class="clear" /> 
    </div> 
  
    <div style="width:100%">
    	<div class="subtitle">
			고객환경
			<p align="right">
				<img align="top" title="접기" style="cursor:pointer;" onclick="jf_view('7', this)" src="/resource/images/admin/img/arrow_up_i.gif" />
			</p>
		</div> 
    
	    <div id="D_APP7" style="display:none;"> 
	    	<iframe scrolling="no" width="100%" scrolling='auto' height="1" onLoad="getReSize('IF_APP7')" frameborder="0" id="IF_APP7" name="IF_APP7" style="margin-bottom: 8px;"></iframe>
	    </div>
	    <br class="clear" /> 
    </div> 
    

	<div style="width:100%">
		<div class="subtitle">
			기술지원이력 
			<p align="right">
				<img align="top" title="접기" style="cursor:pointer;" onclick="jf_view('5', this)" src="/resource/images/admin/img/arrow_up_i.gif" />
			</p>
		</div> 
	
	    <div id="D_APP5" style="display:none;"> 
	    	<iframe scrolling="no" width="100%" height="1" onLoad="getReSize('IF_APP5')"  scrolling='auto' frameborder="0" id="IF_APP5" name="IF_APP5" style="margin-bottom: 8px;"></iframe>
	    </div>
	    <br class="clear" /> 
    </div> 
	
	<br/><br/>
		 	
	
</form>


