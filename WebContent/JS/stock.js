/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

var selOrderNumber;
var talukaOrderId;
var sel_taluka_id;
var sectionID;
var orderType;
var sectionMarathi;
var beatID;
var beatMarathi;

var talukaGovOrderNo;
var sel_taluka_name;
var selectedTalukaOrderDetailID;
var talukaOrderDetailId;
var selDistrictID;
var roles;
var districtOrderID;
var sampleGrid;
var tInvoiceID;
var getCopyTalukaOrderWin;
 

// Seeting for manual challan
var challanFlag = false;

getChallanFlag = function() 
{
 //   Ext.Msg.alert("flag :"+challanFlag);
    return challanFlag;
};
//end

Ext.BLANK_IMAGE_URL = './resources/images/default/s.gif';
Ext.onReady(function()
{
	//Start - Store get all district for order    
    var reader= new Ext.data.JsonReader(
    {
        root: 'root',
       // idProperty : 'stockDiffID',
        totalProperty: 'totalElements',
        fields: ['stockDiffID','stockDiffDate','diffType','diffTypeDetail',
                 'mungdaal','matki','mung','masuldaal','chvli','tel',
                 'mith','mirchi','halad','jire','mohari','tandul','harbara','vatana','extra1','extra2','extra3','extra4','extra5','extra6'],
        sortInfo:
        {
            field:'stockDiffID',
            direction:'ASC'
        }
    });
    //end
    
    allStockDifferanceStore= new Ext.data.GroupingStore(
    {
         autoLoad: true,
         reader: reader,
         groupField : 'diffTypeDetail',
         storeId: 'allStockDifferanceStore',
         url: 'read/get-all-stock-differance.jsp'
    });

    var diffTypeStore = new Ext.data.SimpleStore(
    {
        fields: [
        {
            name: 'diffType',
            type: 'int'
        },
        {
            name: 'text'
        }]
    });

    var diffTypeData = 
    [
        [1, 'Short'],
        [2, 'Extra']
    ];
    	
    diffTypeStore.loadData(diffTypeData);
    
    //Start - Create add district order form
    newStockDiffForm = new Ext.FormPanel(
    {
        labelAlign: 'right',
        frame:true,
        id: 'newStockDiffForm',
        autoDestroy : true,
        layout:'fit',
        buttonAlign: 'center',
        items: [
        {
            layout:'column',
            items:[
            {
                columnWidth:.50,
                layout: 'form',
                items: [                
                {
                    xtype:'datefield',
                    fieldLabel: '<b>Select Date</b>',
                    id:'selectDate',                    
                    editable:false,
                    format: 'd/m/Y',
                    name: 'selectDate',
                    hiddenName : 'selectDate',
                    allowBlank: false,
                    msgTarget : 'side',
                    blankText: 'Correct this field',
                    anchor:'90%'
                },
                {
                    xtype:'numberfield',
                    fieldLabel: '<b>तुरदाळ</b>',
                    id:'mungdaal',                    
                    allowNegative: false,
                    name: 'mungdaal',
                    hiddenName : 'mungdaal',
                    anchor:'90%'
                },
                {
                    xtype:'numberfield',
                    fieldLabel: '<b>तुर डाळ</b>',
                    id:'matki',                    
                    allowNegative: false,
                    name: 'matki',
                    hiddenName : 'matki',
                    anchor:'90%'
                },
                {
                    xtype:'numberfield',
                    fieldLabel: '<b>हरभरा</b>',
                    id:'mung',                    
                    allowNegative: false,
                    name: 'mung',
                    hiddenName : 'mung',
                    anchor:'90%'
                },
                {
                    xtype:'numberfield',
                    fieldLabel: '<b>मटकी</b>',
                    id:'masuldaal',                    
                    allowNegative: false,
                    name: 'masuldaal',
                    hiddenName : 'masuldaal',
                    anchor:'90%'
                },
                {
                    xtype:'numberfield',
                    fieldLabel: '<b>चवली</b>',
                    id:'chvli',                    
                    allowNegative: false,
                    name: 'chvli',
                    hiddenName : 'chvli',
                    anchor:'90%'
                },
                {
                    xtype:'numberfield',
                    fieldLabel: '<b>तेल</b>',
                    id:'tel',                    
                    allowNegative: false,
                    name: 'tel',
                    hiddenName : 'tel',
                    anchor:'90%'
                }]
            },
            {
                columnWidth:.50,
                layout: 'form',
                items: [   
                {
                    xtype: 'combo',
                    id: 'diffType',
                    anchor: '90%',
                    fieldLabel: 'Diffrance Type',
                    fields: ['diffType', 'text'],
                    store: diffTypeStore,
                    mode: 'local',
                    valueField: 'diffType',
                    displayField: 'text',
                    forceSelection: true,
                    triggerAction: 'all',
                    selectOnFocus: true,
                    editable: false,
                    name: 'diffType',
                    hiddenName: 'diffType',
                    msgTarget : 'side',
                    blankText: 'Correct this field',
                    allowBlank: false
                },
                {
                    xtype:'numberfield',
                    fieldLabel: '<b>मीठ</b>',
                    id:'mith',                    
                    allowNegative: false,
                    name: 'mith',
                    hiddenName : 'mith',                
                    anchor:'90%'
                },
                {
                    xtype:'numberfield',
                    fieldLabel: '<b>कांदा लसूण मसाला</b>',
                    id:'mirchi',                    
                    allowNegative: false,
                    name: 'mirchi',
                    hiddenName : 'mirchi',             
                    anchor:'90%'
                },
                {
                    xtype:'numberfield',
                    fieldLabel: '<b>हळद</b>',
                    id:'halad',                    
                    allowNegative: false,
                    name: 'halad',
                    hiddenName : 'halad',                    
                    anchor:'90%'
                },
                {
                    xtype:'numberfield',
                    fieldLabel: '<b>जिरे</b>',
                    id:'jire',                    
                    allowNegative: false,
                    name: 'jire',
                    hiddenName : 'jire',
                    anchor:'90%'
                },
                {
                    xtype:'numberfield',
                    fieldLabel: '<b>मोहरी</b>',
                    id:'mohari',                    
                    allowNegative: false,
                    name: 'mohari',
                    hiddenName : 'mohari',
                    anchor:'90%'
                },
                {
                    xtype:'numberfield',
                    fieldLabel: '<b>तांदूळ</b>',
                    id:'tandul',                    
                    allowNegative: false,
                    name: 'tandul',
                    hiddenName : 'tandul',
                    anchor:'90%'
                }]
            }]
        }],
        buttons: [
        {
            text: 'Save',
            scale: 'medium',
            iconCls:'save',
            height: '25',
            handler: function()
            {
                newStockDiffForm.getForm().submit(
                {
                    url: 'create/add-stock-differance.jsp',
                    method: 'POST',
                    success: function(form, action)
                    {
                    	allStockDifferanceStore.reload();
                        newStockDiffForm.getForm().reset();
                        Ext.Msg.alert('Success', 'Stock Differance Saved');
                    },
                    failure: function(form, action)
                    {
                        if(action.response != undefined)
                        {
                            Ext.Msg.alert('Warning', 'Stock Differance already exists');
                        }
                        else
                        {
                            Ext.MessageBox.alert('Alert...', 'Enter Data Correctly...');
                        }
                    }
                });
            }
        },
        {
            text: 'Clear',
            scale: 'medium',
            height:'25',
            iconCls:'clear',
            handler: function()
            {
                newStockDiffForm.getForm().reset();
            }
        }]
    });
    
  //Start - Create add district order form
    editStockDiffForm = new Ext.FormPanel(
    {
        labelAlign: 'right',
        frame:true,
        id: 'newStockDiffForm',
        autoDestroy : true,
        layout:'fit',
        buttonAlign: 'center',
        items: [
        {
            layout:'column',
            items:[
            {
                columnWidth:.50,
                layout: 'form',
                items: [                
                {
                    xtype:'hidden',
                    id:'stockDiffID',  
                    name: 'stockDiffID',
                    hiddenName : 'stockDiffID'
                },
                {
                    xtype:'datefield',
                    fieldLabel: '<b>Select Date</b>',
                    id:'eselectDate',                    
                    editable:false,
                    format: 'd/m/Y',
                    name: 'eselectDate',
                    hiddenName : 'eselectDate',
                    allowBlank: false,
                    msgTarget : 'side',
                    blankText: 'Correct this field',
                    anchor:'90%'
                },
                {
                    xtype:'numberfield',
                    fieldLabel: '<b>तुरदाळ</b>',
                    id:'emungdaal',                    
                    allowNegative: false,
                    name: 'emungdaal',
                    hiddenName : 'emungdaal',
                    anchor:'90%'
                },
                {
                    xtype:'numberfield',
                    fieldLabel: '<b>तुर डाळ</b>',
                    id:'ematki',                    
                    allowNegative: false,
                    name: 'ematki',
                    hiddenName : 'ematki',
                    anchor:'90%'
                },
                {
                    xtype:'numberfield',
                    fieldLabel: '<b>हरभरा</b>',
                    id:'emung',                    
                    allowNegative: false,
                    name: 'emung',
                    hiddenName : 'emung',
                    anchor:'90%'
                },
                {
                    xtype:'numberfield',
                    fieldLabel: '<b>मटकी</b>',
                    id:'emasuldaal',                    
                    allowNegative: false,
                    name: 'emasuldaal',
                    hiddenName : 'emasuldaal',
                    anchor:'90%'
                },
                {
                    xtype:'numberfield',
                    fieldLabel: '<b>चवली</b>',
                    id:'echvli',                    
                    allowNegative: false,
                    name: 'echvli',
                    hiddenName : 'echvli',
                    anchor:'90%'
                },
                {
                    xtype:'numberfield',
                    fieldLabel: '<b>तेल</b>',
                    id:'etel',                    
                    allowNegative: false,
                    name: 'etel',
                    hiddenName : 'etel',
                    anchor:'90%'
                }]
            },
            {
                columnWidth:.50,
                layout: 'form',
                items: [   
                {
                    xtype: 'combo',
                    id: 'ediffType',
                    anchor: '90%',
                    fieldLabel: 'Diffrance Type',
                    fields: ['diffType', 'text'],
                    store: diffTypeStore,
                    mode: 'local',
                    valueField: 'diffType',
                    displayField: 'text',
                    forceSelection: true,
                    triggerAction: 'all',
                    selectOnFocus: true,
                    editable: false,
                    name: 'ediffType',
                    hiddenName: 'ediffType',
                    msgTarget : 'side',
                    blankText: 'Correct this field',
                    allowBlank: false
                },
                {
                    xtype:'numberfield',
                    fieldLabel: '<b>मीठ</b>',
                    id:'emith',                    
                    allowNegative: false,
                    name: 'emith',
                    hiddenName : 'emith',                
                    anchor:'90%'
                },
                {
                    xtype:'numberfield',
                    fieldLabel: '<b>कांदा लसूण मसाला</b>',
                    id:'emirchi',                    
                    allowNegative: false,
                    name: 'emirchi',
                    hiddenName : 'emirchi',             
                    anchor:'90%'
                },
                {
                    xtype:'numberfield',
                    fieldLabel: '<b>हळद</b>',
                    id:'ehalad',                    
                    allowNegative: false,
                    name: 'ehalad',
                    hiddenName : 'ehalad',                    
                    anchor:'90%'
                },
                {
                    xtype:'numberfield',
                    fieldLabel: '<b>जिरे</b>',
                    id:'ejire',                    
                    allowNegative: false,
                    name: 'ejire',
                    hiddenName : 'ejire',
                    anchor:'90%'
                },
                {
                    xtype:'numberfield',
                    fieldLabel: '<b>मोहरी</b>',
                    id:'emohari',                    
                    allowNegative: false,
                    name: 'emohari',
                    hiddenName : 'emohari',
                    anchor:'90%'
                },
                {
                    xtype:'numberfield',
                    fieldLabel: '<b>तांदूळ</b>',
                    id:'etandul',                    
                    allowNegative: false,
                    name: 'etandul',
                    hiddenName : 'etandul',
                    anchor:'90%'
                }]
            }]
        }],
        buttons: [
        {
            text: 'Update',
            scale: 'medium',
            iconCls:'save',
            height: '25',
            handler: function()
            {
            	editStockDiffForm.getForm().submit(
                {
                    url: 'update/update-stock-differance.jsp',
                    method: 'POST',
                    success: function(form, action)
                    {
                    	allStockDifferanceStore.reload();
                        editStockDiffForm.getForm().reset();
                        Ext.Msg.alert('Success', 'Stock Differance Updated');
                    },
                    failure: function(form, action)
                    {
                        if(action.response != undefined)
                        {
                            Ext.Msg.alert('Warning', 'Stock Differance already exists');
                        }
                        else
                        {
                            Ext.MessageBox.alert('Alert...', 'Enter Data Correctly...');
                        }
                    }
                });
            }
        }]
    });
      
	//Start - Creates a grid for District Master
    stockDifféranceGrid = new Ext.grid.GridPanel(
    {
        store: allStockDifferanceStore,
        id: 'stockDifféranceGrid',
        stripeRows: true,
        loadMask: true,
        columnLines: true,
        stateId: 'stockDifféranceGrid',
        frame : true,
        autoScroll: true,
        tbar:['-',
        {
            iconCls: 'add',
            text: 'ADD',
            handler: function()
            {
                openWin(newStockDiffForm, 'Stock Differance',300,600);
            }
        },'-','-',
        {
            text: 'EDIT',
            iconCls: 'edit',
            handler: function()
            {
            	var sm = stockDifféranceGrid.getSelectionModel();
                var sel = sm.getSelections();
                if(sel.length == 0)
                {
                    Ext.Msg.alert('Warning','No Stock Differance is selected.');
                    return;
                }

                Ext.getCmp('stockDiffID').setValue(sel[0].get('stockDiffID'));
                Ext.getCmp('eselectDate').setValue(sel[0].get('stockDiffDate'));
                Ext.getCmp('ediffType').setValue(sel[0].get('diffType'));
                Ext.getCmp('emungdaal').setValue(sel[0].get('mungdaal'));
                Ext.getCmp('ematki').setValue(sel[0].get('matki'));
                Ext.getCmp('emung').setValue(sel[0].get('mung'));
                Ext.getCmp('emasuldaal').setValue(sel[0].get('masuldaal'));
                Ext.getCmp('echvli').setValue(sel[0].get('chvli'));
                Ext.getCmp('etel').setValue(sel[0].get('tel'));
                Ext.getCmp('emith').setValue(sel[0].get('mith'));
                Ext.getCmp('emirchi').setValue(sel[0].get('mirchi'));
                Ext.getCmp('ehalad').setValue(sel[0].get('halad'));
                Ext.getCmp('ejire').setValue(sel[0].get('jire'));
                Ext.getCmp('emohari').setValue(sel[0].get('mohari'));
                Ext.getCmp('etandul').setValue(sel[0].get('tandul'));
                
                openWin(editStockDiffForm, 'Stock Differance',300,600);
            }
        },'->',
        {
            text:'Delete',
            iconCls:'delete',
            handler: function()
            {               
            	var sm = stockDifféranceGrid.getSelectionModel();
                var sel = sm.getSelections();
                if(sel.length == 0)
                {
                    Ext.Msg.alert('Warning','No Stock Differance is selected.');
                    return;
                }
                var stockDiffID = sel[0].get('stockDiffID');
                Ext.MessageBox.show(
                {
                   title: 'Confirm Delete',
                   msg: 'Do you want to delete <b>'+sel[0].get('diffTypeDetail')+'</b> Stock Differance was created on <b>'+ sel[0].get('stockDiffDate') + '</b>',
                   buttons: Ext.MessageBox.YESNO,
                   fn: function(btn)
                   {
                       if(btn == "yes")
                       {
                           Ext.Ajax.request(
                           {
                               url: 'delete/delete-stock-differance.jsp',
                               method:'GET',
                               params:{stockDiffID:stockDiffID},
                               success: function()
                               {
                                    Ext.Msg.alert("Deleted",'Stock Differance Deleted');
                                    allStockDifferanceStore.reload(
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
        },'-'],
        columns:
        [
		    new Ext.grid.RowNumberer(),
		    {
		        header: '<b>Stock Diff ID</b>',
		        sortable: true,
		        dataIndex:'stockDiffID',
		        align:'center',
		        hidden:true
		    },
		    {
		        header: '<b>Differance Type</b>',
		        sortable: true,
		        dataIndex:'diffType',
		        align:'center',
		        hidden:true
		    },
		    {
		        header: '<b>Date</b>',
		        width:'75',
		        sortable: true,
		        dataIndex:'stockDiffDate',
		        align:'center',
		    },
		    {
		        header: '<b>तुरदाळ</b>',
		        width:75,
		        sortable: true,
		        dataIndex:'mungdaal',
		        align:'center'
		    },
		    {
		        header: '<b>तुर डाळ</b>',
		        width:75,
		        sortable: true,
		        dataIndex:'matki',
		        align:'center'
		    },
		    {
		        header: '<b>हरभरा</b>',
		        width:75,
		        sortable: true,
		        dataIndex:'mung',
		        align:'center'
		    },
		    {
		        header: '<b>मटकी</b>',
		        width:75,
		        sortable: true,
		        dataIndex:'masuldaal',
		        align:'center'
		    },
		    {
		        header: '<b>चवली</b>',
		        width:75,
		        sortable: true,
		        dataIndex:'chvli',
		        align:'center'
		    },
		    {
		        header: '<b>तेल</b>',
		        width:75,
		        sortable: true,
		        dataIndex:'tel',
		        align:'center'
		    },
		    {
		        header: '<b>मीठ</b>',
		        width:75,
		        sortable: true,
		        dataIndex:'mith',
		        align:'center'
		    },
		    {
		        header: '<b>कांदा लसूण मसाला</b>',
		        width:75,
		        sortable: true,
		        dataIndex:'mirchi',
		        align:'center'
		    },
		    {
		        header: '<b>हळद</b>',
		        width:75,
		        sortable: true,
		        dataIndex:'halad',
		        align:'center'
		    },
		    {
		        header: '<b>जिरे</b>',
		        width:75,
		        sortable: true,
		        dataIndex:'jire',
		        align:'center'
		    },
		    {
		        header: '<b>मोहरी</b>',
		        width:75,
		        sortable: true,
		        dataIndex:'mohari',
		        align:'center'
		    },
		    {
		        header: '<b>तांदूळ</b>',
		        width:75,
		        sortable: true,
		        dataIndex:'tandul',
		        align:'center'
		    },
		    {
		    	header: '<b>Stock </b>',
		        width:75,
		        sortable: true,
		        dataIndex:'diffTypeDetail',
		        align:'center'
		    }
		],
        width:1000,
        height:483,
        title:'Stock Differance ',
        iconCls: 'home',
        view: new Ext.grid.GroupingView(
        {
            showGroupName: true,
            enableNoGroups: false,
            enableGroupingMenu: true,
            hideGroupedColumn: true
        }),
        bbar:new Ext.PagingToolbar(
        {
            pageSize: 100,
            store: allStockDifferanceStore,
            displayInfo: true,
            displayMsg: 'Displaying results {0} - {1} of {2}',
            emptyMsg: "No results to display"
        })
    });
    //End - Creates a grid for District Master
	
    
    // Start - Creates a tab panel and adding each grid content to its items to show it on tab panel
    var mainTab = new Ext.TabPanel(
    {
        id: 'main-tab-pane',
        autoTabs: true,
        activeTab:0,
        autoScroll:true,
        frame : true,
        bodyStyle: 'padding:5px;',
        items: [stockDifféranceGrid]//,allBills]
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
                style:'left: 50px; top: 35px;width:100px;',
                items:[ getWestOrderPanel()]
            },
            {
                id:'centerpanel',
                region:'center',
                height:'autoHeight',
                frame : true,
                items:[mainTab]
            }
        ]
    });
    //End - Divide screen into sections for frontend desgining
    

});
 