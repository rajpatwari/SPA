/*!
 * Ext JS Library 3.1.1
 * Copyright(c) 2006-2010 Ext JS, LLC
 * licensing@extjs.com
 * http://www.extjs.com/license
 */

Ext.onReady(function() {
	Ext.QuickTips.init();
	
	fetchStore = new Ext.data.JsonStore( {
		autoDestroy : true,
		storeId : 'fetchStore',
		url : 'get-allbu.jsp',
		fields : [ {
			name : 'BUSINESS_UNIT'
		}, {
			name : 'INVOICE'
		}, {
			name : 'BILL_TO_CUST_ID'
		}, {
			name : 'BILL_STATUS'
		}, {
			name : 'BUS_UNIT_BIALTSRCH'
		}, {
			name : 'CONTRACT_NUM'
		}, {
			name : 'TEMPLATE_IVC_FLG'
		} ]
	});
	
	
	/*---------- Tool Bar Code ---------------*/

	var store = new Ext.data.ArrayStore( {
		fields : [ 'abbr', 'state' ]
	// , data : Ext.exampledata.states // from states.js
			});

	var tb = new Ext.Toolbar();
	tb.setWidth(900);
	tb.render('toolbar');

	// add a combobox to the toolbar
		var combo = new Ext.form.ComboBox( {
			store : buStr,
			displayField : "value",
			valueField : "key",
			mode : 'local',
			triggerAction : 'all',
			emptyText : 'Select a Business Unit',
			selectOnFocus : true,
			width : 200,
			listeners : {
				'select' : function (combo,record,index) {
					fetchStore.load({params:{bu:record.data.key}});					
				}
			}

		});
		tb.addField(combo);
		tb.addField( {

		});

		tb.doLayout();

		// functions to display feedback
		function onButtonClick(btn) {
			Ext.example.msg('Button Click', 'You clicked the "{0}" button.',
					btn.text);
		}

		/*-----------------Grid Code ----------------------*/

		/**
		 * Custom function used for column renderer
		 * 
		 * @param {Object}
		 *            val
		 */
		function change(val) {
			if (val > 0) {
				return '<span style="color:green;">' + val + '</span>';
			} else if (val < 0) {
				return '<span style="color:red;">' + val + '</span>';
			}
			return val;
		}

		/**
		 * Custom function used for column renderer
		 * 
		 * @param {Object}
		 *            val
		 */
		function pctChange(val) {
			if (val > 0) {
				return '<span style="color:green;">' + val + '%</span>';
			} else if (val < 0) {
				return '<span style="color:red;">' + val + '%</span>';
			}
			return val;
		}
		// var gridData
		// ={'rt':[{'BILL_STATUS':'NEW','BILL_TO_CUST_ID':'1001111','BUSINESS_UNIT':'CLINF','BUS_UNIT_BIALTSRCH':'CLINF','CONTRACT_NUM':'','INVOICE':'220554','TEMPLATE_IVC_FLG':'N','class':'com.oracle.xmlns.Enterprise.Tools.schemas.M513677_V1.FO_BI_ENTRYTypeShape'},{'BILL_STATUS':'NEW','BILL_TO_CUST_ID':'1001111','BUSINESS_UNIT':'CLINF','BUS_UNIT_BIALTSRCH':'CLINF','CONTRACT_NUM':'','INVOICE':'220549','TEMPLATE_IVC_FLG':'N','class':'com.oracle.xmlns.Enterprise.Tools.schemas.M513677_V1.FO_BI_ENTRYTypeShape'},{'BILL_STATUS':'NEW','BILL_TO_CUST_ID':'1001005','BUSINESS_UNIT':'CLINF','BUS_UNIT_BIALTSRCH':'CLINF','CONTRACT_NUM':'','INVOICE':'220548','TEMPLATE_IVC_FLG':'N','class':'com.oracle.xmlns.Enterprise.Tools.schemas.M513677_V1.FO_BI_ENTRYTypeShape'},{'BILL_STATUS':'NEW','BILL_TO_CUST_ID':'1001004','BUSINESS_UNIT':'CLINF','BUS_UNIT_BIALTSRCH':'CLINF','CONTRACT_NUM':'','INVOICE':'220547','TEMPLATE_IVC_FLG':'N','class':'com.oracle.xmlns.Enterprise.Tools.schemas.M513677_V1.FO_BI_ENTRYTypeShape'},{'BILL_STATUS':'NEW','BILL_TO_CUST_ID':'1001019','BUSINESS_UNIT':'CLINF','BUS_UNIT_BIALTSRCH':'CLINF','CONTRACT_NUM':'','INVOICE':'220546','TEMPLATE_IVC_FLG':'N','class':'com.oracle.xmlns.Enterprise.Tools.schemas.M513677_V1.FO_BI_ENTRYTypeShape'},{'BILL_STATUS':'NEW','BILL_TO_CUST_ID':'1001008','BUSINESS_UNIT':'CLINF','BUS_UNIT_BIALTSRCH':'CLINF','CONTRACT_NUM':'','INVOICE':'220545','TEMPLATE_IVC_FLG':'N','class':'com.oracle.xmlns.Enterprise.Tools.schemas.M513677_V1.FO_BI_ENTRYTypeShape'},{'BILL_STATUS':'NEW','BILL_TO_CUST_ID':'1001001','BUSINESS_UNIT':'CLINF','BUS_UNIT_BIALTSRCH':'CLINF','CONTRACT_NUM':'','INVOICE':'220544','TEMPLATE_IVC_FLG':'N','class':'com.oracle.xmlns.Enterprise.Tools.schemas.M513677_V1.FO_BI_ENTRYTypeShape'},{'BILL_STATUS':'NEW','BILL_TO_CUST_ID':'1001005','BUSINESS_UNIT':'CLINF','BUS_UNIT_BIALTSRCH':'CLINF','CONTRACT_NUM':'','INVOICE':'220543','TEMPLATE_IVC_FLG':'N','class':'com.oracle.xmlns.Enterprise.Tools.schemas.M513677_V1.FO_BI_ENTRYTypeShape'},{'BILL_STATUS':'NEW','BILL_TO_CUST_ID':'1001005','BUSINESS_UNIT':'CLINF','BUS_UNIT_BIALTSRCH':'CLINF','CONTRACT_NUM':'','INVOICE':'220542','TEMPLATE_IVC_FLG':'N','class':'com.oracle.xmlns.Enterprise.Tools.schemas.M513677_V1.FO_BI_ENTRYTypeShape'},{'BILL_STATUS':'NEW','BILL_TO_CUST_ID':'1001005','BUSINESS_UNIT':'CLINF','BUS_UNIT_BIALTSRCH':'CLINF','CONTRACT_NUM':'','INVOICE':'220541','TEMPLATE_IVC_FLG':'N','class':'com.oracle.xmlns.Enterprise.Tools.schemas.M513677_V1.FO_BI_ENTRYTypeShape'},{'BILL_STATUS':'NEW','BILL_TO_CUST_ID':'1001005','BUSINESS_UNIT':'CLINF','BUS_UNIT_BIALTSRCH':'CLINF','CONTRACT_NUM':'','INVOICE':'220540','TEMPLATE_IVC_FLG':'N','class':'com.oracle.xmlns.Enterprise.Tools.schemas.M513677_V1.FO_BI_ENTRYTypeShape'},{'BILL_STATUS':'NEW','BILL_TO_CUST_ID':'1001005','BUSINESS_UNIT':'CLINF','BUS_UNIT_BIALTSRCH':'CLINF','CONTRACT_NUM':'','INVOICE':'220534','TEMPLATE_IVC_FLG':'N','class':'com.oracle.xmlns.Enterprise.Tools.schemas.M513677_V1.FO_BI_ENTRYTypeShape'},{'BILL_STATUS':'NEW','BILL_TO_CUST_ID':'1001005','BUSINESS_UNIT':'CLINF','BUS_UNIT_BIALTSRCH':'CLINF','CONTRACT_NUM':'','INVOICE':'220524','TEMPLATE_IVC_FLG':'N','class':'com.oracle.xmlns.Enterprise.Tools.schemas.M513677_V1.FO_BI_ENTRYTypeShape'},{'BILL_STATUS':'NEW','BILL_TO_CUST_ID':'1001005','BUSINESS_UNIT':'CLINF','BUS_UNIT_BIALTSRCH':'CLINF','CONTRACT_NUM':'','INVOICE':'220514','TEMPLATE_IVC_FLG':'N','class':'com.oracle.xmlns.Enterprise.Tools.schemas.M513677_V1.FO_BI_ENTRYTypeShape'},{'BILL_STATUS':'NEW','BILL_TO_CUST_ID':'1001005','BUSINESS_UNIT':'CLINF','BUS_UNIT_BIALTSRCH':'CLINF','CONTRACT_NUM':'','INVOICE':'220504','TEMPLATE_IVC_FLG':'N','class':'com.oracle.xmlns.Enterprise.Tools.schemas.M513677_V1.FO_BI_ENTRYTypeShape'}]};
				// create the data store
				// manually load local data
		//fetchStore.loadData({params:{start:0, limit:25}});

		// create the Grid
		var grid = new Ext.grid.GridPanel( {
			store : fetchStore,
			loadMask:true,
			columns : [ /*{
				header : 'Businesss Unit',
				width : 100,
				sortable : true,
				dataIndex : 'BUSINESS_UNIT'
			},*/ {
				header : 'Invoice',
				width : 90,
				sortable : true,
				dataIndex : 'INVOICE'
			}, {
				header : 'Bill To Cust ID',
				width : 90,
				sortable : true,
				renderer : change,
				dataIndex : 'BILL_TO_CUST_ID'
			}, {
				header : 'Bill Status',
				width : 75,
				sortable : true,
				renderer : pctChange,
				dataIndex : 'BILL_STATUS'
			}, {
				header : 'Business Unit BIALTSRCH',
				width : 140,
				sortable : true,
				renderer : pctChange,
				dataIndex : 'BUS_UNIT_BIALTSRCH'
			}, {
				header : 'Contract Number',
				width : 90,
				sortable : true,
				renderer : pctChange,
				dataIndex : 'CONTRACT_NUM'
			}, {
				header : 'Template IVC flag',
				width : 130,
				sortable : true,
				renderer : pctChange,
				dataIndex : 'TEMPLATE_IVC_FLG'
			} ],
			// stripeRows: true,
			//autoExpandColumn: 'INVOICE',
			height : 500,
			width : 900,
			// title: 'Array Grid',
			// config options for stateful behavior
			stateful : true
		//stateId: 'grid'        
				});

		// render the grid to the specified div in the page
		grid.render('gridPane');

	});