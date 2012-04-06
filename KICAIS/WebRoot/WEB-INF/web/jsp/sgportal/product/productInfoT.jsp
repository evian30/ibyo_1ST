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
									<td width="80%" align="right">SG 제품 정보 > 상세</td>
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
				      <td>1.0 </td>
			        </tr>
				    <tr>
                      <td colspan="2" id="odd" scope="col">출시일</td>
				      <td>2009-10-21 </td>
			        </tr>
				    <tr>
                      <td colspan="2" id="odd" scope="col">개발담당자</td>
				      <td>홍길동(전화:02-333-1234</td>
			        </tr>
				    <tr>
                      <td colspan="2" id="odd" scope="col">제품유형</td>
				      <td>서버, 클라이언트</td>
			        </tr>
				    <tr>
                      <td colspan="2" id="odd" scope="col">메뉴얼</td>
				      <td> 사용자메뉴얼,운영자용,설치가이드 </td>
			        </tr>
				    <tr>
                      <td rowspan="2" id="odd" scope="col">요구사항</td>
				      <td scope="col" id="odd">HW</td>
				      <td> CPU: Sun Spark 2GHz <br>
				      RAM: 16GB<br>
				      HDD: 1GB<br>
				      NIC: 10/100Mbps</td>
			        </tr>
				    <tr>
                      <td id="odd" scope="col">SW</td>
				      <td> OS: Solaris 11<br>
				        DG: Oracle 10g<br>
				      Web: Apache 2.1<br>
				      WAS:Jeus 1.0</td>
			        </tr>
				    <tr>
                      <td rowspan="3" id="odd" scope="col">제품소개</td>
				      <td id="odd" scope="col">소개</td>
				      <td>XML 제품 </td>
			        </tr>
				    <tr>
                      <td id="odd" scope="col">기능</td>
				      <td> XML 처리 </td>
			        </tr>
				    <tr>
                      <td id="odd" scope="col">브로셔</td>
				      <td> 카타로그받기 </td>
			        </tr>
				    <tr>
                      <td colspan="2" id="odd" scope="col">기능 변경 사항 </td>
				      <td> v0.5, 제너레이터 버그 수정, 파서 성능개선 <br>
				      v0.3 ,XML 제너레이터 기능 추가 <br>
				      v0.1,XML 파서 개발 </td>
			        </tr>

                  </table></td>
				</tr>
				<tr align="right" valign="middle">
				<!-- 권한 에 따른 쓰기기능 제어 시작  -->		
				
					<td colspan="2" >
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
                          <tr>
                            <td><input name="button3" type="button" class="button03" onClick="javascript:jf_go()" value="목록"/></td>
                            <td align="right"><input name="button2" type="button" class="button03" onClick="javascript:jf_go()" value="수정"/><input name="button" type="button" class="button03" onClick="javascript:jf_go()" value="삭제"/></td>
                          </tr>
                        </table>
				  </td>
				
				<!-- 권한 에 따른 쓰기기능 제어 끝  -->		
				</tr>
			</table>
		</td>
	</tr>
</table>	

 
