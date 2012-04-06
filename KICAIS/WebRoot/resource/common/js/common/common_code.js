function formTest(){
	var bd = Ext.getBody();
	Ext.QuickTips.init();

    // turn on validation errors beside the field globally
    Ext.form.Field.prototype.msgTarget = 'side';
    var fsf = new Ext.FormPanel({
        labelWidth: 75, // label settings here cascade unless overridden
        id: 'commonCodeReg',
        frame:true,
        title: '신규 코드 등록',
        bodyStyle:'padding:5px 5px 0',
        width: 500,

        items: [{
            xtype:'fieldset',
            collapsible: true,
            autoHeight:true,
            title: '필수 항목',
            autoHeight:true,
            defaults: {width: 300},
            
           layout:'column',
           items:[{
                columnWidth:.5,
                layout: 'form',
                items: [{
                    xtype:'textfield',
                    fieldLabel: '그룹코드',
                    name: 'GROUP_CODE',
                    anchor:'90%',
                    allowBlank : false
                }, {
                    xtype:'combo',
                    fieldLabel: '그룹명',
                    name: 'GROUP_NAME',
                    anchor:'90%',
                    allowBlank : false
                }, {
                    xtype: 'radiogroup',
		            fieldLabel: '시스템 Y/N',
		            items: [
		                {boxLabel: '예', name: 'SYSTEM_CODE_YN', inputValue: 'Y'},
		                {boxLabel: '아니오', name: 'SYSTEM_CODE_YN', inputValue: 'N'}
		            ],
                    anchor:'90%',
                    allowBlank : false
                }]
            },{
                columnWidth:.5,
                layout: 'form',
                items: [{
                    xtype:'textfield',
                    fieldLabel: '상세코드',
                    name: 'COM_CODE',
                    anchor:'90%',
                    allowBlank : false
                },{
                    xtype:'textfield',
                    fieldLabel: '코드명',
                    name: 'COM_CODE_NAME',
                    anchor:'90%',
                    allowBlank : false
                },{
                    xtype: 'radiogroup',
		            fieldLabel: '사용 Y/N',
		            items: [
		                {boxLabel: '예', name: 'USE_YN', inputValue: 'Y'},
		                {boxLabel: '아니오', name: 'USE_YN', inputValue: 'N'}
		            ],
                    anchor:'90%',
                    allowBlank : false
                }]
            }]
        },{
            xtype:'fieldset',
            title: '선택 항목',
            collapsed: true,
            checkboxToggle:true,
            autoHeight:true,
            defaults: {width: 600},
            layout:'column',
			items:[{
		        columnWidth:.5,
		        layout: 'form',
		        items: [{
		            xtype:'textfield',
		            fieldLabel: '참조값1',
		            name: 'REF_VAL_01',
		            anchor:'95%'
		        }, {
		            xtype:'textfield',
		            fieldLabel: '참조값2',
		            name: 'REF_VAL_02',
		            anchor:'95%'
		        }, {
		            xtype:'textfield',
		            fieldLabel: '참조값3',
		            name: 'REF_VAL_03',
		            anchor:'95%'
		        }, {
		            xtype:'textfield',
		            fieldLabel: '참조값4',
		            name: 'REF_VAL_04',
		            anchor:'95%'
		        }, {
		            xtype:'textfield',
		            fieldLabel: '참조값5',
		            name: 'REF_VAL_05',
		            anchor:'95%'
		        }, {
		            xtype:'textfield',
		            fieldLabel: '참조값6',
		            name: 'REF_VAL_06',
		            anchor:'95%'
		        }]
		    },{
		        columnWidth:.5,
		        layout: 'form',
		        items: [{
		            xtype:'textfield',
		            fieldLabel: '참조값명1',
		            name: 'REF_NAME_01',
		            anchor:'95%'
		        },{
		            xtype:'textfield',
		            fieldLabel: '참조값명2',
		            name: 'REF_NAME_02',
		            anchor:'95%'
		        },{
		            xtype:'textfield',
		            fieldLabel: '참조값명3',
		            name: 'REF_NAME_03',
		            anchor:'95%'
		        },{
		            xtype:'textfield',
		            fieldLabel: '참조값명4',
		            name: 'REF_NAME_04',
		            anchor:'95%'
		        },{
		            xtype:'textfield',
		            fieldLabel: '참조값명5',
		            name: 'REF_NAME_05',
		            anchor:'95%'
		        },{
		            xtype:'textfield',
		            fieldLabel: '참조값명6',
		            name: 'REF_NAME_06',
		            anchor:'95%'
		        }]
		    }]
        }],

        buttons: [{
            text: '닫기',
            handler: closeHandler
        },{
            text: '초기화',
            handler: function(){
                fsf.getForm().reset();
            }
        },{
            text: '등록',
            handler : submitHandler
        }]
    });

    fsf.render(inputForm);
}

var onSuccessOrFail = function(form, action) {
	var formPanel = Ext.getCmp('commonCodeReg');
	formPanel.el.unmask();
	alert(action.result.success);
	var result = action.result;
	if (result.success) {
		Ext.MessageBox.alert('Success',action.result.msg);
		closeHandler();
	}
	else {
		Ext.MessageBox.alert('Failure',action.result.msg);
	}
}

function closeHandler(){
    var formPanel = Ext.getCmp('commonCodeReg').hide();
    formPanel.hide();
}

var submitHandler = function() {
	var formPanel = Ext.getCmp('commonCodeReg');
	formPanel.el.mask('Please wait', 'x-mask-loading');
  
	formPanel.getForm().submit({
		url		: 'getParam.sg',
		success	: onSuccessOrFail,
		failure	: onSuccessOrFail
	});
}