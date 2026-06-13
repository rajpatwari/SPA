var selectedOrderID;
var govOrder;
var talukaMarathi;
var selectedDistrictOrderID;
var selectedTalukaOrderID ;
var districtOrderNumber;
var selectedSectionID;
fromYear = 0;
toYear = 0;

/*var challanFlag  = false;

getChallanFlag = function() {
    Ext.Msg.alert("flag :"+challanFlag);
    return challanFlag;
}
*/
Ext.onReady(function(){

    if (billDatePreviewWin != undefined) {
        billDatePreviewWin.destroy();
        billDatePreviewWin = undefined;
    }

    copyDistID = 0;

    Ext.state.Manager.setProvider(new Ext.state.CookieProvider());
    function formatDate(value){
        return value ? value.dateFormat('M d, Y') : '';
    }

    var yearStore = {
        xtype : 'jsonstore',
        autoLoad : true,
        idProperty : 'year',
        storeId: 'yearStore',
        url: 'read/years.jsp',
        fields: [ 'year','yearMarathi'],
        root: 'root',
        sortInfo: {
            field:'year',
            direction:'ASC'
        }
    };
    // yearStore.loadData(yearData);

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

    workingYear= new Ext.data.JsonStore({
        autoLoad: true,
        storeId: 'workingYear',
        url: 'read/get-financial-year.jsp',
        idProperty : 'id',
        fields: ['dispatchFinancialYear']
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

    aOStore= new Ext.data.JsonStore({
        autoDestroy: true,
        storeId: 'aOStore',
        url: 'read/get-all-taluka-orders.jsp',
        root: 'root',
        idProperty : 'talukaID',
        fields: [{
            name: 'orderID'
        },{
            name: 'talukaID'
        }, {
            name: 'district'
        },{
            name: 'taluka'
        },{
            name: 'govOrderNumber'
        },{
            name: 'govOrderDate'
        },{
            name: 'fromMonth'
        },{
            name: 'fromYear'
        }, {
            name: 'toMonth'
        },{
            name: 'toYear'
        }, {
            name: 'year'
        }, {
            name: 'date'
        }, {
            name: 'rationVersion'
        }, {
            name: 'talukaInvoiceDate'
        }, {
            name: 'talukaOrderDetailID'
        }],
        sortInfo: {
            field:'orderID',
            direction:'DESC'
        }
    });

    aIStore= new Ext.data.JsonStore({
//        autoLoad: true,
        autoDestroy: true,
        storeId: 'aIStore',
        url: 'read/get-all-invoices.jsp',
        root: 'root',
        totalProperty: 'totalElements',
        idProperty : 'invoiceID',
        fields: [{
            name: 'invoiceID'
        },{
            name: 'invoiceIDMan'
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
        }]
    });
    aIStore.load({
        params: {
            start: 0,
            limit: 25
        }
    });

    allSectionsStore= new Ext.data.JsonStore({
        autoDestroy: true,
        storeId: 'allSectionsStore',
        url: 'read/get-all-taluka-sections.jsp',
        root: 'root',
        idProperty : 'sectionID',
        fields: [{
            name: 'orderID'
        }, {
            name: 'sectionID'
        }, {
            name: 'sectionMarathi'
        }, {
            name: 'talukaID'
        }, {
            name: 's1'
        }, {
            name: 'rationVersion'
        }],
        sortInfo: {
            field:'sectionID',
            direction:'ASC'
        }
    });

    talukaOrderList = new Ext.data.JsonStore({
        //autoLoad: true,
        storeId: 'talukaOrderList',
        url: 'read/get-taluka-orders-list.jsp',
        root: 'root',
        idProperty : 'orderID',
        fields: ['orderID','orderNumber', 'orderYear']
    });


    districtOrderList = new Ext.data.JsonStore({
        //autoLoad: true,
        storeId: 'districtOrderList',
        url: 'read/get-district-orders-list.jsp',
        root: 'root',
        idProperty : 'orderID',
        fields: ['orderID', 'orderNumber', 'orderNoDate']
    });

    godownList = new Ext.data.JsonStore({
        //autoLoad: true,
        storeId: 'godownList',
        url: 'read/get-godown-list.jsp',
        root: 'root',
        idProperty : 'godownID',
        fields: ['godownID','godownName']
    });


    fillOrderWindow  = function (secM){
        var sm = orderSectionsGrid.getSelectionModel();
        var sel = sm.getSelections();
        if(sel.length == 0) {
            Ext.Msg.alert('Select Section', 'No section is selected!');
            return;
        }
        var sID = sel[0].get('sectionID');
        selectedSectionID = sID;

        var fm = Ext.form;
        cm = new Ext.grid.ColumnModel({
            // specify any defaults for each column
            defaults: {
                sortable: true // columns are not sortable by default
            }

        });

        var schoolOrderStore= new Ext.data.JsonStore({
            autoDestroy: true,
            storeId: 'schoolOrderStore',
            url: 'read/get-all-section-schools.jsp',
            root: 'root',
            idProperty : 'schoolID',
            fields: [{
                name: 'schoolID'
            }, {
                name: 'orderID'
            },{
                name: 'orderDetailID'
            }, {
                name: 'sectionID'
            },{
                name: 'schoolID'
            }, {
                name: 'schoolMarathi'
            },{
                name: 'g1'
            }, {
                name: 'challanNumber'
            }, {
                name: 'challanDate'
            }],
            sortInfo: {
                field:'schoolID',
                direction:'ASC'
            }
        });

        // create the editor grid
        var grid = new Ext.grid.EditorGridPanel({
            store: schoolOrderStore,        
            stripeRows: true,
            columnLines: true,
            columns: [new Ext.grid.RowNumberer(),{
                header: 'चालान क्र.',
                dataIndex: 'challanNumber',
                id: 'challanNumber',
                editable : getChallanFlag(),
                align: 'center',
                width: 95,
                editor: new fm.NumberField({
                    allowBlank: false,
                    allowNegative: false,
                    selectOnFocus : true
                })
            },{
                header: 'चालान दिनांक',
                dataIndex: 'challanDate',
                align: 'center',
                editable :false,
                type: 'date',
                id: 'challanDate',
                editable : getChallanFlag(),
                editor: new fm.TextField({
                    allowBlank: false,
                    emptyText: 'dd/mm/yyyy'
                })
            }, {
                id: 'school',
                header: 'अंगणवाडी',
                dataIndex: 'schoolMarathi',
                align: 'center',
                width: 170
            }, {
                header: 'किशोरवइन मुली लाभाथीँ',
                dataIndex: 'g1',
                id: 'g1',
                width: 130,
                align: 'center',
                editor: new fm.NumberField({
                    allowBlank: false,
                    allowNegative: false,
                    selectOnFocus : true
                })
            }],
            listeners: {
            },
            height: 300,
            frame: true,
            loadMask: true,
            tbar: [{
                xtype: 'tbbutton',
                iconCls: 'challans',
                text: 'चालान बनवा',
                handler : function(){
                    createChallans(schoolOrderStore);
                }
            },'->',{
                xtype:'datefield',
                width : 100,
                fieldLabel: 'Select Challan Date',
                id:'changeCdate',
                allowBlank: false,
                editable:false,
                format: 'd/m/Y',
                name: 'challanDate',
                hiddenName : 'challanDate',
                anchor:'95%',
                emptyText : 'चालान दिनांक '
            },{
                xtype: 'tbbutton',
                text: 'चालान दिनांक बदला',
                handler : function(){
                    var changedDate  = Ext.getCmp('changeCdate').value;

                    Ext.Ajax.request({
                        url: 'update/update-challan-date.jsp',
                        method: 'POST',
                        params: {
                            sectionID: sID,
                            orderID : selectedTalukaOrderID,
                            changedDate : changedDate
                        },
                        success: function(resp,opt) {
                            schoolOrderStore.reload({
                                waitMsg:'Loading...'
                            });
                        },
                        failure: function(resp,opt) {
                            Ext.Msg.alert('Error', 'Error in deleting!');
                        }
                    });
                }
            }]
        });
       
        win = new Ext.Window(
        {
            layout:'fit',
            width:750,
            modal: true,
            height:500,
            iconCls: 'add',
            closeAction:'hide',
            title : tit,
            buttonAlign: 'center',
            plain: true,
            items : [
            {
                layout :"border",
                items :[
                {
                    region:"center",
                    bodyStyle: 'padding:0px;',
                    layout: "fit",
                    height:350,
                    items:[grid]
                }
                ]
            }
            ],
            buttons: [{
                text: 'Save Order',
                scale: 'medium',
                id : 'save-order-button',
                handler: function(){
                    var records = schoolOrderStore.getModifiedRecords();
                    if(records.length == 0){
                        Ext.Msg.alert('No changes', 'There are no changes in the orders!');
                        return;
                    }
                    Ext.getCmp('save-order-button' ).setDisabled(true);
                    
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
                    Ext.Ajax.request({
                        url: 'update/update-order-details.jsp',
                        method: 'POST',
                        params: {
                            postdata: changedArray,
                            orderID : selectedTalukaOrderID
                        },
                        success: function(resp,opt) {
                            Ext.getCmp('save-order-button' ).setDisabled(false);
                            schoolOrderStore.removeAll();
                            allSectionsStore.reload({
                                waitMsg:'Loading...'
                            });
                            win.hide();
                            challanFlag = false;
                        //Ext.Msg.alert('Deletion', 'Order has removed permanently!');
                        },
                        failure: function(resp,opt) {
                            Ext.getCmp('save-order-button' ).setDisabled(false);
                            Ext.Msg.alert('Error', 'Order Details are Already Created Before...');
                        }
                    });
                //Ext.Msg.wait('Deleting...','Please wait');
                }
            }]
        });
        schoolOrderStore.removeAll();
        grid.getStore().removeAll();

        schoolOrderStore.load({
            params:{
                orderID:selectedTalukaOrderID,
                sectionID:sID
            },
            waitMsg:'Loading...'
        });

        var tit = talukaMarathi +" - "+ govOrder +", विभाग"+ "-"+secM  ;
        win.setTitle(tit);
        win.show(this);
    };
    //Grid End

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

    invoiceGrid = new Ext.grid.GridPanel({
        store: aIStore,
        stripeRows: true,
        loadMask: true,
        stateful: true,
        iconCls: 'inv',
        columnLines: true,
        stateId: 'sgrid1',
        tbar: [{
            iconCls: 'printer',
            text: 'Print Bill',
            handler: function(){
                var sm = invoiceGrid.getSelectionModel();
                var sel = sm.getSelections();
                if(sel.length == 0){
                    Ext.Msg.alert('Select Bill', 'No bill is selected!');
                    return
                }
                var invoiceID = sel[0].get('invoiceID');
                var orderID = sel[0].get('orderID');

                window.open("reports/print-invoice.jsp?invoiceID="+invoiceID+"&orderID="+orderID ,'invoicewin',"width=1500,height=800,top=40,left=60,menubar=1,resizable=0,location=0,scrollbars=1");
            }
        },{
            iconCls: 'delete',
            text: 'Delete Bill',
            handler: function(){
                var sm = invoiceGrid.getSelectionModel();
                var sel = sm.getSelections();
                if(sel.length == 0){
                    Ext.Msg.alert('Select Bill', 'No bill is selected!');
                    return
                }
                var invoiceID = sel[0].get('invoiceID');
                orderID = sel[0].get('orderID');

                Ext.Msg.show({
                    title: 'Confirm',
                    msg: 'Delete Selected Bill?',
                    buttons: Ext.Msg.YESNO,
                    fn: function(btn) {
                        if (btn == 'yes') {                       

                            Ext.Ajax.request({
                                url: 'delete/delete-bill.jsp',
                                method: 'POST',
                                params: {
                                    invoiceID: invoiceID
                                },
                                success: function(resp,opt) {
                                    aIStore.reload({
                                        waitMsg:'Loading...'
                                    });
                                },
                                failure: function(resp,opt) {
                                    Ext.Msg.alert('Error', 'Error in deleting!');
                                }
                            });
                        }
                    }
                });
            }
        }/*, '-',{
            xtype: 'textfield',emptyText: 'Invoice ID '
        }, '-',{
            xtype: 'textfield'
        }*/],
        columns: [new Ext.grid.RowNumberer(),{
            header: '<b>बिल क्र.</b>',
            width: 60,
            sortable: true,
            dataIndex: 'invoiceIDMan',
            align: 'center'
        }, {
            header: 'बिल दिनांक',
            width: 120,
            sortable: true,
            dataIndex: 'creationDate',
            align: 'center'
        }, {
            header: 'ऑर्डर क्र.',
            width: 120,
            sortable: true,
            dataIndex: 'govOrderID',
            align: 'center'
        }, {
            header: 'तालुका',
            width: 120,
            sortable: true,
            dataIndex: 'taluka',
            align: 'center'
        }, {
            header: 'जिल्हा',
            width: 120,
            sortable: true,
            dataIndex: 'district',
            align: 'center'
        }, {
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
            displayMsg: '<b>Displaying Bills {0} - {1} of {2}</b>',
            emptyMsg: "No results to display"
        })
    });

    //get-all-district-orders
    aDOStore= new Ext.data.JsonStore({
        autoDestroy: true,
        autoLoad: true,
        storeId: 'aDOStore',
        url: 'read/get-all-district-orders.jsp',
        root: 'root',
        /*baseParams : {
            id : '01/04/2011>31/03/2012'
        },*/
        idProperty : 'orderID',
        fields: [{
            name: 'orderID'
        }, {
            name: 'districtID'
        }, {
            name: 'orderDate'
        }, {
            name: 'districtGovOrderID'
        }, {
            name: 'districtMarathi'
        }, {
            name: 'creationDate'
        }, {
            name: 'orderNumber'
        }],
        sortInfo: {
            field:'orderID',
            direction:'DESC'
        }
    });
    showAllTalukOrders = function(){
        var sm = aDOGrid.getSelectionModel();
        var sel = sm.getSelections();
        if(sel.length == 0) {
            Ext.Msg.alert('Select Order', 'No order is selected!');
            return;
        }
        var id = sel[0].get('districtID');
        copyDistID = sel[0].get('districtID');
        //alert(copyDistID);
        var districtMarathi= sel[0].get('districtMarathi');
        talId = sel[0].get('talukaID');
        districtOrderNumber = sel[0].get('orderNumber');
        selectedDistrictOrderID = sel[0].get('orderID');
        govOrder = sel[0].get('districtGovOrderID');
        var tabPane = Ext.getCmp('center-tab-panel');
        var tab = Ext.getCmp('tab1');
        tab.setTitle("सर्व तालूके- जिल्हा : " + districtMarathi+", ऑर्डर : "+ districtOrderNumber+"  ");
        allSectionsStore.removeAll();
        Ext.getCmp('tab2').setTitle('सर्व विभाग ऑर्डर');
        tabPane.setActiveTab(tab);
        aOStore.load({
            params:{
                districtID:id,
                selectedDistrictOrderID: selectedDistrictOrderID
            },
            waitMsg:'Loading...'
        });
    };

    aDOGrid = new Ext.grid.GridPanel({
        store: aDOStore,
        id : 'aDOGrid',
        listeners : {
            dblclick  : showAllTalukOrders            
        },
        stripeRows: true,
        loadMask: true,
        stateful: true,
        iconCls: 'inv',
        columnLines: true,
        stateId: 'aDOGrid',
        tbar: [ '-'/*, '-',{
            xtype: 'textfield',emptyText: 'Invoice ID '
        }, '-',{
            xtype: 'textfield'
        }*/,{
            iconCls: 'showall',
            text: 'सर्व तालूका ऑर्डर',
            handler: showAllTalukOrders
        }, '-',{
            iconCls: 'add',
            text: 'नविन जिल्हा ऑर्डर',
            handler: function(){
                openDistrictOrderWin();
            }
        },'-',{
            text: 'Edit District Order',
            iconCls: 'edit',
            handler: function(){
                var sm = aDOGrid.getSelectionModel();
                var sel = sm.getSelections();
                if(sel.length == 0) {
                    Ext.Msg.alert('Select Order District', 'No district order is selected!');
                    return;
                }
                var districtOrderID = sel[0].get('orderID');
                var orderDate = sel[0].get('orderDate');
                var orderNumber = sel[0].get('orderNumber');
                var districtGovOrderID = sel[0].get('districtGovOrderID');
                var districtID = sel[0].get('districtID');

                Ext.getCmp('edit-d-o-form-hdID').setValue(districtID);
                Ext.getCmp('edit-d-o-form-h').setValue(districtOrderID);
                Ext.getCmp('edit-d-o-form-on').setValue(orderNumber);
                Ext.getCmp('edit-d-o-form-n').setValue(districtGovOrderID);
                Ext.getCmp('edit-d-o-form-d').setValue(orderDate);

                openEdit();
            }
        },'-',{
            xtype:'splitbutton',
            iconCls: 'arrow_out',
            menu: [{
                ref: '../removeBtn',
                iconCls: 'delete',
                text: 'Delete Order',
                handler: function(){
                    var sm = aDOGrid.getSelectionModel();
                    var sel = sm.getSelections();
                    if(sel.length == 0) {
                        Ext.Msg.alert('Select Order', 'No order is selected!');
                        return;
                    }
                    Ext.Msg.show({
                        title: 'Confirm',
                        msg: 'Delete Selected Order?',
                        buttons: Ext.Msg.YESNO,
                        fn: function(btn) {
                            if (btn == 'yes') {
                                id = sel[0].get('districtID');
                                districtMarathi= sel[0].get('districtMarathi');

                                orderNumber = sel[0].get('orderNumber');
                                var orderID = sel[0].get('orderID');

                                Ext.Ajax.request({
                                    url: 'delete/delete-district-order.jsp',
                                    method: 'POST',
                                    params: {
                                        districtOrderID:orderID
                                    },
                                    success: function(resp,opt) {
                                        aDOStore.reload();
                                        Ext.Msg.alert('Order deleted', 'Order deleted successfully!');
                                    },
                                    failure: function(resp,opt) {
                                        Ext.Msg.alert('Error', 'Error in deleting!');
                                    }
                                });
                            }
                        }
                    });
                }
            }]
        }
        ],
        columnLines: true,
        columns: [new Ext.grid.RowNumberer(),
        {
            header: 'जिल्हा',
            width: 120,
            sortable: true,
            dataIndex: 'districtMarathi',
            align: 'center'
        }, {
            header: 'जिल्हा ऑर्डर क्र.',
            width: 120,
            sortable: true,
            dataIndex: 'districtGovOrderID',
            align: 'center'
        }, {
            header: 'जिल्हा ऑर्डर दिनांक',
            width: 120,
            sortable: true,
            dataIndex: 'orderDate',
            align: 'center'
        }, {
            header: 'ऑर्डर',
            width: 120,
            sortable: true,
            dataIndex: 'orderNumber',
            align: 'center',
            renderer : function(v){
                return 'ऑर्डर '+v;
            }
        }, {
            header: 'Created On',
            width: 120,
            sortable: true,
            dataIndex: 'creationDate',
            align: 'center'
        }],
        height: 500,
        width: 700,
        bbar: [{}]
    });

    showOrderDetailWin = function(){
        var sm = orderSectionsGrid.getSelectionModel();
        var sel = sm.getSelections();
        if(sel.length == 0) {
            Ext.Msg.alert('Select Section', 'No section is selected!');
            return;
        }
        //selectedTalukaOrderID =  sel[0].get('orderID');
        sectionID = sel[0].get('sectionID');
        var sectionMarathi = sel[0].get('sectionMarathi');

        fillOrderWindow(sectionMarathi);
    };




    dateStatus = false;

    //returns all items to be added to form
    function getChallanFormItems() {
        var panel = new Ext.Panel({
            layout: 'fit',
            items: [{
                layout : 'column',
                items : [{
                    columnWidth:.80,
                    layout: 'form',
                    style : 'padding-top: 9px',
                    items: [{
                        xtype: 'checkbox',
                        fieldLabel: 'Set Blank Date',
                        id: 'challanPreviewDate',
                        name: 'challanPreviewDate',
                        listeners : {
                            'check' : function(){
                                dateStatus = (this.checked);
                            }
                        }
                    }]
                }
                , {
                    layout : 'column',
                    items : [{
                        columnWidth:.90,
                        layout: 'form',
                        width : 100,
                        items: {
                            buttons: [continueBtn]
                        }
                    }]
                }]
            }]
        });
        return panel;
    }

    //defines action to take on click of Save button
    function continueHandler() {
        challanDatePreviewWin.hide();
        challanParam = challanParam+"&dateStatus="+dateStatus;
        window.open("reports/print-all-challan-formatted.jsp?"+challanParam,'challan-print',"width=1500,height=800,top=40,left=60,menubar=1,resizable=0,location=1,scrollbars=1");
    }

    //variable which defines Save button
    continueBtn = {
        xtype: 'button',
        text: 'Continue',
        handler: continueHandler
    };

    //FormPanel to add data to grid start
    var challanfrm = new Ext.FormPanel({
        region: 'center',
        method: 'POST',
        buttonAlign: 'center',
        labelAlign: 'right',
        url: '',
        id: 'formpanel',
        autoDestroy: false,
        frame: true,
        items: [getChallanFormItems()]//,
    });

    challanDatePreviewWin;
    getChallanDatePreviewWin = function () {
        //Window for adding data to the grid
        if (Ext.type(challanDatePreviewWin)) {
            return challanDatePreviewWin;
        }
        challanDatePreviewWin = new Ext.Window({
            id: 'challandatepreviewwin',
            name: 'challandatepreviewwin',
            autoHeight : true,
            width: 300,
            modal: true,
            autoDestroy: true,
            autoScroll: true,
            title : 'Select Your Challan Preview Date...',
            closeAction: 'hide',
            items: [challanfrm]
        });
        return challanDatePreviewWin;
    };





    orderSectionsGrid = new Ext.grid.GridPanel({
        store: allSectionsStore,
        plugins: [new Ext.ux.grid.GridSummary()],
        stripeRows: true,
        loadMask: true,
        stateful: true,
        columnLines: true,
        listeners : {
            dblclick  : showOrderDetailWin
        },
        iconCls: 'inv',
        id: 'orderSectionsGrid',
        stateId: 'orderSectionsGrid',
        tbar: ['-',{
            iconCls: 'fill',
            text: 'ऑर्डर पूर्ण करा',
            handler: showOrderDetailWin
        },'->',{
            iconCls: 'report',
            text: 'विभाग गोषवारा',
            handler: function(){
                var sm = orderSectionsGrid.getSelectionModel();
                var sel = sm.getSelections();
                if(sel.length == 0) {
                    Ext.Msg.alert('Select Section', 'No section is selected!');
                    return;
                }
                var id = sel[0].get('orderID');
                var sectionID = sel[0].get('sectionID');
                rationVersion = sel[0].get('rationVersion');

                sectionMarathi = sel[0].get('sectionMarathi');
                var param = "orderID="+id+"&sectionID="+sectionID;
                window.open("reports/section-report.jsp?"+param,'sectionreport',"width=1500,height=800,top=40,left=60,menubar=1,resizable=0,location=1,scrollbars=1");
            }
        }, '-',{
            iconCls: 'printerall',
            text: 'चालान प्रिंट करा (Formatted)',
            handler: function(){
                var sm = orderSectionsGrid.getSelectionModel();
                var sel = sm.getSelections();
                if(sel.length == 0) {
                    Ext.Msg.alert('Select Section', 'No section is selected!');
                    return;
                }
                getChallanDatePreviewWin();
                var id = sel[0].get('orderID');
                var sectionID = sel[0].get('sectionID');

                var sectionMarathi = sel[0].get('sectionMarathi');
                challanParam = "orderID="+id+"&sectionID="+sectionID+"&sectionMarathi="+sectionMarathi;
                Ext.getCmp('challanPreviewDate').reset();
                challanDatePreviewWin.show();
            //window.open("reports/print-all-challan-formatted.jsp?"+param,'challan-print',"width=1500,height=800,top=40,left=60,menubar=1,resizable=0,location=1,scrollbars=1");
            }
        }, '-',{
            iconCls: 'printerall',
            text: 'चालान प्रिंट करा (Plain)',
            handler: function(){
                var sm = orderSectionsGrid.getSelectionModel();
                var sel = sm.getSelections();
                if(sel.length == 0) {
                    Ext.Msg.alert('Select Section', 'No section is selected!');
                    return;
                }
                var id = sel[0].get('orderID');
                var sectionID = sel[0].get('sectionID');

                var sectionMarathi = sel[0].get('sectionMarathi');
                var param = "orderID="+id+"&sectionID="+sectionID+"&sectionMarathi="+sectionMarathi;
                window.open("reports/print-all-challan.jsp?"+param,'sectionreport',"width=1500,height=800,top=40,left=60,menubar=1,resizable=0,location=1,scrollbars=1");
            }
        }, '-',{
            xtype:'splitbutton',
            //  text: 'Other',
            iconCls: 'arrow_out',
            menu: [{

                text: 'Set challan mannual',
                handler: function(){
                    challanFlag = true;
                }
            }, {
                text: 'Reset Order',
                handler: function(){
                    var sm = orderSectionsGrid.getSelectionModel();
                    var sel = sm.getSelections();
                    if(sel.length == 0) {
                        Ext.Msg.alert('Select Section', 'No section is selected!');
                        return;
                    }
                    var id = sel[0].get('orderID');
                    var sectionID = sel[0].get('sectionID');

                    Ext.Msg.show({
                        title: 'Confirm',
                        msg: 'Its not reversible action, Do you really want to reset the order?',
                        buttons: Ext.Msg.YESNO,
                        fn: function(btn) {
                            if (btn == 'yes') {

                                Ext.Ajax.request({
                                    url: 'delete/delete-section-order.jsp',
                                    method: 'POST',
                                    params: {
                                        talukaOrderID:id,
                                        sectionID:sectionID
                                    },
                                    success: function(resp,opt) {
                                        allSectionsStore.reload({
                                            waitMsg:'Loading...'
                                        });
                                        Ext.Msg.alert("Reset", "Order did reset!");
                                    },
                                    failure: function(resp,opt) {
                                        Ext.Msg.alert("Error", "Error in resetting!");
                                    }
                                });
                            }
                        }
                    });
                }
            }]
        }],
        columns: [new Ext.grid.RowNumberer(),{
            header: 'विभाग',
            width: 120,
            sortable: true,
            dataIndex: 'sectionMarathi',
            align: 'center',
            summaryType: 'count',
            summaryRenderer: function (v, params, data) {
                params.attr = 'ext:qtip="Total be"'; // summary column tooltip example
                return v? ((v === 0 || v > 1) ? 'एकूण लाभार्थी >'  : 'एकूण लाभार्थी >') : '';
            }
        }, {
//            header: 'एकूण ६ म. ते ३ व. लाभाथीँ',
            header: 'किशोरवइन मुली लाभाथीँ',
            width: 130,
            sortable: true,
            summaryType: 'sum',
            //renderer: change,
            dataIndex:'s1',
            align: 'center'
        }],
        height: 500,
        width: 700,
        // paging bar on the bottom
        bbar: [{}]
    });
    paintNull = function(val) {
        if (!val) {
            return '<span style="color:red;">-</span>';
        }
        return val;
    };

    showAllSectionOrders = function(){
        var sm = orderGrid.getSelectionModel();
        var sel = sm.getSelections();
        if(sel.length == 0) {
            Ext.Msg.alert('Select Order', 'No order is selected!');
            return;
        }
        selectedTalukaOrderID = sel[0].get('orderID');
        if(selectedTalukaOrderID == 0) {
            Ext.Msg.alert('Edit Order', 'Click on <b>Edit Order</b> and Save pending Information!');
            return;
        }
        var talId = sel[0].get('talukaID');
        govOrder = sel[0].get('govOrderNumber');
        talukaMarathi = sel[0].get('taluka');
        var tabPane = Ext.getCmp('center-tab-panel');
        var tab = Ext.getCmp('tab2');
        tab.setTitle( "सर्व विभाग ऑर्डर- तालुका:"+talukaMarathi+", ऑर्डर : "+districtOrderNumber);
        tabPane.setActiveTab(tab);

        allSectionsStore.load({
            params:{
                orderID:selectedTalukaOrderID,
                talukaID:talId
            },
            waitMsg:'Loading...'
        });
    };

    //defines action to take on click of Save button
    function saveHandler() {
        var previewDate = Ext.getCmp('billPreviewDate').value;
        if (previewDate == undefined) {
            Ext.Msg.alert("Alert...","Preview Date Field Cannot Be Left Blank...");
        }
        else {
            billDatePreviewWin.hide();
            previewParam = previewParam + "&previewDate=" + previewDate ;
            window.open("reports/verify-dups-invoices.jsp?"+previewParam,'bills',"width=1500,height=800,top=40,left=60,menubar=1,resizable=0,location=1,scrollbars=1");
        }
    }

    //defines action to take on click of Save button
    function cancelHandler() {
        billDatePreviewWin.hide();
    }

    //returns all items to be added to form
    function getFormItems() {
        var panel = new Ext.Panel({
            bodyStyle: 'padding:5px 5px 0',
            layout: 'form',
            items: [{
                xtype: 'datefield',
                fieldLabel: 'Bill Preview Date',
                format: 'd/m/Y',
                id: 'billPreviewDate',
                name: 'billPreviewDate',
                width: 150,
                editable: false,
                emptyText: 'Preview(DD/MM/YY)'
            }]
        });
        return panel;
    }

    //variable which defines Save button
    var saveButton = {
        xtype: 'button',
        text: 'Save',
        handler: saveHandler
    };
    //variable which defines Cancel button
    var cancelButton = {
        xtype: 'button',
        text: 'Cancel',
        handler: cancelHandler
    };

    //FormPanel to add data to grid start
    var frm = new Ext.FormPanel({
        region: 'center',
        method: 'POST',
        buttonAlign: 'center',
        labelAlign: 'right',
        url: '',
        id: 'formpanel',
        autoDestroy: false,
        frame: true,
        items: [getFormItems()],
        buttons: [saveButton, cancelButton]
    });

    billDatePreviewWin;
    getBillDatePreviewWin = function () {
        //Window for adding data to the grid
        if (Ext.type(billDatePreviewWin)) {
            return billDatePreviewWin;
        }
        billDatePreviewWin = new Ext.Window({
            id: 'billdatepreviewwin',
            name: 'billdatepreviewwin',
            autoHeight : true,
            width: 300,
            modal: true,
            autoDestroy: true,
            autoScroll: true,
            title : 'Select Your Bill Preview Date...',
            closeAction: 'hide',
            items: [frm]
        });
        return billDatePreviewWin;
    };




    //defines action to take on click of Save button
    function saveCopyHandler() {
        //alert(selTalukaID);
        //alert(selectedTalukaOrderID);
        if(copyFrm.getForm().isValid()){
            copyFrm.getForm().submit({
                url: 'create/copy-taluka-order.jsp',
                method: 'POST'
                ,
                params:{
                    selTalukaID : selTalukaID,
                    selectedTalukaOrderID : selectedTalukaOrderID
                },
                success: function(form, action){
                    copyTalukaOrderWin.hide();
                    aOStore.reload({
                        waitMsg:'Loading...'
                    });
                    Ext.Msg.alert('Success', 'Taluka order Copied Successfully');
                },
                failure: function(form, action){
                    Ext.Msg.alert('Error', 'Error Could Not Copy Taluka Order');
                }
                                        
            });
        }
    }

    //defines action to take on click of Save button
    function cancelCopyHandler() {
        copyTalukaOrderWin.hide();
    }

    //returns all items to be added to form
    function getCopyFormItems() {
        var panel = new Ext.Panel({
            bodyStyle: 'padding:5px 5px 0',
            layout: 'form',
            items: [
                
            {
                xtype:'combo',
                id: 'talukaorderid',
                fieldLabel: 'Taluka Order#',
                forceSelection : true,
                allowBlank: false,
                triggerAction : 'all',
                selectOnFocus :true,
                editable:false,
                mode :'local',
                store: talukaOrderList,
                name: 'toCopyTalukaOrderID',
                hiddenName : 'toCopyTalukaOrderID',
                displayField : 'orderYear' ,
                valueField: 'orderID',
                anchor:'95%'
            }
            ]
        });
        return panel;
    }

    //variable which defines Save button
    var saveCopyButton = {
        xtype: 'button',
        text: 'Save',
        handler: saveCopyHandler
    };
    //variable which defines Cancel button
    var cancelCopyButton = {
        xtype: 'button',
        text: 'Cancel',
        handler: cancelCopyHandler
    };

    //FormPanel to add data to grid start
    var copyFrm = new Ext.FormPanel({
        region: 'center',
        method: 'POST',
        buttonAlign: 'center',
        labelAlign: 'right',
        url: '',
        id: 'copyformpanel',
        autoDestroy: false,
        frame: true,
        //layout : 'fit',
        items: [getCopyFormItems()],
        buttons: [saveCopyButton, cancelCopyButton]
    });

    copyTalukaOrderWin;
    getCopyTalukaOrderWin = function () {
        //Window for adding data to the grid
        if (Ext.type(copyTalukaOrderWin)) {
            return copyTalukaOrderWin;
        }
        copyTalukaOrderWin = new Ext.Window({
            id: 'copytalukaorderwin',
            name: 'copytalukaorderwin',
            autoHeight : true,
            width: 500,
            modal: true,
            autoDestroy: true,
            autoScroll: true,
            title : 'Select Taluka Order Details To Be Copied...',
            closeAction: 'hide',
            items: [copyFrm]
        });
        return copyTalukaOrderWin;
    };




    // create the Grid
    orderGrid = new Ext.grid.GridPanel({
        store: aOStore,
        stripeRows: true,
        loadMask: true,
        stateful: true,
        iconCls: 'inv',
        listeners : {
            dblclick  : showAllSectionOrders
        },
        stateId: 'sgrid',
        columnLines: true,
        tbar: [ '-',{
            iconCls: 'showall',
            text: 'सर्व विभाग',
            handler: showAllSectionOrders
        },'-','-','-',
        {
            xtype : 'button',
            iconCls: 'copy',
            text : 'Copy Order',
            handler: function(){
                var sm = orderGrid.getSelectionModel();
                var sel = sm.getSelections();
                if(sel.length == 0) {
                    Ext.Msg.alert('Select Taluka Order To Copy', 'No Taluka Order is selected!');
                    return;
                }
                selectedTalukaOrderID = sel[0].get('orderID');
                if(selectedTalukaOrderID == 0) {
                    Ext.Msg.alert('Copy Order', 'Click on <b>Edit Order</b> and Save pending Information!');
                    return;
                }
                selectedTalukaOrderDetailID = sel[0].get('talukaOrderDetailID');

                if(selectedTalukaOrderDetailID != 0 ) {
                    Ext.Msg.alert('Copy Order', 'Taluka Order Already Exists...');
                    return;
                }
                
                //var selDistOrderID = sel[0].get('orderID');
                selTalukaID = sel[0].get('talukaID');
                selRationVersion = sel[0].get('rationVersion');
                
                getCopyTalukaOrderWin();
                talukaOrderList.removeAll();
                talukaOrderList.load({
                    params:{
                        talukaID : selTalukaID
                    }
                });
                copyFrm.getForm().reset();
                copyTalukaOrderWin.show();
                
            }
        },'-','-','-',
        '->',{
            iconCls: 'report',
            text: 'तालुका गोषवारा ',
            handler: function(){
                var sm = orderGrid.getSelectionModel();
                var sel = sm.getSelections();
                if(sel.length == 0) {
                    Ext.Msg.alert('Select Order', 'No order is selected!');
                    return;
                }
                var id = sel[0].get('orderID');
                var talukaID = sel[0].get('talukaID');
                var rationVersion = sel[0].get('rationVersion');

                var param = "orderID="+id+"&talukaID="+talukaID+"&rationVersion="+rationVersion;

                window.open("reports/taluka-report.jsp?"+param,'talukareport',"width=1500,height=800,top=40,left=60,menubar=1,resizable=0,location=1,scrollbars=1");
            }

        },'-',{
            iconCls: 'report',
            text: 'तालुका लोडींग गोषवारा',
            handler: function(){
                var sm = orderGrid.getSelectionModel();
                var sel = sm.getSelections();
                if(sel.length == 0) {
                    Ext.Msg.alert('Select Order', 'No order is selected!');
                    return;
                }
                var id = sel[0].get('orderID');
                var talukaID = sel[0].get('talukaID');
                var rationVersion = sel[0].get('rationVersion');
                
                var param = "orderID="+id+"&talukaID="+talukaID+"&rationVersion="+rationVersion;
                
                window.open("reports/taluka-loading-report.jsp?"+param,'talukaloadingreport',"width=1500,height=800,top=40,left=60,menubar=1,resizable=0,location=1,scrollbars=1");
            }
        }, '-',{
            iconCls: 'bill',
            text: 'बिल बनवा',
            handler: function(){
                var sm = orderGrid.getSelectionModel();
                var sel = sm.getSelections();
                if(sel.length == 0) {
                    Ext.Msg.alert('Select Order', 'No order is selected!');
                    return;
                }
                getBillDatePreviewWin();
                previewId = sel[0].get('orderID');
                previewTalukaID = sel[0].get('talukaID');

                talukaInvoiceDate = sel[0].get('talukaInvoiceDate');

                previewParam = "orderID="+previewId+"&talukaID="+previewTalukaID;
                Ext.getCmp('billPreviewDate').reset();
                Ext.getCmp('billPreviewDate').setValue(talukaInvoiceDate);
                billDatePreviewWin.show();
            }
        },'-',{
            iconCls: 'edit',
            text: 'Edit Order',
            handler: function(){

                var sm = orderGrid.getSelectionModel();
                var sel = sm.getSelections();
                if(sel.length == 0) {
                    Ext.Msg.alert('Select Order', 'No order is selected!');
                //return;
                }
                selectedTalukaOrderID  = sel[0].get('orderID');
                selectedTalukaID = sel[0].get('talukaID');
                editTalukaOrderForm.getForm().reset();
                if(selectedTalukaOrderID !== 0){
                    editTalukaOrderForm.getForm().load({
                        waitMsg:'Loading...',
                        params:{
                            orderID:selectedTalukaOrderID
                        },
                        url : 'read/get-order.jsp'
                    });
                }

                openEditOrderWin();
                wn.show();
            }
        }],

        columns: [new Ext.grid.RowNumberer(),{
            header: '<b>ऑर्डर क्र.</b>',
            width: 120,
            sortable: true,
            dataIndex: 'govOrderNumber',
            align: 'center',
            renderer : paintNull
        }, {
            header: '<b>ऑर्डर दिनांक</b>',
            width: 100,
            sortable: true,
            dataIndex: 'govOrderDate',
            align: 'center',
            renderer : paintNull
        }, {
            header: 'तालुका',
            width: 100,
            sortable: true,
            // renderer: change,
            dataIndex: 'taluka',
            align: 'center'
        }, {
            header: 'माहे',
            width: 120,
            sortable: true,
            //renderer: change,
            dataIndex: 'fromMonth',
            align: 'center',
            renderer : paintNull
        }, {
            header: 'वर्षे',
            width: 50,
            sortable: true,
            //renderer: pctChange,
            dataIndex: 'fromYear',
            align: 'center',
            renderer : paintNull
        }, {
            header: 'ते माहे',
            width: 120,
            sortable: true,
            // renderer: pctChange,
            dataIndex: 'toMonth',
            align: 'center',
            renderer : paintNull
        }, {
            header: 'ते वर्षे',
            width: 50,
            sortable: true,
            //renderer: pctChange,
            dataIndex: 'toYear',
            align: 'center',
            renderer : paintNull
        }],
        height: 500,
        width: 700,
        // paging bar on the bottom
        bbar: [{}]
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

    editDistrictOrderForm = new Ext.FormPanel({
        labelAlign: 'right',
        frame:true,
        id: 'edit-d-o-form',
        autoDestroy : true,
        layout:'fit',
        buttonAlign: 'center',
        items: [{
            layout:'form',
            items:[{
                columnWidth:.50,
                layout: 'form',
                items: [{
                    xtype:'datefield',
                    fieldLabel: 'District Order Date',
                    id:'edit-d-o-form-d',
                    allowBlank: false,
                    editable:false,
                    format: 'd/m/Y',
                    name: 'orderDate',
                    hiddenName : 'orderDate',
                    anchor:'95%'
                }, {
                    xtype:'numberfield',
                    fieldLabel: 'Order Number',
                    id:'edit-d-o-form-on',
                    allowBlank: false,
                    allowNegative: false,
                    name: 'orderNumber',
                    hiddenName : 'orderNumber',
                    anchor:'95%'
                }, {
                    xtype:'textfield',
                    id:'edit-d-o-form-n',
                    fieldLabel: 'District Order Number',
                    allowBlank: false,
                    name: 'districtGovOrderID',
                    hiddenName : 'districtGovOrderID',
                    anchor:'95%'
                }, {
                    xtype:'hidden',
                    id:'edit-d-o-form-h',
                    allowBlank: false,
                    name: 'orderID',
                    hiddenName : 'orderID',
                    anchor:'95%'
                }, {
                    xtype:'hidden',
                    id:'edit-d-o-form-hdID',
                    allowBlank: false,
                    name: 'districtID',
                    hiddenName : 'districtID',
                    anchor:'95%'
                }
                ]
            }]
        }],
        buttons: [{
            text: 'Save',
            scale: 'medium',
            handler: function(){
                editDistrictOrderForm.getForm().submit({
                    url: 'update/update-district-order.jsp',
                    method: 'POST',
                    success: function(form, action){
                        aDOStore.reload({
                            waitMsg:'Loading...'
                        });

                        Ext.Msg.alert('Success', 'District order updated');
                    },
                    failure: function(form, action){
                        Ext.Msg.alert('Warning', 'District order already Exists');
                    }
                });
            }
        }]
    });

    openEdit = function()
    {
        win = new Ext.Window({
            layout:'fit',
            width:400,
            modal: true,
            height:200,
            iconCls: 'edit',
            closeAction:'hide',
            title : "Edit District Order",
            plain: true,
            items : [
            {
                layout :"border",
                items :[{
                    region:"center",
                    layout:'fit',
                    items:[editDistrictOrderForm]
                }
                ]
            }
            ]
        });
        win.show(this);
    };

    createChallanForm = new Ext.FormPanel({
        labelAlign: 'right',
        frame:true,
        border :false,
        id: 'edit-d-o-form',
        autoDestroy : true,
        layout:'fit',
        buttonAlign: 'center',
        items: [{
            layout: 'form',
            items: [{
                xtype:'datefield',
                fieldLabel: 'Select Challan Date',
                id:'challanDate',
                allowBlank: false,
                editable:false,
                format: 'd/m/Y',
                name: 'challanDate',
                hiddenName : 'challanDate',
                anchor:'95%'
            }
            ]
        }]
    });

    createChallans = function(schoolOrderStore){
        var sm = orderSectionsGrid.getSelectionModel();
        var sel = sm.getSelections();
        if(sel.length == 0) {
            Ext.Msg.alert('Select Section', 'No section is selected!');
            return;
        }
        createChallanForm.getForm().reset();
        win = new Ext.Window(
        {
            layout:'fit',
            width:350,
            modal: true,
            height:150,
            iconCls: 'edit',
            closeAction:'hide',
            title : "Create Challans",
            plain: true,
            buttonAlign: 'center',
            items : [
            {
                layout :"border",
                items :[{
                    region:"center",
                    layout:'fit',
                    items:[createChallanForm]
                }
                ]
            }
            ],
            buttons: [{
                text: 'Create Challans',
                scale: 'medium',
                handler: function(){                 
                    var oID = sel[0].get('orderID');
                    if( oID == 0) {
                        Ext.Msg.alert('Error in creating challans', 'Please <b>ऑर्डर पूर्ण करा</b> before you create challans!');
                        return;
                    }
                    var sID = sel[0].get('sectionID');
                    createChallanForm.getForm().submit({
                        url: 'create/create-challans.jsp',
                        method: 'POST',
                        params: {
                            sectionID: sID ,
                            orderID : oID
                        },
                        success: function(resp,opt) {
                            schoolOrderStore.reload({
                                waitMsg:'Loading...'
                            });
                            Ext.Msg.alert('Challan created', 'Challan date and challan number has been created.<br> To check, please click on <b>ऑर्डर पूर्ण करा</b>!');
                        },
                        failure: function(resp,opt) {
                            Ext.Msg.alert('Error', 'Error in creating challan!');
                        }
                    });
                }
            }]
        });
        win.show(this);
    };

    newDistrictOrderForm = new Ext.FormPanel({
        labelAlign: 'right',
        frame:true,
        id: 'new-district-order-form',
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
                    editable:false,
                    id:'t-of-ds-combo',
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
                    msgTarget : 'side',
                    blankText: 'Correct this field',
                    anchor:'95%'
                }, {
                    xtype:'datefield',
                    fieldLabel: 'Order Date',
                    id:'order-date',
                    allowBlank: false,
                    editable:false,
                    format: 'd/m/Y',
                    name: 'orderDate',
                    hiddenName : 'orderDate',
                    msgTarget : 'side',
                    blankText: 'Correct this field',
                    anchor:'95%'
                }, {
                    xtype:'numberfield',
                    fieldLabel: 'Order Number',
                    id:'order-number',
                    allowBlank: false,
                    name: 'orderNumber',
                    hiddenName : 'orderNumber',
                    allowNegative: false,
                    msgTarget : 'side',
                    blankText: 'Correct this field',
                    anchor:'95%'
                }, {
                    xtype:'textfield',
                    fieldLabel: 'Gov order ref. Number',
                    id:'gov-order-number',
                    allowBlank: false,
                    name: 'govOrderNumber',
                    hiddenName : 'govOrderNumber',
                    msgTarget : 'side',
                    blankText: 'Correct this field',
                    anchor:'95%'
                }
                ]
            }]
        }],
        buttons: [{
            text: 'Save',
            scale: 'medium',
            handler: function(){
                newDistrictOrderForm.getForm().submit({
                    url: 'create/create-district-order.jsp',
                    method: 'POST',
                    success: function(form, action){
                        aDOStore.load();
                        //aDOGrid.getSelectionModel().selectFirstRow();
                        //newDistrictOrderForm.hide();
                        newDistrictOrderForm.getForm().reset();

                        Ext.Msg.alert('Success', 'District Order Created');
                    },
                    failure: function(form, action){
                        if(action.response != undefined) {
                            Ext.Msg.alert('Warning', 'Order already exists');
                        }
                        else{
                            Ext.MessageBox.alert('Alert...', 'Enter Data Correctly...');
                        }
                    }
                });
            }
        },{
            text: 'Clear',
            scale: 'medium',
            handler: function(){}
        }]
    });

    openDistrictOrderWin = function(){
        var wn = new Ext.Window({
            layout:'fit',
            width:400,
            modal: true,
            height:220,
            iconCls: 'add',
            closeAction:'hide',
            title : 'New District Order',
            plain: true,
            items : [
            {
                layout :"border",
                items :[{
                    region:"center",
                    layout:'fit',
                    items:[newDistrictOrderForm]
                }]
            }
            ]
        });
        wn.show(this);
    };

    editTalukaOrderForm = new Ext.FormPanel({
        labelAlign: 'right',
        frame:true,
        //closeAction : 'hide',
        id: 'edit-order-form',
        //autoDestroy : true,
        layout:'fit',
        buttonAlign: 'center',
        items: [{
            layout:'column',
            items:[{
                columnWidth:.50,
                layout: 'form',
                items: [{
                    xtype:'combo',
                    id:'t-eof-fm-combo',
                    store: monthStore,
                    allowBlank: false,
                    displayField : 'mm' ,
                    valueField: 'id',
                    mode :'local',
                    forceSelection : true,
                    triggerAction : 'all',
                    selectOnFocus :true,
                    editable:false,
                    name : 'fromMonth',
                    hiddenName : 'fromMonth',
                    fieldLabel: 'माहे',
                    anchor:'95%'
                }, {
                    xtype:'combo',
                    store: monthStore1,
                    id:'t-eof-tm-combo',
                    allowBlank: false,
                    displayField : 'mm' ,
                    valueField: 'id',
                    mode :'local',
                    forceSelection : true,
                    triggerAction : 'all',
                    selectOnFocus :true,
                    editable:false,
                    anchor:'95%',
                    hiddenName : 'toMonth',
                    fieldLabel: 'ते माहे',
                    name: 'to'
                }, {
                    xtype:'datefield',
                    id:'t-eof-od-date',
                    fieldLabel: 'तालूका ऑर्डर दिनांक',
                    labelWidth: 150,
                    allowBlank: false,
                    editable:false,
                    format: 'd/m/Y' ,
                    name: 'govOrderDate',
                    hiddenName : 'orderDate',
                    anchor:'95%'
                }]
            },{
                columnWidth:.50,
                layout: 'form',
                items: [{
                    xtype:'combo',
                    id:'t-eof-fy-combo',
                    allowBlank: false,
                    forceSelection : true,
                    triggerAction : 'all',
                    selectOnFocus :true,
                    editable:false,
                    store: yearStore,
                    displayField : 'yearMarathi' ,
                    valueField: 'year',
                    fieldLabel: 'वषे',
                    name: 'fromYear',
                    hiddenName : 'fromYear',
                    anchor:'95%'
                }, {
                    xtype:'combo',
                    id:'t-eof-ft-combo',
                    allowBlank: false,
                    forceSelection : true,
                    triggerAction : 'all',
                    selectOnFocus :true,
                    editable:false,
                    store: yearStore,
                    displayField : 'yearMarathi' ,
                    valueField: 'year',
                    fieldLabel: 'ते वषे',
                    name: 'toYear',
                    hiddenName : 'toYear',
                    anchor:'95%'
                }, {
                    xtype:'textfield',
                    id:'t-eof-on-textf',
                    fieldLabel: 'तालूका ऑर्डर क्र.',
                    allowBlank: false,
                    name: 'govOrderNumber',
                    hiddenName : 'orderNumber',
                    anchor:'95%'
                }]
            }]
        }],
        buttons: [{
            text: 'Save',
            scale: 'medium',
            handler: function(){
                editTalukaOrderForm.getForm().submit({
                    url: 'update/update-taluka-order.jsp',
                    method: 'POST',
                    params : {
                        districtOrderID : selectedDistrictOrderID,
                        talukaOrderID : selectedTalukaOrderID  ,
                        talukaID : selectedTalukaID
                    },
                    success: function(form, action){
                        aOStore.reload({
                            waitMsg:'Loading...'
                        });
                        Ext.Msg.hide();
                        editTalukaOrderForm.getForm().reset();
                        //  win.hide();
                        Ext.Msg.alert('Success', 'Order Saved');
                    },
                    failure: function(form, action){
                        Ext.Msg.alert('Warning', 'Taluka Order Already Exists...');
                    }
                });
            }
        },{
            text: 'Cancel',
            scale: 'medium',
            handler: function(){
                wn.hide();
            }
        }]
    });

    openEditOrderWin = function(){
        if (Ext.type(wn)) {
            return wn;
        }

        wn = new Ext.Window({
            layout:'fit',
            id : 'editordrwin',
            width:900,
            modal: true,
            height:200,
            iconCls: 'edit',
            closeAction:'hide',
            //autoDestroy : true,
            title : 'Edit',
            plain: true,
            items : [
            {
                layout :"border",
                items :[{
                    region:"center",
                    layout:'fit',
                    items:[editTalukaOrderForm]
                }
                ]
            }
            ]
        });

        
        //wn.show(this);
        return(wn);
    //editTalukaOrderForm.getForm().reset();
    };

    viewport = new Ext.Viewport({
        layout: 'border',
        bodyStyle: 'padding:5px;',
        bodyStyle: 'padding:5px;',
        items: [
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
            activeTab: 0,
            items: [{
                title: 'सर्व जिल्हा ऑर्डर ',
                iconCls: 'home',
                autoScroll: true,
                id: "tab0",
                layout: 'border',
                items: [{
                    region: "center",
                    bodyStyle: 'padding:5px;',
                    layout: "fit",
                    items: [aDOGrid]
                }]
            },{
                title: 'सर्व तालूका ऑर्डर ',
                iconCls: 'home',
                autoScroll: true,
                id: "tab1",
                layout: 'border',
                items: [{
                    region: "center",
                    bodyStyle: 'padding:5px;',
                    layout: "fit",
                    items: [orderGrid]
                }]
            },{
                title: 'सर्व विभाग ऑर्डर',
                iconCls: 'home',
                autoScroll: true,
                id: "tab2",
                layout: 'border',
                items: [{
                    region: "center",
                    bodyStyle: 'padding:5px;',
                    layout: "fit",
                    items :  orderSectionsGrid
                }]
            },{
                title: 'सर्व बिल्स',
                iconCls: 'home',
                autoScroll: true,
                id: "tab3",
                layout: 'border',
                items: [{
                    region: "center",
                    bodyStyle: 'padding:5px;',
                    layout: "fit",
                    items :  invoiceGrid
                }]
            }
            ]
        })]
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