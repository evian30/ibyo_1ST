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
  
  parent.getReSize('IF_APP7');
  
}




function jf_pjtProdView(prod_no, pjt_no, prod_seq){

	var url = '/sgportal/techsup/techsupApp8.sg?actType=view&prod_no=' + prod_no + '&pjt_no=' + pjt_no + '&prod_seq=' + prod_seq;
	window.open(url, '', 'width=900, height=650, scrollbars=yes, toolbar=no');

	//document.IF_APP8.location = '/sgportal/techsup/techsupApp8.sg?actType=view&prod_no=' + prod_no + '&pjt_no=' + pjt_no + '&prod_seq=' + prod_seq;
	//$("#D_APP8").css({"display":"block"});

	//calcHeight7();
	//calcHeight8();
}
  

function jf_pjtProdIns(){
	document.IF_APP8.location = '/sgportal/techsup/techsupApp8.sg?actType=ins&prod_no=${pMap.prod_no}&pjt_no=${pMap.pjt_no}&prod_seq=${pMap.prod_seq}';
	$("#D_APP8").css({"display":"block"}); 
} 

function goSort(sortKey){
	if(document.vForm.sort.value == "") document.vForm.sort.value = "1";
	if(document.vForm.sortKey.value != sortKey || document.vForm.sort.value == "2"){
		document.vForm.sort.value = "1";
	}else{
		document.vForm.sort.value = "2";
	}
	document.vForm.sortKey.value = sortKey;
 
	var param = "pjt_no=${pMap.pjt_no}" + 
			   "&sortKey=" + sortKey +
			   "&sort=" + document.vForm.sort.value;
	
	parent.parent.document.IF_APP7.location = '/sgportal/techsup/techsupApp7.sg?' + param;
	$("#D_APP7").css({"display":"block"});
}  
 

function calcHeight7(){   
	//var the_height7= parent.document.getElementById('IF_APP7').contentWindow.document.body.scrollHeight+570;
	//parent.document.getElementById('IF_APP7').height = the_height7;
}

function calcHeight8(){  alert('8');
	var the_height8= document.getElementById('IF_APP8').contentWindow.document.body.scrollHeight+50;
	document.getElementById('IF_APP8').height= the_height8;
}

//-->
</SCRIPT>
<c:set var="groups" value="${fn:split(sessionMap.GROUPS, ',')}" />


<form name='vForm' method='post'>
<input type="hidden" name="actType" id="actType" />
<input type="hidden" name="sort" id="sort" value="${pMap.sort}" />
<input type="hidden" name="sortKey" id="sortKey" value="${pMap.sortKey}" /> 
<input type="hidden" name="listCount" id="listCount" value="${fn:length(prodList)}" /> 

