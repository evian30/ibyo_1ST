<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.signgate.core.web.util.*" %>
<%@ include file="/WEB-INF/web/jsp/common/inc/commonInc.jsp" %>

<link rel="stylesheet" type="text/css"  href="/resource/common/css/common_renew.css" />
<script type="text/javascript" src="/resource/common/js/ajax.js"></script>

<script type="text/javascript"> 
function jf_chGroupId(form){ 
	loadUrl("그룹사용자 관리", '/core/manage/group/groupUsersList.sg?group_id='+form.value);
}

function jf_AllCheck(){
	var len = document.vForm.admins.length;
	if(document.vForm.allCheck.checked == true){
		for(var i = 0; i < len; i++){
			document.vForm.admins[i].checked = true;
		}
	}else{
		for(var i = 0; i < len; i++){
			document.vForm.admins[i].checked = false;
		}
	}
}

function jf_addGroupsUser(group_id){
	var url = "/core/manage/group/userList.sg?group_id="+group_id;
	window.open(url, 'users', 'width=550, height=500, scrollbars=yes');
}

function jf_delGroupsUser(){
	if(document.vForm.admins != undefined){
		var len = document.vForm.admins.length;
		var admin_id = "";
		for(var i = 0; i < len; i++){
			if(document.vForm.admins[i].checked){
				admin_id = admin_id +","+document.vForm.admins[i].value;
			}
		}
		
		if(admin_id == ""){
			alert('삭제할 사용자를 선택하세요');
		}else{
			if(confirm("선택한 사용자를 삭제 하시겠습니까?")){
				document.vForm.admin_id.value = admin_id;
				document.vForm.action = "/core/manage/group/userGroupDel.sg";
				document.vForm.submit();
			}
		}	
	}
} 
</SCRIPT>



<div style="width:70%;">  
	
	<form name='vForm' method='post'>
	<input type='hidden' name='admin_id'>
	<input type='hidden' name='command' value="userdel">
	<input type='hidden' name='admins'> 
	
	<table border="0" width="900" height="">
			<tr>
				<td colspan="2"> 
					<div class=" x-panel x-form-label-left" style="width: auto">						
							<div class="x-panel-tl">
							<div class="x-panel-tr">
								<div class="x-panel-tc">
									<div class="x-panel-header x-unselectable" style="-moz-user-select: none;">
										<center><span class="x-panel-header-text">그룹사용자 관리</span></center>
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
															<select name='group_id' onChange="javascript:jf_chGroupId(this)"  style="paddign-left:10px;">
																<OPTION>::::그룹선택::::</OPTION>
																<c:forEach items="${groupList}" var="group" varStatus="i">
																	<option value='${group.GROUP_ID}' <c:if test="${group.GROUP_ID == pMap.group_id}">selected</c:if> >${group.GROUP_NM}</option>
																</c:forEach>
															</select>
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
																				<button type="button" id="saveButton"  onclick="javascript:jf_addGroupsUser('${pMap.group_id}')" class=" x-btn-text">사용자추가</button> 
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
			
 
	<table width="900" border="0" cellpadding="0" cellspacing="0" >
		<tr>	
			<td style="padding-right: 10px">
			<div class="btn">						
				<div class="leftbtn">
					
				</div>
				<div class="rightbtn">
					<!-- 권한 에 따른 쓰기기능 제어 시작  -->		
					<c:if test="${writeGrant != '0' }">
						<table cellspacing="0" class="x-btn  x-btn-noicon" style="width: 50px;">
							<tbody class="x-btn-small x-btn-icon-small-left"> 
								<tr><td class="x-btn-tl"><i>&nbsp;</i></td><td class="x-btn-tc"></td><td class="x-btn-tr"><i>&nbsp;</i></td></tr>
								<tr>
									<td class="x-btn-ml"><i>&nbsp;</i></td>
									<td class="x-btn-mc">
										<em unselectable="on" class="">
											<button type="button" id="searchBtn1"  onclick="javascript:jf_delGroupsUser();" class=" x-btn-text">사용자 삭제</button>
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
			</td>
		</tr>
	</table>		
						
	<table width="900" border="0" cellpadding="0" cellspacing="0"  id="table_gray" rules="cols" summary="관리자 관리" class="grid" rules="cols">
		<tr>			
		<!-- 권한 에 따른 쓰기기능 제어 시작  -->		
		<c:if test="${writeGrant != '0' }">		
			<th scope="col" id="odd" WIDTH='15%'>
				<input type='checkbox' name='allCheck' onclick="javascript:jf_AllCheck()">선택
			</th>
		</c:if>
		<!-- 권한 에 따른 쓰기기능 제어 시작  -->
			<th scope="col" id="odd">아이디</th>
			<th scope="col" id="odd">이름</th>
			<th scope="col" id="odd">회사명</th> 	
			<th scope="col" id="odd">이메일</th>				
		</tr>
		<c:forEach items="${groupUsers}" var="users" varStatus="i">
		<tr <c:if test="${i.index%2==0}"> bgcolor="#fafafa"</c:if>>
		<!-- 권한 에 따른 쓰기기능 제어 시작  -->
		<c:if test="${writeGrant != '0' }">	
			<td align='center'><input type='checkbox' name='admins' value='${users.ADMIN_ID}'></td>
		</c:if>
		<!-- 권한 에 따른 쓰기기능 제어 시작  -->
			<td align='center'>${users.ADMIN_ID}</td>
			<td align='center'>${users.ADMIN_NM}</td>
			<td align='center'>
			<c:choose>
				<c:when test="${users.COR_NM != null && users.COR_NM != ''}">
					${users.COR_NM}
				</c:when>
				<c:otherwise>&nbsp;</c:otherwise>
			</c:choose>
			</td>
			<td align='center'>
			<c:choose>
				<c:when test="${users.ADMIN_MAIL != null && users.ADMIN_MAIL != ''}">
					${users.ADMIN_MAIL}
				</c:when>
				<c:otherwise>&nbsp;</c:otherwise>
			</c:choose>
			</td>
		</tr>
		</c:forEach>
	</table>	 

</div>