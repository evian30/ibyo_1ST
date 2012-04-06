<%--
  Class Name  : itempSearchPop.jsp
  Description : 아이템 검색 팝업
  Modification Information
 
      수정일                수정자                 수정내용
  -------      --------    ---------------------------
  2011. 4. 11.  이재철              최초 생성
 
  author   : 이재철
  since    : 2011. 4. 11.
  version  : 1.0
   
  Copyright (C) 2011 by SG All right reserved.
--%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/web/jsp/sgis-top-inc.jsp" %>
<%
	String openerGridName = request.getParameter("grid_name");	// 부모창의 그리드 이름
	String openerGridRow = request.getParameter("grid_row");	// 그리드의 row index;
%>
<script type="text/javascript">
/***************************************************************************
 * 설  명 : 화면 초기설정
 ***************************************************************************/
// ExtJS 진입함수
Ext.onReady(function() {
	
	// 검색결과확인  클릭
	Ext.get('searchResult').on('click', function(e){
        fnGridOnClick_2nd();	
    });
	
});

/***************************************************************************
 * 그리드 클릭시 Event
 ***************************************************************************/
function fnGridOnClick_2nd(){
	var itemCode = 'tempItem1';
	var itemName = '가상아이템1';
	
	//그리드에서 팝업을 호출한 것임
	var openerGridName = '<%= openerGridName %>';
	if(openerGridName != 'undefined'){
		var openerStore = opener.<%= openerGridName %>.store;
		var openerRecored = openerStore.getAt(<%=openerGridRow%>);
		openerRecored.set('ITEM_CODE', itemCode);
		openerRecored.set('ITEM_NAME', itemName);
	}


	window.close();
	
}
</script>
<body>
	<form name='itemSearchPop' id='itemSearchPop'>
		<input type='button' id='searchResult' value='검색결과확인'/>
	</form>
</body>