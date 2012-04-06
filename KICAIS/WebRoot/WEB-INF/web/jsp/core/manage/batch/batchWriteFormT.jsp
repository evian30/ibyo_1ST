<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/web/jsp/common/inc/commonInc.jsp" %>

<LINK href="/resource/common/css/calendar.css" type="text/css" rel="stylesheet">
<script type="text/javascript" src="/resource/common/js/calendar.js"></script>

<SCRIPT LANGUAGE="JavaScript">
<!--
    function jsChangeBatchCycle() {
        var selIndex = document.getElementById("batch_cycle").selectedIndex;
        var cycle = document.getElementById("batch_cycle").options[selIndex].value;

        if(cycle == '${msg:getString("common.batch-info.batch-cycle.month")}') {
            document.getElementById("monthDiv").style.display = '';
            document.getElementById("dayDiv").style.display = 'none';
            document.getElementById("hourDiv").style.display = 'none';
            document.getElementById("minuteDiv").style.display = 'none';
        } else if(cycle == '${msg:getString("common.batch-info.batch-cycle.day")}') {
            document.getElementById("monthDiv").style.display = 'none';
            document.getElementById("dayDiv").style.display = '';
            document.getElementById("hourDiv").style.display = 'none';
            document.getElementById("minuteDiv").style.display = 'none';
        } else if(cycle == '${msg:getString("common.batch-info.batch-cycle.hour")}') {
            document.getElementById("monthDiv").style.display = 'none';
            document.getElementById("dayDiv").style.display = 'none';
            document.getElementById("hourDiv").style.display = '';
            document.getElementById("minuteDiv").style.display = 'none';
        } else if(cycle == '${msg:getString("common.batch-info.batch-cycle.minute")}') {
            document.getElementById("monthDiv").style.display = 'none';
            document.getElementById("dayDiv").style.display = 'none';
            document.getElementById("hourDiv").style.display = 'none';
            document.getElementById("minuteDiv").style.display = '';
        }
    }

    function jsBatWork() {
        if('${batWorkData.batWork.batch_result}' == '${msg:getString("common.batch-info.batch-result.fail")}') {
            alert('\'상태변경\' 이후에 정보를 수정 하실수 있습니다.');
            return;
        }

		if(Validator.validate(document.dForm)) {
		<c:choose>
		    <c:when test="${actionType eq 'WRITE'}">
			document.dForm.action="./batchWrite.sg";
			</c:when>
            <c:otherwise>
            document.dForm.action="./batchUpdate.sg";
            </c:otherwise>
        </c:choose>
	        document.dForm.submit();
		}
    }
    
    function jsChangeBatchResult() {
        if(Validator.validate(document.dForm)) {
            document.dForm.action="./batchResultUpdate.sg";
            document.dForm.submit();
        }
    }
    
    function jsBatchList() {
	    document.historyForm.action="./batchList.sg";
	    document.historyForm.submit();
    }
    
    function jsDelBatWork() {
        if(confirm('배치 작업을 삭제 하시겠습니까?')) {
	        document.dForm.action="./batchDelete.sg";
	        document.dForm.submit();
        }
    }
//-->
</SCRIPT>

<form name='dForm' method='post'>
    <input type="hidden" name="actionType" value="${actionType}"/>
    <input type="hidden" name="batch_cd" value="${batWorkData.batWork.batch_cd}"/>
    <input type="hidden" name="execute_time" value="${batWorkData.batWork.execute_time}"/>

<div id="title_line">
	<div id="title">배치작업등록</div>
	<div id="location">${menuNavi} </div>
