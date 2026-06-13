<%-- 
    Document   : taluka-report
    Created on : Feb 6, 2013, 2:30:34 PM
    Author     : anita
--%>
<%@page import="java.text.NumberFormat"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="org.spa.helper.TalukaOrderDetailDSHelper"%>
<%@page import="org.spa.entity.*"%>
<%@page import="org.spa.ds.*"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="org.spa.convert.monthYearToMarathi" %>
<%@page import="org.spa.connect.dbConnection" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html lang="mr">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>बीट गोषवारा</title>
        <style>
            .fontMarathiNumber {
                font:normal normal 24px/30px Kiran,Verdana;
                text-decoration:none;
            }
            .fontMarathiNumberBold {
                font:normal normal bold 26px/30px Kiran,Verdana;
                text-decoration:none;
            }
            table.printstyle {
                border-width: 2px;
                border-spacing: 0px ;
                border-style: inset;
                border-color: gray;
                border-collapse: collapse;
                background-color: white;
            }
            table.printstyle th {
                border-width: 2px;
                padding: 1px;
                border-style: inset;
                border-color: gray;
                background-color: white;
            }
            table.printstyle td {
                border-width: 1px;
                padding: 1px;
                border-style: inset;
                border-color: gray;
                background-color: white;
            }
            .fontsize12 {
                font:normal normal 12px Tahoma;
                text-decoration:none;
            }
            .fontsize14 {
                font:normal normal 14px Tahoma;
                text-decoration:none;
            }
            .fontsize18 {
                font:normal normal bold 18px Tahoma;
                text-decoration:none;
            }

        </style>
    </head>
<%
	String rootMarathi = request.getParameter("rootMarathi");
	int rootID = Integer.parseInt(request.getParameter("rootID"));
	
	RootDS DS = new RootDS();
	                                     
	ArrayList<Root> rootSchool = DS.getAllSchoolByRoot(rootID);
%>        
    <body>

        <p align="center"><%=rootMarathi%> Route All School List</p>
        <table align="center" class="printstyle" width="1200" cellspacing="1" cellpadding="1">
            <thead>
                <tr>
                    <th >अ. क्र.</th>
                    <th >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;अंगणवाडी &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>
                </tr>
            </thead>
            <tbody>
    <%   
    		int i = 0;
            for(Root root : rootSchool)
            {
    %>
                <tr>
                    <th class="fontMarathiNumber"><%=i=i+1%></th>
                    <th ><%=root.getSchoolMarathi() %></th>
                </tr>
    <%
            }  
    %>           
            </tbody>
        </table>
    </body>
</html>
