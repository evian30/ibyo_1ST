<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.signgate.core.web.util.*" %>
<%@ include file="/WEB-INF/web/jsp/common/inc/commonInc.jsp" %>


<link rel="stylesheet" type="text/css"  href="/resource/common/css/common_renew.css" />
<script type="text/javascript" src="/resource/common/js/ajax.js"></script>
 

<script type="text/javascript">
 
function jf_search(){
	if(document.vForm.keyword.value == ""){
		alert('검색어를 입력하세요.');
		document.vForm.keyword.focus();
		return;
	}
	document.vForm.action = "/core/manage/suser/userList.sg";
	document.vForm.submit();
}

function jf_go(){
	location.href='/core/manage/suser/userAddForm.sg';
}
 
</SCRIPT>



<div style="width:70%;">	
	<form name='vForm' method='post'>
	<input type='hidden' name='group_id' value='${pMap.group_id}'>
	<input type='hidden' name='admin_id'>
	<input type='hidden' name='command' value="useradd">
	<table border="0" width="900" height="">
			<tr>
				<td colspan="2">
					<div class=" x-panel x-form-label-left" style="width: auto">
							<div class="x-panel-tl">
							<div class="x-panel-tr">
								<div class="x-panel-tc">
									<div class="x-panel-header x-unselectable" style="-moz-user-select: none;">
										<center><span class="x-panel-header-text">로그인 사용자 검색</span></center>
									</div>
								</div>
							</div>
						</div>
						<div class="x-panel-bwrap" >
							<div class="x-panel-ml">
								<div class="x-panel-mr">
									<div class="x-panel-mc" >
										<table border="0" width="100%"  style="font-size: 12px">
											<tr>
												<td width="30%"><div tabindex="-1" class="x-form-item " >
													<div tabindex="-1" class="x-form-item " >
														<label class="x-form-item-label" style="width: auto;" for="key" ></label>
														<div style="padding-left: 30px;" class="x-form-element">
															<select name='key' class="gray_txt">
															 <option value='0' <c:if test="${pMap.key == '0' || pMap.key == ''}">selected</c:if>>전체</option>
															 <option value='1' <c:if test="${pMap.key == '1'}">selected</c:if> >아이디</option>
															 <option value='2' <c:if test="${pMap.key == '2'}">selected</c:if>>이름</option>
															 <option value='3' <c:if test="${pMap.key == '3'}">selected</c:if>>회사명</option>
															</select>
														</div>
													</div>
												</td>
												
												<td width="70%" alugn="left"><div tabindex="-1" class="x-form-item " >
													<div tabindex="-1" class="x-form-item " >
														<label class="x-form-item-label" style="width: auto;" for="keyword" >검색어:</label>
															<div style="padding-left: 30px;" class="x-form-element">
																<input type='text' name='keyword' value='${pMap.keyword}' class="gray_txt" style="width:200px" alt="검색란" onkeypress="javascript:if(event.keyCode=='13'){jf_search();}"/>
															</div>
													</div>
												</td> 
											</tr>
											<tr align="right">
												<td colspan='2'>
													<div tabindex="-1" class="x-form-item " >
														<table cellspacing="0" class="x-btn  x-btn-noicon" style="width: 50px;">
															<tbody class="x-btn-small x-btn-icon-small-left">
																<tr><td class="x-btn-tl"><i>&nbsp;</i></td><td class="x-btn-tc"></td><td class="x-btn-tr"><i>&nbsp;</i></td></tr>
																<tr>
																	<td class="x-btn-ml"><i>&nbsp;</i></td>
																	<td class="x-btn-mc">
																		<em unselectable="on" class="">
																			<button type="button" id="searchBtn1" onclick="jf_search();" class=" x-btn-text">검색하기</button>
																		</em>
																	</td>
																	<td class="x-btn-mr"><i>&nbsp;</i></td>
																</tr>
																<tr>
																	<td class="x-btn-bl"><i>&nbsp;</i></td><td class="x-btn-bc"></td><td class="x-btn-br"><i>&nbsp;</i></td>
																</tr>
															</tbody>
														</table>
													</div>
												</td>
												<td colspan='3'>
													<div tabindex="-1" class="x-form-item " >
														<table cellspacing="0" class="x-btn  x-btn-noicon" style="width: width: 50px;;">
															<tbody class="x-btn-small x-btn-icon-small-left">
																<tr><td class="x-btn-tl"><i>&nbsp;</i></td><td class="x-btn-tc"></td><td class="x-btn-tr"><i>&nbsp;</i></td></tr>
																<tr>
																	<td class="x-btn-ml"><i>&nbsp;</i></td>
																	<td class="x-btn-mc">
																		<em unselectable="on" class="">
																			<button type="button" id="searchClearBtn1" onclick="goRefresh();" class=" x-btn-text">조건해제</button>
																		</em>
																	</td>
																	<td class="x-btn-mr"><i>&nbsp;</i></td>
																</tr>
																<tr><td class="x-btn-bl"><i>&nbsp;</i></td><td class="x-btn-bc"></td><td class="x-btn-br"><i>&nbsp;</i></td></tr>
															</tbody>
														</table>
													</div>
												</td> 
											</tr>
										</table>
									</div>
								</div>
							</div>
						</div> 
					</div>
				</td>
			</tr>
	</table> 
	</form>
	  
	
	<table border="0" width="900" height="">
		<tr>
			<td colspan="2">
				<div class=" x-panel x-form-label-left" style="width: auto"> 
					<div class="x-panel-tl">
						<div class="x-panel-tr">
							<div class="x-panel-tc">
								<div class="x-panel-header x-unselectable" style="-moz-user-select: none;">
									<center><span class="x-panel-header-text">로그인 사용자 목록</span></center>
								</div>
							</div>
						</div>
					</div>
					 	 						
					<table width="100%" border="0" cellpadding="0" cellspacing="0"  id="table_gray" rules="cols" summary="관리자 관리" class="grid" rules="cols">
						<tr>					
							<th scope="col" id="odd">사번</th>
							<th scope="col" id="odd">아이디</th>
							<th scope="col" id="odd">비밀번호</th>
							<th scope="col" id="odd">이름</th>
							<th scope="col" id="odd">회사명</th>
							<th scope="col" id="odd">전화</th>
							<th scope="col" id="odd">이메일</th> 					
						</tr>
						<c:forEach items="${userList}" var="user" varStatus="i">
							<tr <c:if test="${i.index%2==0}"> bgcolor="#fafafa"</c:if>>
								<td  style="padding-left:10px;">${user.SABUN}</td>
								<td  style="padding-left:10px;"><!--<a href="/core/manage/suser/userModForm.sg?admin_id=${user.ADMIN_ID}">}-->${user.ADMIN_ID}</a></td>
								<td  style="padding-left:10px;">${user.ADMIN_PW}</td>
								<td  style="padding-left:10px;">${user.ADMIN_NM}</td>
								<td style="padding-left:10px;">
								<c:choose>
									<c:when test="${user.COR_NM == null || user.COR_NM == ''}">&nbsp</c:when>
									<c:otherwise>${user.COR_NM}</c:otherwise>
								</c:choose>
								<td  style="padding-left:10px;">${user.TEL}</td>
								</td>
								<td style="padding-left:10px;">
								<c:choose>
									<c:when test="${user.ADMIN_MAIL == null || user.ADMIN_MAIL == ''}">&nbsp</c:when>
									<c:otherwise>${user.ADMIN_MAIL}</c:otherwise>
								</c:choose>
								</td>
							</tr>
						</c:forEach>
					</table>		
					
					<div class="paging">
						${pageNavi.pageNavigator}
					</div> 
				</div>
			</td>
		</tr>
	</table>
		
				
	 
													
	
	<div class="btn" style="width: 900">						
		<div class="leftbtn">
			
		</div>
		<div class="rightbtn">
			<!-- 권한 에 따른 쓰기기능 제어 시작  -->		
			<c:if test="${writeGrant != '0' }">
				<table cellspacing="0" class="x-btn  x-btn-noicon" style="width: 50px">
					<tbody class="x-btn-small x-btn-icon-small-left"> 
						<tr><td class="x-btn-tl"><i>&nbsp;</i></td><td class="x-btn-tc"></td><td class="x-btn-tr"><i>&nbsp;</i></td></tr>
						<tr>
							<td class="x-btn-ml"><i>&nbsp;</i></td>
							<td class="x-btn-mc">
								<em unselectable="on" class="">
									<button type="button" id="searchBtn1" onclick="javascript:jf_go();" class=" x-btn-text">등록하기</button>
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
</div>

				
