/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

// This is file to have master menu.
 
 
 

// This is Dashboard Page west panel Menu
getWestDashboard = function () 
{
    var panel = new Ext.Panel(
    {
        id:'container',
        frame : true,
        items:[
        {
            xtype : 'button',
            text : '<b>Master</b>', // Label
            scale : 'medium',
            height:50,
            style: 'padding:7px',
            width: 200,
            handler: function()
            {
                window.location = 'master.jsp';  //call Master file
            }
        },
        {
            xtype : 'button',
            text : '<b>Inward</b>',
            scale : 'medium',
            height:50,
            style: 'padding:7px',
            width: 200,
            handler: function()
            {
                window.location = 'inward.jsp';
            }
        },
        {
            xtype : 'button',
            text : '<b>Orders</b>',
            scale : 'medium',
            height:50,
            style: 'padding:7px',
            width: 200,
            handler: function()
            {
                window.location = 'orders.jsp';
            }
        },        
        {
            xtype : 'button',
            text : '<b>Dispatch</b>',
            scale : 'medium',
            height:50,
            style: 'padding:7px',
            width: 200,
            handler: function()
            {
                window.location = 'dispatch.jsp';
            }
        },
        {
            xtype 		: 	'button',
            text 		: 	'<b>Stock</b>',
            scale 		: 	'medium',
            height		:	50,
            style		: 	'padding:7px',
            width		: 	200,
            handler		: 	function()
            {
                window.location = 'stock.jsp';
            }
        },
        {
            xtype : 'button',
            text : '<b>Reports</b>',
            scale : 'medium',
            height:50,
            style: 'padding:7px',
            width: 200,
            handler: function()
            {
                window.location = 'reports.jsp';
            }
        }]
    });
    return panel;
};


 
 
 getWestPanel = function () 
 {
    var panel = new Ext.Panel(
    {
        id:'container',
        frame : true,
        items:[
        {
            xtype : 'button',
            text : '<b>District Master</b>',
            scale : 'medium',
            id:'district',
            name:'district',
            height:50,
            style: 'padding:7px',
            width: 200,
            handler: function()
            {
                window.location = 'district_master.jsp';
            }
        },
        {
            xtype : 'button',
            text : '<b>Supplier Master</b>',
            scale : 'medium',
            height:50,
            style: 'padding:7px',
            id:'vendor',
            name:'vendor',
            width: 200,
            handler: function(){
                window.location = 'supplier-master.jsp';
               // cls: 'item';
            }
        },
        {
            xtype : 'button',
            text : '<b>Route Master</b>',
            scale : 'medium',
            height:50,
            style: 'padding:7px',
            id:'root',
            name:'root',
            width: 200,
            handler: function()
            {
                window.location = 'root_master.jsp';
               // cls: 'item';
            }
        }]
    });
    return panel;
};

// This is order modules west panel

getWestOrderPanel = function () 
{
    var panel = new Ext.Panel(
    {
        id:'container',
        frame : true,
        items:[
        {            
        }]
    });
    return panel;
};


getWestDispatch = function () 
{
    var panel = new Ext.Panel(
    {
        id:'container',
        height : 590,
        width : 100,
        frame : true,
        items:[
        {
            scale : 'medium',
            id:'dispatch',
            name:'dispatch',
            height:50,
            style: 'padding:7px',
            width: 100
        }]
    });
    return panel;
};

getWestInwardPanel = function ()
{
    var panel = new Ext.Panel(
    {
        id:'container',
        frame : true,
        items:[
        {
            xtype : 'button',
            text : '<b>Inward Details</b>',
            scale : 'medium',
            id:'Inward',
            name:'Inward',
            height:50,
            style: 'padding:7px',
            width: 200,
            handler: function()
            {
                window.location = 'inward.jsp';
            }
        },
        {
            xtype : 'button',
            text : '<b>Set Open Stock</b>',
            scale : 'medium',
            id:'openStock',
            name:'openStock',
            height:50,
            style: 'padding:7px',
            width: 200,
            handler: function()
            {
                window.location = 'open-stock.jsp';
            }
        },
        {
            xtype : 'button',
            text : '<b>Godown To Godown Transfer</b>',
            scale : 'medium',
            id:'transfer',
            name:'transfer',
            height:50,
            style: 'padding:7px',
            width: 200,
            handler: function()
            {
                window.location = 'g2gTransfer.jsp';
            }
        }]
    });
    return panel;
};
getWestopeningStockPanel = function ()
{
    var panel = new Ext.Panel(
    {
        id:'container',
        frame : true,
        items:[
        {
            xtype : 'button',
            text : '<b>Inward Details</b>',
            scale : 'medium',
            id:'Inward',
            name:'Inward',
            height:50,
            style: 'padding:7px',
            width: 200,
            handler: function()
            {
                window.location = 'inward.jsp';
            }
        },
        {
            xtype : 'button',
            text : '<b>Set Open Stock</b>',
            scale : 'medium',
            id:'openStock',
            name:'openStock',
            height:50,
            style: 'padding:7px',
            width: 200,
            handler: function()
            {
                window.location = 'open-stock.jsp';
            }
        },
        {
            xtype : 'button',
            text : '<b>Godown To Godown Transfer</b>',
            scale : 'medium',
            id:'transfer',
            name:'transfer',
            height:50,
            style: 'padding:7px',
            width: 200,
            handler: function()
            {
                window.location = 'g2gTransfer.jsp';
            }
        }]
    });
    return panel;
};