</div>


                
                
          <table width="100%" border="0" cellpadding="0" cellspacing="0"  id="table_gray" summary="배치작업등록" class="grid" rules="cols">
     <tr>
         <th scope="col" id="odd">배치작업 명</th>
         <td><input type="text" id="batch_nm" name="batch_nm" class="required" title="배치작업 명" value="${batWorkData.batWork.batch_nm}"/></td>
     </tr>
     <tr>
         <th scope="col" id="odd">실행여부</th>
         <td>
             <select id="execute_div" name="execute_div">
                 <option value="Y" <c:if test="${batWorkData.batWork.execute_div eq 'Y'}">selected</c:if>>실행</option>
                 <option value="N" <c:if test="${batWorkData.batWork.execute_div eq 'N'}">selected</c:if>>미실행</option>
             </select>
         </td>
     </tr>
     <tr>
         <th scope="col" id="odd">사용여부</th>
         <td>
             <select id="use_div" name="use_div">
                 <option value="Y" <c:if test="${batWorkData.batWork.use_div eq 'Y'}">selected</c:if>>사용</option>
                 <option value="N" <c:if test="${batWorkData.batWork.use_div eq 'N'}">selected</c:if>>미사용</option>
             </select>
         </td>
     </tr>
     <tr>
         <th scope="col" id="odd">배치유형</th>
         <td>
             <input type="radio" id="batch_option" name="batch_option" value="${msg:getString('common.batch-info.batch-option.procedure')}" <c:if test="${batWorkData.batWork.batch_option eq msg:getString('common.batch-info.batch-option.procedure')}">checked</c:if>/> DB 프로시저
             <input type="radio" id="batch_option" name="batch_option" value="${msg:getString('common.batch-info.batch-option.sql')}" <c:if test="${batWorkData.batWork.batch_option eq msg:getString('common.batch-info.batch-option.sql')}">checked</c:if>/> DB 쿼리
         </td>
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
             <textarea id="source" name="source" rows="10" cols="100%" class="required" title="실행소스">${batWorkData.batWork.source}</textarea>
         </td>
     </tr>
     <tr>
         <th scope="col" id="odd">
                             최초시작일시
         </th>
         <td>
             <input type="text" id="first_exe_time" name="first_exe_time" class="required" title="최초시작일시" value="${batWorkData.batWork.first_exe_time}" readonly/> 
             <img src="/resource/images/admin/img/cal_btn.gif" border="0" onclick="javascript:ShowCarlenderOnImg(document.dForm.first_exe_time, 'ymdh');"/>
         </td>
     </tr>
     <tr>
         <th scope="col" id="odd">
                             주기설정
         </th>
         <td>

                      <sghtml:selectBox id="batch_cycle" 
                                          name="batch_cycle" 
                                          optionList="${batWorkData.batchOptionList}" 
                                          onChange="javascript:jsChangeBatchCycle();" 
                                          selectKey="${batWorkData.batWork.batch_cycle}">&nbsp;</sghtml:selectBox>&nbsp;

             <span id="monthDiv" <c:if test="${batWorkData.batWork.batch_cycle != null && batWorkData.batWork.batch_cycle ne msg:getString('common.batch-info.batch-cycle.month')}">style="display:none;"</c:if>>

             <select id="month" name="month">
                 <c:forEach begin="1" end="12" varStatus="i">
                       <option value="${i.index}" <c:if test="${batWorkData.batWork.month eq i.index}">selected</c:if>>${i.index}</option>
                 </c:forEach>
             </select>
                             개월

             </span>
             <span id="dayDiv" <c:if test="${batWorkData.batWork.batch_cycle ne msg:getString('common.batch-info.batch-cycle.day')}">style="display:none;"</c:if>>

             <select id="day" name="day">
                 <c:forEach begin="1" end="31" varStatus="i">
                       <option value="${i.index}" <c:if test="${batWorkData.batWork.day eq i.index}">selected</c:if>>${i.index}</option>
                 </c:forEach>
             </select>
                             일

             </span>
             <span id="hourDiv" <c:if test="${batWorkData.batWork.batch_cycle ne msg:getString('common.batch-info.batch-cycle.hour')}">style="display:none;"</c:if>>

             <select id="hour" name="hour">
                 <c:forEach begin="0" end="23" varStatus="i">
                       <option value="${i.index}" <c:if test="${batWorkData.batWork.hour eq i.index}">selected</c:if>><c:if test="${i.index < 10}">0</c:if>${i.index}</option>
                 </c:forEach>
             </select>
                             시간

             </span>
             <span id="minuteDiv" <c:if test="${batWorkData.batWork.batch_cycle ne msg:getString('common.batch-info.batch-cycle.minute')}">style="display:none;"</c:if>>

             <select id="minute" name="minute">
                 <c:forEach begin="0" end="59" varStatus="i">
                       <option value="${i.index}" <c:if test="${batWorkData.batWork.minute eq i.index}">selected</c:if>><c:if test="${i.index < 10}">0</c:if>${i.index}</option>
                 </c:forEach>
             </select>
                             분
             </span>
         </td>
     </tr>
</table>
                  
<div class="btn">						
	<div class="leftbtn">
		
	</div>
	<div class="rightbtn">
		<!-- 권한 에 따른 쓰기기능 제어 시작  -->        
        <c:if test="${writeGrant != '0' }">
        <c:choose>
          <c:when test="${actionType eq 'WRITE'}">
              <input type="button" class="button04" value="작업등록" style="margin-right:10px;" onclick="javascript:jsBatWork();"/>
          </c:when>
          <c:otherwise>
              <input type="button" class="button04" value="작업수정" style="margin-right:10px;" onclick="javascript:jsBatWork();"/>
              <input type="button" class="button04" value="작업삭제" style="margin-right:10px;" onclick="javascript:jsDelBatWork();"/>
          </c:otherwise>
        </c:choose>
        <c:if test="${batWorkData.batWork.batch_result eq msg:getString('common.batch-info.batch-result.fail')}">
              <input type="button" class="button04" value="상태변경" style="margin-right:10px;" onclick="javascript:jsChangeBatchResult();"/>
        </c:if>
              <input type="button" class="button02" value="취소" style="margin-right:10px;" onclick="javascript:document.dForm.reset();"/>
            </c:if>
            <!-- 권한 에 따른 쓰기기능 제어 끝  -->

        <input type="button" class="button05" value="작업리스트" style="margin-right:10px;" onclick="javascript:jsBatchList();"/>

	</div>
</div>        
   
</form>

<script language="JavaScript">
    writedate("dForm","fromtime");
</script>

<form name="historyForm" method="post">
    <input type="hidden" id="batch_cd" name="batch_cd"/>
</form>