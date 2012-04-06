/*!
 * Ext JS Library 3.3.1
 * Copyright(c) 2006-2010 Sencha Inc.
 * licensing@sencha.com
 * http://www.sencha.com/license
 */
 
Ext.calendar.EventMappings = {
    EventId		:{   name: 'EventId',    mapping: 'id',       type: 'int'      },
    CalendarId	:{   name: 'CalendarId', mapping: 'cid',      type: 'int'      },
    Title		:{   name: 'Title',		 mapping: 'title',    type: 'string'    },
    StartDate	:{   name: 'StartDate',  mapping: 'start',    type: 'date',	   dateFormat: 'c'   },
    EndDate		:{	 name: 'EndDate',    mapping: 'end',      type: 'date',    dateFormat: 'c'   },
    Location	:{   name: 'Location',   mapping: 'loc',      type: 'string'   },
    Notes		:{   name: 'Notes',      mapping: 'notes',    type: 'string'   },
    Url			:{   name: 'Url',        mapping: 'url',      type: 'string'   },
    IsAllDay	:{   name: 'IsAllDay',   mapping: 'ad',       type: 'boolean'  },
    Reminder	:{   name: 'Reminder',   mapping: 'rem',      type: 'string'   },
    IsNew		:{   name: 'IsNew',      mapping: 'n',        type: 'boolean'  }
    
    , scd_day_seq          :  {name: 'scd_day_seq' 			, mapping:'scd_day_seq' 		 , type:'int'}
	, scd_type_code        :  {name: 'scd_type_code' 		, mapping:'scd_type_code' 		 , type:'string'}
	, proc_type_code       :  {name: 'proc_type_code' 		, mapping:'proc_type_code' 		 , type:'string'}
	, scd_day_reg_dept     :  {name: 'scd_day_reg_dept' 	, mapping:'scd_day_reg_dept' 	 , type:'string'}
	, scd_day_reg_emp_num  :  {name: 'scd_day_reg_emp_num' 	, mapping:'scd_day_reg_emp_num'  , type:'string'}
	, status_val           :  {name: 'status_val' 			, mapping:'status_val' 			 , type:'string'}
	, work_pattern_code    :  {name: 'work_pattern_code' 	, mapping:'work_pattern_code' 	 , type:'string'}
	, scd_sdate            :  {name: 'scd_sdate' 			, mapping:'scd_sdate' 			 , type:'string'}
	, scd_time_from        :  {name: 'scd_time_from' 		, mapping:'scd_time_from' 		 , type:'string'}
	, scd_time_to          :  {name: 'scd_time_to' 			, mapping:'scd_time_to' 		 , type:'string'}
	, scd_time             :  {name: 'scd_time' 			, mapping:'scd_time' 			 , type:'string'}
	, labor_cost           :  {name: 'labor_cost' 			, mapping:'labor_cost' 			 , type:'int'}
	
	, pjt_id               :  {name: 'pjt_id' 				, mapping:'pjt_id' 				 , type:'string'}
	, pjt_nm               :  {name: 'pjt_nm' 				, mapping:'pjt_nm' 				 , type:'string'}
	
	, task_group_code      :  {name: 'task_group_code' 		, mapping:'task_group_code' 	 , type:'string'}
	, task_code            :  {name: 'task_code' 			, mapping:'task_code' 			 , type:'string'}
	, pay_no               :  {name: 'pay_no' 				, mapping:'pay_no' 				 , type:'string'}
	, visit_report_no      :  {name: 'visit_report_no' 		, mapping:'visit_report_no' 	 , type:'string'}
	, scd_proc_res_content :  {name: 'scd_proc_res_content' , mapping:'scd_proc_res_content' , type:'string'}
	, note                 :  {name: 'note' 				, mapping:'note' 				 , type:'string'}
	, pjt_status           :  {name: 'pjt_status'			, mapping:'pjt_status'			 , type:'string'}
	, final_mod_id         :  {name: 'final_mod_id' 		, mapping:'final_mod_id' 		 , type:'string'}
	, final_mod_date       :  {name: 'final_mod_date' 		, mapping:'final_mod_date' 		 , type:'string'}
	, scd_edate            :  {name: 'scd_edate' 			, mapping:'scd_edate' 			 , type:'string'}
	, reg_date             :  {name: 'reg_date' 			, mapping:'reg_date' 			 , type:'string'}
	, reg_id               :  {name: 'reg_id' 				, mapping:'reg_id' 				 , type:'string'}
    
    
    
};

 
 (function() {
    var M = Ext.calendar.EventMappings;

    Ext.calendar.EventRecord = Ext.data.Record.create([
    M.EventId,
    M.CalendarId,
    M.Title,
    M.StartDate,
    M.EndDate,
    M.Location,
    M.Notes,
    M.Url,
    M.IsAllDay,
    M.Reminder,
    M.IsNew
    
    ,M.scd_day_seq          
    ,M.scd_type_code        
    ,M.proc_type_code       
    ,M.scd_day_reg_dept     
    ,M.scd_day_reg_emp_num  
    ,M.status_val           
    ,M.work_pattern_code    
    ,M.scd_sdate            
    ,M.scd_time_from        
    ,M.scd_time_to          
    ,M.scd_time             
    ,M.labor_cost           
    ,M.pjt_id    
    ,M.pjt_nm    
    ,M.task_group_code      
    ,M.task_code            
    ,M.pay_no               
    ,M.visit_report_no      
    ,M.scd_proc_res_content 
    ,M.note                 
    ,M.pjt_status           
    ,M.final_mod_id         
    ,M.final_mod_date       
    ,M.scd_edate            
    ,M.reg_date             
    ,M.reg_id               
    ]);

    
    Ext.calendar.EventRecord.reconfigure = function() {
        Ext.calendar.EventRecord = Ext.data.Record.create([
        M.EventId,
        M.CalendarId,
        M.Title,
        M.StartDate,
        M.EndDate,
        M.Location,
        M.Notes,
        M.Url,
        M.IsAllDay,
        M.Reminder,
        M.IsNew
        
        
        ,M.scd_day_seq          
	    ,M.scd_type_code        
	    ,M.proc_type_code       
	    ,M.scd_day_reg_dept     
	    ,M.scd_day_reg_emp_num  
	    ,M.status_val           
	    ,M.work_pattern_code    
	    ,M.scd_sdate            
	    ,M.scd_time_from        
	    ,M.scd_time_to          
	    ,M.scd_time             
	    ,M.labor_cost           
	    ,M.pjt_id
	    ,M.pjt_nm
	    ,M.task_group_code      
	    ,M.task_code            
	    ,M.pay_no               
	    ,M.visit_report_no      
	    ,M.scd_proc_res_content 
	    ,M.note                 
	    ,M.pjt_status           
	    ,M.final_mod_id         
	    ,M.final_mod_date       
	    ,M.scd_edate            
	    ,M.reg_date             
	    ,M.reg_id
        ]);
    };
})();
