Ext.onReady(function(){
    Ext.state.Manager.setProvider(new Ext.state.CookieProvider());
    var SUBMIT_URL = ""  ;

    function formatDate(value){
        return value ? value.dateFormat('M d, Y') : '';
    }

    districtStore= new Ext.data.JsonStore({
        autoLoad: true,
        storeId: 'monthStore',
        url: 'read/get-all-districts.jsp',
        root: 'root',
        idProperty : 'districtID',
        fields: ['districtID','districtMarathi', 'district' ],
        sortInfo: {
            field:'district',
            direction:'ASC'
        }
    });

    talukaStore= new Ext.data.JsonStore({
        storeId: 'talukaStore',
        url: 'read/get-talukas.jsp',
        root: 'root',
        idProperty : 'talukaID',
        fields: ['talukaID','talukaMarathi', 'taluka' ],
        sortInfo: {
            field:'taluka',
            direction:'ASC'
        }
    });

    sectionStore= new Ext.data.JsonStore({
        //autoLoad: true,
        storeId: 'sectionStore',
        url: 'read/get-sections.jsp',
        root: 'root',
        idProperty : 'sectionID',
        fields: ['sectionID','sectionMarathi', 'section'],
        sortInfo: {
            field:'section',
            direction:'ASC'
        }
    });

    schoolStore = new Ext.data.JsonStore({
        //  autoLoad: true,
        storeId: 'schoolStore',
        fields: ['schoolID', 'schoolMarathi', 'school'  ],
        url: 'read/get-schools.jsp',
        root: 'root',
        idProperty :  'schoolID',
        sortInfo: {
            field:'school',
            direction:'ASC'
        }
    });


    monthStore= new Ext.data.JsonStore({
        autoLoad: true,
        storeId: 'monthStore',
        url: 'read/months.jsp',
        root: 'root',
        idProperty : 'id',
        fields: ['id','mm']
    });

    monthStore1= new Ext.data.JsonStore({
        autoLoad: true,
        storeId: 'monthStore',
        url: 'read/months.jsp',
        root: 'root',
        idProperty : 'id',
        fields: ['id','mm']
    });

    var fm = Ext.form;
    var cm = new Ext.grid.ColumnModel({
        // specify any defaults for each column
        defaults: {
            sortable: true // columns are not sortable by default
        },
        columns: [new Ext.grid.RowNumberer(),{
            header: 'चालान क्र.',
            dataIndex: 'orderDetailID',
            id: 'orderDetailID',
            width: 95
        },{
            id: 'school',
            header: 'अंगणवाडी',
            dataIndex: 'school',
            width: 100,
            // use shorthand alias defined above
            editor: new Ext.form.ComboBox({ //    fields: ['ID', 'schoolMarathi'],
                store: schoolStore,
                id : 'cm-school',
                allowBlank: false,
                displayField : 'schoolMarathi' ,
                valueField: 'schoolID',
                editable:false,
                mode :'local',
                forceSelection : true,
                triggerAction : 'all',
                // selectOnFocus :true,
                name :'schoolMarathi',
                hiddenName :'school'
            }),
            renderer: function(value) {
                var r = Ext.getCmp('cm-school').store.getById(value);
                return r ? r.get('schoolMarathi') : '';
            }
        }, {
            header: '६ म. ते ३ व. लाभाथीँ',
            dataIndex: 'g1',
            id: 'g1',
            width: 110,
            align: 'right',
            editor: new fm.NumberField({
                allowBlank: false,
                allowNegative: false,
                maxValue: 100000
            })
        }, {
            header: 'ग. माता व स. माता लाभाथीँ',
            dataIndex: 'g2',
            id: 'g2',
            width: 150,
            align: 'right',
            editor: new fm.NumberField({
                allowBlank: false,
                allowNegative: false,
                maxValue: 100000
            })
        }, {
            header: '० म. ते ३ व तीव्र कुपोषीत बालके लाभाथीँ',
            dataIndex: 'g3',
            id: 'g3',
            width: 200,
            align: 'right',
            editor: new fm.NumberField({
                allowBlank: false,
                allowNegative: false,
                maxValue: 100000
            })
        },{
            header: '३ म. ते ६ व तीव्र कुपोषीत बालके लाभाथीँ',
            dataIndex: 'g4',
            id: 'g4',
            width: 200,
            align: 'right',

            editor: new fm.NumberField({
                allowBlank: false,
                allowNegative: false,
                maxValue: 100000
            })
        },{
            header: 'चालान दिनांक',
            dataIndex: 'challanDate',
            id: 'challanDate',
            width: 95,
            editor: {
                xtype : 'textfield'
            }
        }]
    });

    var ecm = new Ext.grid.ColumnModel({
        // specify any defaults for each column
        defaults: {
            sortable: true // columns are not sortable by default
        },
        columns: [new Ext.grid.RowNumberer(),{
            header: 'चालान क्र.',
            dataIndex: 'orderDetailID',
            id: 'orderDetailID',
            width: 95
        },{
            id: 'school',
            header: 'अंगणवाडी',
            dataIndex: 'school',
            width: 100,
            // use shorthand alias defined above
            editor: new Ext.form.ComboBox({ //    fields: ['ID', 'schoolMarathi'],
                store: schoolStore,
                id : 'ecm-school',
                allowBlank: false,
                displayField : 'schoolMarathi' ,
                valueField: 'schoolID',
                editable:false,
                mode :'local',
                forceSelection : true,
                triggerAction : 'all',
                // selectOnFocus :true,
                name :'schoolMarathi',
                hiddenName :'school'
            }),
            renderer: function(value) {
                var r = Ext.getCmp('ecm-school').store.getById(value);
                return r ? r.get('schoolMarathi') : '';
            }
        }, {
            header: '६ म. ते ३ व. लाभाथीँ',
            dataIndex: 'g1',
            id: 'g1',
            width: 110,
            align: 'right',
            editor: new fm.NumberField({
                allowBlank: false,
                allowNegative: false,
                maxValue: 100000
            })
        }, {
            header: 'ग. माता व स. माता लाभाथीँ',
            dataIndex: 'g2',
            id: 'g2',
            width: 150,
            align: 'right',
            editor: new fm.NumberField({
                allowBlank: false,
                allowNegative: false,
                maxValue: 100000
            })
        }, {
            header: '० म. ते ३ व तीव्र कुपोषीत बालके लाभाथीँ',
            dataIndex: 'g3',
            id: 'g3',
            width: 200,
            align: 'right',
            editor: new fm.NumberField({
                allowBlank: false,
                allowNegative: false,
                maxValue: 100000
            })
        },{
            header: '३ म. ते ६ व तीव्र कुपोषीत बालके लाभाथीँ',
            dataIndex: 'g4',
            id: 'g4',
            width: 200,
            align: 'right',

            editor: new fm.NumberField({
                allowBlank: false,
                allowNegative: false,
                maxValue: 100000
            })
        }, {
            header: 'चालान दिनांक',
            dataIndex: 'challanDate',
            id: 'challanDate',
            width: 95,
            editor: {
                xtype : 'textfield'
            }
        }]
    });


    nOStore= new Ext.data.JsonStore({
        autoDestroy: true,
        // autoLoad: true,
        storeId: 'nOStore',
        url: 'newjsp.jsp',
        root: 'root',
        idProperty : 'orderDetailID',
        writer : new Ext.data.JsonWriter(),
        fields: [{
            name: 'orderDetailID'
        }, {
            name: 'orderID'
        }, {
            name: 'school'
        },{
            name: 'g1'
        }, {
            name: 'g2'
        }, {
            name: 'g3'
        }, {
            name: 'g4'
        }, {
            name: 'challan'
        }, {
            name: 'challanDate'
        }],
        sortInfo: {
            field:'orderID',
            direction:'DESC'
        }
    });

    editOrderStore= new Ext.data.JsonStore({
        autoDestroy: true,
        // autoLoad: true,
        storeId: 'editOrderStore',
        url: 'read/get-order-details.jsp',
        root: 'root',
        idProperty : 'orderDetailID',
        fields: [{
            name: 'orderDetailID'
        }, {
            name: 'orderID'
        }, {
            name: 'school'
        },{
            name: 'g1'
        }, {
            name: 'g2'
        }, {
            name: 'g3'
        }, {
            name: 'g4'
        }, {
            name: 'challan'
        }, {
            name: 'challanDate'
        }],

        sortInfo: {
            field:'orderID',
            direction:'DESC'
        }
    });



    aOStore= new Ext.data.JsonStore({
        autoDestroy: true,
        //autoLoad: true,
        storeId: 'aOStore',
        url: 'read/get-all-orders.jsp',
        root: 'root',
        idProperty : 'orderID',
        fields: [{
            name: 'orderID'
        }, {
            name: 'district'
        },{
            name: 'taluka'
        },{
            name: 'section'
        },{
            name: 'from'
        }, {
            name: 'to'
        }, {
            name: 'year'
        }, {
            name: 'date'
        }],
        sortInfo: {
            field:'orderID',
            direction:'ASC'
        }
    });

    aOStore.load({
        params:{
            start:0,
            limit:25
        }
    });

    aIStore= new Ext.data.JsonStore({
        autoDestroy: true,
        //autoLoad: true,
        storeId: 'aIStore',
        url: 'read/get-all-invoices.jsp',
        root: 'root',
        idProperty : 'invoiceID',
        fields: [{
            name: 'invoiceID'
        }, {
            name: 'district'
        },{
            name: 'taluka'
        },{
            name: 'total'
        },{
            name: 'totalMarathi'
        },{
            name: 'fromMonth'
        }, {
            name: 'toMonth'
        }, {
            name: 'year'
        }, {
            name: 'invoiceDate'
        }],
        sortInfo: {
            field:'invoiceID',
            direction:'ASC'
        }
    });

    aIStore.load({
        params:{
            start:0,
            limit:25
        }
    });

    // create the editor grid
    grid = new Ext.grid.EditorGridPanel({
        store: nOStore,
        stripeRows: true,
        cm: cm,
        listeners: {
        },
        height: 300,
        frame: true,
        loadMask: true,
        clicksToEdit: 1,
        tbar: [{
            text: 'Add School',
            iconCls: 'add',
            handler : function(){
                // access the Record constructor through the grid's store
                var RecordType = grid.getStore().recordType;
                var p = new RecordType({
                    orderDetailID: '0',
                    orderID:'0',
                    school: '',
                    g1: '',
                    g2: '',
                    g3: '',
                    g4: '',
                    challan:'',
                    challanDate: ''
                });
                grid.stopEditing();
                grid.getStore().insert(0, p);
                grid.startEditing(0, 0);
                grid.getView().refresh() ;
            }
        },{
            text: 'Delete School',
            iconCls: 'delete',
            handler : function(){
                deleteRow(grid,'','orderDetailID');
            }
        }]
    });

    editGrid = new Ext.grid.EditorGridPanel({
        store: editOrderStore,
        stripeRows: true,
        loadMask: true,
        cm: ecm,
        listeners: {
        },
        height: 300,
        frame: true,
        clicksToEdit: 1,
        tbar: [{
            text: 'Add School',
            iconCls: 'add',
            handler : function(){
                // access the Record constructor through the grid's store
                var RecordType = editGrid.getStore().recordType;
                var p = new RecordType({
                    orderDetailID: '0',
                    orderID:'0',
                    school: '',
                    g1: '',
                    g2: '',
                    g3: '',
                    g4: '',
                    challan:'',
                    challanDate: ''
                });

                editGrid.stopEditing();
                editGrid.getStore().insert(0, p);
                editGrid.startEditing(0, 0);
                editGrid.getView().refresh() ;
            }
        },{
            text: 'Delete School',
            iconCls: 'delete',
            handler : function(){
                deleteRow(editGrid,'delete/delete-orders-details.jsp','orderDetailID');
            }
        }]
    });

    //Grid End
    formPanel = new Ext.FormPanel({
        labelAlign: 'right',
        frame:true,
        //  title: 'Multi Column, Nested Layouts and Anchoring',
        //bodyStyle:'padding:5px 5px 0',
        layout:'fit',
        width: 600,
        items: [{
            layout:'column',
            items:[{
                columnWidth:.33,
                layout: 'form',
                items: [ { //    fields: ['ID', 'schoolMarathi'],
                    xtype:'combo',
                    store: monthStore,
                    allowBlank: false,
                    displayField : 'mm' ,
                    valueField: 'id',
                    mode :'local',
                    forceSelection : true,
                    triggerAction : 'all',
                    selectOnFocus :true,
                    editable:false,
                    name : 'from',
                    hiddenName : 'from',
                    fieldLabel: 'माहे',
                    anchor:'95%'
                }, {
                    xtype:'combo',
                    editable:false,
                    store: districtStore,
                    allowBlank: false,
                    forceSelection : true,
                    triggerAction : 'all',
                    selectOnFocus :true,
                    mode :'local',
                    displayField : 'districtMarathi' ,
                    valueField: 'districtID',
                    fieldLabel: 'जिल्हा',
                    name: 'district',
                    hiddenName : 'districtID',
                    anchor:'95%',
                    listeners: {
                        select : function(cmb,rec,idx) {
                            tCombo = Ext.getCmp('f-t-combo');
                            tCombo.clearValue();
                            talukaStore.load({
                                params:{
                                    districtID:this.getValue()
                                }
                            });
                        }
                    }
                }]
            },{
                columnWidth:.33,
                layout: 'form',
                items: [{
                    xtype:'combo',
                    store: monthStore1,
                    allowBlank: false,
                    displayField : 'mm' ,
                    valueField: 'id',
                    mode :'local',
                    forceSelection : true,
                    triggerAction : 'all',
                    selectOnFocus :true,
                    editable:false,
                    anchor:'95%',
                    hiddenName : 'to',
                    fieldLabel: 'ते माहे',
                    name: 'to'
                }, {
                    xtype:'combo',
                    id:'f-t-combo',
                    fieldLabel: 'तालुका',
                    forceSelection : true,
                    triggerAction : 'all',
                    selectOnFocus :true,
                    editable:false,
                    mode :'local',
                    store: talukaStore,
                    name: 'taluka',
                    hiddenName : 'talukaID',
                    displayField : 'talukaMarathi' ,
                    valueField: 'talukaID',
                    anchor:'95%',
                    listeners: {
                        select : function(cmb,rec,idx) {
                            tCombo = Ext.getCmp('f-s-combo');
                            tCombo.clearValue();
                            sectionStore.load({
                                params:{
                                    talukaID:this.getValue()
                                }
                            });
                        }
                    }
                }]
            },{
                columnWidth:.33,
                layout: 'form',
                items: [{
                    xtype:'combo',
                    editable:false,
                    store: ['2009','2010', '2011','2012','2013','2014'],
                    fieldLabel: 'वषे',
                    name: 'year',
                    hiddenName : 'year',
                    anchor:'95%'
                }, {
                    xtype:'combo',
                    id: 'f-s-combo',
                    fieldLabel: 'विभाग',
                    displayField : 'sectionMarathi' ,
                    valueField: 'sectionID',
                    forceSelection : true,
                    triggerAction : 'all',
                    selectOnFocus :true,
                    editable:false,
                    store: sectionStore,
                    mode :'local',
                    name: 'section',
                    hiddenName : 'section',
                    anchor:'95%',
                    listeners: {
                        select : function(cmb,rec,idx) {
                            tCombo = Ext.getCmp('cm-school');
                            tCombo.clearValue();
                            tCombo.setValue('');
                            tCombo.store.removeAll();
                            tCombo.store.load({
                                params:{
                                    sectionID:this.getValue()
                                }
                            });
                            tCombo.enable();
                        }
                    }

                }]
            }]
        }]
    });

    fillOrderWindow = function (){
        if(!win){
            win = new Ext.Window({
                layout:'fit',
                width:1000,
                modal: true,
                height:500,
                iconCls: 'add',
                closeAction:'hide',
                title : "New Order",
                plain: true,
                items : [
                {
                    layout :"border",
                    items :[
                    {
                        region:"center",
                        layout:'fit',
                        //bodyStyle: 'padding:5px;',
                        items:[formPanel]
                    },
                    {
                        region:"south",
                        bodyStyle: 'padding:0px;',
                        layout: "fit",
                        height:350,
                        items:[grid]
                    }
                    ]
                },
                ],
                buttons: [{
                    text: 'Save Order',
                    handler: function(){
                        var records = grid.getStore().getModifiedRecords();
                        var changedArray = "{'data':[";
                        for(var j=0;j<records.length;j++){
                            var rec = records[j];
                            //if(rec.get('school').length!==0){
                            changedArray = changedArray.concat(Ext.util.JSON.encode(rec.data));
                            if(j!==(records.length-1)){
                                changedArray = changedArray.concat(',');
                            }
                        //}
                        }
                        changedArray = changedArray.concat("]}");
                        formPanel.getForm().submit({
                            url: 'create/save-order.jsp',
                            params: {
                                orderDetails: changedArray
                            },
                            method: 'POST',
                            success: function(form, action){
                                aOStore.load({
                                    params:{
                                        start:0,
                                        limit:25
                                    }
                                });
                                Ext.Msg.hide();
                                formPanel.getForm().reset();
                                grid.getStore().removeAll();
                                win.hide();

                                Ext.Msg.alert('Success', 'Order Saved');
                            },
                            failure: function(form, action){
                                Ext.Msg.alert('Warning', 'Error');

                            }
                        });
                        Ext.Msg.wait('Saving order...','Please wait!');

                    }
                }, {
                    text: 'Cacel Order',
                    handler: function(){
                        formPanel.getForm().reset();
                    }
                }]
            });
        }
        
        var sm = orderSectionsGrid.getSelectionModel();
        var sel = sm.getSelections();
        if(sel.length == 0) {
            Ext.Msg.alert('Select Section', 'No secti is selected!');
            return;
        }
        var oID = sel[0].get('orderID');
        var sID = sel[0].get('sectionID');
        grid.getForm().load({
            waitMsg:'Loading...',
            params:{
                orderID:oID,sectionID:sID
            }
        }); //,
       // editGrid.getStore().removeAll();

     
        win.show(this);
    };
    //Grid End
    eFormPanel = new Ext.FormPanel({
        labelAlign: 'right',
        frame:true,
        loadMask: true,
        autoLoad : false,
        url : 'read/get-order.jsp',
        layout:'fit',
        width: 600,
        items: [{
            layout:'column',
            items:[{
                columnWidth:.33,
                layout: 'form',
                items: [ { //    fields: ['ID', 'schoolMarathi'],
                    xtype:'textfield',
                    id :  'e-from',
                    disabled:true,
                    name : 'from',
                    fieldLabel: 'माहे',
                    anchor:'95%'
                }, {
                    xtype:'textfield',
                    id :  'e-district',
                    disabled:true,
                    fieldLabel: 'जिल्हा',
                    name: 'district',
                    anchor:'95%'
                }]
            },{
                columnWidth:.33,
                layout: 'form',
                items: [{
                    xtype:'textfield',
                    id :  'e-to',
                    disabled:true,
                    anchor:'95%',
                    fieldLabel: 'ते माहे',
                    name: 'to'
                }, {
                    xtype:'textfield',
                    id :  'e-t-combo',
                    fieldLabel: 'तालुका',
                    disabled:true,
                    name: 'taluka',
                    anchor:'95%'
                }]
            },{
                columnWidth:.33,
                layout: 'form',
                items: [{
                    xtype:'textfield',
                    id :  'e-year',
                    disabled:true,
                    fieldLabel: 'वषे',
                    name: 'year',
                    anchor:'95%'
                }, {
                    xtype:'textfield',
                    id : 'e-s-combo',
                    fieldLabel: 'विभाग',
                    disabled:true,
                    name: 'section',
                    anchor:'95%'
                },
                {
                    xtype:'hidden',
                    name:'orderID',
                    hiddenName : 'orderID'
                } ]
            }]
        }]
    });
    editWindow = function (){
        if(!ewin){
            ewin = new Ext.Window({
                layout:'fit',
                width:1000,
                modal: true,
                height:500,
                iconCls: 'add',
                closeAction:'hide',
                title : "Edit Order",
                plain: true,
                items : [
                {
                    layout :"border",
                    items :[{
                        region:"center",
                        layout:'fit',
                        //bodyStyle: 'padding:5px;',
                        items:[eFormPanel]
                    },
                    {
                        region:"south",
                        bodyStyle: 'padding:0px;',
                        layout: "fit",
                        height:350,
                        items:[editGrid]
                    }
                    ]
                },
                ],
                buttons: [{
                    text: 'Save Order',
                    handler: function(){
                        var records = editGrid.getStore().getModifiedRecords();
                        var changedArray = "{'data':[";
                        arr = new Array(records.length);
                        for(var j=0;j<records.length;j++){
                            var rec = records[j];
                            //if(rec.get('school').length!==0){
                            changedArray = changedArray.concat(Ext.util.JSON.encode(rec.data));
                            if(j!==(records.length-1)){
                                changedArray = changedArray.concat(',');
                            }
                        }
                        changedArray = changedArray.concat("]}");
                        eFormPanel.getForm().submit({
                            url: 'update/update-order.jsp',
                            params: {
                                orderDetails: changedArray
                            },
                            method: 'POST',
                            success: function(form, action){
                                Ext.Msg.hide();
                                eFormPanel.getForm().reset();
                                editGrid.getStore().removeAll();
                                ewin.hide();

                                Ext.Msg.alert('Success', 'Order Saved');
                            },
                            failure: function(form, action){
                                Ext.Msg.alert('Warning', 'Error');

                            }
                        });
                        Ext.Msg.wait('Saving order...','Please wait!');

                    }
                }, {
                    text: 'Cacel Order',
                    handler: function(){
                        eFormPanel.getForm().reset();
                    }
                }]
            });
        }
        var sm = orderGrid.getSelectionModel();
        var sel = sm.getSelections();
        if(sel.length == 0) {
            Ext.Msg.alert('Select Order', 'No order is selected!');
            return
        };
        var id = sel[0].get('orderID');
        eFormPanel.getForm().load({
            waitMsg:'Loading...',
            params:{
                orderID:id
            }
        }); //,
        editGrid.getStore().removeAll();

        for(var k=0;k<50;k++){}
        var section = sel[0].get('section');
        ewin.setTitle('Editing Order - ' +id);
        schoolStore.load({
            params:{
                sectionID:section
            }
        });
        for(var k=0;k<50;k++){}
        editGrid.getStore().load({
            method:'POST',
            waitMsg:'Loading...',
            params:{
                orderID:id
            }
        });
        editGrid.startEditing(0, 0);
        ewin.show();
    };

    function printOrder() {
        var sm = orderGrid.getSelectionModel();
        var sel = sm.getSelections();
        var data =  '';
        if(sel.length == 0){
            Ext.Msg.alert('Select Order', 'No order is selected!');
            return
        };
        data = sel[0].get('orderID');
        var param = data;
        window.open("reports/section-report-by-id.jsp?orderID="+param,'mywin',"width=1500,height=800,top=40,left=60,menubar=1,resizable=0,location=1,scrollbars=1");
    }

    function printBill() {
        var sm = invoiceGrid.getSelectionModel();
        var sel = sm.getSelections();
        var data =  '';
        if(sel.length == 0){
            Ext.Msg.alert('Select Bill', 'No bill is selected!');
            return
        }
        data = sel[0].get('invoiceID');
        var param = data;
        window.open("reports/print-invoice.jsp?invoiceID="+param,'invoicewin',"width=1500,height=800,top=40,left=60,menubar=1,resizable=0,location=1,scrollbars=1");
    }

    function printAllChallanOrder(){
        var sm = orderGrid.getSelectionModel();
        var sel = sm.getSelections();
        var data =  '';
        if(sel.length == 0){
            Ext.Msg.alert('Select Order', 'No order is selected!');
            return
        };
        data = sel[0].get('orderID');
        var param = data;
        window.open("reports/print-all-challan.jsp?orderID="+param,'mywin',"width=1500,height=800,top=40,left=60,menubar=1,resizable=0,location=1,scrollbars=1");
    }

    function deleteOrders() {
        Ext.Msg.show({
            title: 'Confirm',
            msg: 'Delete Selected Orders?',
            buttons: Ext.Msg.YESNO,
            fn: function(btn) {
                if (btn == 'yes') {
                    var sm = orderGrid.getSelectionModel();
                    var sel = sm.getSelections();
                    var data =  '';
                    if(sel.length == 0){
                        Ext.Msg.alert('Select Order', 'No order is selected!');
                        return
                    };
                    for (var i = 0; i<sel.length; i++) {
                        data = data + sel[i].get('orderID');
                        if(i!==(sel.length-1)){
                            data = data.concat(',');
                        }
                    }
                    Ext.Ajax.request({
                        url: 'delete/delete-orders.jsp',
                        method: 'POST',
                        params: {
                            postdata: data
                        },
                        success: function(resp,opt) {
                            Ext.Msg.hide();
                            aOStore.load({
                                params:{
                                    start:0,
                                    limit:25
                                }
                            });
                        //Ext.Msg.alert('Deletion', 'Order has removed permanently!');
                        },
                        failure: function(resp,opt) {
                            Ext.Msg.hide();
                            Ext.Msg.alert('Error', 'Error in deleting!');
                        }
                    });
                    Ext.Msg.wait('Deleting...','Please wait');

                }
            }
        });
    }

    function deleteRow(workingGrid,deleteUrl,deleteIDKey) {
        Ext.Msg.show({
            title: 'Confirm',
            msg: 'Delete Selected Rows?',
            buttons: Ext.Msg.YESNO,
            fn: function(btn) {
                if (btn == 'yes') {
                    var data = workingGrid.getSelectionModel().selection.record.get(deleteIDKey);
                    if(!data){
                        Ext.Msg.alert('Select Row', 'No row is selected!');
                        return
                    }
                    workingGrid.stopEditing();
                    workingGrid.getStore().remove(workingGrid.getSelectionModel().selection.record);
                    workingGrid.getView().refresh() ;

                    if(deleteUrl && deleteUrl.length != 0 && data != 0){
                        Ext.Ajax.request({
                            url: deleteUrl,
                            method: 'POST',
                            params: {
                                postdata: data
                            },
                            success: function(resp,opt) {
                                Ext.Msg.hide();
                                workingGrid.getStore().reload();
                            },
                            failure: function(resp,opt) {
                                Ext.Msg.hide();
                                Ext.Msg.alert('Error', 'Error in deleting!');
                            }
                        });
                        Ext.Msg.wait('Deleting order...','Deleting');

                    }

                }
            }
        });
    }

    invoiceGrid = new Ext.grid.GridPanel({
        store: aIStore,
        stripeRows: true,
        loadMask: true,
        stateful: true,
        iconCls: 'inv',
        stateId: 'sgrid1',
        tbar: [{
            iconCls: 'add',
            text: 'New Bill',
            handler: function(){
                searchSectionWin('reports/verify-dups-invoices.jsp',"Invoice");
            }
        }, '-',{
            iconCls: 'edit',
            text: 'Print Bill',
            handler: function(){
                printBill();
            }

        }, '->',{
            ref: '../removeBtn',
            iconCls: 'delete',
            text: 'Delete Bill',
            //disabled: true,
            handler: deleteOrders
        }],
        columns: [new Ext.grid.RowNumberer(),{
            header: '<b>बिल क्र.</b>',
            width: 60,
            sortable: true,
            dataIndex: 'invoiceID',
            align: 'right'
        }, {
            header: 'बिल दिनांक',
            width: 120,
            sortable: true,
            dataIndex: 'invoiceDate',
            align: 'right'
        },{
            header: 'तालुका',
            width: 120,
            sortable: true,
            dataIndex: 'taluka',
            align: 'left'
        }
        , {
            header: 'माहे',
            width: 120,
            sortable: true,
            //renderer: change,
            dataIndex: 'fromMonth',
            align: 'left'
        }, {
            header: 'ते माहे',
            width: 60,
            sortable: true,
            // renderer: pctChange,
            dataIndex: 'toMonth',
            align: 'left'
        }, {
            header: 'वर्षे',
            width: 50,
            sortable: true,
            //renderer: pctChange,
            dataIndex: 'year',
            align: 'right'
        },{
            header: 'एकूण रक्कम',
            width: 120,
            sortable: true,
            dataIndex: 'total',
            align: 'left'
        }, {
            header: 'एकूण रक्कम अक्षरी',
            width: 300,
            sortable: true,
            //renderer: change,
            dataIndex: 'totalMarathi',
            align: 'left'
        }],
        height: 500,
        width: 700,
        // paging bar on the bottom
        bbar: new Ext.PagingToolbar({
            pageSize: 25,
            store: aIStore,
            displayInfo: true,
            displayMsg: 'Displaying topics {0} - {1} of {2}',
            emptyMsg: "No topics to display",
            items:[
            '-', {
                pressed: true,
                enableToggle:true,
                text: 'Show Preview',
                cls: 'x-btn-text-icon details',
                toggleHandler: function(btn, pressed){
                    var view = grid.getView();
                    view.showPreview = pressed;
                    view.refresh();
                }
            }]
        })


    });

    // create the Grid
    orderGrid = new Ext.grid.GridPanel({
        store: aOStore,
        stripeRows: true,
        loadMask: true,
        stateful: true,
        iconCls: 'inv',
        stateId: 'sgrid',
        tbar: [{
            iconCls: 'add',
            text: 'New Order',
            handler: function(){
                orderWindow();
            }
        }, '-',{
            iconCls: 'edit',
            text: 'Edit Order',
            handler: function(){
                editWindow();
            }
        }, '-',{
            iconCls: 'edit',
            text: 'Print Order',
            handler: function(){
                printOrder();
            }

        }, '-',{
            iconCls: 'edit',
            text: 'Print All Challan',
            handler: function(){
                printAllChallanOrder();
            }

        }, '->',{
            ref: '../removeBtn',
            iconCls: 'delete',
            text: 'Delete Order',
            //disabled: true,
            handler: deleteOrders
        }],

        columns: [new Ext.grid.RowNumberer(),{
            header: '<b>ऑर्डर क्र.</b>',
            width: 60,
            sortable: true,
            dataIndex: 'orderID',
            align: 'right'
        }, {
            header: 'जिल्हा',
            width: 120,
            sortable: true,
            //renderer: change,
            dataIndex: 'district',
            align: 'left'
        },{
            header: 'तालुका',
            width: 120,
            sortable: true,
            // renderer: change,
            dataIndex: 'taluka',
            align: 'left'
        }, {
            header: 'विभाग',
            width: 120,
            sortable: true,
            // renderer: pctChange,
            dataIndex: 'section',
            align: 'left'
        }
        , {
            header: 'माहे',
            width: 120,
            sortable: true,
            //renderer: change,
            dataIndex: 'from',
            align: 'left'
        }, {
            header: 'ते माहे',
            width: 120,
            sortable: true,
            // renderer: pctChange,
            dataIndex: 'to',
            align: 'left'
        }, {
            header: 'वर्षे',
            width: 50,
            sortable: true,
            //renderer: pctChange,
            dataIndex: 'year',
            align: 'right'
        }],
        height: 500,
        width: 700,
        // paging bar on the bottom
        bbar: new Ext.PagingToolbar({
            pageSize: 25,
            store: aOStore,
            displayInfo: true,
            displayMsg: 'Displaying topics {0} - {1} of {2}',
            emptyMsg: "No topics to display",
            items:[
            '-', {
                pressed: true,
                enableToggle:true,
                text: 'Show Preview',
                cls: 'x-btn-text-icon details',
                toggleHandler: function(btn, pressed){
                    var view = grid.getView();
                    view.showPreview = pressed;
                    view.refresh();
                }
            }]
        })


    });




    function change(val){
        if (val > 0) {
            return '<span style="color:green;">' + val + '</span>';
        }
        else
        if (val < 0) {
            return '<span style="color:red;">' + val + '</span>';
        }
        return val;
    }



    //    var searchResult = new Ext.grid.GridPanel({
    //        cm: cm1,
    //        store: store,
    //        stripeRows: true,
    //        height: 350,
    //        stateful: true
    //    });

    searchSectionCriteria = new Ext.FormPanel({
        labelAlign: 'right',
        frame:true,
        id: 's-form',
        autoDestroy : true,
        layout:'fit',
        buttonAlign: 'center',
        items: [{
            layout:'column',
            items:[{
                columnWidth:.33,
                layout: 'form',
                items: [{
                    xtype:'combo',
                    id:'s-from-combo',
                    store: monthStore,
                    allowBlank: false,
                    displayField : 'mm' ,
                    valueField: 'id',
                    mode :'local',
                    forceSelection : true,
                    triggerAction : 'all',
                    selectOnFocus :true,
                    editable:false,
                    name : 'from',
                    hiddenName : 'from',
                    fieldLabel: 'माहे',
                    anchor:'95%'
                }, {
                    xtype:'combo',
                    editable:false,
                    id:'s-ds-combo',
                    store: districtStore,
                    allowBlank: false,
                    forceSelection : true,
                    triggerAction : 'all',
                    selectOnFocus :true,
                    mode :'local',
                    displayField : 'districtMarathi' ,
                    valueField: 'districtID',
                    fieldLabel: 'जिल्हा',
                    name: 'district',
                    hiddenName : 'districtID',
                    anchor:'95%',
                    listeners: {
                        select : function(cmb,rec,idx) {
                            tCombo = Ext.getCmp('s-form-combo');
                            tCombo.clearValue();
                            talukaStore.load({
                                params:{
                                    districtID:this.getValue()
                                }
                            });
                        }
                    }
                }]
            },{
                columnWidth:.33,
                layout: 'form',
                items: [{
                    xtype:'combo',
                    store: monthStore1,
                    id:'s-to-combo',
                    allowBlank: false,
                    displayField : 'mm' ,
                    valueField: 'id',
                    mode :'local',
                    forceSelection : true,
                    triggerAction : 'all',
                    selectOnFocus :true,
                    editable:false,
                    anchor:'95%',
                    hiddenName : 'to',
                    fieldLabel: 'ते माहे',
                    name: 'to'
                }, {
                    xtype:'combo',
                    id: 's-form-combo',
                    fieldLabel: 'तालुका',
                    forceSelection : true,
                    triggerAction : 'all',
                    selectOnFocus :true,
                    editable:false,
                    mode :'local',
                    store: talukaStore,
                    name: 'taluka',
                    hiddenName : 'talukaID',
                    displayField : 'talukaMarathi' ,
                    valueField: 'talukaID',
                    anchor:'95%',
                    listeners: {
                        select : function(cmb,rec,idx) {
                            tCombo = Ext.getCmp('s-s-combo');
                            tCombo.clearValue();
                            sectionStore.load({
                                params:{
                                    talukaID:this.getValue()
                                }
                            });
                        }
                    }
                }]
            },{
                columnWidth:.33,
                layout: 'form',
                items: [{
                    xtype:'combo',
                    id : 's-yr-combo',
                    editable:false,
                    store: ['2009','2010', '2011','2012','2013','2014'],
                    fieldLabel: 'वषे',
                    name: 'year',
                    hiddenName : 'year',
                    anchor:'95%'
                }, {
                    xtype:'combo',
                    id: 's-s-combo',
                    fieldLabel: 'विभाग',
                    displayField : 'sectionMarathi' ,
                    valueField: 'sectionID',
                    forceSelection : true,
                    triggerAction : 'all',
                    selectOnFocus :true,
                    editable:false,
                    store: sectionStore,
                    mode :'local',
                    name: 'section',
                    hiddenName : 'section',
                    anchor:'95%'
                }]
            }]
        }],
        buttons: [{
            text: 'Search',
            scale: 'medium',
            handler: function(){
                var sfc= Ext.getCmp('s-from-combo').getValue();
                var stc = Ext.getCmp('s-to-combo').getValue();
                var yr = Ext.getCmp('s-yr-combo').getValue();
                var ds = Ext.getCmp('s-ds-combo').getValue();
                var tl = Ext.getCmp('s-form-combo').getValue();
                var ss = Ext.getCmp('s-s-combo').getValue();
                var param = "from="+sfc+"&to="+stc+"&year="+yr+"&district="+ds+"&taluka="+tl+"&section="+ss;
                window.open(SUBMIT_URL+"?"+param,'mywin',"width=1500,height=800,top=40,left=60,menubar=1,resizable=0,location=1,scrollbars=1");
            }
        },{
            text: 'Clear',
            scale: 'medium',
            handler: function(){}
        }]
    });

    var wn;
    searchSectionWin = function(submitURL, winTitle){
        SUBMIT_URL = submitURL;

        var tit = ("Enter " +winTitle + " Criteria");
        // if(!wn){
        wn = new Ext.Window({
            layout:'fit',
            width:800,
            modal: true,
            height:160,
            iconCls: 'add',
            closeAction:'hide',
            title : tit,
            plain: true,
            items : [
            {
                layout :"border",
                items :[{
                    region:"center",
                    layout:'fit',
                    items:[searchSectionCriteria]
                }
                ]
            },
            ]
        });
        searchSectionCriteria.getForm().reset();
        wn.show(this);
    };
    
    viewport = new Ext.Viewport({
        layout: 'border',
        bodyStyle: 'padding:5px;',
        items: [{
            region: 'west',
            id: 'west-panel',
            split: true,
            width: 170,
            maxSize: 170,
            collapsible: false,
            margins: '0 0 0 5',
            layout: {
                type: 'accordion',
                animate: true
            },
            items: [{
                contentEl: 'west',
                title: 'ऑर्डर',
                border: false,
                iconCls: 'nav'
            }, {
                title: 'गोषवारा',
                contentEl: 'west2',
                border: false,
                iconCls: 'settings'
            }, {
                title: 'बिल्स',
                contentEl: 'west3',
                border: false,
                iconCls: 'settings'
            }, {
                title: 'बिल्टी',
                contentEl: 'west4',
                border: false,
                iconCls: 'settings'
            }]
        } ,
        new Ext.BoxComponent({
            region: 'north',
            height: 50,
            contentEl: 'el1'
        }), new Ext.TabPanel({
            region: 'center',
            deferredRender: false,
            autoScroll: true,
            bodyStyle: 'padding:5px;',
            id: "center-tab-panel",
            activeTab: 1,
            items: [{
                title: 'सर्व ऑर्डर ',
                iconCls: 'home',
                autoScroll: true,
                id: "home-tab",
                layout: 'border',
                items: [{
                    region: "center",
                    bodyStyle: 'padding:5px;',
                    layout: "fit",
                    items: [orderGrid]
                }]
            },{
                title: 'सर्व बिल्स',
                iconCls: 'home',
                autoScroll: true,
                id: "home-tab3",
                layout: 'border',
                items: [{
                    region: "center",
                    bodyStyle: 'padding:5px;',
                    layout: "fit",
                    items :  invoiceGrid
                }]
            }]
        })]
    });

    Ext.EventManager.addListener("n-o", 'click', orderWindow);
    sr = function () {
        searchSectionWin('reports/section-report.jsp',"Section Report");
    };
    Ext.EventManager.addListener("s-r", 'click',sr );
    tr = function () {
        searchSectionWin('reports/taluka-report.jsp',"Taluka Report");
    };
    Ext.EventManager.addListener("t-r", 'click', tr);
    tlr = function () {
        searchSectionWin('reports/taluka-loading-report.jsp',"Taluka Loading Report");
    };
    Ext.EventManager.addListener("t-l-r",'click', tlr);
    dr = function () {
        searchSectionWin('reports/district-report.jsp',"District Report");
    };
    Ext.EventManager.addListener("d-r", 'click', dr);
    bb = function () {
        searchSectionWin('reports/verify-dups-invoices.jsp',"Invoice");
    };
    Ext.EventManager.addListener("b-b", 'click', bb);
});