</form>


	 	
														
	<table width="100%" border="0" cellpadding="0" cellspacing="0" class="grid" rules="cols">
		<tr>
			<th scope="col" id="odd" onclick="javascript:goSort('SETUP_SV_HOSTNAME')" style="cursor:hand;">
				<c:if test="${pMap.sort == '1'}">
					<c:if test="${pMap.sortKey == 'SETUP_SV_HOSTNAME'}">
						▲ 
					</c:if>
				</c:if>
				<c:if test="${pMap.sort == '2'}">
					<c:if test="${pMap.sortKey == 'SETUP_SV_HOSTNAME'}">
						▼ 
					</c:if>
				</c:if>
			서버명</td>
			<th scope="col" id="odd" onclick="javascript:goSort('SETUP_SV_IP')" style="cursor:hand;">
				<c:if test="${pMap.sort == '1'}">
					<c:if test="${pMap.sortKey == 'SETUP_SV_IP'}">
						▲ 
					</c:if>
				</c:if>
				<c:if test="${pMap.sort == '2'}">
					<c:if test="${pMap.sortKey == 'SETUP_SV_IP'}">
						▼ 
					</c:if>
				</c:if>
			IP주소</td>
			<th scope="col" id="odd" onclick="javascript:goSort('OS')" style="cursor:hand;">
				<c:if test="${pMap.sort == '1'}">
					<c:if test="${pMap.sortKey == 'OS'}">
						▲ 
					</c:if>
				</c:if>
				<c:if test="${pMap.sort == '2'}">
					<c:if test="${pMap.sortKey == 'OS'}">
						▼ 
					</c:if>
				</c:if>
			OS</td> 
			<th scope="col" id="odd" onclick="javascript:goSort('SDK')" style="cursor:hand;">
				<c:if test="${pMap.sort == '1'}">
					<c:if test="${pMap.sortKey == 'SDK'}">
						▲ 
					</c:if>
				</c:if>
				<c:if test="${pMap.sort == '2'}">
					<c:if test="${pMap.sortKey == 'SDK'}">
						▼ 
					</c:if>
				</c:if>
			SDK</td>
			<th scope="col" id="odd" onclick="javascript:goSort('WEB')" style="cursor:hand;">
				<c:if test="${pMap.sort == '1'}">
					<c:if test="${pMap.sortKey == 'WEB'}">
						▲ 
					</c:if>
				</c:if>
				<c:if test="${pMap.sort == '2'}">
					<c:if test="${pMap.sortKey == 'WEB'}">
						▼ 
					</c:if>
				</c:if>
			WEB</td>
			<th scope="col" id="odd" onclick="javascript:goSort('WAS')" style="cursor:hand;">
				<c:if test="${pMap.sort == '1'}">
					<c:if test="${pMap.sortKey == 'WAS'}">
						▲ 
					</c:if>
				</c:if>
				<c:if test="${pMap.sort == '2'}">
					<c:if test="${pMap.sortKey == 'WAS'}">
						▼ 
					</c:if>
				</c:if>
			WAS</td>
			<th scope="col" id="odd" onclick="javascript:goSort('INS_TYPE')" style="cursor:hand;">
				<c:if test="${pMap.sort == '1'}">
					<c:if test="${pMap.sortKey == 'INS_TYPE'}">
						▲ 
					</c:if>
				</c:if>
				<c:if test="${pMap.sort == '2'}">
					<c:if test="${pMap.sortKey == 'INS_TYPE'}">
						▼ 
					</c:if>
				</c:if>
			설치구분</td>
		</tr> 
		<!-- 본문 시작 -->	
			<c:forEach items="${prodList}" var="pjtProd" varStatus="i">
			<tr align="center">
				<!-- <td>${pageNavi.startRowNo - i.index}</td> -->
				<td align="left">
					&nbsp;&nbsp;
					<a href="javascript:jf_pjtProdView('${pjtProd.PROD_NO}', '${pMap.pjt_no}','${pjtProd.PROD_SEQ}')">
						${pjtProd.SETUP_SV_HOSTNAME}
					</a>
				</td>
				<td><a href="javascript:jf_pjtProdView('${pjtProd.PROD_NO}', '${pMap.pjt_no}','${pjtProd.PROD_SEQ}')">${pjtProd.SETUP_SV_IP}</a></td>
				<td><a href="javascript:jf_pjtProdView('${pjtProd.PROD_NO}', '${pMap.pjt_no}','${pjtProd.PROD_SEQ}')">${pjtProd.OS}</a></td>
				<td><a href="javascript:jf_pjtProdView('${pjtProd.PROD_NO}', '${pMap.pjt_no}','${pjtProd.PROD_SEQ}')">${pjtProd.SDK}</a></td>		
				<td><a href="javascript:jf_pjtProdView('${pjtProd.PROD_NO}', '${pMap.pjt_no}','${pjtProd.PROD_SEQ}')">${pjtProd.WEB}</a></td>	
				<td><a href="javascript:jf_pjtProdView('${pjtProd.PROD_NO}', '${pMap.pjt_no}','${pjtProd.PROD_SEQ}')">${pjtProd.WAS}</a></td>
				<td><a href="javascript:jf_pjtProdView('${pjtProd.PROD_NO}', '${pMap.pjt_no}','${pjtProd.PROD_SEQ}')">${pjtProd.INS_TYPE}</a></td>
			</tr>
			</c:forEach>
	</table>
	<div align="right"> 
		<input type="button" class="buttonsmall02" value="등록" onclick="jf_pjtProdIns();" />   
	</div>

	<div class="paging">
		${pageNavi.pageNavigator}
	</div> 

 
	
	<div style="width:100%">
	    <div id="D_APP8" style="display:none;"> 
	    	<iframe scrolling="no" width="100%" height="1" onload="getReSize('IF_APP8')" scrolling='auto' frameborder="0" id="IF_APP8" name="IF_APP8" style="margin-bottom: 8px;"></iframe>
	    </div>
	    <br class="clear" /> 
    </div>

<div id="mypopup" style="position: absolute; visibility: hidden; z-index: 0; background-color: #99BDDF;"></div>
