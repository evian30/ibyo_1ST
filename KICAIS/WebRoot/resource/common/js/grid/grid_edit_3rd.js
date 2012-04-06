﻿/**

	** 확인 및 수정 해야 할 변수/함수
	gridHeigth_edit_3rd : 그리드 전체 높이
	gridWidth_edit_3rd	: 그리드 전체 폭
	gridTitle_edit_3rd 	: 그리드 제목
	
	mappingColumns_edit_3rd	: 사용자 매핑 컬럼
	userColumns_edit_3rd	: 칼럼 인덱스
	 
	fnPagingValue_edit_3rd(): 검색 후 스토어 리로드 후 한글깨짐 현상 방지를 위해 파라메터 설정하는 함수
	
	render_edit_3rd			: 렌더(화면에 그려질) 할 id
	
	pageSize_edit_3rd		: 그리드 페이지 사이즈
	
	proxyUrl_edit_3rd		: 결과 값 페이지
	
	addNew_edit_3rd()		: 행 추가시 참조 키 값 자동으로 Edit Grid에 넘겨주는 함수
	
	goAction_edit_3rd()		: 변경된 레코드가 있는 모든 ROW를 데이터 통신 하는 함수
	
	grid3rdRowDeleteYn		: 그리드의 자료를 실제로 DB에서 삭제할경우 'Y'로 설정
	
	fnGridDeleteRow3rd(record) : 행을 삭제시 DB로 행의 값을 전달하는 함수
	
	tbarHidden_edit_3rd     : 편집그리드의 Tbar를 숨길경우 'Y'로 선언
	
	fnGridOnClick_edit_3rd(model, rowIndex, record) : 그리드의 행이 선택되었을대 Event
**/
// 그리드의 첫번째 컬럼의 체크박스 설정
var checkSm = new Ext.grid.CheckboxSelectionModel({
	checkOnly : true
})

GridClass_edit_3rd = function() {
	return {
		init : function() {
		 
			this.store = new Ext.data.Store({
				proxy		: new Ext.data.HttpProxy({
								url: proxyUrl_edit_3rd
							 })
				,reader		: new Ext.data.JsonReader(
								{ 
								  root: "data_edit_3rd" 
								 ,totalProperty: 'total_edit_3rd'
								}
								,this.myRecordObj = Ext.data.Record.create(mappingColumns_edit_3rd)
							 )
				,listeners	: {
								// 데이타가 로드되기전 Event
							   	beforeload: function(store, options) {					     
									fnPagingValue_edit_3rd();				
							    }
			    			  }
			});
			
			
			/************************ 그리드의 Tbar를 설정 **************************/
			var tbar_edit_3rd= [{
					/*
					text 	: "저장",
					scope	: this,
					handler : this.saveAllChanges
				}, "-", {
					*/
					text 	: "추가",
					scope	: this,
					handler : this.addRecord
				}, "-", {
					text 	: "삭제",
					scope	: this,
					handler : this.deleteRecord
				 
				}, "-", {
					text 	: "새로고침",
					scope	:this,
					handler : function(){ this.store.reload()}
				}]
				;
			
			// 그리드의 Tbar hidden수가 있다면 Tbar정보를 ''로 설정한다.	
			try{
				if(tbarHidden_edit_3rd == 'Y'){
					tbar_edit_3rd = "";
				}
			}catch(e){
			
			}
			/************************ 그리드의 Tbar를 설정 **************************/
			
			this.grid = new Ext.grid.EditorGridPanel({
				 store				: this.store
				,columns			: userColumns_edit_3rd
				,autoExpandColumn	: keyNm_edit_3rd   
				,stripeRows			: true
				/*,loadMask			: {
										msg				:"데이타 로드중"
									  }*/
				,clicksToEdit 		: 1
				,sm					:  new Ext.grid.RowSelectionModel({
										singleSelect	:true
										,listeners		: {
										             		rowselect:function(model, rowIndex, record) { 				// 그리드 행을 클릭시
																try{
																	fnGridOnClick_edit_3rd(model, rowIndex, record);	
																}catch(e){
																	
																}
									 						}
					    			 					 }
									 })
				,view				: new Ext.grid.GridView({
										forceFit		:true,
										enableRowBody	:true,
										emptyText		: "데이터가 없습니다."
										,scrollOffset   : 0	
						 			 })
				,height				: gridHeigth_edit_3rd
				,width				: gridWidth_edit_3rd
				,title				: gridTitle_edit_3rd				
				,bbar				: new Ext.PagingToolbar({
						                  store		: this.store
						                , pageSize	: pageSize_edit_3rd
						                , displayInfo: true
		             				 })
			//	,preEditValue : function(r, field){
        	//		return htmlToUnicode(r.get('field'));
			 //   }
			 //   ,postEditValue : function(value, originalValue, r, field){
			 //   	alert('변경');
			 //       return unicodeToHtml(value);
			 //   }
			    ,listeners			:{
										cellclick:function(grid, rowIndex, columnIndex, e) {		
											try{
												fnEdit3rdCellClickEvent(grid, rowIndex, columnIndex, e);
											}catch(e){
												//alert("fnEdit1stCellClickEvent() 함수를 선언해주세요");
											}
							    		}
										,afteredit:function(obj) {		
											
											try{
												fnEdit3rdAfterCellEdit(obj);
											}catch(e){
												// alert("fnEdit1stAfterCellEdit() 함수를 선언해주세요");
											}
							    		}
									 }
				,tbar 				: tbar_edit_3rd
			});

			this.grid.render(render_edit_3rd);
			this.store.load({
				  params: {
				        	  start : start_edit_3rd          
				        	, limit : limit_edit_3rd
				    		}
			});
			
			//칼럼 수정 때 마다 일어 날 이벤트 처리
			//this.grid.on("afteredit", this.afterCellEditEventHandler, this);

		},
		
		//CEll변경 후 일어나는 이벤트
		afterCellEditEventHandler: function(editEvent){
			
			var r = Ext.isNumber(index) ? this.grid.store.getAt(index) : index;
        	return (r && this.selections.key(r.id) ? true : false);
        
			var gridField = editEvent.field;
			var gridValue = editEvent.value; 
			//editEvent.record.set(keyNm_edit_3rd, editEvent.record.get(keyNm_edit_3rd + "변경필트:"+gridField +"변경된값"+gridValue );
			this.updateCell(editEvent);
		},
		
		// 수정된 Cell만 저장하기
		updateCell : function (editEvent){
			var isNewRecord = editEvent.record.data.newRecord;   		//업데이트할때 사용될 트리거("yes"면 새로운 레코드)
			/**** AJAX 통신 모듈 들어가는곳 ******/  
			// DB를 성공적으로 업데이트 후 처리할 루틴
			
			if (isNewRecord == "yes") {
				editEvent.record.set("newRecord", "no");				//저장한후 새로운 레코드가 아님을 표시
				this.store.commitChanges();								//isDirty Flag 없애기
			} else {
				this.store.commitChanges();
			}
			this.store.rejectChanges();									//잘못됐을경우는 this.sotre.rejectChanges(); 로 리복한다.
		},

		//삭제
		deleteRecord : function(btn){ 
			
			var s = this.grid.getSelectionModel().getSelections();
		  	//var selectedKeys = this.grid.selModel.selections.keys;
			var selectedRecord = this.grid.selModel.getSelected(); 
			
			if( undefined == selectedRecord){
				Ext.Msg.alert('확인', '삭제할 데이터를 선택 해 주세요'); 
			}else if(s != "" && selectedRecord.get(keyNm_edit_3rd) == null){
				// 행의 삭제 여부를 묻기전에 삭제 취소 또는 값확인
				try{
					if(!fnEdit3rdRowValueSelectCheckDelete()){
						return false;						
					}
				}catch(err){}
				
                Ext.MessageBox.confirm('확인', '삭제 하시겠습니까?', fnEdit3rdRowDelete);  
			}else if(selectedRecord.get(keyNm_edit_3rd) != null){
				if(grid3rdRowDeleteYn == "Y"){
			 		Ext.MessageBox.confirm('확인', '삭제 하시겠습니까?', fnEdit3rdRowDeleteBb);  
				}else{
					Ext.Msg.alert('확인', '저장된 데이터는 삭제 불가능 합니다. 사용여부(Y/N)를 수정 해주세요');
				}
			}
		},
		
		//추가
		addRecord: function(btn){ 
			addNew_edit_3rd();
		},
		
		//변경된 것 모두 저장하기
		saveAllChanges: function(editEvent){ 
			try{
				goAction_edit_3rd();
			}catch(e){
				
			}
		}
	}
}();

