 // 팝업
function fnOpenPop(sURL, dlgWidth, dlgHeight, winName){
  var xPos=(window.screen.width) ? (window.screen.width-dlgWidth)/2 : 0;
  var yPos=(window.screen.height) ? (window.screen.height-dlgHeight)/2 : 0;
  var sFeatures = "titlebar=no, scrollbars=no,location=no ,menubar=no, resizable=no, status=yes, width="+dlgWidth+",height="+dlgHeight+",left="+xPos+", top="+yPos;
  window.open(sURL,winName, sFeatures);
}


// 프로젝트 **************************************************
function fnPjtPop(param){
	var sURL      = "/pjt/pjtManage/pjtInfoPop.sg"+param;
	var dlgWidth  = 399;
	var dlgHeight = 444;
	var winName   = "project";
	fnOpenPop(sURL, dlgWidth, dlgHeight, winName);
}

function fnPjtPopValue(records, fieldName){
	var record = records[0].data;	
	Ext.get('pjt_id').set({value:fnFixNull(record.PJT_ID)} , false);
    Ext.get('pjt_nm').set({value:fnFixNull(record.PJT_NAME)} , false);
    Ext.get('calendar').focus();
}
	
Ext.calendar.EventEditWindow = function(config) {
    var formPanelCfg = {
        xtype: 'form',
        labelWidth: 80,
        frame: false,
        bodyStyle: 'background:transparent;padding:5px 10px 10px;',
        bodyBorder: false,
        border: false,
        items: [
		        	{
		        		id: 'scd_day_seq',
			            name: Ext.calendar.EventMappings.scd_day_seq.name,
			            xtype: 'textfield',
			            hidden: true,
			            anchor: '100%'
			            	
		        	},
			        {
			           	id: 'title',
			            name: Ext.calendar.EventMappings.Title.name,
			            fieldLabel: '* 내용',
			            xtype: 'textfield',
			            anchor: '100%'
			        },
			        {
			            xtype: 'daterangefield',
			            id: 'date-range',
			            anchor: '100%',
			            fieldLabel: '* 일시'
			        },
			        { 
				        xtype: 'calendarpicker',
				        id: 'calendar',
				        name: 'calendar',
				        anchor: '50%',
				        store: this.calendarStore
		  			 },
					{
						layout: "column",
						fieldLabel: "프로젝트",
						anchor: '100%',
						items: [
								  {	  
									id: 'pjt_id', 
									xtype: "textfield",
									name: Ext.calendar.EventMappings.pjt_id.name,
									width: 190,
									height:24,
									readOnly: true,
									anchor: '100%'
								  },
								  {
									xtype: 'button',
									text: '프로젝트 검색',
									anchor: '100%', 
									listeners :{
													click:function(grid, rowIndex, columnIndex, e) {		
														try{
															fnPjtPop('?fieldName=pjt_id&src_pjt_type_code=10');
														}catch(e){
															//alert("fnEdit1stCellClickEvent() 함수를 선언해주세요");
														}
										    		}
		    					   				}
									
								  },
								  {
									 id: 'pjt_nm',
					        		 xtype: 'textfield', 
					        		 name: Ext.calendar.EventMappings.pjt_nm.name,
						             fieldLabel: '프로젝트',
						             width: 198,
						             height:24,
						             readOnly: true,
						             anchor: '100%'
								  } 
								  
								]
					}  
			        
        ]
    };
    
   
    
    /**사용자 form 지정 영역 시작 **/
    //업무구분
    if (config.calendarStore) {       
    	this.calendarStore = config.calendarStore; 
        delete config.calendarStore;
        formPanelCfg.items.push(
        	{ 
		        xtype: 'calendarpicker',
		        id: 'calendar',
		        name: 'calendar',
		        anchor: '50%',
		        store: this.calendarStore
  			 }
		);
    }
    
    
    //계획/수행 구분
    if (config.procStore) {
        this.procStore = config.procStore;
        delete config.procStore;
        formPanelCfg.items.push(
	        { 	xtype: 'procpicker',
	            id: 'proc_type_code',
	            name: 'proc_type_code',
	            anchor: '50%',
	            store: this.procStore
	        } 	 
		);
    }
    
    //일정상태
    if (config.statusStore) {
        this.statusStore = config.statusStore;
        delete config.statusStore;
        formPanelCfg.items.push(
	        { 	xtype: 'statuspicker',
	            id: 'status_val',
	            name: 'status_nm',
	            anchor: '50%',
	            store: this.statusStore
	        } 	 
		);
    }
    
    //내외근구분
    if (config.workTypeStore) {
        this.workTypeStore = config.workTypeStore;
        delete config.workTypeStore;
        formPanelCfg.items.push(
	        { 	xtype: 'worktypepicker',
	            id: 'work_pattern_code',
	            name: 'work_pattern_nm',
	            anchor: '50%',
	            store: this.workTypeStore
	        } 	 
		);
    }
    
    
     //타스크 그룹
    if (config.taskgroupStore) {
        this.taskgroupStore = config.taskgroupStore;
        delete config.taskgroupStore;
        formPanelCfg.items.push(
	        { 	xtype: 'taskgrouppicker',
	            id: 'task_group_code',
	            name: 'task_group_nm',
	            anchor: '50%',
	            store: this.taskgroupStore
	        } 	 
		);
    }
    
    /**사용자 form 지정 영역 끝 **/
        
 

    
     
    Ext.calendar.EventEditWindow.superclass.constructor.call(this, Ext.apply({
        titleTextAdd: '일정추가',
   		titleTextEdit: '일정수정',
        width: 600,
        autocreate: true,
        border: true,
        closeAction: 'hide',
        modal: false,
        resizable: false,
        buttonAlign: 'left',
        savingMessage: '저장 처리중...',
        deletingMessage: '일정 삭제중...',

        fbar: [{
            xtype: 'tbtext',
            text: ''//'<b><a href="#" id="tblink">▷▷자세히...</a></b>'
        },
        '->', {
            text: '저장',
            disabled: false,
            handler: this.onSave,
            scope: this
        },
        {
            id: 'delete-btn',
            text: '삭제',
            disabled: false,
            handler: this.onDelete,
            scope: this,
            hideMode: 'offsets'
        },
        {
            text: '취소',
            disabled: false,
            handler: this.onCancel,
            scope: this
        }],
        items: formPanelCfg
    },
    config));
};

