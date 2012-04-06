<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/web/jsp/common/inc/commonInc.jsp" %>
<script type="text/javascript" src="/resource/common/js/ext-base.js"></script>
<script type="text/javascript" src="/resource/common/js/ext-all.js"></script>
<script type="text/javascript" src="/resource/common/js/CheckColumn.js"></script>
<script type="text/javascript" src="/resource/common/js/examples.js"></script>
<link rel="stylesheet" type="text/css" href="/resource/common/css/ext-all.css" />
<link rel="stylesheet" type="text/css" href="/resource/common/css/examples.css" />
<link rel="stylesheet" type="text/css" href="/resource/common/css/grid-examples.css" />
<link rel="stylesheet" type="text/css" href="/resource/common/css/silk.css" />
<SCRIPT LANGUAGE="JavaScript">
<!--
Ext.onReady(function(){

    /**
     * Handler specified for the 'Available' column renderer
     * @param {Object} value
     */
    function formatDate(value){
        return value ? value.dateFormat('M d, Y') : '';
    }

    // shorthand alias
    var fm = Ext.form;

    var userColumns =  [
                        {header: "그룹코드", width: 40, sortable: true, dataIndex: 'group_code'},
                        {header: "상세코드", width: 100, sortable: true, dataIndex: 'com_code', editor: new Ext.form.TextField({})},
                        {header: "코드명", width: 50, sortable: true, dataIndex: 'com_code_name', editor: new Ext.form.TextField({})},
                        {header: "시스템사용여부", width: 50, sortable: true, dataIndex: 'system_code_yn', editor: new Ext.form.TextField({})},
                        {header: "사용여부", width: 50, sortable: true, dataIndex: 'use_yn', editor: new Ext.form.TextField({})},
                        {header: "참조값 1", width: 50, sortable: true, dataIndex: 'ref_name_01', editor: new Ext.form.TextField({})},
                        {header: "참조값명 1", width: 50, sortable: true, dataIndex: 'ref_val_01', editor: new Ext.form.TextField({})},
                        {header: "참조값 2", width: 50, sortable: true, dataIndex: 'ref_name_02', editor: new Ext.form.TextField({})},
                        {header: "참조값명 2", width: 50, sortable: true, dataIndex: 'ref_val_02', editor: new Ext.form.TextField({})},
                        {header: "참조값 3", width: 50, sortable: true, dataIndex: 'ref_name_03', editor: new Ext.form.TextField({})},
                        {header: "참조값명 3", width: 50, sortable: true, dataIndex: 'ref_val_03', editor: new Ext.form.TextField({})},
                        {header: "참조값 4", width: 50, sortable: true, dataIndex: 'ref_name_04', editor: new Ext.form.TextField({})},
                        {header: "참조값명 4", width: 50, sortable: true, dataIndex: 'ref_val_04', editor: new Ext.form.TextField({})},
                        {header: "참조값 5", width: 50, sortable: true, dataIndex: 'ref_name_05', editor: new Ext.form.TextField({})},
                        {header: "참조값명 5", width: 50, sortable: true, dataIndex: 'ref_val_05', editor: new Ext.form.TextField({})},
                        {header: "최종변경자ID", width: 50, sortable: true, dataIndex: 'final_mod_id', editor: new Ext.form.TextField({})},
                        {header: "최종변경일시", width: 50, sortable: true, dataIndex: 'final_mod_date', editor: new Ext.form.TextField({})}
                    ];


    
    // the column model has information about grid columns
    // dataIndex maps the column to the specific data field in
    // the data store (created below)
    var cm = new Ext.grid.ColumnModel({
        // specify any defaults for each column
        defaults: {
            sortable: true // columns are not sortable by default           
        },
        columns: [{
            id: 'common',
            header: 'Common Name',
            dataIndex: 'group_code',
            width: 220,
            // use shorthand alias defined above
            editor: new fm.TextField({
                allowBlank: false
            })
        }, {
            header: 'Light',
            dataIndex: 'light',
            width: 130,
            editor: new fm.ComboBox({
                typeAhead: true,
                triggerAction: 'all',
                // transform the data already specified in html
                transform: 'light',
                lazyRender: true,
                listClass: 'x-combo-list-small'
            })
        }, {
            header: 'Price',
            dataIndex: 'price',
            width: 70,
            align: 'right',
            renderer: 'usMoney',
            editor: new fm.NumberField({
                allowBlank: false,
                allowNegative: false,
                maxValue: 100000
            })
        }, {
            header: 'Available',
            dataIndex: 'availDate',
            width: 95,
            renderer: formatDate,
            editor: new fm.DateField({
                format: 'm/d/y',
                minValue: '01/01/06',
                disabledDays: [0, 6],
                disabledDaysText: 'Plants are not available on the weekends'
            })
        }, {
            xtype: 'checkcolumn',
            header: 'Indoor?',
            dataIndex: 'indoor',
            width: 55
        }
        ]
        
    });

    // create the Data Store
    var store = new Ext.data.JsonStore({
        // store configs
        autoDestroy: true,
        url: 'testResult.sg',
        remoteSort: false,
        sortInfo: {
            field: 'group_code',
            direction: 'ASC'
        },
        storeId: 'myStore',
        
        // reader configs
        idProperty: 'id',
        root: 'data',
        totalProperty: 'total',
        fields: [
                 // the 'name' below matches the tag name to read, except 'availDate'
                 // which is mapped to the tag 'availability'
                 {name: 'common', type: 'string'},
                 {name: 'botanical', type: 'string'},
                 {name: 'light'},
                 {name: 'price', type: 'string'},             
                 // dates can be automatically converted by specifying dateFormat
                 {name: 'availDate', type: 'date', dateFormat: 'm/d/Y'},
                 {name: 'indoor', type: 'string'}
             ]
    });
    
    // create the editor grid
    var grid = new Ext.grid.EditorGridPanel({
        store: store,
        cm: cm,
        renderTo: 'editor-grid',
        width: 600,
        height: 300,
        autoExpandColumn: 'group_code', // column with this id will be expanded
        title: 'Edit Plants?',
        frame: true,
        clicksToEdit: 1,
        tbar: [{
            text: 'Add Plant',
            handler : function(){
                // access the Record constructor through the grid's store
                var Plant = grid.getStore().recordType;
                var p = new Plant({
                	group_code: 'New Plant 1',
                    light: 'Mostly Shade',
                    price: 0,
                    availDate: (new Date()).clearTime(),
                    indoor: false
                });
                grid.stopEditing();
                store.insert(0, p);
                grid.startEditing(0, 0);
            }
        }]
    });

    
     
    // manually trigger the data store load
    store.load({
        // store loading is asynchronous, use a load listener or callback to handle results
        callback: function(){
            Ext.Msg.show({
                title: 'Store Load Callback',
                msg: 'store was loaded, data available for processing',
                modal: false,
                icon: Ext.Msg.INFO,
                buttons: Ext.Msg.OK
            });
        }
    });
 
});
//-->
 </SCRIPT>
 
<html>
<head>
    <title>Editor Grid Example</title>

</head>
<body>
    <h1>Editor Grid</h1>

    <!-- the custom editor for the 'Light' column references the id="light" -->
    <select name="light" id="light" style="display: none;">
    	<option value="Shade">Shade</option> 
    	<option value="Mostly Shady">Mostly Shady</option>
    	<option value="Sun or Shade">Sun or Shade</option>
    	<option value="Mostly Sunny">Mostly Sunny</option>
    	<option value="Sunny">Sunny</option>
    </select>
    
    <div id="editor-grid"></div>

</body>
</html>