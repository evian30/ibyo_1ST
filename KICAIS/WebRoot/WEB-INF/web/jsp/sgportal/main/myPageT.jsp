<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%> 
<%@ include file="/WEB-INF/web/jsp/common/inc/commonInc.jsp" %>
<script type="text/javascript" src="/resource/common/js/jquery.sg.js"></script>

<script language="JavaScript1.2">
	var amplada=500
	var altura=25
	var colordefons=''
	var fons=''
	
	var missatges=new Array() 
	<c:forEach items='${mainBrd}' var='data' varStatus='i'>
	missatges[${i.index}] = '<a href=\'/core/manage/board/boardView.sg?board_id=2&board_seq=${data.BOARD_SEQ}&hmenu_id=001000000\'> ${data.REG_DT} [${data.BOARD_WRITE}] ${data.BOARD_TITLE}</a>';
	</c:forEach>
	
	if (missatges.length > 0){
		i=${fn:length(mainBrd)-1}
	}else{
		i=0 
	}
	
	function moure1(whichlayer){
		tlayer=eval(whichlayer)
		if (tlayer.top>0&&tlayer.top<=5){
			tlayer.top=0
			setTimeout("moure1(tlayer)",3000)
			setTimeout("moure2(document.principal.document.segon)",3000)
		return
		}
		if (tlayer.top>=tlayer.document.height*-1){
			tlayer.top-=5
			setTimeout("moure1(tlayer)",100)
		}
		else{
			tlayer.top=altura
			tlayer.document.write(missatges[i])
			tlayer.document.close()
		if (i==missatges.length-1)
			i=0
		else
			i++
		}
	} 
	
	function moure2(whichlayer){
		tlayer2=eval(whichlayer)
		if (tlayer2.top>0&&tlayer2.top<=5){
			tlayer2.top=0
			setTimeout("moure2(tlayer2)",3000)
			setTimeout("moure1(document.principal.document.primer)",3000)
		return
		}
		if (tlayer2.top>=tlayer2.document.height*-1){
			tlayer2.top-=5
			setTimeout("moure2(tlayer2)",100)
		}
		else{
			tlayer2.top=altura
			tlayer2.document.write(missatges[i])
			tlayer2.document.close()
		if (i==missatges.length-1)
			i=0
		else
			i++
		}
	} 
	
	function moure3(whichdiv){
		tdiv=eval(whichdiv)
		if (tdiv.style.pixelTop>0&&tdiv.style.pixelTop<=5){
			tdiv.style.pixelTop=0
			setTimeout("moure3(tdiv)",3000)
			setTimeout("moure4(segon2)",3000)
		return
		}
		if (tdiv.style.pixelTop>=tdiv.offsetHeight*-1){
			tdiv.style.pixelTop-=5
			setTimeout("moure3(tdiv)",100)
		}
		else{
			tdiv.style.pixelTop=altura
			tdiv.innerHTML=missatges[i]
		if (i==missatges.length-1)
			i=0
		else
			i++
		}
	} 
	
	function moure4(whichdiv){
		tdiv2=eval(whichdiv)
		if (tdiv2.style.pixelTop>0&&tdiv2.style.pixelTop<=5){
			tdiv2.style.pixelTop=0
			setTimeout("moure4(tdiv2)",3000)
			setTimeout("moure3(primer2)",3000)
		return
		}
		if (tdiv2.style.pixelTop>=tdiv2.offsetHeight*-1){
			tdiv2.style.pixelTop-=5
			setTimeout("moure4(segon2)",100)
		}
		else{
			tdiv2.style.pixelTop=altura
			tdiv2.innerHTML=missatges[i]
		if (i==missatges.length-1)
			i=0
		else
			i++
		}
	}
	
	function iniciar(){
		if (document.all){
			moure3(primer2)
			segon2.style.top=altura
			segon2.style.visibility='visible'
		}
		else if (document.layers){
			document.principal.visibility='show'
			moure1(document.principal.document.primer)
			document.principal.document.segon.top=altura+5
			document.principal.document.segon.visibility='show'
		}
	}
