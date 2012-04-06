/**
	** 확인 및 수정 해야 할 변수/함수
	gridHeigth_1st 	 					: 그리드 전체 높이
	gridWidth_1st						: 그리드 전체 폭
	gridTitle_1st 						: 그리드 제목
	mappingColumns_1st					: 사용자 매핑 컬럼
	userColumns_1st						: 칼럼 인덱스
	render_1st							: 렌더(화면에 그려질) 할 id 
	pageSize_1st						: 그리드 페이지 사이즈	
	proxyUrl_1st						: 결과 값 페이지
	start_1st 							: 페이지처리 시작 ROWNUM          
    imit_1st  							: 페이지처리 종료 ROWNUM
   
    fnGridOnClick_1st(store, rowIndex)	: 그리드의 ROW 클릭시 Event
    fnPagingValue_1st()					: 검색 후 스토어 리로드 후 한글깨짐 현상 방지를 위해 파라메터 설정하는 함수
**/

				        	
GridClass_1st = function() {
	return {
		init : function() { 
			 
			this.store = new Ext.data.Store({
				proxy		: new Ext.data.HttpProxy({
								url: proxyUrl_1st
							 })
				,reader		: new Ext.data.JsonReader(
								{ 
								  root: "data_1st" 
								 ,totalProperty: 'total_1st'
								}
								,this.myRecordObj = Ext.data.Record.create(mappingColumns_1st)
							 )
			    ,listeners	: {
				   	beforeload: function(store, options) {						// 데이타가 로드되기전 Event     
						fnPagingValue_1st();									 
				    }
    			  }
			}); 
			
			this.grid = new Ext.grid.GridPanel({
				 store				: this.store
				,columns			: userColumns_1st
				,stripeRows			: true
				/*,loadMask			: {
										msg				:"데이타 로드중"
									  }*/
				,clicksToEdit 		: 1
			 	,sm					: new Ext.grid.RowSelectionModel({
										singleSelect	:false
										,listeners		: {
										             		rowselect:function(model, rowIndex, record) { 				// 그리드 행을 클릭시
			 													fnGridOnClick_1st(GridClass_1st.store, rowIndex);
									 						}
					    			 					 }
									 })
				,view				: new Ext.grid.GridView({
										forceFit		:true,
										enableRowBody	:true,
										emptyText		: "데이터가 없습니다."
										,scrollOffset   : 0
						 			 })
				,height				: gridHeigth_1st
				,width				: gridWidth_1st
				,title				: gridTitle_1st
				,listeners			: {
									   	rowclick:function(userGrid, rowIndex, e) { 				// 그리드 행을 클릭시
								    		fnGridOnClick_1st(this.store, rowIndex);
					 					},rowdblclick :function(userGrid, rowIndex, e) { 			// 그리드 행을 더블클릭시 
									    
					 					},keypress:function(e){

					 					}
					    			  }
				,bbar				: new Ext.PagingToolbar({
						                  store		: this.store
						                , pageSize	: pageSize_1st
						                , displayInfo: true
		             				 })
			});

			this.grid.render(render_1st);
			this.store.load({
				  params: {
				        	  start : start_1st         
				        	, limit : limit_1st
				    		}
			});
			
			;
		} 
	}
}();
 
Ext.EventManager.onDocumentReady(GridClass_1st.init, GridClass_1st, true);

