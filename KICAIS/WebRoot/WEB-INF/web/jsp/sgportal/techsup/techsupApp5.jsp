<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%> 
<%@ include file="/WEB-INF/web/jsp/common/inc/commonInc.jsp" %>
<script type="text/javascript" src="/resource/common/js/jquery.sg.js"></script>
<link href="/resource/common/css/common.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="/resource/common/js/mini.js" ></script>
<script type="text/javascript" src="/resource/common/js/validator.js" ></script> 

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
  
  parent.getReSize('IF_APP5');
  
}



function f_app_tech_sup_write(){
	document.IF_APP6.location = '/sgportal/techsup/techsupView.sg?actType=ins&tech_sup_app_no=' + '${pMap.tech_sup_app_no}';
	$("#D_APP6").css({"display":"block"});
	
}

function techsupView(tech_sup_no){
	
	var url = "/sgportal/techsup/techsupView.sg?actType=view&tech_sup_no=" + tech_sup_no + "&tech_sup_app_no=${pMap.tech_sup_app_no}";
	window.open(url, '', 'width=900, height=550, scrollbars=yes, toolbar=no');
	
	
	//document.IF_APP6.location = '/sgportal/techsup/techsupView.sg?actType=view&tech_sup_no=' + tech_sup_no + '&tech_sup_app_no=' + '${pMap.tech_sup_app_no}';
	//$("#D_APP6").css({"display":"block"});

	//calcHeight5();
	//calcHeight6();
}

function goSort(sortKey){
	if(document.vForm.sort.value == "") document.vForm.sort.value = "1";
	if(document.vForm.sortKey.value != sortKey || document.vForm.sort.value == "2"){
		document.vForm.sort.value = "1";
	}else{
		document.vForm.sort.value = "2";
	}
	document.vForm.sortKey.value = sortKey;

	var param = "tech_sup_app_no=" + '${pMap.tech_sup_app_no}' + 
			   "&sortKey=" + sortKey +
			   "&sort=" + document.vForm.sort.value;
	
	parent.parent.document.IF_APP5.location = '/sgportal/techsup/techsupApp5.sg?' + param;
	$("#D_APP5").css({"display":"block"});
}  

function calcHeight5(){   
	var the_height5= parent.document.getElementById('IF_APP5').contentWindow.document.body.scrollHeight+330;
	parent.document.getElementById('IF_APP5').height = the_height5;
}

function calcHeight6(){  
	var the_height6= document.getElementById('IF_APP6').contentWindow.document.body.scrollHeight+120;
	document.getElementById('IF_APP6').height= the_height6;
}

//-->
</SCRIPT>
<c:set var="groups" value="${fn:split(sessionMap.GROUPS, ',')}" />


<form name='vForm' method='post'>
<input type="hidden" name="actType" id="actType" />
<input type="hidden" name="sort" id="sort" value="${pMap.sort}" />
<input type="hidden" name="sortKey" id="sortKey" value="${pMap.sortKey}" /> 
<input type="hidden" name="listCount" id="listCount" value="${fn:length(supList)}" /> 

