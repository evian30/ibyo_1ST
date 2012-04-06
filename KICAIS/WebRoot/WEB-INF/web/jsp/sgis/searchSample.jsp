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
<title>searchSample</title>
<style type="text/css"> 
	#wrap {margin:0 auto; auto;}
	#top {height:100px; background:#ffffff; margin:0 0 20px 0;}
	#left_grid {width:49%; height:450px; background:#ffffff; float:left; margin:0 2% 10px 0;}
	#right_form { width:49%; height:450px; background:#ffffff; float:left;}
	#under_grid01 {height:100px; background:#ffffff; clear:both;}
	#under_grid02 {height:100px; background:#ffffff; clear:both; margin:10px 0 0 0;}
</style>
<script type="text/javascript">

Ext.onReady(function(){
	Ext.get('searchComplete').on('click', function(){
		searchPanel.toggleCollapse();
		//$("#searchButton1").val('검색완료');
		var result = Ext.get('searchButton1');
		result.set({
			value : '검색완료'
		});
		
		alert('검색 결과','검색이 완료되었습니다.');
	});
	
	Ext.get('regButton').on('click', function(){
		regPanel.toggleCollapse();
		searchPanel.toggleCollapse();
		regPanel.removeAll();
		showRegPanel('regSample.sg');
		regPanel.toggleCollapse();
	});
});

</script>
</head>
<body>
	<div id="left_grid">
		<input type="button" name="searchComplete" id="searchComplete" value="검색 완료" /> <br/>
		 <br/>
		 <br/>
		 <br/>
		 <br/>  
		<input type="button" name="regButton" id="regButton" value="등록 레이버 보이기(등록)" /> <br/>
	</div>
</body>
</html>