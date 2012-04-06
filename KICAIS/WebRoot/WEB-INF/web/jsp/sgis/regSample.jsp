<%--
  Class Name  : 
  Description : 
  Modification Information
 
      수정일                   수정자                 수정내용
  -------      --------    ---------------------------
  2011. 1. 19. dolove9          최초 생성
 
  author   : dolove9
  since    : 2011. 1. 19.
  version  : 1.0
   
  Copyright (C) 2011 by SG All right reserved.
--%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/web/jsp/common/inc/commonInc.jsp" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>regSample</title>
<script type="text/javascript">

Ext.onReady(function(){
	Ext.get('regButton2').on('click', function(){
		alert('등록 결과');
		
		var result = Ext.get('searchButton1');
		result.set({
			value : '등록완료'
		});
		result.highlight();
		regPanel.toggleCollapse();
		regPanel.removeAll();
	});
});
</script>
</head>
<body>
	<div id="tab2">
		<center><input type="button" name="regButton2" id="regButton2" value="등록완료" /></center>
		<input type="hidden" name="regInput1" id="regInput1" /> <br/>
		<input type="hidden" name="regInput2" id="regInput2" /> <br/>
		<input type="hidden" name="regInput3" id="regInput3" /> <br/>
		<input type="hidden" name="regInput4" id="regInput4" /> <br/>
		<input type="hidden" name="regInput5" id="regInput5" /> <br/>
		<input type="hidden" name="regInput6" id="regInput6" /> <br/>
		<input type="hidden" name="regInput7" id="regInput7" /> <br/>
		<input type="hidden" name="regInput8" id="regInput8" /> <br/>
		<input type="hidden" name="regInput9" id="regInput9" /> <br/>
		<input type="hidden" name="regInput10" id="regInput10" /> <br/>
		<input type="hidden" name="regInput11" id="regInput11" /> <br/>
	</div>
</body>
</html>