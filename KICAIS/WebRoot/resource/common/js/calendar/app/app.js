 

App = function() {
    return {
        init : function() {
            
            Ext.BLANK_IMAGE_URL = '/resource/common/js/calendar/resources/images/default/s.gif';

            /**사용자 form 지정 영역 시작 **/
            //업무 구분 콤보박스  	(칼라 인덱싱 있음)
            this.calendarStore = new Ext.data.JsonStore({
                storeId: 'calendarStore',
                root: 'calendars',
                idProperty: 'id',
                data: calendarList, 
                proxy: new Ext.data.MemoryProxy(),
                autoLoad: true,
                fields: calendarListMapping,
                sortInfo: {
                    field: 'EventId',
                    direction: 'ASC'
                }
            });
            
            //계획/수행 구분 콤보박스
             this.procStore = new Ext.data.JsonStore({
                storeId: 'procStore',
                root: 'proc',
                idProperty: 'proc_type_code',
                data: calendarList, 
                proxy: new Ext.data.MemoryProxy(),
                autoLoad: true,
                fields: calendarListMapping
            });
             
            //일정상태 콤보박스
             this.statusStore = new Ext.data.JsonStore({
                storeId: 'statusStore',
                root: 'status',
                idProperty: 'status_val',
                data: calendarList, 
                proxy: new Ext.data.MemoryProxy(),
                autoLoad: true,
                fields: calendarListMapping
            });
             
             //내근,외근  콤보박스
             this.workTypeStore = new Ext.data.JsonStore({
                storeId: 'workTypeStore',
                root: 'workType',
                idProperty: 'work_pattern_code',
                data: calendarList, 
                proxy: new Ext.data.MemoryProxy(),
                autoLoad: true,
                fields: calendarListMapping
            });
             
             //타스크 그룹 콤보박스
             this.taskgroupStore = new Ext.data.JsonStore({
                storeId: 'taskgroupStore',
                root: 'taskGroup',
                idProperty: 'task_group_code',
                data: calendarList, 
                proxy: new Ext.data.MemoryProxy(),
                autoLoad: true,
                fields: calendarListMapping
            }); 
             
             
            /**사용자 form 지정 영역  끝**/ 
             
             

            // A sample event store that loads static JSON from a local file. Obviously a real
            // implementation would likely be loading remote data via an HttpProxy, but the
            // underlying store functionality is the same.  Note that if you would like to 
            // provide custom data mappings for events, see EventRecord.js.
		    this.eventStore = new Ext.data.JsonStore({
		        id: 'eventStore',
		        root: 'evts',
		        data: eventList, // defined in event-list.js
				proxy: new Ext.data.MemoryProxy(),
		        fields: Ext.calendar.EventRecord.prototype.fields.getRange(),
		        sortInfo: {
		            field: 'CalendarId',
		            direction: 'DESC'
		        }
		    });
            
            // This is the app UI layout code.  All of the calendar views are subcomponents of
            // CalendarPanel, but the app title bar and sidebar/navigation calendar are separate
            // pieces that are composed in app-specific layout code since they could be ommitted
            // or placed elsewhere within the application.
            new Ext.Viewport({
                layout: 'border',
                renderTo: 'calendar-ct',
                items: [{
                    id: 'app-header',
                    region: 'north',
                    height: 35,
                    border: false,
                    contentEl: 'app-header-content'
                },{
                    id: 'app-center',
                    title: '...', // will be updated to view date range
                    region: 'center',
                    layout: 'border',
                    items: [{
                        id:'app-west',
                        region: 'west',
                        width: 176,
                        border: false,
                        items: [{
                            xtype: 'datepicker',
                            id: 'app-nav-picker',
                            cls: 'ext-cal-nav-picker',
                            listeners: {
                                'select': {
                                    fn: function(dp, dt){
                                        App.calendarPanel.setStartDate(dt);
                                    },
                                    scope: this
                                }
                            }
                        }]
                    },{
                        xtype: 'calendarpanel',
                        
                        
                        
                        /**사용자 form 지정 영역 시작 **/
                        eventStore: this.eventStore,
                        
                        calendarStore: this.calendarStore,
                        
                        procStore: this.procStore,
                        
                        statusStore: this.statusStore,
                        
                        workTypeStore: this.workTypeStore,
                        
                        taskgroupStore: this.taskgroupStore,
                        
                        /**사용자 form 지정 영역 끝 **/
                        
                        
                        
                        border: false,
                        id:'app-calendar',
                        region: 'center',
                        activeItem: viewType, //기본값 월간 보기
                        
                        // CalendarPanel supports view-specific configs that are passed through to the 
                        // underlying views to make configuration possible without explicitly having to 
                        // create those views at this level:
                        monthViewCfg: {
                            showHeader: true,
                            showWeekLinks: true,
                            showWeekNumbers: true
                        },
                        
                        //달력 기본 보기 형태 변경 옵션
                        
                        //showDayView: false,
                        //showWeekView: false,
                        //showMonthView: false,
                        //showNavBar: false,
                        //showTodayText: false,
                        //showTime: false,
                        //title: '${} 님 일정 달력', 
                        
                        initComponent: function() {
                            App.calendarPanel = this;
                            this.constructor.prototype.initComponent.apply(this, arguments);
                        },
                        
                        listeners: {
                            'eventclick': {
                                fn: function(vw, rec, el){
                              		if(rec.data.CalendarId != '01'){					//1: 공통코드의 CALENDARS 그룹 중 com_code:01 공휴일로 지정하여 수정 할 수 없는 항목으로 분류
                        				this.showEditWindow(rec, el);
                                    	this.clearMsg();
                                    }else{
                                    	//SGAlert("", rec.data.Title);
                                    }
                                },
                                scope: this
                            },
                            'eventover':{
                                fn: function(cp, rec){
                                   this.showMsg(''+rec.data.scd_proc_res_content);
                                },
                                scope: this
                            },	
                            	/*
                            	function(vw, rec, el){
                                //console.log('Entered evt rec='+rec.data.Title+', view='+ vw.id +', el='+el.id); 
                           		},
                           		*/
                           		
                            'eventout':{
                                fn: function(cp, rec){
                                   this.showMsg('');
                                },
                                scope: this
                            },	
                            	
                            /*	
                           	function(vw, rec, el){
                                //console.log('Leaving evt rec='+rec.data.Title+', view='+ vw.id +', el='+el.id);
                            },
                            */
                            
                            'eventadd': {
                                fn: function(cp, rec){
                                    this.showMsg(' ('+ rec.data.Title +') 일정이 추가 되었습니다.');
                                },
                                scope: this
                            },
                            'eventupdate': {
                                fn: function(cp, rec){
                                    //this.showMsg(' ('+ rec.data.Title +') 일정이 수정 되었습니다.');
                            		SGAlert("수정", ' ('+ rec.data.Title +') 일정이 수정 되었습니다.');
                                },
                                scope: this
                            },
                            'eventdelete': {
                                fn: function(cp, rec){
                                    this.showMsg(' ('+ rec.data.Title +') 일정이 삭제 되었습니다.');
                                },
                                scope: this
                            },
                            'eventcancel': {
                                fn: function(cp, rec){
                                    // edit canceled
                                },
                                scope: this
                            },
                            'viewchange': {
                                fn: function(p, vw, dateInfo){
                                    if(this.editWin){
                                        this.editWin.hide();
                                    };
                                    if(dateInfo !== null){
                                       
                                        Ext.getCmp('app-nav-picker').setValue(dateInfo.activeDate);
                                        this.updateTitle(dateInfo.viewStart, dateInfo.viewEnd);
                                    }
                                },
                                scope: this
                            },
                            'dayclick': {
                                fn: function(vw, dt, ad, el){
                                    this.showEditWindow({
                                        StartDate: dt,
                                        IsAllDay: ad
                                    }, el);
                                    this.clearMsg();
                                },
                                scope: this
                            },
                            'rangeselect': {
                                fn: function(win, dates, onComplete){
                                    this.showEditWindow(dates);
                                    this.editWin.on('hide', onComplete, this, {single:true});
                                    this.clearMsg();
                                },
                                scope: this
                            },
                            'eventmove': {
                                fn: function(vw, rec){
                                    rec.commit();
                                    var time = rec.data.IsAllDay ? '' : ' g:i a';
                                    this.showMsg(' ('+ rec.data.Title + ') 일정이 ' +rec.data.StartDate.format('m-d'+time) + ' 으로 이동 하였습니다. '); 
                                },
                                scope: this
                            },
                            'eventresize': {
                                fn: function(vw, rec){
                                    rec.commit();
                                    this.showMsg(' ('+ rec.data.Title +') 일정이 수정 되었습니다.');
                                },
                                scope: this
                            },
                            'eventdelete': {
                                fn: function(win, rec){
                                    this.eventStore.remove(rec);
                                    this.showMsg(' ('+ rec.data.Title +') 일정이 삭제 되었습니다.');
                                },
                                scope: this
                            },
                            'initdrag': {
                                fn: function(vw){
                                    if(this.editWin && this.editWin.isVisible()){
                                        this.editWin.hide();
                                    }
                                },
                                scope: this
                            }
                        }
                    }]
                }]
            });
        },
        
       showEditWindow : function(rec, animateTarget){
	        if(!this.editWin){
	            this.editWin = new Ext.calendar.EventEditWindow({
                    
	            	
	            	/**사용자 form 지정 영역 시작 **/
	            	calendarStore: this.calendarStore,					//업무구분
                    
	            	procStore: this.procStore,							//계획 수행
                    
	            	statusStore: this.statusStore,						//일정상태
	            	
	            	workTypeStore: this.workTypeStore,					//일정상태
	            	
	            	taskgroupStore: this.taskgroupStore,				//일정상태
                    
                    
                    
                    /**사용자 form 지정 영역 끝 **/
                    
					listeners: {
						'eventadd': {
							fn: function(win, rec){
								win.hide();
								rec.data.IsNew = false;
								this.eventStore.add(rec);
                                this.showMsg(' ('+ rec.data.Title +') 일정이 추가 되었습니다.');
							},
							scope: this
						},
						'eventupdate': {
							fn: function(win, rec){
								win.hide();
								rec.commit();
                                this.showMsg(' ('+ rec.data.Title +') 일정이 수정 되었습니다.');
							},
							scope: this
						},
						'eventdelete': {
							fn: function(win, rec){
								this.eventStore.remove(rec);
								win.hide();
                                this.showMsg(' ('+ rec.data.Title +') 일정이 삭제 되었습니다.');
							},
							scope: this
						},
                        'editdetails': {
                            fn: function(win, rec){
                                win.hide();
                                App.calendarPanel.showEditForm(rec);
                            }
                        }
					}
                });
	        }
	        this.editWin.show(rec, animateTarget);
		},
        
        updateTitle: function(startDt, endDt){
            var p = Ext.getCmp('app-center');
            
            if(startDt.clearTime().getTime() == endDt.clearTime().getTime()){
                p.setTitle(startDt.format('Y년 F j일'));
            }
            else if(startDt.getFullYear() == endDt.getFullYear()){
                if(startDt.getMonth() == endDt.getMonth()){
                    p.setTitle(startDt.format('Y년 F j일') + ' - ' + endDt.format('Y년 F j일'));
                }
                else{
                    p.setTitle(startDt.format('Y년 F j일') + ' - ' + endDt.format('Y년 F j일'));
                }
            }
            else{
                p.setTitle(startDt.format('Y년 F j일') + ' - ' + endDt.format('Y년 F j일'));
            }
        },
        
        showMsg: function(msg){
            Ext.fly('app-msg').update(msg).removeClass('x-hidden');
        },
        
        showAlert: function(msg){
        	Ext.MessageBox.alert(msg);
        },
        
         
        
        clearMsg: function(){
            Ext.fly('app-msg').update('').addClass('x-hidden');
        }
    }
}();

Ext.onReady(App.init, App);
