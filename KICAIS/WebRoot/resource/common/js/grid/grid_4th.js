/**
	** 확인 및 수정 해야 할 변수/함수
	gridHeigth_4th 	 					: 그리드 전체 높이
	gridWidth_4th						: 그리드 전체 폭
	gridTitle_4th 						: 그리드 제목
	mappingColumns_4th					: 사용자 매핑 컬럼
	userColumns_4th						: 칼럼 인덱스
	render_4th							: 렌더(화면에 그려질) 할 id 
	pageSize_4th						: 그리드 페이지 사이즈	
	proxyUrl_4th						: 결과 값 페이지
	start_4th 							: 페이지처리 시작 ROWNUM          
    imit_4th  							: 페이지처리 종료 ROWNUM
    
    fnGridOnClick_4th(store, rowIndex)	: 그리드의 ROW 클릭시 Event
    fnPagingValue_4th()					: 검색 후 스토어 리로드 후 한글깨짐 현상 방지를 위해 파라메터 설정하는 함수
**/

GridClass_4th = function() {
	return {
		init : function() { 
			 
			this.store = new Ext.data.Store({
				proxy		: new Ext.data.HttpProxy({
								url: proxyUrl_4th
							 })
				,reader		: new Ext.data.JsonReader(
								{ 
								  root: "data_4th" 
								 ,totalProperty: 'total_4th'
								}
								,this.myRecordObj = Ext.data.Record.create(mappingColumns_4th)
							 )
				,listeners	: {
				   	beforeload: function(store, options) {						// 데이타가 로드되기전 Event     
						fnPagingValue_4th();									 
				    }
    			  }
			}); 
			
			this.grid = new Ext.grid.GridPanel({
				 store				: this.store
				,columns			: userColumns_4th
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
									    ,scrollOffset   : 0
						 			 })
				,height				: gridHeigth_4th
				,width				: gridWidth_4th
				,title				: gridTitle_4th 
				,listeners			:{
										  rowclick:function(userGrid, rowIndex, e) { 			// 그리드 행을 클릭시
				    							fnGridOnClick_4th(this.store, rowIndex);
	 									   },rowdblclick :function(userGrid, rowIndex, e) { 		// 그리드 행을 더블클릭시 
	
	 									   }
									 }
				 ,bbar				: new Ext.PagingToolbar({
						                  store		: this.store
						                , pageSize	: pageSize_4th
						                , displayInfo: true
		             				 })
			});

			this.grid.render(render_4th);
			this.store.load({
				  params: {
				        	  start : start_4th          
				        	, limit : limit_4th
				    		}
			});
		} 
	}
}();
 
Ext.EventManager.onDocumentReady(GridClass_4th.init, GridClass_4th, true);

