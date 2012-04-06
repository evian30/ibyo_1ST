/**

	** 확인 및 수정 해야 할 변수/함수
	gridHeigth_1st_pop 	 		: 그리드 전체 높이
	gridWidth_1st_pop			: 그리드 전체 폭
	gridTitle_1st_pop 			: 그리드 제목
	
	mappingColumns_1st_pop		: 사용자 매핑 컬럼
	userColumns_1st_pop			: 칼럼 인덱스
	 
	fnPagingValue_1st_pop()		: 검색 후 스토어 리로드 후 한글깨짐 현상 방지를 위해 파라메터 설정하는 함수
	
	render_1st_pop				: 렌더(화면에 그려질) 할 id 
	
	pageSize_1st_pop			: 그리드 페이지 사이즈	
	
	proxyUrl_1st_pop			: 결과 값 페이지
	
	start_1st_pop 				: 페이지처리 시작 ROWNUM          
    imit_1st_pop  				: 페이지처리 종료 ROWNUM
**/
// 그리드의 첫번째 컬럼의 체크박스 설정
var checkSm = new Ext.grid.CheckboxSelectionModel({
	checkOnly : true
	,listeners : {
				   	rowselect: function(SelectionModel,rowIndex, record) {						// 데이타가 로드되기전 Event     
						try{
							fnRowSelectPop1st(SelectionModel,rowIndex, record);
						}catch(e){
							
						}								 
				    }
				   ,rowdeselect : function(SelectionModel,rowIndex, record) {						// 데이타가 로드되기전 Event     
						try{
							fnRowdeSelectPop1st(SelectionModel,rowIndex, record);
						}catch(e){
							
						}								 
				    }
    			  }
})
				        	
GridClass_1st_pop = function() {
	return {
		init : function() { 
			 
			this.store = new Ext.data.Store({
				proxy		: new Ext.data.HttpProxy({
								url: proxyUrl_1st_pop
							 })
				,reader		: new Ext.data.JsonReader(
								{ 
								  root: "data_1st_pop" 
								 ,totalProperty: 'total_1st_pop'
								}
								,this.myRecordObj = Ext.data.Record.create(mappingColumns_1st_pop)
							 )
			    ,listeners	: {
				   	beforeload: function(store, options) {						// 데이타가 로드되기전 Event     
						fnPagingValue_1st_pop();									 
				    }
    			  }
			}); 
			
			this.grid = new Ext.grid.GridPanel({
				 store				: this.store
				,columns			: userColumns_1st_pop
				,stripeRows			: true
				/*,loadMask			: {
										msg				:"데이타 로드중"
									  }*/
				,clicksToEdit 		: 1
			 	,sm					: checkSm
				,view				: new Ext.grid.GridView({
										forceFit		:true,
										enableRowBody	:true,
										emptyText		: "데이터가 없습니다."
										,scrollOffset   : 0
						 			 })
				,height				: gridHeigth_1st_pop
				,width				: gridWidth_1st_pop
				,title				: gridTitle_1st_pop
				,listeners			: {
									   	rowclick:function(userGrid, rowIndex, e) { 				// 그리드 행을 클릭시
								    		fnGridOnClick_1st_pop(this.store, rowIndex);
					 					},rowdblclick :function(userGrid, rowIndex, e) { 			// 그리드 행을 더블클릭시 
									    
					 					},keypress:function(e){

					 					}
					    			  }
				,bbar				: new Ext.PagingToolbar({
						                  store		: this.store
						                , pageSize	: pageSize_1st_pop
						                , displayInfo: true
						                , items :[{
											text 	: "선택",
											scope	: this,
											handler : fnSelectPopUpGridRow1st
										  }]
		             				 })
			});

			this.grid.render(render_1st_pop);
			this.store.load({
				  params: {
				        	  start : start_1st_pop         
				        	, limit : limit_1st_pop
				    		}
			});
			
			;
		} 
	}
}();
 
Ext.EventManager.onDocumentReady(GridClass_1st_pop.init, GridClass_1st_pop, true);

