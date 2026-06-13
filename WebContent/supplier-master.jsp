<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<%@page import="org.spa.entity.User" %>
<%

            User user = (User) session.getAttribute("user");
            if (user == null) {
%>
<jsp:forward page="index.jsp"></jsp:forward>
<%}%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Shaley Poshan Ahar - Supplier Master</title>

        <link rel="stylesheet" type="text/css" href="./resources/css/ext-all.css" />
        <script type="text/javascript" src="JS/master_menu.js"></script>
        <script type="text/javascript" src="JS/displayWindow.js"></script>
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
                margin: 5px;
            }
            #vendor button{color: cornflowerblue;}
            #mlabel{
                padding-left: 15px;
                font-size: 14px;
                font-weight: bolder;
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
            .edit{
                background-image: url(./resources/images/icons/fam/application_form_edit.png) !important;
            }
            .showall{
                background-image: url(./resources/images/icons/fam/application_view_tile.png) !important;
            }
            .delete {
                background-image: url(./resources/images/icons/fam/delete.gif) !important;
            }
            .move {
                background-image: url(./resources/images/icons/fam/arrow_left.png) !important;
            }
            .inv {
                background-image: url(./resources/images/icons/topic.gif) !important;
            }
            .indetail {
                background-image: url(./resources/images/icons/details.gif) !important;
            }
            .filter{
                background-image: url(./resources/images/icons/fam/filter.png) !important;
            }
             .go{
                background-image: url(./resources/images/icons/fam/application_go.png) !important;
            }
             .clear{
                background-image: url(./resources/images/icons/fam/broom.png) !important;
            }
             .save{
                background-image: url(./resources/images/icons/save.gif) !important;
            }
             .update{
                background-image: url(./resources/images/icons/update2.jpg) !important;
            }
            .display-false { display: none }
        </style>
        <!-- LIBS -->
        <script type="text/javascript" src="./resources/adapter/ext/ext-base.js"></script>
        <!-- ENDLIBS -->

        <script type="text/javascript" src="./resources/js/ext-all.js"></script>
        <script type="text/javascript" src="./resources/js/CheckColumn.js"></script>

        <!-- EXAMPLES -->
        <script type="text/javascript" src="./resources/js/examples.js"></script>
        
        <!-- Data File -->
        <script type="text/javascript" src="JS/supplier_master.js"></script>

    </head>
    <body>
        <div id="el1" style="padding: 10px;" class="x-hide-display">
            <img alt="SHALEY POSHAN AHAR SOFTWARE SYSTEM" src="resources/images/s.png" id="sys" style="font-size:25px;font-weight:bold;color:#222297;">
            <label id="mlabel">Master Module - Supplier Master</label>
           <a href="logout.jsp"> <img alt="" align="right" src="./resources/images/signout.png"></a>&nbsp;&nbsp;&nbsp;&nbsp;
           <a href="dashboard.jsp"><img src="resources/images/return.png" alt="" align="right"/></a>
        </div>
    </body>
</html>

