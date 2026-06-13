<%-- 
    Document   : orders
    Created on : Jan 29, 2013, 1:26:11 PM
    Author     : anita
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="org.spa.entity.User" %>
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
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Shaley Poshan Ahar - Report</title>

        <!-- Applying Required Stylesheet -->
        <link rel="stylesheet" type="text/css" href="resources/css/ext-all.css" />

        <link rel="stylesheet" type="text/css"
              href="./resources/ux/css/gridsummary.css" />

        <script type="text/javascript">
            function submitForm()
            {
                document.getElementById("login-form").submit();
            }
        </script>
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
             #mlabel{
                padding-left: 15px;
                font-size: 14px;
                font-weight: bolder;
            }
            #main-panel td {
                padding: 5px;
            }
            .arrow_out {
                background-image: url(./resources/images/icons/fam/arrow_out.png) !important;
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
            .inv {
                background-image: url(./resources/images/icons/topic.gif) !important;
            }
            .indetail {
                background-image: url(./resources/images/icons/details.gif) !important;
            }
            .filter {
                background-image: url(./resources/images/icons/fam/filter.png) !important;
            }
              .save{
                background-image: url(./resources/images/icons/save.gif) !important;
            }
              .clear{
                background-image: url(./resources/images/icons/fam/broom.png) !important;
            }
             .update{
                background-image: url(./resources/images/icons/update2.jpg) !important;
            }
            .sOrder{
                margin-right: 50px;
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
            .x-grid3-cell.new
            {
                background-color: #9fc;
            }
            .x-grid3-cell.modify
            {
                background-color: #ffc;
            }
            .x-panel-body 
            {
			    background-color: #DFE8F6;
			    border-color: #99BBE8;
			}
			.orderPanel{
                background-color: #f1f2f4;
            }
            .copy {
                background-image: url(./resources/images/icons/fam/file_copy.png) !important;
            }
            .reset{
                background-image: url(./resources/images/undo_1.png) !important;
                width: 16px;
                height: 16px;
            }
            .spanLabel{
                font-weight: bold;
                font-size: 20px;
            }
        </style>

        <!--<script type="text/javascript" src="./resources/js/extjs/ux/grid/MultiGroupingStore.js"></script>
	<script type="text/javascript" src="./resources/js/extjs/ux/grid/MultiGroupingView.js"></script>
	<script type="text/javascript" src="./resources/js/extjs/ux/grid/MultiGroupingPanel.js"></script>-->
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

        <script type="text/javascript" src="JS/displayWindow.js"></script>
        <script type="text/javascript" src="JS/master_menu.js"></script>
        <script type="text/javascript" src="JS/reports.js"></script>

        <script type="text/javascript">
            <%
                String fromYear = session.getAttribute("fromYear").toString();
                String toYear = session.getAttribute("toYear").toString();
            %>
        </script>
        
    </head>
    <body>
        <div id="el1" style="padding: 10px;" class="x-hide-display">
           <img alt="SHALEY POSHAN AHAR SOFTWARE SYSTEM" src="resources/images/s.png" id="sys" style="font-size:25px;font-weight:bold;color:#222297;">
           <label id="mlabel">Reports Module </label>
           <a href="logout.jsp"> <img alt="" align="right" src="./resources/images/signout.png"></a>&nbsp;&nbsp;&nbsp;&nbsp;
           <a href="dashboard.jsp"><img src="resources/images/return.png" alt="" align="right"/></a>
        </div>
    </body>
</html>


