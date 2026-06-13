var selectedOrderID;
var govOrder;
var talukaMarathi;

Ext.onReady(function(){
    Ext.state.Manager.setProvider(new Ext.state.CookieProvider());
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



    aIStore= new Ext.data.JsonStore({
        autoDestroy: true,
        autoLoad : true,      
        storeId: 'aIStore',
        url: 'read/get-all-invoices.jsp',
        root: 'root',
        idProperty : 'invoiceID',
        fields: [{
            name: 'invoiceID'
        },{
            name: 'orderID'
        },{
            name: 'govOrderID'
        }, {
            name: 'district'
        },{
            name: 'taluka'
        },{
            name: 'total'
        },{
            name: 'creationDate'
        },{
            name: 'orderDate'
        }],
        sortInfo: {
            field:'invoiceID',
            direction:'ASC'
        }
    });
    
    invoiceGrid = new Ext.grid.GridPanel({
        store: aIStore,
        stripeRows: true,
        loadMask: true,
        stateful: true,
        iconCls: 'inv',
        stateId: 'sgrid1',
        tbar: [{
            iconCls: 'printer',
            text: 'Print Bill',
            handler: function(){
                var sm = invoiceGrid.getSelectionModel();
                var sel = sm.getSelections();                
                if(sel.length == 0){
                    Ext.Msg.alert('Select Bill', 'No bill is selected!');
                    return;
                }
                var invoiceID = sel[0].get('invoiceID');
                var orderID = sel[0].get('orderID');                
                window.open("reports/print-invoice.jsp?invoiceID="+invoiceID+"&orderID="+orderID ,'invoicewin',"width=1500,height=800,top=40,left=60,menubar=1,resizable=0,location=0,scrollbars=1");
            }
        }/*, '-',{
            xtype: 'textfield',emptyText: 'Invoice ID '
        }, '-',{
            xtype: 'textfield'
        }*/, '->',{
            ref: '../removeBtn',
            iconCls: 'delete',
            text: 'Delete Bill'
        }],
        columns: [new Ext.grid.RowNumberer(),{
            header: '<b>बिल क्र.</b>',
            width: 60,
            sortable: true,
            dataIndex: 'invoiceID',
            align: 'center'
        }, {
            header: 'बिल दिनांक',
            width: 120,
            sortable: true,
            dataIndex: 'creationDate',
            align: 'center'
        },
        {
            header: 'ऑर्डर क्र.',
            width: 120,
            sortable: true,
            dataIndex: 'govOrderID',
            align: 'center'
        },{
            header: 'तालुका',
            width: 120,
            sortable: true,
            dataIndex: 'taluka',
            align: 'center'
        },{
            header: 'जिल्हा',
            width: 120,
            sortable: true,
            dataIndex: 'district',
            align: 'center'
        },{
            header: 'एकूण रक्कम',
            width: 120,
            sortable: true,
            dataIndex: 'total',
            align: 'center'
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

    // define a custom summary function
    Ext.ux.grid.GroupSummary.Calculations['totalCost'] = function(v, record, field){
        return v;// + (record.data.estimate * record.data.rate);
    };

     var prodGridSummary = new Ext.ux.grid.GridSummary();
     var talukaGridSummary = new Ext.ux.grid.GridSummary();

    var summary = new Ext.ux.grid.GroupSummary();

    var reader = new Ext.data.JsonReader({
        idProperty: 'productionID',
        root: 'root',
        fields: [{
            name: 'batchID'

        },{
            name: 'batchName'
        },{
            name: 'batchNumber'
        },{
            name: 'creationDate'
        },{
            name: 'production'

        },{
            name: 'productionID'
        },{
            name: 'shift'
        }],
        sortInfo: {
            field:'productionID',
            direction:'ASC'
        }

    });


    prodStore= new Ext.data.GroupingStore({
        reader : reader,
        autoDestroy: true,
        groupField: 'batchName',
        autoLoad : true,
        storeId: 'stockStore',
        url: 'read/get-production.jsp'  ,
        sortInfo: {
            field:'productionID',
            direction:'ASC'
        }
        
    });    

    prodGrid = new Ext.grid.EditorGridPanel({
        store: prodStore,
        stripeRows: true,
        loadMask: true,
        stateful: true,
        iconCls: 'inv',
        stateId: 'prodGrid',
        tbar : [{
            iconCls: 'add',
            text: 'Add Produdction',
            handler: function(){
                //open new batch form
                //batch master drop down, create new batch incremet the count
                openAddProductionWin();
            }
        },{
            text: 'Toggle Summary',
            tooltip: 'Toggle the visibility of summary row',
            handler: function(){
                summary.toggleSummaries();
            }
        }],
        columns: [new Ext.grid.RowNumberer(),{
            header: '<b>Transaction ID</b>',
            width: 80,
            sortable: true,
            dataIndex: 'productionID',
            summaryType: 'count',
            hideable: false,
            summaryRenderer: function(v, params, data){
                return ((v === 0 || v > 1) ? 'Batch updated ' + v +' times -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>Total > </b>' : '(1 Task)');
            },
            align: 'center'
        },
        {
            header: 'Batch',
            width: 120,
            sortable: true,
            dataIndex: 'batchName',
            align: 'center'
        },
        {
            header: 'Shift',
            width: 120,
            sortable: true,
            dataIndex: 'shift',
            align: 'center'
        },
        {
            header: 'Updated On',
            width: 120,
            sortable: true,
            dataIndex: 'creationDate',         
            align: 'center'
        },
        {
            header: 'Production(tons)',
            width: 120,
            sortable: true,
            dataIndex: 'production',
            summaryType: 'sum',
            align: 'center'
        }],
        height: 500,
        width: 700,
        view: new Ext.grid.GroupingView({
            forceFit: true,
            showGroupName: true,
            enableNoGroups: false,
            enableGroupingMenu: true,
            hideGroupedColumn: true
        }),

        plugins: summary,
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


    batchMatrixStore= new Ext.data.JsonStore({
        autoDestroy: true,
        // autoLoad : true,
        storeId: 'batchMatrixStore',
        url: 'read/get-all-matrices.jsp',
        root: 'root',
        idProperty : 'ID',
        fields: [{
            name: 'ID'
        },{
            name: 'batchName'
        }],
        sortInfo: {
            field:'ID',
            direction:'ASC'
        }
    });

    allBatchesStore= new Ext.data.JsonStore({
        autoDestroy: true,
        autoLoad : true,
        storeId: 'allBatchesStore',
        url: 'read/get-all-batches.jsp',
        root: 'root',
        idProperty : 'batchID',
        fields: [{
            name: 'batchID'
        },{
            name: 'batchNumber'
        },{
            name: 'batchName'
        }, {
            name: 'creationDate'
        }],
        sortInfo: {
            field:'batchID',
            direction:'DESC'
        }
    });

    allBatchesGrid = new Ext.grid.GridPanel({
        store: allBatchesStore,
        stripeRows: true,
        loadMask: true,
        stateful: true,
        iconCls: 'inv',
        stateId: 'allBatchesGrid',
        tbar: [{
            iconCls: 'add',
            text: 'New Batch',
            handler: function(){
                //open new batch form
                //batch master drop down, create new batch incremet the count
                openNewBatchWin();
            }
        },{
            iconCls: 'add',
            text: 'Add Produdction',
            handler: function(){
                //open new batch form
                //batch master drop down, create new batch incremet the count
                openAddProductionWin();
            }
        }],
        columns: [new Ext.grid.RowNumberer(),{
            header: '<b>Batch Type</b>',
            width: 60,
            sortable: true,
            dataIndex: 'batchName',
            align: 'center'
        }, 
        {
            header: 'Created On',
            width: 120,
            sortable: true,
            dataIndex: 'creationDate',
            align: 'center'
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

    //get-production-summary-by-batch

    prodSummary = new Ext.data.JsonStore({
        autoDestroy: true,
        autoLoad : true,
        storeId: 'prodSummary',
        url: 'read/get-production-summary-by-batch.jsp',
        root: 'root',
        idProperty : 'batchID',
        fields: [{
            name: 'batchID'
        },{
            name: 'batchName'
        }, {
            name: 'batchNumber'
        },{
            name: 'creationDate'
        },{
            name: 'production'
        },{
            name: 'dispatched'
        },{
            name: 'currentStock'
        }],
        sortInfo: {
            field:'batchID',
            direction:'DESC'
        }
    });

    fromProductionBatchesGrid = new Ext.grid.GridPanel({
        ddGroup          : 'secondGridDDGroup',
        enableDragDrop   : true,        
        store: prodSummary,
        stripeRows: true,
        loadMask: true,
        stateful: true,
        iconCls: 'inv',
        stateId: 'fromProductionBatchesGrid',
       
        columns: [new Ext.grid.RowNumberer(),{
            header: '<b>Batch</b>',
            width: 100,
            sortable: true,
            dataIndex: 'batchName',
            align: 'center'
        },
        {
            header: 'Production(tons)',
            width: 120,
            sortable: true,
            dataIndex: 'production',
            align: 'center'
        },
        {
            header: 'Dispatch(tons)',
            width: 120,
            sortable: true,
            dataIndex: 'dispatched',
            align: 'center'
        },
        {
            header: 'Current Stock(tons)',
            width: 120,
            sortable: true,
            dataIndex: 'currentStock',
            align: 'center'
        }]
        
    });
    
    emptyBatchesStore= new Ext.data.JsonStore({

        storeId: 'emptyBatchesStore',
        root: 'root',
        idProperty : 'batchID',
        fields: [{
            name: 'batchID'
        },{
            name: 'batchName'
        }, {
            name: 'batchNumber'
        },{
            name: 'creationDate'
        },{
            name: 'production'
        },{
            name: 'dispatched'
        },{
            name: 'currentStock'
        }]
    });

    toProductionBatchesGrid = new Ext.grid.GridPanel({
        store: emptyBatchesStore,
        enableDragDrop   : true,
        autoScroll: true,
        ddGroup        : 'firstGridDDGroup',
        stripeRows: true,
        loadMask: true,
        stateful: true,
        iconCls: 'inv',
        stateId: 'toProductionBatchesGrid',

        plugins : prodGridSummary,

        columns: [new Ext.grid.RowNumberer(),{
            header: '<b>Batch</b>',
            width:120,
            sortable: true,
            dataIndex: 'batchName',
            align: 'center',
            summaryType: 'count', 
            summaryRenderer: function(v, params, data){
             params.attr = 'ext:qtip="Stock Summary"'; // summary column tooltip example
            return v? ((v === 0 || v > 1) ? '(' + v +' Batches) &nbsp;Total >' : '( 1 Batch)&nbsp;Total >') : '';
            }

        },
        {
            header: 'Production(tons)',
            width: 120,
            sortable: true,
            dataIndex: 'production',summaryType: 'sum',
            align: 'center'
        },
        {
            header: 'Dispatch(tons)',
            width: 120,
            sortable: true,
            dataIndex: 'dispatched',summaryType: 'sum',
            align: 'center'
        },
        {
            header: 'Current Stock(tons)',
            width: 120,
            sortable: true,
            dataIndex: 'currentStock',summaryType: 'sum',
            align: 'center'
        }]

    });


    allTalukaOrderStore= new Ext.data.JsonStore({
        autoDestroy: true,
        autoLoad : true,
        storeId: 'allTalukaOrderStore',
        url: 'read/get-all-json-taluka-orders.jsp',
        root: 'root',
        idProperty : 'orderID',
        fields: [{
            name: 'orderID'
        },{
            name: 'govOrderID'
        },{
            name: 'sattu1170'
        }, {
            name: 'shira936'
        }, {
            name: 'upma880'
        }, {
            name: 'sukadi1170'
        }, {
            name: 'shira1120'
        }, {
            name: 'upma1040'
        }, {
            name: 'shiraXtra1500'
        }],
        sortInfo: {
            field:'orderID',
            direction:'DESC'
        }
    });



    fromTalukaOrderGrid = new Ext.grid.GridPanel({
        ddGroup          : 'fourthGridDDGroup',
        enableDragDrop   : true,
        store: allTalukaOrderStore,
        stripeRows: true,
        loadMask: true,
        stateful: true,
        iconCls: 'inv',
        stateId: 'fromTalukaOrderGrid',

        tbar:[ '-',{

                    text : 'Reset',
                    width : 50
             },'-',{
                    xtype : 'combo',
                    emptyText : 'Select Godown',
                    width : 200,
                    store : allTalukaOrderStore
             }],

        columns: [new Ext.grid.RowNumberer(),
        {
            header: '<b>Taluka Order</b>',
            width: 80,
            sortable: true,
            dataIndex: 'govOrderID',
            align: 'center'
        },

        {
            header: 'सतु ११७०',
            width: 60,
            sortable: true,
            dataIndex: 'sattu1170',
            align: 'center'
        },

        {
            header: 'शिरा ९३६',
            width: 60,
            sortable: true,
            dataIndex: 'shira936',
            align: 'center'
        },
        {
            header: 'उपमा ८८०',
            width: 60,
            sortable: true,
            dataIndex: 'upma880',
            align: 'center'
        },
        {
            header: 'सुकडी ११७०',
            width: 70,
            sortable: true,
            dataIndex: 'sukadi1170',
            align: 'center'
        },
        {
            header: 'शिरा ११२०',
            width: 60,
            sortable: true,
            dataIndex: 'shira1120',
            align: 'center'
        },
        {
            header: 'उपमा १०४०',
            width: 60,
            sortable: true,
            dataIndex: 'upma1040',
            align: 'center'
        },
        {
            header: 'शिरा अतिरिक्त १५००',
            width: 80,
            sortable: true,
            dataIndex: 'shiraXtra1500',
            align: 'center'
        }]
    });


    emptyTalulaOrderStore= new Ext.data.JsonStore({

        storeId: 'emptyBatchesStore',
        root: 'root',
        idProperty : 'orderID',
        fields: [{
            name: 'orderID'
        },{
            name: 'govOrderID'
        },{
            name: 'sattu1170'
        }, {
            name: 'shira936'
        }, {
            name: 'upma880'
        }, {
            name: 'sukadi1170'
        }, {
            name: 'shira1120'
        }, {
            name: 'upma1040'
        }, {
            name: 'shiraXtra1500'
        }],
        sortInfo: {
            field:'orderID',
            direction:'DESC'
        }
    });

    toTalukaOrderGrid = new Ext.grid.GridPanel({
        store: emptyTalulaOrderStore,
        enableDragDrop   : true,
        autoScroll: true,
        ddGroup        : 'thirdGridDDGroup',
        stripeRows: true,
        loadMask: true,
        stateful: true,
        iconCls: 'inv',
        stateId: 'toTalukaOrderGrid',
        plugins : talukaGridSummary,
        columns: [new Ext.grid.RowNumberer(),
        {
            header: '<b>Taluka Order</b>',
            width: 80,
            sortable: true,
            dataIndex: 'govOrderID',
            align: 'center', summaryType: 'count',
            summaryRenderer: function(v, params, data){
             params.attr = 'ext:qtip="Stock Summary"'; // summary column tooltip example
            return v? ((v === 0 || v > 1) ? '(' + v +' Orders) &nbsp;Total >' : '( 1 Order)&nbsp;Total >') : '';
            }
        },

        {
            header: 'सतु ११७०',
            width: 60,
            sortable: true,
            dataIndex: 'sattu1170',
            align: 'center',summaryType: 'sum'
        },

        {
            header: 'शिरा ९३६',
            width: 60,
            sortable: true,
            dataIndex: 'shira936',
            align: 'center',summaryType: 'sum'
        },
        {
            header: 'उपमा ८८०',
            width: 60,
            sortable: true,
            dataIndex: 'upma880',
            align: 'center',summaryType: 'sum'
        },
        {
            header: 'सुकडी ११७०',
            width: 70,
            sortable: true,
            dataIndex: 'sukadi1170',
            align: 'center',summaryType: 'sum'
        },
        {
            header: 'शिरा ११२०',
            width: 60,
            sortable: true,
            dataIndex: 'shira1120',
            align: 'center',summaryType: 'sum'
        },
        {
            header: 'उपमा १०४०',
            width: 60,
            sortable: true,
            dataIndex: 'upma1040',
            align: 'center',summaryType: 'sum'
        },
        {
            header: 'शिरा अतिरिक्त १५००',
            width: 80,
            sortable: true,
            dataIndex: 'shiraXtra1500',
            align: 'center',summaryType: 'sum'
        }]
    });





    newBatchForm = new Ext.FormPanel({
        labelAlign: 'right',
        frame:true,
        id: 'new-batch-form',
        autoDestroy : true,
        layout:'fit',
        buttonAlign: 'center',
        items: [{
            layout:'form',
            items:[{
                columnWidth:.100,
                layout: 'form',
                items: [{
                    xtype:'combo',
                    id:'new-batch-type-combo',
                    fieldLabel: 'Batch Type',
                    store: batchMatrixStore,
                    displayField : 'batchName' ,
                    valueField: 'ID',
                    forceSelection : true,
                    triggerAction : 'all',
                    selectOnFocus :true,
                    editable:false,
                    name : 'batchtype',
                    hiddenName : 'batchtype',
                    allowBlank: false
                  
                },{
                    xtype:'textfield',
                    fieldLabel: 'Batch Number',
                    id:'new-batch-number',
                    allowBlank: false,
                    name: 'batchNumber',
                    hiddenName : 'batchNumber'
                }
                ]
            }]
        }],
        buttons: [{
            text: 'Save',
            scale: 'medium',
            handler: function(){
                newBatchForm.getForm().submit({
                    url: 'create/create-batch.jsp',
                    method: 'POST',
                    success: function(form, action){
                        allBatchesStore.load();
                        newBatchForm.hide();
                        Ext.Msg.alert('Success', 'Batch created');
                    },
                    failure: function(form, action){
                        Ext.Msg.alert('Warning', 'Batch already exists');
                    }
                });
            }
        },{
            text: 'Clear',
            scale: 'medium',
            handler: function(){}
        }]
    });

    openNewBatchWin = function(){
        batchMatrixStore.load();
        var wn = new Ext.Window({
            layout:'fit',
            width:400,
            modal: true,
            height:150,
            iconCls: 'add',
            closeAction:'hide',
            title : 'New Batch',
            plain: true,
            items : [
            {
                layout :"border",
                items :[{
                    region:"center",
                    layout:'fit',
                    items:[newBatchForm]
                }
                ]
            },
            ]
        });       
        wn.show(this);
    };
    

    openAddProductionWin = function(){

        var prodForm = new Ext.FormPanel({
            labelAlign: 'right',
            frame:true,
            id: 'add-prod-form',
            layout:'fit',
            buttonAlign: 'center',
            items: [{
                layout:'form',
                items:[{

                    layout: 'form',
                    items: [{
                        xtype:'combo',
                        id:'add-prod-batch-combo',
                        fieldLabel: 'Batch',
                        store:  allBatchesStore,
                        displayField : 'batchName' ,
                        valueField: 'batchID',
                        forceSelection : true,
                        triggerAction : 'all',
                        selectOnFocus :true,
                        editable:false,
                        name : 'batchNumber',
                        hiddenName : 'batchNumber',
                        allowBlank: false
                    },{
                        xtype:'combo',
                        id:'add-prod-shift-combo',
                        fieldLabel: 'Shift',
                        store: ['DAY','NIGHT'],
                        forceSelection : true,
                        triggerAction : 'all',
                        selectOnFocus :true,
                        editable:false,
                        name : 'shift',
                        hiddenName : 'shift',
                        allowBlank: false
                    },{
                        xtype:'textfield',
                        fieldLabel: 'Production in tons',
                        id:'add-prod-prod-combo',
                        allowBlank: false,
                        name: 'production',
                        hiddenName : 'production'
                    }
                    ]
                }]
            }]
        });

        prodForm.doLayout();
        batchMatrixStore.load();
        var wn = new Ext.Window({
            layout:'fit',
            width:500,
            id:'openAddProductionWin',
            modal: true,
            height:200,
            iconCls: 'add',
            closeAction:'close',
            title : 'Add Prodcution',
            plain: true,
            items : [
            {
                layout :"border",
                items :[{
                    region:"center",
                    layout:'fit',
                    items:[prodForm]
                }
                ]
            },
            ],
            buttons: [{
                text: 'Save',
                scale: 'medium',
                handler: function(){
                    prodForm.getForm().submit({
                        url: 'update/update-production.jsp',
                        method: 'POST',
                        success: function(form, action){
                            prodStore.load();
                            //
                            //wn.close();
                            Ext.Msg.alert('Success', 'Production updated');
                        //allBatchesStore.load();
                        },
                        failure: function(form, action){
                            Ext.Msg.alert('Warning', 'Error in updating');
                        }
                    });
                }
            },{
                text: 'Clear',
                scale: 'medium',
                handler: function(){}
            }]
        });
        wn.doLayout();
        wn.show(this);
    };

  



   

    viewport = new Ext.Viewport({
        layout: 'border',
        bodyStyle: 'padding:5px;',
        items: [/*{
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
            },  {
                title: 'बिल्स',
                contentEl: 'west3',
                border: false,
                iconCls: 'bill'
            }, {
                title: 'बिल्टी',
                contentEl: 'west4',
                border: false,
                iconCls: 'bill'
            }, {
                title: 'स्टॅाक',
                contentEl: 'west5',
                border: false,
                iconCls: 'bill'
            }]
        } ,*/
        new Ext.BoxComponent({
            region: 'north',
            height: 50,
            contentEl: 'el1'
        }), new Ext.TabPanel({
            region: 'center',
            deferredRender: false,
            autoScroll: true,
            bodyStyle: 'padding:1px;',
            id: "center-tab-panel",
            activeTab: 0,
            items: [{
                title: 'Update Stock',
                iconCls: 'home',
                autoScroll: true,
                closable:true,
                id: "tab00",
                layout: 'border',
                items: [{
                    region: "center",
                    bodyStyle: 'padding:5px;',
                    layout: "fit",
                    items : prodGrid
                }]
            },{
                title: 'सर्व बॅचेस',
                iconCls: 'home',
                autoScroll: true,
                closable:true,
                id: "tab4",
                layout: 'border',
                items: [{
                    region: "center",
                    bodyStyle: 'padding:5px;',
                    layout: "fit",
                    items : allBatchesGrid
                }]
            },{
                title: 'Create Bilty',
                iconCls: 'home',
                autoScroll: true,
                closable:true,
                id: "tab6",
                layout: 'border',
                items: [{
                    region: "center",
                    
                    layout: "fit",
                    items : {
                        
                        border : true,
                        items :[{
                            region: "north",
                            bodyStyle: 'padding:1px;',
                            layout: "column",                           
                            height: 210,
                            items : [
                            {
                                region: "west",
                                bodyStyle: 'padding:1px;',
                                layout: "fit",
                                height: 210,
                                title : "All Prduction Batches",
                                columnWidth : .5,
                                items : [fromProductionBatchesGrid]

                            },
                            {
                                region: "center",
                                bodyStyle: 'padding:1px;',
                                layout: "fit",
                                height: 180,
                                title : "Selected Batches",
                                columnWidth : .5,
                                items : [toProductionBatchesGrid]
                            }
                            ]
                        },
                        {
                            region: "center",
                            bodyStyle: 'padding:1px;',
                            layout: "column",                           
                            height: 210,
                            items : [

                            {
                                region: "west",
                                bodyStyle: 'padding:1px;',
                                layout: "fit",
                                height: 210,
                                title : "All Taluka Orders",
                                columnWidth : .5,
                                items : [
                                fromTalukaOrderGrid
                                ]

                            },
                            {
                                region: "center",
                                bodyStyle: 'padding:1px;',
                                layout: "fit",
                                height: 180,
                                title : "Selected Orders",
                                columnWidth : .5,
                                items : [
                                toTalukaOrderGrid
                                ]
                            }
                            ]
                        },
                        {
                            region: "south",
                            bodyStyle: 'padding:5px;',
                            layout: "form",align: 'center',
                           // height: 50,
                             border: false,
                            buttonAlign: 'center',
                               items:[{xtype : "combo",align: 'center',
                                       emptyText : 'Select Truck', width : 200,
                                        store : [10,16,18,20,23,32]},
                                    {   xtype : 'label',
                                        text : 'Select Truck'}],

                             buttons: [
                                {
                                text: 'Validate Bilty',
                                scale: 'medium',
                                handler : function() {
                                    emptyBatchesStore;
                                    emptyTalulaOrderStore;

                                    var batches = [];
                                    emptyBatchesStore.each(function(record) {
                                        batches.push(record.data.batchID);
                                    });

                                    var orders = [];
                                    emptyTalulaOrderStore.each(function(record) {
                                        orders.push(record.data.orderID);
                                    });

                                     Ext.Ajax.request({
                                        url: 'validate/validate-bilty-creation.jsp',
                                        method: 'POST',
                                        params: {
                                            batches: Ext.util.JSON.encode(batches),
                                            orders: Ext.util.JSON.encode(orders)
                                        },
                                        success: function(resp,opt) {
                                            Ext.Msg.hide();                                   
                                        //Ext.Msg.alert('Deletion', 'Order has removed permanently!');
                                        },
                                        failure: function(resp,opt) {
                                            Ext.Msg.hide();
                                            Ext.Msg.alert('Error', 'Error in deleting!');
                                        }
                                    });

                                }
                            },
                             {
                                text: 'Create Bilty',
                                scale: 'medium'
                            }

                            ]

                        }

                        ]

                    }
                }]
            }
            ]
        })]
    });
    // Generic fields array to use in both store defs.
    var fields = [{
        name: 'batchID'
    },{
        name: 'batchNumber'
    },{
        name: 'batchName'
    }, {
        name: 'creationDate'
    }];

    // used to add records to the destination stores
    blankRecord =  Ext.data.Record.create(fields);

    /****
        * Setup Drop Targets
        ***/
    // This will make sure we only drop to the  view scroller element
    var firstGridDropTargetEl =  fromProductionBatchesGrid.getView().scroller.dom;
    firstGridDropTarget = new Ext.dd.DropTarget(firstGridDropTargetEl, {
        ddGroup    : 'firstGridDDGroup',
        notifyDrop : function(ddSource, e, data){
            var records =  ddSource.dragData.selections;
            Ext.each(records, ddSource.grid.store.remove, ddSource.grid.store);
            fromProductionBatchesGrid.store.add(records);
            fromProductionBatchesGrid.store.sort('batchID', 'ASC');
            return true;
        }
    });

    // This will make sure we only drop to the view scroller element
    var secondGridDropTargetEl = toProductionBatchesGrid.getView().scroller.dom;
    secondGridDropTarget = new Ext.dd.DropTarget(secondGridDropTargetEl, {
        ddGroup    : 'secondGridDDGroup',
        notifyDrop : function(ddSource, e, data){
            var records =  ddSource.dragData.selections;
            Ext.each(records, ddSource.grid.store.remove, ddSource.grid.store);
            toProductionBatchesGrid.store.add(records);
            toProductionBatchesGrid.store.sort('batchID', 'ASC');
            return true;
        }
    });


    //------------------------------------------------------------------------------------------


	

    /****
        * Setup Drop Targets
        ***/
    // This will make sure we only drop to the  view scroller element
    var thirdGridDropTargetEl =  fromTalukaOrderGrid.getView().scroller.dom;
    firstGridDropTarget = new Ext.dd.DropTarget(thirdGridDropTargetEl, {
        ddGroup    : 'thirdGridDDGroup',
        notifyDrop : function(ddSource, e, data){
            var records =  ddSource.dragData.selections;
            Ext.each(records, ddSource.grid.store.remove, ddSource.grid.store);
            fromTalukaOrderGrid.store.add(records);
            fromTalukaOrderGrid.store.sort('batchID', 'ASC');
            return true;
        }
    });

    // This will make sure we only drop to the view scroller element
    var fourthGridDropTargetEl = toTalukaOrderGrid.getView().scroller.dom;
    secondGridDropTarget = new Ext.dd.DropTarget(fourthGridDropTargetEl, {
        ddGroup    : 'fourthGridDDGroup',
        notifyDrop : function(ddSource, e, data){
            var records =  ddSource.dragData.selections;
            Ext.each(records, ddSource.grid.store.remove, ddSource.grid.store);
            toTalukaOrderGrid.store.add(records);
            toTalukaOrderGrid.store.sort('batchID', 'ASC');
            return true;
        }
    });

    sr = function () {
        openNewOrderWin();
    };
    Ext.EventManager.addListener("n-o", 'click', sr );




    bb = function () {
        var tabPane = Ext.getCmp('center-tab-panel');
        var tab = Ext.getCmp('tab3');        
        tabPane.setActiveTab(tab);
    };
    Ext.EventManager.addListener("b-b", 'click', bb );
  
});