</form>


	


														
	<table width="100%" border="0" cellpadding="0" cellspacing="0"  class="grid">
		<tr align="center">
			
		
			<th scope="col" id="odd" style="width:15%" style="cursor:hand;" onclick="javascript:goSort('TECH_SUP_APP_NO')">
				<c:if test="${pMap.sort == '1'}">
					<c:if test="${pMap.sortKey == 'TECH_SUP_APP_NO'}">
						▲ 
					</c:if>
				</c:if>
				<c:if test="${pMap.sort == '2'}">
					<c:if test="${pMap.sortKey == 'TECH_SUP_APP_NO'}">
						▼ 
					</c:if>
				</c:if>
				기술지원번호
			</td>
			<th style="width:10%" scope="col" id="odd" style="cursor:hand;" onclick="javascript:goSort('ST_DATE')">
				<c:if test="${pMap.sort == '1'}">
					<c:if test="${pMap.sortKey == 'ST_DATE'}">
						▲ 
					</c:if>
				</c:if>
				<c:if test="${pMap.sort == '2'}">
					<c:if test="${pMap.sortKey == 'ST_DATE'}">
						▼ 
					</c:if>
				</c:if>
				지원일
			</td>
			<th style="width:20%" scope="col" id="odd" style="cursor:hand;" onclick="javascript:goSort('SUP_RESULT')">
				<c:if test="${pMap.sort == '1'}">
					<c:if test="${pMap.sortKey == 'SUP_RESULT'}">
						▲ 
					</c:if>
				</c:if>
				<c:if test="${pMap.sort == '2'}">
					<c:if test="${pMap.sortKey == 'SUP_RESULT'}">
						▼ 
					</c:if>
				</c:if>
				처리결과
			</td>
			<th style="width:20%" scope="col" id="odd" style="cursor:hand;" onclick="javascript:goSort('SUP_METHOD')">
				<c:if test="${pMap.sort == '1'}">
					<c:if test="${pMap.sortKey == 'SUP_METHOD'}">
						▲ 
					</c:if>
				</c:if>
				<c:if test="${pMap.sort == '2'}">
					<c:if test="${pMap.sortKey == 'SUP_METHOD'}">
						▼ 
					</c:if>
				</c:if>
				기술지원 유형
			</td> 
			<th style="width:20%" scope="col" id="odd" style="cursor:hand;" onclick="javascript:goSort('SUP_TYPE')">
				<c:if test="${pMap.sort == '1'}">
					<c:if test="${pMap.sortKey == 'SUP_TYPE'}">
						▲ 
					</c:if>
				</c:if>
				<c:if test="${pMap.sort == '2'}">
					<c:if test="${pMap.sortKey == 'SUP_TYPE'}">
						▼ 
					</c:if>
				</c:if>
				기술지원 종류
			</td> 
			<th style="width:10%" scope="col" id="odd" style="cursor:hand;">
				 
				재방문일<br/>(최종지원일)
			</td>
		</tr>

	<c:forEach items="${supList}" var="data" varStatus="i">
	    <tr height="20px">
	   		<td align='center'>
	   			<a href="javascript:techsupView('${data.TECH_SUP_NO}')">${data.TECH_SUP_NO}</a>
	    	</td>  
	    	<td align='center'><a href="javascript:techsupView('${data.TECH_SUP_NO}')">${data.ST_DATE}</a></td>
	        <td align='center'><a href="javascript:techsupView('${data.TECH_SUP_NO}')">${data.SUP_RESULT}</a></td>
	        <td align='center'><a href="javascript:techsupView('${data.TECH_SUP_NO}')">${data.SUP_METHOD}</a></td>
	        <td align='center'><a href="javascript:techsupView('${data.TECH_SUP_NO}')">${data.SUP_TYPE}</a></td> 
	        <td align='center'>
	        	<a href="javascript:techsupView('${data.TECH_SUP_NO}')">
	        		<c:choose>
	        			<c:when test="${data.TRAN_RESULT == '2'}">${data.REVISIT_EXP_DATE}</c:when>
	        			<c:when test="${data.TRAN_RESULT == '3'}">${data.ST_DATE}</c:when>
	        			<c:otherwise>${data.ST_DATE}</c:otherwise>
	        		</c:choose> 
	        	</a>
	        </td> 
	    </tr>				 
	</c:forEach>
	</table>	
	<div align="right">
		<c:forEach items="${groups}" var="group" varStatus="i">
			<c:if test="${group == 'G003'}">
				<c:if test="${status5.REJECT_YN == 'N' &&  empty status7.REJECT_YN }">
					<c:forEach items="${tech_sup_chman}" var="sw" varStatus="i">
						<c:if test="${sw.CHMAN_NM == sessionMap.ADMIN_NM}">
							<input type="button" class="buttonsmall02" value="등록" onclick="f_app_tech_sup_write();" /> 
						</c:if>
					</c:forEach>
				</c:if>
			</c:if>
		</c:forEach>
	</div>
	<div class="paging">
		${pageNavi.pageNavigator}
	</div> 



	
	<br />

	<div style="width:100%">
	    <div id="D_APP6" style="display:none;"> 
	    	<iframe scrolling="no" width="100%" height="1" onLoad="getReSize('IF_APP6');" scrolling='auto' frameborder="0" id="IF_APP6" name="IF_APP6" style="margin-bottom: 8px;"></iframe>
	    </div>
	    <br class="clear" /> 
    </div>



<div id="mypopup" style="position: absolute; visibility: hidden; z-index: 0; background-color: #99BDDF;"></div>
