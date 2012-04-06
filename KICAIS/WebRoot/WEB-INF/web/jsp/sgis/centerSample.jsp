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
<title>centerSample</title>
<style type="text/css"> 
	#wrap {margin:0 auto; auto;}
	#top {height:100%; background:#FF4AFF; margin:0 0 0 0;}
	#left_grid {width:49%; height:100%; background:#0000FF; float:left; margin:0 2% 10px 0;}
	#right_form { width:49%; height:100%; background:#86B100; float:left;}
	#under_grid01 {height:100%; background:#41006C; clear:both;}
	#under_grid02 {height:100%; background:#B1C200; clear:both; margin:10px 0 0 0;}
</style>
<script type="text/javascript">


Ext.onReady(function(){
	Ext.get('searchButton1').on('click', function(){
		showSearchPanel('searchSample.sg');
	});
});

function showSearchPanel(targetUrl){
	searchPanel.toggleCollapse();
	searchPanel.removeAll();
	searchPanel.load({
		url: targetUrl,
		scripts:true
	});
}

function showRegPanel(targetUrl){
	regPanel.toggleCollapse();
	regPanel.removeAll();
	regPanel.load({
		url: targetUrl,
		scripts:true
	});
}
</script>
</head>
<body>
<div id="wrap">
	<div id="top"></div>
	<div id="left_grid">
		<center><input type="button" name="searchButton1" id="searchButton1" value="Right 레이어 보이기(검색)" /></center>
	</div>
	<div id="right_form"></div>
	<div id="under_grid01"></div>
	<div id="under_grid02"></div>
</div>
</body>
</html>