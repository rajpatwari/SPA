/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

Ext.BLANK_IMAGE_URL = './resources/images/default/s.gif';
var fromYear;
var toYear;
var yr;
var id;

Ext.onReady(function()
{
     /* Javascript code to get Current Date */
    var currentTime = new Date();
    var month = currentTime.getMonth() + 1;
    var day = currentTime.getDate();
    var year = currentTime.getFullYear();
    today = (day + "/" + month + "/" + year);

    var reader= new Ext.data.JsonReader(
    {
        root: 'root',
        idProperty : 'inwardId',
        totalProperty: 'totalElements',
        fields:
        [
            'inwardId',
            'itemId',
            'itemMarathi',
            'supplierId',
            'supplierName',
            'qtyInKG',
            'inwardDate',
            'truckNo',
            'bag'
        ],
        sortInfo: 
        {
            field:'inwardId',
            direction:'DESC'
        }
    });
    //end

    allInwardMaterialReceiveStore= new Ext.data.GroupingStore(
    {
         autoLoad: true,
         reader: reader,
         baseParams : { start : 0, limit : 25 },
         groupField : 'supplierName',
         storeId: 'allInwardMaterialReceiveStore',
         totalProperty: 'totalElements',
         url: 'read/get-all-inward-material-receive.jsp'
    });
    
    allSupplierStore= new Ext.data.JsonStore(
    {
        autoLoad: false,
        storeId: 'allSupplierStore',
        url: 'read/get-all-supplier.jsp',
        root: 'root',
        idProperty : 'supplierID',
        fields: ['supplierID','supplierName'],
        sortInfo:
        {
            field:'supplierID',
            direction:'DESC'
        }
    });
    
    allItemStore= new Ext.data.JsonStore(
    {
        autoLoad: false,
        storeId: 'allItemStore',
        url: 'read/get-all-items.jsp',
        root: 'root',
        idProperty : 'itemId',
        fields: ['itemId','itemMarathi'],
        sortInfo:
        {
            field:'itemId',
            direction:'DESC'
        }
    });
         
    addInwardMaterialForm = new Ext.FormPanel(
    {
        labelAlign: 'right',
        labelWidth : 150,
        frame:true,
        id: 'ad-form',
        autoDestroy : true,
        layout:'fit',
        buttonAlign: 'center',
        items: [
        {
            layout:'form',
            items:[
            {
                columnWidth:.50,
                layout: 'form',
                items: [
                {
                    xtype:'datefield',
                    fieldLabel: 'Received Date',
                    id:'rdate',
                    allowBlank: false,
                    name: 'rdate',
                    msgTarget : 'side',
                    blankText : 'Correct This field',
                    anchor:'90%',
                    hiddenName : 'rdate'
                },
                {
                    xtype:'textfield',
                    fieldLabel: 'Truck Number',
                    id:'tno',
                    allowBlank: false,
                    name: 'tno',
                    msgTarget : 'side',
                    blankText : 'Correct This field',
                    hiddenName : 'tno',
                    anchor:'90%',
                    selectOnFocus:true
                },
                {
                    xtype:'combo',
                    id: 'supplier-combo',
                    fieldLabel: 'Select Supplier',
                    hiddenName: 'supplier-combo',
                    emptyText: 'Select Supplier',
                    store: allSupplierStore,
                    displayField: 'supplierName',
                    valueField: 'supplierID',
                    selectOnFocus: true,
                    mode: 'local',
                    typeAhead: true,
                    editable: false,
                    triggerAction: 'all',
                    anchor:'90%'
                },
                {
                    xtype:'combo',
                    id: 'inward-item-combo',
                    fieldLabel: 'Select Inward Item',
                    hiddenName: 'inward-item-combo',
                    emptyText: 'Select Item Material',
                    store: allItemStore,
                    displayField: 'itemMarathi',
                    valueField: 'itemId',
                    selectOnFocus: true,
                    mode: 'local',
                    typeAhead: true,
                    editable: false,
                    triggerAction: 'all',
                    anchor:'90%'
                },
                {
                    xtype:'numberfield',
                    fieldLabel: 'Total Bag',
                    id:'tbag',
                    allowBlank: false,
                    name: 'tbag',
                    msgTarget : 'side',
                    blankText : 'Correct This field',
                    hiddenName : 'tbag',
                    anchor:'90%',
                    allowNegative: false,
                    allowDecimals:false,
                    decimalPrecision:0,
                    minValue: 1,
                    maxValue:999999,
                    selectOnFocus:true
                },
                {
                    xtype:'numberfield',
                    fieldLabel: 'Quantity in KG',
                    id:'quantity',
                    allowBlank: false,
                    name: 'quantity',
                    msgTarget : 'side',
                    blankText : 'Correct This field',
                    hiddenName : 'quantity',
                    anchor:'90%',
                    allowNegative: false,
                    allowDecimals:true,
                    minValue: 1,
                    decimalPrecision:3,
                    maxValue:999999.99,
                    selectOnFocus:true
                }]
            }]
        }],
        buttons: [
        {
            text: 'Save',
            scale: 'medium',
           // iconCls:'save',
            height:'25',
            handler: function()
            {
                addInwardMaterialForm.getForm().submit(
                {
                    url: 'create/add-inward-master.jsp',
                    method: 'POST',
                    success: function(form, action)
                    {
                        Ext.Msg.alert('Success', 'Inward Material Saved');
                        allInwardMaterialReceiveStore.reload(
                        {
                            waitMsg:'Loading....'
                        });
                    },
                    failure: function(form, action)
                    {
                        if(action.response != undefined)
                        {
                            Ext.Msg.alert('Warning', 'Inward Material Already Exists');
                        }
                        else
                        {
                            Ext.Msg.alert('Alert...', 'Enter Details Correctly...');
                        }

                    }
                });
            }
        },
        {
            text: 'Clear',
            scale: 'medium',
            iconCls:'clear',
            height:'25',
            handler: function()
            {
                addInwardMaterialForm.getForm().reset();
            }
        }]
    });
    
    // Edit Inward Form
    editInwardMaterialForm = new Ext.FormPanel(
    {
        labelAlign: 'right',
        labelWidth : 150,
        frame:true,
        id: 'e-form',
        autoDestroy : true,
        layout:'fit',
        buttonAlign: 'center',
        items: [
        {
            layout:'form',
            items:[
            {
                columnWidth:.50,
                layout: 'form',
                items: [
                {
                    xtype:'datefield',
                    id:'ermDate',
                    fieldLabel: 'Received Date',
                    allowBlank: false,
                    name: 'ermDate',
                    msgTarget : 'side',
                    blankText : 'Correct This field',
                    hiddenName : 'ermDate',
                    anchor:'90%'
                },
                {
                    xtype:'textfield',
                    fieldLabel: 'Truck Number',
                    id:'etno',
                    allowBlank: false,
                    name: 'etno',
                    msgTarget : 'side',
                    blankText : 'Correct This field',
                    hiddenName : 'etno',
                    anchor:'90%',
                    selectOnFocus:true
                },
                {
                    xtype:'numberfield',
                    fieldLabel: 'Total Bag',
                    id:'etbag',
                    allowBlank: false,
                    name: 'etbag',
                    msgTarget : 'side',
                    blankText : 'Correct This field',
                    hiddenName : 'etbag',
                    anchor:'90%',
                    allowNegative: false,
                    allowDecimals:false,
                    minValue: 1,
                    decimalPrecision:0,
                    maxValue:999999,
                    selectOnFocus:true
                },
                {
                    xtype:'numberfield',
                    fieldLabel: 'Quantity In KG',
                    id:'ermWeight',
                    allowBlank: false,
                    name: 'ermWeight',
                    msgTarget : 'side',
                    blankText : 'Correct This field',
                    hiddenName : 'ermWeight',
                    anchor:'90%',
                    allowNegative: false,
                    allowDecimals:true,
                    minValue: 1,
                    decimalPrecision:3,
                    maxValue:999999.99,
                    selectOnFocus:true
                },
                {
                    xtype:'hidden',
                    name: 'ermId',
                    id:'ermId'
                }]
            }]
        }],
        buttons: [
        {
            text: 'Update',
            scale: 'medium',
            height:'25',
            handler: function()
            {
                editInwardMaterialForm.getForm().submit(
                {
                    url: 'update/update-inward.jsp',
                    method: 'POST',
                    success: function(form, action)
                    {
                        allInwardMaterialReceiveStore.reload(
                        {
                            waitMsg:'Loading...'
                        });
                        Ext.Msg.alert('Success', 'Inward Material updated');
                    },
                    failure: function(form, action)
                    {
                        if(action.response != undefined)
                        {
                            Ext.Msg.alert('Warning', 'Inward Material Already Exists');
                        }
                        else
                        {
                            Ext.Msg.alert('Alert...', 'Enter Details Correctly...');
                        }
                    }
                });
            }
        }]
    });
      
    // create the Grid
    imGrid = new Ext.grid.GridPanel(
    {
        store: allInwardMaterialReceiveStore,
        id: 'imGrid',
        stripeRows: true,
        loadMask: true,
        columnLines: true,
        stateful: true,
        stateId: 'rmGrid',
        applyState: function(state)     
        {
            if (state) 
            {
                var newState = Ext.apply({}, state);
                delete newState['sort'];
                Ext.apply(this, newState );
            }
        },
        tbar:[
        {
            text: 'Add Inward Material',
            iconCls: 'add',
            handler : function()
            {
                allSupplierStore.load();
                allItemStore.load();
                addInwardMaterialForm.getForm().reset();
                openWin(addInwardMaterialForm, 'Inward Material',300,400);
            }

        },'-',
        {
            text: 'Edit Inward Material',
            iconCls: 'edit',
            handler : function()
            {
                var sm = imGrid.getSelectionModel();
                var sel = sm.getSelections();
                if(sel.length == 0)
                {
                    Ext.Msg.alert('Warning','No Inward Material is selected.');
                    return;
                }

                var inwardId = sel[0].get('inwardId');
                var ermDate = sel[0].get('inwardDate');
                var ermqty = sel[0].get('qtyInKG');

                Ext.getCmp('ermId').setValue(inwardId);
                Ext.getCmp('ermDate').setValue(ermDate);
                Ext.getCmp('ermWeight').setValue(ermqty);
                Ext.getCmp('etno').setValue(sel[0].get('truckNo'));
                Ext.getCmp('etbag').setValue(sel[0].get('bag'));

                openEdit(editInwardMaterialForm, 'Inward Material',200,350);
            }
        },'-',
        {
            text:'Delete',
            iconCls:'delete',
            scale:'medium',
            height:'25',
            handler : function()
            {
                var sm = imGrid.getSelectionModel();
                var sel = sm.getSelections();
                if(sel.length == 0)
                {
                    Ext.Msg.alert('Warning','No Inward Details is selected.');
                    return;
                }
                var inwardId = sel[0].get('inwardId');
                var itemMarathi = sel[0].get('itemMarathi');
                var supplierName = sel[0].get('supplierName');
                var ermqty = sel[0].get('qtyInKG');
                Ext.MessageBox.show(
                {
                   title: 'Confirm Delete',
                   msg: 'Do you want to delete '+itemMarathi+' Inward Material From : <b>'+ supplierName + '</b> with Quantiry : <b>'+ ermqty + '</b>',
                   buttons: Ext.MessageBox.YESNO,
                   fn: function(btn)
                   {
                       if(btn == "yes")
                       {
                           Ext.Ajax.request(
                           {
                               url: 'delete/delete-inward.jsp',
                               method:'POST',
                               params:
                               {
                                   inwardId : inwardId
                               },
                               success: function()
                               {
                                    Ext.Msg.alert("Deleted",'Inward Material Deleted');
                                    allInwardMaterialReceiveStore.reload(
                                    {
                                        waitMsg: 'Loading...'
                                    });
                               },
                               failure: function()
                               {
                                    Ext.Msg.alert("Error",'Error in deleting');
                               }
                           });
                         }
                      }
                   });
                }
            }],
            columns: [
            {
                id       :'imsID',
                header   : 'Inward No',
                width    : 80,
                sortable : true,
                dataIndex: 'inwardId',
                hidden : false
            },
            {
                header   : 'Received Date',
                width    :120,
                sortable : true,
                dataIndex: 'inwardDate'
            },
            {
                header   : 'Truck No',
                width    : 120,
                sortable : true,
                dataIndex: 'truckNo'
            },
            {
                id       : 'mID',
                header   : 'Material ID',
                width    : 80,
                sortable : true,
                dataIndex: 'itemId',
                hidden : true
            },
            {
                id       : 'mID',
                header   : 'Material Name',
                width    : 120,
                sortable : true,
                dataIndex: 'itemMarathi'
            },
            {
                header   : 'Supplier Id',
                width    :120,
                sortable : true,
                dataIndex: 'supplierId',
                hidden : true
            },
            {
                header   : 'Supplier Name',
                width    :120,
                sortable : true,
                dataIndex: 'supplierName'
            },
            {
                header   : 'Bags',
                width    : 120,
                sortable : true,
                dataIndex: 'bag'
            },
            {
                header   : 'Quantity Recived',
                width    : 120,
                sortable : true,
                dataIndex: 'qtyInKG'
            }
        ],
        width:200,
        height:500,
        title: 'Inward Material Master',
        view: new Ext.grid.GroupingView(
        {
            showGroupName: true,
            enableNoGroups: false,
            enableGroupingMenu: true,
            hideGroupedColumn: true
        }),/*
        bbar: [new Ext.PagingToolbar(
        {
            pageSize: 25,
            store: allInwardMaterialReceiveStore,
            displayInfo: true,
            displayMsg: '<b>Displaying Dispatch {0} - {1} of {2}</b>',
            emptyMsg: "No topics to display"
        })*/
        bbar: new Ext.PagingToolbar(
        {
            pageSize: 25,
            store: allInwardMaterialReceiveStore,
            displayInfo: true,
            displayMsg: 'Displaying results {0} - {1} of {2}',
            emptyMsg: "No results to display"
        })
    });


    // Start - Creates a tab panel and adding each grid content to its items to show it on tab panel
    var mainTab = new Ext.TabPanel(
    {
        id: 'main-tab-pane',
        autoTabs: true,
        activeTab:0,
        autoScroll:true,
        border: false,
        items: [imGrid]
    });

    viewport = new Ext.Viewport (
    {
        layout : 'border',
        bodyStyle: 'padding:5px;',
        items:[
        new Ext.BoxComponent(
        {
            region: 'north',
            height: 50,
            contentEl: 'el1'
        }),
        {
            id:'centerpanel',
            region:'center',
            height:'autoHeight',
            items:[mainTab]
        }]
    });





/*



    // reader
    

    

   


    







    openWin = function(form, Title, ht, width)
    {
        var winTitle = ("Enter " +Title );
        var win = new Ext.Window(
        {
            layout:'fit',
            width:width,
            modal: true,
            height:ht,
            iconCls: 'add',
            closeAction:'hide',
            title : winTitle,
          //  plain: true,
            items : [
            {
                layout :"border",
                items :[{
                        region:"center",
                        layout:'fit',
                        items:[form]
                    }
                ]
            }]
        });

        win.show(this);
    }
    //End - openWin function to open small window




    //Start - openEdit function to open window to edit data
    openEdit = function(form, Title, ht,width)
    {
        var tit = ("Edit " +Title );
        var win = new Ext.Window(
        {
            layout:'fit',
            width:width,
            modal: true,
            height:ht,
            iconCls: 'edit',
            closeAction:'hide',
            title : tit,
            plain: true,
            items : [
            {
                layout :"border",
                items :[{
                        region:"center",
                        layout:'fit',
                        items:[form]
                    }
                ]
            }]
        });
        win.show(this);
    }
    //End - openEdit function to open window to edit data

*/

});
