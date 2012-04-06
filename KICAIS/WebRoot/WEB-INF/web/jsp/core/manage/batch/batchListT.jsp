<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/web/jsp/common/inc/commonInc.jsp" %>

<SCRIPT LANGUAGE="JavaScript">
<!--
    function jsViewBatHistory(batch_cd) {
        document.getElementById("batch_cd").value = batch_cd;
        var historyWin = window.open("", "historyWin", "toolbar=0, status=0, scrollbars=yes, location=0, menubar=0, width=600, height=500");
        document.dForm.action = "./batchHistoryList.sg";
        document.dForm.target = "historyWin";
        document.dForm.submit();
        historyWin.focus();
    }

    function jsBatchWriteForm(batch_cd) {
        document.getElementById("batch_cd").value = batch_cd;
        document.dForm.target = "_self";
        document.dForm.action = "./batchWriteForm.sg";
        if(batch_cd == '')
            document.getElementById("actionType").value = 'WRITE';
        else
            document.getElementById("actionType").value = 'UPDATE';
        document.dForm.submit();
    }

    function jsBatchExecute(batch_cd) {
        document.getElementById("batch_cd").value = batch_cd;
        var executeBatchWin = window.open("", "executeBatchWin", "toolbar=0, status=0, scrollbars=yes, location=0, menubar=0, width=740, height=560");
        document.dForm.action = "./batchExecuteForm.sg";
        document.dForm.target = "executeBatchWin";
        document.dForm.submit();
        executeBatchWin.focus();
    }
//-->
</SCRIPT>

<form name='vForm' method='post'>

<div id="title_line">
	<div id="title">배치작업리스트</div>
	<div id="location">${menuNavi} </div>
</div>


                  <table width="100%" border="0" cellpadding="0" cellspacing="0"  id="table_gray" rules="cols" summary="배치작업리스트" class="grid" rules="cols">
                      <thead>
       <tr>
           <th scope="col" id="odd">번호</th>
           <th scope="col" id="odd">배치작업명</th>
           <th scope="col" id="odd">프로그램유형</th>
           <th scope="col" id="odd">다음작업시간</th>
           <th scope="col" id="odd">마지막작업시간</th>
           <th scope="col" id="odd">마지막작업상태</th>
           <th scope="col" id="odd">&nbsp;</th>
           <th scope="col" id="odd">&nbsp;</th>
       </tr>
                      </thead>
                      <tbody>
       <c:forEach items="${batWorkData.batWorkList}" var="batWork" varStatus="i">

       <tr>
           <td style="padding-left:10px;">${batWorkData.pageNavi.startRowNo - i.index}</td>
           <td style="padding-left:10px;"><a href="javascript:jsBatchWriteForm('${batWork.batch_cd}');">${batWork.batch_nm}</a></td>
           <td style="padding-left:10px;">${batWork.batch_option}</td>
           <td style="padding-left:10px;">${sgdate:getStringDateByFormat(batWork.execute_time, "yyyy-MM-dd HH:mm:ss")}</td>

           <c:forEach items="${batWork.batHistory}" var="batHistory">
           <td style="padding-left:10px;">${sgdate:getStringDateByFormat(batHistory.batch_s_time, "yyyy-MM-dd HH:mm:ss")}</td>
           <td style="padding-left:10px;">
              ${batHistory.batch_result}
              <c:set var="currentTiem" value="${sgdate:getCurrentDate('yyyyMMddHHmmss')}"/>
              <c:if test="${batWork.batch_result eq '001' && batWork.execute_time < currentTiem}">
                  /수작업필요
              </c:if>
           </td>
           </c:forEach>
           <c:if test="${empty batWork.batHistory}">
               <td>&nbsp;</td>
               <td>&nbsp;</td>
           </c:if>

           <td><a href="javascript:jsViewBatHistory('${batWork.batch_cd}');">이력조회</a></td>
           <td><c:if test="${batWork.batch_result ne msg:getString('common.batch-info.batch-result.doing') || batWork.batch_result == null}"><a href="javascript:jsBatchExecute('${batWork.batch_cd}');">실행</a></c:if></td>
       </tr>

       </c:forEach>
	</tbody>
</table>

<div class="paging">
	${pageNavi.pageNavigator}
</div>		

<div class="btn">						
	<div class="leftbtn">
		
	</div>
	<div class="rightbtn">
		<!-- 권한 에 따른 쓰기기능 제어 시작  -->        
        <c:if test="${writeGrant != '0' }">
                <input name="button" type="button04" class="button" onfocus='this.blur()' value="작업등록" onclick="javascript:jsBatchWriteForm('');"/>
        </c:if>
        <!-- 권한 에 따른 쓰기기능 제어 끝  -->
	</div>
</div>
</form>

<form name="dForm" method="post">
    <input type="hidden" id="batch_cd" name="batch_cd"/>
    <input type="hidden" id="actionType" name="actionType"/>
</form>