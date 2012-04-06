<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/web/jsp/common/inc/commonInc.jsp" %>

<script type="text/javascript">
    if(eval('${result}'))
        alert('${msg:getString("common.msg.save-success")}');
    else
        alert('${msg:getString("common.msg.save-fail")}');

    <c:choose>
        <c:when test="${returnUrl == null || returnUrl eq ''}">
            <c:if test="${executeScript != null && executeScript ne ''}">
    ${executeScript}
            </c:if>
    self.close();
        </c:when>
        <c:otherwise>
    location.href="${returnUrl}";
        </c:otherwise>
    </c:choose>
</script>