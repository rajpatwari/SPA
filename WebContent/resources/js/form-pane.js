/*!
 * Ext JS Library 3.1.1
 * Copyright(c) 2006-2010 Ext JS, LLC
 * licensing@extjs.com
 * http://www.extjs.com/license
 */
var buStr;

Ext.onReady(function() {

	Ext.QuickTips.init();

	// turn on validation errors beside the field globally
		Ext.form.Field.prototype.msgTarget = 'side';

		var bd = Ext.getBody();

		/*
		 * ================  Simple form  =======================
		 */
		//    bd.createChild({tag: 'h2', html: 'Form 1 - Very Simple'});
		str = new Ext.data.ArrayStore( {
			url : 'get-uom.jsp',
			autoLoad : true,
			storeId : 'uomStr',
			fields : [ 'key', 'value' ]
		});

		buStr = new Ext.data.ArrayStore( {
			url : 'get-bu.jsp',
			autoLoad : true,
			fields : [ 'key', 'value' ]
		});

		btIdStr = new Ext.data.ArrayStore( {
			url : 'get-btid.jsp',
			autoLoad : true,
			fields : [ 'key', 'value' ]
		});

		bsIdStr = new Ext.data.ArrayStore( {
			url : 'get-bsid.jsp',
			autoLoad : true,
			fields : [ 'key', 'value' ]
		});
		
		
		ltpStr = new Ext.data.ArrayStore( {
			url : 'get-ltp.jsp',
			autoLoad : true,
			fields : [ 'key', 'value' ]
		});

		var simple = new Ext.FormPanel( {
			labelWidth : 100, // label settings here cascade unless overridden
			url : 'save-form.jsp',
			frame : true,
			title : 'People form (* fields are required)',
			bodyStyle : 'padding:5px 5px 0;align:center',
			width : 400,
			renderTo : 'formPane',
			defaults : {
				width : 230
			},
			defaultType : 'textfield',

			items : [ new Ext.form.ComboBox( {
				fieldLabel : 'Business Unit*',
				hiddenName : 'businessunit',
				allowBlank : false,
				store : buStr,
				editable : false,
				displayField : "value",
				valueField : "key",
				//typeAhead: true,
				mode : 'local',
				triggerAction : 'all',
				emptyText : 'Select a BU',
				selectOnFocus : true,
				width : 190
			}), {
				fieldLabel : 'Invoice*',
				name : 'invoice',
				allowBlank : false
			}, new Ext.form.ComboBox( {
				fieldLabel : 'Bill Type Id*',
				hiddenName : 'billtypeid',
				allowBlank : false,
				store : btIdStr,
				editable : false,
				displayField : "value",
				valueField : "key",
				//typeAhead: true,
				mode : 'local',
				triggerAction : 'all',
				emptyText : 'Select a B Type Id',
				selectOnFocus : true,
				width : 190
			}), new Ext.form.ComboBox( {
				fieldLabel : 'Bill Source Id*',
				hiddenName : 'billsourceid',
				allowBlank : false,
				store : bsIdStr,
				editable : false,
				displayField : "value",
				valueField : "key",
				//typeAhead: true,
				mode : 'local',
				triggerAction : 'all',
				emptyText : 'Select a B Source Id',
				selectOnFocus : true,
				width : 190
			}), {
				fieldLabel : 'Bill To Cust Id*',
				name : 'billtocustid',
				allowBlank : false
			}, new Ext.form.ComboBox( {
				fieldLabel : 'Line Type',
				hiddenName : 'linetype',
				allowBlank : false,
				store : ltpStr,
				editable : true,
				displayField : "value",
				valueField : "key",
				typeAhead: true,
				mode : 'local',
				triggerAction : 'all',
				emptyText : 'Select a line type',
				selectOnFocus : true,
				width : 190
			}), {
				fieldLabel : 'Description',
				name : 'descr'
			}, new Ext.form.ComboBox( {
				fieldLabel : 'Unit Of Measure',
				hiddenName : 'unitofmeasure',
				store : str,
				editable : false,
				displayField : "value",
				valueField : "key",
				//typeAhead: true,
				mode : 'local',
				triggerAction : 'all',
				emptyText : 'Select a UOM',
				selectOnFocus : true,
				width : 190
			}), {
				fieldLabel : 'Quantity',
				name : 'qty'
			}, {
				fieldLabel : 'Unit Amount',
				name : 'unitamt'
			}

			],

			buttons : [ {
				text : 'Save',
				handler : function() {
					// when this button clicked, sumbit this form				
				simple.getForm().submit( {
					waitMsg : 'Sending data to Peoplesoft system', // Wait Message				
					success : function() { // When saving data success
						Ext.MessageBox.alert('Message', 'Data has been saved to the Peoplesoft system');
						// clear the form							
					},
					failure : function() { // when saving data failed
						Ext.MessageBox.alert('Message', 'Peoplesoft rejected data');
					}
				});

			}
			}, {
				text : 'Reset',
				handler : function() {
					// when this button clicked, reset this form
				simple.getForm().reset();
			}
			} ]

		});

		//simple.render(document.body);
	});