</script>
 

 
		<!--contents시작 -->
		<div id="contents">
			<div id="maininfo"><div style="float:left; width:50px;"><img src="/resource/images/bass_1st/maininfo_icon.gif"></div>
			<div style="float:left;">
				<span class="txt_maininfo">[${sessionMap.ADMIN_NM}]님 안녕하세요<br></span>
				<b>
				<ilayer id="principal" width=&{amplada}; height=&{altura}; colordefons=&{colordefons}; background=&{fons}; visibility=hide>
					<layer id="primer" left=0 top=1 width=&{amplada};>
						<script language="JavaScript1.2">
							if (document.layers)
								document.write(missatges[0])
						</script>
					</layer> 
					<layer id="segon" left=0 top=0 width=&{amplada}; visibility=hide>
						<script language="JavaScript1.2">
							if (document.layers)
								document.write(missatges[1])
						</script>
					</layer> 
				</ilayer>  
				<script language="JavaScript1.2">
					if (document.all){
						document.writeln('<span id="principal2" style="position:relative;width:'+amplada+';height:'+altura+';overflow:hiden;background-color:'+colordefons+' ;background-image:url('+fons+')">')
						document.writeln('<div style="position:absolute;width:'+amplada+';height:'+altura+';clip:rect(0 '+amplada+' '+altura+' 0);left:0;top:0">')
						document.writeln('<div id="primer2" style="position:absolute;width:'+amplada+';left:0;top:1;">')
						document.write(missatges[0])
						document.writeln('</div>')
						document.writeln('<div id="segon2" style="position:absolute;width:'+amplada+';left:0;top:0;visibility:hidden">')
						document.write(missatges[1])
						document.writeln('</div>')
						document.writeln('</div>')
						document.writeln('</span>')
					}
					iniciar();
				</script> 
				</b>
			</div>
			</div>
			
			<br class="clear"/>
			
			<div>	 
				<table width="100%" border="0" cellpadding="0" cellspacing="0" >
				<tr class="date_title">
					<td> 
						 <img src="/resource/images/bass_1st/icon_carlender.gif" align="absmiddle"> 신규 요청 기술지원 [총: ${appTechSupAppMain} 건]  
					</td>
					<td align="right">
						<input name="button4222" type="button" class="buttonsmall04" onClick="javascript:window.location.href='/sgportal/techsup/techsupAppList.sg?actType=list&hmenu_id=007000000';" value="기술지원"/>
					</td>
				</tr>
				<tr><td style="padding:0 0 0 0;" align="center" colspan="2">
				  <table width="100%" border="0" cellpadding="0" cellspacing="0"  class="grid_date" >
					<thead>
					  <tr>
						<th>
							<!--${fn:substring(stDay,0,4)}년 ${fn:substring(stDay,4,6)}월 ${fn:substring(stDay,6,8)}일 ~ ${fn:substring(edDay,0,4)}년 ${fn:substring(edDay,4,6)}월 ${fn:substring(edDay,6,8)}일-->
								<table  width="100%">
									<tr>
										<th width="15%" scope="col" id="odd">고객사(담당자)</th>
										<th width="20%" scope="col" id="odd">프로젝트명</th>
										 
										<th scope="col" id="odd">제목</th> 
										
										<th width="10%" scope="col" id="odd">접수일</th>
										<th width="10%" scope="col" id="odd">지원예정일</th>
										<th width="10%" scope="col" id="odd">지원요청자</th>		
									</tr>
								</table>  
						</th>
					  </tr>
					  
					  <c:forEach items='${techSupAppMain}' var='data' varStatus='i'>
					  	<tr>
							<td style="padding-left:15px;" <c:if test="${sessionMap.ADMIN_NM==data.CHMAN_NM}">bgcolor="#C2DAFE"</c:if> <c:if test="${i.index%2==0}"> bgcolor="#ececec"</c:if>>
								
								
								<!--
								<img src="/resource/images/bass_1st/date_icon.gif">&nbsp;&nbsp;
								 ${fn:substring(data.ST_DATE, 4, 6)}.${fn:substring(data.ST_DATE, 6, 8)} &nbsp; ~ 
								 ${fn:substring(data.END_DATE, 4, 6)}.${fn:substring(data.END_DATE, 6, 8)} &nbsp;  
								&nbsp;&nbsp;&nbsp;&nbsp;
								${data.CHMAN_NM}
								-->
								<table  width="100%">
									<tr> 
										<td width="15%" style="padding-left:5px">${data.CL_CORP_NM}(${data.PJT_CHMAN_NM})</td>
										<td width="20%" style="padding-left:5px">${fn:substring(data.PJT_NAME, 0, 15)}</b><c:if test="${fn:length(data.PJT_NAME) > 15}">...</c:if></td>
										 
										<td style="padding-left:5px">
											<c:if test="${sessionMap.ADMIN_NM==data.CHMAN_NM}"><b></c:if> 
											<a href="/sgportal/techsup/techsupApp.sg?actType=view&tech_sup_app_no=${data.TECH_SUP_APP_NO}&hmenu_id=007000000">
											${fn:substring(data.APP_TITLE, 0, 28)}<c:if test="${fn:length(data.APP_TITLE) > 28}">...</c:if>
											</a>
											<c:if test="${sessionMap.ADMIN_NM==data.CHMAN_NM}"></b></c:if> 
										</td> 
										
										<td width="10%" align="center" style="padding-right:15px">${data.APP_REC_DATE}</td>
										<td width="10%" align="center" style="padding-right:10px">${data.ABOUT_DATE1}</td>
										<td width="10%" align="center" style="padding-right:15px">
											<c:if test="${sessionMap.ADMIN_NM==data.CHMAN_NM}"><b></c:if> 
											${data.CHMAN_NM}
											<c:if test="${sessionMap.ADMIN_NM==data.CHMAN_NM}"></b></c:if> 
										</td>		
									</tr>
								</table>   
							</td> 
					  	</tr>
					  </c:forEach> 
					</thead>
				  </table></td>
				 </tr>
				</table>
			</div>
			<br/>
				 
				 
		 
			<div>	
				<table width="100%" border="0" cellpadding="0" cellspacing="0" >
				<tr class="date_title">
					<td> 
						 <img src="/resource/images/bass_1st/icon_carlender.gif" align="absmiddle"> 진행 중 기술지원 [총: ${selectTechsupAppTotCountIng} 건]  
					</td>
					<td align="right">
						<input name="button4222" type="button" class="buttonsmall04" onClick="javascript:window.location.href='/sgportal/techsup/techsupAppList.sg?actType=list&hmenu_id=007000000';" value="기술지원"/>
					</td>
				</tr>				
				<tr><td style="padding:0 0 0 0;" colspan="2">
				  <table width="100%" border="0" cellpadding="0" cellspacing="0"  class="grid_date" >
					<thead>
					  <tr>
						<th>
							<!--${fn:substring(stDay,0,4)}년 ${fn:substring(stDay,4,6)}월 ${fn:substring(stDay,6,8)}일 ~ ${fn:substring(edDay,0,4)}년 ${fn:substring(edDay,4,6)}월 ${fn:substring(edDay,6,8)}일-->
								<table  width="100%">
									<tr>
										<th width="10%" scope="col" id="odd">진행상태</th>	
										<th width="15%" scope="col" id="odd">고객사</th>
										<th width="20%" scope="col" id="odd">프로젝트명</th>
										<th width="10%" scope="col" id="odd">프로젝트담당</th>
										
										<th scope="col" id="odd">제목</th>
										
										<th width="10%" scope="col" id="odd">일정(예정)일</th>
										<th width="10%" scope="col" id="odd">지원요청자</th>	
										<th width="10%" scope="col" id="odd">지원담당자</th>		
									</tr>
								</table>  
						</th>
					  </tr>
					  
					  <c:forEach items='${techSupAppIng}' var='data' varStatus='i'>
					  	<tr>
							<td style="padding-left:15px;"  <c:if test="${sessionMap.ADMIN_NM==data.TECH_SUP_APP_NM1}">bgcolor="#C2DAFE"</c:if> <c:if test="${i.index%2==0}"> bgcolor="#ececec"</c:if>>  
								<!--
								<img src="/resource/images/bass_1st/date_icon.gif">&nbsp;&nbsp;
								 ${fn:substring(data.ST_DATE, 4, 6)}.${fn:substring(data.ST_DATE, 6, 8)} &nbsp; ~ 
								 ${fn:substring(data.END_DATE, 4, 6)}.${fn:substring(data.END_DATE, 6, 8)} &nbsp;  
								&nbsp;&nbsp;&nbsp;&nbsp;
								${data.CHMAN_NM}
								-->
								<table  width="100%"> 
									<tr>
										<td width="10%" style="padding-left:5px">
											<a href="/sgportal/techsup/techsupApp.sg?actType=view&tech_sup_app_no=${data.TECH_SUP_APP_NO}&hmenu_id=007000000">
												<b>${data.TECH_SUP_STATUS_CODE_NM}</b>													
											</a>
										</td>
										<td width="15%" style="padding-left:5px">${data.CL_CORP_NM}</td>
										
										<td width="20%" style="padding-left:5px">${fn:substring(data.PJT_NAME, 0, 15)}</b><c:if test="${fn:length(data.PJT_NAME) > 15}">...</c:if></td>
										<td width="10%" align="center"  style="padding-right:15px">${data.PJT_CHMAN_NM}</td>
										 
										<td style="padding-left:5px">
											<c:if test="${sessionMap.ADMIN_NM==data.TECH_SUP_APP_NM1}"><b></c:if>
											<a href="/sgportal/techsup/techsupApp.sg?actType=view&tech_sup_app_no=${data.TECH_SUP_APP_NO}&hmenu_id=007000000">
												${fn:substring(data.APP_TITLE, 0, 10)}<c:if test="${fn:length(data.APP_TITLE) > 10}">...</c:if>
											</a>
											<c:if test="${sessionMap.ADMIN_NM==data.TECH_SUP_APP_NM1}"></b></c:if>
										</td>
										
										<td width="10%" align="center" style="padding-right:15px">
											<c:choose>
												<c:when test="${!empty data.ST_DATE}">
													${data.ST_DATE}	
												</c:when>
												<c:otherwise>
													${data.ABOUT_DATE1}
												</c:otherwise>
											</c:choose> 
										</td>
										<td width="10%" align="center" style="padding-right:15px">${data.CHMAN_NM}</td>
										<td width="10%" align="center" style="padding-right:15px">  
											<c:if test="${sessionMap.ADMIN_NM==data.TECH_SUP_APP_NM1}"><b></c:if>
											${data.TECH_SUP_APP_NM1}
											<c:if test="${sessionMap.ADMIN_NM==data.TECH_SUP_APP_NM1}"></b></c:if> 
										</td>		
									</tr>
								</table>   
							</td> 
					  	</tr>
					  </c:forEach> 
					</thead>
				  </table></td>
				 </tr>
				</table>
			</div><!--일정관리끝 -->	  
			<br/>	 
			
			
		 
	 
 