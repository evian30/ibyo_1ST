<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/web/jsp/common/inc/commonInc.jsp" %>

<SCRIPT LANGUAGE="JavaScript">
<!--

//-->
</SCRIPT>

<form name='vForm' method='post'>
<table width="100%" border="0" cellpadding="0" cellspacing="0">  
    <tr>
        <td align="center" valign="top">
            <table width="90%" height="100%" border="0" cellpadding="0" cellspacing="0">
                <tr valign="middle">
                    <td>
                        <!--제목과 경로가 들어가는 테이블입니다. -->
                            <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td width="20%" class="txt_tt">배치작업이력리스트 </td>
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
                        <table width="100%" border="0" cellpadding="0" cellspacing="0"  id="table_gray" rules="cols" summary="배치작업리스트">
                            <thead>
                               <tr>
			                    <th scope="col" id="odd">번호</th>
			                    <th scope="col" id="odd">배치작업시작시간</th>
			                    <th scope="col" id="odd">배치작업종료시간</th>
			                    <th scope="col" id="odd">작업상태</th>
			                    <th scope="col" id="odd">예외메세지</th>
                               </tr>
                            </thead>
                            <tbody>
				                <c:forEach items="${batHistoryData.batHistoryList}" var="batHistory" varStatus="i">
				        
				                <tr id="list03">
				                    <td align='center'>${batHistoryData.pageNavi.startRowNo - i.index}</td>
				                    <td align='center'>${sgdate:getStringDateByFormat(batHistory.batch_s_time, "yyyy-MM-dd HH:mm:ss")}</td>
				                    <td align='center'>${sgdate:getStringDateByFormat(batHistory.batch_e_time, "yyyy-MM-dd HH:mm:ss")}</td>
				                    <td align='center'>${batHistory.batch_result}</td>
				                    <td align='center'>${batHistory.batch_memo}</td>
				                </tr>
				        
				                </c:forEach>
                            </tbody>
                        </table>
                    </td>
                </tr>
			    <tr>
			        <td align="center">${batHistoryData.pageNavi.pageNavigator}</td>
			    </tr>
            </table>
        </td>
    </tr>
</table>

</form>