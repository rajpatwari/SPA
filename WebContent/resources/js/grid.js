/*!
 * Ext JS Library 3.3.1
 * Copyright(c) 2006-2010 Sencha Inc.
 * licensing@sencha.com
 * http://www.sencha.com/license
 */
Ext.onReady(function() {

      monthStore= new Ext.data.JsonStore({
        autoLoad: true,
        storeId: 'monthStore',
        url: 'http://localhost:8080/THR/months.jsp',
        root: 'root',
        idProperty : 'id',
        fields: [{
            name: 'id'
        }, {
            name: 'mm'
        }]
    });

    var form = new Ext.form.FormPanel({
        baseCls: 'x-plain',
        url:'http://localhost:8080/THR/save-order.jsp',
        labelWidth: 55,
        url: 'save-form.php',
        layout: {
            type: 'vbox',
            align: 'stretch'  // Child items are stretched to full width
        },
        defaults: {
            xtype: 'textfield'
        },

        items: [
            new Ext.form.ComboBox({ //    fields: ['ID', 'schoolMarathi'],
                store: monthStore,
                allowBlank: false,
                valueField: 'id',
                displayField : 'mm' ,
                mode :'local',
                forceSelection : true,
                triggerAction : 'all',
                selectOnFocus :true,
                fieldLabel: 'माहे',
                name : 'from'
            }),


            {
                xtype: 'combo',
                store: ['test@example.com', 'someone-else@example.com' ],
                plugins: [ Ext.ux.FieldReplicator, Ext.ux.FieldLabeler ],
                fieldLabel: 'Send To',
                name: 'to'
            },{
                plugins: [ Ext.ux.FieldLabeler ],
                fieldLabel: 'Subject',
                name: 'subject'
            }, {
                xtype: 'textarea',
                fieldLabel: 'Message text',
                hideLabel: true,
                name: 'msg',
                flex: 1  // Take up all *remaining* vertical space
            }]
    });

    var w = new Ext.Window({
        title: 'Compose message',
        collapsible: true,
        maximizable: true,
        width: 750,
        height: 500,
        minWidth: 300,
        minHeight: 200,
        layout: 'fit',
        plain: true,
        bodyStyle: 'padding:5px;',
        buttonAlign: 'center',
        items: form,
        buttons: [{
                text: 'Send'
            },{
                text: 'Cancel'
            }]
    });
    w.show();
});