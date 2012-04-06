<%--
  Class Name  : deptDetail.jsp
  Description : 부서정보상세
  Modification Information
 
      수정일                   수정자                 수정내용
  -------      --------    ---------------------------
  2011. 1. 31. 고기범                 최초 생성
 
  author   : 고기범
  since    : 2011. 1. 31.
  version  : 1.0
   
  Copyright (C) 2011 by SG All right reserved.
--%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/web/jsp/common/inc/commonInc.jsp" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>부서정보상세</title>
<link rel="stylesheet" type="text/css" href="/resource/common/js/ext3/resources/css/ext-all.css" />
<link rel="stylesheet" type="text/css" href="/resource/common/css/sample/RowEditor.css" />
<link rel="stylesheet" type="text/css" href="/resource/common/css/sample/restful.css" />
<script type="text/javascript">
// ComboBox 에 값을 DB로 부터 조회해와서 selectBox에 Setting
var comboData1 = [
				  <c:forEach items="${COM_CODE}" var="data" varStatus="status">
				  	'${data.COM_CODE}'
					<c:if test="${not status.last}">,</c:if>	
				  </c:forEach>
				 ] ;
var searchBtnHidden = true;		// 검색버튼 hidden 처리여부
var resetBtnHidden = true;			// 조건해제버튼 hidden 처리여부				 
</script>
<script type="text/javascript" src="/resource/common/js/ext3/adapter/ext/ext-base.js"></script>
<script type="text/javascript" src="/resource/common/js/ext3/ext-all-debug.js"></script>
<script type="text/javascript" src="/resource/common/js/ext3/src/locale/ext-lang-ko.js" charset="utf-8"></script>
<script type="text/javascript" src="/resource/common/js/common/App.js"></script>
<!-- form, grid 를 설정 _ 순서를 변경하면 에러가 남 
스크립트 파일은 읽어 오는 순서대로 dependency가 적용 -->
<script type="text/javascript" src="/resource/common/js/com/restful.js"></script>
<!--<script type="text/javascript" src="/resource/common/js/com/RowEditor.js"></script>-->
<script type="text/javascript" src="/resource/common/js/com/UserForm.js"></script>

</head>
<body>
	<div class="container" style="width:500px">
		<div id="user-form"></div>
<!--		<br/>-->
<!--	    <div id="user-grid"></div>-->
	</div>

</body>
</html>