// 행삭제 : 새로 추가된 행을 삭제
function fnEdit3rdRowDelete(btn){

	try{
		// 행 삭제전 로직반영을 위한 함수
		fnEdit3rdBeforeRowDeleteEvent();
	}catch(err){}
	
	if(btn == 'yes'){
		var s = GridClass_edit_3rd.grid.getSelectionModel().getSelections();
		
		for(var i = 0, r; r = s[i]; i++){
            GridClass_edit_3rd.store.remove(r);
        }
    }
	
	try{
		// 행이 삭제된후 전체행의 값들을 자동으로 계산하기 위한 함수
		fnEdit3rdAfterRowDeleteEvent();
	}catch(err){
		
	}
};

// 행삭제 : 조회된 자료를 삭제
function fnEdit3rdRowDeleteBb(btn){
	
	if(btn == 'yes'){
		var selectedRecord = GridClass_edit_3rd.grid.selModel.getSelected(); 
		fnGridDeleteRow3rd(selectedRecord);
    }
};

function htmlToUnicode(s)
{
    if (typeof s === 'string' ) {
            rex = new RegExp('&#([0-9]+);' , "g");
            s = s.replace(rex, function (s, p1 ){ return String.fromCharCode( p1 ); } );
            rex2 = new RegExp('&#x([a-f0-9]+);' , "gi");
            s = s.replace( rex2, function (s, p1 ){ return String.fromCharCode( parseInt(p1,16)  ); } );
       alert('a1 : '+s); 
       return s;
    }else if( s === undefined || s === null){
    	alert('b1');
    	return '';
    }else{
    	alert('c1');
        return s;
    }
}


function unicodeToHtml(s)
{
	if (typeof s === 'string'){
    
		encodedText = '';
        for(i=0;i<s.length;i++)
        (charCode = s.charCodeAt(i))>127 ? encodedText += '&#'+charCode+';' : encodedText += s.charAt(i);
    alert('a : ' + encodedText);
        return encodedText;
    }else if( s === undefined || s === null){
    	alert('B');
        return '';
    }else{
    	alert('c');
        return s;
    }
}


Ext.EventManager.onDocumentReady(GridClass_edit_3rd.init, GridClass_edit_3rd, true);
