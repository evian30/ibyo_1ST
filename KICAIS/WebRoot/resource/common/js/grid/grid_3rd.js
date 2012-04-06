/**
	** 확인 및 수정 해야 할 변수/함수
	gridHeigth_3rd 	 					: 그리드 전체 높이
	gridWidth_3rd						: 그리드 전체 폭
	gridTitle_3rd 						: 그리드 제목
	mappingColumns_3rd					: 사용자 매핑 컬럼
	userColumns_3rd						: 칼럼 인덱스
	render_3rd							: 렌더(화면에 그려질) 할 id 
	pageSize_3rd						: 그리드 페이지 사이즈	
	proxyUrl_3rd						: 결과 값 페이지
	start_3rd 							: 페이지처리 시작 ROWNUM          
    imit_3rd  							: 페이지처리 종료 ROWNUM
    
    fnGridOnClick_3rd(store, rowIndex)	: 그리드의 ROW 클릭시 Event
    fnPagingValue_3rd()					: 검색 후 스토어 리로드 후 한글깨짐 현상 방지를 위해 파라메터 설정하는 함수
**/


GridClass_3rd = function() {
	return {
		init : function() { 
			 
			this.store = new Ext.data.Store({
				proxy		: new Ext.data.HttpProxy({
								url: proxyUrl_3rd
							 })
				,reader		: new Ext.data.JsonReader(
								{ 
								  root: "data_3rd" 
								 ,totalProperty: 'total_3rd'
								}
								,this.myRecordObj = Ext.data.Record.create(mappingColumns_3rd)
							 )
				,listeners	: {
				   	beforeload: function(store, options) {						// 데이타가 로드되기전 Event     
						fnPagingValue_3rd();									 
				    }
    			  }
			}); 
			
			this.grid = new Ext.grid.GridPanel({
				 store				: this.store
				,columns			: userColumns_3rd
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
				,height				: gridHeigth_3rd
				,width				: gridWidth_3rd
				,title				: gridTitle_3rd 
				,listeners			:{
										  rowclick:function(userGrid, rowIndex, e) { 			// 그리드 행을 클릭시
				    							fnGridOnClick_3rd(this.store, rowIndex);
	 									   },rowdblclick :function(userGrid, rowIndex, e) { 		// 그리드 행을 더블클릭시 
	
	 									   }
									 }
				 ,bbar				: new Ext.PagingToolbar({
						                  store		: this.store
						                , pageSize	: pageSize_3rd
						                , displayInfo: true
		             				 })
			});

			this.grid.render(render_3rd);
			this.store.load({
				  params: {
				        	  start : start_3rd          
				        	, limit : limit_3rd
				    		}
			});
		} 
	}
}();
 
Ext.EventManager.onDocumentReady(GridClass_3rd.init, GridClass_3rd, true);

