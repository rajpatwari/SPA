/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

 //Start - openWin function to open small window
 openWin = function(form, Title, ht, width)
 {
    var winTitle = ("Enter " +Title );    
    var win = new Ext.Window(
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
                    items:[form]
                }
            ]
        }]
    });
    win.show(this);
};
//End - openWin function to open small window


//Start - openEdit function to open window to edit data
openEdit = function(form, Title, ht,width)
{
    var tit = ("Edit " +Title );    
    var win = new Ext.Window(
    {
        layout:'fit',
        width:width,
        modal: true,
        height:ht,
        iconCls: 'edit',
        closeAction:'hide',
        title : tit,
        plain: true,
        items : [
        {
            layout :"border",
            items :[{
                    region:"center",
                    layout:'fit',
                    items:[form]
                }
            ]
        }]
    });

    win.show(this);
};
//End - openEdit function to open window to edit data

// Start OpenMove form
 openMove = function(cForm,Title,ht,width)
 {
    var tit = 'Move' + Title;
    var win = new Ext.Window(
    {
        layout:'fit',
        width:width,
        modal: true,
        height:ht,
        iconCls: 'move',
        closeAction:'hide',
        title : tit,
        plain: true,
        items : [
        {
            layout :"border",
            items :[{
                    region:"center",
                    layout:'fit',
                    items:[cForm]
                }
            ]
        }]
    });
    win.show(this);
};
// End Open Move form

// Start Open Filter form
 openFilter = function(cForm,Title,ht,width)
 {
    var tit = 'Filter ' + Title;
    var win = new Ext.Window(
    {
        layout:'fit',
        width:width,
        modal: true,
        height:ht,
        iconCls: 'filter',
        closeAction:'hide',
        title : tit,
        plain: true,
        items : [
        {
            layout :"border",
            items :[{
                    region:"center",
                    layout:'fit',
                    items:[cForm]
                }
            ]
        }]
    });
    win.show(this);
}
// End Open Filter form

openGridWin = function(cForm,Title,ht,width)
{
    var  win = new Ext.Window(
    {
        layout:'fit',
        width:width,
        modal: true,
        height:ht,
        iconCls: 'add',
        closeAction:'hide',
        title : Title,
        buttonAlign: 'center',
        plain: true,
        items : [
        {
            layout :"border",
            items :[
            {
                region:"center",
                bodyStyle: 'padding:0px;',
                layout: "fit",
                height:350,
                items:[cForm]
            }]
        }],
        buttons: 
        [{
            text: 'Add Items To Category',
            scale: 'medium',
            id : 'add-item-button'
        }]
    });
    win.show(this);
};
