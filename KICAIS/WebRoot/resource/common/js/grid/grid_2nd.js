/**
	** 확인 및 수정 해야 할 변수/함수
	gridHeigth_2nd 	 					: 그리드 전체 높이
	gridWidth_2nd						: 그리드 전체 폭
	gridTitle_2nd 						: 그리드 제목
	mappingColumns_2nd					: 사용자 매핑 컬럼
	userColumns_2nd						: 칼럼 인덱스
	render_2nd							: 렌더(화면에 그려질) 할 id 
	pageSize_2nd						: 그리드 페이지 사이즈	
	proxyUrl_2nd						: 결과 값 페이지
	start_2nd 							: 페이지처리 시작 ROWNUM          
    imit_2nd  							: 페이지처리 종료 ROWNUM
    
    fnGridOnClick_2nd(store, rowIndex)	: 그리드의 ROW 클릭시 Event
    fnPagingValue_2nd()					: 검색 후 스토어 리로드 후 한글깨짐 현상 방지를 위해 파라메터 설정하는 함수
**/


GridClass_2nd = function() {
	return {
		init : function() { 
			 
			this.store = new Ext.data.Store({
				proxy		: new Ext.data.HttpProxy({
								url: proxyUrl_2nd
							 })
				,reader		: new Ext.data.JsonReader(
								{ 
								  root: "data_2nd" 
								 ,totalProperty: 'total_2nd'
								}
								,this.myRecordObj = Ext.data.Record.create(mappingColumns_2nd)
							 )
				,listeners	: {
				   	beforeload: function(store, options) {						// 데이타가 로드되기전 Event     
						fnPagingValue_2nd();									 
				    }
    			  }
			}); 
			
			this.grid = new Ext.grid.GridPanel({
				 store				: this.store
				,columns			: userColumns_2nd
				,stripeRows			: true
				/*,loadMask			: {
										msg				:"데이타 로드중"
									  }*/
				,clicksToEdit 		: 1
			 	,sm					: new Ext.grid.RowSelectionModel({
										singleSelect	:false
									 })
				,view				: new Ext.grid.GridView({
										forceFit		:true,
										enableRowBody	:true,
										emptyText		: "데이터가 없습니다."
										,scrollOffset    : 0
						 			 })
				,height				: gridHeigth_2nd
				,width				: gridWidth_2nd
				,title				: gridTitle_2nd 
				,listeners			:{
										  rowclick:function(userGrid, rowIndex, e) { 			// 그리드 행을 클릭시
				    							fnGridOnClick_2nd(this.store, rowIndex);
	 									   },rowdblclick :function(userGrid, rowIndex, e) { 		// 그리드 행을 더블클릭시 
	
	 									   }
									 }
				 ,bbar				: new Ext.PagingToolbar({
						                  store		: this.store
						                , pageSize	: pageSize_2nd
						                , displayInfo: true
		             				 })
			});

			this.grid.render(render_2nd);
			this.store.load({
				  params: {
				        	  start : start_2nd          
				        	, limit : limit_2nd
				    		}
			});
		} 
	}
}();
 
Ext.EventManager.onDocumentReady(GridClass_2nd.init, GridClass_2nd, true);

