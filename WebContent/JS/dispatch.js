Ext.onReady(function()
{
	fourDecimalNum =  function(value)
	{                    
        return (value !== undefined)? value.toFixed(4):v;
    };
	
    twoDecimalNum =  function(value)
    {
        v = 0;
        if(value !== undefined)
            v = value.toFixed(2);
        return v;
    };
    
	allBatchesStore= new Ext.data.JsonStore(
	{
        autoDestroy			: 	true,
        autoLoad			: 	true,
        storeId				: 	'allBatchesStore',
        url					: 	'read/get-all-dispatches.jsp',
        root				: 	'root',
        totalProperty		: 	'totalElements',
        idProperty 			: 	'dispatchID',
        baseParams 			: 	{ start : 0, limit : 25 },
        fields				: 	
        [	
         	'dispatchID','advanceFrieght','biltyNo','createdOn','driverLicense','driverName',
            'freightPerTonInRupees','godownName','truckCapacity','pendingFrieght','totalFrieght',
            'emptySpace','loadingStatus','actualLoading','districtMarathi','talukaMarathi',
            'vehicleNo','agentName','biltyDate','draftBiltyNo','districtID'
        ]
	});
	
	prodSummary = new Ext.data.JsonStore(
	{
        autoDestroy			: 	true,
        // autoLoad 		: 	true,
        storeId				: 	'prodSummary',
        url					: 	'read/get-all-dispatch-taluka-orders.jsp',
        root				: 	'root',
        idProperty 			: 	'dispatchDetailsID',
        fields				: 	
        [
         	'dispatchDetailsID','dispatchID','beatID','talukaOrderID','fromYear','toYear','biltyFlag','biltyNo','beatMarathi','sectionMarathi','talukaMarathi','orderNumber','fromMonth','toMonth','fromMonthYear','toMonthYear','totalLoad','totalPreviousDispatch','totalLoadPending','dispatchLoading'
         	/*'dispatchTalukaOrderID','fromMonth','fromYear','orderNumber','previousDispatch','talukID',
         	'taluka','talukaMarathi','talukaOrderID','talukaTotalLoad','toMonth','toYear','toMonthYear',
         	'fromMonthYear','talukaLoadPending', 'biltyNo','biltyDate','dispatchID','dispatchLoading',
         	'districtID'*/
        ],
        sortInfo			: 
        {
            field			:	'dispatchDetailsID',
            direction		:	'DESC'
        }
    });

	/*//Get All District Store
    var reader= new Ext.data.JsonReader(
    {
        root				: 	'root',
        idProperty 			: 	'districtID',
        fields				: 	['districtID','districtMarathi', 'district', 'stdTypeDetails','districtList','stdTypeDetails','stdType'],
        sortInfo			: 
        {
            field				:	'districtID',
            direction			:	'DESC'
        }
    });
    //end
	
    //Get All District Store
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
	*/
	
	//Get All District Store
    reader= new Ext.data.JsonReader(
    {
        root: 'root',
        idProperty : 'districtID',
        fields: ['districtID','districtMarathi', 'district', 'stdTypeDetails','districtList','stdTypeDetails'],
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
        fields: ['sectionID','districtMarathi','talukaMarathi', 'section',  'sectionMarathi', 'districtID', 'talukaID'],
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
    
    /*Talika Order Details */
    allTalukaOrderStore= new Ext.data.JsonStore(
    {
        autoDestroy			: 	true,
        //autoLoad 			: 	true,
        storeId				: 	'allTalukaOrderStore',
        url					: 	'read/get-all-dispatch-taluka-order_details.jsp',
        root				: 	'root',
        idProperty 			: 	'itemID',
        fields				: 	['dispatchDetailsID','itemID','itemMarathi','talukaOrderID','totalLoad','totalPreviousDispatch','currentStock','totalLoadPending','dispatchLoading'],
        sortInfo			: 
        {
            field				:	'itemID',
            direction			:	'ASC'
        }
    });
    
    talukaOrderList = new Ext.data.JsonStore(
    {
        //autoLoad		: 	true,
        storeId			: 	'talukaOrderList',
        url				: 	'read/get-taluka-orders-list.jsp',
        root			: 	'root',
        idProperty 		: 	'talukaOrderId',
        fields			: 	['talukaOrderId','orderNumber', 'orderYear']
    });
    
    /* View Dispatch Details */    
    openOrderWin =  function ()
    {
        var sm = allBatchesGrid.getSelectionModel();
        var sel = sm.getSelections();
        if(sel.length == 0) {Ext.Msg.alert('Select Dispatch', 'No dispatch is selected!');return;};
        var id = sel[0].get('dispatchID');
        //var godownName = sel[0].get('godownName');
        //var districtID = sel[0].get('districtID');
        var tabPane = Ext.getCmp('center-tab-panel');
        var tab = Ext.getCmp('tab1');
        tab.setTitle("Dispatch Taluka Orders - (Dispatch# - "+ id + ")" );
        allTalukaOrderStore.removeAll();
        allTalukaStore.removeAll();
        
        dispatchID = id;
        biltyNo = sel[0].get('biltyNo');
        //alert((biltyNo == 0));
        if(biltyNo == 0)
        {
            Ext.getCmp('add-taluka-id' ).setDisabled(false);
            Ext.getCmp('delete-taluka-id' ).setDisabled(false);
        }
        else
        {
            Ext.getCmp('add-taluka-id' ).setDisabled(true);
            Ext.getCmp('delete-taluka-id' ).setDisabled(true);
        }
        tabPane.setActiveTab(tab);
        prodSummary.reload({params:{dispatchID:id,biltyNo:biltyNo},waitMsg:'Loading...'});
    };
 	
    openNewDispatchWin =  function ()
	{
        allTalukaStore.removeAll();
        var win = new Ext.Window(
        {
            layout			:	'fit',
            width			:	800,
            modal			: 	true,
            height			:	250,
            iconCls			: 	'add',
            closeAction		:	'hide',
            title 			: 	"New Dispatch",
            plain			: 	true, 
            buttonAlign		: 	'center',
            items 			: 	[
            {
                layout 			:	"border",
                items 			:	[
                {
                    region			:	"center",
                    layout			:	'fit',
                    items			:	[newDispatchForm]
                }]
            }]
        });
        newDispatchForm.getForm().reset();
        win.show(this);
    };
         
    openEditDispatchWin =  function ()
	{
        var win = new Ext.Window(
        {
            layout			:	'fit',
            width			:	800,
            modal			: 	true,
            height			:	250,
            iconCls			: 	'edit',
            closeAction		:	'hide',
            title 			: 	"Edit Dispatch",
            plain			: 	true, 
            buttonAlign		: 	'center',
            items 			: 	[
            {
            	layout 			:	"border",
                items 			:	[
                {
                    region			:	"center",
                    layout			:	'fit',
                    items			:	[editDispatchForm]
                }]
            }]
        });
        newDispatchForm.getForm().reset();

        var sm = allBatchesGrid.getSelectionModel();
        var sel = sm.getSelections();

        if(sel.length == 0)
        {
            Ext.Msg.alert('Select Dispatch', 'No dispatch is selected!');
            return;
        };

        editDispatchForm.getForm().findField( 'et-eof-on-textf1213' ).setValue(sel[0].get('freightPerTonInRupees'));
        editDispatchForm.getForm().findField( 'et-eof-on-textf3f33552' ).setValue(sel[0].get('driverName'));
        editDispatchForm.getForm().findField( 'et-eof-on-textf3f77' ).setValue(sel[0].get('driverLicense'));
        editDispatchForm.getForm().findField( 'et-eof-on-textf3f3355234' ).setValue(sel[0].get('vehicleNo'));
        editDispatchForm.getForm().findField( 'et-eof-on-textfdd' ).setValue(sel[0].get('truckCapacity'));
        editDispatchForm.getForm().findField( 'et-eof-on-textf121' ).setValue(sel[0].get('advanceFrieght'));
        editDispatchForm.getForm().findField( 'et-eof-on-textf12176676' ).setValue(sel[0].get('dispatchID'));
        editDispatchForm.getForm().findField( 't-eof-on-textf3f335523232' ).setValue(sel[0].get('agentName'));
        editDispatchForm.getForm().findField( 'changeCdate8456' ).setValue(sel[0].get('biltyDate'));

        editDispatchForm.getForm().findField( 't-eof-on-biltyno123' ).setValue(sel[0].get('draftBiltyNo'));

        win.show(this);
    };
    
    openAddTalukaOrderWin =  function ()
	{    
	    var win = new Ext.Window(
	    {
	        layout			:	'fit',
	        width			:	400,
	        modal			: 	true,
	        height			:	220,
	        iconCls			: 	'add',
	        closeAction		:	'hide',
	        title 			: 	"Add Taluka Order Dispatch",
	        plain			: 	true, 
	        buttonAlign		: 	'center',
	        items 			: 	[
            {
                layout 			:	"border",
                items 			:	[
                {
                    region			:	"center",
                    layout			:	'fit',
                    items			:	[addSectionForm]
                }]
            }]
	    });
	    //addSectionForm.getForm().reset();
	    win.show(this);
	};
    	
	/*Add Dispatch Form */
	newDispatchForm = new Ext.FormPanel(
	{
        labelAlign			: 	'right',
        frame				:	true,
        id					:	'new-dispatch-form',
        autoDestroy 		:	true,
        layout				:	'fit',
        labelWidth 			: 	130,
        buttonAlign			: 	'center',
        items				: 	[
        {
            layout				:	'column',
            items				:	[
            {
                columnWidth			:	.50,
                layout				: 	'form',
                items				: 	[
                {
                    xtype				:	'combo',
                    id					:	't-eof-fm-combo34344',
                    store				: 	allDistrictStore,
                    allowBlank			: 	false,
                    displayField 		: 	'districtList' ,
                    valueField			: 	'districtID',
                    mode 				:	'local',
                    forceSelection 		: 	true,
                    triggerAction 		: 	'all',
                    selectOnFocus 		:	true,
                    editable			:	false,
                    name 				: 	'districtID',
                    hiddenName 			: 	'districtID',
                    fieldLabel			: 	'Select District',
                    msgTarget 			: 	'side',
                    blankText			: 	'Correct this field',
                    anchor				:	'95%',
                    listeners			: 	
                    {
                        select 				: 	function(cmb,rec,idx) 
                        {
                            tCombo = Ext.getCmp('c3');
                            tCombo.clearValue();
                            allTalukaStore.load(
                            {
                                params				:	
                                {
                                    districtID			:	this.getValue()
                                }
                            });
                        }
                    }
                },
                {
                    xtype				:	'combo',
                    id					:	'c3',
                    fieldLabel			: 	'तालुका',
                    forceSelection 		: 	true,
                    triggerAction 		: 	'all',
                    selectOnFocus 		:	true,
                    editable			:	false,
                    mode 				:	'local',
                    store				:	allTalukaStore,
                    name				: 	'taluka',
                    hiddenName 			: 	'talukaID',
                    displayField 		: 	'talukaMarathi' ,
                    valueField			: 	'talukaID',
                    anchor				:	'95%',
                    msgTarget 			: 	'side',
                    blankText			: 	'Correct this field'
                }, 
                {
                    /*xtype				:	'combo',
                    id					:	'c4',
                    //store				: 	godownList,
                    allowBlank			: 	false,
                    displayField 		: 	'godownName' ,
                    valueField			: 	'godownID',
                    mode 				:	'local',
                    forceSelection 		: 	true,
                    triggerAction 		: 	'all',
                    selectOnFocus 		:	true,
                    editable			:	false,
                    name 				: 	'godownID',
                    hiddenName 			: 	'godownID',
                    fieldLabel			: 	'Select Godown',
                    msgTarget 			:	'side',
                    blankText			: 	'Correct this field',
                    anchor				:	'95%'*/
                },
                {
                    xtype				:	'numberfield',
                    id					:	't-eof-on-textf1213',
                    allowNegative		: 	false,
                    fieldLabel			: 	'Freight(Rs.)/Ton',
                    emptyText 			: 	'Rs.',
                    allowBlank			: 	false,
                    name				: 	'freightRate',
                    hiddenName 			: 	'freightRate',
                    msgTarget 			: 	'side',
                    blankText			: 	'Correct this field',
                    anchor				:	'95%'
                },
                {
                    xtype				:	'textfield',
                    id					:	't-eof-on-textf3f33552',
                    fieldLabel			: 	'Driver Name',
                    name				: 	'driverName',
                    hiddenName 			: 	'driverName',
                    allowBlank			: 	false,
                    msgTarget 			: 	'side',
                    blankText			: 	'Correct this field',
                    anchor				:	'95%'
                },
                {
                    xtype				:	'textfield',
                    id					:	't-eof-on-textf3f3355232',
                    fieldLabel			: 	'Agent Name',
                    name				: 	'agentName',
                    hiddenName 			: 	'agentName',
                    allowBlank			: 	false,
                    msgTarget 			: 	'side',
                    blankText			: 	'Correct this field',
                    anchor				:	'95%'
                }]
            },
            {
                columnWidth			:	.50,
                layout				: 	'form',
                items				: 	[
                {
                    xtype				:	'numberfield',
                    id					:	't-eof-on-textfdd',
                    fieldLabel			: 	'Truck Capacity(ton) ',
                    allowNegative		: 	false,
                    allowBlank			: 	false,
                    name				: 	'truckCapacity',
                    hiddenName 			: 	'truckCapacity',
                    msgTarget 			: 	'side',
                    blankText			: 	'Correct this field',
                    anchor				:	'95%'
                },
                {
                    xtype				:	'numberfield',
                    id					:	't-eof-on-textf121',
                    allowNegative		: 	false,
                    fieldLabel			: 	'Advance Freit(Rs.)',
                    emptyText 			: 	'Rs.',
                    name				: 	'advFreight',
                    hiddenName 			: 	'advFreight',
                    msgTarget 			: 	'side',
                    blankText			: 	'Correct this field',
                    anchor				:	'95%'
                },
                {
                    xtype				:	'textfield',
                    id					:	't-eof-on-textf3f77',
                    fieldLabel			: 	'Driver License',
                    name				: 	'driverLicense',
                    hiddenName 			: 	'driverLicense',
                    allowBlank			: 	false,
                    msgTarget 			: 	'side',
                    blankText			: 	'Correct this field',
                    anchor				:	'95%'
                },
                {
                    xtype				:	'textfield',
                    id					:	't-eof-on-textf3f3355234',
                    fieldLabel			: 	'Vehicle No.',
                    name				: 	'vehicleNo',
                    hiddenName 			: 	'vehicleNo',
                    allowBlank			: 	false,
                    msgTarget 			: 	'side',
                    blankText			: 	'Correct this field',
                    anchor				:	'95%'
                },
                {
                    xtype				:	'datefield',
                    width 				: 	100,
                    fieldLabel			: 	'Bilty Date',
                    id					:	'changeCdate4832',
                    allowBlank			: 	false,
                    editable			:	false,
                    format				: 	'd/m/Y',
                    name				: 	'biltyDate',
                    hiddenName 			: 	'biltyDate',
                    anchor				:	'95%',
                    msgTarget 			: 	'side',
                    blankText			: 	'Correct this field',
                    emptyText 			: 	'Bilty Date '
                },
                {
                    //xtype				:	'numberfield',
                    xtype				:	'textfield',
                    id					:	't-eof-on-biltyno',
                    fieldLabel			: 	'Bilty No# ',
                    //allowNegative		: 	false,
                    allowBlank			: 	false,
                    name				: 	'draftBiltyNo',
                    hiddenName 			: 	'draftBiltyNo',
                    msgTarget 			: 	'side',
                    blankText			:	'Correct this field',
                    anchor				:	'95%'
                }]
            }]
        }],
        buttons				: 	[
        {
            text				: 	'Save',
            scale				: 	'medium',
            handler				: 	function()
            {
                //if(newDispatchForm.getForm().isValid()){
                newDispatchForm.getForm().submit(
                {
                    url					: 	'create/create-dispatch.jsp',
                    method				: 	'POST',
                    success				: 	function(form, action)
                    {
                        newDispatchForm.getForm().reset();
                        allBatchesStore.reload(
                        {
                            waitMsg				:	'Loading...'
                        });
                        Ext.Msg.alert('Success...', 'Dispatch Saved Successfully...');
                    },
                    failure				: 	function(form, action)
                    {
                        if(action.response != undefined)
                        {
                            Ext.Msg.alert('Error', 'Error in saving');
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
		
	/*Edit Dispatch Form */
	editDispatchForm = new Ext.FormPanel(
	{
        labelAlign			: 	'right',
        frame				:	true,
        id					: 	'edit-dispatch-form-123',
        autoDestroy 		: 	true,
        layout				:	'fit',
        labelWidth 			: 	130,
        buttonAlign			: 	'center',
        items				: 	[
        {
            layout				:	'column',
            items				:	[
            {
                columnWidth			:	.50,
                layout				: 	'form',
                items				: 	[
                {
                	xtype				:	'numberfield',
                    id					:	'et-eof-on-textf1213',
                    allowNegative		: 	false,
                    fieldLabel			: 	'Freight(Rs.)/Ton',
                    emptyText 			: 	'Rs.',
                    allowBlank			: 	false,
                    name				: 	'freightRate',
                    hiddenName 			: 	'freightRate',
                    msgTarget 			: 	'side',
                    blankText			: 	'Correct this field',
                    anchor				:	'95%'
                },
                {
                    xtype				:	'textfield',
                    id					:	'et-eof-on-textf3f33552',
                    fieldLabel			: 	'Driver Name',
                    name				: 	'driverName',
                    hiddenName 			: 	'driverName',
                    allowBlank			: 	false,
                    msgTarget 			: 	'side',
                    blankText			: 	'Correct this field',
                    anchor				:	'95%'
                },
                {
                    xtype				:	'textfield',
                    id					:	'et-eof-on-textf3f77',
                    fieldLabel			: 	'Driver License',
                    name				: 	'driverLicense',
                    hiddenName 			: 	'driverLicense',
                    allowBlank			: 	false,
                    msgTarget 			: 	'side',
                    blankText			: 	'Correct this field',
                    anchor				:	'95%'
                },
                {
                    xtype				:	'textfield',
                    id					:	'et-eof-on-textf3f3355234',
                    fieldLabel			: 	'Vehicle No.',
                    name				: 	'vehicleNo',
                    hiddenName 			: 	'vehicleNo',
                    allowBlank			: 	false,
                    msgTarget 			: 	'side',
                    blankText			: 	'Correct this field',
                    anchor				:	'95%'
                }]
            },
            {
	            columnWidth			:	.50,
	            layout				: 	'form',
	            items				: 	[
	            {
                    xtype				:	'numberfield',
                    id					:	'et-eof-on-textfdd',
                    fieldLabel			: 	'Truck Capacity(ton) ',
                    allowNegative		: 	false,
                    allowBlank			: 	false,
                    name				: 	'truckCapacity',
                    hiddenName 			: 	'truckCapacity',
                    msgTarget 			: 	'side',
                    blankText			: 	'Correct this field',
                    anchor				:	'95%'
                },
                {
                    xtype				:	'numberfield',
                    id					:	'et-eof-on-textf121',
                    allowNegative		: 	false,
                    fieldLabel			: 	'Advance Freit(Rs.)',
                    emptyText 			: 	'Rs.',
                    name				: 	'advFreight',
                    hiddenName 			: 	'advFreight',
                    msgTarget 			: 	'side',
                    blankText			: 	'Correct this field',
                    anchor				:	'95%'
                },
                {
                    xtype				:	'hidden',
                    name				:	'dispatchID',
                    id					:	'et-eof-on-textf12176676',
                    hiddenName 			: 	'',
                    value 				: 	'0',
                    hiddenName 			: 	'dispatchID'
                },
                {
                    xtype				:	'textfield',
                    id					:	't-eof-on-textf3f335523232',
                    fieldLabel			: 	'Agent Name',
                    name				: 	'agentName',
                    hiddenName 			: 	'agentName',
                    allowBlank			: 	false,
                    msgTarget 			: 	'side',
                    blankText			: 	'Correct this field',
                    anchor				:	'95%'
                },
                {
                    xtype				:	'datefield',
                    width 				: 	100,
                    fieldLabel			: 	'Bilty Date',
                    id					:	'changeCdate8456',
                    allowBlank			: 	false,
                    editable			:	false,
                    format				: 	'd/m/Y',
                    name				: 	'biltyDate',
                    hiddenName 			: 	'biltyDate',
                    anchor				:	'95%',
                    msgTarget 			: 	'side',
                    blankText			: 	'Correct this field',
                    emptyText 			: 	'Bilty Date '
                },
                {
                    xtype				:	'textfield',
                    id					:	't-eof-on-biltyno123',
                    fieldLabel			: 	'Bilty No# ',
                    allowBlank			: 	false,
                    name				: 	'draftBiltyNo',
                    hiddenName 			: 	'draftBiltyNo',
                    msgTarget 			: 	'side',
                    blankText			: 	'Correct this field',
                    anchor				:	'95%'
                }]
	        }]
        }],
        buttons				: 	[
        {
            text				: 	'Save',
            scale				: 	'medium',
            handler				: 	function()
            {
                //if(editDispatchForm.getForm().isValid()){
                editDispatchForm.getForm().submit(
                {
                    url					: 	'update/update-dispatch.jsp',
                    method				: 	'POST',
                    success				: 	function(form, action)
                    {
                        editDispatchForm.getForm().reset();
                        allBatchesStore.reload(
	                        //{params:{dispatchID:id}
	                        //,waitMsg:'Loading...'}
                        );
                        Ext.Msg.alert('Success... ', 'Dispatch Saved Successfully...');
                    },
                    failure				: 	function(form, action)
                    {
                        if(action.response != undefined)
                        {
                            Ext.Msg.alert('Error', 'Error in saving');
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
		
	addSectionForm = new Ext.FormPanel(
	{
        labelAlign			: 	'right',
        frame				:	true,
        id					: 	's-form',
        autoDestroy 		: 	true,
        layout				:	'fit',
        buttonAlign			: 	'center',
        items				: 	[
        {
        	layout				:	'fit',
            items				:	[
            {                     
                layout				: 	'form',
                items				: 	[
                {
                    xtype				:	'combo',
                    editable			:	false,
                    id					:	'c8',
                    store				: 	allDistrictStore,
                    allowBlank			: 	false,
                    forceSelection 		: 	true,
                    triggerAction 		: 	'all',
                    selectOnFocus 		:	true,
                    mode 				:	'local',
                    displayField 		: 	'districtList' ,
                    valueField			: 	'districtID',
                    fieldLabel			: 	'Select District',
                    name				: 	'district',
                    hiddenName 			: 	'districtID',
                    msgTarget 			: 	'side',
                    blankText 			: 	'Correct This field',
                    anchor				:	'90%',
                    listeners			: 
                    {
                        select 				: 	function(cmb,rec,idx) 
                        {
                            tCombo = Ext.getCmp('c9');
                            tCombo.clearValue();
                            allTalukaStore.load(
                            {
                                params				:
                                {
                                    districtID			:	this.getValue()
                                }
                            });
                        }
                    }
                },
                {
                    xtype				:	'combo',
                    id					: 	'c9',
                    fieldLabel			: 	'Select Taluka',
                    allowBlank			: 	false,
                    forceSelection 		: 	true,
                    triggerAction 		: 	'all',
                    selectOnFocus 		:	true,
                    editable			:	false,
                    mode 				:	'local',
                    store				: 	allTalukaStore,
                    name				: 	'taluka',
                    hiddenName 			: 	'talukaID',
                    displayField 		: 	'talukaMarathi' ,
                    valueField			: 	'talukaID',
                    msgTarget 			: 	'side',
                    blankText 			: 	'Correct This field',
                    anchor				:	'90%',
                    listeners			: 
                    {
                        select 				: 	function(cmb,rec,idx) 
                        {
                            tCombo = Ext.getCmp('c10');
                            tCombo.clearValue();
                            allSectionStore.load(
                            {
                                params				:
                                {
                                    talukaID			:	this.getValue()
                                }
                            });
                        }
                    }
                },
                {
                    xtype				:	'combo',
                    id					: 	'c10',
                    fieldLabel			: 	'Select Section',
                    allowBlank			: 	false,
                    displayField 		: 	'sectionMarathi' ,
                    valueField			: 	'sectionID',
                    forceSelection 		: 	true,
                    triggerAction 		: 	'all',
                    selectOnFocus 		:	true,
                    editable			:	false,
                    store				:	allSectionStore,
                    mode 				:	'local',
                    name				: 	'section',
                    hiddenName 			: 	'section',
                    msgTarget 			: 	'side',
                    blankText 			: 	'Correct This field',
                    anchor				:	'90%',
                    listeners			: 
                    {
                        select 				: 	function(cmb,rec,idx) 
                        {
                            tCombo = Ext.getCmp('c11');
                            tCombo.clearValue();
                            allBeatStore.load(
                            {
                                params				:
                                {
                                    sectionID			:	this.getValue()
                                }
                            });
                        }
                    }
                },
                {
                    xtype				:	'combo',
                    id					: 	'c11',
                    fieldLabel			: 	'Select Beat',
                    allowBlank			: 	false,
                    forceSelection 		: 	true,
                    triggerAction 		: 	'all',
                    selectOnFocus 		:	true,
                    editable			:	false,
                    mode 				:	'local',
                    store				: 	allBeatStore,
                    name				: 	'beat',
                    hiddenName 			: 	'beatID',
                    displayField 		: 	'beatMarathi' ,
                    valueField			: 	'beatID',
                    msgTarget 			: 	'side',
                    blankText 			: 	'Correct This field',
                    anchor				:	'90%',
                    listeners			: 
                    {
                        select 				: 	function(cmb,rec,idx) 
                        {
                            tCombo = Ext.getCmp('c12');
                            tCombo.clearValue();
                            talukaOrderList.load(
                            {
                                params				:
                                {
                                	talukaID			:	Ext.getCmp('c9').getValue()
                                }
                            });
                        }
                    }
                },
                {
                    xtype				:	'combo',
                    id					: 	'c12',
                    fieldLabel			: 	'Taluka Order#',
                    forceSelection 		: 	true,
                    allowBlank			: 	false,
                    triggerAction 		: 	'all',
                    selectOnFocus 		:	true,
                    editable			:	false,
                    mode 				:	'local',
                    store				: 	talukaOrderList,
                    name				: 	'orderID',
                    hiddenName 			: 	'orderID',
                    displayField 		: 	'orderYear' ,
                    valueField			: 	'talukaOrderId',
                    anchor				:	'90%'
                }]
            }]
        }],
        buttons				: [
        {
	        text				: 	'Save',
	        scale				: 	'medium',
	        handler				: 	function()
	        {
	            if(addSectionForm.getForm().isValid())
	            {
	                addSectionForm.getForm().submit(
	                {
	                    url					: 	'create/add-taluka-order-to-dispatch.jsp',
	                    method				: 	'POST',
	                    params				:
	                    {
	                        dispatchID 			: 	dispatchID
	                    },
	                    success				: 	function(form, action)
	                    {
	                        addSectionForm.getForm().reset();
	                        prodSummary.reload({waitMsg:'Loading...'});
	                        Ext.Msg.alert('Success', 'Taluka order and Beat added to dispatch');
	                        //win.hide();
	                    },
	                    failure: function(form, action)
	                    {
	                    	if(action.response != undefined)
	                        {
	                            Ext.Msg.alert('Warning', 'Taluka order and Beat Already Added to Dispatch');
			                }
	                        else
	                        {
	                            Ext.Msg.alert('Alert...', 'Enter Details Correctly...');
	                        }
	                    }
	                });
	            }
	        }
	    }]
    });
	
	/* Dispatch Details */
	fromTalukaOrderGrid = new Ext.grid.EditorGridPanel(
	{                   
        store				: 	allTalukaOrderStore,
        stripeRows			: 	true,
        loadMask			: 	true,
        stateful			: 	true,
        iconCls				: 	'inv',
        stateId				: 	'fromTalukaOrderGrid',
        columnLines			: 	true,
        tbar				:	[ 
        {
        	xtype 				: 	'label',  
        	bodyStyle			: 	'padding:5px;',
            text 				: 	'Details',
            style				: 	'font-weight:bold;margin-left: 5px',
            width 				: 	50
        },'->',
        {
            text 				: 	'<b>Save updated dispatch</b>',
            width 				: 	50,
            iconCls 			: 	'save',
            handler 			: 	function()
            {
                var bn = fromProductionBatchesGrid.getSelectionModel().getSelections()[0].get('biltyNo');
                if(bn != 0){  Ext.Msg.alert('Unable to save', "Can't change the values after bilty(bilty# "+bn + ") is created for dispatch " ); ;return;} ;
                var changedRecArray= [];
                var changedRecData = allTalukaOrderStore.data;
                var zeroCount = 0;

                for(var j=0;j<changedRecData.length;j++)
                {
                    var item = changedRecData.items[j];
                    //var totalLoad = item.data.totalLoad;
                    var totalLoadPending = item.data.totalLoadPending;
                    var currentStock = item.data.currentStock;
                    var dispatchLoading = item.data.dispatchLoading;
                    var itemMarathi = item.data.itemMarathi;
                    //var totalPreviousDispatch = item.data.totalPreviousDispatch;

                    if(dispatchLoading === 0)++zeroCount;
                    if(totalLoadPending === 0 && dispatchLoading> 0 )
                    {
                        Ext.Msg.alert('Ration already dispatched', "Please change Todays Dispatch for ration "+itemMarathi  );
                        return;
                    }
                    if(dispatchLoading > totalLoadPending)
                    {
                        Ext.Msg.alert('Change Todays Dispatch', "Please change Todays Dispatch for ration "+itemMarathi + "<br> Today's dispatch should be less that or equal to Pending Order " );
                        return;
                    }
                    if(dispatchLoading > currentStock)
                    {
                        Ext.Msg.alert('Change Todays Dispatch', "Please change Todays Dispatch for ration "+itemMarathi + "<br> Today's dispatch should be less that or equal to Current Stock " );
                        return;
                    }
                    changedRecArray.push(item.data);
                }

                if(zeroCount == 7){return;}

                Ext.Ajax.request(
                {
                    url					: 	'update/update-taluka-order-dispatch.jsp',
                    method				: 	'POST',
                    params				: 	
                    {
                        postdata 			:	Ext.util.JSON.encode(changedRecArray)
                    },
                    success				: 	function(resp,opt) 
                    {                                      
                        allTalukaOrderStore.reload(
                        {
                            waitMsg				:	'Loading...'
                        });
                        prodSummary.reload(
                        {
                            waitMsg				:	'Loading...'
                        });
                        allBatchesStore.reload(
                        {
                            waitMsg				:	'Loading...'
                        });
                    },
                    failure				: 	function(resp,opt) 
                    {
                        Ext.Msg.alert('Error', 'Error in deleting!');
                    }
                });
            }
        }],

        columns				: 	
        [
         	new Ext.grid.RowNumberer(),  
         	{	header: 'Dispatch ID', width: 80, dataIndex: 'dispatchDetailsID',align: 'center',hidden: true },
         	{	header: 'Ration ID', width: 80, dataIndex: 'itemID',align: 'center' },
        	{	header: 'Order Item',   width: 80, dataIndex: 'itemMarathi',align: 'center'},
            {	header: 'Order Qty(KG)',width: 120,dataIndex: 'totalLoad',align: 'center'},
            {	header: 'Prev. Dispatched Qty(KG)',width: 120,dataIndex: 'totalPreviousDispatch',  align: 'center' },
            {	header: 'Pending Order(KG)', width: 120,dataIndex: 'totalLoadPending',align: 'center'},
            {	header: 'Current Stock In Godown(Pouches)', width: 120, dataIndex: 'currentStock', align: 'center' },                        
            { 	header: "Today's Dispatch(Pouches)",width: 120, dataIndex: 'dispatchLoading',align: 'center',editor: new Ext.form.NumberField({ allowBlank: false,allowNegative: false,selectOnFocus : true }) }
        ]
    });
		
	/* view Dispatch Taluka Grid*/
	fromProductionBatchesGrid = new Ext.grid.GridPanel(
	{
        ddGroup          	: 	'secondGridDDGroup',
        enableDragDrop   	: 	true,
        store				: 	prodSummary,
        columnLines			: 	true,
        stripeRows			: 	true,
        loadMask			: 	true,
        stateful			: 	true,
        iconCls				: 	'inv',
        stateId				: 	'fromProductionBatchesGrid',
        tbar 				: 	[
        {	
        	text				: 	'Add Taluka Order Dispatch',
        	iconCls 			: 	'add',
        	//disabled 			: 	true, 
        	id 					: 	'add-taluka-id',
            handler 			: 	openAddTalukaOrderWin
        },'->',
        {
        	text				: 	'Delete Taluka Order Dispatch',
        	iconCls 			: 	'delete',
        	disabled 			: 	true, 
        	id 					: 	'delete-taluka-id',
            handler 			: 	function()
            {
                var sm = fromProductionBatchesGrid.getSelectionModel();
                var sel = sm.getSelections();
                if(sel.length == 0)
                {
                    Ext.Msg.alert('Select Dispatch Taluka Order', 'No Dispatch Taluka Order is selected!');
                    return;
                };
                var biltyNo = sel[0].get('biltyNo');
                if(biltyNo != 0)
                {
                    Ext.Msg.alert('Cant delete the Dispatch Taluka Order ', 'Dispatch Taluka Order cant be deleted once bilty is created for it!');
                    return;
                };
                var dispatchDetailsID = sel[0].get('dispatchDetailsID');
                var talukaMarathi = sel[0].get('talukaMarathi');
                var orderNumber = sel[0].get('orderNumber');

                Ext.Msg.show(
                {
                    title				: 	'Confirm',
                    msg					: 	'Do you want to delete ' +orderNumber + ' order of ' + talukaMarathi  +  '?'  ,
                    buttons				: 	Ext.Msg.YESNO,
                    fn					: 	function(btn) 
                    {
                        if (btn == 'yes') 
                        {
                            Ext.Ajax.request(
                            {
                                url					: 	'delete/delete-dispatch-taluka-order.jsp',
                                method				: 	'POST',
                                params				: 	
                                {
                                    dispatchDetailsID : 	dispatchDetailsID
                                },
                                success				: 	function(resp,opt) 
                                {
                                    Ext.Msg.alert('Deleted',   orderNumber + ' order of ' + talukaMarathi+' deleted!');
                                    allTalukaOrderStore.removeAll();
                                    prodSummary.reload(
                                    {
                                        waitMsg				:	'Loading...'
                                    });

                                    allBatchesStore.reload(
                                    {
                                        waitMsg				:	'Loading...'
                                    });

                                    var tab = Ext.getCmp('tab1');
                                    tab.setTitle("Dispatch Taluka Orders" );
                                },
                                failure				: 	function(resp,opt) 
                                {
                                    //  Ext.Msg.hide();
                                    Ext.Msg.alert('Error', 'Error in deleting!');
                                }
                            });
                        }
                    }
                });
            }
        }],  
        plugins				: 	[new Ext.ux.grid.GridSummary()],
        listeners 			: 	
        {
            rowclick 			: 	function (g, rowIndex,e) 
            {
                var sm = fromProductionBatchesGrid.getSelectionModel();
                var sel = sm.getSelections();
                var id = sel[0].get('dispatchDetailsID');
                //var talukaMarathi = sel[0].get('talukaMarathi');
                //var orderNumber = sel[0].get('orderNumber');
                var talukaOrderID = sel[0].get('talukaOrderID');
                var biltyFlag = sel[0].get('biltyFlag');
                var beatID = sel[0].get('beatID');
                var dispatchID = sel[0].get('dispatchID');
                allTalukaOrderStore.removeAll();
                allTalukaOrderStore.load(
                {
                	params			:	
                	{	
                		dispatchDetailsID 		:	id,
                		talukaOrderID			:	talukaOrderID,
                		biltyFlag				:	biltyFlag,
                		beatID					:	beatID,
                		dispatchID				:	dispatchID
                	},
                	waitMsg:'Loading...'
                });
            }
        },
        columns				: 	
        [
         	new Ext.grid.RowNumberer(),
         	{	header: 'dispatchDetailsID',width: 100, sortable: true, dataIndex: 'dispatchDetailsID',align: 'center' },
         	{	header: 'Dispatch ID',width: 100, sortable: true, dataIndex: 'dispatchID',align: 'center',hidden : true },
         	{	header: 'Taluka', width: 100,sortable: true, dataIndex: 'talukaMarathi', align: 'center'  },
            {	header: 'Section', width    : 80, sortable : true,dataIndex: 'sectionMarathi' },
            {	header: 'Beat',width    : 80,sortable : true,dataIndex: 'beatMarathi'},
            {	header: 'Taluka Order',width: 100,sortable: true, dataIndex: 'orderNumber',align: 'center',renderer : function (value){return "ऑर्डर# " + value; }},
            {	header: 'From(date)', width: 100,sortable: true,  dataIndex: 'fromMonthYear', align: 'center'},
            { 	header: 'To(date)',width: 100,sortable: true, dataIndex: 'toMonthYear', align: 'center',summaryType: 'count',
                summaryRenderer: function (v, params, data) 
                {
                    params.attr = 'ext:qtip="Total be"'; // summary column tooltip example
                    return v? ((v === 0 || v > 1) ? 'Total >'  : 'Total >') : '';
                }
            },
            {	header: 'Total Taluka Loading(tons)',width: 140, sortable: true,dataIndex: 'totalLoad', summaryType: 'sum', align: 'center', renderer : fourDecimalNum },
            {	header: 'Prev. Taluka Loading Dispatched(tons)', width: 140,sortable: true, dataIndex: 'totalPreviousDispatch',align: 'center', summaryType: 'sum', align: 'center', renderer : fourDecimalNum},
            {	header: 'Taluka Loading Pending(tons)',width: 140, sortable: true,dataIndex: 'totalLoadPending',align: 'center',summaryType: 'sum', align: 'center',renderer : fourDecimalNum},
            {	header: 'Dispatch Load(tons)',width: 140, sortable: true,dataIndex: 'dispatchLoading', align: 'center',summaryType: 'sum', align: 'center', renderer : fourDecimalNum }
        ]
    });    
	
	/* View All Dispatch Grid */	
	allBatchesGrid = new Ext.grid.GridPanel(
	{
        store			: 	allBatchesStore,
        stripeRows		: 	true,
        columnLines		: 	true,
        loadMask 		: 	true,
        stateful		: 	true,
        iconCls			: 	'inv',
        stateId			: 	'allBatchesGrid',
        listeners 		: 
        {
            dblclick  : openOrderWin
        },
        tbar			: 	[
        {
            text			: 	'New Dispatch',
            iconCls			: 	'add',
            handler			: 	function()
            {
                //open new batch form
                //batch master drop down, create new batch incremet the count
                openNewDispatchWin();
            }
        },'-',
        {
            text			: 	'Edit Dispatch',
            iconCls			: 	'edit',
            handler			: 	function()
            {
                //open new batch form
                //batch master drop down, create new batch incremet the count
                openEditDispatchWin();
            }
        },'-',
        {
            text			: 	'Show All Dispatch Taluka Orders',
            iconCls			: 	'showall',
            handler 		: 	openOrderWin
        },'-',
        {
            xtype			: 	'splitbutton',
            iconCls			: 	'brick_add',
            text			: 	'Bilty',
            menu			: 	[
            {
                text			: 	'Create Bilty',
                handler 		: 	function() 
                {
                    var sm = allBatchesGrid.getSelectionModel();
                    var sel = sm.getSelections();                    
                    if(sel.length == 0)
                    {
                        Ext.Msg.alert('Select Dispatch', 'No dispatch is selected!');
                        return;
                    };
                    var biltyNo = sel[0].get('biltyNo');
                    if(biltyNo != 0)
                    {
                        Ext.Msg.alert('Bilty already exists', 'You cant create bilty for already existing one!');
                        return;
                    };
                    var emptySpace = sel[0].get('emptySpace');
                    var actualLoading = sel[0].get('actualLoading');
                    if(sel[0].get('actualLoading') === 0)
                    {
                        Ext.Msg.alert('Add Loading', 'There is no dispatch load!');
                        return;
                    };
                    if(emptySpace < 0)
                    {
                        Ext.Msg.alert('Adjust Loading', 'Bilty cant be created, since current loading is more than truck capacity!');
                        return;
                    };
                    var biltyDraftNo = sel[0].get('draftBiltyNo');
                    if(biltyDraftNo <= 0)
                    {
                        Ext.Msg.alert('Please enter bilty number', 'Bilty number is empty!');
                        return;
                    };                    
                    var truckCapacity = sel[0].get('truckCapacity');
                    var per =(truckCapacity -actualLoading)*100/truckCapacity;
                    per = twoDecimalNum(per);
                    Ext.Msg.show(
                    {
                        title				: 	'Confirm',
                        msg					: 	"1. Once bilty is created, dispatch pouches can't be adjusted <br>2. Truck is <b>"  +per+"%</b> empty.",
                        buttons				: 	Ext.Msg.YESNO,
                        fn					: 	function(btn) 
                        {
                            if (btn == 'yes') 
                            {
                                var id = sel[0].get('dispatchID');
                                biltyDate = sel[0].get('biltyDate');
                                Ext.Ajax.request(
                                {
                                    url				: 	'create/create-bilty.jsp',
                                    method			: 	'POST',
                                    params			: 	
                                    {
                                        dispatchID		:	id
                                    },
                                    success			: 	function(form, action)
                                    {
                                        //biltyDateForm.getForm().reset();
                                        allTalukaOrderStore.removeAll();
                                        prodSummary.removeAll();
                                        Ext.getCmp('add-taluka-id' ).setDisabled(true);
                                        Ext.getCmp('delete-taluka-id').setDisabled(true);
                                        allBatchesStore.reload(
                                        {
                                            waitMsg:'Loading...'
                                        });
                                        Ext.Msg.alert("Bilty ","Bilty Created Succefully  ");
                                    },
                                    failure			: 	function(form, action)
                                    {
                                    	Ext.Msg.alert("Error ","Error on Creating Bilty ");
                                    }
                                });
                            }
                        }
                    });
                }
            },'-',
            {
                text			: 	'Preview Bilty',
                iconCls			: 	'printer',
                handler 		: 	function()
                {
                    var sm = allBatchesGrid.getSelectionModel();
                    var sel = sm.getSelections();
                    if(sel.length == 0)
                    {
                        Ext.Msg.alert('Select Dispatch', 'No dispatch is selected!');
                        return;
                    };
                    var biltyNo = sel[0].get('biltyNo');
                    var loading = sel[0].get('actualLoading');
                    //alert(loading);
                    if(biltyNo != 0)
                    {
                        Ext.Msg.alert('Bilty already exists', 'You cant priview bilty for already existing one, click on Print Bilty!');
                        return;
                    };
                    if(loading > 0) 
                    {
                        var dispatchID = sel[0].get('dispatchID');
                        var draftBiltyNo = sel[0].get('draftBiltyNo');
                        window.open("reports/preview-bilty-revised.jsp?dispatchID="+dispatchID+"&draftBiltyNo="+draftBiltyNo,'print-bilty',"width=1500,height=800,top=40,left=60,menubar=1,resizable=0,location=1,scrollbars=1");
                    }
                    else 
                    {
                        Ext.Msg.alert('Alert...','There is no Loading...');
                    }
                }

            },'-',
            {
                text			: 	'Print Bilty',
                iconCls			: 	'printer',
                handler 		: 	function()
                {
                    var sm = allBatchesGrid.getSelectionModel();
                    var sel = sm.getSelections();
                    if(sel.length == 0)
                    {
                        Ext.Msg.alert('Select Dispatch', 'No dispatch is selected!');
                        return;
                    };
                    var biltyNo = sel[0].get('biltyNo');
                    if(biltyNo == 0)
                    {
                        Ext.Msg.alert('No Bilty ', 'Bilty doesnt exist');
                        return;
                    };
                    var dispatchID = sel[0].get('dispatchID');
                    window.open("reports/print-bilty-revised.jsp?dispatchID="+dispatchID,'print-bilty',"width=1500,height=800,top=40,left=60,menubar=1,resizable=0,location=1,scrollbars=1");
                }
            },'-',
            {
                text			: 	'Delete Bilty',
                iconCls			: 	'delete',
                handler 		: 	function()
                {
                    var sm = allBatchesGrid.getSelectionModel();
                    var sel = sm.getSelections();
                    if(sel.length == 0)
                    {
                        Ext.Msg.alert('Select Dispatch', 'No bilty is selected!');
                        return;
                    };
                    var biltyNo = sel[0].get('biltyNo');

                    if(biltyNo == 0)
                    {
                        Ext.Msg.alert('No such bilty ', 'Bilty doesnt exist');
                        return;
                    };
                    var dispatchID = sel[0].get('dispatchID');
                    Ext.Msg.show(
                    {
                        title			: 	'Confirm',
                        msg				: 	'Do you want to delete Dispatch#' +dispatchID,
                        buttons			: 	Ext.Msg.YESNO,
                        fn				: 	function(btn) 
                        {
                            if (btn == 'yes') 
                            {
                                Ext.Ajax.request(
                                {
                                    url				: 	'delete/delete-bilty.jsp',
                                    method			: 	'POST',
                                    params			: 	
                                    {
                                        dispatchID 		: 	dispatchID
                                    },
                                    success			: 	function(resp,opt) 
                                    {
                                        Ext.Msg.alert('Deleted',   ' Bilty#' + biltyNo+' deleted!');
                                        prodSummary.removeAll();
                                        allBatchesStore.reload(
                                        {
                                            waitMsg			:	'Loading...'
                                        });
                                    },
                                    failure				: 	function(resp,opt) 
                                    {
                                        Ext.Msg.alert('Error', 'Error in deleting!');
                                    }
                                });
                            }
                        }
                    });
                }
            }]
        },'->',
        {
            text			: 	'Delete Dispatch',
            iconCls			: 	'delete',
            handler 		: 	function()
            {
                var sm = allBatchesGrid.getSelectionModel();
                var sel = sm.getSelections();                                
                if(sel.length == 0)
                {
                    Ext.Msg.alert('Select Dispatch', 'No dispatch is selected!');
                    return;
                };
                var biltyNo = sel[0].get('biltyNo');
                if(biltyNo != 0)
                {
                    Ext.Msg.alert('Cant delete the dispatch ', 'Dispatch cant be deleted once bilty is created for it!');
                    return;
                };
                var dispatchID = sel[0].get('dispatchID');
                Ext.Msg.show(
                {
                    title			: 	'Confirm',
                    msg				: 	'Do you want to delete Dispatch#' +dispatchID,
                    buttons			: 	Ext.Msg.YESNO,
                    fn				: 	function(btn) 
                    {
                        if (btn == 'yes')
                        {                              
                            Ext.Ajax.request(
                            {
                                url				: 	'delete/delete-dispatch.jsp',
                                method			: 	'POST',
                                params			: 
                                {
                                    dispatchID 		: 	dispatchID
                                },
                                success			: 	function(resp,opt) 
                                {
                                    Ext.Msg.alert('Deleted',   ' Dispatch#' + dispatchID+' deleted!');
                                    allBatchesStore.reload(
                                    {
                                        waitMsg			:	'Loading...'
                                    });
                                    allTalukaOrderStore.removeAll();
                                    prodSummary.removeAll();
                                },
                                failure			: 	function(resp,opt) 
                                {
                                    //  Ext.Msg.hide();
                                    Ext.Msg.alert('Error', 'Error in deleting!');
                                }
                            });

                        }
                    }
                });                              
            }
        },'-'],
        columns				: 	
        [
         	new Ext.grid.RowNumberer(),
         	{   header: 'Dispatch#',width: 60,sortable: true,dataIndex: 'dispatchID',align: 'center'},
            {	header: 'Bilty#',width: 60,sortable: true,dataIndex: 'biltyNo',align: 'center'},
            {   header: 'Bilty Date',width: 60,sortable: true,dataIndex: 'biltyDate',align: 'center'},
            /*{	header: 'Godown',width: 60,sortable: true,  dataIndex: 'godownName',      align: 'center' },*/
            { 	header: 'Taluka', width: 60,sortable: true,  dataIndex: 'talukaMarathi',align: 'center'}, 
            { 	header: 'District',width: 60, sortable: true, dataIndex: 'districtMarathi',align: 'center'},
	        {	header: 'Truck Loading Capacity(Ton)',  width: 60,sortable: true, dataIndex: 'truckCapacity',align: 'center'},
            {	header: 'Dispatch Loading(Ton)',width: 60,sortable: true,dataIndex: 'actualLoading',align: 'center', renderer : fourDecimalNum},
            {	header: 'Empty Space', width: 60,sortable: true, dataIndex: 'emptySpace',align: 'center',
                renderer : function (value)
                {
                    value = fourDecimalNum(value);
                    if(value<0)
                    {
                        return '<span qtip="Over loaded" ext:qwidth="200" style="color:red;">' + value + '</span>';
                    }
                    return '<span qtip="Under loaded" ext:qwidth="200" style="color:green;">' + value + '</span>';
                }
            },
            {	header: 'Freight(Rs)/Ton',width: 60, sortable: true,dataIndex: 'freightPerTonInRupees',align: 'center'},
            {	header: 'Adv. Freight',width: 60,sortable: true,dataIndex: 'advanceFrieght',align: 'center'},
            {	header: 'Driver Name',width: 60, sortable: true,dataIndex: 'driverName',align: 'center'},
            {	header: 'Agent Name',  width: 60, sortable: true, dataIndex: 'agentName',align: 'center'},
            {	header: 'Driver License',width: 120,sortable: true,dataIndex: 'driverLicense',align: 'center'},
            {	header: 'Vehicle No.',width: 120,sortable: true,dataIndex: 'vehicleNo',align: 'center'}
        ],
        height			: 	500,
        width			: 	700,
        // paging bar on the bottom
        bbar			: 	[new Ext.PagingToolbar(
        {
            pageSize		: 	25,
            store			: 	allBatchesStore,
            displayInfo		: 	true,
            displayMsg		: 	'<b>Displaying Dispatch {0} - {1} of {2}</b>',
            emptyMsg		: 	"<b>No topics to display</b>"
        })]
    });
			
	
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
            new Ext.TabPanel(
            {
                region			: 	'center',
                deferredRender	: 	false,
                autoScroll		: 	true,
                bodyStyle		: 	'padding:1px;',
                id				: 	"center-tab-panel",
                activeTab		: 	0,
                items			: 	[
                {
                    title			: 	'Dispatch',
                    iconCls			: 	'home',
                    autoScroll		: 	true,
                    id				: 	"tab0",
                    layout			: 	'border',
                    items			: 	[
                    {
                        region			: 	"center",
                        bodyStyle		: 	'padding:5px;',
                        layout			: 	"fit",
                        items 			: 	allBatchesGrid
                    }]
                },
                {
                    title			: 	'Dispatch Taluka Orders',
                    iconCls			: 	'home',
                    autoScroll		: 	true,
                    id				: 	"tab1", 
                    bodyStyle		: 	'padding:1px;',
                    layout			: 	'border',
                    items			: 	[
                    {
                        region			: 	"center",
                        height 			: 	600,
                        layout			: 	"fit",
                        items 			: 	
                        {
                            border 			: 	true,
                            items 			:	[
                            {
                            	region			: 	"north",
                                bodyStyle		: 	'padding:1px;',
                                layout			: 	"fit",
                                height			: 	230,
                                items 			: 	[
                                {
                                    region			: 	"north",
                                    bodyStyle		: 	'padding:1px;',
                                    layout			: 	"fit",
                                    items 			: 	[fromProductionBatchesGrid]
                                }]
                            },
                            {
                                region			: 	"center",
                                bodyStyle		: 	'padding:1px;',
                                layout			: 	"fit",                                                       
                                items 			: 	[
                                {                                                             
                                    bodyStyle		: 	'padding:1px;',
                                    layout			: 	"fit",
                                    height 			: 	300,
                                    items 			: 	[fromTalukaOrderGrid]
                                }]
                            }]
                        }
                    }]
                }]
            })
        ]
    });
	
	showReportsWin = function ()
	{
		alert(1);
		return;
	};

});

