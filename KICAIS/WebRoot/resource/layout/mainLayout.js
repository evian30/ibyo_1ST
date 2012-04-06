/*
var topPanel=new Ext.Panel({
	id: 'topPanel',
	enableTabScroll:true,
	collapsible:true,
	region: 'north',
	split:true, 
	collapsible:true, 
	collapseMode:'mini',
	height: 70,
	header:false
});
*/
TopPanel = function() {
	TopPanel.superclass.constructor.call(this, {
		id: 'topPanel',
		enableTabScroll:false,
		collapsible:false,
		region: 'north',
		split:false, 
		collapsible:false, 
		collapseMode:'mini',
		height: 66,
		header:false,
		autoLoad:{
			url: '/sgis/topMenu.sg'
		}		
	})
};
Ext.extend(TopPanel, Ext.Panel, {});

/*
var centerPanel=new Ext.Panel({
	title: 'Center Panel',
	id: 'centerPanel',
	region: 'center'
});
*/

CenterPanel = function() {
	CenterPanel.superclass.constructor.call(this, {
		title: 'KICA Information System',
		id: 'centerPanel',
		region: 'center',
		autoScroll: true
	})
};
Ext.extend(CenterPanel, Ext.Panel, {});

/*
var searchPanel=new Ext.Panel({
	id: 'regPanel',
	enableTabScroll:true,
	collapsible:true,
	region: 'east',
	split:true, 
	collapsible:true, 
	collapseMode:'mini',
	collapsed:true,
	header:false,
	autoWidth:true 
});
*/
SearchPanel = function() {
	SearchPanel.superclass.constructor.call(this, {
		id: 'searchPanel',
		enableTabScroll:true,
		collapsible:true,
		region: 'east',
		split:true, 
		collapsible:true, 
		collapseMode:'mini',
		collapsed:true,
		header:false,
		autoWidth:true 
	})
};
Ext.extend(SearchPanel, Ext.Panel, {});

/*
var regPanel=new Ext.Panel({
	id: 'searchPanel',
	enableTabScroll:true,
	collapsible:true,
	region: 'south',
	split:true, 
	collapsible:true, 
	collapseMode:'mini',
	collapsed:true,
	header:false,
	//autoWidth:true,
	autoHeight: true
});
*/


RegPanel = function() {
	RegPanel.superclass.constructor.call(this, {
		id: 'regPanel',
		enableTabScroll:true,
		collapsible:true,
		region: 'south',
		split:true, 
		collapsible:true, 
		collapseMode:'mini',
		collapsed:true,
		header:false,
		autoHeight: true
	})
};
Ext.extend(RegPanel, Ext.Panel, {});

/*
var navPane = { 
	title: 'SGIS 메뉴',
	id: 'navPanel',
    collapsible: true,
    region:'west',
	width: 260,
    items: {
        xtype: 'treepanel',
        id: 'tree',
        autoScroll: true,
        animate: true,
        enableDD: true,
        containerScroll: true,
        border: false,
		rootVisible: false,
        dataUrl: 'treeMenu.sg',
        root: {
            nodeType: 'async',
            text: '전체',
            draggable: false,
            id: 'project'
        },
		listeners: {
            click: function(node) {
				if (node.isLeaf()){
					//alert('id: ' + node.id + ',  leaf: true' + ', attributes.text : ' + node.attributes.text + ', attributes.url : ' + node.attributes.url);
					centerPanel.removeAll();
					loadUrl(node.attributes.text, node.attributes.url);
					
				}else {
					//alert('id:  ' + node.id + ',  leaf: false');
				}
            }
        }
    }
}
*/

NavPanel = function() {
	NavPanel.superclass.constructor.call(this, {
		title: 'KICA IS 메뉴',
		id: 'navPanel',
	    collapsible: true,
	    region:'west',
		width: 190,
		autoScroll: true,
	    items: {
	        xtype: 'treepanel',
	        id: 'tree',
	        autoScroll: true,
	        animate: true,
	        enableDD: true,
	        containerScroll: true,
	        border: false,
			rootVisible: false,
	        dataUrl: 'treeMenu.sg',
	        root: {
	            nodeType: 'async',
	            text: '전체',
	           // draggable: false,
	            id: 'project'
	        },
			listeners: {
	            click: function(node) {  
					if (node.toString().length == 16){
						centerPanel.removeAll();
						loadUrl(node.attributes.text, node.attributes.url);
					}else {
					}
	            }
	        }
	    }
	});
};
Ext.extend(NavPanel, Ext.Panel, {});

function loadPage(target, url, params)
{
    Ext.Ajax.request(
    {
        url: url,
        params: params,
        success: function(response, options)
        {
            var html = response.responseText;
            var el = target.getUpdater().getEl();
            el.dom.innerHTML = '<div></div>';
            el.insertHtml('afterbegin', html);
        }
    });
}


function loadUrl(targetTitle, targetUrl){
	centerPanel.setTitle(targetTitle);
    //loadPage(centerPanel,targetUrl)
	
	centerPanel.load({
        url: targetUrl,
		scripts:true
   	});
   	
}




var topPanel = new TopPanel();
var navPanel = new NavPanel();
var centerPanel = new CenterPanel();
var searchPanel = new SearchPanel();
var regPanel = new RegPanel();

// 메인 클래스
BasicLayoutClass = function() {
	return {
		init : function() {
			Ext.QuickTips.init();
			this.viewport = new Ext.Viewport( {
				layout : 'border',
				items : [topPanel, navPanel, centerPanel]// searchPanel, regPanel
			});

			this.viewport.doLayout();
   			this.viewport.syncSize();
  		}
	}
}();

Ext.EventManager.onDocumentReady(BasicLayoutClass.init, BasicLayoutClass, true);