Ext.extend(Ext.calendar.EventEditWindow, Ext.Window, {
    // private
    newId: 10000,

    // private
    initComponent: function() {
        Ext.calendar.EventEditWindow.superclass.initComponent.call(this);

        this.formPanel = this.items.items[0];

        this.addEvents({
            
            eventadd: true,
             
            eventupdate: true,
            
            eventdelete: true,
            
            eventcancel: true,
             
            editdetails: true
        });
    },

    // private
    afterRender: function() {
        Ext.calendar.EventEditWindow.superclass.afterRender.call(this);

        this.el.addClass('ext-cal-event-win');
		
        /*	 자세히 보기 호출하는 함수
        Ext.get('tblink').on('click',
        function(e) {
            e.stopEvent();
            this.updateRecord();
            this.fireEvent('editdetails', this, this.activeRecord);
        },
        this);
        */
    },

     
    show: function(o, animateTarget) {
        // Work around the CSS day cell height hack needed for initial render in IE8/strict:
        var anim = (Ext.isIE8 && Ext.isStrict) ? null: animateTarget;

        Ext.calendar.EventEditWindow.superclass.show.call(this, anim,
        function() {
            Ext.getCmp('title').focus(false, 100);
        });
        Ext.getCmp('delete-btn')[o.data && o.data[Ext.calendar.EventMappings.EventId.name] ? 'show': 'hide']();

        var rec,
        f = this.formPanel.form;

        if (o.data) {
            rec = o;
            this.isAdd = !!rec.data[Ext.calendar.EventMappings.IsNew.name];
            if (this.isAdd) {
                rec.markDirty();
                this.setTitle(this.titleTextAdd);
            }
            else {
                this.setTitle(this.titleTextEdit);
            }

            f.loadRecord(rec);
        }
        else {
            this.isAdd = true;
            this.setTitle(this.titleTextAdd);

            var M = Ext.calendar.EventMappings,
            eventId = M.EventId.name,
            start = o[M.StartDate.name],
            end = o[M.EndDate.name] || start.add('h', 1);

            rec = new Ext.calendar.EventRecord();
            rec.data[M.EventId.name] = this.newId++;
            rec.data[M.StartDate.name] = start;
            rec.data[M.EndDate.name] = end;
            rec.data[M.IsAllDay.name] = !!o[M.IsAllDay.name] || start.getDate() != end.clone().add(Date.MILLI, 1).getDate();
            rec.data[M.IsNew.name] = true;

            f.reset();
            f.loadRecord(rec);
        }

        if (this.calendarStore) {
            Ext.getCmp('calendar').setValue(rec.data[Ext.calendar.EventMappings.CalendarId.name]);
        }
        Ext.getCmp('date-range').setValue(rec.data);
        this.activeRecord = rec;

        return this;
    },

    // private
    roundTime: function(dt, incr) {
        incr = incr || 15;
        var m = parseInt(dt.getMinutes(), 10);
        return dt.add('mi', incr - (m % incr));
    },

    // private
    onCancel: function() {
        this.cleanup(true);
        this.fireEvent('eventcancel', this);
    },

    // private
    cleanup: function(hide) {
        if (this.activeRecord && this.activeRecord.dirty) {
            this.activeRecord.reject();
        }
        delete this.activeRecord;

        if (hide === true) {
            // Work around the CSS day cell height hack needed for initial render in IE8/strict:
            //var anim = afterDelete || (Ext.isIE8 && Ext.isStrict) ? null : this.animateTarget;
            this.hide();
        }
    },

    // private
    updateRecord: function() {
        var f = this.formPanel.form,
        dates = Ext.getCmp('date-range').getValue(),
        M = Ext.calendar.EventMappings;

        f.updateRecord(this.activeRecord);
        this.activeRecord.set(M.StartDate.name, dates[0]);
        this.activeRecord.set(M.EndDate.name, dates[1]);
        this.activeRecord.set(M.IsAllDay.name, dates[2]);
        this.activeRecord.set(M.CalendarId.name, this.formPanel.form.findField('calendar').getValue());
    },

    // private
    onSave: function() {
    	/*밸리데이션 체크 후 DB에 집어 넣자*/
    	
        if (!this.formPanel.form.isValid()) {
            return;
        }
        this.updateRecord();

        if (!this.activeRecord.dirty) {
            this.onCancel();
            return;
        }
        
        
        
        if(Ext.getCmp('title').getValue() == ""){
        	 SGAlert("내용", "내용을 입력 해 주세요");
        	 Ext.getCmp('title').focus(false, 100);
        	 return false;
        }
        
        
        if(Ext.getCmp('calendar').getValue() == ""){
        	 SGAlert("업무구분", "업무구분을 선택 해 주세요");
        	 Ext.getCmp('calendar').focus(false, 100);
        	 return false;
        }
        
        /*
        if(Ext.getCmp('proc_type_code').getValue() == ""){
        	 SGAlert("계획/수행", "계획/수행 구분을 선택 해 주세요");
        	 Ext.getCmp('proc_type_code').focus(false, 100);
        	 return false;
        }
        
        if(Ext.getCmp('status_val').getValue() == ""){
        	 SGAlert("일정상태", "일정상태 구분을 선택 해 주세요");
        	 Ext.getCmp('status_val').focus(false, 100);
        	 return false;
        }
        
        if(Ext.getCmp('work_pattern_code').getValue() == ""){
        	 SGAlert("내근/외근", "내근/외근 구분을 선택 해 주세요");
        	 Ext.getCmp('work_pattern_code').focus(false, 100);
        	 return false;
        }
        */  
        
        var scd_date = Ext.getCmp('date-range').getValue(); 
              
        var sTime;
        if(scd_date[0].toString().replaceAll(' ', '').length == 28){
			sTime=scd_date[0].toString().replaceAll(' ', '').substring(8,16);
		}else if(scd_date[0].toString().replaceAll(' ', '').length ==27){
			sTime=scd_date[0].toString().replaceAll(' ', '').substring(7,15);
		}
      
         
         var eTime;
        if(scd_date[1].toString().replaceAll(' ', '').length == 28){
			eTime=scd_date[1].toString().replaceAll(' ', '').substring(8,16);
		}else if(scd_date[1].toString().replaceAll(' ', '').length ==27){ 
			eTime=scd_date[1].toString().replaceAll(' ', '').substring(7,15);			 
		}
         
        
        var scd_key_code;
        if(Ext.getCmp('calendar').getValue() > 9    ){
        	scd_key_code = Ext.getCmp('calendar').getValue();    
        }else{
        	scd_key_code = "0"+Ext.getCmp('calendar').getValue();
        }
        
        this.fireEvent(this.isAdd ? 'eventadd': 'eventupdate', this, this.activeRecord);
        
        Ext.Ajax.request({   
			url: "/com/calendar/actionSchedule.sg"   
			,method : 'POST'   
			,params : { 
					   	 scd_day_seq			:Ext.get('scd_day_seq').getValue()			    
						,scd_type_code          :scd_key_code       
						,proc_type_code         :Ext.getCmp('proc_type_code').getValue()          
						   
						,status_val             :Ext.getCmp('status_val').getValue()               
						,work_pattern_code      :Ext.getCmp('work_pattern_code').getValue()      
						
						,scd_sdate            	:scd_date[0]            
						,scd_time_from        	:sTime
							
							
						,scd_edate            	:scd_date[1]            
						,scd_time_to          	:eTime
							
						//,scd_time             :Ext.get('scd_time').getValue()
						//,labor_cost           :Ext.get('labor_cost').getValue()
						
						,pjt_id                 :Ext.get('pjt_id').getValue()
						,pjt_nm                 :Ext.get('pjt_nm').getValue()
						,task_group_code        :Ext.getCmp('task_group_code').getValue()
						
						//,task_code            :Ext.get('task_code').getValue()
						//,pay_no               :Ext.get('pay_no').getValue()
						//,visit_report_no      :Ext.get('visit_report_no').getValue()
						
						,scd_proc_res_content   :Ext.get('title').getValue()
						
						//,note                 :Ext.get('note').getValue()
						//,pjt_status           :Ext.get('pjt_status').getValue()
				      }                         
		});
	
        
        
       	//Ext.MessageBox.confirm('Confirm', '입력하신 내용의 일정을 저장 하시겠습니까?',showResult('yes')); 
         
    },

    // private
    onDelete: function() {
    	if(confirm("해당 일정 내용을 삭제하시겠습니까?")){
        	this.fireEvent('eventdelete', this, this.activeRecord);
        	
        	Ext.Ajax.request({   
			url: "/com/calendar/deleteSchedule.sg"   
			,method : 'POST'   
			,params : { 
					   	 scd_day_seq			:Ext.get('scd_day_seq').getValue()			    
						,flag					:"del"	
				      }                         
		});
        	
        }
    }
});
