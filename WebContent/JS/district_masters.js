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
    
    /*allDistrictStore= new Ext.data.JsonStore(
    {
        autoLoad: true,
        storeId: 'allDistrictStore',
        url: 'read/get-all-districts.jsp',
        root: 'root',
        idProperty : 'districtID',
        fields: ['districtID','districtMarathi', 'district', 'stdTypeDetails','districtList' ],
        sortInfo: 
        {
            field:'districtID',
            direction:'DESC'
        }
    });*/
        
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
    
    var schoolTypeStore = new Ext.data.SimpleStore(
    {
        fields: [
        {
            name: 'schoolType',
            type: 'int'
        },
        {
            name: 'text'
        }]
    });

    var schoolTypeData = 
    [
        [1, 'STD 1 TO 5'],
        [2, 'STD 6 TO 8']
    ];

    schoolTypeStore.loadData(schoolTypeData);
      
    // Add District Form    
    addDistrictForm = new Ext.FormPanel(
    {
        labelAlign: 'right',
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
                    id:'t1',
                    anchor: '90%',
                    fieldLabel: 'District English',
                    allowBlank: false,
                    name: 'districtEnglish',
                    msgTarget : 'side',
                    blankText : 'Correct This field',
                    hiddenName : 'districtEnglish'

                },
                {
                    xtype:'textfield',
                    fieldLabel: 'District Marathi',
                    anchor: '90%',                   
                    id:'t2',
                    allowBlank: false,
                    name: 'districtMarathi',
                    msgTarget : 'side',
                    blankText : 'Correct This field',
                    hiddenName : 'districtMarathi'
                },
                {
                    xtype: 'combo',
                    id: 'c12',
                    anchor: '90%',
                    fieldLabel: 'School Type',
                    fields: ['schoolType', 'text'],
                    store: schoolTypeStore,
                    mode: 'local',
                    valueField: 'schoolType',
                    displayField: 'text',
                    forceSelection: true,
                    triggerAction: 'all',
                    selectOnFocus: true,
                    editable: false,
                    name: 'schooltype',
                    hiddenName: 'schoolType',
                    allowBlank: false
                }]
            }]
        }],
        buttons: [
        {
            text: 'Save',
            scale: 'medium',
            handler: function()
            {
                addDistrictForm.getForm().submit(
                {
                    url: 'create/create-district.jsp',
                    method: 'POST',
                    success: function(form, action)
                    {
                        allDistrictStore.load();
                        Ext.Msg.alert('Success', 'District Saved');
                    },
                    failure: function(form, action)
                    {
                        if(action.response != undefined)
                        {
                            Ext.Msg.alert('Warning', 'District Already Exists');
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
                addDistrictForm.getForm().reset();
            }
        }]
    });
        
    // Edit District Form
    editDistrictForm = new Ext.FormPanel(
    {
        labelAlign: 'right',
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
                    id:'edfe',
                    fieldLabel: 'District English',
                    allowBlank: false,
                    name: 'districtEnglish',
                    hiddenName : 'districtEnglish',
                    msgTarget : 'side',
                    blankText : 'Enter Data Correctly...'
                },{
                    xtype:'textfield',
                    fieldLabel: 'District Marathi',
                    id:'edfm',
                    allowBlank: false,
                    name: 'districtMarathi',
                    msgTarget : 'side',
                    blankText : 'Enter Data Correctly...',
                    hiddenName : 'districtMarathi'
                },
                {
                    xtype:'hidden',
                    name:'districtID',
                    id:'edf-h',
                    hiddenName : 'districtID',
                    value : '',
                    hiddenName : 'orderID'
                },
                {
                    xtype:'hidden',
                    name:'stdType',
                    id:'edfs-h',
                    hiddenName : 'stdType',
                    value : '',
                    hiddenName : 'stdType'
                }]
            }]
        }],
        buttons: [
        {
            text: 'Save',
            scale: 'medium',
            handler: function()
            {
                editDistrictForm.getForm().submit(
                {
                    url: 'update/update-district.jsp',
                    method: 'POST',
                    success: function(form, action)
                    {
                        allDistrictStore.reload(
                        {
                            waitMsg:'Loading...'
                        });
                        Ext.Msg.alert('Success', 'District updated');
                    },
                    failure: function(form, action)
                    {
                        if(action.response != undefined)
                        {
                            Ext.Msg.alert('Warning', 'District Already Exists');
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

    //ADD Taluka Form    
    addTalukaForm = new Ext.FormPanel(
    {
        labelAlign: 'right',
        frame:true,
        id: 't-form',
        autoDestroy : true,
        layout:'fit',
        buttonAlign: 'center',
        items: [
        {
            layout:'column',
            items:[
            {
                columnWidth:.33,
                layout: 'form',
                items: [
                {
                    xtype:'combo',
                    editable:false,
                    id:'c1',
                    store: allDistrictStore,
                    allowBlank: false,
                    forceSelection : true,
                    triggerAction : 'all',
                    selectOnFocus :true,
                    mode :'remote',
                    displayField : 'districtList' ,
                    valueField: 'districtID',
                    fieldLabel: 'Select District',
                    name: 'district',
                    hiddenName : 'districtID',
                    msgTarget : 'side',
                    blankText : 'Correct This field',
                    anchor:'90%'
                }]
            },
            {
                columnWidth:.33,
                layout: 'form',
                items: [ 
                {
                    xtype:'textfield',
                    fieldLabel: 'Taluka English',
                    name: 'talukaEnglish',
                    hiddenName : 'talukaEnglish',
                    allowBlank : false,
                    msgTarget : 'side',
                    blankText : 'Correct This field',
                    anchor:'90%'
                }]
            },{
                columnWidth:.33,
                layout: 'form',
                items: [
                {
                    xtype:'textfield',
                    fieldLabel: 'Taluka Marathi',
                    name: 'talukaMarathi',
                    hiddenName : 'talukaMarathi',
                    allowBlank : false,
                    msgTarget : 'side',
                    blankText : 'Correct This field',
                    anchor:'90%'
                }]
            }]
        }],
        buttons: [
        {
            text: 'Save',
            scale: 'medium',
            handler: function()
            {
                var distID = Ext.getCmp('c1').getValue();
                addTalukaForm.getForm().submit(
                {
                    url: 'create/create-taluka.jsp',
                    method: 'POST',
                    success: function(form, action)
                    {
                        allTalukaStore.reload({
                            params : {districtID : distID},
                            waitMsg : 'loading...'
                        });
                        Ext.Msg.alert('Success', 'Taluka Saved');
                    },
                    failure: function(form, action)
                    {
                        if(action.response != undefined)
                        {
                            Ext.Msg.alert('Warning', 'Taluka Already Exists');
                        }
                        else
                        {
                            Ext.Msg.alert('Alert...','Enter Details Correctly...');
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
                addTalukaForm.getForm().reset();
            }
        }]
    });

    // Edit Taluka Form
    editTalukaForm = new Ext.FormPanel(
    {
        labelAlign: 'right',
        frame:true,
        id: 'ett-form',
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
                    id:'etfe',
                    fieldLabel: 'Taluka English',
                    allowBlank: false,
                    name: 'talukaEnglish',
                    msgTarget : 'side',
                    blankText : 'Correct This field',
                    hiddenName : 'talukaEnglish'
                },{
                    xtype:'textfield',
                    fieldLabel: 'Taluka Marathi',
                    id:'etfm',
                    allowBlank: false,
                    name: 'talukaMarathi',
                    msgTarget : 'side',
                    blankText : 'Correct This field',
                    hiddenName : 'talukaMarathi'
                },
                {
                    xtype:'hidden',
                    name:'talukaID',
                    id:'etf-h',
                    hiddenName : 'talukaID',
                    value : '',
                    hiddenName : 'talukaID'
                },
                {
                    xtype:'hidden',
                    name:'districtID',
                    id:'etdfm',
                    hiddenName : 'districtID',
                    value : '',
                    hiddenName : 'districtID'
                }]
            }]
        }],
        buttons: [
        {
            text: 'Save',
            scale: 'medium',
            handler: function()
            {
                editTalukaForm.getForm().submit(
                {
                    url: 'update/update-taluka.jsp',
                    method: 'POST',
                    success: function(form, action)
                    {
                        allTalukaStore.reload(
                        {
                            waitMsg:'Loading...'
                        });

                        Ext.Msg.alert('Success', 'Taluka updated');
                    },
                    failure: function(form, action)
                    {
                        if(action.response != undefined)
                        {
                            Ext.Msg.alert('Warning', 'Taluka Already Exists');
                        }
                        else
                        {
                            Ext.Msg.alert('Alert...','Enter Details Correctly...');
                        }
                    }
                });
            }
        }]
    });

    // Add Section Form
    addSectionForm = new Ext.FormPanel(
    {
        labelAlign: 'right',
        frame:true,
        id: 'se-form',
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
                    xtype:'combo',
                    editable:false,
                    id:'c2',
                    store: allDistrictStore,
                    allowBlank: false,
                    forceSelection : true,
                    triggerAction : 'all',
                    selectOnFocus :true,
                    mode :'local',
                    displayField : 'districtList' ,
                    valueField: 'districtID',
                    fieldLabel: 'Select District',
                    name: 'district',
                    hiddenName : 'districtID',
                    msgTarget : 'side',
                    blankText : 'Correct This field',
                    anchor:'95%',
                    listeners: 
                    {
                        select : function(cmb,rec,idx) 
                        {
                            tCombo = Ext.getCmp('c3');
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
                    xtype: 'textfield',
                    fieldLabel : 'Section English',
                    allowBlank: false,
                    hiddenName :  'sectionEnglish',
                    name :  'sectionEnglish',
                    anchor:'95%',
                    msgTarget : 'side',
                    blankText : 'This Field Is Required'
                },
                {
                	xtype			: 	'radiogroup',
                	fieldLabel		: 	'<b> Beat </b>',
                	allowBlank		: 	false,
                    msgTarget 		: 	'under',
                    blankText 		: 	'Select Beat Yes Or No',
                    anchor			:	'85%',
                    id				:	'rd',
                    items			: 	[
                    {
                    	boxLabel		: 	'Yes', 
                    	name			: 	'beatFlag', 
                    	inputValue		: 	0
                    },
                    {	boxLabel		: 	'No', 
                    	name			: 	'beatFlag', 
                    	inputValue		: 	1
                    }]
                }]
            },
            {
                columnWidth:.50,
                layout: 'form',
                items: [ 
                {
                    xtype:'combo',
                    id: 'c3',
                    fieldLabel: 'Select Taluka',
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
                    anchor:'95%',
                    msgTarget : 'side',
                    blankText : 'This Field Is Required'
                },
                {
                    xtype: 'textfield',
                    fieldLabel : 'Section Marathi',
                    allowBlank: false,
                    hiddenName :  'sectionMarathi',
                    name :  'sectionMarathi',
                    anchor:'95%',
                    msgTarget : 'side',
                    blankText : 'This Field Is Required'
                }]
            }]
        }],
        buttons: [
        {
            text: 'Save',
            scale: 'medium',
            handler: function()
            {
                var talID = Ext.getCmp('c3').getValue();
                addSectionForm.getForm().submit(
                {
                    url: 'create/create-section.jsp',
                    method: 'POST',
                    success: function(form, action)
                    {
                        allSectionStore.reload(
                        {
                            talukaID : talID,
                            waitMsg:'Loading...'
                        });   
                        Ext.Msg.alert('Success', 'Section Saved');
                    },
                    failure: function(form, action)
                    {
                        if(action.response != undefined)
                        {
                            Ext.Msg.alert('Warning', 'Section Already Exists');
                        }
                        else
                        {
                            Ext.Msg.alert('Alert...','Enter Details Correctly...');
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
                addSectionForm.getForm().reset();
            }
        }]
    });

    //Edit Section Form
    editSectionForm = new Ext.FormPanel(
    {
        labelAlign: 'right',
        frame:true,
        id: 'est-form',
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
                    xtype:'textfield',
                    id:'esfe',
                    fieldLabel: 'Section English',
                    allowBlank: false,
                    name: 'sectionEnglish',
                    hiddenName : 'sectionEnglish',
                    msgTarget : 'side',
                    blankText : 'Correct This field',
                    anchor:'95%'
                },
                {
                    xtype:'hidden',
                    name:'sectionID',
                    id:'esf-h',
                    hiddenName : 'sectionID',
                    value : '',
                    hiddenName : 'sectionID',
                    anchor:'95%'
                },
                {
                	xtype			: 	'radiogroup',
                	fieldLabel		: 	'<b> Beat </b>',
                	allowBlank		: 	false,
                    msgTarget 		: 	'under',
                    blankText 		: 	'Select Beat Yes Or No',
                    anchor			:	'85%',
                    id				:	'erd',
                    items			: 	[
                    {
                    	boxLabel		: 	'Yes', 
                    	name			: 	'beatFlag', 
                    	inputValue		: 	0
                    },
                    {	boxLabel		: 	'No', 
                    	name			: 	'beatFlag', 
                    	inputValue		: 	1
                    }]
                }]
            },
            {
                columnWidth:.50,
                layout: 'form',
                items: [
                {
                    xtype:'textfield',
                    fieldLabel: 'Section Marathi',
                    id:'esfm',
                    allowBlank: false,
                    name: 'sectionMarathi',
                    hiddenName : 'sectionMarathi', 
                    msgTarget : 'side',
                    blankText : 'Correct This field',
                    anchor:'95%'
                }]
            }]
        }],
        buttons: [
        {
            text: 'Save',
            scale: 'medium',
            handler: function()
            {
                editSectionForm.getForm().submit(
                {
                    url: 'update/update-section.jsp',
                    method: 'POST',
                    success: function(form, action)
                    {
                        allSectionStore.reload(
                        {
                            waitMsg:'Loading...'
                        });
                        Ext.Msg.alert('Success', 'Section updated');
                    },
                    failure: function(form, action)
                    {
                        if(action.response != undefined)
                        {
                            Ext.Msg.alert('Warning', 'Section Already Exists');
                        }
                        else{
                            Ext.Msg.alert('Alert...', 'Enter Details Correctly...');
                        }
                    }
                });
            }
        }]
    });
    
    // Add Beat Form
    addBeatForm = new Ext.FormPanel(
    {
        labelAlign: 'right',
        frame:true,
        id: 'b-form',
        autoDestroy : true,
        layout:'fit',
        buttonAlign: 'center',
        items: [
        {
            layout:'column',
            items:[
            {
                columnWidth:.33,
                layout: 'form',
                items: [
                {
                    xtype:'combo',
                    editable:false,
                    id:'c5',
                    store: allDistrictStore,
                    allowBlank: false,
                    forceSelection : true,
                    triggerAction : 'all',
                    selectOnFocus :true,
                    mode :'local',
                    displayField : 'districtList' ,
                    valueField: 'districtID',
                    fieldLabel: 'Select District',
                    name: 'district',
                    hiddenName : 'districtID',
                    msgTarget : 'side',
                    blankText : 'Correct This field',
                    anchor:'90%',
                    listeners: 
                    {
                        select : function(cmb,rec,idx) 
                        {
                            tCombo = Ext.getCmp('c6');
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
                    xtype: 'textfield',
                    fieldLabel : 'Beat English',
                    allowBlank: false,
                    hiddenName :  'beatEnglish',
                    msgTarget : 'side',
                    blankText : 'Correct This field',
                    name :  'beatEnglish',
                    anchor:'90%'
                }]
            },
            {
                columnWidth:.33,
                layout: 'form',
                items: [ 
                {
                    xtype:'combo',
                    id: 'c6',
                    fieldLabel: 'Select Taluka',
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
                            tCombo = Ext.getCmp('c7');
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
                    xtype: 'textfield',
                    fieldLabel : 'Beat Marathi',
                    allowBlank: false,
                    hiddenName :  'beatMarathi',
                    msgTarget : 'side',
                    blankText : 'Correct This field',
                    name :  'beatMarathi',
                    anchor:'90%'
                }]
            },
            {
                columnWidth:.33,
                layout: 'form',
                items: [
                {
                    xtype:'combo',
                    id: 'c7',
                    fieldLabel: 'Select Section',
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
                    anchor:'90%'
                }]
            }]
        }],
        buttons: [
        {
            text: 'Save',
            scale: 'medium',
            handler: function()
            {
                //var sectID = Ext.getCmp('c7').getValue();
                addBeatForm.getForm().submit(
                {
                    url: 'create/create-beat.jsp',
                    method: 'POST',
                    success: function(form, action)
                    {
                        Ext.Msg.alert('Success', 'Beat Saved');
                        allBeatStore.reload(
                        {
                            waitMsg:'Loading...'
                        });
                    },
                    failure: function(form, action)
                    {
                        if(action.response != undefined)
                        {
                            Ext.Msg.alert('Warning', 'Beat Already Exists');
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
                addBeatForm.getForm().reset();
            }
        }]
    });

    // Edit School Form
    editBeatForm = new Ext.FormPanel(
    {
        labelAlign: 'right',
        frame:true,
        id: 'ebeat-form',
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
                    id:'ebfe',
                    fieldLabel: 'Beat English',
                    allowBlank: false,
                    name: 'beatEnglish',
                    msgTarget : 'side',
                    blankText : 'Correct This field',
                    hiddenName : 'beatEnglish'
                },{
                    xtype:'textfield',
                    fieldLabel: 'Beat Marathi',
                    id:'ebfm',
                    allowBlank: false,
                    name: 'beatMarathi',
                    msgTarget : 'side',
                    blankText : 'Correct This field',
                    hiddenName : 'beatMarathi'
                },
                {
                    xtype:'hidden',
                    name:'beatID',
                    id:'ebf-h',
                    hiddenName : 'beatID',
                    value : '',
                    hiddenName : 'beatID'
                }]
            }]
        }],
        buttons: [
        {
            text: 'Save',
            scale: 'medium',
            handler: function()
            {
                editBeatForm.getForm().submit(
                {
                    url: 'update/update-beat.jsp',
                    method: 'POST',
                    success: function(form, action)
                    {
                        allBeatStore.reload(
                        {
                            waitMsg:'Loading...'
                        });
                        Ext.Msg.alert('Success', 'Beat updated');
                    },
                    failure: function(form, action)
                    {
                        if(action.response != undefined)
                        {
                            Ext.Msg.alert('Warning', 'Beat Already Exists');
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

    // Add School Form
    addSchoolForm = new Ext.FormPanel(
    {
        labelAlign: 'right',
        frame:true,
        id: 's-form',
        autoDestroy : true,
        layout:'fit',
        buttonAlign: 'center',
        items: [
        {
            layout:'column',
            items:[
            {
                columnWidth:.33,
                layout: 'form',
                items: [
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
                    fieldLabel: 'Select District',
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
                    id: 'c11',
                    fieldLabel: 'Select Beat',
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
                    anchor:'90%'
                }]
            },
            {
                columnWidth:.33,
                layout: 'form',
                items: [ 
                {
                    xtype:'combo',
                    id: 'c9',
                    fieldLabel: 'Select Taluka',
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
                    xtype: 'textfield',
                    fieldLabel : 'School English',
                    allowBlank: false,
                    hiddenName :  'schoolEnglish',
                    msgTarget : 'side',
                    blankText : 'Correct This field',
                    name :  'schoolEnglish',
                    anchor:'90%'
                }]
            },
            {
                columnWidth:.33,
                layout: 'form',
                items: [
                {
                    xtype:'combo',
                    id: 'c10',
                    fieldLabel: 'Select Section',
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
                    xtype: 'textfield',
                    fieldLabel : 'School Marathi',
                    allowBlank: false,
                    hiddenName :  'schoolMarathi',
                    msgTarget : 'side',
                    blankText : 'Correct This field',
                    name :  'schoolMarathi',
                    anchor:'90%'
                }]
            }]
        }],
        buttons: [
        {
            text: 'Save',
            scale: 'medium',
            handler: function()
            {
                var sectID = Ext.getCmp('c11').getValue();
                addSchoolForm.getForm().submit(
                {
                    url: 'create/create-school.jsp',
                    method: 'POST',
                    success: function(form, action)
                    {
                        Ext.Msg.alert('Success', 'School Saved');
                        allSchoolStore.reload(
                        {
                            params : {beatID : sectID},
                            waitMsg:'Loading...'
                        });
                    },
                    failure: function(form, action)
                    {
                        if(action.response != undefined)
                        {
                            Ext.Msg.alert('Warning', 'School Already Exists');
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
                addSchoolForm.getForm().reset();
            }
        }]
    });

    // Edit School Form
    editSchoolForm = new Ext.FormPanel(
    {
        labelAlign: 'right',
        frame:true,
        id: 'esct-form',
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
                    id:'escfe',
                    fieldLabel: 'School English',
                    allowBlank: false,
                    name: 'schoolEnglish',
                    msgTarget : 'side',
                    blankText : 'Correct This field',
                    hiddenName : 'schoolEnglish'
                },{
                    xtype:'textfield',
                    fieldLabel: 'School Marathi',
                    id:'escfm',
                    allowBlank: false,
                    name: 'schoolMarathi',
                    msgTarget : 'side',
                    blankText : 'Correct This field',
                    hiddenName : 'schoolMarathi'
                },
                {
                    xtype:'hidden',
                    name:'schoolID',
                    id:'escf-h',
                    hiddenName : 'schoolID',
                    value : '',
                    hiddenName : 'schoolID'
                }]
            }]
        }],
        buttons: [
        {
            text: 'Save',
            scale: 'medium',
            handler: function()
            {
                editSchoolForm.getForm().submit(
                {
                    url: 'update/update-school.jsp',
                    method: 'POST',
                    success: function(form, action)
                    {
                        allSchoolStore.reload(
                        {
                            waitMsg:'Loading...'
                        });
                        Ext.Msg.alert('Success', 'School updated');
                    },
                    failure: function(form, action)
                    {
                        if(action.response != undefined)
                        {
                            Ext.Msg.alert('Warning', 'School Already Exists');
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
    
    /*
   	var tab3 = Ext.getCmp('tab3');
        tab3.setTitle("Section  Master");
        var tab4 = Ext.getCmp('tab4');
        tab4.setTitle("Beat Master");
        var tab5 = Ext.getCmp('tab5');
        tab5.setTitle("School Master");
     */

    showAllTaluka = function()
    {  
        allSchoolStore.removeAll();
        allBeatStore.removeAll();
        allSectionStore.removeAll();
        allTalukaStore.removeAll();
        var sm = grid.getSelectionModel();
        var sel = sm.getSelections();
        if(sel.length == 0) {Ext.Msg.alert('Select District', 'No district is selected!');return;};
        var id = sel[0].get('districtID');
        //var district = sel[0].get('district');
        stdTypeDetails = sel[0].get('stdTypeDetails');
        var districtMarathi = sel[0].get('districtMarathi');
        var tabPane = Ext.getCmp('center-tab-panel');
        var tab = Ext.getCmp('tab2');
        tab.setTitle("Taluka Master - (District - "+ districtMarathi+") "+stdTypeDetails);
        var tab3 = Ext.getCmp('tab3');
        tab3.setTitle("Section  Master");
        var tab4 = Ext.getCmp('tab4');
        tab4.setTitle("Beat Master");
        var tab5 = Ext.getCmp('tab5');
        tab5.setTitle("School Master");
        tabPane.setActiveTab(tab);
        allTalukaStore.reload({params:{districtID:id},waitMsg:'Loading...'});
    };
    
    showAllSection =  function()
    {
        allSchoolStore.removeAll();
        allBeatStore.removeAll();
        allSectionStore.removeAll();
        var sm = tgrid.getSelectionModel();
        var sel = sm.getSelections();
        if(sel.length == 0) {Ext.Msg.alert('Select Taluka', 'No taluka is selected!');return;};
        var id = sel[0].get('talukaID');
        var tabPane = Ext.getCmp('center-tab-panel');
        var tab = Ext.getCmp('tab3');
        tab.setTitle("Section  Master - (Taluka - "+sel[0].get('talukaMarathi')+ ")"+stdTypeDetails );
        var tab4 = Ext.getCmp('tab4');
        tab4.setTitle("Beat Master");
        var tab5 = Ext.getCmp('tab5');
        tab5.setTitle("School Master");
        tabPane.setActiveTab(tab);
        allSectionStore.load({params:{talukaID:id},waitMsg:'Loading...'});
    };
    
    showAllBeat = function()
    {
        allSchoolStore.removeAll();
        allBeatStore.removeAll();
        var bm = sgrid.getSelectionModel();
        var sel = bm.getSelections();
        if(sel.length == 0) {Ext.Msg.alert('Select Section', 'No Section is selected!');return;};
        var id = sel[0].get('sectionID');
        /*var rec = Ext.StoreMgr.lookup("allSectionStore").getById(id);  
        Ext.getCmp('taxDesc').setValue(rec.data.tax_Desp);*/
        //var district = sel[0].get('section');
        var tabPane = Ext.getCmp('center-tab-panel');
        var tab = Ext.getCmp('tab4');
        tab.setTitle("Beat Master - (Section - "+ sel[0].get('sectionMarathi')+") "+ stdTypeDetails);
        var tab5 = Ext.getCmp('tab5');
        tab5.setTitle("School Master");
        tabPane.setActiveTab(tab);
        allBeatStore.load({params:{sectionID:id},waitMsg:'Loading...'});
    };
    
    showAllSchools = function()
    {
        allSchoolStore.removeAll();
        var sm = bgrid.getSelectionModel();
        var sel = sm.getSelections();
        if(sel.length == 0) {Ext.Msg.alert('Select Beat', 'No Beat is selected!');return;};
        var id = sel[0].get('beatID');
        var beat = sel[0].get('beat');
        var tabPane = Ext.getCmp('center-tab-panel');
        var tab = Ext.getCmp('tab5');
        tab.setTitle("School Master - (Beat - "+ beat +") " +stdTypeDetails);
        tabPane.setActiveTab(tab);
        allSchoolStore.load({params:{beatID:id},waitMsg:'Loading...'});
    };

    // create the District Grid
    grid = new Ext.grid.GridPanel(
    {
        store: allDistrictStore,  
        stripeRows: true,
        columnLines: true,
        listeners : 
        {
            dblclick  : showAllTaluka
        },

        tbar:[
        {
            text: 'Add', 
            iconCls: 'add',
            handler : function()
            {
            	addDistrictForm.getForm().reset();
                openWin(addDistrictForm, 'District',200,350);
            }            
        },'-',  
        {
            text: 'Show All Taluka', 
            iconCls: 'showall',
            handler : showAllTaluka
        },'-',
        {
            text: 'Edit', 
            iconCls: 'edit',
            handler : function()
            {
                var sm = grid.getSelectionModel();
                var sel = sm.getSelections();
                if(sel.length == 0) {Ext.Msg.alert('Select District', 'No district is selected!');return;};
                var id = sel[0].get('districtID');
                var district = sel[0].get('district');
                var districtMarathi = sel[0].get('districtMarathi');
                var stdType = sel[0].get('stdType');
                Ext.getCmp('edf-h').setValue(id);
                Ext.getCmp('edfe').setValue(district);
                Ext.getCmp('edfm').setValue(districtMarathi);
                Ext.getCmp('edfs-h').setValue(stdType);

                openEdit(editDistrictForm, 'District',200,350);
            }
        },'->',
        {
            text: 'Delete', 
            iconCls: 'delete',
            handler : function()
            {
                var sm = grid.getSelectionModel();
                var sel = sm.getSelections();
                if(sel.length == 0)
                {
                    Ext.Msg.alert('Select District', 'No district is selected!');
                    return;
                };
                //var districtID = sel[0].get('districtID');
                var districtMarathi = sel[0].get('districtMarathi');

                var ids = "";
                for(var j = 0;j<sel.length;j++)
                {
                    var rec = sel[j];
                    var districtID = rec.id;
                    ids = ids.concat(districtID + ",");
                }

                Ext.Msg.show(
                {
                    title: 'Confirm',
                    msg: 'Do you want to delete '+districtMarathi+' districts?' ,
                    buttons: Ext.Msg.YESNO,
                    fn: function(btn) 
                    {
                        if (btn == 'yes') 
                        {
                            Ext.Ajax.request(
                            {
                                url: 'delete/delete-masters.jsp',
                                method: 'POST',
                                params: 
                                {
                                    ids : ids,
                                    master : "district"
                                },
                                success: function(resp,opt) 
                                {
                                    Ext.Msg.alert('Deleted', ' Districts deleted!');
                                    allDistrictStore.reload(
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
            id       :'company',
            header   : 'District ID',
            width    : 80,
            sortable : true,
            dataIndex: 'districtID'
        },
        {
            header   : 'District English',
            width    :120,
            sortable : true,
            dataIndex: 'district'
        },
        {
            header   : 'District Marathi',
            width    : 120,
            sortable : true,
            dataIndex: 'districtMarathi'
        },
        {
            header   : 'School Type',
            width    : 120,
            sortable : true,
            dataIndex: 'stdType',
            hidden    : true
        },
        {
            header   : 'STD Group',
            width    : 120,
            sortable : true,
            dataIndex: 'stdTypeDetails'
        }],
        stripeRows: true,
        columnLines: true,
        height:500,
        width: 350,
        title: 'District Master',
        stateful: true,
        stateId: 'grid',
        
        view: new Ext.grid.GroupingView(
        {
            showGroupName: true,
            enableNoGroups: false,
            enableGroupingMenu: true,
            hideGroupedColumn: true
        }),
        bbar: new Ext.PagingToolbar(
        {
            pageSize: 100,
            store: allDistrictStore,
            displayInfo: true,
            displayMsg: 'Displaying results {0} - {1} of {2}',
            emptyMsg: "No results to display"
        })
    });
      
    moveTalukaForm = new Ext.FormPanel(
   {
        labelAlign: 'right',
        frame:true,
        id: 'tamv-form',
        autoDestroy : true,
        layout:'fit',
        buttonAlign: 'center',
        items: [
        {
            layout:'column',
            items:[
            {
                columnWidth:.98,
                layout: 'form',
                items: [
                {
                    xtype:'combo',
                    editable:false,
                    id:'semv-c5',
                    store: allDistrictStore,
                    allowBlank: false,
                    forceSelection : true,
                    triggerAction : 'all',
                    selectOnFocus :true,
                    mode :'local',
                    displayField : 'districtList' ,
                    valueField: 'districtID',
                    fieldLabel: 'Select District',
                    name: 'district',
                    hiddenName : 'districtID',
                    anchor:'95%'
                }]
            }]
        }],
        buttons: [
        {
            text: 'Move',
            scale: 'medium',
            handler: function()
            {
                var sm = tgrid.getSelectionModel();
                var sel = sm.getSelections();
                if(sel.length == 0) 
                {
                    Ext.Msg.alert('Select Taluka', 'No Taluka is selected!');
                    return;
                }
                var id = sel[0].get('talukaID');
                moveTalukaForm.getForm().submit(
                {
                    url: 'update/move-talukas.jsp',
                    method: 'POST',
                    params:
                    {
                        talukaIDS:id
                    },
                    success: function(form, action)
                    {
                        Ext.Msg.alert('Success', 'Taluka Moved');
                        allTalukaStore.reload({waitMsg:'Loading...'});
                    },
                    failure: function(form, action)
                    {
                        Ext.Msg.alert('Warning', 'Taluka cant be moved' );
                    }
                });
            }
        }]
    });
          
    moveSectionForm = new Ext.FormPanel(
    {
        labelAlign: 'right',
        frame:true,
        id: 'semv-form',
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
                    xtype:'combo',
                    editable:false,
                    id:'semv-c5',
                    store: allDistrictStore,
                    allowBlank: false,
                    forceSelection : true,
                    triggerAction : 'all',
                    selectOnFocus :true,
                    mode :'local',
                    displayField : 'districtList' ,
                    valueField: 'districtID',
                    fieldLabel: 'Select District',
                    name: 'district',
                    hiddenName : 'districtID',
                    anchor:'95%',
                    listeners: 
                    {
                        select : function(cmb,rec,idx) 
                        {
                            tCombo = Ext.getCmp('semv-c6');
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
                }]
            },
            {
                columnWidth:.50,
                layout: 'form',
                items: [ 
                {
                    xtype:'combo',
                    id: 'semv-c6',
                    fieldLabel: 'Select Taluka',
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
                    anchor:'95%'
                }]
            }]
        }],
        buttons: [
        {
            text: 'Move',
            scale: 'medium',
            handler: function()
            {
                var sm = sgrid.getSelectionModel();
                var sel = sm.getSelections();

                if(sel.length == 0) 
                {
                    Ext.Msg.alert('Select School', 'No school is selected!');
                    return;
                }
                var id = sel[0].get('sectionID');
                moveSectionForm.getForm().submit(
                {
                    url: 'update/move-sections.jsp',
                    method: 'POST',
                    params:
                    {
                        sectionID:id
                    },
                    success: function(form, action)
                    {
                        Ext.Msg.alert('Success', 'Section Moved');
                        allSectionStore.reload({waitMsg:'Loading...'});
                    },
                    failure: function(form, action)
                    {
                        Ext.Msg.alert('Warning', 'Section cant be moved' );
                    }
                });
            }
        }]
    });
    
    // Move Beat Form
    moveBeatForm = new Ext.FormPanel(
    {
        labelAlign: 'right',
        frame:true,
        id: 'bmv-form',
        autoDestroy : true,
        layout:'fit',
        buttonAlign: 'center',
        items: [
        {
            layout:'column',
            items:[
            {
                columnWidth:.33,
                layout: 'form',
                items: [
                {
                    xtype:'combo',
                    editable:false,
                    id:'bmv-c5',
                    store: allDistrictStore,
                    allowBlank: false,
                    forceSelection : true,
                    triggerAction : 'all',
                    selectOnFocus :true,
                    mode :'local',
                    displayField : 'districtList' ,
                    valueField: 'districtID',
                    fieldLabel: 'Select District',
                    name: 'district',
                    hiddenName : 'districtID',
                    anchor:'95%',
                    listeners: 
                    {
                        select : function(cmb,rec,idx) 
                        {
                            tCombo = Ext.getCmp('bmv-c6');
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
                }]
            },
            {
                columnWidth:.33,
                layout: 'form',
                items: [ 
                {
                    xtype:'combo',
                    id: 'bmv-c6',
                    fieldLabel: 'Select Taluka',
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
                    anchor:'95%',
                    listeners: 
                    {
                        select : function(cmb,rec,idx) 
                        {
                            tCombo = Ext.getCmp('bmv-c7');
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
                }]
            },
            {
                columnWidth:.33,
                layout: 'form',
                items: [
                {
                    xtype:'combo',
                    id: 'bmv-c7',
                    fieldLabel: 'Select Section',
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
                    anchor:'95%'
                }]
            }]
        }],
        buttons: [
        {
            text: 'Move',
            scale: 'medium',
            handler: function()
            {
                var sm = bgrid.getSelectionModel();
                var sel = sm.getSelections();
                if(sel.length == 0) 
                {
                    Ext.Msg.alert('Select Beat', 'No Beat is selected!');
                    return;
                }
                var id = sel[0].get('beatID');
                moveBeatForm.getForm().submit(
                {
                    url: 'update/move-beat.jsp',
                    method: 'POST',
                    params:
                    {
                        beatID:id
                    },
                    success: function(form, action)
                    {
                        Ext.Msg.alert('Success', 'Beat Moved');
                        allBeatStore.reload({waitMsg:'Loading...'});
                    },
                    failure: function(form, action)
                    {
                        Ext.Msg.alert('Warning', 'Schools cant be moved' );
                    }
                });
            }
        }]
    });
        
    // move School to Other Beat   
    moveAnganForm = new Ext.FormPanel(
    {
        labelAlign: 'right',
        frame:true,
        id: 'scmv-form',
        autoDestroy : true,
        layout:'fit',
        buttonAlign: 'center',
        items: [
        {
            layout:'column',
            items:[
            {
                columnWidth:.33,
                layout: 'form',
                items: [
                {
                    xtype:'combo',
                    editable:false,
                    id:'scmv-c8',
                    store: allDistrictStore,
                    allowBlank: false,
                    forceSelection : true,
                    triggerAction : 'all',
                    selectOnFocus :true,
                    mode :'local',
                    displayField : 'districtList' ,
                    valueField: 'districtID',
                    fieldLabel: 'Select District',
                    name: 'district',
                    hiddenName : 'districtID',
                    anchor:'95%',
                    listeners: 
                    {
                        select : function(cmb,rec,idx) 
                        {
                            tCombo = Ext.getCmp('scmv-c9');
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
                }]
            },
            {
                columnWidth:.33,
                layout: 'form',
                items: [ 
                {
                    xtype:'combo',
                    id: 'scmv-c9',
                    fieldLabel: 'Select Taluka',
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
                    anchor:'95%',
                    listeners: 
                    {
                        select : function(cmb,rec,idx) 
                        {
                            tCombo = Ext.getCmp('scmv-c10');
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
                }]
            },
            {
                columnWidth:.33,
                layout: 'form',
                items: [ 
                {
                    xtype:'combo',
                    id: 'scmv-c10',
                    fieldLabel: 'Select section',
                    forceSelection : true,
                    triggerAction : 'all',
                    selectOnFocus :true,
                    editable:false,
                    mode :'local',
                    store: allSectionStore,
                    name: 'section',
                    hiddenName : 'sectionID',
                    displayField : 'sectionMarathi' ,
                    valueField: 'sectionID',
                    anchor:'95%',
                    listeners: 
                    {
                        select : function(cmb,rec,idx) 
                        {
                            tCombo = Ext.getCmp('scmv-c11');
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
                }]
            },
            {
                columnWidth:.33,
                layout: 'form',
                items: [
                {
                    xtype:'combo',
                    id: 'scmv-c11',
                    fieldLabel: 'Select Beat',
                    displayField : 'beatMarathi' ,
                    valueField: 'beatID',
                    forceSelection : true,
                    triggerAction : 'all',
                    selectOnFocus :true,
                    editable:false,
                    store: allBeatStore,
                    mode :'local',
                    name: 'beat',
                    hiddenName : 'beat',
                    anchor:'95%'
                }]
            }]
        }],
        buttons: [
        {
            text: 'Move',
            scale: 'medium',
            handler: function()
            {
                var sm = scgrid.getSelectionModel();
                var sel = sm.getSelections();
                var id = sel[0].get('schoolID');                
                moveAnganForm.getForm().submit(
                {
                    url: 'update/move-schools.jsp',
                    method: 'POST',
                    params:
                    {
                        schoolID:id
                    },
                    
                    success: function(form, action)
                    {
                        Ext.Msg.alert('Success', 'Schools Moved');
                        allSchoolStore.reload({waitMsg:'Loading...'});
                    },
                    failure: function(form, action)
                    {
                        Ext.Msg.alert('Warning', 'Schools cant be moved' );
                    }
                });
            }
        }]
    });

    // create the Taluka Grid
    tgrid = new Ext.grid.GridPanel(
    {
        store: allTalukaStore,  
        stripeRows: true,
        columnLines: true,
        id:'tab2',
        listeners : 
        {
            dblclick  : showAllSection
        },
        tbar:[
        {
            text: 'Add', 
            iconCls: 'add', 
            handler:function() 
            {
            	addTalukaForm.getForm().reset();
                openWin(addTalukaForm, 'Taluka',150,900);
            }
        },'-',
        {
            text: 'Show All Sections',
            iconCls: 'showall',
            handler : showAllSection
        },'-',
        {
            text: 'Edit',
            iconCls: 'edit',
            handler:function()
            {
                var sm = tgrid.getSelectionModel();
                var sel = sm.getSelections();
                if(sel.length == 0) 
                {
                    Ext.Msg.alert('Select Taluka', 'No taluka is selected!');
                    return
                };
                var id = sel[0].get('talukaID');
                var taluka = sel[0].get('taluka');
                var did = sel[0].get('districtID');
                var talukaMarathi = sel[0].get('talukaMarathi');
                Ext.getCmp('etf-h').setValue(id);
                Ext.getCmp('etfe').setValue(taluka);
                Ext.getCmp('etfm').setValue(talukaMarathi);
                Ext.getCmp('etdfm').setValue(did);
                openWin(editTalukaForm, 'Taluka',150,700);
            }
        },'->',
        {
            text: 'Move Talukas', 
            iconCls: 'move',
            handler : function() 
            {
                var sm = tgrid.getSelectionModel();
                var sel = sm.getSelections();
                if(sel.length == 0) 
                {
                    Ext.Msg.alert('Select Taluka', 'No taluka is selected!');
                    return;
                }
                openMove(moveTalukaForm, 'Taluka',150,400);
            }
        },
        {
            text: 'Delete',
            iconCls: 'delete' ,
            handler : function()
            {
                var sm = tgrid.getSelectionModel();
                var sel = sm.getSelections();
                if(sel.length == 0)
                {
                    Ext.Msg.alert('Select Taluka', 'No taluka is selected!');
                    return;
                };
                //var talukaID = sel[0].get('talukaID');
                //var talukaMarathi = sel[0].get('talukaMarathi');

                var ids = "";

                for(var j = 0;j<sel.length;j++)
                {
                    var rec = sel[j];
                    var talukaID = rec.id;
                    ids = ids.concat(talukaID + ",");
                }

                Ext.Msg.show(
                {
                    title: 'Confirm',
                    msg: 'Do you want to delete selected Taluka?',
                    buttons: Ext.Msg.YESNO,
                    fn: function(btn) 
                    {
                        if (btn == 'yes') 
                        {
                            Ext.Ajax.request(
                            {
                                url: 'delete/delete-masters.jsp',
                                method: 'POST',
                                params: 
                                {
                                    ids : ids,
                                    master : "taluka"
                                },
                                success: function(resp,opt) 
                                {
                                    Ext.Msg.alert('Deleted',   ' Talukas deleted!');
                                    allTalukaStore.reload(
                                    {
                                        waitMsg:'Loading...'
                                    });
                                },
                                failure: function(resp,opt) 
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
        columns: [
        {
            id       :'company',
            header   : 'Taluka ID',
            width    : 80,
            sortable : true,
            dataIndex: 'talukaID'
        },
        {
            id       :'company',
            header   : 'District',
            width    : 80,
            sortable : true,
            dataIndex: 'districtMarathi'
        },
        {
            header   : 'Taluka English',
            width    :120,
            sortable : true,
            dataIndex: 'taluka'
        },
        {
            header   : 'Taluka Marathi',
            width    : 120,
            sortable : true,
            dataIndex: 'talukaMarathi'
        }],
        stripeRows: true,
        columnLines: true,
        height:400,
        width: 500,
        title: 'Taluka Master',
        stateful: true,
        stateId: 'grid',
        bbar: new Ext.PagingToolbar(
        {
            pageSize: 100,
            store: allTalukaStore,
            displayInfo: true,
            displayMsg: 'Displaying results {0} - {1} of {2}',
            emptyMsg: "No results to display"
        })

    });

    // create the Section Grid
    sgrid = new Ext.grid.GridPanel(
    {
        store: allSectionStore,  
        id : 'tab3',
        listeners : 
        {
            dblclick  : showAllBeat
        },
        tbar:[
        {
            text: 'Add', 
            iconCls: 'add',
            handler : function()
            {
            	addSectionForm.getForm().reset();
                openWin(addSectionForm, 'Section',200,900);
            }
        },'-',
        {
            text: 'Show All Beat', 
            iconCls: 'edit',
            handler : showAllBeat
        },'-',
        {
            text: 'Edit', 
            iconCls: 'edit', 
            handler:function() 
            {
                var sm = sgrid.getSelectionModel();
                var sel = sm.getSelections();
                if(sel.length == 0) 
                {
                    Ext.Msg.alert('Select Section', 'No Section is selected!');
                    return
                };
                var id = sel[0].get('sectionID');
                var district = sel[0].get('section');
                var districtMarathi = sel[0].get('sectionMarathi');
                Ext.getCmp('esf-h').setValue(id);
                Ext.getCmp('esfe').setValue(district);
                Ext.getCmp('esfm').setValue(districtMarathi);
                Ext.getCmp('erd').setValue(sel[0].get('beatFlag'));
                openWin(editSectionForm, 'Section',200,900);
            }
        },'->',
        {
            text: 'Move Sections', 
            iconCls: 'move',
            handler : function() 
            {
                var sm = sgrid.getSelectionModel();
                var sel = sm.getSelections();
                if(sel.length == 0) 
                {
                    Ext.Msg.alert('Select Section', 'No Section is selected!');
                    return;
                }
                openMove(moveSectionForm, 'Section',150,700);
            }
        },
        {
            text: 'Delete', 
            iconCls: 'delete' ,
            handler : function()
            {
                var sm = sgrid.getSelectionModel();
                var sel = sm.getSelections();
                if(sel.length == 0)
                {
                    Ext.Msg.alert('Select Section', 'No section is selected!');
                    return;
                };
                //var sectionID = sel[0].get('sectionID');
                var sectionMarathi = sel[0].get('sectionMarathi');

                var ids = "";

                for(var j = 0;j<sel.length;j++)
                {
                    var rec = sel[j];
                    var sectionID = rec.id;
                    ids = ids.concat(sectionID + ",");
                }



                Ext.Msg.show(
                {
                    title: 'Confirm',
                    msg: 'Do you want to Delete '+ sectionMarathi+' Sections?',
                    buttons: Ext.Msg.YESNO,
                    fn: function(btn) 
                    {
                        if (btn == 'yes') 
                        {
                            Ext.Ajax.request(
                            {
                                url: 'delete/delete-masters.jsp',
                                method: 'POST',
                                params: 
                                {
                                    ids : ids,
                                    master : "section"
                                },
                                success: function(resp,opt) 
                                {
                                    Ext.Msg.alert('Deleted',   ' Sections deleted!');
                                    allSectionStore.reload(
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
            header   : 'Section ID',
            width    : 80,
            sortable : true,
            dataIndex: 'sectionID'
        },
        {
            header   : 'District',
            width    :120,
            sortable : true,
            dataIndex: 'districtMarathi'
        },
        {
            header   : 'Taluka',
            width    :120,
            sortable : true,
            dataIndex: 'talukaMarathi'
        },
        {
            header   : 'Section',
            width    : 120,
            sortable : true,
            dataIndex: 'section'
        } ,
        {
            header   : 'Section Marathi',
            width    : 120,
            sortable : true,
            dataIndex: 'sectionMarathi'
        },
        {
            header   : 'Beat Flag',
            width    : 80,
            sortable : true,
            dataIndex: 'beatFlag',
            hidden 	 : true
        }],
        stripeRows: true,
        columnLines: true,
        height:400,
        width: 500,
        title: 'Section Master',
        stateful: true,
        stateId: 'grid',
        bbar: new Ext.PagingToolbar(
        {
            pageSize: 100,
            store: allSectionStore,
            displayInfo: true,
            displayMsg: 'Displaying results {0} - {1} of {2}',
            emptyMsg: "No results to display"
        })

    });
        
    // create the Beat Grid
    bgrid = new Ext.grid.GridPanel(
    {
        store: allBeatStore,  
        stripeRows: true,
        columnLines: true,
        id : 'tab4',
        listeners : 
        {
            dblclick  : showAllSchools
        },
        tbar:[
        {
            text: 'Add', 
            iconCls: 'add',
            handler : function()
            {
            	addBeatForm.getForm().reset();
                openWin(addBeatForm, 'Beat',200,900);
            }
        },'-',
        {
            text: 'Show All Schools', 
            iconCls: 'edit',
            handler : showAllSchools
        },'-',
        {
            text: 'Edit', 
            iconCls: 'edit', 
            handler:function() 
            {
                var sm = bgrid.getSelectionModel();
                var sel = sm.getSelections();
                if(sel.length == 0) 
                {
                    Ext.Msg.alert('Select Beat', 'No Beat is selected!');
                    return
                };
                var id = sel[0].get('beatID');
                var district = sel[0].get('beat');
                var districtMarathi = sel[0].get('beatMarathi');
                Ext.getCmp('ebf-h').setValue(id);
                Ext.getCmp('ebfe').setValue(district);
                Ext.getCmp('ebfm').setValue(districtMarathi);
                openWin(editBeatForm, 'Beat',200,900);
            }
        },'->',
        {
            text: 'Move Beat', 
            iconCls: 'move',
            handler : function() 
            {
                var sm = bgrid.getSelectionModel();
                var sel = sm.getSelections();
                if(sel.length == 0) 
                {
                    Ext.Msg.alert('Select Beat', 'No Beat is selected!');
                    return;
                }
                openMove(moveBeatForm, 'Beat',150,900);
            }
        },
        {
            text: 'Delete', 
            iconCls: 'delete' ,
            handler : function()
            {
                var sm = bgrid.getSelectionModel();
                var sel = sm.getSelections();
                if(sel.length == 0)
                {
                    Ext.Msg.alert('Select Beat', 'No Beat is selected!');
                    return;
                };
                //var beatID = sel[0].get('beatID');
                var beatMarathi = sel[0].get('beatMarathi');
                var ids = "";
                for(var j = 0;j<sel.length;j++)
                {
                    var rec = sel[j];
                    var beatID = rec.id;
                    ids = ids.concat(beatID + ",");
                }
                Ext.Msg.show(
                {
                    title: 'Confirm',
                    msg: 'Do you want to delete '+beatMarathi+' Beat ?',
                    buttons: Ext.Msg.YESNO,
                    fn: function(btn) 
                    {
                        if (btn == 'yes') 
                        {
                            Ext.Ajax.request(
                            {
                                url: 'delete/delete-masters.jsp',
                                method: 'POST',
                                params: 
                                {
                                    ids : ids,
                                    master : "beat"
                                },
                                success: function(resp,opt) 
                                {
                                    Ext.Msg.alert('Deleted',   ' Beat deleted!');
                                    allBeatStore.reload(
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
            id       :'company',
            header   : 'Beat ID',
            width    : 80,
            sortable : true,
            dataIndex: 'beatID'
        },
        {
            header   : 'District',
            width    :120,
            sortable : true,
            dataIndex: 'districtMarathi'
        },
        {
            header   : 'Taluka',
            width    :120,
            sortable : true,
            dataIndex: 'talukaMarathi'
        },        
        {
            header   : 'Section Marathi',
            width    : 120,
            sortable : true,
            dataIndex: 'sectionMarathi'
        },
        {
            header   : 'Beat',
            width    : 120,
            sortable : true,
            dataIndex: 'beat'
        },
        {
            header   : 'Beat Marathi',
            width    : 120,
            sortable : true,
            dataIndex: 'beatMarathi'
        }],
        stripeRows: true,
        columnLines: true,
        height:400,
        width: 500,
        title: 'Beat Master',
        stateful: true,
        stateId: 'grid',
        bbar: new Ext.PagingToolbar(
        {
            pageSize: 100,
            store: allBeatStore,
            displayInfo: true,
            displayMsg: 'Displaying results {0} - {1} of {2}',
            emptyMsg: "No results to display"
        })

    });
    
    // create the School Grid
    scgrid = new Ext.grid.GridPanel(
    {
        store: allSchoolStore,   
        id : 'tab5' ,
        tbar:[
        {
            text: 'Add', 
            iconCls: 'add',
            handler : function()
            {
            	addSchoolForm.getForm().reset();
                openWin(addSchoolForm, 'Anganwadi',200,900);
            }
        },'-',
        {
            text: 'Edit', 
            iconCls: 'edit', 
            handler:function() 
            {
                var sm = scgrid.getSelectionModel();
                var sel = sm.getSelections();
                if(sel.length == 0) {Ext.Msg.alert('Select School', 'No school is selected!');return;};
                var id = sel[0].get('schoolID');
                var district = sel[0].get('school');
                var districtMarathi = sel[0].get('schoolMarathi');
                Ext.getCmp('escf-h').setValue(id);
                Ext.getCmp('escfe').setValue(district);
                Ext.getCmp('escfm').setValue(districtMarathi);
                openWin(editSchoolForm, 'School',150,325);
            }
        },'->',
        {
            text: 'Move Schools',
            iconCls: 'move',
            handler : function()
            {
                var sm = scgrid.getSelectionModel();
                var sel = sm.getSelections();
                if(sel.length == 0) 
                {
                    Ext.Msg.alert('Select School', 'No school is selected!');
                    return;
                }
                openMove(moveAnganForm, 'Anganwadi',170,900);
            }
        },
        {
            text: 'Delete', 
            iconCls: 'delete' ,
            handler : function()
            {
                var sm = scgrid.getSelectionModel();
                var sel = sm.getSelections();
                if(sel.length == 0)
                {
                    Ext.Msg.alert('Select School', 'No school is selected!');
                    return;
                };
                //var schoolID = sel[0].get('schoolID');
                var schoolMarathi = sel[0].get('schoolMarathi');
                var ids = "";
                for(var j = 0;j<sel.length;j++)
                {
                    var rec = sel[j];
                    var schoolID = rec.id;
                    ids = ids.concat(schoolID + ",");
                }
                Ext.Msg.show(
                {
                    title: 'Confirm',
                    msg: 'Do you want to delete '+schoolMarathi+' schools?',
                    buttons: Ext.Msg.YESNO,
                    fn: function(btn) 
                    {
                        if (btn == 'yes') 
                        {
                            Ext.Ajax.request(
                            {
                                url: 'delete/delete-masters.jsp',
                                method: 'POST',
                                params: 
                                {
                                    ids : ids,
                                    master : "school"
                                },
                                success: function(resp,opt) 
                                {
                                    Ext.Msg.alert('Deleted',   ' Schools deleted!');
                                    allSchoolStore.reload({
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
            id       :'company',
            header   : 'School ID',
            width    : 80,
            sortable : true,
            dataIndex: 'schoolID'
        },
        {
            id       :'company',
            header   : 'District',
            width    : 80,
            sortable : true,
            dataIndex: 'districtMarathi'
        },
        {
            header   : 'Taluka',
            width    :120,
            sortable : true,
            dataIndex: 'talikaMarathi'
        },
        {
            header   : 'Section',
            width    : 120,
            sortable : true,
            dataIndex: 'sectionMarathi'
        },
        {
            header   : 'Beat',
            width    : 120,
            sortable : true,
            dataIndex: 'beatMarathi'
        },
        {
            header   : 'School',
            width    : 120,
            sortable : true,
            dataIndex: 'school'
        },
        {
            header   : 'School Marathi',
            width    : 120,
            sortable : true,
            dataIndex: 'schoolMarathi'
        }],
        stripeRows: true,
        columnLines: true,
        autoScroll: true,
        height:400,
        width: 500,
        title: 'School Master',
        stateful: true,
        stateId: 'grid',// paging bar on the bottom
        bbar: new Ext.PagingToolbar(
        {
            pageSize: 100,
            store: allSchoolStore,
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
        items:[grid,tgrid,sgrid,bgrid,scgrid]
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

});
