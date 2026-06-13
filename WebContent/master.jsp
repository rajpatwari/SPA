<%@page import="org.spa.ds.UserDS"%>
<%@page import="org.spa.entity.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<%

            User user = (User) session.getAttribute("user");
            if (user == null) {
%>
<jsp:forward page="index.jsp"></jsp:forward>
<%}%>
<html>
    <head>

        <link rel="stylesheet" type="text/css"
              href="./resources/css/ext-all.css" />

        <link rel="stylesheet" type="text/css"
              href="./resources/ux/css/gridsummary.css" />
        <!-- Comment below tag for default theme
        <link id="theme" rel="stylesheet" type="text/css"
	href="./resources/css/xtheme-gray.css"> -->

        <!-- Uncomment below tag for access theme -->
        <!-- <link id="theme" rel="stylesheet" type="text/css"
	href="./resources/css/xtheme-access.css"> -->

        <!-- No CSS -->
        <!-- <link id="theme" rel="stylesheet" type="text/css"
	href="./resources/css/ext-all-notheme.css"> -->

        <style type="text/css">
            html,body {
                font: normal 12px verdana;
                margin: 0;
                padding: 0;
                border: 0 none;
                overflow: hidden;
                height: 100%;
            }
            p {
                padding: 5px 5px 5px 20px;
            }
            .settings {
                background-image: url(./resources/images/icons/fam/application_go.png);
                border: 0
            }
            .nav {
                background-image: url(./resources/images/icons/fam/grid.png);
                border: 0
            }
            #main-panel td {
                padding: 5px;
            }

            .home {
                background-image: url(./resources/images/icons/Home.gif) !important;
            }
            .add {
                background-image: url(./resources/images/icons/fam/add.gif) !important;
            }



            .printer {
                background-image: url(./resources/images/icons/fam/printer.png) !important;
            }
            .arrow_out {
                background-image: url(./resources/images/icons/fam/arrow_out.png) !important;
            }

            .printerall {
                background-image: url(./resources/images/icons/fam/printer_add.png) !important;
            }
            .edit{
                background-image: url(./resources/images/icons/fam/application_form_edit.png) !important;
            }
            .showall{
                background-image: url(./resources/images/icons/fam/application_view_tile.png) !important;
            }

            .report{
                background-image: url(./resources/images/icons/fam/report.png) !important;
            }
            .challans{
                background-image: url(./resources/images/icons/fam/layers.png) !important;
            }
            .bill{
                background-image: url(./resources/images/icons/fam/pencil.png) !important;
            }
            .fill{
                background-image: url(./resources/images/icons/fam/table_edit.png) !important;
            }

            .delete {
                background-image: url(./resources/images/icons/fam/delete.gif) !important;
            }
            .move {
                background-image: url(./resources/images/icons/fam/transmit.png) !important;
            }
            .inv {
                background-image: url(./resources/images/icons/topic.gif) !important;
            }
            .indetail {
                background-image: url(./resources/images/icons/details.gif) !important;
            }
            .copy {
                background-image: url(./resources/images/icons/fam/file_copy.png) !important;
            }

            .x-grid3-summary-row {
                border-left:1px solid #fff;
                border-right:1px solid #fff;
                color:#333;
                background: #f1f2f4;
            }
            .x-grid3-summary-row .x-grid3-cell-inner {
                font-weight:bold;
                padding-bottom:4px;
            }
            .x-grid3-cell-first .x-grid3-cell-inner {
                padding-left:16px;
            }
            .x-grid-hide-summary .x-grid3-summary-row {
                display:none;
            }
            .x-grid3-summary-msg {
                padding:4px 16px;
                font-weight:bold;
            }


            .x-grid3-cell-inner {
                font-family:"segoe ui",tahoma, arial, sans-serif;
            }
            .x-grid-group-hd div {
                font-family:"segoe ui",tahoma, arial, sans-serif;
            }
            .x-grid3-hd-inner {
                font-family:"segoe ui",tahoma, arial, sans-serif;
                font-size:12px;
            }
            .x-grid3-body .x-grid3-td-cost {
                background-color:#f1f2f4;
            }
            .x-grid3-summary-row .x-grid3-td-cost {
                background-color:#e1e2e4;
            }
            .icon-grid {
                background-image:url(../shared/icons/fam/grid.png) !important;
            }
            .x-grid3-dirty-cell {
                background-image:none;
            }

        </style>
        <!-- LIBS -->
        <script type="text/javascript" src="./resources/adapter/ext/ext-base.js"></script>
        <!-- ENDLIBS -->

        <script type="text/javascript" src="./resources/js/ext-all.js"></script>
        <script type="text/javascript" src="./resources/js/CheckColumn.js"></script>


        <!-- EXAMPLES -->
        <script type="text/javascript" src="./resources/js/examples.js"></script>
        <script type="text/javascript">    
            Ext.BLANK_IMAGE_URL = './resources/images/default/s.gif';
        </script>
        <script type="text/javascript" src="./resources/ux/gridsummary.js"></script>
        <script type="text/javascript" src="./resources/ux/groupsummary.js"></script>       
        <!--<script type="text/javascript" src="./resources/js/portal/home.js"></script>-->
        <script type="text/javascript" src="JS/master_menu.js"></script>

        <script type="text/javascript">
            Ext.onReady(function()
            {
                var viewport = new Ext.Viewport ({
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
                    frame : true
                }]
             }); 
           });
        </script>
    </head>
    <body>
        <div id="el1" style="padding: 10px;" class="x-hide-display">
            <img alt="SHALEY POSHAN AHAR SOFTWARE SYSTEM" src="resources/images/s.png" id="sys" style="font-size:25px;font-weight:bold;color:#222297;">
           <a href="logout.jsp"> <img alt="" align="right" src="./resources/images/signout.png"></a>&nbsp;&nbsp;&nbsp;&nbsp;
           <a href="dashboard.jsp"><img src="resources/images/return.png" alt="" align="right"/></a>
        </div>
    </body>
</html>
