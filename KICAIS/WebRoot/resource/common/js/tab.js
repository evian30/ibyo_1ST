
Ext.onReady(function(){ 
	
    var tabs = new Ext.TabPanel({ 
        plain: true, 
    	renderTo: 'allProjectMng',
        width:1000,
        activeTab: 0,
        frame:false,
        enableTabScroll: true,
        defaults:{autoHeight: true},
        resizeTabs: true,
        
        items:[
	            {
	            	title: '프로젝트'
	              , contentEl:'allPjtInfo'
	              , layout:'fit'	 
	            },
	            {
	            	title: '견적'
	              , contentEl:'allEstInfo' 
	              , layout:'fit'	  
	            },
	            {
	            	title: '수주'
	              , contentEl:'allOrdInfo' 
	              , layout:'fit'	  
	            },
	            {
	            	title: '구매'
	              , contentEl:'allPurInfo' 
	              , layout:'fit'	  
	            },
	            {
	            	title: '매출'
	              , contentEl:'allSalInfo' 
	              , layout:'fit'	  
	            },
	            {
	            	title: '유지보수'
	              , contentEl:'allManInfo' 
	              , layout:'fit'	  
	            }
	            
            
        ]
         
        
    });  
});