<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/web/jsp/common/inc/commonInc.jsp" %>

<LINK href="/resource/common/css/calendar.css" type="text/css" rel="stylesheet">
<script type="text/javascript" src="/resource/common/js/calendar.js"></script>

<SCRIPT LANGUAGE="JavaScript">
<!--
    function jsExecuteBatch() {
        if(Validator.validate(document.dForm)) {
            document.dForm.action="./batchExecute.sg";
            document.dForm.submit();
        }
    }
//-->
</SCRIPT>

<form name='dForm' method='post'>	
    <input type="hidden" name="batch_cd" value="${batWorkData.batWork.batch_cd}"/>

<table width="100%" border="0" cellpadding="0" cellspacing="0">  
    <tr>
        <td align="center" valign="top">
            <table width="90%" height="100%" border="0" cellpadding="0" cellspacing="0">
                <tr valign="middle">
                    <td>
                        <!--제목과 경로가 들어가는 테이블입니다. -->
                            <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td  class="txt_tt" colspan="2">${menuNavi}</td>
                                </tr>
                            </table>
                        <!--제목과 경로가 들어가는 테이블입니다. -->
                    </td>
                </tr> 
                <tr>
                    <td height="5" colspan="2" class="line_bg"></td>
                </tr>
                <tr>
                    <td colspan="2" align="left" height="40px">&nbsp;</td>
                </tr>
                
                <tr>
                    <td colspan="2" >
                        <table width="100%" border="0" cellpadding="0" cellspacing="0"  id="table_gray" rules="cols" summary="배치작업실행">
                            <tr>
                                <th scope="col" id="odd">배치작업 명</th>
                                <td>${batWorkData.batWork.batch_nm}</td>
                            </tr>
                            <tr>
                                <td colspan="2" >
                                    <table width="100%" border="1" cellpadding="1" cellspacing="1" id="fig1_01">
                                        <tr>
                                            <th scope="col" id="odd">PARAM1</th>
                                            <td>
                                                <input type="text" id="param1" name="param1" value="${batWorkData.batWork.param1}"/>
                                            </td>
                                            <th scope="col" id="odd">PARAM2</th>
                                            <td>
                                                <input type="text" id="param2" name="param2" value="${batWorkData.batWork.param2}"/>
                                            </td>
                                            <th scope="col" id="odd">PARAM3</th>
                                            <td>
                                                <input type="text" id="param3" name="param3" value="${batWorkData.batWork.param3}"/>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th scope="col" id="odd">PARAM4</th>
                                            <td>
                                                <input type="text" id="param4" name="param4" value="${batWorkData.batWork.param4}"/>
                                            </td>
                                            <th scope="col" id="odd">PARAM5</th>
                                            <td colspan="3">
                                                <input type="text" id="param5" name="param5" value="${batWorkData.batWork.param5}"/>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <th scope="col" id="odd">
                                                                    실행소스
                                </th>
                                <td>
                                    <textarea style="width:320px;" id="source" name="source" rows="10"  class="required" title="실행소스">${batWorkData.batWork.source}</textarea>
                                </td>
                            </tr>
                            <tr>
                                <th scope="col" id="odd">
                                                                    주기설정
                                </th>
                                <td>
			                        <c:forEach items="${batWorkData.batchOptionList}" var="batchOption" varStatus="i">
			        
			                            <c:if test="${batchOption.CD_ID eq batWorkData.batWork.batch_cycle}">${batchOption.CD_NM}</c:if>
			        
			                        </c:forEach>&nbsp;
			
			                        <span id="monthDiv" <c:if test="${batWorkData.batWork.batch_cycle ne msg:getString('common.batch-info.batch-cycle.month')}">style="display:none;"</c:if>>
			        
			                        ${batWorkData.batWork.month } 개월
			        
			                        </span>
			                        <span id="dayDiv" <c:if test="${batWorkData.batWork.batch_cycle ne msg:getString('common.batch-info.batch-cycle.day')}">style="display:none;"</c:if>>
			
			                        ${batWorkData.batWork.day} 일
			        
			                        </span>
			                        <span id="hourDiv" <c:if test="${batWorkData.batWork.batch_cycle ne msg:getString('common.batch-info.batch-cycle.hour')}">style="display:none;"</c:if>>
			        
			                        ${batWorkData.batWork.hour} 시간
			        
			                        </span>
			                        <span id="minuteDiv" <c:if test="${batWorkData.batWork.batch_cycle ne msg:getString('common.batch-info.batch-cycle.minute')}">style="display:none;"</c:if>>
			
			                        ${batWorkData.batWork.minute} 분
			                        </span>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr align="right" valign="middle">
                    <td colspan="2" >

                <!-- 권한 에 따른 쓰기기능 제어 시작  -->        
                <c:if test="${writeGrant != '0' }">
		            <input type="button" class="button" value="실행" style="margin-right:10px;" onclick="javascript:jsExecuteBatch();"/>
		            <input type="button" class="button" value="닫기" style="margin-right:10px;" onclick="javascript:self.close();"/>
                </c:if>
                <!-- 권한 에 따른 쓰기기능 제어 끝  -->

                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>

</form>