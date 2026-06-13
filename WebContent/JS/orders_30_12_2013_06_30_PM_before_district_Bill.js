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
var billDatePreviewWin;

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
        idProperty : 'orderID',
        fields: ['orderID','districtName', 'districtGovOrderID','orderNoDate','orderNumber','creationDate','districtID','stdType','stdTypeDetails'],
        sortInfo:
        {
            field:'orderID',
            direction:'ASC'
        }
    });
    //end

    allDistrictOrderStore= new Ext.data.GroupingStore(
    {
         autoLoad: true,
         reader: reader,
         groupField : 'stdTypeDetails',
         storeId: 'allDistrictOrderStore',
         url: 'read/get-all-districts-order.jsp'
    });
    
    //Start - Store get all taluka for order
    allTalukaOrderStore= new Ext.data.JsonStore(
    {
        autoLoad: false,
        storeId: 'allTalukaOrderStore',
        url: 'read/get-all-taluka-order.jsp',
        root: 'root',
        idProperty : 'talukaName',
        fields: ['talukaOrderId','tOrderDate','talukaOrderGovNum', 'talukaName','talukaId','fromMonth','fromYear','toMonth','toYear','fMonthId','tMonthId','orderTypeDetails','orderType','talukaOrderDetailsId' ],
        sortInfo: 
        {
            field:'talukaName',
            direction:'DESC'
        }
    });
    //End - Store get all taluka for order

    // start - Store - get all section for order
    allSectionOrderStore= new Ext.data.JsonStore(
    {
        autoLoad: false,
        storeId: 'allSectionOrderStore',
        url: 'read/get-all-section-order.jsp',
        root: 'root',
        idProperty : 'sectionID',
        fields: ['sectionID','sectionMarathi','mungdaal','matki','mung','masuldaal','chvli','tel','mith','mirchi','halad','jire','mohari','tandul'],
        sortInfo: 
        {
            field:'sectionID',
            direction:'DESC'
        }
    });
    // End  Store - get all section for order

    // start - Store - get all section for order
    allBeatOrderStore= new Ext.data.JsonStore(
    {
        autoLoad: false,
        storeId: 'allBeatOrderStore',
        url: 'read/get-all-beat-order.jsp',
        root: 'root',
        idProperty : 'beatID',
        fields: ['beatID','beatMarathi','mungdaal','matki','mung','masuldaal','chvli','tel','mith','mirchi','halad','jire','mohari','tandul'],
        sortInfo: 
        {
            field:'beatID',
            direction:'DESC'
        }
    });
    // End  Store - get all section for order
    
    allSchoolReturnStore = new Ext.data.JsonStore(
    {
        autoLoad: false,
        root: 'root',
        idProperty : 'schoolID',
        storeId:'allSchoolReturnStore',
        url:'read/get-all-taluka-return-details.jsp',
        fields: ['talukaOrderDetailsId','beatID','schoolID','schoolMarathi',
                 'mungdaal','matki','mung','masuldaal','chvli','tel',
                 'mith','mirchi','halad','jire','mohari','tandul',
                 'omungdaal','omatki','omung','omasuldaal','ochvli','otel',
                 'omith','omirchi','ohalad','ojire','omohari','otandul'],
        sortInfo:
        {
            field:'schoolID',
            direction:'ASC'
        }

    });
    
    allSchoolOrderStore = new Ext.data.JsonStore(
    {
        autoLoad: false,
        root: 'root',
        idProperty : 'schoolID',
        storeId:'allSchoolOrderStore',
        url:'read/get-all-taluka-order-details.jsp',
        fields: ['talukaOrderDetailsId','beatID','schoolID','schoolMarathi','challanNumber','challanDate','mungdaal','matki','mung','masuldaal','chvli','tel','mith','mirchi','halad','jire','mohari','tandul'],
        sortInfo:
        {
            field:'schoolID',
            direction:'ASC'
        }

    });
    
    monthStore= new Ext.data.JsonStore(
    {
        storeId: 'monthStore',
        url: 'read/months.jsp',
        root: 'root',
        idProperty : 'id',
        fields: ['id','mm']
    });    
    
    monthStore1= new Ext.data.JsonStore(
    {
        storeId: 'monthStore1',
        url: 'read/months.jsp',
        root: 'root',
        idProperty : 'id',
        fields: ['id','mm']
    });

    var yearStore = new Ext.data.JsonStore(
    {
        xtype : 'jsonstore',
        idProperty : 'year',
        storeId: 'yearStore',
        url: 'read/years.jsp',
        fields: [ 'year','yearMarathi'],
        root: 'root',
        sortInfo: 
        {
            field:'year',
            direction:'ASC'
        }
    });

    yearStore1 = new Ext.data.JsonStore(
    {
        xtype : 'jsonstore',
        idProperty : 'year',
        storeId: 'yearStore',
        url: 'read/years.jsp',
        fields: [ 'year','yearMarathi'],
        root: 'root',
        sortInfo: 
        {
            field:'year',
            direction:'ASC'
        }
    });
        
    //End - Store get all district for order   
    
    // Javascript code to get Current Date 
    var currentTime = new Date();
    var month = currentTime.getMonth() + 1;
    var day = currentTime.getDate();
    var year = currentTime.getFullYear();
    if(month < 10 && day > 9)
    {
        today = (day + "/0" + month + "/" + year);
    }
    else if(day < 10 && month > 9)
    {
        today = ("0"+day + "/" + month + "/" + year);
    }
    else if(day < 10 && month < 10)
    {
        today = ("0"+day + "/0" + month + "/" + year);
    }
    else
    {
        today = (day + "/" + month + "/" + year);
    }

    paintNull = function(val) 
    {
        if (!val)
        {
            return '<span style="color:red;">-</span>';
        }
        return val;
    };
    
    var orderTypeStore = new Ext.data.SimpleStore(
    {
        fields: [
        {
            name: 'orderType',
            type: 'int'
        },
        {
            name: 'text'
        }]
    });

    var orderTypeData = 
    [
        [1, 'Rice'],
        [2, 'Ration']
    ];

    orderTypeStore.loadData(orderTypeData);
        
    //Get All District Store
    allDistrictStore= new Ext.data.JsonStore(
    {
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
    
    //Get All School Store
    allSchoolStore= new Ext.data.JsonStore(
    {
        storeId: 'allSchoolStore',
        url: 'read/get-all-schools.jsp',
        root: 'root',
        idProperty : 'schoolID',
        fields: ['schoolID','districtMarathi','talukaMarathi','sectionMarathi', 'beatMarathi',  'school', 'schoolMarathi','districtID', 'talukaID','sectionID','beatID' ],
        sortInfo: 
        {
            field:'schoolID',
            direction:'DESC'
        }
    });
    
    talukaOrderList = new Ext.data.JsonStore(
    {
        storeId: 'talukaOrderList',
        url: 'read/get-taluka-orders-list.jsp',
        root: 'root',
        idProperty : 'talukaOrderId',
        fields: ['talukaOrderId','orderNumber', 'orderYear','tOrderDate']
    });
    
    schoolTypeStore = new Ext.data.SimpleStore(
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

    schoolTypeData = 
    [
        [1, 'STD 1 TO 5'],
        [2, 'STD 6 TO 8']
    ];
       
    allRootStore= new Ext.data.JsonStore(
    {
        autoLoad: false,
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
        
    // create challan form
    createChallanForm = new Ext.FormPanel(
    {
        labelAlign: 'right',
        frame:true,
        border :false,
        id: 'edit-d-o-form',
        autoDestroy : true,
        layout:'fit',
        buttonAlign: 'center',
        items: [
        {
            layout: 'form',
            items: [
            {
                xtype:'datefield',
                fieldLabel: 'Select Challan Date',
                id:'challanDate',
                allowBlank: false,
                editable:false,
                format: 'd/m/Y',
                name: 'challanDate',
                hiddenName : 'challanDate',
                anchor:'95%'
            }]
        }]
    });
    // End

    // function when user click on 'चालान बनवा',
    createChallans = function(schoolOrderStore)
    {                   
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
                items :[
                {
                    region:"center",
                    layout:'fit',
                    items:[createChallanForm]
                }]
            }],
            buttons: [
            {
                text: 'Create Challans',
                scale: 'medium',
                handler: function()
                {                              
                    createChallanForm.getForm().submit(
                    {
                        url: 'create/create-challans.jsp',
                        method: 'POST',
                        params :
                        {
                           beatID : beatID,
                           taluka_order_id : talukaOrderId
                        },
                        success: function(resp,opt)
                        {
                            allSchoolOrderStore.reload(
                            {
                               params :
                               {
                                   beatID : beatID,
                                   taluka_order_id : talukaOrderId
                               },
                               waitMsg:'Loading...'
                            });
                            Ext.Msg.alert('Challan created', 'Challan date and challan number has been created.<br> To check, please click on <b>ऑर्डर पूर्ण करा</b>!');
                        },
                        failure: function(resp,opt)
                        {
                            Ext.Msg.alert('Error', 'Error in creating challan!');
                        }
                    });
                }
            }]
        });
        win.show(this);
    };
    //end
       
    // Open Route wise Report
    getOrderRootDetailsForm = new Ext.FormPanel(
    {
        labelAlign: 'right',
        frame:true,
        border :false,
        id: 'getOrderRootDetailsForm',
        autoDestroy : true,
        layout:'fit',
        buttonAlign: 'center',
        items: [
        {
            layout: 'form',
            items: [
			{
			    xtype:'combo',
			    editable:false,
			    id:'com1',
			    store: allRootStore,
			    allowBlank: false,
			    forceSelection : true,
			    triggerAction : 'all',
			    selectOnFocus :true,
			    mode :'local',
			    displayField : 'rootMarathi' ,
			    valueField: 'rootMasterID',
			    fieldLabel: '<b>Select Route</b>',
			    name: 'rootMasterID',
			    hiddenName : 'rootMasterID',
			    msgTarget : 'side',
			    blankText : 'Correct This field',
			    anchor:'90%'
			},
			{
				xtype:'hidden',
                id:'prevparam',
                name: 'prevparam',
                hiddenName : 'prevparam'
			}],
            buttons: [
            {
            	text: 'Route Details',
            	scale: 'medium',
            	handler: function()
                {	
            		var rootMasterID = Ext.getCmp('com1').getValue();
            		var param = Ext.getCmp('prevparam').getValue();
                    param = param+"&rootMasterID="+rootMasterID;
                    if(rootMasterID != "")
                    {
                    	window.open("reports/order-wise-root-report.jsp?"+param,'talukaloadingreport',"width=1500,height=800,top=40,left=60,menubar=1,resizable=0,location=1,scrollbars=1");
                    }
                    else
                	{
                    	Ext.getCmp('com1').setValue(0);
                    	return;                    	
                	}
                }
            }]
        }]
    });
    // End
        
    schoolWiseOrderAndChalanGridEditable = new Ext.grid.EditorGridPanel(
    {
        id:'schoolWiseOrderAndChalanGridEditable',
        store: allSchoolOrderStore,
        stripeRows: true,
        columnLines: true,
        scroll: true,
       // alias: ['widget.gridpanel', 'widget.grid'],
        columns: [new Ext.grid.RowNumberer(),
        {
            header: '<b>School ID</b>',
            dataIndex: 'schoolID',
            hidden: true
        },{
            header: '<b>Taluka Order Details ID</b>',
            dataIndex: 'talukaOrderDetailsId',
            align: 'center',
            width: 80,
            renderer: paintNull,
            hidden: true
        },{
            header: '<b>चालान क्र.</b>',
            dataIndex: 'challanNumber',
            id: 'challanNumber',
            align: 'center',
            editable : getChallanFlag(),
            width: 70,editor: new Ext.form.NumberField(
            {
                allowBlank: false,
                allowNegative: false,
                selectOnFocus : true
            })
        },{
            header: '<b>चालान दिनांक</b>',
            dataIndex: 'challanDate',
            align: 'center',
            type: 'date',
            id: 'challanDate',
            editable : getChallanFlag(),
            width: 90,
            editor: new Ext.form.DateField(
            {
                allowBlank: false,
                allowNegative: false,
                selectOnFocus : true
            })
        },{                       
            id: 'school',
            header: '<b>अंगणवाडी</b>',
            dataIndex: 'schoolMarathi',
            align: 'center',
            width: 120
        },{
            id: 'schoolID',
            header: '<b>School Id</b>',
            dataIndex: 'schoolID',
            align: 'center',
            hidden : true,
            width: 150
        },
        {
            header: '<b>तुरदाळ</b>',
            width:70,
            sortable: true,
            dataIndex:'mungdaal',
            align:'center',
            editor: new Ext.form.NumberField(
            {
                allowBlank: false,
                allowNegative: false,
                selectOnFocus : true,
                decimalPrecision: 3
            }),
            summaryType: 'sum1'
        },
        {
            header: '<b>मसूर डाळ</b>',
            width:70,
            sortable: true,
            dataIndex:'matki',
            align:'center',
            editor: new Ext.form.NumberField(
            {
                allowBlank: false,
                allowNegative: false,
                selectOnFocus : true,
                decimalPrecision: 3
            }),
            summaryType: 'sum2'
        },
        {
            header: '<b>हरभरा</b>',
            width:70,
            sortable: true,
            dataIndex:'mung',
            align:'center',
            editor: new Ext.form.NumberField(
            {
                allowBlank: false,
                allowNegative: false,
                selectOnFocus : true,
                decimalPrecision: 3
            }),
            summaryType: 'sum3'
        },
        {
            header: '<b>मटकी</b>',
            width:70,
            sortable: true,
            dataIndex:'masuldaal',
            align:'center',
            editor: new Ext.form.NumberField(
            {
                allowBlank: false,
                allowNegative: false,
                selectOnFocus : true,
                decimalPrecision: 3
            }),
            summaryType: 'sum4'
        },
        {
            header: '<b>चवली</b>',
            width:70,
            sortable: true,
            dataIndex:'chvli',
            align:'center',
            editor: new Ext.form.NumberField(
            {
                allowBlank: false,
                allowNegative: false,
                selectOnFocus : true,
                decimalPrecision: 3
            }),
            summaryType: 'sum5'
        },
        {
            header: '<b>तेल</b>',
            width:70,
            sortable: true,
            dataIndex:'tel',
            align:'center',
            editor: new Ext.form.NumberField(
            {
                allowBlank: false,
                allowNegative: false,
                selectOnFocus : true,
                decimalPrecision: 3
            }),
            summaryType: 'sum6'
        },
        {
            header: '<b>मीठ</b>',
            width:70,
            sortable: true,
            dataIndex:'mith',
            align:'center',
            editor: new Ext.form.NumberField(
            {
                allowBlank: false,
                allowNegative: false,
                selectOnFocus : true,
                decimalPrecision: 3
            }),
            summaryType: 'sum7'
        },
        {
            header: '<b>कांदा लसूण मसाला</b>',
            width:70,
            sortable: true,
            dataIndex:'mirchi',
            align:'center',
            editor: new Ext.form.NumberField(
            {
                allowBlank: false,
                allowNegative: false,
                selectOnFocus : true,
                decimalPrecision: 3
            }),
            summaryType: 'sum8'
        },
        {
            header: '<b>हळद</b>',
            width:70,
            sortable: true,
            dataIndex:'halad',
            align:'center',
            editor: new Ext.form.NumberField(
            {
                allowBlank: false,
                allowNegative: false,
                selectOnFocus : true,
                decimalPrecision: 3
            }),
            summaryType: 'sum9'
        },
        {
            header: '<b>जिरे</b>',
            width:70,
            sortable: true,
            dataIndex:'jire',
            align:'center',
            editor: new Ext.form.NumberField(
            {
                allowBlank: false,
                allowNegative: false,
                selectOnFocus : true,
                decimalPrecision: 3
            }),
            summaryType: 'sum10'
        },
        {
            header: '<b>मोहरी</b>',
            width:70,
            sortable: true,
            dataIndex:'mohari',
            align:'center',
            editor: new Ext.form.NumberField(
            {
                allowBlank: false,
                allowNegative: false,
                selectOnFocus : true
            }),
            summaryType: 'sum11'
        },
        {
            header: '<b>तांदूळ</b>',
            width:70,
            sortable: true,
            dataIndex:'tandul',
            align:'center',
            editor: new Ext.form.NumberField(
            {
                allowBlank: false,
                allowNegative: false,
                selectOnFocus : true,
                decimalPrecision: 3
            }),
            summaryType: 'sum12'
        }],
//        listeners: 
//        {
//            rowclick : function (g, rowIndex,e) 
//            {
//                var store = schoolWiseOrderGridEditable.getStore();
//                var schoolID = store.getAt(rowIndex).get('schoolId');
//                var talukaOrderID = talukaOrderId;
//                var dOrderID = districtOrderID;
//                var schoolMarathi = store.getAt(rowIndex).get('schoolMarathi');                
//            }
//        },
        height: 300,
        width: 600,
        frame: true,
        loadMask: true,
        tbar: [
        {
            xtype: 'tbbutton',
            iconCls: 'challans',
            text: '<b>चालान बनवा / दिनाक बदला</b>',
            handler : function()
            {
                var sm = bOrders.getSelectionModel();
                var sel = sm.getSelections();
                var s1 = sel[0].get('mungdaal');
                var s2 = sel[0].get('matki');
                var s3 = sel[0].get('mung');
                var s4 = sel[0].get('masuldaal');
                var s5 = sel[0].get('chvli');
                var s6 = sel[0].get('tel');
                var s7 = sel[0].get('mith');
                var s8 = sel[0].get('mirchi');
                var s9 = sel[0].get('halad');
                var s10 = sel[0].get('jire');
                var s11 = sel[0].get('mohari');
                var s12 = sel[0].get('tandul');
                Ext.Msg.alert(s1);
                if( s1 == 0 && s2 == 0 && s3 == 0 && s4 == 0 && s5 == 0 && s6 == 0 && s7 == 0 && s8 == 0 && s9 == 0 && s10 == 0 && s11 == 0 && s12 == 0) 
                {
                    Ext.Msg.alert('Error in creating challans', 'Please <b>ऑर्डर पूर्ण करा</b> before you create challans!');
                    return;
                }
                else
                {
                    //createChallans(allSchoolOrderStore);
                }
            }
        }]
    });
    
    schoolWiseReturnGridEditable = new Ext.grid.EditorGridPanel(
    {
        id:'schoolWiseReturnGridEditable',
        store: allSchoolReturnStore,
        stripeRows: true,
        columnLines: true,
        scroll: true,
       // alias: ['widget.gridpanel', 'widget.grid'],
        columns: [
        new Ext.grid.RowNumberer(),
        {
            header: '<b>School ID</b>',
            dataIndex: 'schoolID',
            hidden: true
        },
        {
            header: '<b>Taluka Order Details ID</b>',
            dataIndex: 'talukaOrderDetailsId',
            align: 'center',
            width: 80,
            renderer: paintNull,
            hidden: true
        },
        {                       
            id: 'rschool',
            header: '<b>अंगणवाडी</b>',
            dataIndex: 'schoolMarathi',
            align: 'center',
            width: 120
        },
        {
            id: 'rschoolID',
            header: '<b>School Id</b>',
            dataIndex: 'schoolID',
            align: 'center',
            hidden : true,
            width: 150
        },
        {
            header: '<b>तुरदाळ</b>',
            width:70,
            sortable: true,
            dataIndex:'mungdaal',
            align:'center',
            editor: new Ext.form.NumberField(
            {
                allowBlank: false,
                allowNegative: false,
                selectOnFocus : true,
                decimalPrecision: 3
            }),
            summaryType: 'sum1'
        },
        {
            header: '<b>मसूर डाळ</b>',
            width:70,
            sortable: true,
            dataIndex:'matki',
            align:'center',
            editor: new Ext.form.NumberField(
            {
                allowBlank: false,
                allowNegative: false,
                selectOnFocus : true,
                decimalPrecision: 3
            }),
            summaryType: 'sum2'
        },
        {
            header: '<b>हरभरा</b>',
            width:70,
            sortable: true,
            dataIndex:'mung',
            align:'center',
            editor: new Ext.form.NumberField(
            {
                allowBlank: false,
                allowNegative: false,
                selectOnFocus : true,
                decimalPrecision: 3
            }),
            summaryType: 'sum3'
        },
        {
            header: '<b>मटकी</b>',
            width:70,
            sortable: true,
            dataIndex:'masuldaal',
            align:'center',
            editor: new Ext.form.NumberField(
            {
                allowBlank: false,
                allowNegative: false,
                selectOnFocus : true,
                decimalPrecision: 3
            }),
            summaryType: 'sum4'
        },
        {
            header: '<b>चवली</b>',
            width:70,
            sortable: true,
            dataIndex:'chvli',
            align:'center',
            editor: new Ext.form.NumberField(
            {
                allowBlank: false,
                allowNegative: false,
                selectOnFocus : true,
                decimalPrecision: 3
            }),
            summaryType: 'sum5'
        },
        {
            header: '<b>तेल</b>',
            width:70,
            sortable: true,
            dataIndex:'tel',
            align:'center',
            editor: new Ext.form.NumberField(
            {
                allowBlank: false,
                allowNegative: false,
                selectOnFocus : true,
                decimalPrecision: 3
            }),
            summaryType: 'sum6'
        },
        {
            header: '<b>मीठ</b>',
            width:70,
            sortable: true,
            dataIndex:'mith',
            align:'center',
            editor: new Ext.form.NumberField(
            {
                allowBlank: false,
                allowNegative: false,
                selectOnFocus : true,
                decimalPrecision: 3
            }),
            summaryType: 'sum7'
        },
        {
            header: '<b>कांदा लसूण मसाला</b>',
            width:70,
            sortable: true,
            dataIndex:'mirchi',
            align:'center',
            editor: new Ext.form.NumberField(
            {
                allowBlank: false,
                allowNegative: false,
                selectOnFocus : true,
                decimalPrecision: 3
            }),
            summaryType: 'sum8'
        },
        {
            header: '<b>हळद</b>',
            width:70,
            sortable: true,
            dataIndex:'halad',
            align:'center',
            editor: new Ext.form.NumberField(
            {
                allowBlank: false,
                allowNegative: false,
                selectOnFocus : true,
                decimalPrecision: 3
            }),
            summaryType: 'sum9'
        },
        {
            header: '<b>जिरे</b>',
            width:70,
            sortable: true,
            dataIndex:'jire',
            align:'center',
            editor: new Ext.form.NumberField(
            {
                allowBlank: false,
                allowNegative: false,
                selectOnFocus : true,
                decimalPrecision: 3
            }),
            summaryType: 'sum10'
        },
        {
            header: '<b>मोहरी</b>',
            width:70,
            sortable: true,
            dataIndex:'mohari',
            align:'center',
            editor: new Ext.form.NumberField(
            {
                allowBlank: false,
                allowNegative: false,
                selectOnFocus : true,
                decimalPrecision: 3
            }),
            summaryType: 'sum11'
        },
        {
            header: '<b>तांदूळ</b>',
            width:70,
            sortable: true,
            dataIndex:'tandul',
            align:'center',
            editor: new Ext.form.NumberField(
            {
                allowBlank: false,
                allowNegative: false,
                selectOnFocus : true,
                decimalPrecision: 3
            }),
            summaryType: 'sum12'
        },
        {
            header: '<b>तांदूळ</b>',
            width:70,            
            sortable: true,
            id:'otandul',
            hidden:true,
            dataIndex:'otandul',
            align:'center'
        }],
        listeners: 
        {
            rowclick : function (g, rowIndex,e) 
            {
                var store = schoolWiseReturnGridEditable.getStore();
                schoolID = store.getAt(rowIndex).get('schoolId');
                talukaOrderID = talukaOrderId;
                dOrderID = districtOrderID;
                schoolMarathi = store.getAt(rowIndex).get('schoolMarathi');                
            }
        },
        height: 300,
        width: 600,
        frame: true,
        loadMask: true
    });
	        
    schoolWiseOrderGridEditable = new Ext.grid.EditorGridPanel(
    {
        id:'schoolWiseOrderGridEditable',
        store: allSchoolOrderStore,
        stripeRows: true,
        columnLines: true,
        scroll: true,
       // alias: ['widget.gridpanel', 'widget.grid'],
        columns: [
        new Ext.grid.RowNumberer(),
        {
            header: '<b>School ID</b>',
            dataIndex: 'schoolID',
            hidden: true
        },
        {
            header: '<b>Taluka Order Details ID</b>',
            dataIndex: 'talukaOrderDetailsId',
            align: 'center',
            width: 80,
            renderer: paintNull,
            hidden: true
        },
        {
            header: 'चालान क्र.',
            dataIndex: 'challanNumber',
            id: 'challanNumber',
            editable : getChallanFlag(),
            align: 'center',
            width: 95,
            editor: new Ext.form.NumberField(
            {
                allowBlank: false,
                allowNegative: false,
                selectOnFocus : true
            })
        },
        {
            header: 'चालान दिनांक',
            dataIndex: 'challanDate',
            align: 'center',
            editable :false,
            type: 'date',
            id: 'challanDate',
            /*editable : getChallanFlag(),
            editor: new fm.TextField({
                allowBlank: false,
                emptyText: 'dd/mm/yyyy'
            })*/
        },
        {                       
            id: 'school',
            header: '<b>अंगणवाडी</b>',
            dataIndex: 'schoolMarathi',
            align: 'center',
            width: 120
        },
        {
            id: 'schoolID',
            header: '<b>School Id</b>',
            dataIndex: 'schoolID',
            align: 'center',
            hidden : true,
            width: 150
        },
        {
            header: '<b>तुरदाळ</b>',
            width:70,
            sortable: true,
            dataIndex:'mungdaal',
            align:'center',
            editor: new Ext.form.NumberField(
            {
                allowBlank: false,
                allowNegative: false,
                selectOnFocus : true,
                decimalPrecision: 3
            }),
            summaryType: 'sum1'
        },
        {
            header: '<b>मसूर डाळ</b>',
            width:70,
            sortable: true,
            dataIndex:'matki',
            align:'center',
            editor: new Ext.form.NumberField(
            {
                allowBlank: false,
                allowNegative: false,
                selectOnFocus : true,
                decimalPrecision: 3
            }),
            summaryType: 'sum2'
        },
        {
            header: '<b>हरभरा</b>',
            width:70,
            sortable: true,
            dataIndex:'mung',
            align:'center',
            editor: new Ext.form.NumberField(
            {
                allowBlank: false,
                allowNegative: false,
                selectOnFocus : true,
                decimalPrecision: 3
            }),
            summaryType: 'sum3'
        },
        {
            header: '<b>मटकी</b>',
            width:70,
            sortable: true,
            dataIndex:'masuldaal',
            align:'center',
            editor: new Ext.form.NumberField(
            {
                allowBlank: false,
                allowNegative: false,
                selectOnFocus : true,
                decimalPrecision: 3
            }),
            summaryType: 'sum4'
        },
        {
            header: '<b>चवली</b>',
            width:70,
            sortable: true,
            dataIndex:'chvli',
            align:'center',
            editor: new Ext.form.NumberField(
            {
                allowBlank: false,
                allowNegative: false,
                selectOnFocus : true,
                decimalPrecision: 3
            }),
            summaryType: 'sum5'
        },
        {
            header: '<b>तेल</b>',
            width:70,
            sortable: true,
            dataIndex:'tel',
            align:'center',
            editor: new Ext.form.NumberField(
            {
                allowBlank: false,
                allowNegative: false,
                selectOnFocus : true,
                decimalPrecision: 3
            }),
            summaryType: 'sum6'
        },
        {
            header: '<b>मीठ</b>',
            width:70,
            sortable: true,
            dataIndex:'mith',
            align:'center',
            editor: new Ext.form.NumberField(
            {
                allowBlank: false,
                allowNegative: false,
                selectOnFocus : true,
                decimalPrecision: 3
            }),
            summaryType: 'sum7'
        },
        {
            header: '<b>कांदा लसूण मसाला</b>',
            width:70,
            sortable: true,
            dataIndex:'mirchi',
            align:'center',
            editor: new Ext.form.NumberField(
            {
                allowBlank: false,
                allowNegative: false,
                selectOnFocus : true,
                decimalPrecision: 3
            }),
            summaryType: 'sum8'
        },
        {
            header: '<b>हळद</b>',
            width:70,
            sortable: true,
            dataIndex:'halad',
            align:'center',
            editor: new Ext.form.NumberField(
            {
                allowBlank: false,
                allowNegative: false,
                selectOnFocus : true,
                decimalPrecision: 3
            }),
            summaryType: 'sum9'
        },
        {
            header: '<b>जिरे</b>',
            width:70,
            sortable: true,
            dataIndex:'jire',
            align:'center',
            editor: new Ext.form.NumberField(
            {
                allowBlank: false,
                allowNegative: false,
                selectOnFocus : true,
                decimalPrecision: 3
            }),
            summaryType: 'sum10'
        },
        {
            header: '<b>मोहरी</b>',
            width:70,
            sortable: true,
            dataIndex:'mohari',
            align:'center',
            editor: new Ext.form.NumberField(
            {
                allowBlank: false,
                allowNegative: false,
                selectOnFocus : true,
                decimalPrecision: 3
            }),
            summaryType: 'sum11'
        },
        {
            header: '<b>तांदूळ</b>',
            width:70,
            sortable: true,
            dataIndex:'tandul',
            align:'center',
            editor: new Ext.form.NumberField(
            {
                allowBlank: false,
                allowNegative: false,
                selectOnFocus : true,
                decimalPrecision: 3
            }),
            summaryType: 'sum12'
        }],
        listeners: 
        {
            rowclick : function (g, rowIndex,e) 
            {
                var store = schoolWiseOrderGridEditable.getStore();
                schoolID = store.getAt(rowIndex).get('schoolId');
                talukaOrderID = talukaOrderId;
                dOrderID = districtOrderID;
                schoolMarathi = store.getAt(rowIndex).get('schoolMarathi');                
            }
        },
        height: 300,
        width: 600,
        frame: true,
        loadMask: true,
        tbar: [
        {
            xtype: 'tbbutton',
            iconCls: 'challans',
            text: '<b>चालान बनवा / दिनाक बदला</b>',
            handler : function()
            {
                var sm = bOrders.getSelectionModel();
                var sel = sm.getSelections();
                var s1 = sel[0].get('mungdaal');
                var s2 = sel[0].get('matki');
                var s3 = sel[0].get('mung');
                var s4 = sel[0].get('masuldaal');
                var s5 = sel[0].get('chvli');
                var s6 = sel[0].get('tel');
                var s7 = sel[0].get('mith');
                var s8 = sel[0].get('mirchi');
                var s9 = sel[0].get('halad');
                var s10 = sel[0].get('jire');
                var s11 = sel[0].get('mohari');
                var s12 = sel[0].get('tandul');
                Ext.Msg.alert(s1);
                if( s1 == 0 && s2 == 0 && s3 == 0 && s4 == 0 && s5 == 0 && s6 == 0 && s7 == 0 && s8 == 0 && s9 == 0 && s10 == 0 && s11 == 0 && s12 == 0) 
                {
                    Ext.Msg.alert('Error in creating challans', 'Please <b>ऑर्डर पूर्ण करा</b> before you create challans!');
                    return;
                }
                else
                {
                    createChallans(allSchoolOrderStore);
                }
            }
        }]
    });
    
    showAllTalukaOrderDetails = function()
    {
        
        var sm = bOrders.getSelectionModel();
        sel = sm.getSelections();
        if(sel.length == 0)
        {
            Ext.Msg.alert('Warning','No Beat is selected.');
            return;
        }
        beatID = sel[0].get('beatID');
        beatMarathi = sel[0].get('beatMarathi');

        var title = "तालुका :"+ sel_taluka_name +"- ["+talukaGovOrderNo+"] - विभाग :"+sectionMarathi+" - बीट :"+beatMarathi+ "]";
        
        cm1 = schoolWiseOrderGridEditable.getColumnModel();
        if(orderType == 2)
        {            
            cm1.setHidden(7,false);
            cm1.setHidden(8,false);
            cm1.setHidden(9,false);
            cm1.setHidden(10,false);
            cm1.setHidden(11,false);
            cm1.setHidden(12,false);
            cm1.setHidden(13,false);
            cm1.setHidden(14,false);
            cm1.setHidden(15,false);
            cm1.setHidden(16,false);
            cm1.setHidden(17,false);
            cm1.setHidden(18,true);            
        }
        else
        {            
            cm1.setHidden(7,true);
            cm1.setHidden(8,true);
            cm1.setHidden(9,true);
            cm1.setHidden(10,true);
            cm1.setHidden(11,true);
            cm1.setHidden(12,true);
            cm1.setHidden(13,true);
            cm1.setHidden(14,true);
            cm1.setHidden(15,true);
            cm1.setHidden(16,true);
            cm1.setHidden(17,true);
            cm1.setHidden(18,false);
        }
       // Ext.Msg.alert("challan flag true"+challanFlag);
        openSchoolWin(schoolWiseOrderGridEditable, title,350,1200);                             
        
        allSchoolOrderStore.reload(
        {
            params :
            {
                beatID : beatID,            
                taluka_order_id : talukaOrderId
            }
        });
    };
    
    showAllTalukaReturnDetails = function()
    {
        
        var sm = bOrders.getSelectionModel();
        var sel = sm.getSelections();
        if(sel.length == 0)
        {
            Ext.Msg.alert("Warning","No Beat is selected");
            return
        };
        beatID = sel[0].get('beatID');
        beatMarathi = sel[0].get('beatMarathi');
        allSchoolReturnStore.removeAll();
        title = "तालुका :"+ sel_taluka_name +"- ["+talukaGovOrderNo+"] - विभाग :"+sectionMarathi+" - बीट :"+beatMarathi+ "]";
        
        cm1 = schoolWiseReturnGridEditable.getColumnModel();
        if(orderType == 2)
        {            
            cm1.setHidden(5,false);
            cm1.setHidden(6,false);
            cm1.setHidden(7,false);
            cm1.setHidden(8,false);
            cm1.setHidden(9,false);
            cm1.setHidden(10,false);
            cm1.setHidden(11,false);
            cm1.setHidden(12,false);
            cm1.setHidden(13,false);
            cm1.setHidden(14,false);
            cm1.setHidden(15,false);
            cm1.setHidden(16,true);            
        }
        else
        {            
            cm1.setHidden(5,true);
            cm1.setHidden(6,true);
            cm1.setHidden(7,true);
            cm1.setHidden(8,true);
            cm1.setHidden(9,true);
            cm1.setHidden(10,true);
            cm1.setHidden(11,true);
            cm1.setHidden(12,true);
            cm1.setHidden(13,true);
            cm1.setHidden(14,true);
            cm1.setHidden(15,true);
            cm1.setHidden(16,false);
        }
        //Ext.Msg.alert("challan flag true");
        openSchoolReturnWin(schoolWiseReturnGridEditable, title,350,1100);                             
        
        allSchoolReturnStore.reload(
        {
            params :
            {
                beatID : beatID,            
                taluka_order_id : talukaOrderId
            }
        });
    };
        
    // Show all Beat depending on selected taluka
    showAllBeatOrder = function()
    {
        allBeatOrderStore.removeAll();
        var sm = sOrders.getSelectionModel();
        var sel = sm.getSelections();        
        if(sel.length == 0)
        {
            Ext.Msg.alert("Warning","No Section is selected");
            return
        };
        var tabPane = Ext.getCmp('main-tab-pane');
        var activeTab = Ext.getCmp('bOrders');
        sectionID = sel[0].get('sectionID');
        sectionMarathi = sel[0].get('sectionMarathi');
        cm = bOrders.getColumnModel();
        if(orderType == 2)
        {   
            cm.setHidden(3,false);
            cm.setHidden(4,false);
            cm.setHidden(5,false);
            cm.setHidden(6,false);
            cm.setHidden(7,false);
            cm.setHidden(8,false);
            cm.setHidden(9,false);
            cm.setHidden(10,false);
            cm.setHidden(11,false);
            cm.setHidden(12,false);
            cm.setHidden(13,false);
            cm.setHidden(14,true);
        }
        else
        {
            cm.setHidden(3,true);
            cm.setHidden(4,true);
            cm.setHidden(5,true);
            cm.setHidden(6,true);
            cm.setHidden(7,true);
            cm.setHidden(8,true);
            cm.setHidden(9,true);
            cm.setHidden(10,true);
            cm.setHidden(11,true);
            cm.setHidden(12,true);
            cm.setHidden(13,true);            
            cm.setHidden(14,false   );
        }
                
        activeTab.setTitle('सर्व बीट ऑर्डर - [विभाग : '+sectionMarathi+', ऑर्डर : '+selOrderNumber+']');
        tabPane.setActiveTab(activeTab);
        allBeatOrderStore.removeAll();
        allBeatOrderStore.reload(
        {
            params:
            {
                sectionID:sectionID,
                talukaOrderID:talukaOrderId
            },
            waitMsg:'Loading...'
        });
    };
      
    // Show all section depending on selected taluka
    showAllSectionOrder = function()
    {
        allSectionOrderStore.removeAll();
        var sm = tOrders.getSelectionModel();
        var sel = sm.getSelections();        
        if(sel.length == 0)
        {
            Ext.Msg.alert("Warning","No taluka Order is selected");return
        };
        var tabPane = Ext.getCmp('main-tab-pane');
        var activeTab = Ext.getCmp('sOrders');
        sel_taluka_id = sel[0].get('talukaId');
        sel_taluka_name = sel[0].get('talukaName');
        talukaOrderId = sel[0].get('talukaOrderId');
        talukaGovOrderNo = sel[0].get('talukaOrderGovNum');
        orderType = sel[0].get('orderType');
        cm = sOrders.getColumnModel();
        if(orderType == 2)
        {   
            cm.setHidden(3,false);
            cm.setHidden(4,false);
            cm.setHidden(5,false);
            cm.setHidden(6,false);
            cm.setHidden(7,false);
            cm.setHidden(8,false);
            cm.setHidden(9,false);
            cm.setHidden(10,false);
            cm.setHidden(11,false);
            cm.setHidden(12,false);
            cm.setHidden(13,false);
            cm.setHidden(14,true);
        }
        else
        {
            cm.setHidden(3,true);
            cm.setHidden(4,true);
            cm.setHidden(5,true);
            cm.setHidden(6,true);
            cm.setHidden(7,true);
            cm.setHidden(8,true);
            cm.setHidden(9,true);
            cm.setHidden(10,true);
            cm.setHidden(11,true);
            cm.setHidden(12,true);
            cm.setHidden(13,true);            
            cm.setHidden(14,false   );
        }
        if(talukaOrderId == 0){Ext.Msg.alert("Warning","Please complete the order first");return;};
        activeTab.setTitle('सर्व विभाग ऑर्डर - [तालुका : '+sel_taluka_name+', ऑर्डर : '+selOrderNumber+']');
        tabPane.setActiveTab(activeTab);
        allSectionOrderStore.removeAll();
        allSectionOrderStore.reload(
        {
            params:
            {
                taluka_id:sel_taluka_id,
                talukaOrderID:talukaOrderId
            },
            waitMsg:'Loading...'
        });
    };
        
    //Get All Taluka order Depend on District
    showAllTalukaOrder = function()
    {                                                          
        allTalukaOrderStore.removeAll();
        var sm = dOrders.getSelectionModel();
        var sel = sm.getSelections();

        if(sel.length == 0){Ext.Msg.alert("Warning","No district Order is selected");return;}

        var tabPane = Ext.getCmp('main-tab-pane');
        var activeTab = Ext.getCmp('tOrders');

        var selDistrictOrderID = sel[0].get('orderID');
        selDistrictID = sel[0].get('districtID');
        var selDistrictName = sel[0].get('districtName');
        selOrderNumber = sel[0].get('orderNumber');
        districtOrderID = sel[0].get('orderID');

        activeTab.setTitle('सर्व तालूका ऑर्डर  - [जिल्हा : '+selDistrictName+',  ऑर्डर : '+selOrderNumber+']');
        Ext.getCmp('editDistrictOrderID').setValue(selDistrictOrderID);
       // Ext.getCmp('sch_grid').setTitle('School Master');

        tabPane.setActiveTab(activeTab);
        allTalukaOrderStore.load(
        {
            params:
            {
                district_order_id:selDistrictOrderID,
                district_id:selDistrictID
            },
            waitMsg:'Loading...'
        });
    };   
    
     //Start - Create add district order form
    newDistrictOrderForm = new Ext.FormPanel(
    {
        labelAlign: 'right',
        frame:true,
        id: 'new-district-order-form',
        autoDestroy : true,
        layout:'fit',
        buttonAlign: 'center',
        items: [
        {
            layout:'form',
            items:[
            {
                columnWidth:.100,
                layout: 'form',
                items: [
                {
                    xtype:'combo',
                    editable:false,
                    id:'t-of-ds-combo',
                    store: allDistrictStore,
                    allowBlank: false,
                    forceSelection : true,
                    triggerAction : 'all',
                    selectOnFocus :true,
                    mode :'local',
                    displayField : 'districtList' ,
                    valueField: 'districtID',
                    fieldLabel: 'जिल्हा',
                    name: 'district',
                    hiddenName : 'district_id',
                    msgTarget : 'side',
                    blankText: 'Correct this field',
                    anchor:'95%',
                    emptyText:'Select District'
                }, 
                {
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
                }, 
                {
                    xtype:'textfield',
                    id:'order-number',
                    fieldLabel: 'Order Number',
                    allowBlank: false,
                    name: 'orderNumber',
                    hiddenName : 'orderNumber',
                    allowBlank: false,
                    allowNegative: false,
                    msgTarget : 'side',
                    blankText: 'Correct this field',
                    anchor:'95%'
                },
                {
                    xtype:'textfield',
                    fieldLabel: 'Gov order ref. Number',
                    id:'gov-order-number',
                    allowBlank: false,
                    name: 'govOrderNumber',
                    hiddenName : 'govOrderNumber',
                    msgTarget : 'side',
                    blankText: 'Correct this field',
                    anchor:'95%'
                },
                {
                    xtype:'textfield',
                    width : 100,
                    fieldLabel: 'Creation Date',
                    id:'currdate',
                    allowBlank: false,
                    name: 'currdate',
                    hiddenName : 'currdate',
                    width : 125,
                    anchor:'95%',
                    value : today,
                    readOnly: true
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
                newDistrictOrderForm.getForm().submit(
                {
                    url: 'create/add-district-order.jsp',
                    method:'POST',
                    success: function(form, action)
                    {
                        allDistrictOrderStore.reload();
                        newDistrictOrderForm.getForm().reset();
                        Ext.Msg.alert('Success', 'District Order Created');
                    },
                    failure: function(form, action)
                    {
                        if(action.response != undefined)
                        {
                            Ext.Msg.alert('Warning', 'Order already exists');
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
                Ext.Msg.alert('Warning', 'Order already exists');
                newDistrictOrderForm.getForm().reset();
            }
        }]
    });
    //End - Create add district order form
    
     //Start - Create add district form
    editDistrictOrderForm = new Ext.FormPanel(
    {
       layout:'fit',
       labelAlign: 'right',
       frame:true,
       labelWidth: 150,
       id:'edit-district-form',
       autoDestroy: true,
       buttonAlign:'center',
       items:[
       {
           layout:  'form',
           items:[
           {
                xtype:'datefield',
                fieldLabel: 'Order Date',
                id:'eorderDate',
                allowBlank: false,
                editable:false,
                format: 'd/m/Y',
                name: 'eorderDate',
                hiddenName : 'eorderDate',
                msgTarget : 'side',
                blankText: 'Correct this field',
                anchor:'95%'
            }, 
            {
                xtype:'numberfield',
                fieldLabel: 'Order Number',
                id:'eorderNumber',
                allowBlank: false,
                name: 'eorderNumber',
                hiddenName : 'eorderNumber',
                allowNegative: false,
                msgTarget : 'side',
                blankText: 'Correct this field',
                anchor:'95%'
            }, 
            {
                xtype:'textfield',
                fieldLabel: 'Gov order ref. Number',
                id:'egovOrderNumber',
                allowBlank: false,
                name: 'egovOrderNumber',
                hiddenName : 'egovOrderNumber',
                msgTarget : 'side',
                blankText: 'Correct this field',
                anchor:'95%'
            },
            {
                xtype:'hidden',
                name:'edistrict-order-id',
                id:'edistrict-order-id',
                value : ''
            },
            {
                xtype:'hidden',
                name:'etaluka-id',
                id:'etaluka-id',
                value : ''
            }]
        }],
        buttons:[
        {
            text:'Update',
            id: 'district-update',
            iconCls:'update',
            height: 25,
            handler: function()
            {
                editDistrictOrderForm.getForm().submit(
                {
                    url: 'update/update-district-order.jsp',
                    method:'POST',
                    success: function()
                    {
                        Ext.Msg.alert("Status","District Order Updated", function(btn,text)
                        {
                            if(btn == 'ok')
                            {
                                allDistrictOrderStore.reload({waitMsg:'Loading..'});
                            }
                        });
                    },
                    failure: function(form,action)
                    {
                        if(action.response != undefined)
                        {
                            Ext.Msg.alert('Warning', 'District Order Already Exists');
                        }
                        else
                        {
                            Ext.Msg.alert('Alert...', 'Enter Details Correctly...');
                           // editDistrict.getForm().reset();
                        }
                    }
                });
            }
        }]
    });
    //End - Create add district form
    
     //Start - Create add taluka order form
    editTalukaOrderForm = new Ext.FormPanel(
    {
        labelAlign: 'right',
        frame:true,
        id: 'edit-taluka-order-form',
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
                    id:'fromMonth',
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
                    anchor:'90%'
                },
                {
                    xtype:'combo',
                    store: monthStore1,
                    id:'toMonth',
                    allowBlank: false,
                    displayField : 'mm' ,
                    valueField: 'id',
                    mode :'local',
                    forceSelection : true,
                    triggerAction : 'all',
                    selectOnFocus :true,
                    editable:false,
                    anchor:'90%',
                    hiddenName : 'toMonth',
                    fieldLabel: 'ते माहे',
                    name: 'toMonth'
                },
                {
                    xtype:'datefield',
                    id:'govOrderDate',
                    fieldLabel: 'तालूका ऑर्डर दिनांक',
                    allowBlank: false,
                    editable:false,
                    format: 'd/m/Y' ,
                    anchor:'90%',
                    name: 'govOrderDate',
                    hiddenName : 'govOrderDate'
                },
                {
                    xtype: 'combo',
                    id: 'orderType',
                    anchor: '90%',
                    fieldLabel: 'Ration Type',
                    fields: ['orderType', 'text'],
                    store: orderTypeStore,
                    mode: 'local',
                    valueField: 'orderType',
                    displayField: 'text',
                    forceSelection: true,
                    triggerAction: 'all',
                    selectOnFocus: true,
                    editable: false,
                    name: 'orderType',
                    hiddenName: 'orderType',
                    allowBlank: false
                }]
            },
            {
                columnWidth:.50,
                layout: 'form',
                items: [
                {
                    xtype:'combo',
                    id:'fromYear',
                    allowBlank: false,
                    forceSelection : true,
                    triggerAction : 'all',
                    selectOnFocus :true,
                    editable:false,
                    store: yearStore,
                    displayField : 'yearMarathi' ,
                    valueField: 'year',
                    fieldLabel: 'वर्षे',
                    name: 'fromYear',
                    hiddenName : 'fromYear',
                    anchor:'90%'
                },
                {
                    xtype:'combo',
                    id:'toYear',
                    allowBlank: false,
                    forceSelection : true,
                    triggerAction : 'all',
                    selectOnFocus :true,
                    editable:false,
                    store: yearStore,
                    displayField : 'yearMarathi' ,
                    valueField: 'year',
                    fieldLabel: 'ते वर्षे',
                    name: 'toYear',
                    hiddenName : 'toYear',
                    anchor:'90%'
                },
                {
                    xtype:'textfield',
                    id:'govOrderNumber',
                    fieldLabel: 'तालूका ऑर्डर क्र.',
                    allowBlank: false,
                    name: 'govOrderNumber',
                    hiddenName : 'govOrderNumber',
                    anchor:'90%'
                },
                {
                    xtype:'hidden',
                    id:'editDistrictOrderID',
                    name:'editDistrictOrderID',
                    fieldLabel:'editDistrictOrderID'
                },
                {
                    xtype:'hidden',
                    id:'editTalukaID',
                    name:'editTalukaID',
                    fieldLabel:'editTalukaID'
                },
                {
                    xtype:'hidden',
                    id:'editTalukaOrderID',
                    name:'editTalukaOrderID',
                    fieldLabel:'editTalukaOrderID'
                }]
            }]
        }],
        buttons: [
        {
            text: 'Save',
            scale: 'medium',
            id:'taluka-order-button',
            iconCls:'save',
            height:'25',
            handler: function()
            {
                editTalukaOrderForm.getForm().submit(
                {
                    url: 'update/update-taluka-order.jsp',
                    method: 'POST',                             
                    success: function(form, action)
                    {
                        allTalukaOrderStore.reload(
                        {
                            waitMsg:'Loading...'
                        });
                        Ext.Msg.hide();
                        editTalukaOrderForm.getForm().reset();
                        win.hupdateide();
                        Ext.Msg.alert('Success', 'Taluka Order Updated');
                    },
                    failure: function(form, action){
                        Ext.Msg.alert('Warning', 'Taluka Order Already Exists...');
                    }
                });
            }
        },
        {
            text: 'Clear',
            scale: 'medium',
            iconCls:'clear',
            height:'25',
            id:'taluka-order-clear',
            handler: function()
            {
                editTalukaOrderForm.getForm().reset();
            }
        }]
    });
    //End - Create edit taluka order form
     
    //Start - Creates a grid for District Master
    dOrders = new Ext.grid.GridPanel(
    {
        store: allDistrictOrderStore,
        id: 'dOrders',
        stripeRows: true,
        loadMask: true,
        columnLines: true,
        stateId: 'dOrders',
        frame : true,
        listeners:
        {
            dblclick: showAllTalukaOrder
        },
        tbar:['-',
        {
            iconCls: 'add',
            text: 'नविन जिल्हा ऑर्डर',
            handler: function()
            {
               allDistrictStore.load();
               openWin(newDistrictOrderForm, 'District Order',270,400);
            }
        },'-','-','-',
        {
            text: 'सर्व तालूका ऑर्डर',
            iconCls:'showall',
            handler: showAllTalukaOrder
        },'-','-','-',
        {
            text: 'Edit District Order',
            iconCls: 'edit',
            handler: function()
            {
                var sm = dOrders.getSelectionModel();
                var sel = sm.getSelections();
                if(sel.length == 0)
                {
                    Ext.Msg.alert('Warning','No district order is selected.');
                    return;
                }
                var district_order_id = sel[0].get('orderID');
                var order_date = sel[0].get('orderNoDate');
                var order_no = sel[0].get('orderNumber');
                var gov_order_no = sel[0].get('districtGovOrderID');
                
                Ext.getCmp('edistrict-order-id').setValue(district_order_id);
                Ext.getCmp('eorderDate').setValue(order_date);
                Ext.getCmp('eorderNumber').setValue(order_no);
                Ext.getCmp('egovOrderNumber').setValue(gov_order_no);
                
                // Call to openEdit function  etaluka-id
                Ext.getCmp('district-update').enable();
                openEdit(editDistrictOrderForm, 'District Order ',200,500);
            }
        },'->',
        {
            text: 'सर्व बिल',
            iconCls:'showall',
            handler: function()
            {
            	allTalukaRationBillStore.load();
            	allTalukaTandulBillStore.load();
            	openAllBillWin();
            }
        },'-',
        {
            iconCls: 'bill',
            text: 'बिल बनवा',
            handler: function()
            {
                var sm = dOrders.getSelectionModel();
                var sel = sm.getSelections();
                if(sel.length == 0) 
                {
                    Ext.Msg.alert('Select District Order', 'No District order is selected!');
                    return;
                }
                getBillDatePreviewWin();
                orderID = sel[0].get('orderID');
                districtID = sel[0].get('districtID');

              //  talukaInvoiceDate = sel[0].get('talukaInvoiceDate');
               // var orderType = sel[0].get('orderType');


                previewParam = "orderID="+orderID+"&districtID="+districtID;//+"&orderType="+orderType;
                Ext.getCmp('billPreviewDate').reset();
               // Ext.getCmp('billPreviewDate').setValue(talukaInvoiceDate);
                billDatePreviewWin.show();
                //allBillStore.reload();
            }
        },'-',
        {
            iconCls: 'report',
            text: 'जिल्हा गोषवारा ',
            handler: function()
            {
            	var sm = dOrders.getSelectionModel();
                var sel = sm.getSelections();
                if(sel == 0){Ext.Msg.alert('Warning','No district order is selected');return;}
                var sel_order_id = sel[0].get('orderID');  
                districtID = sel[0].get('districtID');  
                var param = "orderID="+sel_order_id+"&districtID="+districtID;

                window.open("reports/district-ghoshwara-report.jsp?"+param,'districtreport',"width=1500,height=800,top=40,left=60,menubar=1,resizable=0,location=1,scrollbars=1");
            }

        },'-',
        {
            text:'Delete',
            iconCls:'delete',
            handler: function()
            {
                var sm = dOrders.getSelectionModel();
                var sel = sm.getSelections();
                if(sel == 0){Ext.Msg.alert('Warning','No district order is selected');return;}
                var sel_order_id = sel[0].get('orderID');
                var sel_order_dist = sel[0].get('districtName');
                Ext.MessageBox.show(
                {
                   title: 'Confirm Delete',
                   msg: 'Do you want to delete <b>'+sel_order_id+'</b> district order for district: <b>'+ sel_order_dist + '</b>',
                   buttons: Ext.MessageBox.YESNO,
                   fn: function(btn)
                   {
                       if(btn == "yes")
                       {
                           Ext.Ajax.request(
                           {
                               url: 'delete/delete-district-order.jsp',
                               method:'GET',
                               params:{district_order_id:sel_order_id},
                               success: function()
                               {
                                    Ext.Msg.alert("Deleted",'District Order Deleted');
                                    allDistrictOrderStore.reload(
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
                header: '<b>Order ID</b>',
                width:'80',
                sortable: true,
                hidden: true,
                align: 'center',
                dataIndex:'orderID'
            },
            {
                header: '<b>District Name</b>',
                width:'80',
                sortable: true,
                align: 'center',
                dataIndex:'districtName'
            },
            {
                header: '<b>District Order No.</b>',
                width:120,
                sortable: true,
                align: 'center',
                dataIndex:'districtGovOrderID'
            },
            {
                header: '<b>District Order Date</b>',
                width:150,
                sortable: true,
                align: 'center',
                dataIndex:'orderNoDate'
            },
            {
                header: '<b>Order</b>',
                width:'80',
                sortable: true,
                align: 'center',
                dataIndex:'orderNumber',
                renderer : function(v){
                    return 'ऑर्डर '+v;
                }
            },
            {
                header: '<b>Created On</b>',
                width:'80',
                sortable: true,
                align: 'center',
                dataIndex:'creationDate'
            },
            {
                header: '<b>District ID</b>',
                width:'80',
                sortable: true,
                align: 'center',
                hidden: true,
                dataIndex:'districtID'
            },
            {
                header: '<b>STD Group</b>',
                width:'80',
                sortable: true,
                align: 'center',
                dataIndex:'stdTypeDetails'
            },
            {
                header: '<b>STD ID</b>',
                width:'80',
                sortable: true,
                align: 'center',
                hidden: true,
                dataIndex:'stdType'
            }
        ],
        width:1000,
        height:483,
        title:'सर्व जिल्हा ऑर्डर ',
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
            store: allDistrictOrderStore,
            displayInfo: true,
            displayMsg: 'Displaying results {0} - {1} of {2}',
            emptyMsg: "No results to display"
        })
    });
    //End - Creates a grid for District Master
    
    function getCopyFormItems() 
    {
        var panel = new Ext.Panel(
        {
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
                valueField: 'talukaOrderId',
                anchor:'95%'
            } ]
        });
        return panel;
    };
    
    //defines action to take on click of Save button
    function cancelCopyHandler() {
        copyTalukaOrderWin.hide();
    };
    
     //defines action to take on click of Save button
    function saveCopyHandler() 
    {
        if(copyFrm.getForm().isValid())
        {
            copyFrm.getForm().submit(
            {
                url: 'create/copy-taluka-order.jsp',
                method: 'POST',
                params:
                {
                    selTalukaID : sel_taluka_id,
                    selectedTalukaOrderID : talukaOrderId
                },
                success: function(form, action)
                {
                    copyTalukaOrderWin.hide();
                    allTalukaStore.reload(
                    {
                        waitMsg:'Loading...'
                    });
                    Ext.Msg.alert('Success', 'Taluka order Copied Successfully');
                },
                failure: function(form, action)
                {
                    Ext.Msg.alert('Error', 'Error Could Not Copy Taluka Order');
                }

            });
        }
    };
    
    //variable which defines Save button
    var saveCopyButton = 
    {
        xtype: 'button',
        text: 'Save',
        handler: saveCopyHandler
    };
    //variable which defines Cancel button
    var cancelCopyButton =
    {
        xtype: 'button',
        text: 'Cancel',
        handler: cancelCopyHandler
    };
    
    //FormPanel to add data to grid start
    copyFrm = new Ext.FormPanel(
    {
        region: 'center',
        method: 'POST',
        buttonAlign: 'center',
        labelAlign: 'right',
        url: '',
        id: 'copyformpanel',
        autoDestroy: false,
        frame: true,
        items: [getCopyFormItems()],
        buttons: [saveCopyButton, cancelCopyButton]
    });
    
    
    getCopyTalukaOrderWin = function () 
    {
        //Window for adding data to the grid
        if (Ext.type(copyTalukaOrderWin))
        {
            return copyTalukaOrderWin;
        }
        copyTalukaOrderWin = new Ext.Window(
        {
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
    
    //Start - Creates a grid for Taluka Master
    tOrders = new Ext.grid.GridPanel(
    {
        store: allTalukaOrderStore,
        id: 'tOrders',
        stripeRows: true,
        loadMask: true,
        columnLines: true,
        stateId: 'tOrders',
        frame : true,
        listeners:
        {
            dblclick: showAllSectionOrder
        },
        tbar:['-',
        {
            iconCls: 'showall',
            text: 'सर्व विभाग',
            handler: showAllSectionOrder
        },'-','-','-',
        {
            iconCls: 'copy',
            text : 'Copy Order',
            handler: function()
            {
                var sm = tOrders.getSelectionModel();
                var sel = sm.getSelections();
                if(sel.length == 0) 
                {
                    Ext.Msg.alert('Select Taluka Order To Copy', 'No Taluka Order is selected!');
                    return;
                }
                talukaOrderId = sel[0].get('talukaOrderId');
                if(talukaOrderId == 0) 
                {
                    Ext.Msg.alert('Copy Order', 'Click on <b>Edit Order</b> and Save pending Information!');
                    return;
                }
                selectedTalukaOrderDetailID = sel[0].get('talukaOrderDetailsId');

                if(selectedTalukaOrderDetailID != 0 ) 
                {
                    Ext.Msg.alert('Copy Order', 'Taluka Order Already Exists...');
                    return;
                }

                sel_taluka_id = sel[0].get('talukaId');
                orderType = sel[0].get('orderType');

                getCopyTalukaOrderWin();
                talukaOrderList.removeAll();
                talukaOrderList.load(
                {
                    params:
                    {
                        talukaID : sel_taluka_id,
                        talukaOrderID : talukaOrderId,
                        orderType : orderType
                    }
                });
                copyFrm.getForm().reset();
                copyTalukaOrderWin.show();
            }
        },'-','-','-',
        {
            text: 'Edit Taluka Order',
            iconCls: 'edit',
            handler: function()
            {
                var sm = tOrders.getSelectionModel();
                var sel = sm.getSelections();
                if(sel.length == 0)
                {
                    Ext.Msg.alert('Warning','No taluka is selected.');
                    return;
                }
                var taluka_id = sel[0].get('talukaId');
                var fromMonth = sel[0].get('fMonthId');
                var fromYear = sel[0].get('fromYear');
                var toMonth = sel[0].get('tMonthId');
                var toYear = sel[0].get('toYear');
                var tOrderDate = sel[0].get('tOrderDate');
                var tOrderNo = sel[0].get('talukaOrderGovNum');
                var talukaOrderID = sel[0].get('talukaOrderId');
                if(talukaOrderID != null)
                {
                    Ext.getCmp('editTalukaOrderID').setValue(talukaOrderID);
                }
                else
                {
                    Ext.getCmp('editTalukaOrderID').setValue(" ");
                }

                Ext.getCmp('editTalukaID').setValue(taluka_id);

                if(fromMonth != null){Ext.getCmp('fromMonth').setValue(fromMonth);}else{Ext.getCmp('fromMonth').setValue(" ");}
                if(fromYear != null){Ext.getCmp('fromYear').setValue(fromYear);}else{Ext.getCmp('fromYear').setValue(" ");}
                if(toMonth != null){Ext.getCmp('toMonth').setValue(toMonth);}else{Ext.getCmp('toMonth').setValue(" ");}
                if(toYear != null){Ext.getCmp('toYear').setValue(toYear);}else{Ext.getCmp('toYear').setValue(" ");}
                if(tOrderDate != null){Ext.getCmp('govOrderDate').setValue(tOrderDate);}else{Ext.getCmp('govOrderDate').setValue(" ");}
                if(tOrderNo != null){Ext.getCmp('govOrderNumber').setValue(tOrderNo);}else{Ext.getCmp('govOrderNumber').setValue(" ");}

                // Call to openEdit function
                monthStore.load();
                monthStore1.load();
                openEdit(editTalukaOrderForm, 'Taluka Order',220,800);
                if(talukaOrderID != "0")
                {
                    Ext.getCmp('orderType').hide();
                    Ext.getCmp('taluka-order-button').setText("Update");
                    Ext.getCmp('taluka-order-button').setIconClass("update");
                    Ext.getCmp('taluka-order-clear').hide();
                }
                else
                {          
                    Ext.getCmp('orderType').show();
                    Ext.getCmp('taluka-order-button').setText("Save");
                    Ext.getCmp('taluka-order-button').setIconClass("save");
                    Ext.getCmp('taluka-order-clear').show();
                }
            }
        },'->',
        {
            text:'Delete',
            iconCls:'delete',
            handler: function()
            {
                var sm = tOrders.getSelectionModel();
                var sel = sm.getSelections();
                if(sel == 0)
                {
                    Ext.Msg.alert('Warning','No taluka is selected');return;
                }
                var seltalukaOrderID = sel[0].get('talukaOrderId');
                if(seltalukaOrderID == 0){Ext.Msg.alert('Warning','Selected taluka order is not created. You cannot delete order.');return;}
                var sel_tal_marathi = sel[0].get('talukaName');
                Ext.MessageBox.show(
                {
                   title: 'Confirm Delete',
                   msg: 'Do you want to delete selected taluka order for taluka: <b>'+ sel_tal_marathi + '</b>',
                   buttons: Ext.MessageBox.YESNO,
                   fn: function(btn)
                   {
                       if(btn == "yes")
                       {
                           Ext.Ajax.request(
                           {
                               url: 'delete/delete-taluka-order.jsp',
                               method:'POST',
                               params:{taluka_order_id:seltalukaOrderID},
                               success: function()
                               {
                                    Ext.Msg.alert("Deleted",'Taluka Order Deleted');
                                    allTalukaOrderStore.reload(
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
        },'-','->',
        {
            iconCls: 'bill',
            text: 'बिल बनवा',
            handler: function()
            {
                var sm = tOrders.getSelectionModel();
                var sel = sm.getSelections();
                if(sel.length == 0) 
                {
                    Ext.Msg.alert('Select Taluka Order', 'No taluka order is selected!');
                    return;
                }
                getBillDatePreviewWin();
                previewId = sel[0].get('talukaOrderId');
                previewTalukaID = sel[0].get('talukaId');

              //  talukaInvoiceDate = sel[0].get('talukaInvoiceDate');
               // var orderType = sel[0].get('orderType');


                previewParam = "orderID="+previewId+"&talukaID="+previewTalukaID;//+"&orderType="+orderType;
                Ext.getCmp('billPreviewDate').reset();
               // Ext.getCmp('billPreviewDate').setValue(talukaInvoiceDate);
                billDatePreviewWin.show();
                //allBillStore.reload();
            }
        },'-','->',
        {
             text: 'तालुका ऑर्डर लोडींग गोषवारा',
             handler: function()
             {
                var sm = tOrders.getSelectionModel();
                var sel = sm.getSelections();
                if(sel.length == 0)
                {
                    Ext.Msg.alert('Select Taluka Order', 'No taluka order is selected!');
                    return;
                }
                var id = sel[0].get('talukaOrderId');
                var talukaID = sel[0].get('talukaId');                
                var orderType = sel[0].get('orderType');
                if(id == 0) 
                {
                    Ext.Msg.alert('Selected Taluka Order', 'No Taluka order is Created. Create Order First!');
                    return;
                }

                var param = "talukaOrderID="+id+"&talukaID="+talukaID+"&orderType="+orderType;
                Ext.getCmp('prevparam').setValue(param);
                allRootStore.load();
                openEdit(getOrderRootDetailsForm, 'Loading Details',150,300);
                
                
                //window.open("reports/taluka-loading-report.jsp?"+param,'talukaloadingreport',"width=1500,height=800,top=40,left=60,menubar=1,resizable=0,location=1,scrollbars=1");
            }
    },'-','->',
    {
        text:'तालुका ऑर्डर गोषवारा',
        handler: function()
        {
            var sm = tOrders.getSelectionModel();
            var sel = sm.getSelections();
            if(sel.length == 0) 
            {
                Ext.Msg.alert('Select Taluka Order', 'No taluka order is selected!');
                return;
            }
            var id = sel[0].get('talukaOrderId');
            var talukaID = sel[0].get('talukaId');
            var orderType = sel[0].get('orderType');
            if(id == 0) 
            {
                Ext.Msg.alert('Selected Taluka Order', 'No Taluka order is Created. Create Order First!');
                return;
            }
            
            var param = "talukaOrderID="+id+"&talukaID="+talukaID+"&orderType="+orderType;
            window.open("reports/taluka-report.jsp?"+param,'talukareport',"width=1500,height=800,top=40,left=60,menubar=1,resizable=0,location=1,scrollbars=1");
        }       

    },'-'],
    columns:[
    new Ext.grid.RowNumberer(),
    {
        header: '<b>ऑर्डर क्र.</b>',
        width:'80',
        sortable: true,
        dataIndex:'talukaOrderGovNum',
        renderer : paintNull,
        align:'center'
    },
    {
        header: '<b>ऑर्डर दिनांक</b>',
        width:'80',
        sortable: true,
        dataIndex:'tOrderDate',
        renderer : paintNull,
        align:'center'
    },
    {
        header: '<b>तालुका</b>',
        width:'80',
        sortable: true,
        dataIndex:'talukaName',
        renderer : paintNull,
        align:'center'
    },
    {
        header: '<b>तालुका ID</b>',
        width:'80',
        sortable: true,
        dataIndex:'talukaId',
        renderer : paintNull,
        align:'center',
        hidden:true
    },
    {
        header: '<b>माहे</b>',
        width:'80',
        sortable: true,
        dataIndex:'fromMonth',
        renderer : paintNull,
        align:'center'
    },
    {
        header: '<b>वर्षे</b>',
        width:'80',
        sortable: true,
        dataIndex:'fromYear',
       renderer : paintNull,
        align:'center'
    },
    {
        header: '<b>ते माहे</b>',
        width:'80',
        sortable: true,
        dataIndex:'toMonth',
        renderer : paintNull,
        align:'center'
    },
    {
        header: '<b>ते वर्षे</b>',
        width:'80',
        sortable: true,
        dataIndex:'toYear',
        renderer : paintNull,
        align:'center'
    },
    {
        header: '<b>Order Type</b>',
        width:'80',
        sortable: true,
        dataIndex:'orderTypeDetails',
        renderer : paintNull,
        align:'center'
    },
    {
        header: '<b>Order Type</b>',
        width:'80',
        hidden : true,
        sortable: true,
        dataIndex:'orderType',
        renderer : paintNull,
        align:'center'
    },
    {
        header: '<b>Taluka Order Details ID</b>',
        width:'80',
        sortable: true,
        dataIndex:'talukaOrderDetailsId',
        renderer : paintNull,
        align:'center',
        hidden : true
    }],
    width:200,
    height:500,
    title:'सर्व तालूका ऑर्डर ',
    iconCls: 'home',
    bbar:new Ext.PagingToolbar(
    {
        pageSize: 100,
        store: allTalukaOrderStore,
        displayInfo: true,
        displayMsg: 'Displaying results {0} - {1} of {2}',
        emptyMsg: "No results to display"
    })
});
    //End - Creates a grid for Taluka Master
        
    //Start - Creates a grid for Section Master
    sOrders = new Ext.grid.GridPanel(
    {
        store: allSectionOrderStore,
        id: 'sOrders',
        stripeRows: true,
        loadMask: true,
        columnLines: true,
        stateId: 'sOrders',
        frame : true,        
        listeners:
        {
            dblclick: showAllBeatOrder
        },
        tbar:[
        {
            iconCls: 'showall',
            text: 'सर्व बीट',
            handler: showAllBeatOrder
        },'->',
        {
            iconCls: 'report',
            text: 'विभाग गोषवारा',
            handler: function()
            {
                var sm = sOrders.getSelectionModel();
                var sel = sm.getSelections();
                if(sel.length == 0)
                {
                    Ext.Msg.alert('Select Section', 'No section is selected!');
                    return;
                }
                var sectionID = sel[0].get('sectionID');
                sectionMarathi = sel[0].get('sectionName');
                var param = "talukaOrderID="+talukaOrderId+"&sectionID="+sectionID+"&orderType="+orderType;
                window.open("reports/section-report.jsp?"+param,'sectionreport',"width=1500,height=800,top=40,left=60,menubar=1,resizable=0,location=1,scrollbars=1");
            }   
        }],
        //  plugins: [new Ext.ux.grid.GridSummary()],
        columns:[new Ext.grid.RowNumberer(),
        {
            header: '<b>Section Id</b>',
            width:'30',
            sortable: true,
            dataIndex:'sectionID',
            align:'center',
            hidden:true
        },
        {
            header: '<b>विभाग </b>',
            width:150,
            sortable: true,
            dataIndex:'sectionMarathi',
            align:'center',
            summaryType: 'count',
            summaryRenderer: function (v, params, data) 
            {
                params.attr = 'ext:qtip="Total be"'; // summary column tooltip example
                return v? ((v === 0 || v > 1) ? 'एकूण लाभार्थी >'  : 'एकूण लाभार्थी >') : '';
            }
        },
        {
            header: '<b>तुरदाळ</b>',
            width:90,
            sortable: true,
            dataIndex:'mungdaal',
            align:'center',
            summaryType: 'sum',
            renderer: function(value, metaData, record, rowIdx, colIdx, store, view){
                return value ;
            },
            summaryRenderer: function(value, summaryData, dataIndex) {
                return value;
            },
            field: {
                xtype: 'numberfield'
            }
        },
        {
            header: '<b>मसूर डाळ</b>',
            width:90,
            sortable: true,
            dataIndex:'matki',
            align:'center',
            summaryType: 'sum'
        },
        {
            header: '<b>हरभरा</b>',
            width:90,
            sortable: true,
            dataIndex:'mung',
            align:'center',
            summaryType: 'sum'
        },
        {
            header: '<b>मटकी</b>',
            width:90,
            sortable: true,
            dataIndex:'masuldaal',
            align:'center',
            summaryType: 'sum'
        },
        {
            header: '<b>चवली</b>',
            width:90,
            sortable: true,
            dataIndex:'chvli',
            align:'center',
            summaryType: 'sum'
        },
        {
            header: '<b>तेल</b>',
            width:90,
            sortable: true,
            dataIndex:'tel',
            align:'center',
            summaryType: 'sum'
        },
        {
            header: '<b>मीठ</b>',
            width:90,
            sortable: true,
            dataIndex:'mith',
            align:'center',
            summaryType: 'sum'
        },
        {
            header: '<b>कांदा लसूण मसाला</b>',
            width:90,
            sortable: true,
            dataIndex:'mirchi',
            align:'center',
            summaryType: 'sum'
        },
        {
            header: '<b>हळद</b>',
            width:90,
            sortable: true,
            dataIndex:'halad',
            align:'center',
            summaryType: 'sum'
        },
        {
            header: '<b>जिरे</b>',
            width:90,
            sortable: true,
            dataIndex:'jire',
            align:'center',
            summaryType: 'sum'
        },
        {
            header: '<b>मोहरी</b>',
            width:90,
            sortable: true,
            dataIndex:'mohari',
            align:'center',
            summaryType: 'sum'
        },
        {
            header: '<b>तांदूळ</b>',
            width:90,
            sortable: true,
            dataIndex:'tandul',
            align:'center',
            summaryType: 'sum'
        }],
        width:700,
        height:500,
        title:'सर्व विभाग ऑर्डर',
        iconCls: 'home'
    });
    //End - Creates a grid for Section Master
    
    //Start - Creates a grid for Section Master
    bOrders = new Ext.grid.GridPanel(
    {
        store: allBeatOrderStore,
        id: 'bOrders',
        stripeRows: true,
        loadMask: true,
        columnLines: true,
        stateId: 'bOrders',
        frame : true,
        listeners:
        {
            dblclick: showAllTalukaOrderDetails
        },
        tbar:['-',
        {
            iconCls: 'showall',
            text: 'ओर्डर पूर्ण करा',
            handler: showAllTalukaOrderDetails
        },'-',
        {
            iconCls: 'showall',
            text: 'ओर्डर परत करा',
            handler: showAllTalukaReturnDetails
        },'->',
        {
            iconCls: 'report',
            text: 'बीट गोषवारा',
            handler: function()
            {
                var sm = bOrders.getSelectionModel();
                var sel = sm.getSelections();
                if(sel.length == 0)
                {
                    Ext.Msg.alert('Select Beat', 'No Beat is selected!');
                    return;
                }
                var beatID = sel[0].get('beatID');
                beatMarathi = sel[0].get('beatMarathi');
                var param = "talukaOrderID="+talukaOrderId+"&beatID="+beatID+"&orderType="+orderType;
                window.open("reports/beat-report.jsp?"+param,'sectionreport',"width=1500,height=800,top=40,left=60,menubar=1,resizable=0,location=1,scrollbars=1");
            }
        }, '-',
        {
            iconCls: 'printerall',
            text: 'चालान प्रिंट करा (Plain)',
            handler: function()
            {
                var sm = bOrders.getSelectionModel();
                var sel = sm.getSelections();
                if(sel.length == 0)
                {
                    Ext.Msg.alert('Select Beat', 'No Beat is selected!');
                    return;
                }
                var beatID = sel[0].get('beatID');
                beatMarathi = sel[0].get('beatMarathi');
                var param = "talukaOrderID="+talukaOrderId+"&beatID="+beatID+"&orderType="+orderType;
                window.open("reports/print-all-challan.jsp?"+param,'sectionreport',"width=1500,height=800,top=40,left=60,menubar=1,resizable=0,location=1,scrollbars=1");
            }
        }, '-',
        {
            iconCls: 'printerall',
            text: 'चालान प्रिंट करा (Formatted)',
            handler: function()
            {
                var sm = bOrders.getSelectionModel();
                var sel = sm.getSelections();
                if(sel.length == 0)
                {
                    Ext.Msg.alert('Select Beat', 'No Beat is selected!');
                    return;
                }
                var beatID = sel[0].get('beatID');
                beatMarathi = sel[0].get('beatMarathi');
                var param = "talukaOrderID="+talukaOrderId+"&beatID="+beatID+"&orderType="+orderType;
                window.open("reports/print-all-challan-formatted.jsp?"+param,'sectionreport',"width=1500,height=800,top=40,left=60,menubar=1,resizable=0,location=1,scrollbars=1");
            }
        }, '-',
        {
            xtype:'splitbutton',
            iconCls: 'arrow_out',
            menu: [
            {
                text: 'Set challan mannual',
                handler: function()
                {  
                    challanFlag = true;
                    showAllTalukaOrderDetails();
                }
            },
            {
                text: 'Reset Order',
                handler: function()
                {
                    var sm = bOrders.getSelectionModel();
                    var sel = sm.getSelections();
                    if(sel.length == 0)
                    {
                        Ext.Msg.alert('Select Beat', 'No Beat is selected!');
                        return;
                    }
                    var beatID = sel[0].get('beatID');
                    Ext.Msg.show(
                    {
                        title: 'Confirm',
                        msg: 'Its not reversible action, Do you really want to reset the order?',
                        buttons: Ext.Msg.YESNO,
                        fn: function(btn) 
                        {
                            if (btn == 'yes') 
                            {
                                Ext.Ajax.request(
                                {
                                    url: 'delete/delete-section-beat-order.jsp',
                                    method: 'POST',
                                    params:
                                    {
                                        talukaOrderID:talukaOrderId,
                                        beatID:beatID
                                    },
                                    success: function(resp,opt) 
                                    {
                                        allBeatOrderStore.removeAll();
                                        allBeatOrderStore.reload(
                                        {
                                            params:
                                            {
                                                sectionID: sectionID,
                                                talukaOrderID:talukaOrderId
                                            },
                                            waitMsg:'Loading...'
                                        });
                                        Ext.Msg.alert("Reset", "Order did reset!");
                                    },
                                    failure: function(resp,opt)
                                    {
                                        Ext.Msg.alert("Error", "Error in resetting!");
                                    }
                                });
                            }
                        }
                    });
                }
            }]
        }],
        //  plugins: [new Ext.ux.grid.GridSummary()],
        columns:[new Ext.grid.RowNumberer(),
        {
            header: '<b>Beat Id</b>',
            width:'30',
            sortable: true,
            dataIndex:'beatID',
            align:'center',
            hidden:true
        },
        {
            header: '<b>बीट </b>',
            width:150,
            sortable: true,
            dataIndex:'beatMarathi',
            align:'center',
            summaryType: 'count',
            summaryRenderer: function (v, params, data) 
            {
                params.attr = 'ext:qtip="Total be"'; // summary column tooltip example
                return v? ((v === 0 || v > 1) ? 'एकूण वजन >'  : 'एकूण वजन >') : '';
            }
        },
        {
            header: '<b>तुरदाळ</b>',
            width:90,
            sortable: true,
            dataIndex:'mungdaal',
            align:'center',
            summaryType: 'sum'
        },
        {
            header: '<b>मसूर डाळ</b>',
            width:90,
            sortable: true,
            dataIndex:'matki',
            align:'center',
            summaryType: 'sum'
        },
        {
            header: '<b>हरभरा</b>',
            width:90,
            sortable: true,
            dataIndex:'mung',
            align:'center',
            summaryType: 'sum'
        },
        {
            header: '<b>मटकी</b>',
            width:90,
            sortable: true,
            dataIndex:'masuldaal',
            align:'center',
            summaryType: 'sum'
        },
        {
            header: '<b>चवली</b>',
            width:90,
            sortable: true,
            dataIndex:'chvli',
            align:'center',
            summaryType: 'sum'
        },
        {
            header: '<b>तेल</b>',
            width:90,
            sortable: true,
            dataIndex:'tel',
            align:'center',
            summaryType: 'sum'
        },
        {
            header: '<b>मीठ</b>',
            width:90,
            sortable: true,
            dataIndex:'mith',
            align:'center',
            summaryType: 'sum'
        },
        {
            header: '<b>कांदा लसूण मसाला</b>',
            width:90,
            sortable: true,
            dataIndex:'mirchi',
            align:'center',
            summaryType: 'sum'
        },
        {
            header: '<b>हळद</b>',
            width:90,
            sortable: true,
            dataIndex:'halad',
            align:'center',
            summaryType: 'sum'
        },
        {
            header: '<b>जिरे</b>',
            width:90,
            sortable: true,
            dataIndex:'jire',
            align:'center',
            summaryType: 'sum'
        },
        {
            header: '<b>मोहरी</b>',
            width:90,
            sortable: true,
            dataIndex:'mohari',
            align:'center',
            summaryType: 'sum'
        },
        {
            header: '<b>तांदूळ</b>',
            width:90,
            sortable: true,
            dataIndex:'tandul',
            align:'center',
            summaryType: 'sum'
        }],
        width:700,
        height:500,
        title:'सर्व बीट ऑर्डर',
        iconCls: 'home'
    });
    //End - Creates a grid for Section Master
        
    // Start - Creates a tab panel and adding each grid content to its items to show it on tab panel
    var mainTab = new Ext.TabPanel(
    {
        id: 'main-tab-pane',
        autoTabs: true,
        activeTab:0,
        autoScroll:true,
        frame : true,
        bodyStyle: 'padding:5px;',
        items: [dOrders,tOrders,sOrders,bOrders]//,allBills]
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
    
    openSchoolWin = function(form, Title, ht, width)
    {
        var winTitle = (Title);
        win = new Ext.Window(
        {
            layout:'fit',
            width:width,
            modal: true,
            height:ht,
            iconCls: 'add',
            closeAction:'hide',
            title : winTitle,            
            items :[
            {
                items :[
                {
                    bodyStyle: 'padding:1px;',
                    layout: "fit",
                    autoScroll:true,
                    items : [form]
                }]
            }],
            buttons:[
            {
                text:'Save Order',
                id:'save-order-button',
                iconCls:'save',
                scale:'medium',
                height:'25',
                handler:function()
                {
                    var updatedRecords = form.getStore().getModifiedRecords();
                    if(updatedRecords.length == 0)
                    {
                        Ext.Msg.alert('No changes', 'There are no changes in the orders!');
                        return;
                    }
                    var changedArray = "{'data':[";
                    for(var j=0;j<updatedRecords.length;j++)
                    {
                        var rec = updatedRecords[j];
                        changedArray = changedArray.concat(Ext.util.JSON.encode(rec.data));
                        if(j!==(updatedRecords.length-1))
                        {
                            changedArray = changedArray.concat(',');
                        }
                    }
                    changedArray = changedArray.concat("]}");
                    Ext.Ajax.request(
                    {                        
                        url: 'update/update-taluka-order-details.jsp',
                        method: 'POST',
                        params:
                        {
                            postdata: changedArray,
                            talukaorderID : talukaOrderId,
                            sectionID: sectionID
                        },
                        success: function(resp,opt) 
                        {                            
                            challanFlag = false; 
                            Ext.Msg.alert('Save OrderDetails', 'Taluka order details saved');
                            allSchoolOrderStore.commitChanges();
                            allBeatOrderStore.removeAll();
                            allBeatOrderStore.reload(
                            {
                                params:
                                {
                                    sectionID   :sectionID,
                                    talukaOrderID:talukaOrderId
                                },
                                waitMsg:'Loading...'
                            });
                            win.hide();
                        },
                        failure: function(resp,opt)
                        {
                            Ext.Msg.alert('Error', 'Error in saving !');
                        }
                    });
                }
            }]
        });
        win.show(this);
    };
       
    openSchoolReturnWin = function(form, Title, ht, width)
    {
        var winTitle = (Title);
        win = new Ext.Window(
        {
            layout:'fit',
            width:width,
            modal: true,
            height:ht,
            iconCls: 'add',
            closeAction:'hide',
            title : winTitle,            
            items :[
            {
                items :[
                {
                    bodyStyle: 'padding:1px;',
                    layout: "fit",
                    autoScroll:true,
                    items : [form]
                }]
            }],
            buttons:[
            {
                text:'Save Return',
                id:'save-order-button',
                iconCls:'save',
                scale:'medium',
                height:'25',
                handler:function()
                {
                    var updatedRecords = form.getStore().getModifiedRecords();
                    if(updatedRecords.length == 0)
                    {
                        Ext.Msg.alert('No changes', 'There are no changes in the Return!');
                        return;
                    }
                    var changedArray = "{'data':[";
                    for(var j=0;j<updatedRecords.length;j++)
                    {
                        var rec = updatedRecords[j];     
                        if(rec.data.mungdaal > rec.data.omungdaal)
                    	{
                        	Ext.Msg.alert('Error', rec.data.schoolMarathi + ' शाळेच्या <b>हरभरादाल</b>ची परतीच्या मालाचे वजन (<b>'+rec.data.mungdaal+'</b>) केलेल्या मागणी(<b>'+rec.data.omungdaal+'</b>) पेक्षा जास्त आहे');
                            return;
                    	}
                        if(rec.data.matki > rec.data.omatki)
                    	{
                        	Ext.Msg.alert('Error', rec.data.schoolMarathi + ' शाळेच्या <b>मसूर डाळ</b>ची परतीच्या मालाचे वजन (<b>'+rec.data.matki+'</b>) केलेल्या मागणी(<b>'+rec.data.omatki+'</b>) पेक्षा जास्त आहे');
                            return;
                    	}
                        if(rec.data.mung > rec.data.omung)
                    	{
                        	Ext.Msg.alert('Error', rec.data.schoolMarathi + ' शाळेच्या <b>हरभरा</b>ची परतीच्या मालाचे वजन (<b>'+rec.data.mung+'</b>) केलेल्या मागणी(<b>'+rec.data.omung+'</b>) पेक्षा जास्त आहे');
                            return;
                    	}
                        if(rec.data.masuldaal > rec.data.omasuldaal)
                    	{
                        	Ext.Msg.alert('Error', rec.data.schoolMarathi + ' शाळेच्या <b>मसूरदाल</b>ची परतीच्या मालाचे वजन (<b>'+rec.data.masuldaal+'</b>) केलेल्या मागणी(<b>'+rec.data.omasuldaal+'</b>) पेक्षा जास्त आहे');
                            return;
                    	}
                        if(rec.data.chvli > rec.data.ochvli)
                    	{
                        	Ext.Msg.alert('Error', rec.data.schoolMarathi + ' शाळेच्या <b>चावली</b>ची परतीच्या मालाचे वजन (<b>'+rec.data.chvli+'</b>) केलेल्या मागणी(<b>'+rec.data.ochvli+'</b>) पेक्षा जास्त आहे');
                            return;
                    	}
                        if(rec.data.tel > rec.data.otel)
                    	{
                        	Ext.Msg.alert('Error', rec.data.schoolMarathi + ' शाळेच्या <b>तेल</b>ची परतीच्या मालाचे वजन (<b>'+rec.data.tel+'</b>) केलेल्या मागणी(<b>'+rec.data.otel+'</b>) पेक्षा जास्त आहे');
                            return;
                    	}
                        if(rec.data.mith > rec.data.omith)
                    	{
                        	Ext.Msg.alert('Error', rec.data.schoolMarathi + ' शाळेच्या <b>मीठ</b>ची परतीच्या मालाचे वजन (<b>'+rec.data.mith+'</b>) केलेल्या मागणी(<b>'+rec.data.omith+'</b>) पेक्षा जास्त आहे');
                            return;
                    	}
                        if(rec.data.mirchi > rec.data.omirchi)
                    	{
                        	Ext.Msg.alert('Error', rec.data.schoolMarathi + ' शाळेच्या <b>कांदा लसूण मसाला</b>ची परतीच्या मालाचे वजन (<b>'+rec.data.mirchi+'</b>) केलेल्या मागणी(<b>'+rec.data.omirchi+'</b>) पेक्षा जास्त आहे');
                            return;
                    	}
                        if(rec.data.halad > rec.data.ohalad)
                    	{
                        	Ext.Msg.alert('Error', rec.data.schoolMarathi + ' शाळेच्या <b>हळद</b>ची परतीच्या मालाचे वजन (<b>'+rec.data.halad+'</b>) केलेल्या मागणी(<b>'+rec.data.ohalad+'</b>) पेक्षा जास्त आहे');
                            return;
                    	}
                        if(rec.data.jire > rec.data.ojire)
                    	{
                        	Ext.Msg.alert('Error', rec.data.schoolMarathi + ' शाळेच्या <b>जिरे</b>ची परतीच्या मालाचे वजन (<b>'+rec.data.jire+'</b>) केलेल्या मागणी(<b>'+rec.data.ojire+'</b>) पेक्षा जास्त आहे');
                            return;
                    	}
                        if(rec.data.mohari > rec.data.omohari)
                    	{
                        	Ext.Msg.alert('Error', rec.data.schoolMarathi + ' शाळेच्या <b>मोहरी</b>ची परतीच्या मालाचे वजन (<b>'+rec.data.mohari+'</b>) केलेल्या मागणी(<b>'+rec.data.omohari+'</b>) पेक्षा जास्त आहे');
                            return;
                    	}
                        if(rec.data.tandul > rec.data.otandul)
                    	{
                        	Ext.Msg.alert('Error', rec.data.schoolMarathi + ' शाळेच्या <b>तांदूळ</b>ची परतीच्या मालाचे वजन (<b>'+rec.data.tandul+'</b>) केलेल्या मागणी(<b>'+rec.data.otandul+'</b>) पेक्षा जास्त आहे');
                            return;
                    	}
                        changedArray = changedArray.concat(Ext.util.JSON.encode(rec.data));
                        if(j!==(updatedRecords.length-1))
                        {
                            changedArray = changedArray.concat(',');
                        }
                    }
                    changedArray = changedArray.concat("]}");
                    Ext.Ajax.request(
                    {                        
                        url: 'update/update-taluka-order-return.jsp',
                        method: 'POST',
                        params:
                        {
                            postdata: changedArray,
                            talukaorderID : talukaOrderId,
                            sectionID: sectionID
                        },
                        success: function(resp,opt) 
                        {                            
                            challanFlag = false; 
                            Ext.Msg.alert('Save Return Details', 'Taluka Return details saved');
                            allSchoolOrderStore.commitChanges();
                            allBeatOrderStore.removeAll();
                            allBeatOrderStore.reload(
                            {
                                params:
                                {
                                    sectionID   :sectionID,
                                    talukaOrderID:talukaOrderId
                                },
                                waitMsg:'Loading...'
                            });
                            win.hide();
                        },
                        failure: function(resp,opt)
                        {
                            Ext.Msg.alert('Error', 'Error in saving !');
                        }
                    });
                }
            }]
        });
        win.show(this);
    };

    allTalukaRationBillStore = new Ext.data.JsonStore(
    {
        storeId: 'allTalukaRationBillStore',
        url: 'read/get-all-taluka-ration-bill.jsp',
        root: 'root',
        idProperty : 'invoiceID',
        fields: ['invoiceID','talukaOrderNo','districtMarathi','talukaMarathi','invoiceIDMan','invoiceIDMan1','invoiceIDMan2','invoiceDate','talukaOrderID','totalAmount','totalAmount1','totalAmount2','stdTypeDetails','orderType'],
        sortInfo: 
        {
            field:'invoiceID',
            direction:'DESC'
        }
    });

    allTalukaTandulBillStore = new Ext.data.JsonStore(
	{
        storeId: 'allTalukaTandulBillStore',
        url: 'read/get-all-taluka-tandul-bill.jsp',
        root: 'root',
        idProperty : 'invoiceID',
        fields: ['invoiceID','talukaOrderNo','districtMarathi','talukaMarathi','invoiceIDMan','invoiceIDMan1','invoiceIDMan2','invoiceDate','talukaOrderID','totalAmount','totalAmount1','totalAmount2','stdTypeDetails','orderType'],
        sortInfo: 
        {
            field:'invoiceID',
            direction:'DESC'
        }
    });
    
    //Start - Creates a grid for District Master
    allTalukaTandulBillGrid = new Ext.grid.GridPanel(
    {
        store: allTalukaTandulBillStore,
        id: 'allTalukaTandulBillGrid',
        stripeRows: true,
        loadMask: true,
        columnLines: true,
        stateId: 'allTalukaTandulBillGrid',
        frame : true,
        tbar:[
        {
             text: ' प्रिंट बिल ',
             handler: function()
             {
                var sm = allTalukaTandulBillGrid.getSelectionModel();
                var sel = sm.getSelections();
                if(sel.length == 0)
                {
                    Ext.Msg.alert('Select Bill', 'No Taluka Bill is selected!');
                    return;
                }
                var invoiceID = sel[0].get('invoiceID');
                var param = "invoiceID="+invoiceID;                
                window.open("reports/print-invoice.jsp?"+param,'talukaBill',"width=1500,height=800,top=40,left=60,menubar=1,resizable=0,location=1,scrollbars=1");
            }
        },'->',
        {
            text:'Delete',
            iconCls:'delete',
            handler: function()
            {
            	var sm = allTalukaTandulBillGrid.getSelectionModel();
                var sel = sm.getSelections();
                if(sel == 0){Ext.Msg.alert('Warning','No Bill is selected');return;}
                var invoiceID = sel[0].get('invoiceID');
                var talukaMarathi = sel[0].get('talukaMarathi');
                Ext.MessageBox.show(
                {
                   title: 'Confirm Delete',
                   msg: 'Do you want to delete Bill No.<b>'+invoiceID+'</b>  for Taluka: <b>'+ talukaMarathi + '</b>',
                   buttons: Ext.MessageBox.YESNO,
                   fn: function(btn)
                   {
                       if(btn == "yes")
                       {
                           Ext.Ajax.request(
                           {
                               url: 'delete/delete-taluka-bill.jsp',
                               method:'POST',
                               params:{invoiceID:invoiceID},
                               success: function()
                               {
                                    Ext.Msg.alert("Deleted",'Taluka Bill Deleted');
                                    allTalukaTandulBillStore.reload(
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
                header: '<b>Bill ID</b>',
                width:'80',
                sortable: true,
                align: 'center',
                hidden: true,
                dataIndex:'invoiceID'
            },
            {
                header: '<b>Kendra Bill No.</b>',
                width:'60',
                sortable: true,
                align: 'center',
                dataIndex:'invoiceIDMan1'
            },
            {
                header: '<b>State Bill No.</b>',
                width:'60',
                sortable: true,
                align: 'center',
                dataIndex:'invoiceIDMan2'
            },
            {
                header: '<b>District Name</b>',
                width:'60',
                sortable: true,
                align: 'center',
                dataIndex:'districtMarathi'
            },
            {
                header: '<b>Taluka Name</b>',
                width:'80',
                sortable: true,
                align: 'center',
                dataIndex:'talukaMarathi'
            },
            {
                header: '<b>Taluka Order No.</b>',
                width:110,
                sortable: true,
                align: 'center',
                dataIndex:'talukaOrderNo'
            },
            {
                header: '<b>Bill Date</b>',
                width:80,
                sortable: true,
                align: 'center',
                dataIndex:'invoiceDate'
            },
            {
                header: '<b>Kendra Bill Amount</b>',
                width:'150',
                sortable: true,
                align: 'center',
                dataIndex:'totalAmount1'
            },
            {
                header: '<b>State Bill Amount</b>',
                width:'150',
                sortable: true,
                align: 'center',
                dataIndex:'totalAmount2'
            },
            {
                header: '<b>STD Group</b>',
                width:'60',
                sortable: true,
                align: 'center',
                dataIndex:'stdTypeDetails'
            }
        ],
        width:750,
        height:500,
        bbar:new Ext.PagingToolbar(
        {
            pageSize: 100,
            store: allTalukaTandulBillStore,
            displayInfo: true,
            displayMsg: 'Displaying results {0} - {1} of {2}',
            emptyMsg: "No results to display"
        })
    });
    //End - Creates a grid for District Master
        
    //Start - Creates a grid for District Master
    allTalukaRationBillGrid = new Ext.grid.GridPanel(
    {
        store: allTalukaRationBillStore,
        id: 'allTalukaRationBillGrid',
        stripeRows: true,
        loadMask: true,
        columnLines: true,
        stateId: 'allTalukaRationBillGrid',
        frame : true,
        tbar:[
        {
             text: ' प्रिंट बिल ',
             handler: function()
             {
                var sm = allTalukaRationBillGrid.getSelectionModel();
                var sel = sm.getSelections();
                if(sel.length == 0)
                {
                    Ext.Msg.alert('Select Bill', 'No Taluka Bill is selected!');
                    return;
                }
                var invoiceID = sel[0].get('invoiceID');
                var param = "invoiceID="+invoiceID;                
                window.open("reports/print-invoice.jsp?"+param,'talukaBill',"width=1500,height=800,top=40,left=60,menubar=1,resizable=0,location=1,scrollbars=1");
            }
        },'->',
        {
            text:'Delete',
            iconCls:'delete',
            handler: function()
            {
            	var sm = allTalukaRationBillGrid.getSelectionModel();
                var sel = sm.getSelections();
                if(sel == 0){Ext.Msg.alert('Warning','No Bill is selected');return;}
                var invoiceID = sel[0].get('invoiceID');
                var talukaMarathi = sel[0].get('talukaMarathi');
                Ext.MessageBox.show(
                {
                   title: 'Confirm Delete',
                   msg: 'Do you want to delete Bill No.<b>'+invoiceID+'</b>  for Taluka: <b>'+ talukaMarathi + '</b>',
                   buttons: Ext.MessageBox.YESNO,
                   fn: function(btn)
                   {
                       if(btn == "yes")
                       {
                           Ext.Ajax.request(
                           {
                               url: 'delete/delete-taluka-bill.jsp',
                               method:'POST',
                               params:{invoiceID:invoiceID},
                               success: function()
                               {
                                    Ext.Msg.alert("Deleted",'Taluka Bill Deleted');
                                    allTalukaRationBillStore.reload(
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
                header: '<b>Bill ID</b>',
                width:'80',
                sortable: true,
                align: 'center',
                hidden: true,
                dataIndex:'invoiceID'
            },
            {
                header: '<b>Bill No.</b>',
                width:'80',
                sortable: true,
                align: 'center',
                dataIndex:'invoiceIDMan'
            },
            {
                header: '<b>District Name</b>',
                width:'80',
                sortable: true,
                align: 'center',
                dataIndex:'districtMarathi'
            },
            {
                header: '<b>Taluka Name</b>',
                width:'80',
                sortable: true,
                align: 'center',
                dataIndex:'talukaMarathi'
            },
            {
                header: '<b>Taluka Order No.</b>',
                width:120,
                sortable: true,
                align: 'center',
                dataIndex:'talukaOrderNo'
            },
            {
                header: '<b>Bill Date</b>',
                width:150,
                sortable: true,
                align: 'center',
                dataIndex:'invoiceDate'
            },
            {
                header: '<b>Bill Amount</b>',
                width:'80',
                sortable: true,
                align: 'center',
                dataIndex:'totalAmount'
            },
            {
                header: '<b>STD Group</b>',
                width:'80',
                sortable: true,
                align: 'center',
                dataIndex:'stdTypeDetails'
            }
        ],
        width:750,
        height:500,
        bbar:new Ext.PagingToolbar(
        {
            pageSize: 100,
            store: allTalukaRationBillStore,
            displayInfo: true,
            displayMsg: 'Displaying results {0} - {1} of {2}',
            emptyMsg: "No results to display"
        })
    });
    //End - Creates a grid for District Master
    
    openAllBillWin =  function ()
	{
        //reportCriteria.getForm().reset();
        var win = new Ext.Window(
        {
            layout			:	'fit',
            width			:	1000,
            plain			:	true,
            modal			: 	true, 
            resizable 		: 	false,
            height 			: 	460,
            iconCls			: 	'report', 
            closeAction		:	'hide',
            title 			: 	"All Bill",
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
                     		title 			: 	'District Bill',	
                     		layout			: 	'fit',	
                     		items 			:	[] 
                     	},
                        {
                     		title 			: 	'Taluka Bill Ration',		
                     		layout			:	'fit', 	
                     		items 			:	 [allTalukaRationBillGrid] 
                     	},
                        {
                     		title 			: 	'Taluka Bill Tandul',		
                     		layout			:	'fit', 	
                     		items 			:	 [allTalukaTandulBillGrid] 
                     	},
                        {	
                     		title 			: 	'Sales Bill',
                     		layout			: 	'fit', 	
                     		items 			: 	[]
                     	}]
                    }]
                }]
            }]
        });
        //addSectionForm.getForm().reset();
        win.show(this);
    };
    
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
                allowBlank: false,
                width: 150,
                editable: false,
                emptyText: 'Preview(DD/MM/YY)'
            }]
        });
        return panel;
    }

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

    getBillDatePreviewWin = function () 
    {
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
    
    getBillDatePreviewWin = function () 
    {
        //Window for adding data to the grid
        if (Ext.type(billDatePreviewWin)) 
        {
            return billDatePreviewWin;
        }
        billDatePreviewWin = new Ext.Window(
        {
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
});
    




