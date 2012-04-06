<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/web/jsp/common/inc/commonInc.jsp" %>
<script language='javascript'>

	function MM_openBrWindow(chk, sche_no, tech_sup_app_no, chman_no, sch_date, sch_time) { //v2.0		    
	
		features = 'width=500,height=350,left=430,top=220';
		winName = '';
		theURL = '/sgportal/schedule/scheduleWrite.sg?gubun=week';
		        
		theURL = theURL + 
				'&chk=' + chk + 
				'&sche_no=' + sche_no + 
				'&tech_sup_app_no=' + tech_sup_app_no + 
				'&chman_no=' + chman_no +
				'&sch_date=' + sch_date +   
				'&sch_time=' + sch_time;   
		window.open(theURL,winName,features);
	}
</script>
<div id="contents">
		<!-- 화면 제목 시작 --> 
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
			> 주단위 일정
		</div>
	</div>

		
		
		<!-- 
			<div id="title">주단위 일정</div>
			<div id="location">기술 지원 &gt; 주단위 일정</div>
			</div>	
			 -->
		 
		
		<!-- 탭 시작 -->
		<div class="tab_v" >  
			<div class="tabon"><a href="./weekSchedule.sg"><b style="color:#FFFFFF">주(週)</a></div>
			<div class="taboFF"><a href="./monthSchedule.sg">월(月)</a></div> 
		</div> 
		<div class="tab_v_con">
		
		<!-- 월이동 시작 -->
		<b class="rtop"><b class="r1"></b><b class="r2"></b><b class="r3"></b><b class="r4"></b></b> 
		<div class="search" align="center">
			<a href="./weekSchedule.sg?schWeek=${stWeek}"><img src="/resource/images/bass_1st/bt_before.gif" alt="이전주" /></a>
				${fn:substring(stDay,0,4)}년 ${fn:substring(stDay,4,6)}월 ${fn:substring(stDay,6,8)}일 ~ ${fn:substring(edDay,0,4)}년 ${fn:substring(edDay,4,6)}월 ${fn:substring(edDay,6,8)}일
			<a href="./weekSchedule.sg?schWeek=${edWeek}"><img src="/resource/images/bass_1st/bt_next.gif" alt="다음주" /></a>
		</div>
		<b class="rbottom"><b class="r4"></b><b class="r3"></b><b class="r2"></b><b class="r1"></b></b>
		<br/>	 
		
		
		<!-- 그리드 시작 -->
		<table width="100%" border="0" cellpadding="0" cellspacing="0"  class="grid">
			<tr>
				<th scope="col" id="odd" rowspan="2">시간/일</th>
				<th scope="col" id="odd"><b style="color:red">일</b></th>
				<th scope="col" id="odd"><b style="color:black">월</b></th>
				<th scope="col" id="odd"><b style="color:black">화</b></th>
				<th scope="col" id="odd"><b style="color:black">수</b></th>
				<th scope="col" id="odd"><b style="color:black">목</b></th>
				<th scope="col" id="odd"><b style="color:black">금</b></th>
				<th scope="col" id="odd"><b style="color:blue">토</b></th>
			</tr>
			
			<tr>
			 
			<c:forEach items="${weekDay}" var="x" >
				<th scope="col" id="odd">
					<c:if test="${fn:substring(x,6,8)>9}">
						${fn:substring(x,6,8)}
					</c:if>
					<c:if test="${fn:substring(x,6,8)<10}">
						${fn:substring(x,7,8)}
					</c:if>
					일
				</th>
			</c:forEach>
			</tr>
			
			<c:forEach var="i" begin="0" end="${fn:length(weekScheduleTime) - 1}">
				<c:if test="${i%2==1}">
					<tr bgcolor="f1f1f1">
				</c:if>
				<c:if test="${i%2==0}">
					<tr>
				</c:if>
				 
					<td width="9%" scope="col" id="odd">${fn:substring(weekScheduleTime[i],0,2)}:${fn:substring(weekScheduleTime[i],2,4)}</td>
					<c:forEach var="j" begin="0" end="6">
						<td width="13%" style="padding-bottom:1;padding-top:5">
						<c:forEach items="${list}" var="x" varStatus="k">  
					     	<c:if test="${!empty list && weekDay[j] == fn:substring(x.ST_DATE, 0, 8) && weekScheduleTime[i] <= fn:substring(x.ST_DATE, 8, 12) && weekScheduleTime[i + 1] > fn:substring(x.ST_DATE, 8, 12)}">
					     	<li>
					     		<c:if test="${x.TITLE!= ''}">
									<img src="/resource/images/bass_1st/main_icondot.gif" />
								</c:if>	
					     		<a href="javascript:MM_openBrWindow('modify', '${x.SCHE_NO}', '${x.TECH_SUP_APP_NO}', '${x.CHMAN_NO}','${weekDay[j]}', '${weekScheduleTime[i]}')" title="${x.TITLE}"> 
					     	 		<c:if test="${!empty x.CHMAN_NM}">(${x.CHMAN_NM})<br/></c:if>  
					     	 		${fn:substring(x.TITLE, 0, 11)}
									<c:if test="${fn:length(x.TITLE) > 11}">...</c:if> 
									
					     	 	</a>
					     	 </li><div style="height:4px"></div>
					     	</c:if>
					    </c:forEach>
					    
					    <li><a href="javascript:MM_openBrWindow('write', '${x.SCHE_NO}', '${x.TECH_SUP_APP_NO}', '${x.CHMAN_NO}', '${weekDay[j]}', '${weekScheduleTime[i]}');"></a></li>
						</td> 										
					</c:forEach>
				</tr>
			</c:forEach>
		</table>

	</div>