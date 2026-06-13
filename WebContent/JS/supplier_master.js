Ext.BLANK_IMAGE_URL = './resources/images/default/s.gif';
Ext.onReady(function()
{
    /* Javascript code to get Current Date */
    var currentTime = new Date();
    var month = currentTime.getMonth() + 1;
    var day = currentTime.getDate();
    var year = currentTime.getFullYear();
    today = (day + "/" + month + "/" + year);

    // Get all Supplier Details Store
    allSupplierStore= new Ext.data.JsonStore(
    {
        autoLoad: true,
        storeId: 'allSupplierStore',
        url: 'read/get-all-supplier.jsp',
        root: 'root',
        idProperty : 'supplierID',
        totalProperty: 'totalElements',
        fields: ['supplierID','supplierName','supplierAddress','contactNum','tin','cst'],
        sortInfo: 
        {
            field:'supplierID',
            direction:'DESC'
        }
    });

    // ADD Supplier Form
    addSupplierForm = new Ext.FormPanel(
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
                    xtype:'textfield',
                    id:'sName',
                    name:'sName',
                    fieldLabel: 'Supplier Name',
                    allowBlank: false,
                    msgTarget : 'side',
                    blankText : 'Correct This field',
                    hiddenName : 'sName',
                    anchor:'95%'
                },{
                    xtype:'textarea',
                    fieldLabel: 'Supplier Address',
                    id:'sAddress',
                    allowBlank: false,
                    name: 'sAddress',
                    msgTarget : 'side',
                    blankText : 'Correct This field',
                    hiddenName : 'sAddress',
                    anchor:'95%'
                },{
                    xtype:'numberfield',
                    fieldLabel: 'Contact Number',
                    id:'sContact',
                    allowBlank: false,
                    name: 'sContact',
                    msgTarget : 'side',
                    blankText : 'Correct This field',
                    hiddenName : 'sContact',
                    anchor:'95%',
                    minLength:10,
                    maxLength:10
                },{
                    xtype:'textfield',
                    fieldLabel: 'Creation Date',
                    id:'s4',
                    allowBlank: false,
                    name: 'rate',
                    msgTarget : 'side',
                    blankText : 'Correct This field',
                    hiddenName : 'rate',
                    value : today,
                    disabled: true
                },{
                    xtype:'numberfield',
                    fieldLabel: 'TIN',
                    id:'sTIN',
                    allowBlank: false,
                    name: 'sTIN',
                    msgTarget : 'side',
                    blankText : 'Correct This field',
                    hiddenName : 'sTIN',
                    value : 0

                },{
                    xtype:'numberfield',
                    fieldLabel: 'CST',
                    id:'sCST',
                    allowBlank: false,
                    name: 'sCST',
                    msgTarget : 'side',
                    blankText : 'Correct This field',
                    hiddenName : 'sCST',
                    value : 0
                }]
            }]
        }],
        buttons: [
        {
            text: 'Save',
            scale: 'medium',
            iconCls:'save',
            height:'25',
            handler: function()
            {
                addSupplierForm.getForm().submit(
                {
                    url: 'create/add-supplier-master.jsp',
                    method: 'POST',
                    success: function(form, action)
                    {
                        Ext.Msg.alert('Success', 'Supplier Saved');
                        allSupplierStore.reload(
                        {
                            watMsg:'Loading....'
                        });
                    },
                    failure: function(form, action)
                    {
                        if(action.response != undefined)
                        {
                            Ext.Msg.alert('Warning', 'Supplier Already Exists');
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
                addSupplierForm.getForm().reset();
            }
        }]
    });
    
    //Edit Supplier Form
    editSupplierForm = new Ext.FormPanel(
    {
        labelAlign: 'right',
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
                    xtype:'textfield',
                    id:'esName',
                    fieldLabel: 'Supplier Name',
                    allowBlank: false,
                    name: 'esName',
                    msgTarget : 'side',
                    blankText : 'Correct This field',
                    hiddenName : 'esName'
                },{
                    xtype:'textfield',
                    fieldLabel: 'Supplier Address',
                    id:'esAddress',
                    allowBlank: false,
                    name: 'esAddress',
                    msgTarget : 'side',
                    blankText : 'Correct This field',
                    hiddenName : 'esAddress'
                },{
                    xtype:'numberfield',
                    fieldLabel: 'Contact Number',
                    id:'esContact',
                    allowBlank: false,
                    name: 'esContact',
                    msgTarget : 'side',
                    blankText : 'Correct This field',
                    hiddenName : 'esContact',
                    minLength:10,
                    maxLength:10
                },{
                    xtype:'textfield',
                    fieldLabel: 'Creation Date',
                    id:'set221',
                    allowBlank: false,
                    name: 'rate',
                    msgTarget : 'side',
                    blankText : 'Correct This field',
                    hiddenName : 'rate',
                    value : today

                },{
                    xtype:'textfield',
                    fieldLabel: 'TIN',
                    id:'esTIN',
                    allowBlank: false,
                    name: 'esTIN',
                    msgTarget : 'side',
                    blankText : 'Correct This field',
                    hiddenName : 'esTIN',
                    value : 0
                },{
                    xtype:'textfield',
                    fieldLabel: 'CST',
                    id:'esCST',
                    allowBlank: false,
                    name: 'esCST',
                    msgTarget : 'side',
                    blankText : 'Correct This field',
                    hiddenName : 'esCST',
                    value : 0
                },{
                    xtype:'hidden',
                    name: 'esId',
                    id:'esId'
                }]
            }]
        }],
        buttons: [
        {
            text: 'Update',
            scale: 'medium',
            iconCls:'update',
            height:'25',
            handler: function()
            {
                editSupplierForm.getForm().submit(
                {
                    url: 'update/update-supplier-master.jsp',
                    method: 'POST',
                    success: function(form, action)
                    {
                        allSupplierStore.reload(
                        {
                            waitMsg:'Loading...'
                        });
                        Ext.Msg.alert('Success', 'Supplier updated');
                    },
                    failure: function(form, action)
                    {
                        if(action.response != undefined)
                        {
                            Ext.Msg.alert('Warning', 'Supplier Already Exists');
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
    smGrid = new Ext.grid.GridPanel(
    {
        store: allSupplierStore,
        id: 'smGrid',
        stripeRows: true,
        loadMask: true,
        columnLines: true,
        stateId: 'smGrid',
        tbar:[
        {
            text: 'Add Supplier',
            iconCls: 'add',
            handler : function()
            {
            	addSupplierForm.getForm().reset();
                openWin(addSupplierForm, 'Supplier',350,400);
            }

        },'-',
        {
            text: 'Edit Supplier',
            iconCls: 'edit',
            handler : function(){
                var sm = smGrid.getSelectionModel();
                var sel = sm.getSelections();
                if(sel.length == 0)
                {
                    Ext.Msg.alert('Warning','No supplier is selected.');
                    return;
                }

                var supplier_id = sel[0].get('supplierID');
                var supplier_name = sel[0].get('supplierName');
                var supplier_address = sel[0].get('supplierAddress');
                var supplier_contact = sel[0].get('contactNum');                
                var supplier_tin = sel[0].get('tin');
                var supplier_cst = sel[0].get('cst');

                Ext.getCmp('esId').setValue(supplier_id);
                Ext.getCmp('esName').setValue(supplier_name);
                Ext.getCmp('esAddress').setValue(supplier_address);
                Ext.getCmp('esContact').setValue(supplier_contact);
                Ext.getCmp('esTIN').setValue(supplier_tin);
                Ext.getCmp('esCST').setValue(supplier_cst);

                openEdit(editSupplierForm, 'Supplier',290,400);
            }
        },'->',
        {
            text:'Delete',
            iconCls:'delete',
            scale:'medium',
            height:'25',
            handler : function()
            {
                var sm = smGrid.getSelectionModel();
                var sel = sm.getSelections();
                if(sel.length == 0)
                {
                    Ext.Msg.alert('Warning','No supplier is selected.');
                    return;
                }

                var supplier_id = sel[0].get('supplierID');
                var supplier_name = sel[0].get('supplierName');

               Ext.MessageBox.show({
               title: 'Confirm Delete',
               msg: 'Do you want to delete selected supplier: <b>'+ supplier_name + '</b>',
               buttons: Ext.MessageBox.YESNO,
               fn: function(btn)
               {
                   if(btn == "yes")
                   {
                       Ext.Ajax.request(
                       {
                           url: 'delete/delete-supplier.jsp',
                           method:'POST',
                           params:{supplier_id:supplier_id},
                           success: function()
                           {
                                Ext.Msg.alert("Deleted",'Supplier Deleted');
                                allSupplierStore.reload(
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
            id       :'sID',
            header   : 'Supplier ID',
            width    : 80,
            sortable : true,
            dataIndex: 'supplierID'
        },
        {
            header   : 'Supplier Name',
            width    :120,
            sortable : true,
            dataIndex: 'supplierName'
        },
        {
            header   : 'Address',
            width    : 120,
            sortable : true,
            dataIndex: 'supplierAddress'
        },
        {
            header   : 'Contact Number',
            width    : 120,
            sortable : true,
            dataIndex: 'contactNum'
        },
        {
            header   : 'TIN',
            width    : 120,
            sortable : true,
            dataIndex: 'tin'
        },
        {
            header   : 'CST',
            width    : 120,
            sortable : true,
            dataIndex: 'cst'
        }],
        width:200,
        height:500,
        title: 'Supplier Master',

        bbar: new Ext.PagingToolbar(
        {
            pageSize: 100,
            store: allSupplierStore,
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
        items: [smGrid]
    });
    // End - Creates a tab panel and adding each grid content to its items to show it on tab panel

    //Start - Divide screen into sections for frontend desgining
    viewport = new Ext.Viewport (
    {
        layout : 'border',
        bodyStyle: 'padding:5px;',
        items: 
        [
            new Ext.BoxComponent(
            {
                region: 'north',
                height: 60,
                contentEl: 'el1'
            }),
            {
            xtype:'panel',
            id:'westpanel',
            region:'west',
            autoScroll:true,
            height:100,
            layout:'fit',
            style:'left: 50px; top: 35px;width:220px;',
            items:[ getWestPanel()]
        },
        {
            id:'centerpanel',
            region:'center',
            height:'autoHeight',
            items:[mainTab]
        }]
     });
    //End - Divide screen into sections for frontend desgining

});