/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

Ext.BLANK_IMAGE_URL = './resources/images/default/s.gif';
Ext.onReady(function()
{
	districtOrderList = new Ext.data.JsonStore({
        //autoLoad: true,
        storeId: 'districtOrderList',
        url: 'read/get-district-orders-list.jsp',
        root: 'root',
        idProperty : 'orderID',
        fields: ['orderID', 'orderNumber', 'orderNoDate']
    });
	
	
	//Get All District Store
    var reader= new Ext.data.JsonReader(
    {
        root: 'root',
        idProperty : 'districtID',
        fields: ['districtID','districtMarathi', 'district', 'stdTypeDetails','districtList','stdTypeDetails','stdType'],
        sortInfo: 
        {
            field:'districtID',
            direction:'DESC'
        }
    });
    //end
	
	allDistrictStore= new Ext.data.GroupingStore(
    {
         autoLoad: true,
         reader: reader,
         groupField : 'stdTypeDetails',
         storeId: 'allDistrictStore',
         url: 'read/get-all-districts.jsp'
    });
	
  //Get All Taluka Store
    allTalukaStore= new Ext.data.JsonStore(
    {
        storeId: 'allTalukaStore',
        url: 'read/get-all-talukas.jsp',
        root: 'root',
        idProperty : 'talukaID',
        fields: ['talukaID','districtMarathi','taluka', 'talukaMarathi','districtID' ],
        sortInfo: 
        {
            field:'talukaID',
            direction:'DESC'
        }
    });
    
    //Get All Section Store
    allSectionStore= new Ext.data.JsonStore(
    {        
        storeId: 'allSectionStore',
        url: 'read/get-all-sections.jsp',
        root: 'root',
        idProperty : 'sectionID',
        fields: ['sectionID','districtMarathi','talukaMarathi', 'section',  'sectionMarathi', 'districtID', 'talukaID','beatFlag'],
        sortInfo: 
        {
            field:'sectionID',
            direction:'DESC'
        }
    });
    
    //Get All Beat Store
    allBeatStore= new Ext.data.JsonStore(
    {
        storeId: 'allBeatStore',
        url: 'read/get-all-beat.jsp',
        root: 'root',
        idProperty : 'beatID',
        fields: ['beatID','districtMarathi','talukaMarathi','sectionMarathi', 'beat', 'beatMarathi','districtID', 'talukaID','sectionID' ],
        sortInfo: 
        {
            field:'beatID',
            direction:'DESC'
        }
    });
		
    //Get All School Store
    allSchoolStore= new Ext.data.JsonStore(
    {
        storeId: 'allSchoolStore',
        url: 'read/get-all-schools.jsp',
        root: 'root',
        idProperty : 'schoolID',
        fields: ['schoolID','districtMarathi','talikaMarathi','sectionMarathi', 'beatMarathi',  'school', 'schoolMarathi','districtID', 'talukaID','sectionID','beatID' ],
        sortInfo: 
        {
            field:'schoolID',
            direction:'DESC'
        }
    });
	
	
	reportCriteria = new Ext.FormPanel(
	{
        labelAlign		: 	'right',
        border 			:	false,  
        baseCls			: 	'x-plain',
        autoHeight		: 	true,
        border 			:	false,
        id				: 	's-form-3222',
        autoDestroy 	: 	true, 
        autoHeight		: 	true,
        bodyStyle		: 	'padding: 5px',
        layout			:	'fit',
        buttonAlign		: 	'center',
        items			: 	[
        {
            xtype			: 	'fieldset',
            autoHeight		: 	true,
            title			: 	'ऑर्डर',
            items 			: 	[
            {
                xtype			:	'combo',
                editable		:	false,
                id				:	'cco435435',
                store			: 	allDistrictStore,
                allowBlank		: 	false,
                forceSelection 	: 	true,
                triggerAction 	: 	'all',
                selectOnFocus 	:	true,
                mode 			:	'local',
                displayField 	: 	'districtList' ,
                valueField		: 	'districtID',
                fieldLabel		: 	'जिल्हा ऑर्डर',
                name			: 	'orderDistrictID',
                hiddenName 		: 	'orderDistrictID',
                anchor			:	'95%',
                msgTarget 		: 	'side',
                blankText 		: 	'Correct This Field',
                listeners		:	
                {
                    select : function(cmb,rec,idx) 
                    {
                        tCombo = Ext.getCmp('r-t-o-c');
                        tCombo.clearValue();
                        districtOrderList.load(
                        {
                            params		:
                            {
                                districtID		:	this.getValue()
                            }
                        });
                    }
                }
            },
            {
                xtype			:	'combo',
                id				: 	'r-t-o-c',
                fieldLabel		: 	'ऑर्डर#',
                forceSelection 	: 	true,allowBlank: false,
                triggerAction 	: 	'all',
                selectOnFocus 	:	true,
                editable		:	false,
                mode 			:	'local',
                store			: 	districtOrderList ,
                name			: 	'orderNumber',
                hiddenName 		: 	'orderNumber',
                displayField 	: 	'orderNoDate' ,
                valueField		: 	'orderID',
                msgTarget 		: 	'side',
                blankText 		: 	'Correct This Field',
                anchor			:	'95%',
                listeners		: 
                {
                    select 			: 	function(cmb,rec,idx) 
                    {
                        districtOrderID = this.value;
                        districtOrderNumber = rec.data.orderNumber;
                    }
                }
            }],
            buttons			: 	[
            {
                text			: 	'Dispatch Summary',
                scale			: 	'medium',
                bodyStyle		: 	'padding: 0px 100px 100px',
                handler			: 	function()
                {
                    if(reportCriteria.getForm().findField( 'cco435435' ).getValue() != 0 &&
                        reportCriteria.getForm().findField( 'r-t-o-c' ).getValue() != 0 ) 
                    {
                        var districtID = reportCriteria.getForm().findField( 'cco435435' ).getValue();
                        window.open("reports/district-order-dispatch-report.jsp?districtOrderNumber="+districtOrderNumber+"&districtID="+districtID+"&districtOrderID=" +districtOrderID,'district-order-dispatch-by-taluka-order-report',"width=1500,height=800,top=40,left=60,menubar=1,resizable=0,location=1,scrollbars=1");
                    }
                    else 
                    {
                        Ext.Msg.alert('Alert...','जिल्हा ऑर्डर   and   ऑर्डर#   must be selected..');
                    }
                }
            },
            {
                text			: 	'District Order Pending',
                scale			: 	'medium',
                handler			: 	function()
                {
                    if(reportCriteria.getForm().findField( 'cco435435' ).getValue() != 0 &&
                        reportCriteria.getForm().findField( 'r-t-o-c' ).getValue() != 0 ) 
                    {
                        var districtID = reportCriteria.getForm().findField( 'cco435435' ).getValue();
                        window.open("reports/district-order-dispatch-pending-report.jsp?districtOrderID="+districtOrderID+"&districtOrderNumber="+districtOrderNumber+"&districtID="+districtID,'district-order-dispatch-pending.jsp',"width=1500,height=800,top=40,left=60,menubar=1,resizable=0,location=1,scrollbars=1");
                    } 
                    else 
                    {
                        Ext.Msg.alert('Alert...','जिल्हा ऑर्डर   and   ऑर्डर#   must be selected..');
                    }
                }
            }]
        }]
    });
	
	repChallanCri = new Ext.FormPanel(
	{
        labelAlign: 'right',
        border :false,
        baseCls: 'x-plain',
        autoHeight: true,
        border :false,
        id: 'challanreports',
        autoDestroy : true,
        autoHeight: true,
        bodyStyle: 'padding: 10px',
        layout:'fit',
        buttonAlign: 'center',
        items: [
        {
            xtype: 'fieldset',
            autoHeight: true,
            collapsible : true,
            title: 'Select Dates For Challan / Dispatch Register / Dispatch Summary Report Only',
            items : [
            {
                items: [
                {
                    layout : 'column',
                    autoHeight: true,
                    items : [
                    {
                        columnWidth : .5,
                        layout : 'form',
                        items : [
                        {
                            xtype:'datefield',
                            width : 100,
                            fieldLabel: 'From Date',
                            id:'fromChallanDate',
                            allowBlank: false,
                            msgTarget : 'side',
                            editable:false,
                            format: 'd/m/Y',
                            name: 'fromChallanDate',
                            hiddenName : 'fromChallanDate',
                            emptyText : 'Select Date '
                        }]
                    },
                    {
                        columnWidth : .5,
                        layout : 'form',
                        items : [
                        {
                            xtype:'datefield',
                            width : 100,
                            fieldLabel: 'To Date',
                            id:'toChallanDate',
                            allowBlank: false,
                            msgTarget : 'side',
                            editable:false,
                            format: 'd/m/Y',
                            name: 'toChallanDate',
                            hiddenName : 'toChallanDate',
                            emptyText : 'Select Date '
                        }]
                    }]
                }]
            },
            {
                layout : 'column',
                bodyStyle: 'padding:5px 5px 5px',
                items : [
                {
                    autoHeight: true,
                    items : [
                    {
                        columnWidth : .5,
                        bodyStyle: 'padding:5px 10px 5px',
                        items : [
                        {
                            xtype : 'button',
                            text: 'Challan Report',
                            scale: 'medium',
                            handler: function()
                            {
                                //if(repChallanCri.getForm().isValid()){
                                var from = repChallanCri.getForm().findField( 'fromChallanDate' ).value;
                                var to = repChallanCri.getForm().findField( 'toChallanDate' ).value;
                                if(from != undefined && to != undefined){
                                    window.open("reports/print-challan-reports-between-dates.jsp?fromChallanDate="+from+"&toChallanDate="+to ,'challan-report',"width=1500,height=800,top=40,left=60,menubar=1,resizable=0,location=1,scrollbars=1");
                                }
                                else {
                                    Ext.Msg.alert('Alert...','Date Fields Cannot Be Left Blank...');
                                }
                            }

                        }]
                    }]
                },
                {
                    autoHeight: true,
                    items : [
                    {
                        columnWidth : .5,
                        bodyStyle: 'padding:5px 10px 5px',
                        items : [
                        {
                            xtype : 'button',
                            text: 'Dispatch Register Report',
                            scale: 'medium',
                            handler: function()
                            {
                                //if(repChallanCri.getForm().isValid()){
                                var from = repChallanCri.getForm().findField( 'fromChallanDate' ).value;
                                var to = repChallanCri.getForm().findField( 'toChallanDate' ).value;
                                if(from != undefined && to != undefined){
                                    window.open("reports/print-dispatch-register.jsp?fromChallanDate="+from+"&toChallanDate="+to ,'dispatch-register-report',"width=1500,height=800,top=40,left=60,menubar=1,resizable=0,location=1,scrollbars=1");
                                } else {
                                    Ext.Msg.alert('Alert...','Date Fields Cannot Be Left Blank...');
                                }
                            }
                        }]
                    }]
                }]
            }]
        }]
    });
	
	// raw material report
    repRawMaterialCri = new Ext.FormPanel(
    {
        labelAlign: 'right',
        border :false,
        baseCls: 'x-plain',
        autoHeight: true,
        border :false,
        id: 'repRawMaterialCri',
        autoDestroy : true,
        autoHeight: true,
        bodyStyle: 'padding: 10px',
        layout:'fit',
        buttonAlign: 'center',
        items: [
        {
            xtype: 'fieldset',
            autoHeight: true,
            collapsible : true,
            title: 'Select Dates For Ration Inward Summary Report ',
            items : [
            {
                items: [
                {
                    layout : 'column',
                    autoHeight: true,
                    items : [
                    {
                        columnWidth : .5,
                        layout : 'form',
                        items : [
                        {
                            xtype:'datefield',
                            width : 100,
                            fieldLabel: 'From Date',
                            id:'fromRawMaterialDate',
                            allowBlank: false,
                            msgTarget : 'side',
                            editable:false,
                            format: 'd/m/Y',
                            name: 'fromRawMaterialDate',
                            hiddenName : 'fromRawMaterialDate',
                            emptyText : 'Select Date '
                        }]
                    },
                    {
                        columnWidth : .5,
                        layout : 'form',
                        items : [
                        {
                            xtype:'datefield',
                            width : 100,
                            fieldLabel: 'To Date',
                            id:'toRawMaterialDate',
                            allowBlank: false,
                            msgTarget : 'side',
                            editable:false,
                            format: 'd/m/Y',
                            name: 'toRawMaterialDate',
                            hiddenName : 'toRawMaterialDate',
                            emptyText : 'Select Date '
                        }]
                    }]
                }]
            },
            {
                layout : 'column',
                bodyStyle: 'padding:5px 50px 5px',
                items : [
                {
                    autoHeight: true,
                    items : [
                    {
                        columnWidth : .33,
                        bodyStyle: 'padding:5px 5px 5px',
                        items : [
                        {
                            xtype : 'button',
                            text: 'Inward Ration Report',
                            scale: 'medium',
                            handler: function()
                            {
                                //if(repChallanCri.getForm().isValid()){
                                var from = repRawMaterialCri.getForm().findField( 'fromRawMaterialDate' ).value;
                                var to = repRawMaterialCri.getForm().findField( 'toRawMaterialDate' ).value;
                                if(from != undefined && to != undefined)
                                {
                                    window.open("reports/print-inward-register-between-dates.jsp?fromRationDate="+from+"&toRationDate="+to ,'inward-report',"width=1500,height=800,top=40,left=60,menubar=1,resizable=0,location=1,scrollbars=1");
                                }
                                else {
                                    Ext.Msg.alert('Alert...','Date Fields Cannot Be Left Blank...');
                                }
                            }

                        }]
                    }]
                },
                {
                    autoHeight: true,
                    items : [
                    {
                        columnWidth : .33,
                        bodyStyle: 'padding:5px 5px 5px',
                        items : [
                        {
                            xtype : 'button',
                            text: 'Short Ration Report',
                            scale: 'medium',
                            handler: function()
                            {
                                var from = repRawMaterialCri.getForm().findField( 'fromRawMaterialDate' ).value;
                                var to = repRawMaterialCri.getForm().findField( 'toRawMaterialDate' ).value;
                                if(from != undefined && to != undefined)
                                {
                                    window.open("reports/print-stock-short-extra-reports-between-dates.jsp?fromDate="+from+"&toDate="+to+"&shortExtra=1" ,'stock-report',"width=1500,height=800,top=40,left=60,menubar=1,resizable=0,location=1,scrollbars=1");
                                } 
                                else 
                                {
                                    Ext.Msg.alert('Alert...','Date Fields Cannot Be Left Blank...');
                                }
                            }
                        }]
                    }]
                },
                {
                    autoHeight: true,
                    items : [
                    {
                        columnWidth : .33,
                        bodyStyle: 'padding:5px 5px 5px',
                        items : [
                        {
                            xtype : 'button',
                            text: 'Extra Ration Report',
                            scale: 'medium',
                            handler: function()
                            {
                                var from = repRawMaterialCri.getForm().findField( 'fromRawMaterialDate' ).value;
                                var to = repRawMaterialCri.getForm().findField( 'toRawMaterialDate' ).value;
                                if(from != undefined && to != undefined)
                                {
                                    window.open("reports/print-stock-short-extra-reports-between-dates.jsp?fromDate="+from+"&toDate="+to+"&shortExtra=2" ,'stock-report',"width=1500,height=800,top=40,left=60,menubar=1,resizable=0,location=1,scrollbars=1");
                                } 
                                else 
                                {
                                    Ext.Msg.alert('Alert...','Date Fields Cannot Be Left Blank...');
                                }
                            }
                        }]
                    }]
                }]
            }]
        },
        {
            xtype: 'fieldset',
            autoHeight: true,
            collapsible : true,
            title: 'Select Dates For Ration Current Stock Report Only',
            items : [
            {
                items: [
                {
                    layout : 'column',
                    autoHeight: true,
                    items : [
                    {
                        columnWidth : .5,
                        layout : 'form',
                        items : [
                        {
                            xtype:'datefield',
                            width : 100,
                            fieldLabel: 'Stock On Date',
                            id:'rawMaterialStockDate',
                            allowBlank: false,
                            msgTarget : 'side',
                            editable:false,
                            format: 'd/m/Y',
                            name: 'rawMaterialStockDate',
                            hiddenName : 'rawMaterialStockDate',
                            emptyText : 'Select Date '
                        }]
                    },
                    {
                        columnWidth : .5,
                        layout : 'form',
                        items : [
                        {
                            xtype : 'button',
                            text: 'Raw Material Stock Report',
                            scale: 'medium',
                            handler: function()
                            {
                                var to = repRawMaterialCri.getForm().findField( 'rawMaterialStockDate' ).value;
                                if(to != undefined)
                                {
                                    window.open("reports/print-stock-on-date-reports.jsp?onDate="+to ,'stock-report',"width=1500,height=800,top=40,left=60,menubar=1,resizable=0,location=1,scrollbars=1");
                                }
                                else 
                                {
                                    Ext.Msg.alert('Alert...','Date Fields Cannot Be Left Blank...');
                                }
                            }

                        }]
                    }]
                }]
            }]
        }]
    });
    //end
	
	openReportCriteriaWin =  function ()
	{
        //reportCriteria.getForm().reset();
        var win = new Ext.Window(
        {
            layout			:	'fit',
            width			:	550,
            plain			:	true,
            modal			: 	true, 
            resizable 		: 	false,
            height 			: 	460,
            iconCls			: 	'report', 
            closeAction		:	'hide',
            title 			: 	"Generate Report",
            plain			: 	true, 
            buttonAlign		: 	'center',
            items 			: 	[
            {
                layout 			:	"border",
                items 			:	[
                {
                    region			:	"center",
                    layout			:	'fit',
                    frame			: 	true,
                    items			:	[  
                    {
                        xtype 			: 	'tabpanel', 
                        activeTab		: 	0,
                        items 			:	[
                     	{
                     		title 			: 	'Dispatch Reports',	
                     		layout			: 	'fit',	
                     		items 			:	[reportCriteria] 
                     	},
                        {
                     		title 			: 	'Various Reports',		
                     		layout			:	'fit', 	
                     		items 			:	 [repChallanCri] 
                     	},
                        {	
                     		title 			: 	'Ration Reports',
                     		layout			: 	'fit', 	
                     		items 			: 	[repRawMaterialCri]
                     	}]
                    }]
                }]
            }]
        });
        //addSectionForm.getForm().reset();
        win.show(this);
    };
        
	viewport = new Ext.Viewport(
	{
        layout				: 	'border',
        bodyStyle			: 	'padding:5px;',
        items				: 	
        [
            new Ext.BoxComponent(
            {
                region			: 	'north',
                height			: 	50,
                contentEl		: 	'el1'
            }),
            {
                id:'centerpanel',
                region:'center',
                height:'autoHeight'
            }
        ]
    });
    openReportCriteriaWin();
});