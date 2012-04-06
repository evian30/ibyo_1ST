 
Ext.calendar.ProcPicker = Ext.extend(Ext.form.ComboBox, {
    fieldLabel: '계획/수행',
    valueField: 'proc_type_code',
    displayField: 'proc_type_nm',
    triggerAction: 'all',
    mode: 'local',
    forceSelection: true,
    width: 200,

    // private
    initComponent: function() {
        Ext.calendar.ProcPicker.superclass.initComponent.call(this);
        this.tpl = this.tpl ||
        '<tpl for="."><div class="x-combo-list-item ">{' + this.displayField + '}</div></tpl>';
    },

    // private
    afterRender: function() {
        Ext.calendar.ProcPicker.superclass.afterRender.call(this);

        this.wrap = this.el.up('.x-form-field-wrap');
        this.wrap.addClass('ext-calendar-picker');

        this.icon = Ext.DomHelper.append(this.wrap, {
            tag: 'div',
            cls: 'ext-cal-picker-icon ext-cal-picker-mainicon'
        });
    },

    // inherited docs
    setValue: function(value) {
        this.wrap.removeClass('ext-color-' + this.getValue());
        if (!value && this.store !== undefined) {
            // always default to a valid calendar
            //value = this.store.getAt(0).data.CalendarId;
        }
        Ext.calendar.ProcPicker.superclass.setValue.call(this, value);
        this.wrap.addClass('ext-color-' + value);
    }
});

Ext.reg('procpicker', Ext.calendar.ProcPicker);
 