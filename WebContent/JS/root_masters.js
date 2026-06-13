Ext.BLANK_IMAGE_URL = './resources/images/default/s.gif';
var stdTypeDetails;
var talukaID;
Ext.onReady(function()
{    	
	//Get All District Store
    var reader= new Ext.data.JsonReader(
    {
        root: 'root',
        idProperty : 'districtID',
        totalProperty: 'totalElements',
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
         autoLoad: false,
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
    
    allRootStore= new Ext.data.JsonStore(
    {
        autoLoad: true,
        root: 'root',
        storeId: 'allRootStore',
        url: 'read/get-all-root.jsp',
    	idProperty : 'rootMasterID',
    	fields: ['rootMasterID','rootMarathi','root'],
        sortInfo: 
        {
            field:'rootMasterID',
            direction:'DESC'
        }
    });
    
    //Get All School for root Store
    allSchoolForRootStore= new Ext.data.JsonStore(
    {
        storeId: 'allSchoolForRootStore',
        url: 'read/get-all-schools-for-root.jsp',
        root: 'root',
        idProperty : 'schoolID',
        fields: ['schoolID','school','schoolMarathi'],
        sortInfo: 
        {
            field:'schoolID',
            direction:'DESC'
        }
    });
    
    //Get All School added to Root for grid
    allSchoolStore= new Ext.data.JsonStore(
    {
        storeId: 'allSchoolStore',
        url: 'read/get-all-schools-by-root.jsp',
        root: 'root',
        idProperty : 'schoolID',
        fields: ['rootDetailsID','schoolID','school','schoolMarathi'],
        sortInfo: 
        {
            field:'schoolID',
            direction:'DESC'
        }
    });
    
    // Add District Form    
    addRootForm = new Ext.FormPanel(
    {
        labelAlign: 'right',
        frame:true,
        id: 'root-form',
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
                    id:'rootEnglish',
                    anchor: '90%',
                    fieldLabel: 'Route English',
                    allowBlank: false,
                    name: 'rootEnglish',
                    msgTarget : 'side',
                    blankText : 'Correct This field',
                    hiddenName : 'rootEnglish'
                },
                {
                    xtype:'textfield',
                    fieldLabel: 'Route Marathi',
                    anchor: '90%',                   
                    id:'rootMarathi',
                    allowBlank: false,
                    name: 'rootMarathi',
                    msgTarget : 'side',
                    blankText : 'Correct This field',
                    hiddenName : 'rootMarathi'
                }]
            }]
        }],
        buttons: [
        {
            text: 'Save',
            scale: 'medium',
            handler: function()
            {
                addRootForm.getForm().submit(
                {
                    url: 'create/create-root.jsp',
                    method: 'POST',
                    success: function(form, action)
                    {
                    	allRootStore.load();
                        Ext.Msg.alert('Success', 'Root Saved');
                    },
                    failure: function(form, action)
                    {
                        if(action.response != undefined)
                        {
                            Ext.Msg.alert('Warning', 'Root Already Exists');
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
            handler: function()
            {
                addRootForm.getForm().reset();
            }
        }]
    });        
    
    // Add District Form    
    editRootForm = new Ext.FormPanel(
    {
        labelAlign: 'right',
        frame:true,
        id: 'root-form',
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
				    xtype:'hidden',
				    id:'erootMasterID',
				    anchor: '90%',
				    fieldLabel: 'Route ID',
				    allowBlank: false,
				    name: 'erootMasterID',
				    msgTarget : 'side',
				    blankText : 'Correct This field',
				    hiddenName : 'erootMasterID'				    
				},
                {
                    xtype:'textfield',
                    id:'erootEnglish',
                    anchor: '90%',
                    fieldLabel: 'Route English',
                    allowBlank: false,
                    name: 'erootEnglish',
                    msgTarget : 'side',
                    blankText : 'Correct This field',
                    hiddenName : 'erootEnglish'
                },
                {
                    xtype:'textfield',
                    fieldLabel: 'Route Marathi',
                    anchor: '90%',                   
                    id:'erootMarathi',
                    allowBlank: false,
                    name: 'erootMarathi',
                    msgTarget : 'side',
                    blankText : 'Correct This field',
                    hiddenName : 'erootMarathi'
                }]
            }]
        }],
        buttons: [
        {
            text: 'Save',
            scale: 'medium',
            handler: function()
            {
                editRootForm.getForm().submit(
                {
                    url: 'update/update-root.jsp',
                    method: 'POST',
                    success: function(form, action)
                    {
                    	allRootStore.load();
                        Ext.Msg.alert('Success', 'Route Saved');
                    },
                    failure: function(form, action)
                    {
                        if(action.response != undefined)
                        {
                            Ext.Msg.alert('Warning', 'Route Already Exists');
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
            handler: function()
            {
                editRootForm.getForm().reset();
            }
        }]
    });        
    
    //Add and Update Sales Order Detail Form
	rootSchoolForm = new Ext.FormPanel(
	{
		labelAlign		: 	'left',
        border 			:	false, 
        baseCls			: 	'x-plain',
        autoHeight		: 	true,
        id				: 	'rootSchoolForm',
        autoDestroy 	: 	true, 
        //bodyStyle		: 	'padding: 5px',
        layout			:	'fit',
        buttonAlign		: 	'center',
        items			: 	[
        {
            xtype			: 	'fieldset',
            autoHeight		: 	true,
            //collapsible 	: 	false,
            //collapsed		: 	false,
            title			: 	'Route School',
            style			:	'background-color:white;',
            id				:	'grn2',
            items 			: 	[
            {
            	layout			:	'column',
        		border			: 	false, 
                items			:	[
                {                    	
                    columnWidth		:	.50,
                    layout			: 	'form',
                    border			: 	false, 
                    items			: 	[
					{
					    xtype:'combo',
					    editable:false,
					    id:'c8',
					    store: allDistrictStore,
					    allowBlank: false,
					    forceSelection : true,
					    triggerAction : 'all',
					    selectOnFocus :true,
					    mode :'local',
					    displayField : 'districtList' ,
					    valueField: 'districtID',
					    fieldLabel: '<b>Select District</b>',
					    name: 'district',
					    hiddenName : 'districtID',
					    msgTarget : 'side',
					    blankText : 'Correct This field',
					    anchor:'90%',
					    listeners: 
					    {
					        select : function(cmb,rec,idx) 
					        {
					            tCombo = Ext.getCmp('c9');
					            tCombo.clearValue();
					            allTalukaStore.load(
					            {
					                params:
					                {
					                    districtID:this.getValue()
					                }
					            });
					        }
					    }
					},
					{
	                    xtype:'combo',
	                    id: 'c10',
	                    fieldLabel: '<b>Select Section</b>',
	                    allowBlank: false,
	                    displayField : 'sectionMarathi' ,
	                    valueField: 'sectionID',
	                    forceSelection : true,
	                    triggerAction : 'all',
	                    selectOnFocus :true,
	                    editable:false,
	                    store: allSectionStore,
	                    mode :'local',
	                    name: 'section',
	                    hiddenName : 'section',
	                    msgTarget : 'side',
	                    blankText : 'Correct This field',
	                    anchor:'90%',
	                    listeners: 
	                    {
	                        select : function(cmb,rec,idx) 
	                        {
	                            tCombo = Ext.getCmp('c11');
	                            tCombo.clearValue();
	                            allBeatStore.load(
	                            {
	                                params:
	                                {
	                                    sectionID:this.getValue()
	                                }
	                            });
	                        }
	                    }
	                },
                    {
                    	xtype			:	'textfield',
					    fieldLabel		: 	'<b> Route Name </b>',
					    id				:	'srootMarathi',
					    name			: 	'srootMarathi',
					    hiddenName 		: 	'srootMarathi',
						anchor			:	'90%',
					    readOnly		:	true
                    },{
                    	xtype			:	'hidden',
					    id				:	'srootMasterID',
					    name			: 	'srootMasterID',
					    hiddenName 		: 	'srootMasterID'
                    }]
                },
                {
                	columnWidth		:	.50,
                    layout			: 	'form',
                    border			: 	false, 
                    items			: 	[
                    {
	                    xtype:'combo',
	                    id: 'c9',
	                    fieldLabel: '<b>Select Taluka</b>',
	                    allowBlank: false,
	                    forceSelection : true,
	                    triggerAction : 'all',
	                    selectOnFocus :true,
	                    editable:false,
	                    mode :'local',
	                    store: allTalukaStore,
	                    name: 'taluka',
	                    hiddenName : 'talukaID',
	                    displayField : 'talukaMarathi' ,
	                    valueField: 'talukaID',
	                    msgTarget : 'side',
	                    blankText : 'Correct This field',
	                    anchor:'90%',
	                    listeners: 
	                    {
	                        select : function(cmb,rec,idx) 
	                        {
	                            tCombo = Ext.getCmp('c10');
	                            tCombo.clearValue();
	                            allSectionStore.load(
	                            {
	                                params:
	                                {
	                                    talukaID:this.getValue()
	                                }
	                            });
	                        }
	                    }
	                },
	                {
	                    xtype:'combo',
	                    id: 'c11',
	                    fieldLabel: '<b>Select Beat</b>',
	                    allowBlank: false,
	                    forceSelection : true,
	                    triggerAction : 'all',
	                    selectOnFocus :true,
	                    editable:false,
	                    mode :'local',
	                    store: allBeatStore,
	                    name: 'beat',
	                    hiddenName : 'beatID',
	                    displayField : 'beatMarathi' ,
	                    valueField: 'beatID',
	                    msgTarget : 'side',
	                    blankText : 'Correct This field',
	                    anchor:'90%',
	                    listeners: 
	                    {
	                        select : function(cmb,rec,idx) 
	                        {
	                            tCombo = Ext.getCmp('schoolCombo');
	                            tCombo.clearValue();
	                            allSchoolForRootStore.load(
	                            {
	                                params:
	                                {
	                                    beatID:this.getValue()
	                                }
	                            });
	                        }
	                    }
	                },
	                {
                    	xtype			:	'combo',
					    fieldLabel		: 	'<b> Select School </b>',
					    id				:	'schoolCombo',
					    name			: 	'schoolCombo',
					    hiddenName 		: 	'schoolCombo',
					    editable		: 	true,
					    store			: 	allSchoolForRootStore,
						mode 			: 	'local',
						valueField		: 	'schoolID',
						displayField	: 	'schoolMarathi',
						triggerAction	: 	'all',
					    allowBlank		: 	false,
						forceSelection	: 	true,
						anchor			:	'90%'
                    }]
                }]
            }],
            buttons	:[
            {
	         	text		: 	'ADD',
	         	id			:	'save1',
	            scale		: 	'medium',
	            iconCls		:	'save',
	            handler		:	function(){
	            	rootSchoolForm.getForm().submit(
        	    	{
        	    		url		: 	'create/add-school-to-root.jsp',
	                    method	: 	'POST',
	                    success	: function(form, action)
	                    {
	                    	Ext.getCmp('schoolCombo').setValue("");
	                    	allSchoolStore.reload();
	                    	allSchoolForRootStore.reload();
	                        Ext.Msg.alert('Success', 'School Added to Route');
	                    },
	                    failure	: function(form, action)
	                    {
	                        if(action.response != undefined)
	                        {
	                            Ext.Msg.alert('Warning', 'Error in Adding School');
	                        }
	                        else
	                        {
	                            Ext.MessageBox.alert('Alert...', 'Enter Data Correctly...');
	                        }
	                    }
	                });
	            }
	        }]
        }]
	});
	
	rootSchoolGrid = new Ext.grid.GridPanel(
    {
        store			: 	allSchoolStore,
        stateId			: 	'rootSchoolGrid',
        region			:	'center',
        stripeRows		: 	true,
        columnLines		: 	true,
        width			: 	575,
        height			:	300,
        autoScroll		:	true,
        title			: 	'Route School',
        stateful		: 	true,
        tbar			: 	['->',
     	{
	        iconCls			: 	'delete',
	        text			: 	'Remove School',
	        handler			: 	function()
	        {
	        	sm = rootSchoolGrid.getSelectionModel();
                var sel = sm.getSelections();
                if(sel.length == 0) {Ext.Msg.alert('Select School', 'No School is selected!');return;};
                rootDetailsID = sel[0].get('rootDetailsID');
                schoolMarathi = sel[0].get('schoolMarathi');
	        	
                Ext.Msg.show(
                {
                    title: 'Confirm',
                    msg: 'Do you want to Remove <B>'+schoolMarathi+'</B> Item Details?' ,
                    buttons: Ext.Msg.YESNO,
                    fn: function(btn)
                    {
                        if (btn == 'yes'){
                            Ext.Ajax.request(
                            {
                                url: 'delete/delete-school-from-root.jsp',
                                method: 'POST',
                                params: 
                                {
                                	rootDetailsID : rootDetailsID
                                },
                                success: function(resp,opt)
                                {
                                	Ext.getCmp('schoolCombo').setValue("");
        	                    	allSchoolStore.reload();
        	                    	allSchoolForRootStore.load();
                                    Ext.Msg.alert('Deleted', ' School deleted!');
                                },
                                failure: function(resp,opt)
                                {
                                    Ext.Msg.alert('Error', 'Error in deleting!');
                                }
                            });
                        }
                    }
                });
	        }
        }],
        columns			:
        [
         									new Ext.grid.RowNumberer(),
	        {	header   : 'Root Details ID',	width    : 80,	sortable : true,	dataIndex: 'rootDetailsID', 	hidden:true },
	        {	header   : 'School ID',			width    : 80,	sortable : true,	dataIndex: 'schoolID', 			hidden:true },
        	{ 	header   : 'School Name',		width    :150,	sortable : true,	dataIndex: 'schoolMarathi',  	hidden:false}
        ],
        bbar			: 	new Ext.PagingToolbar({
            pageSize		: 	25,
            store			: 	allSchoolStore,
            displayInfo		: 	true,
            displayMsg		: 	'Displaying results {0} - {1} of {2}',
            emptyMsg		:	"No results to display"
        })
    }); 
			
    
    // create the District Grid
    rgrid = new Ext.grid.GridPanel(
    {
        store: allRootStore,  
        stripeRows: true,
        columnLines: true,
        listeners : 
        {
            //dblclick  : showAllTaluka
        },

        tbar:[
        {
            text: 'Add', 
            iconCls: 'add',
            handler : function()
            {
            	addRootForm.getForm().reset();
                openWin(addRootForm, 'Route',200,350);
            }            
        },'-', 
        {
            text: 'Edit', 
            iconCls: 'edit',
            handler : function()
            {
                var sm = rgrid.getSelectionModel();
                var sel = sm.getSelections();
                if(sel.length == 0) {Ext.Msg.alert('Select Route', 'No Route is selected!');return;};
                Ext.getCmp('erootEnglish').setValue(sel[0].get('root'));
                Ext.getCmp('erootMarathi').setValue(sel[0].get('rootMarathi'));
                Ext.getCmp('erootMasterID').setValue(sel[0].get('rootMasterID'));

                openEdit(editRootForm, 'Route',200,350);
            }
        },'-', 
        {
            text: 'Add/Remove School', 
            iconCls: 'showall',
            handler : function()
            {
            	var sm = rgrid.getSelectionModel();
                var sel = sm.getSelections();
                if(sel.length == 0) {Ext.Msg.alert('Select Root', 'No Route is selected!');return;};
                Ext.getCmp('srootMarathi').setValue(sel[0].get('rootMarathi'));
                Ext.getCmp('srootMasterID').setValue(sel[0].get('rootMasterID'));
                allSchoolStore.load(
                {
                    params : {rootMasterID : sel[0].get('rootMasterID')},
                    waitMsg : 'loading...'
                });
                allDistrictStore.load();
            	addItemWin(rootSchoolForm, 'Add School to Route',400,600);
            }
        },'-', 
        {
            text: 'View Schools', 
            iconCls: 'view',
            handler : function()
            {
                var sm = rgrid.getSelectionModel();
                var sel = sm.getSelections();
                if(sel.length == 0) {Ext.Msg.alert('Select Route', 'No Route is selected!');return;};
                var rootMarathi = sel[0].get('rootMarathi');
                var rootID = sel[0].get('rootMasterID');


                var param = "rootID="+rootID+"&rootMarathi="+rootMarathi;
                window.open("reports/print-root-wise-school-list-report.jsp?"+param,'talukaloadingreport',"width=1500,height=800,top=40,left=60,menubar=1,resizable=0,location=1,scrollbars=1");
            }
        },'->',
        {
            text: 'Delete', 
            iconCls: 'delete',
            handler : function()
            {
            	var sm = rgrid.getSelectionModel();
                var sel = sm.getSelections();
                if(sel.length == 0) {Ext.Msg.alert('Select Route', 'No Route is selected!');return;};
                
                var rootMarathi = sel[0].get('rootMarathi');
                var rootMasterID = sel[0].get('rootMasterID');
                Ext.Msg.show(
                {
                    title: 'Confirm',
                    msg: 'Do you want to delete '+rootMarathi+' Root?' ,
                    buttons: Ext.Msg.YESNO,
                    fn: function(btn) 
                    {
                        if (btn == 'yes') 
                        {
                            Ext.Ajax.request(
                            {
                                url: 'delete/delete-root.jsp',
                                method: 'POST',
                                params: 
                                {
                                    rootMasterID : rootMasterID
                                },
                                success: function(resp,opt) 
                                {
                                    Ext.Msg.alert('Deleted', ' Route deleted!');
                                    allRootStore.reload(
                                    {
                                        waitMsg:'Loading...'
                                    });
                                },
                                failure: function(resp,opt) 
                                {
                                    Ext.Msg.alert('Error', 'Error in deleting!');
                                }
                            });
                        }
                    }
                });
            }
        }],
        columns: [
        {
            header   : 'Route ID',
            width    : 80,
            sortable : true,
            dataIndex: 'rootMasterID'
        },
        {
            header   : 'Route English',
            wiRootdth    :120,
            sortable : true,
            dataIndex: 'root'
        },
        {
            header   : 'Route Marathi',
            width    : 120,
            sortable : true,
            dataIndex: 'rootMarathi'
        }],
        stripeRows: true,
        columnLines: true,
        height:500,
        width: 350,
        title: 'Route Master',
        stateful: true,
        stateId: 'rgrid',
        
        bbar: new Ext.PagingToolbar(
        {
            pageSize: 100,
            store: allRootStore,
            displayInfo: true,
            displayMsg: 'Displaying results {0} - {1} of {2}',
            emptyMsg: "No results to display"
        })
    });
      
    var mainTab = new Ext.TabPanel(
    {
        id:'center-tab-panel',
        autoTabs:true,
        activeTab:0,autoScroll : true,
        deferredRender:false,
        border:false,
        items:[rgrid]
    });

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
            }
        ]
     });
    
    addItemWin = function(form, Title, ht, width)
    {
        var winTitle = ("Enter " +Title );       
        win = new Ext.Window(
        {
        	layout:'fit',
            width:width,
            modal: true,
            height:ht,
            iconCls: 'add',
            closeAction:'hide',
            title : winTitle,
            items : [
            {
                layout :"border",
                items :[{
                        region:"center",
                        layout:'fit',
                        items:[rootSchoolForm,rootSchoolGrid]
                    }
                ]
            }]
        });
        win.show(this);
    };
    

});
