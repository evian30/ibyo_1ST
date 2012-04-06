<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/web/jsp/common/inc/commonInc.jsp" %>
<%@page import="java.util.List"%>
 <div id="contents">
		<!-- 화면 제목 시작 --> 
		<div id="title_line">
			<div id="title">월단위 일정</div>
			<div id="location">기술 지원 &gt; 월단위 일정</div>
		</div>	 
		
		<!-- 탭 시작 -->
		<div class="tab_v" >  
			<div class="taboFF"><a href="./weekSchedule.sg">주(週)</a></div>
			<div class="tabon"><a href="./monthSchedule.sg"><b style="color:#FFFFFF">월(月)</b></a></div> 
		</div> 
		<div class="tab_v_con">
		
		<!-- 월이동 시작 -->
		<b class="rtop"><b class="r1"></b><b class="r2"></b><b class="r3"></b><b class="r4"></b></b> 
		<div class="search" align="center">
				<a href="./monthSchedule.sg?year=${viewData.pyear}&amp;month=${viewData.pmonth}""><img src="/resource/images/bass_1st/bt_before.gif" alt="이전달" /></a>
			${viewData.year}년${viewData.month}월
			<a href="./monthSchedule.sg?year=${viewData.nyear}&amp;month=${viewData.nmonth}"><img src="/resource/images/bass_1st/bt_next.gif" alt="다음달" /></a>
		</div>
		<b class="rbottom"><b class="r4"></b><b class="r3"></b><b class="r2"></b><b class="r1"></b></b>
		<br/>	 

		<!-- 탭 시작 -->
	 
		<!-- 그리드 시작 -->
		<table width="100%" border="0" cellpadding="0" cellspacing="0" class="grid">
			<tr>
				<th scope="col" id="odd"><b style="color:red">일</b></th>
				<th scope="col" id="odd"><b style="color:black">월</b></th>
				<th scope="col" id="odd"><b style="color:black">화</b></th>
				<th scope="col" id="odd"><b style="color:black">수</b></th>
				<th scope="col" id="odd"><b style="color:black">목</b></th>
				<th scope="col" id="odd"><b style="color:black">금</b></th>
				<th scope="col" id="odd"><b style="color:blue">토</b></th>
			</tr> 
			<c:set var="dday" value="0"/>
			<c:forEach var="i" begin="0" end="5">				
				<tr>
					<c:forEach var="j" begin="0" end="6">					
						<td style="height:20px;padding: 0px;">
							<table width="100%" height="100%" border="0">
								<tr>							
									<td align="center" style="height:20px;">																
										<c:if test="${empty dateTab[i][j].dday}">
											&nbsp;
										</c:if>
										<c:if test="${!empty dateTab[i][j].dday}">
											<c:if test="${dateTab[i][j].dday < 10}"><c:set var="dday" value="0${dateTab[i][j].dday}"/></c:if>
											<c:if test="${dateTab[i][j].dday > 9}"><c:set var="dday" value="${dateTab[i][j].dday}"/></c:if>
											<a href="./weekSchedule.sg?schWeek=${viewData.year}${viewData.month}${dday}">
												<b style="color:<c:if test='${ j==0}'>#f03c3c</c:if><c:if test='${ j==6}'>#4254db</c:if>;align:center"><c:out value="${dateTab[i][j].dday}"/> 일</b> 
											</a>
										</c:if>
									</td>
								</tr>
								<tr>
									<td style="width:150px;height:70px;padding:10px">
										<div>					 		
											<ul>													
												<c:if test="${!empty dateTab[i][j].datalist}">
													<c:set var="xx" value="${dateTab[i][j].datalist}"/>								
														<c:forEach items="${xx}" var="x">
															<li>
																<a href="./weekSchedule.sg?schWeek=${viewData.year}${viewData.month}${dday}">
																	<c:if test="${x.TITLE!= ''}">
																		<img src="/resource/images/bass_1st/main_icondot.gif" />
																	</c:if>	
																	(${fn:substring(x.ST_DATE, 8, 10)}:${fn:substring(x.ST_DATE, 10, 12)}) <b style="color:gray">${x.CHMAN_NM}</b><br/>
																	&nbsp;&nbsp;&nbsp;${fn:substring(x.TITLE, 0, 11)}<c:if test="${fn:length(x.TITLE) > 11}">...</c:if> 
																</a>
															</li>			
														</c:forEach>
												</c:if>	
											</ul>
										</div>
									</td>
								</tr>
							</table>				
						</td>
					</c:forEach>
				</tr>
			</c:forEach>			
		</table>
	
</div>		
