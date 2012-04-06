<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/web/jsp/common/inc/commonInc.jsp" %>
<!---------------------------------------------------------
 *  jsp설명 : 
 *  @file   : 
 *  @date   : 
 *  @Modified Date : 
 *  @Version  
 *  @Make   : 
---------------------------------------------------------->














<!------------------------------------------------------------------------
 * 레이아웃
-------------------------------------------------------------------------->


<table width="100%" border="0" cellpadding="0" cellspacing="0">  
	<tr>
		<td align="center" valign="top">
			<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
				<tr valign="middle">
					<td>
						<!--제목과 경로가 들어가는 테이블입니다. -->
							<table width="100%" border="0" cellpadding="0" cellspacing="0">
								<tr>
									<td width="20%" class="txt_tt">SG 제품 정보 </td>
									<td width="80%" align="right">SG 제품 정보 > 수정</td>
								</tr>
							</table>
						<!--제목과 경로가 들어가는 테이블입니다. -->
					</td>
				</tr> 
				<tr>
					<td height="5" colspan="2" class="line_bg"></td>
				</tr>
				<tr>
					<td colspan="2" align="left" height="20px">&nbsp;</td>
				</tr>
				
				<tr>
				  <td colspan="2" ><table width="100%" border="0" cellpadding="0" cellspacing="0"  id="table_gray" rules="cols">
				    <tr>
                      <td colspan="2" id="odd" scope="col">제품명</td>
				      <td>SG SecuXML(Java) </td>
			        </tr>
				    <tr>
                      <td width="20%" colspan="2" id="odd" scope="col">버전</td>
				      <td><input type="text" name="textfield2" class="Input_w " style="width:70%">
			          <img src="resource/images/admin/img/btn_small_files.gif" width="61" height="22" align="absmiddle"></td>
			        </tr>
				    <tr>
                      <td colspan="2" id="odd" scope="col">출시일</td>
				      <td><input type="text" name="textfield24" class="Input_w ">
			          <img src="resource/images/admin/img/btn_small_date.gif" width="61" height="22" align="absmiddle"></td>
			        </tr>
				    <tr>
                      <td colspan="2" id="odd" scope="col">개발담당자</td>
				      <td>홍길동(전화:02-333-1234 <img src="resource/images/admin/img/btn_small_mans.gif" width="69" height="22" align="absmiddle"></td>
			        </tr>
				    <tr>
                      <td colspan="2" id="odd" scope="col">제품유형</td>
				      <td><label>
				        <input type="checkbox" name="checkbox" value="checkbox">
				      </label>
			          서버, 
			          <input type="checkbox" name="checkbox2" value="checkbox">
			          클라이언트</td>
			        </tr>
				    <tr>
                      <td colspan="2" id="odd" scope="col">메뉴얼</td>
				      <td> 사용자메뉴얼&lt;삭제&gt;,운영자용&lt;삭제&gt;,설치가이드&lt;삭제&gt; <br>
				        <input type="text" name="textfield25" class="Input_w " style="width:70%">
			           <img src="resource/images/admin/img/btn_small_files.gif" width="61" height="22" align="absmiddle"></td>
			        </tr>
				    <tr>
                      <td rowspan="2" id="odd" scope="col">요구사항</td>
				      <td scope="col" id="odd">HW</td>
				      <td>&nbsp;CPU : 
			              <input type="text" name="textfield252" class="Input_w " style="width:450px">
			            <br>
			            &nbsp;RAM :
			            <input type="text" name="textfield253" class="Input_w " style="width:450px">
			            <br>
		              &nbsp;HDD
		              
		              :
		              <input type="text" name="textfield254" class="Input_w " style="width:450px">
		              <br>
		              &nbsp;NIC :&nbsp;
		              <input type="text" name="textfield255" class="Input_w " style="width:450px">		          		          </td>
		            </tr>
				    <tr>
                      <td id="odd" scope="col">SW</td>
				      <td> &nbsp;OS&nbsp; : 
				        <input type="text" name="textfield256" class="Input_w " style="width:450px">
				        <br>
				        &nbsp;DG&nbsp; : 
				        <input type="text" name="textfield257" class="Input_w " style="width:450px">
				        <br>
				      &nbsp;Web: 
				      <input type="text" name="textfield258" class="Input_w " style="width:450px">
				      <br>
				      &nbsp;WAS: 
				      <input type="text" name="textfield259" class="Input_w " style="width:450px"></td>
			        </tr>
				    <tr>
                      <td rowspan="3" id="odd" scope="col">제품소개</td>
				      <td id="odd" scope="col">소개</td>
				      <td><input type="text" name="textfield2142" class="Input_w " style="width:70%"></td>
			        </tr>
				    <tr>
                      <td id="odd" scope="col">기능</td>
				      <td><input type="text" name="textfield2143" class="Input_w " style="width:70%"></td>
			        </tr>
				    <tr>
                      <td id="odd" scope="col">브로셔</td>
				      <td> 카타로그삭제<br>
				        <label>
				        <input type="text" name="textfield214" class="Input_w " style="width:70%">
			          <img src="resource/images/admin/img/btn_small_files.gif" width="61" height="22" align="absmiddle"></label></td>
			        </tr>
				    <tr>
                      <td colspan="2" id="odd" scope="col">기능 변경 사항 </td>
				      <td></a>
				      <label>
				      <textarea name="textarea" rows="3" style="width:95%">aaaa
bbbb
cccc</textarea>
				      </label></td>
			        </tr>

                  </table></td>
				</tr>
				<tr align="right" valign="middle">
				<!-- 권한 에 따른 쓰기기능 제어 시작  -->		
				
					<td colspan="2" >
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
                          <tr>
                            <td><input name="button3" type="button" class="button03" onClick="javascript:jf_go()" value="목록"/></td>
                            <td align="right"><input name="button22" type="button" class="button03" onClick="javascript:jf_go()" value="뒤로"/><input name="button2" type="button" class="button03" onClick="javascript:jf_go()" value="수정"/><input name="button" type="button" class="button03" onClick="javascript:jf_go()" value="초기화"/></td>
                          </tr>
                        </table>
				  </td>
				
				<!-- 권한 에 따른 쓰기기능 제어 끝  -->		
				</tr>
			</table>
		</td>
	</tr>
</table>	

