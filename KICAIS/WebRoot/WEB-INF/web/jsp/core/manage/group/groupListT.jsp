<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.signgate.core.web.util.*" %>
<%@ include file="/WEB-INF/web/jsp/common/inc/commonInc.jsp" %>

<link rel="stylesheet" type="text/css"  href="/resource/common/css/common_renew.css" />

<script type="text/javascript" src="/resource/common/js/ajax.js"></script>
<script type="text/javascript" src="/resource/common/js/jquery-1.3.2.min.js"></script>


<script type="text/javascript">
function jf_sbumit(){
	if(document.vForm.group_nm.value == ""){
		alert('그룹명을 입력하세요');
		document.vForm.group_nm.focus();
		return;
	}
	
	<c:forEach items="${groupList}" var="group" varStatus="i">
		if(document.vForm.group_nm.value == '${group.GROUP_NM}'){
			alert('이미 등록된 그룹명이 있습니다.');
			document.vForm.group_nm.focus();
			return;
		}
	</c:forEach>
	
	document.vForm.command.value = "add";
	document.vForm.action = "/core/manage/group/groupIns.sg";
	document.vForm.submit();
}

function jf_updGroup(){
	if(document.vForm.group_nm.value == ""){
		alert('그룹명을 입력하세요');
		document.vForm.group_nm.focus();
		return;
	}
	document.vForm.command.value = "mod";
	document.vForm.action = "/core/manage/group/groupUpd.sg";
	document.vForm.submit();
}

function jf_delGroup(group_id){
	if(confirm('그룹을 삭제 하시겠습니까?')){
		document.vForm.command.value = "del";
		document.vForm.group_id.value = group_id;
		document.vForm.action = "/core/manage/group/groupDel.sg";
		document.vForm.submit();
	}
}

function jf_mod(group_id, group_nm){
	document.vForm.group_id.value = group_id;
	document.vForm.group_nm.value = group_nm;
	 	
	<c:if test="${writeGrant != '0' }">
	$("#saveButton").attr("class", "buttonsmall04");
	document.getElementById("saveButton").value = "새로저장";
	document.getElementById("controll").innerHTML = "<div tabindex='-1' class='x-form-item ' >       																		"+											
													"	<table cellspacing='0' class='x-btn  x-btn-noicon' style='width: 50px;'>                                                "+
													"		<tbody class='x-btn-small x-btn-icon-small-left'>                                                                     "+
													"			<tr><td class='x-btn-tl'><i>&nbsp;</i></td><td class='x-btn-tc'></td><td class='x-btn-tr'><i>&nbsp;</i></td></tr>   "+
													"			<tr>                                                                                                                "+
													"				<td class='x-btn-ml'><i>&nbsp;</i></td>                                                                           "+
													"				<td class='x-btn-mc'>                                                                                             "+
													"					<em unselectable='on' class=''>                                                                                 "+
													 						<c:if test="${writeGrant != '0' }">                                                                            
													"							<button type='button' onclick='javascript:jf_updGroup()' style='height:19px' class=' x-btn-text'>수정</button> "+
													 						</c:if>                                                                                                        
													"					</em>                                                                                                         "+  						
													"				</td>                                                                                                             "+
													"				<td class='x-btn-mr'><i>&nbsp;</i></td>                                                                           "+
													"			</tr>                                                                                                               "+
													"			<tr><td class='x-btn-bl'><i>&nbsp;</i></td><td class='x-btn-bc'></td><td class='x-btn-br'><i>&nbsp;</i></td></tr>   "+
													"		</tbody>                                                                                                              "+
													"	</table>                                                                                                                "+
													"</div>                                                                                                                   "; 
	</c:if>
 
}

function jf_addUser(group_id){
	
	loadUrl("그룹사용자 관리", "/core/manage/group/groupUsersList.sg?group_id="+group_id);
}

function jf_viewMenu(group_id){
	var url = "/core/manage/group/menuGroups.sg?group_id="+group_id;
	window.open(url, 'viewMenu', 'width=400, height=400, scrollbars=yes');
}
 


