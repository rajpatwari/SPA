var buStr;
Ext.onReady(function() {
    // turn on validation errors beside the field globally
    Ext.form.Field.prototype.msgTarget = 'side';
    var bd = Ext.getBody();

    var hops = new Ext.data.ArrayStore( {
        url : 'get-hosplist.jsp',
        autoLoad : true,
        fields : [ 'key', 'value' ]
    });   
    var simple = new Ext.FormPanel(
    {
        labelWidth : 70, // label settings here cascade unless
        // overridden
        url : 'loginsubmit.jsp',
        id : 'form',
        standardSubmit : true,
        frame : true,
        title : 'Order Module Login',
        bodyStyle : 'padding:5px 5px 0;align:center',
        width : 300,
        renderTo : 'formPane',
        defaults : {
            width : 170
        },
        defaultType : 'textfield',

        items : [ {
            fieldLabel : 'Username',
            name : 'username',
            allowBlank : false,
            maxLength : 60
        }, {
            fieldLabel : 'Password',
            name : 'password',
            allowBlank : false,
            inputType : 'password',
            maxLength : 60
        } ],

        buttons : [ {
            text : 'Sign In',
            handler : function() {
                // when this button clicked, sumbit this form
                simple
                .getForm()
                .submit();
            }
        } ]
    });
});