</SCRIPT>

 
<div style="width:70%;">  
	
	<form name='vForm' method='post'>
	<input type="hidden" name='command'>
	<input type="hidden" name='group_id'>
	<table border="0" width="900" height="">
			<tr>
				<td colspan="2"> 
					<div class=" x-panel x-form-label-left" style="width: auto">						
							<div class="x-panel-tl">
							<div class="x-panel-tr">
								<div class="x-panel-tc">
									<div class="x-panel-header x-unselectable" style="-moz-user-select: none;">
										<center><span class="x-panel-header-text">그룹관리</span></center>
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
												<td width="100%"><div tabindex="-1" class="x-form-item " >
													<div tabindex="-1" class="x-form-item " >
														<label class="x-form-item-label" style="width: auto;" for="group_nm" >그룹명:</label>
														<div style="padding-left: 30px;" class="x-form-element">
															<input type='text' name='group_nm' class="gray_txt" style="padding-left:10px;" alt="검색란" onkeypress="javascript:if(event.keyCode=='13'){jf_search();}"/>
														</div>
													</div>
												</td>
											</tr>
											<tr align="right">
												<td>
													<div tabindex="-1" class="x-form-item " >
														<table cellspacing="0" class="x-btn  x-btn-noicon" style="width: 50px;">
															<tbody class="x-btn-small x-btn-icon-small-left">
																<tr><td class="x-btn-tl"><i>&nbsp;</i></td><td class="x-btn-tc"></td><td class="x-btn-tr"><i>&nbsp;</i></td></tr>
																<tr>
																	<td class="x-btn-ml"><i>&nbsp;</i></td>
																	<td class="x-btn-mc">
																		<em unselectable="on" class="">
																			<c:if test="${writeGrant != '0' }">
																				<button type="button" id="saveButton"  onclick="javascript:jf_sbumit()" class=" x-btn-text">저장</button> 
																			</c:if>
																		</em>
																	</td>
																	<td class="x-btn-mr"><i>&nbsp;</i></td> 
																</tr>
																<tr><td class="x-btn-bl"><i>&nbsp;</i></td><td class="x-btn-bc"></td><td class="x-btn-br"><i>&nbsp;</i></td></tr>
															</tbody>
														</table>
													</div>
												</td>
												<td><span id='controll'></span></td>
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
									<center><span class="x-panel-header-text">사용자 그룹 목록</span></center>
								</div>
							</div>
						</div>
					</div>	
									
					<table width="100%" border="0" cellpadding="0" cellspacing="0"  id="table_gray" rules="cols" summary="관리자 관리" class="grid" rules="cols">
						<tr>					
							<th scope="col" id="odd">그룹이름</th>
							<th scope="col" id="odd">사용자추가</th>
							<th scope="col" id="odd">그룹삭제</th>
							<th scope="col" id="odd">그룹에 포함 된 메뉴보기</th> 					
						</tr>
					<c:forEach items="${groupList}" var="group" varStatus="i">
						<tr <c:if test="${i.index%2==0}"> bgcolor="#fafafa"</c:if>>
							<td align='center'><a href="javascript:jf_mod('${group.GROUP_ID}', '${group.GROUP_NM}')">${group.GROUP_NM}</a></td>
							<td align='center'>
							<!-- 권한 에 따른 쓰기기능 제어 시작  -->		
							<c:choose>
							<c:when test="${writeGrant != '0' }">
								<a href="javascript:jf_addUser('${group.GROUP_ID}')">추가</a>
							</c:when>
							<c:otherwise>&nbsp;</c:otherwise>
							</c:choose>
							<!-- 권한 에 따른 쓰기기능 제어 끝  -->	
							</td>
							<td align='center'>
							<!-- 권한 에 따른 쓰기기능 제어 시작  -->		
							<c:choose>
							<c:when test="${writeGrant != '0' }">
								<a href="javascript:jf_delGroup('${group.GROUP_ID}')">삭제</a>
							</c:when>
							<c:otherwise>&nbsp;</c:otherwise>
							</c:choose>
							<!-- 권한 에 따른 쓰기기능 제어 끝  -->	
							</td>
							<td align='center'><a href="javascript:jf_viewMenu('${group.GROUP_ID}')">보기</a></td>
						</tr>
					</c:forEach>
					</table>
				</td>
			</tr>
		</table>
	
</div>		
					